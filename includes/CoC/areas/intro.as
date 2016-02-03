import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function cocMainIntroScene0():void {
	setLocation("\nINGRAM", "", "");
	clearOutput();
	clearMenu();
	processTime(3);
	
	output("You are prepared for what is to come. Most of the last year has been spent honing your body and mind to prepare for the challenges ahead. You are the Champion of Ingnam. The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you’ll never see them again. You wipe away a tear as you enter the courtyard and see Elder Nomur waiting for you. You are ready.");
	output("\n\nThe walk to the tainted cave is long and silent. Elder Nomur does not speak. There is nothing left to say. The two of you journey in companionable silence. Slowly the black rock of Mount Ilgast looms closer and closer, and the temperature of the air drops. You shiver and glance at the Elder, noticing he doesn’t betray any sign of the cold. Despite his age of nearly 80, he maintains the vigor of a man half his age. You’re glad for his strength, as assisting him across this distance would be draining, and you must save your energy for the trials ahead.");
	output("\n\nThe entrance of the cave gapes open, sharp stalactites hanging over the entrance, giving it the appearance of a monstrous mouth. Elder Nomur stops and nods to you, gesturing for you to proceed alone.");
	
	output("The cave is unusually warm and damp, ");
	if (!pc.hasCock()) output("and your body seems to feel the same way, flushing as you feel a warmth and dampness between your thighs. ");
	else output("and your body reacts with a sense of growing warmth focusing in your groin, your manhood hardening for no apparent reason. ");
	output("You were warned of this and press forward, ignoring your body's growing needs.  A glowing purple-pink portal swirls and flares with demonic light along the back wall.  Cringing, you press forward, keenly aware that your body seems to be anticipating coming in contact with the tainted magical construct.  Closing your eyes, you gather your resolve and leap forwards.  Vertigo overwhelms you and you black out...");
	
	addButton(0, "Next", cocMainIntroScene1);
}

public function cocMainIntroScene1():void {
	setLocation("\nIMP", "PORTAL EXIT", "MARETH");
	clearOutput();
	processTime(8 * 60);

	pc.lust(40);
	pc.cor(2);
	
	output("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your [pc.legs].  A surprised looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ");
	if (pc.hasVagina())
		output("the urge to chase down his rod and impale yourself on it.\n\n");
	else
		output("the urge to ram your [pc.cock] down his throat.  The strangeness of the thought surprises you.\n\n");
	output("The imp says, \"<i>I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.</i>\"");
	
	addButton(0, "Next", cocMainIntroScene2);
}

private function cocMainIntroScene2():void {
	setLocation("\nZETAZ", "PORTAL EXIT", "MARETH");
	clearOutput();
	
	pc.lust( -30);
	output("The imp shakes the empty vial to emphasize his point.  You reel in shock at this revelation - you've just entered the demon realm and you've already been drugged!  You tremble with the aching need in your groin, but resist, righteous anger lending you strength.\n\nIn desperation you leap towards the imp, watching with glee as his cocky smile changes to an expression of sheer terror.  The small creature is no match for your brute strength as you pummel him mercilessly.  You pick up the diminutive demon and punt him into the air, frowning grimly as he spreads his wings and begins speeding into the distance.\n\n");
	output("The imp says, \"<i>FOOL!  You could have had pleasure unending... but should we ever cross paths again you will regret humiliating me!  Remember the name Zetaz, as you'll soon face the wrath of my master!</i>\"\n\n");
	output("Your pleasure at defeating the demon ebbs as you consider how you've already been defiled.  You swear to yourself you will find the demon responsible for doing this to you and the other Champions, and destroy him AND his pet imp.");
	
	addButton(0, "Next", cocMainIntroScene3);
}

private function cocMainIntroScene3():void {
	setLocation("\nCAMPSITE", "NEW CAMP", "MARETH");
	clearOutput();
	
	output("You look around, surveying the hellish landscape as you plot your next move.  The portal is a few yards away, nestled between a formation of rocks.  It does not seem to exude the arousing influence it had on the other side.  The ground and sky are both tinted different shades of red, though the earth beneath your feet feels as normal as any other lifeless patch of dirt.   You settle on the idea of making a camp here and fortifying this side of the portal.  No demons will ravage your beloved hometown on your watch.\n\nIt does not take long to set up your tent and a few simple traps.  You'll need to explore and gather more supplies to fortify it any further.  Perhaps you will even manage to track down the demons who have been abducting the other champions!");
	
	processTime(10);

	addButton(0, "Next", move, "COC_CAMP");
}