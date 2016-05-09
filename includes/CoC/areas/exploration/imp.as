import classes.Characters.CoC.CoCImp;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function encounterImp():void
{		
	var impChooser:int = rand(100);
	//Level modifier
	impChooser += Math.min(pc.level, 20);
	//Limit chooser ranges
	if (impChooser > 100) impChooser = 100;
	if (pc.level < 8 && impChooser >= 40) impChooser = 39;
	else if (pc.level < 12 && impChooser >= 60) impChooser = 59;
	else if (pc.level < 16 && impChooser >= 80) impChooser = 79;
	//Imp Lord
	if (impChooser >= 50 && impChooser < 70) {
		impLordEncounter();
		return;
	}
	////Imp Warlord
	//else if (impChooser >= 70 && impChooser < 90) {
		//kGAMECLASS.impScene.impWarlordEncounter();
		//return;
	//}
	////Imp Overlord (Rare!)
	//else if (impChooser >= 90) {
		//kGAMECLASS.impScene.impOverlordEncounter();
		//return;
	//}
	//else {
	//}
	
	clearOutput();
	output("An imp wings out of the sky and attacks!");
	fightImp();
}

private function fightImp():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCImp());
	CombatManager.victoryScene(CoCImpPCVictory);
	CombatManager.lossScene(CoCImpPCLoss);
	CombatManager.displayLocation("IMP");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function CoCImpPCVictory():void {
	clearOutput();
	clearMenu();
	IncrementFlag("COC.DEMONS_DEFEATED");
	//var canFeed:Boolean = (pc.findStatusAffect(StatusAffects.Feeder) >= 0);
	//var canBikiniTits:Boolean = (pc.hasVagina() && pc.biggestTitSize() >= 4 && pc.armor is LustyMaidensArmor);
	output("You smile in satisfaction as " + enemy.a + enemy.short + " collapses and begins masturbating feverishly.\n\n");
	//if (canFeed) {
		//if (pc.lust() >= 33)
			//output("  Of course you could always rape the poor thing, but it might be more fun to force it to guzzle your breast-milk.\n\nWhat do you do?");
		//else output("  You're not really turned on enough to rape it, but it might be fun to force it to guzzle your breast-milk.\n\nDo you breastfeed it?");
		//addButton(3, "Breastfeed", areImpsLactoseIntolerant);
	//}
	//else 
	//if (pc.lust() < 33 || !pc.hasGenitals() && !pc.hasFuckableNipples()) {
		//CombatManager.genericVictory();
		//return;
	//}
	
	addDisabledButton(0, "Male Rape", "Male Rape", "This scene requires you to have fitting cock and sufficient arousal");
	addDisabledButton(1, "Female Rape", "Female Rape", "This scene requires you to have vagina and sufficient arousal");
	addDisabledButton(2, "NippleFuck", "NippleFuck", "This scene requires you to have fuckable nipples and sufficient arousal");
	
	if (pc.lust() >= 33) {
		output("  Sadly you realize your own needs have not been met.");
		output("  Of course you could always rape the poor thing...\n\n");
		if (pc.hasCock()) {
			if (pc.cockThatFits(enemy.analCapacity()) == -1) {
				addDisabledButton(0, "Male Rape", "Male Rape", "You're too big to rape an imp with [pc.smallestCock].");
			}
			else 
				addButton(0, (pc.isTaur() ? "Centaur Rape" : "Male Rape"), (pc.isTaur() ? centaurOnImpStart : rapeImpWithDick));
		}
		if (pc.hasVagina()) {
			if (pc.isTaur()) {
				addButton(1, "Group Vaginal", centaurGirlOnImps);
			}
			else addButton(1, "Female Rape", rapeImpWithPussy);
		}
		if (pc.hasFuckableNipples()) addButton(2, "NippleFuck", noogaisNippleRape);
	}
	//if (canBikiniTits) addButton(4, "B.Titfuck", (pc.armor as LustyMaidensArmor).lustyMaidenPaizuri);
	//if (maleRape == rapeImpWithDick && pc.hasItem(useables.CONDOM)) addButton(5, "Use Condom", rapeImpWithDick, 1);
	//addButton(6, "Kill Him", killImp);
	//if (pc.canOvipositBee()) addButton(8, "Oviposit", putBeeEggsInAnImpYouMonster);
	
	addButton(14, "Leave", function():*{ processTime(15 + rand(10)); CombatManager.genericVictory(); } );
}

private function rapeImpWithDick():void {
	var x:Number = pc.cockThatFits(enemy.analCapacity());
	if (x < 0) x = 0;
	clearOutput();
	
	output("With a demonic smile you grab the insensible imp and lift him from the ground by his neck.  The reduced airflow doesn't seem to slow his feverish masturbation at all, and only serves to make his [enemy.cockNounComplex] harder.");

	if(!pc.isTaur()) {
		output("  You casually unclasp your [pc.lowerGarments] and reveal your [pc.cocks], ");
		if(pc.hasBreasts()) output("smashing him against your [pc.breasts] while you jerk hard on your [pc.cock " + x + "], bringing it to a full, throbbing erection.");
		else output("stroking it to full hardness languidly.");
	}
	output("\n\nWith no foreplay, you press your [pc.cock " + x + "] against his tight little pucker and ram it in to the hilt.  The imp's eyes bulge in surprise even as a thick stream of pre leaks from his [enemy.cock].  You grab him by his distended waist and brutally rape the little demon, whose claws stay busy adding to his pleasure.");
	pc.cockChange();
	if(pc.hasCockFlag(GLOBAL.FLAG_NUBBY, x)) output("  The tiny creature's claws dig into your sides at the feeling of soft, hooked barbs stroking his sensitive insides.");
	if(pc.cocks[x].cLength() >= 7 && pc.cocks[x].cLength() <= 12) output("  Each thrust obviously distorts the imp's abdomen.  It amazes you that it doesn't seem to be hurting him.");
	if(pc.cocks[x].cLength() > 12) output("  Each plunge into the imp's tight asshole seems to distort its entire body, bulging obscenely from its belly and chest.  Amazingly he doesn't seem to mind, his efforts focused solely on his sorely throbbing [enemy.cockNoun].");
	if (pc.balls == 0) {
		output("\n\nThe tight confines of the imp's ass prove too much for you, and you feel your orgasm build. The cum seems to boil out from inside you");
		if (pc.hasVagina())
			output(" as your [pc.vagina] soaks itself.");
		else
			output(", flowing up your [pc.cock " + x + "].");
	}
	else
		output("The [pc.cumNoun] seems to boil in your balls, sending heat spreading through your [pc.cock " + x + "] as your muscles clench reflexively, propelling hot spurts of jism deep into the imp's rectum.");
	if(pc.cocks.length > 1)
		output("  Your other equipment pulses and dripples steady streams of its own [pc.cumNoun].");
	output("  With delicious slowness you fire rope after rope of [pc.cum] deep into the imp's rectum.");
	if(pc.cumQ() >= 14 && pc.cumQ() <= 30) output("  Your orgasm drags on and on, until your [pc.cumVisc] jism is dripping out around your [pc.cock " + x + "].");
	if(pc.cumQ() > 30 && pc.cumQ() <= 100) output("  Your orgasm seems to last forever, jizz dripping out of the imp's [enemy.asshole] around your [pc.cock " + x + "] as you plunder him relentlessly.");
	if(pc.cumQ() > 100) output("  Your orgasm only seems to grow more and more intense as it goes on, each spurt more powerful and copious than the last.  The imp begins to look slightly pregnant as you fill him, and tiny jets of [pc.cum] squirt out around your [pc.cock " + x + "] with each thrust.");
	output("\n\nSatisfied at last, you pull him off just as he reaches his own orgasm, splattering his hot demon-cum all over the ground.   You drop the imp hard and he passes out, dripping mixed fluids that seem to be absorbed by the dry earth as fast as they leak out.\n\n");

	enemy.loadInAss(pc);
	pc.cor(1);
	processTime(25 + rand(10));
	pc.orgasm();
	CombatManager.genericVictory();
}

private function rapeImpWithPussy():void {
	clearOutput();
	output("You shed your [pc.lowerGarments] without a thought and approach the masturbating imp, looming over him menacingly.  Your [pc.vagina " + pc.biggestVaginaIndex() + "] moistens in anticipation as you gaze down upon his [enemy.cockNounComplex]. With no hesitation, you lower yourself until your lips are spread wide by his [enemy.cockHead], the hot pre-cum tingling deliciously.");
	//Too small!
	if(pc.biggestVaginalCapacity() < enemy.cockVolume(0)) {
		output("  You frown as you push against him, but his [enemy.cock] is too large for your [pc.vagina " + pc.biggestVaginaIndex() + "].  With a sigh, you shift position and begin grinding your [pc.vagina " + pc.biggestVaginaIndex() + "] against his [enemy.cock], coating it with fluids of your gender.  Your clit tingles wonderfully as it bumps against every vein on his thick appendage.");
		if(pc.breastRows.length > 0 && pc.breastRows[0].breastRating() > 1) {
			output("  You happily tug and pinch on your erect nipples, adding to your pleasure and nearly driving yourself to orgasm.");
		}
		output("\n\nYou lose track of time as you languidly pump against the imp's [enemy.cock].  At long last you feel your [pc.vagina] ripple and quiver.  Your [pc.legs] give out as you lose your muscle control and collapse against the small demon.  You gasp as his [enemy.cock] erupts against you, splattering your chest with hot demonic cum that rapidly soaks into your [pc.skinFurScales].  You giggle as you rise up from the exhausted imp, feeling totally satisfied.\n\n");
	}
	//Big enough!
	else {
		output("  You sink down his [enemy.cock] slowly, delighting in the gradual penetration and the tingling feeling of his dripping hot pre-cum.  At last you bottom out on his balls.");
		pc.cuntChange(pc.biggestVaginaIndex(), enemy.cockVolume(0));
		output("  Your lust and desire spurs you into movement, driving you to bounce yourself up and down on the [enemy.cock].  His exquisite member pushes you to the very height of pleasure, your [pc.vagina " + pc.biggestVaginaIndex() + "] clenching tightly of its own accord each time you bottom out.  The tensing of the little demon's hips is the only warning you get before he cums inside you, hot demonic jizz pouring into your womb.  Your [pc.legs] give out, pushing him deeper as he finishes filling you.");
		output("\n\nThe two of you lay there a moment while you recover, at last separating as you rise up off his [enemy.cock].  Spunk drips down your [pc.legs], quickly wicking into your [pc.skinFurScales] and disappearing.\n\n");
		//Taking it internal is more corruptive!
		pc.cor(1);
		pc.loadInCunt(enemy);
	}
	pc.cor(1);
	processTime(25 + rand(10));
	pc.orgasm();
	CombatManager.genericVictory();
}

private function sprocketImp():void {
	clearOutput();
	var x:int = pc.thickestCock();
	output("You fall to your knees, lost in thoughts of what you want the imp to do to you.  Your body burns with desire, ready for the anal assault to come.  At least that's what you think.  You reach a hand out to the imp, wanting to pull him to you, to make him take you the way you need to be taken.  But he doesn't, not this time.\n\n");

	output("Much to your surprise, the imp flutters upward on his small leathery wings and rushes toward you.  ");
	if(pc.hairLength > 0) output("His claws dig into your hair ");
	else output("His claws dig into your wrists ");
	output("and you find yourself dragged upward with him, soaring over the tops of the trees.  The cool rush of air does nothing to abate your arousal.  If anything, the cold shock only makes your body more aware of its own need.  After just a few seconds that feel like an eternity to your lust-filled being, the imp hurls you down into a tree.  You flail as you fall, barely catching yourself on the upper branches.  Your hands and [pc.legs] are tangled in the smooth wooden spiderweb below you, your mind torn between desire for the imp above and fear of the fall below.  You can see from the gleam in the horned creature's red eyes that he has you right where he wants you.\n\n");

	output("The imp pulls the loincloth from his waist, revealing his [enemy.cock].  It is certainly large, even though it stands smaller than your own erection.  He tosses the cloth aside, and you see him fluttering down toward you just before the rough fabric lands on your [pc.face].  His clawed fingers grasp your [pc.cock " + x +"], rubbing the tip of his prick against your [pc.cockHead " + x +"], smearing your pre-cum together.  You wonder if he is planning on just jerking both of you off as you shake the cloth from your [pc.face].  He flashes you an evil smile, making your eyes widen in terror as you realize what he is planning. Before you can even think to make a move to stop him, the imp ");
	
	//Variable cocktext
	if(pc.hasCockFlag(GLOBAL.FLAG_TAPERED, 0)) output("finds the hole in the pointed head of your cock and plunges his shaft deeply into it, literally fucking your urethra.  ");
	else if(pc.hasCockFlag(GLOBAL.FLAG_FLARED, 0)) output("seats his dick in the flared head of your prick, and then pushes farther. His shaft plunges into yours, filling your cock more than any cum load ever could.  ");
	else if (pc.hasCockFlag(GLOBAL.FLAG_PREHENSILE, 0)) output("shoves his dick deeply into the slit in the head of your cock.  ");
	else output("shoves his shaft deeply into the slit in the head of your dick.  ");
	
	output("\n\nHe grips your cock tightly as he fucks you, treating you like a ");
	
	//Differing cocksleeve texts
	if(pc.hasFur()) output("furry cock-sleeve");
	else if(pc.race().indexOf("demon") != -1) output("demonic cock-sleeve");
	else output("[pc.race] cock-sleeve");

	//Bonus boob shake or period if no boobs.
	if(pc.biggestTitSize() > 2) output(", fucking you so hard that your [pc.breasts] bounce with each thrust.  ");
	else output(".  ");
	output("It briefly crosses your mind that this should be painful, but something about either his lubrication or yours makes it comfortable enough to have you writhing in pleasure.  ");
	output("He thrusts roughly into you for several minutes, your hips bucking upward to meet him, ");
	if(pc.cocks.length == 2) output("your other cock finding pleasure in rubbing against his body ");
	if(pc.cocks.length > 2) output("your other cocks finding pleasure in rubbing against his body ");
	//Cum
	output("while copious amounts of sweat runs off of both your exposed forms, before he shivers and sinks deeply into you.  He cums hard, the heat of his demon seed burning your loins. His orgasm lasts longer than you think possible, forcing your own climax. Your seed mixes within your body, becoming more than you can handle and spilling out from your urethra around his intruding member.  ");
	//Extra cum-texts
	if(pc.cocks.length == 2) output("Your other cock cums at the same time, liberally splattering your spunk up his back.  ");
	if(pc.cocks.length > 2) output("The rest of your [pc.multiCocks] twitch and release their seed at the same time, creating a shower of spunk that rains down on both you and the imp, coating both of your bodies.  ");
	if(pc.isLactating() >= 1) output("At the same time, milk bursts from your [pc.nipples], splattering him in the face.  You feel a sick sort of triumph as you get him back for cumming inside you.  ");
	//Vagoooz
	if(pc.hasVagina()) output("Your [pc.vaginas] quivers, contracting furiously as your orgasm hits you - like it's trying to milk a phantom dick dry.  ");

	output("Satisfied, his [enemy.cock] slides from you and he flies away as mixed seed continues to spill from your abused body. Your limbs grow weak, and you fall from the tree with a hard thud before losing consciousness.\n\n");
	//Take some damage
	pc.HP(-10);
	processTime(25 + rand(10));
	pc.orgasm();
	CombatManager.genericLoss();
}

private function centaurGirlOnImps():void {
	clearOutput();
	output("You stand over the thoroughly defeated demon and get an amusing idea. The tiny creatures are far from a threat, but their features seem like they might be useful. You pick the imp up and place him in a tree with explicit orders to him to stay, much to his confusion. Once you're sure he won't move, you wolf whistle and wait.\n\n");
	output("A goblin appears from the underbrush behind you, but a swift kick sends her flying; she's not what you're after. You're soon rewarded with a trio of imps, who fly up to you, cocks at the ready.  Grabbing the defeated imp by the head, you explain your need to the group and waft a bit of your scent over to them with your tail. They confer among themselves only briefly, clear on the decision, as you toss their weaker fellow underneath them. The larger of the three, evidently the leader, smiles lewdly at you and agrees to your 'demands'.\n\n");
	//[Female:
	if(pc.hasVagina()) {
		output("The imps approach you, their various genitalia glistening in the sun and drawing your attention. Their cocks swing lewdly with every flap of their wings, but you turn around, wanting their ministrations to be a surprise.\n\n", false);
	
		output("Hands slide over you, stroking and patting your equine form. The roving fingers find their way to your rear quickly, and begin teasing around your [pc.vagina] and [pc.asshole]. They probe around but don't penetrate and you stamp your [pc.foot] in frustration. There's a chuckle from behind you and all but a handful of the hands disappear.\n\n");

		output("A slightly larger hand smacks your [pc.ass] then slides up and pops a thick finger inside. Your [pc.asshole] tries to suck it in deeper, but loses the opportunity as it's extracted before doing anything. Instead, the hand returns to your flank and slides slowly forward to your torso.\n\n");

		output("The 'head' imp comes around into your vision, hovering in front of you and letting you get a good look at his long member. He pulls on it, extracting a large bead of pre onto his other hand. Opening your mouth, he wipes the salty substance onto your tongue. You swallow it happily and feel your mouth watering and your [pc.vagina] pumping out fluid.\n\n");

		output("The leader looks past you and gives a signal to someone you can't see, but you don't have time to turn as a huge dog cock is slipped into your slavering cunt and an even larger spined prick is inserted into your [pc.asshole]. They begin pumping into you hard, and you whinny in satisfaction while the demon before you watches, jerking on himself.");
		pc.cuntChange(0, enemy.cockVolume(0));
		pc.buttChange(enemy.cockVolume(0));
		output("\n\n");

		output("He disappears behind you and gives you a slap on the haunches, yelling, \"<i>Giddyup!</i>\" and laughing heartily. Whether he expected you to or not, you decide to go for it and push off the ground with your forelegs, kicking them about in the air and feeling the demons aboard you scrabble to stay attached, before setting off at as fast a run as you can. You tear about in the dirt, clumps of mud and weeds flung behind you.\n\n");

		output("At the edge of the clearing is the leader, laughing as he watches you and still jerking himself. As if realizing that there's a better option available, he grabs the defeated imp and inserts himself into him, using him like a living cock sleeve who appears to not mind the position and cries out repeatedly as his ass is abused.\n\n");

		output("Your unexpected running momentarily paused the cocks inside you as their owners groped for holds on your [pc.hips] and [pc.ass]. With their positions relatively well established, they begin pounding at you again, causing you to nearly stumble in pleasure.\n\n");

		output("Managing to steady yourself, you run faster, feeling the frenetic cocks inside you explode. The hot spunk sprays about inside and you scream in ecstasy.");
		//[Has breasts: 
		if(pc.biggestTitSize() > 1) output("  Your hands reflexively grab your [pc.chest] and mash them about.");
		output("\n\n");

		output("The owner of the dog-cock in your [pc.vagina] manages to insert his knot as his balls empty inside you, but the cat-cock's body has no such luck and his grip on you falters. He slides out of your [pc.asshole] but manages to grasp the [pc.skinNoun] of your back and straddle you, all while his cock continues to spray you down with jism.\n\n");

		//[Has breasts: 
		if(pc.biggestTitSize() > 1) {
			output("He slides up to your torso and grasps your wildly flailing [pc.fullChest], massaging them harshly. His ministrations are surprisingly crude, and you wonder how many times he's attempted to pleasure a woman.");
			//[Has fuckable nipples: 
			if(pc.hasFuckableNipples()) output("  His fingers slide inside your [pc.nipplesNoun] and start spreading and squishing them. Your femcum leaks out over his hands and soon your front is slick and shiny.");
			//All other nipples: 
			else output("  His fingers grope and grab at your nipples, stretching them uncomfortably. Before you can complain he seems to realize his mistake and releases them.");
			//[Is lactating normally: 
			if(pc.isLactating() && pc.lactationQ() < 50) output("  Milk dribbles and squirts from you as his desperate squishing continues, forming small puddles on the ground.");
			else if(pc.isLactating()) output("  Milk sprays from you as his desperate squishing continues, creating massive puddles of milk that you splash through as you continue moving.");
			output("\n\n");
		}
		
		output("You stop running, spraying dirt in a massive fan and sending the imp on your back flying into a tree, where he crumples to the ground unceremoniously. The doggy-dicked imp collapses out of you and is sprayed down with your orgasm, coating him in femcum and his own semen.\n\n");

		output("You trot over to the leader, still using the nearly unconscious imp as a cock sleeve, and pull the abused creature off of him. He looks shocked as you grab his cock and squeeze his balls, causing him to orgasm hard and spray you down in white hot seed. He collapses onto the ground, spent, as you wipe yourself down as best you can.");

		output("  Collecting your things, you give the assorted bodies one last look and stumble back to camp.\n\n");
		
		pc.cor(1);
	}
	processTime(25 + rand(10));
	pc.orgasm();
	CombatManager.genericVictory();
}

private function centaurOnImpStart():void {
	clearOutput();
	//Event: Centaur-Imp: pc Raping
	output("As the imp collapses in front of you, ");
	if(enemy.HP() <= 1) output("panting in exhaustion");
	else output("masturbating furiously");
	output(", you advance toward the poor creature.  The demon's eyes run over your powerful equine-like muscles as you tower above it.  It is difficult to hide your smile as you look at the tiny creature's engorged cock and the perpetual lust filling its beady eyes.");
	//OPTIONAL THOUGHTS
	//[if previously gave birth to imps and Cor >50] A part of you wonders idly if this is one the offspring that you added to this world 
	//[corruption is under 80] but the you quickly banish the thought. [corruption is over 80]  and the thought fills you with excitement. ))  
	//<< Cor <50 >> 
	if(pc.cor() < 50) output("  You lick your lips slightly as you begin to approach the small figure.");
	else output("You lick your lips obscenely as you approach the small figure.\n\n");
	//[Even chance of any of the following happening if the pc has the correct equipment, distribute chances between what equipment is available]
	var x:Number = pc.cockThatFits(enemy.analCapacity());
	if(x >= 0 && !pc.hasVagina()) centaurOnImpMale();
	else if(pc.hasVagina() && x < 0) centaurOnImpFemale();
	else {
		output("Do you focus on your maleness or girl-parts?");
		clearMenu();
		addButton(0, "Male", centaurOnImpMale);
		addButton(1, "Female", centaurOnImpFemale);
	}
}

//pc has a cock}}
private function centaurOnImpMale(vape:Boolean = false):void {
	var x:Number = pc.cockThatFits(enemy.analCapacity());
	if(x < 0) x = 0;
	clearOutput();
	
	//Tentacledicks!
	//{{pc has 1+ very long (smallest 2+ feet) tentacle cocks}}
	//if(pc.cockTotal() > 1 && pc.cocks[pc.biggestCockIndex()].cLength() >= 24) {
		//output("As your shadow falls over it, it looks with a hint of fear between your legs, and then its eyes widen in a mixture of apprehension and lust.  Before you can even more the little creatures scrambles forward between your [pc.legs] and wraps its hands around your " + cockDescript(pc.biggestCockIndex()) + ".  Its tongue begins to trail all along the length of it as its small hands stroke it intensely.\n\n", false);
		////<< Cor <50>>
		//if(pc.cor < 50) {
			//output("You slowly undulate your " + cockDescript(pc.biggestCockIndex()) + " against the creature's mouth, delighting in its eager tongue.  ", false);
			////<<GoTo I3 then return>> 
			//centaurOnImpResults(3);
			//output("The sounds beneath you quickly take on a more intense note and you feel massive amounts of cum splashing liberally over your hooves, belly, and " + cockDescript(pc.biggestCockIndex()) + ".  The hot sensation sends you over the edge as you begin spilling yourself into the creature's eager mouth.\n\n", false);
			////<<GoTo I2>>
			//centaurOnImpResults(2);
			////<<End>>
			//pc.orgasm();
			//processTime(15);
			//CombatManager.genericVictory();
			//return;
		//}
		////<< 1 or 2 cocks, Cor 50+>>
		//else if(pc.cockTotal() == 2) {
			//output("With an evil smile you wait for your " + cockDescript(pc.smallestCockIndex()) + " to be at its lips before you slide it forward into its waiting mouth.  Giving it little more than a moment to catch its breath you slide your " + cockDescript(pc.smallestCockIndex()) + " further and down the creature's throat.  Though you cannot see the obscene bulge it is making in the creature's mouth-pussy you delight in the intense tightness beneath you.  The throat muscles are massaging your " + cockDescript(pc.smallestCockIndex()) + " as the imp desperately scrambles for air, pulling at the tentacles you have forced into it.  It cannot even begin to close its jaw as you thrust deeper and deeper, as you try to intensify the sensations.\n\n", false);
			//output("As the imp is focused on the tentacles cutting off its air, you position your " + cockDescript(pc.biggestCockIndex()) + " against its " + eAssholeDescript() + ".  Pausing only for a second for the pleasure of anticipation, you shove yourself deep inside the imp's " + eAssholeDescript() + ", only making it a few inches before having to pull back and try again.  The creature's throat seems to be working overtime now as it tries to divide its attention between the two invaders.  Each thrust of your " + cockDescript(pc.smallestCockIndex()) + " makes it a little bit deeper inside of the creature, and you wonder passionately if you can get the two to meet in the middle.\n\n", false);
			//output("It is not long before you begin to feel the creature's struggles slowing down.  ", false);
			////<<Cor <80 >> 
			//if(pc.cor < 80) {
				//output("Feeling merciful you extract yourself from the creature, flipping it unto a nearby rock as it begins to regain consciousness.  Before it realizes what you are doing your " + cockDescript(pc.biggestCockIndex()) + " is prodding at its " + eAssholeDescript() + ", then sliding quickly between its cheeks.  The amount of slobber over you is more than enough lubricant.  You groan in pleasure as it gives a slight squeal, then proceed to finish yourself off in the once-tight orifice.\n\n", false);
				////<<Goto I1>> 
				//centaurOnImpResults(1);
				//pc.orgasm();
				//processTime(15);
				//CombatManager.genericVictory();
				//return;
			//}
			////<<Cor 80+>> 
			//else {
				//output("You groan in pleasure and slide your " + cockDescript(pc.biggestCockIndex()) + " even deeper down the creature's throat, until you can feel its head against your ", false);
				////<<if balls>>
				//if(pc.balls > 0) output(ballsDescriptLight() + ".\n\n", false);
				//else output("groin.\n\n", false);
				////<<GoTo I3 then return>> 
				//centaurOnImpResults(3);
				//output("A guttural moan escapes your mouth as you realize the creature has completely passed out underneath you.  ", false);
				//if(pc.hasFuckableNipples()) output("Shoving your fingers deep into your " + nippleDescript(0) + "s", false);
				//else output("With a fierce tug on your " + nippleDescript(0) + "s", false);
				//output("you begin to cum deep and directly into the imp's stomach and " + eAssholeDescript() + ".  ", false);
				////<<cum multiplier: lots>>
				//if(pc.cumQ() > 250) output("Beneath you the creature's belly is distending more and more, and you can feel some of the overflowing cum filling back out until it is pouring out of the creature's unconscious mouth and overstretched ass, forming a spermy pool beneath it.", false);
				//output("With on last grunt you begin extracting the tentacles back out, almost cumming again from the tightness around them.  You give your " + cockDescript(pc.smallestCockIndex()) + " one last shake over the creature's face before trotting away satisfied and already thinking about the next creature you might abuse.", false);
				//pc.orgasm();
				//processTime(15);
				//CombatManager.genericVictory();
				//return;
			//}
		//}
		////<< 3+ cocks, Cor 80+>>
		//else {
			//output("With an evil smile you wait for the creature's mouth to touch one of your tentacles before the other two snake their way down and wrap themselves around the imp's thighs.  With a tug the creatures is pulled off of it's feet and upside down, its eyes widening in a mixture of fear and debased lust as it sees your " + cockDescript(pc.biggestCockIndex()) + " undulating in front of it.  You slowly move the tentacle up as your other cocks forcefully tug its legs apart, and then playfully begin sliding yourself over the imp's small cheeks.\n\n", false);
			////<<Cor 80+, has given birth to an imp>>Part of you wonders idly if this is one of the creatures that you spawned, and that left its spermy surprise on you after it came out of the womb<</Cor>>  
			//output("Licking your lips in anticipation you begin pushing your " + cockDescript(pc.biggestCockIndex()) + " into the imp's " + eAssholeDescript() + " while listening to the mewling sounds coming from beneath you.  You take your time as you push in, seeing no need to rush yourself as you feel the creature gaping more and more.  Once you bottom out you reach down and grab the creature's arms, securing it firmly against your belly as you break into a trot.  The sensation of the imp's " + eAssholeDescript() + " bouncing around your " + cockDescript(pc.biggestCockIndex()) + " is intense and you ride harder until you know you are close to the bring.  Quickly you slow down and drape the creature over a nearby boulder, using your hands and tentacles to pin it to the harsh surface, and then your mighty legs push you forward even deeper into the creature's bowels.  The shriek should be audible pretty far in this area, and you groan in debased pleasure thinking it might draw someone else for you to rape or be raped by.  Grunting slightly you begin pushing into the imp even harder just to generate more loud sex-noise.  ", false);
			////<<Breasts>>
			//if(pc.biggestTitSize() >= 0) {
				//output("One of your hands releases it and begins playing with your " + pc.allBreastsDescript(), false);
				////<<nips have pussies>> 
				//if(pc.hasFuckableNipples()) output(" and fingering your " + nippleDescript(0) + "s", false);
				//output(" as you drool slightly in absolute pleasure.  ", false);
			//}
			//output("When the creature's noises lessen and all you can hear is the sloppy sounds of its ass being fucked you push yourself in a single mighty heave, grinding the creature into the rock and eliciting one last scream that pushes you over.\n\n", false);
			////<<GoTo I1>>
			//centaurOnImpResults(1);
			////<<End>>
			//pc.orgasm();
			//processTime(15);
			//CombatManager.genericVictory();
			//return;
		//}
	//}
	// no tentackles
	output("As your shadow falls over the imp, it looks between your [pc.legs] with a hint of fear.  ");
	if(pc.cockVolume(x) <= cockVolume(30)) {
		output("Relief washes over it followed by intense lust as is throws itself onto a mossy rock and eagerly presents its [enemy.asshole].   The sound of your [pc.feet] moving on either side of its body seems to send the creature into a frenzy as it begins humping the air while small mewling sounds escape its lips.  ");
		//<<Cor <50>> 
		if(pc.cor() < 50) output("You slowly rub your [pc.cock " + x + "] between the creature's cheeks, letting your pre-cum oil the small hole, before slowly beginning the insertion.  Before you can get half-way the creatures drives its self back against you, impaling its [enemy.asshole] around your [pc.cock " + x + "] and making inhuman sounds of ecstasy. The [enemy.asshole] relaxes around your [pc.cock " + x + "], taking it all in while its practiced muscles grip and jerk you off internally.");
		//<<Cor 50+>> 
		else output("You position your [pc.cock " + x + "] against its dry anus and drive yourself inside of it using your powerful [pc.legs].  The creatures gives a loud shriek as its insides are forced open, and you feel the raw tightness trying to resist your intrusion.  Giving the creature no chance to relax you begin pistoning into it, grinning as the sounds of pain give way to grunts and yelps of pleasure. You cannot last long in the creature's hole, and soon spurts of cum begin shooting out and filling its bowels.");
		pc.cockChange();
		output("\n\n");
		//<<GoTo I1>>
		centaurOnImpResults(1);
		//<<End>>
		processTime(25 + rand(10));
		pc.orgasm();
		CombatManager.genericVictory();
		return;
	}
	else {
		x = pc.smallestCockIndex();
		//<<Cock: large, Cor <50>>
		if(pc.cor() < 50) {
			output("The imp's eyes widen and you see its apprehension as it attempts to turn and flee.  You make soothing sounds as you approach the skittish creature, while easily keeping pace with it.  Seeing little chance for escape, the creature turns toward you again and carefully begins making its way between your [pc.legs], eyes wide in supplication.  Your smile seems to relax it, and lust fills its eyes again as it slowly starts massaging your [pc.cock " + x + "].  Getting more and more confident, the creature is soon using both of its hands on your [pc.cock " + x + "], and its wet and serpentine tongue is moving all over the length of your erection.  There is little chance of your [pc.cock " + x + "] fitting into its small mouth, but it does its best to pleasure you as it goes more and more wild.  ");
			//<<Thick large>>
			if(pc.cocks[x].thickness() > 3) {
				output("It is not long before you feel its tongue slipping into your urethra, and cum rushes from your [pc.balls] as you feel the foreign invader wiggling inside.  ");
				//<</Thick>>  
			}
			output("You cannot take the attention for long before your [pc.legs] are scraping at the ground and jets of [pc.cum] shoot out of your [pc.cock " + x + "] and down its waiting throat.\n\n");
			//<<GoTo I2>>
			centaurOnImpResults(2);
			//<<End>>
			processTime(25 + rand(10));
			pc.orgasm();
			CombatManager.genericVictory();
			return;
		}
		//<<Cock: large, Cor 50+>>
		else {
			output("The imp's eyes widen and you see apprehension as it tries to turn around and get away.  It does not make it far before you run it down, knocking it over with your muscled flank.  Before it can try to run again you pin it down and position your [pc.cock " + x + "] against its [enemy.asshole].  It feels far too small to handle your girth but a push of your powerful legs gets you in with the first inches.  The imp squeals out in pain and you wince slightly in the vice-like grip.  Gritting your teeth you push in the remaining length, the sounds of pain only serving to drive you forward all the harder.");
			pc.cockChange();
			output("  Soon your [pc.cock " + x + "] is moving in and out with more ease, though the imp's tender asshole is distending abnormally to accommodate the invading member.  As much as you long to extend your pleasure, the sensation and the unnatural sounds of the penetration prove too much for you to last long.\n\n");
			//<<GoTo I1>>
			centaurOnImpResults(1);
			//<<End>>
			processTime(25 + rand(10));
			pc.orgasm();
			CombatManager.genericVictory();
			return;
		}
	}
	pc.orgasm();
	processTime(15);
	CombatManager.genericVictory();
}
//CUNTS
private function centaurOnImpFemale(vape:Boolean = false):void {
	clearOutput();
	//PREGGERS CHANCE HERE - unfinished
	//{{pc has a cunt}}
	output("As the imp lays beaten its hands stroke its [enemy.cock] as its eyes look over you in the hope that you might abuse it in some manner.  You lick your lips as you stare at the large member and you turn around to display your [pc.vagina].  ");
	//Not gaping?
	if(pc.looseness() <= 3 || pc.vaginalCapacity() < 150) {
		//Penetration for non-gape cases
		output("With a lascivious grin the imp hops forward, gripping your flanks as it drives its member forward into your [pc.vagina].  ");
		//<<If Pussy Virgin>> 
		if(pc.vaginas[0].hymen) {
			output("You cry out as your virginal pussy is torn open by the massive member and the creature cries out in pleasure as it realizes what it has taken from you.  ");
			//[Lose Virginity] <</Virgin>>
		}
		//Not virgin fucking flavors
		else {
			if(pc.looseness() <= 1) output("It groans in delight at your incredible tightness and shoves itself forward even harder.  ");
			//[Increase size as needed] 
			//<<At Dicksize>>
			else if(pc.looseness() == 2) output("It makes a pleased sound as it slides deeply into your [pc.vagina].  ");
			//<<Bigger than dicksize>> 
			else output("Its dick slides easily and slopping noises start sounding from your backside.  Part of you wishes that its large member was larger still, as your mind drifts to some of the monstrous cocks that have penetrated you in the past.  ");
		}
		pc.cuntChange(0, enemy.cockVolume(0));
		//Ride around with him till he cums and falls off
		output("When the creature completely bottoms out inside of you, you begin trotting forward with a wicked grin.  The creature's hands grasp your flanks desperately, and its [enemy.cock] bounces inside your [pc.vagina], adding to your sensation.  The movement is causing the imp to push himself even harder against you as it tries to not fall off, and it is all you can do to keep an eye on where you are going.  Soon you can feel the imp's sperm filling your [pc.vagina] and overflowing even as your cunt-muscles try to milk it of all of its seed. Unsatisfied you begin to speed up as you use its [enemy.cock] to bring about your own orgasm.  The small creature is unable to let go without hurting itself.  It hangs on desperately while you increase the pace and begin making short jumps to force it deeper into you.  The feeling of sperm dripping out and over your [pc.clit] pushes you over and cry out in intense pleasure.  When you finally slow down and clear your head the imp is nowhere to be seen.  Trotting back along the trail of sperm you left behind you find only its small satchel.\n\n");
		//END OF NON GAPE CASE
	}
	//<<Gaping>>
	else {
		output("With a lascivious grin the imp hops forward, gripping your flanks as it drives its member forward into your [pc.vagina].  While you might have considered him large before you came to this place, the sensation is now merely pleasant, and you can't help but groan in slight disappointment.  ");
		//<<Cor 50+>>
		if(pc.cor() >= 50) output("You take comfort in knowing that at least there is a cock inside of you, and that soon it will be filling you with its seed.  Perhaps it might even impregnate you!  ");
		output("The imp seems to have shared your initial annoyance, and suddenly you feel strange and harsh objects prodding your [pc.vagina] near where you are being penetrated.  Suddenly you feel yourself being forced open even wider, and you feel almost as if you are getting kicked inside of your pussy.  A second object touches near where the first had entered and you quickly brace yourself against a nearby tree.  The second jolt is even harder, feeling as if your cervix is getting stomped.  You howl out in pain as your [pc.vagina] is virtually torn open, the imp using your tail to leverage not only his [enemy.cock] but also his [enemy.legs] inside your [pc.vagina].  ");

		if (pc.cor() > 80 || pc.vaginalCapacity() >= 500) output("and you hang on to the tree, grunting like a rutting animal as you delight in the intense pain.  ");
		if (pc.cor() > 50 || pc.vaginalCapacity() >= 300) output("and you hang on to the tree, afraid of the pain from even the slightest movement.  ");
		else output("Tears pour out of your eyes and you are sure you must be bleeding slightly, ");
		
		//<<Cor 80+>>
		if(pc.cor() >= 80) output("You howl out in pain and pleasure, bucking and hoping to intensify the sensation, hurling enticements and insults at the imp like a slut.  ");
		//<<Cor 50+, Breasts>>
		if(pc.cor() >= 50 && pc.biggestTitSize() >= 2) {
			output("You release the tree as you begin playing with your [pc.chest]");
			//<<w/ nip-pussies>>
			if(pc.hasFuckableNipples()) output(" and shoving your fingers into your [pc.nipples].  ");
			else output(".  ");
			//<</Breasts>>
		}
		output("The imp is pushing deeper and deeper and in moments you cry out again as you feel first its [enemy.feet] and then its [enemy.cock] tearing open your cervix and bottoming out in your womb.  ");
		pc.cuntChange(0, 500, true);
		
		//<<Asshole large+>>
		if(pc.analCapacity() >= 35) {
			output("When the imp realizes it cannot go any further you feel its hands against your [pc.asshole], and your eyes go wide in realization of what it is planning on doing.  Lubed up by your now drooling juices, the fist pushes hard into your [pc.asshole], shoving past your ring-muscles.  ");
			//<<Assole <gaping, Cor <80>>
			if(pc.analCapacity() < 100 && pc.cor() < 80) output("Your howl of pain leaves your throat raw.  ");
			else output("Your howl of perverse pleasure leaves your throat raw.  ");
			pc.buttChange(100, true);
		}
		output("\n\nIt is a relief when you feel the creature's sperm filling your womb and lubricating your raw cervix, your own body is wrecked by an intense orgasm while it breeds you.  You pass out, waking up to find that the imp has slipped out of you and is lying unconscious and coated completely in a mixture of your juices and his own. After looking for anything you might be able to take away from him you limp away, you ");
		if(pc.cor() < 80) output("promise to yourself that you will not do that again.\n\n");
		else output("find your cunt juices already dripping down your [pc.legs] in anticipation of doing this again.\n\n");
	}
	pc.loadInCunt(enemy);
	processTime(35 + rand(10));
	pc.orgasm();
	CombatManager.genericVictory();
}

/*
{{Any pc: Oral Give}}
<<Cor <30>>You look furtively at the imp's [imp cock desc] as the creature masturbates shamelessly on the ground in front of you.  Unable to help yourself, you trot closer and closer, leaning in to get a better look at its giant member.  A lustful part of you wonders what the dripping pre-cum would taste like against your tongue.<<else if Cor <50>>You look lustfully at the imp's [imp cock desc] as the creature masturbates shamelessly on the ground in front of you.  Licking your lips in anticipation you walk closer, lowering your head to better inspect it.  <<else>>Your grin betrays your lust as you watch the imp masturbate its [imp cock desc] shamelessly on the ground.  Your hands already drift over your body as you trot over and grab a hold of its [imp cock desc], bringing it to your eager lips.<</Cor>>  The Imp's eyes shoot open as its hands grab a hold of your [hair desc - if no hair, then ears] and it pulls its member against your lips.  With your guard down, images of fellating the [imp cock desc] fill your mind with overwhelming intensity.  The visions cause your jaw to fly open without any trace of your own volition, and suddenly the [imp cock desc] is forcing its way to the back of your throat.  <<Cor <40>>Your gag reflexes are trying desperately to kick in, serving only to massage the [imp cock desc] as the creature makes guttural noises and pushes its self even deeper. <<else if Cor <70>> Though it takes you a moment to get adjusted to the intrusion, soon you are able to relax your throat like an expert cock-swallower, taking it even deeper. <<else>>You moan around the creature's [imp cock desc], opening your throat as your eyes plead with it to fuck your mouth-hole even deeper.<</Cor>>

The creature's pre-cum tastes more like brimstone than salt, and yet something about it inflames you as it pools in your mouth and pours down your throat.  <<Cor <30>>It is disgusting to let this substance inside your body, but the images keep you from resisting. <<else Cor <60>>The corrupt fluids seem unusual, but something about the lewd act makes them more than worthwhile and you take some delight in knowing they are filling your body. <<else>><<If Pussy>>Your [pussies desc] start drooling juices, <</Pussy>><<If cock and pussy>>and your<<else If Cock>>Your cock grows rock hard<</If>>as you feel the corrupt fluids flowing throughout your body.<</Cor>> Without even having to think about it you reach out and <<Str <80>>stroke its [imp cock desc], trying to milk more of it into you <<else>>pick up the imp with one hand, your other hand stroking its [imp cock desc] and trying to milk more of it into you<</Str>><<Cor 80+, Str <80>> as you shove a finger into its [imp anus desc]<<else Cor 80+, Str 80+>> then shoving a finger into its [imp anus desc] and using the new form of grip to move the creature into and out of your mouth-hole<</Cor>>.<<Goto I3 then return>>  In only a few minutes the creature begins to lose its ability to resist your <<Cor <30>>tight<<else Cor <60>> skilled <<else>> eager <</Cor>> throat and begins to pour massive amounts of corrupt cum into your stomach. <<Cor 60-79>>As much as you love having your stomach filled with sperm, you quickly pull the imp back so that some of it might land on your tongue for you to savor.  The excessive cum is soon dripping down your lips, no matter how fast you try to swallow.<<else Cor 80+>>As much as you love having your stomach filled with sperm, a perverse thought fills you and you pull the creature out, <<Str 80+>>holding the creature over your head as <</Str>>you guide its [imp cock desc] to liberally coat your face <<Breasts>>and [breasts desc]<</Breasts>>.<</Cor>>You lick your lips clean of the creamy mess as you put down the now unconscious Imp and give it a look-over for valuables.  <<Cor 80+>>As you trot back the way you have come you idly trace a finger through the dangling sperm, hoping someone might see what a [slur] you have become becomes too uncomfortable to wear.  Though if you have to clean it off, you can always get more.. perhaps from an even more copious source.<<end>>

{{Any pc: Anal Receive}}
As you watch the imp stroking its [imp cock desc] you find it difficult to resist the urge to feel that massive member sliding into your body.  Slowly you trot closer, turning around to display your rear to the creature.  <<Pussy, Cor <30>>Your [largest pussy desc] is already drooling in anticipation of the cum it is about to receive, though to your surprise you feel the imp's [imp cock desc] bumping slightly above it.  You try to turn and stop it, but the creature pushes deep past your anal muscles before you have a chance.<<else>><<Pussy, Cor <50>>>>Your [largest pussy desc] is already drooling in anticipation of the cum it is about to receive, though to your surprise you feel the imp's [imp cock desc] bumping slightly above it. You brace yourself in anticipation and slight trepidation, delighting in the perversion you are about to take part in. <<else Pussy, Cor 50+>>Though your [largest pussy desc] is dripping at the chance at being bred, you feel like you would like somehing a lot more raw.  Breathlessly you beg it to fuck your [anus desc], debasing yourself and lowering yourself to the ground so you can be as accessile as possible. You moan like a [slur] in anticipation of feeling a cock shoved deep into your [anus desc] <<Breasts>>gripping your nipples hard<<else>>raking your body with your nails<</Breasts>>as you try to keep from biting through your lips.  <</Pussy,/Cor>><<no Pussy>><<Cock>>Your [cocks desc] harden in anticipation<<else>>You rake your nails over your sides in anticipation<</Cock>> as you feel the creature prepare to mount you, its [imp cock desc] pressing up against your [anus desc].  <</no pussy>>
<<Cor 30+, Cor <50>> As the imp slowly pushes into your [anus desc] you moan in animalistic pleasure.<<else>>When you begin to feel your [anus desc] being distended you cry out and beg it to shove it harder, faster, to take your asshole as roughly as it can!<</Cor>><<anus smaller than dick>>The sheer size of the [imp cock desc] tears your anus open, sending streams of pain into you as you cry out in agony.[if anus smaller than dick, increase size]<</anus>>
[if anal virgin, lose anal virginity]

The Imp grunts as it ruts your [anus desc], and you can feel it bumping deeply against your bowels.  After a few minutes the initial pain is gone and you find yourself making bestial sounds along-side the overly-endowed creature.  You long to feel its cum filling you to overflowing, and break into a slight trot that causes the small imp to bounce around inside of your tightening asshole.  The combination of movement, grip, and its own furious thrusting seems to push it over the edge and you can feel jets of sperm shooting deeply into you, sending you into your own anal orgasm.  Used to the limit, the imp slides out of you and drops to the ground, barely conscious. <<Cor 80+>>Grinning at the perversity, you lower yourself down and take its dirty [imp cock desc] into your mouth, cleaning it thoroughly as you enjoy the mixture of your juices.  Your intense sucking and stroking causes a few last spurts of cum to fly out, and you pull the imp out lock enough to shoot the gouy mess over your face and hair while you swallow what was already in your mouth.<<end>>

{{pc has breast-pussies and is E+ sized breasts}}
As the imp falls to the ground, furiously masturbating its [imp cock desc] you smile in delight, your [nip-pussy desc] already beginning to grow wet <<lots of milk>>with the massive flow of milk pouring out of them<</milk>>.  You approach the little Imp at an eager trot, lowering yourself down and encasing its [imp cock desc] in your [breasts desc].  Its eyes fly open and stare in wicked delight at what it sees, quickly reaching out and beginning to fondle and finger your [nip-pussy desc].  Unable to resist any more, you press the opening of one of your [breasts desc] against the tip of the [imp cock desc].  If the creature is confused it does not show it, shoving its self hard quickly and hard into your tit.  [if virgin-nip, lose virginity]<<nip-size smaller than dick size>>Pain shoots through you as you feel the [nip-pussy desc] being forced to widen by the imp's massive tool, and you let out a slight scream [increase nip-pussy size]<</smaller>>  Without missing a beat the creature wraps its hands around your [breast desc] and begins thrusting liberally into it as if your tit was nothing more than a giant and perverted fuck-toy.  Seeing no point in arguing with the perception, you reach over and start shoving your own finger into your other [nip-pussy desc], crying out as you urge the imp to use your [breast desc].  Part of you longs to feel the imp's thick and corrupted cream filling your tit-hole, <<Cor <80>> and you begin moving your breast in circles around the thrusting member. <<else>>and you lower your breast against a rock, letting the imp squish your breast under its weight, grinding it into the rough stone as it continues to fuck it<</Cor>>.  The Imp seems to really enjoy this and after a few more minutes of intense pleasure it begins pouring its cum inside of your chest.  Without anywhere to go the cum pours back out, mixed with torrents of milk that are being stimulated out of you.  Exhausted the imp falls to the ground <<Cor <30>>leaving you frustrated. [no lust reduction] <<Cor <50>>before it can see you bringing your nipples to your mouth and sucking on the spermy mixture until you bring yourself to orgasm. <<Cor 80+>>before it can see you bringing your nipples to your mouth.  You suck hard to get to as much of its sperm as you can, shoving your tongue deep into yourself and digging around wih your fingers.  When this is not enough to bring you to orgasm you slap and bite your [nip-pussy desc], crying out as the intensity and perversion finally proves enough to push you over the edge.<</Cor>><<end>>
*/

private function centaurOnImpResults(iNum:Number):void {
	var x:Number = pc.cockThatFits(enemy.analCapacity());
	if(x < 0) x = 0;
	//{{ GoTo results }}
	//<<I1>>
	if(iNum == 1) {
		//<<cum multiplier: lots>>
		if(pc.cumQ() >= 250) {
			//<<no knot>>
			if(!pc.hasCockFlag(GLOBAL.FLAG_KNOTTED, x)) output("Soon the amount is overflowing from the abused [enemy.asshole], dripping between you with no sign of stopping as you continue thrusting yourself into the imp.  ");
			//<<knot>>
			else output("Soon the abused [enemy.asshole] is full to the brim, though your knot keeps any from escaping while more and more pumps in.  Soon the creature's belly is distending and the imp is gasping wordlessly. ");
			output("When your [pc.cock " + x + "] finally emerges a torrent of [pc.cum] follows out of the distended hole and covering the back of the creature's legs.  ");
			//<<I1_1>>
			//<<2 cocks>>
			if(pc.cockTotal() == 2) output("Your other cock drenches the imp's back with its own secretions that immediately start dripping down its sides.  ");
			//<<3+ cocks>>
			if(pc.cockTotal() > 2) output("Your other cocks release their [pc.cumNoun] all over the creature's back and sides, leaving it a glazed mess.  ");
			//<</I1_1>>
			output("You leave him panting and lapping at a pool of your semen.");
		}//<</multiplier>>
		//<<cum multiplier: little-normal>>
		else {
			output("With a last thrust into the cum receptacle you begin slowing down, even as its own [enemy.cock] spills its seed over the ground.  ");
			//<<I1_1>>
			//<<2 cocks>>
			if(pc.cockTotal() == 2) output("Your other cock drenches the imp's back with its own secretions that immediately start dripping down its sides.  ");
			//<<3+ cocks>>
			if(pc.cockTotal() > 2) output("Your other cocks release their [pc.cumNoun] all over the creature's back and sides, leaving it a glazed mess.  ");
			//<</I1_1>>
			output("You leave him panting and draped over the mossy boulder in a pool of your joint cum.");
		}
		output("\n\n");
		return;
	}
	if(iNum == 2) {
		//<<cum multiplier: lots>>
		if(pc.cumQ() >= 250) {
			output("The imp's eyes widen in at the amount pouring in, and gobs of [pc.cum] begin overflowing down its chin.  ");
			//<<(lots cont.)  cum multiplier: excessive>>
			if(pc.cumQ() >= 500) output("No matter how fast it is swallowing it does not seem to be enough, and soon its belly is distended and its skin is covered in a thick coating of [pc.cumNoun].  ");
			//<</multiplier>>  
		}
		output("Sated you trot away and leave the creature licking its lips and fingers, its eyes following you with lustful cunning.");
		//<</I2>>
		output("\n\n");
		return;
	}
	//<<I3>>
	if(iNum == 3) {
		//<<Has Breasts>>
		if(pc.biggestTitSize() >= 2) {
			output("As the sensations intensify you reach up and begin massaging your [pc.breasts] and playing with your [pc.nipples].  ");
			//<<(breasts cont.) nips have pussies>> 
			if(pc.hasFuckableNipples()) {
				//<<nip-pussies and milk>>
				if(pc.isLactating()) output("[pc.Milk] streams out from your [pc.nipples] as if they had been recently filled with dripping cum.  ");
				else output("Your fingers slide faster and faster into your [pc.nipples] even as the imp begins to stroke itself under you.  ");
			}
			//No pussies
			else {
				//<<else no pussies, has milk>>
				if(pc.isLactating()) {
					//<<little milk>>
					if(pc.lactationQ() <= 50) output("Beads of [pc.milk] begin to drip down your chest and occasionally spurt outward.  ");
					//<<else>>
					else output("[pc.Milk] pours out of your [pc.breasts] and streams down your body.  ");
				}//<</milk>>
			}
		}//<</Breasts>>
		output("\n\n");
		return;
	}
}

//private function areImpsLactoseIntolerant():void {
	//clearOutput();
	//output("You advance on the masturbating imp, baring your " + pc.allBreastsDescript() + " and swinging them from side to side. The little creature watches them, mesmerized as he masturbates his foot-long erection.\n\n", false);
//
	//output("You sit down in front of the little creature and grab ahold of his hair. The imp squeals slightly in pain before his cries are silenced with a " +В nippleDescript(0)В + ".  It fills his mouth as he yields, defeated. At once he starts to drink down as much of your milk as he can.\n\n", false);
	//
	//output("After a moment, he takes one of his hands off his large member and puts it against your " +В biggestBreastSizeDescript()В + " to steady himself as he continues to nurse. You give a pleased sigh and simply bask in the sensations of pleasure that being nursed gives you.  You ruffle the little imp's hair affectionately. \"<i>These creatures are so much nicer to be around when they just take their minds off their cocks,</i>\" you think as you see his other hand relax and stop rubbing his swollen, demonic member.\n\n", false);
//
	//output("You feel the imp's mighty gulps start to slow down until he lets out a sigh of relief. While imps may be small, they're very hungry creatures. Your " +В nippleDescript(0)В + " slips out of the imp's mouth, and you gently lay it down on the ground. It gives a few gentle burps before dozing off; you can see that the imp's erection has retracted, and its belly has expanded significantly. You smile to yourself and, feeling fully satisfied, you stand up.", false);
	////set lust to 0, increase sensitivity slightly
	//dynStats("lib", .2, "lus", -50);
	//pc.milked();
	//cleanupAfterCombat();
//}
//
//public function impGangGetsWhooped():void {
	//clearOutput();
	//output("With the imps defeated, you check their bodies for any gems before you go back to sleep.");
	//cleanupAfterCombat();
	//goNext(timeQ, false);
//}
//
//public function impGangabangaEXPLOSIONS(loss:Boolean = false):void {
	//pc.slimeFeed();
	//spriteSelect(18);
	////Set imp monster values
	////Clear arrays in preparation
	//monster = new ImpGang();
	//output("\n", false);
	//if (!loss) output("<b>You sleep uneasily. A small sound near the edge of your camp breaks into your rest and you awaken suddenly to find yourself surrounded by " + monster.a + monster.short + "</b>!\n\n", false);
	//if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 && (flags[kFLAGS.SLEEP_WITH] == "Marble" || flags[kFLAGS.SLEEP_WITH] == "")) {
		//output("You look at the door to see that it's open. Shit. You forgot to lock the door before you've went to sleep!\n\n");
	//}
	//if ((Math.sqrt(pc.inte + pc.spe) >= rand(16) || rand(3) == 0) && !loss) {
		//output("The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a " + monster.cockDescript(0) + " as long and thick as a man's arm, far oversized for their bodies. Watching an imp trip over its " + monster.cockDescript(0) + " would be funny, if you weren't surrounded by a horde of leering imps closing in from all sides...\n\n", false);
		//output("You quickly get up in time to ready your " + pc.weaponName + "! It's a fight!")
		//startCombat(monster, true);
		//return;
	//}
	//if (loss) clearOutput();
	////CENTAUR
	//if(pc.isTaur()) {
		//if(rand(2) == 0 && (pc.cockTotal() == 0 || pc.gender == 3)) {
			////(First encounter)
			//if(pc.findStatusAffect(StatusAffects.ImpGangBang) < 0) {
				//output("The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a " + monster.cockDescriptShort(0) + " as long and thick as a man's arm, far oversized for their bodies. Watching an imp trip over its " + monster.cockDescriptShort(0) + " would be funny, if you weren't surrounded by a horde of leering imps closing in from all sides...\n\n", false);
				//pc.createStatusAffect(StatusAffects.ImpGangBang,0,0,0,0);
				//output("The imps leap forward just as you start to ready your " + pc.weaponName + ", one sweaty imp clinging to your arm", false);
				////(If the pc has a weapon)
				//if(pc.weaponName != "fists") output(" while another kicks your weapon out of reach", false);
				//output(".  The " + monster.short + " surges forward and grapples you. Imps grope your body and hump their " + monster.cockDescriptShort(0) + " against your horse legs, smearing their sweat and pre-cum into your " + pc.skinDesc + ". The rest of the " + monster.short + ", a dozen or more imps, all leer at you and laugh as they slap and pinch your body. The imps have sharp claws, tiny sharp teeth, and short horns on their heads. They scratch, claw, and bite at you with all of these weapons as they try to pull you down to the ground. One bold imp leaps forward and grabs your ", false);
				////(If the pc has a cock)"
				//if(pc.cockTotal() > 0) output(cockDescript(0), false);
				////(If the pc has breasts)
				//else output(nippleDescript(0), false);
				//output(", twisting and pinching hard enough to make you yelp in pain. An imp leaps up and mounts you, grabbing your " + hairDescript() + " like reins. The long flesh of his " + monster.cockDescriptShort(0) + " rubs against the small of your back. The " + monster.short + " stinks of sweat and pre-cum, its moist grip and obscene smirk leaves you with no doubt as to what they will do to you if you lose this fight.\n\n", false);
			//}
			//output("The horde drags you to your knees, grappling your legs and crawling over your horse-body to pin you down. You try to buck them off but there are too many to fight. The imps drag your arms behind your back, wrapping them around your rider. Another imp whips off his loincloth to reveal his pre-cum drooling " + monster.cockDescriptShort(0) + " and tosses the cloth to the imps holding your arms. They quickly tie your arms back with the sweat-damp loincloth.  ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 1) output("Having your arms tied behind your back forces your chest out, making your " + pc.allBreastsDescript() + " stand out. They bounce as you struggle.  ", false);
			//output("The " + monster.short + " stroke themselves and rub their hands over your outstretched chest, smearing their pre-cum into your skin. The imp riding you bounces up and down, rubbing his sweaty " +  monster.ballsDescriptLight() + " against your " + pc.skinDesc + " while he yanks your hair.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("Your face flushes with humiliation. Your imp rider twists your " + hairDescript() + " hard and you whimper in pain. Imps rub their cocks along your " + hipDescript() + " while others stroke themselves and jeer at your helplessness.  ", false);
			////(High Corruption)
			//else output(monster.capitalA  + " swarms over your body, some stroking themselves as they watch you squirm while others rub their cocks over your flanks. Your imp rider twists your hair, pulling your head back, and you moan in pleasure at the rough handling. Your " + pc.skinDesc + " tingles as you start to flush with desire.  ", false);
			//output("You yelp in shock as you feel a sharp slap on your ass. You look back to see an imp pulling your tail up. He grins at you and slaps your " + hipDescript() + " again. He yanks your tail and slaps your ass one last time, then dives down to plant his face in your " + vaginaDescript(0) + ". His inhumanly nimble tongue teases the folds of your pussy and flicks at your " + clitDescript() + ".  ", false);
			////(If the pc has balls)
			//if(pc.balls > 0) output("The tongue slides over your " + sackDescript() + ", coating it with warm drool.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You shake your hips, trying to escape the demonic tongue. The imp grips your " + hipDescript() + " and pulls his face further into your cunt, sliding his nimble tongue over your lips. You grit your teeth, trying to ignore the warmth spreading from your " + vaginaDescript(0) + ".", false);
			////(High Corruption)
			//else output("You let out a shuddering sigh as the heat from your cunt spreads into the rest of your body. Your " + hipDescript() + " tremble as the tongue slides over the folds of your " + vaginaDescript(0) + ". The imp grips your flanks harder and dives his nimble tongue into your fuck-hole.", false);
			//output("\n\n", false);
			//
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 1) {
				//output("Hands slide over your " + pc.allBreastsDescript() + ", dragging your attention back to the front of the mob. Two imps grope your " + biggestBreastSizeDescript() + ", mauling your flesh as they drag your tits around your chest. They lick your tit-flesh, slowly working their way up towards your " + nippleDescript(0) + ". The imp rider drops your hair and reaches around you, shoving his cock against your back as he squeezes your " + biggestBreastSizeDescript() + ". Finally the imps reach your nipples, their tongues wrapping around and pulling at the tingling flesh.  ", false);
				////(Low Corruption)
				//if(pc.cor < 50) output("You can't escape the tongues lapping and pulling at your " + nippleDescript(0) + ", matching the one in your cunt. You shake your head to deny the pleasure, but your breathing comes faster and faster as lust invades your body.", false);
				////(High Corruption)
				//else output("The tongues squeezing and tugging your nipples match the tongue working your " + vaginaDescript(0) + ", flooding your body with lust. You moan and arch your back, offering your tits to the imps. You can hear your pulse pounding in your ears as you pant with desire.", false);
				//output("  Suddenly you feel tiny needle-sharp teeth pierce your " + nippleDescript(0) + ". You scream as venom pumps into your tits, red-hot poison that makes your " + pc.allBreastsDescript() + " feel as though they were being stung by bees. You moan in pain as your breasts start to swell, the imps continuing to pump demon-taint into them.\n\n", false);
				////Grow tits!
				//pc.growTits(2, pc.breastRows.length, false, 1);
				//pc.boostLactation(.3);
			//}
			//output("Dimly through your haze of lust and pain you see a large imp step forward from the mob. Four feet tall and broader and stronger looking than any imp you've seen before, with a face as much bull as imp, this new imp has mottled grey skin, broad purple demon wings, two curving bull-horns on his head, and a " + Appearance.cockNoun(CockTypesEnum.HORSE) + " big enough to choke a minotaur. The mushroom-like head of it bobs just below his mouth, and his snake-tongue darts out to flick a bit of pre-cum off the head and onto your face. You shudder as the hot fluid stings the sensitive skin of your lips. His " +  monster.ballsDescriptLight() + " are each the size of your fist and slick with sweat. He slaps his sweaty cock-head against your cheek, nearly scalding you with the heat.  ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("You yelp and twist your head to escape the heat.  ", false);
			////(End low corruption) 
			//output("He slowly rubs his shaft over your cheeks and along your lips, each ridge of his demonically-hot " + Appearance.cockNoun(CockTypesEnum.HORSE) + " tugging at your lips. The hot pre-cum dribbles over your sensitive flesh and the musk makes your sinuses tingle. The big imp sneers as you whimper, and whips his bull-shaft back to slap your face. The other imps watch and stroke themselves as their master cock-whips you.\n\n", false);
			//
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 2) output("The big imp grabs one of your painfully distended breasts in each hand, mauling and bouncing the flesh as if weighing them. You gasp in pain as your " + pc.allBreastsDescript() + " swell further at his touch. ", false);
			//output("Hot pre-cum dribbles through your lips and onto your tongue. The steaming salty goo is almost too hot to stand, and you stick your tongue out to cool it. The imps jerk their cocks harder as you pant, tongue hanging out of your mouth. The master imp steps back and looks you up and down, admiring his handiwork. His snake-tongue darts out to an incredible length and wraps itself around your tongue. He licks his pre-cum from you, then forces his tongue into your mouth. The master imp's tongue curves back into your mouth, pressing the glob of pre-cum into your throat. ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("It's either swallow or have that demon-tongue forced all the way down your throat. Against your will you gulp back the glob.", false);
			////(High Corruption)
			//else output("You swallow the glob of pre-cum eagerly, trying to suck the demon's tongue into your throat.", false);
			//output("\n\n", false);
			//
			//output("The big imp walks around you, casting his gaze over your pinned body.  ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 2) output("The other imps reclaim your aching breasts, sucking your " + nippleDescript(0) + " and mauling your " + pc.allBreastsDescript() + " so hard their fingers disappear into your swelling flesh. ", false);
			//output("The imp rubs his hands over your sides and flanks, his " + Appearance.cockNoun(CockTypesEnum.HORSE) + " bobbing as he walks. The other imps watch their master as he moves around you. Only the imp sucking your " + vaginaDescript(0) + " doesn't notice, his tongue thrusting deeply into your folds. The big imp grabs him by the neck and easily tosses him aside, his tongue dragging through your cunt as he's pulled away from you. The master imp takes position behind you and grabs his " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", bringing the mushroom-head of it down to your pussy. You shake, knowing what's coming next. The other imps watch and stroke themselves as their master readies his hips to push into you.\n\n", false);
			////(Low corruption)
			//if(pc.cor < 50) output("You scream for help", false);
			////(High corruption) 
			//else output("You moan with lust", false);
			//output(" as the inhumanly hot cock-head stretches your pussy lips, your cries vanishing into the dark skies above. Your rider grabs your hair to pull your head back, and you cry out as his master pushes his corrupted cock into you.  ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 1) output("The imps working your breasts suck harder, kneading your tit-flesh as though trying to milk you. ", false);
			//output("You squirm and twist against the imps holding you down as the hot " + Appearance.cockNoun(CockTypesEnum.HORSE) + " almost burns your sensitive cunt. You can smell the sweat steaming off his shaft, and your pussy-fluids start to steam as well as he forces his cock-head into your " + vaginaDescript(0) + ". His huge cock-head bulges your groin, and you moan", false);
			////(Low corruption)
			//if(pc.cor < 50) output(" in helpless terror as you feel the bulge work up from the base of your groin towards your stomach. You let out a shuddering moan of pain as inch after inch of monstrous " + Appearance.cockNoun(CockTypesEnum.HORSE) + " stretches your belly", false);
			////(High corruption)
			//else output(", panting in lust as the monstrous " + Appearance.cockNoun(CockTypesEnum.HORSE) + " pushes your flesh aside to make room for itself", false);
			//output(". ", false);
			////(This is a good place for the virginity-loss message, if needed)
			//pc.cuntChange(monster.cockArea(1), true);			
			//output("You can feel every ridge and pulsing vein of his cock pulling on the lining of your stretched cunt. You tremble helplessly around the huge shaft, fully impaled on the imp's mutated bull-cock.\n\n", false);
			//
			//output("Every pulse of his heart makes his cock twitch, making you shake in time to the shaft pulsing in your cunt. The imps jeer at you, masturbating over your shaking body. The big imp flexes his thighs, and his cock-head throbs deep in your belly. The other imps laugh as you ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("whimper, spasming as the hot shaft presses against new areas", false);
			////(High corruption)
			//else output("moan in pleasure, rotating your hips around this incredible cock", false);
			//output(" in your stuffed " + vaginaDescript(0) + ". The big imp sneers and flexes his cock again, watching ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() >= 2) output("your " + pc.allBreastsDescript() + " roll on your chest as you squirm", false);
			////(If the character doesn't have breasts)
			//else output("your eyes roll back as you squirm", false);
			//output(".\n\n", false);
			//
			//output("Finally the big imp pulls back his " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", each ridge pulling on your pussy flesh as he slides out. You yelp and buck as the mushroom-head catches on your folds. ", false);
			////(If the character has a cock)
			//if(pc.cockTotal() > 0) output("Your " + multiCockDescriptLight() + " bounces as the bulge passes over it.  ", false);
			//output("You moan as the mushroom-head reaches the entrance of your " + vaginaDescript(0) + ", your stretched pussy-flesh slowly returning to normal. The master imp pushes forward again, reclaiming your pussy for his monstrous cock. ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("You try to buck your " + hipDescript() + ", fighting to break free as the bulge of his cock-head works its way high up into your belly. You're held down by too many imps. You can only writhe around the hot shaft stretching out your " + vaginaDescript(0) + ". The big imp grunts as his cock-head pops past your cervix, and you moan and shake in pain.  ", false);
			////(High corruption)
			//else output("You moan in ecstasy as the hot " + Appearance.cockNoun(CockTypesEnum.HORSE) + " pushes deep into your " + vaginaDescript(0) + ", turning every inch of your pussy into a pleasure-sheath for the big imp. You know you're nothing but a fuck-toy for this corrupt creature, just a wet pussy for him to fill with cum, and the thought almost makes you orgasm as he forces his huge cock-head past your cervix.  ", false);
			//output("Finally the corrupt cock bottoms out against your womb. The imp pulls back again, and starts to fuck you slowly.\n\n", false);
			//
			////(If the character has breasts)
			//if(pc.biggestTitSize() >= 2) output("The slow fucking shakes your breasts, and the imps sucking at your nipples cling tightly to your monstrously swollen " + pc.allBreastsDescript() + ". Your " + biggestBreastSizeDescript() + " have grown three cup sizes since the imps pumped their venom into you. An ache starts deep in the base of your tits and works its way to your sore " + nippleDescript(0) + ". Your already bloated nipples swell as the imps suckle and you gasp as the first rush of milk spills into their mouths. Your rider reaches around and starts to milk your udders, moving his hands between your " + pc.allBreastsDescript() + " and forcing out more milk for his gangmates.\n\n", false);
			//
			//output("The big imp grinds his hips as he thrusts and pulls, rubbing his cock-ridges against every part of your " + vaginaDescript(0) + ". While sliding his mutated " + Appearance.cockNoun(CockTypesEnum.HORSE) + " in and out of you, the imp rubs his hands along your mound, pulling it open or forcing it tight as he takes you. Your pussy juices steam off his cock as he pumps, and hot pre-cum dribbles down your crack and ", false);
			////(If the character has a cock)
			//if(pc.cockTotal() > 0) output("over your " + multiCockDescriptLight() + " where it ", false);
			//output("drips onto the ground. ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("The pain as this huge cock stretches you is overwhelming, but every thrust rubs more corrupt pre-cum into your pussy walls. You start to pant as the imp rapes you, using your body for his own pleasure. You tremble as the heat of his pre-cum soaks through your body. The huge shaft forces your " + clitDescript() + " out, and the steaming fluids splashing on it make it tingle almost painfully. Your whimpers and moans of pain start to take on a different tone, and the master imp starts to fuck you faster.", false);
			////(High corruption)
			//else output("Pain and pleasure blend into one as the huge " + Appearance.cockNoun(CockTypesEnum.HORSE) + " stretches you, rubbing pre-cum into your steaming pussy. You moan as the big imp fucks you, turning you into a mindless fuck-puppet. Your " + clitDescript() + " swells painfully as hot juices splash over it. Your shaking body only adds to the master imp's pleasure.", false);
			//output("\n\n", false);
			//
			//output("The other imps continue to jerk-off over you as the big imp impales you again and again on his shaft. Their pre-cum starts to splatter down on your body, and they pant as they watch your orgasm build. ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 1) output("Imps gulp milk from your bloated " + biggestBreastSizeDescript() + ". As one imp drinks his fill and staggers away with a sloshing belly, another steps up to pump your milk-spewing udders.  ", false);
			////(If the character has a dick)
			//if(pc.cockTotal() > 0) output("Your " + multiCockDescriptLight() + " swell painfully as the rough fucking pumps blood into your groin.  ", false);
			//output("The big imp's snake tongue flicks out and slides around your " + vaginaDescript(0) + ", pulling at your pussy lips. He moves his tongue back and forth along the sides of your steaming cunt, alternating between stretching and flicking the lips. ", false);
			////(If the character has a dick)
			//if(pc.totalCocks() > 0) output("He draws his tongue back and wraps it around your " + cockDescript(0) + ", sliding its length along your shaft and flicking his tongue over your cock-head.  ", false);
			//output("You gasp in time to the big imp's thrusts, whimpering when his cock or tongue hit a sensitive point. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You're being raped by a demon, milked like a cow, and you're about to cum hard. This corrupted land has left its mark on you.", false);
			////(High corruption)
			//else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.", false);
			//output(" You moan as you rise towards your orgasm.\n\n", false);
	//
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 3) output("Your udders shake back and forth under your chest in time to the rough fucking. You arch your back to press your " + nippleDescript(0) + " into eager mouths, moaning as your rider milks your distended " + pc.allBreastsDescript() + ". ", false);
			////(Low Corruption).
			//if(pc.cor < 50) output("Some part of you can still feel shame, and you whine and clench your teeth as the urge to <i>moo</i> rises in you.", false);
			////(High corruption)
			//else output("You moan shamelessly as you're fucked and milked, and the moans turn to long <i>mooos</i> of ecstasy.", false);
			//output("\n\n", false);
			//
			//output("The master imp pounds into you as hard as he can, driving his " + monster.cockDescriptShort(1) + " deeper into your cunt. His grunts come closer and closer together. Your rider grinds his cock into your back, rubbing his cock-head in your hair. He nips at your neck and shoulder as he pants. The master imp pounds into you and you can feel his " + monster.ballsDescriptLight() + " swell as they slap against you. Through the haze of your approaching orgasm you realize what's about to happen. Those oversized balls are about to pump more cum into you than any normal man could ever produce. They're going to pump demonic cum right into your womb. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You scream as the base of his " + Appearance.cockNoun(CockTypesEnum.HORSE) + " bloats with corrupted jism, the thick bulge stretching your pussy even more as it pumps along the imp's shaft. The bulge swells your belly and you can feel it move through your stretched cunt towards your womb. Another thick bulge forms at the base of the master imp's cock and you thrash wildly, yelling in protest. \"<i>NOO - O - O - OOOOHhh!</i>\" The hot cum floods into your womb and you reach your own orgasm, shaking as your " + vaginaDescript(0) + " clamps down on his cock and milks it of waves of cum. Another orgasm hits on the heels of the first one, and you buck as more demon-cum floods your womb. Gasping for air, you continue to come as your belly swells. Even as he pumps more corrupt cum into you the big imp keeps raping you, forcing you to another peak before you've come down from the last one.", false);
			////(High corruption)
			//else output("The thought of all that demon-jism in your womb pushes you over the edge. You cum hard, bucking your hips against the " + Appearance.cockNoun(CockTypesEnum.HORSE) + " pumping hot cum into your belly. Your eyes roll back in your head and you scream out in ecstasy as thick jets of cum fill your pussy. The imp keeps thrusting into his fuck-toy even as he fills your womb with his cum, forcing you to another peak before you've come down from the last one. The big imp is your master now.", false);
			//output("  You nearly black out as the orgasm blasts through you,  shrieking yourself hoarse as the orgasm wracks your body, eyes rolling back in your head as your womb swells.\n\n", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 2) output("As orgasms wrack your body your breasts pump out even more milk, too much for the imps below to handle. Milk pours down your chest in great streams, soaking the imps and splashing onto the ground below you. The milk gushing through your tender " + nippleDescript(0) + " pushes you to another orgasm. You shake your tits as you cum, mooing in mindless pleasure, spraying jets of milk everywhere. Your rider cums, soaking your " + hairDescript() + " with jets of imp-jism that run down your scalp and over your cheeks. ", false);
			////(High corruption)
			//if(pc.cor >= 50) output("You lap eagerly at the salty cum, licking up and drinking as much as you can.", false);
			//output("\n\n", false);
			//output("Imp-jism rains down on your helpless spasming body. The imps spew cum into your hair, across your back and " + hipDescript() + ", over your face", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 2) output(", and bouncing " + pc.allBreastsDescript(), false);
			//output(". The " + monster.short + " is no longer holding you down. They masturbate over you as you claw at the ground with your hands, hooves scraping the earth as you clamp your thighs tight around the big imp. Another pulse of demonic cum hits your womb. You push back against your master, forcing as much of his cock into you as possible. Arching your back, your eyes roll back in your head and you moo as your womb stretches painfully, a final orgasm crashing through your cum-bloated body. You spasm around the cock that impales you, thrashing as ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 2) output("milk spurts from your " + nippleDescript(0) + " and ", false);
			//output("steaming fluids spew from your over-filled pussy. Unconsciousness follows closely on the heels of this last orgasm, your mind shutting down even as your body still shudders.\n\n", false);
			//output("You wake up later, body still twitching as tiny orgasms spark in your " + vaginaDescript(0) + ". It's still dark out. You lie on your side in a pool of cooling cum, milk, and pussy juice. Your body is covered in long ropes of drying imp-cum, and your hair is plastered to the ground. There's no sign of the horde of imps or their big master. Your skin is stretched and shiny over your still milk-bloated tits. Your belly is as tight and distended as a mare on the verge of giving birth. It quivers as the flesh of your " + vaginaDescript(0) + " spasms. Over the swollen curve of your belly you can see steam rising from between your legs. You start to slip back into unconsciousness. ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("Your last coherent thought is to find a way to better hide your camp, so this never happens again.", false);
			////(High corruption)
			//else output("Your last coherent thought is to find a way to make your own mutated master imp, maybe even a stable full of them...", false);
			//pc.orgasm();
			//dynStats("lib", 2, "cor", 3);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
		//}
		////Scene number 2 - male possible.
		//else {
			////Scene 2 (Centaur, vaginal)
			//if(pc.findStatusAffect(StatusAffects.ImpGangBang) >= 0) {
				////(Subsequent encounters - Low Corruption)
				//if(pc.cor < 50) output("You can't tell if this is the same " + monster.short + " as last time or not. You're not racist, but all imps look alike to you. " + monster.capitalA  + " surges forward, grabbing at your legs and arms and running their hands over your body. You struggle, but there are just too many to fight. The result is the same as last time...\n\n", false);
				////(Subsequent encounters - High Corruption)
				//else output("It's about time they showed up. It's not like there's a lot to do in these rocks, and you were getting bored. You grab an imp dick in either hand and spread your legs as other imps grope your thighs...\n\n", false);
			//}
			//output("The imp mob tackles you, grabbing at your arms as you ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("swing your " + pc.weaponName + " wildly, determined not to let them take you", false);
			////(High Corruption)
			//else output("twist and struggle in their grips, determined to make them work for their fun", false);
			//output("! You kick back and feel your hooves smash into an imp's chest, sending him flying. But the " + monster.short + " has your legs and more imps grab your arms. The pack drags you thrashing and bucking over to an old log lying on the ground.\n\n", false);
			//
			//output("Your human torso is dragged down to the log by " + monster.a  + " while two more leap onto your back. The " + monster.short + " makes short work of your " + pc.armorName + ", unbuckling straps and stripping you quickly. ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 0) output("Your unbound " + biggestBreastSizeDescript() + " bounce out over the weathered log. ", false);
			//output("The imps spread your arms wide, forcing your chest out, and tie them to the log with sweaty loincloths. Your " + hipDescript()  + " are stuck high in the air. Imps rub their sweaty cocks and " + monster.ballsDescriptLight()  + " over your legs and grope your crotch. The two imps riding your back start stroking and licking each other. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("Your face flushes with humiliation as they turn their attentions on each other, each working their hands and tongue over the other's dick. How dare these demons use you as a bed to sate their lusts?!", false);
			////(High Corruption)
			//else output("Your face flushes with anger as they turn their attentions on each other, each working their hands and tongue over the other's dick. You worked hard for this magnificent body, and now they're not using it?!", false);
			//output("\n\n", false);
			//
			//output("An imp quickly climbs up your body, planting his feet on your shoulders and grabbing your " + hairDescript()  + " with one hand for support. He rubs his " + monster.ballsDescriptLight()  + " over your mouth, smearing your lips with musky sweat, while he pries at your jaw with his other hand. ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 2) output("An imp mounts the log and slaps his " + monster.cockDescriptShort(0) + " between your " + pc.allBreastsDescript() + ", squeezing them tight over his cock as he rubs back and forth. He mauls your breasts cruelly, squeezing his fingers deep into your soft flesh.  ", false);
			////(If the pc has a SINGLE cock)
			//if(pc.cockTotal() == 1) output("An imp ducks under your body and grabs your " + cockDescript(0) + ". His nimble tongue flicks over your cock-head while he pricks the shaft with his tiny claws.  ", false);
			////(If the pc has a MULTI cock)
			//if(pc.cockTotal() > 1) output("Two imps duck under your body and seize your " + multiCockDescriptLight() + ", licking the tips with their inhumanly flexible tongues while they stroke the shafts.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You fight to free your hind legs and buck the imps off your back, while sweaty hands slide over your crotch. You whine through clenched teeth as sharp claws jab at your sensitive flesh.\n\n", false);
			////(High Corruption)
			//else output("You writhe in the grasp of the imps, reveling in the sensations as tiny claws and teeth nip at your sensitive crotch. You lick salty musk off the swollen balls dangling above your mouth.\n\n", false);
			//output("\n\n", false);
			//
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 2) output("The imp fucking your " + biggestBreastSizeDescript() + " handles your soft flesh roughly, pressing and pulling your tits into a fuck-canal for his demon cock. Other imps slap your " + pc.allBreastsDescript() + " and laugh as you cry out.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You whimper as your mistreated flesh stings with dozens of pin-prick scratches and bites, and the " + monster.short + " slaps your chest and flanks. The abuse falls on you from all sides, leaving you with no escape. The imp on your shoulders pries your jaws open, and you gag on his " + monster.ballsDescriptLight()  + ".", false);
			////(High Corruption)
			//else output("You suckle eagerly at the musky balls in your mouth. Abuse falls on you from all sides, imps leaving tiny marks on your skin as they nip and scratch at you. You whimper in delight as tiny hands slap your chest and flanks.", false);
			//output("\n\n", false);
			//
			//output("With a loud sucking sound, the imp pulls his balls out of your mouth. Spit and ball-sweat drip over your cheeks as he repositions himself, bending almost completely over on your shoulders to rub his cock-head against your lips. You nearly choke as pre-cum dribbles into your mouth and runs down the back of your throat. The " + monster.cockDescriptShort(0) + " blocks most of your vision, but in the corners of your eyes you see the master of this imp horde step forward. Four feet tall and broader and stronger than any imp in the pack, with a face as much dog as imp, this new imp has black fur, broad red demon wings, two long demon-horns on his head, and a " + Appearance.cockNoun(CockTypesEnum.DOG) + " big enough to choke a minotaur. He leers at your helpless body and grabs ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 2) output("one of your sore " + biggestBreastSizeDescript() + " in his calloused hand, brutally pressing his fingers into your flesh", false);
			////(If the pc doesn't have breasts)
			//else output("your tail and yanks, brutally pulling on it", false);
			//output(" until you shriek. The imp riding your shoulders plunges his " + monster.cockDescriptShort(0) + " into your mouth, pounding at the top of your throat.\n\n", false);
			//
			//output("The master imp walks back to your hips, lightly dragging his sharp claws over your flanks. He kicks another imp out of the way and takes position behind your " + hipDescript()  + ". He pulls his monstrously long " + Appearance.cockNoun(CockTypesEnum.DOG) + " down and rubs the tip over your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(".  ", false);
			////(If the pc has a cock)
			//if(pc.cockTotal() > 0) output("Pre-cum drips from the broad tip of it, dripping down to the base of your " + multiCockDescriptLight() + ".  ", false);
			//output("The big imp's hot pre-cum stings your flesh. The imps licking your crotch lap up the hot fluid, cooling you with their saliva. The big imp sneers as you whimper, and presses the head of his " + Appearance.cockNoun(CockTypesEnum.DOG) + " against your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(". ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You try to pull away from the hot cock-head rubbing against your hole, but the " + monster.short + " holds you tight.", false);
			////(High Corruption)
			//else output("The scent of musk steaming off the" + Appearance.cockNoun(CockTypesEnum.DOG) + " drives you wild, and you push back to try and capture the cock-tip.", false);
			//output("\n\n", false);
			//
			//output("The pointed tip of the master imp's " + Appearance.cockNoun(CockTypesEnum.DOG) + " plunges into your hole, splitting your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(" wide open. You moan around the cock fucking your throat as the corrupted wolf-cock pushes deeper into your hole. The painfully hot shaft claims inch after inch of your flesh, forcing its way deeper into you than any normal human could bear. Bound to the log you can only shake in agony as the big imp's thick dog-knot hits your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(".", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 2) output("  The imp fucking your aching " + biggestBreastSizeDescript() + " paints your tits with a massive load of cum. He falls off the log and another imp jumps up to take his place.", false);
			//output("\n\n", false);
			//
			//output("The big imp fucks you roughly, clenching your " + hipDescript()  + " in his clawed hands as he hammers his " + Appearance.cockNoun(CockTypesEnum.DOG) + " into you. The head of his mutated shaft pounds ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output("the entrance of your womb", false);
			////(If the pc doesn't have a vagina)
			//else output("depths of your bowels", false);
			//output(" as the knot slams against your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(". Each hard thrust pounds you against the log, and you grunt in time to the shaft pistoning in your hole.\n\n", false);
			//
			//output("The master imp fucks you for what seems like hours, beating his dog-knot against your sore ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(" and slapping your ass every few thrusts to remind you who is in charge. Imp after imp stretches your throat with their cocks and your belly with demon-seed as the pack rapes your face. ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 2) output("The rough fucking shakes your cum-stained breasts, and the imp fucking your " + pc.allBreastsDescript() + " clings tightly to your red and swollen tit flesh. Your " + biggestBreastSizeDescript() + " burn with agony as the " + monster.short + " slaps your tits like drums.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You're being raped again by demons, impaled on cocks like a roast pig on a spit, and you can feel your lust rising. This corrupted land has left its mark on you.", false);
			////(High corruption)
			//else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.", false);
			//output("\n\n", false);
//
			////(Low Corruption)
			//if(pc.cor < 50) output("You gurgle helplessly as the cock raping your throat pours thick wads of", false);
			////(High Corruption)
			//else output("You eagerly chug thick wads of cum from the cock stretching your throat, working your throat to force more", false);
			//output(" cum into your swelling belly. The imp slams his cock as deep into your throat as it will go, slapping his " + monster.ballsDescriptLight() + " against your face. He cums for an impossibly long time, streams of jism pouring into you. You can feel your stomach stretching, but you're more worried about breathing. The edge of your vision starts to go red and your chest heaves as you fight for air. Finally the imp draws his cock out of your throat, spraying his last gobs of cum over your face as you gasp in huge lungfuls of air. The sudden rush of oxygen pushes you over the edge and you cum hard. Your hands clench at the air and your eyes roll back in your head as you twist around the demonic " + Appearance.cockNoun(CockTypesEnum.DOG) + " pounding into you. You shriek as your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(" spasms on the steaming pole that impales it. Another imp shoves his cock in your mouth as you scream, throat convulsing around his cock-head.", false);
			////(If the pc has a cock)
			//if(pc.cockTotal() > 0) output("  Your " + multiCockDescriptLight() + " shoots cum across the ground and into the waiting mouths of the imps licking your crotch.", false);
			//output("\n\n", false);
			//
			//output("Another imp-cock spasms in your throat as its owner rams deep into you. He floods your already swollen stomach with inhuman amounts of cum. Again you feel yourself about to black out as the demon pumps jism into you. He pulls out and again you orgasm as you wheeze for air. Another imp forces his cock down your throat as you moan and gasp. Your body shakes in pleasure on the big imp's " + Appearance.cockNoun(CockTypesEnum.DOG) + ".  Tightening his grip on your " + hipDescript() + " the master imp howls and slams his shaft into your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(". His unnaturally huge knot stretches the entrance of your hole, and he hammers into you again. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You howl around the imp-cock stretching your throat. The bloated knot opens your hole far beyond anything you've endured before. Your violent thrashing throws the imps off your back and you buck uselessly, thrashing as the swollen " + Appearance.cockNoun(CockTypesEnum.DOG) + " plunges deeper into you.", false);
			////(High corruption)
			//else output("The master imp's bloated knot stretches your entrance and plunges into your hole with a loud <i>pop</i>. Another orgasm hits you as the " + Appearance.cockNoun(CockTypesEnum.DOG) + " rams even deeper into you. You howl around the imp-cock stretching your throat, bucking as your orgasm shakes you. Your violent thrashing throws the imps off your back and slams your hips against the big imp, pushing him further into your hole.", false);
			//output("  The big imp howls again as he cums, each wave of steaming demon-cum stretching his knot and shaft even more. His cum-pumping " + Appearance.cockNoun(CockTypesEnum.DOG) + " is bottomed out deep in your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output("womb", false);
			////(If the pc doesn't have a vagina)
			//else output("guts", false);
			//output(" and he pumps more jism into you than his balls could possibly hold. Your belly stretches with every blast of cum and you shriek around yet another cock in your throat.\n\n", false);
//
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 2) output("The imp riding your " + biggestBreastSizeDescript() + " cums, his load lost in the flood of jism dripping off your abused fuck-udders. ", false);
			//output("Your master isn't done with you yet, churning his " + Appearance.cockNoun(CockTypesEnum.DOG) + " knot in your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(" as he continues to cum. You're pumped full of demon-cum from both ends as one imp shoots his load in your throat and another steps up to take his place. You shake and tremble in your own endless orgasm as the pleasure in your stretched hole blends with the pain of your swollen belly. Your fingers claw at the log as the master imp shifts his massive knot within your monstrously stretched ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(". Your legs give out as you feel more pulses of demon-cum work their way up his shaft and into your already-huge belly.\n\n", false);
			//
			//output("You pass out as another tidal wave of corrupted jism spews into your hole, another load of imp-cum pours down your throat, to meet somewhere in the middle...\n\n", false);
			//
			//output("You wake up later, still trembling with small orgasms. Cum burbles in your mouth as you breathe, and your " + hairDescript() + " is soaked with jism. You haven't moved since you passed out. Your arms are still tied to the log, ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 0) output("your bruised and throbbing tits pressed against the rough wood, ", false);
			//output("and your body rests in a cooling pool of cum. You couldn't move even if your " + pc.legs() + " felt stronger. Your hideously bloated belly weighs you down, quivering with every orgasmic twitch that passes through you. The skin of your distended belly is drum-tight and shiny. As you slip back into unconsciousness, one last thought flits across your mind. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("How long can you last in this corrupted land, when your body can be so horribly twisted by the sick pleasures of its denizens?", false);
			////(High corruption)
			//else output("Why bother with your silly quest, when you've only scratched the surface of the pleasures this land offers you?\n", false);
			//pc.orgasm();
			//dynStats("lib", 2, "cor", 3);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
			////Stretch!
			//if(pc.hasVagina()) {
				//if(pc.cuntChange(monster.cockArea(2), true)) output("\n", false);
			//}
			//else {
				//if(pc.buttChange(monster.cockArea(2), true)) output("\n", false);
			//}
		//}
	//}
	////NOT CENTAUR
	//else {
		//if(rand(2) == 0 && (pc.cockTotal() == 0 || pc.gender == 3)) {
			////(First encounter)
			//if(pc.findStatusAffect(StatusAffects.ImpGangBang) < 0) {
				//output("The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a " + monster.cockDescriptShort(0) + " as long and thick as a man's arm, far oversized for their bodies. Watching an imp trip over its " + monster.cockDescriptShort(0) + " would be funny, if you weren't surrounded by a horde of leering imps closing in from all sides...\n\n", false);
				//pc.createStatusAffect(StatusAffects.ImpGangBang,0,0,0,0);
			//}
			//output("The imps leap forward just as you start to ready your " + pc.weaponName + ", one sweaty imp clinging to your arm", false);
			//if(pc.weaponName != "fists") output(" while another kicks your weapon out of reach", false);
			//output(". The " + monster.short + " surges forward and grapples you. Imps grope your body and hump their " + monster.cockDescriptShort(0) + " against your legs, smearing their sweat and pre-cum into your " + pc.skinDesc + ". The rest of the " + monster.short + ", a dozen or more imps, all leer at you and laugh as they slap and pinch your body. The imps have sharp claws, tiny sharp teeth, and short horns on their heads. They scratch, claw, and bite at you with all of these weapons as they try to pull you down to the ground. One bold imp leaps forward and grabs your ", false);
			////(If the pc has a cock)
			//if(pc.cockTotal() > 0) output(cockDescript(0), false);
			//else output(nippleDescript(0), false);
			//output(", twisting and pinching hard enough to make you yelp in pain. The " + monster.short + " stinks of sweat and pre-cum, and their moist grips and obscene smirks leave you with no doubts about what they will do to you if you lose this fight.\n\n", false);
			////(Bipedal, vaginal)
			//output("The " + monster.capitalA  + " overwhelms you, dragging you to the ground with sheer numbers. There are at least two imps on each limb, holding you spread-eagled on the cold ground while other imps stroke your body. ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 0) output("Imps surround your chest, slapping their " + monster.cockDescriptShort(0) + "s on your " + pc.allBreastsDescript() + " and rubbing their slippery pre-cum into your " + nippleDescript(0) + ".  ", false);
			//output("Others stand over your head, their cocks bobbing inches from your face as they jack off. A thick musk wafts off their cocks, and the smell of it makes your sinuses tingle. Two more imps take position between your legs, sliding their cocks along your thighs while stroking your " + vaginaDescript(0) + " and flicking your " + clitDescript() + ".", false);
			////(If the pc has a cock)
			//if(pc.cockTotal() > 0) output("An imp rubs his hand across his cock-head, smearing it with his pre-cum. He rubs his hand over your " + multiCockDescriptLight() + ", making your cock-skin tingle as his fluid soaks into you.", false);
			//output("\n\n", false);
			//output("The " + monster.short + " snickers lewdly as your nipples harden and your pussy moistens. One of the imps between your legs slides his shaft along your pussy lips, teasing your " + clitDescript() + " with the tip of his cock.  ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("You renew your struggles, trying to break free of your captors. They only laugh and bear down harder on you.  ", false);
			////(High corruption)
			//else output("You buck your hips, trying to capture his " + monster.cockDescriptShort(0) + " with your " + vaginaDescript(0) + ".  ", false);
			//output("Before he can thrust into you, the imp is shoved aside by the biggest imp you've ever seen.\n\n", false);
			//
			//output("Four feet tall and broader and healthier looking than any imp you've seen before, with a face as much bull as imp, this new imp has mottled grey skin, broad purple demon wings, two curving bull-horns on his head, and a " + Appearance.cockNoun(CockTypesEnum.HORSE) + " big enough to choke a minotaur. The mushroom-like head of it bobs just below his mouth, and his snake-tongue darts out to flick a bit of pre-cum off the head and onto your groin. You shudder as the hot fluid stings the sensitive skin of your " + vaginaDescript(0), false);
			////(If the pc has a dick)
			//if(pc.cockTotal() > 0) output(" and " + multiCockDescriptLight(), false);
			//output(". His " + monster.ballsDescriptLight() + " are each the size of your fist and slick with sweat. He slaps his sweaty balls against your " + vaginaDescript(0) + " nearly scalding you with the heat.  ", false);
			////(Low corruption)
			//if(pc.cor < 33) output("You yelp and buck your hips to escape the heat.  ", false);
			//output("He grabs your hips and slowly drags his shaft down your pussy, each ridge of his demonically-hot " + Appearance.cockNoun(CockTypesEnum.HORSE) + " hitting your clit and pulling at your lips. Finally the broad horse-like head of his shaft catches on your " + clitDescript() + ", and the hot pre-cum dribbles over your sensitive flesh. The big imp sneers as you whimper, and drags his cock-head down to the opening of your " + vaginaDescript(0) + ". The other imps watch and stroke themselves as their master pulls his hips back to push into you.\n\n", false);
			////(Low corruption)
			//if(pc.cor < 50) output("You scream for help", false);
			////(High corruption)
			//if(pc.cor >= 50) output("You moan with lust", false);
			//output(" as the inhumanly hot cock-head stretches your pussy lips, your cries vanishing into the dark skies above. Two imps grab your hair and pull your head up, forcing you to watch as their master pushes his corrupted cock into you. Other imps spread your [legs] even wider, leaving you helpless as the big imp slides his swollen meat into your " + vaginaDescript(0) + ". You squirm and twist against the imps holding you down as the hot flesh almost burns your sensitive cunt. You can smell the hot sweat steaming off his shaft, and your pussy-fluids start to steam as well as he forces his cock-head into your " + vaginaDescript(0) + ". His huge cock-head bulges your groin, and you watch ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("in helpless terror as the bulge inches up from the base of your groin towards your stomach. You let out a shuddering moan of pain as inch after inch of monstrous " + Appearance.cockNoun(CockTypesEnum.HORSE) + " stretches your belly", false);
			////(High corruption)
			//else output("panting in lust as the monstrous " + Appearance.cockNoun(CockTypesEnum.HORSE) + " pushes your flesh aside to make room for itself", false);
			//output(". ", false);
			////(This is a good place for the virginity-loss message, if needed)
			//pc.cuntChange(monster.cockArea(1), true);
			//output("\n\n", false);
			//output("You can feel every ridge and pulsing vein of his cock pulling on the lining of your stretched cunt. You tremble helplessly around the huge shaft, fully impaled on the imp's mutated bull-cock.\n\n", false);
			//output("Every pulse of his heart makes his cock twitch, making you shake in time to the shaft pulsing in your cunt. The imps jeer at you, masturbating over your shaking body. The big imp flexes his thighs, and the bulge of his cock-head bounces high in your belly. The other imps laugh as you ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("whimper, spasming as the hot shaft presses against new areas", false);
			////High corruption)
			//else output("moan in pleasure, rotating your hips around this incredible cock", false);
			//output(" in your stuffed " + vaginaDescript(0) + ". The big imp sneers and bounces his cock again, watching ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() >= 3) output("your " + pc.allBreastsDescript() + " roll on your chest as you squirm", false);
			////(If the character doesn't have breasts)
			//else output("your eyes roll back as you squirm", false);
			//output(".  ", false);
			////(If the character has a cock)
			//if(pc.cockTotal() > 0) output("Your " + multiCockDescriptLight() + " slaps against your distended belly as you shake.", false);
			//output("\n\n", false);
			//output("Finally the big imp pulls back his " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", each ridge pulling on your pussy flesh as he slides out. An imp reaches out and slaps the bulge as it withdraws, making you yelp and buck.  ", false);
			////(If the character has a cock)
			//if(pc.cockTotal() > 0) output("Your " + multiCockDescriptLight() + " bounces as the bulge passes under it.  ", false);
			//output("You moan as the mushroom-head reaches the entrance of your " + vaginaDescript(0) + ", your stretched pussy-flesh slowly returning to normal. The master imp pushes forward again, reclaiming your pussy for his monstrous cock. ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("You try to pull your hips back, fighting to break free as the bulge of his cock-head works its way high up into your belly. You're held down by too many imps. You can only writhe around the hot shaft stretching out your " + vaginaDescript(0) + ". Your head is held steady by two imps, you can't even look away as their master rapes you. The big imp grunts as his cock-head pops past your cervix, and you moan and shake in pain.", false);
			////(High corruption)
			//else output("You moan in ecstasy as the hot " + Appearance.cockNoun(CockTypesEnum.HORSE) + " pushes deep into your " + vaginaDescript(0) + ", turning every inch of your pussy into a pleasure-sheath for the big imp. You know you're nothing but a fuck-toy for this corrupt creature, just a wet pussy for him to fill with cum, and the thought almost makes you orgasm as he forces his huge cock-head past your cervix.", false);
			//output("Finally the corrupt cock bottoms out against your womb. The imp pulls back again, and starts to fuck you slowly.\n\n", false);
			//
			//output("The big imp grinds his hips as he thrusts and pulls, rubbing his cock-ridges against every part of your " + vaginaDescript(0) + ".  While sliding his mutated " + Appearance.cockNoun(CockTypesEnum.HORSE) + " in and out of you the imp rubs his hands along your mound, pulling it open or forcing it tight as he takes you. Your pussy juices steam off his cock as he pumps, and hot pre-cum dribbles down your crack to your " + assholeDescript() + ". ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("The pain as this huge cock stretches you is overwhelming, but every thrust rubs more corrupted pre-cum into your pussy walls. You start to pant as the imp rapes you, using your body for his own pleasure. Your nipples swell as the heat of his pre-cum soaks through your body. The huge shaft forces your " + clitDescript() + " out, and the steaming fluids splashing on it make it tingle almost painfully. Your whimpers and moans of pain start to take on a different tone, and the master imp starts to fuck you faster.", false);
			////(High corruption)
			//else output("Pain and pleasure blend into one as the huge " + Appearance.cockNoun(CockTypesEnum.HORSE) + " stretches you, rubbing pre-cum into steaming pussy. You moan as the big imp fucks you, turning you into a mindless fuck-puppet. Your " + clitDescript() + " swells painfully as hot juices splash over it. Your " + nippleDescript(0) + " tingle almost painfully as the heat of his pre-cum spreads through your body.", false);
			//output("\n\n", false);
			//output("The other imps continue to jerk-off over you as the big imp impales you again and again on his shaft. Their pre-cum starts to splatter down on your body, and they pant as they watch you build towards your orgasm.  ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() >= 3) output("Your " + pc.allBreastsDescript() + " bounce and jiggle back and forth as the master imp roughly fucks you.  ", false);
			////(If the character has a dick)
			//if(pc.totalCocks() > 0) output("Your " + multiCockDescriptLight() + " swell painfully as the rough fucking pumps blood into your groin.  ", false);
			//output("The big imp's snake tongue lashes out to incredible length and wraps around one of your " + nippleDescript(0) + "s, pulling at it and stretching the flesh under it. He moves his tongue back and forth between your nipples, alternating between stretching and flicking them. ", false);
			////(If the character has a dick)
			//if(pc.cockTotal() > 0) output("He draws his tongue back and wraps it around your " + cockDescript(0) + ", sliding its length along your shaft and flicking his tongue over your cock-head.", false);
			////(If the character doesn't have a dick)
			//else output("His tongue flicks down to your " + clitDescript() + ", the split ends of it teasing your clit.", false);
			//output("  You gasp in time to the big imp's thrusts, whimpering when his cock or tongue hit a sensitive point.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You're being raped by a demon, forced to take an inhuman cock, and you're about to cum hard. This corrupted land has left its mark on you.", false);
			////(High corruption)
			//else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.", false);
			//output("  You moan as you rise towards your orgasm.\n\n", false);
			//
			//output("The master imp pounds at you as hard as he can, driving his " + monster.cockDescriptShort(1) + " deeper into you. His grunts come closer and closer together. Your head still held up, you watch as the imps around you start to cum. They spray your body with thick globs of cum, splattering it across your belly", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() >= 3) output(" and " + pc.allBreastsDescript(), false);
			//output(". The master imp pounds into you and you can see his " + monster.ballsDescriptLight() + " swell. Through the haze of your approaching orgasm you realize what's about to happen. Those oversized balls are about to pump more cum into you than any normal man could ever produce. They're going to pump demonic cum right into your womb.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You scream as the base of his " + Appearance.cockNoun(CockTypesEnum.HORSE) + " bloats with corrupted jism, the thick bulge stretching your pussy even more as it pumps along the imp's shaft. The bulge swells your belly and you watch as it moves towards your womb. Another thick bulge forms at the base of the master imp's cock and you thrash wildly, yelling in protest. \"<i>NOO - O - O - OOOOHhh!</i>\" The hot cum floods into your womb and you hit your own orgasm, shaking as your " + vaginaDescript(0) + " clamps down on his cock and milks it of waves of cum. Another orgasm hits on the heels of the first one, and you buck as more demon-cum floods your womb. Gasping for air, you continue to come as your belly swells. Even as he pumps more corrupt cum into you the big imp keeps raping you, forcing you to another peak before you've come down from the last one.", false);
			////(High corruption)
			//else output("The thought of all that demon-jism in your womb pushes you over the edge. You cum hard, bucking your hips against the " + Appearance.cockNoun(CockTypesEnum.HORSE) + " pumping hot cum into your belly. Your eyes roll back in your head and you scream out your ecstasy as thick jets of cum fill your pussy. The imp keeps thrusting into his fuck-toy even as he fills your womb with his cum, forcing you to another peak before you've come down from the last one. The big imp is your master now.", false);
			//output("  You nearly black out as the orgasm blasts through you,  arching your back off the ground as the orgasm wracks your body, eyes rolling back in your head as your womb swells.\n\n", false);
			//
			//output("Imp-jism rains down on your helpless spasming body. The imps spew cum into your hair, across your swollen belly, over your face", false);
			////(If the character has a cock) 
			//if(pc.cockTotal() > 0) output(", and cum-dripping " + cockDescript(0), false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() >= 3) output(", and bouncing " + pc.allBreastsDescript(), false);
			//output(". The " + monster.short + " is no longer holding you down. They masturbate over you as you claw at the ground with your hands, toes curling as you clamp your thighs tight around the big imp. Another pulse of demonic cum hits your womb. You wrap your legs around your master, forcing as much of his cock into you as possible. Arching your back, your eyes roll back in your head and you shriek as your womb stretches painfully, a final orgasm crashing through your cum-bloated body. You spasm around the cock that impales you, thrashing against the ground as ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() >= 3 && pc.biggestLactation() > 1) output("milk spurts from your " + nippleDescript(0) + " and ", false);
			//output("steaming fluids spew from your over-filled pussy. Unconsciousness follows close on the heels of this last orgasm, your mind shutting down even as your body still shudders.\n\n", false);
			//output("You wake up later, body still twitching as tiny orgasms spark in your " + vaginaDescript(0) + ". It's still dark out. You lie in a pool of cooling cum and pussy juice. Your body is covered in long ropes of drying imp-cum, and your hair is plastered to the ground. There's no sign of the horde of imps or their big master. Your belly is as tight and distended as a woman on the verge of giving birth. It quivers as the flesh of your " + vaginaDescript(0) + " spasms. Over the swollen curve of your belly you can see steam rising from between your legs. You start to slip back into unconsciousness. ", false);
			////(Low corruption)
			//if(pc.cor < 50) output("Your last coherent thought is to find a way to better hide your camp, so this never happens again.", false);
			////(High corruption)
			//else output("Your last coherent thought is to find a way to make your own mutated master imp, one you can keep as a fuck-toy...", false);
			//pc.orgasm();
			//dynStats("lib", 2, "cor", 3);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
		//}
		//else {
			////Imp Scene 2 (Bipedal, vaginal)
			////Tag-team
			////Include milking alt text in separate blocks. 
			////Work cock and multicock alt text directly into main text blocks.
			//if(pc.findStatusAffect(StatusAffects.ImpGangBang) >= 0) {
				////(Subsequent encounters - Low Corruption)
				//if(pc.cor < 50) output("You can't tell if this is the same " + monster.short + " as last time or not - all imps look alike to you.  The " + monster.capitalA  + " surges forward, grabbing at your " + pc.legs() + " and arms and running their hands over your body. You struggle, but there are just too many to fight. The result is the same as last time...\n\n", false);
				////(Subsequent encounters - High Corruption)
				//else output("It's about time they showed up. It's not like there's a lot to do in these rocks, and you were getting bored. You grab an imp dick in either hand and spread your legs as other imps grope your thighs...\n\n", false);
			//}
			//output("The " + monster.capitalA + " swarms over you, dragging you to the ground as ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("you punch and kick wildly, determined not to let them take you", false);
			////(High Corruption)
			//else output("you twist and struggle in their grips, determined to make them work for their fun", false);
			//output("! They pull you down over a fallen log, ass resting above your head. Two imps sit on your arms, their gonads rubbing against your biceps, and rub their hands over your shoulders and chest. Others stretch your ");
			//if(pc.isNaga()) output("coils out, twisting them around a log to hold you still.\n\n");
			//else output(pc.legs() +" wide apart, holding them against the log.\n\n", false);
			//
			//output("The " + monster.short + " makes short work of your " + pc.armorName + ", unbuckling straps and stripping you quickly. ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 0) output("An imp mounts your chest and slaps his " + monster.cockDescriptShort(0) + " between your " + pc.allBreastsDescript() + ", squeezing them tight over his cock as he rubs back and forth.  ", false);
			////(If the pc has a SINGLE cock)
			//if(pc.cockTotal() == 1) output("Your " + cockDescript(0) + " is seized by an imp, who licks the tip with his inhumanly nimble tongue while he strokes the shaft.  ", false);
			////(If the pc has a MULTI cock)
			//if(pc.cockTotal() > 1) output("Two imps seize your " + multiCockDescriptLight() + ", licking the tips with their inhumanly nimble tongues while they stroke the shafts.  ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You fight to free your arms and shake the imp off your chest while tiny hands slide over your face. They tug at your lips and try to pry your jaws open", false);
			////High Corruption)
			//else output("You writhe in the grasp of the imps, reveling in the sensations of being spread open and completely at the mercy of these demons. Tiny hands slide over your face and you lick and suck at the fingers", false);
			//output(".\n\n", false);
			//
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 0) {
				//output("Hands slide over your " + pc.allBreastsDescript() + ", pinching and pulling at your nipples. The imp riding your " + biggestBreastSizeDescript() + " licks your tit-flesh, slowly working his tongue up towards your " + nippleDescript(0) + ". Finally the imp's tongue reaches your nipple, wrapping around and pulling at the tingling flesh. ", false);
				////(Low Corruption)
				//if(pc.cor < 50) output("You can't escape the tongue lapping and pulling at your " + nippleDescript(0) + ". You shake your head to deny the pleasure, but your breathing comes faster and faster as lust invades your body.", false);
				////(High Corruption)
				//else output("The tongue squeezing and tugging your nipple floods your body with lust. You moan and arch your back, offering your tits to the imp riding your chest. You can hear your pulse pounding in your ears as you pant in desire.", false);
				//output("  Suddenly you feel tiny needle-sharp teeth pierce your nipple. You scream as venom pumps into your tits, red-hot poison that makes your " + pc.allBreastsDescript() + " feel as though they were being stung by bees. You moan in pain as your breasts start to swell, the imp rider biting into your other nipple to pump demon-taint into it.", false);
				//if(pc.hasFuckableNipples()) output("With the imp's taint seeping into your " + nippleDescript(0) + ", each one's cunt-like shape begins swelling. The fuckable orifices engorge into larger and fatter looking labia, becoming fuller cunts each with an engorged clitoral nub the size of a golf ball. Their color deepens as the skin of your nipple-cunts becomes tighter and smoother.  The imp giggles and continues nibbling the newly swollen sensitive flesh, injecting further doses of venom.", false);
				//output("\n\n", false); 
				////Grow tits!
				//pc.growTits(2, pc.breastRows.length, false, 1);
				//pc.boostLactation(.5);
			//}
			//output("The master of this " + monster.short + " steps up ");
			//if(pc.isNaga()) output("alongside your taut tail");
			//else output("between your " + pc.legs());
			//output(", leering down at your trapped body. Four feet tall and broader and stronger than any imp in the pack, with a face as much dog as imp, this new imp has grey fur, broad black demon wings, two long demon-horns on his head, and a " + Appearance.cockNoun(CockTypesEnum.DOG) + " big enough to choke a minotaur. Pre-cum drips from the broad tip of it, dripping down onto your ", false);
			////(If the pc has a cock)
			//if(pc.cockTotal() > 0) output(multiCockDescriptLight(), false);
			////(If the pc doesn't have a cock)
			//else output(vaginaDescript(0), false);
			//output(".  ", false);
			//output("The heat stings your flesh. The imps licking your groin lap up the hot fluid, cooling you with their saliva. The big imp sneers as you whimper, and drags the head of his " + Appearance.cockNoun(CockTypesEnum.DOG) + " down to your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(".  He thrusts brutally, shoving the head of his " + monster.cockDescriptShort(2) + " into your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)" + 
			//else output(assholeDescript(), false);
			//output(". ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You screech in agony as the big imp forces his mutated wolf-cock into your hole, brutally shoving thick inch after inch of painfully hot " + Appearance.cockNoun(CockTypesEnum.DOG) + " deeper into you than anything should ever go.  ", false);
			////(High Corruption)
			//else output("The master imp's painfully hot " + Appearance.cockNoun(CockTypesEnum.DOG) + " stretches your hole wider than it ever should be, and you moan in perverse ecstasy.  ", false); 
			//output("His huge dick-knot bumps against the entrance of your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(".\n\n", false);
			//
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 0) output("The big imp reaches past your tit-rider and grabs one of your painfully distended breasts in each hand, mauling and bouncing the flesh as if weighing them. You gasp in pain as your " + pc.allBreastsDescript() + " swell further at his touch.  ", false);
			//output("Your mouth gapes open and an imp takes the chance to stuff it full of cock.  ", false);
			//output("The master imp grabs your hips and starts to fuck you hard, pistoning his steaming cock in and out of your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(". ", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 1) output("The rough fucking shakes your breasts, and the imp sucking your nipples clings tightly to your monstrously swollen " + pc.allBreastsDescript() + ". Your " + biggestBreastSizeDescript() + " have grown three cup sizes since the imp pumped his venom into you.  ", false);
			//output("The imp fucking your face grabs your " + hairDescript() + " and jaw, forcing your head back so he can ram his cock into your throat. The obscene bulge sliding in your throat matches the bulge in your belly. The smaller imp pulls back just enough to let you gasp for air, then thrusts into your throat again. The big imp pounds the knot of his " + Appearance.cockNoun(CockTypesEnum.DOG) + " against your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(", not caring that he's stretching you beyond normal human endurance. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You're being raped again by demons, impaled on cocks like a roast pig on a spit, and you can feel your lust rising.  This corrupted land has left its mark on you.", false);
			////(High corruption)
			//else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.", false);
			//output("\n\n", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 0) output("An ache starts deep in the base of your tits and works its way to your sore " + nippleDescript(0) + ". Your already bloated nipples swell as your rider suckles and you gasp as the first rush of milk spills into his mouth. Your rider milks your udders, moving his hands between your " + pc.allBreastsDescript() + " and forcing out more milk than he could ever drink. Other imps lick the milk from the shiny skin of your swollen breasts.\n\n", false);
			//
			//output("The smaller imp slams his cock as deep into your throat as it will go, slapping his " + monster.ballsDescriptLight() + " against your face. He cums, balls twitching as they pump spunk down your throat. You can feel your stomach stretching, but you're more worried about breathing. The imp cums for an impossibly long time, streams of jism pouring into you. The edge of your vision starts to go red and your chest heaves as you fight for air. Finally the imp draws his cock out of your throat, spraying his last gobs of cum over your face as you gasp in huge lungfuls of air. The sudden rush of oxygen pushes you over the edge and you cum hard. Your body arches and your eyes roll back in your head as you twist around the demonic " + Appearance.cockNoun(CockTypesEnum.DOG) + " pounding into you. You shriek as your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(" spasms on the steaming pole that impales it. Another imp shoves his cock in your mouth as you scream, throat convulsing around his cock-head.", false);
			////(If the pc has a cock)
			//if(pc.cockTotal() > 0) output("  Your " + multiCockDescriptLight() + " shoots cum across your belly and into the waiting mouths of the imps licking your crotch.", false);
			//output("\n\n", false);
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 0) {
				//output("Imps lick milk from your bloated " + biggestBreastSizeDescript() + " as your rider milks you.  As one imp drinks his fill, staggering away with a sloshing belly, another steps up to guzzle from your milk-spewing udders.\n\n", false);
				////Additional nipplefucking scene by Xodin
				//if(pc.hasFuckableNipples()) {
					//output("The imp rider grabs the fat folds of one of your nipplecunt's 'labia' and grins mischeviously. He rubs his obscene erection all over the milk stained surface of your nipple-cunt's clit and begins to press the head of his bulbous imp cock into the swollen orifice against the flow of milk. You know no woman in your village could have handled an aroused cock this big, and yet now this imp on your " + pc.allBreastsDescript() + " is about to ram just such an erection into one of your " + nippleDescript(0) + "s. He tugs and pulls and pulls again on your nipple-cunt's sensitive labia, forcing his cock to push into the flesh of your " + biggestBreastSizeDescript() + ". Your taut flesh burns with his venom already, and is now violated by the presence of his demonic flesh rod.  ", false);
					////[START BREAST SIZE SPECIFIC TEXT] 
					////[IF breastSize <= DD]
					//if(pc.biggestTitSize() <= 5) output("You feel the bulbous head of his cock squeeze further and deeper until it pushes up against your ribs.", false);
					////[ELSE IF breastSize > DD]
					//else output("You feel the unnaturally large erection spear the fat filled depths of your " + biggestBreastSizeDescript() + " until at last the imp has shoved himself in to his hilt. He smiles at the sensation of having his manhood completely engulfed in your " + biggestBreastSizeDescript() + ".", false);
					////[END BREAST SIZE SPECIFIC TEXT]
					//output("  Back and forth he begins fucking your tit as if it were a regular pussy, and it occurs to you that such a description isn't far from the truth. You gasp in pleasure as a strange kind of minor orgasm ripples through your tit and the taut skin of your mammary feels tighter as the " + biggestBreastSizeDescript() + " momentarily spasms around the imp's manhood. The horny little demon slaps your nipplecunt's clit in gleeful victory and jumps to the next breast to repeat his lewd fucking on a fresh hole.", false);
					//output("\n\n", false);
				//}
//
			//}
			//output("The imp-cock in your throat spasms and its owner rams as deep into you as he can get. He floods your already swollen stomach with inhuman amounts of cum. Again you feel yourself about to black out as the demon pumps jism into you. He pulls out and again you orgasm as you wheeze for air. Another imp forces his cock down your throat as you moan and gasp. Your body shakes in pleasure on the big imp's " + Appearance.cockNoun(CockTypesEnum.DOG) + ".  Tightening his grip on your " + hipDescript() + " the master imp howls and slams his shaft into your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0),false);
			////If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(". His unnaturally huge knot stretches the entrance of your hole, and he hammers into you again. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("You howl around the imp-cock stretching your throat. The bloated knot opens your hole far beyond anything you've endured before. Your violent thrashing throws the imps off your " + pc.legs() + " and you kick uselessly, thrashing and bucking as the swollen " + Appearance.cockNoun(CockTypesEnum.DOG) + " plunges deeper into you.", false);
			////(High corruption)
			//else output("The master imp's bloated knot stretches your entrance and plunges into your hole with a loud <i>pop</i>. Another orgasm hits you as the " + Appearance.cockNoun(CockTypesEnum.DOG) + " rams even deeper into you. You howl around the imp-cock stretching your throat, thrashing and bucking as your orgasm shakes you. Your violent thrashing throws the imps off your legs and you wrap your legs around the big imp, pulling him further into your hole.", false);
			//output(" The big imp howls again as he cums, each wave of steaming demon-cum stretching his knot and shaft even more. His cum-pumping " + Appearance.cockNoun(CockTypesEnum.DOG) + " is bottomed out deep in your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output("womb", false);
			////(If the pc doesn't have a vagina)
			//else output("guts", false);
			//output(" and he pumps more jism into you than his balls could possibly hold. Your belly stretches with every blast of cum and you shriek around yet another cock in your throat.\n\n", false);
			//
			////(If the character has breasts)
			//if(pc.biggestTitSize() > 0) output("The imp riding your " + biggestBreastSizeDescript() + " finally cums, painting your distended fuck-udders with his massive load.  ", false);
			//output("Your master isn't done with you yet, churning his " + Appearance.cockNoun(CockTypesEnum.DOG) + " knot in your ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(" as he continues to cum. You're pumped full of demon-cum from both ends as one imp shoots his load in your throat and another steps up to take his place. You shake and tremble in your own endless orgasm as the pleasure in your stretched hole blends with the pain of your swollen belly. Your " + pc.legs() + " thrash as the master imp shifts his massive knot within your monstrously stretched ", false);
			////(If the pc has a vagina)
			//if(pc.hasVagina()) output(vaginaDescript(0), false);
			////(If the pc doesn't have a vagina)
			//else output(assholeDescript(), false);
			//output(". Your toes curl as you feel more pulses of demon-cum work their way up his shaft and into your already-huge belly.\n\n", false);
			//
			//output("You pass out as another load of imp-cum pours down your throat, another tidal wave of corrupted jism spews into your hole, to meet somewhere in the middle...\n\n", false);
			//output("You wake up later, still trembling with small orgasms. Cum burbles in your mouth as you breathe. You haven't moved since you passed out. Your hips are still propped up over the log, and you rest in a cooling pool of cum, your " + hairDescript() + " plastered to the ground with drying jism. You couldn't move even if your " + pc.legs() + " felt stronger. Your hideously bloated belly weighs you down, ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 0) output("and your milk-filled udders are still swollen with imp-venom, ", false);
			//output("quivering with every orgasmic twitch that passes through you. The skin of your distended belly ", false);
			////(If the pc has breasts)
			//if(pc.biggestTitSize() > 3) output("and massive tits ", false);
			//output("is drum-tight and shiny, and your belly-button has popped out into an outie. As you slip back into unconsciousness, one last thought flits across your mind. ", false);
			////(Low Corruption)
			//if(pc.cor < 50) output("How long can you last in this corrupted land, when your body can be so horribly twisted for the sick pleasures of its denizens?\n\n", false);
			////(High corruption)
			//else output("Why bother with your silly quest, when you've only scratched the surface of the pleasures this land offers you?\n\n", false);
			//pc.orgasm();
			//dynStats("lib", 2, "cor", 3);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
			////Stretch!
			//if(pc.hasVagina()) {
				//if(pc.cuntChange(monster.cockArea(2), true)) output("\n", false);
			//}
			//else {
				//if(pc.buttChange(monster.cockArea(2), true)) output("\n", false);
			//}
		//}
	//}
	//if (getGame().inCombat) cleanupAfterCombat();
	//else doNext(pcMenu);
//}
public function CoCImpPCLoss():void {
	clearOutput();
	if (pc.isBimbo() && !pc.isTaur() && pc.hasVagina()) {
		output("You sink to the ground, assuming a position that feels all too natural to you now, leaning forward to let your [pc.fullChest] hang down slightly. The imp looks you up and down, wickedly eyeing your ready, slightly open lips. He drops his loin-cloth to reveal a hardening [enemy.cockNounComplex]. Your eyes bulge as it grows larger... and larger... and larger! The imp's [enemy.cock] finally bulges to a full twelve inches... and it's moving closer. You struggle to think... but you just can't! You want that in your mouth, like, so bad!\n\n");
		output("Your [pc.vagina] drips in anticipation, and you find yourself involuntarily moving your knees farther apart to prepare yourself to be filled. He smiles and presses his cock against your [pc.vagina], pushing you back to get a better angle. You try to make words, but your brain can only think of so much at once! Right now, it's thinking of cock, which, naturally, makes you open your mouth and let out a slutty moan.\n\n");

		output("The imp pushes into you violently, ramming his [enemy.cock] in to the hilt, leaving you gasping in pain and surprise. He leaves it in your slutty pussy, giving you a second to... oh who is he kidding... he can tell by your air-headed look that you've done nothing but take cocks your whole life. He fucks you hard, slapping your [pc.ass] to remind you who is in charge. You can't help but think about, like, how you just love it when a man takes charge. Less thinking!");
		pc.cuntChange(0, enemy.biggestCockVolume(), true, false, true);
		output("\n\n");

		output("The rough fucking becomes more and more pleasurable as time goes on. You moan air-headedly with each thrust, hips squeezing around the [enemy.cock], loving the feeling of his fullness. Before long you can't help but cum all over him, your vagina locking around his cock like a vice, muscles rippling, milking him for his cum. The imp's prick explodes inside you, pumping huge loads of hot demon-seed inside you with each eruption. You swoon, feeling it fill your womb and distend your belly as the imp's orgasm fills you with insane amounts of cum.\n\n");

		output("With a sigh, he pulls his [enemy.cock] free, and you flop down, cum leaking out onto the ground from your well-fucked hole. If you could, like, focus at all, you'd totally be worrying about being, like, pregnant or whatever. But you lose consciousness.");
		pc.loadInCunt(enemy);
		pc.libido(1);
		pc.cor(1);
		processTime(25 + rand(10));
		pc.orgasm();
		CombatManager.genericLoss();
		return;
	}
	//Lust loss
	if(pc.HP() > 1) {
		//50% chance of sprocket rape for super-thick people. 
		if(pc.hasCock() && rand(2) == 0 && pc.cocks[pc.thickestCock()].thickness() >= 4 && enemy.bodyStrength() > enemy.fullBodyWeight() + pc.fullBodyWeight()) {
			sprocketImp();
			return;
		}
		//Female or Futa
		if(pc.hasVagina()) {
			output("You sink to the ground, too overcome by lust and desire to fight.  The imp smiles, a wicked look glinting in his eyes.  He drops his loincloth to reveal a hardening [enemy.cockNoun].  Your eyes bulge a bit as it grows...and grows...and grows!  That imp has a twelve inch [enemy.cock]..and he's walking towards you.   Your [pc.vagina] practically juices itself in anticipation, and you find yourself spreading your [pc.legs] in preparation.");
			output("\n\nHe smiles and presses his [enemy.cock] against your [pc.vagina].  Your lust-driven mind is speechless, leaving you panting and moaning like a whore.");
			//If too big, only partly penetrate.
			if(pc.vaginalCapacity() < enemy.cockVolume(0)) {
				if(pc.vaginas[0].hymen)
					output("  He plunges in hard, breaking your hymen and stealing your virginity.  A look of surprise crosses his face, chased away by ecstasy.  If you had a rational bit left in your mind, you'd notice he looks... stronger somehow, but you're too horny to care.");
				else
					output("  He pushes against your tight little pussy, struggling to penetrate you.");
				output("  His [enemy.cock] only sinks a few inches in, but he begins fucking you hard, each time claiming a bit more of your pussy for his demonic tool.  You feel a painful stretching as he gets half of it inside you, ruining your [pc.vagina] for most humans.  He fucks you like this for what seems like forever, never getting much further. ");
			}
			else
				output("  He plunges in violently, ramming his [enemy.cock] in to the hilt, leaving you gasping in pain and surprise.  He leaves it there, giving you a second to get used to him, and then begins fucking you hard, slapping your [pc.ass] every few thrusts to remind you who is in charge.");
			pc.cuntChange(0, enemy.cockVolume(0), true, true, true);
			
			if(pc.hasCock()) output("\n\nThe rough fucking becomes more and more pleasurable as time passes, until you cannot help but stroke your [pc.cock] along with each plunge he takes in your [pc.vagina].  You feel yourself clench around him as your sexual organs release, erupting spurts of [pc.cum] and milking the demon's cock like your life depended on it.");
			else output("\n\nThe rough fucking becomes more and more pleasurable as time passes.  You moan loudly and lewdly with each thrust, hips squeezing around the demon-cock, relishing the feeling of fullness.  Before long you cannot help but cum all over him, [pc.vagina] locking around his cock like a vice, muscles rippling, milking him for his cum.");
			output("  The imp's [enemy.cock] explodes inside you, pumping huge loads of hot demon-seed inside you with each eruption.  You swoon, feeling it fill your womb and distend your belly as the imp's orgasm fills you with an unnatural quantity of corrupted semen.\n\nWith a sigh, he pulls his [enemy.cock] free, and you flop back on your back, cum surging out onto the ground from your well-fucked hole.  ");
			if(pc.isPregnant(0)) {
				output("You wonder what this will do to whatever is growing in your womb...  ");
			}
			else {
				if(pc.hasStatusEffect("Heat")) output("You find yourself hoping you're pregnant as you swiftly lose consciousness.");
				else if(!pc.isPregnant(0)) {
					if(pc.cor() > 75) output("With an appreciative moan, you bury your fingers in its slimy warmth, hoping you are pregnant with some fiendish offspring, and lose consciousness.");
					else output("You hope you don't become pregnant, but promptly lose consciousness before you can contemplate the prospect any further.");
				}
			}
			pc.loadInCunt(enemy);
			pc.libido(1);
			pc.lust(1);
			pc.cor(1);
		}
		//Male or genderless
		if(!pc.hasVagina()) {
			//Alternate male-only case
			if (pc.hasCock() && rand(2) == 0) {
				output("Your eyes glaze over with lust as the imp's dark magic destroys your will to continue fighting. You sink to your ");
				if(pc.isTaur()) output("knees, your [pc.cock] hurting from the massive blood pressure caused by your unbridled lust. He approaches you and stops about two feet in front of you, watching with delight your helpless state");
				else output("knees, pull out your [pc.cock] and begin mindlessly stroking yourself as the imp approaches you, a wicked grin on his face. Your mind races with thoughts and images of sucking the imp's cock. He approaches you and stops about two feet in front of you, watching with delight as you succumb to your own lust");
				output(". Your eyes glance down to his waist and see a massive bulge form under his loincloth, the sight of which causes your [pc.cock] to twitch and begin leaking pre-cum.\n\n");
				output("The imp drops his loincloth, revealing his huge 12-inch penis, and then forcefully grabs your head and pulls you down on to his hard throbbing [enemy.cock]. He shoves his [enemy.cockHead] past your lips and deep down your throat in one slow, forceful push. You can barely accommodate his huge cock, and yet your lust makes you hunger for more. You cough and gag while the imp proceeds to fuck your mouth hard, slapping his hot balls against your chin, disregarding your need to breathe.  ");
				if(pc.isTaur()) output("Dropping down to the ground, your [pc.cock] trembles against your body to the rhythm of the imp's thrusts, leaving your underbelly smeared with its own pre-cum.\n\n");
				else output("On all fours now, your [pc.cock] bounces up and down against you to the rhythm of the imp's thrusts, leaving your belly smeared in your own pre-cum.\n\n");
				if(pc.balls > 0 && pc.ballSize() >= 5) output("Your [pc.balls] swing heavily against you as well, responding to the force of the imp's thrusts, slapping your own ass and driving your [pc.cock] even stiffer with lust, the pre-cum pulsing out of your cock in time with the slapping.\n\n");
				output("You begin to feel light-headed from lack of air just as the imp grips your head firmly and begins making rapid, shallow thrusts down your throat, nearing his orgasm. Suddenly he clenches tight, his claws digging into your head and thrusts down your throat as far as he can, holding his [enemy.cock] deep in your stomach. Your eyes go wide as you feel the imp's balls on your chin spasm violently.  His cock pulses in your mouth as the thick demon cum is pumped violently down your throat. It feels like an eternity as the imp continues to fill your guts with his hot cum, his orgasm lasting far longer than any human's. ");
				pc.loadInMouth(enemy);
				output("He slowly withdraws his still-pumping [enemy.cock] from you, coating your throat and then mouth with an almost continual spray of his unnaturally hot and sticky demon seed. The imp pulls out of your mouth just in time to splatter your face with his cum before his orgasm stops, coating your lips, nose, eyes, and [pc.hair] with his incredibly thick and sticky cum.\n\n");
				output("You fall to the ground gasping, exhausted and unable to move, the demon cum on your [pc.face] and inside you still burning with intense heat and corruption. You lose consciousness, your [pc.cock] still firmly erect, your lust not sated.");
				pc.lust(20);
				pc.cor(1);
				processTime(25 + rand(10));
				CombatManager.genericLoss();
				return;					
			}
			else {
				output("You sink to the ground, too overcome by lust and desire to fight.  The imp smiles and circles you, dropping his loincloth as he goes.  You are roughly shoved to the ground, your backside slapped hard.  You're too horny to do anything but moan from the pain ");
				if(!pc.isTaur() && pc.isCrotchGarbed()) output("as you are disrobed");
				output(".  As the imp presses a large bulk against your backside, you realize he has a massive penis!\n\nThe imp pushes his [enemy.cock] into your ass and fucks you hard, with little regard to your pleasure.  After a rough fucking, he cums, stuffing your ass full of hot demon cum.  His orgasm lasts far longer than any human's, leaving your belly slightly distended.");
				pc.buttChange(enemy.cockVolume(0), true, true, true);
				pc.loadInAss(enemy);
				pc.libido(1);
				pc.lust(1);
				pc.cor(1);
				processTime(25 + rand(10));
				if(pc.libido() > 40) {
					output("  You manage to orgasm from the feeling of being filled by hot cum.");
					if(pc.hasCock()) output("  You jizz all over the ground in front of you, spraying cum in huge squirts in time with the demon's thrusts.");
					pc.orgasm();
					pc.cor(1);
				}
				output("\n\nYou drop to the ground when he's done with you, cum spilling from your abused ass all over the ground, too exhausted to move.  Consciousness fades.  ");
				CombatManager.genericLoss();
				return;
			}
		}
	}
	//HP or insta-loss
	else {
		output("<b>You fall, defeated by the imp!</b>\n\nThe last thing you see before losing consciousness is the creature undoing its crude loincloth to reveal a rather disproportionately-sized [enemy.cock].");
		pc.buttChange(enemy.cockVolume(0));
		pc.loadInAss(enemy);
		pc.cor(1);
	}
	processTime(25 + rand(10));
	pc.orgasm();
	CombatManager.genericLoss();
}

//noogai McNipple-holes
private function noogaisNippleRape():void {
	clearOutput();
	output("You slowly walk over to the masturbating imp, your [pc.hips] and [pc.butt] swaying suggestively with every step.\n\n");
	
	output("Shedding your [pc.gear] you push the imp to the ground and straddle him, keeping his hands away from his twitching [enemy.cock] while you quickly tie him up with his own loincloth.  The lust-addled demon utterly incapacitated, you start to use both of your hands to toy freely with your slimy nipple-holes, as well as your ");
	if(pc.hasCock()) output("[pc.cock]");
	if(pc.hasCock() && pc.hasVagina()) output(" and ");
	if(pc.hasVagina()) output("[pc.vagina]");
	if(!pc.hasGenitals()) output("[pc.asshole]");
	output(".\n\n");
	
	output("You gently insert a single digit into one of your nipple-cunts, ");
	if(pc.lactationQ() >= 1000) output("unleashing a torrent of [pc.milk] and ");
	//(if regular milky; 
	else if(pc.lactationQ() >= 50 && pc.isLactating()) output("releasing a steady trickle of warm [pc.milk] and ");
	output("lust-induced sex juice onto the imp's lap; your other hand instinctively moves down to stroke your ");
	//((if male/herm; 
	if(pc.hasCock()) {
		output("[pc.cocks]");
		if(pc.hasVagina()) output(" and ");
	}
	if(pc.hasVagina()) output("[pc.vagina]");
	if(!pc.hasGenitals()) output("[pc.asshole]");
	output(", teasing him with a lewd moan as your head rolls back in sexual ecstasy.");
	if(silly) output("  The imp is sickened, but curious.");
	
	output("\n\nYou continue finger-fucking your [pc.nipple], becoming more and more aroused as the imp gets harder and harder from watching the exotic display before him.  You soon tire of watching the imp squirm beneath you, desperate for sexual relief; you slowly move your hand away from your groin, reaching down towards his crotch, and start to toy with his apple-sized balls, fondling and squeezing them roughly.  You casually slip a second finger into your [pc.nipple], stretch it out teasingly, and hold the gaping orifice in front of the imp's face, giving him a good view of the inside of your freakish, wet nipple-cunt.\n\n");
	
	//(If corrupt: 
	if(pc.cor() >= 66) {
		output("\"<i>Mmm, wouldn't you just love to stick your [enemy.cockNounComplex] into this sopping wet hole, and cum deep inside my [pc.breast]?</i>\"  You whisper huskily into his ear, sliding your fingers away from his balls and up along the underside of his aching dick, teasing every inch of it until you reach his swollen head and start rubbing your finger around his glans in small circles.  The imp is panting heavily, his eyes firmly locked on your [pc.nipple], bucking his hips upwards in desperation.\n\n");
	}
	output("Deciding that the poor bastard has suffered enough, you guide your stretched [pc.nipple] down to his quivering member and hold it over the tip for a moment.  The imp groans in frustration, feeling the heat of your slutty juices dripping down onto his aching rod and overfull testes, making him even more desperate to drive deep into your waiting breast.  Without warning, you forcefully shove your breast onto his swollen fuckstick, ");
	if(pc.biggestTitSize() <= 4) output("bottoming out halfway on his immense dick.");
	else output("only stopping when the flesh of your immense mammary bumps into his quaking ballsack.");
	output("\n\n");

	output("You shudder in ecstasy as you rise off of his drenched girth; your nipple-hole is slick with arousal, making it easier for you to slide back down until ");
	//((if breast size below D) 
	if(pc.biggestTitSize() <= 4) output("you feel his swollen cock bottom out, your petite breast unable to swallow any more of his throbbing maleness");
	//((over D) 
	else output("his swollen cock and desperately filled balls are entirely engulfed in tit-flesh");
	output(".  Eventually the imp starts timing his thrusts with your movements, and soon the two of you are working in a steady rhythm - thrust, retract, thrust, retract.  Minutes go by as the rhythm slowly builds towards a crescendo, with the only sounds being the lewd schlicking noise of your breast servicing the imp's rod, and the odd moan escaping your lips.  While one hand is furiously jilling off your vacant nipple-slit, the other one is furiously");
	//[(if male)
	if(pc.hasCock()) output(" pumping your [pc.cock]");
	//(if female)
	else if(pc.hasVagina()) output(" fingering your hungry baby tunnel");
	else output(" fingering your tingling anus");
	output(".\n\n");

	output("Eventually the rhythm becomes more sporadic as you and the imp approach climax; your [pc.tongue] rolls out of your open mouth and your [pc.toes] curl as you feel the imp spasm violently inside you, letting an endless stream of his searing spunk pour directly into your [pc.chest].  The intense heat pushes you over the edge and ");
	//(if dick)
	if(pc.hasCock()) {
		output("a ");
		//[(cum production < 500ml)
		if(pc.cumQ() < 500) output("jet ");
		//(cum production 500-1000ml)
		else if(pc.cumQ() < 1000) output("geyser ");
		//(cum production > 1000ml)
		else output("volcano ");
		output("of [pc.cum] sprays from your [pc.cocks] and splatters over both you and the hapless imp");
		if(pc.hasVagina()) output(", while ");
	}
	if(pc.hasVagina()) {
		output("your pussy juices spurt out as your [pc.vagina] twitches in orgasm");
	}
	if(!pc.hasGenitals()) output("your [pc.asshole] clenches tight on your finger");
	output(".\n\n");

	output("You collapse heavily on top of the imp, once again impaling your breast on his still-erect cock.  You lie like this for a few moments until you notice that the imp has dozed off, exhausted by the whole ordeal.  You stand up woozily as a mixture of ");
	//(if lactating) 
	if(pc.isLactating() && pc.lactationQ() > 40) output("[pc.milk], ");
	output("fem-spunk and hot demon cum leaks out from your gaping nipple-cunt.\n\n");

	//(if corruption > 60)
	if(pc.cor() > 60) output("You thrust your digits into your [pc.nipple] once more, scooping out as much imp jizz as you can reach.  You happily drink up the thick goo, savoring the cloying taste before quickly getting dressed and leaving the imp to slumber.");
	//(continue to non-corrupt text)
	//(if not)
	else output("You quickly get dressed and leave the imp to his slumbering, his hands still tied together by his loincloth.");
	//Gain xp and gems here
	pc.cor(1);
	processTime(15);
	pc.orgasm();
	CombatManager.genericVictory();
}

////IMP WARLORD
//public function impWarlordEncounter():void {
	//clearOutput();
	//output("A large corrupted imp crosses your path.  He is wearing armor, unlike most of the imps.  He is also wielding a sword in his right hand.  He flashes a cruel smile your way.  No way around it, you ready your " + pc.weaponName + " for the fight.");
	//flags[kFLAGS.TIMES_ENCOUNTERED_IMP_WARLORD]++;
	//startCombat(new ImpWarlord());
	//if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
		//flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
		//output("\n\n<b>New codex entry unlocked: Imps!</b>")
	//}
	//doNext(pcMenu);
//}
//
////IMP OVERLORD
//public function impOverlordEncounter():void {
	//clearOutput();
	//output("A large corrupted imp crosses your path but he is no ordinary imp.  Glowing veins line his body.  He is clad in bee-chitin armor and he's wearing a shark-tooth necklace.  He is also wielding a scimitar in his right hand.  He must be an Imp Overlord!  He flashes a cruel smile your way.  No way around it, you ready your " + pc.weaponName + " for the fight.");
	//flags[kFLAGS.TIMES_ENCOUNTERED_IMP_OVERLORD]++;
	//startCombat(new ImpOverlord());
	//if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
		//flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
		//output("\n\n<b>New codex entry unlocked: Imps!</b>")
	//}
	//doNext(pcMenu);
//}

//private function putBeeEggsInAnImpYouMonster():void {
	//clearOutput();
	////IMP EGGS
	////(functions for bipedal bee morphs.  At time of writing, unsure as to whether bee abdomen worked for centaur/naga/goo forms)
	//output(images.showImage("imp-egg"), false);
	//output("You glance down at the masturbating imp, feeling a twitch in your swollen, insectile abdomen.  As the red-skinned homunculus writhes on the ground, beating his meat, you smile, feeling a globule of sweet nectar oozing out of your ovipositor.");
	//
	//output("\n\nHeвЂ™s too busy humping the air and stroking himself to notice you hooking the tip of one of your [feet] under him.  You kick up one of your [legs], flipping the fapping imp over.  He gasps as he lands face-down on the ground, startled enough to stop jerking his tool.");
	//output("\n\nYou grin, straddling his surprisingly perky ass, resting your [hips] on his small, round cheeks.  With your arms pinning down his shoulders, he canвЂ™t stroke himself, and he whimpers at the restraint.");
	//
	//output("\n\n\"<i>Wait - whatвЂ™s going on?</i>\" he gasps.");
//
	//output("\n\nYou deign not to answer him, lost in the unique sensation of your abdomen curling behind you.  You toss your head back, luxuriating in the pleasure of your black ovipositor emerging against smooth, glossy skin of the impвЂ™s ass.");
	//
	//output("\n\n\"<i>No, nooooooo...</i>\" whimpers the imp as you bite your lip, pushing the tip of your organ into his surprisingly pliant hole.");
	//
	//output("\n\nYou and the imp shudder in tandem as your sweet honey smears between his cheeks, oozing down his crack as you squeeze your throbbing ovipositor further and further into him.  Buried deep in his bowels, you feel the first of your eggs push through your rubbery organ, stretching out your tube along with his asshole.");
	//
	//output("\n\nAs you lay your first egg inside the imp, he gurgles, face-down against the ground, and you feel him tighten around your ovipositor.  The imp wriggles beneath your body and by the slowly-spreading pool of steaming cum; you guess that he just climaxed.");
	//
	//output("\n\nThe imp pants, trying to catch his breath as you twitch your abdomen, adjusting your ovipositor inside him.  Before he can recover, you push another egg down your tube, implanting it deep in the imp alongside the first egg.");
	//
	//output("\n\n\"<i>Suh-stop...</i>\" groans the imp even as you push a third egg into his tiny body.  But youвЂ™re beyond stopping.  Egg after egg, you fill his twitching body.  The pool of cum grows, and it oozes around your ");
	//if(pc.isGoo()) output("rippled goo edges");
	//else if(pc.isNaga()) output("trembling coils");
	//else output("straddling knees");
	//output(" as you turn the imp into your own, private incubator.");
	//
	//output("\n\nAfter a handful of eggs, you grunt, realizing that youвЂ™ve run out of room inside the imp.  Tilting your head to one side, you consider that the imp is face-down, and that his stomach might need more room to stretch.  You rise halfway up and flip him over beneath you, careful to leave your ovipositor still buried inside him.");
	//
	//output("\n\nThe impвЂ™s eyes are almost completely rolled back in his head, his flat chest smothered with his own spunk.  His breathing is ragged, and his hard, massive cock is slathered with thick, white cum.  His belly already bulges slightly with your eggs and his small hands move to clutch at his stomach, giving him the look of a debased, pregnant mother.");
	//
	//output("\n\nThat realization is enough to stimulate your ovipositor again.  With a groan, you plant your hands on the ground to either side of his head, on your knees as your ovipositor pumps another egg into the impвЂ™s bowels.  The imp shudders as his belly swells, filling with your brood.");
	//
	//output("\n\n\"<i>More... more!</i>\" moans the imp beneath you.  You oblige, and ");
	//if(pc.biggestTitSize() >= 1) {
		//output("his tiny claws grab your ");
		//if(pc.bRows() > 1) output("first row of ");
		//output(breastDescript(0) + ", squeezing your tits as you fuck him full.");
		//if(pc.lactationQ() >= 500) output("  Rivulets of your milk run down his forearms as he inexpertly milks you.");
	//}
	////[If cock: 
	//else if(pc.hasCock()) output("the rise of his swollen belly soon presses against [oneCock] and the rhythm of your thrusts strokes his shiny red stomach against your sensitive organ.");
	//else if(pc.hasVagina()) output("the impвЂ™s tiny, clawed feet scrabble against you as he flails in pleasure.  By mistake, one slips between the lips of your pussy, small toes wriggling against your inner walls, and you instinctively push down against the small limb, fucking yourself with his foot.");
	//else output("you feel a firm pressure at your [asshole] as the tip of the impвЂ™s lashing tail prods frantically against you, manically shoving in and out of your [asshole].");
	//
	//output("\n\nYou groan, climaxing against the imp, just as he lets out another gout of hot seed from his cum-smeared dick.  He spatters your front, his spunk mingling with your fluids, shuddering as he takes the last of your eggs inside him, his belly swollen to the size of a beach ball.");
	//
	//output("\n\nYou pant heavily, and with a messy squelching, you pull yourself out of the imp, pushing yourself up from your crouched position.  A gush of honey pours from the impвЂ™s ass, cutting off quickly as an egg rolls into place from the inside, stopping up your imp-cubator.");
	//
	//output("\n\nYou hear a strange noise from the imp, one that sounds strangely like a giggle.  You glance down at him, instinctively evaluating him as a bearer of your eggs.  The imp is still panting, looking up at you from under his messy, black hair.  With a flushed, submissive expression and swollen, pregnant belly, the imp seems almost... cute?  He cradles his massive, egg-filled belly, caressing it, then looks back to you, blushing.");
//
	//output("\n\nYou blink then stand up.  You shake your head as you walk away, chalking the odd thoughts up to your egg-laying instincts.  Some of these mutations have some weird effects, after all...");
	//pc.orgasm();
	//dynStats("sen", -1);
	//pc.dumpEggs();
	//cleanupAfterCombat();
//}

//public function loseToAnImpOverlord():void {
	//clearOutput();
	//if(pc.hasVagina() && (pc.gender == 2 || rand(2) == 0) && flags[kFLAGS.SFW_MODE] <= 0) getRapedAsAGirlByImpOverlord();
	//else if(pc.hasCock() && flags[kFLAGS.SFW_MODE] <= 0) loseToImpOverlord();
	//else {
		//output("Taking a look at your defeated form, the " + monster.short + " snarls, \"<i>Useless,</i>\" before kicking you in the head, knocking you out cold.");
		//pc.takeDamage(9999);
		//cleanupAfterCombat();
	//}
//}

//private function loseToImpOverlord():void {
	//clearOutput();
	//if (doSFWloss()) return;
	//output(images.showImage("impoverlord-loss-male"), false);
	//output("Unable to control your lust you fall to the ground, remove your " + pc.armorName + " and begin masturbating furiously.  The powerful imp saunters over to you smirking evilly as he towers over your fallen form. You look up at him nervously.  He grabs your chin with one of his clawed hands, while the other digs through his satchel.  He pulls out a vial filled with glowing green liquid, and pops the cork stopper off with his thumb. Before you can react, the demon forces open your mouth and pours the liquid in.  Instinct reacts fast then logic and you swallow the substance as it's poured down your throat.");
	//output("\n\nYou cough and splutter, grabbing your gut, as a hot pain fills your stomach.  The imp laughs as you roll around in agony for several long moments, before the burning turns to an arousing warmth that spreads to your [hips] and [asshole].  Groaning, you feel your cheeks flush with arousal, and your eyes glaze over once more with insatiable lust.");
	//if(pc.cockTotal() == 1) {
		//output("\n\nYou feel your " + cockDescript(0) + " grow harder than usual and throb.  You go to stroke yourself but it's far too sensitive. Any stroking you can do is far too little stimulation and anything else is too painful to withstand.  You whimper and curse in desperation.  Your lust clouded mind can only think of one solution; you bend over and reveal your [asshole] to the grinning imp.  The humiliation keeps you from looking back to see the imp's reaction, but you can tell by his chuckle that this is exactly what he wanted.");
	//}
	//else if(pc.cockTotal() > 1) {
		//output("\n\nYou feel your " + multiCockDescriptLight() + " grow harder than usual and throb.  You go to stroke yourself but they are far too sensitive. Any stroking you can do is far too little stimulation and anything else is too painful to withstand.  You whimper and curse in desperation.  Your lust clouded mind can only think of one solution; you bend over and reveal your " + assholeDescript() + " to the grinning imp.  The humiliation keeps you from looking back to see the imp's reaction, but you can tell by his chuckle that this is exactly what he wanted.");
	//}
	//output("\n\nThe imp gets behind you; his corrupt presence makes the air feel heavy and hard to breathe.  You notice his satchel and loincloth get carelessly tossed to the ground.  Chancing a glance back, you look in aroused horror at the " + monster.cockDescript(0) + " between the imp's legs as well as his matching cum-filled balls.  Two clawed, red hands spread your [butt] revealing your [asshole].  Mercifully, the demon decides you'll need some form of lubrication and relaxation before he continues.  He leans forward and presses his tongue between your [butt] and begins lapping at your [asshole] viciously.  You can't help but mewl from the merciless attack on your tender rectum.");
	//
	////if(pc has a vagina)
	//if(pc.hasVagina()) {
		//output("\n\nThe imp takes a moment to pleasure your [vagina], forcing his tongue and two clawed fingers inside.  The claws scratch and tease painfully at your inner walls.  You mewl and cry out from the stimulation, as the imp's tongue moves from your [vagina] to your [clit].  You cry out in desperation as the powerful demon attacks your [clit] with his tongue.");
	//}
	//else if(pc.balls > 0 && pc.hasCock()) {
		//output("\n\nThe imp moves away from your [asshole], and begins to focus on your [balls].  He pulls one into his hand, and squeezes it cruelly while he licks and bites at your [sack].  He gives a painfully tight squeeze to the orb in his hand, which makes you cry out in painful ecstasy.  A single bead of precum gets forced out of your " + cockDescript(0) + ".");
	//}
	//output("  You watch as the imp stands up and removes his loincloth to reveal his demonic member.  He doesn't even have to remove his armor!");			
	//output("\n\nThe imp finally backs off from his brutal attack on your sensitive backside.  Whatever was in that vial has made your body incredibly sensitive... each caress feels like an orgasm, and each scratch feels like a stab wound.  You hope that's the only effect of the green liquid, but don't get much chance to ponder it as you feel the muscular demon press the head of his " + monster.cockDescript(0) + " against your [asshole].");
	//
	//output("\n\nYou whimper in fear as you look back towards the devilish imp behind you.  He simply grins at you in response as he thrusts forward.  You yell out in pain as the " + monster.cockDescript(0) + " forces its way into your [asshole].  You try to struggle away, but the imp gives you a very rough slap on the ass.  He then roughly grabs your [hips], making sure to dig his claws in just enough to deter you from struggling.");
	//pc.buttChange(monster.cockArea(0),true,true,false);
	//
	//output("\n\nThough the entry was rough, the imp's thrusts are incredibly gentle.  He carefully thrusts in and out of your [asshole], and even begins licking and delicately kissing your back.  The horrible stretching of your [asshole] is still incredibly painful, but made tolerable by the contrasting caresses.  You quickly lose track of time as the pain and pleasure spark across your overly sensitive body.  The imp continues to be oddly affectionate now that you've fully submitted to his will.  He even releases his painful, clawed grip on your [hips].");
	//
	//output("\n\nAfter longer then you'd have hoped for, the painful stretching sensation begins to disappear; and the pleasurable sensation of the imp's " + monster.cockDescript(0) + " thrusting in and out of your [asshole] becomes entirely pleasurable.  The way his " + monster.cockDescript(0) + " fills every inch of your ass, and rubs all your most sensitive spots.  The weird sensation his warm, demonic pre-cum coats your insides.  You find your lust-blinded mind has become lost in the sensations - so lost that you don't even notice the imp increasing his pace.");
	//
	//output("\n\nWithin moments the beast is wildly thrusting in and out of your [asshole].  Pre-cum is pumping out of his " + monster.cockDescript(0) + " like a faucet. The hot demon pre begins to spill back out of your abused [asshole], coating your [hips], and dripping to the ground beneath.  The imp gives you a few more rough thrusts before cumming hard into your [asshole].  The little demon's " + monster.cockDescript(0) + " spasms as he continues to roughly thrust and pump you full of his burning hot demon seed.");
	//
	//if(pc.hasCock()) {
		//output("\n\nThe hot seed filling your belly wakes you from your lust induced daydream and you howl in discomfort.  Your belly begins to swell with the thick seed, coating every inch of your insides with the burning, arousing sensation.  This pushes you over the edge and you orgasm.  ");
		//if(pc.balls > 0) output("Your [balls] clench up against your body, desperate to finally expel their contents.  ");
		//output("Your seed spills across the ground, mixing with the copious amount of demon pre that had sloshed to the ground earlier.  You howl loudly in pleasure, as you're finally given release.");
	//}
	//
	//output("\n\nThe imp pulls out, but is quick to stuff a soft unknown object into your [asshole] to plug all of his delicious, corrupt seed inside of you.  You stay in position, though you're wobbling slightly from the intense experience.  The short, muscular demon looks down at you, and you look up at him concerned.  He chuckles, \"<i>Don't worry my bitch, that thing will dissolve on its own in a day or so,</i>\" the demon assures you.  He grips his " + monster.cockDescript(0) + ", which is soaked with his own juices, and holds it out towards you.");
	//
	//output("\n\nYou take the hint and nervously lick the cock clean.  You can taste the corruption, and it sends sparks through your mind.  You almost wish it didn't have to end, but soon the imp is satisfied with your cleaning job, gathers his things and turns to leave you to recover from your ordeal.  Within minutes of him leaving you pass out, collapsing to the ground.  You lay there, in a puddle of sexual fluids for a long time before you wake up.  After gathering your equipment, you begin to make your way back to camp.  Hopefully that green stuff's effects will have worn off once you get back.");
	//pc.orgasm();
	//dynStats("sen", 2, "cor", 1);
	//pc.slimeFeed();
	//cleanupAfterCombat();
//}

//FEMALE LOSE
//private function getRapedAsAGirlByImpOverlord():void {
	//clearOutput();
	//if (doSFWloss()) return;
	//output(images.showImage("impoverlord-loss-female"), false);
	//output("You collapse from exhaustion, your [vagina] beginning to soak your [armor].  You groan loudly, desperately trying to continue the fight, or flee, but the exhaustion is too much.  You close your eyes for a moment, but hearing a loud thud near your face causes you to painfully open your eyes.  You see a large bestial hoof near your face, while the other hoof is used to roll you onto your back.");
	//
	//output("\n\nYou try to move, but before you can even begin to squirm a hoof presses hard between your " + breastDescript(0) + ".  You gasp as the air is temporarily knocked out of your lungs.  The demon chuckles at your last feeble attempt to free yourself.  He holds his " + monster.cockDescript(0) + " stroking it lewdly, a cruel smirk stretching across his face.  You watch as several beads of pre begin to drip from his tip onto your stomach.");
	//
	//output("\n\nThe imp steps between your legs, gently kicking them apart, until the wet spot on your [armor] is painfully obvious.  He chuckles, and leans down, ripping your [armor] off.  He casually tosses it to the side, and leans towards your [vagina].");
	//
	////if(pc has balls)
	//if(pc.balls > 0) {
		//output("\n\nThe imp pulls your [balls] up, revealing your [vagina].  Unceremoniously, he presses his lips towards your crotch forcing his tongue into your [vagina], making you gasp in pleasure.  He gives your [balls] a rough squeeze, making your [vagina] even wetter then it was.  The imp moans in delight, licking up all your girl juices.");
	//}
	//else {
		//output("\n\nThe imp roughly forces his tongue into your [vagina] making you gasp in pleasure.  Your [vagina] clenches around the demonic tongue, squirting some of your girl juices around the wet flesh as it delves deeper into you.  You writhe and squirm trying to fight against the forced pleasure.");
	//}
	//
	//output("\n\nYou mewl pitifully as the imp removes his tongue. He smirks at your [vagina] and kneels"); 
	//if (pc.isBiped()) output(" between your legs");
	//else output(" before you");
	//output(", draping his " + monster.cockDescript(0) + " across your wet crotch.  You groan, and unintentionally thrust against the magnificent tool between your legs.  The imp chuckles evilly as you coat his " + monster.cockDescript(0) + " in your girl juice, but he doesn't wait long before he slowly presses his head down against your [vagina].  His head slowly spreads your lips; the pleasure is unmistakable, and forces a loud moan from your lips.");
	//
	//output("\n\nWith a soft pop, the " + monster.cockDescript(0) + " pops into your [vagina], and both of you moan in unison, the demon beginning to thrust wildly into you.  His hips pumps back and forth into you.  The loud slapping sound of flesh on flesh echoes around you, drowning out the grunts of the vicious demon above you.");
	//pc.cuntChange(monster.cockArea(0),true,true,false);
	//
	//output("\n\nYou mewl softly as you're viciously fucked by the beast above you.  It doesn't take long before your [vagina] clenches tightly around the " + monster.cockDescript(0) + " as you orgasm.  You scream in pleasure as your inner walls begin to milk the imp's " + monster.cockDescript(0) + " of its seed.  The imp quickly succumbs and cums, his swollen balls tightening up against his crotch.  The hot jizz continues to pump into you for what feels like several painfully long minutes, until your belly bulges slightly, and your " + vaginaDescript(0) + " begins to leak the white demonic fluid.");
	//
	//output("\n\nThe imp pulls out, and gives himself a few final strokes, sending one last shot of cum across your face.  You blush in embarrassment and wipe the sticky seed from your nose and lips.  Standing up, the imp presses a hoof down hard on your distended stomach, making you gasp loudly as the demon's thick cum is forced back out of your [vagina], pooling between your legs. The imp gives a satisfied smirk and flies off, leaving you to clean up.");
	//
	//output("\n\nYou stand up weakly after several moments, and gather your [armor].  It takes you a while to get dressed in your defeated state, but you manage to crawl back towards your camp.  Your [vagina] is still leaking some of the demonic cum, but you try not to worry about it as you arrive, collapsing almost immediately.");
	//pc.orgasm();
	//dynStats("cor", 1);
	//pc.slimeFeed();
	//cleanupAfterCombat();
//}

//private function killImp():void {
	//clearOutput();
	//flags[kFLAGS.IMPS_KILLED]++;
	//output("You make a quick work of the imp before dragging the corpse away. That's one less foul creature prowling the realms. ");
	//if (pc.cor < 25) dynStats("cor", -0.5);
	//menu();
	//addButton(0, "Take Skull", takeSkull);
	//addButton(1, "Leave", cleanupAfterCombat);
//}
//private function takeSkull():void {
	//inventory.takeItem(useables.IMPSKLL, cleanupAfterCombat);
//}