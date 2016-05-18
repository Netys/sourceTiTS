import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//*Witch Birth Scene:
public function birthAWitch(pregSlot:int):void {
	if (!pc.hasVagina(pregSlot)) {
		pc.createVagina();
		pregSlot = pc.vaginas.length - 1; // failsafe
		output("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a [pc.vagina " + pregSlot + "].");
		output("\n\n");
	}
	
	output("You moan in pain as a sudden sharp spike ripples through your distended midriff.  You clumsily haul yourself upright and waddle out into camp, collapsing as you hear your water break, soaking the dry earth of the wasteland below you.  Placing yourself in the most comfortable position you can manage, you grit your teeth and start to push...");
	output("\n\nYour world fades away to the demands of your body; the cycle of painful pushing and exhausted relaxation.  Time ceases to exist, but, finally, inevitably, your body thrusts its squalling intruder into the outside world.  You collapse, heaving in lungfuls of air, as the pain in your body fades away to a dull throbbing ache.  When you feel like you can move without breaking, you pick yourself up and investigate your howling, healthy offspring.");
	
	output("\n\nLying on the dusty ground, still slick with the fluids of the womb, is a healthy, beautiful baby girl, with sandy blonde fuzz on her head and olive-colored skin.  The twin sets of tiny little nipples on her chest and the two pussies are the only signs that she isn't strictly human.");
	output("\n\nSmiling with a sudden sense of maternal pride, you scoop the baby witch up and hold her to your breast.  She fusses and wriggles some, but soon calms down, cooing as she snuggles against your [chest].   Milk begins to leak from your [nipples], and like iron to a magnet your baby's lips are drawn to the sweet, creamy fluid.  Sparks of pleasure tingle through your breasts as your child nurses, and you can't resist a smile.  Gently you hold her, rocking her back and forth as she noisily suckles from you.");
	output("\n\nWhen she's finally done, you're surprised to see she hasn't grown at all - unless you count the big, round belly she contentedly strokes, a result of the sheer amount of milk the greedy little girl drank.  She starts to squirm and fuss as her greediness catches up to her, and you sling her over your shoulder and gently burp her, the sound echoing out over the wasteland.  As the baby settles in your arms and starts to fall asleep, you carefully gather some scrap cloth, to form a blanket for her, gather your things, and head off to the desert.");
	
	output("\n\nYou soon find your way to the hidden caves of the Sand Witches, where you present your new daughter to the nursery.  The sand witches there aren't too happy about the idea of looking after her themselves, insisting you should stay here with them and rear her yourself, but you are insistent that you cannot stay here and it's not safe to keep your daughter with you.  Finally, they give in and start fussing over your daughter, giving you the opportunity to quietly slip out and head back home.");
	pc.energy( -40);
	
	processTime(4 * 60);
	
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}