import classes.Characters.CoC.CoCSandWitchMob;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "Sanura.as";
include "WitchMob.as";
include "CumWitch.as";
include "PharmacyNursery.as";
//include "SandWitchPregs.as"; // TODO. Maybe.
include "MilkBath.as";
include "SandMother.as";

// TODO:
// take lactaid/labova from sand mother
// milk slave buy
// essy interactions and freedom

public function TravelToDesertCave():void {
	processTime(10 + rand(5));
	move("COC_DESERT_CAVE_ENTRACE"); 
}

public function TravelFromDesertCave():void {
	processTime(10 + rand(5));
	move("COC_CAMP"); 
}

//ROOMS
public function DesertCaveEntrance():Boolean {
	if (flags["COC.BEATEN_SANURA_COUNT"] == undefined) flags["COC.BEATEN_SANURA_COUNT"] = 0;
	if (flags["COC.TIMES_SUBMITTED_TO_SANURA"] == undefined) flags["COC.TIMES_SUBMITTED_TO_SANURA"] = 0;
	if (flags["COC.TIMES_WINFUCKED_SANURA"] == undefined) flags["COC.TIMES_WINFUCKED_SANURA"] = 0;
	if (flags["COC.SANURA_DISABLED"] == undefined) flags["COC.SANURA_DISABLED"] = 0;
		
	if (flags["COC.BEATEN_SANURA_COUNT"] == 0 && flags["COC.SANURA_DISABLED"] == 0) clearMenu(); // remove nav if she is not defeated
	
	if(flags["COC.SANURA_DISABLED"] != 0) {
		output("Just ahead, in one of the larger dunes, is a square stone doorway, built into the side of a large, sparkling mountain of sand.  You never would have noticed it if the sun hadn't been at the perfect angle to trace a rectangular shadow down the side of the incline.  As you approach, you notice a familiar obsidian orb embedded into the side of it.  It's obviously the mechanism to open it.");
	}
	else if (flags["COC.MET_SANURA"] != 1) {
		
		flags["COC.MET_SANURA"] = 1;
		output("Just ahead, in one of the larger dunes, is a square stone doorway, built into the side of a large, sparkling mountain of sand.  You never would have noticed it if the sun hadn't been at the perfect angle to trace a rectangular shadow down the side of the incline.  As you approach, you notice a smooth obsidian orb embedded into the side of it.  Perhaps that's the mechanism to open it?");
		output("\n\nSuddenly, a huge shadow looms over you, and the sound of beating wings echo from on high. You spin around in time to see a huge creature leap from the dune tops and slam into the ground a few feet away.  At first glance, the creature looks like a tall, tanned woman with flowing black hair, adorned in a great wealth of gold and jewels.  A moment later, though, you're able to take in the full view of her form: from the waist down, her shapely human form morphs into the lower body of a great, golden-haired lion, padding on a quartet of powerful legs ending in sharp claws.  From her leonine sides grow a pair of massive wings, easily over a dozen feet across, which quickly furl up against her body.  She's a sphinx!");
		output("\n\nThe sphinx-girl pads over towards you, her arms crossed under her small, palmable breasts. Chestnut-colored eyes examine you, looking you over from your [pc.hair] to your [pc.feet], a playful grin playing across her feminine features.  \"<i>O-ho!  What's this we have here?  A poor, lost " + pc.race() + " wandering the desert; or are you something more?  Indeed, I should think so, with your [pc.weapon] so eager for battle, and your [pc.gear] that looks to have seen a thousand blows.  My, my.  Could it be you've come to brave my Mistress's lair?  Ah, if so... you must answer my riddles three, lest I keep from you the key!</i>\" she says, a little tune springing into her voice as she stalks towards you.");
		output("\n\n\"<i>We could even make it interesting...  If you can't guess my riddles, you must surrender your body to my pleasure.  If you win, your pleasure shall be my wish.</i>\"");
		
		//(Display Options: [Riddle Game] [Fight] [Leave])
		addButton(0, "Riddle Game", riddleGameGo, null, "Riddle Game", "Start the riddle game.");
		addButton(1, "Uh, FIGHT!", fuckItAttackSphinx, null, "Uh, FIGHT!", "Screw the riddles, fight her instead!");
	}
	else {
		if(flags["COC.TIMES_SUBMITTED_TO_SANURA"] + flags["COC.TIMES_WINFUCKED_SANURA"] > 0) {
			output("You approach Sanura the sphinx as she pads around the great stone doorframe.  A playful grin spreads across her thin lips as you approach.  \"<i>O-ho!  Back again, I see.  Mmm, it's been so dull since last you <i>came</i>.  There's no one more fun to play out here in the wastes.  So... care to try your hand at my game once more?");
			if(flags["COC.BEATEN_SANURA_COUNT"] > 0) output("  Or would you rather skip the formalities?  We both know who's got the sharper wit, I should think.");
			output("</i>\"");
		}
		else {
			output("The sphinx, Sanura, is padding around the stone doorframe.  Occasionally she beats her leonine wings or gives a mighty yawn, obviously bored by a present lack of stimulation.  Seeing you standing about, however, Sanura gives you a sultry come-hither look and a seductive wink.  You're not sure if she wants to tempt your mind or your body.");
		}
		addButton(0, "Riddle Game", riddleGameGo, null, "Riddle Game", "Start the riddle game.");
			
		if(flags["COC.BEATEN_SANURA_COUNT"] > 0) {
			addButton(1, "Fuck", fuckDatSphinx, null, "Fuck", "Use Sanura to get off.");
		} else 
			addButton(1, "Uh, FIGHT!", fuckItAttackSphinx, null, "Uh, FIGHT!", "Screw the riddles, fight her instead!");
	}

	if(flags["COC.DISCOVERED_WITCH_DUNGEON"] != 1) {
		output("\n\n(<b>You've discovered a new dungeon, available in the places menu in the future!  Make sure you save before delving too deeply...</b>)");
		flags["COC.DISCOVERED_WITCH_DUNGEON"] = 1;
	}
	
	if (flags["COC.BEATEN_SANURA_COUNT"] == 0 && flags["COC.SANURA_DISABLED"] == 0) {
		addButton(14, "Leave", TravelFromDesertCave); // not defeated - button in corner
		return true;
	} else addButton(7, "Leave", TravelFromDesertCave); // defeated - button in navigation block
		
	return false;
}

public function DesertCaveCommons():Boolean {
	if (flags["COC.BEATEN_SANURA_COUNT"] == 0 && flags["COC.SANURA_DISABLED"] == 0) {
		clearOutput();
		clearMenu();
		output("You can not enter without dealing with sphinx!");
		addButton(0, "Next", move, rooms[currentLocation].southExit);
		return true;
	}
	
	output("Dancing lights swirl around the roof of the cavern, twirling around each other in patterns too intricate to follow.  Whatever they are, they're clearly magical, and they lend this place an otherworldly ambience unmatched by anything you've seen.  This huge room reminds you of your village commons in a way - it's clearly a communal area.  There's a water-pump in the northwest corner and a blazing purple bonfire in the center of the chamber, heating the cool underground air.  The ground is dirt, rather than sand, and hard-packed as any road.  Various chairs and benches are set up for witches to relax in.  ");

	if(flags["COC.SANDWITCH_MOB_DEFEATED"] == undefined) {
		output("Worst of all, a huge assortment of spellcasters is assembling into a mob, obviously hostile.");
		output("\n\n<b>A magical barrier appears at the exit, preventing your escape!</b>");

		CombatManager.newGroundCombat();
		CombatManager.setFriendlyCharacters(pc);
		CombatManager.setHostileCharacters(new CoCSandWitchMob());
		CombatManager.victoryScene(yoYouBeatUpSomeSandWitchesYOUMONSTER);
		CombatManager.lossScene(loseToSammitchMob);
		CombatManager.displayLocation("SAND\nWITCH MOB");

		clearMenu();
		addButton(0, "Next", CombatManager.beginCombat);
		return true;
	}
	else output("The women you defeated before have returned to their tasks, casting wary glances your way from time to time but no longer threatening.");
	output("  Cave tunnels lead in to the east and west into more underground chambers.  A path leads south towards the exit.");

	if(flags["COC.SANDWITCH_THRONE_UNLOCKED"] == undefined) {
		output("\n\nA huge stone doorway blocks the path north.  You cannot see a way to open it.");
	}
	else {
		output("\n\nAn open doorway opens up to the north.  You can faintly see some kind of altar beyond it.");
	}
	
	return false;
}
public function DesertCaveLustRoom():Boolean {
	output("This room is surprisingly large - big enough to hold the " + num2Text(rand(6) + 5) + " heavily pregnant women inside plus perhaps a dozen more.  Like the outer tunnel, this room is lit by magic, though its contents are equally mundane, if a great deal more... interesting.  There's female sex-toys of every variety on almost every surface.  They sit in piles on the floor, they hang from the walls, and there are even some mounted on the wall, to be fucked in place.  Many such toys have multiple shafts and come in shapes from standard to canine to obscenely equine.  All of the witches are presently engaged in coitus with each other or their 'marital aids', but once you enter, they glance at you with hungry, lust-filled eyes.");
	if(pc.hasCock() && silly) output("  Clearly, if you wanted to, you could put some extra meat in a sand witch.");

	addDisabledButton(0, "Fuck Witches", "Fuck Witches", "Use the sand witches to get off. This scene requires you to have cock and sufficient arousal.");
	if (pc.hasCock() && pc.lust() >= 33) {
		addButton(0, "Fuck Witches", knockUpSomeDoubleStuffedSandWitches, null, "Fuck Witches", "Use the sand witches to get off.");
	}
	return false;
}
public function DesertCaveWestHall2():Boolean {
	output("The smooth tunnel comes to an end here, blocked by the omnipresent sandstone.  The sapphire light plays beautifully across the rough-hewn stone as you watch, but you don't take the time to give it much thought.  To the east, the arching hallway leads back towards a large common area of a cave.  Along the north and south walls are door-sized openings, blocked with rugs of fine make and thick fabric.  They don't leave enough of a gap for any light or sound to bleed into the hall.  You'll have to take a peek if you want to see what's going on.");
	
	if(flags["COC.ESSRAYLE_ESCAPED_DUNGEON"] == undefined && flags["COC.MET_ESSY"] != undefined) {
		flags["COC.ESSY_MET_IN_DUNGEON"] = 1;
		if(flags["COC.TOLD_MOTHER_TO_RELEASE_ESSY"] == 1) {
			output("\n\n<b>Your attention is immediately drawn to Essrayle...</b>");
			clearMenu();
			addButton(0, "Next", essyWitchVictory);
			flags["COC.ESSRAYLE_ESCAPED_DUNGEON"] = 1;
			return true;
		}
		output("\n\nQuite an unusual sight awaits you in this chamber.  Sitting in an oversized pot is what looks to be the overly busty, plant girl you encountered earlier, Essrayle.  She's changed quite a bit since you last saw her, however.  While her inhumanly smooth, elfin face seems to be unchanged, the rest of her verdant body seems to have been warped into a hyper-sexual parody of a fertility idol, with features that echo the nomadic sand witch tribe.");
		addButton(0, "Essrayle", approachTrappedEssy, null, "Essrayle", "Approach Essrayle the plant-girl.");
	}
	return false;
}
public function DesertCavePharmacy():Boolean {
	output("<b><u>Western Warrens, Western Portion, South Side (Pharmacy)</u></b>\n");
	output("This room is so tiny it can barely get away with being called that.  If anything, it's more of a small, cozy nook.  There isn't anyone else here, though the room is illuminated by the same omnipresent magics found elsewhere in this little cave of wonders.  Standing silent vigil on the southern wall, a large chest looms over you, stretching most of the way to the ceiling.  It is completely, almost impossibly neat, with every drawer fully and completely closed.  Spurred on by this strangeness, you pop a few of them open.  One drawer has pink pills, another brown.  Searching drawer by drawer until you discover that every single compartment houses the same dual medicines.  You glance about the room and spy a faded parchment on the wall.  It reads \"<i>Tnangerp rof knip, nerrab rof nworb.</i>\"  There is an opening in the wall to the north.");
	
	if(flags["COC.SANDWITCH_THRONE_UNLOCKED"] == undefined) {
		output("\n\nThere is also a lever on the floor.  Looking closely at it, it appears that it connects with machinery that leads to the east...");
		addButton(2, "Pull Lever", function():* {
			clearOutput();
			output("There is a loud rumbling from the direction of the cavernous commons...");
			flags["COC.SANDWITCH_THRONE_UNLOCKED"] = 1;
			clearMenu();
			addButton(0, "Next", mainGameMenu);
		}, 
		null, "Pull the lever", "You suspect that it might open the door");
	}
	
	addButton(0, "Brown Pill", takeBarrenPills, null, "Swallow the brown pill.", "You suspect that it might make you barren.");
	addButton(1, "Pink Pill", takeFertilePills, null, "Swallow the pink pill.", "You suspect that it might make you fertile again.");
	return false;
}
public function DesertCaveBathroom():Boolean {
	output("As soon as you step in, you can smell a sweet, dairy-like scent in the air, but as your eyes adjust to the dimmer lighting, you realize you've stumbled into the sand witches' bathroom!  Fluffy towels hang from the wall, ready for use.  There's one giant tub in the center of the room, recessed deep into the floor.  It has a number of seats carved into the side with a small, open hole in the bottom.  Hanging from the ceiling, a long chain dangles down, topped with a plug.");
	flags["COC.MET_MILK_SLAVE"] = 1;
	if(flags["COC.MILK_NAME"] == undefined) {
		output("  There are no faucets or water sources that you can see, but your unasked questions are answered when a heavy, liquid sloshing sound emanates from the corner.  The source of the noise reveals itself to be a tit-encumbered, black-skinned human girl.  She drags her milk-swollen mammaries up to the edge of the tub and asks in a breathy, excited voice, \"<i>Bath time?</i>\"  Whoever she was, the witches seem to have broken her utterly - she's interested in nothing but being milked or lounging in her corner.  The way out lies west.");
		addButton(0, "Bath Time", milkBathsAhoy, null, "Bath Time", "Have a milk bath.");
	}
	return false;
}
public function DesertCaveCumWitchOffice():Boolean {	
	if(flags["COC.SAND_WITCHES_FRIENDLY"] > 0) {
		//{SAND WITCHES NOW FRIENDLY}
		output("The cum witch is here, pounding away at one of her sister's cunts, like usual.  She seems to CONSTANTLY excrete her jism into her partner's many cunt-folds, but as her passion and speed rises, the flow thickens, eventually filling the poor milk-witch's wombs entirely.  They go at it like animals for a few seconds more, then separate after a climactic orgasm that leaves a puddle of spooge inches deep on part of the uneven floor.  The cum-witch moves her insensate sister to rest on a nearby bench before putting on her hat and robes.  She winks at you and offers, \"<i>Well, I hope you enjoyed the show, interloper.  Did you come here for some of my gift, or something else?</i>\"");
		addDisabledButton(0, "Volunteer", "Volunteer", "Volunteer to become a Cum Witch. \n\nThis will end your adventures. NOT IMPLEMENTED.");
		addDisabledButton(0, "Blessing", "Blessing", "Receive a blessing from the Cum Witch. NOT IMPLEMENTED.");
		//{VOLUNTEER FOR SERVICE: BAD-END, BLESSING: +CUM PRODUCTION}
		addButton(0, "Volunteer", volunteerConfirmation, null, "Volunteer", "Volunteer to become a Cum Witch. \n\nThis will end your adventures.");
		if (flags["COC.BEEN_BLESSED_BY_CUM_WITCH"] == undefined) {
			addButton(1, "Blessing", friendlyCumWitchBlessing, null, "Blessing", "Receive a blessing from the Cum Witch.");
		}
	}
	else {
		//{CUM WITCH UNDEFEATED}
		if (flags["COC.CUM_WITCH_DEFEATED"] == undefined) {
			clearMenu();
			output("The curtain pulls to the side easily, and as soon as you enter, you're greeted by the sound of flesh slapping on flesh from somewhere to your left.  Briefly, you note a number of desks as you turn towards the sexual audio, but what really catches your eyes are the two girls locked in coitus.  One, a normal-looking sand witch, is bent over a bench and taking quite the fucking.  Milk drips in huge beads from her four fat teats while fresh rivulets of cum run down past the dried-cum on her thighs.  Above her is something else entirely, a taller woman with a single pair of obscenely large breasts.  She's so dark skinned that at first you have difficulty picking out her features in the dim lighting.  Glittering sweat runs down her form, dripping from her pendulous breasts as she throws back her head and moans, \"<i>Gonna... just... take it!  Take my gift!</i>\"");
			output("\n\nBeneath the ebony woman, you see the sand witch begin to quiver and moan, thick gouts of semen back-flooding from her packed cunny as her belly rounds with delicious fecundity.  Her muscles lock, then twitch feebly for a few seconds before she slides off into the new-born cum-puddle, slipping along the floor in an insensate pile of orgasmic bliss.  You're so enraptured by the sight, that you don't even try to hide when the ebony futanari turns to face you, putting on a pointed, wide-brimmed hat and black robe.  For the slightest second you see a pair of orange-sized balls and one thick, cum-lubed member, but those quickly disappear into the voluminous robes.");
			output("\n\n\"<i>Well now, surely you aren't one of the witches here to receive my seed,</i>\" the odd witch muses, \"<i>I'm afraid you must be an interloper then.  Pity, ");
			if(pc.hasVagina()) output("but then, maybe you can come to serve us as a mother.  Our tribe is not wasteful.");
			else if(pc.hasCock()) output("but perhaps, once you have been disabused of your notions of freedom, you could serve as my loyal cum-pump.  It does get so tiring inseminating all these girls alone.");
			else output("but then, perhaps you could be made to serve in other ways.");
			output("</i>\"");
			
			output("\n\nThe soot-skinned futanari delicately opens one of her palms and murmurs an unintelligible word. Before your eyes, flickers of light flash into existence and align themselves vertically, slowly sliding together like pieces of a flawless crystal jigsaw puzzle.  The glimmering phantasmal luminance slowly fades as all the pieces come together, leaving a flawless ivory staff in the woman's hand.  She slams the base into the ground, sending ripples of magical force through the many pools of cum scattered around the room.  <b>It looks like you'll have to fight her!</b>");
			//{START CUM WITCH FIGHT}
			CombatManager.newGroundCombat();
			CombatManager.setFriendlyCharacters(pc);
			CombatManager.setHostileCharacters(new CoCCumWitch());
			CombatManager.victoryScene(cumWitchDefeated);
			CombatManager.lossScene(defeatedByCumWitch);
			CombatManager.displayLocation("CUM WITCH");

			clearMenu();
			addButton(0, "Next", CombatManager.beginCombat);
			return true;
		}
		//{CUM WITCH BEATEN}
		else {
			output("This room is absolutely, unequivocally inundated with the scent of spunk.  Sure, you note there's a few grates built into the floor to drain off most of it, but it hasn't stopped a number of huge puddles from building up all over this room, likely the result of the two semi-conscious women in this room.  One, a recently-bred sand witch got the fucking of her life from the other, a cum witch.  Both are front-down in jizz, their abused bodies quivering and weak.  The cum witch had tried to fight you, but she was no match for your superior technique.");
			//Lust:
			addDisabledButton(0, "Sex", "Sex", "Use the Cum Witch to get off. This scene requires you to have sufficient arousal.");
			if(pc.lust() >= 33) {
				output("\n\nYou could probably pull the cum witch up and sate yourself on her, if you wanted.  She doesn't seem in any shape to resist.");
				////lust win menu.
				addButton(0, "Sex", cumWitchDefeated, null, "Sex", "Use the Cum Witch to get off.");
			}
		}
	}
	return false;
}

public function DesertCaveAltarRoom():Boolean {
	if(flags["COC.SANDWITCH_THRONE_UNLOCKED"] != 1) 
	{
		clearOutput();
		clearMenu();
		output("The door is locked, and you cannot see a way to open it.");
		addButton(0, "Next", move, rooms[currentLocation].southExit);
		return true;
	}
	return false;
}

public function DesertCaveSandMotherThrone():Boolean {	
	output("This chamber is lit by swirling vortexes of magical colors, each hue dancing around another in coordinated motions.  The walls are made of hewn sandstone inlaid with ivory engravings that appear to depict what must be flowing milk.  Ahead there is a huge, white throne, also made from ivory.  It is a magnificent piece of craftsmanship.  Clearly, you have found the leader's throne room.  There is a robed figure atop it.");
	
	foes = []; // dirty hack to ensure cleanup after other dirty hack
	
	addButton(0, "Approach", sandMotherStuffGOA, null, "Approach", "Approach the Sand Mother.");
	return false;
}

public function DesertCaveCleared():Boolean {
	return flags["COC.SAND_WITCHES_FRIENDLY"] > 0 || flags["COC.SAND_WITCHES_COWED"] > 0;
}