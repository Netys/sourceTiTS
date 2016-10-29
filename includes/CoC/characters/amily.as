import classes.Characters.CoC.CoCAmily;
import classes.Characters.CoC.CoCGoblin;
import classes.Creature;
import classes.Engine.Combat.applyDamage;
import classes.Engine.Combat.combatMiss;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.Engine.Combat.rangedCombatMiss;
import classes.GameData.CombatManager;
import classes.GameData.StatTracking;
import classes.GLOBAL;
import classes.Items.Apparel.CoCNurseOutfit;
import classes.Items.Apparel.CoCSluttySwimwear;
import classes.Items.Apparel.ComfortableClothes;
import classes.Items.Drinks.CoCFuckDraft;
import classes.Items.Drinks.CoCLustDraft;
import classes.Items.Miscellaneous.CoCBlackChitin;
import classes.Items.Miscellaneous.CoCDragonScale;
import classes.Items.Miscellaneous.CoCGreenGel;
import classes.Items.Miscellaneous.CoCToughSpiderSilk;
import classes.Items.Transformatives.*;
import classes.Items.Transformatives.CoCCaninePepperLarge;
import classes.Items.Transformatives.CoCEggs.CoCBlackEgg;
import classes.Items.Transformatives.CoCEggs.CoCBlackEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCBrownEgg;
import classes.Items.Transformatives.CoCEggs.CoCBrownEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCPinkEgg;
import classes.Items.Transformatives.CoCEggs.CoCPinkEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCPurpleEgg;
import classes.Items.Transformatives.CoCEggs.CoCPurpleEggLarge;
import classes.Items.Transformatives.CoCEggs.CoCWhiteEgg;
import classes.Items.Transformatives.CoCEggs.CoCWhiteEggLarge;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

public function get amily():CoCAmily
{
	return chars["COC.AMILY"];
}

public function amilyCombatStart():void {
	amily.maxOutHP();
	amily.maxOutEnergy();
	amily.lust(20, true);
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(amily);
	CombatManager.victoryScene(conquerThatMouseBitch);
	CombatManager.lossScene(CombatManager.genericLoss);
	CombatManager.displayLocation("AMILY");
	CombatManager.beginCombat();
}

public function followerCampMenuBlurbAmily(showInteractButton:Boolean):void {
	if (amilyFollower() && !amilyCorrupt() && !showInteractButton) {
		if (flags["COC.FUCK_FLOWER_LEVEL"] >= 4 && flags["COC.FUCK_FLOWER_KILLED"] == undefined)
			output("Amily has relocated her grass bedding to the opposite side of the camp from the strange tree; every now and then, she gives it a suspicious glance, as if deciding whether to move even further.\n\n");
		else output("A surprisingly tidy nest of soft grasses and sweet-smelling herbs has been built close to your bedroll. A much-patched blanket draped neatly over the top is further proof that Amily sleeps here. She changes the bedding every few days, to ensure it stays as nice as possible.\n\n");
	}
	
	if (amilyFollower() && !amilyCorrupt() && flags["COC.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO"] == undefined && showInteractButton) {
		output("Amily is currently strolling around your camp, ");
		temp = rand(6);
		if (temp == 0) {
			output("dripping water and stark naked from a bath in the stream");
			if (flags["COC.RATHAZUL_IN_CAMP"] == 1) outputText(".  Rathazul glances over and immediately gets a nosebleed");
		}
		else if (temp == 1) output("slouching in the shade of some particularly prominent rocks, whittling twigs to create darts for her blowpipe");
		else if (temp == 2) output("dipping freshly-made darts into a jar of something that looks poisonous");
		else if (temp == 3) output("eating some of your supplies");
		else if (temp == 4) output("and she flops down on her nest to have a rest");
		else output("peeling the last strips of flesh off of an imp's skull and putting it on a particularly flat, sun-lit rock to bleach as a trophy");
		output(".\n\n");
		addButton(followerBtnNum++, "Amily", function():* { processTime(5); amilyFollowerEncounter() } );
	}
	//Amily out freaking Urta?
	//else if (flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) {
		//outputText("Amily's bed of grass and herbs lies empty, the mouse-woman still absent from her sojourn to meet your other lover.\n\n", false);
	//}
	
	if (amilyFollower() && amilyCorrupt() && flags["COC.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO"] == undefined && flags["COC.FOLLOWER_AT_FARM_AMILY"] == undefined) {
		output("Sometimes you hear a faint moan from not too far away. No doubt the result of your slutty toy mouse playing with herself.\n\n");
		if (showInteractButton) addButton(followerBtnNum++, "Amily", function():* { processTime(5); amilyFollowerEncounter() } );
	}
}

private var followerCampMenuBlurbAmilyHook: * = followerCampMenuBlurbAmilyGrapple();
private function followerCampMenuBlurbAmilyGrapple():* {
	followerCampMenuBlurb.push(followerCampMenuBlurbAmily);
}

//public function AmilyScene()
//{
	//pregnancy = new PregnancyStore(kFLAGS.AMILY_PREGNANCY_TYPE, kFLAGS.AMILY_INCUBATION, kFLAGS.AMILY_BUTT_PREGNANCY_TYPE, kFLAGS.AMILY_OVIPOSITED_COUNTDOWN);
	//pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 150, 120, 100, 96, 90, 72, 48);
										////Event: 0 (= not pregnant),  1,   2,   3,  4,  5,  6,  7,  8 (< 48)
	//CoC.timeAwareClassAdd(this);
//}
//
////Implementation of TimeAwareInterface
//public function timeChange():Boolean
//{
	//var needNext:Boolean = false;
	//pregnancy.pregnancyAdvance();
	//trace("\nAmily time change: Time is " + model.time.hours + ", type: " + pregnancy.type + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event);
	//trace("\nAmily time change: butt type: " + pregnancy.buttType + ", butt incubation: " + pregnancy.buttIncubation + ", butt event: " + pregnancy.buttEvent);
	//if (flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] > 0) flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO]--;
	//if (flags[kFLAGS.AMILY_INCEST_COUNTDOWN_TIMER] > 0 && flags[kFLAGS.AMILY_INCEST_COUNTDOWN_TIMER] < 30 * 24) flags[kFLAGS.AMILY_INCEST_COUNTDOWN_TIMER]++;
	//if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//if (flags["COC.AMILY_INCUBATION"] != undefined && pregnancy.incubation == 0) {
			//output("\n", false);
			//amilyPopsOutKidsInCamp();
			//pregnancy.knockUpForce(); //Clear Pregnancy
			//output("\n", false);
			//needNext = true;
		//}
		//if (pregnancy.isButtPregnant && pregnancy.buttIncubation == 0) {
			//amilyLaysEggsLikeABitch();
			//pregnancy.buttKnockUpForce(); //Clear Pregnancy
			//needNext = true;
		//}
	//}
	//if (model.time.hours == 6) {
		////Pure amily flips her shit and moves out!
		//if (flags["COC.AMILY_FOLLOWER"] == 1 && cor() >= 66 + cor()ruptionTolerance() && flags["COC.AMILY_CORRUPTION_WARNING"] > 0) {
			//amilyScene.farewellNote();
			//needNext = true;
		//}
		////Amily moves back in once uncorrupt.
		//if (flags[kFLAGS.AMILY_TREE_FLIPOUT] == 0 && flags["COC.AMILY_CORRUPTION_WARNING"] > 0 && cor() <= 25 + cor()ruptionTolerance() && flags["COC.AMILY_FOLLOWER"] == 0) {
			//amilyScene.amilyReturns();
			//needNext = true;
		//}
	//}
	//else if (model.time.hours > 23) {
		//if (flags[kFLAGS.AMILY_X_JOJO_COOLDOWN] > 0) flags[kFLAGS.AMILY_X_JOJO_COOLDOWN]--;
	//}
	//return needNext;
//}
//
//public function timeChangeLarge():Boolean {
	//if (!kGAMECLASS.urtaQuest.urtaBusy() && flags["COC.AMILY_VISITING_URTA"] == 2 && model.time.hours == 6) {
		//kGAMECLASS.followerInteractions.amilyUrtaMorningAfter();
		//return true;
	//}
	//if (flags["COC.AMILY_FOLLOWER"] == 1 && model.time.hours == 6 && flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 && flags[kFLAGS.CAMP_WALL_SKULLS] < 100 && rand(3) == 0) {
		//flags[kFLAGS.CAMP_WALL_SKULLS]++;
	//}
	//return false;
//}
////End of Interface Implementation

// NEW EVENTS:
// 3172 = Ask to defur Amily
// 3174 = Defur Amily at camp (both corrupt/noncorrupt)
public function amilyFollower():Boolean {
	if (flags["COC.AMILY_FOLLOWER"] > 0) {
		//Amily not a follower while visiting Urta
		return !(flags["COC.AMILY_VISITING_URTA"] == 1 || flags["COC.AMILY_VISITING_URTA"] == 2);
	}
	else return false;
}

	//pregnancy = new PregnancyStore(kFLAGS.AMILY_PREGNANCY_TYPE, kFLAGS.AMILY_INCUBATION, kFLAGS.AMILY_BUTT_PREGNANCY_TYPE, kFLAGS.AMILY_OVIPOSITED_COUNTDOWN);

public function AmilyTimePassedNotify(deltaT:uint, doOut:Boolean = true):void {
	if (flags["COC.AMILY_INCUBATION"] != undefined) flags["COC.AMILY_INCUBATION"] -= deltaT;
	if (flags["COC.AMILY_OVIPOSITED_COUNTDOWN"] != undefined) flags["COC.AMILY_OVIPOSITED_COUNTDOWN"] -= deltaT;
}

private var AmilyTimePassedNotifyHook: * = AmilyTimePassedNotifyGrapple();
private function AmilyTimePassedNotifyGrapple():* { 
		timeChangeListeners.push(AmilyTimePassedNotify);
	}

public function amilyCorrupt():Boolean {
	return flags["COC.AMILY_FOLLOWER"] == 2;
}

public function amilySprite():void {
	//if (flags["COC.AMILY_NOT_FURRY"] == undefined) spriteSelect(3);
	//else spriteSelect(65);
	showName("\nAMILY");
}

private function rackCount():int {
	var temp:int = 0;
	if (flags["COC.CAMP_STORAGE_WARDROBE"] != undefined) temp++;
	if (flags["COC.CAMP_STORAGE_EQUIPMENT"] != undefined) temp++;
	return temp;
}

//Encounters
//[Ruined Village]
//[Exploring the Lake]
public function discoverAmilyVillage():void {
	clearOutput();
	output("As you roam the shores of the lake, you find your footsteps echoing as though you were stepping on wood rather than squishing in the sandy mud of the shore. Curious, you squat down and brush the soil away, revealing the rotting form of a wooden plank. Looking carefully at the ground underfoot, you realize that it is part of a pathway – the kind that villages make to provide easier access to and from muddy rivers, lakes and beaches. You believe you can make out the rest of the path clearly enough to follow it to its end.\n\n");
	output("Do you follow the pathway?");
	//Yes / No
	clearMenu();
	addButton(0, "Yes", exploreAmilyVillage);
	addButton(1, "No", dontExploreAmilyVillage);
}

//[No]
private function dontExploreAmilyVillage():void {
	clearOutput();
	output("Standing up, you turn and walk away. You presume from the state of the pathway that the village at the other end must either be in dire straits, abandoned, or overwhelmed by demons. In other words, it's no safe place for a traveler like you.\n\n");
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Yes]
private function exploreAmilyVillage():void {
	clearOutput();
	output("You follow the overgrown path inland, away from the shore of the lake. You pass through thick trees, struggling not to lose the path, before finally reaching what is clearly the end.  In front of you lie crumbling walls, broken and scattered by the wind and rain... and by other forces entirely. Beyond them are houses that have been torn apart, burned or collapsed. This was clearly once a village, but it was devastated at some point in the past. Demon attack is the first possibility that leaps into your mind. You examine the ruins for a time, and then decide to head back to camp. You don't think it would be wise to investigate here without preparing first.\n\n", false);
	output("(<b>\"TownRuins\" added to Places menu.</b>)");
	//set village unlock flag
	flags["COC.AMILY_VILLAGE_ACCESSIBLE"] = 1;
	flags["COC.AMILY_VILLAGE_EXPLORED"] = 0;
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Exploring the Ruined Village]
public function exploreVillageRuin():void {
	IncrementFlag("COC.AMILY_VILLAGE_EXPLORED");
	processTime(20 + rand(20)); // take your time looking for trouble!
	
	if (flags["COC.AMILY_AFFECTION"] == undefined) flags["COC.AMILY_AFFECTION"] = 0;
	
	clearOutput();
	//50% chance of ghost-girl
	if ((flags["COC.SHOULDRA_SILLY_ENCOUNTER_FOLLOWUP_TIMER"] == undefined && flags["COC.AMILY_VILLAGE_EXPLORED"] > 10 && rackCount() >= 2 && rand(10) <= 3) && int(flags["COC.SHOULDRA_FOLLOWER_STATE"]) <= 0) {
		shouldraGreeting();
		return;
	}
	//20% chance of playing with a rack
	if (rand(5) == 0 && rackCount() < 2) {
		var rack:Number = 0;
		var rackArray:Array = [];
		if (flags["COC.CAMP_STORAGE_WARDROBE"] == undefined) rackArray[rackArray.length] = 0;
		if (flags["COC.CAMP_STORAGE_EQUIPMENT"] == undefined) rackArray[rackArray.length] = 1;
		rack = rackArray[rand(rackArray.length)];
		output("While picking through the ruined houses and abandoned structures of this dilapidated village, you manage to find something useful!  There's an intact but empty ");
		switch(rack) {
			case 0:
				output("armor");
				break;
			case 1:
				output("weapon");
				break;
			default:
				output("  <b>WTF??? It is a bug, report it!</b>");
		}
		output(" rack here.  It looks like it could hold dozen different ");
		switch(rack) {
			case 0:
				output("armors");
				break;
			case 1:
				output("weapons");
				break;
			default:
				output("  <b>WTF??? It is a bug, report it!</b>");
		}
		output(".  You check it over and spot an easy way to fold it up for transport.  This would be a fine addition to your camp, so you pack it up and haul it back.");
		switch(rack) {
			case 0:
				flags["COC.CAMP_STORAGE_WARDROBE"] = 10;
				break;
			case 1:
				flags["COC.CAMP_STORAGE_EQUIPMENT"] = 10;
				break;
			default:
				output("  <b>WTF??? It is a bug, report it!</b>");
		}
		processTime(60 + rand(60));
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//Initialize saved gender:
	if (flags["COC.AMILY_MET"] == undefined) flags["COC.AMILY_PC_GENDER"] = gender(pc);
	//Amily gone/hiding super hard
	if (flags["COC.AMILY_IS_BATMAN"] > 0 || flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] == 1  || flags["COC.AMILY_TREE_FLIPOUT"] > 0) {
		output("You enter the ruined village cautiously. There are burnt-down houses, smashed-in doorways, ripped-off roofs... everything is covered with dust and grime. You explore for an hour, but you cannot find any sign of another living being, or anything of value. The occasional footprint from an imp or a goblin turns up in the dirt, but you don't see any of the creatures themselves. It looks like time and passing demons have stripped the place bare since it was originally abandoned. Finally, you give up and leave. You feel much easier when you're outside of the village.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	//Schrödinger Amily corrupted that damn place!
	else if (flags["COC.AMILY_FOLLOWER"] == 2) {
		amilySprite();
		output("You enter the ruined village, still laughing at your past nefarious deeds. Maybe it's just your imagination, but you feel like this entire place reeks of corruption now... You explore for an hour, then go back to your camp, knowing your tainted slave will be more than happy to satisfy your urges.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	//Remove worm block if player got rid of worms.
	if (flags["COC.AMILY_GROSSED_OUT_BY_WORMS"] == 1) {
		if (!pc.hasStatusEffect("Infested")) flags["COC.AMILY_GROSSED_OUT_BY_WORMS"] = undefined;
	}
	//Corrupt blow up! - requires you've met Amily
	if (flags["COC.AMILY_CORRUPT_FLIPOUT"] == undefined && flags["COC.AMILY_MET"] > 0 && pc.cor() > 25) {
		meetAmilyAsACorruptAsshat();
		return;
	}
	//CORRUPTIONZ
	if (flags["COC.AMILY_CORRUPT_FLIPOUT"] > 0 && pc.cor() > 25 && allowFollowers()) {
		//Cook amily a snack if player doesnt have key item for it.
		if (pc.hasKeyItem("Potent Mixture") < 0 && !(flags["COC.UNKNOWN_FLAG_NUMBER_00170"] > 3)) {
			cookAmilyASnack();
			return;
		}
		//Has snacks!
		else {
			if (flags["COC.UNKNOWN_FLAG_NUMBER_00170"] == undefined) stalkingZeAmiliez();
			else if (flags["COC.UNKNOWN_FLAG_NUMBER_00170"] == 1) stalkingZeAmiliez2();
			else if (flags["COC.UNKNOWN_FLAG_NUMBER_00170"] == 2) stalkingZeAmiliez3();
			else rapeCorruptAmily4Meeting();
			return;
		}
	}
	//Amily Un-encounterable (worms):
	if (flags["COC.AMILY_GROSSED_OUT_BY_WORMS"] == 1 || pc.cor() > 25 || flags["COC.AMILY_CORRUPT_FLIPOUT"] > 0) {
		output("You enter the ruined village cautiously. There are burnt-down houses, smashed-in doorways, ripped-off roofs... everything is covered with dust and grime. For hours you explore, but you cannot find any sign of another living being, or anything of value. The occasional footprint from an imp or a goblin turns up in the dirt, but you don't see any of the creatures themselves. It looks like time and passing demons have stripped the place bare since it was originally abandoned. Finally, you give up and leave. You feel much easier when you're outside of the village – you had the strangest sensation of being watched while you were in there.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	amilySprite();
	//Preggo birthing!
	if (flags["COC.AMILY_INCUBATION"] <= 0) {
		flags["COC.AMILY_INCUBATION"] = undefined;
		fuckingMouseBitchPopsShitOut();
		return;
	}
	if (amilyCanHaveTFNow())
	{
		amilyDefurrify();
		return;
	}
	//meeting scenes for when PC is the same gender as when they last met Amily
	if (flags["COC.AMILY_PC_GENDER"] == gender(pc)) {
		//"bad" or "good" ends.
		if (StatTracking.getStat("coc/pregnancy/amily") + StatTracking.getStat("coc/pregnancy/pc amily") >= 5 && flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] == undefined && allowFollowers())
		{
			if (flags["COC.AMILY_AFFECTION"] < 40) thisIsAReallyShittyBadEnd();
			else thisFunctionProbablySucksTooOhYeahAmilyFunction();
			return;
		}
		
		//Man Meetinz!
		if (gender(pc) == 1) {
			//Desperate Plea
			//(Amily reach Affection 50 without having had sex with the PC once.)
			//Requires the PC have been male last time.
			if (flags["COC.AMILY_AFFECTION"] >= 50 && flags["COC.AMILY_FUCK_COUNTER"] == undefined && flags["COC.AMILY_PC_GENDER"] == 1) {
				output("Wandering into the ruined village, you set off in search of Amily.\n\n");
				/*NOPE!
				[Player meets the requirements to stalk Amily]
				if (pc.spe > 50 && pc.inte > 40) {
					output("Using all of your knowledge, skill and cunning, you sneak and squirm through the ruins until you finally find yourself coming up right behind the dusty mouse girl. She's picking berries off of a small bush and hasn't noticed you yet.\n\n", false);
					output("How do you approach her?", false);
					//Announce yourself / Scare her
					simpleChoices("Announce",announceSelfOnDesperatePleaMeeting,"Scare Her",scareAmilyOnDesperatePleaMeeting,"",0,"",0,"",0);
				}*/
				output("After wondering for a while how on earth you are going to track down Amily, you hear a whistle. Looking around, you see her waving cheekily at you from around a corner; it's pretty obvious that you have a long way to go before you'll be able to beat her at this kind of game.\n\n");

				output("\"<i>Ah... do you have the time to talk? There's something I want to get off my chest,</i>\" Amily nervously asks.\n\n");

				output("Curious what she has to say, you agree.\n\n");

				output("Amily scuffs the ground with one of her finger-like toe claws, looking down at it as if it was the most interesting thing in the world – or as if she doesn't dare to look you in the eyes. \"<i>I... You know what I've been asking of you; from you, and you keep turning me down... but you kept talking to me, asking me about myself. You wanted to get to know me, but... why don't you want to know ALL of me? I... I want to give myself to you. You're the nicest, kindest man I've met – even before the demons destroyed my village. I want to be with you... but you don't seem to want to be with me.</i>\" She looks up to you at last, her eyes wet with tears. \"<i>Is there something wrong with me? Can't you like me in that way?</i>\" she pleads.\n\n");
				//Accept her / Turn her down gently / Turn her down bluntly
				clearMenu();
				addButton(0, "Accept Her", desperateAmilyPleaAcceptHer);
				if (amily.hasFur()) addButton(1, "RejectFurry", amilyNoFur);
				addButton(2, "RejectGently", desperateAmilyPleaTurnDown);
				addButton(3, "BluntReject", desperateAmilyPleaTurnDownBlunt);
				return;
			}
			//[First Meeting]
			if (flags["COC.AMILY_MET"] == undefined) {
				//Set flag for what she met the player as.
				flags["COC.AMILY_MET_AS"] = gender(pc);
				//set 'met' to true
				IncrementFlag("COC.AMILY_MET");
				output("You wind your way deep into the maze of dusty crumbling buildings and twisted saplings, looking for any sign of life – or, failing that, something that can help you in your quest.  Bending down to rummage through an old heap of rubbish, you complain aloud that this is hardly the sort of thing you expected to be doing as a champion. Suddenly, you hear a 'thwip' and something shoots past your face, embedding into the stone beside your head and trembling with the impact.\n\n");

				output("\"<i>Don't make any sudden moves!</i>\" A voice calls out, high pitched and a little squeaky, but firm and commanding. You freeze to avoid giving your assailant a reason to shoot at you again. \"<i>Stand up and turn around, slowly,</i>\" it commands again. You do as you are told.\n\n");

				//[Jojo previously encountered]
				if (flags["COC.JOJO_MET"] > 0) {
					output("The creature that has cornered you is clearly of the same race as Jojo, though notably a female member of his species. Her fur is thick with dust, but you can still easily make out its auburn color. Her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. She wears a tattered pair of pants and an equally ragged-looking shirt. A very large and wicked-looking dagger – more of a short sword really – is strapped to her hip, and she is menacing you with a blowpipe.\n\n");
				}
				//[Jojo not previously encountered]
				else {
					output("You have been cornered by a very strange being: a bipedal female humanoid with the unmistakable features of a giant mouse; paw-like feet, a muzzled head with long whiskers, large mouse ears, and a body covered in dust-caked auburn fur. It doesn't look like she has had a very easy life; her clothing consists of a dirty, tattered set of pants and shirt, while her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. Still, she looks quite capable of defending herself; not only is she brandishing a blowpipe, clearly ready to spit another doubtlessly-poisoned dart at you, but she has a formidable-looking knife strapped to her hip.\n\n");
				}
				output("She looks at you for a few long moments, and then lowers her blowpipe, \"<i>I'm sorry about that, but I thought you were another demon. They destroyed this place years ago, but some of the damn scavengers still occasionally drift through. Not so much lately, of course. I've made something of an impression on them.</i>\" She grins malevolently, one hand caressing the blade of her knife in an almost sensual fashion. \"<i>My name is Amily, the last survivor of this village. All of my people are gone now; they're scattered, dead, enslaved, or worse. What about you? ");
				if (pc.humanScore() > 4) output("Are you ");
				else output("Were you ");
				output("one of those... humans, I've heard sometimes wander into this world?</i>\"\n\n");

				output("You admit that, yes, you are a human, and then ask her why she remains here in this empty wasteland of a settlement.\n\n");

				output("\"<i>I was born here, I grew up here, and I would have gotten married and settled down here if it hadn't been for those demons.</i>\" She spits the word 'demons' with contempt. \"<i>After it was all over, I had nowhere else to go. So I stayed here. I've still got nowhere else to go, to be honest. I haven't found any other settlements of my own people, and I'd sooner die than give myself over to the demons. But it seems that if I'm ever going to see more of my people living free, I'm going to have to take the leading role...</i>\"\n\n");

				output("She stares at you intently, and you ask her what the matter is.\n\n");

				output("\"<i>You see, that role I was talking about? I've had a long time to think about it, and there's no one else for it. If there are ever going to be more of my kind born into freedom, they're going to have to be born. Literally; I need to find a mate that is pure, one that can give me strong and pure children of my own kind,</i>\" she explains, one hand absently touching her flat belly. \"<i>The few males of my kind that I've managed to find are demon slaves – far too corrupt to make suitable mates, even if I could free them. I've heard, though, that humans are strangely weak breeders; your seed would be free of taint, and you would father more of my own kind. Unlike, say, an imp or a minotaur.</i>\"\n\n");

				output("She tucks her blowpipe into her belt and takes several uncertain steps towards you, trying to appear winning – flirtatious even – despite her grimy appearance and clear inexperience with the matter. \"<i>Please, will you help me? You said something about being a champion – If you lay with me and help me bring more of my people into this world, free of the demons and untouched by their perverse taint, you will be striking another kind of blow against their corrupt stranglehold on Mareth.</i>\"\n\n");

				output("What do you do?");
				//Accept Eagerly / Accept Hesitantly / Refuse
				clearMenu();
				addButton(0, "Eagerly", acceptAmilysOfferEagerly);
				addButton(1, "Hesitantly", acceptAmilyOfferHesitantly);
				addButton(2, "No Furries", amilyNoFur);
				addButton(3, "Refuse", refuseAmilysOffer);
				//Set flag for 'last gender met as'
				flags["COC.AMILY_PC_GENDER"] = gender(pc);
				return;
			}
			//[Remeeting if previously refused]
			else if (gender(pc) == 1 && flags["COC.AMILY_OFFER_ACCEPTED"] == undefined) {
				output("Wandering into the ruined village, you set off in search of Amily.\n\n");
				/*NOPE!
				//[Player meets the requirements to stalk Amily]
				if (pc.spe > 50 && pc.inte > 40) {
					output("Using all of your knowledge, skill and cunning, you sneak and squirm through the ruins until you finally find yourself coming up right behind the dusty mouse girl. She's picking berries off of a small bush and hasn't noticed you yet.\n\n", false);
					output("How do you approach her?", false);
					//Announce yourself / Scare her
					simpleChoices("Announce",remeetingAmilyAnnounceSelf,"Scare",remeetingAmilyScare,"",0,"",0,"",0);
				}
				//[Player does not meets the requirements to stalk Amily]*/
				//else {
				output("After wondering for a while how on earth you are going to track down Amily, you hear a whistle. Looking around, you see her waving cheekily at you from around a corner; it's pretty obvious that you have a long way to go before you'll be able to beat her at this kind of game.\n\n");
				amilyRemeetingContinued();
				//Set flag for 'last gender met as'
				flags["COC.AMILY_PC_GENDER"] = gender(pc);
				return;
			}
		}
		//GIRL MEETINZ
		else if (gender(pc) == 2) {
			//First time
			if (flags["COC.AMILY_MET"] == undefined) {
				//Set flag for what she met the player as.
				flags["COC.AMILY_MET_AS"] = gender(pc);
				//set 'met' to true
				IncrementFlag("COC.AMILY_MET");
				output("You wind your way deep into the maze of dusty crumbling buildings and twisted saplings, looking for any sign of life – or, failing that, something that can help you in your quest.  Bending down to rummage through an old heap of rubbish, you complain aloud that this is hardly the sort of thing you expected to be doing as a champion. Suddenly, you hear a 'thwip' and something shoots past your face, embedding into the stone beside your head and trembling with the impact.\n\n");

				output("\"<i>Don't make any sudden moves!</i>\" A voice calls out, high pitched and a little squeaky, but firm and commanding. You freeze to avoid giving your assailant a reason to shoot at you again. \"<i>Stand up and turn around, slowly,</i>\" it commands again. You do as you are told.\n\n");

				//[Jojo previously encountered]
				if (flags["COC.JOJO_MET"] > 0) {
					output("The creature that has cornered you is clearly of the same race as Jojo, though notably a female member of his species. Her fur is thick with dust, but you can still easily make out its auburn color. Her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. She wears a tattered pair of pants and an equally ragged-looking shirt. A very large and wicked-looking dagger – more of a short sword really – is strapped to her hip, and she is menacing you with a blowpipe.\n\n");
				}
				//[Jojo not previously encountered]
				else {
					output("You have been cornered by a very strange being: a bipedal female humanoid with the unmistakable features of a giant mouse; paw-like feet, a muzzled head with long whiskers, large mouse ears, and a body covered in dust-caked auburn fur. It doesn't look like she has had a very easy life; her clothing consists of a dirty, tattered set of pants and shirt, while her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. Still, she looks quite capable of defending herself; not only is she brandishing a blowpipe, clearly ready to spit another doubtlessly-poisoned dart at you, but she has a formidable-looking knife strapped to her hip.\n\n");
				}
				output("She looks at you for a few long moments, and then lowers her blowpipe, \"<i>I'm sorry about that, but I thought you were another demon. They destroyed this place years ago, but some of the damn scavengers still occasionally drift through. Not so much lately, of course. I've made something of an impression on them.</i>\" She grins malevolently, one hand caressing the blade of her knife in an almost sensual fashion. \"<i>My name is Amily, the last survivor of this village. All of my people are gone now; they're scattered, dead, enslaved, or worse. What about you? ");
				if (pc.humanScore() > 4) output("Are you ");
				else output("Were you ");
				output("one of those... humans, I've heard sometimes wander into this world?</i>\"\n\n");

				output("You admit that, yes, you are a human, and then ask her why she remains here in this empty wasteland of a settlement.\n\n");

				output("\"<i>I was born here, I grew up here, and I would have gotten married and settled down here if it hadn't been for those demons.</i>\" She spits the word 'demons' with contempt. \"<i>After it was all over, I had nowhere else to go. So I stayed here. I've still got nowhere else to go, to be honest. I haven't found any other settlements of my own people, and I'd sooner die than give myself over to the demons. But it seems that if I'm ever going to see more of my people living free, I'm going to have to take the leading role...</i>\"\n\n");

				output("She shakes her head and smiles at you wistfully. \"<i>Listen to me, rambling. I'm sorry again for attacking you. But, take care out there; there's a lot of freaky monsters that will do the most unspeakable things to a woman if they can catch her.</i>\"\n\n");

				output("You thank her, and she brushes it off.\n\n");

				output("\"<i>Hey, us girls gotta stick together, right?</i>\" She winks at you then wanders off behind a partially collapsed wall, disappearing into the rubble.");
				//Set flag for 'last gender met as'
				flags["COC.AMILY_PC_GENDER"] = gender(pc);
				clearMenu();
				addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
				return;
			}
			//Lesbo lovin confession!
			if (flags["COC.AMILY_CONFESSED_LESBIAN"] == undefined && flags["COC.AMILY_AFFECTION"] >= 25) {
				amilyIsTotallyALesbo();
				return;
			}
			//Amily totally grows a wang for you once she loves you
			if (flags["COC.AMILY_CONFESSED_LESBIAN"] == 2 && int(amily.longestCockLength()) == 0) {
				amilyPostConfessionGirlRemeeting();
				return;
			}
			//If PC shot down love confession, cap affection at 35 and re-offer?
			if (flags["COC.AMILY_AFFECTION"] > 35 && flags["COC.AMILY_CONFESSED_LESBIAN"] == 1) {
				flags["COC.AMILY_AFFECTION"] = 35;
				amilyIsTotallyALesbo();
				return;
			}
		}
		//Herm Meetinz
		else if (pc.isHerm()) {
			//First time
			if (flags["COC.AMILY_MET"] == undefined) {
				//Set flag for what she met the player as.
				flags["COC.AMILY_MET_AS"] = gender(pc);
				//set 'met' to true
				IncrementFlag("COC.AMILY_MET");
				output("You wind your way deep into the maze of dusty crumbling buildings and twisted saplings, looking for any sign of life – or, failing that, something that can help you in your quest.  Bending down to rummage through an old heap of rubbish, you complain aloud that this is hardly the sort of thing you expected to be doing as a champion. Suddenly, you hear a 'thwip' and something shoots past your face, embedding into the stone beside your head and trembling with the impact.\n\n");

				output("\"<i>Don't make any sudden moves!</i>\" A voice calls out, high pitched and a little squeaky, but firm and commanding. You freeze to avoid giving your assailant a reason to shoot at you again. \"<i>Stand up and turn around, slowly,</i>\" it commands again. You do as you are told.\n\n");

				//[Jojo previously encountered]
				if (flags["COC.JOJO_MET"] > 0) {
					output("The creature that has cornered you is clearly of the same race as Jojo, though notably a female member of his species. Her fur is thick with dust, but you can still easily make out its auburn color. Her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. She wears a tattered pair of pants and an equally ragged-looking shirt. A very large and wicked-looking dagger – more of a short sword really – is strapped to her hip, and she is menacing you with a blowpipe.\n\n");
				}
				//[Jojo not previously encountered]
				else {
					output("You have been cornered by a very strange being: a bipedal female humanoid with the unmistakable features of a giant mouse; paw-like feet, a muzzled head with long whiskers, large mouse ears, and a body covered in dust-caked auburn fur. It doesn't look like she has had a very easy life; her clothing consists of a dirty, tattered set of pants and shirt, while her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. Still, she looks quite capable of defending herself; not only is she brandishing a blowpipe, clearly ready to spit another doubtlessly-poisoned dart at you, but she has a formidable-looking knife strapped to her hip.\n\n");
				}
				output("She looks at you for a few long moments, and then lowers her blowpipe, \"<i>I'm sorry about that, but I thought you were another demon. They destroyed this place years ago, but some of the damn scavengers still occasionally drift through. Not so much lately, of course. I've made something of an impression on them.</i>\" She grins malevolently, one hand caressing the blade of her knife in an almost sensual fashion. \"<i>My name is Amily, the last survivor of this village. All of my people are gone now; they're scattered, dead, enslaved, or worse. What about you? ");
				if (pc.humanScore() > 4) output("Are you ");
				else output("Were you ");
				output("one of those... humans, I've heard sometimes wander into this world?</i>\"\n\n");

				output("You admit that, yes, you are a human, and then ask her why she remains here in this empty wasteland of a settlement.\n\n");

				output("\"<i>I was born here, I grew up here, and I would have gotten married and settled down here if it hadn't been for those demons.</i>\" She spits the word 'demons' with contempt. \"<i>After it was all over, I had nowhere else to go. So I stayed here. I've still got nowhere else to go, to be honest. I haven't found any other settlements of my own people, and I'd sooner die than give myself over to the demons. But it seems that if I'm ever going to see more of my people living free, I'm going to have to take the leading role...</i>\"\n\n");

				output("She looks thoughtful. \"<i>You know...</i>\" She begins, but stops and ");
				//[If breasts are flat, manly breasts]
				if (pc.biggestTitSize() < 1) output("sniffs the air intensely, her whiskers quivering. ");
				//[If breasts are A-cup or bigger]
				else output("stares at the bulge in your top, as well as the bulge in your bottom.  ");
				output("\"<i>Never mind,</i>\" she says after a moment. \"<i>You're a hermaphrodite, aren't you? Forget I mentioned it.</i>\"\n\n");

				output("She turns and walks away, vanishing into the dust and the rubble like magic.");
				//Set flag for 'last gender met as'
				flags["COC.AMILY_PC_GENDER"] = gender(pc);
				clearMenu();
				addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
				return;
			}
			//Medium affection 33% chance, guaranteed by 20.
			//Requires she hasn't yet given this scene!
			if (((flags["COC.AMILY_AFFECTION"] >= 15 && rand(3) == 0) || flags["COC.AMILY_AFFECTION"] >= 20) && flags["COC.AMILY_HERM_QUEST"] == undefined) {
				whyNotHerms();
				return;
			}
			if (flags["COC.AMILY_HERM_QUEST"] == 1) {
				maybeHermsAintAllBadBITCH();
				return;
			}
		}
		//Genderless
		else if (gender(pc) == 0) {
			//[First Meeting]
			if (flags["COC.AMILY_MET"] == undefined) {
				flags["COC.AMILY_MET_AS"] = gender(pc);
				//set 'met' to true
				IncrementFlag("COC.AMILY_MET");
				output("You wind your way deep into the maze of dusty crumbling buildings and twisted saplings, looking for any sign of life – or, failing that, something that can help you in your quest.  Bending down to rummage through an old heap of rubbish, you complain aloud that this is hardly the sort of thing you expected to be doing as a champion. Suddenly, you hear a 'thwip' and something shoots past your face, embedding into the stone beside your head and trembling with the impact.\n\n");

				output("\"<i>Don't make any sudden moves!</i>\" A voice calls out, high pitched and a little squeaky, but firm and commanding. You freeze to avoid giving your assailant a reason to shoot at you again. \"<i>Stand up and turn around, slowly,</i>\" it commands again. You do as you are told.\n\n");

				//[Jojo previously encountered]
				if (flags["COC.JOJO_MET"] > 0) {
					output("The creature that has cornered you is clearly of the same race as Jojo, though notably a female member of his species. Her fur is thick with dust, but you can still easily make out its auburn color. Her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. She wears a tattered pair of pants and an equally ragged-looking shirt. A very large and wicked-looking dagger – more of a short sword really – is strapped to her hip, and she is menacing you with a blowpipe.\n\n");
				}
				//[Jojo not previously encountered]
				else {
					output("You have been cornered by a very strange being: a bipedal female humanoid with the unmistakable features of a giant mouse; paw-like feet, a muzzled head with long whiskers, large mouse ears, and a body covered in dust-caked auburn fur. It doesn't look like she has had a very easy life; her clothing consists of a dirty, tattered set of pants and shirt, while her limbs and midriff are wiry, hardened as much by meals that are less than frequent as by constant exercise and physical exertion. Her buttocks are non-existent, and her breasts can't be any larger than an A-cup. Still, she looks quite capable of defending herself; not only is she brandishing a blowpipe, clearly ready to spit another doubtlessly-poisoned dart at you, but she has a formidable-looking knife strapped to her hip.\n\n");
				}
				output("She looks at you for a few long moments, and then lowers her blowpipe, \"<i>I'm sorry about that, but I thought you were another demon. They destroyed this place years ago, but some of the damn scavengers still occasionally drift through. Not so much lately, of course. I've made something of an impression on them.</i>\" She grins malevolently, one hand caressing the blade of her knife in an almost sensual fashion. \"<i>My name is Amily, the last survivor of this village. All of my people are gone now; they're scattered, dead, enslaved, or worse. What about you? ");
				if (pc.humanScore() > 4) output("Are you ");
				else output("Were you ");
				output("one of those... humans, I've heard sometimes wander into this world?</i>\"\n\n");

				output("You admit that, yes, you are a human, and then ask her why she remains here in this empty wasteland of a settlement.\n\n");

				output("\"<i>I was born here, I grew up here, and I would have gotten married and settled down here if it hadn't been for those demons.</i>\" She spits the word 'demons' with contempt. \"<i>After it was all over, I had nowhere else to go. So I stayed here. I've still got nowhere else to go, to be honest. I haven't found any other settlements of my own people, and I'd sooner die than give myself over to the demons. But it seems that if I'm ever going to see more of my people living free, I'm going to have to take the leading role...</i>\"\n\n");

				//(If breasts < A-Cup)
				if (pc.biggestTitSize() < 1) {
					output("She stares at you intently, and you ask her what the matter is.\n\n");

					output("\"<i>You see, that role I was talking about? I've had a long time to think about it, and there's no one else for it. If there are ever going to be more of my kind born into freedom, they're going to have to be born. Literally; I need to find a mate that is pure, one that can give me strong and pure children of my own kind,</i>\" she explains, one hand absently touching her flat belly. \"<i>The few males of my kind that I've managed to find are demon slaves – far too corrupt to make suitable mates, even if I could free them. I've heard, though, that humans are strangely weak breeders; your seed would be free of taint, and you would father more of my own kind. Unlike, say, an imp or a minotaur.</i>\"\n\n");

					output("She tucks her blowpipe into her belt and takes several uncertain steps towards you, trying to appear winning – flirtatious even – despite her grimy appearance and clear inexperience with the matter. \"<i>Please, will you help me? You said something about being a champion – if you lay with me and help me bring more of my people into this world, free of the demons and untouched by their perverse taint, you will be striking another kind of blow against their corrupt stranglehold on Mareth.</i>\"\n\n");

					output("Sheepishly, you look down at the ground and confess that as much as you might like to help, that's actually impossible.\n\n");

					output("Amily looks hurt. \"<i>Why?</i>\" she demands desperately.\n\n");

					output("Highly embarrassed but unable to think of a way to articulate it, you drop your pants and let her see the flat and featureless expanse of flesh that is your crotch.\n\n");

					output("Amily's eyes bug out, her jaw falls slack and she stares at you, clearly gobsmacked. Then she spits a stream of incoherent, dumbfounded profanities. Finally, she shakes her head. \"<i>Well... that's a new one. I guess... it makes sense. Damn, just when you thought you'd seen it all. I suppose I should go now,</i>\" she tells you and turns to leave.\n\n");

					output("She stops, however, just before rounding a wall. \"<i>There's this stuff you'll find in bottles called Incubus Draft. If you drink that, it'll make you a boy - but I'd find an alchemist first, so he can remove the corruption from it.</i>\"\n\n");

					output("She continues walking away. After she has vanished, though, another musing drifts back to you. \"<i>There's also this stuff called Succubus Milk you can do the same thing with, if you want to be a girl.</i>\"\n\n");
				}
				//(If breasts > A-Cup)
				else {
					output("She shakes her head and smiles at you wistfully. \"<i>Listen to me, rambling. I'm sorry again for attacking you. But, take care out there; there's a lot of freaky monsters that will do the most unspeakable things to a woman if they can catch her.</i>\"\n\n");

					output("Blushing, you explain to her that you aren't actually a woman. She looks very puzzled at this.\n\n");

					output("\"<i>But you have boobs... and I don't see a crotch-bulge,</i>\" she says, sounding almost petulant. \"<i>I don't smell a vagina, either... Wait, are you telling me you don't have either pair of genitals?</i>\" she asks, clearly dumbfounded.\n\n");

					output("Embarrassed, you admit that is so.\n\n");

					output("Amily stares at you, clearly at a loss for words, and then shakes her head in disbelief. She tries to give you a smile. \"<i>Well... us girls gotta stick together, right? If you look for a bottle of Succubus Milk – Imps seem to carry it on occasion, though I don't know why – then you can drink it to get your vagina back. Also, I'd find an alchemist first, so he can remove the corruption from it.</i>\"\n\n");

					output("Having evidently regained her confidence, she winks and then vanishes behind a tumbled-down wall, leaving you alone.");
				}
				//Set flag for 'last gender met as'
				flags["COC.AMILY_PC_GENDER"] = gender(pc);
				clearMenu();
				addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
				return;
			}
		}
	}
	//[Surprise Remeeting]
	/*(random chance of happening instead of [Normal Remeeting] if player meets 'requirements' for stalking Amily)
	if (pc.spe > 50 && pc.inte > 40 && rand(4) == 0) {
		output("Deciding to find Amily first instead of waiting for her to find you, you set off into the ruins. Using all of your knowledge, skill and cunning to figure out where she is likely to be, you make your way there without giving yourself away.\n\n", false);
		//[Amily is not pregnant]
		if (flags[kFLAGS.AMILY_INCUBATION] == 0) {
			output("Finally, you find her squatting down in front of a small bush. She's industriously picking it clean of berries, gulping down almost as many as she puts into a small sack at her side.\n\n", false);
		}
		//[Amily is slightly pregnant]
		else if (flags[kFLAGS.AMILY_INCUBATION] >= 90) {
			output("Finally, you find her rummaging through the contents of a home that has been torn open. She appears to be looking for as many old strips of cloth as she can find.\n\n", false);
		}
		//[Amily is heavily pregnant]
		else {
			output("Finally, you find her emerging from a turn-off, pulling up her pants and muttering to herself about her bladder.\n\n", false);
		}
		output("How do you approach her?", false);
		//Announce yourself / Scare her
		simpleChoices("Announce",sneakyUberAmilyRemeetingsAnnounce,"Scare Her",scareAmilyRemeetingsProBaws,"",0,"",0,"",0);
		return;
	}*/

	//[Normal Remeeting]
	//Did the PC genderchange?  OH SHIT SON!
	//Alternatively: get bitched at
	if (flags["COC.AMILY_PC_GENDER"] != gender(pc)) {
	//Stripped this out since it was making her flip out weirdly at genderless folks
	//|| (gender(pc) == 0 && flags["COC.AMILY_AFFECTION"] < 15)) {
		amilyNewGenderConfrontation();
		return;
	}
	
	output("Curious on how Amily is holding up, you head back into the ruined village. This time you don't bother trying to hide your presence, hoping to attract Amily's attention quicker. After all, she did say that the place is basically empty of anyone except her, and you can otherwise handle a measly Imp or Goblin.\n\n");
	if(flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) {
		//Amily is slightly pregnant
		output("Amily materializes out of the ruins somewhat slower than usual. You can see that your efforts together have taken; an undeniable bulge pokes out of her midriff, pushing up her tattered shirt slightly and seriously straining her belt. She idly rubs it with one hand, as if confirming its presence to herself.\n\n");
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15 || !pc.hasGenitals()) output("\"<i>Well, I guess despite whatever other faults you may have, you can get the job done.</i>\" She says, not looking directly at you.\n\n");
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) output("\"<i>Thank you. With your help, my people will soon live again.</i>\" She strokes her belly, grinning happily. \"<i>Is there something you want to talk about?</i>\"\n\n");
		//[High Affection]
		else output("\"<i>Thank you, thank you! I couldn't have done this without you!</i>\" She exclaims. \"<i>You've done a wonderful, noble thing, and I'm glad I found you to be their father. So, not that it isn't great to see you again, but why did you come to visit?</i>\"\n\n");
	}
	else if (flags["COC.AMILY_INCUBATION"] != undefined) {
		 //Amily is heavily pregnant
		output("It takes several minutes before Amily appears, but when you see her, you marvel at how she got to you as quickly as she did. Her stomach is hugely swollen; one of her hands actually cradles underneath its rounded expanse, as if trying to hold it up. She is pants-less, evidently no longer able to fit into them. Her shirt drapes loosely, barely managing to cover the upper half of her firm orb of a belly. The belt where she hangs her blowpipe and dagger has been tied around her upper chest like a sash – between her breasts and her bulge – so she can still carry her weapons effectively.\n\n");
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15 || !pc.hasGenitals()) output("She seems to be paying more attention to her gravid midriff than to you, and it's several long moments before she finally speaks. \"<i>These children will be born soon. I guess I owe you my thanks for being willing to father them.</i>\"\n\n");
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) output("She groans softly. \"<i>This isn't an easy task, you know. But I still want to thank you. Maybe, when these ones are born, you'll be willing to help me make some more?</i>\" She asks, her tail gently waving behind her.\n\n");
		//[High Affection]
		else output("\"<i>I should have known you were coming; they always start kicking up a storm when you're here – did you know that?</i>\" She smiles beatifically. \"<i>They know their daddy already, they do. With your help, a new generation of my people will have a chance to grow up free from the taint of demons. Was there something on your mind?</i>\"\n\n");
	}
	else {
		//Amily is not pregnant
		output("It doesn't take long for Amily to materialize out of the ruins. Her blowpipe and dagger are both thrust into her belt, and she's still wearing the same tattered clothes as before.\n\n");
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15 || !pc.hasGenitals()) {
			if (flags["COC.AMILY_MET_AS"] == 2 && gender(pc) == 2) output("She crosses her arms and smiles at you. \"<i>So you came back huh?  Did you want to chat with little old me?</i>\" she asks.\n\n");
			else output("She crosses her arms and taps her fingers on her shoulder. \"<i>So, why are you here? What do you want?</i>\" she asks.\n\n");
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("She smiles softly upon seeing you. \"<i>It's always good to see somebody else who hasn't given in to corruption. Did you have something on your mind?</i>\"\n\n");
		}
		//[High Affection]
		else {
			output("She grins at you with open delight. \"<i>Hey there, [pc.name]! It's great to see you again... ");
			if (pc.hasCock()) {
				output("Have you come to knock me up?");
				if (amily.hasCock() && pc.hasVagina() && !pc.isPregnant()) output(" Or have you come to get knocked up?");
			}
			else if (pc.hasVagina()) {
				if (amily.hasCock() && !pc.isPregnant()) output("Have you come back so I could stuff another bun in your oven?");
				else output("Did you come back for a little 'quality time' with me?");
			}
			output("</i>\" she teases, but her body language ");
			if (amily.hasCock()) {
				output("and the erection tenting her pants ");
			}
			output("suggests that it's no joking matter.");
			applyDamage(new TypeCollection( { tease : 5 } ), amily, pc);
			output("\n\n");
		}
	}
	
	clearMenu();
	//Sex / Talk / Talk then sex
	//Amily is not a herm but is ok with herm-daddying!
	if (pc.hasItem(new CoCIncubiDPure()) && !amily.hasCock() && flags["COC.AMILY_HERM_QUEST"] == 2 && flags["COC.AMILY_AFFECTION"] >= 40 && pc.isHerm()) {
		addButton(3, "Efficiency", makeAmilyAHerm);
		output("You could probably bring up the efficiency of having two hermaphrodite mothers, particularly since you have this purified incubi draft handy.\n\n", false);
	}
	var sex:* = determineAmilySexEvent();
	if (sex != null) addButton(0, "Sex", sex);
	else addDisabledButton(0, "Sex", "Sex", "She is not up to sex now.");
	addButton(1, "Talk", talkToAmily);
	if (sex != null) addButton(2, "Both", talkThenSexWithAmily);
	else addDisabledButton(2, "Both", "Both", "She is not up to sex now.");
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	//Set flag for 'last gender met as'
	flags["COC.AMILY_PC_GENDER"] = gender(pc);

	/*FAILSAFE - ALL GENDERS HAVE HAD THERE GO AN NOTHING HAPPENED!
	output("You enter the ruined village cautiously. There are burnt-down houses, smashed-in doorways, ripped-off roofs... everything is covered with dust and grime. You explore for an hour, but you cannot find any sign of another living being, or anything of value. The occasional footprint from an imp or a goblin turns up in the dirt, but you don't see any of the creatures themselves. It looks like time and passing demons have stripped the place bare since it was originally abandoned. Finally, you give up and leave. You feel much easier when you're outside of the village – you had the strangest sensation of being watched while you were in there.", false);
	doNext(13);
	return;*/
}

private function determineAmilySexEvent(forced:Boolean = false):Function {
	var sex:Function = null;
	if (!forced && pc.lust() < 33) return null;
	//If Amily is lesbo lover!
	if (flags["COC.AMILY_CONFESSED_LESBIAN"] > 0 && gender(pc) == 2) {
		//Futa amily!
		if (amily.hasCock()) {
			//If not pregnant, always get fucked!
			if (!pc.isPregnant()) sex = hermilyOnFemalePC;
			//else 50/50
			else {
				if (rand(2) == 0) sex = girlyGirlMouseSex;
				else sex = hermilyOnFemalePC;
			}
		}
		//LESBO LUVIN!
		else sex = girlyGirlMouseSex;
	}
	//If Amily is a herm lover!
	if (pc.isHerm() && flags["COC.AMILY_HERM_QUEST"] == 2) {
		//Amily is herm too!
		if (amily.hasCock()) {
			//If Amily is not pregnant
			if (flags["COC.AMILY_INCUBATION"] == undefined) {
				//If PC is also not pregnant, 50/50 odds
				if (!pc.isPregnant()) {
					//Herm Amily knocks up PC
					if (rand(2) == 0) sex = hermilyOnFemalePC;
					//PC uses dick on amily
					else {
						if (forced) sex = amilySexHappens;
						else sex = sexWithAmily;
					}
				}
				//If PC is preg, knock up amily.
				else {
					if (forced) sex = amilySexHappens;
					else sex = sexWithAmily;
				}
			}
			//Amily is preg
			else {
				//Pc is not
				if (!pc.isPregnant()) sex = hermilyOnFemalePC;
				//PC is preg too!
				else {
					//Herm Amily knocks up PC
					if (rand(2) == 0) sex = hermilyOnFemalePC;
					//PC uses dick on amily
					else {
						if (forced) sex = amilySexHappens;
						else sex = sexWithAmily;
					}
				}
			}
		}
		//Amily still girl!
		else {
			//Not pregnant? KNOCK THAT SHIT UP
			if (flags["COC.AMILY_INCUBATION"] == undefined) sex = sexWithAmily;
			//Pregnant?  Random tribbing!
			else {
				//Lesbogrind
				if (rand(2) == 0) sex = girlyGirlMouseSex;
				//Fuck!
				else {
					if (forced) sex = amilySexHappens;
					else sex = sexWithAmily;
				}
			}
		}
	}
	//Dudesex!
	if (gender(pc) == 1) {
		if (forced) sex = amilySexHappens;
		else sex = sexWithAmily;
	}
	return sex;
}

//[Accept Eagerly]
private function acceptAmilysOfferEagerly():void {
	clearOutput();
	amilySprite();
	output("You grin lecherously, unable to help it. It's rare when someone in this world wants to fuck and actually asks you, rather than just trying to beat you senseless and then rape you. You tell Amily that if she wants you to fuck her, you'll be happy to do so.\n\n");

	output("The mouse-woman looks appalled. \"<i>Must you be so vulgar?</i>\" she complains.\n\n");

	output("You tell her that this is precisely what she's asking you to do, and you'll be happy to do so if that is what she wants.\n\n");

	output("She still looks disgruntled. \"<i>Very well, come on. I suppose it was too much to hope that you would be roaming this world and yet still have some decorum when it comes to sex...</i>\" She begins leading the way and you follow. She doesn't have much of a butt to stare at, but you can already think of some interesting things to do with that tail of hers...\n\n");

	output("Your brash enthusiasm has made Amily uncomfortable, and your quick surrender to baser impulses has made you slightly more lustful.");
	//Offer accepted
	flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
	//[-5 Affection]
	flags["COC.AMILY_AFFECTION"] -= 5;
	//[+5 Libido]
	pc.slowStatGain("l", 5);
	//[/ Go to [First Time Sex]]
	processTime(5);
	clearMenu();
	addButton(0, "Next", amilySexHappens);
}

//[Accept Hesitantly]
private function acceptAmilyOfferHesitantly():void {
	clearOutput();
	amilySprite();
	output("The offer is shocking... and yet, strangely enticing. You cannot help but think that it's nice to meet somebody who, even if they are more sexually explicit than in your village, actually approaches the matter with some decorum. You are still surprised and even embarrassed by the invitation, but you can't help but think it might be worthwhile to accept. It's for a good cause, and she's clearly not entirely comfortable with it herself. Maybe you've been too long in this world of beast-people and monsters, but she actually is kind of cute.\n\n");

	output("Softly, you ask if she really does want you to mate with her, to father her offspring.\n\n");

	output("\"<i>Yes. You're the best hope I have... the only hope I have.</i>\" She replies, sadly.\n\n");

	output("You bow your head and tell her that if she really does need your help, you will help her – even if it does mean doing things with her that she doesn't want.\n\n");

	output("She blinks at you, clearly surprised. \"<i>I've never met a male who actually cared if a female wanted sex or not...</i>\" She then smiles gently. \"<i>It's nice to meet somebody who can still care about people as something other than fuck toys. Please, come with me.</i>\"\n\n");

	output("She eagerly leads you down a path, her tail swishing back and forth energetically. She seems very happy by your acceptance.\n\n");

	output("It seems you've made Amily happy by asking if this is what she wants.");
	//Offer accepted
	flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
	//{+5 Affection}
	flags["COC.AMILY_AFFECTION"] += 5;
	//[/ Go to [First Time Sex]]
	processTime(5);
	clearMenu();
	addButton(0, "Next", amilySexHappens);
}

//[Refuse]
private function refuseAmilysOffer():void {
	clearOutput();
	amilySprite();
	output("You shake your head in refusal.\n\n");

	output("Amily stares at you in disbelief. \"<i>No? What do you mean, no? I'm honestly offering to have sex with you here.</i>\"\n\n");

	output("You tell her that you can't simply have sex with some stranger who you have never met before, especially when that stranger admits it would just be a casual, unfeeling, emotionally hollow act. You dread the idea of simply whoring yourself out, even for an evidently noble cause as this - it's just not right. You came to this world to try and fight the hedonism and lechery that the demons represent, not to support it or, worse, give in to it yourself.\n\n");

	output("Amily is wide-eyed when you finish. \"<i>I have... I haven't heard anybody say things like that, think like that, in a long time.</i>\" She smiles, faintly, then fiercely shakes her head. \"<i>I really do need your help... but I can only respect your conviction. I do hope that we can come to terms later, though.</i>\"\n\n");

	output("She gives you a bow and then leaves, giving you the chance to turn around and leave this ruined village yourself.\n\n");

	output("You have impressed Amily considerably, and reigning in your sexual impulses has helped to calm your libido.\n\n");
	//{+10 Affection}
	flags["COC.AMILY_AFFECTION"] += 10;
	//{-5 Libido}
	pc.slowStatGain("l", -2);
	processTime(5);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Announce yourself]
private function remeetingAmilyAnnounceSelf():void {
	clearOutput();
	amilySprite();
	output("Reasoning that it's best not to scare someone like Amily, you clear your throat nosily. Amily whirls around to face you and immediately draws her knife into a defensive position. When she sees that it's you, she blinks a few times before grinning in surprise. \"<i>Why hello, [pc.name]; good to see you again! It's nice to be reminded that there's another person out here who hasn't become a brainless fuck-puppet.</i>\" Her mood then sobers.\n\n");
	processTime(2);
	clearMenu();
	addButton(0, "Next", amilyRemeetingContinued);
}

//[Scare her]
private function remeetingAmilyScare():void {
	clearOutput();
	amilySprite();
	output("Grinning with mischief, you carefully sneak up behind her. Suddenly grabbing her shoulders, you shout, \"<i>Gotcha!</i>\" She jolts with a panicked squeal and whirls around, bringing along a scything slash from her dagger!\n\n");
	//[Player Speed less than 50]
	if (pc.reflexes() < 35 && !combatMiss(amily, pc)) {
		output("You scramble backwards, but it still cuts a nasty gash into your flesh.  Amily looks poised to strike again, but stops when she sees that it's you. She looks apologetic – well, somewhat. \"<i>Are you all right? I'm sorry, but that was honestly the stupidest thing I've ever seen someone do!</i>\" She approaches you and makes sure that you aren't seriously hurt. \"<i>You'll live,</i>\" she says rather quickly.");
		//{Player takes minor HP damage}
		applyDamage(amily.meleeDamage(), amily, pc);
		output("\n\n");
	}
	//[Player Speed is 50 or higher]
	else {
		output("You manage to leap backwards just in time to avoid a strike that could have seriously hurt you. Amily recovers quickly and readies her knife again, only to realize that it's you. An irritated expression crosses her face. \"<i>Are you insane!? Do you have any idea how stupid that was? I could have killed you!</i>\" she bellows, before slowly calming down. \"<i>Ah, well... no harm, no foul, I guess...</i>\"\n\n");
	}
	processTime(2);
	clearMenu();
	addButton(0, "Next", amilyRemeetingContinued);
}

private function amilyRemeetingContinued():void {
	clearOutput();
	amilySprite();
	output("\"<i>So, have you changed your mind? Have you come to help me out?</i>\" Amily asks curiously.\n\n");
	//Accept / Politely refuse / Here to talk / Get lost
	processTime(1);
	clearMenu();
	addButton(0, "Accept", secondTimeAmilyOfferedAccepted);
	addButton(1, "RefusePolite", secondTimeAmilyRefuseAgain);
	addButton(2, "Just Talk", repeatAmilyTalk);
	addButton(3, "Get Lost", tellAmilyToGetLost);
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Accept]
private function secondTimeAmilyOfferedAccepted():void {
	clearOutput();
	amilySprite();
	output("You tell her that, yes – you'll give her the children she wants. She smiles pleasantly and tells you to follow her.\n\n");
	//Offer accepted
	flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
	//[/ Go to [First Time Sex]]
	processTime(1);
	clearMenu();
	addButton(0, "Next", amilySexHappens);
}

//[Politely refuse]
private function secondTimeAmilyRefuseAgain():void {
	clearOutput();
	amilySprite();
	output("You shake your head gently and explain that your position has not changed. Amily looks annoyed, but respects your decision.\n\n");

	output("\"<i>All right; it is your choice. But my offer still stands, you know,</i>\" she tells you.\n\n");

	output("You let her know you'll remember that, and then turn and leave.");
	processTime(1);
	clearMenu();
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Here to talk]
private function repeatAmilyTalk():void {
	clearOutput();
	amilySprite();
	output("You tell her that you only wanted to talk.\n\n");
	output("\"<i>Just to talk?</i>\" Amily asks, and then adds quietly, \"<i>Well... it has been a long time since I actually had somebody to talk to...</i>\" She looks distracted for a moment, but then she smiles. Clearly, Amily is pleased with the prospect. \"<i>So, is there anything in particular you want to talk about?</i>\"\n\n");
	//[/ Go to random [Conversation]]
	processTime(1);
	clearMenu();
	addButton(0, "Next", talkWithCuntIMeanAmily);
}

//[Get Lost]
private function tellAmilyToGetLost():void {
	amilySprite();
	output("You jeer at Amily that you have no interest in a hypocrite who claims to be pure but is really just like everything else in this tainted world; no higher purpose other than her next fuck.\n\n");

	output("Amily goes red with rage. \"<i>Why you arrogant, puffed-up, pigheaded...!</i>\" She's livid! \"<i>The demons'll have you – see if they don't! I don't need you – you're probably infertile anyway, you—</i>\" She trails off into a stream of the most perverse profanity you have ever heard, and then runs off into the ruins.\n\n");

	output("You spin on your heel and stalk off. You figure that she will go out of her way to avoid you in the future; there's no point coming back here.");
	//{Amily can no longer be encountered}
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	//{Ruined Village removed from Places list}
	//I think one variable can handle both these...
	processTime(2);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Sex]
public function sexWithAmily():void {
	clearOutput();
	amilySprite();
	output("You tell Amily that you came here because you wanted to have sex with her.\n\n");

	if(flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) {
		//Amily is slightly pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("She stares at you, puzzled. \"<i>Why? I'm already pregnant,</i>\" she tells you. \"<i>...Forget it. You can have sex when I need to get pregnant again. Go find a goblin if you want to fuck some brainless baby-stuffed whore!</i>\"\n\n");
			output("Amily can still move quickly despite her pregnancy, and you are very promptly left all alone. Perhaps it would be better not to broach the subject that bluntly with her while she's in this state.\n\n");
			//Reduce affection. DERP
			flags["COC.AMILY_AFFECTION"] -= 3;
			processTime(3);
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("She is clearly surprised, putting a hand to her swelling midriff. But then she shrugs and says, \"<i>Well, I guess I do owe you that much for helping me.</i>\"\n\n");
			output("Though she does set off and indicate for you to follow, you realize that she's not too happy about your reason for being here.\n\n");
			//[/ Go to [Medium Affection Sex]]
			processTime(3);
			clearMenu();
			addButton(0, "Next", amilySexHappens);
		}
		//[High Affection]
		else {
			output("\"<i>You still want me, even though I'm already pregnant?</i>\" she asks – not angry or disappointed, but sounding rather pleased. \"<i>Well, how can I say no to you?</i>\" She smiles broadly and begins to walk away, doing her best to give you a sexy wiggle of her hips as an invitation for you to follow her.\n\n");
			//[/ Go to [High Affection Sex]]
			processTime(3);
			clearMenu();
			addButton(0, "Next", amilySexHappens);
		}
	}
	else if(flags["COC.AMILY_INCUBATION"] != undefined) {
		//Amily is heavily pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("Her disbelief is quite obvious. She stares at her belly, then at you, then at your crotch, then back at her belly again. She shakes her head, clearly looking disgusted. \"<i>What kind of sicko are you? Look at the state of me – I'm in no shape to have sex! Come back after I've given birth, if that's all I mean to you!</i>\"\n\n");
			output("Annoyed, she turns and waddles off. You do not give chase; you can tell that you've offended her.\n\n");
			//Reduce affection
			flags["COC.AMILY_AFFECTION"] -= 3;
			processTime(3);
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("She boggles as if she can't believe you. \"<i>You can't be that desperate you'd want somebody as fat and knocked up as I am!</i>\" she protests.\n\n");
			output("You insist to her that you're not joking – you really do think she's sexy enough to make love to.\n\n");
			output("\"<i>...Well, I guess I'm flattered, but... do you have the faintest idea how to make love to a woman who is pregnant? Especially one as far along as I am?</i>\"\n\n");
			output("You are forced to concede that, actually, you don't.\n\n");
			output("\"<i>It's not that I don't like you, [pc.name], it's just... well, I don't feel comfortable doing that,</i>\" she explains apologetically.\n\n");
			output("You apologize back for confronting her with something she's uncomfortable with, and leave for your own camp, lest you insult her seriously.");
			flags["COC.AMILY_AFFECTION"] -= 3;
			processTime(3);
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		//[High Affection]
		else {
			output("She looks a little puzzled by the request, but then smiles with sincere pleasure. \"<i>I'm game if you are, dear.</i>\" She winks and offers her hand to you. You take it, and let her lead you to her chosen nesting site.\n\n");
			//[/ Go to [High Affection - Heavily Pregnant Sex]]
			processTime(3);
			clearMenu();
			addButton(0, "Next", amilySexHappens);
		}
	}
	else {
		//Amily is not pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("\"<i>Of course you did. Well, come on, I guess I can oblige you. It's the only way I'm going to get pregnant.</i>\"\n\n");
			output("She sets off, clearly leading the way as you follow her.\n\n");
			//[/ Go to [Low Affection Sex]]
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("\"<i>Well, I guess you'll do. I mean, I still need to get pregnant,</i>\" she teases you, tail waving merrily. \"<i>Follow me.</i>\"\n\n");
			output("You have to push yourself to keep up with her, but she's clearly just playing with you by moving so quickly rather than seriously trying to escape you.\n\n");
			//[/ Go to [Low Affection Sex]]
		}
		//[High Affection]
		else {
			output("Amily doesn't bother to say anything; she just grins like the cat that ate the canary (well, the mouse that ate the cheesecake, anyway). She grabs hold of your hand and does her best to pull you as fast as she can towards her closest bolt-hole.\n\n");
			//[/ Go to [Low Affection Sex]]
		}
		processTime(3);
		clearMenu();
		addButton(0, "Next", amilySexHappens);
	}
}

//[Talk]
private function talkToAmily():void {
	clearOutput();
	amilySprite();
	if (flags["COC.AMILY_MET_AS"] == 2 && gender(pc) == 2) output("You tell Amily that you came here because you wanted to talk with her.\n\n");
	else output("You tell Amily that you came here because you wanted to talk with her, and you have no desire to approach her sexually on this encounter.\n\n");

	//[Low Affection]
	if (flags["COC.AMILY_AFFECTION"] < 15) {
		if(flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) {
			//Amily is slightly pregnant
			output("\"<i>I could use someone to talk to, I suppose,</i>\" she says plainly, but you can clearly see that she's very happy that's what you want to do.\n\n");
		}
		else if(flags["COC.AMILY_INCUBATION"] != undefined) {
			//Amily is heavily pregnant
			output("\"<i>Oh, NOW you want to get to know me,</i>\" she complains, but her tone is gentle – amused even, and she clearly isn't as unhappy as her words may imply. Heavily, she sits herself down unceremoniously. \"<i>But... there are things weighing on my mind. I really could use somebody to talk to.</i>\"\n\n");
		}
		else {
			//Amily is not pregnant
			if (flags["COC.AMILY_MET_AS"] == 2 && gender(pc) == 2) output("\"<i>A chat would be lovely,</i>\" she says, clearly enjoying herself.  \"<i>I... I hardly ever get a chance to find someone to chat with.  Sometimes it seems like everyone in Mareth just wants to breed non-stop...</i>\" she murmers to herself.  \"<i>Well, what shall we talk about?</i>\" she asks, seemingly quite happy with your presence.\n\n");
			else output("\"<i>You want to talk? No sex?</i>\" she asks, clearly having a hard time believing it. \"<i>I... I haven't had the chance to talk to anyone in years. It's been so long...</i>\" she murmurs to herself, and you think you see the start of a tear glinting in her eye. \"<i>Well, what do you want to talk about?</i>\" she asks, seemingly quite happy that's what you're here for.\n\n");
		}
	}
	//[Medium Affection]
	else if (flags["COC.AMILY_AFFECTION"] < 40) {
		output("\"<i>Of course, [pc.name], I always enjoy our talks.  What shall we discuss this time?</i>\" she asks happily.\n\n");
	}
	//[High Affection]
	else {
		output("She smiles playfully at you. \"<i>And here I was thinking we knew each other already.  But if you want, I'm always happy to talk.</i>\"\n\n");
	}
	//[/ Go to random [Conversation]]
	processTime(3);
	clearMenu();
	addButton(0, "Next", talkWithCuntIMeanAmily);
}

//[Talk then sex]
private function talkThenSexWithAmily():void {
	clearOutput();
	amilySprite();
	output("You tell Amily that you came here because you wanted to talk with her.  If she feels like having sex when you are done, though, you would be happy to oblige.\n\n");
	
	if(flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) {
		//Amily is slightly pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("She rubs her belly thoughtfully. \"<i>I guess a bit of conversation would be nice, after all this time. Sex, though? Maybe if you're lucky.</i>\" She's already heading off, encouraging you to follow her.\n\n");
			//[/ Go to random [Conversation], then small chance of [Low Affection Sex]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkWithCuntIMeanAmily);
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("\"<i>Talking to you is always nice... and, why the hell not? I'm not that big yet, I don't think?</i>\"\n\n");
			output("You assure her that she still looks trim and lean to you.\n\n");
			output("\"<i>Flatterer. Come on, I have something to eat back in my den.</i>\"\n\n");
			//[/ Go to random [Conversation], then to [Medium Affection Sex]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkToAmilyWithSexAfter);
		}
		//[High Affection]
		else {
			output("\"<i>Well, I could maybe do without the sex part...</i>\" Amily muses, rubbing her chin. Then she grins. \"<i>We'll see how things work out, all right?</i>\"\n\n");
			output("You assure her that's fine, and the two of you find a relatively comfortable patch to sit down on so you can talk.\n\n");
			//[/ Go to random [Conversation], then to [High Affection Sex]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkToAmilyWithSexAfter);
		}
	}
	else if(flags["COC.AMILY_INCUBATION"] != undefined) {
		//Amily is heavily pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("She stares at you, then smiles faintly. \"<i>Talk? Talk is good... it's so quiet here; I spent so many years without anybody to talk to. But sex? In my condition? No, I don't think so.</i>\"\n\n");
			output("Despite her refusing the prospect of sex, she happily takes a seat on a toppled column and invites you to join her.\n\n");
			//[/ Go to random [Conversation]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkWithCuntIMeanAmily);
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("She blinks in surprise. \"<i>The talk would be wonderful... but do you really want to have sex with me when I look like this? It gets kind of lonely around here without you, but isn't this,</i>\" she loudly claps her hand against her belly and continues, \"<i>Something of an obstacle? I mean, I don't know how we'd actually make it work.</i>\"\n\n");
			output("You are forced to concede that you don't have any real ideas how sex between you would work with her in her current state.\n\n");
			output("Amily smiles and pulls up a seat on a mound of leaf litter. \"<i>That's all right; you meant well. And even if we can't have sex, we can still talk. Anything on your mind in particular?</i>\"\n\n");
			//[/ Go to random [Conversation]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkWithCuntIMeanAmily);
		}
		//[High Affection]
		else {
			output("She grins at you playfully. \"<i>It's just wonderful to finally have somebody to talk to after all these years. And maybe I'll let you make love to me afterwards, if you're a good listener.</i>\"\n\n");
			output("She waddles over to something that – in the distant past – might have been a stone seat for public convenience, and seats herself upon it heavily. \"<i>So, what do you want to talk about?</i>\" she asks.\n\n");
			//[/ Go to random [Conversation], then to [High Affection Sex – Heavily Pregnant Sex]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkToAmilyWithSexAfter);
		}
	}
	else {
		//Amily is not pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("\"<i>...Well, maybe you're not like everyone else in this world after all,</i>\" she finally answers. Though she walks away without a second word, she seems rather pleased by your answer.\n\n");
			output("\"<i>Hey, hurry up!</i>\" she calls back over her shoulder. You snap out of your musings and follow her.\n\n");
			//[/ Go to random [Conversation], then to [Low Affection Sex]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkToAmilyWithSexAfter);
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("She smiles at you. \"<i>Well... I was feeling a little tired, a little lonely, and... maybe a little horny. Why not?</i>\"\n\n");
			output("She crooks a finger at you as a gesture to follow her.\n\n");
			//[/ Go to random [Conversation], then to [Medium Affection Sex]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkToAmilyWithSexAfter);
		}
		//[High Affection]
		else {
			output("\"<i>Conversation with a wonderful friend, and a wonderful bout of lovemaking afterwards... Well, I guess that's what passes for true romance in this crazy, messed up world these days,</i>\" Amily notes. She tries to sound lighthearted, but you know her well enough to sense the tinge of pain and loss in her words. Undaunted, she starts to walk off, gesturing you to follow. \"<i>Come on; I can talk and walk at the same time, surely you can do the same?</i>\"\n\n");
			//[/ Go to random [Conversation], then to [High Affection Sex]]
			processTime(2);
			clearMenu();
			addButton(0, "Next", talkToAmilyWithSexAfter);
		}
	}
}

//[Announce yourself]
private function sneakyUberAmilyRemeetingsAnnounce():void {
	clearOutput();
	amilySprite();
	output("Reasoning that it's best not to scare someone like Amily, you clear your throat nosily. Amily whirls around to face you and immediately draws her knife into a defensive position. When she sees that it's you, she blinks a few times.\n\n");

	if(flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) {
		//Amily is slightly pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) output("\"<i>I guess maybe I'm starting to slow down with this hanging off of me,</i>\" she grumbles. \"<i>Something you wanted?</i>\"\n\n");
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) output("\"<i>Be honest – did this make me easier to find?</i>\" she asks, pushing out her belly for emphasis. Then, seemingly uncaring about the answer, she changes the subject. \"<i>Is there a reason you wanted to see me?</i>\"\n\n");
		//High Affection
		else output("\"<i>I may be pregnant, but I didn't make this any easier on you now, did I?</i>\" She smirks. \"<i>It takes great skill to find me... but what is your reason?</i>\"\n\n");
	}
	else if(flags["COC.AMILY_INCUBATION"] != undefined) {
		//Amily is heavily pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) output("\"<i>The only reason you could possibly find me is because this huge belly makes me too slow to move quickly and too big to hide. You know that, don't you?</i>\" she proclaims defensively, before changing her tone and asking curiously, \"<i>...Why are you here, anyway?</i>\"\n\n");
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) output("\"<i>I guess it's not as easy for me to hide as it once was. So, why are you here?</i>\"\n\n");
		//[High Affection]
		else output("\"<i>It's not easy for me to run and hide anymore, these days. I'm glad you decided to do the guardian angel act. So, how can I thank you for coming to check on me?</i>\"\n\n");
	}
	else {
		//Amily is not pregnant
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) output("\"<i>How on earth did you get here? Nobody's ever been able to track me!</i>\" she protests. Then she shakes her head. \"<i>Ah well, I guess if it's you, it's no matter. So, whaddya want?</i>\"\n\n");
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) output("\"<i>Hmm... I'll have to work on that; I can't let just any bozo trail me,</i>\" she proclaims, smiling mischievously. \"<i>What's up?</i>\"\n\n");
		//[High Affection]
		else output("\"<i>You're coming along nicely, lover mine.</i>\" She smiles, proud as can be at your display of skill. \"<i>So, what brings you running to me?</i>\" she teases.\n\n");
	}
	//Sex / Talk / Talk then sex
	processTime(5);
	clearMenu();
	addDisabledButton(0, "Sex")
	addDisabledButton(2, "Both")
	if (pc.lust() >= 33) {
		addButton(0, "Sex", sexWithAmily);
		addButton(2, "Both", talkThenSexWithAmily);
	}
	addButton(1, "Talk", talkToAmily);
}

//[Scare her]
private function scareAmilyRemeetingsProBaws():void {
	clearOutput();
	amilySprite();
	output("Grinning with mischief, you carefully sneak up behind her. Suddenly grabbing her shoulders, you shout, \"<i>Gotcha!</i>\" She jolts with a panicked squeal and whirls around, bringing along a scything slash from her dagger!\n\n");
	//[Player Speed less than 50]
	if (pc.reflexes() < 35 && !combatMiss(amily, pc)) {
		//{Player takes minor HP damage}
		output("You scramble backwards, but it still cuts a nasty gash into your flesh.");
		applyDamage(amily.meleeDamage(), amily, pc);
		output(" Amily looks poised to strike again, but stops when she sees that it's you.\n\n");
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("\"<i>Oh... It's you. Well, that was a dumb thing to do,</i>\" she says, surprisingly collected. She roughly grabs hold of you and painfully probes your injury, causing you to yelp in pain. \"<i>Big baby, you'll live. And let that serve a reminder not to sneak up on a survivor with a knife – not here, at least. So, what made you come here, anyway?</i>\" she asks, disinterested.\n\n");
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("\"<i>That's what happens when you surprise someone with a knife,</i>\" she says, though clearly worried. \"<i>Hey, are you all right?</i>\" she asks.\n\n");

			output("You assure her that, while it hurts, it's nothing serious.\n\n");

			output("She looks relieved. \"<i>That's good... you did kind of deserve it, but killing you for being a dummy isn't how I'd like this relationship to end... So, why are you here, anyway?</i>\"\n\n");
		}
		//[High Affection]
		else {
			output("\"<i>You idiot! You moron! You-you-you!</i>\" she trails off incoherently, even as she practically bowls you over in her desperation to check your wound. Her touches are gentle, and she looks relieved to see it's only a flesh wound. Reaching into a pouch you hadn't noticed before, she quickly begins to bind it. \"<i>It's only a minor injury; you'll be okay... but don't you ever startle me like that again!</i>\" she squeaks loudly. \"<i>I could have hurt you - did you even think about that? About what would happen if I actually hurt you?</i>\"");
			//[If Amily is pregnant]
			if (flags["COC.AMILY_INCUBATION"] != undefined) output("  \"<i>Do you want our children to grow up without their father?</i>\" she asks softly, touching her bulging belly with one hand.\n\n");
			output("\n\n");

			output("You apologize for your foolishness, and promise it won't happen again.\n\n");

			output("\"<i>See that it doesn't,</i>\" she sniffs, primly. Then she grins in relief. \"<i>So, why did you want to come and see me?</i>\"\n\n");
		}
	}
	//[Player Speed is 50 or higher]
	else {
		output("You manage to leap backwards just in time to avoid a strike that could have seriously hurt you. Amily recovers quickly and readies her knife again, only to realize that it's you.\n\n");
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("Her expression is fierce. \"<i>Idiot! Don't sneak up on me! If you had been a little slower, I might have killed you!</i>\" Amily spits indignantly. She shakes her head and mutters imprecations about your intelligence and lineage, and you wonder for a second if she's going to storm off. But then she calms down. \"<i>Well? Spit it out! Why are you here?</i>\"\n\n");

			output("Okay, maybe she hasn't entirely calmed down yet.\n\n");
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("An irritated expression crosses her face. \"<i>Are you insane!? Do you have any idea how stupid that was? I could have killed you!</i>\" she bellows, before slowly calming down. \"<i>Ah, well... no harm, no foul, I guess...</i>\"\n\n");
		}
		//[High Affection]
		else {
			output("Fear gives way to relief, which is then tinged with anger. \"<i>Of all the stupid half-witted stunts! Do you have any idea how dangerous that was?</i>\" She latches onto you, tears starting to glimmer in her eyes. \"<i>Do you know how I would have felt if I'd hurt you - if I'd killed you? Promise me you won't sneak up on me like that again!</i>\"\n\n");
			
			output("You promise you won't startle her like that in the future, and her face lights up with relief. \"<i>Good. So, that unpleasantness aside... why are you here?</i>\"\n\n");
		}
	}
	//Sex / Talk / Talk then sex
	//(Same as [Normal Remeeting))
	flags["COC.AMILY_AFFECTION"] -= 1;
	processTime(7);
	clearMenu();
	addDisabledButton(0, "Sex")
	addDisabledButton(2, "Both")
	if (pc.lust() >= 33) {
		addButton(0, "Sex", sexWithAmily);
		addButton(2, "Both", talkThenSexWithAmily);
	}
	addButton(1, "Talk", talkToAmily);
}

//[Desperate Plea]

//[Announce yourself]
private function announceSelfOnDesperatePleaMeeting():void {
	clearOutput();
	amilySprite();
	output("Reasoning that it's best not to scare someone like Amily, you clear your throat nosily. Amily whirls around to face you and immediately draws her knife into a defensive position. When she sees that it's you, she blinks a few times before grinning in surprise. \"<i>Why hello, [pc.name]; good to see you again! It's nice to be reminded that there's another person out here who hasn't become a brainless fuck-puppet.</i>\" Her mood then takes a nervous turn. \"<i>Ah... do you have time to talk? There's something I want to get off my chest,</i>\" she tells you, hardly daring to look you in the eye.\n\n");
	processTime(2);
	desperateFinallyAmily();
}

//[Scare her]
private function scareAmilyOnDesperatePleaMeeting():void {
	clearOutput();
	amilySprite();
	output("Grinning with mischief, you carefully sneak up behind her. Suddenly grabbing her shoulders, you shout, \"<i>Gotcha!</i>\" She jolts with a panicked squeal and whirls around, bringing along a scything slash from her dagger!\n\n", false);
	//[Player Speed less than 50]
	if (pc.reflexes() < 35 && !combatMiss(amily, pc)) {
		output("You scramble backwards, but it still cuts a nasty gash into your flesh.");
		applyDamage(amily.meleeDamage(), amily, pc);
		output(" Amily looks poised to strike again, but stops when she sees that it's you. She looks apologetic – well, somewhat. \"<i>Are you all right? I'm sorry, but that was honestly the stupidest thing I've ever seen someone do!</i>\" She approaches you and makes sure that you aren't seriously hurt.\n\n");
		output("\"<i>You'll live,</i>\" Amily declares quickly, though there is an honest sound of relief in her voice. \"<i>Ah... do you have the time to talk? There's something I want to get off my chest,</i>\" she asks, clearly nervous and maybe a little embarrassed.\n\n");
	}
	//[Player Speed is 50 or higher]
	else {
		output("You manage to leap backwards just in time to avoid a strike that could have seriously hurt you. Amily recovers quickly and readies her knife again, only to realize that it's you. An irritated expression crosses her face. \"<i>Are you insane!? Do you have any idea how stupid that was? I could have killed you!</i>\" she bellows, before slowly calming down. \"<i>Ah, well... no harm, no foul, I guess...</i>\"\n\n");
		output("She shifts awkwardly. \"<i>Ah... do you have the time to talk? There's something I want to get off my chest,</i>\" Amily nervously asks.\n\n");
	}
	processTime(3);
	desperateFinallyAmily();
}

private function desperateFinallyAmily():void {
	amilySprite();
	output("Curious what she has to say, you agree.\n\n");

	output("Amily scuffs the ground with one of her finger-like toe claws, looking down at it as if it was the most interesting thing in the world – or as if she doesn't dare to look you in the eyes. \"<i>I... You know what I've been asking of you; from you, and you keep turning me down... but you kept talking to me, asking me about myself. You wanted to get to know me, but... why don't you want to know ALL of me? I... I want to give myself to you. You're the nicest, kindest man I've met – even before the demons destroyed my village. I want to be with you... but you don't seem to want to be with me.</i>\" She looks up to you at last, her eyes wet with tears. \"<i>Is there something wrong with me? Can't you like me in that way?</i>\" she pleads.\n\n");

	//Accept her / Turn her down gently / Turn her down bluntly
	processTime(2);
	clearMenu();
	addButton(0, "Accept Her", desperateAmilyPleaAcceptHer);
	addButton(1, "TurnDownGently", desperateAmilyPleaTurnDown);
	addButton(3, "TurnDownBlunt", desperateAmilyPleaTurnDownBlunt);
}

//[Accept her]
private function desperateAmilyPleaAcceptHer():void {
	clearOutput();
	amilySprite();
	//set accepted flag
	flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
	output("With a gentle smile, you reach out and take hold of her hand. You tell her that you do like her too; you just wanted to know her as a person before you would take something as precious to her as her virginity. If she still wants you, then you want to go with her now.\n\n");

	output("Amily stares at you, stunned. After a moment, she embraces you fiercely and begins to drag you away.\n\n");
	//[/ Go to [High Affection Sex]]
	processTime(2);
	clearMenu();
	addButton(0, "Next", amilySexHappens);
}

//[Turn her down gently]
private function desperateAmilyPleaTurnDown():void {
	clearOutput();
	amilySprite();
	output("You softly tell her that you're sorry, but it just can't be helped. You have a quest to fulfill, and you don't even know if you'll be staying around instead of going home when it's over. That's even assuming you succeed, and don't end up dead in a ditch somewhere. You can't countenance taking a lover with something like that hanging over your head. Besides, you tell Amily that she should have more respect for her body than what this plan of hers entails, anyway.\n\n");
	output("Amily sniffs loudly, tears blatantly running down her cheeks. \"<i>If... if that's the way it has to be, then,</i>\" she sniffles, \"<i>I... I guess that there's nothing left for me here. I'll just have to leave... Maybe I can find somewhere that will at least give me shelter.</i>\"\n\n");
	//[Player has found Tel'Adre]
	if (flags["COC.TEL_ADRE_KNOWN"] >= 1) {
		output("You tell her that you've discovered a hidden city in the desert, free of corruption. Amily looks shocked, but clearly grateful as you assure her of its existence and provide instructions on how to get there.\n\n");
	}
	else {
		output("Looking dejected, Amily slowly begins to walk away. However, just before she makes her final turn to disappear, she turns back to you. \"<i>I'll always remember you,</i>\" she promises sincerely – and then she is gone.\n\n");
	}
	output("Feeling the weight of the empty village pressing in on you, you quickly retreat yourself. There's no point coming back here.\n\n");
	//turn off village.
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	processTime(7);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Turn her down bluntly]
private function desperateAmilyPleaTurnDownBlunt():void {
	amilySprite();
	clearOutput();
	output("Without mercy or hesitation, you tell her that there is indeed something wrong with her: You could never be attracted to a woman that looks like a pest and should be hiding in a granary.\n\n");

	output("\"<i>Why you-! I bare my soul to you, and this is how you repay me?!</i>\" Amily screams; rage, hurt and betrayal are all evident in her words.\n\n");

	output("You jeer at her that it's not your fault that she's so pathetic, falling for the first person to take pity on her and talk to her.\n\n");

	output("Amily responds by spitting a stream of the most jarringly foul language at you. In her rage, she hurls a blowpipe dart at you with her hands, which you easily swat aside. Cursing all the while, she races off in a fury.\n\n");

	output("You know she's never going to come back.");
	//Player gains corruption}
	pc.cor(1);
	//{Amily can no longer be encountered}
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	//{Ruined Village removed from Places list}
	processTime(7);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Birth]
private function fuckingMouseBitchPopsShitOut():void {
	amilySprite();
	output("You head into the ruined village, wondering how Amily is doing. You can't be sure, but you think that it will soon be time for her to give birth. Right as that thought sinks in, you hear a squeaking wail of pain in the distance. You hurriedly take off to find the source, and you soon find her; Amily, squatting naked in the shelter of a building. She squeals softly with exertion as her swollen abdomen visibly ripples, and fluids drip from her swollen pink vagina. She is definitely in labor.\n\n");

	output("What will you do?");
	//Increase baby count here rather than in 3 places.
	IncrementFlag("COC.AMILY_BIRTH_TOTAL");
	StatTracking.track("coc/pregnancy/amily");
	//Leave / Watch / Help
	processTime(3);
	clearMenu();
	addButton(0, "Leave", pregnancyIsScaryGoddamnMousePregnancyImNotWatchingThisShit);
	addButton(1, "Watch", heyIGotTicketsToMicePoppingOut);
	addButton(2, "Help", helpThatFukkinUngratefulBitchGiveBirth);
}

//[Leave]
private function pregnancyIsScaryGoddamnMousePregnancyImNotWatchingThisShit():void {
	clearOutput();
	amilySprite();
	output("You make a hasty retreat. You aren't sure why; maybe it was fear, maybe it was memories of the way the midwives always chased the men away when one of the women back in the village went into labor. Reassuring yourself that she will be fine, you head back to camp.\n\n");

	output("The next morning, you find a note scratched onto a slab of bark beside your sleeping roll, reading, \"<i>The babies and I are both fine. No thanks to you!</i>\"\n\n");
	//{Affection goes down}
	flags["COC.AMILY_AFFECTION"] -= 10;
	processTime(3);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}


//[Watch]
private function heyIGotTicketsToMicePoppingOut():void {
	clearOutput();
	amilySprite();
	output("You don't want to just run away and leave her, but at the same time you think it would be best to respect her privacy. You stand a respectful distance away, watching as she strains. Her pink nether lips part and a small");
	//([horsecock]
	if (amily.hasFur()) output(", mousy figure – pink, hairless and ");
	else output(" figure –");
	output(" maybe six inches tall – slips out, falling to the ground with a squeak. Fortunately, Amily has prepared a pile of rags and soft leaves to cushion its landing. It rolls around a bit, and then scrambles with surprising speed; which is good, as it is joined by company very quickly. A second infant falls onto the padding beside it, and then a third... a fourth...\n\n");

	output("You watch as baby after baby slips free of its mother's womb and into the wider world. ");
	//([horsecock]
	if (amily.hasFur()) output(" Though hairless like regular infant mice,");
	else output(" Though remarkably similar to a regular infant - minus the ears and tail, of course -");
	output(" they can already crawl around at high speed; even totter unsteadily on two legs. The first of them begin to instinctively make its way up its mother's body to latch onto one of her nipples and suckle. You lose count somewhere after a dozen, but Amily finally gives an exhausted sigh of relief as the afterbirth slips free of her body. Each infant has nursed from her by this point. They now seem more confident about standing on two legs,");
	//([horsecock]
	if (amily.hasFur()) output(" and fur has already begun to cover their formerly-naked bodies.");
	else output(" maturing dramatically as you watch.");
	output("  Their color patterns vary considerably; white, black and brown are most common, and you even see one or two with your hair color. Amily flops back onto her rump and then topples over onto her back, clearly too tired to stand up. Her offspring crowd around, cuddling up to her, and she gives them a tired but happy smile.\n\n");

	output("Making sure that there doesn't seem to be any danger, you quietly let yourself out. It seems that she's too concerned about the children to notice you leave.");
	processTime(45);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Help]
private function helpThatFukkinUngratefulBitchGiveBirth():void {
	clearOutput();
	amilySprite();
	output("You move forward instinctively. Amily is in labor – she needs help. The fact that you are the father only makes it more natural for you to want to help her.\n\n");
	output("\"<i>Hghnn... [pc.name]? What are you doing?</i>\" Amily asks, before groaning again as another contraction hits her. You reassure her that you're here to help as you kneel beside her, and reach out to touch her swollen middle, placing one hand on either side of its globular mass. Unsure of what else to do, you start to gently massage it, trying to relax and soothe the muscles after every time they clench and lower the pain when she goes through another contraction. She starts to thank you, then clenches her teeth,");

	//([horsecock]
	if (amily.hasMuzzle())
		output("turns her little muzzle skywards and hisses in pain");
	else
		output("hissing in pain"); // This sound a bit wrong for what should look like a human...

	output(" as the strongest contraction yet hits – she's crowning! Immediately your hands dive down to hover under her vagina as a small, pink, naked and wriggling thing slips between their parted lips. The little body is surprisingly light in your hands, but it squeaks loudly as it draws its first breath – correction, HER first breath. It's a ");
	var amilyKid:String = "girl";
	if ((pc.isHerm() || amily.hasCock()) && rand(2) == 0) amilyKid = "herm";
	if (pc.isHerm() && amily.hasCock()) amilyKid = "herm";
	output(amilyKid + ".\n\n");

	output("Awestruck, you tell Amily that she's beautiful and you really mean it. Even though she's a different species, she's your daughter and she's gorgeous to you.\n\n");
	output("\"<i>That's nice... but there's a lot more where she came from, so...</i>\" Amily trails off as another contraction hits, and you see a second baby beginning to peek out between her nether lips. At your panicked expression, she manages a grim laugh. \"<i>Just... put her to my breast. She can handle things from there,</i>\" she instructs you.\n\n");
	output("Uncertain, you do as you are told; your daughter latches onto her mother's ");

	//([horsecock]
	if (amily.hasFur())
		output("fur");
	else
		output("bosom");

	output(", rooting eagerly for her nipple as your hands dart down to catch her first sibling. It almost becomes a rhythm; catch a baby, place her or him at Amily's breast to nurse, catch the next baby... Well over a dozen babies are born – you think it might be as many as two dozen – before Amily finally stops, the afterbirth gushing out to signal the end of her labors. Gently, you catch her and lower her onto a soft piece of ground to rest. Around you, your many children play; though born only a short time ago, they can now stand strong and proud on their two legs.");

	//([horsecock]
	if (amily.hasFur())
		output("Their fur has come in too, something triggered by the first drink of their mother's milk.");
	else
		output("Their hair is also starting to grow in an accelerated rate.");

	output("  Your firstborn daughter is already asserting herself as the leader of the pack, and you can't help but notice that her ");

	//([horsecock]
	if (amily.hasFur())
		output("fur");
	else
		output("hair");

	output(" is the same color as your hair.\n\n");
	output("Amily is tired, but she smiles at you happily. \"<i>I... thank you. For being here. For me – and them,</i>\" she says. You assure her that it was no problem. You sit there with her, letting your inquisitive offspring examine you and tussle with you while their mother regains her strength.\n\n");
	output("As the rambunctious little mouselets burn up their energy and curl up beside Amily to sleep, you gently excuse yourself and return to camp.");
	//{Affection goes up}
	flags["COC.AMILY_AFFECTION"] += 5;
	processTime(45);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Bad End]
private function thisIsAReallyShittyBadEnd():void {
	clearOutput();
	amilySprite();
	output("You wander through the empty streets of the ruined village, wondering where Amily is. For all her many faults, she's an acceptable fuck. The sudden sound of footsteps catches your attention, and you ready yourself for battle; Amily never makes her presence felt so clumsily.\n\n");

	output("Except for today. Amily walks out to confront you casually. \"<i>Ah, [pc.name], there you are,</i>\" she states. \"<i>Good. I was hoping to see you one last time; I thought you at least deserved a goodbye.</i>\"\n\n");

	output("\"<i>A goodbye?</i>\" you echo, confused.\n\n");

	output("Amily nods, then puts a finger to either side of her mouth in order to whistle piercingly. All around you, from behind walls and out of holes in roofs, mousy faces begin to pop up. There are dozens of them! Their fur is primarily white, black, brown and mottlings of the three, but you see some that have your own hair color as well. You gape for a moment in shock, and then begin to ask, \"<i>These are...?</i>\"\n\n");

	output("\"<i>The results of the litters that you fathered with me, yes.</i>\" Amily nods. \"<i>They are my children – my tribe – and we are now numerous and strong enough to leave these lands... find a new place to carve out a home for us.</i>\"\n\n");

	output("As you watch, they begin gathering at one street opening behind their mother. They're clad in rags and wield makeshift weapons, but look determined and surprisingly fierce.\n\n");

	output("\"<i>This is goodbye, [pc.name]. You may not have been the most noble of [men]... but you did help me in my quest, and I am grateful – no matter how selfish your reasons may have been.</i>\"\n\n");

	output("Amily inclines her head towards you in a respectful nod, and then joins her vast brood as they begin to march away purposefully. You watch them go until they have vanished from sight, then shake your head with a sneer. Like you need her or her brats, anyway! Spinning on your heel, you stride purposefully out of this dump of a village; you don't intend to come back here again.\n\n");

	output("Amily has left the region with her children to found a new colony elsewhere.\n\n");
	//{Amily can no longer be encountered}
	//{Ruined Village removed from Places list}
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	processTime(30 + rand(10));
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}


//Good End:
private function thisFunctionProbablySucksTooOhYeahAmilyFunction():void {
	clearOutput();
	amilySprite();
	output("As you wander through the empty streets of the ruined village, you wonder where Amily is. Even beyond what she means to you now, you simply enjoy knowing that there's someone else in this twisted place you can talk to.\n\n");

	output("\"<i>[pc.name]! Darling! You're here!</i>\"\n\n");

	output("You hear her delighted squeak, but she moves too quickly for you to catch, fiercely tackling you and embracing you.\n\n");

	output("\"<i>I was wondering if maybe we should go and find you first, I didn't want you to miss this chance.</i>\" She tells you, nuzzling your side emphatically.\n\n");

	output("Too confused to even hug her back, you ask what she's talking about.\n\n");

	output("Amily blinks and looks confused, then smiles. \"<i>Oh, right, I'm getting ahead of myself. Kids! Come and say hello to your father!</i>\" She calls out in delight.\n\n");

	output("Before your eyes, a veritable stampede of forms erupt from the rubble, mice in a wild array of colors - black, white and brown are most common, but you see more than a few with your hair (well, fur) color and eyes - charging to surround you, chittering and squeaking happily. You fight to keep your footing when they press in around you so enthusiastically. You can be forgiven for taking several long moments before what Amily said registers.\n\n");

	output("\"<i>These are...?</i>\" You begin hesitantly, unable to say it.\n\n");

	output("“<i>Our children, yours and mine");
	// Mix
	if (StatTracking.getStat("coc/pregnancy/pc amily") > 0 && StatTracking.getStat("coc/pregnancy/amily") > 0)
	{
		output(".</i>”");
	}
	// Only PC birth
	else if (StatTracking.getStat("coc/pregnancy/pc amily") > 0 && StatTracking.getStat("coc/pregnancy/amily") == 0)
	{
		output(", planted by me inside of you.</i>”");
	}
	// Only Amily birth
	else if (StatTracking.getStat("coc/pregnancy/pc amily") == 0 && StatTracking.getStat("coc/pregnancy/amily") > 0)
	{
		output(", planted by you inside of me.</i>”");
	}
	output("  Amily trills happily.\n\n");

	output("You can only stare at the multitude in shock. From somewhere inside you, a lone thought wondering what your mother would say at the sight of so many grandchildren rears itself, only to be brushed aside when the realization of what else Amily said manages to sink in. You ask if she's leaving.\n\n");

	output("\"<i>Yes. There's enough of them here now that they can survive leaving this place to establish a new village elsewhere.</i>\" She confirms. \"<i>...Oh, don't look so gloomy!</i>\" She laughs, watching your face as you digest this news. \"<i>I'm not going with them.</i>\"\n\n");

	output("You can only start in shock and disbelief at this statement. Amily steps close, takes you hand in hand, and does her best to look you in the eyes. \"<i>");
	if (flags["COC.AMILY_MET_AS"] == 1) output("When we first met, you were just sperm to me, a pure male to father the children I needed. ");
	else output("When we first met, I was afraid of you, I needed your male essence, but I was prejudiced against your other gender. ");
	output("But as I got to know you, you became more to me. I love you, [pc.name], and I don't want to leave you. You came to this world on a quest, didn't you? Well, you helped me with my quest, so it's only fair I help you with yours. The children have been taught well, they can make their own way from here and now... but I want to come back with you, to stay with you and help however I can. Will you let me?");
	output("</i>\"\n\n");

	output("You shake off your confusion as her words sink in. Smiling broadly, you wrap her in your arms and tell her you want her to come back with you. She smiles, and hugs you back with surprising fierceness, even as your many children react with delight.\n\n");

	output("You spend over an hour getting to know your many sons and daughters, helping them pack up their meager supplies and wishing them well as they set off. Then, with Amily's hand in yours, you return to your camp, leaving behind this empty village to be reclaimed by the wilderness.\n\n");
	//Oh boy.  So excited.  wee.  Blech.
	output("\\[<b>Amily has joined you as a lover.</b>\\]\n\n");
	//Set amily follower flag
	flags["COC.AMILY_FOLLOWER"] = 1;
	amily.breastRows[0].breastRatingRaw = 1;
	amily.nippleLengthRatio = .3;
	amily.hipRatingRaw = 6;
	amily.buttRatingRaw = 6;
	amily.vaginas[0].wetnessRaw = 1;
	amily.armor.longName = "rags";
	
	////if marble is there, tag it for freakout
	if (flags["COC.MARBLE_FOLLOWER"] == 1) {
		flags["COC.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT"] = 1;
	}
	else flags["COC.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT"] = 2;
	//if Izma is there, tag for freekout!
	if (izmaFollower()) {
		flags["COC.UNKNOWN_FLAG_NUMBER_00236"] = 1;
	}
	//Disable amily encounters in the village!
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	processTime(45);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Conversations - talk wif da bitch.
public function talkWithCuntIMeanAmily(sexAfter:Boolean = false):void {
	clearOutput();
	amilySprite();
	var convo:Number = rand(15);
	
	// Bump past convo #12 if she's already at camp because it doesn't make much sense by this point.
	if (convo == 12 && amilyFollower()) convo++;
	
	//Girls dont get to listen to amily talk about being knocked up.
	//Herms either unless she's okay'ed them for dad-hood.
	if (gender(pc) == 2 || (pc.isHerm() && !(flags["COC.AMILY_HERM_QUEST"] >= 2))) convo = rand(12);
	//Boost affection!
	flags["COC.AMILY_AFFECTION"] += 2 + rand(3);
	pc.cor( -1 / 3);
	//Conversation: Items
	if (convo == 0) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the various potions and elixirs discovered in this world.\n\n");

		output("\"<i>You know...  I don't have the equipment needed to practice alchemy, but I do know a few things about it.</i>\" Amily says.  \"<i>If you can bring me a potion or a reagent, I may be able to remember some of the things my father taught me.</i>\"\n\n");

		////(If player has no main item:)
		//if (pc.itemSlot1.quantity == 0) {
			//output("Promising you'll keep that in mind, you take your leave of Amily.\n\n");
			//if (sexAfter) doNext(determineAmilySexEvent());
			//else doNext(returnToCampUseOneHour);
			//return;
		//}
		////(If player has an item:)
		//else {
			//output("You remember that you have something in your pockets that might be of interest, and show it to Amily.\n\n");
		//}
		if (pc.hasItemByType(CoCEquinum)) {
			output("\"<i>That's a distillation of horse essence, I think.</i>\" Amily says.  \"<i>I guess it would probably make you stronger and tougher... but horses aren't smart, and it might be too strong for a human to handle without changing them,</i>\" she warns you.\n\n");
		}
		//Canine Pepper & Variants:
		else if (pc.hasItemByType(CoCCaninePepper) || pc.hasItemByType(CoCCaninePepperLarge) || pc.hasItemByType(CoCCaninePepperDouble) || pc.hasItemByType(CoCCaninePepperBlack) || pc.hasItemByType(CoCCaninePepperKnotty) || pc.hasItemByType(CoCCaninePepperBulby)) {
			output("\"<i>Looks kind of like a dog's dick, doesn't it?  Especially this one with the big knot-like bulge or this one with the ball-like bulbs.  I suppose it would make you more dog-like... but I'm pretty sure you should avoid these jet-black ones.  I can't remember why...</i>\" she trails off, wracking her brain.\n\n");
		}
		//Succubus Milk/Incubus Draft:
		else if (pc.hasItemByType(CoCIncubiD) || pc.hasItemByType(CoCSucMilk)) {
			output("She recoils with a hiss.  \"<i>That's demon fluid, it is - like drinking liquid corruption! Avoid that stuff if you can; it'll turn you into a demon, and supercharge your sex-drive.  I've heard it can even mess with your gender if you drink too much of the opposite stuff.</i>\"\n\n");
		}
		//Succubi's Delight:
		else if (pc.hasItemByType(CoCSucDelight)) {
			output("\"<i>Full of taint, no question of that.  Succubi give it to males who haven't become demons yet; makes them better able to produce cum, and pushes them towards demonhood.</i>\"\n\n");
		}
		//Wet Cloth:
		//else if (pc.itemSlot1.itype == consumables.WETCLTH) {
			//output("\"<i>I... have no idea what that is.</i>\" she says, looking confused.  \"<i>I guess it's... slimey?  Concentrate of goo?  I think it's got something to do with whatever's been polluting the lake, so I wouldn't rub it into your skin.</i>\"\n\n", false);
		//}
		//Bee Honey:
		else if (pc.hasItemByType(CoCBeeHoney)) {
			output("\"<i>Honey from a giant bee?</i>\" she asks eagerly, perking up.  \"<i>Oh, that stuff's delicious! I hear it's full of special essences secreted by the giant bees, though, so it could have transformative effects.</i>\"\n\n");
		}
		//Pure Honey:
		else if (pc.hasItemByType(CoCBeeHoneyPure)) {
			output("\"<i>You managed to get your hands on ultra-pure giant bee honey?</i>\" she asks, sounding impressed.  \"<i>I hear that stuff's so pure it can actually help purge the eater of demonic taint - but it's probably otherwise the same as regular bee honey.</i>\"\n\n");
		}
		//Whisker Fruit:
		if (pc.hasItemByType(CoCWhiskerFruit)) {
			output("\"<i>That's a whisker fruit,</i>\" Amily says, \"<i>It might give you cat ears and even tail! It would make you cute-looking!</i>\"\n\n");
		}
		//Pigtail or Boar Truffle:
		//if (pc.itemSlot1.itype == consumables.PIGTRUF || pc.itemSlot1.itype == consumables.BOARTRU) {
			//output("\"<i>That's a pigtail truffle,</i>\" Amily says, \"<i>It might give you pig ears and even tail! It would make you plump and cute-looking!</i>\"\n\n", false);
		//}
		//Green Glob:
		else if (pc.hasItemByType(CoCGreenGel)) {
			output("\"<i>A blob of slime from a green gel?  Hmm...</i>\" she looks thoughtful.  \"<i>I think I remember my dad once telling me you could make a really strong armor out of a special distillation of green oozes.  I can't say for sure, and I wouldn't have the equipment even if I did remember.</i>\"\n\n");
		}
		//Bee Chitin:
		else if (pc.hasItemByType(CoCBlackChitin)) {
			output("\"<i>If you had a sufficient mass of this stuff, you could make a suit of armor out of it.  It needs special alchemical reagents, though, otherwise it'll just get all brittle and smashed up.</i>\"\n\n");
		}
		//Spider Silk:
		else if (pc.hasItemByType(CoCToughSpiderSilk)) {
			output("\"<i>Some spider silk? I think I remember someone who could take these and make them into armor or even comfortable robes.</i>\"\n\n");
		}
		//Dragon Scale:
		else if (pc.hasItemByType(CoCDragonScale)) {
			output("\"<i>Dragonscale? I never knew dragons existed");
			//if (camp.followerKiha() || camp.followerEmber()) output(" until");
			//if (camp.followerKiha()) output(" Kiha");
			//if (camp.followerKiha() && camp.followerEmber()) output(" and");
			//if (camp.followerEmber()) output(" Ember");
			//if (camp.followerKiha() || camp.followerEmber()) output(" came to your camp");
			output(". They could be made into flexible yet protective armor.</i>\"\n\n");
		}
		//Imp Skull:
		//else if (pc.itemSlot1.itype == useables.IMPSKLL) {
			//output("\"<i>The skull of an imp? I hunt imps and sometimes, I would cut their head off and take their skulls as trophy. " + (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 ? "I'll hang some the skulls on the wall around your camp. You did a good job with the wall though." : "") + "</i>\"\n\n", false);
		//}
		else {
			output("You promise that you'll keep that in mind");
		}
		if (sexAfter) output(".\n\n");
		else output(" and take your leave of the mouse-girl.\n\n");
	}
	//Conversation: Minotaurs
	else if (convo == 1) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the strange bull-men that you have seen haunting the mountains.\n\n");

		output("\"<i>You were lucky to get away with your skin intact.</i>\" Amily tells you emphatically.  \"<i>Minotaurs are dangerous brutes - they're one of the biggest, strongest and toughest beasts around.  I don't dare go near the mountains, not with those beasts roaming around.  Sometimes they carry around huge axes, but usually they make do with just their huge, knuckley fists.</i>\"\n\n");

		output("You ask her why it is that minotaurs are so dangerous; they don't seem to look like demons.\n\n");

		output("\"<i>They may as well be demons, now. Oh, they may not look corrupted, but all they care about is finding something to rut with - man, woman, both, neither, they don't care.  So long as it's got a hole, they'll fuck it...  I think maybe I heard somewhere that they can only reproduce by raping other creatures with a vagina now, but I don't remember where.</i>\"  She looks perturbed, but why you can't say for certain.\n\n");

		output("You ask her then if she has any advice on how to deal with them.\n\n");

		output("Amily laughs.  \"<i>Not really; me, I run if ever I see them.  I'm not a stand-up fighter to begin with, but against those brutes?  And it's not just their strength, either...  I think they've got some kind of addictive chemical in their cum.  The stink of their presence alone can make you feel turned on.  There was this one that managed to corner me; it pulled out its huge horse-cock and started masturbating.</i>\"  She shudders in disgust.  \"<i>I narrowly missed getting sprayed, but the smell... it was intoxicating.</i>\"  She admits, clearly embarrassed.  \"<i>My legs nearly buckled from arousal - it was so tempting to just give in and let him fuck me.</i>\"\n\n");

		output("You ask her what she did.\n\n");

		output("\"<i>I fought it off and ran,</i>\" she insists, looking a little insulted, ");
		//(If player hasn't had sex with Amily:
		if (flags["COC.AMILY_FUCK_COUNTER"] == undefined) output("\"<i>I am still a virgin, after all.</i>\"\n\n");
		//(If player has had sex with Amily:
		else output("\"<i>I was a virgin when we met, in case you forgot.</i>\"\n\n");

		output("\"<i>The big brute was stupid enough to follow me; once I got to the trees, where he couldn't get around so easily, I put a poisoned dart in each of his eyes.  When he stopped thrashing around, I walked up and slit his throat.</i>\"\n\n");

		output("She looks quite proud of herself for that.  Feeling a bit disturbed by her ruthlessness, you thank her for the warning");
		if (sexAfter) output(".\n\n");
		else output(" and excuse yourself.\n\n");
	}
	//Conversation: Sand Witches
	else if (convo == 2) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the mysterious female magic-users you've seen in the Desert.\n\n");

		output("\"<i>Sand Witches, eh? Funny, it seems the only pseudo-humans left in this area that aren't demons are magic-users... even though it was their usage of magic that turned the first demons into demons,</i>\" Amily notes.  \"<i>Or so I heard, anyway,</i>\" she adds.\n\n");

		output("You ask her if she knows what the Sand Witches are trying to do out there in the desert.\n\n");

		output("\"<i>Not a clue.  I think... I think that they might be some kind of druidic sect or something. Restoring life to the desert, trying to make it into grassland or something like that,</i>\" Amily suggests.\n\n");

		output("You ask her why she comes to that conclusion.\n\n");

		output("\"<i>Have you seen them under those robes?  They're all women, they all have two pairs of breasts, and those breasts are always bloated huge with milk.  My guess is that they've gone mad like those Fetish Cultists; they're not proper demons, but they're still sex-warped.  Maybe they use milk to try and nourish seedlings or something,</i>\" the mouse-woman shrugs.\n\n");

		output("You ask her how on earth she would know that all Sand Witches have four milk-filled breasts.  She blushes deeply and fidgets, clearly embarrassed.  Finally, she speaks up.\n\n");

		output("\"<i>I... kind of got lost in the desert once.  A Sand Witch approached me and asks me if I'd let her cast a spell on me.  When I refused, she attacked, trying to beat me down so she could cast it on me anyway.</i>\"\n\n");

		output("You interrupt to ask her what the spell would have done.\n\n");

		output("\"<i>How should I know? Make me into some kind of milk-producing slave?</i>\" Amily retorts fiercely, tail lashing in agitation.  \"<i>I didn't give her a chance to use it.  Three sleeping potion darts in her face, quicker than she could blink.  I was annoyed, so I pulled off her robes to bind her limbs - I figured that'd slow her down long enough when she woke up that I'd be far away.  Her breasts were full of milk - so full I could see it leaking out of each nipple.</i>\"  She blushes intently, clearly embarrassed.  \"<i>I... I hadn't had anything to eat or drink for ages, I was starving and thirsty and so I...</i>\"\n\n");

		output("You assure her that she doesn't need to spell it out.  She looks grateful, then continues.\n\n");

		output("\"<i>So, I had just drunk my fill, feeling fuller then I had in weeks, and then, you won't believe it, another Sand Witch shows up - from the things she was saying, I must have accidentally interrupted some kind of lesbian tryst they had planned.  I grab my stuff and bolt for safety - not quick enough to keep her from casting some spell that makes this stone orb fly up my... my...</i>\"  She blushes again.  \"<i>It was like having some kind of vibrating sex toy jammed up there. I don't know how I managed to run away with it, but when I got too far, it dissolved into sand and just fell out.  I don't think they can take much punishment, but they've clearly got some nasty tricks.</i>\"\n\n");

		output("Thanking her for the advice, you promise you'll be more careful if you see them in the future");
		if (sexAfter) output(".\n\n");
		else output(" and take your leave.\n\n");
	}
	//Conversation: Giant Bees
	else if (convo == 3) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the strange bee-like women you've seen in the forest.\n\n");

		output("\"<i>Giant Bees?  They're a strange race,</i>\" Amily says.  \"<i>They're not really corrupt, but at the same time, they act kind of like demons.</i>\"\n\n");

		output("You ask her to explain how that works.\n\n");

		output("\"<i>Well... the Giant Bees you've probably seen?  The official name for them is the fertile caste, but folks tend to just call them handmaidens,</i>\" Amily explains.\n\n");

		output("At your confused look, she continues.\n\n");

		output("\"<i>Giant Bees hatch from each egg as hundreds of regular-looking little bees.  And fertiles are involved in that - for some reason, the eggs need to incubate inside a living being to hatch in the first place.</i>\"\n\n");

		output("Your expression probably tells the story, because Amily giggles slightly before adding.  \"<i>It's not dangerous or anything like that!  The queen and the handmaidens both have this cock-like appendage on their abdomens; the queen uses this to lay her eggs into the handmaidens, filling up their abdomens, while the handmaiden then lays a mixture of eggs and honey into a person's gut via their anus.  The eggs kind of... well, they sit there, and then, when they're ready to hatch, they just... come out.</i>\"\n\n");

		output("She shrugs, clearly not able to explain it any better than that.  You ask how you can avoid such a fate.\n\n");

		output("\"<i>Well, they mainly use this hypnotic thrumming from their wings; but if you've got a strong, sharp mind you can shake it off.  They aren't the kind to get violent; they will ask you to accept their eggs, if you resist their hypnosis, but they won't try to beat you into submission so they can lay their eggs.  I wouldn't recommend fighting them; they're quick and pretty tough, thanks to that armor, and they've got this nasty venom that saps your strength and arouses you at the same time.</i>\"\n\n");

		output("You thank her for her advice, and then, curious, ask how she knows so much about these creatures.\n\n");

		output("Amily looks flustered.  \"<i>Well, they, they have been willing to trade honey in the past if you confront them peacefully and... alright, I'll admit it, when times have been really lean, I've been willing to host some giant bee eggs in exchange for honey.</i>\"\n\n");

		output("You smile and thank her for sharing, noting that she didn't need to tell you such personal information");
		if (sexAfter) output(".\n\n");
		else output(", and politely excuse yourself.\n\n");
	}
	//Conversation: Fetish Cultists & Zealouts
	else if (convo == 4) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the bizarrely-dressed people you've caught glimpses of around the lake.\n\n");

		output("Amily thinks fiercely, then shakes her head, looking apologetic.  \"<i>I'm sorry, I don't know anything about them.  They're new to this area, I can tell you that much.  It looks like they have some weird magic that lets them change their clothes at random.  I stay away from them; there's something about them that reminds me of demons, but they're... scarier, somehow.</i>\"\n\n");

		output("Telling her that it's all right if she doesn't know that much, you get up");
		if (sexAfter) output(" and sigh.\n\n");
		else output(" and leave.\n\n");
	}
	//Conversation: Imps
	else if (convo == 5) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the small demons you've seen in your travels.\n\n");

		output("\"<i>Imps!</i>\" Amily spits, looking fierce.  \"<i>Disgusting demon vermin, that's what they are! All over the place, looking to rape anything they can get their hands on.  They're puny little creatures, and they're easy to cut down, but they use black magic to try and make you so horny they can rape you.  I kill them wherever I find them, but there's always more and more of them.</i>\"\n\n");

		output("Her tail is lashing furiously from side to side, and, clearly worked up, she tensely excuses herself ");
		if (sexAfter) output("and regains her composure.\n\n");
		else {
			output("and leaves.");
			if (flags["COC.AMILY_FOLLOWER"] == undefined) output("  As you set off back to camp,");
			else output("  As you sit back down in camp,");
			output(" you have little doubt that she's gone to find and kill an imp.\n\n");
		}
	}
	//Conversation: Shark Girls
	else if (convo == 6) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the humanoid female sharks you've seen while rowing your boat.\n\n");

		output("\"<i>Shark Girls? Near as I can tell, they used to be a village of humans who lived right here on the lake... then the lake got polluted, and turned them all into... well, what they are now.</i>\"\n\n");

		if (!izmaFollower()) output("She looks pensive.  \"<i>Odd... I don't think they have any males left, but on very rare occasions I've seen these weird tiger-striped Shark Girls... and they always had huge cocks and balls as well.  But, whether female or herm, they seem to only care about fighting and fucking... and from the way I've seen them going at it, I don't think they see any difference between the two any more.</i>\"\n\n");

		output("You ask her if she has any advice on fighting them.\n\n");

		output("\"<i>I'm afraid not.  They don't come to the shore too often, never mind too far out of the lake. They're probably resistant to pain and have a really wicked bite, though,</i>\" she tells you.\n\n");

		if (!sexAfter) output("Thanking her for her time, you take your leave of her.\n\n");
		else output("You thank her for her time as the conversation winds down.\n\n");
	}
	//Conversation: Goblins
	else if (convo == 7) {
		output("The two of you swap tales about your respective adventures, and from there the topic drifts to the strange green women you've seen in the forest and the mountains.\n\n");

		output("\"<i>Ah, Goblins.</i>\" Amily says, shaking her head sadly.  \"<i>Yet another race corrupted by the demons.  Used to be that all they wanted was to experiment with potions and build machines.  Now all they do is fuck... Weird thing is, they seem to actively want to get pregnant.  I've heard that giving birth is like the biggest, most prolonged orgasm to them.</i>\"\n\n");

		output("You ask if they're aggressive.\n\n");

		output("\"<i>Not particularly... but, if you're female, they may get territorial and attack without warning, and if you've got a penis, they'll want to have sex with you, even if that means beating you into submission.  They're... honestly kind of puny.  If you can dodge the lust potions and poisons they throw, they basically can't do anything to you.</i>\"\n\n");

		if (!sexAfter) {
			if (flags["COC.AMILY_FOLLOWER"] == undefined) output("Thanking her for her time, and the warning, you head back to your own camp.\n\n");
			else output("Thanking her for her time, and the warning, you sit back down in your camp.\n\n");
		}
		else output("You thank her for her time as the conversation winds down.\n\n");
	}
	//Conversation: What was life in her village like?
	else if (convo == 8) {
		output("You think for a moment, wondering what to ask her. Then you shrug your shoulders and tell her that you'd like to know a little more about her, that you want to get to know her better.\n\n");

		output("Amily looks surprised... but pleased.  \"<i>I... You're really interested in hearing about me?  Well... okay.  What do you want to know?</i>\"\n\n");

		output("You rack your brains for a few moments, then ask her to tell you what life was like in her village, before everything.\n\n");

		output("\"<i>Well, what was life like in your village, huh?</i>\" she responds immediately.  \"<i>If I gotta share something private like that, then the least you can do is reciprocate.</i>\"\n\n");

		output("Her tone is light and playful, you think she may only be teasing, but you decide that it is fair.  And so you start to talk, telling her about your village; you describe the people, your friends, the places you liked to go.  She sits and stares at you, clearly not expecting you to share that kind of information, but she looks quite appreciative, and she listens intently.  Finally, when you finish, she gives a soft, sad smile, shakes her head, and then starts to speak.\n\n");

		output("\"<i>Life in the village, huh? It was so many years ago... and yet, I can remember it almost like it was yesterday.  The demons had already been around for a few years by the time I remember - I think I was born maybe shortly after they first appeared, I haven't celebrated my Day of First Breath in so long I don't really know how old I am.  We had walls to protect the village, and guards, but we never really believed that we would ever have to fight.  We were a peaceful, quiet little village; we had nothing of real monetary worth, we thought we would be safe, that the demons would just ignore us.  We fished in the lake, went swimming and sailed boats to amuse ourselves, we gathered fruits and nuts and berries and mushrooms from the forest, we hunted birds and small game for meat.</i>\"\n\n");

		output("She sighs softly.  \"<i>We were fools... but we were so happy, can we be blamed for being fools?  Life wasn't perfect, the hunters often had to hunt imps, but they never invaded our streets, and so we thought we were safe.  We quarreled and made up, we laughed and loved and lived...  It was such a wonderful time.</i>\"\n\n");

		output("You see a small tear form in her eye and trickle down her cheek.  Unable to say why, you reach out and wipe it away with your finger.  She looks at you, startled");
		if (!sexAfter) output(", and, embarrassed and unable to explain why you did that, you politely take your leave.");
		else output(", before giving you a warm smile.\n\n");
	}
	//Conversation: Who was she before it was all lost?
	else if (convo == 9) {
		output("You think for a moment, wondering what to ask her.  Then you shrug your shoulders and tell her that you'd like to know a little more about her, that you want to get to know her better.\n\n");

		output("Amily looks surprised... but pleased.  \"<i>I...  You're really interested in hearing about me?  Well... okay.  What do you want to know?</i>\"\n\n");

		output("You rack your brains for a few moments, then ask her to tell about herself, about who she was, before everything.\n\n");

		output("\"<i>Well, what were you like before you came to this world, huh?</i>\" she responds immediately.  \"<i>If I gotta share something private like that, then the least you can do is reciprocate.</i>\"\n\n");

		output("Her tone is light and playful, you think she may only be teasing, but you decide that it is fair.  And so you talk to her, you tell her about your own family, your own childhood.  She listens intently, laughing with you at the funny things you remember, and nodding with sombre empathy at the sad things.  Finally, when you finish, she gives a soft, sad smile, shakes her head, and then starts to speak.\n\n");

		output("\"<i>Who was I?  Well... I was nobody, really. Just an average little girl, a face in the crowd.  Daddy was an alchemist; he made a lot of his money in those days working to purify items that were tainted in some fashion, but his primary goal was trying to come up with a concoction that could actually help purify someone who had been tainted already.  He thought that there might be something worth investigating in Pure Giant Bee Honey, but he never did succeed.</i>\"\n\n");

		output("You ask if she didn't get on with her father.\n\n");

		output("\"<i>What?</i>\" she asks, clearly surprised.  \"<i>No, he loved me, and I loved him, but he didn't have a lot of free time.  I tried to take an interest in learning alchemy, it was a way to get closer to him, but it never really interested me that much.</i>\"  She smiles, amused.  \"<i>I was really more of a mommy's girl than a daddy's girl, I guess.</i>\"\n\n");

		output("You ask her to tell you about her mother.\n\n");

		output("\"<i>She was a hunter - one of the best in the village.  Quick enough to run a deer to ground, quiet enough that it wouldn't know she was there until her knife was at its throat, skilled enough with a blowpipe to pin a fly to a tree from fifty paces without killing it,</i>\" Amily boasts.  \"<i>I admired her - I adored her, I wanted to be just like her.  I was always bugging her to teach me, and she worked hard to help me get good.  Everyone always said I was going to be just like her.</i>\"  She smiles... and then she looks sad.  \"<i>If it wasn't for those skills, I mightn't have survived when the demons came.</i>\"\n\n");

		output("Gently, you reach out and take her hand, trying to offer her some comfort, and then ask what happened to her parents.\n\n");

		output("\"<i>I... I don't know.</i>\" She sniffs.  \"<i>The last I saw of them, daddy was throwing some exploding potions at a tentacle beast, and mom was yelling at me to run, to run as fast as I could and hide myself in the wilderness while she took on a pack of imps.  I haven't seen them since.</i>\"  Her voice cracks, and she buries her head in her hands.\n\n");

		output("\"<i>I'll be alright,</i>\" she sobs.  \"<i>But... please... leave me alone now? Please?</i>\"\n\n");

		output("Wanting to respect her privacy, you place a hand on her shoulder and give her a squeeze, attempting to convey that you will always be ready to talk if she needs it.");
		if (!sexAfter) output("  Then you leave her, giving her the chance to mourn her lost family.\n\n");
	}
	//Conversation: How did it fall?
	else if (convo == 10) {
		output("You think for a moment, wondering what to ask her.  Then you shrug your shoulders and tell her that you'd like to know a little more about her, that you want to get to know her better.\n\n");

		output("Amily looks surprised... but pleased.  \"<i>I... You're really interested in hearing about me?  Well... okay.  What do you want to know?</i>\"\n\n");

		output("Hesitantly, you ask her what happened to cause her village to fall.  Why is she the only survivor?\n\n");

		output("Amily looks shocked, and then sad.  \"<i>I knew you would ask this, eventually,</i>\" she murmurs.  Her gaze unfocuses itself, memories she evidently would rather not recall coming flooding back.  \"<i>It was the evening of the annual autumn festival.  We were all in the town square, celebrating the end of another year and our success in stockpiling food to see us through the winter.  That was when they came... a horde of them, spilling over the walls, smashing through the gates. We had no sentries up... we had no forewarning.  We didn't know they were there until the screaming started.</i>\"\n\n");

		output("You realize she's starting to shiver.\n\n");

		output("\"<i>There were so many of them... so horrible.  Imps by the dozens, the hundreds, succubi, incubi, creatures I can't even name.  Twisted forms, all blurring into each other...</i>\"\n\n");

		output("You place a hand on her shoulder, trying to draw her back into the real world.  She stops shaking and continues, calmer.\n\n");

		output("\"<i>We had no weapons - we hadn't been well armed even before, and who took spears and daggers to a festival?  It was pandemonium - we scattered in all directions like brainless animals.  The demons just had to pick us off. Some tried to fight, but they were quickly overwhelmed - beaten down by superior force.  Some of us must have gone mad from the corruption boiling off of them, because they just gave up and let the demons have them.  I... I saw this one boy, he couldn't have been more then a year or two older than me.  I could only watch as he just opened his arms and looked up blissfully at this monster with a human woman's face, cat ears, six pairs of big, milk-seeping breasts and a horse's cock as long as she was tall.  She grabbed him, and forcefed him that huge dick - rammed down his throat and he just swallowed it and swallowed it, looking delighted as she pushed him to the limit.</i>\"\n\n");

		output("\"<i>You can't imagine what it was like.  Things flapping through the darkness, twisted shapes springing out of the gloom, the stink of blood, urine, milk and cum, screaming, laughing, roaring, howling... I don't know how the fire started, it could have been any of a dozen reasons.  All I knew, when it was over, and I dared creep back into the ruins of what had been my home...  I was the only one left.</i>\"\n\n");

		output("Tears are pouring down her face.  Unable to think of anything else to do, you wrap your arms around her, holding her as she leans against you and weeps silently.  Finally, you feel her tears stop, and she gently pushes you away.\n\n");

		output("\"<i>Thank you.  It's been so long... but it still hurts, remembering.</i>\"\n\n");

		output("You tell her that you're sorry for bringing up such painful memories");
		if (sexAfter) output(".");
		else output(", then excuse yourself once you are certain she is okay.\n\n");
	}
	//Conversation: How did she survive?
	else if (convo == 11) {
		output("You think for a moment, wondering what to ask her.  Then you shrug your shoulders and tell her that you'd like to know a little more about her, that you want to get to know her better.\n\n");

		output("Amily looks surprised... but pleased.  \"<i>I... You're really interested in hearing about me?  Well... okay.  What do you want to know?</i>\"\n\n");

		output("You ask her, hesitantly, how she managed to survive the destruction of her village, and how she's stayed alive ever since.\n\n");

		output("She looks not upset, like you feared, but confused.  \"<i>I haven't explained that already?</i>\" She asks.  \"<i>I ran.  I ran as fast as I could for my house - I ran for my hunting knife and my blowpipes.  And then, my parents ordered me to run into the wilderness and hide.  I didn't want to go, but I obeyed.  I just ran and ran all through the night, stopping only when I was exhausted - and even then, I crawled into a hollow at the roots of a tree to hide.  I slept until hunger woke me, foraged for something to eat, and then I crept back to my village.  I found it ruined, and I've lived here ever since.</i>\"\n\n");

		output("\"<i>As for day to day survival...</i>\"  She shrugs.  \"<i>I do what my mother taught me.  I hunt.  I forage.  I managed to find and store a lot of left-behind food after I was sure the village was no longer being occupied, but that was eaten or went off years ago. I managed to scavenge a few bits of alchemical equipment from my parents' home, and from the other village alchemists - not enough to do anything complicated, but enough to build a water purifier in a hidden cove, so I could distill the lake water and make it drinkable.  I also have water traps set up to catch rainwater and morning condensation. I may not be a real alchemist, but I do know what plants, animals and fungi are poisonous and I can whittle new darts for my blowpipe to use them with.  I have snares set up and I check them regularly.</i>\"\n\n");

		output("She grins at you, mischievously.  \"<i>Any more questions?</i>\"\n\n");

		output("You shake your head \"<i>no</i>");
		if (!sexAfter) {
			if (flags["COC.AMILY_FOLLOWER"] == undefined) output("\", politely excuse yourself, and head back to your own camp. It sounds like she's doing better at keeping a steady supply of food and water going than you are.  But if that's the case... why does she look so thin?\n\n");
			else output("\", politely excuse yourself, and sit back down in camp.  It sounds like she's doing better at keeping a steady supply of food and water going than you are.  But if that's the case... why does she look so thin?\n\n");
		}
		else output(".\"");
	}
	//Conversation: What does she plan to do when she gives birth?
	else if (convo == 12) {
		output("You think for a moment, wondering what to ask her. Then you shrug your shoulders and tell her that you'd like to know a little more about her, that you want to get to know her better.\n\n");

		output("Amily looks surprised... but pleased. \"<i>I... You're really interested in hearing about me? Well... okay. What do you want to know?</i>\"\n\n");

		output("You point out that she's told you why she wants you to father children with her, but she hasn't told you what she will do once she gives birth.\n\n");

		output("\"<i>You actually care what happens to them afterwards?</i>\" She asks, seemingly having a hard time believing that.\n\n");

		output("You insist that, yes, you do want to know.\n\n");

		output("\"<i>Alright... Many of the races that are corrupt are able to breed very quickly; their pregnancies don't take too long, and their offspring grow to full size in a span that can take from minutes to hours,</i>\" she begins explaining, \"<i>My own race is quite fertile; if we don't take a certain herbal medicine, we can have up to two dozen children in a single pregnancy.  My plan is to take advantage of both those facts... Now that I have a pure human like you to father them for me.</i>\"\n\n");

		output("You ask how that is supposed to work, given that she is very obviously not corrupt.\n\n");

		output("\"<i>You may have seen Goblins while you were exploring?  Well, they're corrupted creatures, but their corruption stems from chemicals in their blood.  I managed to... persuade... a Goblin to get me some samples of a distillation of that specific chemical.  Once I am certain I am pregnant, I can take a vial to cause my pregnancy to advance really quickly, and for the children to grow to full maturity in one or two weeks, like a Goblin does.</i>\"\n\n");

		output("Feeling a little enlightened, you then ask her just why she needs to have so many children, and so fast.  You remember that she wants her race to be reborn outside of demonic slavery, but what will she do when she judges she has enough.\n\n");

		output("\"<i>Well, I don't exactly have a specific number of kids I want to deliver,</i>\" she explains.  \"<i>The Goblin only gave me five vials of that chemical; five pregnancies are all I'll get.  Once I use them, and they're all grown big and strong, we can leave this area and find ourselves somewhere else to found a new village.  In a place where the demons can't get us, we can work on expanding our numbers, bringing my people back to life as something other than just fucktoys.</i>\"\n\n");

		output("You thank her for the explanation.\n\n");
	}
	else if (convo == 13) {
		//[Amily Talks About Kitsune]
		output( "The two of you swap tales about your respective adventures, and from there the topic drifts to the odd many-tailed fox women you've seen deep in the woods.\n\n");
		output("\"<i>Kitsune,</i>\" she says matter-of-factly, nodding gently.  \"<i>There's a race that's hard to categorize, if there ever was one.</i>\"\n\n");

		output("You ask her what she means by this.\n\n");

		output("\"<i>Well, they don't seem to be demons, exactly, but they do share a few things in common with them.  In spite of that, they somehow seem to have an amazing resistance to corruption.  From the tales I've heard, they existed in their current form already for a long time before the demons arrived,</i>\" she explains. Seeing your perplexed expression, she continues.  \"<i>They have extremely potent magic, and they draw their power from living things to sustain it.  They can get it in lots of ways, but it seems like their favorite way is through sexual contact.  They form a sort of...  link, with their partner, I suppose, and absorb small amounts of their life energy.</i>\"\n\n");

		output("You nod, noting that you can see how that is similar to some of the demons you've come across.\n\n");
		output("\"<i>Physically, they're not the strongest, but they don't have to be – once they've got you caught in one of their illusions, you're pretty much under their power. Despite that, they don't seem to be particularly evil... at least, for the most part.</i>\"\n\n");

		output("You give her a slightly quizzical look and then press her on the details.\n\n");

		output("\"<i>Well... I've never seen one face-to-face, but I've heard some other travelers tell stories about meeting corrupted kitsune.  Nasty pieces of work, if any of it's true.  Most kitsune are fairly innocuous, if a little irritating.  Sometimes they can actually be pretty friendly, if you play along right.  They seem to get off on making mischief, but it's more or less harmless – the worst that ever happens is you wind up getting lost in the woods or find some kind of treasure that turns out to be a box of rocks when you bring it home.  The corrupted ones though... they cross a line.  Their tricks are downright vindictive... and once they finish tormenting you, they'll suck the life right out of you without a moment's hesitation.</i>\"\n\n");

		output("You ask how anyone knows this much about them, if even meeting one is so dangerous.  Amily scratches her head a bit and blushes, clearly a little embarrassed to not have a definitive answer for this one.  \"<i>W-well... it's mostly just conjecture.  Like I said, I'm only repeating what I've heard.</i>\"\n\n");

		output("She pauses for a moment, and then speaks up with another interesting fact in an attempt to save face.  \"<i>They do seem to have a strange fascination with tentacle beasts, for some reason.</i>\"\n\n");

		output("From the blush on her face, you get the feeling that she may be speaking from experience.  You don't press her on the matter though, ");

		output("just nodding politely as you process the information.");
	}
	//Conversation: How will she care for her children?
	else {
		output("You think for a moment, wondering what to ask her.  Then you shrug your shoulders and tell her that you'd like to know a little more about her, that you want to get to know her better.\n\n");

		output("Amily looks surprised... but pleased.  \"<i>I...  You're really interested in hearing about me?  Well... okay.  What do you want to know?</i>\"\n\n");

		if (flags["COC.AMILY_FOLLOWER"] == undefined)
		{
			output("You pause for a few moments, trying to think of a way to phrase this delicately, then ask her how she plans on caring for her children.\n\n");

			output("She looks puzzled and not quite sure if she wants to be amused or offended.  \"<i>I do have lots of food stockpiled - that's why I'm looking thinner than usual, in fact; I've been carefully saving up and preserving as much food as I can.  Or did you think I was that bad a hunter and forager?  I wouldn't have lasted all these years if I was,</i>\" she states.  \"<i>Besides, I have a special potion I bartered from some goblins... within a week or two, any children I have will be grown enough to hunt and forage for themselves.  Don't worry, I can handle looking after them.</i>\"\n\n");
		}
		else
		{
			output("You pause for a few moments, trying to think of a way to phrase this delicately, then ask her how she thinks your children are doing.\n\n");

			output("A hint of worry creeps into her expression, matching your own; but she remains resolute. “<i>The first of our kids grew up so fast, and they seem to be doing OK out there without their parents to dote on them. The eldest are doing a great job caring for the young ones.</i>” she answers.\n\n");
		}
		
		output("Feeling somewhat more reassured, but not entirely so, you get ready to leave.\n\n");

		output("\"<i>Hey, hold on a second,</i>\" Amily tells you.  \"<i>You were worried, weren't you? Worried about me...? About the children?</i>\"\n\n");

		output("You nod and admit you were worried, yes.\n\n");

		output("\"<i>That's... that's sweet of you,</i>\" Amily says, clearly shocked.  \"<i>I didn't think you would actually care...</i>\" she trails off, looking thoughtful.");
		if (!sexAfter) {
			if (flags["COC.AMILY_FOLLOWER"] == undefined) output("  Then, as if realising you are still here, she waves at you to go, getting up and leaving herself.  Wondering what that was about, you return to camp.\n\n");
			else output("  Then, as if realising you are still here, she waves at you to go, getting up and leaving herself.  Wondering what that was about, you sit down in camp.\n\n");
		}
	}
	processTime(flags["COC.AMILY_FOLLOWER"] != undefined || sexAfter ? 8 : 15);
	clearMenu();
	if (sexAfter) {
		addButton(0, "Next", determineAmilySexEvent(true));
	}
	else {
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

//First Time Sekksin:
private function stickItInMouseTwatForTheFirstTimeNOTWORTHALLBULLSHIT():void {
	clearOutput();
	amilySprite();
	output("Amily leads you on a convulated route through the ruins of the village. Up streets, down streets, around corners, even straight through some ruins.  ");
	//(If player is five feet or less in height:
	if (pc.tallness < 60) output("Fortunately, being smaller than average means you have less difficulty following her than you might.");
	else if (pc.tallness >= 84) output("Your considerable size makes it surprisingly tricky to get around, but you manage to stay with her.");
	output("  Finally, you are led into one particular ruined house, and from there, to a bedroom. It's not exactly an impressive sight; a few bits of smashed furniture, and a large mound of vaguely clean rags and tattered cushions is the closest thing to a bed. The floor is covered in a thick layer of dirt - more than just dust, it's like dirt was deliberately brought in from outside.\n\n");

	output("Amily sees you examining the room and looks sheepish. \"<i>I have to stay hidden, I can't afford to make it too obvious that anyone lives here. That dirt actually helps warn me if anyone else has found this bolthole.</i>\" She idly takes her tail in one hand and starts stroking the tip. \"<i>So... here we are?</i>\" She says, hesitantly. It's clear that for all her insistence on this being what she needed to do, she's evidently a virgin, and has no real idea of how to proceed from here. What do you do?\n\n");

	//[Take Charge]
	//[Wait for Her]
	//[Kiss Her]
	processTime(7);
	clearMenu();
	addButton(0, "Take Charge", FirstTimeAmilyTakeCharge);
	addButton(1, "Wait 4 Her", beSomeKindofNervousDoucheAndWaitForAmily);
	addButton(2, "Kiss Her", kissAmilyInDaMoufFirstTimeIsSomehowBetterThatWay);
}

//[=Take Charge=]
private function FirstTimeAmilyTakeCharge():void {
	clearOutput();
	//output(images.showImage("amily-forest-takecharge"), false);
	amilySprite();
	output("You decide that the scenery doesn't matter; Amily promised you sex, and you want that sex. Without a word you step forward and give her a mighty push, sending her falling onto her butt with a squeak as you thrust her towards the \"<i>bed</i>\" - that she lands in it is more coincidence than anything. You drop down on top of her, pinning her arms and legs with your own.\n\n");

	output("\"<i>Hey, what's the big idea?</i>\" She protests indignantly.\n\n");

	output("\"<i>You wanted sex with me, so just shut up, lie back and take it.</i>\" You snap back at her.\n\n");

	output("Amily goes quiet, her eyes hardening into gimlets. It's pretty obvious she's not happy about this in the slightest, but she doesn't protest as you roughly pull off her shirt and her pants, exposing her pink sex, and then begin to tear off your own clothes.\n\n");

	//(If player has penis 14 inches or more long)
	var x:int = pc.cockThatFits(amily.vaginalCapacity());
	if (x == -1) x = pc.smallestCockIndex();
	
	if (pc.cocks[x].cLength() >= 14) {
		if (pc.cocks[x].cType == GLOBAL.TYPE_DEMONIC) {
			output("Horror and disgust write themselves on her features as your knobbly, diabolic penis is revealed to her. \"<i>What kind of monster are you?! You'll kill me with that unholy thing!</i>\"\n\n");
			output("\"<i>Just shut up and you'll enjoy this.</i>\" You promise her.\n\n");
		}
		//(If player has an equine penis 14 inches or more long)
		else if (pc.cocks[0].cockType == GLOBAL.TYPE_EQUINE) {
			output("Her eyes go wide with shock and fear as she discovers your stallion-like cock. \"<i>Even in this world, being hung like a horse isn't a good thing! I can't take something like that!</i>\"\n\n");
			output("\"<i>How do you know until you've tried?</i>\" You ask.\n\n");
		}
		//(If player has a canine penis 14 inches or more long)
		else if (pc.hasKnot(x)) {
			output("\"<i>You can't be serious!</i>\" She protests when she sees what you have hidden in your pants.\n\n");

			output("You don't bother to answer her, instead licking your lips as you imagine what she'll feel like wrapped around your knot.\n\n");
		}
		else {
			output("Her eyes go wide with shock and fear as you reveal your impressively sized member, already growing erect and hard. \"<i>You can't stick that in me! It'll never fit!</i>\" She squeals.\n\n");
			output("\"<i>I'll make it fit!</i>\" You assure her.\n\n");
		}
	}
	output("Without further ado, you thrust into her, eliciting a shriek of equal parts pain and rage. Ignoring that, you focus on trying to squeeze as much as your cock as you can into her warm, tight, velvety depths.");
	pc.cockChange();
	output(" She sobs and moans as you struggle, ");

	if (pc.cocks[x].cLength() >= 14) output("failing to fit in more than a foot of your cock's length, ");
	output("but she doesn't try very hard to fight you off.\n\n");

	output("Your hips thrust back and forth, harder and faster as you grow more and more aroused. Her cunt grips you like a vice, and you can feel the warm delicious pressure building up inside you. Stronger and stronger it grows, until you cannot hold it back any more and with a roar let your [pc.cum] gush out, flooding her as deeply as you can.\n\n");

	output("Only when you are sure that the last of your climax is over do you pull out, carelessly striding over to retrieve your clothing and start getting dressed. Amily stares at you, her eyes hard and sharp as flints. \"<i>Was it good for you?</i>\" She spits. \"<i>Let's hope we've both gotten what we want out of this.</i>\"\n\n");

	output("\"<i>I'll be happy to come back and do it again if you need.</i>\" You jeer back, finishing dressing yourself and leaving her without so much as a backwards glance.\n\n");
	//Affection downer
	flags["COC.AMILY_AFFECTION"] -= 5;
	amilyPreggoChance();
	processTime(15);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[=Wait for Her=]
private function beSomeKindofNervousDoucheAndWaitForAmily():void {
	clearOutput();
	//output(images.showImage("amily-forest-plainfuck"), false);
	amilySprite();
	output("Amily may be a cute little girl, but you're not sure it's really a good idea to... proceed... So you just wait for her to decide whether she really wants to have sex here and now. After a few moments, when it's clear that you're not going to do anything, she frowns a little and steps up to you. Looking up into your eyes, you suddenly realize she wants a kiss. Bending down your head, you plan to give her a rather chaste kiss, but Amily obviously has other ideas. You feel your tongue entering her mouth, and what was intended as a short, innocent kiss turns into a very hot, rather 'not-so-innocent' one.  Suddenly you feel her little hand (or paw?) grabbing your ass.\n\n");

	output("Despite this passionate display, though, she doesn't seem to really be 'feeling' it, more going through the motions to arouse you. You are too horny to care that much.\n\n");

	//(If player has a penis 14" long or more)
	var x:int = pc.cockThatFits(amily.vaginalCapacity());
	if (x == -1) x = pc.smallestCockIndex();
	
	if (pc.cocks[x].cLength() >= 14) {
		output("She leads you to her 'bed' and makes you sit down before stripping in front of you and kneeling down to help you take off your clothes.  At the sight of your huge penis, she's obviously unsure of how to proceed. After a moment or two thinking about it, she begins to stroke it with her hand. Once she has you hard and almost ready to explode on her, she sits back directly in front of you, guides the tip of your member into her netherlips and resumes stroking. She adds her other hand and her tail and continues to give you a combined hand- and tail-job until you orgasm. While it doesn't feel bad, you get the feeling that it could have been much better - and you also realize that Amily seems to be... disappointed.\n\n");
	}
	else {
		output("At the sight of your member, she grins and begins stroking it. \"<i>You are obviously the right size for me...</i>\" Before long, you're hard and almost desperately waiting for her to start doing 'it' for real. Never losing her grin, she slowly lowers herself onto you and guides your penis into her netherlips.");
		pc.cockChange();
		output(" The feeling is better than you imagined, but still, something doesn't feel quite right... However, as soon as the mouse-girl starts moving up and down, you forget anything but the pleasure you feel. It doesn't take long before you can't hold back anymore. Afterwards, Amily looks into your eyes for a moment before standing up and putting on her clothes again. You get the distinct feeling that she's somehow disappointed.\n\n");
	}

	output("Seeing as how she clearly has no further need for you, you quietly excuse yourself, get dressed and leave.");
	flags["COC.AMILY_AFFECTION"] -= 2;
	amilyPreggoChance();
	processTime(15);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}
//[=Kiss Her=]
private function kissAmilyInDaMoufFirstTimeIsSomehowBetterThatWay():void {
	clearOutput();
	amilySprite();
	//output(images.showImage("amily-forest-kissingfuck"), false);
	output("While the scenery certainly isn't anything you'd call \"<i>romantic</i>\" or \"<i>arousing</i>\", the eager little mouse-girl in front of you is quite appealing, so you step up to her, take her in your arms and lightly kiss her. Seeing her eyes widen in surprise for a moment, she soon closes her eyes and returns the kiss. Continuing the kiss you two begin to explore each other. Along the way, you help each other out of your clothes and slowly, almost reluctantly step back so you can for the first time see each other without anything in the way.\n\n");

	//(If player has a penis 14" long or more)
	var x:int = pc.cockThatFits(amily.vaginalCapacity());
	if (x == -1) x = pc.smallestCockIndex();
	
	if (pc.cocks[x].cLength() >= 14) output("At the size of your [pc.cock " + x + "], Amily's eyes widen, but she still seems to be almost mesmerized. Slowly, blushing furiously and avoiding your gaze, she touches it and begins stroking your member. It soon turns into a veritable hand-job. Not taking her hand away, the mouse-girl guides you to the 'bed' and asks you to lie down. She continues stroking your penis with her hand, but also uses her tail and her tongue to bring you closer and closer to orgasm. Just before you can't hold back anymore, she sits down on your legs and slowly guides the tip of your penis to her netherlips. Soon, this 'almost penetration' overwhelms you and sends you over the edge.\n\n");
	else {
		output("She looks down between your legs and, blushing, smiles. \"<i>It's nice to see a " + pc.mf("man","woman") + " who hasn't gone insane about that part.</i>\" She murmurs to you, holding you as tightly as she can. Despite the fact you can feel her hands pressed against your back, you suddenly become aware of something stroking your penis as well; it takes a bit of wriggling, which presses her small, perky breasts to your chest in the most interesting way, but you can see that she is using her tail. Working in synch as best you can, the two of you crabwalk over to the pile of bedding and topple over; you land on your back, and she lands on you.\n\n");

		output("By this point, your member is rock hard, and Amily pushes, somewhat reluctantly, against your grip, positioning herself so that the two of you are crotch to crotch. Looking up at her, you start to mouth the question \"<i>Are you okay with this?</i>\" to her, but she smiles, nods her head insistently, and then her lips seal themselves against yours again. Her vagina hovers almost teasingly against the tip of your cock as she works up the courage to make the final plunge... and plunge she does, suddenly skewering herself to the hilt upon you, to your shock.");
		pc.cockChange();
		output(" You can feel her pained wince, muscles clenching in pain all up her body, and you hold her tighter, kiss her deeper, in an effort to try and comfort her. You lie there, holding her, until she relaxes and unclenches, slowly beginning to work herself back and forth.\n\n");
	}
	output("Enjoying the sensations, you start caressing her to increase her pleasure, too. It doesn't take long for you both to orgasm, before Amily sinks down on you, looking into your eyes with a smile on her face.\n\n");

	output("\"<i>...That was... wow. Uh, I mean.</i>\" She hastily corrects herself, blushing. \"<i>I guess you weren't so bad... I knew I had a good feeling about you.</i>\" She smiles. \"<i>You do know I'm not neccessarily pregnant, right? We're going to have to do this again.</i>\"\n\n");

	output("You smile, and tell her that you're happy to do it with her as often as it takes. She blushes so red ");
	//([horsecock]
	if (amily.hasFur())
		output("it's almost like the fur on her cheeks has turned red.");
	else
		output("she nearly resembles an imp!");
	output("  Excusing yourself, you get dressed, receiving a lazy wave goodbye and a happy smile as you head out of the door and head for the main street, from there finding the way back to your camp.\n\n");
	//Affection boost?
	flags["COC.AMILY_AFFECTION"] += 3;
	amilyPreggoChance();
	processTime(15);
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function amilySexHappens():void {
	clearOutput();
	amilySprite();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	//If too big
	if (x == -1 && pc.hasCock()) {
		output("Amily looks between your legs and doubles over laughing, \"<i>There is no way that thing is fitting inside of me!  You need to find a way to shrink that thing down before we get in bed!</i>\"");
		flags["COC.AMILY_AFFECTION"]--;
		processTime(2);
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	if (flags["COC.AMILY_FUCK_COUNTER"] == undefined) {
		stickItInMouseTwatForTheFirstTimeNOTWORTHALLBULLSHIT();
		IncrementFlag("COC.AMILY_FUCK_COUNTER");
		return;
	}
	//Low Affection Sex:
	if (flags["COC.AMILY_AFFECTION"] < 15) {
		output("Amily's efforts at leading you through the ruined village are brisk and efficient. You don't really think she's looking forward to doing this all that much. No, that might be overstating things. It's more like she's under the impression that, details aside, this encounter between the two of you will be pure business.\n\n");

		output("It's hard for you to say if you were led by a different route this time, but soon you are in what Amily has to offer for a private bedchamber, and she begins to reach for her clothes, obviously expecting you to do the same thing.\n\n");
		clearMenu();
		addButton(0, "Business", amilySexBusiness);
		addButton(1, "Playtime 1st", amilySexPlaytimeFirst);
	}
	//Moderate Affection Sex:
	else if (flags["COC.AMILY_AFFECTION"] < 40) {
		output("Amily leads you to her nest as quickly as ever, but things are a little different this time. You can tell Amily has what can only be described as a 'spring in her step'. She moves just a little bit quicker, she seems more enthusiastic about the prospect - her tail even waves slowly from side to side, a bit of body language you haven't seen from her before. And you're certain there's a bit of a seductive wiggle to her hips - which you definitely haven't seen from her before.");
		//(If Amily is Slightly Pregnant:
		if (flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) output("  However, she does sometimes touch the swell signifying the litter growing inside her, and when she does her attitude becomes uncertain and nervous.");
		output("\n\n");

		output("Once you are inside, Amily gently tries to push you onto the bedding where you will be mating. Once you are seated, she smiles at you with a teasing expression and begins to slowly strip herself off, clearly trying to make the act seem as erotic as possible.");
		if (flags["COC.AMILY_INCUBATION"] <= 7 * 168 / 2) output("  However, her confidence visibly slips when she has to fully bare the bulging belly that marks her pregnant state, but she musters the confidence and starts to show it off for you as well.");
		clearMenu();
		addButton(0, "Step In", amilyStepTheFuckIn);
		addButton(1, "Watch Show", amilyEnjoyShow);
	}
	else {
		if (flags["COC.AMILY_INCUBATION"] <= 7 * 168 / 2) fuckAmilyPreg();
		else amilyHighAffectionSecks();
	}
}

//[Straight To Business]
private function amilySexBusiness():void {
	clearOutput();
	amilySprite();
	output("Allowing Amily to take care of her clothes, you hastily remove your own [pc.gear]. Once the two of you are naked in front of each other, Amily looks you up and down, and then sniffs - not in disdain, but honestly trying to get a good scent of you. You speculate that this is some kind of check to see that you haven't somehow managed to become corrupted since last you met.\n\n");
	processTime(1);
	amilySexPtII();
}

//[Playtime First]
private function amilySexPlaytimeFirst():void {
	clearOutput();
	amilySprite();
	output("As Amily begins reaching for her clothes, rather than start stripping off yourself, you close the distance between the two of you and take hold of her hands.\n\n");

	output("\"<i>W-What are you doing?</i>\" She asks, curious and a little wary.\n\n");

	output("You simply smile back at her, and then gently begin to undress her, stopping her from lifting a finger to take off her clothes as you playfully remove them for her. At least, as playfully as you can, given how simple her garb is. The mouse-girl is confused, and she blushes a bit, but you think she's enjoying the attention, and you take this as an opportunity to gently scratch the base of her tail and tickle the rim of her ears with your fingers, the latter of which makes her giggle despite herself. Once she is standing nude before you, you begin to take off your own clothes. However, to your surprise, it is her turn to stop you.\n\n");

	output("\"<i>Fair is fair.</i>\" She growls, but she's blushing faintly. Clumsy with unfamiliarity, she nonetheless does her best to remove your [pc.gear] in as erotic a fashion as she can manage, and you catch her nimble little fingers hesitantly stroking across the more interesting parts of your anatomy more than once. When you stand before her naked, she carefully looks you over and takes several deep breaths through her nose.\n\n");

	output("\"<i>Just making sure that you haven't... you know, picked up something you shouldn't.</i>\" She explains softly.\n\n");
	pc.lust(5);
	flags["COC.AMILY_AFFECTION"]++;
	amilySexPtII();
}

private function amilySexPtII():void {
	amilySprite();

	//worm infested reaction
	if (pc.hasStatusEffect("Infested")) {
		output("\"<i>EWWWW!  You're infested!</i>\" she shrieks, \"<i>Get out!  Don't come back 'til you get rid of the worms!</i>\"\n\nYou high tail it out of there.  It looks like Amily doesn't want much to do with you until you're cured.");
		flags["COC.AMILY_AFFECTION"] -= 3;
		flags["COC.AMILY_GROSSED_OUT_BY_WORMS"] = 1;
		processTime(4);
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	output("Now that both of you are naked, Amily takes a step back from you and begins to stroke herself - though her gestures are a little hesitant, and she clearly has never done this before, she is sincerely trying to be arousing. A finger strokes each dainty little nipple, circling around in opposite directions in order to make them perk as hard as they can. Her right hand slips away, leaving her left hand to alternate between each nipple as her nimble fingers begin to tease her most private of places. She may not be extraordinarily skilled at it, but she's definitely doing a good job of turning you on - particularly with the cute little gasp she makes when she pinches her clitoris a bit too hard.\n\n");
	
	processTime(4);
	clearMenu();
	addButton(0, "Sit & Watch", sitAndWatchAmilySex);
	addButton(1, "Caress Her", caressAmilyHaveSex);
}

//[Sit & Watch]
private function sitAndWatchAmilySex():void {
	clearOutput();
	amilySprite();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	output("You stay right where you are, not wanting to spoil the show. By the time that she is visibly starting to drip girlcum and approaches you, clearly ready to move on to the main event, your " + pc.cockDescript(x) + " is iron-hard.\n\n");
	pc.lust(50);
	continueAmilySmex();
}

//[Caress Her]
private function caressAmilyHaveSex():void {
	clearOutput();
	amilySprite();
	output("Watching Amily masturbate and tease herself in front of you is definitely erotic... but you want something more to this session than that. Licking your lips with a combination of arousal and nervousness, you tentatively reach out one hand and brush a feather-light touch against her fingers.  Her eyes, which she had previously been keeping closed, suddenly spring open, and you ready yourself to withdraw and apologize if she protests. But, for whatever reason, she does not protest and, emboldened, you continue to touch and caress her. You keep your touches gentle, light and restricted to non-intimate regions, but she seems to be enjoying this; she draws a little closer, and reaches out to brush your cheek, absentmindedly using the very hand she had been stroking her netherlips with before, and so the scent of her intimate regions drifts to your nostrils from where her fingers lay. Her eyes have rolled almost completely shut, the gaze she is giving you is a very languid one, but something about the set of her lips, only just starting to open, entices you to kiss them.\n\n");
	processTime(3);
	clearMenu();
	addButton(0, "Refuse Kiss", AmilyGetKissed);
	addButton(1, "Kiss Her", AmilyTakeTheKiss);
}
//[Refuse the Kiss]
private function AmilyGetKissed():void {
	clearOutput();
	amilySprite();
	output("You pull your mind back from that thought. That's taking things in directions you're not sure that either you or Amily are actually comfortable with.\n\n");
	//Affection hit!
	flags["COC.AMILY_AFFECTION"] -= 3;
	continueAmilySmex();
}

//[Take the Kiss]
private function AmilyTakeTheKiss():void {
	clearOutput();
	amilySprite();
	output("Slowly, doing your best to convey that you will stop or back away if Amily is uncomfortable with this, you press your lips tenderly to Amily's.");
	if (amily.hasMuzzle())
		output("  It's quite an unusual experience; though her lips proper are as naked as your own, there is fur around them, soft and fine and just close enough to tickle the edges of your own lips, to say nothing of the unusual sensation of kissing someone with a muzzle.  Amily doesn't seem bothered at all. In fact, she kisses you back, and quite eagerly so, too.");
	output("\n\n");
	//AffectionGAIN!
	flags["COC.AMILY_AFFECTION"] += 1 + rand(3);
	processTime(1);
	pc.lust(5);
	continueAmilySmex();
}

private function continueAmilySmex():void {
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	amilySprite();
	//output(images.showImage("amily-forest-plainfuck"), false);
	output("The time couldn't be any more right for either of you, and you both sink onto the bedding that Amily has prepared. Lying side by side, Amily guides you with surprising efficiency into her entry, and then, once you are comfortably inside, she begins to thrust, her cunt gripping your " + pc.cockDescript(x) + " like a vice.\n\n");

	/*(If player chooses "Share The Pleasure":)
	{
		output("Determined to make this good for Amily too, you resume stroking and caressing her, doing your best to meet her thrusts with your own, and planting the odd kiss on the nape of her neck", false);
		//([horsecock]
		if (flags["COC.AMILY_NOT_FURRY"] == undefined)
			output(" - not actually an unpleasant experience, despite the fur", false);
		output(". She is surprised, and tenses warily at first, but then melts under your ministrations, squeaking softly in her appreciation of your efforts.", false);
	}
	*/
	output("But all good things must come to an end, and soon you both build to a mutual climax. Once you have regained your strength, you stop holding each other and begin to dress, ready to go your separate ways once more. At the door, though, Amily stops you.\n\n");

	output("\"<i>Thank you, that was... nice...,</i>\" the little mousegirl says with a blush. \"<i>Maybe... we can... do it again?</i>\"\n\n");

	output("She seems surprised that she actually enjoyed it (at least a little), but she's definitely willing to repeat the experience. You assure her that you'll come back, and then resume your travels.");
	//Knock up, PC stats, etc.
	IncrementFlag("COC.AMILY_FUCK_COUNTER");
	amilyPreggoChance();
	//Slight affection gain?
	flags["COC.AMILY_AFFECTION"] += 1 + rand(2);
	processTime(10);
	pc.orgasm();
	//dynStats("sen", -1);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}


//[Enjoy The Show]
private function amilyEnjoyShow():void {
	clearOutput();
	amilySprite();
	output("Surprised, curious and aroused in equal measures, you decide to sit back and watch the show. Amily seems very happy to perform for you, and does her best to make it as intriguing as possible.");
	if (flags["COC.AMILY_INCUBATION"] <= 7 * 168 / 2) output("  Even though she was clearly a little nervous about her gravid state in the beginning, as she continues, she grows in confidence to the point it seems she has almost forgotten about it.");
	output("\n\n");
	processTime(2);
	AmilyMidSexLevel2();
}

//[Step In]
private function amilyStepTheFuckIn():void {
	clearOutput();
	amilySprite();
	output("Eager, confused and feeling impatient, you rise from your seat to help Amily undress. She accepts your help, and does seem to enjoy your touches and help, but at the same time she seems disappointed... maybe even a little hurt? Almost as if she had been wanting you to watch her efforts?\n\n");
	AmilyMidSexLevel2();
}

private function AmilyMidSexLevel2():void {
	pc.lust(5);
	amilySprite();
	output("By the time Amily is completely naked, she is clearly excited about what is coming up; you even think she's wet already. She stares at you with a mischievous, turned-on smile, waiting to see what you will do now that it is your turn to strip.\n\n");

	output("Do you do a striptease of your own or just strip naked and get to business?");
	processTime(2);
	clearMenu();
	addButton(0, "Striptease", StripForAmilyYouSlut);
	addButton(1, "Business", getDownWithSexTiem);
}

//[Fair Is Fair]
private function StripForAmilyYouSlut():void {
	clearOutput();
	amilySprite();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	output("It is your turn to give her a mischievous smile back. Feeling turned on and excited, and remembering the elders in the village telling you that fair is only fair, you decide to give her a little show of her own. Standing up, you tilt your head back and thrust out your chest, trying to look enticing. As Amily watches, at first bemused and then pleased, you slowly strip off your [pc.gear], working hard to make it as sensual and suggestive as possible. You show off your body for her, leisurely stroking your own limbs and down your midriff to finally reveal that which lies inside your pants; your " + pc.cockDescript(x) + ". Amily is definitely appreciative of the show.\n\n");
	processTime(3);
	continueWithMoreMidLevelAmilySex();
}

//[Straight To Business]
private function getDownWithSexTiem():void {
	clearOutput();
	amilySprite();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	output("Too horny to think of anything else than what lies ahead, you hastily remove your [pc.gear].  Amily smiles at what she can see, enjoying the sight of your body and your " + pc.cockDescript(x) + ".\n\n");
	processTime(1);
	continueWithMoreMidLevelAmilySex();
}

private function continueWithMoreMidLevelAmilySex():void {
	pc.lust(5);
	amilySprite();
	output("Once you are both naked, you embrace and begin with a deep kiss. Slowly you both sink down and start exploring each other's bodies. You feel Amily's hands caressing you while you lightly kiss her breasts, one of your hands slowly drifting down to her cute ass and lightly squeezing it. Looking into her eyes, you see a sparkle in them before she surprises you and somehow manages to turn you onto your back. Now she's sitting on your belly, with your already hard cock being fondled by her rather flexible tail. Grinning at you, she seems to plan on teasing you as long as possible before allowing you to enter her.\n\n");
	processTime(3);
	clearMenu();
	addButton(0, "Play Along", playAlongWithAmilyWhataDumbBitch);
	addButton(1, "Please Her", workToPleaseTheCunt);
}

//[Play Along]
private function playAlongWithAmilyWhataDumbBitch():void {
	clearOutput();
	amilySprite();
	//output(images.showImage("amily-forest-reverse-cowgirl"), false);
	output("You decide to let her take the dominant position, relax (as much as you can with a beautiful, hot and very wet little mouse-girl sitting on you and fondling you) and simply enjoy her attentions. Amily obviously knows what she is doing - though you have no idea HOW she knows - and manages to bring you nearly to the climax before drawing back a little and letting you calm down.  She repeats this several times until you're nearly going crazy.  Just when you think you can't stand it anymore, she removes her tail from your cock and instead uses it to lightly bind your hands. You could easily move your hands, but decide not to. Grinning at you, she hovers a moment over your cock before slowly sinking down. You somehow manage to avoid cumming as soon as you enter her, but it's really, really hard. Amily's tail draws your 'bound' hands onto her breasts, while hers start caressing yours as she begins slowly riding you. Soon, the speed increases, and it isn't long before you both orgasm.\n\n");
	pc.orgasm();
	//dynStats("sen", -1);
	AmilyMiddleGradeSexOver();
}

//[Work To Please Her]
private function workToPleaseTheCunt():void {
	clearOutput();
	amilySprite();
	output("You decide to take a more active role and start caressing her, kneading her breasts and making sure she enjoys it just as much as you do. Soon, Amily can't hold herself back and sinks down on you, beginning to ride you for all she's worth. It doesn't take you two long to reach the climax.\n\n");
	processTime(6);
	pc.orgasm();
	//dynStats("sen", -1);
	AmilyMiddleGradeSexOver();
}
private function AmilyMiddleGradeSexOver():void {
	amilySprite();
	output("Quite spent from your lovemaking, Amily sinks down on your breast, smiles at you and slowly dozes off. You also drift off to sleep soon after. Some time later, you wake up to find her already putting on her clothes again.\n\n");
	//Affection gain here?
	amilyPreggoChance();
	flags["COC.AMILY_AFFECTION"] += 3 + rand(4);
	IncrementFlag("COC.AMILY_FUCK_COUNTER");
	processTime(15);
	clearMenu();
	addButton(0, "Say Goodbye", sayGoodByeToAmilyPostSecks);
	addButton(1, "Stay A While", stayAfterAmilyMiddleGradeSecks);
}

//[Say Goodbye]
private function sayGoodByeToAmilyPostSecks():void {
	amilySprite();
	clearOutput();
	output("You smile at her and give her a kiss before saying goodbye and returning to your camp.");
	processTime(1);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Stay A While]
private function stayAfterAmilyMiddleGradeSecks():void {
	amilySprite();
	clearOutput();
	output("You decide you'd rather stay with her a little longer, so you get up, go to her and with a kiss and some caresses draw her down again. She doesn't really put up any resistance, so you both lie there kissing and caressing each other for some time before you finally say goodbye and return to your camp.");
	//Bonus affection mayhapz?
	flags["COC.AMILY_AFFECTION"] += 3;
	processTime(15);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}


//[High Affection - Non-Pregnant/Slightly Pregnant]
private function amilyHighAffectionSecks():void {
	amilySprite();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	output("Amily really didn't waste any time getting to her hidden bedroom, sprinting as fast as she could with you in tow.");
	if (flags["COC.AMILY_INCUBATION"] != undefined) output("  Even in a slightly pregnant state, she goes surprisingly fast, though she's also rather cautious of her small bump.");
	output("\n\n");

	output("Once inside, the two of you get to work undoing each others clothes, tossing the garments across the room with little care for them. Amily bites her lower lip as she examines your naked form again, before practically jumping you. She wraps her small hands around your stiff [pc.cockNoun " + x + "] in an almost painful fashion, rubbing and teasing it, and presses her mouth against yours, her tongue exploring every inch of your mouth that it can reach, and you quickly respond by doing the same favor for Amily.");
	if (flags["COC.AMILY_INCUBATION"] != undefined) output("  Really it seems the only thing between you two now is Amily's small stomach bulge.");
	//(If Amily is herm:
	if (amily.hasCock()) output("  You can feel her erection, hot and solid, pressed between your two bodies.");
	output("\n\n");

	output("Not releasing her grip on your raging erection, or breaking the passionate kiss for even a single second, she moves back toward the bed and takes you with her. You're quite surprised that the quiet mousegirl has come out of her shell and is being so forward. Is this the effect you have on her?\n\n");

	output("Finally putting some distance between the two of you, Amily flops back onto the bed and places her hands behind her head, presenting her beautiful body to you. Finding the sight irresistible, you move your head between her legs and start licking at her moist vag, pushing your tongue or your fingers in every once in a while, and ");
	if (!(amily.hasCock())) output("sucking on her sensitive clit");
	else output("licking and kissing her human-like cock");
	output(" to stimulate her further. In response, Amily moans loudly and spreads her legs further apart, an invitation to continue. You happily oblige your lover, burying two fingers into her wet cunt while you move to other parts of her body.");
	if (flags["COC.AMILY_INCUBATION"] != undefined) output("  As you move your head across her beautiful form, you stop at her growing baby bump and give it a small kiss.");
	output("  Your head hovers at her breasts");
	if (flags["COC.AMILY_INCUBATION"] != undefined) output(", which seem to have grown from the pregnancy,");
	output(" and get to work licking and suckling her nipples, rubbing the sensitive mounds.");
	if (flags["COC.AMILY_INCUBATION"] != undefined) output("  When you get a dribble of milk in your mouth it surprises you, but you certainly don't stop.  \"<i>Hah...You're going to have to teach the children how that's done,</i>\" Amily says, in between fevered breaths.");
	output("\n\n");

	output("By the time you start teasing her neck and collarbone, Amily's hands are clinging onto your back and she's impatiently grinding against your raging erection.  \"<i>Please don't tease me anymore,</i>\" Amily whispers into your ear, making you almost feel a little bad for teasing your love in such a way.\n\n");

	output("As an apology you quickly push your " + pc.cockDescript(x) + " past her dampened nether-lips, and set to work thrusting in and out of your mousegirl lover.");
	if (flags["COC.AMILY_INCUBATION"] != undefined) output("  You are of course mindful of her baby bump, not going too fast and making sure you're in a position that's comfortable for the two of you, not wanting to harm your future offspring with the lovely mouse maiden.");
	output("  It's not too long before you're going at a regular pace, stuffing Amily's fuckhole with your familiar manhood.\n\n");

	output("Amily moans from the pleasure and raises her hips up to meet your thrusts, desperate for more of your loving.  She whispers a few dirty things to you between shallow breaths, \"<i>");
	if (flags["COC.AMILY_INCUBATION"] == undefined) output("Fill me up with everything you have... I want to be a mother for your children, just as much as I want to be a mother of my own people,");
	else output("No need to hold back, pump as much cum into me as you can,");
	output("</i>\" she whispers in a sultry tone, and her words are enough to send you over the edge. You grunt loudly, feeling as if your cock is about to explode from the exertion, blasting Amily so full of your cum that it starts to ooze out. Amily gives a cute little cry, and her vaginal walls clamp down on your sensitive member with enough force to make you wince as girlcum sprays out onto your thighs");
	//(if Amily is herm:
	if (amily.hasCock()) output(" and cum spurts into the air between you, splattering on you both");
	output(".\n\n");

	if (flags["COC.AMILY_INCUBATION"] == undefined) output("\"<i>If that didn't knock me up... I don't care as much as you'd think. It was magnificent either way,");
	else output("\"<i>Hmm...My kids are pretty lucky that their father is such a virile specimen,");
	output("</i>\" Amily says as she catches her breath, reaching up to ruffle your hair. You give her a bashful smile, glad to see you've made her so happy.\n\n");

	output("The two of you lie together for some time, and it's with great regret that you tell her that you need to check in on your own camp. Amily seems disappointed, not wanting you to leave, but understands why you need to go. \"<i>");
	if (flags["COC.AMILY_INCUBATION"] == undefined) output("Okay... Well, I'm sure you'll be back. I will need your help again if this doesn't set,");
	else output("Okay dear...But you better come back some time. You don't want your children to have abandonment issues, do you?");
	output("</i>\" Amily says while rubbing her stomach. You smile at her and nod, promising you'll come back, before setting off for your own camp.");
	//boost affection
	flags["COC.AMILY_AFFECTION"] += 2 + rand(4);
	IncrementFlag("COC.AMILY_FUCK_COUNTER");
	processTime(25);
	pc.orgasm();
	//dynStats("sen", -1);
	//preggo chance
	amilyPreggoChance();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[High Affection- Heavily Pregnant]
private function fuckAmilyPreg():void {
	amilySprite();
	clearOutput();
	//output(images.showImage("amily-forest-fuckpreg"), false);
	output("Amily leads you by the hand to her hiding place as quickly as possible... which is a relatively brisk walking speed. You don't rush her or anything, understanding how the heavy bump on her belly is slowing her down, moving side-by-side at the same pace.  You try to help Amily over the difficult terrain facing her.");
	if (amily.hasCock()) output("  The erection tenting her pants isn't helping.");
	output("\n\n");

	output("Once inside the little safe spot you help Amily undress from her restrictive garments, getting a good grope at every sensual curve your hands roam over. It's only when Amily herself is fully undressed that you remove your own gear.\n\n");

	output("Amily, as per usual, is quite pleased by your naked form but she herself is casting her gaze to the ground and blushing furiously. \"<i>Do you still think I'm pretty?</i>\" she asks you, and you waste no time telling her that she's more beautiful than ever now, her new curves are far more emphasised and certainly arousing to look at. Amily's expression brightens at that, and she hugs onto you as tightly as she can, declaring just how much she loves you. Your own feelings for her seem to be mutual.\n\n");

	output("She pulls your head in, your lips locking in a passionate display, her hands tracing a line down to your chest until she's gently fondling your cock.  ");
	//(If player has a tail)
	if (pc.hasTail()) output("You even feel Amily wrap her mousy tail around your own, making you chuckle softly into your lovers mouth.  ");
	else output("A tickling sensation hits your body, making you snort and giggle, realising that Amily's tail is fondling your thigh.  ");
	output("Your eyes catch sight of Amily's swollen breasts, seeing a few drops of milk on her stiff nipples. You smirk and fondle her breasts, breaking the kiss every few moments to get a taste of her milk. Amily moans in response, tightening her grip on you every time your lips return to her own.\n\n");

	output("Once she pulls her head back, a few strands of saliva still link the two of you.  She looks at you expectantly, wanting you to make the first move. You scratch the back of your head and look at her somewhat embarrassed, saying you don't really know what kind of position to use on a heavily pregnant woman. Amily giggles, squeaking a few times, her hands coming to rest on your shoulders \"<i>Alright, let me show you...</i>\" she says, positioning you on the bed, on your back.\n\n");

	output("\"<i>I did some research on the matter, just in case you still wanted to make love while I'm like this... I'm pretty glad you do - you have no idea how horny I've been from this.</i>\" Amily says as she straddles your hips, feeling the extra weight that the cute little mouse-girl has put on. Nothing you can't handle, and certainly something you're not going to call attention to.\n\n");

	output("Amily teases you for a little while, running her pussy-lips and tail along the tip of your erection a few times, earning a few moans and groans from you. Amily smirks slightly before sliding herself down your fully erect [pc.cockNoun], taking as much as she can. You're a little worried that this might be harmful for your offspring, or worse - that they'll know what's going on... but Amily really seems to know more about this than you do, so you're just going to go along with her suggestions on the matter.\n\n");

	output("Amily manages to keep a rather impressive rhythm and pace as she rides your cock like a mechanical bull. In time you manage to return her motions, thrusting your hips up to meet her and twisting yourself around counter-clockwise. The way Amily shrieks, or squeeks, in pleasure is a good sign, and as a result, you pick up speed with your gyrations. The intense pleasure makes you wish this session didn't have to end, but as you feel your orgasm rapidly approach, you sigh in defeat and resolve to make it a memorable one. You quickly clasp your hands around Amily's hips and pick up speed, making Amily gasp in surprise. You keep your motions up for another few minutes, before the two of you bring each other to a powerful simultaneous orgasm, mixed fluids drooling from Amily's thoroughly stretched cunt");
	if (amily.hasCock()) output(", her own mouse-cock spewing futa-cum all over her belly");
	output(".\n\n");

	if (amily.hasCock()) output("\"<i>Remember when you said this cock was a bad thing?</i>\" you tease, causing Amily to blush and playfully punch you in the shoulder.  \"<i>Sh-shut up!  It's... it's pretty incredible, there, I said it.</i>\"\n\n");
	
	output("With the two of you having finished your bout of lovemaking, you sit up and let Amily recline against your chest, letting your hands run along her beautiful bump. Amily smiles happily, her hands moving over your own and guiding them over her bulge. You smile happily as you feel your children kicking, which causes Amily to giggle slightly. The two of you sit together in silence for the remainder of your time together, feeling nothing but love for each other and the offspring you've managed to create. You see Amily smile warmly at you, with a hint of sadness on her face, with a question forming on her lips. She doesn't really say anything though, deciding not to ruin the quiet moment between the two of you.\n\n");

	output("Eventually, with great sadness and regret, you leave your lover's side and head off back to camp, vowing to return.");
	//boost affection
	flags["COC.AMILY_AFFECTION"] += 2 + rand(4);
	IncrementFlag("COC.AMILY_FUCK_COUNTER");
	processTime(25);
	pc.orgasm();
	//dynStats("sen", -1);
	//preggo chance
	amilyPreggoChance();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function amilyPreggoChance(force:Boolean = false):void {
	if (pc.virility() <= 0) return; // blanks!
	
	//Is amily a chaste follower?
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//If pregnancy not enabled, GTFO
		if (flags["COC.AMILY_ALLOWS_FERTILITY"] == undefined) return;
	}
	
	//Cant repreg if already preg!
	if (flags["COC.AMILY_INCUBATION"] != undefined) return;
	
	// Cant preg if at the farm
	if (flags["COC.FOLLOWER_AT_FARM_AMILY"] != undefined) return;
	
	//25% + gradually increasing cumQ bonus
	if (rand(4) == 0 || pc.cumQ() > rand(1000) || force) {
		flags["COC.AMILY_INCUBATION"] = 182 * 60; //Amily completes her pregnancies much faster than a regular player
	}
}


//----------=============================------------
//  tion camp   AMILY COMPANION BULLSHIT
//----------=============================------------
//Approach Amily:
// EVENT 2427
public function amilyFollowerEncounter():void {
	if (!amilyCorrupt() && pc.canOviposit() && flags["COC.AMILY_OVIPOSITION_UNLOCKED"] == undefined) {
		amilyEggStuff();
		return;
	}
	if (flags["COC.AMILY_INCEST_COUNTDOWN_TIMER"] < timeAsStamp && flags["COC.AMILY_FOLLOWER"] == 2 && (hours >= 11 && hours <= 13)) {
		amilyIncest();
		return;
	}
	amilySprite();
	//Amily freakout
	if (pc.cor() >= 50 && flags["COC.AMILY_CORRUPTION_WARNING"] == undefined && flags["COC.AMILY_FOLLOWER"] == 1) {
		amilyTaintWarning();
		return;
	}
	//Clear warning if PC is good!
	if (pc.cor() < 50 && flags["COC.AMILY_CORRUPTION_WARNING"] > 0) flags["COC.AMILY_CORRUPTION_WARNING"] = undefined;
	//Preggo birthing!
	if (flags["COC.AMILY_INCUBATION"] != undefined && flags["COC.AMILY_INCUBATION"] <= 0 && flags["COC.AMILY_FOLLOWER"] == 2) {
		clearOutput();
		amilyPopsOutKidsInCamp();
		flags["COC.AMILY_INCUBATION"] = undefined; //Clear Pregnancy
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//Jojo + Amily Spar
	if (flags["COC.AMILY_FOLLOWER"] == 1 && flags["COC.AMILY_MET_PURE_JOJO"] == 1 && flags["COC.AMILY_SPAR_WITH_PURE_JOJO"] == undefined && flags["COC.JOJO_IN_CAMP"] == 1) {
		pureJojoAndAmilySpar();
		return;
	}
	//Amily
	if (flags["COC.AMILY_FOLLOWER"] == 1 && flags["COC.AMILY_WAIT_FOR_PC_FIX_JOJO"] == 1 && pc.hasItem(new CoCBeeHoneyPure()) && !(flags["COC.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO"] > timeAsStamp) && flags["COC.JOJO_FIXED_STATUS"] == undefined)
	{
		fixJojoOOOOHYEEEEAHSNAPINTOASLIMJIM();
		return;
	}
	clearOutput();
	//Non corrupt!
	if (flags["COC.AMILY_FOLLOWER"] == 1) output("As you approach the mouse-woman, her big, hairless ears twitch and she turns to face you with a smile. \"<i>Hi, [pc.name]! What's up?</i>\" She grins at you.\n\n");
	//Corrupt!
	else
	{
		if (flags["COC.FOLLOWER_AT_FARM_AMILY"] == undefined)
		{
			output("\"<i>Amily!</i>\" you yell. In no time a purplish blur rushes towards you; skidding to a halt, she kneels before you, hands behind her back, fully exposed. \"<i>Yes my " + pc.mf("master", "mistress") + "?</i>\" Amily says seductively, licking her lips.\n\n");
		}
		else
		{
			output("Amily is kneeling before you before you’ve even finished calling her name. She looks a bit dusty but her pussy gleams cleanly and invitingly.");
			
			if (flags["COC.FOLLOWER_AT_FARM_AMILY_GIBS_MILK"] == 1)
			{
				flags["COC.FOLLOWER_AT_FARM_AMILY_GIBS_MILK"] = 2;
				output("\n\nYou wordlessly hold out your hand. Grinning, Amily produces a bottle of succubus milk and places it in your palm.");
				
				output("\n\n“<i>I'll leave my regular production with the rest of the payment Whitney owes you [pc.master].</i>”\n\n");
				
				itemScreen = amilyFollowerEncounter;
				lootScreen = amilyFollowerEncounter;
				useItemFunction = amilyFollowerEncounter;
				itemCollect([new CoCSucMilk()]);
				return;
			}
			else
			{
				amilyMenu(false);
				return;
			}
		}
	}
	
	if(flags["COC.AMILY_INCUBATION"] != undefined)
		switch (8 - int(flags["COC.AMILY_INCUBATION"] / 24)) {
			case 2: if (flags["COC.AMILY_FOLLOWER"] == 1) { //Pure
						output("You notice that Amily seems to be ill. Of course, you at once go to her and ask her what's wrong, but she only smiles at you and says that it's all right. Your incomprehension must show on your face, since Amily giggles, puts her arms around you and kisses you. \"<i>Silly " + pc.mf("boy", "girl") + "... You're going to be a father... again...</i>\"\n\n");
					}
					else { //Corrupt
						output("You notice that Amily seems to be ill. Despite that, she seems to be happy about something. You wonder what could be going on, and decide to ask; Amily grins at you. \"<i>Oh, " + pc.mf("master", "mistress") + "! You did it! You're going to be a father... I can't wait to birth many more mouse-sluts for you, " + pc.mf("master", "mistress") + ".</i>\"\n\n");
					}
					break;
			case 3:
			case 4: output("Amily's belly is starting to protrude a little. She's unquestionably pregnant.\n\n");
					break;
			case 5:
			case 6: output("Amily's belly has gotten very big. She must be carrying more than one child.\n\n");
					break;
			case 7: if (flags["COC.AMILY_FOLLOWER"] == 1) { //Pure
						output("Amily's swollen stomach moves on occasion, warranting an unthinking pat from her to calm the restless children within.\n\n");
					}
					else { //Corrupt
						output("Amily's swollen stomach moves on occasion, warranting a stroke from her to urge the restless children within to come out soon.\n\n");
					}
					break;
			case 8: output("Amily's bulge frequently wriggles and squirms, though this doesn't seem to bother her. " + (flags["COC.AMILY_FOLLOWER"] == 1 ? "T" : "She smiles with glee, t") + "he children mustn't have too much longer until they are born.\n\n");
	}
	amilyMenu(true);
}

private function amilyMenu(displayOutput:Boolean = true):void {
	clearMenu();
	//Innocent
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//output("Options:\nAppearance\nTalk\nMake Love\n", false);
		//MOAR OPTIONS: Give Present\nAlchemy\nTeach Blowpipe
		addButton(0, "Appearance", amilyAppearance, undefined, "Appearance", "Examine Amily's appearance.");
		addButton(1, "Talk", talkToAmilyCamp, undefined, "Talk", "Discuss with Amily about something");
		addButton(2, "Make Love", fuckTheMouseBitch, undefined, "Sex", "Proposition Amily for some sexy-times.");
		addButton(3, "Give Present", giveAmilyAPresent, undefined, "Give Item", "Give Amily something to give her clothes or possibly alter how she looks.");
		addButton(4, (amily.hasFur() ? "Defur" : "Refuzz"), (amily.hasFur() ? amilyDefurryOfferAtCamp: refuzzAmily), undefined, (amily.hasFur() ? "Defur" : "Refuzz"), (amily.hasFur() ? "Give Amily something to remove her fur." : "Give Amily something to re-grow her fur."));
		//If no fight yet, have option to introduce Urta and Amily
		if (gender(pc) > 0 && flags["COC.AMILY_FOLLOWER"] == 1 && flags["COC.AMILY_VISITING_URTA"] == undefined && (flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 5 || urtaLove()) && !urtaBusy())
		{
			if (displayOutput) output("<b>You could take Amily on a date to Tel'Adre, and perhaps even introduce her to Urta!</b>\n\n");
			addButton(5, "Date", dateNightFirstTime, undefined, "Date", "Take Amily on a date to Tel'Adre?");
		}
		if (flags["COC.AMILY_OVIPOSITION_UNLOCKED"] > 0 && pc.canOviposit()) addButton(6, "Lay Eggs", layEggsInAmily, null, "Lay Eggs", "Unload your eggs into Amily's ass.");
		//if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] > 0 && flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100) {
			//if (flags[kFLAGS.AMILY_DESTROYING_CORRUPTED_GLADES] == 0) addButton(7, "Destroy Glades", amilyDestroyGladesToggle, null, null, null, "Request Amily to destroy any corrupted glades she can find.");
			//else addButton(7, "Stop Destroying", amilyDestroyGladesToggle, null, null, null, "Request Amily to stop destroying the corrupted glades.");
		//}
		addButton(14, "Leave", campLoversMenu);
	}
	//Corrupt
	else {
		//output("Options:\nAppearance\nGive Item\nSex\nTalk\n", false);
		//  [Sex] [Give Item] [Talk] [Call Jojo]
		addButton(0, "Appearance", amilyAppearance, undefined, "Appearance", "Examine Amily's appearance.");
		addButton(1, "Talk", talkWithCORRUPTCUNT, undefined, "Talk", "Discuss with Amily about something");
		addButton(2, "Sex", fuckTheMouseBitch, undefined, "Sex", "Proposition Amily for some sexy-times.");
		addButton(3, "Give Item", giveAmilyAPresent, undefined, "Give Item", "Give Amily something to give her clothes or possibly alter how she looks.");
		addButton(4, (amily.hasFur() ? "Defur" : "Refuzz"), (amily.hasFur() ? amilyDefurryOfferAtCamp: refuzzAmily), undefined, (amily.hasFur() ? "Defur" : "Refuzz"), (amily.hasFur() ? "Give Amily something to remove her fur." : "Give Amily something to re-grow her fur."));
		addButton(14, "Leave", campSlavesMenu);
		if (flags["COC.AMILY_INCUBATION"] == undefined && flags["COC.FOLLOWER_AT_FARM_AMILY"] == undefined && flags["COC.FARM_CORRUPTION_STARTED"] == 1)
		{
			addButton(5, "Farm Work", sendCorruptCuntToFarm, undefined, "Farm Work", "Send Amily to the farm for work.");
		}
		
		if (flags["COC.FOLLOWER_AT_FARM_AMILY"] == 1)
		{
			addButton(5, "Go Camp", backToCamp, null, "Go Camp", "Send Amily back to your camp.");
			if (flags["COC.FOLLOWER_PRODUCTION_AMILY"] == undefined) addButton(6, "Harvest Milk", harvestMilk);
			else addButton(6, "Stop Harvest", stopHarvestingMilk);
			//addButton(14, "Back", kGAMECLASS.farm.farmCorruption.rootScene);
			addButton(0, "Next", mainGameMenu);
		}
	}
}

//Corrupt Amily Sex Options
private function amilyCorruptSexMenu():void {
	amilySprite();
	if (gender(pc) > 0) {
		output("Amily asks, \"<i>How would " + pc.mf("master", "mistress") + " like to use " + pc.mf("his", "her") + " cum-bucket today?");
		clearMenu();
		if (pc.hasCock()) {
			addButton(0, "Anal", corruptAmilyBuckFutter, null, "Anal", "Fuck Amily in the ass!");
			addButton(1, "Get BJ", corruptAmilyOralSuckOff, null, "Get Blowjob", "Have Amily suck you off.");
			addButton(5, "Vagina", corruptAmilysPussyGetsMotherfuckingFucked, null, "Vagina", "Fuck Amily the classic way by penetrating her vaginally.");
		}
		if (pc.hasVagina()) {
			addButton(2, "Get Licked", corruptAmilyLickPussiesLikeAPro, null, "Get Licked", "Have Amily lick your pussy.");
			if (amily.hasCock()) addButton(3, "GetPen'ed", corruptAmilyCampBonesPCWithHerCock, null, "Get Penetrated", "Have Amily put her cock to good use by penetrating you vaginally.");
			addButton(4, "Scissor", corruptAmilyScissorsLikeAPro, null, "Scissor", "Do some girly fun-times with Amily.");
		}
		addButton(14, "Nevermind", amilyFollowerEncounter);
	}
	else {
		//[Genderless PC Tries Sex]
		output("Eagerly, you strip off your [pc.gear] and present yourself to your admiring slut-mouse... but when her eyes fall upon the bare expanse of flesh that is your crotch, she lets out a cry of horror. \"<i>Nothing! There's nothing there! [pc.Master], what's happened to your genitals?</i>\" she squeals in dismay, rushing forward on her hands and knees and slamming her face roughly into your crotch.\n\n");

		output("She desperately gropes and nuzzles you, trying to find some sign - ANY sign - of genitalia, but, of course, she can't. She promptly bursts into big, wet, noisy tears, blubbering like a little baby. \"<i>Why? Why are you punishing me like this, [pc.master]? Haven't I been a good little slut for you? Haven't I done everything I could to please you? I've degraded myself without hesitation for the glories of sex - why have you stolen that from me?!</i>\"\n\n");

		output("As she collapses onto the ground, crying her heart out, you silently redress yourself and slink away. All this blubbering has turned you off, and it's obvious that nothing can be done until you've grown a cock, a pussy, or both.");
		pc.lust( -20);
		if (flags["COC.FOLLOWER_AT_FARM_AMILY"] == undefined) {
			addButton(0, "Next", mainGameMenu);
		}
		else {
			addButton(0, "Next", mainGameMenu);
			//doNext(kGAMECLASS.farm.farmCorruption.rootScene);
		}
	}
}

//Appearance:
private function amilyAppearance():void {
	amilySprite();
	clearOutput();
	// [HORSECOCK]
	var stopSayingNetherlipsFuck:String = "its hairless netherlips seem to shine in between her fur";
	if (!amily.hasFur())
		stopSayingNetherlipsFuck="its netherlips seem to shine in contrast to her thighs";

	var what:String = amily.hasFur() ? "mouse-morph" : "mouse girl";
	var onHerMuzzle:String = amily.hasFur() ? "on her furry little muzzle " : "";
	var furDesc:String = "";
	var feetDesc:String = "";
	//FURRAH
	if (amily.hasFur()) {
		//Corrupt
		if (flags["COC.AMILY_FOLLOWER"] == 2)
		{
			furDesc = "She is covered in fur, except on her hands, feet, ears and tail.";
			feetDesc = "surprisingly hand-like pink paws instead of feet";
		}
		else furDesc = "She is covered in fur, except on her hands, feet, ears and tail.  She has dainty, surprisingly hand-like pink paws instead of feet and";
	}
	//NONFURR
	else {
		if (flags["COC.AMILY_FOLLOWER"] == 2) feetDesc = "a trademark succubus high-heel";
		furDesc = "Her face is framed by a stylish bob of auburn hair, large mouse-ears jutting from her 'do.  She has small, dainty feet and";
	}
	//PUR
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//(Start [horsecock]
		output("Amily is a 5' 2\" tall " + what + ", with a lean and wiry build. Her pink eyes normally twinkle merrily, but they can turn hard and cold if the circumstances warrant, just as the normally friendly grin " + onHerMuzzle+"can turn cruel and harsh when she is angry. " + furDesc + " a long, hairless mouse's tail that sways and twitches constantly from her behind. She is currently wearing " + amily.armor.longName + ". She has " + amilyHips() + " and a " + amilyButt() + ".\n\n");
		//(End [horsecock]
		output("She has a pair of " + amilyTits() + " on her chest. They have " + amily.nippleLengthRatio + "-inch nipples at their tips and must be at least " + amily.breastCup() + "s.\n\n");

		//(If Amily has a penis:
		if (amily.hasCock()) {
			//([horsecock]
			var dickDesc:String = amily.hasFur() ? "naked and hairless and pink and throbbing":"pink and throbbing";
			output("She has a " + amily.longestCockLength() + "-inch penis growing from her crotch, replacing the clitoris that would normally jut from her vulva. It is surprisingly human looking, " + dickDesc + "");
			if (amily.ballSizeRaw == 0) output(" - it even has a foreskin, not a sheath.");
			else output(", though it does have a" + (!amily.hasFur() ? " little sheath.":" fuzzy little sheath.") + "");
			output("\n\n")
		}
		if (amily.ballSizeRaw > 0) {
			output("She has " + amilyBalls() + " dangling ");
			if (amily.hasCock()) output("underneath her shaft");
			else output("from her groin");
			output(".\n\n")
		}
		output("Amily has a little pink pussy in between her legs; " + stopSayingNetherlipsFuck + ".");
	}
	else {
		//Start [horsecock]
		output("Amily, your personal cumslut, is a 5' 2\" tall " + what + ", with quite the voluptuous build.  Her pink eyes normally glow with desire and adoration every time she looks at you, and a lusty smile adorns her face.  " + furDesc + " " + feetDesc + ", and a long, hairless mouse tail with a spaded tip that sways and coils around her legs seductively at every opportunity.  She is currently wearing " + amily.armor.longName + ".  She has " + amilyHips() + " and a " + amilyButt() + ".\n\n");
		// End [horsecock]
		output("She has a pair of " + amilyTits() + " on her chest. They have " + amily.nippleLengthRatio + "-inch nipples at their tips and must be at least DD-cups.\n\n");

		//(If Amily has a penis:
		if (amily.hasCock()) {
			output("She has a half-erect " + amily.longestCockLength() + "-inch penis growing from her crotch. It is surprisingly human looking, " + (amily.hasFur() ? "naked and hairless ":"") +"and pink and throbbing");
			if (amily.ballSizeRaw == 0) output(" - it even has a foreskin, not a sheath.\n\n");
			else output(", though it does have a" + (!amily.hasFur() ? " little sheath.":" fuzzy little sheath.") + "\n\n");
		}
		if (amily.ballSizeRaw > 0) {
			output("She has " + amilyBalls() + " dangling ");
			if (amily.hasCock()) output("underneath her shaft");
			else output("from her groin");
			output(", churning with cum as you gaze at them.\n\n");
		}
		//Need to account for pussy wetness here.
		output("Amily has a ");
		if (amily.vaginas[0].wetnessRaw <= 2) output("moist, ");
		else if (amily.vaginas[0].wetnessRaw <= 3) output("wet, ");
		else if (amily.vaginas[0].wetnessRaw <= 4) output("dripping, ");
		else output("soaked, ");
		// [Horsecock]
		output("pink pussy in between her legs; " + stopSayingNetherlipsFuck + ".\n");

		//if (kGAMECLASS.farm.farmCorruption.hasTattoo("amily"))
		//{
			//output("\n");
			//if (kGAMECLASS.farm.farmCorruption.amilyFullTribalTats())
			//{
				//output("She is covered from head to tail in tribal tattoos, erotic lines snaking all over her naked frame, giving her the look of a barely tamed savage.\n")
			//}
			//else
			//{
				//if (kGAMECLASS.farm.farmCorruption.numTattoos("amily") > 1) output("She has the following tattoos emblazoned across her body:\n");
				//else output("\nShe has ");
//
				//if (flags[kFLAGS.AMILY_TATTOO_COLLARBONE] != 0) output(flags[kFLAGS.AMILY_TATTOO_COLLARBONE] + "\n");
				//if (flags[kFLAGS.AMILY_TATTOO_SHOULDERS] != 0) output(flags[kFLAGS.AMILY_TATTOO_SHOULDERS] + "\n");
				//if (flags[kFLAGS.AMILY_TATTOO_LOWERBACK] != 0) output(flags[kFLAGS.AMILY_TATTOO_LOWERBACK] + "\n");
				//if (flags[kFLAGS.AMILY_TATTOO_BUTT] != 0) output(flags[kFLAGS.AMILY_TATTOO_BUTT] + "\n");
			//}
		//}
	}
	output("\nShe has a tiny pink pucker between her mousey butt-cheeks, where it belongs.");
	//Back to amily menu
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//private function amilyDestroyGladesToggle():void {
	//clearOutput();
	//if (flags[kFLAGS.AMILY_DESTROYING_CORRUPTED_GLADES] == 0) {
		//output("You ask Amily if she's willing to destroy the corrupted glades in the forest on sight. After all, the forest could be cleansed.");
		//output("\n\n\"<i>I'll destroy any corrupted glades I see. I'll make sure they don't live again,</i>\" Amily says. She grins and holds up the knife for emphasis.");
		//flags[kFLAGS.AMILY_DESTROYING_CORRUPTED_GLADES] = 1;
	//}
	//else {
		//output("You tell Amily that she doesn't have to destroy the foul glades in the forest.");
		//output("\n\n\"<i>All right but they might come back if you don't keep them at bay,</i>\" Amily says.");
		//flags[kFLAGS.AMILY_DESTROYING_CORRUPTED_GLADES] = 0;
	//}
	//doNext(amilyFollowerEncounter);
//}

// EVENT 2429: Talk to Amily in camp
public function talkToAmilyCamp():void {
	amilySprite();
	clearOutput();
	output("You tell Amily you'd like to talk about things. She grins, happy at the prospect, and takes a seat, inviting you to sit down as well.\n\n");
	//(Random camp discussion takes place)
	talkWithCuntIMeanAmily();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function talkToAmilyWithSexAfter():void { talkWithCuntIMeanAmily(true); }

//Make Love:
private function fuckTheMouseBitch():void {
	amilySprite();
	clearOutput();
	//Corrupt Amily has her own shit
	if (flags["COC.AMILY_FOLLOWER"] == 2) {
		amilyCorruptSexMenu();
		return;
	}
	//[Amily rejects sex]
	if (flags["COC.AMILY_WAIT_FOR_PC_FIX_JOJO"] > 0) {
		output("Amily pushes you away and says, \"<i>Not until we fix Jojo.</i>\"  You sigh and grumble.  No sex today!");
		clearMenu();
		addButton(0, "Next", amilyFollowerEncounter);
		return;
	}

	output("You give Amily a seductive smile and tell her that you want to make love to her.\n\n");

	if (rand(2) == 0) output("She grins wickedly back, \"<i>Ooh, is that so? Well, I suppose I might be able to squeeze you in...</i>\"\n\n");
	else output("She giggles, \"<i>What kept you so long? I've been waiting way too long.</i>\"\n\n");
	output("At your expression, she laughs, \"<i>We had about seventy kids before I moved in here; I think I'm a bit too experienced to be shy about sex now.</i>\"\n\n");

	output("She strides over to take you in her arms, \"<i>So, what would you like to do, [pc.name]?</i>\"\n\n");
	clearMenu();
	//[Take Charge]
	//[Let Amily Lead]
	//[Make Babies - Requires player has a penis, or Amily has a penis & player has a vagina]
	if (pc.hasCock() || (pc.hasVagina() && amily.hasCock())) {
		//Make babies option
		if (flags["COC.AMILY_ALLOWS_FERTILITY"] == undefined) {
			output("Amily is currently taking herbs that will prevent pregnancy and keep her sterile.\n\n");
			////Send make babies to an appropriate override
			//if (izmaFollower() && flags[kFLAGS.AMILY_X_IZMA_POTION_3SOME] == 0 && pc.hasCock() && !izmaScene.flags["COC.AMILY_INCUBATION"] != undefined && flags["COC.AMILY_INCUBATION"] == undefined) {
				//babies = amilyXIzmaSuperPregOptions;
			//}
			addButton(2, "Make Babies", makeChildren, undefined, "Make Babies", "Request Amily to stop taking her herbs and allow her to get pregnant.");
		}
		//No Babies Option
		else {
			output("Amily is currently off her infertility herbs and may get pregnant.\n\n");
			addButton(2, "No Babies", makeChildren, undefined, "Make Babies", "Request Amily to start taking her herbs and prevent pregnancy.");
		}
	}
	
	addButton(0, "Take Charge", amilyTakesChargeSex, undefined, "Take Charge", "Take charge and decide how you should have your way with Amily.");
	addButton(1, "Amily Leads", letAmilyLead, undefined, "Amily Leads", "Let Amily choose how she's going to have sex with you.");
	
	if (flags["COC.AMILY_VISITING_URTA"] == 4 && flags["COC.URTA_COMFORTABLE_WITH_OWN_BODY"] >= 0/* && !getGame().urtaQuest.urtaBusy()*/)
		//addButton(3, "Urta", amilyUrtaSex, null, "Urta", "Take Amily for a visit to Urta in Tel'Adre for some threesome sexy times.");
	if (flags["COC.AMILY_OWNS_BIKINI"] > 0 && pc.hasCock() && !amilyCorrupt()) addButton(4, "Swim", amilySwimFuckIntro, null, "Swim", "What's a better pleasure than to take Amily for a swim and do some fuck?");
	if (izmaFollower() && flags["COC.AMILY_X_IZMA_POTION_3SOME"] > 0 && pc.hasCock()) {
		output("You could see if Amily and Izma are up for another round of Amily's fertility potion, though contraceptives won't matter at all once she takes that.\n");
		addButton(5, "Izma3Some", drinkThePotion, null, "Izma3Some", "Get into a threesome with Amily and Izma. This will pretty much get them pregnant.");
	}
	if (flags["COC.GIVEN_AMILY_NURSE_OUTFIT"] > 0 && pc.hasCock() && pc.cockThatFits(amily.vaginalCapacity()) >= 0 && pc.lust() >= 33) {
		output("Amily might be up for playing nurse again.\n");
		addButton(6, "Nurse RP", amilyNurseCheckup, null, "Nurse RP", "Have Amily roleplay as a nurse in a naughty way.");
	}
	
	addButton(14, "Back", amilyFollowerEncounter);
}

//[=Take Charge=]
private function amilyTakesChargeSex():void {
	amilySprite();
	clearOutput();
	output("You stride up to her and take her in your arms, kissing her deeply. She melts enthusiastically into your embrace, kissing you back just as hard, her tail winding around your " + pc.leg() + ". You lead her back to the nest she has made for herself and firmly but gently place her on her back there. She smiles up at you. \"<i>Ooh, taking charge, are we?</i>\" She trills with pleasure, tail waving to and fro with sincere excitement.\n\nWhat will you do?");
	clearMenu();
	if (pc.hasCock()) {
		if (pc.cockThatFits(amily.vaginalCapacity()) >= 0) addButton(0, "Fuck", takeChargeAmilyFuck, null, "Fuck", "Penetrate Amily vaginally.");
		if (pc.cockThatFits(amily.analCapacity()) >= 0) addButton(1, "Buttfuck", fuckPureAmilysHeiny, null, "Buttfuck", "Take Amily from behind."); //ButtFuckButtFUCKBUTTFUCK
		addButton(2, "Get Sucked", takeChargeAmilyGetSucked, null, "Get Sucked", "Have Amily suck you off.");
	}
	if (pc.hasVagina()) {
		addButton(3, "Scissor", takeChargeAmilyScissorMeTimbers, null, "Scissor", "Get into some girly fun-times by rubbing your girl-bits against Amily's.");
		if (amily.hasCock()) addButton(4, "Mount Her", takeChargeAmilyMountHer, null, "Mount Her", "Ride Amily's cock until she cums!");
	}
	if (StatTracking.getStat("coc/pregnancy/amily") > 0 || amily.milkMultiplier >= 60) addButton(5, "Drink Milk", takeChargeAmilyMouseMilk, null, "Drink Milk", "Drink some of Amily's yummy mouse-milk.");
	addButton(6, "Eat Out", takeChargeAmilyEatOut, null, "Eat Out", "Get a taste of Amily's pussy.");
	if (amily.hasCock()) addButton(7, "Catch Anal", pureAmilyPutsItInYourRectumDamnNearKilledEm, null, "Catch Anal", "Have Amily put her cock to a good use by taking you from behind.");
	//addButton(14, "Nevermind", fuckTheMouseBitch);
}


//Take Charge 1: Fuck
private function takeChargeAmilyFuck():void{
	amilySprite();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	clearOutput();
	output("With a smile, you gently place the tip of a finger on her nose, then slowly run it down along her body, over her lip, between her breasts, across her stomach, and finally stopping between her legs, where you playfully circle her secret spot with the tip of your finger.");
	//(if Amily is herm:
	if (amily.hasCock()) output("  Her pants begin to tent as her male organ reacts, and you start to idly stroke it as well for emphasis.");
	output("\n\n");

	output("Amily giggles, and then starts to wriggle out of her pants, shaking her " + amilyHips() + " and giving you a chance to grab hold of her " + amilyButt() + " as she does so. Soon, she's naked from the waist down, her little pink netherlips already winking at you");
	//(if Amily is herm:
	if (amily.hasCock()) output(" and her " + amilyCock() + " standing erect");
	output("; she's clearly very excited about this.");
	output("\n\n");

	output("Now it is your turn to strip, and she watches you all the while, eagerly licking her lips when you unveil your " + pc.cockDescript(x) + ". You stretch out over her body to kiss her, and she reaches up to embrace you with all the strength she has, pulling you deeper into the kiss and down onto her " + amilyTits() + ", her " + amilyNipples() + "s hard and firm against your chest. Finally, she breaks the kiss to whisper hoarsely to you, \"<i>Stop teasing me and put it in, already!</i>\" She growls, surprisingly deeply for a mouse-woman.\n\n");

	output("You smirk back at her, but you're hardly inclined to toy with her; your " + pc.cockDescript(x) + " is aching with your need for her hot, tight depths. So you guide your member to her netherlips and lightly brush its tip against her. You may have wanted to begin slowly, but obviously, Amily has other plans, grabbing your " + pc.cockDescript(x) + " and putting it in.  Gasping a bit as she feels you entering her, she grins and whispers: \"<i>Do I have to do everything myself?</i>\"\n\n");

	output("Feeling your cock slide into her moist and hot vagina, you're not really inclined to waste time talking, so you hungrily kiss the mousegirl and begin to move slowly. Amily eagerly returns your kiss and moves with you. Soon, you both pick up speed while letting your hands wander over each other's body. As you break your kiss to gasp for air, a little moan escapes her, before she puts a hand on your head and pulls you down into another hungry and passionate kiss. Not long after, you can feel yourself fast reaching the limits of your ability to hold back. Luckily, Amily seems to also be nearing an orgasm, so you let go and nearly explode inside her. That seems to have pushed her over the edge too, and with a rather loud moan for such a little girl, Amily orgasms");
	if (amily.hasCock()) output(" her " + amilyCock() + " spasming and spraying futa-jism in between your bodies");
	output(".\n\n");

	output("Grinning at each other with obvious satisfaction in your eyes, you slowly relax and cuddle in the afterglow for some time, before you decide that you'll definitely repeat this soon.");
	amilyPreggoChance();
	processTime(15 + rand(10));
	pc.orgasm();
	//dynStats("sen", -1);
	addButton(0, "Next", mainGameMenu);
}
//Take Charge 2: Mousemilk
private function takeChargeAmilyMouseMilk():void {
	amilySprite();
	clearOutput();
	output("You ponder for a second what it is that you want to do, running your hands gently down Amily's body. At one point, you squeeze one of her breasts - a little too hard, because the smell of milk promptly fills the air. Smiling, you sit down on the nest and coax a confused Amily into also being seated. Confusion gives way to understanding when you start to remove her shirt, and she happily helps you, letting her " + amilyTits() + " hang freely. The wind is chilly, but you are sure arousal is also to blame for the perky erectness of her " + amilyNipples() + "s, and you playfully tweak each of them in turn, which prompts a blush and a somewhat indignant squeak from your mousy lover. Her arms gently reach up to snake around your neck and pull you in closer, which you need little encouragement for.\n\n");

	output("Your thirsty mouth reaches for the first mousy breast, closing your lips tantalizingly around its " + amilyNipples() + ". Amily squeaks and coos as you play it with your lips and your tongue, clearly enjoying the attention, and soon rewarding you with the first drops of milk into your mouth.\n\n");

	output("The taste is unique, distinctly unlike anything you have ever drank before, and yet somehow so very much like Amily. It is thick and creamy and piquant, putting you somewhat in mind of well-aged cheddar, warm from her body-heat and very nourishing.\n\n");

	//Low Amily Milk:
	if (amily.milkMultiplier < 70) {
		output("You drink eagerly, suckling and nursing with all the erotic skill you can muster, and soon her breast is empty. Without further ado, you turn to the next one, and repeat the experience there. Amily moans softly, disappointed, when you drink it dry as well, and you give each nipple in turn a teasing last loving lick before withdrawing. Your mousy lover smiles at you. \"<i>I hope you enjoyed your drink.</i>\" You assure her that you did, and then you help her get dressed, having had enough fun for now.\n\n");
	}
	//Moderate Amily Milk:
	else if (amily.milkMultiplier < 90) {
		output("You drink eagerly, suckling and nursing with all the erotic skill you can muster, and the milk flows thick and freely. You drink and drink, and then, when her breast is empty, you feel compelled to empty the other one. By the time you're finished, you're quite relieved; you feel uncomfortably full, and your stomach gurgles softly as it strains to start digesting your liquid meal. \"<i>Well, they do say milk is good for you, but try not to overdo it, okay?</i>\" Amily teases you. You stick your tongue out at her - which prompts her to pull you into a kiss, her tongue wriggling against yours as she does her best to wring the taste of her own milk from your mouth. Eventually, you push her off... not trying too hard... and she gets dressed, walking away with a jaunty wave of her tail.\n\n");
	}
	//High Amily Milk:
	else {
		output("You drink eagerly, suckling and nursing with all the erotic skill you can muster, and are rewarded with all the milk that Amily has to offer, which is almost more than you can keep up with. You gulp, swallow, and suck desperately as cascades of her fluid pour into your mouth and down your throat, droplets of it seeping between your straining lips to run down your chin. Things get blurry, your world receding to just Amily's breasts, the milk they contain, and your need to drink or choke. At some point you become distantly aware of pains from your overfull stomach, but drinking is all you can think of. Finally, you empty both of her breasts and find yourself collapsing bonelessly onto your back, gasping for breath, your chin, lips and chest stained with milk. It takes you several moments to realize Amily is asking about you in concern.\n\n");

		output("You try to answer that you are fine, but all that comes out is a huge, wet belch. Shaking your head, you manage to regain your wits - and you realize that you are having a hard time sitting up. Your stomach is so full of milk that it is bulging out, almost like a pregnant belly, and it's weighing you down. You realize Amily is also staring at your distended midriff, looking a little scared... and maybe also a little proud.\n\n");

		output("\"<i>All that came out of me?</i>\" She asks, curious. She gently rubs your belly, and you moan as the milk sloshes uncomfortably inside your sensitive stomach. Amily sits down, your head in her lap, and lets you rest there until you recover your strength and digest a good portion of the milk. Still feeling uncomfortably full, you get up and go for a walk to help work off your titanic liquid meal.\n\n");
	}
	var refillAmount:int = amily.milkQ() / 10;
	//pc.refillHunger(refillAmount, false);
	pc.energy(refillAmount);
	//dynStats("spe", .3, "lus", 10, "cor", -.5);
	pc.slowStatGain("r", 0.3);
	pc.lust(10);
	pc.cor( -0.5);
	processTime(10 + rand(5));
	pc.milkInMouth(amily);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Take Charge 3: - eat out
private function takeChargeAmilyEatOut():void {
	amilySprite();
	clearOutput();
	output("With a smile, you gently place the tip of a finger on her nose, then slowly run it down along her body, over her lip, between her breasts, across her stomach, and finally stopping between her legs, where you playfully circle her secret spot with the tip of your finger.");
	//(if Amily is herm:
	if (amily.hasCock()) output("  Her pants begin to tent as her male organ reacts, and you start to idly stroke it as well for emphasis.");
	output("\n\n");

	output("Amily giggles, and then starts to wriggle out of her pants, shaking her " + amilyHips() + " and giving you a chance to grab hold of her " + amilyButt() + " as she does so. Soon, she's naked from the waist down, her little pink netherlips already winking at you");
	//(if Amily is herm:
	if (amily.hasCock()) output(" and her " + amilyCock() + " standing erect");
	output(".  She's clearly very excited about this.\n\n");

	output("She's obviously expecting you to strip down, and is surprised when you instead flop down and wriggle backwards, looking a little disconcerted as she realizes just what you have in mind. You are staring at her vagina");
	//(if herm:
	if (amily.hasCock()) output(", and her " + amilyCock() + " is sticking up where her clitoris should be.  Y");
	else output(", and y");
	output("ou reach out with your tongue to give it a probing lick. Amily squeaks loudly at the sensation and, emboldened, you start to lick more enthusiastically, running your tongue around each of her netherlips, reaching up to tickle ");
	if (!(amily.hasCock())) output("her clitoris.");
	else output("the base of her cock.");
	output("\n\n");

	output("You can feel her juices starting to trickle down her inner walls, hot and salty, and you start to probe your tongue deeper inside her vulva, toying with her labia, lovingly licking her interior. Amily squeaks and squeals, bucking and thrashing in her enjoyment as your tongue caresses her most delicate of spots, sliding in as deeply as it can, until finally, with a shuddering squeal, she climaxes.  Her juices flood your tongue and splash onto you face, turning it into a sticky mess");
	//(if herm:
	if (amily.hasCock()) output(" as her penis erupts and sprays its own cum into the air to sprinkle the both of you");
	output(".\n\n");

	output("She lies there, gasping for breath, even as you pick yourself up and start to clean yourself off. \"<i>Not my favorite...</i>\" She squeaks. \"<i>But definitely can't argue with the results.</i>\" You smile, and leave her in her nest to get her strength back.\n\n");
	//dynStats("int", .25, "lus", 10);
	processTime(10 + rand(5));
	pc.girlCumInMouth(amily);
	pc.slowStatGain("i", 0.25);
	pc.lust(10);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Take Charge 4 - amily sucks off
private function takeChargeAmilyGetSucked():void {
	amilySprite();
	var hands:String = amily.hasFur() ? "paws":"hands"; // [Horsecocks]
	clearOutput();
	output("You stand up and undo your clothes, allowing ");
	if (pc.totalCocks() > 1) output("each of ");
	output("your [pc.multiCocks] to expose itself to the outer world. Amily starts reaching for her pants, but you shake your head and she stops, confused. Her confusion quickly evaporates as you straddle her, giving her the chance to sit up, but ensuring that she'll be on a level with your crotch.\n\n");

	output("You can't say that she looks too eager to do so, but she diligently sits up and takes hold of your ");
	if (pc.cockTotal() > 1) output("largest ");
	// [Horsecocks]
	output(pc.cockDescript(0) + ", stroking it with her " + hands + " and starting to lick the tip. You moan encouragingly and she takes it into her mouth, starting to suck on just the head, her tongue continuing to stroke and lick the head and part of the shaft. Seeing that you are clearly enjoying her ministrations, she gets bolder and starts taking more and more of it in" + (amily.hasMuzzle() ? " - the experience is hard to describe, as there's quite a difference between getting a blowjob and getting a blowjob from someone with a muzzle":"") +". Soon, you can feel that your " + pc.cockDescript(0) + " is bumping against her throat, and you try to back away a little to avoid choking her. To your surprise, though, she firmly pulls you back in, and the two of you make something of a game of it, you pulling out, and her pulling you back in.  All the while, she sucks and licks and delicately scrapes your shaft with her teeth - the stimulus is incredible. You groan and moan as the warmth fills you, the churning pleasure growing deep inside your [pc.balls] as you ready yourself for release.\n\n");

	output("You try to gasp a warning to Amily that you are about to cum, but all that emerges from your throat is a hollow groan.  Even as [pc.cumNoun] pours from your cock into her waiting mouth, ");
	if (pc.cumQ() < 50) output("she swallows it all without skipping a beat");
	else if (pc.cumQ() < 500) output("her cheeks bulge but she manages to swallow it all");
	else output("her cheeks bulge hugely and, though she swallows valiantly (her stomach bulges from the amount she takes), a lot of it spurts back from between her lips, drizzling onto your crotch and her " + amilyTits());
	output(".  Finally, you finish, and she releases your " + pc.cockDescript(0) + " with a wet \"pop\" noise.\n\n");

	output("\"<i>Satisfied now?</i>\" she asks. Feeling weak at the knees, you can only nod. \"<i>Good,</i>\" she says, smiling, and then she walks off in the direction of the stream.\n\n");

	//(If Amily is herm:
	if (amily.hasCock()) output("She turns halfway back to you as she goes. \"<i>I hope you'll remember this and return the favor someday,</i>\" she calls out to you. She then resumes walking off.");
	processTime(10 + rand(5));
	pc.orgasm();
	//dynStats("sen", -1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Take charge 5: scissor me timbers!
private function takeChargeAmilyScissorMeTimbers():void {
	amilySprite();
	//Camp Sex Scene: Scissor
	clearOutput();
	output("Grinning at her, you take Amily into your arms and hungrily kiss her. After a moment of surprise, she passionately returns your kiss. You feel her tail creeping up your leg, obviously questing for your netherlips. Letting your hand wander down her back, you suddenly grab her tight butt and pull her against your body, basking in the feeling of her short fur tickling on your skin. Amily's hands begin exploring your body in turn, before she murmurs: \"<i>Let's find a nice, comfortable place, love...</i>\" Not stopping to caress and kiss each other, you find a nice, secluded place, where you sit down with Amily on your lap.\n\n");

	output("You begin lightly kneading her perky little breasts, eliciting a moan from the mousegirl. You kiss her neck, while your hand goes down to Amily's netherlips, touching her already wet vagina. Slowly, teasingly, you slip two fingers into it, making her moan in pleasure and twisting on your lap so that she can kiss you again without interrupting your ministrations. Soon, you can feel her quiver.\n\n");

	output("Grinning at her, you pull out your fingers. Amily pouts a little at you (rather playfully, in fact) for not bringing her to an orgasm, but when you raise an eyebrow, she grins in return. \"<i>Oh? You want me to pay attention to your pussy, too?</i>\" She stands up for a moment and then pushes you back so that you're now lying before her. She kneels between your legs and lowers her face until it is hovering an inch or two above your " + pc.vaginaDescript() + ". Smiling at you, she begins to use her tongue and nose to play with your netherlips. You close your eyes and moan a bit as the mousegirl pleasures you. Suddenly, the feeling of Amily between your legs is missing. Your eyes pop open, only to find her looking into your eyes. \"<i>Fair's fair, wouldn't you say?</i>\" she asks before kissing you. Your surprise is complete when you feel her tail entering your " + pc.vaginaDescript() + ". You feel yourself nearing an orgasm, but Amily seems to want revenge for you not making her climax.\n\n");

	output("Smiling in defeat, you kiss her again and switch your position so that you and the mousegirl are scissoring - or rather, you will be as soon as she realizes what you're up to and you both start moving. Sure enough, Amily soon grins at you again and tentatively pushes her vagina against your " + pc.vaginaDescript() + ". You return the 'favor', and a few moments later, you two are grinding your vaginas against each other. Moans escaping from both your lips, it doesn't take long for the mousegirl and you to orgasm almost at the same time.\n\n");

	output("With a contented sigh and a broad, satisfied smile, Amily murmurs, \"<i>That felt great...</i>\" She switches her position again so that her head is again next to yours, puts her arms around you and nuzzles you a bit. You embrace her too, and enjoy the afterglow with her for some time, before you both go back to work.\n\n");
	processTime(10 + rand(5));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Take Charge: Mount Amily
private function takeChargeAmilyMountHer():void {
	amilySprite();
	clearOutput();
	output("With a smile, you gently place the tip of a finger on her nose, then slowly run it down along her body, over her lip, between her breasts, across her stomach, and finally stopping between her legs, where you begin to teasingly stroke and caress her " + amilyCock() + " through her pants, letting it tent her clothing.\n\n");

	output("\"<i>That? You want that?</i>\" She asks.\n\n");

	output("You smirk, not thinking a verbal answer needed, and begin to strip down, even as she takes the hint and pulls off her own clothing, Straddling her, you give her " + amilyCock() + " some careful strokes and teases, making sure that she is fully erect, before you begin to lower your " + pc.vaginaDescript() + " onto it. You let just the tip penetrate your netherlips, then pull off before lowering yourself down again, just an inch deeper.\n\n");

	output("Amily groans beneath you. \"<i>Please... stop teasing me. Let me put it in!</i>\" She pleads.\n\n");

	output("You reach down and stroke her cheek, a little worried that you may have seriously upset her, but happy to comply and fully impale yourself upon her length. ");
	pc.cuntChange(0, amily.cockVolume(), true, false, true);
	//(If pussy is gaping:
	if (pc.looseness() >= 5) output("You can barely feel it within your stretched out depths, but you determine to do your best, for your sake and for hers.");
	//Otherwise:
	else output("You grin lustfully as you feel it filling you. Hungry for more, you start to rise and fall, letting it pierce you as deeply as possible.");
	output("\n\n");

	output("Amily gasps in delight at the sensation of being surrounded by your " + pc.vaginaDescript() + ". \"<i>Oh, yes, [pc.name], please!</i>\" she cries, clearly happy.\n\n");

	//(If player is herm with "self-titfuck" cock:
	if (pc.longestCockLength() >= 18) {
		output("Amily grabs hold of your " + pc.cockDescript(pc.longestCockIndex()) + ", eagerly cramming it between her " + amilyTits() + ", mashing them together and running them up and down against your " + pc.cockDescript(pc.longestCockIndex()) + ", surrounding it with warm, soft, velvety flesh.");
		//(If player has "autofellatio" cock:
		if (pc.longestCockLength() >= 22) output("  She then starts to lick and kiss the tip, sucking on it, playing with its slit with her tongue, smothering it with oral affection.");
		output("\n\n");
	}
	//(If player is herm:
	else if (pc.hasCock()) output("She reaches out and grabs hold of [pc.oneCock], stroking, tugging, and teasing it to further excite you into increasing the speed and force with which you thrust.... Something that she succeeds admirably in doing.\n\n");

	output("You pound yourself eagerly into Amily, pelvis meeting pelvis in a lustful collision that sends pleasure surging through you. Amily squeaks and whines loudly at your exertions, which only spurs you to greater efforts. However, soon Amily can no longer resist and, with one particularly piercing squeak, she cums, a gout of mousey-cum flooding into your " + pc.vaginaDescript() + "; this is your signal, and soon you too cum");
	//(if herm:
	if (pc.hasCock()) output(", spraying your own [pc.cum] onto Amily's face");
	output(", splattering mixed fluids below your " + pc.legs() + " and Amily's ");
	if (amily.hasFur()) output("furry ");
	output("thighs.\n\n");

	output("You collapse backwards off of Amily, waiting to regain your breath and your strength, then compliment Amily on just how good she is with her extra appendage.\n\n");

	output("\"<i>Flatterer.</i>\" Is all that she says, but she's smiling happily, even as you both clean up and go your seperate ways again.");
	//PREGGO CHECK HERE
	processTime(15 + rand(10));
	pc.loadInCunt(amily);
	pc.orgasm();
	//dynStats("sen", -1);
	addButton(0, "Next", mainGameMenu);
}

//[=Let Amily Lead=]
private function letAmilyLead():void {
	amilySprite();
	clearOutput();
	output("Not saying anything, you simply grin at her. After a moment, Amily realizes what you want her to do (or maybe what you're offering her). She blushes a little, but then answers your grin with one of her own, before grabbing your hand and leading you to her nest. You're not completely sure, but you think you notice a certain spring in her step - and her tail seems to almost have a mind of its own, weaving back and forth and occasionally caressing your " + pc.leg() + ".\n\n");
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	var choices:Array = [];
	//POPULATE ARRAY WITH POSSIBLE SEX OPTIONS
	//========================================
	if (pc.hasCock()) {
		//Too big
		if (x == -1) output("Amily glances down at the beast between your [pc.legs] and says, \"<i>I was going to ride you, but since you're SOOO big I think I'll have to get creative...</i>\"\n\n");
		//Add 'get ridden' if it fits.
		else choices[choices.length] = 3
		//All males get tailjobs
		choices[choices.length] = 0;
		//HJs
		choices[choices.length] = 1;
	}
	//Everyone has a chance of eating mousecunt.
	choices[choices.length] = 2;
	//If Amily is a herm you might suck off...
	if (amily.hasCock()) choices[choices.length] = 4;
	//Get fucked by amily if she's herm and u have cunt
	if (amily.hasCock() && pc.hasVagina()) choices[choices.length] = 5;
	//========================================
	//CHOOSE PROPER SCENE
	var scene:Number = choices[rand(choices.length)];
	//========================================
	//B1: Tailjob
	if (scene == 0) {
		output("At her nest, Amily turns back to you, puts her arms around you and hungrily kisses you. It doesn't seem as if she's planning on stopping the kiss anytime soon, but that's all right by you. Still, it's only a matter of time until you have to breathe again, so you draw back and gasp for air, noticing the gleam in Amily's eyes and the broad (and rather naughty...) smile. Being drawn into another kiss you begin to wonder what exactly the mousegirl is planning.\n\n");

		output("Suddenly, you almost jump as you feel something entering your pants - it feels almost like a snake or something, but then you realize that it's Amily's tail that's now wrapping itself around your " + pc.cockDescript(0) + ". Your eyes widening, you look at her in surprise as she begins to methodically squeeze and relax her tail's grip on your member.\n\n");

		output("You'd never have expected the little mousegirl to do something like this - and you certainly would never have thought it would feel so good. Sure enough, you soon feel yourself reaching the \"<i>point of no return</i>\", but any attempts to tell her that you won't be able to hold back much longer are made futile by her enduring kisses. You're quite sure she's smiling at your predicament - she probably planned for this to happen. Shrugging mentally, you decide to go with the flow and worry about it later. So you try to relax (as much as you can do that while Amily is giving you an incredible tailjob...) and simply enjoy the feeling. Sure enough, it doesn't take her much longer to finally make you cum. Breaking the kiss, she steps back and with a broad grin asks: \"<i>Did you enjoy that, you naughty " + pc.mf("man", "girl") + "?</i>\"\n\n");

		output("Naturally, you tell her that you enjoyed it very much, and with a smile, Amily helps you clean up. \"<i>If you liked it that much...</i>\" she says over her shoulder and winks at you as she goes to take care of something else.\n\n");
		processTime(15 + rand(10));
		pc.orgasm();
		//dynStats("sen", -1);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//B2: Hand/Footjob
	else if (scene == 1) {
		output("Once you are at her nest, Amily makes you sit down and kneels in front of you. She leans over to kiss you passionately, but you can feel her hands being busy on your pants. Drawing back, the mousegirl smiles at you, as her hands pull out your " + pc.cockDescript(0) + " and start stroking it. Shuddering a little, you sit back and enjoy Amily's ministrations. You knew that she's quite dexterous, but you'd never have thought... Shuddering a little at the pleasure you feel, you partly close your eyes.\n\n", false);

		output("Suddenly, your eyes snap open again and you look with something very much like disappointment at Amily as she withdraws her hands. \"<i>What? Did you think I'd only use my hands on you?</i>\" she asks while sitting down. \"<i>Close your eyes again!</i>\" she demands. Not really sure what she has in mind, you still comply. After a moment or two, you feel something else on your " + pc.cockDescript(0) + ". You open one of your eyes a little and realize that Amily's now using her feet. Smiling, you close your eye again and simply enjoy the feeling. The mousegirl continues stroking your cock with her feet for some time before switching back to her hands. Alternating between them (and sometimes using hands and feet at once), Amily soon makes you cum with a pleasured groan. Opening your eyes again, you smile at her in thanks.\n\n");

		output("Looking at her hands and feet covered by your [pc.cum], Amily jokingly accuses you of forcing her to clean herself yet again, just because you have no control. Your eyes widen a bit in surprise when the mousegirl lightly licks one of her hands and comments \"<i>Mmhhmm... not bad, actually...</i>\" With a grin, she cleans up the results of her hand-and-foot-job before pulling you to your feet again. \"<i>Back to work, Champion!</i>\"\n\n");

		output("With a satisfied smile, you turn to other things.");
		processTime(15 + rand(10));
		pc.orgasm();
		//dynStats("sen", -1);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//B3: Eat Out
	else if (scene == 2) {
		output("Once you are at the nest, Amily pushes you down onto your back. You lay there in the soft, sweet-smelling vegetation as she strips off. Then, to your surprise, she pounces onto your chest, straddling your neck and leaving you face to face with her vagina.");
		//(if Amily is herm:
		if (amily.hasCock()) output("  Her cock bobs merrily in your field of vision.");
		output("\n\n");

		output("\"<i>You've got a very sweet tongue, you know that?</i>\" Amily giggles. \"<i>Let's see just how sweet it is...</i>\"\n\n");

		output("You don't need any further nudging; you open your mouth, bend forward and stick out your [pc.tongue] to give her vagina a probing lick. Despite herself, Amily squeaks at the sensation and, emboldened, you start to lick more enthusiastically, running your tongue around each of her netherlips.\n\n");

		//(If Amily is herm:
		if (amily.hasCock()) output("\"<i>Could you... could you give it a lick, please?</i>\" she whispers, pointing at her male addition. Wanting to make her happy, you kiss the tip of her penis, eliciting a squeak of shock, before you start to lick from the base of her " + amilyCock() + " to the tip again. You then return your attention to her vagina itself.\n\n");

		output("\"<i>Yes, yes, yes, that's it! Oooh!</i>\" Amily squeals at your ministrations, wriggling and squirming in her pleasure. You can feel her juices starting to trickle down her inner walls, hot and salty; you start to probe your tongue deeper inside her vulva, caressing her most delicate of spots. With a shudder and a squeal, she climaxes as you slide your tongue in as deeply as it can go and her juices flood your mouth and splash onto your face.");
		//(if Amily is herm:
		if (amily.hasCock()) output("  Her penis erupts and sprays its own cum into the air to sprinkle the both of you.");
		output("\n\n", false);

		output("She flops over onto your belly on her back, gasping for air, leaving her crotch sitting on your neck. Finally, she recovers and sits up, dragging her damp pussy ");
		//(if Amily is herm:
		if (amily.hasCock()) output("and limp cock ");
		output("across your chest as she repositions herself so that she is looking you in the eyes, laying atop you. \"<i>You always know how to make a girl feel special, don't you?</i>\" she says, softly. Then she kisses you, probing her tongue deep into your mouth to get a good taste of her juices, before wriggling off of you, grabbing her pants and running merrily away. You watch her go, then clean yourself off.\n\n");
		processTime(15 + rand(10));
		//dynStats("int", .25, "lus", 10);
		pc.slowStatGain("i", 0.25);
		pc.lust(10);
		pc.girlCumInMouth(amily);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//B4: Get Ridden
	else if (scene == 3) {
		output("Once you are at the nest, Amily pushes you down onto your back. You lay there in the soft, sweet-smelling vegetation as she strips off. Then she starts tugging insistently at your pants, and you wriggle to help her. Soon, [pc.eachCock] is exposed, rapidly growing erect. She strokes it with one hand. \"<i>Oh, you're eager for this, aren't you?</i>\" she teases.\n\n");

		output("You don't deny it, groaning with longing and nodding your head.\n\n");

		output("\"<i>Well, let's see if I can live up to your expectations...</i>\" She purrs (an odd image, given she's a mouse). She strokes your " + pc.cockDescript(0) + " with one hand, then kisses the tip. She starts to lick it, long, teasing, saliva-heavy licks that have you moaning with pleasure and soon has it lubed up well and truly. Then, without further ado, she straddles you, impaling herself upon you in one practiced motion. She squeals loudly at the sensation, but she's evidently far from hurt, given the wide grin on her mousy face.\n\n");

		output("\"<i>Mmm... You feel so good down there, you know?</i>\" She teases you, starting to thrust and grind against you. In turn, you start to buck back against her, only for her to suddenly press you down to the floor. \"<i>No! Bad!</i>\" She snaps, though her smile and mischievous eyes make it clear she's only playing. Whenever you try to participate, she stops to admonish you, and so you are forced to lie on the nest, groaning with temptation and pleasure as Amily tantalizingly grinds, thrusts and bucks against you - but only at the pace she likes, bringing you to the edge of climax, and then stopping, only to start again when you are beginning to fade in your pleasure. She cums, more than once, but keeps you riding the edge until, at last, she takes mercy and lets you cum into her slick, wet pussy.\n\n");

		output("She howls in unison with you at this final climax");
		//(if high cum amount:
		if (pc.cumQ() > 500) output(", your torrents of spooge making her belly distend visibly");
		output(", and then collapses onto your front. You lie there together, arms unthinkingly winding around each other. Amily is the first of you to stir. \"<i>Do you... Are you happy, that I'm here?</i>\" You assure her that you are. \"<i>That's good...</i>\" She yawns. \"<i>Because I'm so happy to be here with you.</i>\"\n\n");

		output("Exhausted, you feel a quick nap is in order yourself. When you wake up, you're alone in the nest but Amily is nearby; she hands you some food and then points you in the direction of the stream to wash up.\n\n");
		amilyPreggoChance();
		processTime(15 + rand(10));
		pc.orgasm();
		//dynStats("sen", -1);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//B5: Suck Off
	else if (scene == 4) {
		output("Once you are at the nest, Amily pushes you down onto your back. You lay there in the soft, sweet-smelling vegetation as she strips off. Then, to your surprise, she pounces onto your chest, straddling your neck and leaving you face to face with her half-erect cock. She twitches her " + amilyHips() +" back and forth, grinning as your eyes follow the tip of her penis. \"<i>Now, as I recall, it's your fault I grew this thing...</i>\" She says, mischievously. \"<i>And now it's starting to feel really in need of some... attention. So, wouldn't it be best if that somebody who made me grow it gave it that attention, hmm?</i>\"\n\n");

		output("You smirk up at her, because she's fooling nobody, then lean forward and engulf the head of the " + amilyCock() + ". Amily's breath explodes out of her in shock as you start to lick and suck upon her futanari member. \"<i>You... you really aren't scared of this?</i>\" She whispers, moaning softly as you grow bolder, starting to lick the shaft, doing your best to swallow all " + amily.longestCockLength() + " inches of it.\n\n");

		output("Slowly, uncertainly, Amily begins to thrust back and forth, pushing her futa-mouse-cock into your mouth and out again, as deeply as you can take it. She squeaks and whimpers softly at the sensations of her alien sexual organ and your hot, wet mouth, beginning to increase her thrusts. The taste of her pre, salty-sweet, starts tickling your tongue and you start sucking and licking harder, doing your best to coax as much pleasure out of her as possible.\n\n");

		output("Perhaps you are better at this than you thought, or maybe Amily just isn't good at controlling the sensations from her secondary sexual organ, because it seems like no time at all before she lets out a high-pitched squeak and a flood of mouse-futa cum fills your mouth. Hot and salty, but with an aftertaste you can't explain, one that puts you in mind of Amily herself. Unthinkingly you swallow it, and it seems to burn a trail down your gullet.\n\n");

		output("Amily's cock pops from your mouth as she flops over onto your chest, " + amilyTits() + " heaving as she gasps for breath. \"<i>Was... Was that...</i>\" She swallows and tries again. \"<i>Is that what it's like? ");
		if (pc.hasCock()) output("When I do that for you?</i>\"\n\n");
		else output("For a guy?</i>\"\n\n");

		output("You shrug, uncertain. Slowly, Amily sits up and gets off of you. \"<i>I... um... thank you.</i>\" She says, then quickly steals a kiss from you before running off. She's in such a hurry that she's clear over on the other side of the camp before you can tell her that she left her pants behind.");
		processTime(15 + rand(10));
		//dynStats("int", .25, "lus", 10);
		pc.slowStatGain("i", 0.25);
		pc.lust(10);
		pc.loadInMouth(amily);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	//Let Amily Lead: Amily Mounts You
	else if (scene == 5) {
		output("Once you're at the nest, Amily pushes you down onto your back. You lay there in the soft, sweet-smelling vegetation as she strips off. Then she starts tugging insistently at your pants, and you wriggle to help her. Soon, you are both naked, and Amily takes a step back, stroking her " + amilyCock() + ".\n\n");

		output("\"<i>I've got this because of you, so you owe me a chance to use it.</i>\" She says.\n\n");

		output("You smile up at her and spread your " + pc.legs() + " to let her have a full look at your " + pc.vaginaDescript() + ", smirking at her as an exhortation to come and get it. From her own smirk, and the fully erect penis she's sporting, you know she's about to get it as much as she can.\n\n");

		output("Amily situates herself between your legs and starts to stroke your " + pc.vaginaDescript() + "; needless to say, her skill and experience from her own efforts to masturbate herself soon have you bucking with pleasure, lubing up your passage with your own feminine fluids.");
		//(if player is herm:
		if (pc.hasCock()) output("  She strokes your " + pc.cockDescript(0) + " a few times, but in a prefunctory manner; it's obvious that she's focusing on her own penis, this time.");
		output("\n\n");

		output("Once you are sufficiently wet for her tastes, Amily plunges her mouse-futa cock into you. ");
		pc.cuntChange(0, amily.cockVolume(), true, false, true);
		//(If player has a gaping pussy:
		if (pc.looseness() >= 5) output("You are so large that you barely feel it, but Amily is determined to take what pleasure she can all the same.");
		//Otherwise:
		else output("You gasp in pleasure and do your best to grip Amily's dick with your netherlips.");
		output("\n\n");

		output("\"<i>I can hardly believe I've got a cock stuck in another woman's pussy... but, I gotta admit, this is actually really good, even if it is really weird too.</i>\" Amily murmurs, but then she starts doing what you consider really important and she begins thrusting into you. You wrap your " + pc.legs() + " around Amily's back and pull her tightly against you, eagerly meeting her every thrust with one of your own. She moans and gasps at your efforts, pounding your pussy with everything she has,");
		//(if player is a squirter:
		if (pc.isSquirter()) output(" audibly squelching and slurpring thanks to the wetness of your pussy,");
		output(" doing her best to make you buck and writhe under her, a job you think she's doing just fine at.\n\n");

		output("Together you thresh and thrust, hips pounding together furiously, until Amily grunts suddenly, loudly and deeply, as her hot futa essence wells up from deep inside of her and begins gushing into you. At that, you lose it yourself, your own fluids pouring forth to mingle with hers and run out of your [pc.vagina]");
		//if herm: your (cockdescript cocknumber)
		if (pc.hasCock()) output(", [pc.eachCock] spraying jism to fall upon you both like sex-scented rain");
		output(". Panting with your mutual release, Amily slides wetly from your sex and falls upon your belly, to rest there for a moment.\n\n");

		output("Slowly, she raises her head and pecks you affectionately on the lips. \"<i>Thank you,</i>\" is all she says, continuing to lay there with you for a while. Then she picks herself up and walks away, and you do the same.");
		//PREGGO CHECK HERE
		processTime(15 + rand(10));
		pc.loadInCunt(amily);
		pc.orgasm();
		//dynStats("sen", -1);
		clearMenu();
		addButton(0, "Next", mainGameMenu);
		return;
	}
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Give Present:
private function giveAmilyAPresent():void {
	amilySprite();
	clearOutput();
	clearMenu();
	var haveGift:Boolean = false;
	var button:int = 0;
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		output("You tell Amily that you have something you want to give her.\n\n");
		
		output("\"<i>Aw, how sweet of you.</i>\" She smiles, delighted and full of love.\n\n");
	}
	else {
		output("You look at the horny cum-bucket and wonder what you should make her take this time.\n\n");
	}
	if (pc.hasItem(new CoCIncubiD()) && flags["COC.AMILY_FOLLOWER"] == 2) {
		addButton(button++, "Incubus D.", giveAmilyPureIncubusDraft);
		haveGift = true;
	}
	else if (pc.hasItem(new CoCIncubiDPure())) {
		addButton(button++, "P. Incubus D.", giveAmilyPureIncubusDraft);
		haveGift = true;
	}
	if (pc.hasItem(new CoCSucMilk()) || (pc.hasItem(new CoCSucMilkPure()) && flags["COC.AMILY_FOLLOWER"] == 2)) {
		addButton(button++, "Succ Milk", giveAmilyPurifiedSuccubusMilk);
		haveGift = true;
	}
	if (amily.hasCock() && (pc.hasItem(new CoCPinkEgg()) || pc.hasItem(new CoCPinkEggLarge()))) {
		addButton(button++, "Pink Egg", giveAmilyAPinkEgg);
		haveGift = true;
	}
	if (pc.hasItem(new CoCWhiteEgg()) || pc.hasItem(new CoCWhiteEggLarge())) {
		addButton(button++, "White Egg", giveAmilyAWhiteEgg);
		haveGift = true;
	}
	if (pc.hasItem(new CoCBrownEgg()) || pc.hasItem(new CoCBrownEggLarge())) {
		addButton(button++, "Brown Egg", giveAmilyABrownEgg);
		haveGift = true;
	}
	if (pc.hasItem(new CoCPurpleEgg()) || pc.hasItem(new CoCPurpleEggLarge())) {
		addButton(button++, "Purple Egg", giveAmilyAPurpleEgg);
		haveGift = true;
	}
	if (pc.hasItem(new CoCReducto())) { //IMPLEMENTED! W00T!
		addButton(button++, "Reducto", giveAmilySomeReducto);
		haveGift = true;
	}
	if (pc.hasItem(new CoCLactaid()) && amily.milkMultiplier < 100) { //IMPLEMENTED! W00T!
		addButton(button++, "Lactaid", makeTheMouseAMilkCowMoo);
		haveGift = true;
	}
	if (pc.hasItem(new CoCSucDelight()) && flags["COC.AMILY_FOLLOWER"] == 2) {
		addButton(button++, "Suc. Delite", giveCorruptAmilySuccubusDelight);
		haveGift = true;
	}
	if (pc.hasItem(new CoCSucDelightPure())) {
		if (flags["COC.AMILY_FOLLOWER"] == 1) addButton(7, "P. Suc. Delite", giveAmilyPureSuccubusDelight);
		else addButton(button++, "P. Suc. Delite", giveCorruptAmilySuccubusDelight);
		haveGift = true;
	}
	if (pc.hasItem(new ComfortableClothes())) {
		addButton(button++, "Clothes", giveAmilySomePants);
		haveGift = true;
	}
	else if (pc.hasItem(new CoCSluttySwimwear()) && flags["COC.AMILY_OWNS_BIKINI"] == undefined && pc.hasCock() && pc.cockThatFits(amily.vaginalCapacity()) >= 0 && !amilyCorrupt()) {
		output("You could give her a bikini, then invite her for a swim in the stream to show it off.\n\n");
		addButton(button++, "Bikini", amilySwimFuckIntro);
		haveGift = true;
	}
	else if (flags["COC.GIVEN_AMILY_NURSE_OUTFIT"] == undefined && !amilyCorrupt()) {
		if (pc.hasItem(new CoCNurseOutfit()) && pc.hasCock() && pc.cockThatFits(amily.vaginalCapacity()) >= 0) {
			output("You could give Amily the nurse's outfit you got, though it barely covers anything at all, and would likely be inviting some roleplay from the kinky mouse-girl.\n\n");
			addButton(button++, "NurseClothes", amilyNurseCheckup);
			haveGift = true;
		}
		else if (pc.hasItem(new CoCNurseOutfit()))
			output("You have a hunch if you had a penis that wasn't too big, giving Amily a nurse's outfit might set off some kinky roleplay.\n\n");
		else {
			output("You have a hunch that if you had a nurse's outfit you could get Amily to give you a rather erotic checkup, provided ");
			if (!pc.hasCock())
				output("you had a dick.");
			else if (pc.cockThatFits(amily.vaginalCapacity()) < 0) output(" your dick could fit.");
		}
	}
	if (haveGift)
		addButton(14, "Back", amilyFollowerEncounter);
	else {
		if (flags["COC.AMILY_FOLLOWER"] == 1)
			output("You realize that you don't have any items she would be interested in, and apologize.");
		else output("You realize you don't have any items worth using on her.");
		addButton(0, "Next", amilyFollowerEncounter);
	}
}

//[Purified Incubus Draft - If Amily is a Female]
public function giveAmilyPureIncubusDraft():void {
	amilySprite();
	clearOutput();

	var maxSizePure:Number = 13;
	var maxSizeCorr:Number = 15;

	//PURE AMILY
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//Herm amily is different
		if (amily.hasCock()) {
			//[Purified Incubus Draft - If Amily is Herm and has a 13" penis]
			if (amily.longestCockLength() >= maxSizePure) {
				output("Amily sees the vial you are holding as you approach and shakes her head.  \"<i>I'm not sure I should take any more of that stuff.</i>\"\n\n");

				output("Seeing your look of disappointment, she explains, \"<i>I'm flattered you want more of me inside you, but this thing's already nearly a fifth of my size.  If it gets any bigger, I'm going to have trouble staying conscious while erect.</i>\"\n\n");

				//[if corruption high (50+?) or high vaginal depth/looseness]
				if (pc.slut() >= 50 || pc.vaginalCapacity() > amily.cockVolume() * 2) {
					output("You struggle to contain your disappointment, having entertained lurid fantasies of being stretched beyond all reason by her ever-growing member, but you can't deny her logic: an unconscious mouse-girl wouldn't be nearly as much fun, even if she was exceptionally well endowed.");
					//if corruption VERY high -75+?]
					if (pc.slut() >= 75) output("  Although the idea of raping yourself with your futa-mouse lover's helpless body is appealing, you realize this is one argument you simply won't win.");
					output("\n\n");
				}
				//otherwise]
				else output("Her logic is undeniable, even though you had looked forward to enjoying even more of her body than before. You nod and explain that you understand perfectly; you want what's best for her above anything else.\n\n");

				output("You put the vial back in its pouch, as Amily excuses herself and walks off.");
				processTime(3);
				clearMenu();
				addButton(0, "Next", mainGameMenu);
				return;
			}
			//[Purified Incubus Draft - If Amily is Hermaphrodite]
			output("She looks disdainfully at the vial in your hand. \"<i>What, am I not big enough for you already? Oh well, I suppose if it makes you happy.</i>\" She snatches it from your hand and gulps it down. She tries her best to look apathetic, but is unable to help either the pleased moan or the dribbles of pre-cum that stain her clothes as her penis grows erect and then longer, at least a full inch so.  Breathing heavily, she pants, \"<i>Why does this have to actually feel good?</i>\"  Then she turns and lurches drunkenly away. You decide against following her and wander off in the other direction.\n\n");
			pc.destroyItem(new CoCIncubiDPure());
			amilyDickGrow();
			processTime(7);
			clearMenu();
			addButton(0, "Next", amilyFollowerEncounter);
		}
		//Normal Amily
		else {
			output("You offer up the vial of purified Incubus Draft - and Amily promptly leaps back with a shrill squeak that borders on a scream in terms of volume.\n\n");

			output("\"<i>That's liquid corruption!</i>\" She protests. \"<i>Have you gone insane? I'm not drinking that, and you shouldn't either!</i>\"\n\n");

			output("You hastily assure her that it is purified and so neither of you have to worry about joining the ranks of the demons. She still looks skeptical, but then nods slowly and approaches you.\n\n");

			output("\"<i>All right... but, are you sure you want to give that to me? You know it will make me grow a penis, right?</i>\"\n\n");
			
			processTime(2);
			clearMenu();
			addButton(0, "Yes", giveAmilyPureIncubusDraft4Realz);
			addButton(1, "No", amilyFollowerEncounter);
		}
	}
	//CORRUPT
	else {
		//No wang yet
		if (!(amily.hasCock())) {
			//Consume dah goodies!
			if (pc.hasItem(new CoCIncubiD())) pc.destroyItem(new CoCIncubiD());
			else pc.destroyItem(new CoCIncubiDPure());
			output("You pick up a vial of incubus draft and show it to Amily. \"<i>Drink this,</i>\" you tell her, passing the bottle to her. \"<i>" + pc.mf("Master", "Mistress") + ", this will make me grow a cock. Are you sure you wish to do that?</i>\"\n\n");

			output("You tell her yes, this is exactly what you want. Amily smiles and replies seductively, \"<i>As you wish " + pc.mf("master", "mistress") + ".</i>\"\n\n");

			output("She downs the bottle in a single go, then begins moaning as heat gathers on her clit. You push her back and tell her to keep her legs open, you want to watch; she silently complies and continues panting and moaning. Her clit begins distending itself, growing and slowly moving up and out of its hiding place in her pussy, reaching upwards from her crotch. Its pinkish-purple and spills cum as it grows, stopping just below her navel, where it spurts a couple more jets.\n\n");

			output("Amily stops her moaning; apparently the transformation is over... But it's such a small dick... Only four inches long and barely one inch thick...\n\n");

			output("Do you make her grow a huge one?");
			
			if (!amily.hasCock()) amily.createCock(4, 1.2);
			
			processTime(5);
			clearMenu();
			addButton(0, "Yes", corruptAmilyGetsDickMaxxedOut);
			addButton(1, "No", corruptAmilyYouDeclineMaxxingHerDick);
		}
		else if (amily.longestCockLength() < maxSizeCorr)
		{
			//Consume dah goodies!
			if (pc.hasItem(new CoCIncubiD())) pc.destroyItem(new CoCIncubiD());
			else pc.destroyItem(new CoCIncubiDPure());

			output("You pick up a vial of incubus draft and show it to Amily. \"<i>I want you to have a bigger cock; drink this.</i>\" You order her, passing the bottle to her. Amily smiles and says, \"<i>As you wish, [pc.master], your orders are my pleasure.</i>\"\n\n");

			output("She opens her legs to give you a good view and downs the whole bottle in one go. She moans as her cock turns purple and grows impossibly hard, her veins bulging along the shaft as she cums. With every throb her cock grows a bit longer and a bit thicker as well, finally stopping when it's a couple inches bigger. She pants with pleasure and says, \"<i>Thank you, [pc.master], for allowing this horny cum-bucket the honor of possessing such a wonderful tool.</i>\"\n\n");

			output("Satisfied, you dismiss her with a wave and go about your business.");
			amilyDickGrow();
			processTime(7);
			clearMenu();
			addButton(0, "Next", amilyFollowerEncounter);
		}
		//Too big!
		else {
			output("You reconsider - her small frame probably couldn't handle anything larger.");
			processTime(1);
			clearMenu();
			addButton(0, "Next", amilyFollowerEncounter);
		}
	}
}

private function corruptAmilyYouDeclineMaxxingHerDick():void {
	clearOutput();
	amilySprite();
	output("You decide to leave her as she is. If you want her to have a bigger dick you can always give her more drafts. \"<i>I want you to practice using your new tool, so you'll be ready whenever I need you,</i>\" you order Amily. \"<i>Yes, " + pc.mf("master", "mistress") + ",</i>\" she answers. You leave her on the floor and go about your business.");
	processTime(1);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

private function corruptAmilyGetsDickMaxxedOut():void {
	clearOutput();
	amilySprite();

	var maxSizeCorr:Number = 15;

	//(If PC has 2 feet that are not hooves)
	if (pc.isBiped() && pc.hasToes()) {
		output("You're not satisfied; it needs to be bigger. You put your " + pc.foot() + " on her cock and begin stroking it, drawing more pleasured moans from the slutty corrupt futa-mouse. You stroke her into an orgasm, milky white fluid flows out of her dick to hit her in the chest and in the face, but you don't stop. Her cock throbs and spills pre-cum, making your movements easier. You keep stroking her cock with your " + pc.foot() + " vigorously, willing it to grow more and more; each time her cock throbs and orgasms it grows a bit more.\n\n");

		output("Amily is already covered in her own cum, her juices pooling under her, but you never stop. You keep stroking until she comes again, her cock growing more and more. Finally, when one last orgasm brings it to just about 15 inches long and three thick, you press on her cockhead with your " + pc.foot() + " and she comes one last time, coating your " + pc.foot() + " with spooge. \"<i>Clean this up,</i>\" you order her, presenting her with your messy " + pc.foot() + ". She obediently begins licking at the mess, tasting herself in the process. After it's clean you tell her you will call her when she you need her services again, and that she is to practice with her new tool until you do so. \"<i>Yes... [pc.Master],</i>\" she answers tiredly, panting.\n\n");
	}
	//(else)
	else {
		output("You're not satisfied, it needs to be bigger. You take hold of her cock and begin stroking it, drawing more pleasured moans from the slutty corrupt futa-mouse. You stroke her into an orgasm; milky white fluid flows out of her dick to hit her in the chest and in the face, but you don't stop. Her cock throbs and spills pre-cum, making your movements easier. You keep stroking her cock vigorously, willing it to grow more and more; each time her cock throbs and orgasms it grows a bit more.\n\n");

		output("Amily is already covered in her own cum, her juices pooling under her, but you never stop. You keep stroking until she comes again, her cock growing more and more. Finally, when one last orgasm brings it to just about 15 inches long and three thick, you grasp roughly on her cockhead with your hands and she comes one last time, coating your hands with spooge. \"<i>Clean this up,</i>\" you order her, presenting her with your messy hands. She obediently begins licking at the mess, tasting herself in the process. After you're clean you tell her you will call her when she you need her services again, and that she is to practice with her new tool until you do so. \"<i>Yes... " + pc.mf("Master", "Mistress") + ",</i>\" she answers tiredly, panting.\n\n");
	}
	output("You abandon her in a heap of fluids and go about your own business.");
	amily.cocks[0].cLengthRaw = maxSizeCorr;
	processTime(10);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//(If the player says Yes):
private function giveAmilyPureIncubusDraft4Realz():void {
	clearOutput();
	amilySprite();
	pc.destroyItem(new CoCIncubiDPure());

	output("Assuring her that this is what you want, you pass it over. Amily takes it reluctantly, then downs it, shuddering - first in disgust at what she actually drank, then with pleasure. Moaning ecstatically, she pulls off her pants to give you a full view as her clitoris swells, longer and thicker; finally, skin peels back at the tip to reveal what is unmistakably the glans of a penis, complete with a cum-gouting slit as she experiences her first male orgasm.\n\n");

	output("Amily is now a hermaphrodite. Her human-like penis is four inches long and one inch thick.\n\n");

	output("Catching her breath, she stares at her new appendage with an unreadable expression, then pulls her clothes back on with a grimace. You decide to give her some time alone to adjust to the change.");
	amilyDickGrow();
	processTime(7);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function amilyDickGrow():void {
	var maxSize:Number = 15;
	if (!amily.hasCock()) {
		amily.createCock(4, 1.2);
	}
	else if (amily.longestCockLength() < 15){
		amily.cocks[0].cLengthRaw++;
	}
	if (amily.cocks[0].cLengthRaw >= maxSize) {
		amily.cocks[0].cLengthRaw = maxSize;
	}
}

//(If the player says No):
private function declineToMakeAmilyFuta():void {
	clearOutput();
	amilySprite();
	output("On second thought, you decide against giving it to her. Amily looks relieved as you apologize and put it back in your pocket. \"<i>So, what did you really want to ask me about?</i>\" She says, eager to change the subject.\n\nYou don't really have anything to say and walk away, embarrassed.");
	addButton(1);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//[Purified Succubi Milk]
public function giveAmilyPurifiedSuccubusMilk():void {
	clearOutput();
	amilySprite();
	//DAH PURE

	var maxSizePure:Number = 5;

	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		output("You offer her a vial of demonic milk, assuring her as you do so that the corruptive elements have been removed from it.\n\n");

		//(If Amily's breast size is smaller than DD-cup):
		if ((amily.breastRows[0].breastRatingRaw < maxSizePure)){
			output("She smiles at you. \"<i>I always did kind of want bigger breasts.</i>\" She admits, sheepishly. She takes it from you and eagerly chugs. She then drops the empty bottle, allowing it to smash on the ground, clutching her breasts and moaning ecstatically as they visibly swell, her clothes growing tighter as they do. When they finish, she squeezes them with glee. \"<i>Mmm... That feels nice. Did you want something else?</i>\"\n\n");
			amily.breastRows[0].breastRatingRaw++;
			pc.destroyItem(new CoCSucMilkPure());
			addButton(10);
		}
		//(If Amily's breast size is DD-cup):
		else {
			output("She looks thoughtful for a moment, then shakes her head reluctantly. \"<i>I'm sorry darling, I really am, but I think I've got big enough breasts as it is.</i>\" She then smirks, and playfully jiggles her abundant cleavage. \"<i>Don't you agree?</i>\" she teases.");
			applyDamage(new TypeCollection( { tease : 5 } ), amily, pc);
			output("\n\n");
			output("Swallowing hard, you have to agree, which makes Amily laugh.");
			addButton(1);
		}
	}
	//CORRUPT UNZ
	else {
		//[Give Succubi's Milk]
		if (pc.hasItem(new CoCSucMilk())) pc.destroyItem(new CoCSucMilk());
		else pc.destroyItem(new CoCSucMilkPure());
		//Doesn't matter if purified or not, she takes it the same way.
		//Amily's vagina is already at wetness 1, goes up to 4 (squirter).
		//You can give it Amily more Succubi's Milk after she's at 4, but it'll have no effect.
		output("You pick up a vial of Succubi's Milk and show it to Amily. \"<i>Do you know what to do with this, slut?</i>\" you ask her. \"<i>You want me to drink it, [pc.master]?</i>\" she asks you, licking her lips. You smile and reply, \"<i>That's right.</i>\" Then you push her on her back and lift her legs over her shoulders, exposing her wet pussy to you.  \"<i>Only, you're going to drink with these lips,</i>\" you add. Amily smiles in approval and excitement.");
		//[(If Amily has a dick)
		if (amily.hasCock()) output("  Her cock hardens with delight at your idea.");
		output("\n\n");

		output("You uncork the vial, spread Amily's pussy with a hand and pour the contents of the vial into Amily's hungry snatch. \"<i>Ah [pc.master]! It feels so good! Just like cum,</i>\" Amily moans in pleasure. The contents quickly disappear inside Amily's womb, triggering an orgasm within the whorish mouse-slave.");
		amily.vaginas[0].wetnessRaw++;
		//[(if Amily reached/is a squirter)
		if (amily.isSquirter()) output("  A jet of femcum flies straight out of her pussy, only to arch and hit her straight in the face.");
		else output("  Juices flood out of her pussy like water comes out of a spring, running down her body and pooling underneath her.");
		output("\n\n");

		//(if Amily's wetness < 4 (squirter))
		if (!amily.isSquirter()) {
			output("You let go of Amily's legs and she plops down in her pooled juices. You observe her as she comes down from her afterglow and realize her pussy is now much wetter; you're tempted to make her use her newly lubed up pussy, but refrain from doing so.\n\n");
			output("It'll be more fun to let her lust build; no doubt her pussy must be extra sensitive after this healthy dose of milk. You toss the vial away and casually stride back into the camp, leaving Amily panting on her juices.");
		}
		//(else)
		else {
			output("You let go of Amily's legs and she plops down in her pooled juices. You observe her and she comes down from her afterglow and realize her pussy is still squirting small jets of fluid; it seems giving her more succubi's milk won't have any effect besides... You give Amily's clit a little poke, and she screams in pleasure as she orgasms once more.\n\n");

			output("Looks like giving her more milk only makes her pussy sensitive. You're tempted to make use of her new, sensitive pussy, but refrain from doing so. It'll be more fun to let her lust build. You toss the vial away and casually stride back into the camp, leaving Amily panting in her juices.");
		}
		addButton(10);
	}
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//Drink succubus delight
private function amilyDrinksSuccubusDelight():void {
	clearOutput();
	amilySprite();
	// [HORSECOCKS] - Since I'm fucking lazy, that's why
	var footpaw:String = "foot";
	if (amily.hasFur())
		footpaw += "paw";
	if (amily.ballSizeRaw == 0) {
		if (flags["COC.AMILY_FOLLOWER"] == 2) {
			if (pc.hasItem(new CoCSucDelight())) pc.destroyItem(new CoCSucDelight());
			else pc.destroyItem(new CoCSucDelightPure());
			output("You tell her you need her to be able to cum more, so balls would help with that. Amily smiles and says, \"<i>Of course, [pc.master]. Forgive your stupid mouse slut for questioning you.</i>\"\n\n");
			output("She opens her legs so you can watch and downs the bottle in one go.");
			if (amily.hasCock()) output("Her cock grows hard, but nothing else seems to happen...");
			output("\n\n");

			output("You decide she needs a little push if she's going to have balls. \"<i>Lay down bitch,</i>\" you order her; being called a bitch only makes her smile as she complies.\n\n");

			//[=Cock=]
			if (pc.hasCock() && (gender(pc) == 1 || rand(2) == 0)) {
				output("You drop your pants and stand over her, your cock hardening at what you're about to do. \"<i>Pleasure me.</i>\" You order Amily. She lifts a " + footpaw + " and begins stroking your exposed " + pc.cockDescript(0) + "; she takes utmost care not to hurt you with her claws as she grips your shaft expertly between her toes. Her first " + footpaw + " is soon joined by her other one and together she begins nimbly masturbating you, giving you an expert footjob. No doubt she's been practicing; you'll have to reward her for this later.\n\n");

				output("You focus your corruptive powers, and a dollop of black pre forms on your tip; it slides over your shaft and lubes your " + pc.cockDescript(0) + ", allowing Amily to better stroke you. You can feel your orgasm coming fast, and you tell Amily to stop and open wide. She spreads her legs as far as they will go and watches, panting, as you finish yourself off. You shoot jet after jet of black cum all over her crotch. Amily moans with every jet that is spilled onto her corrupt form, relishing in the warmth that spreads throughout her.\n\n");
			}
			//[=Pussy=]
			else {
				output("You drop your pants and stand over her, your pussy moistening at what you're about to do. \"<i>Pleasure me,</i>\" you order Amily. Her tail lifts itself towards your pussy and begins rubbing against your lip and clit, drawing a moan of pleasure from you. Soon the spaded tip presses against your " + pc.vaginaDescript(0) + " and pushes into your depths. Amily begins expertly tail-fucking you, spinning her tail around like it was a tongue, licking at every inch of your depths. Soon the first gush of fluids spill onto her tail, lubing it up and making Amily's job easier as she pleasures you with a grin.\n\n");

				output("You focus your corruptive powers, imagining Amily with huge balls, producing delicious cum that she will spill at your command. The mouse cumslut becoming more and more of a toy; the only purpose in her life, to obey and pleasure you. You order her to withdraw; she complies reluctantly, and watches as you finish yourself off. A veritable tide of black juices spills from your " + pc.vaginaDescript(0) + " to hit her groin. Amily moans with every jet that is spilled on her corrupt form, relishing in the warmth that spreads throughout her.\n\n");
			}
			output("You watch, smiling, as a couple of " + (!amily.hasFur() ? "lumps begin forming" :"fuzzy lumps begin forming"));
			if (amily.hasCock()) output("right under her cock. Her skin grows and covers the base of her cock, pulling it in; giving her what looks like a sheath. It continues to expand and is finally complimented by a couple of orbs falling into her " + (amily.hasFur() ? "fuzzy " :"") + "sack, giving it the weight it needs to produce more cum. ");
			else output("between her legs. Her skin expands with the lumps, forming into a small sack. It continues to expand and is finally complimented by a couple of orbs falling into her " + (amily.hasFur() ? "fuzzy " :"") + " nutsack, giving it the weight it needs to produce cum, though how it will ever expel it is a mystery to you. ", false);
			output("\"<i>Good. Now, I want you to practice walking with these. I can't have you hurting yourself as you walk about,</i>\" you tell her. \"<i>Yes, [pc.master]</i>\,\" she replies, panting slightly; you leave her prone on the ground.");
			pc.orgasm();
			amily.ballSizeRaw++;
			processTime(12);
		}
		else {
			pc.destroyItem(new CoCSucDelightPure());
			output("Assuring her that this is what you want, you pass it over. Amily takes it reluctantly, then downs it, shuddering - first in disgust at what she actually drank, then with pleasure. Moaning ecstatically, she pulls off her pants to give you a full view as lumps grow in her groin just under her penis. It eventually shifts until a duo of testicles form completely.\n\n");

			output("Catching her breath, she stares at her new balls with an unreadable expression, then pulls her clothes back on with a grimace. You decide to give her some time alone to adjust to the change.");
			amily.ballSizeRaw++;
			processTime(6);
		}
	}
	//Too much
	else if (amily.ballSizeRaw >= 6) {
		output("You realize that giving Amily any more Succubi's Delight would make her practically immobile.  No, she doesn't need any more.  Maybe once you've secured a more appropriate place to keep an over-endowed harem.");
		processTime(1);
	}
	//[Give Succubus' Delight - repeat]
	else {
		pc.destroyItem(new CoCSucDelight());
		output("You pick up a vial of Succubi's Delight and show it to Amily. \"<i>Drink this; you need bigger balls,</i>\" you order her, passing the bottle to her. Amily replies, \"<i>Yes, [pc.master]</i>.\" Then she opens her legs and downs the bottle. She moans as her balls grow bigger and denser, churning with the extra cum her sack now holds.");
		amily.ballSizeRaw++;
		processTime(5);
	}
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//[Give Succubus' Delight]
public function giveCorruptAmilySuccubusDelight():void {
	clearOutput();
	amilySprite();
	//Doesn't matter if purified or not, she takes it the same way.
	//Amily must have a dick before she can take Succubus' Delight
	//Maximum size is cantaloupe-sized (size 6)
	//No balls yet?  QUERY!
	if (amily.ballSizeRaw == 0) {
		output("You pick up a vial of Succubi's Delight and show it to Amily. \"<i>Drink this,</i>\" you order her, passing the bottle to her. \"<i>You're going to give me balls, " + pc.mf("master", "mistress") + "? Are you sure?</i>\"\n\n");
		processTime(1);
		clearMenu();
		addButton(0, "Yes", amilyDrinksSuccubusDelight);
		addButton(1, "No", amilyFollowerEncounter);
	}
	else amilyDrinksSuccubusDelight();
}

public function giveAmilyPureSuccubusDelight():void {
	clearOutput();
	amilySprite();
	output("You offer up the vial of purified Succubi's Delight - and Amily promptly leaps back with a shrill squeak that borders on a scream in terms of volume.\n\n");
	
	output("\"<i>That's liquid corruption!</i>\" She protests. \"<i>Have you gone insane? I'm not drinking that, and you shouldn't either!</i>\"\n\n");
	
	output("You hastily assure her that it is purified and so neither of you have to worry about joining the ranks of the demons. She still looks skeptical, but then nods slowly and approaches you.\n\n");
	
	processTime(2);
	clearMenu();
	if (amily.hasCock() && amily.ballSizeRaw == 0) {
		output("\"<i>All right... but, are you sure you want to give that to me? You know it will make me grow balls, right?</i>\"\n\n");
		addButton(0, "Yes", amilyDrinksSuccubusDelight);
		addButton(1, "No", amilyFollowerEncounter);
		return;
	}
	else if (amily.ballSizeRaw > 0) {
		output("\"<i>All right... but, I don't want to grow my balls any bigger. Sorry.</i>\"\n\n");
		addButton(0, "Next", amilyFollowerEncounter);
		return;
	}
	else {
		output("\"<i>All right... but, I don't have a penis. Otherwise, I wouldn't be able to cum. Sorry.</i>\"\n\n");
		addButton(0, "Next", amilyFollowerEncounter);
	}
}

//[Pink Egg - Requires Amily be a Herm]
public function giveAmilyAPinkEgg():void {
	clearOutput();
	amilySprite();
	//PUREZ
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		output("You offer her a pink egg, explaining that it will remove her penis. You barely have time to finish before she snatches it from your hands and bites into it savagely; the shell crunches audibly as she fiercely masticates it, messily devouring it whole in her eagerness. Once she has finished, she drops her pants to watch as <b>her penis shrinks and blurs, eventually resolving itself once more into the dainty form of her clitoris</b>. She sighs, softly.\n\n");
		output("\"<i>Thank you, that's such a relief. So, anything else you wanted?</i>\" she squeaks merrily, quite clearly feeling very cheerful now.");
	}
	//Corrupt
	else {
		output("You offer her a pink egg, explaining that it will remove her penis.  Amily looks completely devastated as she says, \"<i>Did fuck-slut not use her dick well enough?  Cum-bucket is so sorry [pc.master], it won't happen again!</i>\"  Before you can respond she snatches the egg from your hand and begins to eat it, messily devouring it until she's licking her fingers.  Once she has finished, she drops her pants to watch as <b>her penis shrinks and blurs, eventually resolving itself once more into the dainty form of her clitoris</b>.\n\n");
		output("\"<i>Well, is there something else this worthless cum-collector can do to please her " + pc.mf("master", "mistress") + "?  Slut is so sorry she disappointed you,</i>\" she squeaks sadly, still trying to entice you into sex.");
	}
	if (pc.hasItem(new CoCPinkEgg())) pc.destroyItem(new CoCPinkEgg());
	else pc.destroyItem(new CoCPinkEggLarge());
	amily.removeCocks();
	amily.ballSizeRaw = 0;
	processTime(6);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}
//[White Egg]
public function giveAmilyAWhiteEgg():void {
	clearOutput();
	amilySprite();

	var maxSizePure:Number = 4;
	var maxSizeCorr:Number = 4;

	output("You hold out a white egg, telling her that it will make her nipples grow.\n\n");
	//Pure
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//(If Nipples are smaller than 4 inches:
		if (amily.nippleLengthRatio < maxSizePure) {
			output("She looks at it skeptically. \"<i>I guess bigger nipples would be more sensitive...</i>\" She mutters, but she takes it from you all the same. Unthinkingly biting off the top, she sucks down the contents in a practiced gulp. Crushing the shell in her hand, she pulls at her top, allowing you to see her nipples swell and grow until they stop. She experimentally tweaks one, squeaking in shock at the sensation. \"<i>Well... I guess that they do feel kind of nice... Was there anything else?</i>\"\n\n");
			if (pc.hasItem(new CoCWhiteEgg())) {
				pc.destroyItem(new CoCWhiteEgg());
				amily.nippleLengthRatio += .25;
				amily.nippleLengthRatio = int(amily.nippleLengthRatio * 100) / 100;
			}
			else {
				pc.destroyItem(new CoCWhiteEggLarge());
				amily.nippleLengthRatio += .7;
				amily.nippleLengthRatio = int(amily.nippleLengthRatio * 100) / 100;
			}
			if (amily.nippleLengthRatio > maxSizePure)
			{
				amily.nippleLengthRatio = maxSizePure;
			}
			processTime(6);
		}
		//(If Nipples are 4 inches:
		else {
			output("She shakes her head. \"<i>I'm sorry, but I think these are big and sensitive enough already. I'm a mouse, not a cow.</i>\" At that, she insistently walks away, clearly not going to take the egg. You return it to your pocket and decide to let her be.");
			processTime(1);
		}
	}
	//Corrupt!
	else {
		//(If Nipples are smaller than 4 inches:
		if (amily.nippleLengthRatio < maxSizeCorr) output("She looks at it and smiles knowingly. \"<i>Is " + pc.mf("master", "mistress") + " going to make this one's nipples into obscene toys?</i>\" she asks while accepting the egg.  She bites off the top and sucks down the contents in a practiced gulp.  Crushing the shell in her hand, she pulls at her top, allowing you to see her nipples swell and grow until they stop. She experimentally tweaks one, squeaking in shock at the sensation. \"<i>Thank you " + pc.mf("master", "mistress") + " for giving your slut such wonderful nipple-toys.  Would you like to abuse your slut's needy fuck-hole now?</i>\"\n\n");
		else output("She looks at it and moans lewdly, \"<i>My nipples are going to be sure huge for you " + pc.mf("master", "mistress") + ".  No, nipples isn't right.  They're teats now.  Huge, swollen cow-teats on your mousey fuck-pet.  Lets make them bigger!</i>\" She bites off the top and sucks down the contents in a practiced gulp.  Crushing the shell in her hand, she pulls at her top, allowing you to see her nipples swell and hang even lower. She experimentally tweaks one, squeaking in shock at the sensation. \"<i>Thank you " + pc.mf("master", "mistress") + " for making your slut's body useless for anything but sex.  Would you like to abuse your slut's needy fuck-hole now?</i>\"\n\n");
		if (pc.hasItem(new CoCWhiteEgg())) {
			pc.destroyItem(new CoCWhiteEgg());
			amily.nippleLengthRatio += .25;
			amily.nippleLengthRatio = int(amily.nippleLengthRatio * 100) / 100;
		}
		else {
			pc.destroyItem(new CoCWhiteEggLarge());
			amily.nippleLengthRatio += .7;
			amily.nippleLengthRatio = int(amily.nippleLengthRatio * 100) / 100;
		}
			processTime(6);
	}
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);

}

//[Brown Egg]
public function giveAmilyABrownEgg():void {
	clearOutput();
	amilySprite();

	var maxSizePure:Number = 16;
	var maxSizeCorr:Number = 20;

	output("You hold out a brown egg, telling her that it will make her butt grow.\n\n");
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//(If Amily's butt size is smaller than "jiggles with every step":
		if (amily.buttRatingRaw < maxSizePure) {
			output("\"<i>So, you want me to have a little more junk in the trunk, huh?</i>\" She giggles. \"<i>Well, I guess a little padding down there wouldn't hurt...</i>\" She takes the egg from you, her prominent front-teeth effortlessly biting off the top, whereupon she sucks down the contents in a practiced gulp. Crushing the shell in her hand, her hands then press themselves to her butt as she spins around so that it faces you, trying to look over her shoulder as it visibly swells, straining her pants.");
			applyDamage(new TypeCollection( { tease : 5 } ), amily, pc);
			output(" She pats it a few times, then shakes her head. \"<i>I'm going to have to go and let these pants out a little now.</i>\" She apologizes, and then walks away.\n\n");
			if (pc.hasItem(new CoCBrownEgg())) {
				pc.destroyItem(new CoCBrownEgg());
				amily.buttRatingRaw += 1 + rand(2);
			}
			else {
				pc.destroyItem(new CoCBrownEggLarge());
				amily.buttRatingRaw += 2 + rand(3);
			}
			if (amily.buttRatingRaw > maxSizePure) amily.buttRatingRaw = maxSizePure;
			processTime(6);
		}
		//(If Amily's butt is "delightfully jiggly":
		else {
			output("She looks at the egg, and then shakes her head. \"<i>Sorry, but I've got more than enough junk in my trunk for my taste.</i>\" Sensing she won't back down on this, you put the egg back. \"<i>So, is there anything else you wanted?</i>\" She asks.");
			processTime(1);
		}
	}
	//IMPURE
	else {
		//(If Amily's butt size is smaller than "jiggles with every step":
		if (amily.buttRatingRaw < maxSizeCorr) {
			output("\"<i>So, " + pc.mf("master", "mistress") + " would like " + pc.mf("his", "her") + " toy to have a little more padding around her horny puss and asshole?</i>\" she giggles. \"<i>I obey.</i>\" She takes the egg from you, her prominent front-teeth effortlessly biting off the top, whereupon she sucks down the contents in a practiced gulp. Crushing the shell in her hand, her hands then press themselves to her butt as she spins around so that it faces you, trying to look over her shoulder as it visibly swells, jiggling slightly.");
			applyDamage(new TypeCollection( { tease : 5 } ), amily, pc);
			output(" She pats it a few times, then shakes her head. \"<i>Will you be using your newly-improved cum-dumpster now?</i>\" she asks.\n\n");
			if (pc.hasItem(new CoCBrownEgg())) {
				pc.destroyItem(new CoCBrownEgg());
				amily.buttRatingRaw += 1 + rand(2);
			}
			else {
				pc.destroyItem(new CoCBrownEggLarge());
				amily.buttRatingRaw += 2+rand(3);
			}
			processTime(6);
		}
		//(If Amily's butt is "delightfully jiggly":
		else {
			output("Amily scarfs down the egg and looks back expectantly, but it doesn't seem to make her already massive backside any larger.  She pouts and whimpers, \"<i>Slut is sorry, but her ass is as big and round as it can get [pc.master]!</i>\"");
			processTime(1);
		}
	}
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//[Purple Egg]
public function giveAmilyAPurpleEgg():void {
	clearOutput();
	amilySprite();
	var maxSizePure:Number = 16;
	var maxSizeCorr:Number = 20;

	output("You hold out a purple egg, telling her that it will make her hips grow.\n\n");
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		//(If Amily doesn't have "full, womanly hips":
		if (amily.hipRatingRaw < maxSizePure)
		{
			output("She looks at it thoughtfully. \"<i>Wider hips...? Well, if you really want, I guess I can try it.</i>\" She takes the egg from you, her prominent front-teeth effortlessly biting off the top, whereupon she sucks down the contents in a practiced gulp. Crushing the shell in her hand, she almost loses her balance as her hips suddenly jut wider, the growth happening much faster than she expected. \"<i>I'm going to have to get used to walking like this, now.</i>\" She mutters, and then she awkwardly walks away.\n\n");
			if (pc.hasItem(new CoCPurpleEgg())) {
				pc.destroyItem(new CoCPurpleEgg());
				amily.hipRatingRaw += 1 + rand(2);
			}
			else {
				pc.destroyItem(new CoCPurpleEggLarge());
				amily.hipRatingRaw += 2+rand(3);
			}
			if (amily.hipRatingRaw > maxSizePure)
			{
				amily.hipRatingRaw = maxSizePure;
			}
			processTime(6);
		}
		//(If Amily has "full, womanly hips":
		else {
			output("She looks at you with one eyebrow quirked. \"<i>Any bigger, and I won't be able to run anymore. No thank you; I feel like enough woman already, and they aren't messing with my speed.</i>\" She turns and saunters off, as quickly as she can, but with a deliberate swaying of her hips, as if to prove both her points.");
			applyDamage(new TypeCollection( { tease : 5 } ), amily, pc);
			processTime(1);
		}
	}
	//Corrupt
	else {
		//(If Amily doesn't have "full, womanly hips":
		if (amily.hipRatingRaw < maxSizeCorr) {
			output("She looks at it thoughtfully. \"<i>[pc.Master] wants my hips even wider?  Are you going to use me as your private breeding stock?  Mmm, that turns me on!</i>\" She takes the egg from you, her prominent front-teeth effortlessly biting off the top, whereupon she sucks down the contents in a practiced gulp. Crushing the shell in her hand, she almost loses her balance as her hips suddenly jut wider, the growth happening much faster than she expected. \"<i>Gods that made me wet!  Take me... let's fuck right now, please!</i>\" she begs.\n\n");
			if (pc.hasItem(new CoCPurpleEgg())) {
				pc.destroyItem(new CoCPurpleEgg());
				amily.hipRatingRaw += 1 + rand(2);
			}
			else {
				pc.destroyItem(new CoCPurpleEggLarge());
				amily.hipRatingRaw += 2 + rand(3);
			}
			if (amily.hipRatingRaw > maxSizeCorr)
			{
				amily.hipRatingRaw = maxSizeCorr;
			}
			processTime(6);
		}
		//(If Amily has "full, womanly hips":
		else {
			output("She chomps down on the proferred egg, but nothing happens. \"<i>Slut's body is at its limits " + pc.mf("master", "mistress") + ".  Her huge breeding hips can't widen any further.  Would you like to fuck?</i>\" she asks, rocking her considerable mass back and forth hypnotically.");
			applyDamage(new TypeCollection( { tease : 5 } ), amily, pc);
			processTime(1);
		}
	}
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//[Reducto]
private function giveAmilySomeReducto():void {
	clearOutput();
	output("She wrinkles her nose at the awful smell of the paste you are showing her, even as you explain it's able to shrink down oversized bodyparts, and you can use this to reduce any parts that she thinks are oversized.");
	processTime(1);
	clearMenu();
	if (amily.breastRows[0].breastRatingRaw > 1) addButton(0, "Breasts", amilyReducto, 0);
	if (amily.nippleLengthRatio > 0.5) addButton(1, "Nipples", amilyReducto, 1);
	if (amily.hipRatingRaw > 6) addButton(2, "Hips", amilyReducto, 2);
	if (amily.longestCockLength() > 4) addButton(3, "Penis", amilyReducto, 3);
	if (amily.buttRatingRaw > 6) addButton(4, "Butt", amilyReducto, 4);
	addButton(14, "Nevermind", amilyFollowerEncounter);
}

private function amilyReducto(part:int):void {
	pc.destroyItem(new CoCReducto());
	var chosenPart:String = "";
	if (part == 0) { //Breasts
		chosenPart = "breasts";
		if (amily.breastRows[0].breastRatingRaw > 6) amily.breastRows[0].breastRatingRaw--; //Large breasts shrink more!
		amily.breastRows[0].breastRatingRaw--;
		if (amily.breastRows[0].breastRatingRaw < 1) amily.breastRows[0].breastRatingRaw = 1;
	}
	else if (part == 1) { //Nipples
		chosenPart = "nipples";
		if (amily.nippleLengthRatio > 3) amily.nippleLengthRatio -= 0.5; //Large nipples shrink more!
		amily.nippleLengthRatio -= 0.5;
		if (amily.nippleLengthRatio < 0.5) amily.nippleLengthRatio = 0.5;
	}
	else if (part == 2) { //Hips
		chosenPart = "hips";
		if (amily.hipRatingRaw > 12) amily.hipRatingRaw--; //Large hips shrink more!
		amily.hipRatingRaw--;
		if (amily.hipRatingRaw < 6) amily.hipRatingRaw = 6;
	}
	else if (part == 3) { //Penis
		if (amily.longestCockLength() > 10) amily.cocks[0].cLengthRaw--; //Large cock shrinks more!
		amily.cocks[0].cLengthRaw--;
		if (amily.cocks[0].cLengthRaw < 4) amily.cocks[0].cLengthRaw = 4;
	}
	else if (part == 4) { //Butt
		if (amily.buttRatingRaw > 10) amily.buttRatingRaw--; //Large butt shrinks more!
		amily.buttRatingRaw--;
		if (amily.buttRatingRaw < 6) amily.buttRatingRaw = 6;
	}
	output("Grimacing at the smell - it must be awful, for her sensitive nose - she starts smearing it over the " + chosenPart + ", and you step forward to help her. As the last of it wicks away, the part begins to shrink before your eyes. \"<i>Hmm. Not bad, I guess. So, was there something else you wanted?</i>\" She asks.");
	processTime(8);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//[Clothes]
public function giveAmilySomePants():void {
	clearOutput();
	amilySprite();
	//If you played an early build that didnt initialize clothes.
	output("You offer her a set of comfortable clothes, asking if she'd like to wear these instead of her " + amily.armor.longName + " she's wearing.\n\n");
	//(If Amily is wearing Tattered Rags:
	if (amily.armor.longName == "rags" || amily.armor.longName == "sexy rags") {
		output("Her eyes light up with glee. \"<i>Oh, I've always wanted some more clothes! Please, let me have them!</i>\" she squeaks with delight as you hand them over, carelessly stripping herself and throwing her old clothes aside before pulling on her new gear. She spins idly in place as she strives to examine how she looks, then she runs off to the stream to get a better view of her reflection.");
		amily.armor.longName = "comfortable clothes";
	}
	//(If Amily is wearing anything other than Tattered Rags:
	else if (amily.armor.longName != "comfortable clothes") {
		output("\"<i>More new clothes? Ooh, you're spoiling me, [pc.name]</i>!\" she teases you. Unabashed in the slightest at being naked in front of you, she strips down, doing her best to give you a little show as she does so. She then redresses herself in her new offering. \"<i>How do I look?</i>\" she giggles.\n\n");
		output("You assure her that she looks beautiful. \"<i>Flatterer.</i>\" She smirks, and then wanders off to the stream.");
	}
	processTime(8);
	pc.destroyItem(new ComfortableClothes());
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//[Lactaid]
private function makeTheMouseAMilkCowMoo():void {
	clearOutput();
	pc.destroyItem(new CoCLactaid());
	//--PURITY--
	if (flags["COC.AMILY_FOLLOWER"] == 1) { //Pure
		output("\"<i>Lactaid? You really want to try drinking mouse milk?</i>\" Amily asks, a little uncertainly, a little playfully.  You nod and assure that you do.  \"<i>Alright, if you insist.</i>\" She proclaims, taking the pink bottle from you and drinking the creaminess to be found within.");
	}
	else if (flags["COC.AMILY_FOLLOWER"] == 2) { //Corrupt
		output("\"<i>Lactaid? You really want to try drinking mouse milk?</i>\" Amily teases, seductively, a little playfully.  You nod and assure that you do.  \"<i>Alright, my " + pc.mf("master", "mistress") + "!</i>\" She proclaims, taking the pink bottle from you and drinking the creaminess to be found within.");
	}
	//--LACTATION--
	if (!amily.canLactate()) { //Not lactating
		//Less than C-cup
		if (amily.breastRows[0].breastRatingRaw < 3) {
			output("\n\nIt's quite obvious when the lactaid kicks in; her " + amily.breastCup() + " breasts suddenly puff out, swelling into proud C-cup breasts, milk flowing freely from her nipples, leaving her shirt both severely strained and soaked in milk.  She squeaks in dismay, and races away, clearly going to try and clean herself up.");
			amily.breastRows[0].breastRatingRaw = 3;
		}
		//C-cup or greater
		else if (amily.breastRows[0].breastRatingRaw >= 3) {
			output("\n\n\"<i>So...  when is this supposed to start - yeek</i>!\" She suddenly squeaks in shock as she realizes her shirt is growing damp.  She hastily pulls her top open, grabbing at her dripping breasts.  \"<i>I, I just gotta go take care of this.</i>\" She explains, blushing and then scampering away.");
		}
		clearMenu();
		addButton(0, "Next", amilyFollowerEncounter);
	}
	else { //Already lactating
		if (flags["COC.AMILY_FOLLOWER"] == 1) { //Pure
			output("\n\nQuickly she pulls her breasts out of her top; she doesn't want to make a mess on herself.  Beads of milk begin to form at the tip of her " + amilyNipples() + ", soon giving way to a steady trickle of fluid.  \"<i>More milk for thirsty Champions, hmm?</i>\" She teases you.  \"<i>I'm going to go and take care of this...  unless you want to help me now?</i>\" She trills.");
		}
		if (flags["COC.AMILY_FOLLOWER"] == 2) { //Corrupt
			output("\n\nQuickly she pulls her breasts out of her top; she doesn't want to make a mess on herself.  Beads of milk begin to form at the tip of her " + amilyNipples() + ", soon giving way to a steady trickle of fluid.  \"<i>More milk for my" + pc.mf("Master", "Mistress") + ", hmm?</i>\" She teases you.  \"<i>I'm going to go and take care of this...  unless you want to help me now?</i>\" She trills, seductively.");
		}
		clearMenu();
		addButton(0, "Yes",  takeChargeAmilyMouseMilk);
		addButton(1, "No", amilyFollowerEncounter);
	}
	if (amily.milkMultiplier < 50) amily.milkMultiplier = 50;
	amily.milkMultiplier += 10;
	amily.milkFullness = 100;
	
	processTime(6);
}

private function amilyHips():String {
	var desc:String = "";
	var rando:Number = 0;
	if (amily.hipRatingRaw <= 1)
	{
		if (rand(2) == 0) desc = "boyish ";
		else desc = "tiny ";
		if (amily.buttRatingRaw >= 6) desc = "waspish ";
	}
	if (amily.hipRatingRaw > 1 && amily.hipRatingRaw < 4) {
		rando = rand(3);
		if (rando == 0) desc = "slender ";
		if (rando == 1) desc = "narrow ";
		if (rando == 2) desc = "thin ";
		if (amily.buttRatingRaw >= 6) desc = "waspish ";
	}
	if (amily.hipRatingRaw >= 4 && amily.hipRatingRaw < 6) {
		rando = rand(3);
		if (rando == 0) desc = "average ";
		if (rando == 1) desc = "normal ";
		if (rando == 2) desc = "plain ";
	}
	if (amily.hipRatingRaw >= 6 && amily.hipRatingRaw < 10) {
		rando = rand(3);
		if (rando == 0) desc = "ample ";
		if (rando == 1) desc = "noticeable ";
		if (rando == 2) desc = "girly ";
	}
	if (amily.hipRatingRaw >= 10 && amily.hipRatingRaw < 15) {
		rando = rand(3);
		if (rando == 0) desc = "flared ";
		if (rando == 1) desc = "curvy ";
		if (rando == 2) desc = "wide ";
	}
	if (amily.hipRatingRaw >= 15 && amily.hipRatingRaw < 20) {
		rando = rand(3);
		if (rando == 0) desc = "fertile ";
		if (rando == 1) desc = "child-bearing ";
		if (rando == 2) desc = "voluptuous ";
	}
	if (amily.hipRatingRaw >= 20) {
		rando = rand(3);
		if (rando == 0) desc = "broodmother-sized ";
		if (rando == 1) desc = "cow-like ";
		if (rando == 2) desc = "inhumanly-wide ";
	}
	rando = rand(2);
	if (rando == 0) {
		if (rand(2) == 0 && amily.hipRatingRaw >= 15) desc += "flanks";
		else desc += "hips";
	}
	if (rando == 1) {
		if (rand(2) == 0 && amily.hipRatingRaw >= 15) desc += "flanks";
		else desc += "thighs";
	}

	return desc;
}

private function amilyButt():String {
	var desc:String = "";
	var rando:Number = 0;
	if (amily.buttRatingRaw <= 1)
	{
		if (rand(2) == 0) desc = "pixie-like ";
		else desc = "very small ";
	}
	if (amily.buttRatingRaw > 1 && amily.buttRatingRaw < 4) {
		rando = rand(3);
		if (rando == 0) desc = "tight ";
		if (rando == 1) desc = "firm ";
		if (rando == 2) desc = "compact ";
	}
	if (amily.buttRatingRaw >= 4 && amily.buttRatingRaw < 6) {
		rando = rand(2);
		if (rando == 0) desc = "fair ";
		if (rando == 1) desc = "nice ";
	}
	if (amily.buttRatingRaw >= 6 && amily.buttRatingRaw < 8) {
		rando = rand(3);
		if (rando == 0) return "handful of ass";
		if (rando == 1) desc = "full ";
		if (rando == 2) desc = "shapely ";
	}
	if (amily.buttRatingRaw >= 8 && amily.buttRatingRaw < 10) {
		rando = rand(3);
		if (rando == 0) desc = "squeezable ";
		if (rando == 1) desc = "large ";
		if (rando == 2) desc = "substantial ";
	}
	if (amily.buttRatingRaw >= 10 && amily.buttRatingRaw < 13) {
		rando = rand(3);
		if (rando == 0) desc = "jiggling ";
		if (rando == 1) desc = "spacious ";
		if (rando == 2) desc = "heavy ";
	}
	if (amily.buttRatingRaw >= 13 && amily.buttRatingRaw < 16) {
		rando = rand(3);
		if (rando == 0) desc = "hand-devouring ";
		if (rando == 1) return "generous amount of ass";
		if (rando == 2) desc = "voluminous ";
	}
	if (amily.buttRatingRaw >= 16 && amily.buttRatingRaw < 20) {
		rando = rand(3);
		if (rando == 0) desc = "huge ";
		if (rando == 1) desc = "vast ";
		if (rando == 2) return "jiggling expanse of ass";
	}
	if (amily.buttRatingRaw >= 20) {
		rando = rand(3);
		if (rando == 0) desc = "ginormous ";
		if (rando == 1) desc = "colossal ";
		if (rando == 2) desc = "tremendous ";
	}
	rando = rand(2);
	if (rando == 0) desc += "butt";
	if (rando == 1) desc += "ass";

	return desc;
}

private function amilyBalls():String {
	if (amily.ballSizeRaw == 0) return "prostate";
	var descripted:Boolean;
	var rando:Number;
	var desc:String = "";
	rando = rand(3);
	if (rando == 0) desc += "pair of ";
	if (rando == 1) desc += "two ";
	if (rando == 2) desc += "duo of ";
	//size!
	if (amily.ballSizeRaw > 1 && rand(3) <= 1) {
		if (amily.ballSizeRaw > 1 && amily.ballSizeRaw < 2) desc += "large ";
		if (amily.ballSizeRaw >= 2 && amily.ballSizeRaw < 3) desc += "baseball-sized ";
		if (amily.ballSizeRaw >= 3 && amily.ballSizeRaw < 4) desc += "apple-sized ";
		if (amily.ballSizeRaw >= 4 && amily.ballSizeRaw < 5) desc += "grapefruit-sized ";
		if (amily.ballSizeRaw >= 5 && amily.ballSizeRaw < 7) desc += "cantaloupe-sized ";
		if (amily.ballSizeRaw >= 7 && amily.ballSizeRaw < 9) desc += "soccerball-sized ";
		if (amily.ballSizeRaw >= 9 && amily.ballSizeRaw < 12) desc += "basketball-sized ";
		if (amily.ballSizeRaw >= 12 && amily.ballSizeRaw < 15) desc += "watermelon-sized ";
		if (amily.ballSizeRaw >= 15 && amily.ballSizeRaw < 18) desc += "beachball-sized ";
		if (amily.ballSizeRaw >= 18) desc += "hideously swollen and oversized ";
	}
	else if (amily.hasFur()) desc += "fuzzy ";
	rando = rand(9);
	if (rando < 4) {
		desc += "balls";
	}
	if (rando >= 4 && rando < 6) desc += "testicles";
	if (rando == 6) desc += "testes";
	if (rando == 7) desc += "gonads";
	if (rando == 8) desc += "nuts";
	return desc;
}

public function amilyTits():String
{
	var temp:int = Math.random() * 3;
	var descript:String = "";
	//50% of the time size-descript them
	if (rand(2) == 0) {
		if (amily.breastRows[0].breastRatingRaw <= 2)
		{
			temp = rand(3);
			if (temp == 0) descript += "small ";
			if (temp == 1) descript += "little ";
			if (temp == 2) descript += "perky ";
		}
		if (amily.breastRows[0].breastRatingRaw > 2 && amily.breastRows[0].breastRatingRaw <= 4)
		{
			descript += "ample ";
		}
		if (amily.breastRows[0].breastRatingRaw > 4 && amily.breastRows[0].breastRatingRaw <= 6)
		{
			temp = rand(4);
			if (temp == 0) descript += "big ";
			if (temp == 1) descript += "large ";
			if (temp == 2) descript += "pillowy ";
			if (temp == 3) descript += "jiggly ";
		}
		if (amily.breastRows[0].breastRatingRaw > 6 && amily.breastRows[0].breastRatingRaw < 13) {
			temp = rand(4);
			if (temp == 0) descript += "basketball-sized ";
			if (temp == 1) descript += "whorish ";
			if (temp == 2) descript += "pornstar-like ";
			if (temp == 3) descript += "jiggling ";
		}
		if (amily.breastRows[0].breastRatingRaw >= 13) {
			descript += "beach-ball sized ";

		}
		if (amily.breastRows[0].breastRatingRaw >= 18) {
			temp = rand(2);
			if (temp == 1) descript += "mountainous ";
			else descript += "immense ";
		}
	}
	//Nouns!
	temp = rand(10);
	if (temp == 0) descript += "breasts";
	if (temp == 1) {
		if (amily.milkMultiplier > 70) descript += "milk-udders";
		else descript += "breasts";
	}
	if (temp == 2) {
		if (amily.milkMultiplier > 65) descript += "milky ";
		if (amily.breastRows[0].breastRatingRaw > 4) descript += "tits";
		else descript += "breasts";
	}
	if (temp == 3) {
		//if (amily.breastRows[0].breastRatingRaw > 6) descript += "rack";
		descript += "breasts";
	}
	if (temp == 4) descript += "tits";
	if (temp == 5) descript += "tits";
	if (temp == 6) descript += "tits";
	if (temp == 7) {
		if (amily.milkMultiplier >= 50 && amily.milkMultiplier < 75) descript += "milk jugs";
		if (amily.milkMultiplier >= 75) descript += "udders";
		if (amily.milkMultiplier < 50) descript += "jugs";
	}
	if (temp == 8) {
		if (amily.breastRows[0].breastRatingRaw > 6) descript += "love-pillows";
		else descript += "boobs";
	}
	if (temp == 9) {
		if (amily.breastRows[0].breastRatingRaw > 6) descript += "tits";
		else descript += "breasts";
	}
	return descript;
}

public function amilyCock():String {
	var descript:String = "";
	var descripted:Boolean = false;
	var rando:Number;
	//Discuss length one in 3 times.
	if (int(Math.random()*3) == 0) {
		if (amily.longestCockLength() < 3) descript = "squat ";
		if (amily.longestCockLength() >= 3 && amily.longestCockLength() < 5) descript = "short ";
		if (amily.longestCockLength() >= 5 && amily.longestCockLength() < 7) descript = "average ";
		if (amily.longestCockLength() >= 7 && amily.longestCockLength() < 9) descript = "long ";
		if (amily.longestCockLength() >= 10 && amily.longestCockLength() < 13) descript = "huge ";
		if (amily.longestCockLength() >= 13 && amily.longestCockLength() < 18) descript = "massive ";
		if (amily.longestCockLength() >= 18 && amily.longestCockLength() < 30) descript = "enormous ";
		if (amily.longestCockLength() >= 30) descript = "towering ";
		descripted = true;
	}

	//Discuss girth one in 3 times.
	if (int(Math.random()*3) == 0) {
		//narrow, thin, ample, broad, distended, voluminous
		if (amily.thickestCockThickness() <= .75) descript += "narrow ";
		if (amily.thickestCockThickness() > 1 && amily.thickestCockThickness() <= 1.4) descript += "ample ";
		if (amily.thickestCockThickness() > 1.4 && amily.thickestCockThickness() <= 2) descript += "broad ";
		if (amily.thickestCockThickness() > 2 && amily.thickestCockThickness() <= 3.5) descript += "fat ";
		if (amily.thickestCockThickness() > 3.5) descript += "distended ";
		descripted = true;
	}
	rando=int(Math.random()*10);
	if (rando >= 0 && rando <=4) descript += "cock";
	if (rando ==5 || rando == 6) descript += "prick";
	if (rando == 7) descript += "pecker";
	if (rando > 7) descript += "shaft";

	return descript;
}
private function amilyNipples():String {
	var descripted:Boolean = false;
	var description:String = "";
	var rando:Number;
	//Size descriptors 33% chance
	if (rand(4) == 0) {
		//TINAHHHH
		if (amily.nippleLengthRatio < .25) {
			temp = rand(3);
			if (temp == 0) description += "tiny ";
			if (temp == 1) description += "itty-bitty ";
			if (temp == 2) description += "teeny-tiny ";
			if (temp == 3) description += "dainty ";
		}
		//Prominant
		if (amily.nippleLengthRatio >= .4 && amily.nippleLengthRatio < 1) {
			temp = rand(5);
			if (temp == 0) description += "prominent ";
			if (temp == 1) description += "pencil eraser-sized ";
			if (temp == 2) description += "eye-catching ";
			if (temp == 3) description += "pronounced ";
			if (temp == 4) description += "striking ";
		}
		//Big 'uns
		if (amily.nippleLengthRatio >= 1 && amily.nippleLengthRatio < 2) {
			temp = rand(4);
			if (temp == 0) description += "forwards-jutting ";
			if (temp == 1) description += "over-sized ";
			if (temp == 2) description += "fleshy ";
			if (temp == 3) description += "large protruding ";
		}
		//'Uge
		if (amily.nippleLengthRatio >= 2 && amily.nippleLengthRatio < 3.2) {
			temp = rand(5);
			if (temp == 0) description += "enlongated ";
			if (temp == 1) description += "massive ";
			if (temp == 2) description += "awkward ";
			if (temp == 3) description += "lavish ";
			if (temp == 4) description += "hefty ";
		}
		//Massive
		if (amily.nippleLengthRatio >= 3.2) {
			temp = rand(4);
			if (temp == 0) description += "bulky ";
			if (temp == 1) description += "ponderous ";
			if (temp == 2) description += "unmanageable ";
			if (temp == 3) description += "thumb-sized ";
			if (temp == 4) description += "cock-sized ";
			if (temp == 5) description += "cow-like ";
		}
		descripted = true;
	}
	
	//Milkiness/Arousal/Wetness Descriptors 33% of the time
	if (rand(3) == 0 && !descripted) {
		//Just lactating!
		if (amily.canLactate() > 0) {
			//Light lactation
			if (amily.milkMultiplier <= 60) {
				temp = rand(3);
				if (temp == 0) description += "milk moistened ";
				if (temp == 1) description += "slightly lactating ";
				if (temp == 2) description += "milk-dampened ";
			}
			//Moderate lactation
			if (amily.milkMultiplier > 60 && amily.milkMultiplier <= 70) {
				temp = rand(3);
				if (temp == 0) description += "lactating ";
				if (temp == 1) description += "milky ";
				if (temp == 2) description += "milk-seeping ";
			}
			//Heavy lactation
			if (amily.milkMultiplier > 70) {
				temp = rand(4);
				if (temp == 0) description += "dripping ";
				if (temp == 1) description += "dribbling ";
				if (temp == 2) description += "milk-leaking ";
				if (temp == 3) description += "drooling ";
			}
			descripted = true;
		}
	}
	//Nounsssssssss*BOOM*
	temp = rand(5);
	if (temp == 0) description += "nipple";
	if (temp == 1) {
		if (amily.nippleLengthRatio < .5) description += "perky nipple";
		else description += "cherry-like nub";
	}
	if (temp == 2) {
		if (amily.milkMultiplier >= 60 && amily.nippleLengthRatio >= 1) description += "teat";
		else description += "nipple";
	}
	if (temp == 3) {
		if (amily.milkMultiplier >= 60 && amily.nippleLengthRatio >= 1) description += "teat";
		else description += "nipple";
	}
	if (temp == 4) {
		description += "nipple";
	}
	return description;
}

//Oral
private function corruptAmilyOralSuckOff():void {
	amilySprite();
	clearOutput();
	output("\"<i>Come and suck me off,</i>\" you order. Amily wastes no time and scrambles to nuzzle your crotch affectionately");
	//[(if PC has a pussy)
	if (pc.hasVagina()) {
		output("; getting some of your juices on her " + (amily.hasMuzzle()?"muzzle":"lips"));
		if (pc.balls > 0) output(" and ");
	}
	else if (pc.balls > 0) output("; ");
	if (pc.balls > 0) output("tickling your balls with her " + (amily.hasFur()?"fur":"skin"));
	output(".  She rubs her head all over your crotch, making sure to catch as much of your musk as possible; as well as exciting you further. Finally when she's done she begins saying, \"<i>Thank you for allowing this worthless cunt to taste your wonderful essence, my [pc.master].</i>\" Amily gives your shaft a small lick and then continues, \"<i>Blessed be, oh great Marae, for granting this slutty cumdumpster mercy and allowing me to have and serve my [pc.master] so fully. Amen.</i>\"  ");
	output("With that said, she grins widely and dives into her task, brutally shoving as much of your shaft into her mouth as she can.");
	//[(if PC is huge)
	if (pc.cockVolume(0) > amily.vaginalCapacity()) output("  However, even she has her limits. At one point Amily's throat just can't take in any more of you, and the rest of your shaft is left out of her mouth. She's determined to take in all of you however; and keeps trying to push more of your shaft inside, until you get tired of waiting and tell her to just start bobbing like a good slut. She immediately complies.");
	output("\n\n");

	output("Amily's skills have been honed to near perfection.  She is familiar with your " + pc.cockDescript(0) + " and is able to massage every single sensitive spot on your cock. Every time she bobs her head, she slurps noisily on your shaft and rakes her teeth teasingly; always careful so she won't hurt this most precious part of her [pc.master].\n\n");
	//NO TEETH! OW
	output("It only takes a while to drive you near the edge of an orgasm, yet the final push never comes. When you look down you see Amily looking at you mischievously. It looks like she wants to play... She wants you to take her head in your grasp and give her a good face fucking. You smile wickedly at her and say, \"<i>Very well, you clever little bitch.</i>\" You see Amily's eyes light up with happiness as you roughly grab her ears and begin to give her the fucking she yearns for. You pay no heed to the pain you might be causing her, not that it looks like she's in any pain. All that escapes her mouth are happy moans and muffled screams of pleasure; voicing to the world how much she enjoys being roughly fucked by you.  If anything, she seems to be thinking of how great it is to be abused and used by you like the cumslut she is.\n\n");

	output("Now in control, you quickly feel your");
	//[(if PC has balls)
	if (pc.balls > 0) output(" balls churn and your");
	output(" " + pc.cockDescript(0) + " throb one last time before saying, \"<i>Here's your reward, bitch.</i>\" Then you explode deep into her throat, much to her pleasure.");
	//[(if PC has big cum amount)
	if (pc.cumQ() >= 1000) output("  Her belly distends and doesn't stop distending, nor does the flow of your cum ebb. For Amily, this is her purpose in life, to serve as a receptacle for your lusts, to serve you like a good cumbucket and take every little drop you pour into her. That thought only makes you cum harder.");
	output(" Finally, the flow of [pc.cumNoun] ebbs; Amily rubs her distended belly and inhales sharply, pulling back slightly. With a brutal thrust, she blows on your cock; sending a shock of pleasure running through you and milking a few more spurts of cum. Now completely spent, you pull back; Amily tries to keep your cock inside her mouth by sucking on it with all her might, but it's useless. With a <b>POP</b> you pull your " + pc.cockDescript(0) + " free of Amily's hungry jaws; it is clean, without a single trace of cum and barely any spit on it. You look at Amily and she looks back, smiling happily and licking her lips. \"<i>Thank you for the meal, [pc.master],</i>\" she says before a small burp escapes her. You pat her on the head, get dressed, and leave Amily, satisfied with her good work.");
	processTime(16);
	pc.orgasm();
	//dynStats("sen", 1, "cor", 1);
	pc.cor(1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
private function corruptAmilyLickPussiesLikeAPro():void {
	amilySprite();
	clearOutput();
	//[Oral sex]
	//Herms pick if Amily gets to lick them or blow them.
	output("\"<i>It's time to eat,</i>\" you declare and Amily instantly perks up after hearing it. You remove the lower half of your [pc.gear] and thrust your crotch at Amily; displaying your quickly ");
	if (pc.hasCock()) output("hardening [pc.cockNoun] and ");
	output("moistening " + pc.vaginaDescript() + ". Amily watches as if mesmerized, drool escaping her mouth as she licks her lips in anticipation.\n\n");

	//[=Pussy=]
	output("You spread your pussy lips, ");
	//[(if squirter)
	if (pc.isSquirter()) output("and a jet of fluids shoots out of your sensitive pussy.");
	else output("moisture wetting your finger.");
	output("You grin at Amily and say, \"<i>What are you waiting for?</i>\" Amily grins back and rushes forward to bury her nose into your " + pc.vaginaDescript() + ", inhaling as much of your scent as she can.\n\n");

	output("Amily's cold nose sends a chill of pleasure coursing through you, and you reward Amily's initiative with a small stream of juices that stick to her nose");
	//, [(if PC has a cock)
	if (pc.hasCock()) {
		output(", your cock springing up into attention");
		if (pc.balls > 0) output(" and ");
	}
	//[(if PC has balls)
	if (pc.balls > 0) {
		if (!pc.hasCock()) output(", ");
		output("your " + pc.ballsDescript() + " gently resting atop her head, supported by her small horns");
	}
	output(".  She moves her head back, a thin strand of girlcum linking her nose to your " + pc.vaginaDescript() + ".  Amily "+(amily.hasMuzzle() ? "licks":"wipes") +" her nose "+(amily.hasMuzzle() ? "off and licks it all up":"") +", savoring the taste of the juices, \"<i>Wonderful, mistress, just wonderful,</i>\" Amily grins; then she bows and says, \"<i>Thank you for allowing this worthless cunt to taste your wonderful essence, my mistress.</i>\"  She gives your clit a quick lick and continues, \"<i>Blessed be, oh great Marae.  For granting this slutty cumdumpster mercy and allowing me to have serve my [pc.master] so fully.  Amen.</i>\" With that said, she licks her lips, ");
	//[(if PC has balls)
	if (pc.balls > 0) output("lifts your [pc.balls] to set them gently atop her head, ");
	output("then she dives into her task.\n\n");

	output("Amily excitedly slathers your netherlips with her saliva, licking all around your " + pc.vaginaDescript() + "; every once in a while she'll stop her ministrations to give your ");
	if (pc.balls > 0) output("balls");
	else output(pc.clitDescript());
	output(" a quick kiss.  You pat her head, letting her know you're pleased with her ministrations, but also urging her to get on with it and start eating you out properly.  The silent order does not go unnoticed and Amily plunges her tongue as far into your love-hole as she can"+(amily.hasFur()?"; her fur tickles your labia pleasurably":""));
	//[(if PC has balls)
	if (pc.balls > 0) output(" and her small horns gently massage your [pc.balls]");
	//[(if PC has a cock)
	if (pc.hasCock()) output("; [pc.eachCock] throbs and begins leaking pre; it forms small rivulets that run down onto Amily's head");
	output(".  The " + (amily.hasFur()?"mousette":"succubus") +" jumps slightly and you can almost imagine her grinning as she eats out her meal.\n\n");

	output("You wonder, just how has Amily been practicing her pussy eating skills - she's really good at this, and her intimate knowledge of your insides combined with her agile tongue means she can lick your special spot frequently.  Each time her tongue brushes over your g-spot, you reward her with increasingly bigger streams of femcum.  Amily remains in a constant rhythm, and while it is pleasurable you're going to need more if you're to ever reach orgasm; when you look down to order her to get serious you see she's looking back at you with a mischievous look; you giggle and say, \"<i>So that's how it's gonna be huh? Clever little bitch.</i>\"\n\n");
	// More [Horsecock]
	output("You move back and push Amily back into the ground, she hits the ground with a <b>THUD</b> and grins at you.  You move quickly, sitting on top of Amily's face and beginning using her mousy "+(amily.hasMuzzle()?"muzzle":"nose") +" like a dildo, rubbing it all over your pussy; her tongue darts out to give little licks and enhance your pleasure.\n\n", false);
	//(if PC is loose enough [Horsecock] and has a muzzle to fuck with)
	if (pc.vaginalCapacity() >= 100 && amily.hasMuzzle()) {
		output("You giggle and decide to take things one step further; you shove Amily's muzzle into your " + pc.vaginaDescript() + "; Amily's eyes bulge with surprise once she feels her muzzle begin to slide inside you and you voice your pleasure with a long moan, \"<i>I'm not letting you breathe until you make me come, slut.</i>\"  With those words, you begin rising and lowering yourself into Amily's muzzle; her tongue darts out to taste your walls once in a while, but most of the time your clenching vagina keeps her muzzle shut, so Amily settles for muzzle-fucking you like the good little cumslut slave she is.\n\n");
	}
	else {
		// BEGIN [Horsecock]
		output("You giggle and decide to take things one step further; you ");
		if (amily.hasMuzzle())
			output("hold Amily's muzzle tightly closed and shove Amily's muzzle against your ");
		else
			output("bury her nose as far as it will go into your ");
		output(pc.vaginaDescript() + " , holding her " + (amily.hasMuzzle()?"nose":"mouth") + " closed; Amily's eyes bulge with surprise and you voice your pleasure with a long moan, \"<i>I'm not letting you breathe until you make me come slut. </i>\" With those words, you begin frigging yourself against Amily's ");
		output((amily.hasMuzzle()?"mousy muzzle":"face") + ", intent on driving yourself to orgasm as you feel her cheeks bulge with air and need.\n\n");
		// END [Horsecock]
	}

	//Both variations link here
	output("Amily's rather desperate and eager ministrations are effective and you feel yourself on the edge of orgasm.  ");
	//[(if PC is loose enough)
	if (pc.vaginalCapacity() >= 100) output("You pull yourself off Amily's "+(amily.hasMuzzle()?"muzzle":"face") +" and moan deeply.");
	else output("You let go of Amily's "+(amily.hasMuzzle()?"muzzle":"face") +" and moan deeply.");
	output("  Amily gasps for air, just in time to receive a faceful of your girlcum; she quickly latches her mouth onto your " + pc.vaginaDescript() + ", sealing it to avoid losing any more of your delicious juices; and you're more than happy to feed her as much as you can. Amily never stops drinking, though some droplets inevitably escape her and splatter against her wet face. Once you're done you rise and look down at your handywork.\n\n");

	output("Amily coughs, but gathers as much of your spilled juice as she can and licks if off her hands.  When she's settled down, you look at her, as if waiting for something.  \"<i>Oh! Of course, forgive me mistress,</i>\" Amily says, quickly scrambling up onto her knees to begin licking your pussy and thighs clean. Once you're satisfied, you get dressed and walk away.  \"<i>Mistress!</i>\" Amily calls out to you; you turn to see the smiling corrupt mousette rubbing her belly and licking her lips.  \"<i>Thank you for the wonderful meal.</i>\"\n\n");

	output("You chuckle and dismiss her with a wave.");
	processTime(26);
	pc.orgasm();
	//dynStats("sen", -1, "cor", 1);
	pc.cor(1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Corrupt scissortastrophie!
private function corruptAmilyScissorsLikeAPro():void {
	amilySprite();
	clearOutput();
	output("You grin as an interesting idea comes to your mind; you order Amily to lay down and spread her legs; she complies and you undress and gently set yourself between her legs, aligning your pussy with hers,");
	//[(if Amily has a cock)
	if (amily.longestCockLength() > 0) output(" Amily's " + amilyCock() + " throbs,");
	output(" and she smiles once she gets what you want to do.\n\n");

	output("You examine Amily's crotch closely, ");
	//[(if Amily has a cock)
	if (amily.longestCockLength() > 0) {
		output("idly stroking her " + amilyCock());
		//(if Amily has balls)
		if (amily.ballSizeRaw > 0) output(" and " + amilyBalls() + ", which you shift to reveal her ");
		else output(" before dipping down to her ");
	}
	else output("eyeing her ");
	output(pc.vaginaDescript() + ".  You lift a hand and stroke the slutty box with your fingers.  It doesn't take long before she is wet and ready, her little clit poking out as stiff as a cock");
	//[(if Amily has a cock)
	if (amily.longestCockLength() > 0) output(" almost as if trying to match its bigger brother above");
	output(". You give Amily a smirk as you take your lubricant-wet hand and begin to massage her juices into your own " + pc.vaginaDescript() + ".  \"<i>Do you like it when I play with your cunt, slut?</i>\" you ask her.\n\n");

	output("\"<i>Oh, Mistress... I love being your plaything,</i>\" Amily replies, her spade tipped tail gently coiling around your " + pc.leg() + " to tease your " + pc.vaginaDescript() + ".  \"<i>Let me pleasure you, let me worship you, let me serve you, mistress.</i>\"  With a diabolic grin, you sink down on top of your rodent sex-slave, giving her " + amilyTits() + " a good squeeze to emphasise it.  \"<i>Well then, let's see how well you can do. Lie back and let me enjoy myself, slut.</i>\"\n\n");

	output("Amily does as you order and with a little flick against your ");
	//[(pc.ballsDescript)
	if (pc.balls > 0) output(pc.ballsDescript());
	else if (pc.hasCock()) output(pc.cockDescript(0));
	else output(pc.clitDescript());
	output(" her tail uncoils and goes to her mouth so she can suckle the tip.\n\n");

	output("Making sure her legs are spread wide to receive you ");
	//[(if Amily has a cock)
	if (amily.longestCockLength() > 0) output("and her cock ");
	output("is tipped out of the way ");
	output(", you slowly lower your " + pc.vaginaDescript() + " to that of Amily's. You're not entirely sure how well scissoring will work when she is the submissive and you are the dominant... but you can sure have some fun trying!\n\n");

	output("Amily moans");
	//[(if Amily's a squirter)
	if (amily.isSquirter()) output(" and a jet of warm juices splashes against your " + pc.vaginaDescript());
	// [Horsecock]
	output("; her "+(amily.hasFur()?"claws":"feet") +" curl in pleasure and she begins panting, eager to pleasure you and enjoying being used so. Amily looks at you, awaiting your next move or command with lusty eyes; you grin and wonder how much teasing she can take before she starts begging for release. You rub Amily's little wethole with your own gently, barely touching and taking care to ensure your clit pokes hers; Amily moans in pleasure, but you can see this is not enough to get her to cum. Still you continue with your light teasing until Amily says, \"<i>Please mistress! I-I need... I can't... Ah!</i>\"\n\n");

	output("Watching the slutty little succu-mouse buck and writhe under you is so fun, but you've got a needy pussy");
	if (pc.hasCock()) output(" and an aching " + pc.cockDescript(0));
	output(" to sate, so it's time for things to get heavy. \"<i>You need, slut? What about what I need, hmm? Will you let me do whatever I want to you if I help you get off, hmm?</i>\" you tease her. Amily gasps in realization and says, \"<i>Forgive your worthless fucktoy mistress. Of course your pleasure comes first. I-I'll pleasure however you like, without cumming if you will forgive me mistress.</i>\"\n\n");

	output("You give her a patronizing smile and then pat her gently on the head. \"<i>There, there, my little slut; it's all right. After all, how can you be expected to think about anything other then sex? That's not what you're made for - you're my little sextoy. I made you to fuck and fuck; and that's what you're going to do.</i>\" You smile sweetly, then finally lower your pussy back to her own now-sopping fuckhole. It squelches and slurps as your netherlips mesh together, her little clit rubbing against your own " + pc.clitDescript() + " in a way that sends the most delightful tingles of pleasure racing through your lips. Smiling fiercely, you begin to squeeze and fondle her big mouse-tits, feeling their weight, their delightfully grippable balance between softness and firmness, even as you start to rock back and forth.\n\n");

	// [Horsecock]
	output("\"<i>Thank you so much mistress! I love to fuck! I love to be fucked! I love to be used! I love being your sextoy! I love the way your pussy feels against mine! I love you, mistress!</i>\" Amily screams as an orgasm rocks her. She presses against you with all her strength, legs wrapping themselves around you, "+(amily.hasFur()?"claws":"feet") +" curled in pleasure, eyes rolled back.");
	//[(if Amily's a squirter)
	if (amily.isSquirter()) output("  A veritable jet of juices shoots up, splashing against your netherlips, some of it even making it inside.");
	else output("  Wet squeltches and splats resound around you, as the results of Amily's orgasm flood what little space remains between the two of you.");
	//[(if Amily has a cock)
	if (amily.longestCockLength() > 0) output(" Her " + amilyCock() + " throbs and cum splashes on her breasts and face.");
	output("\n\n");

	// [Horsecock]
	output("You grin wickedly; the former puritan" + (amily.hasFur()?" mouse":"") +", now turned into another horny little beast, your horny little beast. The irony is so delicious... but not as delicious as the feelings she's eliciting inside you. You grind, hump, and thrust, brutally shoving your pelvises together, craving the friction and almost feeling upset with the copious amounts of femcum helping you slide back and forth. Amily's grinds against you even as you viciously attack her, riding out her orgasm as well as trying to pleasure you. Her tail pokes your " + pc.hipDescript() + " as it seeks entry between your tightly mashed pussies; eventually it manages to do so and it slowly snakes itself in and out, the tip flicking against your clit and providing the additional friction to bring you ever closer to the edge.");
	//[(if PC has a cock)
	if (pc.hasCock()) output("  Amily's hands shoot out to grab [pc.oneCock] and begin masturbating you; the corrupt succu-mouse doing all she can to give you the release that you crave.");
	output("\n\n");

	output("\"<i>Yes! Good little toy - you are good at this!</i>\" you tell her, unable to think clearly. You can feel your orgasm coming, but all that comes out of your mouth is a wordless howl of pleasure as the ecstasy thunders through your loins and out, riding the crescendo in a storm of femcum that spews from your " + pc.vaginaDescript());
	//[(if PC's a squirter)
	if (pc.isSquirter()) output(", drenching Amily's body in your fluids and marking her quite emphatically as your property");
	output(".\n\n");

	// [Horsecock] - Someone missed the "mouse". - Harb
	output("Amily goes limp while your juices continue dripping on her.  She pants as she looks at you with mixed desire and adoration, moving into a kneeling position to say, \"<i>Thank you for letting this worthless cumslut pleasure you.</i>\" You just smirk at her before reaching down to scoop up some of the pooled sexual fluids.  You plaster it in a crude pattern onto the "+(amily.hasFur()?"mouse":"succubi") +"'s "+(amily.hasMuzzle()?"muzzle":"face") +". \"<i>Never forget; you belong to me, my little toy,</i>\" you tell her. Then, feeling generous, you decide to give her the honor of your kiss, tongue fiercely probing to help emphasize that Amily is yours. Then, standing up, you see the state you are in and frown. \"<i>Clean me off, slut; I don't need to be reeking of juices all day,</i>\" you order her imperiously.\n\n");

	output("Amily beams with happiness, \"<i>Yes mistress!</i>\" then proceeds to clean you up, licking every single drop she can out of your body.  To finish it all up, she licks your " + pc.feet() + " clean of whatever juices remained on them. Satisfied, you dismiss Amily with a wave, heading back to the camp, while Amily rubs the results of your coupling on her body.");
	processTime(24);
	pc.orgasm();
	//dynStats("sen", -1, "cor", 1);
	pc.cor(1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Fuck corrupt Amily's pussaaaaaayyyyy
private function corruptAmilysPussyGetsMotherfuckingFucked():void {
	amilySprite();
	clearOutput();
	output("You tell Amily that you're feeling playful and tell her you'd like to do some role-playing; you tell Amily to play the role of a demon out to seduce you. \"<i>But I could never do that [pc.master], the only role I'm fit for is being your adoring slave!</i>\"\n\n");

	output("You grin and tell her she should at least try. Amily smiles and replies, \"<i>If that's what you want [pc.master], I'd be glad to try,</i>\" Before starting, you tell Amily to try and act like a real demon.\n\n");

	output("You tell Amily to spread her legs and begin undressing, peeling off your [pc.gear] piece by piece. Amily doesn't even bother to speak to you; she simply grins in delight, moisture already beginning to flow from her gaping pink vagina.\n\n");
	//(If pregnant:
	if (flags["COC.AMILY_INCUBATION"] < 3 * 168 / 2) output("  Her gravid state doesn't faze her; indeed, she thrusts her bump forward proudly, a visible sign of your mastery over her.");
	output("  She flops down onto her " + amilyButt() + " and rolls backwards, spreading her legs out eagerly for you to have access and waving them like hungry, groping limbs, reaching for you in her impatience to start.  You grin in delight, but decide to tease the slutty "+(amily.hasFur()?"mousette":"succubus") +" by staying just out of the reach of her "+(amily.hasFur()?"foot-claws":"shapely feet") +".  \"<i>If you want it, then tell me just how much you want it slut,</i>\" you tease her mockingly, stroking your " + pc.cockDescript(0) + " into erection. "+(amily.hasFur()?" Just watch the heels, and don't dare injure your master.":""));
	//[(if PC has a vagina)
	if (pc.hasVagina()) output("  Your other hand probes your moist fuck-hole for lube to help with your stroking.");
	output("\n\n");

	output("Amily doesn't even roll her eyes, she is that much of a helplessly loyal slut for you. \"<i>I want it, [pc.master]! I want it more than anything else! I'm a cum-dumpster, a baby factory - I need cum in my hungry pussy, or I'll just fade away! Please, [pc.master], pump me full of your hot, [pc.cumFlavor], [pc.cumVisc] [pc.cumNoun]!");
	//(If not pregnant:
	if (flags["COC.AMILY_INCUBATION"] == undefined) output("  I want you to fuck me full of cum, bloat me with seed until I'm a ball of skin over spooge with a head and limbs sticking out! I need to be full and round with the very stuff of life; fucking cum into me, [pc.master]!");
	//(If pregnant:
	else output("  The babies need their cum, [pc.Master]. They won't grow strong and healthy and slutty if you don't flood their womb with your hot baby-making juice! Please, cum and fill me with cum, for their sake?");
	output("</i>\"\n\n");

	output("It pleases you to see how much of a eager bitch she really is. You step close and take hold of her hip, then further tease her by rubbing your shaft along her slit, slickening it with her juices.");
	//[(if Amily has balls)
	if (amily.ballSizeRaw > 0) output("  Her balls do get in the way, but they form a nice cushion to rub your " + pc.cockDescript(0) + " on, further stimulating you.");
	output("  Amily squeals in glee and wraps her legs around your " + pc.hipDescript() + ". She is too well-trained to use them to slam you into her crotch, but you can feel the muscles in them quivering with the urge to pull you into proper penetrative position. You smile wickedly; as much as you want to plow her depths and fuck her raw, you also want to see just how far you can go before she breaks... \"<i>[pc.Master]... please... why are you torturing yourself? Give yourself over to your loving mousy slut; lose yourself between my legs, let my needy cunt swallow your " + pc.cockDescript(0) + " and milk you as only I can. No two-bit whore of a succubus will ever bring you the pleasure I will...</i>\" Amily moans pleadingly, her tail rising up to caress your " + pc.buttDescript() + ", her hands playing with her " + amilyTits() + ".\n\n");

	output("\"<i>Torturing myself you say? I think you're right. Maybe I should see if ");
	//[(if Jojo's corrupt)
	if (campCorruptJojo()) output("Jojo wants to play,");
	//(else)
	else output("I can't find someone else to play with,");
	output("</i>\" you say, nonchalantly attempting to pull away from her. \"<i>No!</i>\" Amily screams; her legs tighten about your waist with such force that she actually lifts herself off of the ground in her eagerness to plant herself firmly against your crotch, rubbing her slavering pussy against you. \"<i>Mine! My fuck! Mine!</i>\" she squeaks indignantly. You laugh at how far you've pushed your little mouse slave.  Sliding your " + pc.cockDescript(0) + " against her pussy, you bend down and grope her breasts roughly, drawing a desperate moan from her; slowly you get closer to her ears, then whisper, \"<i>Go ahead,</i>\" while humping against her to further excite her.\n\n");

	//(If PC is Huge)
	if (pc.cockVolume(0) >= amily.vaginalCapacity()) {
		output("She quivers with tension; for a moment, you think she's going to kiss you in gratitude. But then, instead, she remembers her place and pushes backward, her tail awkwardly coiling around your " + pc.cockDescript(0) + " and pulling on it to clumsily maneuver it into place. You can feel the heat emanating from her juicy cunt as the tip brushes against its lips, but no matter how much she pushes, she just can't seem to get it in. She pushes and grinds against your " + pc.cockDescript(0) + " with all her might, with no regards if she hurts herself in the process. You decide to stop her before she does something irreversible. \"<i>F-Forgive me [pc.master]. This slut's useless cunt is unfit for your glorious " + pc.cockDescript(0) + ", [pc.master].</i>\" You pat her in the head and tell her that someday, perhaps, she will be able to take all of you in, but for now she should take it slow. You grind against her, lubing up your " + pc.cockDescript(0) + " as well as you can, and stretching her bit by bit. Then with a bit of effort you finally manage to get some if it inside. \"<i>See? This is how you get a huge cock inside you Amily,</i>\" you tell her. \"<i>You truly are most wise [pc.master],</i>\" Amily comments. You smile and say, \"<i>Now get back in character slut,</i>\" giving her ass a good slap.");
	}
	else {
		output("She quivers with tension; for a moment, you think she's going to kiss you in gratitude. But then, instead, she remembers her place and pushes backward, her tail awkwardly coiling around your " + pc.cockDescript(0) + " and pulling on it to clumsily maneuver it into place. You can feel the heat emanating from her juicy cunt as the tip brushes against its lips, seconds before, with a squeal of triumph, she brutally impales herself upon you. You can't help but moan in pleasure; despite all the teasing you really needed this. Her insides are warm and wet, just the way you like it.");
		if (amily.isSquirter()) output("  Jets of fluid wash down whatever pre escapes your rigid tool.");
		output("  You have half a mind to brutalize the mousette then and there; yet for now you decide to let Amily have her way. She has earned this small reward for amusing you.");
	}
	pc.cockChange();
	output("\n\n");
	output("Amily thrusts and bucks against you; trying her best to impale herself upon you. But in her current position, her attempts are clumsy at best. Disappointed by her failure to properly serve you, you pin her down against the dirt, twisting one of her nipples painfully and grabbing her hair roughly. \"<i>This is not good enough cumslut. What do you have to say for yourself?</i>\" you ask her calmly, but threateningly. \"<i>Forgive me, [pc.master]! But this worthless slut doesn't know how to better please you... Please! Show me how to please you, [pc.master]!</i>\" she begs you, not sounding at all frightened of you, nor in pain from your rough treatment; all you see in her eyes is lust and an overwhelming desire to please you and be fucked by you...\n\n");
	//both variants link here
	output("You grin at her answer. You'll show her just how to properly pleasure you... You let go of her and grab her full thighs, flipping her knees above her head. Amily gasps and smiles at you; then you begin forcefully pounding her, doing your very best to fuck her raw; ");
	if (pc.balls > 0) output("your balls slap against her butt and ");
	output("her tail thrashes about behind you. You grunt and pant; quickly nearing orgasm. Your " + pc.cockDescript(0) + " throbs and leaks copious quantities of pre. \"<i>Oh, yes, yes, yes! Give it to me, [pc.master]! That's what your little slut deserves - fuck her hard and raw! Hurt me good, teach me what a bad girl I was!</i>\" Amily squeals in lustful joy, rutting as hard with you as you are with her.");
	//(if Amily is herm:
	if (amily.longestCockLength() > 0) output("  Her " + amilyCock() + " slices through the air like a fleshy knife, that stiff with blood and pleasure.");
	//(If Amily is squirter:
	if (amily.isSquirter()) output("  Although she has yet to climax, her cunt is already bubbling and frothing madly around your " + pc.cockDescript(0) + ", causing you to squelch and slurp loudly with each thrust in and out of her wet depths. She's like a pot of sexual fluids on the boil, just waiting to geyser forth. All she needs is a little more encouragement.");
	output("\n\n");

	output("You feel it's time to end this. With one last vicious thrust, you cause Amily to dig slightly into the floor and cum. Painting her walls all the way to her womb, you unload.  Even her cervix is unable to stop the torrent you unleash upon her.");
	//[(If Amily is pregnant)
	if (flags["COC.AMILY_INCUBATION"] != undefined) output("  You wonder if your unborn children will appreciate their bath. Their mother certainly does.");
	//(If not squirter:
	if (!amily.isSquirter()) output("  Her fluids slop wetly over your crotch, painting between your legs with her lubricant.");
	//(If squirter:
	else output("  A cascade of fluids pours from inside her; if you had allowed her to ride atop you, you'd be sopping with her femcum.");
	//(If Amily is herm:
	if (amily.longestCockLength() > 0) output("  It doesn't take long - seconds, at most - before her pulsing, twitching cock finally explodes, spewing gush after gush of herm-spunk all over her tits and face, which Amily eagerly laps up.");
	output("\n\n");

	output("You orgasm finally ends.");
	//[(if PC has large cum amount)
	if (pc.cumQ() >= 1000) {
		//(if Amily is not pregnant)
		if (flags["COC.AMILY_INCUBATION"] == undefined) output("  Amily's womb is so full of [pc.cumNoun] that it's bloated as if she was carrying a full litter of mousy sluts ready to birth.");
		//(else)
		else output("  Amily's belly looks ready to explode; besides the litter she's carrying, you've also filled her with enough cum to feed the little mousy sluts for week.");
	}
	output("  Spent, you slump on top of Amily.");
	//[(if PC has a pussy)
	if (pc.hasVagina()) output("  Despite being neglected during the act, your " + pc.vaginaDescript() + " leaks fluids to join Amily's on the floor.");
	output("  Amily pants loudly and sighs in satisfaction. Hesitantly, one hand dares to reach out and stroke your " + pc.face() + ". \"<i>Mmm... You are the light of my world, [pc.master].");
	//(if not pregnant:
	if (flags["COC.AMILY_INCUBATION"] == undefined) output("  I can only hope you've knocked me up, so I can do what I was made for,");
	else output("  I almost wish I wasn't pregnant, just so I could have the pleasure of knowing you've knocked me up,");
	output("</i>\" she tells you softly.\n\n");

	output("You feel like you should scold her for acting tender with you. She is your fucktoy mouse slut, not your lover. But she did do a good job of pleasuring you; so you decide to let it slide this time.\n\n");

	output("Once you've regained your breath you get up, extracting yourself from Amily's embrace. She gets up herself, a bit embarrassed by the way she acted. \"<i>Did I please you [pc.master]?</i>\" she asks, awaiting your judgement expectantly. You smile and pat her head, telling her yes; she did please you. You comment that her theatrics weren't so bad.  She smiles and replies, \"<i>Thank you [pc.master]. I loved this little play of ours... My favorite part was when I got used like a cocksleeve bitch in heat.</i>\" she says adoringly. You rub her hair and tell her she still has a job to do. Amily gasps and says, \"<i>Of course, forgive me [pc.master],</i>\", and then she begins licking your " + pc.cockDescript(0) + " clean.");
	//[(if PC has a pussy)
	if (pc.hasVagina()) output("  Once she's done with your cock she begins licking your thighs; ensuring none of your precious juices go to waste.");
	output("  Amily licks her lips after her task and looks up at you lovingly. You pat her head and dress up, before leaving the mousette to her own devices.");
	amilyPreggoChance();
	processTime(23);
	pc.orgasm();
	//dynStats("sen", -2, "cor", 2);
	pc.cor(2);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Let corrupt Amily bone you with her cock
private function corruptAmilyCampBonesPCWithHerCock():void {
	amilySprite();
	clearOutput();
	output("Your gaze sets upon Amily's cock and an idea forms in your head. You wonder how much Amily can resist her own lust... perhaps you should test this now; see if she is truly the ideal fucktoy, an obedient cumslut that lives only for your pleasure, that will follow your orders no matter what.\n\n");

	output("\"<i>Stay still, don't touch yourself and don't move.</i>\" You order Amily, she responds with an eager, \"<i>Yes [pc.master]!</i>\" You continue looking at Amily's cock, carefully admiring your work.");
	//[(if Amily has balls)
	if (amily.ballSizeRaw > 0) output("  A pair of balls hangs under Amily's shaft; as you look, you have the slightest impression that her balls became rounder, fuller...");
	output("  Amily's shaft is ");
	if (amily.longestCockLength() < 6) output("small");
	else if (amily.longestCockLength() < 9) output("average");
	else output("big");
	output("; you wonder how good Amily is at using it. Gently you touch her shaft, testing its girth and drawing a silent whimper from Amily; a small bead of pre begins forming on the tip as her cock throbs slightly. Smiling, you grab Amily's shaft, carefully teasing her tip with your thumb and feeling her pulse through her cock; as more blood is diverted towards her throbbing organ, Amily begins panting lightly; clearly you're exciting her more and more... You chuckle and look at Amily's eyes, daring her to disobey your orders. She looks back with resolve and adoration. You laugh mischievously, and clench your fist, gripping and releasing Amily's shaft rhythmically, drawing forth more pre while Amily gasps and her resolve and adoration melt into lust and desire.\n\n");

	output("\"<i>If you even dare to disobey my orders, I'll have to punish you,</i>\" you warn her, smiling as she squirms under your touch. \"<i>I-I won't [pc.master].</i>\" Amily answers, with more worry than determination. You can tell it wouldn't take much stimulation to make the mousette break; still it would be fun seeing her try, so you decide to take this slowly. You gently run the tip of your finger along the underside of Amily's shaft; her hips lift a bit trying to get you to touch more of her shaft. Immediately you chastise her.  \"<i>I told you not to move.</i>\" Amily flinches and forces herself to stay still; her body begins to sweat and she trembles with each stroke of your finger; pre-cum flowing steadily; her breathing grows laboured");
	if (amily.ballSizeRaw > 0) output(", and her balls seeingly inflate");
	output(". Amily moans; she is almost on the edge of an orgasm when you suddenly stop. Amily whimpers in frustration. \"<i>M-[pc.Master]... Please...</i>\" she begs, panting.\n\n");

	output("You smirk at her, amused. \"<i>What's wrong, Amily? You aren't going to disobey me, are you? I would so hate for you to disobey me...</i>\" You purr. Even as you speak, you stroke her shaft, gently tracing the head with the ball of your thumb, fingers dancing sensually up and down her length. \"<i>I don't want to punish you,</i>\" you tell her. \"<i>It hurts me, having to make you suffer, but it's for your own good...</i>\" You smirk and add, \"<i>By the way, you're not allowed to orgasm either.</i>\" Amily looks at you in desperation; while you watch in amusement. Amily's breathing gets a bit more regular, and you know she's no longer close to blowing. Now that is not fun at all... You blow on her cock lightly, the gentle caress of the wind and its soothing coldness shakes Amily to the core. Instantly her dick throbs, veins looking like they'll burst; her prick gets so hard, you're almost sure Amily will pop right then and there; somehow, she manages to hold back, but you can see that she is even closer now than she was earlier. You can't help the small laugh of amusement that escapes you.\n\n");

	output("\"<i>Poor little bitch... you really do live for nothing but sex, don't you?</i>\" You taunt her, swiping up a stray drop of pre with your finger and slowly taking it inside your " + pc.vaginaDescript() + ". Amily watches every little detail as it goes in. Finally, with a groan and an almost bestial scream, Amily loses her composure and pounces you.  As you hit the ground hard, you begin forming the words to scold her, but one glimpse of her eyes is enough to realize she's no longer thinking - the only things running through her head right now are fuck and breed. Amily rants and gibbers atop you, eyes blazing with unsated lust and the need, dearer to her than life itself, to fuck and breed. Her cock is as hard as an iron bar, slapping hard against your belly as she, made clumsy with her desires, struggles to position herself right to aim. She stabs clumsily against your " + pc.vaginaDescript() + "'s lips, then, finally managing to hit the correct alignment, wastes no time in driving forward with a howl, impaling herself in you to her very hilt.");
	//(Play virginity lost message if appropriate.)
	pc.cuntChange(0, amily.cockVolume(), true, true, false);
	//[(If Amily's cock area > PC's capacity)
	if (amily.cockVolume() > pc.vaginalCapacity()) output("  You growl at her rough penetration, Amily stretches you out without regards for your pleasure; you'll definitely have to punish her for this later...");
	output("\n\n", false);

	output("Amily is overwhelmed by the feeling of your " + pc.vaginaDescript() + ", and immediately goes berserk with lust. She doesn't speak, she grunts and snarls, thrusting into you as hard and fast as she can. There is nothing between you but the friction of flesh on flesh");
	//(squirter PC:
	if (pc.wetness() >= 4) output(", the sounds of your fem-lube slurping and squelching as she smears it over herself and makes it splash out onto the ground beneath you");
	//(if Amily has balls:
	if (amily.ballSizeRaw > 0) output(" and the meaty smack-smack-smack of her balls slapping against your [pc.ass]");
	output(".\n\n");

	output("You consider stopping Amily and smacking her for being a disobedient horny slut, but her desperate, clumsy thrusts do bring you some pleasure; besides, listening to you is beyond her capacity right now. She is truly possessed by her lust; you moan and laugh.  You find her desperation cute; how easy it was to reduce your cumbucket mouse into a mindless animal only capable of sex... oh! She hit a sweet spot!\n\n");

	output("Maybe Amily isn't totally lost in her own needs; when you react to her hitting a particular spot, she pauses, for a heartbeat, and then she picks up again, still rutting you as hard and wild as before, but now aiming specifically to hit that spot, to make this as good for you as she can, given her state. You can feel gobbets of pre-cum starting to spurt and gush into your depths - you don't think she'll last much longer. Amily's frantic thrusting slows considerably and she groans with the effort of each thrust.  ");
	//[(if Amily has balls)
	if (amily.ballSizeRaw > 0) output("The slapping of her balls on your ass reverberates around you.  ");
	output("The squelching noise of a wet pussy on cock grows audibly louder, heralding the coming of a final, explosive climax.  With a nearly screaming groan, Amily explodes inside you; thrusting as deep as she can, while her mouse-spunk pools inside your womb.\n\n");

	output("Amily collapses on top of you, panting and sweating; you casually say, \"<i>Is that all? First you fuck me without permission, now you would dare not finish me off?</i>\" Amily gasps and quickly extracts herself from you; she kneels and bows her head as far as it'll go while muttering a string of apologies. \"<i>Please mistress, forgive this unworthy slut. I swore to serve you and only you, yet I dared to pleasure myself instead of you.</i>\" You get up and silence her by sitting atop her and pushing her head down into the floor with one of your " + pc.feet() + ". \"<i>Silence, whore, I'm thinking about what I should do with you.</i>\" You touch yourself as you think of a suitable punishment, juice and cum slowly trickling down on top of Amily. You suddenly have an idea, but first you must take care of your needs... You get up and sit on a nearby rock, spreading your legs and order Amily. \"<i>Get up, slut. First you will pleasure me, then I will punish you. Now put that " + amilyCock() + " of yours to use.</i>\"\n\n");

	output("\"Yes, mistress.</i>\" Amily says solemnly as she gets up and makes way towards you; cock still erect and covered in your juices. She penetrates you easily, drawing a moan from both of you, then begins fucking you; Amily takes care to properly stimulate you, paying attention to the spots that bring you the most pleasure. It doesn't take long to finish you off. Your walls grip Amily's shaft, milking them while the mouse-slut moans and shoots inside you once again.");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("  Your jets of [pc.girlCum] wash down all the seed Amily spills inside you, pushing it all out around her cock and painting Amily's lower body in juice and cum.");
	output("  Slowly Amily withdraws, her cock finally beginning to shrink as she kneels subserviently before you; head down in shame and guilt at her earlier outburst.\n\n");

	output("\"<i>Fetch me a rope.</i>\" You order her; Amily quickly gets up and runs off, returning with a rope in hand. \"<i>Now kneel,</i>\" you order her once again. She does as you say and awaits her punishment patiently.");
	//[(if PC has proper feet)
	if (pc.isBiped() && pc.hasToes()) output("  You begin stroking her limp dick with your " + pc.foot() + ", ");
	//(else)
	else output("  You reach down and begin stroking her limp dick with your hands, ");
	output("slowly coaxing it into erection once again. Amily moans and you quickly command, \"<i>Silence!</i>\" The horny mouse-cunt clamps her mouth down and attempts to stifle her moans; yet she is unable to contain the grunts that escape her. Once her cock is erect and throbbing, you quickly loop the rope around it and tie it up, ensuring it'll remain erect for a while still. \"<i>Slut, you are not allowed to touch your cock until it has gone limp on its own. If you disobey me this time I assure you a far worse punishment is in store,</i>\" you say with a hint of anger. \"<i>Yes, [pc.master]. I promise this stupid cunt won't make the same mistake again.</i>\"\n\n");

	output("\"<i>Good, now clean me off,</i>\" you order her, presenting your pussy, dripping with the aftermath of your intercourse. Amily expertly licks you clean of all the jism and juice she can; by the time she's done, gobs of cum and wet patches of juice cover her face, yet your nethers are impressively clean. \"<i>Good work, bitch,</i>\" you compliment her; Amily's tail perks up and begins swaying as she smiles in happiness.  Sated, you dress up and go about your business, leaving Amily with a raging erection.  You wonder if Amily managed to knock you up with her lack of self control.");
	//[(if PC has a dick)
	if (pc.hasCock()) output("  If she did, you might have to return the favor...");
	//(else)
	else output("  If she did, you'll just have to tie her up and get someone to return the favor...");

	//Preg chanceeee
	//pc.knockUp(PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.INCUBATION_MOUSE);
	processTime(24);
	pc.loadInCunt(amily);
	pc.orgasm();
	//dynStats("sen", -2, "cor", 2);
	pc.cor(2);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//CAMP CORRUPT AMILY SEX
private function corruptAmilyBuckFutter():void {
	amilySprite();
	clearOutput();
	//[Anal - non-mutant]
	output("You order Amily to get on her hands and knees; you want to pound her ass. Amily's eyes light up in happiness and she replies excitedly, \"<i>Yes, [pc.master]</i>!\" She quickly turns around and gets in position; her full ass swaying invitingly, while her tail stands erect to give you access. Her excitement at the prospect of having her ass fucked by you is made evident by the trickles of moisture that run down her legs");
	if (amily.longestCockLength() > 0) output("; her " + amilyCock() + " stands erect, a tiny bead of pre forming on the tip as it throbs");
	output("\n\n");

	output("You undress and press your erect " + pc.cockDescript(0) + " against Amily's buttcrack, rubbing your shaft on her ass and enjoying the grip of her soft yet firm ass; beads of pre-cum begin forming and sliding down your " + pc.cockDescript(0) + ", and you order Amily, \"<i>Prepare yourself for me.</i>\" Amily complies silently until her spaded tail digs into her pussy, drawing a moan from the excited mousette as she tail-fucks herself for a bit, before pulling her juice-slickened tail out. You distance yourself to allow her access and she rubs her slick tail-tip all over her asshole, lubing it up for you; then she rubs the still-wet spade along your " + pc.cockDescript(0) + ", slickening it and massaging your shaft all at once. \"<i>That's enough,</i>\" You say; her tail immediately releases your " + pc.cockDescript(0) + " and goes back to its erect position.\n\n");

	output("You press your cockhead against Amily's throbbing ass and, with a groan, push inside. Amily moans lewdly, the pain of having her ass penetrated not even registering beyond the pleasure of the act. \"<i>Yesssss... [pc.Master], fuck your mousy slut's ass! Fuck me until my ass is gaping wide. Oh! [pc.master], I love being your fucktoy!</i>\" Amily screams in praise as you fill her insides.\n\n");

	//[(if PC is huge)
	if (pc.cockVolume(0) >= 61) output("You force as much of your shaft in as you can; until you reach a point where pushing against Amily just rocks her and your shaft won't go deeper. Amily "+(amily.hasMuzzle()?"squeaks":"squeals") +" desperately. \"<i>No, no, no! I want all of [pc.master]. Please [pc.master]! Push harder!</i>\" Amily says, gripping the floor with her "+(amily.hasFur()?"claws":"hands") +" and pushing back herself. But no matter how much you try, you're unable to drive any more of your " + pc.cockDescript(0) + " inside.");
	else {
		output("You push until your hips meet her cushiony ass ", false);
		if (pc.balls > 0) output("and your " + pc.ballsDescript() + " slap against her pussy, causing her juices to squirt all over them.");
		else output(" and draw back before violently plunging back in.  Her juices squirt all over you.");
	}
	output("\n\n");

	output("Having reached the limit, you waste no time and begin to brutally fuck the horny mousette's ass; drawing moans and screams of pleasure with each powerful movement and throb of your " + pc.cockDescript(0) + ". Amily has no reservations about letting the world know that she's enjoying her predicament; she pushes back with every thrust and pulls away with every pull.  With such a brutal fucking you have no doubt that her ass is going to be sore for a while; yet she doesn't seem to care... pleasing her [pc.master] is more important... besides, pain from such an act is pleasure for the corrupted mousette.\n\n");

	output("You slap her ass roughly, causing it to jiggle, and yell, \"<i>Tighter!</i>\" Amily complies by constricting your " + pc.cockDescript(0) + " with her ass muscles as tight as she can. In response, you up the rhythm of your thrusting. Dirty sounds of slapping complete the erotic picture, and you feel your ");
	//[(if PC has balls)
	if (pc.balls > 0) output("balls churn and your ");
	output(pc.cockDescript(0) + " throb and tense. You give one last powerful push, while Amily drives back, impaling herself with all her might; in one final perverted <b>SLAP</b>, you blow your load deep into the mousette's bowels.\n\n");

	//[(if PC has large cum amount)
	if (pc.cumQ() >= 750) output("Her belly begins filling and inflating, not stopping even as she starts to look 6 months pregnant. Her ass clenches around you, trying to prevent the massive load you're still depositing from escaping, but inevitably, a few weak jets escape from around your " + pc.cockDescript(0) + ".  ");
	output("You spill your last jets with a couple more hard thrusts and then pull out of Amily's ass.");
	//[(if PC has large cum amount)
	if (pc.cumQ() >= 1000) output("  Some cum backflows out of her ass in a jet, before she plugs herself with a hand, attempting to hold everything in.");
	else output("  Some [pc.cum] begins leaking out of her ass, before she plugs herself with a hand.");
	output("\n\n");

	output("\"<i>Finish your work,</i>\" you order the tired mousette. She spins around");
	//[(if PC has large cum amount)
	if (pc.cumQ() >= 750) output(" heavy belly jiggling along her breasts, ");
	else output(" boobs jiggling, ");
	output("as she looks at your still erect " + pc.cockDescript(0) + "; some cum still leaking from it. She licks her lips and inches her way towards you, still holding her ass closed; she begins licking the remaining cum off of your " + pc.cockDescript(0));
	//[(if PC has balls)
	if (pc.balls > 0) output(" and her spilled juices from your balls");
	output("; stopping only when you're completely clean. You pat her head and praise her, \"<i>That's a good cumdumpster.</i>\" She responds by smiling tiredly, still panting a bit, and swaying her tail in happiness. You wipe the remaining saliva off your dick on her face and dress yourself. \"<i>Don't waste a single drop, cunt,</i>\" you tell her.  You leave the tired mouse alone to recompose herself.");
	processTime(17);
	pc.orgasm();
	//dynStats("sen", -2, "cor", 1);
	pc.cor(1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Amily Female Stuff Start
//Lesbian Love Confession:
//(Replaces the Meet & Talk scene for a female PC who has gotten Amily's Affection to Moderate)
private function amilyIsTotallyALesbo():void {
	amilySprite();
	clearOutput();
	output("Strangely, you don't need to seek Amily out this time; she's waiting for you. You ask her if something is wrong, and she shakes her head... but she looks kind of embarrassed as she does so.\n\n");

	output("\"<i>There's... ah... something I want to talk about with you, [pc.name],</i>\" She finally says. \"<i>I... Well, I've never really thought of other women as being attractive before, and maybe it's just because I've been alone so long, but you've been so kind to me and it's so nice to have somebody who cares for me and well I guess what I want to say is -</i>\"\n\n");

	output("You interject, telling her to slow down and breathe, you're not going anywhere. Amily pants, then finally squeaks out, \"<i>I'm in love with you!</i>\" before her face turns bright red. Stunned, you ask her to repeat that. \"<i>I said... I'm in love with you. I... ah, forget it, who was I kidding?</i>\" She trails off, sadly, and you watch as she begins to turn around and shuffle off.");
	//Set flag that she's confessed her lesbo-live!
	flags["COC.AMILY_CONFESSED_LESBIAN"] = 1;
	processTime(3);
	clearMenu();
	addButton(0, "Stop Her", amilyLesboStopHer);
	addButton(1, "Let Her Go", amilyLesboLetHerGo);
}

//[=Stop Her=]
private function amilyLesboStopHer():void {
	amilySprite();
	clearOutput();
	output("Before she can get too far, though, your hand shoots out and clasps her shoulder. She starts to question what you're doing, but you spin her around and pull her into a tight embrace, telling her that you feel the same way. Shyly, she offers her lips to you, and you kiss them eagerly. When you seperate for breath, you ask if she wants to see what it's like with another woman. Her eyes glazed, she nods at you wordlessly and starts leading you away down the street.\n\n");
	//WHAT THE FUCK DOES THIS SCENE LEAD TO?
	flags["COC.AMILY_CONFESSED_LESBIAN"] = 2;
	processTime(3);
	clearMenu();
	addButton(0, "Next", girlyGirlMouseSex);
}

//[=Let Her Go=]
private function amilyLesboLetHerGo():void {
	amilySprite();
	clearOutput();
	/*(If player is already locked into a relationship):
	if (pc.hasStatusEffect(StatusEffects.CampMarble) >= 0 || urtaLove()) {
		output("You put a hand on her shoulder, bringing her to a stop. She looks so hopeful at you that it's almost painful, but you tell her that, while you do care for her and you like her as a friend, you're already in a relationship with somebody.\n\n", false);

		output("\"<i>Are you? ...I see. Well, I'm happy that you, at least, found somebody. I... You're still welcome to come by and talk, but I'll respect your wishes.</i>\" Amily tells you. Evidently still quite embarrassed, she apologises and then melts away into the ruins again.", false);
		//(Amily is now locked out of a relationship with the player)
	}*/
	output("You watch her go, feeling a little guilty, but you just don't swing that way. You can only hope she'll be all right.\n\n");
	//(Amily's affection drops back down to Low)
	if (flags["COC.AMILY_AFFECTION"] > 10) flags["COC.AMILY_AFFECTION"] = 10;
	processTime(1);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Amily's Surprise:
//(Replaces the Remeeting Scene for a female player has had the Lesbian Love Confession scene and gotten Amily's Affection to High)
private function amilyPostConfessionGirlRemeeting():void {
	amilySprite();
	clearOutput();
	output("Amily looks happy to see you, as usual, but shy as well. \"<i>Ah... [pc.name]... it's good to see you again.</i>\"\n\n");

	output("You agree that it is, then ask if something is the matter.\n\n");

	output("Amily scuffs the ground nervously. \"<i>It's like this... You know I love you, don't you? But that I also want - I *need* - to have children to resurrect my race?</i>\"\n\n");

	output("You nod your agreement and ask her what exactly she means.\n\n");

	output("She looks down at the ground, unable to meet your eyes, then pulls her tattered pants down to reveal something you never would have expected. A penis - a four inch long, surprisingly human-like penis, already swelling to erection. Blushing, she starts to speak, still not looking at you. \"<i>I... I thought that, if it's my idea and all, I should be the one to grow this thing... Please, I love you, I want to have children with you, can't we -</i>\"\n\n");
	if (!amily.hasCock()) amily.createCock(4, 1.2);
	processTime(3);
	clearMenu();
	addButton(0, "Accept", amilyOnGirlSurpriseBonerAcceptance);
	addButton(1, "Reject", amilyOnGirlSurpriseBonerREJECT);
}
//[=Accept=]
private function amilyOnGirlSurpriseBonerAcceptance():void {
	amilySprite();
	clearOutput();
	output("Her increasingly nervous, high-pitched tone is cut off when you press a finger to her lips, smiling affectionately at her. You tell her that you understand what she is saying and why she did this, and you're happy to be with her in that way. Putting on a saucy grin, you stage-whisper into her ear about giving her new appendage a trial-run, and she blushes bright red.\n\n");

	output("She still starts leading you away, though.");
	//TO THE SMEX yiffyiffmurrmurr!
	processTime(3);
	clearMenu();
	addButton(0, "Next", hermilyOnFemalePC);
}

//[=Reject=]
private function amilyOnGirlSurpriseBonerREJECT():void {
	amilySprite();
	clearOutput();
	output("You scowl and take a pointed step back. You cared about her because she was another woman, alone and lost in this twisted world full of horny freaks that seem to be nothing but dicks and lust; now she's turned herself into one of them? She couldn't accept the pure love that the two of you already had?\n\n");

	output("Amily stops, her new cock wilting, her expression making it quite obvious that she's heartbroken. Her head falls, tears dripping from her eyes, and she turns and runs away. You glare after her as she vanishes, sobbing, into the ruins, hoping she never comes back.");
	//no moar amily in village
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Yuri:
public function girlyGirlMouseSex():void {
	amilySprite();
	clearOutput();
	output("You take Amily by the hand and allow her to lead you to where it is she plans on having sex with you. Soon enough, through many twists and turns, you are in a makeshift bedroom in an otherwise gutted building.\n\n", false);

	//(If first time:
	if (flags["COC.AMILY_TIMES_FUCKED_FEMPC"] == undefined) output("Amily stops and lets go of your hand, blushing faintly and looking embarrassed. \"<i>So, ah... how do we do this? I... I've never been attracted to another woman before, how does sex even work between us?</i>\"\n\n");
	else output("\"<i>Remember how you had to take charge the first time?</i>\" She grins. \"<i>Care to see if you've still got it?</i>\"\n\n");


	output("You smile at her, place a hand gently under her chin, and then draw her in closely. You kiss her, deeply and warmly, not trying to force anything but letting her be drawn into it of her own accord. As she starts to kiss you back, you gently reach into her shirt and begin to caress her small, tender breasts. As you stroke and tease the sensitive flesh, rubbing a thumb enticingly around each nipple, Amily moans, and her tail suddenly wraps convulsively around your " + pc.leg() + ", making it quite clear that she's enjoying this and getting ready.\n\n");

	output("Slowly you lead her to her bedding, and it is only when she is on her back that you break off the kiss. Amily looks dazed for a few moments, and then grins at you. \"<i>Wow.</i>\" You smile in response and start to remove your [pc.gear] - Amily sees this and hurriedly starts to pull off her own tattered rags. Once the two of you are naked, you give her one last kiss before you gently sit atop her, facing backwards. You slowly lie yourself down onto her, giving you a perfect view of her pink, naked pussy, and allowing her to come face to face with your own " + pc.vaginaDescript(0) + ".\n\n");

	if (flags["COC.AMILY_TIMES_FUCKED_FEMPC"] == undefined) output("\"<i>...I'm supposed to lick you there, right?</i>\" Amily asks, hesitantly. You smirk and promptly give her own sex a long, sloppy lick of your own. She squeaks in shock and then clumsily licks you in return.\n\n");
	else output("Amily needs no instructions and plunges her tongue as deeply as it can go into your sex. You yelp in shock, which makes Amily's tail wave happily, and, grinning mischievously, you return the favor.\n\n");

	output("You stroke her pussy's walls with your tongue as slowly and as intensely as possible, even as Amily licks you in return. Her taste begins to fill your mouth, the unmistakable taste of sex and girlcum. Amily does her best to mirror your actions; when you suck playfully on her little clit, Amily sucks on your own " + pc.clitDescript() + ".  When you go faster, she goes faster, when you go slower, she goes slower.\n\n");

	output("Her juices are flowing strong and thick, now, leaving you lapping at the wetness with audible slurps. Your tongue reaches into every crevice, every fold that you can find, and Amily moans and squeaks incoherently as she savors your ministrations. Emboldened, she suddenly thrusts her "+(amily.hasMuzzle()?"muzzle":"lips") +" into your " + pc.vaginaDescript(0) + ", using her pointed nose as a phallic substitute to reach deeper and hit spots of yours that her tongue just isn't hitting strongly enough. You bite back your own squeal of pleasure, and start licking as hard as you can.\n\n");

	output("Under such mininstrations, it is no surprise that, inevitably, both of you cum, leaving each other's faces splattered with your juices. Sighing with relief, you roll off of Amily's body and lay there in her bed, breathing heavily from your exertions.\n\n");

	if (flags["COC.AMILY_TIMES_FUCKED_FEMPC"] == undefined) output("\"<i>...I didn't know it could feel so good with another woman.... But I was never attracted to women before.</i>\" Amily murmurs to herself.\n\n");
	else output("\"<i>...Does it make me a lesbian, that I love this so much? Or am I just so lonely for company that even another woman is good?</i>\" Amily asks. Then she musters the energy to shake her head. \"<i>It doesn't matter. I love you.</i>\"\n\n");

	output("Your own strength returning to you, you sit up and smile at your mousey lover before giving her a deep kiss, tasting your juices and letting her get a taste of her own. Then you redress yourself and return to your camp.");
	processTime(22);
	pc.orgasm();
	IncrementFlag("COC.AMILY_TIMES_FUCKED_FEMPC");
	IncrementFlag("COC.AMILY_FUCK_COUNTER");
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Herm Amily on Female:
public function hermilyOnFemalePC():void {
	amilySprite();
	clearOutput();
	output("Amily's efforts at leading you to a place to make love are a bit hampered by the erection tenting her pants, which she is clearly still having a bit of difficulty adjusting to. Finally, though, you have reached her current den, where you waste no time in removing your [pc.gear].\n\n");

	if (flags["COC.AMILY_HERM_TIMES_FUCKED_BY_FEMPC"] == undefined) output("\"<i>I can't believe this is actually happening... I've grown a cock and I'm about to use it on another woman.</i>\" Amily mutters to herself, though it's very evident that she likes what she sees, unable to resist staring at your " + pc.chestDesc() + " or your " + pc.vaginaDescript() + ".\n\n");
	else output("\"<i>I still can't believe that I'm burying this hot, throbbing thing in another woman's pussy... More than that, I think I'm actually starting to like it.</i>\" Amily comments to herself, staring unabashedly at your curves.\n\n");

	//(If first time & player is herm:
	if (pc.isHerm()) {
		if (flags["COC.AMILY_HERM_TIMES_FUCKED_BY_FEMPC"] == undefined) output("\"<i>How on earth did I let myself get talked into this? If you've got both a cock and a pussy, then what's wrong with you just filling me with that cock?</i>\" Amily mutters to herself. Despite her words, though, her gaze is fixed squarely on your " + pc.vaginaDescript() + ".\n\n");
		//else
		else output("\"<i>You know, it's not all bad, us both being this way... but remember that I want a turn at that, too.</i>\" She states, staring hungrily at your [pc.multiCocks].\n\n");
	}

	output("You smile at her, and indicate that she may want to remove her own clothing. Looking a bit embarrassed, Amily strips herself down, revealing her perky breasts and her straining, eager cock for your own perusal. You step close and reach out to gently stroke the hot, pulsing member, eliciting a pleased groan from the futanari mouse, which entices you to use your grip around it to lead her to the makeshift bed, where you sink down onto your back and spread your ");
	if (pc.isBiped()) output(pc.legs() + " in readiness for her.");
	else output(" [pc.vagina] in readiness for her.");
	output(" Amily kneels down in between them, easily able to tell what you want.\n\n");

	//(If first time:
	if (flags["COC.AMILY_HERM_TIMES_FUCKED_BY_FEMPC"] == undefined) output("\"<i>Er... are you really sure about this? I mean...</i>\" Amily murmurs uncertainly, until, irritated, you suddenly wrap your " + pc.legs() + " around her waist and pull her the last few inches needed to slam her dick into your needy pussy. She "+(amily.hasMuzzle()?"squeaks":"gasps") +" in shock and tries to pull out, but you still have your grip on her and pull her back, a process that repeats several times until the rhythm of it sinks in and Amily starts to thrust back and forth on her own.\n\n");
	else output("Amily grips your " + pc.hipDescript() + ", gathering her courage, and then plunges her penis into your depths. Cautiously at first, she begins to thrust herself back and forth, growing faster and harder as her resolve builds.");
	pc.cuntChange(0, amily.cockVolume(), true, true, false);
	output("\n\n");

	output("Amily's ministrations are hardly the most expert of sexual techniques you've seen in Mareth, but her intentions to make it as pleasant as possible for you are obvious, and what she lacks in expertise she makes up for in enthusiasm, "+(amily.hasMuzzle()?"squeaking":"panting") +" and moaning as the unfamiliar sensations of your " + pc.vaginaDescript() + " gripping her newfound penis fill her. You work your hardest to make it good as well, but Amily's inexperience with having a male sexual organ is evident in that she soon loses control and, with a loud "+(amily.hasMuzzle()?"squeak":"groan") +", you feel her shooting cum into your thirsty " + pc.vaginaDescript() + ". The hot fluid gushes from her futa-member, and when the last few drops have dripped from her, she collapses onto you, panting.\n\n");

	//(First time:
	if (flags["COC.AMILY_HERM_TIMES_FUCKED_BY_FEMPC"] == undefined) output("\"<i>...I had no idea it would feel like that,</i>\" she gasps softly.\n\n");
	else output("\"<i>It gets me every time when that happens. Is this what it's like for men?</i>\" she wonders.\n\n");

	output("You smile and reach up to stroke her cheek. She smiles back and reaches down to pat you on your belly.");
	//(If player is preg
	if (pc.isPregnant()) {
		if (pc.hasPregnancyOfType("CoCAmilyPregnancy"))
			output("\"<i>Boy, this is weird.  I'm a woman and I'm going to be a dad.");
		else output("\"<i>After you give birth to this baby come and see me when you're ready for mine.  This is really weird, I'm a woman and I can't wait to be a dad.");
	}
	//not preg yet!
	else {
		output("\"<i>Let's see if you'll be a mommy from this load... If not, well, I guess we'll have to try again.");
		//PREGGO CHECK HERE
	}
	output("</i>\"  Chuckling softly, you lay there and embrace your lover for a time and then, reluctantly, you get dressed and leave.");
	processTime(22);
	pc.orgasm();
	pc.loadInCunt(amily);
	IncrementFlag("COC.AMILY_HERM_TIMES_FUCKED_BY_FEMPC");
	IncrementFlag("COC.AMILY_FUCK_COUNTER");
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Player gives Birth (quest version):
public function pcBirthsAmilysKidsQuestVersion(pregSlot:int):void
{
	if (flags["COC.AMILY_FOLLOWER"] == 1 && !amilyFollower() || amilyCorrupt()) // not in a camp or corrupt
	{
		giveBirthToGenericMice(pregSlot);
		return;
	}
	
	clearOutput();

	var pData:PregnancyData = pc.pregnancyData[pregSlot] as PregnancyData;
	
	if (!pc.hasVagina(pregSlot)) {
		pc.createVagina();
		pregSlot = pc.vaginas.length - 1; // failsafe
		output("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a [pc.vagina " + pregSlot + "].");
		output("\n\n");
	}
	
	if (!pc.canLactate()) pc.boostLactation(50);
	
	amilySprite();
	
	//Add to brood size count
	StatTracking.track("coc/pregnancy/pc amily");
	//In camp version:
	if (amilyFollower()) {
		playerBirthsWifAmilyMiceInCamp(pregSlot);
		return;
	}
	
	//Quest Ending: Herm Amily Variant
	//Requirements: Player must have given birth to a litter of Amily's children at least five times before.
	if (StatTracking.getStat("coc/pregnancy/pc amily") + StatTracking.getStat("coc/pregnancy/amily") >= 5 && allowFollowers()) {
		output("You wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.\n\n");

		output("Pain shoots through you as they pull open your cervix forcefully, causing you to cry out involuntarily. At once, Amily suddenly appears, racing out from the undergrowth. \"<i>Is it time? Are you going into labor?</i>\" She asks, worry evident in her voice. Your pain is momentarily forgotten by your surprise and you ask where she came from. She snorts disdainfully at the question. \"<i>I've been shadowing you for a couple of days, now. Did you really think I'd let the mother of my children go through this alone?</i>\"\n\n");

		output("Any reply you may have been inclined to make to that is swallowed by another cry of pain as yet another contraction wrings its way through you. Amily takes your hand in hers and you cling to the lifeline of comfort it offers, thankful to not be alone for this. You can feel the first child moving out of your womb, through your cervix, down and into your " + pc.vaginaDescript() + ". Your lips part and, with a grunt, you expel the first child into Amily's waiting hand. She holds it up to you so that you can see your firstborn; it's a little mouselet");
		//(if player is female: 1 in 3 chance of it being boy, girl or herm, if player is herm, 100% chance of it being a herm)"
		output((amily.hasFur()?", naked, pink, and totally hairless":"") +". Amily helps hold it to your " + pc.breastDescript(0) + ", where it eagerly takes hold of your " + pc.nippleDescript(0) + " and starts to suckle. As it drinks, it starts to grow larger, and " + (amily.hasFur()?"fur the same color as your own hair starts to cover its body":"") +". It quickly drinks its fill and then detaches, its 'father' putting it aside, which is good, because by this time there's another baby waiting for its turn... and another... and another...\n\n");

		output("Soon, you are back to your old self again, lying down in exhaustion with Amily sitting nearby, your many rambunctious offspring already starting to walk and play around you.\n\n");

		output("\"<i>Get some rest, darling. There are things you and I need to talk about,</i>\" Amily instructs you.\n\n");

		output("You are eager to comply, though your last thought as you sink into unconsciousness is to wonder what Amily wants to talk about.");
		flags["COC.PC_PENDING_PREGGERS"] = 1;
		processTime(60 * 4 + rand(60));
		//To part 2!
		clearMenu();
		addButton(0, "Next", postBirthingEndChoices);
		return;
	}
	output("You wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.\n\n");

	output("Pain shoots through you as they pull open your cervix forcefully, causing you to cry out involuntarily. At once, Amily suddenly appears, racing out from the undergrowth. \"<i>Is it time? Are you going into labor?</i>\" She asks, worry evident in her voice. Your pain is momentarily forgotten by your surprise and you ask where she came from. She snorts disdainfully at the question. \"<i>I've been shadowing you for a couple of days, now. Did you really think I'd let the mother of my children go through this alone?</i>\"\n\n");

	output("Any reply you may have been inclined to make to that is swallowed by another cry of pain as yet another contraction wrings its way through you. Amily takes your hand in hers and you cling to the lifeline of comfort it offers, thankful to not be alone for this. You can feel the first child moving out of your womb, through your cervix, down and into your " + pc.vaginaDescript() + ". Your lips part and, with a grunt, you expel the first child into Amily's waiting hand. She holds it up to you so that you can see your firstborn; it's a little mouselet");
	//(if player is female: 1 in 3 chance of it being boy, girl or herm, if player is herm, 100% chance of it being a herm)
	output((amily.hasFur()?", naked, pink, and totally hairless":"") +". Amily helps hold it to your " + pc.chestDesc() + ", where it eagerly takes hold of your " + pc.nippleDescript(0) + " and starts to suckle. As it drinks, it starts to grow larger, and "+(amily.hasFur()?"fur the same color as your own hair starts to cover its body":"") +". It quickly drinks its fill and then detaches, its 'father' putting it aside, which is good, because by this time there's another baby waiting for its turn... and another... and another...\n\n");

	output("Soon, you are back to your old self again, lying down in exhaustion with Amily sitting nearby, your many rambunctious offspring already starting to walk and play around you.\n\n");

	output("\"<i>Look at them all. You... I never thought it would turn out this way, but you're helping my dream to come true. Thank you,</i>\" Amily tells you sincerely. You're too exhausted to keep your eyes open for long, but she promises to stay in touch and, even as you fall asleep, she's gathering up your children and taking them away.");
	
	output("\n\n");
	pc.cuntChange(0, cockVolume(60), true, true, false);
	if (pc.vaginas[pregSlot].wetnessRaw == 0) pc.vaginas[pregSlot].wetnessRaw++;
	pc.orgasm();
	
	// tou -2
	pc.slowStatGain("p", -1);
	pc.slowStatGain("r", 4);
	pc.slowStatGain("l", 1);
	// sen +0.5
	
	processTime(60 * 4 + rand(60));
}

public function giveBirthToGenericMice(pregSlot:int):void
{
	clearOutput();

	var pData:PregnancyData = pc.pregnancyData[pregSlot] as PregnancyData;
	
	if (!pc.canLactate()) pc.boostLactation(50);
	
	output("You wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.");
	
	if (!pc.hasVagina(pregSlot)) {
		pc.createVagina();
		pregSlot = pc.vaginas.length - 1; // failsafe
		output("\n\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a [pc.vagina " + pregSlot + "].");
	}
	
	output("\n\nPain shoots through you as they pull open your cervix forcefully. You grip the ground and pant and push as the pains of labor overwhelm you. You feel your hips being forceably widened by the collective mass of the creatures moving down your birth canal. You spread your legs wide, laying your head back with groans and cries of agony as little white figures begin to emerge from between the lips of your abused pussy. Large innocent eyes, even larger ears, cute little muzzles, long slender pink tails all appear as the figures emerge. Each could be no larger than six inches tall, but they seem as active and curious as if they were already developed children.");
	output("\n\nTwo emerge, then four, eight... you lose track. They swarm your body, scrambling for your chest, and take turns suckling at your nipples. Milk does their bodies good, making them grow rapidly, defining their genders as the girls grow cute little breasts and get broader hips and the boys develop their little mouse cocks and feel their balls swell. Each stops suckling when they reach two feet tall, and once every last one of them has departed your sore, abused cunt and drunk their fill of your milk, they give you a few grateful nuzzles, then run off towards the forest, leaving you alone to recover.");
	
	if (pc.milkMultiplier < 100) {
		output("\n\nYour breasts won't seem to stop dribbling milk, lactating more heavily than before.");
		pc.boostLactation(10);
	}
	
	pc.cuntChange(pregSlot, cockVolume(60), false, true, false);
	
	if (pc.vaginas[pregSlot].wetnessRaw == 0) pc.vaginas[pregSlot].wetnessRaw++;
	
	pc.orgasm();
	
	// tou -2
	pc.slowStatGain("p", -1);
	pc.slowStatGain("r", 3);
	pc.slowStatGain("l", 1);
	// sen +0.5
	
	if (pc.buttRatingRaw < 14 && rand(2) == 0) {
		if (pc.buttRatingRaw < 10) {
			pc.buttRatingRaw++;
			output("\n\nYou notice your [pc.ass] feeling larger and plumper after the ordeal.");
		}
		//Big butts grow slower!
		else if (pc.buttRatingRaw < 14 && rand(2) == 0) {
			pc.buttRatingRaw++;
			output("\n\nYou notice your ass feeling larger and plumper after the ordeal.");
		}
	}
	
	StatTracking.track("coc/pregnancy/mice", 1);
	
	processTime(4 * 60);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function postBirthingEndChoices():void {
	amilySprite();
	clearOutput();
	output("When you awake, the children are gone, and Amily has prepared something for you to eat. You eagerly start to feed yourself as Amily, looking grave, begins to speak.\n\n");

	output("\"<i>You know that this... well, this isn't how I saw my future going. I wanted a human mate to help me make pure children, to revive my race, that's true, but... I kind of always saw myself as the mother to those children. But, being the father... well, it's not so bad.</i>\" She takes your hands in hers, looking deep into your eyes. \"<i>I... I never dreamed I'd say this to ");
	//(if player is female:
	if (gender(pc) == 2) output("another woman");
	//, if player is herm:
	else output("a hermaphrodite");
	output(", but... I love you. The children, they're going to leave here now, and set up a new village somewhere else. But I... I want to stay here with you. Forever. Please, say yes.</i>\"\n\n");
	output("Do you accept her offer?");
	processTime(60 * 4 + rand(60));
	clearMenu();
	addButton(0, "Accept", acceptAmilyAsYourFemaleWaifu);
	addButton(1, "StayFriends", declineButBeFriends);
	addButton(2, "ShootDown", notInterestedInDumbshitMouseBitches);
}

//[=Accept=]
private function acceptAmilyAsYourFemaleWaifu():void {
	amilySprite();
	clearOutput();
	output("You stare at her in surprise. Then, you take hold of her hands and smile at her. You tell her that nothing would make you happier than to have her here, living with you, being with her. Amily squeaks loudly with joy and passionately embraces you, kissing you as deeply as she can. When she finally lets you go for lack of air, she takes a good long look around the camp, as if she's seeing it for the first time.\n\n");

	output("\"<i>Well, I better start moving in, huh?</i>\" she jokes. She then flops down on your sleeping roll beside you, \"<i>There we are, I'm moved in.</i>\" She grins at you, and you can't help but laugh.\n\n");

	//(Amily becomes a follower; quest is over)
	//Disable village encounters!
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	//Set amily follower flag
	flags["COC.AMILY_FOLLOWER"] = 1;
	amily.breastRows[0].breastRatingRaw = 1;
	amily.nippleLengthRatio = .3;
	amily.hipRatingRaw = 6;
	amily.buttRatingRaw = 6;
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[=Stay Friends=]
private function declineButBeFriends():void {
	amilySprite();
	clearOutput();
	output("You think about it, and then shake your head. You tell her that you do appreciate her feelings, but you're not sure the two of you are ready to make the committment that living together entails. Besides, your camp is set up to guard the portal leading back to your world; that makes it a magnet for demons. You can't imagine exposing her to the danger that moving to camp would entail for her.\n\n");

	output("Amily doesn't look entirely happy, but you assure her that you will keep coming back to see her. And when you tease at the possibility of a few more litters in your respective futures, stroking her penis through her tattered pants, she blushes but agrees to go.\n\n");
	//(Amily returns to the Ruined Village; this scene will repeat the next time the player gives birth to a litter of Amily's children)
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Shoot the bitch down!
//[=Not Interested=]
private function notInterestedInDumbshitMouseBitches():void {
	amilySprite();
	clearOutput();
	output("You stare at her coldly, and inform her that you have no interest in any kind of relationship with her on that level. You decided to let her plant her brats in you out of pity, but now that she no longer needs your womb, you have no more intention of renting it out to her.\n\n");

	output("Amily reels, heartstruck, her expression making it clear that her heart has shattered, tears rolling down her face. \"<i>I...I didn't know that was the way you felt about me. F-Fine, if that's how it is...</i>\" She bursts into sobs and runs away; you know she'll never come back.\n\n");
	//Disable village encounters, go!
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Gender Modified:
private function amilyNewGenderConfrontation():void {
	amilySprite();
	clearOutput();
	var sex:Function = null;
	//Remember old gender.
	var oldGender:Number = flags["COC.AMILY_PC_GENDER"];
	//Re-init old gender so we don't get caught in a loop!
	flags["COC.AMILY_PC_GENDER"] = gender(pc);
	//Called from mid-way through remeeting's intro!
	output("Suddenly, Amily stops and looks puzzled, her nose twitching. \"<i>Have you changed...? Yes, you have! You've been messing with some of those weird potions and things that show up here and there - you've altered your gender, haven't you?</i>\"\n\n");

	output("You nod your head and admit you have.\n\n");
	//Male tooo
	if (oldGender == 1) {
		//[Male To Female]
		if (gender(pc) == 2) {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("\"<i>Oh, great. Now what am I going to do with you? Why on earth would you stuff this up?</i>\" Amily complains. She shakes her head. \"<i>Come back later - I'm too frustrated to talk to you now.</i>\" She storms away and you decide it would be best to take her advice.\n\n");
				//(Player must now begin the Female Quest from the beginning.)
				processTime(3);
			}
			//Medium Affection:
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("\"<i>I... I... why would you do that?</i>\" Amily asks, looking hurt. \"<i>I... no, This wasn't an effort by you to hurt me, I'm sorry, I was being selfish.</i>\" She apologizes. \"<i>But... I don't know what we can do any more. I... I need time to think.</i>\" She turns and walks away, and you decide to give her what she asks for.");
				//(When next the PC encounters Amily, they will receive the "confession of love" scene.)
				processTime(3);
			}
			//High Affection:
			else {
				output("Amily looks quite upset, and then her expression changes to one of resolve. \"<i>I won't pretend to know how this happened, or to understand why you would do this voluntarily, if that was the case, but you mean too much to me to let you go over something like this.</i>\" She seizes hold of your hand, fiercely, and starts determinedly pulling you along. \"<i>Come with me!</i>\" She orders.");
				//(Amily Yuri sex scene plays.)
				processTime(5);
				clearMenu();
				addButton(0, "Next", girlyGirlMouseSex);
				return;
			}
		}
		//[Male To Herm]
		else if (pc.isHerm()) {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("\"<i>...Are you a herm, now?</i>\" She asks, sounding appalled. When you confirm it, she grimaces in disgust. \"<i>Stay away from me! You're not coming near my bed again until you're all man again!</i>\" She orders, and then storms off.\n\n");
				//(Player must now begin the Herm Quest from the beginning.)
				processTime(3);
			}
			//Medium Affection:
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("She looks intimidated. \"<i>I... I'm sorry, but I don't think I can share my bed with you, not any more. Please, find a way to become male again, then come back to me?</i>\" She pleads, then slips away.\n\n");
				//(Amily's affection score remains unchanged, but the player must make the "What's Wrong With Herms" scene.)
				processTime(3);
			}
			//High Affection:
			else {
				output("\"<i>I...</i>\" She swallows hard. \"<i>This is a great shock, I must confess, but... But I care too much to lose you. I don't care if you've got a pussy of your own, now. I still want to be with you.</i>\" She smiles at you, feebly. \"<i>So, as I was saying, what do you want to talk about?</i>\"\n\n");
				//(The player is considered as having completed the herm-specific part of Amily's quest.)
				flags["COC.AMILY_HERM_QUEST"] = 2;
				processTime(3);
			}
		}
		//[Any to Genderless]
		else {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("She looks at you in disdain. \"<i>How can you be so stupid as to completely remove all gender from yourself? Get out of my sight and don't come back until you're one gender or the other again!</i>\" She then proceeds to storm off.\n\n");
				//(Amily will repeat this scene on each remeeting until the player becomes a gender other than Genderless.)
				processTime(3);
			}
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("She shakes her head sadly. \"<i>I guess this kind of puts a kink in our relationship, doesn't it? Still, I'll always be willing to talk with you.</i>\"\n\n");
				//(The player can only Talk with Amily on each remeeting until they have become a gender other than Genderless.)
				processTime(3);
			}
			//High Affection:
			else {
				output("She looks upset and concerned - but for your sake, not hers. \"<i>I can't imagine what catastrophe robbed you like this. Please, find a way to change yourself back? Man, woman, even herm, I can't bear to see you like this... but I'll give you all the support I can.</i>\"\n\n");
				//(The player can only Talk with Amily on each remeeting until they have become a gender other than Genderless.)
				processTime(3);
			}
		}
	}
	//[Female...
	else if (oldGender == 2) {
		// to Male]
		if (gender(pc) == 1) {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("Amily looks deeply surprised. \"<i>You... you turned yourself from a woman into a man? ...For me?</i>\" She scuffs her foot at the ground in embarrassment. \"<i>I... I don't know what to say. But... will you hear me out, now that you have changed?</i>\"\n\n");
				//(Begin Male variant of Amily's quest.)
				//FEN: Increase affection!
				flags["COC.AMILY_AFFECTION"] += 15;
				//FEN: If PC has had any kids with her, set as good to go!
				if (StatTracking.getStat("coc/pregnancy/pc amily") > 0) flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
				processTime(3);
			}
			//Medium Affection:
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("She looks surprised, unsure of what to say. \"<i>I... thank you. I do feel we've grown closer, but this will make things much easier...</i>\"");
				//(Begin Male variant of Amily's quest.)
				//FEN: Increase affection!
				flags["COC.AMILY_AFFECTION"] += 5;
				//FEN: If PC has had any kids with her, set as good to go!
				if (StatTracking.getStat("coc/pregnancy/pc amily") > 0) flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
				processTime(3);
			}
			//High Affection:
			else {
				output("She looks pleased, but then adopts an exaggerated expression of irritation. \"<i>You go to all the hard work of seducing me as a woman, and now you turn into a man? Why do you put me through these things?</i>\" She heaves a similarly exaggerated sigh, then smiles again. \"<i>Ah, well, now we can start things over, can't we? Let's see what the new you is like in bed.</i>\" She makes a 'come hither' expression, then playfully starts running off into the ruins, making sure you follow her.\n\n");
				//mark as agreed to preg-quest!
				flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
				//(Play High Affection Male sex scene.)
				processTime(5);
				clearMenu();
				addButton(0, "Next", amilySexHappens);
				return;
			}
		}
		//[Female to Herm]
		else if (pc.isHerm()) {
			//Amily has no dick.
			if (!amily.hasCock()) {
				//Low Affection:
				if (flags["COC.AMILY_AFFECTION"] < 15) {
					output("She looks at you for a long time, then shakes her head in disbelief. \"<i>What woman in her right mind would grow a dick? Ah, well, get rid of the pussy, and then you and I may have something to talk about. But, for now, we'll just talk.</i>\"");
					//(Begin herm variant of Amily's quest.)
					processTime(3);
				}
				//Medium Affection:
				else if (flags["COC.AMILY_AFFECTION"] < 40) {
					output("\"<i>I... don't take this the wrong way, [pc.name], but... I'm not so sure we can be together any more while you have that. Be one thing or the other, not both.</i>\" Amily states. \"<i>But we can still talk, this time.</i>\"");
					//(Next encounter with Amily is the "Maybe Herms Aren't So Bad" scenes.)
					processTime(3);
				}
				//High Affection:
				else {
					output("She looks you up and down, swallows forcefully, then looks determined. \"<i>I... I never dreamed I would say this to a hermaphrodite, but... but I know you, and I love you. If you still want to be with me, I'll stay with you.</i>\" She gives you wry grin. \"<i>Besides, I guess this means that now you and I can have children, anyway.</i>\"");
					//(Player counts as having finished the herm variant of Amily's quest.)
					flags["COC.AMILY_HERM_QUEST"] = 2;
					processTime(3);
				}
			}
			//Amily grew a dick for you.
			else {
				output("Amily looks you up and down, blushes and says, \"<i>Did you get a little jealous of me and decide to have some fun for yourself?  I-I didn't want it to be this way, but I guess we can both repopulate my race now.  How wonderful.</i>\"");
				flags["COC.AMILY_HERM_QUEST"] = 2;
				processTime(3);
			}
		}
		//[Any to Genderless]
		else {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("She looks at you in disdain. \"<i>How can you be so stupid as to completely remove all gender from yourself? Get out of my sight and don't come back until you're one gender or the other again!</i>\" She then proceeds to storm off.\n\n");
				//(Amily will repeat this scene on each remeeting until the player becomes a gender other than Genderless.)
				processTime(3);
			}
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("She shakes her head sadly. \"<i>I guess this kind of puts a kink in our relationship, doesn't it? Still, I'll always be willing to talk with you.</i>\"\n\n");
				//(The player can only Talk with Amily on each remeeting until they have become a gender other than Genderless.)
				processTime(3);
			}
			//High Affection:
			else {
				output("She looks upset and concerned - but for your sake, not hers. \"<i>I can't imagine what catastrophe robbed you like this. Please, find a way to change yourself back? Man, woman, even herm, I can't bear to see you like this... but I'll give you all the support I can.</i>\"\n\n");
				//(The player can only Talk with Amily on each remeeting until they have become a gender other than Genderless.)
				processTime(3);
			}
		}
	}
	//Herm toooooooo
	else if (oldGender == 3) {
		//[Herm to Male]
		if (gender(pc) == 1) {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("She looks you over and smiles. \"<i>Well, now that's more like it. You and I, we need to talk...</i>\"");
				//(Begin the male variant of Amily's quest, +5 affection.)
				flags["COC.AMILY_AFFECTION"] += 5;
				//if engaged in herm-quest autoenable male quest!
				if (flags["COC.AMILY_HERM_QUEST"] == 2) flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
				processTime(3);
			}
			//Medium Affection:
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("\"<i>And here I was starting to get used to you like that... but I'm happy you made such a change for me.</i>\" She tells you, smiling.\n\n");
				flags["COC.AMILY_AFFECTION"] += 2;
				//mark as agreed to preg-quest!
				flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
				//(Use the Remeeting scene options.)
				processTime(3);
				clearMenu();
				if (pc.lust() >= 33) addButton(0, "Sex", sexWithAmily);
				else addDisabledButton(0, "Sex", "Sex", "You are not up to sex now.");
				addButton(1, "Talk", talkToAmily);
				if (sex != null) addButton(2, "Both", talkThenSexWithAmily);
				else addDisabledButton(2, "Both", "Both", "You are not up to sex now.");
				return;
			}
			//High Affection:
			else {
				 output("\"<i>I was comfortable with who you were, you didn't have to change on my account...</i>\" Amily says, clearly looking guilty. When you assure her that you did this voluntarily, she brightens up. \"<i>Well, I am happy to have you all man - so, what were you wanting to speak about?</i>\"");
				//(Use the Remeeting scene options.)
				flags["COC.AMILY_AFFECTION"] += 2;
				//mark as agreed to preg-quest!
				flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
				//(Use the Remeeting scene options.)
				processTime(3);
				clearMenu();
				if (pc.lust() >= 33) addButton(0, "Sex", sexWithAmily);
				else addDisabledButton(0, "Sex", "Sex", "You are not up to sex now.");
				addButton(1, "Talk", talkToAmily);
				if (sex != null) addButton(2, "Both", talkThenSexWithAmily);
				else addDisabledButton(2, "Both", "Both", "You are not up to sex now.");
				return;
			}
		}
		//[Herm to Female]
		else if (gender(pc) == 2) {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("\"<i>Well, I guess it's nice to see another woman around... though I could have used you as all male. So, do you want to talk?</i>\" Amily asks.\n\n");
				//(Amily gains a small amount of Affection, begin the Female variant of Amily's quest.)
				flags["COC.AMILY_AFFECTION"] += 2;
				processTime(3);
				clearMenu();
				addButton(0, "Next", talkToAmily);
				return;
			}
			//Medium Affection:
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("\"<i>You didn't need to change yourself for my sake... but, I do like having somebody who can really understand what life in this world is like.</i>\" Amily notes.");
				//(Amily's affection remains unchanged, but the quest switches to the female variant.)
				processTime(3);
			}
			//High Affection:
			else {
				output("Amily looks kind of disappointed. \"<i>I will always love you no matter who you are, but... I was kind of used to that nice cock of yours, love.</i>\" She shakes her head. \"<i>Ah, well, if it's you, then sex is sex to me.</i>\" She smiles.");
				//Set love confession to: GO!
				flags["COC.AMILY_CONFESSED_LESBIAN"] = 2;
				processTime(3);
			}
		}
		//[Any to Genderless]
		else {
			//Low Affection:
			if (flags["COC.AMILY_AFFECTION"] < 15) {
				output("She looks at you in disdain. \"<i>How can you be so stupid as to completely remove all gender from yourself? Get out of my sight and don't come back until you're one gender or the other again!</i>\" She then proceeds to storm off.\n\n");
				//(Amily will repeat this scene on each remeeting until the player becomes a gender other than Genderless.)
				processTime(3);
			}
			else if (flags["COC.AMILY_AFFECTION"] < 40) {
				output("She shakes her head sadly. \"<i>I guess this kind of puts a kink in our relationship, doesn't it? Still, I'll always be willing to talk with you.</i>\"\n\n");
				//(The player can only Talk with Amily on each remeeting until they have become a gender other than Genderless.)
				processTime(3);
			}
			//High Affection:
			else {
				output("She looks upset and concerned - but for your sake, not hers. \"<i>I can't imagine what catastrophe robbed you like this. Please, find a way to change yourself back? Man, woman, even herm, I can't bear to see you like this... but I'll give you all the support I can.</i>\"\n\n");
				//(The player can only Talk with Amily on each remeeting until they have become a gender other than Genderless.)
				processTime(3);
			}
		}
	}
	//Genderless tooo
	else {
		//[Low Affection]
		if (flags["COC.AMILY_AFFECTION"] < 15) {
			output("Amily looks at you with disdain, but you can't help but notice just a small tinge of relief at seeing you have a [pc.crotch]. \"<i>Maybe you're not that stupid after all,</i>\" mutters the mouse before she flounces off.");
			//{player normal encounter options}
		}
		//[Medium Affection]
		else if (flags["COC.AMILY_AFFECTION"] < 40) {
			output("She notices you have a [pc.crotch], and she smiles at you. \"<i>I guess this means we can continue with our task?</i>\" You nod in affirmation.  The mouse-girl nods, but turns to leave.  It seems she needs a little time to adjust to this new development.\n\n");
			//{normal encounter options}
		}
		//[High Affection]
		else {
			output("When Amily gazes upon your regained genitals, she instantly hugs you and gives you a deep kiss; ");
			if (pc.hasCock()) output("bringing [pc.eachCock] to erection");
			if (pc.hasVagina() && pc.hasCock()) output(" and ");
			if (pc.hasVagina()) output("earning a clench from your [pc.vagina]");
			output(".");
			applyDamage(new TypeCollection( { tease : 25 + pc.libido() / 10 } ), amily, pc);
			output("  \"<i>I'm so glad you've recovered a gender!</i>\"\n\nAmily turns and stalks off with a spring in her step.  Clearly she's happy, but she still needs some time to get used to it.");
			//{normal encounter options}
		}
	}
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//"Why Not Herms?" (Req medium 'like')
private function whyNotHerms():void {
	amilySprite();
	clearOutput();
	output("As you head into the ruined village to find Amily, your thoughts drift yet again to the strange conundrum that has been puzzling you. You haven't failed to realize that Amily initially seemed to want to talk to you about her plans for reviving her people, but after realizing your bi-gendered nature, she insists on dropping the subject if it ever comes up.");

	output("\n\nYou are so intent on asking her why it is that she doesn't want to talk about it that you almost walk into her.");

	output("\"<i>You looked deep in thought; what's the matter?</i>\" She asks.\n\n");

	output("You remind her of how, when you first met, she spoke of her having to take \"<i>a role</i>\" in freeing her people, and how she was about to ask you for help, but she stopped when she realized you were a hermaphrodite.\n\n");

	output("Amily looks at the ground, scuffing it idly with one pink claw. \"<i>I did, yes... The role? Well, I've been forced to realize that there just aren't any of my people left in freedom - they're all dead or slaves to the demons. If there are any out there, they're too far away for it to make any difference to me. So, I came to the decision; if I am the last of the free mice in this land, then I must take whatever steps are neccessary to restore my people. Even if it means becoming the mother of a whole new generation of them.</i>\"\n\n");

	output("You ask if that is why she was particularly interested in you being human.\n\n");

	output("\"<i>Yes. I've heard that humans are both inherently pure and very weak-seeded; if I could find a human man before the demons caught him, he would be the perfect mate to help me with that goal, because the children he fathered on me would be pure in both senses.</i>\"\n\n");

	output("Crossing your arms, you sarcastically ask what you are; chopped liver?\n\n");

	output("Amily stands up and does her best to look you in the eyes, crossing her arms as well. \"<i>You're not a man - you're a hermaphrodite. I can't lie with you - what if the babies inherit that trait?</i>\"\n\n");

	output("You ask if that wouldn't be an advantageous trait, allowing each individual to both impregnate and be impregnated and letting their population swell all the faster.\n\n");

	output("\"<i>But it's unnatural!</i>\" She barks... well, squeaks indignantly, anyway. \"<i>Women with cocks, men with cunts - before those fucking demons, you never saw creatures like that! They're not normal! I mean, you don't seem to be a bad person, but I could never have sex with someone like that!</i>\"\n\n");

	output("At that, she turns and runs off, quickly vanishing into the rubble. You choose not to pursue; it seems she's clearly not in the mood to talk about it.\n\n");
	IncrementFlag("COC.AMILY_HERM_QUEST");
	processTime(15);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//"Maybe Herms Aren't So Bad":
private function maybeHermsAintAllBadBITCH():void {
	amilySprite();
	clearOutput();
	output("Yet again, you find yourself wandering through the ruined village where Amily stalks. Not entirely sure if you want to speak to her, you turn and are about to leave when you hear the sound of a rock plinking off of a wall. Looking around, you find Amily has joined you, looking apologetic.\n\n");

	output("\"<i>I... I want to say that I'm sorry. I was a real asshole, in that conversation, but... I've seen so many others mutated into herms to become mindless fucktoys, or who could only think about sex after they became herms. I've never met somebody who had two genders and could think about anything besides pussy and dick... until I met you, anyway.</i>\"\n\n");

	output("She pointedly looks away from you, blushing slightly. \"<i>I've been thinking, about things. About us. And... well, even if you are a herm, you've been the only friend I've had in years. If you can find it in your heart to forgive me... I'd like you to be the father of my children.</i>\" She stares at you, eyes wide and hopeful. \"<i>What do you say?</i>\"\n\n");

	//[Yes]
	//[No]
	//doYesNo(beAmilysDadAsAHerm,fuckNoYouWontBeAmilysHermDaddy);
	processTime(5);
	clearMenu();
	addButton(0, "Yes", beAmilysDadAsAHerm);
	addButton(1, "No", fuckNoYouWontBeAmilysHermDaddy);
	if (amily.hasFur()) addButton(2, "No Furry", amilyNoFur);
}

//[=Yes=]
private function beAmilysDadAsAHerm():void {
	amilySprite();
	clearOutput();
	flags["COC.AMILY_HERM_QUEST"] = 2;
	output("You tell her that you'll forgive her, and you will help her breed the " + (amily.hasFur()?"free mousemorphs that she wants so badly. She looks a bit confused by you using the term 'mouse-morphs', but otherwise seems happy.":"") +" \"<i>Wonderful! Come with me!</i>\" She says, grabbing your hand and pulling you down the street.\n\n");
	//(Play out "First Sex" scene, with whatever tweaks are needed to account for the PC's hermaphroditic nature.)
	processTime(5);
	clearMenu();
	addButton(0, "Next", amilySexHappens);
}

//[=No=]
private function fuckNoYouWontBeAmilysHermDaddy():void {
	amilySprite();
	clearOutput();
	output("You scoff at her, and tell her that she called you a freak of nature, an unnatural demon-crafted thing. You have no interest in having sex with somebody who thinks of you as some kind of breeding toy.\n\n");

	output("Amily winces, looking deeply hurt. \"<i>I... You're right, what I said was unforgivable. I... think it's best that we part ways.</i>\"\n\n");

	output("Looking deeply sad, she turns and walks away, vanishing into the urban wilderness in that way only she can. Instinctively, you realize that you will never see her again.");
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	processTime(5);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Conversation: Efficiency
//(Requires: Player is a herm, player has at least one Purified Incubus Draft, chose the "Talk" or "Talk & Sex" option from the Remeeting scene, Amily is High Affection)
public function makeAmilyAHerm():void {
	amilySprite();
	clearOutput();
	output("You talk to Amily about how she and you have grown to know each other well, so well that she has been willing to have sex with you despite her aversion to hermaphrodites.\n\n");

	output("\"<i>That's true... I... I can't say I can understand what life must be like for you like that.</i>\" She admits.\n\n");

	output("You ask if she would be willing to try and see your view on things - you happen to have a vial of Incubus Draft from which the tainting elements have been removed.\n\n");

	output("She looks very nervous. \"<i>I... I mean... I don't really want to do that.</i>\"\n\n");

	output("You point out that it would be for the best for her plans; this way, the two of you will be able to bear litters simultaneously, so she can have children even faster and in greater numbers than before. Giving her a winning smile, you clasp hold of her hands gently and ask if she'll please consider doing it; for you?\n\n");

	output("Amily looks crestfallen, then finally nods her head, slowly. \"<i>I... I'm not really sure about this, but... if it's for you, [pc.name], then... I'll do it.</i>\" She takes the vial, staring at it apprehensively, then pops the cork and swallows it down quickly in a single gulp. She shudders - first in disgust at what she actually drank, then with pleasure. Moaning ecstatically, she " + (flags["COC.AMILY_INCUBATION"] <= 7 * 168 / 2 ? "lifts her shirt" : "pulls off her pants") + " to give you a full view as her clitoris swells, longer and thicker; finally, skin peels back at the tip to reveal what is unmistakably the glans of a penis, complete with a cum-gouting slit as she experiences her first male orgasm.\n\n");

	output("Amily is now a hermaphrodite. Her human-like penis is four inches long and one inch thick.\n\n");

	output("Catching her breath, she " + (flags["COC.AMILY_INCUBATION"] <= 7 * 168 / 2 ? "tries to get a look at her new member over her bulging belly. When that fails she runs her hand over it, touching it carefully while maintaining an unreadable expression. Then she stares at you and says, " : "stares at her new appendage with an unreadable expression, then she stares at you.") + " \"<i>Well, now I've got a penis... so that means you're coming with me to let me try it out!</i>\"\n\n");

	output("You agree, and allow her to begin leading you to the \"<i>bedroom</i>\".");
	if (!amily.hasCock()) amily.createCock(4, 1.2);
	pc.destroyItem(new CoCIncubiDPure());
	//[Herm Amily on Female PC, First Time, scene plays]
	processTime(8);
	clearMenu();
	addButton(0, "Next", hermilyOnFemalePC);
}

//ENHANCED CAMP FOLLOWER SHIT
//Player gives Birth (camp follower version):
private function playerBirthsWifAmilyMiceInCamp(pregSlot:int):void {
	amilySprite();
	output("You wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.\n\n");

	output("Pain shoots through you as they pull open your cervix forcefully, causing you to cry out involuntarily. At once, Amily suddenly appears, racing over from across the camp. \"<i>Is it time? Are you going into labor?</i>\" She asks, worry evident in her voice.\n\n");

	output("You grunt in affirmation with a trace of irritation; ");
	//Repeat brood
	if (StatTracking.getStat("coc/pregnancy/pc amily") > 0) output("this is hardly the first time you've given birth to her offspring before, after all");
	//First time!
	else output("she's probably just glad you're the one that has to push them all out");
	output(". However, any more detailed reply you may have been inclined to make to that is swallowed by another cry of pain as yet another contraction wrings its way through you. Amily takes your hand in hers and you cling to the lifeline of comfort it offers, thankful to not be alone for this. You can feel the first child moving out of your womb, through your cervix, down and into your " + pc.vaginaDescript() + ". Your lips part and, with a grunt, you expel the first child into Amily's waiting hand. She holds it up to you so that you can see your firstborn; it's a little mouselet" + (amily.hasFur()?", naked, pink, and totally hairless":"") +". Amily helps hold it to your " + pc.chestDesc() + ", where it eagerly takes hold of your " + pc.nippleDescript(0) + " and starts to suckle. As it drinks, it starts to grow larger" + (amily.hasFur()?", and fur the same color as your own hair starts to cover its body":"") +". It quickly drinks its fill and then detaches, its 'father' putting it aside, which is good, because by this time there's another baby waiting for its turn... and another... and another...\n\n");

	output("Soon, you are back to your old self again, lying down in exhaustion with Amily sitting nearby, your many rambunctious offspring already starting to walk and play around you. However, you notice that they are a little less large and energetic than the other times you have seen them born and grow in such a fashion.\n\n");

	output("\"<i>Because there are only trace elements of those chemicals left in our bodies, they should age normally from this point on.</i>\" Amily notes.\n\n");

	output("Worry fills you; how on earth are you going to take care of such small, defenseless creatures in a place like this? Before you can voice such concerns to Amily, though, rustling in the bushes catches your attention. As you watch, a pair of young "+(amily.hasFur()?"mouse-morphs":"mouse fellows") +" appear and walk confidently into your camp. They're two of your children, the ones who Amily told you had left the area.\n\n");

	output("\"<i>I hope you don't mind, [pc.name], but I contacted them to come and take their new siblings back with them shortly after you told me you were pregnant.</i>\" Amily says, sheepishly. \"<i>We just can't really care for them here, and they'll be safer and happier with all their siblings.</i>\"\n\n");

	output("You nod your head and admit that you agree. Once you have regained your strength, you spend some time talking with your fully adult children and playing with your overdeveloped newborns. Then, with a final wave goodbye, the "+(amily.hasFur()?"mouse-morphs":"family of mice") +" disappear into the wilderness once more.");
	
	output("\n\n");
	pc.cuntChange(0, cockVolume(60), true, true, false);
	if (pc.vaginas[pregSlot].wetnessRaw == 0) pc.vaginas[pregSlot].wetnessRaw++;
	pc.orgasm();
	
	// tou -2
	pc.slowStatGain("p", -1);
	pc.slowStatGain("r", 3);
	pc.slowStatGain("l", 1);
	// sen +0.5
	
	processTime(4 * 60 + rand(60));
}

//Amily gives Birth (camp follower version):
public function amilyPopsOutKidsInCamp():void {
	amilySprite();
	IncrementFlag("COC.AMILY_BIRTH_TOTAL");
	StatTracking.track("coc/pregnancy/amily");
	//if (prison.inPrison) return;
	//Uncorrupt
	if (flags["COC.AMILY_FOLLOWER"] == 1) {
		output("\nThe peace of your camp is suddenly disrupted by a loud squeal of distress. \"<i>[pc.name]! It's time!</i>\" Amily cries out, then shrieks again - there is no question at all in your mind that she's gone into labor.  You race over to find her squatting naked over her nest, squealing softly with exertion as her swollen abdomen visibly ripples, fluid dripping from her swollen, naked, pink vagina. She is definitely in labor.\n\n");

		output("Falling into routine, you kneel beside her, reaching out to touch her swollen middle, one hand on either side of its globular mass. You gently start to massage it, trying to relax and soothe the muscles after each time they clench and to lower the pain when they do experience another contraction. She starts to thank you, then clenches her teeth, "+(amily.hasFur()?"turns her little "+(amily.hasMuzzle()?"muzzle":"lips") +" skywards and ":"") +"hisses in pain as the strongest contraction yet hits - she's crowning! Immediately your hands dive down to hover under her vagina as a small, pink, naked, wriggling thing slips between their parted lips. The little body is surprisingly light in your hands, but it squeaks loudly as it draws its first breath.\n\n");

		output("You favor your lover with a reassuring smile, placing the baby to her breast with the practice of experience, then resume catching the next one to emerge from her.\n\n");

		output("There's definitely as many this time as there was the last time you saw her pregnant, and soon they are all resting alongside their weary mother in the nest of grasses and leaves. However, you notice that they are a little smaller and less energetic than the other times you have seen them born and grow in such a fashion.\n\n");

		output("\"<i>Because there are only trace elements of those chemicals left in my bloodstream, they developed and grew a little faster than normal, but they should age normally from this point on.</i>\" Amily notes.\n\n");

		output("Worry fills you; how on earth are you going to take care of such small, defenseless creatures in a place like this? Before you can voice such concerns to Amily, though, rustling in the bushes catches your attention. As you watch, a pair of young "+(amily.hasFur()?"mouse-morphs":"mouse fellows") +" appear and walk confidently into your camp. They're two of your children, the ones who Amily told you had left the area.\n\n");

		output("\"<i>I hope you don't mind, [pc.name], but I contacted them to come and take their new siblings back with them shortly after we confirmed I was pregnant.</i>\" Amily says, sheepishly. \"<i>We just can't really care for them here, and they'll be safer and happier with all their siblings.</i>\"\n\n");

		output("You nod your head and admit that you agree. Once you have regained your strength, you spend some time talking with your fully adult children and playing with your overdeveloped newborns. Then, with a final wave goodbye, the "+(amily.hasFur()?"mouse-morphs":"family of mice") +" disappear into the wilderness once more.");
	}
	//CORRUPT!
	else {
		//Start incest countdown timer!
		if(flags["COC.AMILY_INCEST_COUNTDOWN_TIMER"] == undefined) flags["COC.AMILY_INCEST_COUNTDOWN_TIMER"] = 30 * 24 * 60 + timeAsStamp;
		output("You decide to go and speak to your heavily-pregnant mousy slut, but as you approach the particular patch of greenery that she tends to lurk in, you find she has other things on her mind...\n\n");

		output("\"<i>Yes! Ooh, yes, yes, yes! Ah, so good - that's it, babies, stretch your momma's dirty cunt for her! Out, out, little ones; [pc.master] needs lots of new mousey sluts to worship " + pc.mf("him","her") + " like " + pc.mf("he","she") + " deserves!</i>\" Amily squeals in ecstasy, tail lashing at her surroundings like a whip and wings flapping madly. She is squatting in the clearing with her back to you, a mixture of feminine lubricant and amniotic fluid visibly pouring from her dilated cunt - she is quite evidently in labor, and loving every moment of it.");
		//(If Amily is herm:
		if (amily.hasCock()) output("  She has hold of her cock with both hands and is furiously jacking herself off, spurts of cum spilling like a fountain; then spattering onto her heaving breasts, face and belly, even though her erection refuses to die away.");
		//[If Amily has balls:
		if (amily.ballSizeRaw > 0) output("  Her testicles shake and quiver, swaying in the breeze as the pussy behind them readies itself to disgorge the life crammed into her swollen stomach above.");
		output("  Her eyes are rolled up in her head and her face is contorted into an expression of unholy orgasmic delight.\n\n");

		output("With a lewd moan, Amily pants, \"<i>Yes, it's coming! It's coming!!</i>\" Then she loses her balance and falls onto her back, her legs spreading wide; as if she wanted the whole world to see what's about to take place. And then it begins... A gush of fluids");
		//[(if Amily has a dick)
		if (amily.hasCock()) output(" followed by a spurt of cum");
		output(" signals the coming of the first mouse. The head topped with wide mousy ears appears from between Amily's stretched lips, its small hands follow in suit;");
		//[(if Amily has balls)
		if (amily.ballSizeRaw > 0) output(" it grabs Amily's balls and uses them to try and pull itself out;");
		output(" its efforts to leave its mother's leaking canal are finally paid off when a jet of fluids slicken its lower half, making its exit easier. As soon as it's out, another mousy head starts showing; Amily moans and screams her pleasure as the process repeats itself over and over.\n\n");

		output("When the last "+(amily.hasFur()?"mouse":"mouse-girl") +" is finally free of the confines of its slutty mother's cunt, they all crawl up towards their mother's breasts and each takes their turn drinking from their mother's corrupt milk. You just smile and observe; Amily's babies come in various flavors, some are girls, some are boys, and some are even both; they all share the same lewd purple "+(amily.hasFur()?"fur":"skin tone") +" of their mother; you can't help but wonder if they'll be wonderful cum-sluts like their mother. As they drink, you see the little babies grow bigger; and that's not all, you see little cocks getting bigger, balls developing, breasts expanding, pussies juicing up.  The sight fills you with joy.\n\n");

		output("Several children have their fill, but some are still in line.  \"<i>[pc.Master]...</i>\" You hear Amily call between pants and moans of delight. You give her an inquisitive look. \"<i>Can I drink from you? Your sexy fucktoy bitch needs more food to turn into delicious milk for your newly born sluts.</i>\"\n\n");

		//(if PC is genderless)
		if (gender(pc) == 0) {
			output("You tell Amily that right now you can't feed her, so she'll have to make do with what she has. Amily pouts, but carries on. You chuckle and leave her with an order. \"<i>Make sure to train them into proper sluts, Amily, then let them go so they can gain some field experience,</i>\" You say, \"<i>Yes, [pc.master].</i>\" Amily says. You turn and leave them to their own devices.");
			return;
		}

		//Herm get to pick if they want to use their pussies or dicks.
		//Should Amily drink from your cock or your pussy?
		//[=Cock=]
		if (pc.hasCock() && (gender(pc) == 1 || rand(2) == 0)) {
			output("You smile and undress, showing Amily ");
			output("your erect [pc.multiCocks]");
			if (pc.hasVagina()) output(" and [pc.vagina]");
			output("; Amily licks her lips in anticipation. You kneel above her head and let her tongue stretch out to lick the tip of your " + pc.cockDescript(0) + ", then pull it inside her maw. Even in her awkward position, she still manages to effectively blow you, working her delicious tongue in all the right places that she's become so familiar with. Amily's practiced suckles and slurps soon have you at the edge of orgasm, and in no time you cross that edge, shooting rope after rope of hot jism down Amily's eager and hungry throat.");
			//[(if PC has large cum amount)
			if (pc.cumQ() >= 500) output("  Her belly distends, but she continues drinking and suckling as efficiently as ever; making sure not to spill even a single drop of her [pc.master]' precious seed; the sight is enough to make you swell with pride at how seriously Amily takes her job; you decide to reward her with even more spunk.");
			output("\n\n");
		}
		//[=Pussy=]
		else {
			output("You smile and undress, showing Amily ");
			if (pc.hasCock()) {
				output("your erect [pc.multiCocks] and ");
			}
			output("[pc.vagina]; Amily licks her lips in anticipation. You squat above Amily, hovering over her " + (amily.hasMuzzle()?"muzzle":"face") +".");
			//[(if PC has balls)
			if (pc.balls > 0) output("  She gives your balls a teasing lick, tickling you; impatient, you tell her to get on with it before you change your mind and go fuck something else.");
			output("  Amily wastes no time and digs right into her task. Her tongue explores every cranny and nook of your " + pc.vaginaDescript() + "; it's as if she had a map of every little detail of your pleasure hole; no doubt a result of all the practice you've given her. Every once in a while her nose bumps against your " + pc.clitDescript() + ", sending shocks of pleasure running through your body and extracting a moan of pleasure from you, as you edge ever closer to orgasm.");
			//[(if PC is a squirter)
			if (pc.isSquirter()) output("  Amily has no problem dealing with the constant jets of girl-cum that spill from your pussy, in fact she does all she can to make sure you shoot as many of those as possible into her hungry maw; you're pleased to notice that not even a small drop escapes her searching tongue and slurping maw.");
			output("\n\n");
		}
		//both variations continue into this next paragraph
		output("When you're done, you realize the last of Amily's children has already had its fill.  Your children look in awe between their mother's smiling face and your saliva coated groin. As you rise to your feet and Amily rises to kneel beside you, the children eye you with reverence.\n\n");

		output("Amily nuzzles your crotch affectionately before saying, \"<i>Look [pc.master], our children are already eager to serve you.</i>\" You look down at her and she looks up at you. Then finally Amily turns to address the gathered children, \"<i>Sorry, my dears, but you're not yet ready to serve the [pc.master]. If you want some of this...</i>\" She says, nuzzling your crotch once more, \"<i>You will need to have some experience first.</i>\"  The children all look down and whine in disappointment, sad that they won't get anywhere near their mother's treasure. \"<i>Now, now, don't despair, my beautiful budding sluts. If you go out into the world, I'm sure you'll gather the experience needed to serve the [pc.master] in no time. Now give mommy a goodbye kiss.</i>\"\n\n");

		output("The mice quickly perk up and rush towards Amily, and she takes turns giving each of them a kiss; then sending each of them off towards the jungle with a playful slap on their little butts. When the last one has left, you congratulate Amily on being a good slut and giving birth to so many cute potential toys, \"<i>Thank you [pc.master]!</i>\" she says happily. Then she nuzzles your crotch once more and adds, \"<i>If [pc.master] wants to knock me up again, just say so. Your mousey cunt-slut is always ready to receive and deliver even more sluts to worship you and join your harem, my [pc.master].</i>\" You pat her head and leave to attend to other affairs.");
		pc.orgasm();
		//dynStats("cor", 3);
		pc.cor(3);
	}
	processTime(2 * 60 + rand(60));
}

//"Make Children" Lovemaking Option:
public function makeChildren():void {
	amilySprite();
	clearOutput();
	if (flags["COC.AMILY_ALLOWS_FERTILITY"] == 1) {
		output("You ask Amily if she wouldn't mind going back on her herbs for now.  The mousegirl snickers and asks, \"<i>Had enough babies huh?</i>\" before she gives you a knowing wink.  Amily assures you, \"<i>Don't worry [pc.name], we've brought more than enough life into the world.  I don't mind a break from it.</i>\"");
		flags["COC.AMILY_ALLOWS_FERTILITY"] = undefined;
	}
	else {
		output("You smile winningly at Amily, and tell her you have something a little different in mind. You want to have another litter with her.\n\n");

		output("Amily looks startled. \"<i>You want... children? More children, I mean?</i>\" She asks, hesitantly. You confirm, and she looks happy. \"<i>Thank you... If you really do want them, then I'll stop using those herbal contraceptives. Let's see what happens then...</i>\" She trills, idly tracing a circle on your chest with her little claw. She turns and leads you towards the nest, tail waving eagerly.\n\n");

		flags["COC.AMILY_ALLOWS_FERTILITY"] = 1;
	}
	processTime(2);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//[Revised Corrupt Meeting]
//Requires PC have done first meeting and be corrupt
private function meetAmilyAsACorruptAsshat():void {
	amilySprite();
	clearOutput();
	output("Curious about how Amily is holding up, you head back into the ruined village. This time, you don't bother making any secret of your presence, hoping to attract Amily's attention quicker. After all, she did say that the place is basically empty of anyone except her, and you can handle a measly Imp or Goblin.\n\n");

	if(flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) {
		//Amily is slightly pregnant
		output("Amily materializes out of the ruins, somewhat slower than usual. You can see that your efforts together have taken; an undeniable bulge pokes out of her midriff, pushing up her tattered shirt slightly and seriously straining her belt. She idly strokes it with one hand, as if confirming its presence to herself.\n\n");
	} else if(flags["COC.AMILY_INCUBATION"]) {
		//Amily is heavily pregnant
		output("It takes several minutes before Amily appears - but when you can see her, you marvel that she got to you as quickly as she did. Her stomach is hugely swollen, and one of her hands actually cradles underneath its rounded expanse as if trying to hold it up. She is pantsless, evidently no longer able to fit into them with this firm orb of a belly, and her shirt drapes loosely, barely managing to cover its upper half. Her belt, where she hangs her blowpipe and dagger, has been tied around her upper chest, between her breasts and her bulge, so she can still carry them effectively.\n\n");
	} else {
		//Amily is not pregnant
		output("It doesn't take long for Amily to materialize out of the ruins. Her blowpipe and dagger are both thrust into her belt, and she's still wearing the same tattered clothes as before.\n\n");
	}

	output("\"<i>Hey there, [pc.name], how... are you?</i>\" She trails off with a troubled expression. \"<i>You seem different...</i>\" She murmurs, studying you intently, and then she obviously comes to a sudden realization. \"<i>Have you had contact with demons!? You... This feeling... You're corrupted!</i>\" You take a step towards her, causing her to leap back. \"<i>N-No! Stay away!</i>\" She yells, hand darting towards her blowpipe. She spits a dart right at you!\n\n");

	//(if PC doesn't have the perk Evasion or Feline Flexibility)
	if (!pc.hasPerk("Flexibility") && !rangedCombatMiss(amily, pc)) {
		output("Amily's sudden reaction catches you off guard and the dart hits you; almost immediately you feel your body going stiff. Amily doesn't even wait to see if she hit you or not before running away, yelling back at you.\n\n");

		output("\"<i>Don't come near me again!  You're tainted, ruined!</i>\" Her voice is panicked, as she disappears into the ruins.\n\n");

		output("It takes almost two hours before you are able to move again, and your joints are still stiff and painful as you hobble back to camp, cursing that mouse. Maybe you should teach her not to mess with you.\n\n");

		//-(if PC's int >= 40)
		if (pc.intelligence() >= 25) output("You begin to formulate a plan, but to put this plan into motion you'll require a Lust Draft and some Goblin Ale. That damn rat is going to rue the day she denied you.\n\n");
		//-(else)
		else output("You think about some of the more interesting potions you found while exploring; perhaps you could use some of them...");
	}
	//(else)
	else {
		output("Despite Amily's fast reactions, they're no match for your trained reflexes; you bend just enough for the dart to barely graze you. Amily doesn't even wait to see if she hit you or not before running away, yelling back at you.\n\n");

		output("\"<i>Don't come near me again!  You're tainted, ruined!</i>\" Her voice is panicked, as she disappears into the ruins.\n\n");

		output("That stupid cunt; how dare she attack you after asking you to help her! So what if you are aren't so pure anymore; you're still very much capable of helping her! Maybe you should teach her not to mess with you...?\n\n");

		//-(if PC's int >= 40)
		if (pc.intelligence() >= 25) output("You begin to formulate a plan, but to put this plan into motion you'll require a Lust Draft and some Goblin Ale. That damn rat is going to rue the day she denied you.\n\n");
		//-(else)
		else output("You think about some of the more interesting potions you found while exploring; perhaps you could use some of them...");
	}
	pc.lust(25);
	//FLAG THAT THIS SHIT WENT DOWN
	flags["COC.AMILY_CORRUPT_FLIPOUT"] = 1;
	processTime(35);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Cooking the drug]
//This happens when going inside the village while at or above 25 Corruption.
//Only once.
//Potent Mixture key-item added to inventory.
//Takes 1 hour.
private function cookAmilyASnack():void {
	clearOutput();
	//[Cooking the drug - repeat]
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00169"] > 0) {
		//After raping Amily for the first time, she is commited to the path of corruption.
		//Used to get to stage 2 and 3 of corruption, for stage 4 PC only needs the correct amount of Corruption.
		//Potent Mixture key-item added to inventory.
		//Takes 1 hour.
		//(if PC doesn't have the required items)
		if (!(pc.hasItem(new CoCLustDraft()) || pc.hasItem(new CoCFuckDraft())) || !pc.hasItem(new CoCGoblinAle())) {
			output("You think about going into the Ruined Village, but you don't have the ingredients to create more of Amily's medicine. You return to your camp.");
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
			return;
		}
		//(if PC is genderless and has the ingredients.)
		else if (gender(pc) == 0) {
			output("You think about going into the Ruined Village, but without a cock or a pussy you can't complete the mixture. You return to your camp.");
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
			return;
		}
		//(else)
		else {
			output("You pick up a bowl and carefully pour the contents of the ");
			if (pc.hasItem(new CoCLustDraft())) output("Lust Draft ");
			else output("Fuck Draft ");
			output("and Goblin Ale inside, then you produce a wooden branch and begin stirring the contents until they are mixed together. Then you dip a finger and have a taste; ");
			if (pc.hasCock()) {
				output("[pc.eachCock] jumps to attention ");
				if (pc.hasVagina()) output("and ");
			}
			if (pc.hasVagina()) output("your [pc.vagina] moistens itself ");
			output("in preparation for the next step.\n\n");

			//Herms will do male variant with something extra, then play the female variant.
			//[Male]
			if (pc.hasCock()) {
				output("You begin to stroke your " + pc.cockDescript(0) + " vigorously, milking drop after drop of pre. With each stroke you think of how fun it'll be to fuck that rodent. You imagine her becoming a slut who lives only to breed and fuck; begging you to fuck her again and again, belly swollen with your offspring, swarms of her half-grown daughters clustering around and just as eager to fuck as their worthless whore of a mother... The thoughts spur you on, and soon send you over the edge; jet after jet of hot jism splatters the ground around you, painting it [pc.cumColor]. Remembering what you were going to do, you struggle to hold back one last jet; you keep holding back for far longer than you thought yourself capable, building this last jet especially for Amily's delight; the orgasmic sensations of pleasure continue rippling through you, but somehow you manage to kneel and aim yourself at the bowl. Finally you let go and dump a huge load of hot spunk into the bowl, splattering some of its contents onto the ground.");
				//[(If PC is a herm.)
				if (pc.hasVagina()) output("  Not yet fully sated, you decide that it couldn't hurt to add something 'girly' to the mixture...");
				output("\n\n");
			}
			//[Female]
			if (pc.hasVagina()) {
				output("You begin to stroke your " + pc.vaginaDescript(0) + " vigorously, pinching your clit and dripping all over the floor. Every time a new gush of fluids escapes your " + pc.vaginaDescript() + ", you think of how much fun you'll have with Amily. You'll have her lick you again and again until you pass out; perhaps you can even get her to grow a dick so the two of you can have more fun; after all, she's always going on and on about how she wants babies, well, she doesn't have to be the one carrying them does she? You imagine how it'd be to get knocked up by Amily; your belly growing big with tiny mice as Amily's reduced to a pile of fuck and breed; incapable of doing anything but begging you for a good fucking. Just imagining this is enough to push you over the edge and your juices shower on the ground below you. It feels so good that you almost forget why you began masturbating in the first place. You squat above the bowl and begin pinching and massaging your clit, trying to draw one last burst of [pc.girlCum] just for Amily; you hold back, intent on making this final orgasm extra pleasurable and extra-long. Finally you feel it hit you; you look down just in time to see your fluids splatter into the bowl; the heavy musk of sex fills the air around you, prolonging your orgasm and causing the bowl to overflow. You moan as the last of your fluids hit the bowl and overflow it.\n\n");
			}
			output("After taking a few minutes to rest you look inside the bowl; the mixture has become pinkish-white in color and it bubbles omniously. You take one of the empty bottles and fill it with as much of the mixture as you can, before putting the cork back and putting it back into your pouch. Now all you have to do is find Amily... You smile wickedly as you head back to camp.");
			//Consume items
			if (pc.hasItem(new CoCLustDraft())) pc.destroyItem(new CoCLustDraft());
			else pc.destroyItem(new CoCFuckDraft());
			pc.destroyItem(new CoCGoblinAle());
			pc.createKeyItem("Potent Mixture", 0, 0, 0, 0);
			IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00169");
		}
	}
	//First Time
	else {
		//(if PC doesn't have the required items and has >= 25 Corruption)
		if (!(pc.hasItem(new CoCLustDraft()) || pc.hasItem(new CoCFuckDraft())) || !pc.hasItem(new CoCGoblinAle())) {
			output("You think about going into the Ruined Village, but decide it's best to wait until you have a plan underway (maybe some lust draft and a goblin ale to get the ball rolling... you return to your camp.");
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
			return;
			return;
		}
		//(else if the PC is genderless)
		else if (gender(pc) == 0) {
			output("You think about going into the Ruined Village, but decide to turn back; right now, you just don't have the proper 'parts' to get the job done, and so you return to your camp.\n\n");
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
			return;
			return;
		}
		//(else)
		else {
			output("You pick up a bowl and carefully pour the contents of the ");
			if (pc.hasItem(new CoCLustDraft())) output("Lust Draft ");
			else output("Fuck Draft ");
			output("and Goblin Ale inside, then you produce a wooden branch and begin stirring the contents until they are mixed together. Slowly you dip a finger and take a experimental lick; you're almost knocked back by the strong taste, your ");
			if (pc.hasCock()) {
				output("[pc.eachCock] jumps to attention ");
				if (pc.hasVagina()) output("and ");
			}
			if (pc.hasVagina()) output("your [pc.vagina] moistens itself");
			output(".  You smile wickedly; no doubt this mixture is going to make that stupid cunt open her legs and beg for a good fucking; but you feel there's still something missing...\n\n");

			output("As you think about what could be missing your hand idly moves lower to stroke your ");
			if (pc.hasCock()) output("[pc.cock]");
			if (pc.hasCock() && pc.hasVagina()) output(" and ");
			if (pc.hasVagina()) output("[pc.vagina]");
			output("; then realization hits you. Of course! How could you forget to add some 'special sauce' to the mixture....?\n\n");

			//Herms will do male variant with something extra, then play the female variant.
			//[Male]
			if (pc.hasCock()) {
				output("You begin to stroke your " + pc.cockDescript(0) + " vigorously, milking drop after drop of pre. With each stroke you think of how fun it'll be to fuck that rodent. You imagine her becoming a slut who lives only to breed and fuck; begging you to fuck her again and again, belly swollen with your offspring, swarms of her half-grown daughters clustering around and just as eager to fuck as their worthless whore of a mother... The thoughts spur you on, and soon send you over the edge; jet after jet of hot jism splatters the ground around you, painting it white. Remembering what you were going to do, you struggle to hold back one last jet; you keep holding back for far longer than you thought yourself capable, building this last jet especially for Amily's delight; the orgasmic sensations of pleasure continue rippling through you, but somehow you manage to kneel and aim yourself at the bowl. Finally you let go and dump a huge load of [pc.cum] into the bowl, splattering some of its contents onto the ground.");
				//[(If PC is a herm.)
				if (pc.hasVagina()) output("  Not yet fully sated, you decide that it couldn't hurt to add something 'girly' to the mixture...");
				output("\n\n", false);
			}
			//[Female]
			if (pc.hasVagina()) {
				output("You begin to stroke your " + pc.vaginaDescript() + " vigorously, pinching your clit and dripping all over the floor. Every time a new gush of fluids escapes your " + pc.vaginaDescript() + ", you think of how much fun you'll have with Amily. You'll have her lick you again and again until you pass out; perhaps you can even get her to grow a dick so the two of you can have more fun; after all, she's always going on and on about how she wants babies, well, she doesn't have to be the one carrying them does she? You imagine how it'd be to get knocked up by Amily; your belly growing big with tiny mice as Amily's reduced to a pile of fuck and breed; incapable of doing anything but begging you for a good fucking. Just imagining this is enough to push you over the edge and your juices shower on the ground below you. It feels so good that you almost forget why you began masturbating in the first place. You squat above the bowl and begin pinching and massaging your clit, trying to draw one last burst of girlcum just for Amily; you hold back, intent on making this final orgasm extra pleasurable and extra-long. Finally you feel it hit you; you look down just in time to see your fluids splatter into the bowl; the heavy musk of sex fills the air around you, prolonging your orgasm and causing the bowl to overflow. You moan as the last of your fluids hit the bowl and overflow it.\n\n");
			}
			output("After taking a few minutes to rest you look inside the bowl; the mixture has become pinkish-white in color and it bubbles omniously. You take one of the empty bottles and fill it with as much of the mixture as you can, before putting the cork back and putting it back into your pouch. Now all you have to do is find Amily... You smile wickedly as you head back to camp.\n\n");
			//Consume items
			if (pc.hasItem(new CoCLustDraft())) pc.destroyItem(new CoCLustDraft());
			else pc.destroyItem(new CoCFuckDraft());
			pc.destroyItem(new CoCGoblinAle());
			pc.createKeyItem("Potent Mixture", 0, 0, 0, 0);
			IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00169");
		}
	}
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function sendCorruptCuntToFarm():void
{
	clearOutput();
	amilySprite();
	
	output("You tell your pet mouse that she is to head towards the lake, find a farm, present herself to the lady who works there and do as she says.");

	output("\n\n“<i>You’re... you’re sending me away?</i>” An expression of miserable horror dawns on Amily’s face. “<i>Have... have I done something to offend you [pc.master]? Please punish me any way you see fit, I deserve it, but please don’t take me away from your glorious person!</i>” You laugh fondly.");

	output("\n\n“<i>This isn’t a punishment, but I need you to be doing more than sitting around diddling yourself to the thought of servicing me. I’ll visit often and keep you well fed, don’t worry about that - and all that farm work will make you nice and limber for when I’m throwing you around. Go on now.</i>” Slightly mollified but still looking uncertain, Amily gets up off her knees and trundles off in the direction of the lake.");
	
	output("\n\nShe will make a hard worker for Whitney, you think, but you doubt she will be much use protection wise.");
	
	flags["COC.FOLLOWER_AT_FARM_AMILY"] = 1;
	processTime(4);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function backToCamp():void
{
	clearOutput();
	amilySprite();
	
	output("You tell her to head back to camp; there are things you need to do to her you can’t do whilst she’s here. Repeatedly. Amily bites her lip, trembling with excitement.");

	output("\n\n“<i>Immediately, [pc.master]!</i>” You watch the purple blur disappear over the hill and laugh to yourself.");
	
	flags["COC.FOLLOWER_AT_FARM_AMILY"] = undefined;
	
	processTime(5);
	//doNext(kGAMECLASS.farm.farmCorruption.rootScene);
	addButton(0, "Next", mainGameMenu);
}

private function harvestMilk():void
{
	clearOutput();
	amilySprite();
	
	output("You tell Amily that you want her hooked up to a milking machine whenever possible; you need her fluids.");

	output("\n\n“<i>You want to use me like an animal, [pc.master]? Drain my teats every day like the fuck-cow I am?</i>” Amily quivers, staining the ground beneath her with pussy juices at the thought.");
	
	if (flags["COC.FARM_UPGRADES_REFINERY"] == undefined) output("\n\n“<i>I-I’m sorry though, master. The milk I produce wouldn’t be much use to you. Talk to Mistress Whitney, maybe she can be build a machine that can concentrate it.</i>”");
	else output("\n\n“<i>It will be an honor, [pc.master]!</i>”");
	
	if (flags["COC.FARM_UPGRADES_REFINERY"] == 1) flags["COC.FOLLOWER_PRODUCTION_AMILY"] = 1;
	
	processTime(5);
	//doNext(kGAMECLASS.farm.farmCorruption.rootScene);
	addButton(0, "Next", mainGameMenu);
}

private function stopHarvestingMilk():void
{
	clearOutput();
	amilySprite();
	
	output("You tell Amily to stop producing succubus milk; you’re practically drowning in the stuff.");

output("\n\n“<i>Ooh... what a fabulous idea.</i>” Amily moans and begins to paw at her vagina. You cough deliberately before she can immerse herself entirely in the fantasy. “<i>O-of course [pc.master]. I’ll stop immediately.</i>”");
	
	flags["COC.FOLLOWER_PRODUCTION_AMILY"] = undefined;
	
	processTime(5);
	//doNext(kGAMECLASS.farm.farmCorruption.rootScene);
	addButton(0, "Next", mainGameMenu);
}

private function talkWithCORRUPTCUNT(sexAfter:Boolean = false):void {
	clearOutput();
	amilySprite();
	var convo:Number = rand(13);
	//Girls dont get to listen to amily talk about being knocked up.
	//Herms either unless she's okay'ed them for dad-hood.
	// if (gender(pc) == 2 || (pc.isHerm() && flags[kFLAGS.AMILY_HERM_QUEST] < 2)) convo = rand(12); <-- I think this is likely a copypaste issue from the original talk menu.
	//Boost affection!
	flags["COC.AMILY_AFFECTION"] += 2 + rand(3);
	pc.cor(1 / 3);
	//Conversation: Items
	if (convo == 0) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring.  From there the topic drifts to the various potions and elixirs discovered in this world.\n\n");

		output("\"<i>[pc.Master], I have some experience in alchemy, so if you wish I can share some of what I know with you,</i>\" she says.\n\n");

		//(If player has no main item:)
		//if (pc.itemSlot1.quantity == 0) {
			//output("You tell her that you'll call for her, if you ever need her knowledge.\n\n");
			//if (sexAfter) doNext(amilySexHappens);
			//else doNext(returnToCampUseOneHour);
			//return;
		//}
		////(If player has an item:)
		//else {
			//output("You remember that you have something in your pockets that might be of interest, and show it to Amily.\n\n");
		//}
		if (pc.hasItemByType(CoCEquinum)) {
			output("\"<i>That's a distillation of horse essence, I think,</i>\" Amily says. \"<i>It would probably make you stronger and tougher... Perhaps it could also give you a horse cock. Or perhaps give you a pussy as wet as mine,</i>\" she giggles. \"<i>Whatever happens, could you come test it on me?</i>\" she asks seductively.\n\n");
		}
		//Canine Pepper & Variants:
		else if (pc.hasItemByType(CoCCaninePepper) || pc.hasItemByType(CoCCaninePepperLarge) || pc.hasItemByType(CoCCaninePepperDouble) || pc.hasItemByType(CoCCaninePepperBlack) || pc.hasItemByType(CoCCaninePepperKnotty) || pc.hasItemByType(CoCCaninePepperBulby)) {
			output("\"<i>Looks kind of like a dog's dick, doesn't it? Especially this one with the big knot-like bulge or this one with the ball-like bulbs. I suppose it would make you more dog-like... Have you ever tried one of the jet-black ones?  Those look yummy...</i>\" she says, licking her lips.\n\n");
		}
		//Succubus Milk/Incubus Draft:
		else if (pc.hasItemByType(CoCIncubiD) || pc.hasItemByType(CoCSucMilk)) {
			output("She hums at the scent. \"<i>That's demon fluid, [pc.master]. It'd be like drinking liquid corruption. It could turn you into a demon, or supercharge your feminity or masculinity. I've heard it can even mess with your gender if you drink too much of the opposite stuff. But none of that is important, I'd be happy to drink from you no matter what gender you are [pc.master],</i>\" she says with a grin.\n\n");
		}
		//Succubi's Delight:
		else if (pc.hasItemByType(CoCSucDelight)) {
			output("\"<i>Full of taint, no question of that. Succubi give it to males who haven't become demons yet; makes them better able to produce cum, and pushes them towards demonhood. Why don't you try some?</i>\" she asks with a smile.\n\n");
		}
		//Wet Cloth:
		//else if (pc.itemSlot1.itype == consumables.WETCLTH) {
			//output("\"<i>Forgive your useless cumslut for her ignorance, [pc.master],</i>\" she says, looking down. \"<i>I don't really know what this is; but it looks like some sort of... concentrate of goo?  I think it's got something to do with whatever's been polluting the lake, but it does smell great, doesn't it?</i>\" she asks, smiling at you.\n\n", false);
		//}
		//Bee Honey:
		else if (pc.hasItemByType(CoCBeeHoney)) {
			output("\"<i>That is honey from a giant bee, [pc.master]!</i>\" she tells you eagerly, perking up. \"<i>Oh, that stuff's delicious!</i>\" Then she diverts her stare to you, looking at you with half-lidded eyes, idly sucking on a clawed finger. \"<i>But I prefer having your honey, [pc.master],</i>\" she says seductively, licking at her finger, a tiny strand of saliva connecting it to her mouth.\n\n");
		}
		//Pure Honey:
		else if (pc.hasItemByType(CoCBeeHoneyPure)) {
			output("\"<i>You managed to get your hands on ultra-pure giant bee honey?</i>\" she asks, sounding impressed. \"<i>I hear that stuff's so pure it can actually help purge the eater of demonic taint - but why would you want to do that?</i>\" she asks mockingly.\n\n");
		}
		//Whisker Fruit:
		if (pc.hasItemByType(CoCWhiskerFruit)) {
			output("\"<i>That's a whisker fruit,</i>\" Amily says, \"<i>It might give you cat ears and even tail! It would make you cute-looking, [pc.master],</i>\" she giggles.\n\n");
		}
		//Pigtail or Boar Truffle:
		//if (pc.itemSlot1.itype == consumables.PIGTRUF || pc.itemSlot1.itype == consumables.BOARTRU) {
			//output("\"<i>That's a pigtail truffle,</i>\" Amily says, \"<i>It might give you pig ears and even tail! It would make you plump and cute-looking, [pc.master],</i>\" she giggles.\n\n");
		//}
		//Green Glob:
		else if (pc.hasItemByType(CoCGreenGel)) {
			output("\"<i>A blob of slime from a green gel? Hmm...</i>\" She looks thoughtful. \"<i>I think I remember my dad once telling me you could make a really strong armor out of a special distillation of green oozes. Slut doesn't remember for sure, but she thinks you look better naked [pc.master]</i>,\" she says seductively.</i>\"\n\n");
		}
		//Bee Chitin:
		else if (pc.hasItemByType(CoCBlackChitin)) {
			output("\"<i>If you had a sufficient mass of this stuff, you could make a suit of armor out of it. It needs special alchemical reagents, though, otherwise it'll just get all brittle and smashed up. But why bother? That would hide your perfect body, [pc.master]</i>,\" she says seductively.\n\n");
		}
		//Spider Silk:
		else if (pc.hasItemByType(CoCToughSpiderSilk)) {
			output("\"<i>Some spider silk? I think I remember someone who could take these and make them into armor. But why bother? That would hide your perfect body, [pc.master]. Unless you want to tease me,</i>\" she says seductively.\n\n");
		}
		//Dragon Scale:
		else if (pc.hasItemByType(CoCDragonScale)) {
			output("\"<i>Dragonscale? I never knew dragons existed. They could be made into armor. But why bother? That would hide your perfect body, [pc.master]. Unless you want to tease me,</i>\" she says seductively.\n\n");
		}
		//Imp Skull:
		//else if (pc.itemSlot1.itype == useables.IMPSKLL) {
			//output("\"<i>The skull of an imp? Why would you kill imps, " + pc.mf("master", "mistress") + "?</i>\" Amily asks, frowningly, \"<i>Unless you want to keep the imps away from your camp.</i>\"\n\n");
		//}
		else {
			output("You promise that you'll keep that in mind.\n\n");
		}
		output("Satisfied, you wave her off. She pouts, disappointed that you decided to not fuck her this time; but obeys anyway.\n\n");
	}
	//Conversation: Minotaurs
	else if (convo == 1) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring. From there the topic drifts to the strange bull-men that you have seen haunting the mountains.\n\n");

		output("\"<i>It doesn't surprise me in the least you got away untouched, [pc.master],</i>\" Amily says flatteringly. \"<i>Minotaurs are dangerous brutes -  they're one of the biggest, strongest and toughest beasts around. I don't dare go near the mountains, not with those things roaming around. Sometimes they carry around huge axes, but most just make do with their fists,</i>\" she explains.\n\n");

		output("You ask her why it is that Minotaurs are so dangerous; they don't seem to look like demons.\n\n");

		output("\"<i>Oh, they may not look corrupted, but all they care about is finding something to rut with - man, woman, both, neither, they don't care. So long as it's got a hole, they'll fuck it... I think maybe I  heard somewhere that they can only reproduce by raping other creatures with a vagina now, but I don't remember where,</i>\" she says, tapping her chin in thought.\n\n");

		output("You ask her then if she has any advice on how to deal with them.\n\n");

		output("Amily laughs. \"<i>Oh, [pc.master]. I'm sure someone like you could easily take them down; me, I ran whenever I saw them. I'm not a stand-up fighter to begin with, but against those brutes? I'd be doomed!</i>\" she says; then she adds, \"<i>I think they've got some kind of addictive chemical in their cum.  The stink of their presence alone can make you feel turned on.  There was this one that managed to corner me; then it pulled out that huge horse-cock of its and starts masturbating.</i>\" One of her hands wanders towards her pussy, the memory clearly getting her turned on. \"<i>I narrowly missed getting sprayed, but the smell... it was intoxicating,</i>\" she admits, panting a bit. \"<i>My legs nearly buckled from arousal  - it was so tempting to just give in and let him fuck me.</i>\"\n\n");

		output("You ask her what she did.\n\n");

		output("\"<i>I fought it off and ran,</i>\" she says, panting and masturbating harder. \"<i>Oh, [pc.master]! Recalling all of this is making me soooo horny.</i>\" She looks at you pleadingly. \"<i>Can you fuck me? Please? Fuck your slutty mousy cumslut? Pretty please with sugar on top?</i>\" she begs, still masturbating.");
		applyDamage(new TypeCollection( { tease : 5 + pc.libido() / 20 } ), amily, pc);
		output("\n\n");

		output("You laugh and tell her you'll think about it, before leaving her to finish herself off. She just pouts and continues masturbating.\n\n");
	}
	//Conversation: Sand Witches
	else if (convo == 2) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring. From there the topic drifts to the mysterious female magic-users you've seen in the Desert.\n\n");

		output("\"<i>Sand Witches? They are human-like magic users, but they aren't truly humans, and to my knowledge they aren't demons either... Forgive me, [pc.master], but this useless fucktoy of yours doesn't know for sure,</i>\" she says, looking down. \"<i>I think that they might be some kind of druidic sect. Restoring life to the desert, trying to make it into grassland or something like that,</i>\" Amily adds.\n\n");

		output("You ask her why she would think that.\n\n");

		output("\"<i>Under those robes they're all women, they all have two pairs of breasts, and those breasts are always bloated huge with milk. I believe they've gone mad like those Fetish Cultists; they're not proper demons, but they're still sex-warped. Maybe they use milk to try and nourish seedlings?</i>\" she wonders. \"<i>Wasting all that milk by spilling it on the desert seems like such a waste... If I had huge milky orbs like those I would only offer them for you, [pc.master],</i>\" she says, smiling seductively at you.\n\n");

		output("You ask her how she found out so much about the Sand Witches. She smiles and says, \"<i>I got lost in the desert once. A Sand Witch approached me and asked me if I would let her cast a spell on me. When I refused, she attacked, trying to beat me down so she could cast it on me anyway.</i>\"\n\n");

		output("You ask her what does she think the spell would've done.\n\n");

		output("\"<i>I don't know... Maybe make me into some kind of milk-producing slave? That wouldn't do... if I became their slave I would never have been able to become your slave, [pc.master],</i>\" she responds, grinning at you.\n\n");

		output("She leans forward a bit, approaching your crotch. You smile and nod; she nuzzles your crotch affectionately, until you push her back. You ask her if she knows anything more.\n\n");

		output("\"<i>I remember the sand witch had cast some spell that made a stone orb fly up my pussy.</i>\" She closes her eyes and smiles, remembering how it felt. \"<i>It was like having a vibrating sex toy in there. It felt good... Do you want me to find something to shove up my pussy, so I can show you how it was?</i>\" she asks.\n\n");

		output("You tell her no, when you want something inside her pussy you can shove it in yourself.  \"<i>[pc.Master], you're going to make me horny saying things like that,</i>\" she says in mock embarassment. You laugh and dismiss her with a wave.\n\n");
	}
	//Conversation: Giant Bees
	else if (convo == 3) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring. From there the topic drifts to the strange bee-like women you've seen in the forest.\n\n");

		output("\"<i>Giant Bees? They're a strange, but kinky race,</i>\" Amily says. \"<i>They're not really corrupt, but sometimes they act kind of like demons.</i>\"\n\n");

		output("You ask her to explain why.\n\n");

		output("\"<i>Well... the Giant Bees you've probably seen [pc.master]... the official name for them is the fertile caste, but folks tend to just call them handmaidens,</i>\" Amily explains.\n\n");

		output("At your confused look, she continues.\n\n");

		output("\"<i>Giant Bees hatch from each egg as hundreds of regular-looking little bees.  The fertiles are involved in that - for some reason, the eggs need to incubate inside a living being to hatch in the first place.</i>\"\n\n");

		output("Your expression probably tells the story, because Amily giggles slightly before adding, \"<i>It's not dangerous or anything like that! The queen and the handmaidens both have this cock-like appendage on their abdomens; the queen uses this to lay her eggs into the handmaiden's, filling up their abdomens, while the handmaiden then lays a mixture of eggs and honey into a person's gut through their ass. The eggs kind of... well, they sit there, and then, when they're ready to hatch, they just... come out.</i>\"\n\n");

		output("She shrugs, clearly not able to explain it any better than that. You ask how you can avoid such a fate.\n\n");

		output("\"<i>Well [pc.master], they mainly use this hypnotic thrumming from their wings; but someone as sharp and wise as you should have no problem shrugging it off. They aren't the kind to get violent; they will ask you to accept their eggs, if you resist their hypnosis, but they won't try to beat you into submission so they can lay their eggs. I wouldn't ever fight them; they're quick and pretty tough, thanks to that armor, and they've got this strange venom that saps your strength and arouses you at the same time. But I'm sure you wouldn't have any problems dealing with them [pc.master]. If you ever fight one, get some of their honey; and if you get dirty while doing it, I'd be happy to give you a tongue bath until you're clean,</i>\" Amily says, slowly licking her lips from side to side.\n\n");

		output("Curious, you ask how she knows so much about these creatures.\n\n");

		output("Amily grins. \"<i>Well, they have been willing to trade honey in the past if you confront them peacefully... So I let them fill my ass with their eggs,</i>\" she explains. \"<i>If you want to [pc.master]. I'd be happy to get my ass stuffed with whatever you want,</i>\" Amily adds, smiling while some of her juice running down her legs.\n\n");

		output("You smile and tell her you'll stuff her ass later. \"<i>Thank you, [pc.master],</i>\" she says, smiling. You dismiss her with a wave.\n\n");
	}
	//Conversation: Fetish Cultists & Zealouts
	else if (convo == 4) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring. From there the topic drifts to the bizarrely-dressed people you've caught glimpses of around the lake.\n\n");

		output("Amily looks down to the floor and says, \"<i>Forgive your ignorant juice slave, [pc.master]. I haven't had much contact with them so I can't tell you much. It looks like they have some weird magic that lets them change their clothes at random.</i>\"\n\n");

		output("\"<i>If you want [pc.master], I could dress up for you, I'd love to wear any kind of kinky wear you would give me. Even if it was just ropes for tying me down.</i>\" Amily adds, smiling.\n\n");

		output("You tell her you'll think about it, before dismissing her with a wave.\n\n");
	}
	//Conversation: Imps
	else if (convo == 5) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring. From there the topic drifts to the small demons you've seen in your travels.\n\n");

		output("\"<i>Imps,</i>\" Amily says. \"<i>They're weak and small, easy to cut down. They're also all over the place, looking to rape anything they can get their hands on; they can also use some black magic to get you horny. I used to kill them all the time, but there was always more.</i>\" Amily smiles a bit. \"<i>They have big cocks as well, I wouldn't mind having a cock that big inside me,</i>\" She says, her eyes slowly moving towards your crotch.\n\n");

		//[(if PC has a dick < 24 area)
		if (pc.hasCock() && pc.biggestCockLength() < 12) output("\"<i>[pc.Master], can you grow a bigger cock to fuck your loyal cumdumpster?</i>\"");
		//(else if PC has a dick >= 24 area)
		else if (pc.hasCock()) output("\"<i>[pc.Master] I'm so horny, can you take your huge cock and jam it into your slutty mouse slave?</i>\"");
		//(else)
		else output("\"<i>[pc.Master], can you grow a huge dick to fuck your needy cumslut?</i>\"");
		output(" Amily asks, rubbing her thighs together while moisture leaks from her sex.\n\n");

		output("You smile and say you'll think about it, then you dismiss her with a wave.");
	}
	//Conversation: Shark Girls
	else if (convo == 6) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring. From there the topic drifts to the humanoid female sharks you've seen while rowing your boat.\n\n");

		output("\"<i>Those are Shark Girls, [pc.master]. I think they used to be a village of humans who lived on the lake... then the lake was contaminated, and they all turned into the lovely sharks they are now,</i>\" Amily says with a smile.\n\n");

		if (!izmaFollower()) output("Amily looks pensive, trying to recall something. \"<i>I don't think they have any males left, but on very rare occasions I've seen these weird tiger-striped Shark Girls.</i>\" Her tail begins moving from side to side, moisture beginning to drip from her. \"<i>They have these huge cock and huge balls, and the only thing they care about is fighting and fucking. I think both things are the same for them,</i>\" she says, panting a bit.\n\n");

		output("She looks at you with lust-filled eyes. \"<i>[pc.Master], let's fuck like them; spank me, hit me and then fuck me. Cum all over me, make me feel like the cumslut that I am,</i>\" she begs, openly panting.");
		applyDamage(new TypeCollection( { tease : 5 + pc.libido() / 20 } ), amily, pc);
		output("\n\n");

		output("You smile and tell her that you'll call for her when you want to fuck her. You dismiss her with a wave, and she begins masturbating.\n\n");
	}
	//Conversation: Goblins
	else if (convo == 7) {
		output("You decide to talk to Amily about the adventures she's had when she was still adventuring.  From there the topic drifts to the strange green women you've seen in the forest and the mountains.\n\n");

		output("\"<i>Ah, Goblins,</i>\" Amily says, nodding her head in approval. \"<i>They used to just experiment with potions and build machines. But now all they do is fuck... a much needed improvement if you ask me. They actively seek to get pregnant, giving birth is like the biggest, most prolonged orgasm to them.</i>\"\n\n");

		output("Amily bites her lower lip, looking away sheepishly. You ask her what's up.\n\n");

		output("She looks to you pleadingly and says, \"<i>I love getting knocked up too, [pc.master]. I could birth you many mice to worship you like you deserve; and then we could all fuck. Oh, [pc.master]!");
		//[(if Amily's pregnant)
		if (flags["COC.AMILY_INCUBATION"] != undefined) output("  I can't wait to give birth to this batch of mice, just so I can get pregnant again.");
		//(else)
		else output("  Can you please knock me up? I don't care how, just order me to fuck until I get pregnant.");
		output("</i>\"");
		applyDamage(new TypeCollection( { tease : 5 + pc.libido() / 20 } ), amily, pc);
		output("\n\n");

		output("You step closer and pat her head approvingly, telling her she's a good girl. Amily takes the opportunity to nuzzle your crotch affectionately. Then you dismiss her with a wave.\n\n");
	}
	//Conversation: What was life in her village like?
	else if (convo == 8) {
		output("You decide to amuse yourself and ask Amily about her past. She rolls her eyes as if just the idea of breaching the subject was boring, but a quick glare puts her back in her place. \"<i>Umm... As you wish, [pc.master],</i>\" she replies meekly.\n\n");

		output("\"<i>I don't really know why you are insterested in my past, [pc.master]. What matters now is that I'm your slutty pet mouse, is it not?</i>\" she asks. You say yes, but it'd be amusing to know more about who she was. She smiles. \"<i>Very well, [pc.master]. I'll do my best to entertain you. Is there anything in particular you wish to know?</i>\"\n\n");

		output("You rack your brains for a few moments, then ask her to tell you what life was like in her village.\n\n");

		output("\"<i>That is... Quite a boring subject [pc.master]. But since you asked I'll tell you,</i>\" she says; then stops to think for a while. \"<i>It was a long time ago, but I can still remember like it was yesterday. The demons had already been around for a few years by the time I remember - I think I was born maybe shortly after they first appeared. In fact, I haven't celebrated my Day of First Breath in so long I don't really know how old I am. Not that it would matter, I'd much rather celebrate the day I became your personal cumbucket, [pc.master]. Preferably with a nice load of cum,</i>\" she says, smiling seductively. Then she carries on, \"<i>Anyways, we had all that small village stuff. We fished in the lake, went swimming and sailed boats, gathered fruits and nuts and berries and mushrooms from the forest, we hunted birds and small game for meat. It was peaceful, really... But it was also boring... So boring... Everyone was a prude in the village and sex out in the open would get treated as some kind of taboo. It's moronic really,</i>\" Amily says, rolling her eyes.\n\n");

		output("\"<i>Fools... That's what we were.  We were fools living a fool's life. Back them the only thing that got inside the village was imps, and we, like the fools we were, believed we were safe. Haha, I feel like laughing, just remembering all this. It's no wonder my village fell the way it did... And I don't miss it; not for one instant. I'm much too happy here as your loyal cumslut, [pc.master]. You saved me from a boring life as a villager, so I could live a glorious existence as a cumdumpster for you... Thank you, [pc.master],</i>\" Amily says, smiling at you adoringly.\n\n");

		output("You approach her and pat her head, allowing her to nuzzle your crotch lovingly. You tell her not to worry; you will fuck her much more in the future. \"<i>Cum-pet can't wait for that, [pc.master],</i>\" she replies. You dismiss her with a wave.\n\n");
	}
	//Conversation: Who was she before it was all lost?
	else if (convo == 9) {
		output("You decide to amuse yourself and ask Amily about her past. She rolls her eyes as if just the idea of breaching the subject was boring, but a quick glare puts her back in her place. \"<i>Umm... As you wish, [pc.master],</i>\" She replies meekly.\n\n");

		output("\"<i>I don't really know why you are insterested in my past, [pc.master]. What matters now is that I'm your slutty pet mouse, is it not?</i>\" she asks. You say yes, but it'd be amusing to know more about who she was. She smiles and asks, \"<i>Very well, [pc.master]. I'll do my best to entertain you. Is there anything in particular you wish to know?</i>\"\n\n");

		output("You rack your brains for a few moments, then ask her to tell about herself, about who she was, before she became your sex slave.\n\n");

		output("\"<i>Who was I? Well, [pc.master]... Before you saved me, I was nobody, really. Just an average little girl, a face in the crowd. My father was an alchemist; he made a lot of his money in those days working to purify items that were tainted in some fashion, but his primary goal was trying to come up with a concoction that could actually help purify someone who had been tainted already. What a fool; It's no wonder he never did succeed,</i>\" Amily mocks.\n\n");

		output("You ask her what was her relationship with her father was like.\n\n");

		output("\"<i>At first... I cared. He was busy all the time with his alchemical experiments, so I tried to take an interest in learning alchemy; it was a way to get closer to him, but it never really interested me that much,</i>\" she says, nonchalantly. \"<i>I was closer to my mom than my dad, I guess.</i>\"\n\n");

		output("You ask her to tell you about her mother.\n\n");

		output("\"<i>She was a hunter, one of the best I think... Quick enough to run a deer to ground, quiet enough that it wouldn't know she was there until her knife was at its throat, skilled enough with a blowpipe to pin a fly to a tree from fifty paces without killing it,</i>\" Amily says, not without a hint of pride. \"<i>Of course, in the end that didn't help her at all. I mean... She taught me all she knew, and people used to say I was going to be just like her when I grew up; yet, I got caught. Thankfully it was you who caught me, [pc.master]. I couldn't imagine myself as anyone else's sexy mouse pet fucktoy. I love you, [pc.master]!</i>\" she suddenly exclaims, throwing herself at you, hugging your waist and nuzzling your crotch affectionately.\n\n");

		output("You pat her head, and then push her away. She settles herself back on her knees. \"<i>Sorry about that, [pc.master],</i>\" she says, a bit ashamed of her little outburst.  You ask her what the fate of her parents was.\n\n");

		output("\"<i>Who knows? Probably got caught by some inferior demon and made to be their slaves,</i>\" she says shrugging. \"<i>I'm just happy I got caught by a good [pc.master].</i>\" She smiles. You smile back and dismiss her with a wave.\n\n");
	}
	//Conversation: How did it fall?
	else if (convo == 10) {
		output("You decide to amuse yourself and ask Amily about her past. She rolls her eyes as if just the idea of breaching the subject was boring, but a quick glare puts her back in her place. \"<i>Umm... As you wish, [pc.master],</i>\" she replies meekly.\n\n");

		output("\"<i>I don't really know why you are interested in my past, [pc.master]. What matters now is that I'm your slutty pet mouse, is it not?</i>\" she asks. You say yes, but it'd be amusing to know more about who she was. She smiles. \"<i>Very well, [pc.master]. I'll do my best to entertain you. Is there anything in particular you wish to know?</i>\"\n\n");

		output("You rack your brains for a few moments, then ask her to tell you how her village was destroyed.\n\n");

		output("She closes her eyes and rubs her chin, attempting to recall every little detail of the attack. \"<i>It was the evening of a festival... Everyone was in the town square celebrating something stupid like the years harvest. Typical country mouse stuff,</i>\" Amily says with disdain. \"<i>Anyways; the demons managed to break in through the gate and over the walls. It's kind of stupid if you think about it [pc.master]. Demons have wings... Who is the genius that thought walls would hold them back?</i>\" Amily mocks. \"<i>And you know what's even more funny? We had sentries, but those fools were at the festival too!</i>\" Amily bursts out laughing. You chuckle and tell her to carry on.\n\n");

		output("\"<i>I remember seeing a lot of different demons... From imps to succubi and incubi.  We were powerless to defend ourselves. Unarmed and caught by surprise; we scattered about like the scared little field mice we were,</i>\" Amily continues, then looks up to you adoringly. \"<i>I'm sure you'd never make such a naive mistake [pc.master].</i>\" You smile back and pat her head lightly. \"<i>The demons only had to pick us out one by one. The smarter ones just surrendered on the spot and let the demons have their way with them; some of the more foolish tried fighting back. Me? I ran away. But it was kind of stupid in hindsight... I could have joined that wonderful orgy of cocks, cunts and cum,</i>\" Amily says dreamily, looking in the distance; but then her eyes quickly focus on yours and she grins.\n\n");

		output("\"<i>Of course... That would mean I wouldn't have been picked by the best of the lot.</i>\" Amily hugs your waist and looks up at you adoringly. \"<i>I'm so glad it's you who got me, [pc.master],</i>\" she says, lightly nuzzling your crotch. You smile at her and pat her on her head. You tell her that later you'll see about reenacting the invasion of her village, only this time she'll get caught. Amily lights up and giddily says, \"<i>I can't wait for it [pc.master]!</i>\" You chuckle and leave her to her own devices.\n\n");
	}
	//Conversation: How did she survive?
	else if (convo == 11) {
		output("You decide to amuse yourself and ask Amily about her past. She rolls her eyes as if just the idea of breaching the subject was boring, but a quick glare puts her back in her place. \"<i>Umm... As you wish, [pc.master],</i>\" she replies meekly.\n\n");

		output("\"<i>I don't really know why you are interested in my past, [pc.master]. What matters now is that I'm your slutty pet mouse, is it not?</i>\" she asks. You say yes, but it'd be amusing to know more about who she was. She smiles, \"<i>Very well, [pc.master]. I'll do my best to entertain you. Is there anything in particular you wish to know?</i>\"\n\n");

		output("You rack your brains for a few moments, then ask her to tell you how she survived all alone in her village.\n\n");

		output("\"<i>Well [pc.master]... I ran as fast as I could to my house. I wanted to get my hunting knife and blowpipe. Useless tools... But back then I was a fool too,</i>\" she explains. \"<i>Then my parents showed up and told me to run. I didn't want to, but I obeyed... I was so scared... Don't know why, though? It's just sex... Wonderful, sweaty, slimy, creamy sex,</i>\" she says dreamily, licking her lips and shooting you a seductive grin. You tell her that you'll think about some way to reward her later. \"<i>I kept running as fast as I could, until I couldn't run anymore; then I hid and stayed hidden through the whole night. I only woke up in the morning, and I was ravenous, so I foraged something to eat and went back to the village. That's when I saw it was in ruins... I was lost and my life was in shambles... Thankfully, you eventually showed up to save me and pick up the pieces, [pc.master],</i>\" she says adoringly.\n\n");

		output("You ask her what about her day-to-day? What was her routine?\n\n");

		output("\"<i>Boring.</i>\" she says rolling her eyes. \"<i>I prefer my new routine; I get to have wonderful sex with my [pc.master] and drink a lot of cum. It's all a girl could ask for,</i>\" she says, smiling at you. \"<i>Anyways... I had enough knowledge to know what I could eat or not... I also salvaged some alchemy stuff to make poison darts, I was pretty weak before you gave me this delicious body, [pc.master],</i>\" she continues, caressing her breasts for effect. You scold her, telling her she's not supposed to pleasure herself without permission. Amily quickly apologizes; you pat her head and tell her it's fine, you'll punish her later. \"<i>Thank you, [pc.master],</i>\" She replies with a grin. \"<i>Other than that I only hid, hunted, foraged, ate and slept; that's all.</i>\"\n\n");

		output("Satisfied for the moment, you dismiss her with a wave and tell her you'll call for her when its time for her punishment. Amily excuses herself and leaves with a smile, pussy dripping");
		//[(if Amily has a dick)
		if (amily.hasCock()) output(", and cock hardening");
		output(" with excitement.\n\n");
	}
	else if (convo == 12) {
		//[Corrupted Amily talks about Kitsune]
		output( "You decide to talk to Amily about the adventures she had when she was still adventuring, and from there the topic drifts to the odd many-tailed fox women you've seen deep in the woods.\n\n");
		output("\"<i>They're weird,</i>\" she says, touching her chin absently as she thinks.\n\n");
		output("You ask her what she means by this.\n\n");

		output("\"<i>Well, they're not exactly demons, I guess, but they do have some similarities.  For some reason, they're really resistant to being corrupted, though,</i>\" she says, frowning slightly.  \"<i>I'm sure you'd have no problems doing it though, [pc.master].  From the tales I've heard, they were already like that waaay before the demons came along,</i>\" she explains.  You take a moment to think about this, and then gesture for her to continue.  \"<i>Their magic is like... really strong.  I'm sure someone as great as you wouldn't have any problems dealing with it though,</i>\" she says in a deeply flattering tone.  \"<i>I think they get their power from living things.  They can get it in lots of ways, but I guess their favorite way is through fucking,</i>\" she says, drooling a little.  \"<i>Mmm... Just thinking about it is making me wanna fuck.</i>\"\n\n");

		output("You chuckle a little, telling the mouse-slut to continue her story.  You'll come to her for a fuck later if you feel like it.  She looks a little disappointed, but obediently continues.\n\n");

		output("\"<i>They're not very strong, but they don't have to be – they try to trap you in their illusions and trick you into doing what they want.  You're too smart to fall for that though, " + pc.mf( "master", "mistress") + ".  They're not really evil...  just WAY irritating. Most of the time...</i>\" she trails off a bit.\n\n");

		output("You raise an eyebrow, chastising her a little for holding back details.  She shrinks a bit at your admonishment, but happily nods and continues.\n\n");

		output("\"<i>W-well... I've never seen one face-to-face, but I've heard some other travelers tell stories about meeting corrupted kitsune.  Most kitsune just spend the whole day playing stupid pranks on whatever fools wander into their territory.  They seem to get off on their own stupid sense of humor, but the worst that ever happens is just stuff like getting you lost in the woods or you find some kind of treasure that ends up being a box of rocks when you get home.  The dumb bitches don't have the brains for anything else, I guess.  The corrupted ones though... they know how to have a good time!  Once they finish tormenting their victims, they'll suck the life right out of them without a moment's hesitation.</i>\"\n\n");

		output("You ask how anyone knows this much about them, if even meeting one is so dangerous.  Amily scratches her head a bit and blushes, apologizing profusely.  \"<i>Please forgive your ignorant mouse-slut, [pc.master], I'm only repeating what I've heard.</i>\"\n\n");

		output("She pauses for a moment, and then speaks up with another interesting fact in an attempt to please you.  \"<i>They do seem to have a strange fascination with tentacle beasts, for some reason.  Oooh just thinking about it gets me so horny!  Please [pc.master], fuck me?  Please, oh please!</i>\"\n\n");

		output("You chuckle a little and tell her you'll think about it.  As you leave, she begins to masturbate, no doubt fantasizing about being used by a tentacle beast.");
	}
	processTime(10 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}


//(Winning Messages)
public function conquerThatMouseBitch():void {
	amilySprite();
	clearOutput();
	//By HP:
	if (enemy.HP() <= 1) output("Amily falls on the ground, unconscious. You drag the mousette towards an empty spot in her hideout. You smile as you strip her clothes off, then you find a rope to tie her up. You tie her hands together, then tie her hands to her ankles, ensuring she won't be able to fight you back. After that, you dispose of anything that could be used as a weapon, or could aid her in her escape, then sit down on a nearby stool to wait until she's recovered her consciousness. After all, it's much more fun if she's awake to see everything you'll do to her...\n\n");
	//By Lust:
	else output("Amily lets go of her knife and begins masturbating in earnest, too horny to fight. You walk up to her, pick up one of her darts and stab her, knocking her out. You drag the mousette towards an empty spot in her hideout. You smile as you strip her clothes off, then you find a rope to tie her up. You tie her hands together, then tie her hands to her ankles, ensuring she won't be able to fight you back. After that you dispose of anything that could be used as a weapon, or could aid her in her escape, then sit down on a nearby stool to wait until she's recovered her consciousness.  After all, it's much more fun if she's awake to see everything you'll do to her...\n\n");
	//Amily gives XP and Gems normally; but you have no option, you always rape her.
	chooseYourAmilyRape();
}

private function chooseYourAmilyRape():void {
	amilySprite();
	clearMenu();
	if (flags["COC.UNKNOWN_FLAG_NUMBER_00170"] == undefined) {
		addButton(0, "Next", rapeCorruptAmily1);
	}
	//2nd rape scene
	else if (flags["COC.UNKNOWN_FLAG_NUMBER_00170"] == 1) {
		if (pc.hasCock()) addButton(0, "MaleFocus", rapeCorruptAmily2Male);
		else addDisabledButton(0, "MaleFocus", "MaleFocus", "This scene requires you to have cock.");
		if (pc.hasVagina()) addButton(1, "FemaleFocus", rapeCorruptAmily2Female);
		else addDisabledButton(1, "MaleFocus", "MaleFocus", "This scene requires you to have vagina.");
	}
	//3nd rape scene
	else if (flags["COC.UNKNOWN_FLAG_NUMBER_00170"] == 2) {
		if (pc.hasCock()) addButton(0, "MaleFocus", rapeCorruptAmily3Male);
		else addDisabledButton(0, "MaleFocus", "MaleFocus", "This scene requires you to have cock.");
		if (pc.hasVagina()) addButton(1, "FemaleFocus", rapeCorruptAmily3Female);
		else addDisabledButton(1, "MaleFocus", "MaleFocus", "This scene requires you to have vagina.");
	}
	//4nd rape scene
	else if (flags["COC.UNKNOWN_FLAG_NUMBER_00170"] == 3) {
		addButton(0, "Next", rapeCorruptAmily4Meeting);
	}
}

//Rape Amily 1
private function rapeCorruptAmily1():void {
	amilySprite();
	IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00170");
	clearOutput();
	//[Raping Amily]
	output("You wait for a while, idly looking at the mixture you made for Amily, until a groan draws your attention towards the bound mouse.\n\n");

	output("\"<i>Huh!? What happened!? Why am I tied up!?</i>\" She quickly blurts out, panicked.\n\n");

	output("\"<i>Hello Amily,</i>\" you say.\n\n");

	output("The mousette looks at you and then at the bubbling mixture in your hand. \"<i>W-What is this!?</i>\" she asks you.\n\n");

	output("\"<i>Something I made just for you,</i>\" you answer, grining perversely.\n\n");

	output("\"<i>No! Oh goddess please no! Don't do this, I beg you! Please just let me go!</i>\" Amily pleads, her eyes getting teary.\n\n");

	output("You laugh at her, \"<i>You can't expect me to just let you go after that stunt you pulled.</i>\" Then you begin to strip.\n\n");

	output("Amily never stops her pleading, insisting she's sorry and begging you to let her go; but you ignore all of it. By the time you're done undressing, your ");
	if (pc.cockTotal() > 0) {
		if (pc.cockTotal() > 1) output("[pc.multiCocks] are");
		else output("[pc.cock] is");
		output(" already hard");
		if (pc.hasVagina()) output(", and your ");
	}
	if (pc.hasVagina()) output("[pc.vagina] is already wet");
	output(". Amily cries openly, giving up on her pleading. You straddle her chest and uncork the bottle, then say, \"<i>Open up, I got a special drink for you.</i>\" She keeps her mouth clamped shut, but you won't have it; you hold her nose shut, forcing her to open her mouth to breath; that's when you strike.\n\n");

	output("You shove the bottle inside her mouth, forcing the contents down her throat. She gurgles and splutters, nearly choking as the cocktail flows into her belly, but you don't stop until the bottle is drained. You get up and put the bottle away while Amily coughs and gasps on the floor. When she settles down, you look at her face. She's panting and flushed, her eyes glazed and empty as she looks at the ceiling; then you hear her moan loudly and watch a flood of juices spill from her pussy onto the floor.\n\n");

	output("You chuckle at her spontaneous orgasm; no doubt she must've loved the little drink you gave her. Her eyes regain their focus and she looks at you; not in anger or panic, as you would expect, but in lust. \"<i>S-So hot... So gooooood...</i>\" Amily says, moaning as she cums yet again. You laugh and begin molesting her; groping her breasts, massaging her pussy and pinching her clit. Each touch brings a wave of fluids as Amily orgasms. \"<i>I need...</i>\" You hear Amily mutter. \"<i>I need more! Give me more... Whatever was in that bottle!</i>\" the mouse says with a sense of urgency. You laugh and tell her. \"<i>There isn't any more, you drank everything.</i>\" Amily's face changes to one of desperation. \"<i>No! But I-</i>\" You silence her with a finger, then say. \"<i>I can, however, let you drink some of my juices. There was some in that potion you just drank.</i>\" Amily's face lights up and she says excitedly. \"<i>Yes! Please yes! Give it to me!</i>\"\n\n");

	clearMenu();
	if (pc.hasCock()) addButton(0, "Cock", rapeCorruptAmily1Male);
	else addDisabledButton(0, "Cock", "Cock", "This scene requires you to have cock.");
	if (pc.hasVagina()) addButton(1, "Pussy", rapeCorruptAmily1Female);
	else addDisabledButton(1, "Pussy", "Pussy", "This scene requires you to have vagina.");
}

//[Male]
private function rapeCorruptAmily1Male():void {
	amilySprite();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	if (x < 0) x = 0;
	pc.removeKeyItem("Potent Mixture");
	clearOutput();
	output("You smile and say, \"<i>Fine, but you're gonna have to work for it.</i>\" Amily's answer is to open her mouth wide. The invitation clear, you scoot closer to her mouth, and her lips touch the tip of your " + pc.cockDescript(x) + "; Amily suddenly lifts her head and starts swallowing your dick");
	//[(if PC is huge)
	if (pc.cockThatFits(amily.vaginalCapacity()) == -1) output("- you're quite surprised she managed to fit it in at all.");
	else output(".");
	output("  You moan and take hold of her ears; then proceed to violently fuck her face, shoving as much of your dick in as you can. Amily doesn't seem to mind; in fact she tries to take as much of your cock in as possible... but she just can't get her throat open enough for that.\n\n");

	output("You smile as she licks the underside of your cock; bound as she is, there isn't much she can do; but you're happy that she seems so eager to blow you. Especially after she denied and even attacked you, claiming you're too corrupt for her; things would be so much better if she was a bit more open minded... Your musings are stopped by a particularly noisy slurp from Amily. She looks so nice with your cock buried in her mouth... It's surprisingly good too; she's paying attention to all the right spots and making sure to massage your shaft with her tongue. Amily sucks fiercely on your dick, and you feel yourself getting closer to orgasm. Amily notices your breathing getting ragged and your increased rhythm, and doubles her efforts. It wouldn't be bad if she was always this eager to suck you off like the slut she is... The thought of her, willingly kneeling between your legs and opening wide to accept your " + pc.cockDescript(x) + "... You feel your ");
	if (pc.balls > 0) output(pc.ballsDescript() + " churn");
	else output(pc.cockDescript(x) + " throb");
	output("; the very idea of a mousy slut eager for cum distills into one massive load of [pc.cum], and you dump it all in her mouth.\n\nYou sigh, sated for now and leave her to clean herself up.");
	output("\n\n");
	processTime(25 + rand(10));
	pc.orgasm();
	//dynStats("lib", -2, "cor", 5);
	pc.slowStatGain("l", -2);
	pc.cor(5);
	if(CombatManager.inCombat) CombatManager.genericVictory()
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}
//[Female]
private function rapeCorruptAmily1Female():void {
	amilySprite();
	clearOutput();
	pc.removeKeyItem("Potent Mixture");
	output("You smile and say, \"<i>Fine, but you're gonna have to work for it.</i>\" Amily's answer is to open her mouth wide. The invitation clear, you advance and lower your " + pc.vaginaDescript() + " towards her open mouth.\n\n");

	output("Amily suddenly lifts her head and begins licking and slurping your pussy like her life depended on it");
	//[(If PC's a squirter)
	if (pc.isSquirter()) output(", a jet of fluids escape your lower lips and hit her straight in the face; but she pays no mind");
	output(".  She blows on your clit, causing you to jump in pleasure, you say, \"<i>Calm down, there's plenty of juice for you.</i>\" But Amily doesn't seem to be listening; she licks you until your first orgasm rocks you and flows into her hungry mouth. She drinks as much as possible, but ends up choking and spilling most of your juices.\n\n");

	output("You laugh as she splutters. \"<i>Look at what you've done,</i>\" you say, motioning at the spilled juice all around her; she finishes coughing and takes a deep breath.\n\n");

	output("\"<i>More,</i>\" she says.\n\n");

	output("\"<i>More? After all the mess you've made? I don't think you deserve more.</i>\" You reply.\n\n");

	output("She begins tearing up, desperate to have more of your delicious juices.\n\n");

	output("\"<i>Please! I Need it! Please!</i>\" she wails.\n\n");

	output("\"<i>Fine, but you'd better do it right this time.</i>\" You say; she beams and licks her lips as you lower yourself towards her mouth yet again.\n\n");

	output("She pushes her "+(amily.hasMuzzle()?"muzzle":"nose") +" against you " + pc.vaginaDescript() + ", tightly sealing her around your dripping snatch before working her tongue in. You moan and grip her ears tighly; she just keeps licking, not even feeling pain as you begin bucking into her "+(amily.hasMuzzle()?"muzzle":"lips") +".\n\n");

	output("This feels so good... Amily's licking you like a pro. You imagine her thirsty for more of you; eager to lap every little drop of femcum that spills from you; growing hornier with each lap. The thought is too much for you, and you finally hit a ferocious orgasm; a flood of [pc.girlCum] entering her mouth and going straight into her belly.\n\n");

	//[(if PC has large cum amount or is a squirter)
	if (pc.isSquirter()) output("She tries to gulp down everything she can, but ultimately a lot of it escapes her mouth and ends up on her face and all around her.  ");
	output("You keep feeding her more and more cum, your orgasm lasting much longer than usual. Amily's belly even distends a bit from the quantity, her pussy leaks juice like an open tap; it seems servicing you was enough to drive her over the edge several times.\n\n");

	output("Finally done, you let go of her and get up; she proceeds to slump down and give a small burp of satisfaction, then drift off into sleep. You untie her and proceed to get dressed; you give her a light pat on the thigh and return to your camp. You'll have to do this again sometime later...");
	output("\n\n");
	processTime(25 + rand(10));
	pc.orgasm();
	//dynStats("lib", -2, "cor", 5);
	pc.slowStatGain("l", -2);
	pc.cor(5);
	if(CombatManager.inCombat) CombatManager.genericVictory()
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//[Raping Amily 2]
//Lock in from first scene?
//[Male]
private function rapeCorruptAmily2Male():void {
	amilySprite();
	clearOutput();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	if (x < 0) x = 0;
	output("You unceremoniously shove your " + pc.cockDescript(x) + " into her maw. ");
	//[(if PC has a huge dick)
	if (pc.cockThatFits(amily.vaginalCapacity()) < 0) output("Despite your size, she presses forward to take in as much of you as possible.  ");
	output("Once you feel yourself hit the back of her throat, she twists her head a bit and takes you even further, deep throating you.\n\n");

	output("You gasp in surprise; there's no way she could have done this before your last meeting! Has she been practicing?\n\n");

	output("Soon you feel that she's taken in all that ");
	//[(if PC's dick is huge)
	if (pc.cockThatFits(amily.vaginalCapacity()) < 0) output("is possible.");
	//(else)
	else output("you have to offer.");
	output("\n\n");

	output("You pat her head and say. \"<i>Good girl.</i>\"\n\n");

	output("She smiles and gives your dick a big slurp, drawing a moan from you.\n\n");

	output("You begin pumping into her mouth; long strokes that bring your tip almost out of her mouth and then back in as far as it'll go.");
	//[(If PC is huge.)
	if (pc.cockThatFits(amily.vaginalCapacity()) < 0) output("  One of Amily's hands settles on your " + pc.cockDescript(x) + ", stroking whatever she doesn't manage to swallow.");
	output("\n\n");

	output("As you settle upon a steady rhythm, you can't help but notice she's become an excellent cock sucker. Could it be that your potion is helping her release her inner slut? You hope that's the case!\n\n");

	//[(if PC has balls)
	if (pc.balls > 0) output("Amily grabs your balls and begins kneading them.  ");
	//(else if PC has a pussy)
	else if (pc.hasVagina()) output("Amily shoves her fingers into your " + pc.vaginaDescript() + ".  ");
	output("You moan and begin leaking pre, accelerating to keep up with Amily's noisy slurps. She shows no sign of shame in letting the world know she's giving you a blow job.\n\n");

	output("She looks much more feminine with her new figure, but it would be better if her assets were bigger... Then she could give you a tit job too!");
	//[(if PC has balls)
	if (pc.balls > 0) output("  Just the thought of it is enough to make your balls churn.");
	output("  You imagine Amily growing ever more eager to blow you; begging for your cum like the slut she is. The previously prudish mouse reduced to nothing more than a cumbucket for you to unload into.\n\n");

	output("Suddenly, you grab her hair and roughly shove yourself as far in as you can; Amily doesn't scream in pain, instead she moans in pleasure, eyes wide and eager at what she's about to receive.\n\n");

	output("You unload into her, jet after delicious jet of [pc.cumNoun] bursting into her throat to hit her stomach, even distending it a bit.");
	//[(If PC has large cum amount)
	if (pc.cumQ() >= 750) output("  You feel your enourmous load coming back through her throat and spilling from her mouth and nose, smearing your crotch as you pull away to let her breathe.");
	output("\n\n");

	rapeCorruptAmily2Epilogue();
}

//[Female]
private function rapeCorruptAmily2Female():void {
	amilySprite();
	clearOutput();
	output("You roughly grab ahold of Amily's ears and shove her face on your " + pc.vaginaDescript() + ".");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("  Your juices rocket into her face, painting her "+(amily.hasMuzzle()?"muzzle":"face") +" in your femcum as she giggles with happiness and pleasure.");
	output("  Amily begins licking and slurping, her nose bumping into your clit every once in a while; she eats your " + pc.vaginaDescript() + " like her life depended on it. You can only moan in pleasure as the previously prudish mousette gorges herself on your tasty juices.\n\n");

	output("You gently pat her head and say, \"<i>Good girl.</i>\"\n\n");

	output("Amily replies by giving your clit a big slurp and doubling her efforts to get to every cranny and nook inside your juicy tunnel; you reward her with a flood of juices, which she licks happily; making you moan lewdly...\n\n");

	output("Amily herself moans once in a while, sending pleasurable ripples throughout your " + pc.vaginaDescript() + " and body. She seems to be enjoying herself immensely; and she displays no shame in letting everyone know that she likes cunt juice.\n\n");

	output("You can't see her very well from this position, but from what you did see before, she looks much more feminine with her new figure, but it would be better if her assets were bigger... big jiggling tits to press and grope. It would be wonderful! Just the thought is enough to make you cum again");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output(", giving Amily a juice bath; even if the mousy cunt did get better at drinking, there is no way she'd be able to drink all of your fluids");
	output(".");
	//(else)
	if (!pc.isSquirter()) output("  A flood of juices escape your pussy and go directly into the mousy cunt's hungry maw, however, some of it spills; even if Amily did get better at drinking, she's still a long way from being the perfect fucktoy you want her to be.");
	output("\n\n");

	output("Suddenly you grab her ears and pull her against your dripping pussy as hard as you can. Amily doesn't even seem to notice the pain; all she does is moan in pleasure as her tongue continues lapping excitedly, eager to receive her reward.\n\n");

	output("You cum... you cum hard, harder than you believe you've ever had. A flood of juices shower Amily's open mouth, face and upper body; soaking her in your juices and marking her as your property. She chokes on your juices, but you don't let go; Amily herself seems unwilling to stop, despite her current predicament; all she can do is drink and moan.");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("  Your orgasm lasts much longer than usual. Eventually you release Amily and finish off on top of her head.\n\n");

	rapeCorruptAmily2Epilogue();
}

private function rapeCorruptAmily2Epilogue():void {
	amilySprite();
	IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00170");
	//Both variations link into this next paragraph
	output("Amily falls on her back, panting happily and licking her mouth to taste as much of you as possible. That's when you notice her beginning to change, slowly but significantly.\n\n");

	output("Her breasts start filling up, and her butt and hips grow bigger; you can't help but smile at how you're changing the mousette.\n\n");

	output("You lower yourself and open one of her ears wide, before whispering, \"<i>Be ready for when I come back, there's a lot more where this came from,</i>\" then you get up and walk away to fetch more ingredients for Amily's 'medicine'.");
	output("\n\n");
	processTime(25 + rand(10));
	pc.orgasm();
	//dynStats("lib", -2, "cor", 5);
	pc.slowStatGain("l", -2);
	pc.cor(5);
	if(CombatManager.inCombat) CombatManager.genericVictory()
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//[Raping Amily 3]
//Herms will get to pick how to fuck her.
//[Male]
private function rapeCorruptAmily3Male():void {
	amilySprite();
	clearOutput();
	output("You strip while Amily watches hungrily. Finally naked, you order the mouse to come closer and use her breasts to pleasure you. Amily quickly scoots closer on her knees and press her breasts around your " + pc.cockDescript(0) + ".");
	//[(if PC is huge)
	if (pc.cockVolume(0) >= amily.vaginalCapacity()) output("  She can't get her breasts all the way around though, still she doesn't stop, determined to do as you ordered.");
	output("\n\n");

	output("Amily begins moving her ");
	if (amily.hasFur()) output("furry ");
	output("breasts along your shaft, causing pleasurable chills to run along your body; the pre-cum that seeps down your cock only serves to lube up Amily's breasts, making the act all the more pleasurable. You can feel yourself getting ready to blow your load and order Amily to lay down and stay still.\n\n");

	output("Amily complies without a word; then you drive your " + pc.cockDescript(0) + " between her breasts and begin pumping vigorously.You blow your load then and there, right on Amily's breasts, covering them in a layer of white hot spunk, while Amily smiles contentedly.\n\n");

	//(if PC is < 60 Corruption)
	if (pc.cor() < 60) {
		output("Satisfied for the moment, you leave the smiling mouse lying in a pool of cum and return to the camp.");
		pc.orgasm();
		processTime(15);
		//dynStats("cor", 2);
		pc.cor(2);
		output("\n\n");
		if (CombatManager.inCombat) CombatManager.genericVictory()
		else {
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		return;
	}
	//(else)
	output("That was good, but now it's time to reward Amily for her efforts; besides you could really use a proper blow job.\n\n");

	output("\"<i>Get up cumbucket, it's time for your reward,</i>\" you say.\n\n");

	output("Amily jumps up and rushes to nuzzle at your still erect " + pc.cockDescript(0) + ". \"<i>Thank you! Thank you! Thank you!</i>\" she says excitedly. Then with a lick of her lips, she opens wide to accept your meat.  ");
	//[(if PC is huge)
	if (pc.cockVolume(0) > amily.vaginalCapacity() * 0.8) output("You didn't think it was possible, but somehow ");
	output("Amily manages to fit all of you inside her in one go.  She gurgles in ecstasy and sends vibrations along your shaft, drawing a moan of pleasure from you. Her tongue darts out of her mouth to lick at ");
	if (pc.balls > 0) output("your " + pc.ballsDescript());
	else if (pc.hasVagina()) output("your " + pc.vaginaDescript());
	else output("the base of your shaft");
	output(".  It tickles you and causes a jet of pre to splatter her insides, drawing another moan from her.\n\n");

	output("\"<i>Enough teasing. Get to work now,</i>\" you order.  She complies by beginning to move and suckle on your " + pc.cockDescript(0) + ".\n\n");

	output("She moves her whole body to make the experience as pleasurable as possible for you while her ropey mouse tail sways happily behind her with each noisy slurp. It's wonderful to see how good Amily's gotten at this, you could even say this is what she was born for, sucking dick. The only way this could be any better is if Amily was a succubus herself. After all, you have no doubt that as good as Amily is, she's still no match for a sex demon. That's not a bad idea actually... maybe you should push to convert her into a demon? Amily could be your own personal cumslut, a cocksucking demon to dump your load into whenever you feel like. Your cock throbs at the idea, as if in approval.");
	//[(if PC has balls)
	if (pc.balls > 0) output("  Your " + pc.ballsDescript() + " churn with cum, growing heavier with every nasty detail that goes through your mind.");
	output("  The image of a demonized Amily servicing you distills into a massive load of spunk.  You're all too happy to dump it into Amily's eager throat. You grab her ears and forcibly pull her head, plunging into her throat as far as you can. Then you explode inside her.\n\n");

	output("Her belly fills, distending far more than it has in the past, and not one drop of cum of what - you presume - has been your longest orgasm yet escapes from her throat.");
	//[(if PC has large cum amount)
	if (pc.cumQ() >= 750) output("  You keep pumping and she keeps drinking; her distended belly doesn't stop growing until she looks heavily pregnant and you're spent.");
	output("\n\n");

	//call followup function
	processTime(25);
	rapeCorruptAmily3Epilogue();
}

//[Female]
private function rapeCorruptAmily3Female():void {
	amilySprite();
	clearOutput();
	output("You strip while Amily watches hungrily.  Finally naked, you order the mouse to come closer and use her breasts to pleasure you. Amily scoots closer on her knees and presses her breasts against your " + pc.vaginaDescript() + ", one orb at a time. You smile and moan softly as her erect nipple stimulates your labia; ");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("you show her your enjoyment by spurting a jet of femcum all over her breasts, washing them with sexual lubricant. Amily can't help but smile as she looks at her now glistening breasts.");
	//(else)
	else output("moisture gathers and drips over Amily's sensitive nipples, causing the mousette to sigh in pleasure and smile as she looks at her wet nipples.");
	output("\n\n");

	//[(if PC's clit is big enough)
	if (pc.clitLength >= 4) output("Amily then crushes your sensitive clit between her breasts, working her mounds over it like it was a cock. You gasp and moan as Amily smiles up at you, happy to see your reaction to her stimulation.");
	//(else)
	else output("Amily decides to tease your sensitive clit with her wet nipples, circling the little nub and sending electric shocks up your spine; you can't help but moan; Amily just smiles and grinds her generous breasts harder against your pussy.");
	output("\n\n");

	output("With a final push of your fingers against your " + pc.vaginaDescript() + ", you cum; spilling juices all over the eager mousette. She hastens to try and lick it up in mid-stream; most of it ends up on her face, but what does get inside her open maw disappears quickly. You finish up and watch as Amily licks her lips, trying to taste more of you.\n\n");

	//(if PC is < 60 Corruption)
	if (pc.cor() < 60) {
		output("Satisfied for the moment, you leave the smiling mouse lying in a pool of juices and return to the camp.");
		processTime(15);
		pc.orgasm();
		//dynStats("cor", 2);
		pc.cor(2);
		output("\n\n");
		if (CombatManager.inCombat) CombatManager.genericVictory()
		else {
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		return;
	}
	output("That was good, but now it's time to reward Amily for her efforts, besides you could really use a proper licking.\n\n");

	output("You sit on a nearby stump and say, \"<i>Get up cumbucket, it's time to properly reward you.</i>\"\n\n");

	output("Amily springs up and rushes to nuzzle your still leaking vagina. \"<i>Thank you! Thank you! Thank you!</i>\" she says excitedly. Then, with a lick of her lips, she opens wide and engulfs your whole " + pc.vaginaDescript() + ".");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("  Her nose bumps against your clit, causing you to release a jet of juices up the mousette's throat. To your surprise, she doesn't spill even a single drop and happily gulps all of it down.");
	output("  She licks and kisses your lower lips, making out with them as if they were the lips of a long lost lover. Her ropey mouse tail sways happily behind her with every noisy slurp. It's wonderful to see how good Amily's gotten at this; you could even say this is what she was born for, licking pussy. The only way this could be any better is if Amily was a succubus herself. After all, you have no doubt that as good as Amily is, she's still no match for a sex demon. That's not a bad idea actually; maybe you should push to convert her into a demon?  Your own personal cumslut of a pussy licking demon to dump your juices into whenever you feel like. Your pussy contracts at the idea, as if in approval. The image of a demonized Amily servicing you sends a ripple of wild pleasure throught your pussy, and you feel the thought distill into a giant flood of juices.  You're all too happy to dump it into Amily's eager maw. You grab her ears and forcibly pull her head into your crotch, crushing her nose against your clit and her mouth against your pussy, she moans with joy at the deed and then you explode.\n\n");

	output("You flood her maw at an alarming rate. Someone not practiced in the art of juice guzzling would surely choke and drown on the amazing amount of femcum that you're dumping into Amily's maw; yet she not only manages to chug it all down, she even continues licking to draw out more. Even more surprising than that is the fact that her mouth seems to have formed a perfect seal around your " + pc.vaginaDescript() + ", ensuring not a single drop escapes her.");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("  You keep on spilling more and more juices; at one point you worry you might become dehydrated, but the pleasure of your overwhelming orgasm is enough to make you push the thought away. Amily doesn't stop drinking, even as her belly begins distending. You keep cumming until you are spent.");
	output("\n\n");

	processTime(25);
	//Link to followup.
	rapeCorruptAmily3Epilogue();
}

//Both variants link here
private function rapeCorruptAmily3Epilogue():void {
	amilySprite();
	IncrementFlag("COC.UNKNOWN_FLAG_NUMBER_00170");
	output("Amily falls on her back, licking her lips and rubbing her bulging belly. Then she begins moaning as something starts changing. Her tail thrashes madly between her legs, and you watch enraptured as a spade-like tip forms on the tip of her tail. On top of her head a pair of small bumps appear, then develop into small cute demonic horns... Just like you imagined. Could it be that the true source of Amily's transformation was you, and not the mixture?\n\n");

	output("You smile wickedly. It was you all along; corrupting the mousette into a slut. You turn around and start back towards your camp.\n\n");

	output("\"<i>Please! Wait, [pc.master], please!</i>\" Amily yells, you turn around and look back at her. \"<i>I want more. Please,</i>\" she begs.\n\n");

	output("\"<i>So you do? Well... I'll give you more, if you pass a test,</i>\" you tell her.\n\n");

	output("She gets up and kneels, looking up to you in attention. \"<i>I'm willing to take you in as my cumbucket, only if you obey all my orders and keep practicing to pleasure me even more,</i>\" you say.\n\n");

	output("Amily happily answers, \"<i>Anything you desire!</i>\"\n\n");

	output("\"<i>I will return when I think you're ready.</i>\" You say, then leave her to her own devices.");

	processTime(25 + rand(10));
	pc.orgasm();
	//dynStats("lib", -2, "cor", 5);
	pc.slowStatGain("l", -2);
	pc.cor(5);
	if(CombatManager.inCombat) CombatManager.genericVictory()
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//[Raping Amily 4]
//Herms will get to pick how to fuck her.
private function rapeCorruptAmily4Meeting():void {
	amilySprite();
	clearOutput();
	//(if PC is genderless)
	if (gender(pc) == 0) {
		output("You would love to play with your mouse bitch, but you don't have the parts for that; so you return to the camp.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	output("You enter the ruined village hoping to find your corrupted mouse cumbucket. It doesn't take long until you spot her; she's stroking her pussy and blowing a wood carved dildo, practicing like you told her to.\n\n");

	output("As soon as she realizes you're there, she drops the dildo and rushes towards you; kneeling submissively in front of you, she nuzzles your crotch and asks, \"<i>[pc.Master], did you come to feed me?</i>\"\n\n");

	output("You smile and scratch her behind one ear, drawing a pleasured sigh from the corrupted mouse. You can't help but recall how prudish she was, refusing and attacking you; now she's really come a long way, begging for a drop of cum at the very sight of you.  \"<i>Let's see if you're ready,</i>\" you say, roughly grabbing her ear and pulling her away.\n\n");

	clearMenu();
	if (pc.hasCock()) addButton(0, "Cock", rapeCorruptAmily4Male);
	else addDisabledButton(0, "Cock", "Cock", "This scene requires you to have cock.");
	if (pc.hasVagina()) addButton(1, "Pussy", rapeCorruptAmily4Female);
	else addDisabledButton(1, "Pussy", "Pussy", "This scene requires you to have vagina.");
}

//[Male]
private function rapeCorruptAmily4Male():void {
	amilySprite();
	clearOutput();
	output("You slowly strip off your [pc.gear], while Amily pants in anticipation. When you're done you present to her your erect " + pc.cockDescript(0) + "; she quickly nuzzles and kisses along your length, rubbing her breasts along your length");
	//[(if pc has balls)
	if (pc.balls > 0) output(" and " + pc.ballsDescript());
	output(".\n\n");

	output("\"<i>Get to it,</i>\" you order her.\n\n");

	output("She backs off and gives your tip a light kiss, which quickly turns into a slurp as you feel your " + pc.cockDescript(0) + " slip into her throat; there is barely any resistance, your cock glides down her throat, Amily doesn't gag at all.");
	//[(if PC is huge)
	if (pc.cockVolume(0) > amily.vaginalCapacity() * 0.8) output("  You smirk, pleased; with your size, you'd probably choke whomever tried to swallow your " + pc.cockDescript(0) + " to death. But Amily doesn't choke or gag, she's only capable of moaning in delight with each inch that she manages to fit inside her hungry maw.");
	output("\n\n");

	output("In no time at all, you're all the way inside her maw; she looks up at you smiling, as her tongue darts out to give ");
	if (pc.balls > 0) output("your balls");
	else if (pc.hasVagina()) output("your pussy");
	else output("the base of your cock");
	output(" a teasing lick. You smile back and say, \"<i>Go ahead, pleasure me.</i>\" Amily moans and begins moving her tongue and maw along your shaft.\n\n");

	output("You grip her ears for leverage, when did she get so good at this? She must've been practicing all the time... She bobs her head along you eagerly, hungrily, and almost desperately.");
	//[(if PC has balls)
	if (pc.balls > 0) output("  Sometimes you even feel her nipples brush your balls teasingly.");
	output("  Each time her nose bumps against your crotch, she swallows, massaging your whole length; and each time she pulls back, she blows, sending pleasurable chills along your body.");
	output("\n\n");

	output("You feel your cock getting even harder as you feel your orgasm building up. Amily must feel it too, as she doubles her work to pleasure you. You pull her head flush against you and blow your load deep into her throat. Amily moans in pleasure and delight, juices hitting the floor and wetly signalling her own orgasm.  She gulps all you offer her hungrily, sucking and massaging your dick to draw as much cum out of you as possible.");
	//[(if PC has balls)
	if (pc.balls > 0) output("  One of her hands even begins kneading your balls, attempting to coax even more out of you.");
	output("\n\n");

	//(if PC's corruption < 80)
	if (pc.cor() < 80) {
		output("You push her back and withdraw, spent. Amily looks up to you adoringly, ");
		//[(if PC has huge cum amount)
		if (pc.cumQ() >= 750) output("her belly distended to the point that she looks pregnant and just about ready to give birth.");
		//(else)
		else output("her belly filled with the huge load you just dumped in her.");
		output("\n\n");

		output("You try to summon more strength to continue fucking the mouse's wonderful throat, but for the moment you're spent. \"<i>Go and keep practicing, I'll come to feed you later.</i>\" Amily smiles, licks her lips and gives your cock a parting kiss before running away to one of her hideouts.\n\n");

		output("You return to the camp.");
		processTime(15);
		pc.orgasm();
		pc.cor(3);
		output("\n\n");
		if (CombatManager.inCombat) CombatManager.genericVictory()
		else {
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		return;
	}
	
	output("You push her back and withdraw, not yet satisfied. <b>A familiar power gathers inside you, and you decide to tap into it.</b>\n\n");

	output("\"<i>I have decided to make you my bitch; to make you into a willing cum-dumpster for me to dump my load into whenever I feel like it. If you want that. Beg for it, grovel at my feet and beg me to finish your corruption into a true cumslut. Do a good enough job and I might even consider knocking you up.</i>\" You say, smiling wickedly.\n\n");

	output("Moaning, she drops on fours and crawls toward you to grovel at your " + pc.feet() + ", rubbing her face on the very ground you stand on, and begging all the while.\n\n");

	output("\"<i>Please [pc.master], make me your cumbucket. There is nothing I would love more than to become a receptacle for your lust. This would be like a dream come true! Please, oh please [pc.master]! Knock me up and allow me to birth more mice to worship you like you deserve.</i>\"\n\n");

	output("Her words please you, and you ");
	if (pc.isNaga()) output("coil your serpentine tail around her head.");
	else if (pc.isGoo()) output("engulf her maw in slime.");
	else output("put a " + pc.foot() + " on her head.");
	output(" She falls silent and you say. \"<i>Very well. From now on I am your one and only [pc.master].  You will address me as such, always. My word is law, and you shall do whatever I tell you to, whenever I tell you to. Rise, it's time to break you into your new role as my cum-dumpster.</i>\"\n\n");

	output("You let her go and she rises to her knees. \"<i>Now prove your fealty. Blow me!</i>\" you order her.\n\n");

	output("Amily wastes no time and gets to work.  You let her suck on her favorite thing in the world for a while; then you tell her to lick you, to work her tongue all around your shaft");
	//[(if PC has balls)
	if (pc.balls > 0) output(" and balls");
	output(".\n\n");

	output("She obeys you at once; following your orders is like second nature to her. An image of an even more corrupted Amily comes to your mind. Demonic features adorn her as she becomes a mix of succubus and mouse. You focus into those thoughts and send them towards your cock.\n\n");

	output("\"<i>Stop and stand still. It's time to baptise you,</i>\" you tell her, panting.\n\n");

	output("Amily closes her eyes and bows slightly, giving you a clear shot of her head.  Finally, you let go.\n\n");

	output("Black spunk comes out of your " + pc.cockDescript(0) + ", ripe with corruption. The moment it hits Amily's head, she moans. Your vile cum covers her whole head, then her whole upper body, and spreads along her body unnaturally. Not even a crevice is left free as your black jism permeates her skin and covers her like a full body suit. Soon enough she's covered from head to toe. Her pussy leaks copiously and she moans throughout the whole affair.\n\n");
	
	processTime(25);
	rapeCorruptAmily4Epilogue();
}

//[Female]
private function rapeCorruptAmily4Female():void {
	amilySprite();
	clearOutput();
	output("You slowly strip off your [pc.gear], while Amily pants in anticipation. When you're done you present to her your dripping " + pc.vaginaDescript() + "; she quickly nuzzles and kisses your clit.");
	//[(if PC has balls)
	if (pc.balls > 0) output("  Pulling back enough to give your balls a teasing lick.");
	output("\n\n");

	output("\"<i>Get to it,</i>\" You order her.\n\n");

	output("She goes back to nuzzling and kissing along your netherlips; she inhales deeply, enjoying the scent of your wet pussy, then exhales right on your clit. It tickles you enough to make you ");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("wet her face with a small jet of juices.");
	//(else)
	else output("even wetter.");
	output("  Amily digs into your " + pc.vaginaDescript() + " like her life depended on it; slurping, kissing, sucking and lapping every single drop of juice that she manages to get to. The sound of wet pussy and lapping tongue fills the air.\n\n");

	output("Finally, Amily's tongue penetrates deep into your " + pc.vaginaDescript() + ". She takes great care to stimulate you in all the right ways; it's as if she had a map to every pleasurable spot inside your love-hole. You moan, proud of the corrupt mousette. To get this good, she must've really worked hard on her training. You scratch her behind her ears, earning a pleasured moan that sends ripples of pleasure throughout your insides. \"<i>You're doing great slut. Keep at it.</i>\" You tell her. She answers with a muffled, \"<i>Thank you, mistress,</i>\" and doubles her efforts to please you.\n\n");

	output("The pleasure is overwhelming, Amily's practiced licks are able to send you into multiple orgasms, at one point you have to resort to supporting yourself on her head; something she doesn't seem to mind. In fact, realizing what kind of effect her pussy eating is having just eggs her on. She pushes and grinds her nose on your pussy; bumping on your clit with each lick; sending shocks of pleasure up your spine.");
	//[(if PC has a big clit)
	if (pc.clitLength >= 4) output("  One of her hands begins stroking your erect clit as if it was a cock. The pleasure of the act nearly overloads your senses.");
	output("\n\n");

	output("You feel the biggest orgasm yet build up, and you decide to reward your obedient little cumslut by making sure she gets all of it. \"<i>Clamp down on my pussy slut. I'm about to reward you for all your effort.</i>\" Amily loses no time in obeying your orders. She gives your pussy one final lap, and you feel it.");
	//[(if PC is a squirter)
	if (pc.isSquirter()) output("  Amily barely has to work to drink your juices, your pussy jets them forth with such force that all of them go straight through Amily's mouth and into her throat.");
	//(else)
	else output("  Amily drinks from you like a parched man drinks from a well.");
	output("  Every drop offered is consumed, something you've come to expect from your elected cum-bucket. One final powerful gush of fluids signals the end of your orgasm.\n\n");

	//(if PC's corruption < 80)
	if (pc.cor() < 80) {
		output("You push her back and withdraw, spent, ");
		//[(if PC is a squirter)
		if (pc.isSquirter()) output("her belly distended from the immense amount of femcum she just drank.");
		//(else)
		else output("her belly slightly distended from the flood of juices you just dumped in her.");
		output("\n\n");

		output("You feel like you should continue, but are too weak to do so... \"<i>Go and keep practicing, I'll come to feed you later,</i>\" you tell her.  Amily smiles, licks her lips and gives your pussy a parting kiss before running away to one of her hideouts.\n\n");

		output("You return to the camp.");
		processTime(15);
		pc.orgasm();
		pc.cor(3);
		output("\n\n");
		if (CombatManager.inCombat) CombatManager.genericVictory()
		else {
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		}
		return;
	}
	output("You push her back and withdraw, not yet satisfied. <b>A familiar power gathers inside you, and you decide to tap into it.</b>\n\n");

	output("\"<i>I have decided to make you my bitch; to make you into a willing cum-dumpster for me to dump my load into whenever I feel like it. If you want that. Beg for it, grovel at my feet and beg me to finish your corruption into a true cum-slut,</i>\" you say, smiling wickedly.\n\n");

	output("Moaning, she drops on all fours and crawls toward you to grovel at your " + pc.feet() + ", rubbing her face on the very ground you stand on, and begging all the while.\n\n");

	output("\"<i>Please [pc.master], make me your cum-bucket. There is nothing I would love more than to become a receptacle for your lust. This would be like a dream come true! Please, oh please [pc.master]!  Allow me to knock you up so you can birth more mice to worship you like you deserve.</i>\"\n\n");

	output("Her words please you, and you ", false);
	if (pc.isNaga()) output("coil your serpentine tail around her head.");
	else if (pc.isGoo()) output("engulf her maw in slime.");
	else output("put a " + pc.foot() + " on her head.");
	output("  She falls silent and you say, \"<i>Very well. From now on I am your one and only mistress. You will address me as such, always. My word is law, and you shall do whatever I tell you to, whenever I tell you to. Rise, it's time to break you into your new role as my cum-dumpster.</i>\"\n\n");

	output("You let her go and she rises to her knees. \"<i>Now prove your fealty. Lick me!</i>\" you order her.\n\n");

	output("Amily wastes no time and gets to work.  She licks your " + pc.vaginaDescript() + " adoringly, like it was a holy relic for her to worship.");
	//[(if PC has balls)
	if (pc.balls > 0) output("  She ignores your balls for the moment, so concentrated in her task, that she barely notices them resting on top of her head.");
	output("  You tell her to work harder and she eagerly complies, licking and kissing faster and harder; working you into another mind-blowing orgasm. An image of an even more corrupted Amily comes to your mind. Demonic features adorn her as she becomes a mix of succubus and mouse. You focus into those thoughts and send them down your pussy.\n\n");

	output("\"<i>Stop and stand still. It's time to baptise you,</i>\" you tell her, panting.\n\n");

	output("Amily closes her eyes and bows slightly, giving you a clear shot of her head.  Finally, you let go.\n\n");

	output("Black juices squirt from your " + pc.vaginaDescript() + ", ripe with corruption.  The moment it hits Amily's head, she moans. Your vile femcum covers her whole head, then her whole upper body, and spreads along her body unnaturally. Not even a crevice is left free as your black juices permeate her skin and cover her like a full body suit. Soon enough she's covered from head to toe. Her pussy leaks copiously and she moans throughout the whole affair.\n\n");
	
	processTime(25);
	rapeCorruptAmily4Epilogue();
}

//Both variations link here.
private function rapeCorruptAmily4Epilogue():void {
	amilySprite();
	output("Your cum is completely absorbed by her and she doubles over in pleasure as she screams. Her biggest orgasm yet rocks her to the core; her eyes roll back and you see her begin to change.\n\n");

	output("Her " + (amily.hasFur()?"fur turns to a lewd purple":"hair turns into a lewd purple, skin fading to a light lavender") + "; her small horns grow and become more defined; small bat-like wing sprout from her shoulders; the spade-like tip of her tail grows bigger and more defined; ");
	if (amily.hasFur()) output("her feet warp into a mix of mousy foot-paws and demonic claws, complete with ebony claws and a fourth joint");
	else output("her feet are forced into a perpetual tip-toe as the trademark demonic bone juts from her heel");
	output("; her hands grow small black claws.  Finally, her eyes focus back on you, now with a seductive glow.\n\n");

	output("She looks herself over, examining and enjoying her new sensitive body; every movement is accompanied with a pleasured sigh or a moan. She looks at you and kneels in front of you, a rush of fluids escapes her pussy as she does so. \"<i>[pc.Master]... What are your orders?</i>\" Amily asks with a seductive tone.\n\n");

	output("You grin wickedly. The mousette has really become part succubus. \"<i>I want you to come and settle next to my camp.  I need my cumslut close whenever I call,</i>\" you say.\n\n");

	output("Amily grins and replies seductively, \"<i>Yes, [pc.master]... Your orders are my pleasure.</i>\"\n\n");
	output("<b>(Corrupted Amily added to slaves)</b>");
	//Add corrupted amily flag here
	flags["COC.AMILY_FOLLOWER"] = 2;
	//Switch to less lovey pregnancy!
	if (pc.hasPregnancyOfType("CoCAmilyPregnancy")) pc.getPregnancyOfType("CoCAmilyPregnancy").pregnancyType = "CoCMousePregnancy";
	amily.impregnationType = "CoCMousePregnancy";
	
	//Make babies disappear
	//pregnancyStore.knockUpForce(); //Clear Pregnancy - though this seems unneccessary to me. Maybe it was needed in an older version of the code?
	//Set other flags if Amily is moving in for the first time
	if (flags["COC.AMILY_CORRUPTION_WARNING"] == 0) {
		amily.breastRows[0].breastRatingRaw = 5;
		amily.nippleLengthRatio = .5;
		amily.hipRatingRaw = 12;
		amily.buttRatingRaw = 12;
		amily.vaginas[0].wetnessRaw = 1;
		amily.armor.longName = "sexy rags";
	}
	//if marble is there, tag it for freakout
	//if (pc.findStatusEffect(StatusEffects.CampMarble) >= 0) {
		//flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 1;
	//}
	//else flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 2;
	//Disable amily encounters in the village!
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
	processTime(25);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//[Stalking Amily (Corrupt)]
//This event takes about 3 hours.
//Only happens if the PC has the Potent Mixture and is >= 25 Corruption.
private function stalkingZeAmiliez():void {
	clearOutput();
	output("You step into the ruined village and set out to look for Amily.\n\n");

	processTime(60 + rand(60 * 2));
	//(If PC's intellingence >= 50 and speed >= 65)
	if (pc.intelligence() >= 25 && pc.reflexes() >= 35) {
		amilySprite();
		output("You cautiously survey the surroundings, and finally spot some recent tracks made by Amily. It's clear she tried to hide them, but using your superior wits, you not only find the routes leading to all of her hideouts, but deduce which hideout she'll use next and decide to hide inside; now, all that's left to do is wait...\n\n");

		output("You wait for quite some time, but eventually you hear Amily approaching; she checks the hideout for any signs of intrusions, but you have concealed your presence well and she finds nothing. Satisfied, she sets down a bag with some fruits she gathered and sits down on a stool, letting out a sigh of relief.\n\n");

		output("This is your cue to act; you quickly burst out of your hideout and swipe her blowpipe away. Amily jumps away in surprise and tries to reach for her knife, but you're too fast; you knock her off her feet and grab her wrists, pinning her against the floor as her knife skids away. \"<i>Hello Amily.</i>\" you say with a wicked smile.\n\n");

		output("\"<i>N-No! Get off me!</i>\" She yells back, panicked at her predicament. You hold both her wrists with one hand above her head, then take one of her darts and stab her in the thigh. She squeaks loudly and ceases her struggling, the drugs within the dart quickly knocking her out.\n\n");

		output("You smile as you strip her off, then you find a rope to tie her up. You tie her hands together, then tie her hands to her ankles, ensuring she won't be able to fight you back. After that, you dispose of anything that could be used as a weapon, or could aid her in her escape, then sit down on the stool she was sitting earlier to wait until she's recovered her consciousness. After all, it's much more fun if she's awake to see everything you'll do to her...\n\n");
		//[Proceed to rape scene.]
		//RAPE 1 GO
		chooseYourAmilyRape();
	}
	//(if PC's intelligence >= 50)
	else if (pc.intelligence() >= 25) {
		amilySprite();
		output("You cautiously survey the surroundings, and finally spot some recent tracks made by Amily. It's clear she tried to hide them, but using your superior wits, you not only find the routes leading to all of her hideouts, but deduce which hideout she'll use next and decide to hide inside; now, all that's left to do is wait...\n\n");

		output("You wait for quite some time, but eventually you hear Amily approaching; she checks the hideout for any signs of intrusions, but you have concealed your presence well and she finds nothing. Satisfied, she sets down a bag with some fruits she gathered and sits down on a stool, letting out a sigh of relief.\n\n");

		output("This is your cue to act; you quickly burst out of your hideout and swipe her blowpipe away. Amily jumps away in surprise and reaches for her knife, assuming a fighting stance. You [pc.readyWeapon] and prepare to teach the foolish mouse a lesson.\n\n");
		//[Proceed to battle.]
		clearMenu();
		addButton(0, "Next", amilyCombatStart);
	}
	//(if PC's speed >= 65)
	else if (pc.reflexes() >= 35) {
		amilySprite();
		output("You walk about the village, looking for Amily, but after searching for a while with no luck, you catch a break when you hear some bushes moving.\n\n");

		output("You spot Amily just in time to see a dart flying towards you; but you quickly sidestep the dart and rush towards her. Realising she missed, she reaches for another dart; but you won't allow it, you take a rock lying on the ground and throw it at her blowpipe, striking it out of her hand.\n\n");

		output("Panicked, she takes her knife and prepares to fight you. You ready your [pc.readyWeapon] and prepare to teach the foolish mouse a lesson.\n\n");
		//[Proceed to battle.]
		clearMenu();
		addButton(0, "Next", amilyCombatStart);
	}
	else {
		output("You search for Amily high and low, but can't find a single trace of her. Frustrated, you return to the camp.  Maybe if you were smarter or faster you could find her.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

//[Stalking Amily 2 (Corrupt)]
private function stalkingZeAmiliez2():void {
	clearOutput();
	//(if PC is genderless)
	if (gender(pc) == 0) {
		output("You think about going into the ruined village, but playing with Amily is not going to be possible if you don't have the parts for it... You return to your camp.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
	//(else)
	else {
		amilySprite();
		output("You step into the ruined village and set out to look for Amily.\n\n");

		output("It doesn't take long before you locate her and you immediately see how she's changed after the first dose of her special medicine.\n\n");

		output("Her hips and butt have grown bigger, her breasts also seem fuller; overall she looks far more feminine and attractive now. You can already feel your ");
		if (pc.hasCock()) {
			output(pc.cockDescript(0) + " getting hard");
			if (pc.hasVagina()) output(" and your ");
		}
		if (pc.hasVagina()) output(pc.vaginaDescript() + " growing wet");
		output(".\n\n");

		output("\"<i>Hey Amily! I've got more juice for you!</i>\" you call out to her, shaking the bottle filled with the mixture in the air.\n\n");

		output("She squeaks in surprise, apparently she hadn't noticed you; she begins fidgeting and shaking.\n\n");

		output("\"<i>What's the matter? Don't you want more?</i>\" You ask.\n\n");

		//(if PC's corruption < 45)
		if (pc.cor() < 45) {
			output("Amily shakes her head and yells, \"<i>No! I can't!</i>\" before darting off.\n\n");

			output("You laugh and put the bottle away, then return to your camp.\n\n(Not corrupt enough...)");
			processTime(15);
			clearMenu();
			addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
			return;
		}
		output("You begin stripping off your [pc.gear] and show her your [pc.crotch]. \"<i>Come and I'll let you drink more of me.</i>\"\n\n");

		output("Amily shakes her head and says, \"<i>No! I-I can't,</i>\" but she begins walking towards you nevertheless.\n\n");

		output("Once she's close, she kneels before you and you uncork the bottle. \"<i>Open wide!</i>\" you say, smiling.\n\n");

		output("You shove the bottle into her mouth and she greedily gulps down everything. Once empty, you discard the bottle and watch as she moans loudy and juices her pants.\n\n");

		output("You laugh, but take a step back when she reaches for her knife; then proceeds to cut off her ragged clothing, disposing of it along with the knife. \"<i>Aaaah... Much better,</i>\" she says in relief.\n\n");

		output("Glad to see she meant you no harm, you decide it's time to reward her for her openness. \"<i>Now open wide once more, Amily. It's time for your reward.</i>\" you tell her.\n\n");

		output("\"<i>Yes! Please I need it!</i>\" she says eagerly, closing her eyes and opening her mouth.");
		pc.removeKeyItem("Potent Mixture");
		//RAPE 2 GO
		processTime(15);
		chooseYourAmilyRape();
	}
}

//[Stalking Amily 3 (Corrupt)]
private function stalkingZeAmiliez3():void {
	clearOutput();
	//(if PC is genderless)
	if (gender(pc) == 0) {
		output("You think about going into the ruined village, but playing with Amily is not going to be possible if you don't have the parts for it... You return to your camp.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
		return;
	}
	amilySprite();
	output("You step into the ruined village and set out to look for Amily.\n\n");

	output("You barely have to search, as Amily finds you herself. Her figure has changed very dramatically since the first time you two met, she has developed a perfect hourglass figure; with generous breasts, a full butt and wide flanks. She just looks at you with hungry, lusty eyes, panting and drooling a bit.\n\n");

	output("You begin to greet her, but she quickly dashes towards you and kneels before you.\n\n");

	output("\"<i>I need you! I need more of you! Please let me drink moooore!</i>\" she begs, nuzzling your crotch; ");
	if (pc.hasCock()) {
		output("driving your " + pc.cockDescript(0) + " into erection");
		if (pc.hasVagina()) output(" and ");
	}
	if (pc.hasVagina()) output(" moistening your " + pc.vaginaDescript());
	output(".  Amily's nose twitches a little and she forcibly pulls your pants down, looking up at you with pleading eyes, as if asking for permission.\n\n");

	output("\"<i>Don't you want more of your medicine?</i>\" you ask, showing her the bottle with the mixture.\n\n");

	output("She takes the bottle from your hand and throws it away. \"<i>No. All I need is your cum... Please let me drink more. I-I'll do anything you want, just let me have a taste. Please?</i>\" She begs.\n\n");
	pc.removeKeyItem("Potent Mixture");
	output("Surprised at her forwardness, you realize something. She must be addicted to you, or more specifically... Your cum. You barely supress the urge to laugh, this is priceless! The prudish mouse has been reduced to a needy addict. This is almost too perfect, you were just imagining previously how good it'd be if she turned into a cumslut.\n\n");

	output("\"<i>You'll do anything, you say? I want you to grovel at my feet and beg me!</i>\" you order.\n\n");

	output("Amily plants her head on the ground and starts. \"<i>[pc.Master], please let me drink more of your cum. Please! I need it so bad that I can't help but drool. I need it so bad that not being able to drink from you is like torture. Please let me drink!</i>\"\n\n");

	output("You laugh at the mousette, then say, \"<i>Very well! I will you allow you to drink from me, you worthless cunt!</i>\"");

	//RAPE 3 GO
	processTime(15);
	chooseYourAmilyRape();
}

//Warning of Taint:
private function amilyTaintWarning():void {
	clearOutput();
	amilySprite();
	output("Amily approaches you, looking concerned.  \"<i>Darling... I don't know what's been going on, but you need to start taking better care of yourself.  I can smell the corruption taking root in you - if you don't stop, you'll soon start acting like any other demon.</i>\"\n\n");
	flags["COC.AMILY_CORRUPTION_WARNING"] = 1;
	processTime(3);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Farewell Note:
public function farewellNote():void {
	amilySprite();
	output("\nWhen you awaken this morning, you find Amily gone and a small message left for you.\n\n");

	output("\"<i>Dear [pc.name], I tried to warn you, but the corruption, it seems, was too strong for even you.  I don't want to do this, but I've left the camp - I care too much for the " + pc.mf("man","woman") + " you were to see you throw your life into depravity and sin as another demon. If you should manage to turn back from the abyss, then I will come back to you.</i>\"\n\n");

	output("<b>Amily has moved out!</b>\n\n");

	output("So what if you are aren't so pure anymore; you're still very much capable of helping her!  Maybe you should teach her a lesson?\n\n");

	//-(if PC's int >= 40)
	if (pc.intelligence() >= 25) output("You begin to formulate a plan, but to put this plan into motion you'll require a Lust Draft and some Goblin Ale.  That damn rat is going to rue the day she denied you...");
	//-(else)
	else output("You think about some of the more interesting potions you found while exploring; perhaps you could use some of them...");

	output("  Maybe she had a point though?  You are getting pretty corrupt... these thoughts are proof enough.\n");
	flags["COC.AMILY_FOLLOWER"] = undefined;
	//Set - amily flipped her shit
	flags["COC.AMILY_CORRUPT_FLIPOUT"] = 1;
	//Enable village encounters
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = undefined;
	//Change to plain mouse birth!
	if (pc.hasPregnancyOfType("CoCAmilyPregnancy")) pc.getPregnancyOfType("CoCAmilyPregnancy").pregnancyType = "CoCMousePregnancy";
}

//Amily's Return:
public function amilyReturns():void {
	amilySprite();
	output("\nYou awaken to the sensation of limbs wrapped blissfully around your body, and discover Amily has curled up to you. She quickly wakes, and gives you a joyous smile.\n\n");

	output("\"<i>Thank you, [pc.name]. I don't know how you did it, or if it had anything to do with me, but you managed to do something that I've never heard of anyone else having the will to do. You turned back from demonhood and repurified yourself again.</i>\"\n\n");

	output("She squeezes you tightly, then gets up to start making breakfast.\n\n");
	output("<b>Amily has moved back in.</b>\n");
	//Clear amily shit flipping
	flags["COC.AMILY_CORRUPT_FLIPOUT"] = undefined;
	//Move in
	flags["COC.AMILY_FOLLOWER"] = 1;
	//Clear 'warning'
	flags["COC.AMILY_CORRUPTION_WARNING"] = undefined;
	//Disable village encounters
	flags["COC.AMILY_VILLAGE_ENCOUNTERS_DISABLED"] = 1;
}

// [EVENT 3174: Ask Emily to ditch the fuzz]
public function amilyNoFur():void {
	amilySprite();
	flags["COC.AMILY_OFFERED_DEFURRY"] = 1;
	clearOutput();
	output("You shake your head gently and explain that your position has not changed. Amily looks annoyed, but respects your decision.  You interrupt her next thought with a clarification; you don't want to have sex with her because of her appearance.  \"<i>...What do you mean?</i>\" she asks, one of her hands idly moving up and tugging one of her mousey ears.  As gently as you can, you explain that mice (and rats, for that matter) are considered pests in your home world, and you can't find yourself inclined to mate with a walking version of them.\n\n");
	output("There's a long pause while Amily digests your implication.  \"<i>You want me to... change?</i>\" she asks quietly.  \"<i>Would that... make you want to mate with me?</i>\"  You can't make any promises, but it would definitely change your considerations, you explain.\n\n");
	output("After another long silence, she sighs.  \"<i>I don't know.  What would my family say if I just... went and made myself a completely different person, all for the sake of a human?</i>\"  You slowly move to her and lay a hand on her shoulder, forcing her to look once more into your eyes.  It's not the fact that she won't be a mouse, you insist.  It's the fact that she's moving on for the sake of her race.  She manages a little smile at that, her expression brightening just a bit.  \"<i>I'll think about it,</i>\" she finally decides.  \"<i>If you can find some non-demonic reagents, perhaps we can give it a try.  If anything bad happens, though,</i>\" she warns, wagging a finger at you threateningly.  She backs off and stands awkwardly for a second.\n\n");
	output("\"<i>Well, uh... bye,</i>\" Amily concludes, whirling around and walking away.  You can't be sure, but it seems like she's exaggerating the sway of her hips a bit.  You don't think much of it, heading back toward camp and beginning to formulate a concoction to de-mouse your potential breeding partner.  Perhaps... a <b>golden seed</b> for a human face, a <b>black egg</b> to get rid of the fur, and some <b>purified succubus milk</b> to round things off.  You make a mental note to remember those ingredients, for they won't show up again and you'd feel positively silly if you somehow completely forgot them.\n\n");
	processTime(15);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

// Check if we have all the shit we need
private function amilyCanHaveTFNow():Boolean
{
	//<b>golden seed</b> for a human face
	// <b>black egg</b> to get rid of the fur
	// some purified <b>succubus milk</b> to round things off
	return amily.hasFur()  // Amily isn't already defurried
	&& flags["COC.AMILY_OFFERED_DEFURRY"]==1  // Amily has been offered to be dehaired
	&& pc.hasItem(new CoCGoldenSeed())     // And we have all the shit we need
	&& (pc.hasItem(new CoCBlackEgg()) || pc.hasItem(new CoCBlackEggLarge()))
	&& (pc.hasItem(new CoCSucMilkPure()) || (amilyCorrupt() && pc.hasItem(new CoCSucMilk())));
}

// Arrive with all the stuff you need to make Amily not look completely rediculous.
private function amilyDefurrify():void
{
	pc.destroyItem(new CoCGoldenSeed());
	if (pc.hasItem(new CoCBlackEgg())) pc.destroyItem(new CoCBlackEgg());
	else pc.destroyItem(new CoCBlackEggLarge());
	if (amilyCorrupt()) {
		if (pc.hasItem(new CoCSucMilk())) pc.destroyItem(new CoCSucMilk());
		else pc.destroyItem(new CoCSucMilkPure());
	}
	else pc.destroyItem(new CoCSucMilkPure());
	
	flags["COC.AMILY_OFFER_ACCEPTED"] = 1;
	flags["COC.AMILY_OFFERED_DEFURRY"] = 2; // We're now completing this dumb little quest.
	
	amily.skinType = GLOBAL.SKIN_TYPE_SKIN;
	amily.faceType = GLOBAL.TYPE_HUMAN;
	amily.faceFlags = [];
	amily.armType = GLOBAL.TYPE_HUMAN;
	amily.armFlags = [];
	amily.legType = GLOBAL.TYPE_HUMAN;
	amily.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
	
	amilySprite();
	clearOutput();
	output("It's not long after arriving in the ruins, darting about to announce your presence, before Amily steps out from a dilapidated alley.  She squares up to you with a hand planted on her slender hip, looking to you expectantly.");
	output("Without uttering a word, you reach into your pack and produce three items, passing them to the mouse girl as she inspects them curiously.  \"<i>And you're sure this is free of the taint?</i>\" she asks somewhat nervously.  You nod, but she doesn't seem completely convinced.  \"<i>If I do this... what's to stop you from just leaving me? What if this is just some sick game you're playing?</i>\" You quell her rising anxiety with a reassuring smile, making certain she realizes leaving is the last thing on your mind.  ");
	output("That seems to calm her enough.  She nips the tip off of the black egg, leaving a large enough hole to funnel the other ingredients into the shell.  With surprising ease, she puts the harpy's seed into her hand and grinds it into a powder, sprinkling the product into her makeshift mortar.  With obvious hesitation, Amily hefts the bottle of succubus milk, pouring a token amount in.  Placing a finger over the opening, she shakes the stuff together, then simply raises the shell to her lips and chugs the contents in a single gulp.\n\n");
	output("Amily falls back from you with a gasp, paws flying to her temples.  The appendages shudder, digital pads lengthening and the metacarpal pad flattening until she's suddenly left with slender, perfectly-formed hands.  Her astounded gaze flutters from her completely normal digits to your own curious visage; she starts to speak, but the words catch in her throat as she regards a growing pile of fur at her feet.  Like taking a comb to a stray cat, the hair covering most of her body simply falls out in clumps.\n\n");
	output("A cry brings your attention from the hair-pile back up to her face.  As if by magic, her rodent snout simply recedes back into her face, the nose reforming into a more human model.  She gently reaches up and brushes a fingertip across her new lips, eyes glazing over as tears begin to form.  \"<i>So... different,</i>\" she whispers as the transformation continues.  You move to her and wrap her in a warm, comforting hug, and after a moment's pause, she wraps her arms around you as well.\n\n");
	output("Finally, the process comes to a close.  You break from each other and stand at arm's length, both of you studying the changes to her previously-animalistic self.  Her auburn-colored ears and bare tail remain unchanged, but other than that, Amily's completely human.  Though a bit conflicted, Amily seems happy enough with her decision.  \"<i>Well, I guess that's all there is to it,</i>\" she says, scratching her newly bare cheek idly.  \"<i>I'll let you think for a bit... see you later.</i>\"\n\n");
	output("She stalks off into the ruins once more, humming a little tune as she goes.  You note a little more spring in her step, now that hope is restored in repopulating her race.\n\n");
	processTime(15);
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

// NOTE: Not sure how this ties in.
// Be a humongous asshole to Amily and tell her that she's, in effect, a whiny bitch.  Or something.
private function amilySufferNotTheFurryToLive():void
{
	amilySprite();
	amily.skinType = GLOBAL.SKIN_TYPE_SKIN;
	amily.faceType = GLOBAL.TYPE_HUMAN;
	amily.faceFlags = [];
	amily.armType = GLOBAL.TYPE_HUMAN;
	amily.armFlags = [];
	amily.legType = GLOBAL.TYPE_HUMAN;
	amily.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
	flags["COC.AMILY_IS_BATMAN"] = 1;
	clearOutput();
	output("You laugh spitefully as you look at the now humanized mouse girl. You tell her, with a grin on your face, that you did all this to screw with her; she should really trust her gut next time. Continuing with your tirade, you tell her that she's a complete fool, as well as a hypocrite that pretends to be noble, but is just a whore deep down inside. Pausing only to savor the look of betrayal on her face, you remark that her clinging to some twisted ideal of repopulating her people is just a depraved pipe dream; one that will never happen. You smirk and taunt her, implying that she should \"enjoy\" her new body as you depart, leaving your words to ring through her as she visibly tears up. The faint sounds of sniffling are all that echo behind you as you head back to camp.");
}

public function amilyDefurryOfferAtCamp():void
{
	clearOutput();
	amilySprite();
	if (flags["COC.AMILY_OFFERED_DEFURRY"] == undefined) flags["COC.AMILY_OFFERED_DEFURRY"] = 1;
	if (!amilyCanHaveTFNow())
	{
		output("Unfortunately, you can't do such a thing until you have acquired the necessary magical prerequisites.  In simple terms, you need a <b>golden seed</b> for a human face, a <b>black egg</b> to get rid of the fur, and some <b>purified succubus milk</b> to round things off.");
		clearMenu();
		addButton(0, "Next", amilyFollowerEncounter);
		return;
	}
	//EAT ZE ITEMS!
	pc.destroyItem(new CoCGoldenSeed());
	if (pc.hasItem(new CoCBlackEgg())) pc.destroyItem(new CoCBlackEgg());
	else pc.destroyItem(new CoCBlackEggLarge());
	if (amilyCorrupt()) {
		if (pc.hasItem(new CoCSucMilk())) pc.destroyItem(new CoCSucMilk());
		else pc.destroyItem(new CoCSucMilkPure());
	}
	else pc.destroyItem(new CoCSucMilkPure());

	if (amilyCorrupt())
	{
		output("Beckoning your furry little slut over to you, you inform her that her [pc.master] has a special little something for her to drink. \"<i>What does it do, [pc.master]?</i>\" she inquires curiously. Grinning, you tell her that this potion will rid her body of all of her fur and rat - like facial features, turning her into a more human looking mouse morph; perfect for your tastes and desires.  Hesitation washes over Amily's face at the thought of losing what is her core identity... something you nip in the bud as you tell her that her [pc.master] demands it, and she will obey, without question.  To help \"encourage\" her, you remove your lower coverings and toss them aside, motioning her to come over and sit on your lap.  Her eyes fixate on your ");
		// See, fen, this is why smart people use constants instead of just guessing what each fucking number means.
		switch(gender(pc))
		{
			case 1:  // Male
				output("hardening [pc.multiCocks] ");
				break;
			case 2: // Female
				output("moistening [pc.vagina] ");
				break;
			default: // Fallback
				output("hardening [pc.nipples] ");
				break;
		}
		output("and she quickly runs up to sit in your lap like a good girl.\n\nWith a giggle, you command her to open her mouth while guiding her head back with your head.  \"<i>Say ahh</i>,\" you tell her, and she cracks her mouth open with little hesitation as you begin to pour it down her throat.  She gulps greedily as she swallows the mixture, purring contentedly as you rub her furry belly.  As soon as the bottle is empty, you tell her to get up so you can watch the transformation in full detail.  Jumping to her feet, she presents her body to her [pc.master], and then gasps as the changes overtakes her body; fur begins to fall out of her at a furious rate, her paws begin to warp into more human hands, and her muzzle starts to twitch and shrink into her face, until what remains is a corrupted, humanoid mouse morph, with a human face, smooth skin, and no whiskers.  You certainly like what you see; you beckon her over so you can get a taste of her new-and-improved self.");
	} else {
		output("She squares up to you with a hand planted on her slender hip, looking to you expectantly.  Without words, you reach into your pack and produce three items.  You pass them to the mouse girl, and she looks over them curiously.  \"<i>And you're sure this is free of the taint?</i>\" she asks somewhat nervously.  Your nod is the only urging she needs.  She nips the tip off of the black egg, leaving a large enough hole to funnel the other ingredients into the shell.  With surprising ease, she puts the harpy's seed into her hand and grinds it into a powder, sprinkling the product into her makeshift mortar.  With obvious hesitation, Amily hefts the bottle of succubus milk, pouring a token amount in.  Placing a finger over the opening, she shakes the stuff together, then simply raises the shell to her lips and chugs the contents in a single gulp.\n\n");
		output("Amily falls back from you with a gasp, paws flying to her temples.  The appendages shudder, digital pads lengthening and the metacarpal pad flattening until she's suddenly left with slender, perfectly-formed hands.  Her astounded gaze flutters from her completely normal digits to your own curious visage; she starts to speak, but the words catch in her throat as she regards a growing pile of fur at her feet.  Like taking a comb to a mangy stray cat, the hair covering most of her body simply falls out in clumps.\n\n");
		output("A cry brings your attention from the hair-pile back up to her face.  As if by magic, her rodent snout simply recedes back into her face, the nose reforming into a more human model.  She gently reaches up and brushes a fingertip across her new lips, eyes glazing over as tears begin to form.  \"<i>So...  different,</i>\" she whispers as the transformation continues.  You move to her and wrap her in a warm, comforting hug, and after a moment's pause, she wraps her arms around you as well.\n\n");
		output("Finally, the process comes to a close.  You break from each other and stand at arm's length, both of you studying the changes to her previously-animalistic self.  Her auburn-colored ears and bare tail remain unchanged, but other than that, Amily's completely human.  Though a bit conflicted, Amily seems happy enough with her decision.  \"<i>Well, I guess that's all there is to it,</i>\" she says, scratching her newly bare cheek idly.  \"<i>This is what you wanted, right?  Now, is there anything else you'd like to discuss?</i>\"\n\n");
	}
	// Back to Amily's camp controls
	
	amily.skinType = GLOBAL.SKIN_TYPE_SKIN;
	amily.faceType = GLOBAL.TYPE_HUMAN;
	amily.faceFlags = [];
	amily.armType = GLOBAL.TYPE_HUMAN;
	amily.armFlags = [];
	amily.legType = GLOBAL.TYPE_HUMAN;
	amily.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
	
	flags["COC.AMILY_OFFERED_DEFURRY"] = 2;
	amilySprite();
	processTime(25);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}
public function refuzzAmily():void {
	clearOutput();
	if (!pc.hasItem(new CoCMouseCocoa(), 2)) {
		output("Unfortunately, you can't do such a thing until you have two handfuls of mouse cocoa.");
		doNext(amilyFollowerEncounter);
		return;
	}
	
	pc.destroyItem(new CoCMouseCocoa(), 2);
	if (amilyCorrupt()) {
		output("Beckoning your furry little slut over to you, you inform her that she should be changed back to the way she was before you've even met her. You produce the two batches of mouse cocoa and give them to Amily, telling her to just suck on it. \n\nEagerly, she sucks on the mouse cocoa and her eyes widen. Her face changes, rodent snout and whiskers grow. Fur grows all over her body and her hands warp into more paw-like. <b>Amily is now back to her former mouse self albeit corrupted.</b>");
	} else {
		output("She squares up to you with a hand planted on her slender hip, looking to you expectantly.  Without words, you reach into your pack and produce the batches of mouse cocoa.  You pass them to the mouse girl, and she looks over them curiously.  \"<i>Are you sure you want me to change back?</i>\" she asks somewhat nervously.  Your nod is the only urging she needs.  She sucks on the mouse cocoa, savouring the chocolatey taste.\n\n");
		output("Her face changes, rodent snout and whiskers grow. Fur grows all over her body and her hands warp into more paw-like. <b>Amily is now back to her former mouse self.</b>");
	}
	
	amily.skinType = GLOBAL.SKIN_TYPE_FUR;
	amily.faceType = GLOBAL.TYPE_MOUSE;
	amily.faceFlags = [GLOBAL.FLAG_MUZZLED];
	amily.armType = GLOBAL.TYPE_MOUSE;
	amily.armFlags = [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
	amily.legType = GLOBAL.TYPE_MOUSE;
	amily.legFlags = [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
	
	flags["COC.AMILY_OFFERED_DEFURRY"] = 1;
	amilySprite();
	processTime(25);
	clearMenu();
	addButton(0, "Next", amilyFollowerEncounter);
}

//Amily/Urta Interaction
//Must have Pure Amily as follower
//Must have "UrtaSexed" flagged
//Must have Lover Urta?
//(Add a new option to Amily's screen: \"<i>Date Night</i>\" during the evening)
//(PC chooses option: \"<i>Date Night</i>\")
public function dateNightFirstTime():void {
	clearOutput();
	output("Sitting Amily down, you ask her what she'd think about taking a \"<i>little trip</i>\" with you into town.\n\n");
	if (flags["COC.AMILY_INCUBATION"] != undefined) {
		output("\"<i>Perhaps once I'm no longer pregnant.  I wouldn't want to hurt the little ones,</i>\" Amily answers.");
		processTime(1);
		clearMenu();
		addButton(0, "Next", amilyFollowerEncounter);
		return;
	}
	
	output("\"<i>A-A trip?</i>\" the little mouse-morph stutters, surprised at your sudden invitation.  \"<i>Well, I haven't really been out much since we, you know...</i>\" She suddenly brightens. \"<i>Yeah, why not?  Could be fun!  I've never been to Tel'Adre, though.  What's it like?</i>\" You take Amily's hand in yours and start to tell her all about the strange, faraway city as you prepare for your \"<i>date.</i>\"  When she's ready, the two of you head out toward the desert.\n\n");

	output("It takes you a bit longer than usual to reach the desert city.  You're on guard for two today, and go well out of your way to avoid the various denizens of the wasteland.  Eventually, though, the great walled city of Tel'Adre comes into view, its imposing white walls a stark contrast to the barren desert around it.  You approach the gates, and are pleased to see your foxy lover Urta standing beside them, her halberd and guard uniform fitting her well, though you can just see her tail wrapped tightly around her extra... package.\n\n");

	output("\"<i>Hey there, lover,</i>\" Urta says happily as you approach the gates.  However, her gaze quickly shifts to the little mouse-girl at your side.  Urta wrinkles her brow in confusion for a moment before slow-dawning comprehension spreads across her face.  \"<i>So, [pc.name], uh... who's your friend?</i>\"\n\n");

	output("Amily smiles, as friendly as she can be when placed in such an awkward situation, \"<i>Hi! My name's Amily - [pc.name]'s mate.</i>\"  You give Amily's hand a little squeeze, proud of her for not overreacting to Urta's casual drop of the word \"<i>lover.</i>\"\n\n");

	output("\"<i>Oh, " + pc.mf("his","her") + "... mate...</i>\"  Urta mumbles, looking a little crestfallen at the admission.  Her emerald eyes light up with an idea while a mischievous grin spreads over her vulpine muzzle.  Before she can act on it, you request her to allow the two of you through the gates, interrupting whatever tricks the clever fox has planned.  She retrieves the corruption-detecting gem she once used on you and gives Amily a quick sweep.  When the gem emits a white glow, Urta gives an authoritative nod and calls for the gates to be opened.\n\n");

	output("You and Amily step onto the streets of Tel'Adre.  The city's narrow roads are crowded");
	if (hours >= 18) output("despite the late hour, bustling with centaurs and canine-morphs going about their business, heading home after a long day's work or making their way to the Wet Bitch for a relaxing drink.\n\n");
	else if (hours < 6 && hours > 3) output("despite the early time, bustling with centaur and canine-morphs on their way to their pre-dawn activities.");
	else if (hours < 12 && hours > 3) output("despite the morning hours, busy with centaur and canine-morphs hurrying to their own personal tasks.");
	else output(" with centaur and canine-morphs busy with their own tasks.");

	output("Amily seems enthralled by the sights of the city before you've even passed the gate.  Wide-eyed, she follows your guiding hand down the main street, watching with awe as folk of all descriptions pass her by.  More than once, you're forced to pull her back from trying to jump an unsuspecting mouse-morph, mistaking the poor soul for someone she knew many years ago.\n\n");

	output("Eventually, your city tour takes you to that infamous hole, the Wet Bitch. Despite the late hour, the tavern is relatively empty, and the two of you have no problem finding a table.  Your drinks arrive promptly, and as a show of appreciation, Amily pays your tab.  You spend the next hour or so listening politely while the mouse-girl excitedly recounts everything she's seen, so completely overwhelmed by her first exposure to civilization in years that you're afraid she's liable to faint.\n\n");

	output("However, after Amily has shared her excitement twice over with you, the two of you fall into a companionable silence over your drinks.  Lightweight that she is, Amily is buzzed before you've knocked back your first full stein.  As you watch the mouse-morph start the short, steep road to drunkenness, you're surprised to see Tel'Adre's own Captain of the Guard step into the tavern.\n\n");

	output("Urta scans the tavern's main room briefly, sees you, and strides over.  With a charming smile, Urta asks if she can have a seat.  You try to gently explain that you're on a date right now, but ");
	output("Amily interrupts, slurring about how she'd like to meet some of your friends.  Oh, this is going to end well...\n\n");
	//(OLD: Urta is either too dense to catch the hint or simply ignores it. You sigh and ask Amily if it's alright if Urta joins you.
	//output("\"<i>Huh? Oh yeah, ish fiiine,</i>\" Amily drawls, half-drunk. Oh, this is going to end well.)
	output("The fox-girl grabs a chair from an adjacent table and brings it over, sitting reverse and leaning heavily on the back rest.  Before she can say anything more than a simple greeting, however, Amily grabs a bottle from ");
	if (flags["COC.ENCOUNTERED_VALA_AT_BAR"] == undefined) output("a passing waitress");
	else output("a rather alarmed Vala as she flutters by");
	output(". \"<i>Herr, ish gud,</i>\" Amily slurs, pawing off the bottle to a surprised Urta.\n\n");

	output("Well, this could be interesting.  If you get both the girls drunk, it might be easy (or inevitable) for something sexual to happen.  Or, you could take Amily home right now and make sure nothing untoward happens to either of your lovers.");
	//(Display Options: [Drink!] [Leave])
	pc.imbibeAlcohol(30);
	processTime(120 + rand(60));
	pc.imbibeAlcohol(30);
	clearMenu();
	addButton(0, "Drink", liqueurUpTheWaifus);
	addButton(1, "Leave", amilyXUrtaRunAWAY);
}

//Amily/Urta -- LEAVE
private function amilyXUrtaRunAWAY():void {
	clearOutput();
	clearOutput();
	output("You watch Urta take a nice long drink from the proffered bottle, but before she gets well and truly smashed, you politely excuse yourself and, helping an inebriated Amily to her feet, exit the Wet Bitch.  The two of you make your way back to camp and, putting the drunken mouse-girl to bed, you give her a kiss on the cheek and soon fall asleep.");
	//Disable threesomes between them forever.
	flags["COC.AMILY_VISITING_URTA"] = 3;
	clearOutput();
	addButton(0, "Next", mainGameMenu);
}

//Amily/Urta -- DRINK!
private function liqueurUpTheWaifus():void {
	clearOutput();
	output("You encourage Urta to drink up, and watch with a perverse delight as she starts knocking back the liquor.  You sip at your drink, taking things nice and slow as the fox-girl drowns her issues in booze.  More than once, Urta tries to start a conversation with the two of you, but each time she does, you merrily refill her stein and Amily is quick to urge her on.  You give the mouse-girl a look, trying to gauge her reception of the situation: you can see, through the mist of intoxication in her eyes, a lustful gaze aimed straight at Urta's ample bosom.\n\n");

	output("Before long, Urta's swaying in her chair, her brief snippets of conversation becoming more and more lewd with each passing minute.  Eventually, much to your delight, an unintentional show of cleavage from Amily sets off the beast.\n\n");

	output("THUNK!\n\n");

	output("The table is nearly lifted off its base. Urta gasps, embarrassed, and Amily nearly leaps out of her seat in surprise.  \"<i>W-What the hell was that!?</i>\" she squeaks.  Before you can answer, Amily ducks her head under the table - and comes back up blushing beet-red.\n\n");

	output("With a drunken grin, Urta laughs, \"<i>Oh, shit. Sorry, sweetie, I figured [pc.name] woulda' blabbed about my third leg by now...</i>\" She leans over the table, nearly brushing noses with Amily as she adds, \"<i>Hey... Wanna give it a try?</i>\"\n\n");

	output("For a moment, you're unsure of what's about to happen... then Urta moans lewdly, her eyes suddenly rolling back into her head.  You take a peek under the table and are absolutely thrilled to see Amily's hand firmly wrapped around Urta's throbbing horse-cock.  You say a few encouraging words as Amily gives Urta a stealth handy, quickly making the fox-girl shudder and squirm.  You lean back and nod");
	if (pc.hasCock()) output(", already feeling a strong stirring in your [pc.cocks]");
	else if (pc.hasVagina()) output(", already feeling a little moisture in your loins");
	output(".\n\n");

	output("Unabashedly aroused by your mouse-lover getting the fox-girl off, you gently suggest that the three of you go and get a room.\n\n");

	output("\"<i>Mmm, I thought you'd never ask,</i>\" Urta purrs, giving a particularly violent shudder.\n\n");

	output("\"<i>Oh, that shounds loooovely,</i>\" Amily adds.\n\n");

	output("Grinning, you saunter over to the bar, rent a room, and lead the girls upstairs.  Half-drunk yourself, you stumble up the last few stairs and hurriedly unlock the door.  The room is sparsely decorated, sporting a single large bed.\n\n");

	output("Urta and Amily flop down on the bed, already undressing and teasing each other - Urta running her hands ");
	if (amily.hasFur()) output("through the mouse's fur ");
	else output("over the mouse's skin ");
	output("and Amily wrapping her lithe little tail around Urta's massive endowment.  You strip off your [pc.gear] and, looming over the girls, decide on how you want to go about this.");
	processTime(15);
	//(Display Appropriate Options: [Use Cock] [Use Vag])
	clearMenu();
	addDisabledButton(0, "Use Cock");
	if (pc.hasCock()) addButton(0, "Use Cock", threesomeAmilUrtaCAWKS);
	addDisabledButton(1, "Use Vagina");
	if (pc.hasVagina()) addButton(1, "Use Vagina", urtaXAmilyCuntPussyVagSQUICK);
	addButton(3, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); }, undefined, "Leave", "Leave them alone.");
}

//Amily/Urta -- Use Cock
public function threesomeAmilUrtaCAWKS():void {
	clearOutput();
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	//Silly mode alternative:
	/*if (silly()) {
		output("MUZZLESMUZZLES MUZZLE PAW FUR MURR HIR SHI YIFF YIFFITY YIFF PURR PURR MEW.", false);
	}*/
	output("You take hold of your " + pc.cockDescript(x) + " and present it to the girls.  Giggling, they both crawl to the edge of the bed, giving their asses and chests exaggerated shakes and jiggles until their heads are level with your shaft.  Eagerly, Urta and Amily grab your " + pc.cockDescript(x) + " and begin to play with it, giving it little brushes and licks with their wonderful, animalistic tongues.  You run your hands through their hair, urging them on until your dick is well and truly soaked with their warm saliva, the perfect lubricant to get things started.\n\n");

	output("You gently push Amily and Urta away from your ready shaft and tell the fox-girl to get on her back.  Urta licks her lips and, with a lusty grin, flops onto her back with her legs splayed around your waist.  Her massive horse-cock points upwards like a flagpole, wavering in the air and already dribbling streams of pre that would make any normal man jealous.  You easily lift her hefty sack out of the way, revealing the prize beneath: her wet, drooling cunt.\n\n");

	output("You line up your " + pc.cockDescript(x) + " with the fox-girl's eager vag, but stop short of penetration, running your cockhead up and down along her outer lips, teasing the drunken herm with short little shifts of your hips.  This only gets her harder, and her pre-cum is soon flowing out of her horse-cock to pool on her belly and thighs.  As you tease Urta's womanhood, you give Amily a little nod.  The petite mouse morph wastes no time climbing up onto Urta's lap and, with a little help from you, gets herself in position atop the fox-morph's towering rod.\n\n");

	output("You give Amily a pat on the butt, and as one, you take Urta's cock and cunt; you slam your " + pc.cockDescript(x) + " in her to the hilt as Amily slides down her shaft, taking as much of her horsemeat inside herself as she can before it starts distending her stomach.  You grin ear to ear as Urta's eyes roll back in her head, a look of complete sexual rapture on her foxy face as you and Amily double-team her.\n\n");

	output("Grabbing hold of Urta's flared hips, you start to repeatedly penetrate her slick vag, burying yourself in her loose fuckhole and pulling out until the crown of your " + pc.cockDescript(x) + " tastes the air.  While you've almost completely withdrawn, however, Amily is just bottoming out, giving you a disjointed rhythm that has Urta moaning like a bitch in heat inside of a minute.  Once she starts bouncing on Urta's cock, there's no stopping Amily, whose drunken lust propels her to surprising speeds, forcing you to hammer Urta with everything you've got almost right out of the gates.  Convulsing and writhing from the incredible pleasure she must be feeling, Urta's cock spurts pre and her cunt begins to squeeze down on your " + pc.cockDescript(x) + "; nearly mad with pleasure, she grabs her hefty tits and ravages her dark nipples.\n\n");

	output("Well, you can't have the fox cumming too soon.  You pull out of her gaping vag, eliciting a disappointed moan from Urta before Amily's bouncing reminds her just how much pleasure she's feeling.  Speaking of the mouse-girl, you grab her by the waist, slowing her rut just enough for you to get a good bead on her other, vacant hole.  With a wicked laugh, you slam your cock forcefully into Amily's ass, ");
	if (pc.cockVolume(x) > amily.analCapacity()) output("filling her until she just can't take any more of you");
	else output("burying yourself up to the hilt in her sweet, wonderfully tight bum");
	output(".");
	pc.cockChange();
	output("  She lets out a startled squeak at the sudden double-penetration.  You grab Amily's " + amilyTits() + " and start to pound her ass, burying your shaft in her at the apex of her grind atop Urta so that she's never without a nice cock deep inside her.\n\n");

	output("Urta is close to orgasm, and now under a twin-dick assault, Amily won't last much longer either.  Urta lets out a harsh growl and, grabbing Amily's hips, thrusts until her balls slap the bottom of your " + pc.cockDescript(x) + ".  You feel the force of her orgasm, the sudden heat inside Amily's fuckhole spreading right to your cock as Urta's foxy spunk starts spewing back out of Amily's twat.  You follow her example, plunging yourself as far into the mouse-girl as you can and cum, shooting your load straight up her ass until her tight, velvety walls are running white with your spooge.  Overwhelmed by the two jets shooting into her at once, Amily rolls her head back and screams, clamping down hard on the cocks inside her");

	//if Futamily:
	if (amily.hasCock()) output(" as her cock orgasms, too, spurting a nice, thick trail of mousecum all over Urta's face and tits");
	output(".\n\n");

	output("Now thoroughly filled with cum, Amily slides off your dick and Urta's, falling face-first between the fox-girl's soft tits.  Urta, covered in thick white cum, only laughs and wraps her arms around Amily, hugging her new fuckbuddy tight.  With a smile, you crawl into bed beside them, locking both girls in a tight embrace.\n\n");

	output("\"<i>That was wonderful,</i>\" Amily sighs, exhausted.\n\n");

	output("\"<i>Mmm,</i>\" Urta purrs, giving her ass a playful slap. \"<i>We gotta do this again sometime.</i>\"\n\n");

	output("You couldn't agree more.");

	processTime(25);
	pc.orgasm();
	//dynStats("sen", -2);

	clearMenu();
	addButton(0, "Next", urtaXAmilyAfterMurrrath);
}

//Urta/Amily -- [Use Vag]
public function urtaXAmilyCuntPussyVagSQUICK():void {
	clearOutput();
	output("You leap into bed with the girls, wrapping Amily tight in your arms, and give her a long, drawn-out kiss.  Before Urta can start complaining, however, you give her ass a playful swat and tell her to put that big, meaty horse-cock of hers to good use.  She nods eagerly and gets on her knees behind the two of you, stroking her horse-cock as she readies herself for the threesome ahead.\n\n");

	output("You brace yourself for penetration, but it doesn't come.  To your surprise, Urta thrusts forward and into Amily, grabbing the mousegirl's hips and ramming her schlong so far into the poor mouse's stomach that you can feel it pressing into you through her belly.  Amily's mouth opens as if to scream, but no sound comes out.  You take the opportunity to put your lips to hers, drawing her into a long kiss as Urta begins to fuck her hard and fast.\n\n");

	output("You wiggle underneath Amily, positioning your " + pc.vaginaDescript() + " right underneath Urta's thrusting horse-cock, letting the tingle of her shaft sliding across your lower lips bide you as Amily begins to gasp and moan.  You can see - and feel - the mouse-girl's stomach bulging and shifting with the mass of Urta's huge cock, doubling the strange sensation of Urta's cock running across your cunt's hole.  Amily lets out a shriek, and you can feel her cumming, contracting hard on Urta's dick, making the fox grunt with effort not to shoot her load on the spot.\n\n");

	output("Before you can truly get used to the sensation, it ceases completely.  You look up at Urta questioningly, only to see her massive cock suddenly withdraw from Amily and shoved into your gaping mouth.  You gag and struggle, but Amily, barely concious after her hard fucking, prevents you from going anywhere.  Urta grins, \"<i>Go on, lick the mouse's juices off me.  I want to be clean for you, lover.</i>\"\n\n");

	output("You are forced to suck Urta's cock or suffocate on it.  She shudders as your tongue rolls across her shaft, playing with the head and tickling her urethra.  You can still taste Amily all over her, a wonderful taste mixed with Urta's own sweat and musk.  You practically drink it up until Urta yanks her shaft out of your mouth.  You're almost giddy with anticipation as she runs it down your thigh and lines her horse-cock up with your " + pc.vaginaDescript() + ".\n\n");

	output("You groan as Urta slowly slides into you, filling your cunt until it's stretched to the limit to take your lover's massive equine dong.  She finally bottoms out, pushing into you until you feel her flared head pressing against your womb.");
	pc.cuntChange(0, urta.cockVolume(), true, true, false);
	output("  She grabs your " + pc.hipDescript() + " and starts to thrust, mercilessly hammering into you without respite until you're a moaning mess, panting like a whore as she jackhammers into you.  Your cervix feels like it could snap any moment, but it's a feeling of more pleasure than pain; your cunny contracts hard on Urta's cock, milking the already well-done fox for all she's worth until her tongue rolls out her mouth.\n\n");

	output("You grit your teeth as she makes one last brutal thrust into your eager womb and cums, spurting her scalding-hot horsemilk inside you. The sudden heat and force of her thick spunk flooding inside you sends you right over the edge - you cum, squeezing down on her deflating cock until it dribbles out its last drops of cum into you.\n\n");

	output("Now filled with cum, you roll onto your side, taking a now-sleeping Amily with you.  Urta crawls into bed after you, gently stroking your cheek and giving you little kisses on the shoulders and neck.  You don't even mind as her cum drips out of you onto the floor, mixed lewdly with your girlcum and Amily's.  Exhausted, you close your eyes to a final kiss from Urta.\n\n");

	output("\"<i>Mmm,</i>\" she purrs, giving your cheek a last stroke with her thumb.  \"<i>We gotta do this again sometime.</i>\"\n\n");
	output("You couldn't agree more.");
	processTime(25);
	pc.orgasm();

	clearMenu();
	addButton(0, "Next", urtaXAmilyAfterMurrrath);
}
//Urta/Amily -- Parting (First & Repeat)
private function urtaXAmilyAfterMurrrath():void
{
	clearOutput();
	output("You wake up later, still entwined with your cum-soaked lovers, smelling entirely of sex and sweat.  It's wonderful, in its own way. You gently wake the girls, and give each a kiss.  They giggle and moan, still sexually sensitive and not a little hungover.  All three of you spend the rest of the hour getting dressed, teasing and playing with each other until you finally must part ways.  You give the Captain of the Guard one last, long kiss before you and Amily make your way back to camp.");

	// Do all the shared shit here

	// Reset urta cumtimer
	//flags["COC.URTA_CUM_NO_CUM_DAYS"] = 0;
	//flags["COC.URTA_TIME_SINCE_LAST_CAME"] = 3+rand(4);
	//Enable threesome mode!
	if (flags["COC.AMILY_VISITING_URTA"] == undefined) {
		output("\n\n(<b>Urta unlocked in Amily's sex menu!</b>)");
		flags["COC.AMILY_VISITING_URTA"] = 4;
	}

	processTime(60 + rand(60));
	clearMenu();
	addButton(0, "Next", urtaXAmilyAfterMurrrath);
}

public function pureAmilyPutsItInYourRectumDamnNearKilledEm():void {
	clearOutput();
	var x:Number = pc.biggestCockIndex();
	output("You pause and flash her a coy smirk, then you gently place the tip of a finger on her nose, slowly running it down along her body, over her lip, between her breasts, across her stomach, finally stopping in between her legs, where you start to teasingly stroke her cock through her pants, letting it tent her clothing.\n\n");

	output("Before she can misunderstand your intentions, you lean ");
	if (pc.tallness >= 40) output("down ");
	else output("over ");
	output("and whisper in her ear where exactly you would like her to use her cock, which makes her cheeks grow hot with embarrassment.\n\n");

	//(1st time):
	if (flags["COC.AMILY_TIMES_BUTTFUCKED_PC"] == undefined) {
		output("\"<i>Seriously...?</i>\" she says, looking at you skeptically. \"<i>You want that?</i>\"\n\n");

		output("You nod to her, still idly stroking her through her pants, assuring her that that is exactly what you want.\n\n");

		output("\"<i>Well... okay. Wait here a moment though,</i>\" she says, turning to rummage through her alchemy supplies.  She pulls out a small tub and takes the cap off. Inside is a thick green salve that jiggles slightly when she shakes the container.  With a sheepish grin, she takes a small dollop of it into her fingers and begins to rub it onto her shaft.\n\n");

		output("You give her a slightly skeptical look, asking her what exactly is in that stuff, but she scoffs a bit and says \"<i>Relax, it's just a little burn ointment... Should do the trick though.</i>\"\n\n");
	}
	//(Else):
	else {
		output("\"<i>You want that?  Well... Okay,</i>\" she says, smiling a bit in spite of the rosy blush covering her face.\n\n");

		output("She turns around, rummaging through her things and emerging with the strange green salve, popping the cap off and running her fingers through it a bit.  As you begin to undress, she starts to rub the ointment onto her shaft, shivering visibly from its cool touch.\n\n");
	}
	//(Merge):
	output("Working delicately, she carefully coats her shaft in a generous layer of the green ointment, until her cock glistens with an odd greenish sheen.  You take your position on the ground, lowering yourself down onto your knees and elbows, resting your chin on top of your hands and raising your " + pc.buttDescript() + " into the air");
	if (pc.hasTail()) output(", moving your tail out of the way");
	output(".\n\n");

	output("Amily ");
	if (flags["COC.AMILY_TIMES_BUTTFUCKED_PC"] == undefined) output("looks a bit puzzled as she contemplates the mechanics of this for a moment, and then with a shrug, ");
	output("takes her place behind you, running her shaft between your buttocks a bit to spread the slick lubricant around.\n\n");

	if (pc.analCapacity() < amily.cockVolume() * 0.75) output("Bracing yourself a bit, you grimace a little as you feel Amily start to push against your " + pc.assholeDescript() + ", just the tip sliding in with a bit of resistance.");
	else if (pc.analCapacity() < amily.cockVolume() * 1.33) output("You relax yourself, letting out a husky moan as you feel the tip of Amily's cock sliding into you.");
	else output("Amily lets out a slightly surprised squeak as your " + pc.assholeDescript() + " offers her little resistance.");
	
	pc.buttChange(amily.cockVolume(), true, true, false);
	
	output("  The ointment does its job admirably, allowing Amily to penetrate you fully with no pain whatsoever");
	if (pc.analCapacity() > amily.cockVolume() * 1.5 || pc.ass.wetness() >= 2) output(", though you are sure you could easily handle her without it");
	output(".  Slowly, she begins to rock her hips back and forth, placing her hands on your " + pc.hipDescript() + " for support.");
	output("\n\n", false);

	if (flags["COC.AMILY_TIMES_BUTTFUCKED_PC"] == undefined) output("\"<i>Is this okay? Ah... it feels... really good...</i>\" she says with a low moan, to which you reply with a pleasure-filled groan of your own.\n\n");

	output("You begin to push yourself back against her slow thrusts, and, encouraged by your actions, she starts to pump a little harder.  Sliding herself down along your back, she begins to nuzzle into your neck, stroking your sides sensually as her " + amilyHips() + " rise and fall against you.");
	if (pc.hasCock()) {
		output("  You can feel her hand slipping down underneath you, gripping your " + pc.cockDescript(x) + " gently and starting to stroke and tease it with her fingertips.");
		if (pc.cockTotal() > 1) output("She brushes along [pc.eachCock] one at a time, stroking for a moment or two before switching off.");
	}
	output("\n\n", false);

	output("It isn't long before Amily's sensual thrusting and touching has you on the precipice of your orgasm, and you voice your pleasure loudly, digging your fingertips into the ground and moaning.");
	if (pc.hasVagina()) {
		output("  Sexual fluids ");
		if (pc.wetness() <= 1) output("drip ");
		else if (pc.wetness() <= 3) output("dribble ");
		else output("gush ");
		output("down your thighs");
		if (pc.hasCock()) output(" and p");
	}
	if (pc.hasCock()) {
		if (!pc.hasVagina()) output("  P");
		output("recum dribbles from your [pc.cocks]");
	}
	if (gender(pc) > 0) output(", forming a small puddle underneath you as you feel your climax approaching.");
	output("  With a tremendous shudder, you orgasm, your " + pc.assholeDescript() + " clenching around her member.  At the same time, Amily moans into your ear, warm ribbons of herm-jizz filling your innards.");
	if (pc.hasCock()) {
		output("  [pc.EachCock] twitches with pleasure, soaking the ground beneath you with ");
		if (pc.cumQ() < 250) output("a few streams");
		else if (pc.cumQ() < 500) output("a small deluge");
		else output("a small lake");
		output(" of cum.");
	}
	output("\n\n");

	output("With a shuddering sigh, Amily dismounts you, and you roll onto your side next to her, reaching back to caress her cheek and tell her how wonderful she did.  She wraps her arms around you, hooking a leg around your waist softly, and the two of you lie there and cuddle for some time.\n\n");

	output("\"<i>Mm... you know... maybe we should do this again sometime,</i>\" she says with a devious smirk, kissing your cheek.");
	IncrementFlag("COC.AMILY_TIMES_BUTTFUCKED_PC");
	processTime(18);
	pc.orgasm();
	//dynStats("sen", 1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

private function fuckPureAmilysHeiny():void {
	clearOutput();
	var x:Number = pc.cockThatFits(amily.analCapacity());
	if (x < 0) x = 0;
	output("You pause and flash her a coy smirk, then you gently place the tip of a finger on her nose, slowly running it down along her body, over her lip, between her breasts, across her stomach, finally stopping to firmly grip her " + amilyButt() + ".");
	if (amily.hasCock()) output("  Her pants tent from arousal as her male organ reacts to your sensual touching, and you start to teasingly stroke it as well.");
	output("\n\n");

	//(First Time):
	if (flags["COC.TIMES_FUCKED_AMILYBUTT"] == undefined) {
		output("She looks ");
		if (pc.tallness >= 60) output("up ");
		else if (pc.tallness <= 40) output("down ");
		output("at you with a slightly puzzled look in her eye, and you try as casually as you can to bring up the subject of anal sex.  You ask her if she's ever considered it, and tell her it could be fun.\n\n");

		output("\"<i>I... I mean, you want to put your... in there?</i>\" she says, her brow furrowed a bit.  You are worried for a moment that you may have stepped over a line, but she slowly tilts her head, giving you a bit of a shrug and a contemplative grimace.\n\n");

		output("\"<i>Well... I had never really considered it up until now, but... if you're sure that's what you want,</i>\" she says, her lips pursed a bit as she mulls it over.\n\n");

		output("You smile broadly, nodding, and assure her you'll be gentle as you begin to strip out of your [pc.gear].\n\n");

		output("\"<i>Woah, woah, hold on there,</i>\" she says, putting up a hand gently to halt your eager advances.  \"<i>I said I'd do it, but you're not coming in the back door without greasing the hinges a bit first.</i>\"\n\n");

		output("You reign yourself in, nodding in understanding.\n\n", false);

		output("\"<i>Hang on, I think I've got just the thing...</i>\" she says, rummaging around through some of her alchemy supplies.  She pulls out a small tub, taking the cap off.  Inside is a thick green salve that jiggles slightly when she shakes the container.  With a smile, she takes a small dollop of it into her fingers, and then holds her other hand out for your " + pc.cockDescript(x) + ".\n\n");

		output("You recoil a little, knowing full well the kinds of effects unfamiliar chemical concoctions could wreak upon your body, but then mentally scold yourself for doubting Amily for a moment.\n\n");

		output("She rolls her eyes a bit and snatches up your " + pc.cockDescript(x) + " a bit possessively, laughing to herself.  \"<i>Oh relax, you big baby. It's just burn ointment. It should serve well enough, though.</i>\"\n\n");
	}
	//(Else):
	else {
		output("She smirks back at you just as coyly, trailing her fingers up your chest and laying a small kiss on your cheek.  \"<i>Oh, you're in the mood for that sort of thing again, are you?</i>\"\n\n");

		output("You nod, affirming that that is indeed what you were in the mood for, chuckling a bit at your unspoken bond with the cute mouse girl.\n\n");

		output("She gently breaks away from you, bending down to rummage through her things and giving you a teasing view of her rear in the process.  When she returns to you, she has a tub of green salve in hand, taking a small dollop of it into her fingers, her other hand idly stroking your " + pc.cockDescript(x) + " and drawing you up to full mast.\n\n");
	}
	//Merge):
	output("As she touches the cool salve to your shaft, you let out a small shiver.  Her hands work delicately, spreading a thin layer across your entire length, until your " + pc.cockDescript(x) + " glistens with a glossy, greenish sheen.\n\n");

	output("She wipes her hand off on a discreet corner of her " + amily.armor.longName + " and begins to shimmy out of them.");
	if (flags["COC.TIMES_FUCKED_AMILYBUTT"] == undefined) output("  \"<i>I'm... not really sure how this goes... I guess... like this?</i>\"");
	output("  Turning around, she lowers herself onto the ground carefully, her whiplike tail raising out of the way as she slides onto her knees and elbows.\n\n");

	output("Your hand cascades over her " + amilyHips() + ", sliding up to take a handful of her " + amilyButt() + " and massaging her lower back sensually.  Sliding a finger along your shaft, you take a small amount of the lubricating salve and rub it into the quivering ring of flesh between her cheeks.  Amily releases a slight moan, shuddering from the cool touch, and lets out a sharp squeak as you push the first section of your finger past her anus, spreading the lubrication around the first inch of her tight rear passage.\n\n");

	output("She shudders and lowers her chin to the ground as you pull your finger out, raising her rump a little as you begin to run the head of your " + pc.cockDescript(x) + " over her pucker, easing forward.  You build pressure very gradually until you feel the tight entrance start to give way, and slowly begin to sink forward into her rectum.");
	pc.cockChange();
	output("\n\n");

	if (flags["COC.TIMES_FUCKED_AMILYBUTT"] == undefined) output("\"<i>Aah... ah... that feels really weird,</i>\" she pants, noticeably struggling against the instinct to clench up against the invader. \"<i>Ah... not... bad... just weird...</i>\"\n\n");
	else output("\"<i>Ahhn... it's still weird... but I just might be starting to like it...</i>\"\n\n");

	output("Once you are sufficiently buried in her rear passage, you lower yourself down, conforming to the curve of her back.  Brushing her hair aside a little, you plant a few soft kisses along the edge of her jawline, being very careful to control your movements so as to spare her any pain.  As you ease into a very slow, gentle pace, you both begin to voice your pleasures, breathing heavily.\n\n");

	output("Your hands slide along Amily's sides, gently pressing into her flesh and eliciting soft moans and squeaks from her, while your hips rise and fall against hers at an even, metered pace.  You can feel the walls of her passage clenching rhythmically against your shaft, the muscles of her anus squeezing you with each gentle thrust.  The ointment does its job admirably, easing every movement; without it you have your doubts whether Amily's rear would be so readily accepting of your " + pc.cockDescript(x) + ".\n\n");

	output("\"<i>I think you can go faster, now...</i>\" Amily says breathlessly, smiling back at you as you run your fingers lovingly through her hair.  Nodding a little, you hook your elbows underneath her arms, hugging against her back, and begin to slowly ramp up the pace.  Amily's moans grow more passionate as your motions become more deliberate, but she doesn't seem to be experiencing any discomfort, thankfully.\n\n");

	output("Her hands clasp around yours under her chin, and she closes her eyes, gently biting her lower lip, even rocking her hips a little now to supplement your movements.  In spite of the slow, gentle pace, or perhaps in part because of it, you can start to feel a quivering in your loins marking the approach of your orgasm.\n\n");

	output("You close your eyes and let out a shuddering moan into Amily's ear as your climax comes rushing forth, ");
	if (pc.cumQ() <= 250) output("your " + pc.cockDescript(x) + " twitching and throbbing as you paint her insides with a few strands of cum");
	else if (pc.cumQ() <= 500) output(" the swell of your orgasm pushing past her sphincter as you unload a thick deluge into her back door");
	else output(" the volume of your virile jism filling her innards with warmth as she begins to gain a slight bulge in her abdomen");
	output(".  Being stimulated in such a way is not enough to give Amily a complete release, but the sensation of your warm [pc.cumNoun] filling her rear is enough to make ");
	if (amily.hasCock()) output("her own member twitch and dribble a small puddle of clear pre-cum onto the ground below her, joining with ");
	output("a noticeable trail of juices gradually sliding down her thighs.\n\n");

	output("You very carefully pull back, Amily drawing a sharp intake of breath when you are fully freed from the grips of her pucker.  Gently sliding down alongside her, you draw her into a warm embrace, cuddling with her for a long while afterward");
	if (pc.cumQ() > 500) output(" and gently stroking along the curves of her belly with a smile");
	output(".");
	processTime(28);
	pc.orgasm();
	//dynStats("sen", -2);
	IncrementFlag("COC.TIMES_FUCKED_AMILYBUTT");
	addButton(0, "Next", mainGameMenu);
}

//Scene 2: Amily Teaches Grown Corrupt Mice How To Sex (Z)
private function amilyIncest():void {
	clearOutput();
	amilySprite();
	//AKA:
	//output(Fen gets donated to write something that makes him moderately uncomfortable.)
	output("When you go looking for Amily, you find her on the edge of camp, talking with three of her offspring.  The purple-");
	if (amily.hasFur()) output("furred");
	else output("haired");
	output(", heavily corrupted mice have matured into adults, as evidenced by their larger size and MUCH bigger endowments.  The whole spectrum of genders is represented - a well hung male, a huge-breasted female, and a herm who seems to have picked up a giant, knotty dog-dick at some point.  The male has long hair and a goatee, lending him an air of wisdom, even as he struggles not to jack off his foot-long, phimotic cock at the sight of his slutty mother.  The sister is completely nude, and she doesn't seem to mind in the slightest.  Her massive breasts sway pendulously, and with a start, you realize she's got a visible baby-bump half hidden underneath the well-developed mammaries.  She keeps glancing the herm's way and rubbing her fingers across the taut ");
	if (amily.hasFur()) output("fur");
	else output("skin");
	output(".  You suppose that with so much corruption coursing through them, incest really wouldn't bother them in the slightest.");
	output("\n\nThe herm is cuddling up next to Amily and smearing ropes of doggie cum ");
	if (amily.hasFur()) output("through her mother's fur");
	else output("over her mother's thigh");
	output(" as the latter lectures about pleasing her [pc.master].  Amily, for her part, just seems to be getting wetter and wetter, but she somehow controls herself.  When her three children aren't casting anxious, lewd glances at themselves or their mother, they're nodding vigorously at her words.  Clearly, the trio is as excited with the prospect of serving you as their mom.");
	output("\n\nNone of them are aware of you yet.  You could duck out before they find you and avoid any potential incest, or you could take the sluts for a ride.  What do you do?");
	clearMenu();
	addDisabledButton(0, "Fuck Cunts", "Fuck Cunts", "This scene requires you to have fitting cock.");
	addDisabledButton(1, "Fuck Em All", "Fuck Em All", "This scene requires you to have fitting cock.");
	if (pc.cockThatFits(amily.vaginalCapacity()) >= 0) {
		addButton(0, "Fuck Cunts", fuckIncestCunts, false);
		addButton(1, "Fuck Em All", fuckIncestCunts, true);
	}
	addButton(14, "Leave", mainGameMenu);
	//[Get doubleteamed {Vag req}] [Fuck Cunts] [Fuck 'Em All][Skedaddle]
}

//Fuck Cunts/All (extra pg or two) (Z)
private function fuckIncestCunts(all:Boolean):void {
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	if (x < 0) x = 0;
	var y:Number = x + 1;
	clearOutput();
	amilySprite();
	output("You step up and ");
	if (!all) output("tell Amily to send the male away - you've got pussies to fuck.  She squeaks in excitement, barely noticing as her son tramps off.");
	else output("tell Amily to get ready - you're going to fuck each of them full of their [pc.master]'s [pc.cum].  She squeaks in excitement, her nipples visibly puckering.");
	output("  Amily takes the girl's hand and passes her your way.  The younger mouseling's baby-bump looks more and more prominent as she's brought close.  Milk starts to drip from her huge, leaking nipples as she looks ");
	if (pc.tallness >= 48) output("up ");
	output("at you and says, \"<i>Hey, " + pc.mf("Dad", "other Mom") + ", go ahead and put it in.  I've been wanting this since the first time I saw you.</i>\"");
	output("\n\nYou shrug out of your [pc.gear] to let [pc.eachCock] spring free.  Your assembled offspring gasp as one.  You see ");
	if (amily.hasMuzzle()) output("muzzles");
	else output("mouths");
	output(" watering with tongues hanging lewdly as they take in your [pc.multiCocks].  Your daughter rubs up against you, her tail encircling [pc.oneCock] as she dances and grinds into you.  Female lubricant spatters the ground beneath her as you reach forward to take her huge melons in your hands.  The nipples are big enough to grab, like tiny cow-teats, and when you take hold, they both let out large streamers of milk, to the delight of their owner.  Your daughter moans out loud and begins jerking [pc.oneCock] with slow, practiced motions of her tail.  Crushing against you, the mousette's thick, soft ass heats against your " + pc.skinFurScales() + ".");
	output("\n\n\"<i>That's a good girl,</i>\" Amily whispers encouragingly into her daughter's large ears.  The young, pregnant slut nods and pulls away, leaning forward to properly present her soaked twat to you.  Her tail wraps a few more loops around your [pc.cock " + y + "] and gently tugs as she looks back over her shoulder, eyes lidded and her tongue drooling.  She asks, \"<i>Please, take me... " + pc.mf("daddy","mommy") + ".</i>\"");
	output("\n\nAs if you could resist such a polite (and enticing!) request.  You take the gravid girl's wide hips in hand, and give her exactly what she wants.  One moment, you're looking down at her, swollen tits and all, and the next, your [pc.cock " + y + "] is enveloped in tight, wet flesh.  Your daughter squeaks with joy at being filled, and gently squeezes down on your [pc.cock " + y + "] encouragingly.");
	output("\n\nYou take her drippy teats in hand and compress, expressing a thick flow of alabaster as you begin to properly fuck your daughter.  She squeaks appreciatively and bumps her bouncy bottom against your [pc.hips], rolling her juicy thighs up and down and giving you a little bit of a show.  You slap her ass and watch the flesh ripple from the blow, a delightful prelude to what's to come.  Then, returning to expertly milking her incredible jugs, you start to move your hips to your daughter's tempo.  Her cunny makes wet squelches with each piston and rhythmically clamps down on you, trying to milk your [pc.cock " + y + "].  You grunt from pleasure and pick up the pace, ignoring her slower, weaker rhythm.");
	output("\n\nThe knocked-up little slut squeaks and moans from each ass-jiggling thrust, wailing happily as her cunny is thoroughly plowed by her parent.  She begs, \"<i>Fuck me harder, " + pc.mf("daddy","mommy") + ", fuck me full of cum.  Screw me so good I come crawling back to make you more children!</i>\"");
	output("\n\nYou hump her faster, slick fluids splattering your [pc.legs] with each thrust.  The rest of the family is looking on, watching quietly and touching themselves.  Amily is right next to her daughter, whispering encouragements into her ear idly, stroking herself as she does so.  She shudders when that same daughter latches on to one of her hard nipples but goes right back to instructing in between excited moans.  Your hermaphrodite 'daughter' has her fingers wrapped around her sheath, just underneath the tiny swell of her uninflated knot.  She's circling the pointed tip with a finger, teasing herself as she awaits her turn.");
	output("\n\nWhile you're watching her, the herm gives you a sultry wink and pleads, \"<i>Please, cum in my sis, cum in her now.  I need you inside me... I need you fucking me until I'm soaking myself in my thick doggy-cum.  Don't you want to see, " + pc.mf("dad", "mom") + "? </i>\"  She smiles knowingly when you're forced to break eye contact by your clenching, arching body.  Cum bubbles from your [pc.cock " + y + "] to fill your writhing, ecstatic daughter with seed.  Her soaked little pussy squeezes and gushes rivulets of mixed spunk onto your [pc.legs] as it contracts about you, trying to wring you dry, but with her womb blocked, all it does is squirt jism back out her entrance to drip from your loins");
	if(pc.balls> 0) output(" and [pc.balls].");
	output(" Unintentionally, your hands find her nipples and squeeze hard, sending thick runnels of mouse-milk to muddy the ground.");
	output("\n\nThe pregnant slut beneath you slips off your [pc.cock " + y + "] as her legs give out, her body splaying obscenely.  She whimpers, \"<i>So good... I wish you could make me pregnant... " + pc.mf("Dad","Mom") + "</i>\".");
	output("\n\nSighing, you crook your fingers at Amily and the hermaphrodite.  They approach you reverently, and when you indicate that they should attend to your flagging erection, the two corrupt sluts exchange looks of glee.  Two wide-open maws descend upon [pc.eachCock], licking and sucking, squeezing and slurping.  They hastily devour your leftover, wasted sperm and ravenously swallow the tangy pussy-juice that still drips from you.  Looking down, you see four large breasts - two pairs of delicious bosoms - mashed together, milk lubricating them as they slide over each other.  [pc.EachCock] surges forward as you watch, ready to go again.");
	output("\n\n\"<i>It looks like [pc.Master] is ready now.  Go on,</i>\" Amily says, stepping back to leave you alone with your 'daughter'.  Before you can act, she leaps into your arms, her tiny-but-well-endowed frame perfectly sized to rest in your arms.  She smoothly pivots her hips to accept your [pc.cock " + y + "], and though her pussy isn't quite the sopping-wet love-tunnel of her sister, the herm makes up for it with enthusiasm.  She wraps her arms around your shoulders, ");
	if(pc.cockTotal() > 1) output("her red, knotted tool bobbing and weaving against the remainder of your [pc.multiCocks].");
	else output("her red, knotted tool bouncing between your bodies.");
	output("  Moaning as she holds tight, the most unusual of your offspring begins to drip warmth against you.");
	output("\n\n\"<i>So good... I can see why you'd make Mom want to have your cum inside so badly,</i>\" she says, starting to bob and grind against you.  Every time she allows herself to bottom out on your [pc.cock " + y + "], a jet of pre-cum messily sprays her underboobs.  It drips down as she fucks you, but you grow tired of the burgeoning mess growing between your bodies and spin her around to face her mother.  Amily watches lustfully as you plow her daughter's snatch, the red doggie dong just inches away and dripping with pre-seed.");
	output("\n\nYour corrupted mouse-slave licks her lips and pounces onto the two of you, overbalancing you both, and you fall to the ground, still joined at your surging, eager genitals.  You growl Amily's name, confused and irritated, but a muffled squeak of pleasure from your daughter alerts you to what's just happened - Amily has mounted her!  Your hermaphrodite daughter is sandwiched between her parents, fucking both of them simultaneously.  She's moaning deliriously and making out with her mother, their tongues sliding in and out of mouths, occassionally licking across puffy lips.  Nearby, your other slutty offspring is still partially insensate, cradling her belly with legs locked together.");
	output("\n\nAmily breaks off the kiss with your daughter to say, \"<i>Let me show you the proper way to use a tail.</i>\"  The hermaphrodite gasps at some unseen action.  Her pussy tightens incredibly, and you hear her moan out loud.  A second later, a thin, murine tail whips around the base of your dick.");
	output("\n\n\"<i>W-what are you...OOOOOOOH!</i>\" the mousette screams.  Your daughter wasn't just using her tail as a cock-ring - she reached the whole way back to peg her mother with it!  It squirms around inside Amily, stroking her innards, even as it coils around your [pc.cock " + y + "] like a snake.  At the bottom of the pile, you have the luxury of setting the pace, and even though you've cum once already, you feel anxious to do it again.  You thrust your hips hard, hard enough to bounce the girls on top of you, breast-flesh squishing and juices drooling.");
	output("\n\nSweaty arms cling and rub over all three bodies, until you lose track of whose limbs belong to whom.  Instead, you focus on the pounding rhythm you're hammering through your [pc.legs], the wet squish of your member plowing through your own offspring's naughty folds.  The nagging thought that you're moments away from impregnating your own offspring surfaces but only manages to excite you that much more, the taboo of the act filling your loins with the burgeoning warmth of a fast-approaching orgasm.  The mouse in the middle begs, \"<i>Fuck yes!  Give it to me!</i>\" and squeezes your shaft affectionately with her tail as she cums, the tip waving wildly in Amily's asshole.");
	output("\n\nYou grab the closest pair of hips and ram your cock hilt-deep inside her as you cum.  She wails through her climax, her cunny clenching nice and tight to squeeze the first rope of jism from you.  It surges through you to spatter against her cervix, and as the next jet erupts, you're sure that some of her own must be flooding through her urethra.");
	if(pc.cumQ() > 500) output(" You just keep cumming and cumming, and you almost wish you could see the cum filling her belly and flooding from her nethers.");
	if(pc.cumQ() > 1500) output(" Even so, her belly pudges out a bit, and you realize she must look extraordinarily pregnant from any other angle.");

	output("\n\nAmily gasps, \"<i>Gods,</i>\" and rolls to the side, the still-inflated knot in her cooch taking your daughter with her.  Now that you've been freed from the extra weight, you catch your breath and sigh as the mousy fluids soaking your body start to dry.  You glance to the side, and see Amily and your daughter ass-to-ass on all fours.  [if (cumQuantity > 500) \"The younger girl's belly is wonderfully filled with cum, hanging nice and low.  \"]Amily's belly appears to be slowly growing and ballooning.  She's nervously trying to pull away, but your daughter's knot holds her there, trapped and unable to do anything as the sticky animal-sperm floods her once-pure womb.");
	//{Phimosis boy buttfuck optional)
	if (all) {
		output("\n\nYou realize you haven't been entirely drained, and you beckon for the male mouse.  His hole ought to be tight enough to milk the last of your seed from your [pc.balls].  He looks at you hopefully, but you sit up and point at him, then your slightly-flagging dick.  The recently-of-age male sighs and kneels between your legs and gets to work.  Though he clearly wants nothing better than to masturbate or start fucking you, he proves as obedient as his mother and slurps his sister's filth from your dick.  A trickle of boy-slime dribbles onto your leg as he bobs up and down, his purple hair obscuring most of his ");
		if (amily.hasMuzzle()) output("muzzle");
		else output("face");
		output(" from your view as he sucks you.");
		output("\n\nSoon, your erection is nice and hard, gently throbbing on your boy's tongue.  He wraps his soft, pink fingers around your shaft and starts stroking you - it's clear he thinks he's going to be giving you a blowjob to completion.  Well, none of that; you've got at least one more jizz-bomb to drop, and you want something tighter!  You grab your vermin progeny by his purplish hair and yank him back, shoving so hard he falls onto all fours and gasps in distress.  As you'd expect, his ass is cute and pert, with a puckered pink hole just begging for you to violate it.  His giant, foreskin-clad cock drags through the dirt, smearing his pre-cum behind it as he begins trying to crawl away from you.");
		output("\n\nYour jump him before he can get away, pinning him beneath your form, [pc.oneCock] bouncing between his cheeks as you line it up.  He protests, \"<i>Noo!  N-not my ass!  Not there, " + pc.mf("Dad","Mom") + "!</i>\"  You tell him to be quiet and enjoy it, and surprisingly he does, as if secretly waiting for the word of command.  The mouse's rectum clenches tightly when you push against it, but with a few gentle prods, you slowly get the nervous hole to relax enough for your [pc.cockHead " + y + "] to slip inside.  Your son gasps from sudden discomfort, but as you pull him back into your lap, you can hear a hint of pleasure in his protests.");
		output("\n\nHe slowly settles into your lap, no longer fleeing, and you're given your first good look at his cock when you glance around his shoulder.  It's VERY thick for its size, and you can see his foreskin shining dully, obscuring all but a small circle that surrounds his cum-slit, which currently beads pre-cum at an alarming rate.  Gently, you take his dick in your hand and pull back, stroking him slowly every time he moves up or down.  The little bitch gets the idea pretty quickly and begins to bounce on your cock like a whore in heat.  Your reacharound winds up going so fast that his foreskin peels back, revealing the little mouse's shiny, cum-slicked cockhead.");
		output("\n\n\"<i>Oh, f-f-fuck, " + pc.mf("Dad","Mom") + ", you're gonna m-m-make me cum!</i>\" he moans.  You let go of his dick and spank his ass, not wanting him to blow until you've had a chance to stuff his pert, femboy asshole full of spunk.  He hisses in displeasure, but begins to bounce faster, smashing his prostate into your [pc.cockHead " + y + "] over and over again in an attempt to get off hands-free.  His frenzied thrashings awaken a trembling, budding pleasure, familiar to you at this point as the beginning of an orgasm, and as you clench, you have to wonder if he'll manage to get off at all.");
		output("\n\nQuivering tightly around your [pc.cock " + y + "], the mouse-boy's nicely-stretched anus fills with heat from the sudden cum-injection you give it.  You can feel the thick fluid sloshing about inside him, and as you jet lance after lance of hot jizz into his asshole, he begins to clench repeatedly, as if milking your dick.  A second later, your son's now-exposed glans flares wide and erupts, firing a torrent of thick, corrupted mouse-cum directly into the purple-haired slut's own face.  He takes it happily, tongue lolling as it fills his mouth and drenches his hair.  It geysers up like that, wave after wave of white sticking to him as your dick squeezes it out of his core.  Soon, your son's spunk fountain dies down, and he lets out a few pathetic squeaks of joy.");
		output("\n\nIt isn't until he tries to stand on wobbly legs that you realize how thoroughly worn out you are, and as you flop onto your side, you're treated to the sight of your spunk ");
		if (pc.cumQ() < 200) output("drizzling ");
		else if (pc.cumQ() < 500) output("raining ");
		else if (pc.cumQ() < 2000) output("pouring ");
		else output("spraying ");
		output("down to the ground.  Clearly, your boy needs some training in how to hold his cum.  You close your eyes and doze, feeling as sated as you are tired.");
	}
	else {
		output("\n\nIt isn't until you try to stand that you realize how thoroughly worn-out you are, and as you roll onto your side, you close your eyes and doze, watching cum squirt out of Amily's pussy from around your daughter's knot.");
	}
	amilyPreggoChance();
	processTime(45);
	pc.orgasm();
	//dynStats("lib", -1, "sen", -1);
	pc.slowStatGain("l", -1);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//First talk: Finished (Bagpuss)(Zedited, but no followups are ready yet)
//Scene triggers the first time you approach Amily with eggs to lay
private function amilyEggStuff():void {
	clearOutput();
	output("As you approach the mouse-woman, her big, hairless ears twitch and she turns to face you with a smile.  However, before she can open her mouth to greet you her eyes settle on your slightly bulging abdomen.");
	output("\n\n\"<i>[pc.name], are you alright? You're looking a little... bigger back there.</i>\"  As if on cue you feel your abdomen throb slightly, sending a shudder of pleasure up your back as it lets you know that you're more than ready to lay your next clutch of eggs.  Amily's mouth scrunches up as you steady yourself, apparently finding your predicament a little puzzling.  \"<i>You know, you don't have to eat <b>everything</b> you find out there; it looks like it's starting to have quite the effect on you.</i>\"");
	output("\n\nA smirk crosses her face as you tremble again, another bolt of ecstasy surging through you.  \"<i>Seems like you'll need to take care of that soon, else who knows what might happen?  I'm sure there's plenty of room around here for you to dig a hole and... relieve yourself.</i>\"  She chuckles to herself as a moan escapes your lips");
	//if (gender(pc)> 0) {
		////(if sexed)
		//output(", your [if (hasCock = true) [pc.cock] stiffening][if (isHerm = true)  and ][if (hasVagina = true) [pc.vagina] starting to burn with need]");
	//}
	output(" whilst your body instinctively reacts to the pleasure it's feeling, ovipositor slowly thickening as it pulses with need.");
	output("\n\nAmily's right; you do need to relieve this achingly good pressure, but when you think about just wasting your eggs in a muddy ditch a flash of inexplicable unease runs through you.  No, you need something... some <b>one</b> to carry your eggs.  Wait, didn't Amily say that she's done this before?  You swear you remember her talking about her encounters with the bees, exchanging 'favors' for honey.");
	output("\n\n\"<i>Well...  yes,</i>\" she replies slowly, as if a little apprehensive of where you're taking the conversation.  \"<i>I only did it when I was desperate for food though; it's not like I was heading over there every week to get topped up!</i>\"  Amily's voice gets ever-higher as she speaks, sounding a little indignant.  You try to gauge her reaction, the lack of a frown on her face telling you that she's overacting at least a bit.");
	output("\n\nYour abdomen twitches at the mention of her previous encounters; it seems as though just thinking about laying your eggs is enough to get you horny at this point.  As you whine pathetically, your ovipositor starts to slide out of your abdomen, drizzling fluid onto the ground as a painfully obvious indicator of how aroused you are.  Amily bites her lip, eyes widening as she starts to understand exactly how much this is affecting you.  Putting on your best puppy-dog eyes");
	//if dogmorph
	if (pc.canineScore() >= 4) output(", which you know for a fact are <i>very</i> good,");
	output(" you gently take her hand and ask if she can help you out, explaining that you're not sure whether you can take care of it yourself and going out exploring in such a state could end badly.  Seeing her brow wrinkle as you explain, you add that she probably has more experience with this sort of thing than you do.");
	output("\n\n\"<i>Damnit, [pc.name].  You know that this isn't what I meant when I asked to have children with you, right?</i>\"  Despite her begrudging tone, her tail flits back and forth excitedly ");
	//if amily = herm
	if (amily.hasCock()) output("and you notice a growing bulge in her trousers");
	output(".  Looks like you aren't entirely twisting her arm to get her to go along with this.  \"<i>Fine, I'll help lighten that load you've got, just...  don't expect me to help out as much around camp if I'm full of eggs.</i>\"");

	output("\n\nBefore she can move away you quickly wrap your arms around her, pulling the mousegirl into a deep kiss.  She grabs you around the neck, pressing her body against you as your tongues wrestle.  Amily coos slightly as you rub her back and you break the kiss, whispering your thanks for being such an accommodating lover.  She gives you a final peck before heading back to her bedding, a small smile on her face.");

	output("\n\n\"<i>Whenever you're ready, I suppose.</i>\"");
	flags["COC.AMILY_OVIPOSITION_UNLOCKED"] = 1;
	//Unlocks 'Eggs' option in Amily's 'Make Love' menu
	//Amily menu
	processTime(8);
	amilyMenu(false);
}

//Eggs
public function layEggsInAmily():void {
	clearOutput();
	output("Feeling your ");
	if (pc.eggs < 20) output("engorged");
	else if (pc.eggs < 40) output("heaving");
	else output("unbelievably swollen");
	output(" abdomen stir your mind drifts back to Amily's offer.  Dipping into her neck, you start to kiss her softly as your ovipositor begins to thicken, slowly peeking out into the air.  She shivers in your arms, your hands sliding around her sides to pull her close.  Barely able to pull your lips away, you nip along her jaw as you ask her if she's up for a little egging.");
	output("\n\n\"<i>I suppose I could be persuaded, you <b>do</b> look like you need a little attention...</i>\"  You feel a hand slipping down into your [pc.gear] as she cranes her neck, moaning quietly as her searching fingers find their way to your [pc.crotch], teasing you into unconsciously humping against her slender digits.");
	if (flags["COC.AMILY_INCUBATION"] != undefined) output("  \"<i>But try to remember that I'm already carrying.  I don't want it getting too cramped in there; so make sure you don't miss, alright?</i>\"");
	output("\n\nYour try to clear your mind as the pleasure starts to overwhelm you, ovipositor extending fully whilst you attempt to focus and decide how to proceed.");
	processTime(3);
	//[Anal]
	clearMenu();
	addButton(0, "Next", layEggsInAmilysCorruptedHole);
}

private function layEggsInAmilysCorruptedHole():void {
	clearOutput();
	output("Still groaning as Amily caresses your body, you make sure that you have a good grip around her waist before suddenly pulling her down to the ground.  She squeaks as you descend, though her hand doesn't leave your leggings.  Lying on your back, Amily props herself up on your chest with her free arm, trying to frown but unable to keep a playful smile off her lips.");
	output("\n\nYou set to work freeing her from her trousers whilst she loosens your own leggings, dragging them down to reveal your [pc.crotch], your bulging ovipositor fully emerging at the same time.");

	output("\n\n\"<i>Looks like someone's excited; you must really enjoy the idea of filling me with eggs.</i>\"  Amily's voice is playful as her fingers trace over your lower stomach, clouding your mind with bliss as she avoids caressing your needy nethers.  However, as you finally strip her leggings it quickly becomes clear that she's as ready as you are, the sight of her flushed labia glistening with a wet sheen");
	if (amily.hasCock()) output(" and her erect shaft shuddering as it throbs in the air");
	output(" telling you everything.  You ask her if she's sure she isn't projecting just a little, the mousegirl blushing furiously as she sheepishly nods, a demure smile spreading across her face.");
	output("\n\nWith her reddened lips ");
	if (amily.hasCock()) output("and stiff cock ");
	output("exposed Amily positions herself below your hips, settling gently on your thighs with her firm cheeks resting on your egg-filled abdomen.  You gasp as her tail flits across the sensitive surface, before it gently wraps around your slick, aching ovipositor.  She smirks at you as the pressure on your shaft increases, turning your gasp into a long, drawn out moan that leaves you thrusting uselessly into the air, your body shuddering with ecstasy.");
	output("\n\nYou grip her by the waist, holding her in place as you try to position your insectile half.  Amily moans as your ovipositor brushes between her cheeks in search of an entrance, her lower body jolting forwards in response to the unexpected contact.  Her hot sex presses wetly against ");
	if (gender(pc) > 0) output("yours");
	else output("your groin");
	output(" with the rolling of her hips, making you both cry out as you connect.  She looks down at you, eyes half-lidded with pleasure, arms shaking as she holds herself up on your chest.  Biting her lip she starts to grind in earnest, pressing herself against you as hard as she can, her rear teasingly rubbing against your egg-shaft with each thrust.");
	output("\n\nYour ovipositor is practically gushing fluid now, covering Amily's rear with thick goo each time her tight ass slides against it.  ");
	//(Males/Herms)
	if (pc.hasCock()) {
		output("Unable to hold yourself back, you grab her hips and raise them up, desperate to feel yourself buried as deeply into her as possible.  She groans as your [pc.cockHead] grazes along her dripping entrance, running a hand down her body to position you.  Your breath catches in your throat when her hand clutches your member, turning into a ragged moan as she rocks her hips against you, pressing your tip against her to slowly spread her lips.  You can only pant whilst your body is wracked with pleasure, clenching your teeth to try and stop yourself from crying out as Amily soaks your length with arousal");
		if (amily.hasCock()) output(", her shaft oozing thick globs of pre-cum that roll down her cock to smear against your own as she moves against you");
		output(".");
	}
	//(Females + AmilyUndicked)
	else if (pc.hasVagina() && !(amily.hasCock())) {
		output("Her soaked pussy keeps pressing against yours, smearing both of you with femcum as you both shiver with delight.  Your ovipositor twitches wildly as you scrabble in the dirt, moaning incoherently with each thrust Amily makes against your lust-crazed frame.  Her hard little clit slips between your lips suddenly, sliding up your slit until it flicks against your own hard button, leaving both of you shuddering at the overwhelming sensation.");
	}
	//(Females + AmilyHerm)
	else if (pc.hasVagina()) {
		output("You cry out in pleasure as she teases you, the tip of her shaft slipping against your entrance and spreading your lips around the head of her member.  You writhe at the feeling the warmth spreading through your nethers as her cock drools pre-cum into you, thick cream spreading across your snatch with every motion of your hips.  It bathes your clit with heat, the tremors coursing through your body forcing your grip on Amily's thighs to tighten, a groan slipping from her lips as her thrusts become more forceful and disjointed.");
	}
	//{(Genderless)
	else {
		output("She moans as your shaft rubs against her, her own thrusts against your blank groin increasing in pace every time your overly sensitive pseudo-member grazes her behind.  Her femcum splatters your lower half with each roll of her hips");
		if (amily.hasCock()) output(", her shaft covering your stomach with thick strands of pre-cum");
		output(" as thrusts become faster and harder.  You pant huskily in time with your lover, hands sliding around her hips to grab her cheeks in an attempt to sink your throbbing length inside her.");
	}

	output("\n\nAmily manages to smirk as you struggle beneath her, your body wracked with too much pleasure to even think as she continues to tease you, her hands caressing your [pc.chest] whilst her hips slide against you.  You buck against her suddenly, your abdomen jumping up and brushing the tip of your ovipositor against her tight hole, making her squeak as the wet shaft slips easily between her cheeks, leaving a trail of slime around her ass.");
	//(Males/Herms)
	if (pc.hasCock()) output("  Amily jolts forwards from the unexpected movement and you seize the opportunity, impaling her tight, wet entrance on your [pc.cock].  You both cry out in bliss as she sinks down your shaft, her passage almost burning your oversensitive shaft as her arms wrap around your neck, pulling herself close to you.");
	//(Females + AmilyHerm)
	else if (pc.hasVagina() && amily.hasCock()) {
		output("  Amily jumps forwards suddenly in reaction to your uncontrolled spasm, her shaft suddenly spearing you and forcing a desperate cry from your lips.  She responds in kind, a strangled moan escaping her as she slumps against you, her hips starting to thrust wildly into your trembling [pc.vagina].");
	}
	//(F/F or Genderless)
	else output("  You moan as Amily slumps against you, her arms sliding around your neck as her crotch presses ever more forcefully against your.  Your eyes lock with hers as she groans, her lower body undulating against yours with a desperate need, your abdomen straining as your body flushes with desire.");

	output("\n\nAlmost as if moving of its own accord your abdomen jolts towards Amily, your aching egg-shaft sinking deeply into her ass, the thick slime covering it allowing the thick tube to bury nearly halfway into her before she reflexively clenches down on you.  Groaning as you slide ever further inside her, ");
	//(Males/Herms)
	if (pc.hasCock()) output("you feel her passage clamp down around your shaft, her body shaking as she whimpers softly above you.");
	//(Females + AmilyHerm)
	else if (pc.hasVagina()) output("her thrusts falter slightly, her member twitching within you as your ovipositor fills her body up, shaking slightly with pleasure as her hot shaft brushes against your walls.");
	//(F/F or Genderless)
	else output("her body hammers into you with more urgency, each hit covering you with another splatter of her femspunk as she groans at how much you're filling her.");

	output("\n\nAnother moan bursts out of you as her passage");
	if (pc.hasCock()) output("s quiver");
	else output(" quivers");
	output(" around you, feeling the first of what's sure to be many eggs slowly making its way into her.  A particularly loud whimper snaps you from your lust-fogged haze as the slight bulge in your ovipositor squeezes past her tight ring, but you feel plenty more on the way.  Each one draws out another low groan from the girl as she continues to move against you, both of your crotches gradually becoming slick with a mix of slime and you combined juices.");

	output("\n\nYour hands eventually find their way to her cheeks and you play with them as you stuff the girl with your eggs, kneading them as you pull her even harder into you, the pair of you groaning with delight at the slow pace of your laying.");

	output("\n\nBefore long the feeling of fullness completely overwhelms Amily, her body quivering as an orgasm rushes through her.  You moan as ");
	//(Males/Herms)
	if (pc.hasCock()) output("her pussy spasms around your member, the feeling pulling you over the edge with her, your hips thrusting into her tight confines as you fill her with cream.  She shivers with delight at the double-stuffing you're giving her, relaxing in your arms as you both rides out the pleasure high.");
	//(Females + AmilyHerm)
	else if (pc.hasCock() && amily.hasCock()) output("she floods your [pc.vagina] with her hot seed, arms tightening around your neck to pull herself as tightly against you as she can, her shaft pulsing as it erupts.  She grunts squeakily with each spurt, packing your tight hole with as much cum as she can manage, even as you fill her rear with egg after egg.  The flurry of sensation pushes you over the edge, you stomach going tight as you wrap your legs around Amily, pinning her against you as you hump uselessly against her, your pussy quivering with each movement.");
	//(F/F or Genderless)
	else output("her hips slam into yours one final time, bodies trembling as you both reach your peaks together.  You feel liquid splattering your crotch, coating your thighs as Amily grinds into you, her breathing becoming ragged as she tries to keep moving throughout her body-shaking orgasm.  Groaning, you can do little more that hold her in your arms as your own climax electrifies your muscles, your body going taut with pleasure.");

	output("\n\nYour egg-shaft twitches as you orgasm and you feel a flood of heat in your abdomen.  As if acting like a ");
	//(Males/Herms)
	if (pc.hasCock()) output("another ");
	output("penis, a rush of eggs engorges your shaft, leaving your abdomen feeling as light as air.  Amily moans as egg after egg pushes past her ring, still playing with her rear whilst you finish filling her with your clutch, her stomach pressing gently against yours as it bulges with her new load.  Before long the last egg slips out of the tip of your ovipositor and it begins to withdraw reflexively, slipping from its tight confines far more easily that it entered due to the impossible amount of slime that lines Amily's passage.  It cascades from her once you fully withdraw, covering you with a thick layer of the stuff as you both lie there, slowly drifting off to sleep.");
	//[Next]
	pc.orgasm();
	//if (pc.fertilizedEggs() > 0) {
		//if (pc.canOvipositSpider()) {
			//pregnancy.buttKnockUp(PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.INCUBATION_DRIDER - 304); //(96)
		//}
		//else if (pc.canOvipositBee()) {
			//pregnancy.buttKnockUp(PregnancyStore.PREGNANCY_BEE_EGGS, PregnancyStore.INCUBATION_BEE + 48); //(96)
		//}
		//flags[kFLAGS.AMILY_OVIPOSITED_COUNT] = pc.eggs();
	//}
	pc.dumpEggs();
	processTime(40);
	clearMenu();
	addButton(0, "Next", layEggsInAmilysButtPt2);
}

private function layEggsInAmilysButtPt2():void {
	clearOutput();
	output("You wake up almost an hour later, Amily still dozing on top of you.  Gently picking her up, you take her to her nest and lay the girl down in the soft bedding, smiling at the bulge in her stomach.  It takes you a little while to clean yourself off and redress, though you can't help but feel that getting a little bit of slime on your [pc.gear] was a price worth paying.");
	processTime(40);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Amily Laying
public function amilyLaysEggsLikeABitch():void {
	output("\nWhilst wandering around your camp, you heard a flurry of soft squeaks from the direction of Amily's nest.  Intrigued, you sidle over to see what the commotion is.  When you get there, your eyes widen at the sight of your oft-restrained lover relaxing in her soft bedding, completely bottomless.  Her legs are spread wide, giving you a perfect view of both her holes as she rapidly ");
	if (!(amily.hasCock())) output("teases her clit");
	else output("squeezes her shaft");
	output(" with one hand, the other catching your eye as it moves beneath her top, apparently caressing her breasts.");
	output("\n\nThe sight surprises you so much that it takes a few moments of dumbstruck staring to notice the small pile of glistening orbs gathering between Amily's thighs.  Realisation quickly hits you as another slime-covered sphere joins them, easing its way out of the girl's tight ass to a chorus of soft moans.  It looks as though she's been at this for a while, though you doubt she's anywhere close to being finished yet.");
	output("\n\nAnother egg flows from her, still covered with the thick goo that you left in her when you made your 'deposit'.  Amily tenses at the way it spreads her ring, ");
	if (!(amily.hasCock())) output("pussy visibly quivering");
	else output("member oozing a thick glob of pre-cum");
	output(" as her body shudders with pleasure.");

	output("\n\nYou decide to leave the girl to her ministrations, ");
	//if abdomen
	if (pc.canOviposit()) output("though the sight has certainly gotten you thinking about what you'll be doing with your next clutch.\n");
	else output("though a distinct heat in your nethers leaves you wishing you had another clutch to unload right now\n");
	pc.lust(5 + pc.libido() / 10);
	flags["COC.AMILY_OVIPOSITED_COUNT"] = undefined;
}

public function amilySwimFuckIntro():void {
	clearOutput();
	if (flags["COC.AMILY_TIMES_SWIMFUCKED"] == undefined) {
		output("Pulling out the sexy black two piece, you offer it up to the mouse-girl with a smile");
		if (pc.slut() >= 60) output(", eagerly anticipating the opportunity to drink in her form while it's bound up in body-hugging black fabric.");
		else if (pc.cor() < 50) output(", happy to share the fruits of your adventure with your mousy lover.");
		else output(", secretly hoping she'll get used to putting on a show for you.");
		output("\n\nAmily's eyes open so wide they're nearly as big around as her ears, and she happily bounds up to you, touching the fabric carefully.  \"<i>It's so beautiful, [pc.name],</i>\" she says, \"Do you really think I would look good in something like this?</i>\"  She bounces on her toes, still touching the fabric but unwilling to take it out of your hands.");
		output("\n\nYou push the pile of tiny triangles and string into the mouse-girl's hands and say, \"<i>Why don't you try it on and come for a swim in the stream with me?  Then we can see just how good it looks on you.</i>\"");
		output("\n\nShe squeaks in excitement and runs off, cheeks aglow.  The saucy sway of her " + amilyHips() + " draws your eye as she vanishes behind a rock and makes it clear she's not too shy to change around you - she's just building up to a big reveal.  You suppress the urge to follow her and sneak a peak.  Seeing her half-clothed isn't exactly a new thing for you, and you want to be floored when you see how she fills it out.  Sitting back on a rock, the sounds of swishing fabric reaches your ears, and before you know it, Amily calls out, \"<i>Okay, I'm ready!");
		if (amily.hasCock()) output("  D-don't laugh, okay?");
		output("</i>\"");
		output("\n\nAmily strides around the rocks nervously, hands on her hips.  Her soft ");
		if (!amily.hasFur()) output("skin");
		else output("fur");
		output(" is almost totally exposed, left unbound by the skimpy fabric that barely covers her most sensitive places.  The mousette's toned legs and thighs draw your eye, right up to her " + amilyHips() + " and " + amilyButt() + ", divided by a narrow strip of black fabric.  Between those survival-honed limbs is a tiny triangle that barely covers Amily's nether-lips, clinging gently to her clearly visible camel toe.");
		if (amily.hasCock()) {
			output("  The top portion of it is pulled out away from her body, a taut tent that her " + amilyCock() + " is threatening to tear through at any moment.  After a moment of fidgeting, Amily pulls it out the top to flop lamely.");
			if (amily.ballSizeRaw > 0) output("  It snaps back onto her " + amilyBalls() + " to snug them tightly.");
		}
		output("  Higher up, silky onyx wreaths the globes of " + amilyTits() + ", but as you admire her new appearance, the hard tips of " + amilyNipples() + " rise up, so clearly defined that you can see their pebbly texture through the inviting swimsuit.");
		output("\n\n\"<i>How do I look,</i>\" your lover asks demurely, toeing at the dirt.  The usually confident little mouse is clearly out of her element but excited as well.");
		output("\n\n\"<i>Stunning,</i>\" you answer, and remembering your earlier offer, you ask, \"<i>Shall we hit the water, then?</i>\"");
		output("\n\nAmily seductively sashays up to your side and takes your hand, leaning heavily against you as the two of you head toward the stream.");
		pc.destroyItem(new CoCSluttySwimwear());
		flags["COC.AMILY_OWNS_BIKINI"] = 1;
	}
	//Repeat Swim Intro
	else {
		output("You ask Amily if she'd like to go for a swim again.  She smiles genuinely and nods.  \"<i>Let me get dressed, I'll be right back!</i>\"");
		output("\n\nAmily scurries off towards her stash, and you wait patiently for her return.  When she comes back, her little body is all bound up in sheer black, simultaneously concealing and highlighting her assets.");
		if (amily.hasCock()) {
			output("  The only thing left exposed is her " + amilyCock() + ", which bobs lightly with each step.");
			if (amily.ballSizeRaw > 0) output("  Her balls are snugly secured in her bottoms, looking like a cute little sphere of virile fun.");
		}
		output("  The hard points of her " + amilyNipples() + " prominantly display themselves on the bikini top.  Clearly she doesn't plan to spend too much swimming, just like last time.");
		output("\n\nAmily saunters up and grabs your hand, leading you towards the stream while her " + amilyButt() + " sways in your direction.  Amusingly, her tail is poking through a hole in the rear triangle of her sexy black bikini bottoms.");
	}
	IncrementFlag("COC.AMILY_TIMES_SWIMFUCKED");
	processTime(8);
	clearMenu();
	addButton(0, "Next", amilySwimFuckPartII);
}

//Go 'Swimming'
private function amilySwimFuckPartII():void {
	var x:Number = pc.cockThatFits(amily.vaginalCapacity());
	if (x < 0) x = pc.smallestCockIndex();
	clearOutput();
	output("The stream isn't far away, and the two of you reach it in practically no time.  The journey is slowed by the occasional teasing touches and whispered compliments between you and your lover.  Amily is giggling and flushed by the time you arrive, fanning herself with her hand even though it isn't THAT hot out.  Turning to face you, she sensually glides up against your [pc.gear] and begins to rub your ");
	if (pc.hasCock()) output("package");
	else if (pc.hasVagina()) output("puffy lips");
	else output("[pc.butt]");
	output(".  You sigh from the sensation and mumble, \"<i>I thought we were going swimming?</i>\"");
	output("\n\nAmily answers, \"<i>Right after you!</i>\" and twists, hooking her foot under you and tripping you right into the icy waters.  You push up, sputtering from the icy drink");
	if (flags["COC.AMILY_TIMES_SWIMFUCKED"] > 1) output(", and wondering why you keep falling for it");
	output(".  Amily bounds in after, launching into a deep spot with a raucous cannon ball.  The resulting splash is less than impressive due to her stature, and when she comes up for air after, you make sure to splash her back for the surprise dunk you got.  The mouse-morph giggles and throws her arms in front of her face defensively, staggering back, " + amilyTits() + " jiggling in their barely-supporting top.  You splash at her a few more times for good measure, but she begins to return fire.  The resulting water war soaks you both completely.");
	output("\n\nOnce you tire of slinging the icy liquid to and fro, you take the time to remove your [pc.gear] and lay on the bank.  Amily stops what she's doing to watch, playfully asking, \"<i>Tired of losing already?</i>\" while her eyes drink you in.");
	output("\n\nYou smirk and declare that her skimpy two piece has put her body on such display that you figured the only way to compete is to go naked yourself.  Stretching your arms up, you let droplets cascade down your [pc.chest] and unrepentantly gaze upon the mouse-woman's shrink-wrapped form.  The water has soaked into her clingy garb, and with the added moisture, you can actually see parts of her in perfect detail.  Sure, her pussy made a clearly visible camel toe before, but now... it's like you're getting a black-framed peep show.  Her pert breasts bounce when she rocks back in surprise at your statement.");
	output("\n\n\"<i>You perv!</i>\" Amily shouts in mock surprise, fixing her eyes on your own nipples and exposed groin.  \"<i>If you're going to be dirty about it,</i>\" she begins, her voice dropping to a decidedly uncharacteristic purr, \"<i>then you had better be ready for what you get.</i>\"  Her hands come to rest on your shoulders, and as she looks you in the eyes, she says \"<i>You got me all wet, too.</i>\"");
	output("\n\nThe petite mouse-girl launches herself into your arms, tight against your chest.  She easily reaches down to her bottoms and pushes them aside, just in time for her soaked muff to meet your " + pc.cockDescript(x) + ".  Your [pc.cockHead " + x + "] glides through her silken gateway with ease, aided by Amily's liquid ardor.  Water and juices drip from both your frames as your short-statured lover rides you, and your hands find their way to her " + amilyButt() + ", grabbing hold to pull her down, deeper.  After being in the frigid stream, the clinging folds of Amily's tight cunt feel like a hot salve for your erection, shooting electric jolts of hot pleasure through your body as she comes to rest on your ");
	if (pc.balls > 0) output("[pc.balls]");
	else output("base");
	output(".");
	output("\n\nYou knead her supple cheeks, admiring ");
	if (amily.hasFur()) output("her silky coat ");
	else output("her smooth skin ");
	output("with all ten fingers.  The mousette's tail curls around your [pc.hips] to pull you closer, grinding herself into you with all her might.  You can feel the ");
	if (!(amily.hasCock())) output("engorged bud that is her clit");
	else output("slippery member");
	output(" sliding back and forth between your drenched bellies.  Amily gasps, \"<i>I love you,</i>\" and her slippery tunnel hugs tight, just like the rest of her body.");
	if (amily.hasMuzzle()) output("  Her whiskers tickle your cheeks as s");
	else output("  S");
	output("he comes up for a kiss.  Slender lips meet your own, her narrow, skillful tongue slipping into your mouth.");
	output("\n\nBurning with desire, you walk out of the water with your lover speared on your shaft, and as soon as you're on solid ground, you begin to fuck her.  Your hands pull her up, almost off your [pc.cockHead " + x + "] before you let gravity pull her back down, slightly inclining your [pc.hips] to speed the pleasurable friction along. Amily squeaks when she hits rock bottom, breaking the kiss before she plants it again with renewed vigor.");
	output("\n\nThe two of you fuck like horny animals at their favorite watering hole, and every chance you get, you make sure to let a stray hand touch her " + amilyNipples() + ", " + amilyTits() + ", or " + amilyButt() + ".  The soaked girl is soon twitching and squirming atop you, wordlessly riding out an epic climax.  Her sweet cavity caresses your " + pc.cockDescript(x) + " throughout, wringing your tumescent dick with insistent female pleasure, as if that could somehow milk your cum from you.");
	output("\n\n\"<i>Gods,</i>\" Amily gasps, \"<i>You're incredible!</i>\"  She looks at you through heavy eyelids and kisses you again, though her muscles spasm wildly when you resume your quick, wet fuck.  You pound her hard and fast, rutting her hot hole hard enough to make her whole body bounce in your arms.  Amily is little more than a pile of quivering female flesh, snug around your " + pc.cockDescript(x) + " and just waiting to be impregnated.  Shoving her down, you throw back your head and cum at last, pumping thick seed into her.");
	if (pc.cockTotal() > 1) {
		output("  Your untended erection");
		if (pc.cockTotal() > 2) output("s do");
		else output(" does");
		output(" a fine job of spraying ");
		if (pc.cockTotal() == 2) output("its load ");
		else output("their loads ");
		output("over her middle.");
	}
	output("  The heat flowing inside her sets off a second orgasm");
	if (amily.hasCock()) output(", and she climaxes all over again, spraying the underside of her " + amilyTits() + " and your [pc.chest] with milky mouse seed");
	output(".  Her channel soon drips with your mixed sexual fluids");
	if (pc.cumQ() > 250) {
		output(", but it doesn't stop you from continuing to pump away, ");
		if (pc.cumQ() < 500) output("squirting more and more spunk from the contracting cunt with every movement");
		else if (pc.cumQ() < 750) output("spurting out a backflood of semen as Amily's belly gains a tiny but visible cum-bump");
		else if (pc.cumQ() < 1000) output("gouts of cum washing from her snatch as her belly rounds nicely");
		else if (pc.cumQ() < 2000) output("waves of jism washing out around your " + pc.cockDescript(x) + " as it pumps her to a rounded, pregnant look");
		else output("geysers of [pc.cum] bursts out from the quivering mouse-hole as Amily's belly balloons with jizz.  Even after it can stretch no more, you keep cumming, firing out high pressure jets that splatter your [pc.legs]");
	}
	output(".\n\n");
	output("Once finished, gently set the moaning girl down and tug her bikini bottom back in place to hold in the cream filling.  Amily moans, \"<i>Pervert,</i>\" but she doesn't stop you.  She even helps you get dressed again, and the two of you walk back to camp, hand and hand, clean and dirty at the same time.");
	processTime(35);
	pc.orgasm();
	//dynStats("sen", -1);
	amilyPreggoChance();
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}


//PC - dicked.
//Amily + Izma – some kind of lust boosting, cum boosting, preg-chance boosting potion that causes a three-way! (silly mode cum out rear and mouse launch requested)
//all pretty much just an excuse for the belly bulging cumshot though
private function amilyXIzmaSuperPregOptions():void {
	clearOutput();
	output("You smile winningly at Amily, and tell her you have something a little different in mind. You want to have another litter with her.");
	output("\n\n\"<i>Oh?  You want me to get pregnant... again?</i>\" the mouse asks, nervously holding her tail in her hands.  \"<i>You know I ran out of the goblin pregnancy drugs right?  So, my fertility won't be nearly what it was before.</i>\"");
	output("\n\nYou nod, smiling again.");
	output("\n\n\"<i>Thank you... If you really do want them, then I'll stop using those herbal contraceptives.  Perhaps I could whip something up... I am something of an alchemist after all!</i>\" Amily trills, idly tracing a circle on your chest with her little claw. She turns and leads you towards the nest, tail waving eagerly.");
	output("\n\n<b>Do you want her to just go off the herbs normally or try to brew up a fertility potion?  Such a potion might have unusual side-effects...</b>");
	flags["COC.AMILY_ALLOWS_FERTILITY"] = 1;
	processTime(2);
	//[Norma] [Try The Potion]
	clearMenu();
	addButton(0, "Normal", fuckTheMouseBitch, null, "Normal", "Have Amily just go off the herbs normally.");
	addButton(1, "Try Potion", drinkThePotion, null, "Try Potion", "Try something new. You have a hunch that it might lead to inevitable impregnation.");
}

//Try The Potion
public function drinkThePotion():void {
	clearOutput();
	IncrementFlag("COC.AMILY_X_IZMA_POTION_3SOME");
	if (flags["COC.AMILY_X_IZMA_POTION_3SOME"] == 1) {
		output("Amily smiles up at you while her tail coils around your [pc.leg], and she warns, \"<i>Now, I've been fiddling with this for a while, but I haven't had a chance to test it, so it could have some unexpected side-effects.</i>\"");
		output("\n\nSmiling just as widely as before, you let her know that you expected as much when you agreed to the idea.");
		output("\n\nThe mouse-girl pulls a pair of potions out of her bag and explains, \"<i>There's one for the dad and one for the mom.  Here's yours.</i>\"  The bottle she's offering is filled with a swirling, viscous blue fluid under its tightly-plugged cork, and Amily is holding a similar container, hers containing a pink mixture.");
		output("\n\nYou tap yours against the short girl's and toast, \"<i>To our children and us!</i>\"");
		output("\n\nAmily taps hers against yours and echoes, \"<i>To our children and us!</i>\"");
		output("\n\nYou smile as you pop the cork and throw back the brew, guzzling it down with abandon, secure in the knowledge that anything that enhances the chances of conception will prove to enhance the fun as well.  Amily's fingers slip off the tightly inserted plug as she struggles to open her own.");
		output("\n\n\"<i>Urk... the damned... thing... won't... budge!</i>\" she grumps in despair as she flops down on her " + amilyButt() + ", twisting and tugging away in frustration.");
		output("\n\nYou've only finished about half of the sweet tasting drink, but you stubbornly stick with it, figuring that a potion should be imbibed all at once.  There's a definite sensation of burgeoning warmth within your middle already.  Each swallow allows the knot of heat to diffuse through you, though it seems to be mounting in your groin faster than elsewhere...");
		output("\n\nSuddenly, strong arms wrap around your waist, and a sharp voice asks, \"<i>Getting into something fun without me, Alpha?</i>\"  Izma!  The surly shark-girl takes advantage of your full mouth to continue on unhindered.  \"<i>A little bit of drink with your companions, huh?  Let me help you with that, mousey.</i>\"");
		output("\n\nIzma plucks the bottle of Amily's hands and handily uncorks it, \"<i>Cheers!</i>\"  Amily stutters over her protests, but the damage is already done.  Izma chugs half the draught down before pulling it away with a satisfied smirk, a strand of pink-tinged spit dangling between her lips and the bottle.  \"<i>Not my usual vintage, mind you.  A bit too sweet.</i>\"  She pushes her glasses up her nose and hands the half-drank draught back to the mouse.  \"<i>Share and share alike, right?</i>\"");

		output("\n\nAmily blurts, \"<i>That's not a drink!  It's my fertility potion, and I haven't even tested it yet!</i>\"  The angry mousette proudly purses her own lips to chug the remainder while you wipe the last of yours from your mouth, not sure what to make of the situation.");

		output("\n\n\"<i>A fertility potion!?</i>\" the shark-girl cries before an unlady-like burp escapes her maw.  \"<i>You let me drink some kind of... breeding draft!?</i>\"  Izma rounds on the mouse-girl, placing herself directly between the you and the smaller woman.  Her tail is slapping at your [pc.legs] with angry lashes, but each time she pushes a little more against you until her butt is rubbing on your groin through your [pc.gear].  She growls in irritation while her hands reach back to clasp your [pc.hips] protectively.");
		output("\n\nAmily retorts, \"<i>You didn't give me a chance to explain, you ninny!</i>\"");
		output("\n\nThe two begin to bicker back and forth, but honestly, you stop paying attention to the shrill, female voices.  There's a warm body squeezed up against you, and it feels so... right.  You let your hands play across Izma's curves, barely caring when they come to rest on her covered breasts, squeezing each one gently before slipping under the fabric to tweak the rigid nipples below.  There's a lecherous grin painted on your face, though you're barely aware of it, to be honest.  Your undergarments and [pc.gear] are just so... restrictive, and they make it too hard for you to grind [pc.eachCock] against her firm, shapely bottom.");
		output("\n\n\"[pc.name]!</i>\" Amily shrieks, stepping around Izma to put her hand on your back.  \"<i>You weren't thinking about wasting my potion on this watery tart, were you?</i>\"  She's rubbing in gentle circles across your muscles, already working to get you naked.  \"<i>Remember, you're going to stuff me full of another huge litter again, right?</i>\" the mouse-morph purrs as she dares to slide a hand over [pc.oneCock], giving it a squeeze and gently tugging it towards her.");

		output("\n\n\"<i>Like hell!</i>\" Izma snarls as she spins about.  She easily tears away the rest of your [pc.gear], placing her hand ");
		if (pc.longestCockLength() < 5) output("overtop of the petite, cock-holding digits");
		else output("on your [pc.sheath]");
		output(" possessively.  \"<i>You two let me drink that, so you'd better deal with the consequences.</i>\"  Her lusty eyes flick towards you before casting down submissively, \"<i>That is, if that's your will, Alpha</i>\"  Her fingers gently squeeze on your member.");
		output("\n\nGroaning and feeling more ready to fuck than you have in a long time, you answer, \"<i>Both of you... I'll take care of both of you... after all, I drank twice as much of either of you, so it should be no problem, right?</i>\"");
		output("\n\nAmily seems about to make an argument, but she thinks better of it.  \"<i>Okay, love, I suppose we can be your pregnant, sister-wives after all.</i>\"");
	}
	//[Next]
	//Try the Potion: Repeat
	//Appears in Amily's Sex Menu - Izma3Some
	else {
		output("You ask Amily if she's made up any more of that potion that you, her, and Izma had so much fun with before.");
		output("\n\nAmily laughs, \"<i>You want to do that again?</i>\" with a wisp of a sheepish smile curling at the corners of her petite mouth.");
		output("\n\nWhen you nod, her smile becomes excited, and she begins sorting a few bottles out of her gear.  You note that there's one blue one and two pink ones, though the girly drafts are portioned out to have half as much as their more masculine counterpart.  \"<i>It worked really, really well last time, so I didn't think it would be a good idea to adjust the dosages at all.  I'm not even sure I could handle a full course after being that sore...");
		if (flags["COC.AMILY_INCUBATION"] != undefined) output("  At least I can't get any more pregnant!");
		output("</i>\"");
		output("\n\nYou smirk and raise an eyebrow, asking, \"<i>Izma?</i>\"");
		output("\n\nAmily nods.  \"<i>Izmaaaaaaaa!</i>\"");
		output("\n\nThe pretty tigershark-girl comes sashaying around the rocks, putting a bookmark in her reading material as she answers the high-pitched call.  She glances between the two of you and huffs, \"<i>Oh, couldn't think of having a little fun without me?</i>\" with a wry grin.  Her skirt rustles slightly as she closes the intervening distance");
		if (flags["COC.IZMA_NO_COCK"] == undefined) output(", barely concealing the half-swollen bulge beneath");
		output(".  Izma says, \"<i>What the hell, I ");
		if (flags["COC.IZMA_INCUBATION"] != undefined) output("suppose I can do it for fun, since I'm already pregnant.");
		else output("suppose we can have another kid.");
		output("</i>\"");
		output("\n\nThe potions are passed around, and the three of you quickly get to drinking them.  The girls finish their half-filled bottles first, leaving them with nothing to do but slowly undress you while you try to devour the last of the sweet, lust-inducing stuff.  It's very hard to focus on swallowing your part of the equation with four hands roaming across your body, and you nearly choke on it when the two girls start hugging you from each side, mismatched hands diving into your crotch to fondle [pc.oneCock] with eager grasps.  The artificial warmth that's gathering in your midsection slowly spreads throughout your body, though it seems like the bulk of it winds up in [pc.eachCock] where it can be properly stimulated by the needy females' pleasant fingers.");
		output("\n\nAmily nuzzles under your arm, her nose against the side of your [pc.chest] as she inhales, murmurring, \"<i>Such a " + pc.mf("strong, potent male...","beautiful, potent breeder...") + "  You're going to ");
		if (flags["COC.AMILY_INCUBATION"] == undefined) output("give me lots of babies");
		else output("put even more babies inside me");
		output(", right?  No need to bother with her...</i>\"");
		output("\n\nIzma matches the mouse-girl's demure posture, glaring daggers at her from the other side, hand fixating on [pc.oneCock] just behind Amily's.  \"<i>Alpha, that rodent could never handle you in bed.  Come on, use me.</i>\"");
		output("\n\nThe pleasant fog of your lust makes it hard to think.  Why can't these girls get that there's more than enough of you to go around?  You groan and you answer, \"<i>I'll take care of both of you... you're too hot for me to let you leave without a load in every hole.</i>\"");
		output("\n\nThe girls share one last glare across your middle before both sets of eyes settle on your [pc.multiCocks], two voices agreeing, \"<i>We can share.</i>\"");
	}
	processTime(15);
	pc.slowStatGain("l", 1);
	pc.lust(pc.lustMax(), true);
	//dynStats("lib", 1, "sen", 1, "lus=", 100, "resisted", false);
	clearMenu();
	addButton(0, "Next", izmaAmilyDrugThreeWaySex);
}

//Start Ze Fucking!
private function izmaAmilyDrugThreeWaySex():void {
	clearOutput();
	output("The amorous embrace's effects on you are more than telling.  [pc.EachCock] has swollen up, long and proud, as thick with arousal as ");
	if (pc.cockTotal() == 1) output("it's");
	else output("they've");
	output(" ever been.  The continuing caresses from your horny females have your [pc.cock " + pc.biggestCockIndex() + "] aching with a less than subtle need.  There's a certain, growing tightness in your [pc.balls]");
	if (pc.balls > 0) output(", one that has your [pc.sack] swelling slightly, the skin growing smooth and glossy as it fills with the heavy, comfortable weight of your sloshing seed");
	else output(", one that has you feeling comfortably swollen with pent-up seed just waiting to erupt");
	output(".  Droplets of pre-cum slowly trickle from [pc.eachCock] onto the busy ladies' hands and forearms, turning their fondles into strokes so wet and lubricated that you could almost mistake them for a succubus's twat.  There's something wonderfully right about being served by these docile woman");
	if (flags["COC.AMILY_INCUBATION"] == undefined && flags["COC.IZMA_INCUBATION"] == undefined) output(", with their hungry wombs just waiting to be impregnated at your leisure");
	else if (flags["COC.AMILY_INCUBATION"] != undefined && flags["COC.IZMA_INCUBATION"] != undefined) output(", with their ripe wombs stuffed full of your offspring already");
	else output(", with at least one of their wombs already ripe with your offspring");
	output(".");

	output("\n\nAmily is equally enamored of you if the look on her face is any indication.  Her eyelids are low, with her dilated orbs almost hidden by her lengthy lashes.  She's fixated on your [pc.cock " + pc.biggestCockIndex() + "] while her hand sloppily pumps and jerks along its length, sharing the plumped-up penis with the tigershark-girl's larger hand.  The mouse-wife is licking her chops each time a fresh dollop of clear cock-cream escapes from your [pc.cockHead " + pc.biggestCockIndex() + "], but her tiny hand swiftly gathers it when she can - sometimes Izma lets go to get first shot at the fragrant, " + pc.mf("male","female") + " honey you're so freely exuding.  Amily's tail is slowly sliding up and down your [pc.leg] with unintentional excitement, upraised high enough that you can see her exposed muff.  Dewy moisture beads on the close-cropped crotch-fur so thickly that a few drops have begun to run down her thigh.  Her needy scent is so thick in the air you can practically taste it.  It makes your [pc.cocks] twitch.");
	output("\n\nOn the other side of the heavenly handjob, Izma is smiling warmly, inadvertently displaying her large, predatory teeth while she attends to your pre-slicked shaft.  She's still clothed in her skirt and top - for now.  Her breasts bounce a little with each stroke she makes, the orange and black globes jiggling slightly.  The motion draws your eyes to the perky nubs of her nipples, which strain so very hard against the oppressive tightness of their fabricky prison.  ");
	if (flags["COC.IZMA_NO_COCK"] == undefined) output("Izma's skirt rustles softly, and some of the fronds that compose it slowly begin to rise.  For a while, it's just a slight protrusion, but as the tigershark-girl has her way with your [pc.cock " + pc.biggestCockIndex() + "], her bulge lifts into a tent well over a foot tall and inches thick.  Its owner's cheeks blush more red than normal  as Izma begins to pant, accompanied by something steadily dripping within the confines of her sorely-stretched waist-covering.");
	else output("Izma's skirt visibly begins to dampen, and some of the fronds start sticking to her striped thighs in a rather alluring manner.  For a while, that's all that comes of it, but as the tigershark-girl has her way with your [pc.cock " + pc.biggestCockIndex() + "], the skirt gets wet enough to stick to her like a second skin.  Blushing a deeper red than normal, Izma begins to pant, accompanied by a steady dripping that spatters the ground below.");

	output("\n\nStaggering under the weight of your own unfulfilled arousal, you stumble into the nest with your prick-addled harem, momentarily losing the double-handjob on your [pc.cock " + pc.biggestCockIndex() + "] while the three of you tumble into Amily's comfy abode.  Izma's glasses fly past overhead as she collapses next to you, landing softly at the far edge of the nest.  The de-spectacled ");
	if (flags["COC.IZMA_NO_COCK"] > 0) output("former-");
	output("hermaphrodite giggles, and whispers, \"<i>I didn't need them anyway.</i>\"");

	output("\n\nAmily's big, fuzzy ears tickle your head as she nuzzles at the nape of her neck.  Her arm falls across your torso onto the far side of your [pc.chest] to gently cup ");
	if (pc.averageNipplesPerBreast() <= 1) output("one of your nipples");
	else output("at your multitude of nipples");
	output(".  Panting eagerly, she licks up the underside of your chin, eventually cresting your jawline.  Her lips meet yours, their supple, slippery pressure heavenly on your own, and a slim tongue sides across the paired puckers to delve inside your maw.  You return the gesture in kind, slithering around your flexible organ to taste her mouth... her lips... her everything.  You make love to her mouth the way you imagine you'll be making love to her nethers in a few moments.");
	output("\n\nAmily abruptly grunts in displeasure, and the skillful twirls of her tongue lapse into uncontrolled jerks.  Her lips, which you were oh so enjoying, push slightly to the side.  You make to break away and voice your complaint, but a reassuring hand lays across the other side of your [pc.chest], crossing the mouse-woman's arm as a second mouth comes to rest on the exposed half of your own.  You retract your tongue just as the new arrival is forcing its own into your well-packed jaw.  With all the cushy, girly orifices sloppily kissing on you and the pair of mouth-muscles wrangling your own, you can't even properly return the french anymore.  You do your best to simply focus on the wriggling menagerie of spit-slobbering snakes, licking and suckling them as skillfully as you can given the circumstances.  Sometimes they even tangle up in each other and retreat, sliding between the two girls' lips in their own twisted dance before returning to you, the real object of their affection.");

	output("\n\nAmily surprises Izma with a particularly fierce kiss, one that sends the girls rolling through the soft nest to the very edge.  Devoid of sensation for the first time in what feels like ages, you watch in stunned silence.  The lighter, smaller woman comes out on top, tail raised high to help her balance while Izma rests underneath her with both hands busily kneading at the rodent sweetheart's " + amilyButt() + ".  Their gushing cunnies are locked together mound-to-mound, and the rigid clits glide through the opposite set of labia, smoothly deforming the engorged, flowery lips with gentle, grinding stimulation.  ");
	if (flags["COC.IZMA_NO_COCK"] == undefined) output("The shark-girl's balls are pushed to the side, barely avoiding being smothered in the mouse-girl's weight, and her rigid dick is drooling up between Amily's tits, where it seems quite happy to rest.  ");
	output("Izma's tail suddenly arcs up towards the mouse's behind, lightning-fast.  It impacts the tender rodent-bottom with a crack loud enough to make you wince.  Growling into the other woman's mouth, Amily flexes her own tail, wrapping Izma's up in coil after coil of smooth restraints.  They wrestle against each other, cunt to cunt and kissing the whole time.");
	output("\n\nFrom where you are, the two glistening mounds look almost like one enticing, pink delta with a star-shaped crease just waiting to be violated.  The drugs dancing through your brain keep you from looking away.  As a matter of fact, the more you watch the struggling women, the more important that doubled, chimeric hole becomes to you.  Your rutting body is unable to wait, and you give in to the tempting, clarion call that's surging out from your loins to pollute the rest of your body with sexual need.");

	output("\n\nYou lumber up to the pile of writhing flesh and place your hand upon a curvy buttock.  It doesn't matter which.  Izma's soaked skirt occasionally obscures your view, so you tear it away to give yourself a better view of your target.  Thrusting forward, you feel the pair of pussies cling against your [pc.cockHead " + pc.biggestCockIndex() + "] while it journeys between the slobbering cunts' tightly-compressed entrances.  The immense amount of moisture is far beyond what either of the two normally produces - clearly the potion is affecting them as readily as it has you.  The amount of pre you're smearing over everything your [pc.cock " + pc.biggestCockIndex() + "] touches is proof enough of that.");
	if (pc.cockTotal() == 2) output("  You even cram your second member in alongside its big brother.  The two cunt-oiled shafts rub against each other as well as the sloppy holes on either side, leaving you grateful for the extra maleness.");
	else if (pc.cockTotal() > 2) output("  You even cram an extra member in alongside its big brother.  The two cunt-oiled shafts rub against each other as well as the sloppy holes surrounding them, leaving you grateful for your extra maleness.  Of course, that isn't your entire package, but there isn't room to stuff any more dick into that stuffed cock-sauna.");
	if (flags["COC.IZMA_NO_COCK"] == undefined) output("  You even bump up against Izma's forgotten package, slathering it with mixed juices.  While it's rigid with arousal, Izma seems to have almost forgotten about it, instead choosing to focus exclusively on her more womanly parts.");

	output("\n\nThe ladies' pleased moans are each muffled by the other's puckered lips, but the purring sounds of pleasure are unmistakable.  An excited growl crawls up out of your throat as you give in to the overpowering rut and let your [pc.cock " + pc.biggestCockIndex() + "] lead you deeper into the smothering, sweltering heat of your breed-ready females.  You grab the bottom girl - the one with the stripes, since she's bigger - and you pull yourself back, nearly fainting from the heat of the of the twin mounds as they cling to every inch of your ");
	if (pc.cockTotal() > 1) output("cocks");
	else output("[pc.cock " + pc.biggestCockIndex() + "]");
	output(".  The sapphic kiss is shattered by your slit-moistening hardness, and Amily looks back at you, disentangling her tail from Izma's to caress you as she asks, \"<i>You aren't going to waste it outside, are you?  Please, cum in me!</i>\"");

	output("\n\n\"<i>No, give it to me!  ");
	if (flags["COC.IZMA_INCUBATION"] != undefined) output("My pussy is the obvious, stronger choice.");
	else output("I'm the stronger, obvious breeding choice.  Knock me up and you'll have fitter, better offspring.");
	output("  Besides, can't you feel how wet my cunt is, and how those little tentacles inside are going to feel around you when you give me your cum?  That is your job as Alpha after all, to dominate my pussy and fill it full of you...  Ooooh...</i>\" Izma moans, pleading her own case as she starts to finger Amily's asshole.  \"<i>Besides, this little - ohgods - thing couldn't handle your babies, [pc.name].</i>\"");
	output("\n\nAmily squeaks in surprise at the sudden intrusion before stabbing her tail tip into the shark's rectum as well, turning Izma's demands into a lewd moan.  \"<i>Come on, [pc.name].  I'm the one that figured out-ooouuuhhhh... uh, how to make the potion.  ");
	if (flags["COC.AMILY_INCUBATION"] == undefined) output("Give me your babies...  Mmmm, we'll make such smart babies.  ");
	output("Just, ahhh... put it inside me and cum, cum in me again and again and fuck me till I'm pregnant with your spunk!</i>\"  She's ");
	if (amily.hasFur()) output("actually blushing so hard that you can see it through her fur, a crimson tint that looks even better on her with the way her tongue is hanging out");
	else output("blushing so hard her whole face is almost beet-red, a fine look on her with her tongue dangling so erotically out of her gasping mouth");
	output(".");
	output("\n\nYou push and pull on the two girls, fucking both sets of mons without care for who eventually gets jizz inside them.  You're definitely going to flood a ");
	if (flags["COC.AMILY_INCUBATION"] == undefined || flags["COC.IZMA_INCUBATION"] == undefined) output("womb");
	else output("cunt");
	output(", judging by how full your genitals are feeling, but it doesn't matter greatly one way or the other.  There's a calm, confident surety in the back of your mind that keeps reminding you that you're in charge here, and that both these women WILL be ");
	if (flags["COC.AMILY_INCUBATION"] == undefined || flags["COC.IZMA_INCUBATION"] == undefined) output("pregnant");
	else output("squirting");
	output(" for you.  Each time you slam your ");
	if (pc.cockTotal() > 1) output("doubled dicks");
	else output("[pc.cock " + pc.biggestCockIndex() + "]");
	output(" home, you wind up pushing the ass-pegging tail deeper inside Izma and her finger deeper inside the mouse, which in turn makes their cunts gush harder around you.  Amily has given up on the debate and started suckling one of Izma's nipples while you grind their sloppy gashes towards orgasm, and your ");
	if (pc.balls > 0) output("straining balls slosh ");
	else output("straining fullness tingles ");
	output("meaningfully, reminding you that the steady throb of your own encroaching climax is a few quick thrusts away.");

	output("\n\nWithout warning, you pull back, exposing yourself to the cool air, and thrust up and in, stabbing your [pc.cock " + pc.biggestCockIndex() + "] ");
	if (pc.biggestCockVolume() > amily.vaginalCapacity()) output("as far into Amily's juicy slit as it will go");
	else output("straight into Amily's juicy slit");
	output(".  Izma's finger rubs up against you through the mouse-girl's inner walls, providing an extra layer of stimulation on top of the pleasure her glove-tight cunt is doling out.  Lady-spunk gushes over you from [pc.cockHead " + pc.biggestCockIndex() + "] all the way to your [pc.sheath], and it drips on to Izma's dick-deprived snatch as you fuck the pregnancy-fetishizing mouse-girl.  The predatory slut sighs, but her finger begins to wiggle faster and faster within the confines of the mouse's ass, vibrating through the climaxing rodent-pussy to shroud you in ecstasy.  You bottom out inside the heavenly cunt and release, the pleasure of cumming stronger than normal, propelled by a biological imperative to ensure that every drop of semen is deposited as deeply into a willing female as possible.");
	output("\n\nAmily stops suckling the shark-tit as she screeches out her excitement for the whole of your camp to hear.  Her " + amilyHips() + " buck wildly against you and the shark, splattering you both with the proof of her pleasure as instinct takes over.  With her efforts so focused on her nether-lips, her face slumps against Izma's pillow-like breast, and she begins to drool stupidly in between gasps and groans, too drunk on orgasm to care.  The sense of relief is as palpable as it is intense, growing with each thick, sticky bulge that launches out of your urethra.  Amily's pussy is splattered with cock-cream, quickly filling, the walls of her well-used canal entirely soaked in white.");
	if (flags["COC.AMILY_INCUBATION"] == undefined) output("  Her belly begins to puff up from the thorough insemination, at first going a little pudgy, but then turning large and bulbous.  Her empty womb is somehow taking more and more of your virile seed inside.  It's almost like her cervix is sucking down the yogurt-thick load like a one-way valve, and soon Amily's middle is positively jiggly with spunk, bulging out to either side of her from her body weight.");
	else {
		output("  With her womb already occupied by your offspring, Amily's cervix stays steadfastly closed.  There's so much jizz pumping out of you that the tight canal can't even begin to hold all of it");
		if (pc.hasKnot(pc.biggestCockIndex())) output(", but your knot traps it inside anyway.  You cum and cum until the pressure is almost painful, but even your magnificent knot can't hold it all back");
		output(".  Spraying out in high-pressure streams, your spunk gushes out in a white river, soaking your legs, glazing Izma's groin and tail, and most importantly, leaving Amily's mound so thoroughly creampied that you think her muff may as well get pregnant too.  Even knowing that it's flowing out around you, you stay stubbornly hilted, compelled to release it all inside her, the surging sperm-flow that pumps out with each squirt massaging you into releasing even more.");
	}
	//[Next]
	clearMenu();
	addButton(0, "Next", izmaAmilyDrugThreeWaySex2);
}

private function izmaAmilyDrugThreeWaySex2():void {
	clearOutput();
	output("Time goes hazy, for a bit, but the cool air on your sopping boner is enough to rouse you back to full consciousness.  The scene is unreal.  Amily rolled off of Izma at some point and is laying flat on her back, cradling her ");
	if (flags["COC.IZMA_INCUBATION"] == undefined) output("cum-");
	output("pregnant belly and murmuring, \"<i>Babies,</i>\" while her fingers mindlessly diddle her alabaster-painted cunt.  She shudders as aftershocks of pleasure torture her lust-wracked brain, keeping her in a horny, docile state.");
	output("\n\nIzma seems to have taken advantage of your lapse in consciousness - you're on your back, and she's straddling your chest");
	if (flags["COC.IZMA_NO_COCK"] == undefined) output(", dick and balls flopping lamely on top of you");
	output(".  She pants, \"<i>Dunno why I didn't just fuck ya while you were out of it...  Didn't seem right.</i>\"  Rubbing her breast one-handed, the shark-girl begs, \"<i>Can I have it now?  Can you cum in me like you did her, [pc.name]?  Please, I'm so... so wet for you, I'll make you feel so good.</i>\"  She keeps scooting back and forth just above your [pc.hips], the hard lump of her clit pressing into you as she awaits permission to ");
	if (flags["COC.IZMA_INCUBATION"] == undefined) output("be inseminated");
	else output("have her pregnant-pussy packed full again");
	output(".");

	output("\n\nBehind her, [pc.eachCock] has remained triumphantly stiff, and ");
	if (pc.balls == 0) output("the pressure is as omnipresent as ever");
	else output("your [pc.balls] are stretching your [pc.sack] as tight as before");
	output(".  The need to cum is almost overpowering, and without thinking about it at all, you fold your arms behind your head and nod, eager to slake the need you just can't seem to overcome.");

	output("\n\nIzma rises on shaky legs and flashes you a sultry look before diving back down, her cunt swallowing your [pc.cock " + pc.biggestCockIndex() + "] with ravenous abandon.  Her pussy doesn't feel as warm or tight as Amily's, but there are lots of tiny little tentacles inside that caress your [pc.cockHead " + pc.biggestCockIndex() + "], swirling across the sensitive skin.  When she ");
	if (pc.biggestCockVolume() <= izma.vaginalCapacity()) output("bottoms out");
	else output("takes as much as she can");
	output(", there's a squirt of lubricant that washes out onto your middle");

	if (flags["COC.IZMA_NO_COCK"] == undefined) output(" along with a matching jet of pre-cum from her tip");
	output(".");
	if (pc.cockTotal() > 1) {
		output("  Strong hands wrap around ");
		if (pc.cockTotal() > 2) output("two of ");
		output("your extra penis");
		if (pc.cockTotal() > 2) output("es");
		output(", jacking ");
		if (pc.cockTotal() == 1) output("it");
		else output("them");
		output(" with smooth, confident strokes.  \"<i>I bet the mouse couldn't tend to your needs like this, huh?</i>\"");
	}

	output("\n\nYou look up at the cum-hungry shark-girl with undisguised affection.  She meets your gaze and blows a kiss before she starts the slow journey back up, tight lips hugging your girth as they leave their own fragrant moisture on your [pc.cock " + pc.biggestCockIndex() + "].  You allow your woman to ride you with a lazy smile");
	if (flags["COC.IZMA_NO_COCK"] == undefined) output(", ignoring the dribbly cock that's leaking on your chest");
	output(".  Instinctive, half-thought voices remind you that is how it should be - so virile that you need a herd of woman to take turns satisfying your insatiable desires.  Lucky for you, you've got the start of one right here.");

	output("\n\nIzma leans down");
	if (pc.cockTotal() == 2) output(", taking a hand away from your extra dick to support herself,");
	if (pc.cockTotal() > 2) output(", taking a hand away from one of your extra dicks to support herself,");
	output(" and kisses you passionately.  The fervent kiss is as short as it is frenzied, but as you're recovering from it, Izma starts to talk, \"<i>You like that, Alpha?  You like having my cunt suckling on your dick?</i>\"  She swivels her hips with her words, the inner tentacles all pulling on you in concerted waves, actually lifting your penis to press deeper inside her, right up against her ");
	if (flags["COC.IZMA_INCUBATION"] != undefined) output("closed");
	else output("dilated");
	output(" cervix.  \"<i>");
	if (flags["COC.IZMA_INCUBATION"] != undefined) output("I know I'm pregnant, but I want you to cum as deeply inside me as possible, okay?  I just... I have to have your cum. I NEED to feel that warmth flooding inside me.  It'll... ohh, yes... it'll make me feel so good, so loved.");
	else output("I don't know how, but I just know that you're going to make me pregnant when you cum inside me.  It's going to get me oh-ohhhhh... so heavy with your child, and it'll be perfect and blissful.  You're going to fucking flood me with jizz, aren't you, Alpha?");
	output("</i>\"  Izma's eyes twinkle with a mixture of obscene hunger and overbearing affection.  She whispers, \"<i>Will you please");
	if (flags["COC.IZMA_INCUBATION"] == undefined) output(" make me your gravid, jizz-slurping beta-wife?");
	else output(" cum in your pregnant, jizz-hungry wife?");
	output("</i>\"");

	output("\n\nFuck, it's like she's telling you to do exactly what you want to do!  There's nothing hotter than ");
	if (flags["COC.IZMA_INCUBATION"] == undefined) output("watching a bitch's belly bloat as it's packed to a full, fertile dome");
	else output("stuffing a cunt so full she'll never stop dripping your seed");
	output(".  Getting to lie back and watch her cum her brains out while you do it?  That's just icing on the cake.  Izma's feelers flutter erotically about you, spastically stroking with uncoordinated, individual slithers that remind you of a hundred tiny tongues.  She gets infinitely wetter, something you didn't think possible, and her whole body begins to go scarlet, coloring as she climaxes.");
	if (flags["COC.IZMA_NO_COCK"] == undefined) output("  Her four balls quake atop you, and you watch her urethra bulge, ready to splatter your [pc.chest] with her own, lesser climax.");
	output("  Lady-spunk washes across your middle as her walls begin to wring your length, squeezing it just firmly enough to make your ardor flare hotter, triggering an avalanche of feelings within you that you could not hope to repress.");
	if (flags["COC.IZMA_NO_COCK"] == undefined) output("  The smell of her hot, inferior seed hits your nostrils, exciting you even further as it rolls off of you in thick globs.");

	output("\n\nYou feel like an over-pressurized tank that's just been tapped.  One moment, there's indescribable force all bottled up inside you, and the next you're letting it spray out in long waves, each one guided through your urethra by contractions so violent they cause your whole body to shake each time.  You pump long lances of seed into the shark-girl's ready snatch.  She screams, \"<i>Yes!  Give it to me!  Ohhh, gods, YES!</i>\" as you fill her.");
	if (flags["COC.IZMA_INCUBATION"] != undefined) {
		output("  Her womb remains steadfastly closed, already seeded to capacity, so your salty deposit quickly floods the smaller canal.  The tendrils go lax as they're dipped in your baby-batter, each limp in the heady flow.");
		if (pc.hasKnot(pc.biggestCockIndex())) output("  Your knot balloons explosively inside her, but the seal on her womb is tighter.");
		output("  Jism rushes out around your cock in a river.  The nest was already soaked with liquid lust from your last tryst, moments ago, but now it's soaked completely white.  After a while, Izma's actually forced off you by the incredible potency of your eruptions, falling flat on her back.");
	}
	else {
		output("  Her womb beckons for your spunk, and the tentacles undulate slowly, working like tiny paddles to push every single drop deep into her uterus.  You cum until your eyes cross, but you still manage to watch Izma's taut midriff bulge out, her striped skin stretching smooth with the sloshing weight you're pumping into her.  She moans and rubs her hands across the increasingly spherical distention, holding herself down on top of you seal in as much as possible.");
		if (pc.hasKnot(pc.biggestCockIndex())) output("  Of course, with a knot like yours there's no need for that.  You keep her sealed up so tightly that she has no choice but to take every drop.");
		output("  The tigershark babbles, \"<i>So... full</i>\" and topples over backward under her own doubled weight");
		if (pc.hasKnot(pc.biggestCockIndex())) output(", your dong forced out with a noisy 'SCHLURRRPOP'");
		output(".");
	}
	output("\n\nIzma pants, \"<i>Ung... mmm... so much,</i>\" and cradles her ");
	if (flags["COC.AMILY_INCUBATION"] == undefined) output("jizz-bloated");
	else output("child-bearing");
	output(" middle.  You're still going, still spurting, but without a tight hole to fill, there's just no pleasure on it.  You start to push yourself up - you need to impregnate something, but Amily is there in a flash, still jilling her pussy as she stuffs her ass with your squirting cock.  It slides on in with ease thanks to its copious spurting and the double-dose of cunt-juice that wreathes it.");

	output("\n\nThe gravid mouse-girl purrs, \"<i>You can use my ass... my mouth.  I don't care, [pc.name].  I love you and I'll let you knock up all my holes, as long as you keep me full...</i>\"  Her heavy belly drops down on top of you, pinning you there, and she pivots on it, bouncing her ass on your cock while you give her an alabaster enema.  Amily moans, \"<i>Take me, [pc.name]!</i>\" and throws her head back, rolling her nipples in her fingers. Her tail slips into your [pc.asshole] and presses up on your prostate, milking a few last, long squirts from you.  She's too packed to take much more, but thankfully, you don't have much more to give, as the tigershark-girl took most of it.");

	output("\n\nAs the orgasm passes, you find yourself invigorated rather than exhausted.  Meanwhile, Amily is wobbling about unsteadily, and you pick her up, slowly exiting her ass, your dick already washed clean by the tide of ejaculate that drains from her plugged bottom.");

	output("\n\nIzma is still fairly out of it, but when you wave your [pc.cock " + pc.biggestCockIndex() + "] under her nose, she perks right up.  A wet, pink tongue slithers out of her open maw, and her teeth retract, leaving you with a smiling cock-sucker just waiting for a snack.  As soon as your [pc.cock " + pc.biggestCockIndex() + "] sinks into her mouth, your [pc.legs] give out, and you tumble down next to her, overwhelmed.  You're ultra sensitive after two back-to-back orgasms, and feeling that slippery muscle undulating across your length is just too much for you.  You groan in satisfaction and pull Izma down against your groin, weakly pumping against one member of your pregnant harem.");

	output("\n\nYour vision goes black when a " + amilyButt() + " suddenly lands across your face, smearing her sperm-slicked pussy-lips against your mouth.  The owner of that fine ass's tangy taste is layered in with your juices, and you begin to please her orally, if only to have her ready for another filling.");

	output("\n\nAmily moans, \"<i>You're so good to us, [pc.name],</i>\" while Izma agrees, \"<i>Mmmphhmmm!</i>\" around your dick.  Your ");
	if (pc.balls > 0) output("[pc.balls] are");
	else output("body is");
	output(" already refilling, and you know that before long, you'll give Izma enough to keep her fed for a week.  It's hard to think with lightning bolts of pleasure exploding in your cock and a mouth stuffed full of cummy cunt, so you don't.  You let the scent of the mixed sexual juices and the feel of Izma's mouth take over, enjoying simple reciprocation until your next cum, one you barely remember aside from the blackout inducing ecstasy.");
	//[Next]
	processTime(35);
	clearMenu();
	addButton(0,"Next",izmaAmilyDrugThreeWaySex3);
}

private function izmaAmilyDrugThreeWaySex3():void {
	clearOutput();
	pc.orgasm();
	//dynStats("sen", -3);
	output("<b>Some time later...</b>\n");
	output("You come to in a daze.  You're soaked in sexual juices of all kinds from the waist down, though for once, [pc.eachCock] has gone soft.  Izma is snuggled up under your left arm and Amily under your right.  They're still asleep, but they're even more soaked than you, and hugging each other across your body.  The potion may have worked a little differently than Amily designed it to, but you can't really complain about the results.");
	if (flags["COC.IZMA_INCUBATION"] == undefined || flags["COC.AMILY_INCUBATION"] == undefined) {
		output("\n\n(<b>");
		if (flags["COC.AMILY_INCUBATION"] == undefined) {
			output("Amily");
			amilyPreggoChance(true);
			if (flags["COC.IZMA_INCUBATION"] == undefined) output(" and ");
		}
		if (flags["COC.IZMA_INCUBATION"] == undefined) {
			output("Izma");
			//izmaPreg(true);
		}
		output(" definitely got pregnant.</b>)");
	}
	processTime(60 * 2 + rand(60));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Amily Nurse RP
//The player gives Amily a Skimpy Nurse's Outfit (the first time only), and she asks them if they want a checkup. Amily then proceeds to 'examine' the player and 'diagnoses' them with blue balls (or the prostate equivalent if the player has no balls). Obviously this must be 'treated' immediately by way of Amily having sex with the pc. Must include the possibility of impregnating Amily if she's off her herbs, but not necessarily limited to just vaginal penetration. Bonus points if she asks the player to make an appointment for a follow-up exam afterwards.
//This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.

//Prompt to Give It To Her:
//	You could give Amily the nurse's outfit you got, though it barely covers anything at all, and would likely be inviting some roleplay from the kinky mouse-girl.
//	{No dick: You have a hunch if you were a male, giving Amily a nurse's outfit might set off some kinky roleplay.}
//	{You have a hunch that if you had a nurse's outfit you could get Amily to give you a rather erotic checkout{, provided you had a dick}.}

//Give It To Her/Repeat Sex Option
//[NurseCheckup]
public function amilyNurseCheckup():void {
	clearOutput();
	//First Time
	processTime(6);
	clearMenu();
	if (flags["COC.GIVEN_AMILY_NURSE_OUTFIT"] == undefined) {
		pc.destroyItem(new CoCNurseOutfit());
		flags["COC.GIVEN_AMILY_NURSE_OUTFIT"] = 1;
		output("You hand Amily the enticing garments with a roguish smile.  Her eyes seem confused at first, but a knowing, playful grin spreads over her features.  Slapping you with the costume, she teases, \"<i>What is this supposed to be, [pc.name]?</i>\"  The fabric stretches across her as she holds it up in front of her 'assets'.  \"<i>This is barely modest!</i>\"");
		output("\n\nShe rounds on you, her tail rubbing on your leg as she steps closer, holding the thin fabric tight to her lithe body.  \"<i>Did you want me to look obscene for you?  To look like a naughty nurse?</i>\"  Her ears twitch as she mulls it over.");
		output("\n\nYou try to answer, but before you get a half-dozen words out, Amily prances off behind some rocks, warning, \"<i>No peeking!</i>\"  The rustling of clothing can be heard as she changes, underscored by mischievous humming noises.  You do your best to wait patiently, but [pc.eachCock] is warm and anxious.");
		output("\n\nA sultry voice purrs, \"<i>Ah, [pc.name].  Come on in, it's time for your check-up.</i>\"");
		amily.armor.longName = "a naughty nurse's outfit";
		clearMenu();
		addButton(0, "Next", amilyNurseCheckupV2, false);
	}
	//Repeat
	else {
		output("\"<i>You want another check-up?</i>\" Amily says.  \"<i>Well, okay.  Let me get the outfit!</i>\"  She turns, her tail smacking your [pc.butt] as she runs behind some rocks to grab the skimpy white \"dress\", if it can be call that.  You wait with undisguised excitement, twiddling your thumbs to pass the time.");
		output("\n\nEventually, Amily's fair voice purrs out, \"<i>Time for your checkup, [pc.name].  You must have quite the condition since you keep coming back.  Come on in...</i>\"");
		clearMenu();
		addButton(0, "Next", amilyNurseCheckupV2, true);
	}

}

//[Next] - both merge here
private function amilyNurseCheckupV2(repeat:Boolean):void {
	clearOutput();
	var x:int = pc.cockThatFits(amily.vaginalCapacity());
	output("You step in to Amily's office, as it were.  It's really just a cluster of boulders, but with the way the mouse-girl is looking about imperiously and gesturing for you to sit on a flat rock, you really do feel like you're back at the village doctor, getting checked on to make sure you're okay.  As for Amily, she's looking fine... mighty fine indeed.  Her " + amilyTits() + " nicely fill the tight, cleavage exposing top, while her ");
	if (flags["COC.AMILY_INCUBATION"] > 7 * 168 / 2) output("slightly-protruding pregnancy is exposed beneath it");
	else if (flags["COC.AMILY_INCUBATION"] != undefined) output("pregnancy-swollen tummy rounds out beneath it");
	else output("taut midriff is fully on display");
	
	output(".  The clingy bottom is little more than a micro-skirt, short enough that it nearly exposes her vagina to your roaming eyes.");
	if (amily.hasCock()) output("  It bulges out lewdly in a sheer outline of her " + amilyCock() + ", which is curled over to remain inside the stretchy skirt.");
	if (amily.longestCockLength() > 9) output("  The effort is a failure, as her immense cock is simply too big for such a slinky covering, and the fat tip curves down to dangle below the hem, pulsing dangerously.");
	output("  To complete the outfit, a tiny, white hat with a red cross adorns her head, tilted slightly off-center.");

	output("\n\n\"<i>Please, take off your clothes, [pc.name].</i>\" she playfully recites, holding a flat piece of wood she must have found in a hurry like a clipboard.  \"<i>Now, it says here you are feeling feverish around females, particularly young, healthy mice.  I also see mentions of an out-of-control libido.  Is this right?</i>\"");

	output("\n\nYou listen as you undress, sitting down on the stone when instructed and nodding along with the list of symptoms.  They sound pretty accurate to your ears.  A soft ");
	if (!amily.hasFur()) output("hand");
	else output("paw");
	output(" touches your thigh as Amily sets the 'clipboard' aside.");

	output("\n\nShe says, \"<i>Let's get on with the examination then, shall we?</i>\"");

	output("\n\nYou nod, perhaps a little too eagerly, but Amily doesn't seem to mind.  In fact, her touches grow more direct and suggestive, trailing up your thigh to your belly, then down to the sensitive " + pc.skinFurScales() + " just above your crotch.  She rubs there in soft, gentle circles while her other hand gracefully explores your back.  Naked and exposed before the horny mouse, you can't help but grow excited with an immediacy that startles even you.  [pc.EachCock] rockets to full size in a split second, almost vibrating from the force of your erection.  You moan out loud, something Amily plays off to be pain.");

	output("\n\n\"<i>Oh I see, such a painful condition to endure,</i>\" she murmurs as her hand meets the lust-thickened pole.  Her fingers flutter down the length");
	if (pc.balls == 0) output(", testing to engorgement with soft squeezes that are almost painful with how aroused you've become.");
	else {
		output(", eventually coming to rest on your [pc.sack].  She dutifully hefts your [pc.balls], ");
		if (pc.ballSize() <= 4 * Math.PI) output("rolling them in her fingers with a sly smile");
		else output("letting her fingers sink into one of the swollen orbs with a sly smile");
		output(".");
	}
	output("  Watching your face the whole time, Amily smiles seductively when you begin to pant.  You miss it, too busy looking down her exposed cleavage, enhanced by the chest-compressing tightness of her naughty nurse's outfit.  A none-too-subtle squeeze on your sensitive genitals draws you back to the present");
	if (pc.hasVagina()) output(", while a sneaky finger slides into your cleft, testing the wetness");
	output(".");

	output("\n\nAmily explains, \"<i>It's ");
	if (pc.balls > 0) output("Blue Balls");
	else output("Boneritus");
	output(", I think.  It's a condition that affects exceptionally virile males and herms like yourself from time to time.  Thankfully, it isn't permanent.</i>\"  Her crotch-bound hand squeezes and strokes across your sensitive genitals.  \"<i>Unless of course, you want it to be.</i>\"  She tugs your stiff mast from the [pc.sheath] up to the [pc.cockHead " + pc.biggestCockIndex() + "] slowly, milking a dollop of pre-cum from it as she prattles on.  \"<i>We have a new treatment I've been pioneering, but it is very experimental.</i>\"");

	output("\n\nYou moan, \"<i>Oohhh, what is it?</i>\"");

	output("\n\nAmily abruptly releases your over-engorged pecker and lifts her leg high enough to place it on your shoulder, stretching the obscene skirt up on to her hips, her womanhood laid bare just inches from your [pc.face].  \"<i>Mouse-cunt,</i>\" she breathes.  \"<i>Again and again, until the naughty spunk is out and your ");
	if (pc.balls > 0) output("plump balls are");
	else output("stiff shaft is");
	output(" freed from the perverted needs that afflict you.</i>\"");

	output("\n\nYour pupils contract into needy pinpricks as her scent slithers up your nose, and you lean forward to stuff your tongue straight up that wet snatch, feeling the hot, wet heat clinging to your muscle as you spear the mouse's slick channel.");

	output("\n\n\"<i>Yessss... this is another symptom... inability to resist sexu... sexua - ooOOH, right there!  Sexual contact.  You've got it so bad, don't you?</i>\" Amily pants as you assault her ripe pussy.");

	output("\n\nYou nod into the feminine vice, your nose bumping and grinding against a stiff clit.  Your hands raise and grab hold of your nurse by her " + amilyButt() + " to pull her against you, to get your tongue deeper inside.  Shuddering slightly, she wiggles out of your grip and lowers her leg, stumbling a bit weakly on legs that aren't working the way they should.  The moist rodent-girl is panting heavily as she recovers from your oral assault, but after a few breaths, she whispers, \"<i>That was nice, but it's time to administer the treatment.</i>\"");

	output("\n\nAmily unbuttons the top, letting her breasts sway freely as she climbs ");
	if (!pc.isTaur()) output("into your lap");
	else output("alongside your [pc.lowerBody]");
	output(".  \"<i>J-just relax.  This won't hurt a b-bit,</i>\" she stutters as she aligns her entrance with your " + pc.cockDescript(x) + ", pungent humidity rolling off her sex in steamy waves.  Your tip slowly parts her glittering mound, accompanied by a burst of ecstasy that has you slumping back against a boulder, tongue hanging out happily.  The petite mouse slowly undulates her waist as she takes more and more of your length into her box, the mousy muff eventually coming to rest against your [pc.hips] with an almost apologetic pause in friction.");

	output("\n\nThrowing her head back, the mouse-girl moans in excitement, and you feel her tunnel squeeze down on your " + pc.cockDescript(x) + ", compressing it with forgiving, soft pressure.  Her secretions slowly trickle out onto you");
	if (pc.cockTotal() > 1) {
		output(" as her hand finds its way to ");
		if (pc.cockTotal() > 2) output("one of your extra cocks");
		else if (pc.cockTotal() == 2) output("your extra cock");
		output(".  Slowly, she pumps the spare shaft, muttering something about, \"<i>Treating allll the symptoms.</i>\"");
	}
	output(".\n\nSlowly dragging her tightly-clinging pussy up your rod, the nurse begins to properly treat your condition, and it's surely working, for you're already releasing slow pulses of pre into her pussy.  Amily throws her head back and cries out even louder, the silly little hat tumbling off behind her as her hair swishes back and forth with her every convulsion.");

	output("\n\nThe petite woman's skillful cock-manipulations have you squirming uncomfortably under her on the cusp of a blissful explosion for what seems like hours.  She whines, \"<i>Give it to me, [pc.name]!  Fuck your naughty, nasty nurse!  Screw her silly! Yesssssss-!</i>\"  Her voice loses cohesion as she cums, and her pussy begins to assault you with sensuous, milking ripples all along your length.  [pc.EachCock] squirts in response, accompanied by a clenching spasm of pleasure that crashes through the very fibres of your being.  Your [pc.hips] lurch upward, hard enough to bounce the mouse into the air as you inseminate her.");
	if (pc.cumQ() >= 500) {
		output("  The steady rhythm of your spurts goes on unabated for well over thirty seconds, ");
		if (flags["COC.AMILY_INCUBATION"] == undefined) output("slowly filling Amily's womb to capacity");
		else output("slowly forcing trails of semen out of her entrance");
		output(".");
		if (pc.cumQ() >= 2000) {
			output("  Amily hangs on for dear life as ");
			if (flags["COC.AMILY_INCUBATION"] == undefined) output("she's filled to capacity, her stretchy, mallaeble middle bulging lewdly with spunky jizz, sloshing with each fresh injection.");
			else output("torrents of the stuff spray out of her entrance, her canal too filled to hold even a drop more and your penis continuing to push the pressure higher.");
		}
		if (pc.cumQ() >= 500) output("  It turns your crotch into a sticky mess.");
	}

	output("\n\nYour body goes limp as it spends the last of your desire into Amily's spasming slit.  Her body is wracked by one last convulsion");
	if (amily.hasCock()) output(" that flings sticky ropes across your [pc.chest].  Her back arches as she continues to launch her own jism towards you");
	output(", and then she too sags down against you, hugging you as she says, \"<i>That was... intense.</i>\"  She tries to rise, but her legs fall limp halfway up.");
	if (pc.hasKnot(x)) output("  She tries again.  This time, it's your knot that keeps her rooted firmly in place, and she stays plugged like that for a good twenty minutes, her cunt basting in your animal-spooge as she enjoys the fullness only a thick knot can provide.");
	output("  Finally, she makes it up and off of you.  Her pussy is nice and wet, matted with white.");

	output("\n\nYou rise and kiss Amily on the lips, thanking her for the checkup before you pick up her hat and put it back on her head, mentioning that you're not sure her cure took.");

	output("\n\nAmily tips her head to the side, smiling in post-coital bliss as she clenches her thighs together to hold in your cum.  \"<i>We had better schedule an appointment for your next visit then, hadn't we?</i>\"");
	if (!repeat) output("\n\n(<b>Nurse RP sex option unlocked for Amily!</b>)");
	pc.orgasm();
	//dynStats("sen", -2);
	amilyPreggoChance();
	processTime(45);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}