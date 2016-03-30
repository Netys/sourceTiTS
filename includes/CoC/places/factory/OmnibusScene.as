import classes.Characters.CoC.CoCOmnibusOverseer;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Omnibus Overseer
public function DemonFactoryOmnibusFight():void {
	//spriteSelect(16);
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("You strike a combat pose and prepare your [pc.mainWeapon].  She smiles and saunters around the desk, letting something bulbous and fleshy drop free from between her nether-lips.  You watch in shock as it hardens into a dick, growing right from where her clit should be.\n\nShe taunts, \"<i>Like what you see cow?  I'll be sure to visit you in the pens.</i>'\" \n\nAn unseen force closes the glass door to the north, preventing you from running away!");

	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCOmnibusOverseer());
	CombatManager.victoryScene(DemonFactoryOmnibusDefeated);
	CombatManager.lossScene(DemonFactoryOmnibusWon);
	CombatManager.displayLocation("OMNIBUS");

	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function DemonFactoryOmnibusAccept():void {
	//spriteSelect(16);
	clearOutput();
	clearMenu();
	processTime(1);
	
	output("She smiles, sauntering closer.  Your eyes widen in shock as her vulva are spread apart by something inside her.   A slick and growing cock emerges, sprouting from where her clit should be located.  She's a hermaphrodite.  You don't have time to contemplate the implications, as the demoness used your temporary distraction to sink a needle into your neck.  You sigh and black out almost instantaneously, letting her catch you with her strong arms and soft bosom.");
	
	addButton(0, "Next", DemonFactoryBadEndGeneric, null);
}

public function DemonFactoryOmnibusWon():void {
	kGAMECLASS.userInterface.showName("DEFEAT:\nOMNIBUS");
	DemonFactoryOmnibusDoBadEndPart1();
}

//Choose your poison
public function DemonFactoryOmnibusDefeated():void {
	kGAMECLASS.userInterface.showName("VICTORY:\nOMNIBUS");
	flags["COC.FACTORY_OMNIBUS_DEFEATED"] = 1;
	clearOutput();
	if(enemy.lustQ() > 99) {
		output("The omnibus trembles where she stands, her proud demonic dick twitching and pulsating as her desires totally overwhelm her.  The tainted nodules covering the purplish hermaphrodite's member ripple and swell from the base towards the tip, culminating with an explosive eruption of sticky, white demon-seed.  She moans with shame and pleasure, pumping larger and larger volumes of cum onto her office's floor.  She drops to her knees, too exhausted and ashamed by her premature orgasm to continue fighting.\n\n");
		
		output("\"<i>Ooooh no.  You can't tell the other demons I got off so easily!  I'll never live it down,</i>\" she cries, \"<i>You've beaten me, please if you let me go and promise not to tell the other demons I'll use my magic to give you a gift!  My magic is powerful, I can do nearly ANYTHING with it when the subject desires the changes.</i>\"\n\n");
	}
	else {
		output("The omnibus trembles and drops to her knees, utterly defeated.\n\n");
		output("\"<i>Please, if you'll let me go I could use my magics to give you nearly anything you want!  Just please don't tell the other demons what happened here, I'd never live it down,</i>\" she begs.\n\n");
	}
	
	output("What do you do?  You could use her boon increase the size of your endowments or maybe regain some of your lost humanity!  Or you could play it safe and turn down her offer.  Although then you'd have to decide to let her go or kill her.");
	
	clearMenu();
	addButton(0, "Grow Breasts", DemonFactoryOmnibusChooseBreasts, null, "Grow Breasts", "Grow a new pair of breasts if flat-chested or grow existing breasts. \n\nAnd receive something else.");
	addButton(1, "Grow Dick", DemonFactoryOmnibusChooseDick, null, "Grow Dick", "Grow a new penis. Somehow, you have a feeling that the new cock you'll receive won't be a normal cock. \n\nAnd receive something else.");
	addButton(2, "Normal Face", DemonFactoryOmnibusNormalFace, null, "Normal Face", "Normalize your face. This will also remove your horns or antennae and change your ears back to human ears! \n\nAnd receive something else.");
	addButton(3, "Normal Chest", DemonFactoryOmnibusNormalChest, null, "Normal Chest", "Normalize your chest. This will shrink breasts larger than E-cup to a reasonable size and remove their other unusual traits, if you have it. This will also change your skin to human skin. \n\nAnd receive something else.");
	addButton(4, "Normal Groin", DemonFactoryOmnibusNormalGroin, null, "Normal Groin", "Normalize your groin, removing any extra cocks and reset remaining cock to normal, if you have any. Or grow genitalia for genderless. \n\nAnd receive something else.");
	addButton(5, "Normal Legs", DemonFactoryOmnibusNormalLegs, null, "Normal Legs", "Turn your legs back to normal. This will also remove your tail, if you have any! \n\nAnd receive something else.");
	addButton(6, "More Lust", DemonFactoryOmnibusBoon, true, "Get unsatiable lust", "Be always ready for sex.\n\nDo you think it is really good idea?");
	addButton(8, "No (Let go)", DemonFactoryOmnibusLetGo, null, "Let her go", "Refuse the offer and let the demon go.");
	addButton(9, "No (Kill Her)", DemonFactoryOmnibusKill, null, "Kill her", "Refuse the offer and kill the demon instead.");
}

public function DemonFactoryOmnibusChooseBreasts():void {
	//spriteSelect(16);
	clearOutput();
	//Grow if none
	if(pc.breastRows.length == 0) {
		output("<b>Your chest swells out, forming rounded C-cup globes, capped with tiny erect nipples!</b>");
		pc.createBreastRow();
		pc.breastRows[0].breastRatingRaw = 3;
		pc.nippleLengthRatio = 0.75;
	}
	//Singular row - cup size + 3.  Nipple size to 1" if smaller.
	else if(pc.breastRows.length <= 1) {
		output("Your [pc.fullChest] tingle pleasantly as the magic takes effect.  You watch with fascination as they begin to swell up, like sponges exposed to water.  ");
		if (pc.isChestGarbed()) output("The top of your [pc.gear] is pulled tight by change, until your chest seems ready to burst free.  ");
		output("< b > You've gained 3 cup sizes!</b>  ");
		pc.breastRows[0].breastRatingRaw += 3;
		if(pc.nippleLengthRatio < .75) {
			pc.nippleLengthRatio = .75;
			output("Your [pc.nipples] grow hard and sensitive, becoming much more noticable");
			if (pc.isChestGarbed()) output(" inside your [pc.gear]");
			output(".  It appears your nipples are have grown larger to match.");
		}
	}
	//Multiple Rows...
	else {
		//Top row + 3, all other rows brought up to par.
		output("Your top [pc.breasts 0] tingle pleasantly as the magic takes effect.  You watch with fascination as they begin to swell up, like sponges exposed to water.  ");
		if (pc.isChestGarbed()) output("The top of your [pc.gear] is pulled tight by change, until your chest seems ready to burst free.  ");
		output("<b>You've gained 4 cup sizes!</b>  ", false);
		pc.breastRows[0].breastRatingRaw += 4;
		output("The next row of [pc.breasts 1] jiggle and tingle with even more pleasure than the first.  They pulsate for a few seconds, shrinking and growing rapidly until they settle at a size just below your top [pc.breasts 0].  ", false);
		pc.breastRows[1].breastRatingRaw = pc.breastRows[0].breastRatingRaw-1;
		if(pc.breastRows.length >= 3) {
			output("Your third group of [pc.breasts 2] seem to follow their sister's example, and settle tingle briefly before settling at a size just below the breasts above.  ");
			pc.breastRows[2].breastRatingRaw = pc.breastRows[1].breastRatingRaw-1;
		}
		if(pc.breastRows.length >= 4) {
			output("Your remaining [pc.breasts 3] feel so wonderful that you just can't resist cupping and squeezing them as they reshape to fit in perfectly with the rest of your breasts.  ");
			pc.breastRows[3].breastRatingRaw = pc.breastRows[2].breastRatingRaw-1;
			if(pc.breastRows.length == 5) pc.breastRows[4].breastRatingRaw = pc.breastRows[3].breastRatingRaw-1;
		}
		if(pc.nippleLengthRatio < .75) {
			pc.nippleLengthRatio += .5;
			output("Your [pc.nipples] grow hard and sensitive, becoming much more noticable");
			if (pc.isChestGarbed()) output(" inside your [pc.gear]");
			output(".  It appears your nipples are have grown larger to match.");
		}
	}
	output("\n\n", false);
	DemonFactoryOmnibusBoon();
}

public function DemonFactoryOmnibusChooseDick():void {
	//spriteSelect(16);
	clearOutput();
	//No dick?  Grow one!
	if(pc.cocks.length == 0) {
		pc.createCock(10);
		pc.shiftCock(0, GLOBAL.TYPE_DEMONIC);
		output("A sudden pressure builds in your groin.  You look down in wonder, more than a little turned on by the prospect of growing your own penis.  Your skin ripples and bulges outwards, the sensation turning from pressure to feelings of intense warmth.  The bump distends, turning purple near the tip as it reaches three inches in size.  You touch it and cry out with pleasure, watching it leap forwards another inch in response.  Your tiny dick's crown becomes more and more defined as it grows larger, until you have what looks like a normal six inch dick.  You sigh with happiness and desire at your new addition.  Before you can enjoy it, another wave of heat washes through you, making your new addition respond.  It grows painfully hard as it crests eight inches in length.  ");
		if(pc.cor() < 80) output("In horror you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your cock look more like a crazed sex-toy than a proper penis.  You pant and nearly cum as it lengthens one last time, peaking at ten inches long.  One last ring of nodules forms around the edge of your demon-dick's crown, pulsating darkly with each beat of your horrified heart.");
		else output("Curious, you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your penis look more like those amazing cocks you saw on demons!  You pant and moan in happiness as it lengthens one last time, peaking at ten inches long.  The excitement of possessing such a magnificent pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your new demon-dick's crown, you notice to your surprise that the liquid you ejaculated is pitch black!  But as your new cock pulsates darkly with each beat of your heart, the only thing you have on your mind is to try it out as soon as possible...");
	}
	else if(pc.cocks.length == 1) {
		if(pc.totalCocks(GLOBAL.TYPE_DEMONIC) < 1) {
			output("You smile, watching your [pc.cock] grow longer.  Inches of newfound dick-flesh erupt from your crotch in response to omnibus' dark magics.  Before you can play with your transformed tool, a wave of burning desire passes through you.  ");
			if(pc.cor() < 80) output("You watch in horror as the skin of your [pc.cock] turns shiny and purplish-black.  ");
			else output("Curious, you watch the skin of your [pc.cock] turn a shiny-dark purple.  ");
			pc.cocks[0].cLength(3 + rand(5));
			pc.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			if (pc.cor() < 50) {
				output("Corrupt nodules begin to spring up over its entire length.  <b>Your penis is transforming into a [pc.cock]!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the head.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crown of your [pc.cock], seemingly completing its transformation");
				if(pc.balls > 0) output(", until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes");
				output("!  ");
			}
			else {
				output("As you watch expectantly, tiny wriggling nodules begin to erupt from the purplish skin, like those magnificent cocks you saw on demons!  <b>Your penis is transforming into a [pc.cock]!<\b>  You pant and moan in happiness as it lengthens one last time.  As you stroke all of its amazing length with both hands, the excitement of possessing such a beautiful pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your [pc.cockHead], you notice that the squirts getting out of your cock-slit are not completely [pc.cumColor] and gradually become darker, the last drops being purple!");
				if(pc.balls > 0) output(" Your new [pc.cock] pulsates darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid which apparently has perverted them.");
				output(" You ponder what its purpose might be, but then you decide, as you stroke the huge, dark, bumpy shaft, that if this feels as good as this looks, it doesn't really matter.  ");
			}
		}
		else {
			output("Your [pc.cock] leaps forwards, taking to the dark magic with ease.  Inch after inch of new length erupts from your groin as your [pc.cock] gets longer and thicker.  It pulsates, as if promising dark pleasure as it settles into its new enhanced size.");
			pc.cocks[0].cLength(6 + rand(10));	
		}
	}
	if(pc.cocks.length > 1) {
		//Already has demoncocks
		if(pc.cockTotal(GLOBAL.TYPE_DEMONIC) == pc.cockTotal()) {
			output("Your [pc.cocksLight] leap forwards, taking to the dark magic with ease.  Inch after inch of new length erupts from your groin as your [pc.cocksLight] get longer and thicker.  They pulsate, as if promising dark pleasure as they settle into their new enhanced size.", false);
			temp = pc.cocks.length;
			while(temp > 0) {
				temp--;
				pc.cocks[temp].cLength(6 + rand(10));
			}
		}
		//Not yet full of demoncocks...
		else {
			output("You smile, watching your [pc.cocksLight] grow longer.  Inches of newfound dick-flesh erupt from your crotch in response to omnibus' dark magics.  Before you can play with your transformed pleasure tools, a wave of burning desire passes through you.  You watch");
			if(pc.cor() < 80) output(" in horror");
			else output(" curiously");			
			output(" as the skin of your [pc.cocksLight] turns shiny and purplish-black.  Corrupt nodules begin to spring up over the entire length of each dick.  ");
			temp = pc.cocks.length;
			while(temp > 0) {
				temp--;
				pc.shiftCock(temp, GLOBAL.TYPE_DEMONIC);
				pc.cocks[temp].cLength(3 + rand(5));
			}
			if (pc.cor() < 50) {
				output("<b>Your dicks are transforming into [pc.multiCocks]!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the heads.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crowns of your [pc.multiCocks], seemingly completing its transformation");
				if(pc.balls > 0) output(", until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes");
				output("!  ");
			}
			else {
				output("<b>Your dicks are transforming into [pc.multiCocks]!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the heads.  You pant and moan in happiness as they lengthen one last time.  As you stroke all of their amazing length with both hands, the excitement of possessing such a magnificent pleasure tool makes you cum. You lick your fingers eagerly, tasting your new purple cum, while a last ring of nodules forms around the crowns of your beautiful [pc.cocksLight].");
				if(pc.balls > 0) output("   Your new [pc.multiCocks] pulsate darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid which apparently has perverted them. You ponder what its purpose might be, but then you decide, as you stroke a huge, dark, bumpy shaft, that if they feel as good as they look, it doesn't really matter.  ");
			}
		}
	}
	DemonFactoryOmnibusBoon();
}

public function DemonFactoryOmnibusNormalFace():void {
	//spriteSelect(16);
	clearOutput();
	if(pc.hasHorns() || pc.hasAntennae()) {
		output("Your forehead itches intensely.  You cannot help but stratch madly at it.  ");
		if(pc.hasHorns()) {
			output("Your horns fall off, landing on the floor with a heavy thud.  ");
			pc.removeHorns();
		}
		if(pc.hasAntennae()) {
			output("Antennae pop free, and float lightly down towards the floor.  ");
			pc.removeAntennae();
		}
	}
	//EARS
	if(pc.earType != GLOBAL.TYPE_HUMAN) {
		output("Pain erupts from both sides of your head as your ears reform and move, returning to look like your old human ears!  ");
		pc.earType = GLOBAL.TYPE_HUMAN;
	}
	//Face
	if(pc.faceType != GLOBAL.TYPE_HUMAN) {
		output("Your facial structure rearranges itself into a normal human visage, exactly like yours was before you came to this horrid place.  ");
		pc.faceType = GLOBAL.TYPE_HUMAN;
		pc.clearFaceFlags();
	}
	DemonFactoryOmnibusBoon();
}

public function DemonFactoryOmnibusNormalChest():void {
	//spriteSelect(16);
	clearOutput();
	temp = 0;
	if(pc.breastRows.length > 1) {
		pc.removeBreastRow(1,pc.breastRows.length-1);
		output("Your chest tingles and begins to feel lighter.  You ");
		if (pc.isChestGarbed()) output("hastily pull open your [pc.upperGarmentOuter] ");
		output("and realize you only have [pc.fullChest] now!  ");
		if(pc.nippleLengthRatio > 1) {
			output("Your nipples shrink down to a more normal size.  ");
			pc.nippleLengthRatio = 1;
		}
		temp++;
	}
	//Size!
	if(pc.breastRows[0].breastRating > 7) {
		output("The weighty flesh that constantly hangs from your chest gets lighter and lighter, vanishing rapidly.  ");
		pc.breastRows[0].breastRating = 3 + rand(4);
		output("You now have [pc.fullChest].  ");
		temp++;
	}
	//Fix nips
	if(pc.nippleLengthRatio > 1) {
		output("Your nipples shrink down to a more normal size.  ");
		pc.nippleLengthRatio = 1;
		temp++;
	}
	if(pc.hasFuckableNipples()) {
		output("The vagina-like openings in your nipples close, sealing themselves shut.  ");
		pc.breastRows[0].fuckable = false;
		temp++;
	}
	if(pc.skinType != GLOBAL.SKIN_TYPE_SKIN) {
		output("The skin on your body itches intensely as it shifts into " + pc.skinTone + " skin.  ");
		pc.clearSkinFlags();
		pc.skinType = GLOBAL.SKIN_TYPE_SKIN;
		temp++;
	}
	//Nothing changed
	if(temp == 0) {
		output("You tingle briefly but feel no obvious change.  Your chest is already fairly human.");
	}
	DemonFactoryOmnibusBoon();
}

public function DemonFactoryOmnibusNormalGroin():void {
	//spriteSelect(16);
	//Temp used to track changes
	clearOutput();
	temp = 0;
	output("You feel a strange shivering sensation pass through you.  ");
	//Remove multiple.
	if(pc.cocks.length > 1) {
		output("All but one of your [pc.cocks] shiver and retract back towards your body.  When the process finishes you are left with only your [pc.cock].  ");
		pc.removeCock(1, pc.cocks.length - 1);
		temp++;
	}
	//Super long nerf
	if(pc.hasCock()) {
		if(pc.cocks[0].cLength() > 12) {
			output("A tingling sensation worms through your [pc.cock] as it shrinks down to a more modest eleven inches.  ");
			pc.cocks[0].cLength(11, true);
			temp++;
		}
		//Super thick nerf
		if(pc.cocks[0].cThicknessRatio() > 1.5) {
			output("Obscene thickness of your [pc.cock] withers down to more normal proportions.  ");
			pc.cocks[0].cThicknessRatio(1.5);
			temp++;
		}
		//Humanitize
		if(pc.cocks[0].cType != GLOBAL.TYPE_HUMAN && pc.cocks[0].cType != GLOBAL.TYPE_DEMONIC) {
			output("The inhuman appearance of your [pc.cock] shifts, the flesh rearranging itself into a more human configuration.  After a few seconds you have a very normal looking penis.  ");
			pc.shiftCock(0, GLOBAL.TYPE_HUMAN);
			pc.cocks[0].cType = GLOBAL.TYPE_HUMAN;
			temp++;
		}
		//If demon cocked....
		if(pc.cocks[0].cType == GLOBAL.TYPE_DEMONIC) {
			output("Your [pc.cock] tingles as the bumps begin to fade.  After a moment the flesh darkens, and every single nodule reappears.  <b>Your corrupt penis resisted the magic!</b>  ");
			temp++;
		}
	}
	//Balls shrink
	if(pc.ballSizeRaw > 5) {
		temp++;
		output("The [pc.balls] that constantly pull so heavily on your groin tingle and shrink down to a more managable size.  ");
		pc.ballSizeRaw = 2 + rand(3);
	}
	if(temp > 0) output("\n\n", false);
	//Vajajay
	for (var i:int = 0; i < pc.vaginas.length; i++) 
	{		
		if(pc.vaginas[i].wetness() > 2) {
			output("The constant fluids leaking from your " + pc.vaginaDescript(i) + " slow down, then stop.  ");
			pc.vaginas[i].wetness(2, true);
			temp++;
		}
	}
	//Being genderless isn't normal too...
	if (!pc.hasGenitals()) {
		if (pc.balls > 0 || pc.femininity < 35 || rand(3) == 0) {
			pc.createCock(10);
			pc.shiftCock(GLOBAL.TYPE_DEMONIC);
			output("A sudden pressure builds in your groin.  You look down in wonder, more than a little turned on by the prospect of growing your own penis.  Your skin ripples and bulges outwards, the sensation turning from pressure to feelings of intense warmth.  The bump distends, turning purple near the tip as it reaches three inches in size.  You touch it and cry out with pleasure, watching it leap forwards another inch in response.  Your tiny dick's crown becomes more and more defined as it grows larger, until you have what looks like a normal six inch dick.  You sigh with happiness and desire at your new addition.  Before you can enjoy it, another wave of heat washes through you, making your new addition respond.  It grows painfully hard as it crests eight inches in length.  ");
			if (pc.cor() < 80) output("In horror you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your cock look more like a crazed sex-toy than a proper penis.  You pant and nearly cum as it lengthens one last time, peaking at ten inches long.  One last ring of nodules forms around the edge of your demon-dick's crown, pulsating darkly with each beat of your horrified heart.");
			else output("Curious, you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your penis look more like those amazing cocks you saw on demons!  You pant and moan in happiness as it lengthens one last time, peaking at ten inches long.  The excitement of possessing such a magnificent pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your new demon-dick's crown, you notice to your surprise that the liquid you ejaculated is pitch black!  But as your new cock pulsates darkly with each beat of your heart, the only thing you have on your mind is to try it out as soon as possible...");
			if (pc.balls == 0) {
				pc.balls = 2;
				output("\n\nIncredible pain scythes through your crotch, doubling you over.  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
				pc.ballSizeRaw = 1;    
			}
		}
		else {
			pc.createVagina();
			output("An itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new [pc.vagina]</b>!");
		}
		temp++;
		output("\n\n");
	}
	//Reduce excessive anal wetness
	if (pc.ass.wetnessRaw > 2) { 
		output("The constant fluids leaking from your [pc.asshole] slow down, then stop.  ");
		pc.ass.wetnessRaw = 2;
		temp++;
	}

	//Nothing changed
	if(temp == 0) {
		output("You tingle briefly but feel no obvious change.  Your crotch isn't really in need of becoming more human.");
	}
	
	DemonFactoryOmnibusBoon();
}

public function DemonFactoryOmnibusNormalLegs():void {
	//spriteSelect(16);
	clearOutput();
	if (pc.legType == GLOBAL.TYPE_HUMAN && pc.legCount == 2) 
		output("You feel as if you should slap yourself for stupidy.  Your legs are already normal!  You flush hotly as the corrupt magics wash over you, changing nothing.");
	else 
		output("You collapse as your [pc.legs] are unable to support you.  The sounds of bones breaking and reshaping fills the room, but oddly you feel no pain, only mild arousal.  You blink your eyes and sigh, and when you look down again <b>you have two normal human legs</b>!");
	pc.legType = GLOBAL.TYPE_HUMAN;
	pc.legCount = 2;
	pc.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
	
	if(pc.hasTail()) {
		output("  A moment later, your feel something detach from above your backside.  <b>You no longer have a tail!</b>");
		pc.removeTails();
	}
	
	DemonFactoryOmnibusBoon();
}

public function DemonFactoryOmnibusBoon(willing:Boolean = false):void {
	if (willing) {
		clearOutput();
		output("The omnibus disappeared while you were examining the changes.  You guess you did get what you wanted.  You blush and smile, feeling very horny.  You decide to use the privacy of the office to relieve the tension you've been building up since you arrived.\n\nYou masturbate quickly and efficiently, eager to calm down and resume your exploration.  In no time at all an orgasm crashes through your body.  Stretching and standing up, you find yourself still aroused.\n\nYou've got exactly what you were asking for - <b>the demoness' magic is keeping you from ever being totally satisfied!</b>\n(Perk Gained - Omnibus' Gift - Minimum lust has been increased!)\n\n");
	}
	else
		output("The omnibus disappeared while you were examining the changes.  You guess you did get what you wanted.  You blush and smile, still feeling very horny.  You decide to use the privacy of the office to relieve the tension you've been building up since you arrived.\n\nYou masturbate quickly and efficiently, eager to calm down and resume your exploration.  In no time at all an orgasm crashes through your body.  Stretching and standing up, you find yourself still aroused.\n\nYou slap your forehead as realization washes over you - <b>the demoness' magic is keeping you from ever being totally satisfied!</b>\n(Perk Gained - Omnibus' Gift - Minimum lust has been increased!)\n\n");
	if (!pc.hasPerk("Omnibus' Gift")) pc.createPerk("Omnibus' Gift", 0, 0, 0, 0, "Increases minimum lust but provides some lust resistance.");
	output("\n\n");
	pc.orgasm();
	pc.cor(2);
	
	processTime(30);
	CombatManager.genericVictory();
}

public function DemonFactoryOmnibusLetGo():void {
	//spriteSelect(16);
	clearOutput();
	output("You refuse to fall for her ploy, and decide not to take her up on her offer.  However, being that she is so thoroughly defeated, you allow her to escape, promising her far worse should she ever oppose you in the future.\n\n\"<i>Thank you, merciful hero!</i>\" she says and she sprints out the door.  Wings unfurl from her back and she takes flight, disappearing out a skylight above the main factory floor.\n\n");

	processTime(10);
	CombatManager.genericVictory();
}
public function DemonFactoryOmnibusKill():void {
	//spriteSelect(16);
	clearOutput();
	output("You step forwards and grab her by the head.  With an abrupt twist you snap her neck, ending at least one small part of the demonic threat.\n\n");
	flags["COC.D1_OMNIBUS_KILLED"] = 1;

	processTime(10);
	CombatManager.genericVictory();
}

public function DemonFactoryOmnibusDoBadEndPart1():void {
	if(pc.HP() <= 1) output("You stagger into the desk, clutching tightly just to stay upright.  ");
	else output("Forgetting about the fight, you lean on the desk and slide your free hand under your [pc.gear], seeking any pleasure you can get.  ");
	output("Sensing victory, the demoness sidles up next to you and pushes you into a chair.  Incapable of resisting, all you can do is watch");
	if (pc.hasArmor()) output(" as she opens your [pc.armor] for easier access");
	output(".  She steps back and admires her handiwork as she gives you a thorough looking over.\n\n");  
	output("\"<i>I have just the thing for a " + pc.mf("man", "woman") + " such as you.  I've been crossbreeding the parasites that developed in the deep jungle, trying to create the PERFECT slave-maker.  You get to be my first test subject,</i>\" she says.\n\n");
	output(" She sees the look of fear creeping into your eyes and pats you comfortingly, \"<i>Awww don't worry. It'll feel REALLY good.  If anything you should feel honored to be assisting an Omnibus in her experiments.</i>\"\n\n");
	output(" She opens one of the desk drawers, and searches briefly before her eyes light up with recognition.  \"<i>Here we are,</i>\" she says as she pulls something free...");
	doNext(DemonFactoryOmnibusDoBadEndPart2);
}

public function DemonFactoryOmnibusDoBadEndPart2():void {
	clearOutput();
	//(Multi dicks)
	if(pc.cocks.length > 1) {
		output("In her hand is a mass of shining green material.  She turns to face you, bringing it closer and letting you see the lights shift and change on its luminescent surface.\n\n");
		output("\"<i>For someone as... different as you, we will have to try this creature.  I've bred it from a mixture of plant-tentacles, dazzle-weed, and what we've taken to calling pussy plants,</i>\" she mentions, her hands working to open the mass on the table.  The interior surface is a mass of slimy undulating protrusions that wriggle feverishly as they are exposed to the air.  She gathers up the thing in her arms while continuing to speak to you, \"<i>You see, my plant will encapsulate your members tightly, wrapping them in sticky wetness.  Its fluids are a perfect blend of aphrodisiacs, lubricants, and will-sapping narcotics.  You'll love it.</i>\"\n\n");
		output("You make a desperate attempt to escape her chair, but your body fails to do much more than squirm in place.  She drops the creature squarely into your crotch and hops up onto her desk to watch.  Thousands of tiny wet nodules immediately begin massaging your [pc.cocksLight]");
		if(pc.balls > 0) output(" and [pc.balls]");
		output(".  You groan as the pleasure washes over you like a wave.  Your squirming stops as your hips begin twitching into the air, as if begging for even more stimulation.  It's not fair how good this feels... you can't help it, it's just too hard to fight.\n\n");
		output("You watch with detached fascination as each of your [pc.cocks] is wrapped tightly in shiny green material.  The shape of each penis is still clearly defined under the pulsating green stuff, though you can see it shifting and rippling over your lengths as it pleasures you.  It almost looks like some kind of kinky bondage-toy.  Aware of your attentions, the green stuff squeezes you tightly and begins flashing beautiful bioluminescent color patterns across its surface that scatter your thoughts as you watch.  You blink a few times as the green mass rolls more of itself out, curling over your ");
		if(pc.balls > 0) {
			output("balls");
			if(pc.vaginas.length > 0) output(" and [pc.vagina]", false);
		}
		else if(pc.vaginas.length > 0) output("[pc.vagina]", false);
		else output("[pc.asshole]");
		output(", sliding up your abdomen, and oozing down over your hips.  As it spreads the colors fill more and more of your head, clearing away your thoughts of resistance.\n\n");
		output("A soothing female voice talks to you from somewhere, \"<i>Did I mention it's specifically tuned to ensnare the conscious mind with it's pretty colors?  I must have forgot.  Well, I see you've discovered it on your own.  The colors are just so perfect for opening your mind to me, aren't they?  They just chase away your thoughts and let my words slip deep into your subconscious.  I bet it feels nice to just focus on the colors and let my pet tease your cocks, doesn't it?</i>\"\n\n");
		output("You nod without any awareness of the act.\n\nThe voice laughs and continues while the creature reaches around your [pc.hips] and slides a feeler between your cheeks, completing the tight loop around your groin, \"<i>That's good.  You want to let the creature cover as much of you as it wants.  Being sex-food for a symbiotic plant is arousing beyond measure.</i>\"  You feel the creature licking at your [pc.asshole] until it relaxes, and then slides something inside.  A warm wetness spreads through your bowels as something begins caressing your prostate from inside you.\n\n");
		output("Overloaded with pleasure, you feel your [pc.cocksLight] pulse and cum, creating translucent green cum balloons the size of ");
		if(pc.cumQ() < 50) output("apples ");
		if(pc.cumQ() >= 50 && pc.cumQ() < 300) output("cantaloupes ");
		if(pc.cumQ() >= 300) output("watermelons ");
		output("at the end of each of your dicks.  The creature's flashing intensifies while your hips quake uncontrollably, pumping the last of your load feeds into the wonderful plant.  The light-show grows brighter, totally emptying any remaining stray thoughts and leaving you feeling wonderfully open.\n\n");
		output("\"<i>Being used for your cum is great,</i>\" says the voice and you agree, it is great.\n\n");
		output("\"<i>Your greatest fetish is allowing demonic creatures to feed on your cum,</i>\" she says, and it feels so right.  Your cum is meant for demons and plants to feast on.  Just the thought makes you want to orgasm again.\n\n");
		output("\"<i>Since you provide food-source, that must make you livestock.  You like being livestock.  Livestock don't have to think.  Livestock follow orders.  Best of all, as livestock you can live your favorite fetish of being milked of all your cum, every hour of every day,</i>\" the voice says, filling your mind with new thoughts.  Of course it's right, you can just let a demon or tentacle plant milk you and do all the hard stuff, like thinking.  All you have to do is cum.  The thought makes you shiver as the plant-suit absorbs the encapsulated bubbles of jizz.  The dazzling lights grow even brighter as it takes in the nutrients.\n\n");
		output("*FLASH* \"<i>You want to cum for the plant.</i>\"\n\n");
		output("Tendrils of plant crawl up your belly, coating you in slime as they massage every inch of you.\n\n");
		output("*FLASH* \"<i>You need to cum for the plant.</i>\"\n\n");
		if(pc.breastRows.length == 1) output("They reach the lower curve of your breasts.\n\n");
		if(pc.breastRows.length > 1) output("They slide over your lowest pair of breasts, encapsulating them in wriggling tightness.\n\n");
		output("*FLASH* \"<i>You love cumming for anything and anyone.</i>\"\n\n");
		if(pc.breastRows.length == 3) output("Your middle breasts tingle with absolute pleasure as they too become engulfed in tightness.\n\n");
		if(pc.breastRows.length == 2) output("You groan as the plant grows up the summit of your top breasts, coating the bottom half of your aureola.\n\n");
		if(pc.breastRows.length == 1) output("Your [pc.nipples] become hard as steel as the wave of slick pleasure washes over them.\n\n");  
		output("*FLASH* \"<i>You love being told to orgasm.</i>\"\n\n");
		if(pc.breastRows.length == 1) output("The wriggling mass slides up the top-most parts of your breasts, narrowing into two tiny tendrils that loop around your neck.\n\n");
		if(pc.breastRows.length >= 2) output("The wriggling mass climbs your top pair of breasts with ease, wrapping your diamond-hard nipples in slime and sensation.  It continues climbing upward, narrowing into two bands that loop around the back of your neck.\n\n");
		output("*FLASH* \"<i>To orgasm is to obey.  You love to orgasm.  You love to obey.  You love to obey my voice more than any other.  Obeying my voice gave you these orgasms.  Since you love to obey me, you must be my pet.</i>\"\n\n");
		output("Your mistress' OTHER pet wraps around your neck, forming a choker comprised of shifting green colors.  You smile as you realize it is done - you've become one of her pet cattle.  Your body is wrapped in an emerald sea of shifting pleasure, just like your mistress wanted.  If it weren't for the obvious bulges of your [pc.cocksLight], you'd look to be wearing an extraordinarily revealing one piece swim-suit.  The constant teasing at your crotch continues, and you stay rock-hard, even though you just came.  The idea of being milked to feed your new clothing just turns you on so much that you bet you're leaking constant streams of pre-cum for your new green master.\n\n");
		output("The flashing subsides, and your new thoughts rush into the void.  You immediately begin masturbating your encapsulated members as you seek to obey.  To orgasm is to obey.  To obey is to orgasm.  You discover that you can feel every touch through the skin of your 'clothing'.  You increase the tempo, knowing that your orgasm will be feeding the creature that now lives on you, fulfilling your deepest darkest desires.  You cum again, just as hard as before, inflating " + num2Text(pc.cocks.length) + " shiny green balloons with the proof of your obedience.\n\n");
		
		//if(pc.findStatusAffect(StatusAffects.CampMarble) >= 0) {
			//output("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n");
			//output("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first...\"\n\n");
		//} else 
		
		output("Your mistress looks down with approval and speaks, \"<i>Very good.  ");
		output("I want you to stay here and cum 'til morning.  My pet needs lots of nutrition to recharge, and I have plans for new ways to teach you to obey tomorrow.</i>\"\n\n");
		output("Happy to have such a wonderful task, you spend the next day being bathed in drugged aphrodisiacs, cumming over and over and over.  Every morning the creature flashes you into obedience while the voice teaches you more and more about how to think.  After a week you're the perfect pet.  By the end of your first month of servitude, any memories of your past life are gone.  You spend the rest of your days feeding your mistress and her pet, and helping her refine and breed her pets in order to teach others the way.");
		badEnd();
		return;
	}
	//Dick version
	if(pc.cocks.length == 1) {
		output("In her hand is a squirming purplish mass.  It has a smooth outer surface, spotted with dark shades of iridescent purple. The opposite side is comprised of a smooth mucusy membrane covered with wriggling pink cilia.\n\n");
		output("She leans over you with a predatory smile, \"<i>This little guy is my favorite.  I've even given him a bit of 'field testing'.</i>\"  She gestures towards a small dripping orifice, explaining, \"<i>You see, once I put this on you, it'll open up niiice and wide.  It'll suck your nice little cock into its mouth and starting squeezing and massaging you with each of its tiny tentacles until you can't help but release all your ");
		if(pc.cor() < 33) output("sweet ");
		if(pc.cor() >= 66) output("tainted ");
		output("sexual energies deep into its gullet.  And that's just the start!</i>\"  Her hands let go of the squirming mass, dropping it squarely into your lap.\n\n");
		if(pc.cocks[0].cLength() < 15) output("With one swift motion, the beast engulfs your [pc.cock] in its slimy maw.  ");
		else output("Distending obscenely, the beast starts engulfing your [pc.cock] in its slimy maw, progressing along its entire length until you can no longer see your pleasure tool.  ");		
		output("The slimy tentacles waste no time, massaging you with mechanical precision.  You groan in helpless pleasure, growing to painful hardness within the squirming confines of the creature.  Three protrusions sprout from the creature's core, dripping with slime of their own, and covered on the inside with the same wriggling protrusions that now massage your trapped member.  Two curl around your [pc.hips], while the last one");
		if(pc.balls > 0) output(" smothers your balls, entrapping them in sticky sensation as it continues across your taint between your butt-cheeks.  ");
		else output(" journeys over your taint before travelling between your butt-cheeks.  ");
		output("The three tendrils join together in the back, forming a seemless tiny purple triangle.  It really rides up high, tickling your [pc.asshole] with constant teasing.  You're wearing an organic purple thong!\n\n");
		output("You try to endure, but the humiliation is too much for you to take.  The pleasure and shame push you past your limit.  You let out a squeal of mixed agony and delight as the proof of your pleasure boils out into the creature.  You pant and twitch, helpless to resist the strength of your orgasm as your jism fills the creature, distorting it visibly around your member.  Sighing, you relax as the assault winds down, the squirming tentacles relaxing noticeably as they work to digest their 'meal'.\n\n");
		output("\"<i>Enjoy yourself?  The best part is about to start,</i>\" she says with an evil glint in her eye.  You sit bolt upright as your living thong squirms and shifts, pressing something rigid against the ring of your [pc.asshole].  You reach down, trying to pull the creature off, but its outer covering is surprisingly hard, and seals almost perfectly against your [pc.skinFurScales].  You look up with terror in your eyes, a pleading look painted across your face.\n\n");
		output("She cocks her head to the side with an inquisitive look and asks, \"<i>So it's found your back door I take it?</i>\"  You nod sheepishly, squealing as the rigid growth pushes through your sphincter, violating you completely.  She continues with a nonchalant tone, though her eyes seem to be drinking in the scene, \"<i>That thing you feel drilling into your ass?  It's a carefully evolved injection appendage.  Don't worry, once it settles in it won't move much.  It's just going to get nice and cozy with your prostate and a few major blood vessels.  Then it's going to reward you for cumming!</i>\"\n\n");
		output("You feel it burrow a little deeper, and then curve up.  It presses against something inside of you in a way that makes your [pc.cock] twitch uncontrollably.  You're sure that if it weren't for the greedy tentacle-panties around your dick you would've seen a huge dollop of pre-cum squeeze out.  Filled with angst and worry as to what is to come, you ask, \"<i>Ummm, h-h-how is it going to reward me?</i>\"\n\n");
		output("She winks, petting the mottled surface of your purple-cock-prison as you feel a sensation of warm wetness in your backside.  At the same time you nearly jump as you feel a painful pinch in your prostate.  The demoness licks her lips and answers, \"<i>Well, it rewards you in two ways pet.  One:  It empties a specially designed cocktail of drugs directly into your bowels, where they'll be absorbed slowly into the body.</i>\"  As if on cue a gentle warmth spreads through your torso, radiating out into your limbs, and settling like calming mist in your head.  You relax utterly, enjoying the feeling in spite of your worries.\n\n");
		output("She coos, petting your still-hard member and the creature around it.  Miraculously you can feel both the touch of her silky fingers and the constant pleasurable squirming of the panties themselves.  You twitch your [pc.cock] against her hand, giggling happily.\n\n");
		output("\"<i>That's right, it's a good reward isn't it?</i>\" she asks as she continues to fondle you, \"<i>those drugs are making you docile and extraordinarily suggestible.  For instance – every time I talk you can feel my hands caressing and fondling your member");
		if(pc.balls > 0) output(" and teasing your balls");
		output(".  You see?  I'm not even touching you anymore and you're still twitching.  My my, what an obedient slave you're going to be.</i>\"\n\n");
		output("You pant and groan while she talks to you, still feeling the combined efforts of the panty-creature and your master's wonderful hands, \"<i>And I haven't even told you about the second part of your reward.  If you want me to tell you, you'll need to admit out loud what we both already know – that you're my obedient slave-toy.  Say it toy.</i>\"\n\n");
		output("\"<i>I-I-I'm your obedia—ahhh-nt s-s-lave toy,</i>\" you moan.  As soon as the words leave your mouth, you know it's true, but that settles in the back of your mind.  You're eager to know how the creature and your mistress will reward you for being such an obedient-toy.  And of course, to get her talking again so you can feel those smooth fingertips caress you once more.\n\n");
		output("\"<i>You really are my good toy already, aren't you?</i>\" she muses, \"<i>You just love pleasing, me don't you toy?</i>\"  You nod feverishly, eliciting a happy laugh from your mistress as she lectures you, \"<i>The second part of your reward is an injection of its venom directly into your prostate.  You may not have noticed with the constant teasing your cock is enduring, but by now your prostate should have doubled in size.  If I ever separate you and your training-suit, you'll notice you're producing so much pre-cum that it's dribbling out ALL the time.  Your orgasms won't get much bigger, but you'll find yourself pouring out pre as you get more and more turned on.  After all, my baby here needs to feed.</i>\"\n\n");
		output("Your mistress pats your obscene purple panties tenderly and whispers in your ear, \"<i>Be a good toy and cum for mistress.</i>\"  You smile broadly as your hips piston in the air, as if fucking an imaginary twat.  Cum boils out from your ", false);
		if(pc.balls > 0) output("[pc.balls] and ");
		output(" over-sized prostate, filling the chamber around your cock with thick blasts of seed.  You smile happily as the tentacle-chamber distorts to hold your load, bulging out into a more spherical appearance.  You slump down as your orgasm finishes and you begin to feel even more 'reward' fill your now greedy-hole.\n\n");
		//if(pc.findStatusAffect(StatusAffects.CampMarble) >= 0) {
			//output("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
			//output("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first...</i>\"\n\n", false);
		//}
		output("Your mistress pats your head and whispers commands in your ear while the now-sated slave-making creature devours your cum, turning it into more 'reward'.  You don't pay attention to her words, what's important is serving mistress and cumming for your panty-toy as often as possible.  You don't need to worry, she will tell you what to think.  She's just so perfect and amazing, you don't know why anyone would want to harm her or her wonderful creations.  'Gods it feels good to obey' is the last thought your mind ever thinks for itself.\n\n");
		output("In the days to come, you spend your time being teased by your new mistress until you feel as if you'll burst, then being brought to sudden explosive orgasms that fill your panty-prison to capacity.  After every session you black out, but each time you mind less and less.  You wanted to be here, having these wonderful orgasms and obeying your beautiful mistress.\n\n");
		output("After a month she starts letting you live without your favorite panties.  You beg her to put them back on you, but she often makes you crawl around the factory, pooling pre-cum everywhere from your swollen prick as you beg her to be put back into the pleasure-panties.  Sometimes, if you're lucky, she'll fuck you, or send you out to catch another adventurer.  There is nothing you love more than cumming into your tentacle-panties while another one of your mistress' creations teaches a slut how to embrace her true nature.");
		badEnd();
		return;
	}
	//(Female) 
	if(pc.hasVagina() || !pc.hasGenitals()) {
		output("In her hand is a seamless pair of panties.  Their surface reflects light perfectly, as if its bright pink surface were coated in slippery oil or made from latex.  ");
		if(!pc.hasGenitals()) {
			output("The demoness smiles with wicked intent and yanks the bottoms of your [pc.gear] the rest of the way off.  Your lack of genetalia does not faze her, and she responds by swiftly pulling out a needle and injecting your groin.  In seconds your crotch splits open, revealing a fresh virgin vagina.  Licking her perfect lips with anticipation, she inverts the panties and holds them up for you to see.\n\n");
			pc.createVagina();
		}
		else {
			output("The demoness smiles with wicked intent");
			if (pc.isCrotchGarbed()) output(" and yanks your [pc.gear]'s bottom the rest of the way off");
			output(".  She leans close, smiling and inhaling the scent of your sex, savoring it like a aroma of a fine wine.  Licking her perfect lips with anticipation, she inverts the panties and holds them up for you to see.\n\n");
		}
		output("They aren't panties at all, but instead some living creature.  The entire inside surface of the living garment is covered with fleshy pink nodules that wriggle constantly, practically dripping with a pungent lubricant that smells not unlike your own juices.  Horrifyingly, there is a large lump of flesh towards the front.  Its surface is ribbed and pulses, constantly swelling and shrinking.  It's clearly designed to enter the passage of anyone who wears it.  Worse yet is a smaller narrower protrusion on the backside.  This... creature... will certainly do its best to plug both your holes.\n\n");
		output("Your captor pulls it back and leans closer, letting the scent of her own fragrant puss fill the air.  It smells tangy and sweet and makes you ");
		if(pc.vaginas[0].wetness() < 3) output("wet ");
		else if(pc.vaginas[0].wetness() < 4) output("drip on the chair ");
		else output("soak the chair ");
		output("from the heady taste that clings to your nostrils.  She speaks with confidence, \"<i>You needn't worry my dear.  I call this little creature my slut-panties.  You see, when you wear them they will stimulate every part of you.  They'll suck on your clit while the two large mounds grow inside you, filling you with wriggling pleasure.  Their slime is a wonderful lubricant and a mild aphrodisiac.  Between the constant touches and its secretions, you'll be horny and on the edge of orgasm in no time.</i>\"\n\n");
		output("You shake your head in desperate denial and start to cry as you realize she intends to keep you locked in some kind of hellish pleasure-prison.  The panties slide up your legs with ease, and with a swift movement, the demon lifts your ass up and slips them into position with a wet 'SQUELCH'.  You moan as it goes to work, wrapping your [pc.clit] in slippery tightness.  The two 'lumps' you observed elongate, the ridged surfaces making your [pc.vagina] quiver and dance with pleasure.  In mere seconds you're panting hotly and ready to cum.  Your crying devolves into heated moans of pleasure and longing.\n\n");
		output("Bright red eyes fill your vision as the beautiful visage comes closer.  She whispers hotly in your ear, \"<i>I bet it feels good doesn't it?  Do you feel wet and horny?  I bet you'd love to throw yourself on my cock and get off right now.</i>\"\n\n");
		output("You blink away the tears and nod frantically; you're so close!  But every time you feel an orgasm start to build the creature eases up just enough to keep you away from your orgasm.\n\n");
		output("\"<i>You see, these panties are attuned to our kind.  I've worked hard to breed a pair that could be taught to only provide release when a demon cums in or on them.  Fortunately for you, the nodules will actually open to allow a demon's dick in either passage.  And just for our succubi friends, they can grow a protrusion from the front, and transmit the sensations to you,</i>\" she says as she demonstrates by bringing her throbbing purplish prick close to your pink-enclosed groin.  The surface of the panties splits with a line down the front, reshaping to reveal your pink-covered camel-toe.\n\n");  
		output("She asks, \"<i>I won't be a rapist my dear.  This cock will only enter you if you desire the pleasure it can bring you.  You could say no and just enjoy being on the edge until your will finally crumbles.</i>\"\n\n");
		//if(pc.findStatusAffect(StatusAffects.CampMarble) >= 0) {
			//output("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
			//output("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first, didn't you want something from me?</i>\"\n\n", false);
		//}
		output("It takes less than a second for you to moan out, \"<i>Taaaaake meeeee!</i>\"\n\n");
		output("She smiles and lifts you up from the chair with her strong arms, and sits down on the desk.  She lowers your symbiote-covered lips onto her demon dick and coos with delight as you slide down her length, taking the entire thing in your greedy depths.  If anything, the creature inside you makes sex even better - you feel a combination of her nub-covered cock fucking you and the ridges of the panty-creature as it continues to stimulate you.  It drives you mad with pleasure, and you begin bouncing yourself up and down, spearing your [pc.vagina] with the demon's pole.\n\n");
		output("She giggles and reaches down.  Too aroused to care, you just keep fucking her and moaning in delight.  Her hands come up and begin to massage and rub your [pc.fullChest] taking special care to tweak and tug on your nipples.  They become as hard as ");
		if(pc.nippleLength() < .5) output("erasers ");
		else if(pc.nippleLength() < 3) output("bullets ");
		else output("tiny cocks ");
		output("in moments");
		if(pc.isLactating()) output(" and start to drip with milk");
		output(".  You sigh with disappointment when her hands drop away.  You were so close to orgasm.  She reaches back up and places something wet and warm on ");
		if(pc.breastRows.length <= 1) output("your [pc.nipples]");
		if(pc.breastRows.length > 1) output("your top [pc.nipples]");
		output(".  You look down and see " + num2Text(pc.breastsPerRow(0)) + " star-shaped creatures made of glistening pink (just like your panties!) attached to your [pc.nipples].  They pulse and ripple as they constantly massage and suck.  ");
		if(pc.isLactating()) output("Your [pc.milk] erupts, spraying out from a tiny hole in the center of the star.  In response the creature increases the force of its sucking action, making you fountain milk constantly.  ");
		if(pc.breastRows.length > 1) output("While you continue to fuck that meat pole and watch the creatures squirming on your nipples, more are affixed to each of your remaining [pc.nipples], until every single one is covered with its own tiny pleasure-creature.\n\n");
		output("A flood of hot demonic spunk unloads into your aching [pc.vagina], filling you with warmth.  The panty-plug in your backside seems to erupt as well, dumping a flood of undiluted aphrodisiacs into your body.  You squeal and cum, your eyes rolling back with pleasure as you sink down on the quivering member of your captor.  You twitch and moan, orgasming for far longer than the dick inside of you.  The pleasure goes on for minute after minute.  Your [pc.nipples] each radiate satisfaction and pleasure as they manage to provide you with miniature orgasms of their own.  You moan, feeling relief at last and losing yourself in the wave of satisfaction that fills your body.\n\n");
		output("You blink a few times, and sit up, finding yourself back in the chair.  Your pink panty-creature has closed back up, trapping the demon's cum inside you.  The corrupted seed is so potent you can actually feel it tainting your body further as it spreads into your core.  You stretch languidly as you try to recover from the best orgasm of your life.  Perhaps you can escape?  No, you can't leave, the panties are already massaging your aching cunt and toying with your still-hard [pc.clit].  You squirm as it effects you, ramping your body's desires back up to the max.  Maybe if you take a load in the front AND back at the same time it'll sate the creature long enough for you to escape....\n\n");
		output("You set off into the factory, looking for the Omnibus and an Incubus to help.\n\n");
		output("<b>One month later:</b>\nYou lick the demonic jism from your lips and stretch, happy your mistress provided you with your fifth orgasm of the morning.  Normally she only lets her favorite slut get her off three or four times before lunch.  You squirm as your panties go to work, taking you back to that wonderful plateau of pleasure that only your masters and mistresses can bring you down from.  Thinking back, this really is the best way for things to end.  You thank your mistress and ask if you can see if any of the imps want to knock you up again.  She smiles condescendingly and nods, making your cunt squeeze with happiness.  Imps have such great cum!");
		badEnd();
		return;
	}
}