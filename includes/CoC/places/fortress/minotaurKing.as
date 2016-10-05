import classes.Characters.CoC.CoCMinotaurKing;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function encounterMinotaurKing():void
{
	clearOutput();
	output("The moment you step away from the defeated demon, Lethice’s assembled host parts like some kind of tentacled sea, revealing a path that would lead directly to the Queen of Corruption were it not barred by a form out of nightmares. A minotaur like none you’ve ever seen bars your path - the last obstacle before a face-to-face encounter with the cause of so much discontent.");
	output("\n\nEven for one of the bovine beast-men, he’s a giant among giants. His broad shoulders seem ready to scrape the gilding from the cavernous chamber. His crimson-rimmed eyes glare down like a pair of low-burning coals. Stretching from end to end, a cow-girl could barely touch each end of his wide-spread horns. If it weren’t for the three feet of glistening, freshly-fucked maleness jutting from between his legs, he’d look almost regal.");
	output("\n\n<i>“You’re strong, Champion, but your quest ends here,”</i> the brute promises. He snorts and extends a hand toward the crowd. <i>“Excellia, my weapon.”</i>");
	output("\n\nA vision of curves and ripe sexuality emerges from the curtain of wet and wiggling flesh. She’s at least part cow, with upraised horns and a happily flicking tail - to say nothing of her egregiously supple breasts, still leaking milk from a recent suckle or their own overtly-abundant production. In her hands is a massive axe; it’s too large to be wielded by human hands.");
	//if (flags["COC.ISABELLA_FOLLOWER_ACCEPTED"] > 0)
	//{
		//output(" Even Isabella would struggle to wield such a weapon.");
	//}
	//else if (pc.findStatusEffect(StatusEffects.CampMarble) >= 0)
	//{
		//output(" Even Marble would struggle to wield such a weapon");
	//}
	//else if (getGame().helFollower.followerHel())
	//{
		//output(" Even Helia would struggle to wield such a weapon.");
	//}
	output(" This poor cow-slut, this ‘Excellia’ can barely to bring it to her lord without tipping forward onto her too-large tits.");
	output("\n\nTaking the gleaming metal shaft from his smaller slave, the proud beast stamps the butt-end into the worked stone floor, creating a spiderweb of cracks from brute strength alone.");
	output("\n\n<i>“Careful not to damage my property, oh King of the Minotaurs. Remember within whose feast-hall you dwell,”</i> a chilly, yet feminine voice calls.");
	output("\n\nEars twitching in irritation, the royal brute inclines his head ever so slightly. <i>“Your property, yes. I’ll not damage your precious floors, but this one... this Champion... " + pc.mf("he","she") + " will be mine.”</i> The corners of the minotaur’s lips quirk upward in time with his tremendous erection. <i>“Do not make this more painful than it has to be.”</i>");
	output("\n\nYou’ve got a metric fuckton of muscle in between you and the end of this sick, twisted journey. Once more, you’ll have to fight.");
	
	clearMenu();
	addButton(0, "Next", fightMinotaurKing);
}

public function fightMinotaurKing():void {
	var foe:CoCMinotaurKing = new CoCMinotaurKing();
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(foe);
	CombatManager.victoryScene(handleKingMaybeVictory);
	CombatManager.lossScene(hailToTheKingBaby);
	CombatManager.displayLocation("MINOTAUR\nKING");
	CombatManager.beginCombat();
}

public function handleKingMaybeVictory():void
{
	if ((enemy as CoCMinotaurKing).orgasms == 0 && enemy.lustQ() >= 100)
	{
		(enemy as CoCMinotaurKing).lustDump();
		(enemy as Creature).alreadyDefeated = false;
		CombatManager.continueCombat();
		return;
	}
	if (enemy.HP() < 1 && (enemy as CoCMinotaurKing).milkDrinks < 10)
	{
		(enemy as CoCMinotaurKing).hpRestore();
		(enemy as Creature).alreadyDefeated = false;
		CombatManager.continueCombat();
		return;
	}
	theKingIsDeadLongLiveTheKing();
}

public function theKingIsDeadLongLiveTheKing():void
{
	flags["COC.MINOTAURKING_DEFEATED"] = 1;
	clearOutput();
	output("The King’s axe clatters on noisily on the ground. A gasp runs through the corrupt host as one of their mightiest champions drops to his knees, staring at his dick and furiously pumping it with both hands. Nearly insensate with need, he topples over, humping his own hands with so much enthusiasm that he’s lost interest in anything but immediate sexual gratification.");
	output("\n\nA slow, quiet clap begins from the rear of the room. <i>“Well done, Champion... quite well done.”</i> The Queen herself is smiling at you, though her eyes are as cold as dark ice on a winter’s eve. <i>“Avail yourself of your prizes. It wouldn’t be sporting to take you on while you’re all worked up. My underling’s loyal retainers might get the wrong idea about my strength.”</i> Her eyes flash dangerously.");
	output("\n\nOf course. If she preyed on you while you were still recovering from the minotaur, her subordinates might think her weak or afraid. You have a semi-conscious royal and his cow-slut to use as you will. Or you could just put them out of their misery.");
	if (pc.cor() <= 33)
	{
		output(" The poor things are so corrupted.");
	}
	clearMenu();
	addButton(0, "Kill Them", murderhobo);

	addDisabledButton(1, "Docking", "Docking", "This scene requires you to have cock able to fit in his urethra.");
	addDisabledButton(2, "Buttfuck", "Buttfuck", "This scene requires you to have cock.");
	addDisabledButton(3, "Titfuck", "Titfuck", "This scene requires you to have cock.");
	addDisabledButton(4, "SlpySecond", "Sloppy Seconds", "This scene requires you to have cock.");
	addDisabledButton(5, "Ride Him", "Ride Him", "This scene requires you to have vagina.");
	
	if (pc.cockThatFits(enemy.cockVolume(0)) != -1)
		addButton(1, "Docking", dockucocku);
	if (pc.hasCock())
	{
		addButton(2, "Buttfuck", buttufucku);
		addButton(3, "Titfuck", titfuckCowslut);
		addButton(4, "SlpySecond", sloppySeconds);
	}
	if (pc.hasVagina())
	{
		addButton(5,"Ride Him",mechanicalbullhue);
	}
}

private function murderhobo():void
{
	flags["COC.MINOTAURKING_KILLED"] = 1;
	clearOutput();
	output("You make it quick, then straighten to stare Lethice in the eye. You’ll purge every single ounce of corruption from this world by any means necessary.\n\n");
	processTime(10 + rand(10));
	CombatManager.genericVictory();
}

private function dockucocku():void
{
	var cockIdx:int = pc.cockThatFits(enemy.cockVolume(0));
	flags["COC.MINOTAURKING_FUCKED"] = 1;
	clearOutput();
	output("With a dick that big and that hard at your disposal... you could do something that some might consider crazy, something with enough erotic potential that it makes your [pc.cocks] even harder than the fuck-scent in the air and the nude, well-endowed figures before you.");
	output("\n\nThe wildly flaring tip of the Minotaur King’s dick is neatly adorned with a nice, big cumslit, one that’s spread wide by pre-cum even now. It’s big enough to be a pussy. Bigger than some goblins’ pussies, you bet, and twice as wet looking. The three medial rings that stud the length between sheath and tip would make great grips for your hands, the better to hold onto while you literally fuck the exotic minotaur-dick. You briefly wonder if those extra rings make such cocks even more pleasurable to ride than");
	if (pc.cockTotal(GLOBAL.TYPE_EQUINE) > 0)
	{
		output(" a horse-dick like yours");
	}
	else
	{
		output(" the average equine prick");
	}
	output(", but you discard the thought as irrelevant.");
	output("\n\nYou’ll be the one doing the fucking this time.");
	output("\n\nYou grab the monarch’s masturbating hands and pull them from your prize, a task made easier by his physical exhaustion. He grumbles weakly, but when your fingers make contact, he abruptly goes quiet, realizing that someone else may do him the favor of bringing him off. Little does he know just what you have planned. His jet-black member is slicker than you would have thought possible, coated with layer upon layer of jism. Your hands feel buttery after the briefest contact, like you’ve dipped them in a vat of grease.");
	output("\n\nHis bulging flare and unique anatomy help you to wrangle the rebelliously twitching boner, aiding you in holding still while you line [pc.cock " + cockIdx + "] up with the dribbling slit. His flesh is hot in your hands, and his free-flowing fluids feel like bathing warm oil on your [pc.cockHead " + cockIdx + "]. You tremble, awash in the delirious desire to thrust it home all at once, to impale this massive beast-cock on your smaller length in one massive stroke.");
	output("\n\nBut you hold back for now, starting by gently easing your [pc.cockHead " + cockIdx + "] into the welcoming embrace of the Minotaur King’s larger erection. He grunts in discomfort at the sensation, weakly craning his head up to watch you, but after a second he slumps right back down on the ground, moaning. He’s too turned on to care that you’re feeding inch after inch of your penis into his own; he’d accept anything that would get him off at this point. What a slut.");
	output("\n\nYou waver momentarily, bathing your [pc.cock " + cockIdx + "]");
	if (pc.balls > 0)
	{
		output(" and [pc.balls]");
	}
	output(" in the steady flow of pre that leaks around your dong, savoring this moment for what it is. You might not get another chance to do something like this once you take down Lethice, and you want it to be memorable. Grinning up at her, you mouth, <i>“You’re next,”</i> and resume feeding the rest of yourself into your cylindrical fucktube.");
	output("\n\nThe inside is tight, blessedly tight, but so wet that you could probably slide two of yourself in side-by-side and still manage to enjoy yourself. You squeeze down with your fingers the moment you hilt yourself, cranking the pressure up another notch. The defeated beast-man’s heart is hammering, sending rolling waves of pneumatic pleasure through his cock-pussy, massaging you with his own excitement.");
	output("\n\nFeeling generous, or at least turned on enough not to care, you catch some of the drooling pre in your hand and slather it over the hulk’s glistening prong. A beast like this deserves to be rewarded for being so complacent, so you begin to fuck him and stroke him, working him to a simultaneous beat, stimulating his gigantic cock from inside and out. You swear, the sweltering fuck-tube is getting warmer, or at the very least wetter, like your [pc.cock] could just melt into a puddle of ecstatic bliss.");
	output("\n\nOr maybe that’s just some of the royal brute’s druggy pre-cum backflowing into your own urethra. It’s hard to tell. You fuck him faster, grunting with the effort, plowing the rigid horse-dick with your own so hard that the cum-slut gapes sloppily when you accidentally pull out. You feed yourself right back in and resume humping, plowing this magnificent-smelling slut for all your worth. He’s so big and so virile, but with your smaller dick inside him, he’s little more than willing whore, desperate to be fucked.");
	output("\n\nYou inhale deeply, filling your lungs with his potent pheromones, riddling your body with corrupted arousal as you pass the point of no return. You’re going to blow inside this beast-man’s cock and backfill his balls with a spunky surprise. There’s no avoiding it. Orgasmic pleasure is flooding your mind, demanding your hips slap hard into the blunted tip of your fuck-toy, urging you to impregnate the wet-and-willing orifice you’ve been presented with.");
	if (pc.cumQ() <= 500)
	{
		output("\n\nYou cum in one moment of pure, beatific release, unloading every drop of [pc.cumNoun] directly into the minotaur’s urethra. His face screws up from the feeling of foreign fluids flowing backwards through his body. You can only imagine where your jizz is flowing, what parts of the minotaur’s body is being assaulted by sperm. You hope some made it to his bloated balls.");
	}
	else if (pc.cumQ() <= 2500)
	{
		output("\n\nImpregnate is a mild term for what you do. You flood the powerful monster’s most masculine places with thick spurts of your virile [pc.cumNoun], spending it so deeply in his body that it has nowhere to flow but deep into his form. You swear you even see his balls bulge slightly. Still blissed-out and squirting into him, you heft one of the swollen orbs and feel it twitch an influx of new, fluid weight.");
	}
	else
	{
		output("\n\nYou cum like a firehose, spraying a deluge of [pc.cumVisc] [pc.cumNoun] straight down the minotaur’s cock. His body may have been ready to expel such flows, but never to take one in. He grunts in what you take for discomfort and stares in horror at the bulges of fluid disappearing into his sheath, spreading through his body and collecting in his balls. You can actually see his nuts swelling up with all the pumped-in sperm, absolutely bloated with the fruit of your loins. Hefting one, you feel the extra fluid slosh as you fill it, marvelling at your own virility.");
	}
	
	if (!pc.hasKnot(cockIdx) || pc.knotThickness(cockIdx) <= 2)
	{
		output("\n\nSatisfied at last, you pull out with lurid ‘schliiiick’ sound. A few of the assembled demons clap and catcall, but most surprising of all is the monarch’s own roar of bliss, followed shortly after by his powerful hips lifting up off the floor. The well-fucked horse-cock erupts like a long-dormant volcano, spraying jizz from its sloppy, stretched slit until minotaur spunk is raining over the assembled crowd. Many of the demons immediately fall into fucking one another, but you have the good sense to avoid the bulk of it.");
		output("\n\nAgain and again, those powerful, shaggy hips lift, and each time, more cow-cream explodes into the air, mixed with something else. Something better. Champion cum. Excellia is revitalized by erotic monsoon and manages to climb on top before he finishes, riding him like the bucking bronco that he is.");
		output("\n\nNeither of them will be standing in your way any time soon. Time to deal with Lethice.\n\n");
		processTime(18 + rand(10));
		pc.orgasm();
		CombatManager.genericVictory();
	}
	else
	{
		clearMenu();
		addButton(0,"Next",this.dockucockuknotu);
	}
}

private function dockucockuknotu():void
{
	var cockIdx:int = pc.cockThatFits(enemy.cockVolume(0));
	clearOutput();
	output("When you try to pull out, there’s a problem: your knot. It inflated while you were cumming, and now that you’ve finished, it has expanded to lock you inside your unusual mate. No matter how you tug or pull, you can’t seem to extricate yourself from the cream-filled cow-man, and worse still, he’s starting to moan and squirm. Getting filled full of your spunk must have been more enjoyable for him than you thought.");
	output("\n\nThe Minotaur King is moaning, and his cock is getting still harder in your hands, making it even harder to pull yourself free. Panicked now, you tug in vain, anything to get free before your cum and a wave of bovine beast-cum flows back into you. Your [pc.feet] slip in the puddled juices, and the surging bull’s member pulls you over onto his chest, still joined at the crotch. He catches you, holding you an angle so as not to damage either of your members, and then you feel it: pre-cum mixed with your liquid relief pushing back into your [pc.cock " + cockIdx + "].");
	output("\n\nOrgasmic pressure has reversed the liquid flow, and the moment his hips lift from the floor, carrying you with them, the pressure redoubles, turning your urethra into a minotaur cum pipeline. Some of your own is mixed in of course, but you’ve never had the alabaster jism applied to your body so directly. You sag bonelessly into the brute’s grip as he turns you into his personal twinkie");
	if (pc.balls == 0)
	{
		output(", fat with bull-cream.");
	}
	else
	{
		output(". Your [pc.sack] swells larger and larger, complete with the realization that your [pc.balls] are being transformed into spooge-filled balloons.");
	}
	output("\n\nYou should be alarmed or worried, but mostly you’re amazed by how good it feels. How great it feels to go limp in his powerful arms. How wonderfully warm and content his narcotic spooge makes your body feel. You drool on his chest, then lick it back up, savoring the salty, sweaty tang of it. Your mouth feels empty without his cock, but then you realize you can suck his nipple until his cock is free.");
	output("\n\nMinotaurs are so great. A fuzzy memory of some other desire tries to make itself known, but another buck of your bull’s hips has your head swimming and your body cumming. The pressure of your own ejaculation is nothing next to his of course. You doubt you could squirt anything out ever again. Your insides must be all stretched out with your lord’s love, but that’s fine so long as he uses you again. You can be his dribbly little spunksleeve.");
	badEnd();
}

private function buttufucku():void
{
	flags["COC.MINOTAURKING_FUCKED"] = 1;
	clearOutput();
	output("Why fuck the spoiled tart when you’ve got such a virile, muscular specimen at your beck and call? He’s pumping his cock with wild, frenetic strokes, spurting bullet-sized bursts of pre-cum over his musky balls and abdominal fur, but no matter how he tugs or squeezes, he doesn’t seem to be getting any closer to release.");
	output("\n\nHow perfect. You shed your [pc.gear], intent on a little relief yourself. Normally a brute like this might take offense to the forceful claiming of his backdoor. Now, when he’s writhing and bleating, begging the demons in the audience to mount him and provide relief? He’ll accept anything you give him, even if it’s a thorough prostate pounding. Your [pc.cocks] swell");
	if (pc.cocks.length == 1)
	{
		output("s");
	}
	output(" at the thought, growing hard and firm, ready to batter through the bull’s clenching ring. This is going to be fun.");
	output("\n\nYou kick the minotaur King’s legs apart for better access and sidle in close, one hand idly pumping at your [pc.cock " + pc.biggestCockIndex() + "] while you do your damnedest not to give in to the delicious scent. No matter how pernicious the desire to indulge in his aroma, how wonderful it would be to press your cheek against that pillar of masculinity and lick, you know you have to resist it or you’ll forget all about getting yourself off and taking down Lethice.");
	output("\n\nShe’s watching you too. Her hungry, soulless eyes are watching you stroke your cock, watching you line it up with the angry pucker of the minotaur King’s asshole. The corrupt Queen licks her lips when you push forward. You rub your [pc.cockHead " + pc.biggestCockIndex() + "] against her most trusted servant’s entrance, slowly splitting his derriere, reshaping it into a vessel for your pleasure. He’s tight, tighter than you would expect from such a massive creature. His asshole clutches at every inch of cock you feed it, almost like it wants to squeeze you off, to massage you with rapt enthusiasm.");
	output("\n\nThe royal minotaur’s pained moo tells quite the different story. His horned visage stares down at you in disbelief, but his cock perceptibly plumps between his fingers, displaying a network of bulging veins all too happy to have you stimulate him from behind. Slapping his ass, you give him more of what his body so unsubtly craves. You thrust");
	if (pc.biggestCockLength() >= 24)
	{
		output(" until his belly bulges with the clear outline of your [pc.cockNounSimple " + pc.biggestCockIndex() + "], displaying just how fully he has been taken to the entire assemblage. You’ve claimed this once noble beast, turned his body into a fuzzy, pleasant-smelling condom for your excessively-large cock.");
	}
	else if (pc.biggestCockLength() >= 12)
	{
		output(" until you’ve fed his ass the whole of your girthy rod");
		if (pc.hasKnot(pc.biggestCockIndex()))
		{
			output(", knot and all");
		}
		output(". A visible bulge presents itself on the once-noble beast’s belly, declaring your dominion over him for all to see. Whatever he was before, he’s your cock-sleeve now.");
	}
	else
	{
		output(" until you’ve buried the entirety of your [pc.cockNounSimple " + pc.biggestCockIndex() + "] inside his snugly squeezing intestines, repurposing his digestive system into your own personal, phallus playground.");
	}
	output("\n\nThis really is a first class asshole. It’s elastic enough to take anything you could offer it and strong enough to provide the perfect amount of friction. Whenever that friction flags, you can just slap him on the ass, and he tightens right up. Best of all, his constantly-dribbling pre-spunk inevitably drips down onto your member as you saw it between his buttcheeks, lubricating you with enough of the sticky to stuff to making fucking him an absolute breeze.");
	output("\n\nWhat a waste of perfectly good muscle. All this time, this big, slutty minotaur has been free to wander around ramming his cock inside of everyone else when he had a treasure like this packed between his tight, toned buttcheeks. Grabbing hold of his thighs, you snarl and pound his ass harder. Your heartbeat is hammering in your ears. Your dick is hard enough to chisel stone, and you’re having a really hard time seeing anything past the swaying horse-cock a few inches in front of you.");
	output("\n\nThe King’s cock stands straight upright, three feet of heavenly member with a flare that seems wider by the second. You delight in drilling into him, humping inward and upward to rub against the edge of his prostate. Whenever you hit it, his dick’s dribbles turn into squirts. Some falls on your [pc.hair] and nose, but you wear it as a badge of honor, proof of just how much you’re making this once-proud minotaur a slave to the anal pleasures you’ve given him.");
	output("\n\nHe wriggles and twists, on the edge of a no-doubt impressive orgasm. You’re right there with him too. His ass is a cock heaven");
	if (pc.cocks.length > 1)
	{
		output(", and the feeling of your other member");
		if (pc.cocks.length > 2)
		{
			output("s");
		}
		output(" slipping and sliding past his quivering balls certainly doesn’t hurt");
	}
	output(". If you didn’t have better things to do, or his scent toying with your mind, driving your ardor higher and higher the longer you breath it in, you could savor this for hours. But you’re dizzy with need and in a hurry.");
	output("\n\nDeciding to give yourself a little reward, you lean forward and slip your tongue against the pre-soaked surface of the King’s majestic cock, trembling in orgiastic ecstasy as the taste pushes you over the edge.");
	if (pc.hasKnot(pc.biggestCockIndex()))
	{
		output(" Your knot balloons.");
	}
	else if (pc.hasCockFlag(GLOBAL.FLAG_FLARED, pc.biggestCockIndex()))
	{
		output(" Your flare expands right on cue, matching the one pressing back against your tongue.");
	}
	else
	{
		output(" His flare blooms with all the force of a mushroom cloud, nearly pushing your tongue back into your mouth.");
	}
	output(" You erupt a split-second before he does, squirting thick ropes of jism into his sucking asshole. Then he goes off, shooting a torrent of spunk twenty feet into the air. Horned goblins dance in the deluge, tongues extended and hands cupped to catch as much as possible.");
	output("\n\nSome lands in your mouth while you’re moaning and cumming, hot and fresh, somehow making your orgasm hotter still, juicier than you can truly comprehend.");
	if (pc.cumQ() > 2500)
	{
		output(" The King’s belly swells");
		if (pc.biggestCockLength() >= 18)
		{
			output(" even bigger");
		}
		if (pc.cumQ() > 5000)
		{
			output(", but you’re far from done. You pressurize his entire digestive system. The last few ejaculations backblast out over");
			if (pc.balls > 0)
			{
				output(" your balls");
			}
			else
			{
				output(" your crotch");
			}
			output(", creating a [pc.cumVisc], [pc.cumFlavor] puddle on the floor");
		}
		output(".");
	}
	output("\n\nThe beaten brute squirms and writhes long after you both of you finish cumming, lost in barely understood pleasure. You pull out before his over-eager motions carry you with him, noisily licking his residue from your lips and preparing to get on with your business. The taste might be keeping you hard, but you feel more than sated enough to take on a demon queen.");
	processTime(18 + rand(10));
	pc.orgasm();
	pc.lust(10);
	CombatManager.genericVictory();
}	

private function mechanicalbullhue():void
{
	flags["COC.MINOTAURKING_FUCKED"] = 1;
	clearOutput();
	output("Well, you’ve been handed a prize bull on a silver platter, why not help yourself to his delectable meat? It’s right there, trembling with need and polished to perfection by his erstwhile lover’s affections. It’d slip right in");
	if (pc.vaginalCapacity() <= enemy.biggestCockVolume())
	{
		output(", probably");
	}
	output(".");
	
	if (pc.looseness() == 4)
	{
		output(" One of the perks of having experience with well-endowed lovers is not having to second-guess yourself when you come upon a real treat like this one.");
	}
	else if (pc.looseness() < 4 && pc.vaginalCapacity() < 200)
	{
		output(" You’re not the most experienced at handling such well-endowed studs, but even if you’re wrong, nothing beats trying.");
	}
	else
	{
		output(" A big thing like that would stretch you so wonderfully. You barely manage to swallow before you start to drool.");
	}
	
	output(" All you have to do is climb on. Excellia doesn’t look like she’d mind.");
	output("\n\nAnd the King still smells like sex filtered through an angel’s veil, like endless hours of bareback plowing in a pristine, flowering field. You nose twitches as you approach, and your cunny");
	if (pc.wetness() >= 4)
	{
		output(" gushes, drenching your thighs");
	}
	else if (pc.wetness() >= 3)
	{
		output(" drools rivulets of desire down your thighs");
	}
	else
	{
		output(" drenches itself anew");
	}
	output(". Part of you is tempted to drop to");
	if (pc.hasKnees())
	{
		output(" your knees");
	}
	else
	{
		output(" the ground");
	}
	output(" and take him into your mouth, to see if he tastes as good as he smells. You could take him deep into your throat until your nose nestles deep into the curly brush of his pubic hairs, fully immersed in the taste and scent of this bastion of masculinity.");
	output("\n\nA taste just won’t do. The empty ache of your throbbing quim won’t abide you wasting your time with senseless oral, not when a ribbed column of pussy-pleasing fuckmeat is this close at hand. Droplets of feminine leakage spatter the monarch’s shaggy fur behind you while you climb into position above the mountainous member. Your lips are so inflamed that you swear you can feel them squishing and sliding against the hard nub of your clit with every shift of your hips.");
	if (pc.hasCock())
	{
		output(" Your dick");
		if (pc.cocks.length > 1)
		{
			output("s");
		}
		output(" twitch");
		if (pc.cocks.length == 1)
		{
			output("es");
		}
		output(" along with the eager beats of your heart, and in a moment of weakness, you lean down to drag your " + pc.cockHead(pc.biggestCockIndex()) + " along the Minotaur King’s length. It is but a brief dalliance - foreplay before you put him where he belongs. With a regretful sigh, you stop frotting and line him back up.");
	}
	if (pc.looseness() >= 5)
	{
		output("\n\nEasing his tremendous dick into your gaping cunt feels like the most natural thing in the world. All your previous encounters were nothing more than practice to take this bestial rod deep inside yourself. It’s flaring too, imbued with more lust than any mere mortal was meant to handle, swelling to push and stroke against your straining walls as it nestles its way inside of you. It’s perfect. To find such a perfectly-shaped lover so close to your goal... you couldn’t have planned it any better.");
	}
	else if (pc.looseness() >= 1)
	{
		output("\n\nThe first attempt to guide the King’s cock into your anxious slit is nearly a failure. The flaring, flat-headed tip spreads you open, but not nearly far enough for it to slide into your honey-coated cavern. Grunting in distress, you give it a little wiggle, slipping the left side of the horse-like cock inside before working in the other. You have to stop, gasping and panting at the raw sensation of it, struggling to come to grips with it before you can continue your delectable descent. Never before have you been so wholly filled with cock, and you’re just now lowering yourself down the rest of the way.");
	}
	else
	{
		output("\n\nYour first attempt to force the fleshy totem into your virginal");
		if (!pc.vaginas[0].hymen)
		{
			output("-looking");
		}
		output(" gates meets with about as much success as one could expect. Despite the almost hilarious mismatch in the sizes of your genitalia, you’re determined to take it all. Holding it in both hands, you press against the flared tip, gyrating your lips against the blunt crown until his pre and your juices are intermingled into a fuck-happy slurry. Then, one of your lips catches on the edge of his beastly flesh, pulled apart with surprising elasticity.");
		output("\n\nYou repeat the action on the other side and gasp in delight as your entrance blooms like an exotic flower, opening up to reveal its pink-tinged interior to its mate. Somehow, your [pc.vagina] is opening wider and wider, and it doesn’t hurt in the slightest. Perhaps the bath of royal pre-spunk is loosening it up, or maybe the Minotaur King is blessed with some sort of inherent magic that allows him to claim even the smallest of willing females as his own. Either way, it’s for the best.");
		output("\n\nYou go from a needful vacuum of sensuous hunger to more stuffed than a Christmas turkey in all of about five seconds, and you couldn’t be happier. The torment of an empty, unfilled pussy has been replaced with a seductive pleasure that steals your breath and addles your reason. You wish you could somehow be even wetter, even hotter, to wring still greater surges of bliss from your sex.");
	}
	output("\n\nThree rings are the next challenge standing between you and total impalement. Equidistant along the Minotaur King’s shaft, those medial rings are small but significant obstacles along your erotic journey. The first actually bumps against your [pc.clit]");
	if (pc.hasCock())
	{
		output(", stimulating the base of your jutting she-dick");
	}
	output(". You reverse direction and slide up, filling the air with the sloppy sound of withdrawing phallus, then drop back down, using the momentum to spread your buttery lips over the first obstruction. Your eyes actually roll back from the raw sensation of it.");
	output("\n\nSplashes of warm pre-cum splatter off of your cervix. The big boy likes it.");
	output("\n\nIt’s hard to think about much right now. Whether it’s his pheromone-laced scent pushing you into an artificial heat");
	if (pc.lustQ() >= 80)
	{
		output(" - not that you needed much help -");
	}
	output(" or his unbelievably potent fluids addling your mind, you find it hard to care. The heat burning");
	if (pc.isBiped() || pc.isTaur())
	{
		output(" between your legs");
	}
	else
	{
		output(" in your loins");
	}
	output(" is too demanding, too all consuming to mind one way or the other. Why should it matter anyway? You’re going to bounce on this lordly stud’s prick until your pussy is raw and flooded, bathed in spunk.");
	output("\n\nYou hear the quiet pop of another ring entering your pussy. Drizzles of excitement slide out around him, and in between moans, you’re shocked to realize that you nearly came. Your hand winds down to your [pc.clit] to finish the job.");
	output("\n\nBelow, the bull king is groaning and grunting. One meaty hand cradles your [pc.butt]");
	if (!pc.isTaur())
	{
		output(" in its entirety");
	}
	output(" while his hips lift to meet your downward strokes. A cylindrical bulge distends your belly. The assembled audience can actually watch the progress of his member into your canal. They can see the head flare wider when your cunt pleases him");
	if (pc.tallness <= 50 && pc.thickness <= 10)
	{
		output(", stretching your skin until it shines");
	}
	output(".");
	output("\n\nWhen the hand on your [pc.butt] abruptly firms its grip and begins to pull you down, you lose it. Your eyes cross. Your back arches. Girlcum erupts from your pussy, soaking into the sensitive skin of the brute’s sheath just in time for your quivering folds to kiss it. You’ve taken his third ring, slid the whole way down to his base, all without any awareness of it. Like finding a needle in a haystack, picking apart the individual notes of pleasure thrumming through your mind is impossible. It’s like a white wave of bliss that slashes back and forth between your ears, yoked to the tempo of the up-and-down slide of your [pc.vagina].");
	output("\n\nYou slap your spasming fingertips down against the beast-man’s sweat-oiled chest, needing the leverage to hold yourself upright. Your muscles aren’t working quite like they should. None of them are, same for the ones listening to your pussy’s siren song. Those are working like a vice, rolling up and down along surprisingly winsome member. Your voice is screaming and gasping, faltering breathlessly when the ecstasy becomes too overwhelming.");
	output("\n\nNo respite is given to your beleaguered body. Just as you start to come down, your traitorous nerves wrack you with a whole new orgasmic high");
	if (pc.isLactating())
	{
		output(", tricking your full nipples into spraying their milk everywhere");
	}
	else
	{
		output(", denying you even the chance to climb off");
	}
	output(". Your body has given itself over to this hedonistic relief. So long as the minotaur’s hips saw in and out of your soaked delta, you’re going to keep cumming.");
	output("\n\nThen you feel it. The swollen crown of the King’s equine phallus palpably expands inside you, arresting your motions. Somehow it doesn’t");
	if (pc.isPregnant(0))
	{
		output(" force its way past your cervix");
	}
	else
	{
		output(" tear open your womb");
	}
	output(". Your insides stretch like they’re made of rubber");
	if (pc.looseness() >= 5 || pc.elasticity > 2)
	{
		output(", which isn’t far from the truth,");
	}
	output(" in order to accommodate the swelling intrusion. The beast below roars. You can feel the bass rumble in your bones - and your [pc.clit].");
	if (pc.hasCock())
	{
		output(" Hell, you can feel it surging through your [pc.cocks], vibrationally expelling the last few unspent drops from your urethra");
		if (pc.cocks.length > 1)
		{
			output("s");
		}
		output(".");
	}
	output("\n\nHis cum is unbelievable. It comes out like water from a pipe, only warm and gooey inside you. Your belly expands from the erupting beast-spunk, filling out into an idol of perverse fertility. One of your hands reaches over to cradle it, feeling your increasingly gravid dome swell until the edge of the minotaur’s flare is no longer visible. Torrents of white pour out from your lips. The scent of his alabaster cream is so strong that you feel dizzy - or maybe that’s all the druggy, narcotic-laced bullspunk soaking your insides. Either way, it’s a fantastic rush completely at odds with your spooge-gifted immobility.");
	output("\n\nThe Minotaur King’s touches fall away the moment your belly stops inflating. The poor brute has passed out, literally fucked into unconsciousness by your teasing and subsequent ride, and while his cock doesn’t go soft in the slightest, his flare does shrink down, allowing your body to slowly vent a tide of animalistic sperm. Once you are no longer encumbered by your own inflation, you doggedly rise, dragging your [pc.vagina] off the rigid cunt-buster with agonizing slowness.");
	output("\n\nYou nearly don’t make it. You’re all dizzy from the minotaur cum and multiple orgasms, and the crossing over three rings and a flare nearly takes you back to the peak. When the fat head finally pops free from your labia, you breathe a ragged sigh of relief and tumble off");
	if (pc.isBiped())
	{
		output(", [pc.legs] akimbo");
	}
	output(". The artificial euphoria this has brought you makes it difficult not to crawl over to the nearest incubus and offer your body up, but you still have to deal with Lethice. Maybe you can make her lick the drippings from your slit after you take her down.");
	output("\n\nWith that fantasy firmly in mind, you stand up and fix your [pc.gear]. You can still do this, right?\n\n");
	//pc.createStatusEffect(StatusEffects.MinotaurKingsTouch,0,0,0,0);
	flags["COC.MINOTAURKINGS_TOUCH"] = 1;
	//pc.minoCumAddiction(20);
	//pc.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR - 48);
	pc.loadInCunt(enemy);
	processTime(25 + rand(10));
	pc.orgasm();
	pc.lust(5);
	CombatManager.genericVictory();
}

private function titfuckCowslut():void
{
	flags["COC.MINOTAURKINGSSLUT_FUCKED"] = 1;
	clearOutput();
	output("Forget that beefcake; there’s a primo slut close at hand with a set of tits that’d be worth damnation to fuck. It’s a good thing Lethice is giving you this chance to sate yourself. You might have had to risk giving them a good fucking even if she didn’t. Pulling [pc.oneCock] out of your [pc.gear], you advance on the fallen slut, feeling momentarily sorry for her.");
	output("\n\nExcellia is barely conscious. Her pussy is gaped wide open and still drooling her master’s excess spunk. Her eyes are glassy and a little unfocused. When you climb atop her though, she manages to smile at you and grab hold of her boobs. The touch alone sends her into a moaning fit with her eyes half rolled back and her tongue hanging out. Her tits are <i>sensitive</i>. You aren’t sure if she’s naturally a perfect tit-fuck-slut or if it’s an effect of her master’s druggy cum, but it really doesn’t matter to you.");
	output("\n\nThe quivering cow moans once you place your [pc.cock] into her canyon-like cleavage and props her tits up with her elbows, sealing you inside the mountains of mammary flesh. Her fingers nearly disappear into the soft pillows, squeezing jets of uncontrolled milk from her chocolate-brown nipples. Remembering what it did to your fallen foe, you avoid drinking it yourself, letting it cascade back over the bouncy tits and into the oh-so-pleasant crevasse between.");
	output("\n\nHer milk isn’t a perfect lubricant, but it slickens her skin enough to let her milky mounds glide across your [pc.cock] almost as well as a sodden pussy. Ever the slut, Excellia moves her enormous tits for you, sliding them back and forth along your length with a gentle but  arousing rhythm. The real delight is in the show this motion provides, jiggling her melons delightfully, allowing you to enjoy the play of light across their gleaming curvature.");
	output("\n\nYou twitch in her velvety embrace, and Excellia manages to smile.");
	output("\n\nThe slut is loving this even more than you are, no two ways about her. Her full lips are almost always parted by moans. Her face is flushed. Heck, she’s still squirting milk. The flow is stronger when your cock is fully embedded in her chesty embrace, pressing back against the fluid-reservoirs in countersync to her busily kneading hands. A body like this... it’s made to be fucked and used. No wonder the Minotaur King claimed her as a concubine.");
	output("\n\nNo more. As of this moment, she’s yours to enjoy. Your’s to climb on board and ride until you’re milked of every drop. When your [pc.cockHead ] clears her cleavage, Excellia even remembers to suck it. She doesn’t always. Sometimes her lips are busy releasing a joyous moo or inarticulate screech of bliss, but most of the time, she’s all too happy to wrap her gold-gilt lips around your [pc.cock].");
	output("\n\nWait... gold lips? Like the harpies?");
	output("\n\nDesire wells up inside you potent and uncompromising. No wonder your opponent was always rock-hard. Your own dick throbs angrily against the pillowy embrace of the cow-slut’s tits. delirious with the need for release and yet craving nothing more than endless breeding by the nearest female. Fuck!");
	output("\n\nYou grab hold of one of her horns and pin her head back before she can dose you with any more of her arousing drug. You’re going to win this, and you can’t do that if this slut gets her lips on you again. Pinching one nipple, you cut off the flow of milk and begin to powerfully thrust your way between her sensitive breasts, rudely plowing Excellia’s tits with no considerations for her enjoyment.");
	output("\n\nIt doesn’t matter. The moment you start to use her more aggressively, you can actually hear her slutty slit leaking onto the floor behind you. She’s clearly used to being used and abused like this. Maybe she even enjoys it. You pinch a nipple and listen to her scream another moo of delight, then you grab hold of the other and repeat the action. Whenever she seems to be considering going for your cock again, you pinch down on both sides, denying her with nothing more than her body’s own too-raw sensation.");
	output("\n\nYou lose track of how many times the eager fuckslut gets her rocks off, but you’re not far yourself. The residual effects of her lipstick are a constantly rising crescendo of erotic energy inside you, to say nothing of the delightful squish of her tits on your [pc.cock]. Howling in delight, you redouble your pace, determined to wring every ounce of pleasure from this slut’s whorish boobs. Her broad, cow-like tongue is hanging out in a blissed-out expression. You wonder if you can paint it white.");
	output("\n\nWhen you go off, you slam yourself home and savor the tight, titty-squeeze, squirting thick ropes of jizz at your target.");
	if (pc.cumQ() <= 500)
	{
		output(" Most fall short, but one daring squirt manages to coat Excellia’s tongue.");
	}
	else if (pc.cumQ() <= 1500)
	{
		output(" Most manage to fall on Excellia’s tongue, painting it a nearly [pc.cumColor] save for a few off-color splotches. The rest puddles in the nape of her neck, giving you time to enjoy the cow-print tongue you’ve created.");
	}
	else
	{
		output(" Excellia’s tongue never stood a chance. You cover most of it in the first shot alone, pouring much of the rest down her throat. Bits of sperm fleck her cheeks, and a deep puddle forms at the nape of her neck, complete with dribbling tributaries along her collarbones.");
		if (pc.cumQ() >= 5000)
		{
			output(" And her breasts? They’re basically [pc.cumColor] save for their peaks.");
		}
	}
	output("\n\nRegrettably, you’ve got work to do. You extricate yourself from the cum-and-milk splattered cow-girl and stand up, regarding the awaiting demoness.\n\n");
	processTime(12 + rand(10));
	pc.orgasm();
	pc.HP(pc.maxHP());
	CombatManager.genericVictory();
}

private function sloppySeconds():void
{
	flags["COC.MINOTAURKINGSSLUT_FUCKED"] = 1;
	clearOutput();
	output("Why resort to making use of the brutal minotaur when there’s a puddle of wet trollop so close at hand? It’s a good thing that all the spunk leaking from between her legs actually smells");
	if (pc.hasPerk("Minotaur Cum Addict") || kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_STATE"] == 2)
	{
		output(" wonderful");
	}
	else
	{
		output(" sort of... nice... sexy even");
	}
	output(", or you might have had second thoughts. Her creampied honeypot ought to feel like teflon-treated silk against your [pc.cock " + pc.biggestCockIndex() + "]. It glitters in the flickering, bedroom light of Lethice’s throne room, beckoning you to plunge inside and see just how good it will feel.");
	output("\n\n<i>“Hrmmm, again?”</i> Excellia dreamily coos, lifting her ass up into position. <i>“...yes sir, I’m always rarin’ for a fuck.”</i> She happily sighs and wiggles her ass in your direction, completely unaware that you’re the one advancing toward her ass with a aching cock");
	if (pc.balls > 0)
	{
		output(" and " + num2Text(pc.balls) + " balls full of cum");
	}
	else
	{
		output(" and a load of backed-up cum");
	}
	output(". You don’t see much point in correcting her, not when she’s presenting so enthusiastically. Grabbing hold of her tail, you yank her into position, positioning your [pc.cockHead " + pc.biggestCockIndex() + "] just outside the cream-drizzling gates of her cunt.");
	output("\n\nExcellia moans, <i>“So gentle, Lord! Please, don’t make me wait!”</i>");
	output("\n\nSavagely tugging on her tail, you bury yourself into well-stuffed quim, unable to believe that this passes for gentle in the service of the Minotaur King. Each");
	if (pc.balls > 0)
	{
		output(" ball");
	}
	else
	{
		output(" ass");
	}
	output("-slapping impact ripples through the plush cow-slave’s derriere like waves through a pond. She exhales blissful little moos, pushing back against you to the same tempo, ever the faithful cock-milker.");
	if (pc.biggestCockLength() < 18)
	{
		output(" You don’t think she could possibly confuse your less-impressive erection for her minotaur master’s, but she doesn’t give any sign of caring. Perhaps all the minotaur jism stuffed in her twat has left her beyond caring, or maybe she’s just happy to serve a dick - any dick.");
	}
	else if (pc.biggestCockLength() <= 30)
	{
		output(" You didn’t think she’d confuse your prick for her master’s, but she’s happily fucking it all the same. It probably stretches her cunt just about as much.");
	}
	else
	{
		output(" You don’t think she could possibly confuse your slab of cock for a smaller sample like her minotaur master’s, but she doesn’t show much sign of caring. Perhaps all the minotaur jism stuffed in her twat has left her so inundated with pleasure that worry is beyond her. So long as she’s split with a massive shaft, what’s the difference?");
	}
	output(" You can see why the overgrown beast-man keeps her around.");
	output("\n\nThe quivering cow-slut’s cunt is fucking magic too. It feels like her muscles are pulling you deeper with every thrust, coaxing your [pc.cock " + x + "] to sprout another inch if only to better fill. Gods, you’re getting harder and harder. She feels so damned good that it’s making your head spin, making it impossible to do anything but grab hold of her ass and squeeze like your life depends on it. In this moment, bereft of anything but the sinful squelches emanating from Excellia’s too-moist muff, you feel like you love her, or at least her pussy.");
	output("\n\nFuck, you could love almost anyone right now. If the crowd around you wasn’t composed of soulless abominations, you’d probably love them too. You knead her ass some more, watching it give beneath your fingers. Your digits nearly disappear into the cushy, fuckable asscheeks, and you grunt in approval. It’s hypnotic. You’re still fucking her, of course. You couldn’t stop if you wanted to, but there’s a strange disconnect between your hips and the rest of your awareness, like there’s so much pleasure that you’ve gone with numb it.");
	output("\n\nArcs of electric bliss hum and sizzle through your [pc.cock] from second to second, popping in starbursts behind your eyes that make it hard to focus on anything but the swaying ass in front of you. You ravage Excellia on autopilot, groaning in delight as realization finally dawns on you - all the minotaur cum inside of her is affecting you, somehow. And there’s so much of the stuff! Creamy white blobs slop out whenever you pull out or thrust in, but there’s always more inside her to bathe your member, cocooning it in layer after layer of narcotic aphrodisiac.");
	output("\n\nPart of you wants to stop, but that part of you is getting smaller with every thrust. This is wonderful, the raw, almost feral feeling of an athletic fuck unbounded by civilization or decency. Excellia’s pussy was designed to glove your [pc.cock " + pc.biggestCockIndex() + "] perfectly, to match its ravenous thrusting with a sordid massage. Faintly, you hear cheering and the greedy slut begging for more. She wants you to cum inside of her; you can tell. Everything from her body-language to the pitch of her delirious voice is begging you to feed her overactive ovaries their second meal of the hour. Her body is ravenous for cum, even when she’s so stuffed with it that it won’t stop pouring out.");
	output("\n\nYou need to get off more than you ever thought possible. Logically, you want this over quickly so that you can fu- face Lethice in all her naked glory. You bet you’ll even get to squeeze her tits at least once before you take her down... Those purple orbs beckon for your fingertips. But then there’s the ecstatic undulations wreathing you in fleshy heaven, caressing your nerves with individualized attention, playing your body like a harp. How could you possibly want this to end? You’ve grown so addicted to this pleasure in such a short time that ever leaving it seems an alien concept to your cunt-obsessed mind. You want to fuck this pussy <i>forever.</i>");
	output("\n\nThe light shimmers across Excellia’s sweat-shined ass hypnotically from the hard-fucking you’re giving her. You swat it, just to watch it ripple - and to feel the way Excellia clenches down around you, her voice lilting into an almost musical, blissful moo. It’s fascinating, how her body reacts to your thrusts, the way she seems to wrap her whole self around you. You barely register than you’re panting or that your [pc.cock] is hard enough to cut diamonds.");
	if (pc.cocks.length == 2)
	{
		output(" Your other penis is enjoying sliding between her perspiring thighs almost as much.");
	}
	else if (pc.cocks.length > 2)
	{
		output(" Your other penises are enjoying sliding between her perspiring thighs nearly as much.");
	}
	output("\n\nIt isn’t desire that brings you off. It’s your body’s simple, biological imperative to breed. No matter how much you may want to endlessly rut against this avatar of fertility, your body eventually reaches the point where the [pc.cumNoun] it’s churning out is too voluminous to contain any more. The upwelling of your seed triggers blissful contractions inside your body, and like the flipping of a lightswitch, you’re abruptly cumming, spewing your load into this living spooge-sinkhole.");
	output("\n\nExcellia moos ear-splittingly loudly, clenching down on you as you climax, sealing your rapidly ejaculating load inside herself.");
	if (pc.hasKnot(pc.biggestCockIndex()))
	{
		output(" There’s not much point in it; your knot does that much and more, trapping your load inside as effectively as the remainder of the Minotaur King’s.");
	}
	output(" Your");
	if (pc.isBiped() || pc.isTaur())
	{
		output(" [pc.legs] wobble");
	}
	else
	{
		output(" [pc.leg] wobbles");
	}
	output(" weakly beneath you, dumping you and your jiggly concubine to the floor mid-orgasm, but it doesn’t slow your ejaculation in the slightest. You feel like you could keep cuming for ever, clenching and releasing, feeding wave after wave into the happily mooing bovine temptress.");
	output("\n\n");
	if (pc.hasKnot(pc.biggestCockIndex()) && pc.cumQ() >= 5000)
	{
		output(" Excellia’s belly bulges into an exceedingly pregnant state, stuffed with so much of your [pc.cumNoun] that she looks nine months pregnant and then some. Her belly button pops out just before you finish squirting into her, diluting the bestial brute’s druggy load with the seed of a Champion.");
	}
	else if (pc.cumQ() >= 5000 && !pc.hasKnot(pc.biggestCockIndex()))
	{
		output(" Excellia’s muscular control is no match for the sheer virility of your load. The gates of her cunt give out in short order, releasing a flood of Champion-diluted minotaur spunk onto the ground. She whimpers and cries out in ecstasy, driven to the peak again and again by the continuous flooding of her womb with your seed.");
	}
	output("\n\nPivoting on your prick, dragging her velvety dicksleeve in a delightful 180 on your length, Excellia crawls atop you, still shaking. Her pussy is still squeezing and clenching down around your [pc.cock " + pc.biggestCockIndex() + "], keeping your attention focused solely on the itch between your thighs. Your overstimulated crotch has no choice but to climax once more, orgasming to the insatiable mynx’s demands. There’s not much to left to give her, but that doesn’t stop you from writhing in ecstasy, or groping her tits in wild excitement.");
	output("\n\nYou aren’t sure how many more times you give it to her, but by the time you finally manage to extract yourself from her wanton lips, the Minotaur King has been dragged into the crowd.");
	output("\n\nLethice looks bored, drumming her fingers on the edge of her throne. Time to deal with her.\n\n");
	processTime(15 + rand(10));
	pc.orgasm();
	CombatManager.genericVictory();
}

public function hailToTheKingBaby():void
{
	clearOutput();
	var mk:CoCMinotaurKing = enemy as CoCMinotaurKing;
	var hpVictory:Boolean = pc.HP() < 1;
	if (!hpVictory)
	{
		output("Your determination burns away in the fires of your desire, nothing against molten need burning through your brain. How could you ever resist this magnificent beast? His magnificent cock is so big... so hard");
		if (mk.orgasms > 0)
		{
			output("... so wet with the juices of his slut");
		}
		output(". It fills your vision and your thoughts. It would be so easy to bend over for him, to lift your [pc.butt] up in the air and wiggle it in his direction until the big brute forced himself on you. Gods, he could stuff you so well. It’s be so perfect, him inside you, the head of his gigantic monster-cock clearly outlined on your belly.");
		output("\n\n<i>“Are you giving in already?”</i> The minotaur king grabs hold of your head, nearly enveloping your entire skull in the palm of his head. <i>“No matter how well they fight, they all wind up like you. If you could see yourself right now... you’d want to fuck you too.”</i>");
	}
	else
	{
		output("You’ve been beaten. Staying upright has become an almost impossible task, and the idea of fighting little more than a pipe dream. Still wobbling in place, you look up in time to see the brute approach, laughing jovially.");
		output("\n\n<i>“There we go. Just accept it.”</i> The minotaur king grabs hold of your head, nearly enveloping your entire skull in the palm of his head. <i>“You fought well, for a human, but you don’t need to fight any more.”</i>");
	}
	output(" He drags you up against his crotch, smearing his sweat and sex-soaked balls against your face. It feels thick and oily on your cheek but smells like getting fucked bareback until your eyes roll back and your tongue lolls out.");
	output("\n\nYou wanted to fight this, you’re sure. You didn’t come here to lean against his comforting warmth and breathe in more of his salt and tang musk. Powerful veins bulge against your forehead, and pre-cum drizzles down into your [pc.hair]. There’s no escape now. No matter what you do or where you go, that scent is going to cling to you. The scent of royal... powerful cock. Girls will drench their panties just from being close to you, and you’ll never be able to think of anything else. The next breath you take is punctuated by a whimpering moan.");
	output("\n\nHis cock drags past your temple to your cheek as the King lifts you higher. Your lips brush the edge of his meaty shaft, and your tongue snakes out unbidden. <i>Just a taste</i>, you tell yourself. <i>Just a taste.</i>");
	output("\n\nPre-cum, sweat, and skin blend together into an ambrosial feast. Your taste buds are overwhelmed by the flavor. Torrents of red-hot, chemically-assisted pleasure seem to wash your other senses away, leaving you little more than a wiggling tongue and a hungry, empty mouth. How much better would it be to capture the tip? Would you forget the shame of your defeat? Could you live the rest of your life like this, wiggling happily on the end of a royal rod?");
	output("\n\nOnly one way to find out.");
	output("\n\nYou push back against the hand holding you back, grabbing hold of the oozing cock in both hands to pull the blunted tip to your mouth. Spongy flare brushes your lower lip, glazing in a layer of spunky cockdrool. Rather than lick it off, you leave it there and open wide, letting the lubricating juices do what they were meant to do: help ease a dick into a too-small hole. Just getting the tip inside has your jaw aching and your mouth stretched into an impossibly slutty ‘O,’ but once you get past that, the going gets easier.");
	output("\n\n<i>“Atta " + pc.mf("boy","girl") + ",”</i> the triumphant beast-man croons. <i>“This is where you belong.”</i>");
	output("\n\nYou can hardly disagree. With his cock captive, no pre-cum will be wasted. The freely-spilling droplets have no choice but to slip down the length of your tongue and into your throat, where they can be swallowed. Your head might as well be filled with thick, pink cotton balls at this point, and every swallow, every eager gulp, adds more, blotting out worry and concern. Those anxious thoughts have no room to form, not when your head is so full of cock, literally and figuratively. Just thinking about it makes you want to smile and giggle, but there’s no room for that in a maw increasingly stuffed with phallus.");
	output("\n\nWhether you’re leaning forward to slide it deeper or the hand on the back of your head is gently but inexorably force-fucking your face is a matter of debate. With a lascivious lick, you wonder why it can’t be both? It takes two to fuck, after all. You open wider, bathing your tonsils in a fresh spurt of the minotaur’s musky gunk, not even flinching when his cockhead flatters your uvula against your palate.");
	if (pc.isBimbo() || pc.cor() >= 66)
	{
		output(" You’re long past the point of having a gag reflex and glad for it.");
	}
	else
	{
		output(" Miraculously, your gag reflex is completely absent. Maybe it’s too drenched in his heavenly pre to protest?");
	}
	output("\n\nFlaring your nostrils, you take in a huge gulp of air, just in time to fortify you before that giant slab of dickmeat blocks your lungs off completely. You tip your head back and lift your ass to straighten your esophagus, the better to accept more of this brute’s gorgeous fuckpipe. It’s just in time too. The moment he senses an opening, he plows right in, distending your throat, packing you full of more cock than you ever imagined possible.");
	output("\n\nThe head of the minotaur’s mighty member flares as it travels through your body, pushing against you with painful urgency. It would probably hurt if he wasn’t practically pissing pre-cum directly into your body, hosing the raw parts of your throat down with more of his heavenly goo. Pleasure replaces pain, and tingles of delight radiate upward from everything between your gut and your mouth. When his flaring tip finally breaches the top of your stomach, you nearly cum on the spot.");
	output("\n\nNo longer feeling the pressure of his expanding crown is an immense relief and accomplishment you feel bizarrely proud of. Your nose is pressed deep into sticky folds of the minotaur’s sheath, your lips liberally slimed with half-dried pre. The tops of his swollen, excessively virile nuts slap your chin as the brutish monarch roars in pleasure. You close your eyes and hum, perfectly content to sit here and vibrate around his cock until he dumps his prodigious load directly into your hungry belly.");
	output("\n\nYou aren’t left waiting long.");
	output("\n\nThe minotaur King lurches forward powerfully");
	if (pc.biggestTitSize() >= 5)
	{
		output(", jiggling your tits wildly");
	}
	else if (pc.hasCock())
	{
		output(", making your oozing, half-hard prick");
		if (pc.cocks.length > 1)
		{
			output("s");
		}
		output(" flail around comically, sliming the floor");
	}
	else
	{
		output(", shaking your whole body with the force of his passion");
	}
	output(". His flare somehow grows even fatter, wide enough to be visible through the [pc.skinFurScales] of your belly and hard enough for you to stroke through the intervening flesh.");
	output("\n\nHis orgasm rocks your entire world. The first squirt alone fills your stomach to capacity, giving you a nicely-rounded cum paunch. The second stretches your tummy into gravid obscenity. Your eyes roll back, both from lack of oxygen and the super-sized load of druggy, mind-obliterating minotaur spunk. You barely register the feeling of his cannon-like ejaculations pushing you off his spasming member. You definitely don’t remember opening wide and letting him paint your face and hair in a mask of it.");
	output("\n\nEverything is too hazy to clearly piece together, just flashes of memories, sensations, and an all-consuming bliss. Excellia’s hands on your [pc.chest], stroking and squeezing, massaging her lord’s copious ejaculation into your [pc.skinFurScales] until you gleam with it. Imps jacking off high above, mixing their tainted spooge in with the pure love of your majestic master. Lethice may have even fucked your ass. Somebody definitely did.");
	clearMenu();
	addButton(0, "Next", gurglegurgle);
}

private function gurglegurgle():void
{
	clearOutput();
	output("You wind up being grateful for that half-forgotten assfucking later, when the minotaur King finally lays claim to your other end. That little bit of extra gape and lubrication is enough to help him lodge his humongous pecker deep into your asshole. Just like with your throat, you find him easier to handle than his size alone would suggest, but that does nothing to diminish the obscene fullness occupying your mind.");
	output("\n\nIt’s wonderful. Even when he’s not fucking your ass, he’s rock hard and dribbling, giving you a constant feed of the fluid you’ve fallen in love with. You let him carry you around like that. That’s what you tell yourself, anyway. The big lug would probably pin you in place if you tried to struggle, but you can’t imagine yourself fighting this.");
	output("\n\nSo what if you’re a dick-cozy, mounted on a minotaur’s beastly cock like some kind of trophy? Who cares if sometimes you have to lick out the Demon Queen while being reamed from behind? Everything is great. You never worry about anything, and there’s always someone filling you, fucking you full of liquid happiness.");
	output("\n\nYou smile and request someone fuck your mouth. It always feels better with one in each end.");
	badEnd();
}

private function leavethem():void
{
	flags["COC.MINOTAURKING_ALIVE"] = 1;
	clearOutput();
	output("\n\nYou square yourself off at the demon queen");
	if (pc.hasWeapon())
	{
		output(", [pc.mainWeapon] in hand");
	}
	else
	{
		output(", balled fists raised");
	}
	output(" and reject her offer out of hand. <i>“");
	if (pc.isBimbo())
	{
		output("Ummm, like, I’m not </i>that<i> horny. Besides, I can fuck all I want once I take you out, cutie!");
	}
	else if (pc.cor() >= 66)
	{
		output("Oh come on. If you’re going to give me something to fuck, at least make it something worth my time. How about your ass, after I beat you?");
	}
	else if (pc.cor() <= 20)
	{
		output("Why would I debase myself in front of you like that? The pure need no such indulgence.");
	}
	else
	{
		output("Not all of us are as enslaved by our desires as you.");
	}
	output("”</i>");
	processTime(10 + rand(10));
	CombatManager.genericVictory();
}