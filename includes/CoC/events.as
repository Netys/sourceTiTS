import classes.GameData.Pregnancy.PregnancyManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function EventsAdopterHellNotify():void {
	////////////////////////////////////////////////////
	////    BRO BREW AND BIMBO LIQUOR PROCESSORS    ////
	////////////////////////////////////////////////////
	var tmp:Number;
	if (pc.hasPerk("Futa Form")) { //Futa checks
		tmp = pc.hasPerk("Futa Faculties") ? 10 : 6;
		if (!pc.hasCock() && !pc.hasStatusEffect("Goo Crotch")) { //(Dick regrowth)
			pc.createCock(tmp);
			pc.shiftCock(0, Mutator.guessCockType(pc));
			eventBuffer += "\n\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new [pc.cock] pulses happily.";
			//if (pc.balls == 0) {
				//eventBuffer += "  A pair of heavy balls drop into place below it, churning to produce cum.";
				//pc.balls = 2;
				//pc.ballSizeRaw = int(3 * Math.PI);
			//}
			pc.slowStatGain("i", -1);
			pc.lust(15);
			eventBuffer += "</b>";
		}
		tmp = pc.hasPerk("Futa Faculties") ? 8 : 6;
		if (pc.longestCockLength() < tmp && !pc.hasStatusEffect("Goo Crotch")) { //(Dick rebiggening) 
			eventBuffer += "\n\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at 8 inches long.  You really have no control over your dick.</b>";
			pc.cocks[pc.longestCockIndex()].cLength(tmp, true);
			if (pc.cocks[pc.longestCockIndex()].cThicknessRatio() < 1) pc.cocks[pc.longestCockIndex()].cThicknessRatio(1, true);
		}
		//if (pc.balls == 0) { //(Balls regrowth)
			//eventBuffer += "\n\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath [pc.eachCock] grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>";
			//pc.balls = 2;
			//pc.ballSizeRaw = 3 * Math.PI;
		//}
		tmp = pc.hasPerk("Futa Faculties") ? 5 : 3;
		if (pc.breastRows.length > 0 && pc.breastRows[0].breastRatingRaw < tmp && !pc.hasStatusEffect("Gel Body")) { //Tits!
			pc.breastRows[0].breastRatingRaw = tmp;
			if (pc.isBimbo())
				eventBuffer += "\n\n<b>Your tits get nice and full again.  You'll have lots of fun now that your breasts are back to being big, swollen knockers!</b>";
			else eventBuffer += "\n\n<b>Your " + pc.breastDescript(0) + " have partially regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>";
			pc.slowStatGain("i", -1);
			pc.lust(15);
		}
		if (!pc.hasVagina() && !pc.hasStatusEffect("Goo Crotch")) { //Vagoo
			pc.createVagina();
			pc.shiftVagina(0, Mutator.guessVagType(pc));
			if (pc.isBimbo())
				eventBuffer += "\n\n<b>Your crotch is like, all itchy an' stuff.  Damn!  There's a wet little slit opening up, and it's all tingly!  It feels so good, why would you have ever gotten rid of it?</b>";
			else eventBuffer += "\n\n<b>Your crotch tingles for a second, and when you reach down to feel, your [pc.legs] fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>";
			pc.slowStatGain("i", -1);
			pc.lust(15);
		}
	}
	
	if (pc.hasPerk("Bimbo Body") || pc.hasStatusEffect("Bimbo Champagne")) { //Bimbo checks
		tmp = pc.hasPerk("Bimbo Brains") ? 5 : 3;
		if (pc.breastRows[0].breastRatingRaw < tmp && !pc.hasStatusEffect("Gel Body")) { //Tits!
			pc.breastRows[0].breastRatingRaw = tmp;
			if (pc.isBimbo())
				eventBuffer += "\n\n<b>Your boobies like, get all big an' wobbly again!  You'll have lots of fun now that your tits are back to being big, yummy knockers!</b>";
			else eventBuffer += "\n\n<b>Your " + pc.breastDescript(0) + " have partially regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>";
			pc.slowStatGain("i", -1);
		}
		if (!pc.hasVagina() && !pc.hasStatusEffect("Goo Crotch")) { //Vagoo
			pc.createVagina();
			pc.shiftVagina(0, Mutator.guessVagType(pc));
			if (pc.isBimbo())
				eventBuffer += "\n\n<b>Your crotch is like, all itchy an' stuff.  Omigawsh!  There's a wet little slit opening up, and it's all tingly!  It feels so good, maybe like, someone could put something inside there!</b>";
			else eventBuffer += "\n\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + pc.legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>";
		}
		tmp = pc.hasPerk("Bimbo Brains") ? 12 : 9;
		if (pc.hipRatingRaw < tmp && !pc.hasStatusEffect("Gel Body")) {
			if (pc.isBimbo())
				eventBuffer += "\n\nWhoah!  As you move, your [pc.hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate on a tittering bimbo.  You giggle when you realize you can't walk any other way.  At least it makes you look, like, super sexy!";
			else eventBuffer += "\n\nOh, no!  As you move, your [pc.hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate for a bimbo.  Once you realize that you can't walk any other way, you sigh heavily, your only consolation the fact that your widened hips can be used to tease more effectively.";
			pc.slowStatGain("i", -1);
			pc.hipRatingRaw = tmp;
		}
		if (pc.buttRatingRaw < tmp && !pc.hasStatusEffect("Gel Body")) {
			if (pc.isBimbo())
				eventBuffer += "\n\nGradually warming, you find that your [pc.butt] is practically sizzling with erotic energy.  You smile to yourself, imagining how much you wish you had a nice, plump, bimbo-butt again, your hands finding their way to the flesh on their own.  Like, how did they get down there?  You bite your lip when you realize how good your tush feels in your hands, particularly when it starts to get bigger.  Are butts supposed to do that?  Happy pink thoughts wash that concern away - it feels good, and you want a big, sexy butt!  The growth stops eventually, and you pout disconsolately when the lusty warmth's last lingering touches dissipate.  Still, you smile when you move and feel your new booty jiggling along behind you.  This will be fun!";
			else eventBuffer += "\n\nGradually warming, you find that your [pc.butt] is practically sizzling with erotic energy.  Oh, no!  You thought that having a big, bloated bimbo-butt was a thing of the past, but with how it's tingling under your groping fingertips, you have no doubt that you're about to see the second coming of your sexy ass.  Wait, how did your fingers get down there?  You pull your hands away somewhat guiltily as you feel your buttcheeks expanding.  Each time you bounce and shake your new derriere, you moan softly in enjoyment.  Damnit!  You force yourself to stop just as your ass does, but when you set off again, you can feel it bouncing behind you with every step.  At least it'll help you tease your foes a little more effectively...";
			pc.slowStatGain("i", -1);
			pc.lust(10);
			pc.buttRatingRaw = tmp;
		}
	}
	
	if (pc.hasPerk("Bro Body")) { //Bro checks
		//pc.removeStatusAffect(StatusAffects.Feeder);
		//pc.removePerk(PerkLib.Feeder);
		tmp = pc.hasPerk("Bro Brains") ? 10 : 6;
		if (!pc.hasCock() && !pc.hasStatusEffect("Goo Crotch")) { //(Dick regrowth) 
			pc.createCock(10);
			pc.shiftCock(0, Mutator.guessCockType(pc));
			eventBuffer += "\n\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, " + tmp + "-inch cock pulses happily.";
			if (pc.balls == 0) {
				eventBuffer += "  A pair of heavy balls drop into place below it, churning to produce cum.";
				pc.balls = 2;
				pc.ballSizeRaw = 3 * Math.PI;
			}
			eventBuffer += "</b>";
		}
		tmp = pc.hasPerk("Bro Brains") ? 8 : 6;
		if (pc.cocks[0].cLength() < 8 && !pc.hasStatusEffect("Goo Crotch")) { //(Dick rebiggening)
			eventBuffer += "\n\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at " + tmp + " inches long.  ";
			if (pc.isBro()) eventBuffer += "Goddamn, that thing is almost as tough as you!  ";
			eventBuffer += "You really have no control over your dick.</b>";
			pc.cocks[pc.longestCockIndex()].cLength(8, true);
			if (pc.cocks[pc.longestCockIndex()].cThicknessRatio() < 1) pc.cocks[pc.longestCockIndex()].cThicknessRatio(1, true);
		}
		tmp = pc.hasPerk("Bro Brains") ? 3 : 2;
		if (pc.balls == 0 && !pc.hasStatusEffect("Goo Crotch")) { //(Balls regrowth)
			eventBuffer += "\n\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath [pc.eachCock] grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>";
			pc.balls = 2;
			pc.ballSizeRaw = int(tmp * Math.PI);
		}
	}
	
	//////////////////////////////////////////
	////    OVIPOSITION PERK PROCESSOR    ////
	//////////////////////////////////////////
	if (pc.hasPerk("Oviposition") && pc.hasVagina() && pc.fertility() > 0 && (days % 30 == 0 || pc.fertility() >= 2 && days % (30 / int(pc.fertility())) == 0) && !pc.isPregnant()) {
		if (PregnancyManager.findHandler("CoCOviElixEggs").tryKnockUp(pc, pc, 0)) {
			eventBuffer += "\n\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>";
			pc.createStatusEffect("MagicColorfulEggs", rand(5), 0, 0, 0);
			if (pc.hasPerk("Harpy Womb") && pc.legType == GLOBAL.TYPE_AVIAN && pc.hasTail(GLOBAL.TYPE_AVIAN)) pc.setStatusValue("MagicColorfulEggs", 2, 1);
			pc.addPerkValue("Oviposition", 1, 1); //Count times eggpregged this way in perk.
		}
	}
	
	///////////////////////////////////////
	////    HEAT AND RUT PROCESSORS    ////
	///////////////////////////////////////
	if ((pc.hasVaginaType(GLOBAL.TYPE_CANINE) || pc.hasVaginaType(GLOBAL.TYPE_FELINE)) // regulars heats for appropriate morphs... should be actually some function
		&& pc.fertility() > 0 && (days % 30 == 0 || pc.fertility() >= 2 && days % (30 / int(pc.fertility())) == 0) && !pc.isPregnant() && flags["HEAT_LAST_CYCLE"] != days) { // same schedule with oviposition for correct overlaps
		if (Mutator.goIntoHeat(pc, true, pc.fertility())) flags["HEAT_LAST_CYCLE"] = days;
	}
	
	if (pc.hasStatusEffect("Heat") && pc.statusEffectv3("Heat") == 0) {
		if (pc.isPregnant()) {
			eventBuffer += "\n\n<b>Your heat is suddenly gone.</b>";
			
			if(pc.hasVagina() && pc.statusEffectv4("Heat") > 0) {
				pc.vaginas[0].wetnessRaw -= pc.statusEffectv4("Heat");
				pc.vaginas[0].wetnessRaw = 1;
			}
			
			pc.removeStatusEffect("Heat");
		}
		if (!pc.hasVagina() && pc.statusEffectv4("Heat") == 0) {
			eventBuffer += "\n\n<b>Your heat is gone with your vagina.</b>";
			pc.removeStatusEffect("Heat");
		}
	}
	if (pc.hasStatusEffect("Rut") && !pc.hasCock()) {
		eventBuffer += "\n\n<b>Your rut is gone with your cock.</b>";
		pc.removeStatusEffect("Rut");
	}
}
private var EventsAdopterHellNotifyHook: * = EventsAdopterHellNotifyGrapple();
private function EventsAdopterHellNotifyGrapple():* { timeChangeListeners.push(EventsAdopterHellNotify); }