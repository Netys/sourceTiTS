import classes.Characters.CoC.CoCImpGang;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.PregnancyData;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function giveBirthToImps(pregSlot:int):void
{
	clearOutput();

	var pData:PregnancyData = pc.pregnancyData[pregSlot] as PregnancyData;
	
	//Add imp birth status - used to control frequency of night imp gangbag
	//actually handled by pregnancy engine
	
	if (!pc.hasVagina(pregSlot)) {
		pc.createVagina();
		pregSlot = pc.vaginas.length - 1; // failsafe
		output("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a [pc.vagina " + pregSlot + "].");
		output("\n\n");
	}
	output("A sudden gush of fluids erupts from your vagina - your water just broke.  You grunt painfully as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards.  ");
	if (pc.cor() < 50) output("You rue the day you encountered that hateful imp.  ");
	output("The pain begins to subside as your delivery continues... replaced with a building sensation of pleasure.  Arousal spikes through you as the contractions intensify, and as you feel something pass you have a tiny orgasm.");
	output("\n\nYet you feel more within you, and the contractions spike again, pushing you to orgasm as you pass something else.  It repeats, over and over, nearly a dozen times you birth and orgasm.  After an eternity of procreation and pleasure, you sense your ordeal is over and collapse, unconscious.");
	
	if (pc.vaginas[pregSlot].looseness() <= 2) pc.vaginas[pregSlot].looseness(1);
	//50% chance
	if (pc.vaginas[pregSlot].minLooseness < 4 && rand(2) == 0) {
		pc.vaginas[pregSlot].minLooseness++;
		pc.vaginas[pregSlot].loosenessRaw++;
		output("\n\n<b>Your cunt is painfully stretched from the ordeal, permanently enlarged.</b>");
	}
	
	output("\n\nWhen you wake you find a large number of tiny imp tracks... and a spattering of cum on your clothes and body.  They must be born fully-formed.");
	
	for (var i:int = 0; i < pData.pregnancyQuantity; i++) 
	{
		processTime(4);
		pc.orgasm();
	}
	
	if (pc.canLactate() && pc.milkMultiplier < 100) {
		output("  Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
		pc.boostLactation(10);
	}
	
	//Lactate if large && not lactating
	if (pc.biggestTitSize() >= 1 && !pc.canLactate()) {
		output("  As you ponder the implications, <b>you realize your breasts have been slowly lactating</b>.  You wonder how much longer it will be before they stop.");
		pc.boostLactation(70);
	}
	
	//Enlarge if too small for lactation
	if (pc.biggestTitSize() == 2 && pc.mostBreastsPerRow() > 1) {
		output("  <b>Your breasts have grown to C-cups!</b>");
		Mutator.growTits(pc, 1, 1, false, 3, 3);
	}
	
	//Enlarge if really small!
	if (pc.biggestTitSize() == 1 && pc.mostBreastsPerRow() > 1) {
		output("  <b>Your breasts have grown to B-cups!</b>");
		Mutator.growTits(pc, 1, 1, false, 3, 3);
	}
	
	if (pc.vaginas[pregSlot].wetnessRaw == 0) pc.vaginas[pregSlot].wetnessRaw++;
	
	pc.orgasm();
	applyCumSoaked(pc);
	
	// tou -2
	pc.slowStatGain("r", 2);
	pc.slowStatGain("l", 1);
	// sen +0.5
	pc.cor(7);
	
	if (pc.buttRatingRaw < 10 && rand(2) == 0) {
		pc.buttRatingRaw++;
		output("\n\nYou notice your [pc.ass] feeling larger and plumper after the ordeal.");
	}
	else if (pc.buttRatingRaw < 10) {
		pc.buttRatingRaw++;
		output("\n\nAfter the birth your [pc.gear] fits a bit more snugly about your [pc.hips].");
	}
	
	processTime(4 * 60);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function impNightEvent():Boolean
{
	if (minutes != 0 || !inCamp() || !pc.hasGenitals() || (flags["COC.SLEEP_WITH"] != undefined && flags["COC.SLEEP_WITH"] != "") || flags["COC.IMP_GANG_LAST_ROLL"] == days) return false;
	
	flags["COC.IMP_GANG_LAST_ROLL"] = days;
	
	var temp:Number = StatTracking.getStat("coc/pregnancy/imps birthed") * 2;
	if (temp > 7) temp = 7;
	if (pc.hasPerk("Pierced: Lethite")) temp += 4;
	if (pc.hasStatusEffect("Heat")) temp += 2;
	if (vapulaSlave()) temp += 7;
	
	if (temp <= rand(100)) return false;
	
	switch(hasNightGuard())
	{
		case "":
			eventQueue.push(impGangabangaEXPLOSIONS);
			return true;
		case "Canopy":
			break; // silent one
		case "Kiha":
			eventBuffer += "\n\nYou find charred imp carcasses all around the camp.  It looks like Kiha repelled a swarm of the little bastards.";
			break;
		case "Hel":
			eventBuffer += "\n\nHelia informs you over a mug of beer that she whupped some major imp asshole last night.  She wiggles her tail for emphasis.";
			break;
		case "Jojo":
			eventBuffer += "\n\nJojo informs you that he dispatched a crowd of imps as they tried to sneak into camp in the night.";
			break;
		case "Holli":
			eventBuffer += "\n\nDuring the night, you hear distant screeches of surprise, followed by orgasmic moans.  It seems some imps found their way into Holli's canopy...";
			break;
		case "Kid A":
			eventBuffer += "\n\nYour rest is momentarily disturbed by the sound of tiny clawed feet skittering away in all directions.  When you sit up, you can make out Kid A holding a struggling, concussed imp in a headlock and wearing a famished expression.  You catch her eye and she sheepishly retreats to a more urbane distance before beginning her noisy meal.";
			break;
		default:
			eventBuffer += "\n\nUnhandled camp guardian for imp gang: " + hasNightGuard();
	}
	return false;
}

private function fightImpGang():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCImpGang());
	CombatManager.victoryScene(impGangGetsWhooped);
	CombatManager.lossScene(impGangabangaEXPLOSIONS);
	CombatManager.displayLocation("IMP");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function get impgang():CoCImpGang
{
	if (enemy != null && enemy is CoCImpGang) return enemy as CoCImpGang;
	return new CoCImpGang();
}

public function impGangGetsWhooped():void {
	clearOutput();
	output("With the imps defeated, you check their bodies for any gems.");
	
	output("\n\n");
	processTime(15 + rand(5));
	CombatManager.genericVictory();
}

public function impGangabangaEXPLOSIONS():void {
	//spriteSelect(18);
	clearOutput();
	var loss:Boolean = inCombat();
	if (!loss) output("<b>You sleep uneasily. A small sound near the edge of your camp breaks into your rest and you awaken suddenly to find yourself surrounded by " + impgang.a + impgang.short + "</b>!\n\n");
	if ((Math.sqrt(pc.intelligence() + pc.reflexes()) >= rand(16) || rand(3) == 0 || isNineTails(pc) || pc.hasCombatDrone()) && !loss) {
		output("The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a " + impgang.randomSimpleCockNoun() + " as long and thick as a man's arm, far oversized for their bodies. Watching an imp trip over its " + impgang.randomSimpleCockNoun() + " would be funny, if you weren't surrounded by a horde of leering imps closing in from all sides...");
		output("\n\nYou quickly get up in time to [pc.readyWeapon]! It's a fight!")
		fightImpGang();
		return;
	}
	if (loss) clearOutput();
	//CENTAUR
	if (pc.isTaur()) {
		if (rand(2) == 0 && (pc.cockTotal() == 0 || pc.isHerm())) {
			//(First encounter)
			if (flags["COC.MET_IMP_GANG"] == undefined) {
				output("The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a " + impgang.randomSimpleCockNoun() + " as long and thick as a man's arm, far oversized for their bodies. Watching an imp trip over its " + impgang.randomSimpleCockNoun() + " would be funny, if you weren't surrounded by a horde of leering imps closing in from all sides...\n\n");
				output("The imps leap forward just as you start to [pc.readyWeapon], one sweaty imp clinging to your arm");
				//(If the player has a weapon)
				if (pc.hasWeapon()) output(" while another kicks your weapon out of reach");
				output(".  The " + impgang.short + " surges forward and grapples you. Imps grope your body and hump their " + impgang.randomSimpleCockNoun() + " against your horse legs, smearing their sweat and pre-cum into your [pc.skinFurScales]. The rest of the " + impgang.short + ", a dozen or more imps, all leer at you and laugh as they slap and pinch your body. The imps have sharp claws, tiny sharp teeth, and short horns on their heads. They scratch, claw, and bite at you with all of these weapons as they try to pull you down to the ground. One bold imp leaps forward and grabs your ");
				//(If the player has a cock)"
				if (pc.cockTotal() > 0) output("[pc.cockBiggest]");
				//(If the player has breasts)
				else output("[pc.nipple]");
				output(", twisting and pinching hard enough to make you yelp in pain. An imp leaps up and mounts you, grabbing your " + pc.hairDescript() + " like reins. The long flesh of his " + impgang.randomSimpleCockNoun() + " rubs against the small of your back. The " + impgang.short + " stinks of sweat and pre-cum, its moist grip and obscene smirk leaves you with no doubt as to what they will do to you if you lose this fight.\n\n");
			}
			
			output("The horde drags you to your knees, grappling your [pc.legs] and crawling over your [pc.lowerBody] to pin you down. You try to buck them off but there are too many to fight. The imps drag your arms behind your back, wrapping them around your rider. Another imp whips off his loincloth to reveal his pre-cum drooling " + impgang.randomSimpleCockNoun() + " and tosses the cloth to the imps holding your arms. They quickly tie your arms back with the sweat-damp loincloth.  ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 1) output("Having your arms tied behind your back forces your chest out, making your " + pc.allBreastsDescript() + " stand out. They bounce as you struggle.  ");
			output("The " + impgang.short + " stroke themselves and rub their hands over your outstretched chest, smearing their pre-cum into your skin. The imp riding you bounces up and down, rubbing his sweaty " +  impgang.ballsDescript() + " against your [pc.skinFurScales] while he yanks your [pc.hair]. ");
			//(Low Corruption)
			if (pc.cor() < 50) {
				output("Your face flushes with humiliation. Your imp rider twists your ");
				if (pc.hasHair()) output("[pc.hair]");
				else if (pc.hasLongEars()) output("[pc.ear]");
				else output("[pc.nipple]");
				output(" hard and you whimper in pain. Imps rub their cocks along your [pc.hips] while others stroke themselves and jeer at your helplessness.  ");
			}
			//(High Corruption)
			else output("Gang of imps" + " swarms over your body, some stroking themselves as they watch you squirm while others rub their cocks over your flanks. Your imp rider twists your hair, pulling your head back, and you moan in pleasure at the rough handling. Your [pc.skinFurScales] tingles as you start to flush with desire.  ");
			output("You yelp in shock as you feel a sharp slap on your ass. You look back to see an imp");
			if(pc.hasTail()) output(" pulling your [pc.tails] up");
			output(". He grins at you and slaps your [pc.hip] again. He yanks your tail and slaps your ass one last time, then dives down to plant his face in your [pc.vagina]. His inhumanly nimble tongue teases the folds of your pussy and flicks at your [pc.clit].  ");
			//(If the player has balls)
			if (pc.balls > 0) output("The tongue slides over your [pc.sack], coating it with warm drool.  ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You shake your hips, trying to escape the demonic tongue. The imp grips your [pc.hips] and pulls his face further into your cunt, sliding his nimble tongue over your lips. You grit your teeth, trying to ignore the warmth spreading from your [pc.vaginaNoun].");
			//(High Corruption)
			else output("You let out a shuddering sigh as the heat from your cunt spreads into the rest of your body. Your [pc.hips] tremble as the tongue slides over the folds of your [pc.vaginaNoun]. The imp grips your flanks harder and dives his nimble tongue into your fuck-hole.");
			output("\n\n");
			
			//(If the character has breasts)
			if (pc.biggestTitSize() > 1) {
				output("Hands slide over your " + pc.allBreastsDescript() + ", dragging your attention back to the front of the mob. Two imps grope your " + pc.allBreastsDescript() + ", mauling your flesh as they drag your tits around your chest. They lick your tit-flesh, slowly working their way up towards your [pc.nipples]. The imp rider drops your [pc.hair] and reaches around you, shoving his cock against your back as he squeezes your " + pc.breastCup() + ". Finally the imps reach your nipples, their tongues wrapping around and pulling at the tingling flesh.  ");
				//(Low Corruption)
				if (pc.cor() < 50) output("You can't escape the tongues lapping and pulling at your [pc.nipples], matching the one in your cunt. You shake your head to deny the pleasure, but your breathing comes faster and faster as lust invades your body.");
				//(High Corruption)
				else output("The tongues squeezing and tugging your nipples match the tongue working your [pc.vagina], flooding your body with lust. You moan and arch your back, offering your tits to the imps. You can hear your pulse pounding in your ears as you pant with desire.");
				output("  Suddenly you feel tiny needle-sharp teeth pierce your [pc.nipple]. You scream as venom pumps into your tits, red-hot poison that makes your " + pc.allBreastsDescript() + " feel as though they were being stung by bees. You moan in pain as your breasts start to swell, the imps continuing to pump demon-taint into them.\n\n");
				//Grow tits!
				Mutator.growTits(pc, 2, pc.breastRows.length, false, 3);
				pc.boostLactation(60);
			}
			output("Dimly through your haze of lust and pain you see a large imp step forward from the mob. Four feet tall and broader and stronger looking than any imp you've seen before, with a face as much bull as imp, this new imp has mottled grey skin, broad purple demon wings, two curving bull-horns on his head, and a " + impgang.simpleCockNoun(1) + " big enough to choke a minotaur. The mushroom-like head of it bobs just below his mouth, and his snake-tongue darts out to flick a bit of pre-cum off the head and onto your face. You shudder as the hot fluid stings the sensitive skin of your lips. His " +  impgang.ballsDescript() + " are each the size of your fist and slick with sweat. He slaps his sweaty cock-head against your cheek, nearly scalding you with the heat.  ");
			//(Low corruption)
			if (pc.cor() < 50) output("You yelp and twist your head to escape the heat.  ");
			//(End low corruption) 
			output("He slowly rubs his shaft over your cheeks and along your lips, each ridge of his demonically-hot " + impgang.simpleCockNoun(1) + " tugging at your lips. The hot pre-cum dribbles over your sensitive flesh and the musk makes your sinuses tingle. The big imp sneers as you whimper, and whips his bull-shaft back to slap your face. The other imps watch and stroke themselves as their master cock-whips you.\n\n");
			
			//(If the character has breasts)
			if (pc.biggestTitSize() > 2) output("The big imp grabs one of your painfully distended breasts in each hand, mauling and bouncing the flesh as if weighing them. You gasp in pain as your " + pc.allBreastsDescript() + " swell further at his touch. ");
			output("Hot pre-cum dribbles through your lips and onto your tongue. The steaming salty goo is almost too hot to stand, and you stick your tongue out to cool it. The imps jerk their cocks harder as you pant, tongue hanging out of your mouth. The master imp steps back and looks you up and down, admiring his handiwork. His snake-tongue darts out to an incredible length and wraps itself around your tongue. He licks his pre-cum from you, then forces his tongue into your mouth. The master imp's tongue curves back into your mouth, pressing the glob of pre-cum into your throat. ");
			//(Low corruption)
			if (pc.cor() < 50) output("It's either swallow or have that demon-tongue forced all the way down your throat. Against your will you gulp back the glob.");
			//(High Corruption)
			else output("You swallow the glob of pre-cum eagerly, trying to suck the demon's tongue into your throat.");
			output("\n\n");
			
			output("The big imp walks around you, casting his gaze over your pinned body.  ");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 2) output("The other imps reclaim your aching breasts, sucking your " + pc.nippleDescript(0) + " and mauling your " + pc.allBreastsDescript() + " so hard their fingers disappear into your swelling flesh. ");
			output("The imp rubs his hands over your sides and flanks, his " + impgang.simpleCockNoun(1) + " bobbing as he walks. The other imps watch their master as he moves around you. Only the imp sucking your [pc.vagina] doesn't notice, his tongue thrusting deeply into your folds. The big imp grabs him by the neck and easily tosses him aside, his tongue dragging through your cunt as he's pulled away from you. The master imp takes position behind you and grabs his " + impgang.simpleCockNoun(1) + ", bringing the mushroom-head of it down to your pussy. You shake, knowing what's coming next. The other imps watch and stroke themselves as their master readies his hips to push into you.\n\n");
			//(Low corruption)
			if (pc.cor() < 50) output("You scream for help");
			//(High corruption) 
			else output("You moan with lust");
			output(" as the inhumanly hot cock-head stretches your pussy lips, your cries vanishing into the dark skies above. Your rider grabs your hair to pull your head back, and you cry out as his master pushes his corrupted cock into you.  ");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 1) output("The imps working your breasts suck harder, kneading your tit-flesh as though trying to milk you. ");
			output("You squirm and twist against the imps holding you down as the hot " + impgang.simpleCockNoun(1) + " almost burns your sensitive cunt. You can smell the sweat steaming off his shaft, and your pussy-fluids start to steam as well as he forces his cock-head into your [pc.vagina]. His huge cock-head bulges your groin, and you moan");
			//(Low corruption)
			if (pc.cor() < 50) output(" in helpless terror as you feel the bulge work up from the base of your groin towards your stomach. You let out a shuddering moan of pain as inch after inch of monstrous " + impgang.simpleCockNoun(1) + " stretches your belly");
			//(High corruption)
			else output(", panting in lust as the monstrous " + impgang.simpleCockNoun(1) + " pushes your flesh aside to make room for itself");
			output(". ");
			//(This is a good place for the virginity-loss message, if needed)
			pc.cuntChange(0, impgang.cockVolume(1), true);
			output("You can feel every ridge and pulsing vein of his cock pulling on the lining of your stretched cunt. You tremble helplessly around the huge shaft, fully impaled on the imp's mutated bull-cock.\n\n");
			
			output("Every pulse of his heart makes his cock twitch, making you shake in time to the shaft pulsing in your cunt. The imps jeer at you, masturbating over your shaking body. The big imp flexes his thighs, and his cock-head throbs deep in your belly. The other imps laugh as you ");
			//(Low corruption)
			if (pc.cor() < 50) output("whimper, spasming as the hot shaft presses against new areas");
			//(High corruption)
			else output("moan in pleasure, rotating your hips around this incredible cock");
			output(" in your stuffed [pc.vaginaNoun]. The big imp sneers and flexes his cock again, watching ");
			//(If the character has breasts)
			if (pc.biggestTitSize() >= 2) output("your " + pc.allBreastsDescript() + " roll on your chest as you squirm");
			//(If the character doesn't have breasts)
			else output("your eyes roll back as you squirm");
			output(".\n\n");
			
			output("Finally the big imp pulls back his " + impgang.simpleCockNoun(1) + ", each ridge pulling on your pussy flesh as he slides out. You yelp and buck as the mushroom-head catches on your folds. ");
			//(If the character has a cock)
			if (pc.cockTotal() > 0) output("Your [pc.cocks] bounces as the bulge passes over it.  ");
			output("You moan as the mushroom-head reaches the entrance of your [pc.vagina], your stretched pussy-flesh slowly returning to normal. The master imp pushes forward again, reclaiming your pussy for his monstrous cock. ");
			//(Low corruption)
			if (pc.cor() < 50) output("You try to buck your " + pc.hipDescript() + ", fighting to break free as the bulge of his cock-head works its way high up into your belly. You're held down by too many imps. You can only writhe around the hot shaft stretching out your [pc.vagina]. The big imp grunts as his cock-head pops past your cervix, and you moan and shake in pain.  ");
			//(High corruption)
			else output("You moan in ecstasy as the hot " + impgang.simpleCockNoun(1) + " pushes deep into your [pc.vagina], turning every inch of your pussy into a pleasure-sheath for the big imp. You know you're nothing but a fuck-toy for this corrupt creature, just a wet pussy for him to fill with cum, and the thought almost makes you orgasm as he forces his huge cock-head past your cervix.  ");
			output("Finally the corrupt cock bottoms out against your womb. The imp pulls back again, and starts to fuck you slowly.\n\n");
			
			//(If the character has breasts)
			if (pc.biggestTitSize() >= 2) output("The slow fucking shakes your breasts, and the imps sucking at your nipples cling tightly to your monstrously swollen " + pc.allBreastsDescript() + ". Your " + pc.breastCup(pc.biggestTitRow()) + " have grown three cup sizes since the imps pumped their venom into you. An ache starts deep in the base of your tits and works its way to your sore " + pc.nippleDescript(0) + ". Your already bloated nipples swell as the imps suckle and you gasp as the first rush of milk spills into their mouths. Your rider reaches around and starts to milk your udders, moving his hands between your " + pc.allBreastsDescript() + " and forcing out more milk for his gangmates.\n\n");
			
			output("The big imp grinds his hips as he thrusts and pulls, rubbing his cock-ridges against every part of your [pc.vagina]. While sliding his mutated " + impgang.simpleCockNoun(1) + " in and out of you, the imp rubs his hands along your mound, pulling it open or forcing it tight as he takes you. Your pussy juices steam off his cock as he pumps, and hot pre-cum dribbles down your crack and ");
			//(If the character has a cock)
			if (pc.cockTotal() > 0) output("over your [pc.cocks] where it ");
			output("drips onto the ground. ");
			//(Low corruption)
			if (pc.cor() < 50) output("The pain as this huge cock stretches you is overwhelming, but every thrust rubs more corrupt pre-cum into your pussy walls. You start to pant as the imp rapes you, using your body for his own pleasure. You tremble as the heat of his pre-cum soaks through your body. The huge shaft forces your " + pc.clitDescript() + " out, and the steaming fluids splashing on it make it tingle almost painfully. Your whimpers and moans of pain start to take on a different tone, and the master imp starts to fuck you faster.");
			//(High corruption)
			else output("Pain and pleasure blend into one as the huge " + impgang.simpleCockNoun(1) + " stretches you, rubbing pre-cum into your steaming pussy. You moan as the big imp fucks you, turning you into a mindless fuck-puppet. Your " + pc.clitDescript() + " swells painfully as hot juices splash over it. Your shaking body only adds to the master imp's pleasure.");
			output("\n\n");
			
			output("The other imps continue to jerk-off over you as the big imp impales you again and again on his shaft. Their pre-cum starts to splatter down on your body, and they pant as they watch your orgasm build. ");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 1) output("Imps gulp milk from your bloated " + pc.breastCup(pc.biggestTitRow()) + ". As one imp drinks his fill and staggers away with a sloshing belly, another steps up to pump your milk-spewing udders.  ");
			//(If the character has a dick)
			if (pc.cockTotal() > 0) output("Your [pc.cocks] swell painfully as the rough fucking pumps blood into your groin.  ");
			output("The big imp's snake tongue flicks out and slides around your [pc.vagina], pulling at your pussy lips. He moves his tongue back and forth along the sides of your steaming cunt, alternating between stretching and flicking the lips. ");
			//(If the character has a dick)
			if (pc.hasCock()) output("He draws his tongue back and wraps it around your " + pc.cockDescript(0) + ", sliding its length along your shaft and flicking his tongue over your cock-head.  ");
			output("You gasp in time to the big imp's thrusts, whimpering when his cock or tongue hit a sensitive point. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You're being raped by a demon, milked like a cow, and you're about to cum hard. This corrupted land has left its mark on you.");
			//(High corruption)
			else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.");
			output(" You moan as you rise towards your orgasm.\n\n");
	
			//(If the character has breasts)
			if (pc.biggestTitSize() > 3) output("Your udders shake back and forth under your chest in time to the rough fucking. You arch your back to press your " + pc.nippleDescript(0) + " into eager mouths, moaning as your rider milks your distended " + pc.allBreastsDescript() + ". ");
			//(Low Corruption).
			if (pc.cor() < 50) output("Some part of you can still feel shame, and you whine and clench your teeth as the urge to <i>moo</i> rises in you.");
			//(High corruption)
			else output("You moan shamelessly as you're fucked and milked, and the moans turn to long <i>mooos</i> of ecstasy.");
			output("\n\n");
			
			output("The master imp pounds into you as hard as he can, driving his " + impgang.simpleCockNoun(1) + " deeper into your cunt. His grunts come closer and closer together. Your rider grinds his cock into your back, rubbing his cock-head in your hair. He nips at your neck and shoulder as he pants. The master imp pounds into you and you can feel his " + impgang.ballsDescript() + " swell as they slap against you. Through the haze of your approaching orgasm you realize what's about to happen. Those oversized balls are about to pump more cum into you than any normal man could ever produce. They're going to pump demonic cum right into your womb. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You scream as the base of his " + impgang.simpleCockNoun(1) + " bloats with corrupted jism, the thick bulge stretching your pussy even more as it pumps along the imp's shaft. The bulge swells your belly and you can feel it move through your stretched cunt towards your womb. Another thick bulge forms at the base of the master imp's cock and you thrash wildly, yelling in protest. \"<i>NOO - O - O - OOOOHhh!</i>\" The hot cum floods into your womb and you reach your own orgasm, shaking as your [pc.vagina] clamps down on his cock and milks it of waves of cum. Another orgasm hits on the heels of the first one, and you buck as more demon-cum floods your womb. Gasping for air, you continue to come as your belly swells. Even as he pumps more corrupt cum into you the big imp keeps raping you, forcing you to another peak before you've come down from the last one.");
			//(High corruption)
			else output("The thought of all that demon-jism in your womb pushes you over the edge. You cum hard, bucking your hips against the " + impgang.simpleCockNoun(1) + " pumping hot cum into your belly. Your eyes roll back in your head and you scream out in ecstasy as thick jets of cum fill your pussy. The imp keeps thrusting into his fuck-toy even as he fills your womb with his cum, forcing you to another peak before you've come down from the last one. The big imp is your master now.");
			output("  You nearly black out as the orgasm blasts through you,  shrieking yourself hoarse as the orgasm wracks your body, eyes rolling back in your head as your womb swells.\n\n");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 2) output("As orgasms wrack your body your breasts pump out even more milk, too much for the imps below to handle. Milk pours down your chest in great streams, soaking the imps and splashing onto the ground below you. The milk gushing through your tender " + pc.nippleDescript(0) + " pushes you to another orgasm. You shake your tits as you cum, mooing in mindless pleasure, spraying jets of milk everywhere. Your rider cums, soaking your " + pc.hairDescript() + " with jets of imp-jism that run down your scalp and over your cheeks. ");
			//(High corruption)
			if (pc.cor() >= 50) output("You lap eagerly at the salty cum, licking up and drinking as much as you can.");
			output("\n\n");
			output("Imp-jism rains down on your helpless spasming body. The imps spew cum into your hair, across your back and " + pc.hipDescript() + ", over your [pc.face]");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 2) output(", and bouncing " + pc.allBreastsDescript(), false);
			output(". The " + impgang.short + " is no longer holding you down. They masturbate over you as you claw at the ground with your hands, hooves scraping the earth as you clamp your thighs tight around the big imp. Another pulse of demonic cum hits your womb. You push back against your master, forcing as much of his cock into you as possible. Arching your back, your eyes roll back in your head and you moo as your womb stretches painfully, a final orgasm crashing through your cum-bloated body. You spasm around the cock that impales you, thrashing as ");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 2) output("milk spurts from your " + pc.nippleDescript(0) + " and ");
			output("steaming fluids spew from your over-filled pussy. Unconsciousness follows closely on the heels of this last orgasm, your mind shutting down even as your body still shudders.\n\n");
			output("You wake up later, body still twitching as tiny orgasms spark in your [pc.vagina]. It's still dark out. You lie on your side in a pool of cooling cum, milk, and pussy juice. Your body is covered in long ropes of drying imp-cum, and your hair is plastered to the ground. There's no sign of the horde of imps or their big master. Your skin is stretched and shiny over your still milk-bloated tits. Your belly is as tight and distended as a mare on the verge of giving birth. It quivers as the flesh of your [pc.vagina] spasms. Over the swollen curve of your belly you can see steam rising from between your legs. You start to slip back into unconsciousness. ");
			//(Low corruption)
			if (pc.cor() < 50) output("Your last coherent thought is to find a way to better hide your camp, so this never happens again.");
			//(High corruption)
			else output("Your last coherent thought is to find a way to make your own mutated master imp, maybe even a stable full of them...");
			pc.orgasm();
			pc.slowStatGain("l", 2);
			pc.cor(3);
			pc.loadInCunt(impgang);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
		}
		//Scene number 2 - male possible.
		else {
			//Scene 2 (Centaur, vaginal)
			if (flags["COC.MET_IMP_GANG"] != undefined) {
				//(Subsequent encounters - Low Corruption)
				if (pc.cor() < 50) output("You can't tell if this is the same " + impgang.short + " as last time or not. You're not racist, but all imps look alike to you. " + "Gang of imps"  + " surges forward, grabbing at your legs and arms and running their hands over your body. You struggle, but there are just too many to fight. The result is the same as last time...\n\n");
				//(Subsequent encounters - High Corruption)
				else output("It's about time they showed up. It's not like there's a lot to do in these rocks, and you were getting bored. You grab an imp dick in either hand and spread your legs as other imps grope your thighs...\n\n");
			}
			output("The imp mob tackles you, grabbing at your arms as you ");
			//(Low Corruption)
			if (pc.cor() < 50) output("swing your [pc.meleeWeapon] wildly, determined not to let them take you");
			//(High Corruption)
			else output("twist and struggle in their grips, determined to make them work for their fun");
			output("! You kick back and feel your hooves smash into an imp's chest, sending him flying. But the " + impgang.short + " has your legs and more imps grab your arms. The pack drags you thrashing and bucking over to an old log lying on the ground.\n\n");
			
			output("Your human torso is dragged down to the log by " + impgang.a  + " while two more leap onto your back. The " + impgang.short + " makes short work of your [pc.gear], unbuckling straps and stripping you quickly. ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 0) output("Your unbound " + pc.breastCup(pc.biggestTitRow()) + " bounce out over the weathered log. ");
			output("The imps spread your arms wide, forcing your chest out, and tie them to the log with sweaty loincloths. Your " + pc.hipDescript()  + " are stuck high in the air. Imps rub their sweaty cocks and " + impgang.ballsDescript()  + " over your legs and grope your crotch. The two imps riding your back start stroking and licking each other. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("Your face flushes with humiliation as they turn their attentions on each other, each working their hands and tongue over the other's dick. How dare these demons use you as a bed to sate their lusts?!");
			//(High Corruption)
			else output("Your face flushes with anger as they turn their attentions on each other, each working their hands and tongue over the other's dick. You worked hard for this magnificent body, and now they're not using it?!");
			output("\n\n");
			
			output("An imp quickly climbs up your body, planting his feet on your shoulders and grabbing your " + pc.hairDescript()  + " with one hand for support. He rubs his " + impgang.ballsDescript()  + " over your mouth, smearing your lips with musky sweat, while he pries at your jaw with his other hand. ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 2) output("An imp mounts the log and slaps his " + impgang.randomSimpleCockNoun() + " between your " + pc.allBreastsDescript() + ", squeezing them tight over his cock as he rubs back and forth. He mauls your breasts cruelly, squeezing his fingers deep into your soft flesh.  ");
			//(If the player has a SINGLE cock)
			if (pc.cockTotal() == 1) output("An imp ducks under your body and grabs your " + pc.cockDescript(0) + ". His nimble tongue flicks over your cock-head while he pricks the shaft with his tiny claws.  ");
			//(If the player has a MULTI cock)
			if (pc.cockTotal() > 1) output("Two imps duck under your body and seize your [pc.cocks], licking the tips with their inhumanly flexible tongues while they stroke the shafts.  ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You fight to free your hind legs and buck the imps off your back, while sweaty hands slide over your crotch. You whine through clenched teeth as sharp claws jab at your sensitive flesh.\n\n");
			//(High Corruption)
			else output("You writhe in the grasp of the imps, reveling in the sensations as tiny claws and teeth nip at your sensitive crotch. You lick salty musk off the swollen balls dangling above your mouth.\n\n");
			output("\n\n");
			
			//(If the player has breasts)
			if (pc.biggestTitSize() > 2) output("The imp fucking your " + pc.breastCup(pc.biggestTitRow()) + " handles your soft flesh roughly, pressing and pulling your tits into a fuck-canal for his demon cock. Other imps slap your " + pc.allBreastsDescript() + " and laugh as you cry out.  ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You whimper as your mistreated flesh stings with dozens of pin-prick scratches and bites, and the " + impgang.short + " slaps your chest and flanks. The abuse falls on you from all sides, leaving you with no escape. The imp on your shoulders pries your jaws open, and you gag on his " + impgang.ballsDescript()  + ".");
			//(High Corruption)
			else output("You suckle eagerly at the musky balls in your mouth. Abuse falls on you from all sides, imps leaving tiny marks on your skin as they nip and scratch at you. You whimper in delight as tiny hands slap your chest and flanks.");
			output("\n\n");
			
			output("With a loud sucking sound, the imp pulls his balls out of your mouth. Spit and ball-sweat drip over your cheeks as he repositions himself, bending almost completely over on your shoulders to rub his cock-head against your lips. You nearly choke as pre-cum dribbles into your mouth and runs down the back of your throat. The " + impgang.randomSimpleCockNoun() + " blocks most of your vision, but in the corners of your eyes you see the master of this imp horde step forward. Four feet tall and broader and stronger than any imp in the pack, with a face as much dog as imp, this new imp has black fur, broad red demon wings, two long demon-horns on his head, and a " + impgang.simpleCockNoun(2) + " big enough to choke a minotaur. He leers at your helpless body and grabs ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 2) output("one of your sore " + pc.breastCup(pc.biggestTitRow()) + " in his calloused hand, brutally pressing his fingers into your flesh");
			//(If the player doesn't have breasts)
			else output("your tail and yanks, brutally pulling on it");
			output(" until you shriek. The imp riding your shoulders plunges his " + impgang.randomSimpleCockNoun() + " into your mouth, pounding at the top of your throat.\n\n");
			
			output("The master imp walks back to your hips, lightly dragging his sharp claws over your flanks. He kicks another imp out of the way and takes position behind your " + pc.hipDescript()  + ". He pulls his monstrously long " + impgang.simpleCockNoun(2) + " down and rubs the tip over your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(".  ");
			//(If the player has a cock)
			if (pc.cockTotal() > 0) output("Pre-cum drips from the broad tip of it, dripping down to the base of your [pc.cocks].  ");
			output("The big imp's hot pre-cum stings your flesh. The imps licking your crotch lap up the hot fluid, cooling you with their saliva. The big imp sneers as you whimper, and presses the head of his " + impgang.simpleCockNoun(2) + " against your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0));
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript());
			output(". ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You try to pull away from the hot cock-head rubbing against your hole, but the " + impgang.short + " holds you tight.");
			//(High Corruption)
			else output("The scent of musk steaming off the" + impgang.simpleCockNoun(2) + " drives you wild, and you push back to try and capture the cock-tip.");
			output("\n\n");
			
			output("The pointed tip of the master imp's " + impgang.simpleCockNoun(2) + " plunges into your hole, splitting your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0));
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript());
			output(" wide open. You moan around the cock fucking your throat as the corrupted wolf-cock pushes deeper into your hole. The painfully hot shaft claims inch after inch of your flesh, forcing its way deeper into you than any normal human could bear. Bound to the log you can only shake in agony as the big imp's thick dog-knot hits your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0));
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript());
			output(".");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 2) output("  The imp fucking your aching " + pc.breastCup(pc.biggestTitRow()) + " paints your tits with a massive load of cum. He falls off the log and another imp jumps up to take his place.");
			output("\n\n");
			
			output("The big imp fucks you roughly, clenching your " + pc.hipDescript()  + " in his clawed hands as he hammers his " + impgang.simpleCockNoun(2) + " into you. The head of his mutated shaft pounds ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output("the entrance of your womb");
			//(If the player doesn't have a vagina)
			else output("depths of your bowels");
			output(" as the knot slams against your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0));
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript());
			output(". Each hard thrust pounds you against the log, and you grunt in time to the shaft pistoning in your hole.\n\n");
			
			output("The master imp fucks you for what seems like hours, beating his dog-knot against your sore ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0));
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript());
			output(" and slapping your ass every few thrusts to remind you who is in charge. Imp after imp stretches your throat with their cocks and your belly with demon-seed as the pack rapes your face. ");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 2) output("The rough fucking shakes your cum-stained breasts, and the imp fucking your " + pc.allBreastsDescript() + " clings tightly to your red and swollen tit flesh. Your " + pc.breastCup(pc.biggestTitRow()) + " burn with agony as the " + impgang.short + " slaps your tits like drums.  ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You're being raped again by demons, impaled on cocks like a roast pig on a spit, and you can feel your lust rising. This corrupted land has left its mark on you.");
			//(High corruption)
			else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.");
			output("\n\n");

			//(Low Corruption)
			if (pc.cor() < 50) output("You gurgle helplessly as the cock raping your throat pours thick wads of");
			//(High Corruption)
			else output("You eagerly chug thick wads of cum from the cock stretching your throat, working your throat to force more");
			output(" cum into your swelling belly. The imp slams his cock as deep into your throat as it will go, slapping his " + impgang.ballsDescript() + " against your face. He cums for an impossibly long time, streams of jism pouring into you. You can feel your stomach stretching, but you're more worried about breathing. The edge of your vision starts to go red and your chest heaves as you fight for air. Finally the imp draws his cock out of your throat, spraying his last gobs of cum over your face as you gasp in huge lungfuls of air. The sudden rush of oxygen pushes you over the edge and you cum hard. Your hands clench at the air and your eyes roll back in your head as you twist around the demonic " + impgang.simpleCockNoun(2) + " pounding into you. You shriek as your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(" spasms on the steaming pole that impales it. Another imp shoves his cock in your mouth as you scream, throat convulsing around his cock-head.");
			//(If the player has a cock)
			if (pc.cockTotal() > 0) output("  Your [pc.cocks] shoots cum across the ground and into the waiting mouths of the imps licking your crotch.");
			output("\n\n");
			
			output("Another imp-cock spasms in your throat as its owner rams deep into you. He floods your already swollen stomach with inhuman amounts of cum. Again you feel yourself about to black out as the demon pumps jism into you. He pulls out and again you orgasm as you wheeze for air. Another imp forces his cock down your throat as you moan and gasp. Your body shakes in pleasure on the big imp's " + impgang.simpleCockNoun(2) + ".  Tightening his grip on your " + pc.hipDescript() + " the master imp howls and slams his shaft into your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(". His unnaturally huge knot stretches the entrance of your hole, and he hammers into you again. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You howl around the imp-cock stretching your throat. The bloated knot opens your hole far beyond anything you've endured before. Your violent thrashing throws the imps off your back and you buck uselessly, thrashing as the swollen " + impgang.simpleCockNoun(2) + " plunges deeper into you.");
			//(High corruption)
			else output("The master imp's bloated knot stretches your entrance and plunges into your hole with a loud <i>pop</i>. Another orgasm hits you as the " + impgang.simpleCockNoun(2) + " rams even deeper into you. You howl around the imp-cock stretching your throat, bucking as your orgasm shakes you. Your violent thrashing throws the imps off your back and slams your hips against the big imp, pushing him further into your hole.");
			output("  The big imp howls again as he cums, each wave of steaming demon-cum stretching his knot and shaft even more. His cum-pumping " + impgang.simpleCockNoun(2) + " is bottomed out deep in your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output("womb");
			//(If the player doesn't have a vagina)
			else output("guts");
			output(" and he pumps more jism into you than his balls could possibly hold. Your belly stretches with every blast of cum and you shriek around yet another cock in your throat.\n\n");

			//(If the character has breasts)
			if (pc.biggestTitSize() > 2) output("The imp riding your " + pc.breastCup(pc.biggestTitRow()) + " cums, his load lost in the flood of jism dripping off your abused fuck-udders. ");
			output("Your master isn't done with you yet, churning his " + impgang.simpleCockNoun(2) + " knot in your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(" as he continues to cum. You're pumped full of demon-cum from both ends as one imp shoots his load in your throat and another steps up to take his place. You shake and tremble in your own endless orgasm as the pleasure in your stretched hole blends with the pain of your swollen belly. Your fingers claw at the log as the master imp shifts his massive knot within your monstrously stretched ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(". Your legs give out as you feel more pulses of demon-cum work their way up his shaft and into your already-huge belly.\n\n");
			
			output("You pass out as another tidal wave of corrupted jism spews into your hole, another load of imp-cum pours down your throat, to meet somewhere in the middle...\n\n");
			
			output("You wake up later, still trembling with small orgasms. Cum burbles in your mouth as you breathe, and your " + pc.hairDescript() + " is soaked with jism. You haven't moved since you passed out. Your arms are still tied to the log, ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 0) output("your bruised and throbbing tits pressed against the rough wood, ");
			output("and your body rests in a cooling pool of cum. You couldn't move even if your " + pc.legs() + " felt stronger. Your hideously bloated belly weighs you down, quivering with every orgasmic twitch that passes through you. The skin of your distended belly is drum-tight and shiny. As you slip back into unconsciousness, one last thought flits across your mind. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("How long can you last in this corrupted land, when your body can be so horribly twisted by the sick pleasures of its denizens?");
			//(High corruption)
			else output("Why bother with your silly quest, when you've only scratched the surface of the pleasures this land offers you?\n");
			pc.orgasm();
			pc.slowStatGain("l", 2);
			pc.cor(3);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
			//Stretch!
			if (pc.hasVagina()) {
				if (pc.cuntChange(0, impgang.cockVolume(2), true)) output("\n");
				pc.loadInCunt(impgang);
			}
			else {
				if (pc.buttChange(impgang.cockVolume(2), true)) output("\n");
				pc.loadInAss(impgang);
			}
		}
	}
	//NOT CENTAUR
	else {
		if (rand(2) == 0 && (pc.cockTotal() == 0 || pc.isHerm())) {
			//(First encounter)
			if (flags["COC.MET_IMP_GANG"] == undefined) {
				output("The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. They all have a " + impgang.randomSimpleCockNoun() + " as long and thick as a man's arm, far oversized for their bodies. Watching an imp trip over its " + impgang.randomSimpleCockNoun() + " would be funny, if you weren't surrounded by a horde of leering imps closing in from all sides...\n\n");
			}
			output("The imps leap forward just as you start to [pc.readyWeapon], one sweaty imp clinging to your arm");
			if (pc.hasWeapon()) output(" while another kicks your weapon out of reach");
			output(". The " + impgang.short + " surges forward and grapples you. Imps grope your body and hump their " + impgang.randomSimpleCockNoun() + " against your legs, smearing their sweat and pre-cum into your [pc.skinFurScales]. The rest of the " + impgang.short + ", a dozen or more imps, all leer at you and laugh as they slap and pinch your body. The imps have sharp claws, tiny sharp teeth, and short horns on their heads. They scratch, claw, and bite at you with all of these weapons as they try to pull you down to the ground. One bold imp leaps forward and grabs your ");
			//(If the player has a cock)
			if (pc.cockTotal() > 0) output(pc.cockDescript(0), false);
			else output(pc.nippleDescript(0), false);
			output(", twisting and pinching hard enough to make you yelp in pain. The " + impgang.short + " stinks of sweat and pre-cum, and their moist grips and obscene smirks leave you with no doubts about what they will do to you if you lose this fight.\n\n");
			//(Bipedal, vaginal)
			output("The " + "gang of imps"  + " overwhelms you, dragging you to the ground with sheer numbers. There are at least two imps on each limb, holding you spread-eagled on the cold ground while other imps stroke your body. ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 0) output("Imps surround your chest, slapping their " + impgang.randomSimpleCockNoun() + "s on your " + pc.allBreastsDescript() + " and rubbing their slippery pre-cum into your " + pc.nippleDescript(0) + ".  ");
			output("Others stand over your head, their cocks bobbing inches from your face as they jack off. A thick musk wafts off their cocks, and the smell of it makes your sinuses tingle. Two more imps take position between your legs, sliding their cocks along your thighs while stroking your [pc.vagina] and flicking your " + pc.clitDescript() + ".");
			//(If the player has a cock)
			if (pc.cockTotal() > 0) output("An imp rubs his hand across his cock-head, smearing it with his pre-cum. He rubs his hand over your [pc.cocks], making your cock-skin tingle as his fluid soaks into you.");
			output("\n\n");
			output("The " + impgang.short + " snickers lewdly as your nipples harden and your pussy moistens. One of the imps between your legs slides his shaft along your pussy lips, teasing your " + pc.clitDescript() + " with the tip of his cock.  ");
			//(Low corruption)
			if (pc.cor() < 50) output("You renew your struggles, trying to break free of your captors. They only laugh and bear down harder on you.  ");
			//(High corruption)
			else output("You buck your hips, trying to capture his " + impgang.randomSimpleCockNoun() + " with your [pc.vagina].  ");
			output("Before he can thrust into you, the imp is shoved aside by the biggest imp you've ever seen.\n\n");
			
			output("Four feet tall and broader and healthier looking than any imp you've seen before, with a face as much bull as imp, this new imp has mottled grey skin, broad purple demon wings, two curving bull-horns on his head, and a " + impgang.simpleCockNoun(1) + " big enough to choke a minotaur. The mushroom-like head of it bobs just below his mouth, and his snake-tongue darts out to flick a bit of pre-cum off the head and onto your groin. You shudder as the hot fluid stings the sensitive skin of your " + pc.vaginaDescript(0), false);
			//(If the player has a dick)
			if (pc.cockTotal() > 0) output(" and [pc.cocks]");
			output(". His " + impgang.ballsDescript() + " are each the size of your fist and slick with sweat. He slaps his sweaty balls against your [pc.vagina] nearly scalding you with the heat.  ");
			//(Low corruption)
			if (pc.cor() < 33) output("You yelp and buck your hips to escape the heat.  ");
			output("He grabs your hips and slowly drags his shaft down your pussy, each ridge of his demonically-hot " + impgang.simpleCockNoun(1) + " hitting your clit and pulling at your lips. Finally the broad horse-like head of his shaft catches on your " + pc.clitDescript() + ", and the hot pre-cum dribbles over your sensitive flesh. The big imp sneers as you whimper, and drags his cock-head down to the opening of your [pc.vagina]. The other imps watch and stroke themselves as their master pulls his hips back to push into you.\n\n");
			//(Low corruption)
			if (pc.cor() < 50) output("You scream for help");
			//(High corruption)
			if (pc.cor() >= 50) output("You moan with lust");
			output(" as the inhumanly hot cock-head stretches your pussy lips, your cries vanishing into the dark skies above. Two imps grab your hair and pull your head up, forcing you to watch as their master pushes his corrupted cock into you. Other imps spread your [pc.legs] even wider, leaving you helpless as the big imp slides his swollen meat into your [pc.vagina]. You squirm and twist against the imps holding you down as the hot flesh almost burns your sensitive cunt. You can smell the hot sweat steaming off his shaft, and your pussy-fluids start to steam as well as he forces his cock-head into your [pc.vagina]. His huge cock-head bulges your groin, and you watch ");
			//(Low corruption)
			if (pc.cor() < 50) output("in helpless terror as the bulge inches up from the base of your groin towards your stomach. You let out a shuddering moan of pain as inch after inch of monstrous " + impgang.simpleCockNoun(1) + " stretches your belly");
			//(High corruption)
			else output("panting in lust as the monstrous " + impgang.simpleCockNoun(1) + " pushes your flesh aside to make room for itself");
			output(". ");
			//(This is a good place for the virginity-loss message, if needed)
			pc.cuntChange(0, impgang.cockVolume(1), true);
			output("\n\n");
			output("You can feel every ridge and pulsing vein of his cock pulling on the lining of your stretched cunt. You tremble helplessly around the huge shaft, fully impaled on the imp's mutated bull-cock.\n\n");
			output("Every pulse of his heart makes his cock twitch, making you shake in time to the shaft pulsing in your cunt. The imps jeer at you, masturbating over your shaking body. The big imp flexes his thighs, and the bulge of his cock-head bounces high in your belly. The other imps laugh as you ");
			//(Low corruption)
			if (pc.cor() < 50) output("whimper, spasming as the hot shaft presses against new areas");
			//High corruption)
			else output("moan in pleasure, rotating your hips around this incredible cock");
			output(" in your stuffed [pc.vagina]. The big imp sneers and bounces his cock again, watching ");
			//(If the character has breasts)
			if (pc.biggestTitSize() >= 3) output("your " + pc.allBreastsDescript() + " roll on your chest as you squirm");
			//(If the character doesn't have breasts)
			else output("your eyes roll back as you squirm");
			output(".  ");
			//(If the character has a cock)
			if (pc.cockTotal() > 0) output("Your [pc.cocks] slaps against your distended belly as you shake.");
			output("\n\n");
			output("Finally the big imp pulls back his " + impgang.simpleCockNoun(1) + ", each ridge pulling on your pussy flesh as he slides out. An imp reaches out and slaps the bulge as it withdraws, making you yelp and buck.  ");
			//(If the character has a cock)
			if (pc.cockTotal() > 0) output("Your [pc.cocks] bounces as the bulge passes under it.  ");
			output("You moan as the mushroom-head reaches the entrance of your [pc.vagina], your stretched pussy-flesh slowly returning to normal. The master imp pushes forward again, reclaiming your pussy for his monstrous cock. ");
			//(Low corruption)
			if (pc.cor() < 50) output("You try to pull your hips back, fighting to break free as the bulge of his cock-head works its way high up into your belly. You're held down by too many imps. You can only writhe around the hot shaft stretching out your [pc.vagina]. Your head is held steady by two imps, you can't even look away as their master rapes you. The big imp grunts as his cock-head pops past your cervix, and you moan and shake in pain.");
			//(High corruption)
			else output("You moan in ecstasy as the hot " + impgang.simpleCockNoun(1) + " pushes deep into your [pc.vagina], turning every inch of your pussy into a pleasure-sheath for the big imp. You know you're nothing but a fuck-toy for this corrupt creature, just a wet pussy for him to fill with cum, and the thought almost makes you orgasm as he forces his huge cock-head past your cervix.");
			output("Finally the corrupt cock bottoms out against your womb. The imp pulls back again, and starts to fuck you slowly.\n\n");
			
			output("The big imp grinds his hips as he thrusts and pulls, rubbing his cock-ridges against every part of your [pc.vagina].  While sliding his mutated " + impgang.simpleCockNoun(1) + " in and out of you the imp rubs his hands along your mound, pulling it open or forcing it tight as he takes you. Your pussy juices steam off his cock as he pumps, and hot pre-cum dribbles down your crack to your " + pc.assholeDescript() + ". ");
			//(Low corruption)
			if (pc.cor() < 50) output("The pain as this huge cock stretches you is overwhelming, but every thrust rubs more corrupted pre-cum into your pussy walls. You start to pant as the imp rapes you, using your body for his own pleasure. Your nipples swell as the heat of his pre-cum soaks through your body. The huge shaft forces your " + pc.clitDescript() + " out, and the steaming fluids splashing on it make it tingle almost painfully. Your whimpers and moans of pain start to take on a different tone, and the master imp starts to fuck you faster.");
			//(High corruption)
			else output("Pain and pleasure blend into one as the huge " + impgang.simpleCockNoun(1) + " stretches you, rubbing pre-cum into steaming pussy. You moan as the big imp fucks you, turning you into a mindless fuck-puppet. Your " + pc.clitDescript() + " swells painfully as hot juices splash over it. Your " + pc.nippleDescript(0) + " tingle almost painfully as the heat of his pre-cum spreads through your body.");
			output("\n\n");
			output("The other imps continue to jerk-off over you as the big imp impales you again and again on his shaft. Their pre-cum starts to splatter down on your body, and they pant as they watch you build towards your orgasm.  ");
			//(If the character has breasts)
			if (pc.biggestTitSize() >= 3) output("Your " + pc.allBreastsDescript() + " bounce and jiggle back and forth as the master imp roughly fucks you.  ");
			//(If the character has a dick)
			if (pc.hasCock()) output("Your [pc.cocks] swell painfully as the rough fucking pumps blood into your groin.  ");
			output("The big imp's snake tongue lashes out to incredible length and wraps around one of your " + pc.nippleDescript(0) + "s, pulling at it and stretching the flesh under it. He moves his tongue back and forth between your nipples, alternating between stretching and flicking them. ");
			//(If the character has a dick)
			if (pc.cockTotal() > 0) output("He draws his tongue back and wraps it around your " + pc.cockDescript(0) + ", sliding its length along your shaft and flicking his tongue over your cock-head.");
			//(If the character doesn't have a dick)
			else output("His tongue flicks down to your " + pc.clitDescript() + ", the split ends of it teasing your clit.");
			output("  You gasp in time to the big imp's thrusts, whimpering when his cock or tongue hit a sensitive point.  ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You're being raped by a demon, forced to take an inhuman cock, and you're about to cum hard. This corrupted land has left its mark on you.");
			//(High corruption)
			else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.");
			output("  You moan as you rise towards your orgasm.\n\n");
			
			output("The master imp pounds at you as hard as he can, driving his " + impgang.simpleCockNoun(1) + " deeper into you. His grunts come closer and closer together. Your head still held up, you watch as the imps around you start to cum. They spray your body with thick globs of cum, splattering it across your belly");
			//(If the character has breasts)
			if (pc.biggestTitSize() >= 3) output(" and " + pc.allBreastsDescript(), false);
			output(". The master imp pounds into you and you can see his " + impgang.ballsDescript() + " swell. Through the haze of your approaching orgasm you realize what's about to happen. Those oversized balls are about to pump more cum into you than any normal man could ever produce. They're going to pump demonic cum right into your womb.  ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You scream as the base of his " + impgang.simpleCockNoun(1) + " bloats with corrupted jism, the thick bulge stretching your pussy even more as it pumps along the imp's shaft. The bulge swells your belly and you watch as it moves towards your womb. Another thick bulge forms at the base of the master imp's cock and you thrash wildly, yelling in protest. \"<i>NOO - O - O - OOOOHhh!</i>\" The hot cum floods into your womb and you hit your own orgasm, shaking as your [pc.vagina] clamps down on his cock and milks it of waves of cum. Another orgasm hits on the heels of the first one, and you buck as more demon-cum floods your womb. Gasping for air, you continue to come as your belly swells. Even as he pumps more corrupt cum into you the big imp keeps raping you, forcing you to another peak before you've come down from the last one.");
			//(High corruption)
			else output("The thought of all that demon-jism in your womb pushes you over the edge. You cum hard, bucking your hips against the " + impgang.simpleCockNoun(1) + " pumping hot cum into your belly. Your eyes roll back in your head and you scream out your ecstasy as thick jets of cum fill your pussy. The imp keeps thrusting into his fuck-toy even as he fills your womb with his cum, forcing you to another peak before you've come down from the last one. The big imp is your master now.");
			output("  You nearly black out as the orgasm blasts through you,  arching your back off the ground as the orgasm wracks your body, eyes rolling back in your head as your womb swells.\n\n");
			
			output("Imp-jism rains down on your helpless spasming body. The imps spew cum into your hair, across your swollen belly, over your [pc.face]");
			//(If the character has a cock) 
			if (pc.cockTotal() > 0) output(", and cum-dripping [pc.cocks]");
			//(If the character has breasts)
			if (pc.biggestTitSize() >= 3) output(", and bouncing " + pc.allBreastsDescript());
			output(". The " + impgang.short + " is no longer holding you down. They masturbate over you as you claw at the ground with your hands, toes curling as you clamp your thighs tight around the big imp. Another pulse of demonic cum hits your womb. You wrap your legs around your master, forcing as much of his cock into you as possible. Arching your back, your eyes roll back in your head and you shriek as your womb stretches painfully, a final orgasm crashing through your cum-bloated body. You spasm around the cock that impales you, thrashing against the ground as ");
			//(If the character has breasts)
			if (pc.biggestTitSize() >= 3 && pc.isLactating()) output("milk spurts from your " + pc.nippleDescript(0) + " and ");
			output("steaming fluids spew from your over-filled pussy. Unconsciousness follows close on the heels of this last orgasm, your mind shutting down even as your body still shudders.\n\n");
			output("You wake up later, body still twitching as tiny orgasms spark in your [pc.vagina]. It's still dark out. You lie in a pool of cooling cum and pussy juice. Your body is covered in long ropes of drying imp-cum, and your hair is plastered to the ground. There's no sign of the horde of imps or their big master. Your belly is as tight and distended as a woman on the verge of giving birth. It quivers as the flesh of your [pc.vagina] spasms. Over the swollen curve of your belly you can see steam rising from between your legs. You start to slip back into unconsciousness. ");
			//(Low corruption)
			if (pc.cor() < 50) output("Your last coherent thought is to find a way to better hide your camp, so this never happens again.");
			//(High corruption)
			else output("Your last coherent thought is to find a way to make your own mutated master imp, one you can keep as a fuck-toy...");
			pc.orgasm();
			pc.slowStatGain("l", 2);
			pc.cor(3);
			pc.loadInCunt(impgang);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
		}
		else {
			//Imp Scene 2 (Bipedal, vaginal)
			//Tag-team
			//Include milking alt text in separate blocks. 
			//Work cock and multicock alt text directly into main text blocks.
			if (flags["COC.MET_IMP_GANG"] != undefined) {
				//(Subsequent encounters - Low Corruption)
				if (pc.cor() < 50) output("You can't tell if this is the same " + impgang.short + " as last time or not - all imps look alike to you.  The " + "gang of imps"  + " surges forward, grabbing at your " + pc.legs() + " and arms and running their hands over your body. You struggle, but there are just too many to fight. The result is the same as last time...\n\n");
				//(Subsequent encounters - High Corruption)
				else output("It's about time they showed up. It's not like there's a lot to do in these rocks, and you were getting bored. You grab an imp dick in either hand and spread your legs as other imps grope your thighs...\n\n");
			}
			output("The " + "gang of imps" + " swarms over you, dragging you to the ground as ");
			//(Low Corruption)
			if (pc.cor() < 50) output("you punch and kick wildly, determined not to let them take you");
			//(High Corruption)
			else output("you twist and struggle in their grips, determined to make them work for their fun");
			output("! They pull you down over a fallen log, ass resting above your head. Two imps sit on your arms, their gonads rubbing against your biceps, and rub their hands over your shoulders and chest. Others stretch your ");
			if (pc.isNaga()) output("coils out, twisting them around a log to hold you still.\n\n");
			else output(pc.legs() +" wide apart, holding them against the log.\n\n");
			
			output("The " + impgang.short + " makes short work of your [pc.gear], unbuckling straps and stripping you quickly. ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 0) output("An imp mounts your chest and slaps his " + impgang.randomSimpleCockNoun() + " between your " + pc.allBreastsDescript() + ", squeezing them tight over his cock as he rubs back and forth.  ");
			//(If the player has a SINGLE cock)
			if (pc.cockTotal() == 1) output("Your " + pc.cockDescript(0) + " is seized by an imp, who licks the tip with his inhumanly nimble tongue while he strokes the shaft.  ");
			//(If the player has a MULTI cock)
			if (pc.cockTotal() > 1) output("Two imps seize your [pc.cocks], licking the tips with their inhumanly nimble tongues while they stroke the shafts.  ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You fight to free your arms and shake the imp off your chest while tiny hands slide over your face. They tug at your lips and try to pry your jaws open");
			//High Corruption)
			else output("You writhe in the grasp of the imps, reveling in the sensations of being spread open and completely at the mercy of these demons. Tiny hands slide over your face and you lick and suck at the fingers");
			output(".\n\n");
			
			//(If the player has breasts)
			if (pc.biggestTitSize() > 0) {
				output("Hands slide over your " + pc.allBreastsDescript() + ", pinching and pulling at your nipples. The imp riding your " + pc.breastCup(pc.biggestTitRow()) + " licks your tit-flesh, slowly working his tongue up towards your " + pc.nippleDescript(0) + ". Finally the imp's tongue reaches your nipple, wrapping around and pulling at the tingling flesh. ");
				//(Low Corruption)
				if (pc.cor() < 50) output("You can't escape the tongue lapping and pulling at your " + pc.nippleDescript(0) + ". You shake your head to deny the pleasure, but your breathing comes faster and faster as lust invades your body.");
				//(High Corruption)
				else output("The tongue squeezing and tugging your nipple floods your body with lust. You moan and arch your back, offering your tits to the imp riding your chest. You can hear your pulse pounding in your ears as you pant in desire.");
				output("  Suddenly you feel tiny needle-sharp teeth pierce your nipple. You scream as venom pumps into your tits, red-hot poison that makes your " + pc.allBreastsDescript() + " feel as though they were being stung by bees. You moan in pain as your breasts start to swell, the imp rider biting into your other nipple to pump demon-taint into it.");
				if (pc.hasFuckableNipples()) output("With the imp's taint seeping into your " + pc.nippleDescript(0) + ", each one's cunt-like shape begins swelling. The fuckable orifices engorge into larger and fatter looking labia, becoming fuller cunts each with an engorged clitoral nub the size of a golf ball. Their color deepens as the skin of your nipple-cunts becomes tighter and smoother.  The imp giggles and continues nibbling the newly swollen sensitive flesh, injecting further doses of venom.");
				output("\n\n"); 
				//Grow tits!
				Mutator.growTits(pc, 2, pc.breastRows.length, false, 3);
				pc.boostLactation(50);
			}
			output("The master of this " + impgang.short + " steps up ");
			if (pc.isNaga()) output("alongside your taut tail");
			else output("between your " + pc.legs());
			output(", leering down at your trapped body. Four feet tall and broader and stronger than any imp in the pack, with a face as much dog as imp, this new imp has grey fur, broad black demon wings, two long demon-horns on his head, and a " + impgang.simpleCockNoun(2) + " big enough to choke a minotaur. Pre-cum drips from the broad tip of it, dripping down onto your ");
			//(If the player has a cock)
			if (pc.cockTotal() > 0) output("[pc.cocks]");
			//(If the player doesn't have a cock)
			else output(pc.vaginaDescript(0), false);
			output(".  ");
			output("The heat stings your flesh. The imps licking your groin lap up the hot fluid, cooling you with their saliva. The big imp sneers as you whimper, and drags the head of his " + impgang.simpleCockNoun(2) + " down to your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(".  He thrusts brutally, shoving the head of his " + impgang.simpleCockNoun(2) + " into your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)" + 
			else output(pc.assholeDescript(), false);
			output(". ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You screech in agony as the big imp forces his mutated wolf-cock into your hole, brutally shoving thick inch after inch of painfully hot " + impgang.simpleCockNoun(2) + " deeper into you than anything should ever go.  ");
			//(High Corruption)
			else output("The master imp's painfully hot " + impgang.simpleCockNoun(2) + " stretches your hole wider than it ever should be, and you moan in perverse ecstasy.  "); 
			output("His huge dick-knot bumps against the entrance of your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(".\n\n");
			
			//(If the character has breasts)
			if (pc.biggestTitSize() > 0) output("The big imp reaches past your tit-rider and grabs one of your painfully distended breasts in each hand, mauling and bouncing the flesh as if weighing them. You gasp in pain as your " + pc.allBreastsDescript() + " swell further at his touch.  ");
			output("Your mouth gapes open and an imp takes the chance to stuff it full of cock.  ");
			output("The master imp grabs your hips and starts to fuck you hard, pistoning his steaming cock in and out of your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(". ");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 1) output("The rough fucking shakes your breasts, and the imp sucking your nipples clings tightly to your monstrously swollen " + pc.allBreastsDescript() + ". Your " + pc.breastCup(pc.biggestTitRow()) + " have grown three cup sizes since the imp pumped his venom into you.  ");
			output("The imp fucking your face grabs your " + pc.hairDescript() + " and jaw, forcing your head back so he can ram his cock into your throat. The obscene bulge sliding in your throat matches the bulge in your belly. The smaller imp pulls back just enough to let you gasp for air, then thrusts into your throat again. The big imp pounds the knot of his " + impgang.simpleCockNoun(2) + " against your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(", not caring that he's stretching you beyond normal human endurance. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You're being raped again by demons, impaled on cocks like a roast pig on a spit, and you can feel your lust rising.  This corrupted land has left its mark on you.");
			//(High corruption)
			else output("This corrupted land has left its mark on you. You could never have taken a cock this big before you arrived here.");
			output("\n\n");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 0) output("An ache starts deep in the base of your tits and works its way to your sore " + pc.nippleDescript(0) + ". Your already bloated nipples swell as your rider suckles and you gasp as the first rush of milk spills into his mouth. Your rider milks your udders, moving his hands between your " + pc.allBreastsDescript() + " and forcing out more milk than he could ever drink. Other imps lick the milk from the shiny skin of your swollen breasts.\n\n");
			
			output("The smaller imp slams his cock as deep into your throat as it will go, slapping his " + impgang.ballsDescript() + " against your face. He cums, balls twitching as they pump spunk down your throat. You can feel your stomach stretching, but you're more worried about breathing. The imp cums for an impossibly long time, streams of jism pouring into you. The edge of your vision starts to go red and your chest heaves as you fight for air. Finally the imp draws his cock out of your throat, spraying his last gobs of cum over your face as you gasp in huge lungfuls of air. The sudden rush of oxygen pushes you over the edge and you cum hard. Your body arches and your eyes roll back in your head as you twist around the demonic " + impgang.simpleCockNoun(2) + " pounding into you. You shriek as your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(" spasms on the steaming pole that impales it. Another imp shoves his cock in your mouth as you scream, throat convulsing around his cock-head.");
			//(If the player has a cock)
			if (pc.cockTotal() > 0) output("  Your [pc.cocks] shoots cum across your belly and into the waiting mouths of the imps licking your crotch.");
			output("\n\n");
			//(If the character has breasts)
			if (pc.biggestTitSize() > 0) {
				output("Imps lick milk from your bloated " + pc.breastCup(pc.biggestTitRow()) + " as your rider milks you.  As one imp drinks his fill, staggering away with a sloshing belly, another steps up to guzzle from your milk-spewing udders.\n\n");
				//Additional nipplefucking scene by Xodin
				if (pc.hasFuckableNipples()) {
					output("The imp rider grabs the fat folds of one of your nipplecunt's 'labia' and grins mischeviously. He rubs his obscene erection all over the milk stained surface of your nipple-cunt's clit and begins to press the head of his bulbous imp cock into the swollen orifice against the flow of milk. You know no woman in your village could have handled an aroused cock this big, and yet now this imp on your " + pc.allBreastsDescript() + " is about to ram just such an erection into one of your " + pc.nippleDescript(0) + "s. He tugs and pulls and pulls again on your nipple-cunt's sensitive labia, forcing his cock to push into the flesh of your " + pc.breastCup(pc.biggestTitRow()) + ". Your taut flesh burns with his venom already, and is now violated by the presence of his demonic flesh rod.  ");
					//[START BREAST SIZE SPECIFIC TEXT] 
					//[IF breastSize <= DD]
					if (pc.biggestTitSize() <= 5) output("You feel the bulbous head of his cock squeeze further and deeper until it pushes up against your ribs.");
					//[ELSE IF breastSize > DD]
					else output("You feel the unnaturally large erection spear the fat filled depths of your " + pc.breastCup(pc.biggestTitRow()) + " until at last the imp has shoved himself in to his hilt. He smiles at the sensation of having his manhood completely engulfed in your " + pc.breastCup(pc.biggestTitRow()) + ".");
					//[END BREAST SIZE SPECIFIC TEXT]
					output("  Back and forth he begins fucking your tit as if it were a regular pussy, and it occurs to you that such a description isn't far from the truth. You gasp in pleasure as a strange kind of minor orgasm ripples through your tit and the taut skin of your mammary feels tighter as the " + pc.breastCup(pc.biggestTitRow()) + " momentarily spasms around the imp's manhood. The horny little demon slaps your nipplecunt's clit in gleeful victory and jumps to the next breast to repeat his lewd fucking on a fresh hole.");
					output("\n\n");
				}

			}
			output("The imp-cock in your throat spasms and its owner rams as deep into you as he can get. He floods your already swollen stomach with inhuman amounts of cum. Again you feel yourself about to black out as the demon pumps jism into you. He pulls out and again you orgasm as you wheeze for air. Another imp forces his cock down your throat as you moan and gasp. Your body shakes in pleasure on the big imp's " + impgang.simpleCockNoun(2) + ".  Tightening his grip on your " + pc.hipDescript() + " the master imp howls and slams his shaft into your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0));
			//If the player doesn't have a vagina)
			else output(pc.assholeDescript());
			output(". His unnaturally huge knot stretches the entrance of your hole, and he hammers into you again. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("You howl around the imp-cock stretching your throat. The bloated knot opens your hole far beyond anything you've endured before. Your violent thrashing throws the imps off your " + pc.legs() + " and you kick uselessly, thrashing and bucking as the swollen " + impgang.simpleCockNoun(2) + " plunges deeper into you.");
			//(High corruption)
			else output("The master imp's bloated knot stretches your entrance and plunges into your hole with a loud <i>pop</i>. Another orgasm hits you as the " + impgang.simpleCockNoun(2) + " rams even deeper into you. You howl around the imp-cock stretching your throat, thrashing and bucking as your orgasm shakes you. Your violent thrashing throws the imps off your legs and you wrap your legs around the big imp, pulling him further into your hole.");
			output(" The big imp howls again as he cums, each wave of steaming demon-cum stretching his knot and shaft even more. His cum-pumping " + impgang.simpleCockNoun(2) + " is bottomed out deep in your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output("womb");
			//(If the player doesn't have a vagina)
			else output("guts");
			output(" and he pumps more jism into you than his balls could possibly hold. Your belly stretches with every blast of cum and you shriek around yet another cock in your throat.\n\n");
			
			//(If the character has breasts)
			if (pc.biggestTitSize() > 0) output("The imp riding your " + pc.breastCup(pc.biggestTitRow()) + " finally cums, painting your distended fuck-udders with his massive load.  ");
			output("Your master isn't done with you yet, churning his " + impgang.simpleCockNoun(2) + " knot in your ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(" as he continues to cum. You're pumped full of demon-cum from both ends as one imp shoots his load in your throat and another steps up to take his place. You shake and tremble in your own endless orgasm as the pleasure in your stretched hole blends with the pain of your swollen belly. Your " + pc.legs() + " thrash as the master imp shifts his massive knot within your monstrously stretched ");
			//(If the player has a vagina)
			if (pc.hasVagina()) output(pc.vaginaDescript(0), false);
			//(If the player doesn't have a vagina)
			else output(pc.assholeDescript(), false);
			output(". Your toes curl as you feel more pulses of demon-cum work their way up his shaft and into your already-huge belly.\n\n");
			
			output("You pass out as another load of imp-cum pours down your throat, another tidal wave of corrupted jism spews into your hole, to meet somewhere in the middle...\n\n");
			output("You wake up later, still trembling with small orgasms. Cum burbles in your mouth as you breathe. You haven't moved since you passed out. Your hips are still propped up over the log, and you rest in a cooling pool of cum, your " + pc.hairDescript() + " plastered to the ground with drying jism. You couldn't move even if your " + pc.legs() + " felt stronger. Your hideously bloated belly weighs you down, ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 0) output("and your milk-filled udders are still swollen with imp-venom, ");
			output("quivering with every orgasmic twitch that passes through you. The skin of your distended belly ");
			//(If the player has breasts)
			if (pc.biggestTitSize() > 3) output("and massive tits ");
			output("is drum-tight and shiny, and your belly-button has popped out into an outie. As you slip back into unconsciousness, one last thought flits across your mind. ");
			//(Low Corruption)
			if (pc.cor() < 50) output("How long can you last in this corrupted land, when your body can be so horribly twisted for the sick pleasures of its denizens?\n\n");
			//(High corruption)
			else output("Why bother with your silly quest, when you've only scratched the surface of the pleasures this land offers you?\n\n");
			pc.orgasm();
			pc.slowStatGain("l", 2);
			pc.cor(3);
			//pc.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 14); //Bigger imp means faster pregnancy
			//Stretch!
			if (pc.hasVagina()) {
				if (pc.cuntChange(0, impgang.cockVolume(2), true)) output("\n");
				pc.loadInCunt(impgang);
			}
			else {
				if (pc.buttChange(impgang.cockVolume(2), true)) output("\n");
				pc.loadInAss(impgang);
			}
		}
	}
	
	IncrementFlag("COC.MET_IMP_GANG");
	pc.loadInMouth(impgang);
	applyCumSoaked(pc);
	applyCumSoaked(pc);
	
	if (inCombat()) {
		output("\n\n");
		processTime(15 + rand(5));
		CombatManager.genericLoss();
	}
	else addNextButton();
}