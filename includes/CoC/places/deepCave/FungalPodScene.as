import classes.Characters.CoC.CoCEncapsulationPod;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Melee.CoCJeweledRapier;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;


//Encapsulation pod
public function EncapsulationPodGetSwordAndGetTrapped():void {
	clearOutput();
	if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
	{
		output("You walk over to the corpse and its discarded weapon.  The leaf-like petals shift underfoot, and you stumble, slipping on the shifting, slick surface.  Still, they doesn't take any action.  Looks like they have no intellegence, and with your airtight armor they can't sense you as living creature.\n\n");
		flags["COC.ZETAZ_FUNGUS_ROOM_DEFEATED"] = 1;
	
		itemScreen = mainGameMenu;
		lootScreen = mainGameMenu;
		useItemFunction = mainGameMenu;
		itemCollect([new CoCJeweledRapier()]);
		return;
	}
	
	output("You start to walk over to the corpse and its discarded weapon, but halfway through your journey, the unexpected happens.   The leaf-like petals shift underfoot, snapping up with lightning-quick speed.  You ");
	if(pc.RQ() < 50) output("fall flat on your [pc.ass], slipping on the slick, shifting surface.");
	else output("stumble and nearly fall, slipping on the shifting, slick surface.");
	
	output("\n\nA loud 'slap' nearly deafens you, and the visible light instantly diminishes to a barely visible, purple glow.  The fungal 'leaves' have completely encapsulated you, sealing you inside a fleshy, purple pod.  No light can penetrate the thick sheath surrounding you, but muted illumination pulses from the flexing walls of your new prison, oscillating in strength with the subtle shifts of the organic chamber.\n\n");
	output("The sweet aroma that you smelled before is much, MUCH stronger when enclosed like this.  It's strong enough to make you feel a little dizzy and light-headed.  Deciding that you had best escape from this impromptu prison with all possible speed, you try to find a joint to force your way out through, but the pod's walls appear completely seamless.  You pound on the mushy surface, but your repeated blows have little effect.  Each impact brings with it a burst of violet radiance, but the fungus seems built to resist such struggles.  Moisture beads on the capsule's walls in larger and larger quantities, drooling into a puddle around your feet.\n\n");
	output("Meanwhile, a number of tentacles have sprung up from below, and are crawling up your [pc.legs].  It's becoming fairly clear how the skeleton wound up in this cave...  You've got to escape!");
	
	EncapsulationPodFight()
}

private function EncapsulationPodFight():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCEncapsulationPod());
	CombatManager.victoryScene(EncapsulationPodVictory);
	CombatManager.lossScene(EncapsulationPodLoseToThisShitPartII);
	CombatManager.displayLocation("POD");
	
	CombatManager.getHostileCharacters()[0].EncapsulationPodUpdateDescription(pc);
	
	clearMenu();
	addButton(0, "FIGHT!", CombatManager.beginCombat);
}

public function EncapsulationPodVictory():void {
	flags["COC.ZETAZ_FUNGUS_ROOM_DEFEATED"] = 1;
	clearOutput();
	
	output("The pod's wall bursts under your onslaught.  The strength goes out of the tentacles holding you at once, giving them all the power of a limp noodle.  The spongy surface of the pod gives out, and the 'petals' split apart, falling down to the ground with a heavy 'thwack'.  You stand there, exulting in your freedom.  You've won!\n\nThe rapier you approached originally still lies there, and you claim your prize.\n\n");
	
	processTime(10 + rand(5));
	CombatManager.genericVictory();
}

public function EncapsulationPodLoseToThisShitPartII():void {
	clearOutput();
	clearMenu();
	//[OPTIONAL CUM ESCAPE]
	if(pc.cumQ() > 3500) {
		output("Your orgasm drags on for so long that you begin to feel pressure from the cum-slime surrounding you.  It doesn't seem to matter to your [pc.multiCocks], which is too busy sending bliss to your brain and squirting cum for the tentacles to care.  It actually kind of hurts.  The oscillating purple ambiance flashes brighter in protest for a second, and then everything releases all at once.  The pressure is gone and you're sliding down on a wave of fungal-slime cum, feeling the tentacles being pulled from you by the sudden shift of position.  Moist cave air tickles at your [pc.skinFurScales] as you come to rest on another spongy petal and begin to cough out the sludge.\n\n");
		
		output("Over the next minute your head clears and your strength returns.  You push yourself up on something hard, then glance down and realize you washed up next to the skeleton!  The bleached bone leers up at you knowingly, and everything you can see is covered in a thick layer of your [pc.cum].  And your [pc.multiCocks] is still dripping more spunk.  Clearly your ruined orgasm didn't pump it ALL out.  You look down at the rapier and pick it up out of your mess, examining it.  The blade shines keenly, and the sword is balanced to perfection.  Though you succumbed to the same fate as its owner, your warped body saved you from sharing his fate.  Thankfully potential pods that carpet the floor don't even twitch at you.  Perhaps your orgasm was enough to sate them all?  Or maybe they've learned their lesson.");
		//(switch from loss to victory, sword loot)
		enemy.lust(100, true);
		pc.orgasm();
	}
	//[OPTIONAL MILK ESCAPE]
	else if(pc.lactationQ() > 3500 || (pc.lactationQ() + pc.cumQ() > 4500)) {
		output("Your milk-spouting [pc.nipples] continuously pour your [pc.milk] into the soupy fluids surrounding you.  Once you let down your [pc.milk], there was no stopping it.  Pressure backs up inside the flesh-pod, pressing down on you with near painful intensity, but your [pc.fullChest] refuse to give up or slow down.  Even though each squirt jacks up the force on your body, your [pc.milk] production will not relent.  The oscillating purple ambience flashes bright in protest, then gives out entirely, along with the pressure.  At once you're pulled away by a wave of milk-laced fungus-slime, yanking the tentacles away from your body with the change in position.\n\n");
		
		output("Over the next minute your head clears and your strength returns.  You push yourself up on something hard, then glance down and realize you washed up next to the skeleton!  The bleached bone leers up at you knowingly, and everything you can see is covered in a thick layer of slime and [pc.milk].  Your [pc.breasts] are still pouring out [pc.milk].  Clearly you weren't even close to done with your pleasure-induced lactation.  You look down at the rapier and pick it up out of your mess, examining it.  The blade shines keenly, and the sword is balanced to perfection.  Though you succumbed to the same fate as its owner, your warped body saved you from sharing his fate.  Thankfully potential pods that carpet the floor don't even twitch at you.  Perhaps your milk was enough to sate them all?  Or maybe they've learned their lesson.");
		//(switch from loss to victory, sword loot)
		enemy.lust(100, true);
		pc.orgasm();
	}
	//(GENDERLESS)
	else if(!pc.hasGenitals()) {
		output("You orgasm around the tentacle in your [pc.asshole] for what feels like hours, though some dim, half forgotten whisper of your mind tells you it can't possibly have gone on for that long.  It feels so right and so perfect that resistance is almost a foreign concept to you at this point.  How could you have tried to fight off this heaven?  You're completely limp, totally helpless, and happier than you ever remember.  The pulsing lights of your womb-like prison continue their steady beat in time with the tentacle buried in your ass, soothing you while your body is played like a violin heading towards its latest crescendo.\n\n");
		
		output("In spite of the constant stimulation, it unceremoniously comes to a halt.  The tentacle in your [pc.asshole] yanks out with near-spiteful force, and the fluid starts to drain from around you.  With so many strange chemicals pumping in your blood, it's too hard to stand, so you lie down on the fleshy 'floor' as the last of the pod's ooze empties out.  The petals unfold, returning the view of the outside world to your drug and orgasm riddled mind.  Over the next minute your head clears and your strength slowly returns.\n\n");
		
		output("You walk over to the skeleton and get a good look at it.  The bleached bone leers up at you knowingly, and its jaw is locked in a rictus grin.  Looking down at the rapier, you decide to pick it up out of your mess and examine it.  The blade shines keenly, and the sword is balanced to perfection.  Though you succumbed to the same fate as its owner, your genderless body must have saved you from sharing his fate.  The potential pods that carpet the floor don't even twitch at you, and you breathe a silent prayer of thanks while a dark part of you curses.");
		enemy.lust(100, true);
		//enemy.XP = 1;
	}
	//Done if escaped
	if(enemy.lust() >= 100) {
		output("\n\n");
		flags["COC.ZETAZ_FUNGUS_ROOM_DEFEATED"] = 1;
		processTime(120 + rand(60));
		CombatManager.genericVictory();
		return;
	}
	//[BAD-END GO]
	//(MALE)  
	if(pc.hasCock() && !pc.hasVagina() || (pc.isHerm() && rand(2) == 0)) {
		output("The orgasm squirts and drips from your [pc.multiCocks] for what seems like forever.  It feels so right, so perfect, that you actually whine in disappointment when it finally does end.  You can't even be bothered to reach down and stroke yourself.  The softening in your loins is nothing compared to your flaccid, listless muscles.  You couldn't make your arms reach down to touch yourself even if you could work up the motivation to try.  Thankfully the slippery tentacles curl back around your ");
		if(!pc.hasSheath()) output("base");
		else output("sheath");
		output(" and squeeze, forcing your [pc.multiCocks] to inflate to readiness.  Deep inside your [pc.asshole], the tentacle starts to rub against your prostate.  It caresses the male organ on each side and pauses to squeeze the center of it, pushing a few drops of sticky [pc.cum] from your trembling [pc.multiCocks].\n\n");
		
		output("The vine-like stalks currently hugging your [pc.multiCocks] constrict the base and begin to swirl around it in a circular motion.  Warm fungi-flesh and viscous, drugged ooze work together to send hot spikes of pleasure up your spinal-cord.  Despite your recent orgasm, you aren't being given any chance to recover or refill your [pc.balls].  Things like logic and rest don't matter in this warm, soupy environment, at least not to your poor, unthinking mind and erect, sensitive dick");
		if(pc.cockTotal() > 1) output("s");
		output(".  With such stimulation coming so closely on the heels of your last orgasm, [pc.eachCock] is suffering painful levels of pleasure.  Your whole body shakes from the sensory overload; though with your muscles so completely shut down, it's more of a shiver.\n\n");
		
		output("Another wave of sperm begins the slow escape from your helpless, pinned form, drawn out by the fungus' constant sexual ministrations.  The fluid inside your pod gurgles noisily as the fluids are exchanged, but the sensory input doesn't register to your overloaded, drugged-out shell of a mind.  You've lost yourself to mindless pleasure, and repeated, endless orgasms.  The rest of your life is spent floating in an artificial womb, orgasming over and over to feed your fungus prison, and enjoying the pleasure that long ago eroded your ability to reason.");
		badEnd();
		//GAME OVER 
	}
	//(FEM)
	else {
		output("You orgasm around the tentacles in your [pc.vagina] and [pc.asshole] for what feels like hours, though some dim, half forgotten whisper of your mind tells you it can't possibly have gone on for that long.  It feels so right and so perfect that resistance is almost a foreign concept to you at this point.  How could you have tried to fight off this heaven?  You're completely limp, totally helpless, and happier than you ever remember.  The pulsing lights of your womb-like prison continue their steady beat in time with the tentacles buried in your snatch, soothing you while your body is played like a violin heading towards its latest crescendo.\n\n");
		output("The steady rhythm of your penetration sends rockets of bliss-powered pleasure up your spinal cord and straight into your brain, where it explodes in orgasm.  Your body barely twitches, too relaxed to work up any muscle response, involuntary or otherwise.  A moment to rest never presents itself.  The cruel fungus never relents.  It never slows, unless it's only the briefest pause to intensify the next thrust.  Were you in the open air, away from the strange fluid you're now breathing, you'd be twisting and screaming with pleasure.  Instead you float and cum in silence.\n\n");
		output("Fluids gurgle and shift inside the pod as they are exchanged.  If you were capable of noticing the sound or change, you might wonder if it's harvesting your sexual fluids, but even those thoughts are beyond you now. You've lost yourself to mindless pleasure, and repeated, endless orgasms.  The rest of your life is spent floating in an artificial womb, orgasming over and over to feed your fungus prison, and enjoying the pleasure that long ago eroded your ability to reason.");
		badEnd();
		//GAME OVER 
	}
}
