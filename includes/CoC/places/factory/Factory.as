import classes.GLOBAL;
import classes.Items.Transformatives.CoCGroPlus;
import classes.Items.Transformatives.CoCLactaid;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "SuccubusScene.as";
include "IncubusScene.as";
include "OmnibusScene.as";

public function DemonFactoryEnter():void {
	clearOutput();
	clearMenu();
	setLocation("FACTORY\nDOOR", rooms["COC_FACTORY_FOYER"].planet, rooms["COC_FACTORY_FOYER"].system);
	
	if (flags["COC.FACTORY_SHUTDOWN"] == undefined) flags["COC.FACTORY_SHUTDOWN"] = 0;
	if (flags["COC.FACTORY_FOUND"] == undefined)    flags["COC.FACTORY_FOUND"] = 0;
	//output(images.showImage("dungeon-entrance-factory"));
	
	//Shutdown state
	if (flags["COC.FACTORY_SHUTDOWN"] == 2) output("Rounding a bend in the mountainous foothills, you stumble upon a large, rusted and eerily silent iron structure with a number of tall gray smokestacks.  A bevy of green-tinged copper pipes stem from the rear of the building, climbing up the steep mountainside toward a jagged hole in its face.  Most of these are cracked open along their seams and both the pipes and mountainside are glazed with pink tinted runoff.");
	else if (flags["COC.FACTORY_SHUTDOWN"] == 1) output("Rounding a bend in the mountainous foothills, you stumble upon a large, rusted and eerily silent iron structure with a number of tall gray smokestacks.  A bevy of green-tinged copper pipes stem from the rear of the building, climbing up the steep mountainside and disappearing into a hole in its face.");
	else output("Rounding a bend in the mountainous foothills, you stumble upon a large and rusted iron structure belching cloying pink smoke from its tall smokestacks.  A bevy of green-tinged copper pipes stem from the rear of the building, climbing up the steep mountainside and disappearing into a hole in its face.  It must be some kind of demonic factory, though you've no idea what they could be pumping out.  High atop the roof, you spy a huge water tower fed by smaller pipes that run down the building's side and off in the direction of the lake.  ");
	//Generic text
	output("\n\nThere are no windows to the hellish factory, with only a single iron door adorning the front wall. ");
	if (flags["COC.FACTORY_SHUTDOWN"] == 0) output("If you go inside there will undoubtedly be many demons to fight and little chance to escape. Death or worse awaits should you fall into their hands.");
	output("\n\nDo you enter the factory or leave?");
	if (flags["COC.FACTORY_FOUND"] < 1) {
		output("\n\n<b>The factory is now accessible from the 'Dungeons' submenu inside 'Places' menu.</b>");
		flags["COC.FACTORY_FOUND"] = 1
	}
	
	processTime(50 + rand(20));
	addButton(0, "Enter", DemonFactoryGetIn);
	addButton(1, "Leave", DemonFactoryGetOut, true);
}

private function DemonFactoryGetOut(outside:Boolean=false):void {
	clearOutput();
	clearMenu();
	
	if(outside) output("You decided to head back towards your camp, leaving the hellish factory behind.");
	else output("You slip out the door and disappear, heading back towards your camp, leaving the hellish factory behind.");

	processTime(20 + rand(5));
	addButton(0, "Next", move, "COC_CAMP");
}

private function DemonFactoryGetIn():void {
	clearOutput();
	clearMenu();
	
	output("The door swings shut behind you with an ominous 'creeeeeaaaaaaak' followed by a loud 'SLAM'.  ");
		
	processTime(1);
	addButton(0, "Next", move, "COC_FACTORY_FOYER");
}

private function DemonFactoryTakeIronKey():void {
	clearOutput();
	clearMenu();
	
	output("You take the <b>Iron Key</b> to keep with your other important items.", true);	
	pc.createKeyItem("Factory Iron Key", 0, 0, 0, 0);
	
	processTime(1);
	addButton(0, "Next", mainGameMenu);
}

private function DemonFactoryTakeSupervisorKey():void {
	clearOutput();
	clearMenu();
	
	output("You search the desk and find a silver key labelled 'Supervisor'.\n\nYou take the <b>Supervisor Key</b> to keep with your other important items.");
	pc.createKeyItem("Factory Supervisor's Key", 0, 0, 0, 0);
	
	processTime(1);
	addButton(0, "Next", mainGameMenu);
}

private function DemonFactoryDrinkCoffee():void {
	clearOutput();
	clearMenu();
	//spriteSelect(96);
	output("You take a sip of the rich creamy coffee and suddenly feel refreshed. As you replace the coffeepot, the busty coffee-maker comes to life, grabbing her thick dusky nipples and squeezing out a trickle of scaldingly hot liquid. You can see her eyes roll up into her head from what you assume to be pleasure as she automatically refills the missing coffee, mouth open with ecstasy.  Her movements gradually slow as she quivers almost imperceptibly. A contented smile graces her features as immobility overtakes her, freezing her back in place.  You wonder if 'Mrs. Coffee' was created, or a victim of this place's dark master.");
	//dynStats("lus", 1);
	pc.lust(1);
	pc.HP(35);
	//HPChange(35, false);
	//pc.refillHunger(10);
	doNext(mainGameMenu);
}

private function DemonFactoryBuildCockMilker():void {
	clearOutput();
	clearMenu();
	output("You puzzle out how to build a fully functional cock-milker from the spare parts here and assemble it.\n\nYou gained a <b>Cock Milker</b>!");
	output("\n\nYou'll need a little help to use it though.");
	pc.createKeyItem("Cock Milker",0,0,0,0);
	flags["COC.FACTORY_MILKER_BUILT"] = 1;
	
	doNext(mainGameMenu);
}

private function DemonFactoryBuildBreastMilker():void {
	clearOutput();
	clearMenu();
	output("You puzzle out how to build a fully functional breast-milker from the spare parts here and assemble it.\n\nYou gained a <b>Breast Milker</b>!");
	output("\n\nYou'll need a little help to use it though.");
	pc.createKeyItem("Breast Milker",0,0,0,0);
	flags["COC.FACTORY_MILKER_BUILT"] = 1
	
	doNext(mainGameMenu);
}

private function DemonFactoryDoTensionRelease():void {
	clearOutput();
	//First time...
	if(flags["COC.FACTORY_TENSION_RELEASED"] == undefined) {
		output("You nod and step forwards, allowing her to hook up a modified harness and inject you with the demonic concoction.  In no time heat boils through your veins, pooling on your chest and crotch.  ");
		if(pc.biggestTitSize() < 10) {
			Mutator.growTits(pc, 1, (2+rand(3)), true, 1);
			output("  ");
		}
		output("You glance over to the pile of glistening entwined bodies as they writhe in pleasure, and find yourself drawn in to the mass.  You spend the next four hours suckling tainted breast milk, fucking gaping pussies, and doing your damnedest to milk as much cum from the dick-girls around you.  Eventually the drugs work their way out of your system, leaving you to recover on the floor.  Cum, milk, and sweat drip from your nude form as you try to clean up and get dressed.");
		pc.orgasm();
		//dynStats("int", -2, "lib", 4, "cor", 4);
		pc.intelligence( -2);
		pc.libido(4);
		pc.cor(4);
		//pc.slimeFeed();
		flags["COC.FACTORY_TENSION_RELEASED"] = 0;
	}
	//Second/third times...
	else {
		//[[2nd time]] 
		if(flags["COC.FACTORY_TENSION_RELEASED"] == 0) {
			output("You eagerly put on the modified harness and let them inject you with more of those body-altering chemicals.  As they fill you with artificial lust and desire, you cry out and beg for more.  They oblige you and give you a larger dose than the first time.  ");
			//Grow dick!
			if(pc.hasCock()) {
				Mutator.lengthChange(pc, pc.increaseCock(5,0), pc.cocks.length);
			}
			//Grow chest
			//(If player has 0 bewbs)
			if(pc.breastRows.length == 0) {
				pc.createBreastRow();
				output("Your chest tingles, revealing a pair of pink nipples on your new mammory glands.  ", false);
			}
			Mutator.growTits(pc, 1, (2+rand(3)), true, 1);
			output("  ", false);
			output("Your [pc.nipples] ", false);
			if(pc.cocks.length > 0) output("and [pc.cocks]", false);
			output(" become rock hard, leaking fluids constantly.  ", false);
			//MALE
			if(pc.cocks.length > 0 && pc.vaginas.length == 0) output("Glancing over into the sea of sex, you find yourself drawn to the nearest pussy, as if it was the only thing in the world to matter.  You lose track of the time as you fuck hard dozens of gaping cunts, each of them overflowing with cum from all participants in this infernal orgy.  ", false);
			//FEMALE
			if(pc.vaginas.length > 0 && pc.cocks.length == 0) {
				output("As you enter the sex-crazed crowd, you notice several \"girls\" with demonic cocks bloated by the use of drugs, getting drawn to you by the scent of your dripping wet [pc.vagina]. Sitting on the floor, you spread your legs wide, facing the nearest one with an inviting lewd moan, while you hungrily grab another cum-covered cock, that just filled up an obscenely wide gaping vagina, to suck it.  You are soon penetrated and fucked hard and deep, one huge infernal dick after another, as they all cum into you in turn. ", false);
				pc.cuntChange(0, 150, true);
			}
			//HERM
			if(pc.vaginas.length > 0 && pc.cocks.length > 0) output("You feel your [pc.cocks] getting milked by many wet holes, though you are too busy sucking cocks and moaning in ecstasy to notice who they belong to.  ");
			output("The next eight hours are lost to your desires as you cum over and over, feeling mind-shattering pleasure.  You recover a while on the floor, soaked with a mixture of milk, cum, and pussy-juice.  Getting dressed is a bit troublesome with the recent changes, but you manage to squeeze back into your [pc.gear].  You walk away while still feeling horny, and the moaning of the girls behind you doesn't help.  Maybe you could stay for another round...");
			pc.orgasm();
			//dynStats("int", -2, "lib", 4, "cor", 4);
			pc.intelligence( -2);
			pc.libido(4);
			pc.cor(4);
			flags["COC.FACTORY_TENSION_RELEASED"] = 1;
			//pc.slimeFeed();
		}
		//Third time, move on to bad end!
		else {
			DemonFactoryDoBadEndTension();
		}
	}
	doNext(mainGameMenu);
}

//Factory finale
private function DemonFactoryShutdown():void {
	clearOutput();
	output("You resolve to shut down the factory, then destroy the controls.  You spend a few moments making sure you aren't about to do something disastrous.  A few deep breaths calm your nerves, letting you focus on pressing the correct buttons.  The constant thrumming of the machinery slowly dies down, closely followed by a chorus of disappointed moans.  You step over to the window and watch as the captives come out of their drug induced sex-comas.  A great deal of them gather up and leave, though you are unsure what their destination is.  A few seem to be gathering back around the equipment, and puzzling out how to operate it.  Maybe they liked being here..."); 
	output("\n\nYou remember to destroy the controls. You pick up a nearby large wrench and repeatedly smash the controls. Finally, you throw the wrench at the exposed spinning gears, causing it to jam and dislodge.")
	flags["COC.FACTORY_SHUTDOWN"] = 1;
	doNext(mainGameMenu);
}

private function DemonFactoryOverload():void {
	clearOutput();
	output("You resolve to shut down the factory by overloading the storage tanks, rendering much of the equipment inoperable and difficult to repair.  With a quick twist of a knob, you override the pressure vents for the storage tanks.  Within minutes, you hear the sounds of popping rivets and straining pumps.  You look out over the factory floor and watch as many of the pipes fracture, dripping seed over the moaning captives.  Smoke rises from pumps as they short out and overheat.  The entire building shudders as a massive blast echoes from somewhere to the west.  A high pitched whine fills the building as the last motors shriek and die.  The captives slowly start to come to as the flood of drugs and artificial pleasure come to a stop.  Many break down and cry, others begin unhooking themselves and exploring their surroundings.  You watch with interest as many of them rally together and make for an exit.   The remaining survivors begin scavenging parts from the machinery and puzzling out how to use it.  Perhaps they liked it here.");
	output("\n\nYou remember to destroy the controls. You pick up a nearby large wrench and repeatedly smash the controls. Finally, you throw the wrench at the exposed spinning gears, causing it to jam and dislodge.")
	flags["COC.FACTORY_SHUTDOWN"] = 2;
	doNext(mainGameMenu);
}

//BAD ENDS
private function DemonFactoryBadEndGeneric():void {
	clearOutput();
	output("You crack your sleep-fuzzed eyes, blinking at the sudden light as you try to get your bearings and remember where you are.  A nearby voice is moaning like a bitch in heat, or a drunk slut.  You giggle a bit at the thought as you work at focusing your eyes.  You feel warm and happy, particularly in your chest and groin.  The cobwebs of sleep clear from your mind with agonizing slowness, but you find it hard to worry about with how warm and wonderful you feel.  It's almost like hot wet mouths are latched onto your crotch and breasts, licking and sucking in perfect rhythm.  ", false);
	if(pc.cocks.length == 0 || pc.biggestTitSize() <= 1) {
		output("A small inner voice pipes up to remind you that you don't have ", false);
		if(pc.cocks.length == 0) {
			output("anything in your groin to suck on", false);
			if(pc.biggestTitSize() <= 1) output(" or ", false);
		}
		if(pc.biggestTitSize() <= 1) output("any adornments on your chest", false);
		output(".  That voice trails off as that feeling of perfect pleasure and rightness sweeps it away with the last remnants of sleep.\n\n", false);
	}
	else output("A small inner voice tries to warn you of something, only to be swept away in the feelings of perfect pleasure and rightness that wash away the last remnants of your sleep.\n\n", false);
	output("You realize that the moaning voice is your own, and find that the thought just turns you on more.\n\n", false);
	output("'<i>You're such a horny slut!</i>' echoes a voice in your head.  You want to nod and smile, but are prevented by something.  You realize you're strapped into some kind of chair and harness so securely that you can't even move.  Tiny soothing fingers massage your temples, rubbing away the fears that moments ago threatened to interrupt your pleasure.  You can see a ", false);
	if(pc.totalBreasts() == 2) output("pair of ", false);
	else output("multitude of ", false);
	output(" clear hoses coming away from your cow-like chest udders.  ", false);
	if(pc.milkQ() < 750) output("Creamy white milk is flowing in a steady stream up the tubes and away from you.  ", false);
	else output("The hoses bulge obscenely as they struggle to keep up with the torrents of creamy-white milk you're producing.  ", false);  
	output("Even more wanton moans erupt from your disobedient lips now that you know what's going on.  You're not just a horny slut.  You're a horny cow-slut who's getting off on having her tits pumped.  The massage you're getting feels so good once you realize that.\n\n", false); 
	output("A snap echoes through the pumping room, nearly drowned out by the moans of the other milk-sluts around you.  You look around as you realize the band to restrain your head has been unlatched.  You take advantage of your newfound freedom and look around.  Rows and rows of other girls are there, just like you.  Almost all of them have bigger tits and fuller milk-tubes.  In addition, they all have enormous members that would drag on the floor were it not for the gigantic tubes encapsulating each and every one.  ", false);
	output("The girl next to you squirms and cums, wriggling inside her harness as waves of sticky goop are pumped down her cock-tube into a floor-socket.  She just keeps going and going, making you wonder how she can make so much of the stuff.  As the sight excites you, the pleasure in your own crotch redoubles.  Looking down thanks to your newfound freedom, you see your own giant encapsulated member; though not as large as your neighbor's, it still looks and feels wonderful.\n\n", false); 
	output("The lining of the tube squeezes and massages your trapped prick expertly, even as those hands continue to work on your mind.  Some part of you suspects that your thoughts are being manipulated, but the carnal pleasure you are experiencing is so amazing that you have no intention of resisting. If being a cumslut for your sexy demonic masters is what it takes, so be it. Cramming a massive demon-cock in your throat, getting a few others up your holes to keep you pregnant all the time, and being their busty hermaphrodite breeding tool would be your joy and privilege.  ", false);
	//if(pc.findStatusAffect(StatusAffects.CampMarble) >= 0) {
		//output("As if reading your thoughts, the hands stop massaging, and their owner snaps their fingers. You see Marble step in front of you, wearing an odd set of pink panties with a dick-like protrusion sticking out the front of them.  At the command of the figure behind you, she presents the panty-cock to you.  Happy to be of service, you spread your jaws and engulf as much of the great penis-like thing as you can, while the figure behind you moves around and takes Marble in the ass.  You continue to suck on the pink flesh until you feel it pour some kind of unholy load into your stomach.  Gurgling in pleasure, you start cumming yourself, all the while appeasing your demonic masters by servicing your once lover.\n\n", false);
	//} else 
	output("As if reading your thoughts, the hands stop massaging, and their owner comes in front of you, presenting you with a meaty, throbbing cock.  Happy to be of service, you spread your jaws and engulf as much of the great penis as you can, until you feel it pouring his unholy load into your stomach.  Gurgling in pleasure, you start cumming yourself, all the while attending to one or more of your demonic masters.\n\n", false);
	
	
	output("<b>This kind of treatment continues for a few days, until sucking, fucking and getting fucked is the only thing you desire. As your mind is now broken, injections are no longer necessary to keep you in a perfect pleasure state. After a month, they even untie you, since you are now their complete cum-puppet, eager only to please and obey.</b>", false);
	//The style on this part wasn't up to par with the rest, so I rewrote some of it, while keeping the meaning
	badEnd();
}

private function DemonFactoryDoBadEndTension():void {
	clearOutput();
	output("Desperate for more of the demon-drugs, you slide into the now-familiar harness and let the needles sink into your skin.   Panting in lust, you beg for them increase the dosage again.   Desire burns through your veins as the cocktail surges through them");
	if(pc.cocks.length > 0) {
		output(", filling your [pc.cocksLight]");
		output(" with sensation");
		if(pc.cockTotal() == 1) output("s");
		output(" as ");
		if(pc.cocks.length > 1) output("they");
		else output("it");
		output(" grow");
		if(pc.cocks.length == 1) output("s");
		output(" massive and engorged.  ");
	}
	else output(".  ");
	output("Your [pc.nipples] throb, becoming hard, puffy, and starting to dribble milk.  ");
	if(pc.vaginas.length > 0) output("Your pussy is instantaneously soaked, filling the air with the scent of sex.  ");
	output("The desire for more of the drugs battles with your need to fuck and be fucked, until a small functioning part of your brain realizes it'll be easier to get sex than to get more of the drug.  You pull free and throw yourself into the mass of sweaty bodies, losing yourself in the salty tang of sweat and sex, pleasing nipples, clits, and cocks with your hands, and giving and receiving as much pleasure as you can.  You're in heaven.  Vaguely you realize time is passing, but it is a secondary concern next to the idea of having another groin-soaking orgasm.   You fuck and suck until you pass out from delirium.\n\n");
	//GAME OVERZZ
	output("In time you wake, your body aching both from the exertion and a desire for more.  On one hand you had a mission here, but why fight and struggle with danger and loneliness when you could be high on sex and cumming near-constantly?  You cuddle up to an exhausted girl and decide to wait for the drug-mistresses to give you another turn in the pile.  One of them turns, as if noticing your train of thought, and wheels over a breast-pump.  She hooks it up to your still-leaking nipples and you ");
	if(pc.milkQ() > 1000) output("moo");
	else output("moo"); // RESISTANCE IS FUTILE
	output(" with happiness, promising another dose to you if you are a good cow for her.");
	//dynStats("int", -100, "lib", 100, "cor", 2);
	pc.intelligence(0, true);
	pc.libido(100, true);
	pc.cor(2);
	badEnd();
}

//ROOMS
public function DemonFactoryFoyer():Boolean {	
	output("Glancing around, you find yourself in some kind of stylish foyer, complete with works of art and a receptionist's desk.  Looking closer at the paintings on the wall quickly reveals their tainted and demonic nature: One appears at first to be a painting of a beautiful smiling woman, except you notice dripping tentacles coiling around the hem of her dress.  Behind the receptionist's desk, the second painting is even less discreet, openly depicting a number of imps gang-raping a vaguely familiar-looking woman.  Luckily, whatever demon is employed as the receptionist is away at the moment.  Behind the desk on the northern wall stands a secure-looking iron door.  On the western wall, is a door. A sign on the door indicates that it leads to the factory restroom.  On the eastern wall is a simple wooden door, though the color of the wood itself is far darker and redder than any of the hard woods from your homeland.  Behind you to the south is the rusty iron entry door.");
	
	addButton(7, "Leave", DemonFactoryGetOut);
	
	return false;
}

public function DemonFactoryBreakRoom():Boolean {	
	output("Stepping through the dark red doorway, you wander into an expansive break room. Tables surrounded by crude wooden chairs fill most of the floor space. Along the far eastern wall sits a small counter, complete with a strange ebony sculpture of a busty woman with 'Mrs. Coffee' printed on the side. Below the sculpture is a pot of steaming hot coffee, giving off an invigoratingly rich smell.");
	
	if(flags["COC.FACTORY_SUCCUBUS_DEFEATED"] > 0) {
		if(!pc.hasKeyItem("Factory Iron Key")) {
			output("  It seems your opponent dropped a small iron key as she fled.");
			addButton(0, "Iron Key", DemonFactoryTakeIronKey, null, "Iron Key", "Pick up the iron key. It looks like it might unlock the door in this factory.");
		}
		addButton(1, "Coffee", DemonFactoryDrinkCoffee, null, "Coffee", "Drink some coffee.");
		//spriteSelect(96);
	}
	else {
		//spriteSelect(55);
		output("\n\nStanding next to the coffeemaker is a blue-skinned woman holding a mug of coffee.  As she takes a sip, oblivious to your presence, you see the mug has '#1 Dad' written on it.  Dressed in a tiny vest, short skirt, and sheer stockings, she looks every bit an air-headed secretarial ditz.  Her two horns are little more than nubs, mostly covered by her flowing blond hair, and if it wasn't for her blue skin and the tip of a spaded tail peeking out from under her skirt, you'd never know what she was.\n\n", false);
		clearMenu();
		// demon bad end available
		if(pc.demonScore() >= 4 && pc.cor() > 75) {
			output("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there " + pc.mf("stud", "sexy") + "!</i>\"  She stops, sniffing the air, a curious expression on her face as she slowly circles you, her heals clicking loudly on the floor.  A knowing grin blooms across her face as understanding hits her.\n\n"); 
			output("She exclaims, \"<i>Omigawsh!  You're the champion!  Your, like, soul is still there and everything!  But, you're like, completely corrupt an' stuff!  Ya know what'd be fun?  I could fuck you 'til you cum so hard your soul melts out an' you turn into a demon.  Wouldn't that be great?</i>\"\n\n");
			output("The secretarial demoness pulls out a file and fiddles with her nails, murmuring, \"<i>I guess if you don't wanna, we could just hook you up in the factory.  What's it gonna be?</i>\"");
			//if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
				//flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
				//output("<b>New codex entry unlocked: Succubus!</b>\n\n")
			//}
			addButton(0, "Fight", DemonFactoryDoFightSuccubus);
			addButton(1, "Go Demon", DemonFactoryGoDemon);
			addButton(2, "Hook Up", DemonFactoryTalkSuccubusYes);
		}
		//Not recognized
		else if(pc.humanScore() <= 3) {
			output("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there " + pc.mf("stud", "sexy") + "!  You haven't seen a confused human about calling itself a champion have you?</i>\"\n\nShe shakes her more-than-ample bosom from side to side as she licks her lips and offers, \"<i>If you do, be sure and bring them back here ok?  We've got their spot all ready for them, but that little prick Zetaz fucked up the pickup.  Tell you what – if you bring me the 'champion' I'll ");
			if(pc.hasCock()) output("give you the blowjob of a lifetime");
			else if(pc.hasVagina()) output("lick your honeypot 'til you soak my face");
			else output("give you a new addition and show you how to use it");
			output(".</i>\"\n\nThe succubus turns away from you and makes a show of tweaking her make-up, ignoring you for the moment.");
			//if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
				//flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
				//output("<b>New codex entry unlocked: Succubus!</b>\n\n")
			//}
			addButton(0, "Fight", DemonFactoryDoFightSuccubus);
			addButton(1, "It's Me!", DemonFactoryTalkSuccubusItsMe);
			addButton(2, "Leave", move, rooms[currentLocation].westExit);
		}
		else {
			output("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there " + pc.mf("stud", "sexy") + "!  What's a cute little morsel like you doing by yourself out here?</i>\"");
			//if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
				//flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
				//output("<b>New codex entry unlocked: Succubus!</b>\n\n")
			//}
			
			addButton(0, "Fight", DemonFactoryDoFightSuccubus);
			addButton(1, "Talk", DemonFactoryTalkSuccubus);
			addButton(2, "Run", move, rooms[currentLocation].westExit);
		}
		return true;
	}
	
	return false;
}

public function DemonFactoryPumpRoom():Boolean {
	if (!pc.hasKeyItem("Factory Iron Key")) 
	{
		clearOutput();
		clearMenu();
		output("The door is locked with a key that is not in your possession.");
		addButton(0, "Next", move, rooms[currentLocation].southExit);
		return true;
	}
	
	if(flags["COC.FACTORY_SHUTDOWN"] <= 0) {
		output("As you step through the iron door, a cacophony of thrumming mechanical noise assaults your ears.  Coppery pipes arch overhead, riveted into spiked iron brackets that hang from the ceiling in twisted pairs.  The constant thrum-thrum-thrum of concealed pumps and mechanisms makes it difficult to hear anything, but you swear you can make out the faint sounds of sexual pleasure emanating from the northwest side of the room.  Investigating further, you spot a door along the west wall of the room that appears to be the source of the licentious sounds.  The vibrations of all the machinery are strongest along the east walls, indicating the possible site of this hellish place's power-plant. There is a door on the east wall and a door on the north.  To the south is a solid iron door that leads back to the lobby.", false);
	}
	else output("As you step through the iron door, silence is the only noise you hear.  Coppery pipes arch overhead, riveted into spiked iron brackets that hang from the ceiling in twisted pairs.  The near-complete silence of the place unnerves you, but allows you to make out the faint sounds of sexual pleasure emanating from northwest side of the room.  Investigating further, you spot a door along the west wall of the room that appears to be the source of the licentious sounds.  There are two other doors, one along the east wall and one on the north.  To the south is a solid iron door that leads back to the lobby.", false);

	return false;
}

public function DemonFactoryFurnaceRoom():Boolean {	
	if(flags["COC.FACTORY_SHUTDOWN"] <= 0) {
		output("The air inside this room is hot enough to coat your [pc.skinFurScales] in a fine sheen of sweat.  The eastern side of the chamber is more machine than wall, a solid mass of iron piping covered in small metal blast-doors through which fuel is to be fed.  A small transparent plate is riveted into the wall, allowing you to see some kind of pink crystalline fuel being burned by purple-white fire.  The few visible controls and gauges don't seem to be linked into anything important, and the machinery looks far too durable to damage with what you have.  The only exit is a heavy iron door on the west wall.  ");
	}
	else {
		output("Despite the machinery being shut down, the air in this room is still hot enough to coat your [pc.skinFurScales] in a fine sheen of sweat.  The eastern side of the chamber is more machine than wall, a solid mass of iron piping covered in small metal blast-doors through which fuel is to be fed.  A small transparent plate is riveted into the wall, allowing you to see some the ashes of a previous fuel source.  The few visible controls and gauges don't seem to be linked into anything important, and the machinery looks far too durable to damage with what you have.  The only exit is a heavy iron door on the west wall.  ");			
	}
	
	//Incubus is ALLLLIVE
	if (!(flags["COC.FACTORY_INCUBUS_DEFEATED"] > 0)) {
		//spriteSelect(30);
		//if(flags[kFLAGS.FACTORY_INCUBUS_BRIBED] > 0) {
			//output("\n\nThe incubus mechanic is here, thumbing through a hentai comic and laughing to himself at the absurdity of it.  That doesn't stop him from stroking his half-hard member the whole time...", false);
			//addButton(0, "Fight", doFightIncubus);
		//}
		//else {
			clearMenu();
			output("\n\nA demonic mechanic lounges against the hot machinery, unperturbed by the high temperatures of the room.  He wears cut-off denim overalls, stained with grease in a few places.  They don't seem to be in good repair, and have a fair-sized hole at his groin, where a floppy foot-long member hangs free.  His skin is light purple and unblemished, as you would expect from a sexual demon.  He has a rugged handsome face and black hair tied back in a simple ponytail.  Two large curving horns protrude from his forehead, curving back along his skull and giving him a dangerous appearance.  A narrow goatee grows from his chin, about 3 inches long and braided skillfully.  He looks up and smiles, amused at your appearance.", false);
			addButton(0, "Fight", DemonFactoryDoFightIncubus);
			addButton(1, "Talk", DemonFactoryDoTalkIncubus);
		//}
		return true;
	}
	
	return false;
}

public function DemonFactoryRepairCloset():Boolean {
	output("As you carefully slip inside the room, you note with some relief that it seems to be an empty storage closet. The room is tiny, barely 6' by 8' and almost entirely empty.  The one piece of furniture inside the closet is a simple wooden cabinet, placed against the far wall.  ")

	if(flags["COC.FACTORY_MILKER_BUILT"] > 0) output("The shelves are empty.  ");
	else {
		output("The shelves of the cabinet hold various pieces of pump machinery, probably used to repair complete machines further into the factory.  ");
		if(pc.IQ() >= 40) {
			output("You realize there are enough pieces here to put together a breast-milking pump or a cock-milker.  But not enough for both.  ");
			
			if(pc.hasKeyItem("Cock Milker"))	addDisabledButton(1, "Cock Milker", "Cock Milker", "You already have a cock milker");
			else								addButton(1, "Cock Milker", DemonFactoryBuildCockMilker);
			
			if(pc.hasKeyItem("Breast Milker"))	addDisabledButton(0, "Breast Milker", "Breast Milker", "You already have a breast milker");
			else								addButton(0, "Breast Milker", DemonFactoryBuildBreastMilker);
		}
	}
	output("The only exit is back to the south.");
	
	return false;
}

public function DemonFactoryMainChamber():Boolean {
	if(flags["COC.FACTORY_SHUTDOWN"] <= 0) {
		output("This cavernous chamber is filled with a cacophony of sexual moans.  Rows of harnesses are spaced evenly throughout this room, nearly all of them filled with delirious-looking humans.  Each is over-endowed with huge breasts and a penis of elephantine proportions.  The source of their delirium hangs down from the ceiling - groups of hoses that end with needles buried deep into the poor 'girls' flesh, pumping them full of demonic chemicals.  Constant sucking and slurping noises emanate from nipple and cock pumps as they keep the victims in a state of near-constant orgasm.  ");
		if(pc.cor() < 50) output("You wish you could free them, but it would take the better part of a day to get them all free.  It'd be better to find the control room and shut down the infernal machinery.  ");
		else output("You wish you had some machinery like this for yourself.  It looks so fun!  Still, you suppose you should find the control panel to shut this down and free these people.  ");
		output("There is a doorway to the east marked with an 'exit' sign above it.  Along the southern wall is a stairwell that leads up to some kind of foreman's office.  Perhaps the controls are in there?");
	}
	//Dungeon shut down.
	else {
		output("The chamber is significantly emptier since you've shut down this factory.  Roughly half the girls appear to have left.  The rest seem to be pre-occupied by fucking each other in a massive orgy.  A few enterprising ladies have found leather outfits and appear to be helping to manually administer the chemical cocktails to those engaged in rampant sexual exploits.  It seems some of them preferred a life of near-constant orgasm to their freedom.  There is a door to the east marked as 'EXIT', and a stairwell along the south wall that leads to an overseer's office.");
		output("\n\nOne of the leather-clad ladies steps over and offers, 'Would you like a dose?  You look like you need to relieve some tension...");
		addButton(0, "Tension", DemonFactoryDoTensionRelease);
	}
	
	return false;
}

public function DemonFactoryForemanOffice():Boolean {
	//Foreman's Office
	output("This office provides an excellent view of the 'factory floor' through a glass wall along the north side.  Towards the south side of the room is a simple desk with an even simpler chair behind it.  The desk's surface is clear of any paperwork, and only has a small inkwell and quill on top of it.  There are a few statues of women and men posted at the corners of the room.  All are nude and appear to be trapped in mid-orgasm.  You wonder if they're statues or perhaps some kind of perverted petrified art.  The north has a glass door leading back to the factory.  There are two other doors, both made of very solid looking metal.  One is on the east wall and another is on the south, behind the desk.  The one behind the desk is marked 'Premium Storage' (though it appears to be locked).");

	if (!(flags["COC.FACTORY_OMNIBUS_DEFEATED"] > 0)) {
		clearMenu();
		//spriteSelect(16);
		output("\n\nA nearly nude demonic woman is standing behind the desk, appraising you.  She is gorgeous in the classical sense, with a curvy hourglass figure that radiates pure sexuality untamed by any desire for proper appearance.  Shiny black lip-gloss encapsulates her bubbly lips, while dark eyeshadow highlights her bright red eyes.  The closest thing she has to clothing is a narrow band of fabric that wraps around her significant chest, doing little to hide the pointed nubs of her erect nipples.  Her crotch is totally uncovered, revealing the hairless lips of her glistening womanhood.\n\n");
		output("She paces around the edge of the desk, licking her lips and speaking, \"<i>So you've made it all the way here have you, 'champion'?  Too bad you've wasted your time.  Have you figured it out yet?  Have you discovered why you were sent here with no weapons or blessed items?  Have you found out why there are more humans here than anywhere else in this realm?  I'll tell you why.  You weren't a champion.  You were a sacrificial cow, meant to be added to our herd.  You just got lucky enough to get free.</i>\"\n\n", false);
		output("A part of you wants to deny her, to scream that she is wrong.  But it makes too much sense to be a lie... and the evidence is right behind you, on the factory floor.  All those women must be the previous champions, kept alive and cumming for years in order to feed these insatiable demons.  The demoness watches your reaction with something approaching sexual bliss, as if the monstrous betrayal of it all is turning her on.\n\n");
		output("\"<i>Yes,</i>\" she coos, \"<i>you belong here.  The question is do you accept your fate, or do you fight it?</i>\"");
		addButton(0, "Fight", DemonFactoryOmnibusFight);
		addButton(1, "Accept", DemonFactoryOmnibusAccept);
		return true;
	}
	else {
		if (!pc.hasKeyItem("Factory Supervisor's Key")) {
			addButton(0, "Desk", DemonFactoryTakeSupervisorKey, null, "Desk", "Check the desk for something useful.");
		}
	}
	
	return false;
}

public function DemonFactoryControlRoom():Boolean {
	output("This room is little more than a closet in reality.  There is a simple set of mechanical controls on a finely crafted terminal against the far wall.  ")
	
	if(!(flags["COC.FACTORY_SHUTDOWN"] > 0)) {
		output("You spend a moment looking over them, and realize you have three options to deal with this place.\n\n");
		output("-You could close the storage vent valves and overload the fluid storage systems.  The storage tanks along the back portion of the building would rupture, releasing thousands of gallons of tainted fluids into the surrounding area, but the facility's systems would suffer catastrophic failures and shut down forever.\n");
		//(Consequences - lake goddess becomes tainted!)
		output("-You could perform a system shutdown and then smash the controls.  It'd let the girls go and keep the factory shut down in the short term.  However most of the equipment would be undamaged and the place could be re-opened without too much work on the demons' part.\n", false);
		//(Consequences - If Marcus is a demon he takes over running the factory forever.  If not, nothing bad happens)
		output("-You could leave the equipment to continue running.  After all, the girls downstairs did seem to be enjoying themselves...\n");
		//(Consequences - Marcus takes over if demonic choice taken, if not he shuts down the equipment & things continue as per #3).
	}
	else {
		output("The controls are now inoperable due to the damage your actions have caused.");
	}

	if (flags["COC.FACTORY_SHUTDOWN"] <= 0) {
		addButton(0, "Valves", DemonFactoryOverload, null, "Valves", "Overload the valves. This may have unintended consequences but the factory will suffer catastrophe and shut down forever.");
		addButton(1, "Shutdown", DemonFactoryShutdown, null, "Shutdown", "Shut down the factory safely. This may seem like a safe bet but it leaves the factory vulnerable to the possibility of being re-opened.");
	}
	
	return false;
}

public function DemonFactoryPremiumStorage():Boolean {
	if(!pc.hasKeyItem("Factory Supervisor's Key")) 
	{
		clearOutput();
		clearMenu();
		output("The door is locked with a key that is not in your possession.");
		addButton(0, "Next", move, rooms[currentLocation].northExit);
		return true;
	}
	
	output("This store room is filled with a few opened crates, meant to store the various substances in the factory.  It looks as if the current overseer has allowed supplies to run low, as there is not much to be gleaned from this meager stash.\n\n");

	if (flags["COC.FACTORY_TAKEN_LACTAID"] == undefined) flags["COC.FACTORY_TAKEN_LACTAID"] = 0;
	if (flags["COC.FACTORY_TAKEN_GROPLUS"] == undefined) flags["COC.FACTORY_TAKEN_GROPLUS"] = 0;
	
	if(flags["COC.FACTORY_TAKEN_LACTAID"] > 0) {
		if(flags["COC.FACTORY_TAKEN_LACTAID"] < 5) {
			output("There is a crate with " + num2Text(5 - flags["COC.FACTORY_TAKEN_LACTAID"]) + " bottles of something called 'Lactaid' inside.\n\n");
			addButton(0, "LactAid", DemonFactoryTakeLactaid);
		} else {
			output("There is an empty crate with label'Lactaid'.\n\n");
			addDisabledButton(0, "LactAid", "LactAid", "Crate is already empty");
		}
	}
	else {
		output("There is an unopened crate with five bottles of something called 'Lactaid' inside.\n\n");
		addButton(0, "LactAid", DemonFactoryTakeLactaid);
	}
	if(flags["COC.FACTORY_TAKEN_GROPLUS"] > 0) {
		if(flags["COC.FACTORY_TAKEN_GROPLUS"] < 5) {
			output("There is a crate with " + num2Text(5 - flags["COC.FACTORY_TAKEN_GROPLUS"]) + " syringes of something called 'Gro+' inside.\n\n");
			addButton(1, "GroPlus", DemonFactoryTakeGroPlus);
		} else {
			output("There is an empty crate with label'GroPlus'.\n\n");
			addDisabledButton(1, "GroPlus", "GroPlus", "Crate is already empty");
		}
	}
	else {
		output("There is an unopened crate with five syringes of something called 'Gro+' inside.\n\n");
		addButton(1, "GroPlus", DemonFactoryTakeGroPlus);
	}
	
	return false;
}

public function DemonFactoryBathroom():Boolean {
	output("This room is fairly clean. At one of the walls, there is a row of four sinks. Opposite side, there are few bathroom stalls. Three urinals are mounted against one of the walls. You'd guess even the demons need to use the bathroom.");
	if (silly) output(" Unlike you.");
	output("\n\n");
	
	return false;
}

public function DemonFactoryTakeLactaid():void {
	clearOutput();
	clearMenu();
	flags["COC.FACTORY_TAKEN_LACTAID"]++;
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCLactaid()]);
}

public function DemonFactoryTakeGroPlus():void {
	clearOutput();
	clearMenu();
	flags["COC.FACTORY_TAKEN_GROPLUS"]++;
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	itemCollect([new CoCGroPlus()]);
}

public function DemonFactoryCleared():Boolean {
	return flags["COC.FACTORY_OMNIBUS_DEFEATED"] > 0 
		&& flags["COC.FACTORY_SUCCUBUS_DEFEATED"] > 0 
		&& flags["COC.FACTORY_INCUBUS_DEFEATED"] > 0;
}

public function FactoryRoomUpdateNotify():void {
	if(DemonFactoryCleared())
	{
		rooms["COC_FACTORY_FOYER"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_BREAK_ROOM"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_PUMP_ROOM"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_FURNACE_ROOM"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_REPAIR_CLOSET"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_MAIN_CHAMBER"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_FOREMAN_OFFICE"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_CONTROL_ROOM"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_BATHROOM"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
		rooms["COC_FACTORY_PREMIUM_PRODUCTS"].removeFlags(GLOBAL.HAZARD, GLOBAL.NOFAP);
	}
	
	if (flags["COC.FACTORY_INCUBUS_DEFEATED"] != 1) rooms["COC_FACTORY_FURNACE_ROOM"].addFlag(GLOBAL.NPC); // not objective here
	else rooms["COC_FACTORY_FURNACE_ROOM"].removeFlag(GLOBAL.NPC);
	if (flags["COC.FACTORY_SUCCUBUS_DEFEATED"] != 1) rooms["COC_FACTORY_BREAK_ROOM"].addFlag(GLOBAL.OBJECTIVE);
	else rooms["COC_FACTORY_BREAK_ROOM"].removeFlag(GLOBAL.OBJECTIVE);
	if (flags["COC.FACTORY_OMNIBUS_DEFEATED"] != 1) rooms["COC_FACTORY_MAIN_CHAMBER"].addFlag(GLOBAL.OBJECTIVE); // technically it's COC_FACTORY_FOREMAN_OFFICE, but it is on other floor and you are there once you use ladder
	else {
		rooms["COC_FACTORY_MAIN_CHAMBER"].removeFlag(GLOBAL.OBJECTIVE)
		rooms["COC_FACTORY_MAIN_CHAMBER"].addFlag(GLOBAL.NPC);
	}
	
}
private var FactoryRoomUpdateNotifyHook: * = FactoryRoomUpdateNotifyGrapple();
private function FactoryRoomUpdateNotifyGrapple():* { variableRoomUpdateListeners.push(FactoryRoomUpdateNotify); }