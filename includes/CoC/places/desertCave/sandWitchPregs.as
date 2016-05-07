import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

/*336 == bigger belly
280 == prolly pregger
216 == unmistakable bulge
180 == obvious pregnancy
120 == impossible to conceal
72 == painfully distended
48 == bulges with unclean spawn..blahblahblah*/
public function sandPregUpdate():Boolean {
	//1: 
	if(pc.pregnancyIncubation == 336) {
		output("\nYour breasts have felt unusually heavy recently, and a strange pulsing sensation occasionally emanates from them.  Your appetite is a little off; you could really go for some milk...\n");
		return true;
	}
	//2:
	if(pc.pregnancyIncubation == 280) {
		output("\nYou've been having strange dreams recently, about seeds growing before your eyes into beautiful flowers; what's really weird is the sense of pride and maternal contentment that seeing them bloom makes you feel.  Your breasts are definitely heavier than normal, and sometimes you wake up to find them damp; are you ");
		if(pc.biggestLactation() < 1) output("starting to lactate");
		else output("lactating more");
		output("?  Your belly is even bulging a little bit more than food can explain.\n");
		temp = pc.bRows();
		while(temp > 0) {
			temp--;
			if(pc.breastRows[temp].breastRating < 1) pc.breastRows[temp].breastRating = 1;
			
		}
		while(pc.biggestLactation() < 1.5) {
			pc.boostLactation(.5);
		}
		return true;
	}
	//3:
	if(pc.pregnancyIncubation == 216) {
		output("\nYour breasts have definitely grown bigger, and they occasionally trickle milk.  More importantly than that, your stomach is bulging out in a small but unquestionable pot belly.  You're definitely pregnant.\n");
		temp = pc.bRows();
		while(temp > 0) {
			temp--;
			if(pc.breastRows[temp].breastRating < 20) pc.breastRows[temp].breastRating++;
			else pc.breastRows[temp].breastRating += 0.5;
		}
		while(pc.biggestLactation() < 1.5) {
			pc.boostLactation(.5);
		}
		return true;
	}
	//4:
	if(pc.pregnancyIncubation == 180) {
		output("\nYour belly continues to grow, the hormones triggering your milk's production to kick it up a notch.  Your breasts are so heavy and sensitive, aching to be used to feed life-giving milk to something.\n");
		while(pc.biggestLactation() < 2) {
			pc.boostLactation(.5);
		}
		return true;
	}
	//5:
	if(pc.pregnancyIncubation == 120) {
		output("\nYou sometimes catch yourself humming to your unborn child, stroking your belly like a contented mother.  At other times, you catch yourself proudly stroking your swollen breasts, admiring the way it makes the milk spurt and flow.");
		while(pc.biggestLactation() < 3) {
			pc.boostLactation(.5);
		}
		return true;
	}
	//6:
	if(pc.pregnancyIncubation == 72) {
		output("\nMilk dribbles constantly out of your nipples now, in many ways being harder to deal with than the ever-increasing swell of your midriff.  The scent of milk hangs in the air around you constantly, giving you a craving to suckle almost as bad as your breasts' need to be suckled from.\n");
		while(pc.biggestLactation() < 4.5) {
			pc.boostLactation(.5);
		}
		return true;
	}
	//7:
	if(pc.pregnancyIncubation == 48) {
		output("\nYour stomach hangs out, heavy and round as any full-term mother's back in Ingnam, your breasts feeling almost as taut and swollen, as if jealous of the life nearly grown inside your womb.  At morning, you find yourself milking your breasts until the cascading fluid ends up glazing your engorged stomach in a beautiful liquid white sheen, not that it seems to make much difference to your production.  You can only hope whatever's growing inside you will be hungry enough to keep up with all the food you'll have for it...");
		while(pc.biggestLactation() < 5.5) {
			pc.boostLactation(.5);
		}
		return true;
	}
	return false;
}

//*Witch Birth Scene:
public function birthAWitch():void {
	output("\n<b><u>Something amazing happens...</u></b>\n");
	if(pc.vaginas.length == 0) {
		output("You feel a terrible pressure in your groin... then an incredible discomfort accompanied by the rending of flesh.  You look down and behold a vagina.  ", false);
		pc.createVagina();
		pc.genderCheck();
	}
	output("You moan in pain as a sudden sharp spike ripples through your distended midriff.  You clumsily haul yourself upright and waddle out into camp, collapsing as you hear your water break, soaking the dry earth of the wasteland below you.  Placing yourself in the most comfortable position you can manage, you grit your teeth and start to push...");
	output("\n\nYour world fades away to the demands of your body; the cycle of painful pushing and exhausted relaxation.  Time ceases to exist, but, finally, inevitably, your body thrusts its squalling intruder into the outside world.  You collapse, heaving in lungfuls of air, as the pain in your body fades away to a dull throbbing ache.  When you feel like you can move without breaking, you pick yourself up and investigate your howling, healthy offspring.");
	
	output("\n\nLying on the dusty ground, still slick with the fluids of the womb, is a healthy, beautiful baby girl, with sandy blonde fuzz on her head and olive-colored skin.  The twin sets of tiny little nipples on her chest and the two pussies are the only signs that she isn't strictly human.");
	//Cum Witch: Lying on the dusty ground, still slick with the fluids of the womb, is a dark-skinned, healthy, beautiful-looking baby, human in virtually every detail.  At first, you wonder if you've given birth to a son, but looking closer reveals the pussy under her little cock and balls.)
	output("\n\nSmiling with a sudden sense of maternal pride, you scoop the baby witch up and hold her to your breast.  She fusses and wriggles some, but soon calms down, cooing as she snuggles against your [chest].   Milk begins to leak from your [nipples], and like iron to a magnet your baby's lips are drawn to the sweet, creamy fluid.  Sparks of pleasure tingle through your breasts as your child nurses, and you can't resist a smile.  Gently you hold her, rocking her back and forth as she noisily suckles from you.");
	if (prison.inPrison) output("\n\nMistress Elly opens the door to see that you're tending to the baby girl. \"<i>Isn't she a cutie? I grant you my permission to bring the baby to Sand Witches,</i>\" she says. You acknowledge her and get up. ");
	output("\n\nWhen she's finally done, you're surprised to see she hasn't grown at all - unless you count the big, round belly she contentedly strokes, a result of the sheer amount of milk the greedy little girl drank.  She starts to squirm and fuss as her greediness catches up to her, and you sling her over your shoulder and gently burp her, the sound echoing out over the wasteland.  As the baby settles in your arms and starts to fall asleep, you carefully gather some scrap cloth, to form a blanket for her, gather your things, and head off to the desert.");
	
	output("\n\nYou soon find your way to the hidden caves of the Sand Witches, where you present your new daughter to the nursery.  The sand witches there aren't too happy about the idea of looking after her themselves, insisting you should stay here with them and rear her yourself, but you are insistent that you cannot stay here and it's not safe to keep your daughter with you.  Finally, they give in and start fussing over your daughter, giving you the opportunity to quietly slip out and head back home.\n");
	if (prison.inPrison) output("\n\nWith your daughter safely delivered to the cave of the Sand Witches, you return to the prison.");
	fatigue(40);
}