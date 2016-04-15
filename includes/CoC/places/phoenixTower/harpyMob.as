import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Harpy Horde -- PC is Defeated (MAYBE BAD END!!!)
public function pcLosesToHarpyHorde():void {
	output("\n\nUnable to withstand the ");
	if (pc.HP() <= 1) output("brutal assault");
	else output("raw sexuality");
	output(", you collapse, utterly at the harpies' mercy.  The group looms over you, lusty, evil grins all around, but to your surprise, one of them shouts a harsh command, making the swarm of feathery bitches back off.  A particularly slight harpy with a shock of bright-orange hair waves the brood off, astonishingly commanding for the runt of the litter.  The other harpies hiss and growl at her, but still she speaks, \"<i>Hold it!  We can't have the intruder yet.  Mother will want to talk to " + pc.mf("him","her") + " first.</i>\"");
	output("\n\nThe brood grumbles, but you are hauled off your feet and dragged upstairs...");
	//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
	processTime(10);
	clearMenu();
	addButton(0, "Next", harpyQueenBeatsUpPCBadEnd);
}

//Harpy Horde -- PC is Victorious
public function pcDefeatsHarpyHorde():void {
	clearOutput();
	flags["COC.HEL_HARPIES_DEFEATED"] = 1;
	output("The harpies collapse in a pile in the center of the room, all utterly defeated... except one.  The lone harpy that did not attack you throughout the fight, a rather slight girl with a shock of bright orange hair, still stands, gaping at the destruction you've wrought.  Eventually, her gaze shifts up to you.");

	output("\n\n\"<i>Holy shit, " + pc.mf("dude", "lady") + ".  You're a goddamn one-" + pc.race() + "-army, aren't you? You... you must be [pc.name], right? Hel... er, Miss Helia told me about you.  I'm, uh... I'm Kiri.  Sorry about the other girls - I'd just spiked their drinks, but they didn't have time to finish them.  You're a little earlier than I was expecting.  Sorry,</i>\" she whispers nervously, rubbing the back of her neck.");

	output("\n\nYou ask her who she is exactly and how she knows Hel.");

	output("\n\n\"<i>Uh, well, I'm the one who told her about this place. You could say I'm her informant, I guess,</i>\" she shrugs and slips her hands behind her inhumanly wide hips.  Cocking an eyebrow, you notice the girl is actually quite pretty - her wings and hair are an orange as bright as the sun, and she has deliciously curvaceous thighs and hips, not to mention cute perky breasts.  Noticing your lusty glances, she makes a little giggle and bites her lower lip.");

	output("\n\n\"<i>Anyway, Miss Helia asked me to help you any way I can, so... I guess, just ask me if you need anything.</i>\"");
	
	output("\n\n");
	processTime(15);
	CombatManager.genericVictory();
}