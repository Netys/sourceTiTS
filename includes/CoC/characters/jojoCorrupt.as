import classes.Engine.Combat.applyDamage;
import classes.Engine.Combat.DamageTypes.TypeCollection;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Transformatives.CoCIncubiD;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

		//public var pregnancy:PregnancyStore;
//
		//public function JojoScene()
		//{
			//pregnancy = new PregnancyStore(kFLAGS.JOY_PREGNANCY_TYPE, kFLAGS.JOY_PREGNANCY_INCUBATION, kFLAGS.JOJO_BUTT_PREGNANCY_TYPE, kFLAGS.JOJO_EGGCUBATE_COUNT);
			//pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 150, 120, 96, 72, 48);
			//CoC.timeAwareClassAdd(this);
		//}
//
		////Implementation of TimeAwareInterface
		//public function timeChange():Boolean
		//{
			//pregnancy.pregnancyAdvance();
			//if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) trace("\nJoy time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation);
			//else trace("\nJojo time change: Time is " + model.time.hours + ", butt incubation: " + pregnancy.buttIncubation);
			//if (flags[kFLAGS.JOJO_COCK_MILKING_COOLDOWN] > 0) flags[kFLAGS.JOJO_COCK_MILKING_COOLDOWN]--;
			//if (pc.findStatusEffect(StatusEffects.NoJojo) >= 0) pc.removeStatusEffect(StatusEffects.NoJojo);
			//if (pregnancy.isButtPregnant && pregnancy.buttIncubation == 0) {
				//jojoLaysEggs();
				//return true;
			//}
			//if (pc.findStatusEffect(StatusEffects.PureCampJojo) >= 0 && inventory.hasItemInStorage(consumables.BIMBOLQ) && flags[kFLAGS.JOJO_BIMBO_STATE] == 0 && flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO] < 72) {
				//flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO]++;
			//}
			//if (flags[kFLAGS.JOJO_BIMBO_STATE] == 2 && flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO] < 24) {
				//flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO]++;
			//}
			//if (pregnancy.isPregnant) {
				//if (joyScene.joyPregnancyUpdate()) return true;
			//}
			//if (flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] > 1) {
				//flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER]--;
			//}
			//return false;
		//}
	//
		//public function timeChangeLarge():Boolean {
			//return false;
		//}
		////End of Interface Implementation
//
	//protected function set monk(value:Number):void{
		//flags["COC.JOJO_STATE"] = value;
	//}

//const TIMES_AMILY_AND_JOJO_PLAYED_TIMES:int = 434;
//const AMILY_X_JOJO_COOLDOWN:int = 435;
//const JOJO_MOVE_IN_DISABLED:int = 550;
//const TIMES_EGGED_JOJO:int = 590;
//const JOJO_EGGCUBATE_COUNT:int = 591;

public function JojoTimePassedNotify(deltaT:uint, doOut:Boolean = true):void {
	var newTimestamp:uint = timeAsStamp + deltaT;
	if (timeAsStamp / (60 * 24) < newTimestamp / (60 * 24)) // once per day
		if (flags["COC.JOJO_DISABLED"] == 1) flags["COC.JOJO_DISABLED"] = undefined;
}

private var JojoTimePassedNotifyHook: * = JojoTimePassedNotifyGrapple();
private function JojoTimePassedNotifyGrapple():* { 
		timeChangeListeners.push(JojoTimePassedNotify);
	}

public function tentacleJojo():Boolean {
	return flags["COC.JOJO_TENTACLES"] == 1;

}

public function campCorruptJojo():Boolean {
	return flags["COC.JOJO_STATE"] >= 5 && int(flags["COC.JOJO_DISABLED"]) == 0 && int(flags["COC.JOJO_DEAD_OR_GONE"]) == 0 && flags["COC.JOJO_DISABLED"] == undefined && int(flags["COC.JOJO_DEAD_OR_GONE"]) == 0;
}

private function jojoMutationOffer():void {
	showJojo();
	clearOutput();
	output("A wicked idea comes to mind while thinking of Jojo.  The lethicite you took from the lake goddess – perhaps it could be used to enhance your own budding demonic powers, and twist your mousey fuck-puppet into a truly worthy pet?\n\n<b>Do You?</b> (WARNING: Offered only once & unlocks tentacle content)");
	clearMenu();
	addButton(0, "Yes", jojoMutationOfferYes);
	addButton(1, "No", jojoMutationOfferNo);
}

private function jojoMutationOfferNo():void {
	showJojo();
	clearOutput();
	output("There are some lines even you won't cross.  Besides, having a sex-addled mouse with a constantly drooling foot-long cock is all the fun you can handle.\n\nWith that decided you prepare to call on your slut.");
	//Normal jojo sex scene here
	addNextButton(corruptJojoSexMenu);
}

//CORRUPT CAMP JOJO
public function corruptCampJojo():void {
	clearOutput();
	showJojo();
	if (int(flags["COC.FOLLOWER_AT_FARM_JOJO"]) == 0)
	{
		//Corrupt Amily and Jojo sexings
		if (amilyFollower() && amilyCorrupt() && campCorruptJojo() && int(flags["COC.AMILY_X_JOJO_COOLDOWN"]) <= 0 && rand(5) == 0 && int(flags["COC.FOLLOWER_AT_FARM_AMILY"]) == 0) {
			flags["COC.AMILY_X_JOJO_COOLDOWN"] = 7;
			amilyTeachingJojoBJ();
			return;
		}
		//Oh shit goes down! (Wiv Tentacles)
		if (amilyFollower() && !amilyCorrupt() && int(flags["COC.AMILY_DISCOVERED_TENTATLE_JOJO"]) == 0 && rand(10) <= 1 && tentacleJojo()) {
			amilyDiscoversJojoWithTentaclesAndShitOhBoy();
			return;
		}
		//Oh shit goes down! (No tentacles)
		if (amilyFollower() && !amilyCorrupt() && int(flags["COC.AMILY_PISSED_PC_CORRUPED_JOJO"]) == 0 && rand(10) <= 1 && !tentacleJojo()) {
			amilyIsPissedAtYouForRuiningJojo();
			return;
		}
		//Offer lethicite jojo tf if the player is ready
		if (int(flags["COC.JOJO_TF_OFFERED"]) == 0 && pc.hasKeyItem("Marae's Lethicite") && pc.keyItemv2("Marae's Lethicite") < 3 && pc.cor() >= 75) {
			flags["COC.JOJO_TF_OFFERED"] = 1;
			jojoMutationOffer();
			return;
		}
		output("Before you call for your corrupted pet, how do you want to use him?");
	}
	else
	{
		output("Jojo slinks out of a barn when you call his name, hating and loving every step he takes towards you. He looks dusty and worn out but his dick still strains at the sight of you.");
		
		// Appearance splice lel
		output("\n\nJojo is an anthropomorphic mouse with immaculate white fur. His brown eyes stare at you with a mixture of despair and unrequited need. Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed. He’s naked, with a large tainted throbbing member bouncing at attention. A fuzzy sack with painfully large looking balls dangles between his legs.");
		if (tentacleJojo()) output(" A number of tentacles vaugley resembling cocks have sprouted from his back and groin. They sway restlessly around him, oozing thick, fragrant pre from their tips.");
		
		//if (kGAMECLASS.farm.farmCorruption.hasTattoo("jojo"))
		//{
			//output("\n\n");
			//if (kGAMECLASS.farm.farmCorruption.jojoFullTribalTats())
			//{
				//output("He is covered from head to tail in tribal tattoos, erotic lines snaking all over his naked frame, giving him the look of a barely tamed savage.")
			//}
			//else
			//{
				//if (kGAMECLASS.farm.farmCorruption.numTattoos("jojo") > 1) output("He has the following tattoos emblazoned across his body:\n");
				//else output("He has ");
				//
				//if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] != 0) output(flags[kFLAGS.JOJO_TATTOO_COLLARBONE] + "\n");
				//if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] != 0) output(flags[kFLAGS.JOJO_TATTOO_SHOULDERS] + "\n");
				//if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] != 0) output(flags[kFLAGS.JOJO_TATTOO_LOWERBACK] + "\n");
				//if (flags[kFLAGS.JOJO_TATTOO_BUTT] != 0) output(flags[kFLAGS.JOJO_TATTOO_BUTT] + "\n");
				//output("\n");
			//}
		//}
		
		
		if (flags["COC.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT"] == 1)
		{
			flags["COC.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT"] = 2;
			output("\n\nYou wordlessly hold out your hand. Trembling, Jojo lays an incubus draft on it.");
			
			output("\n\n“<i>M-mistress Whitney says s-she'll put the rest with your cut of the farm profits [pc.master].</i>”\n\n");
			
			itemScreen = corruptCampJojo;
			lootScreen = corruptCampJojo;
			useItemFunction = corruptCampJojo;
			itemCollect([new CoCIncubiD()]);
			return;
		}
		else
		{
			output("\n\n“<i>What can I do for [pc.master]?</i>”");
		}
	}
	
	clearMenu();
	addDisabledButton(0, "Sex", "Sex", "This option requires you to have genitals and sufficient arousal.");
	addDisabledButton(1, "TentacleSex", "Tentacle Sex", "This option requires you to have tentacled Jojo and sufficient arousal.");
	addDisabledButton(2, "Milk Him", "Milk Him", "This option requires you to have installed cock milker.");
	addDisabledButton(3, "TentacleMilk", "Tentacle Milk", "This option requires you to have tentacled Jojo having experience with the installed cock milker.");
	addDisabledButton(4, "HairCare", "Hair Care", "This option requires you to know the locaation of Lynette's salon.");
	addDisabledButton(5, "Lay Eggs", "Lay Eggs", "This option requires you to have bee ovipositor.");
	addButton(14, "Back", campSlavesMenu);
	
	if (pc.lust() >= 33) {
		addButton(0, "Sex", corruptJojoSexMenu);
		if (tentacleJojo()) addButton(1, "TentacleSex", useTentacleJojo);
	}
	
	if (flags["COC.COCK_MILKER_INSTALLED"] == 1) {
		if (flags["COC.JOJO_COCK_MILKING_COOLDOWN"] > timeAsStamp) {
			addDisabledButton(2, "Milk Him", "Milk Him", "Jojo is still drained from his last visit to the milkers - you should wait a few hours before taking him back.");
			addDisabledButton(3, "TentacleMilk", "Tentacle Milk", "Jojo is still drained from his last visit to the milkers - you should wait a few hours before taking him back.");
		}
		else if (flags["COC.JOJO_TIMES_MILKED"] > 0) {
			addButton(2, "Milk Him", repeatMilkJojo);
			if(tentacleJojo()) addButton(3, "TentacleMilk", repeatMilkJojo, true);
		}
		else
			addButton(2, "Milk Him", milkJojoFirst);
	}
	
	if (flags["COC.GOBLIN_SALON_FOUND"] > 0) addButton(4, "HairCare", jojoPaysForPerms);
	
	if (pc.canOvipositBee() && pc.eggs >= 10) {
		addButton(5, "Lay Eggs", beeEggsInCorruptJojo);
	}
	
	if (flags["COC.FARM_CORRUPTION_STARTED"] == 1 && int(flags["COC.FOLLOWER_AT_FARM_JOJO"]) == 0) addButton(6, "Farm Work", sendJojoToFarm);
	if (flags["COC.FARM_CORRUPTION_STARTED"] == 1 && flags["COC.FOLLOWER_AT_FARM_JOJO"] == 1) addButton(6, "Go Camp", backJojoToCamp);
	
	if (flags["COC.FOLLOWER_AT_FARM_JOJO"] == 1 && int(flags["COC.FOLLOWER_PRODUCTION_JOJO"]) == 0) addButton(7, "Harvest Draft", harvestJojoDraft);
	if (flags["COC.FOLLOWER_AT_FARM_JOJO"] == 1 && flags["COC.FOLLOWER_PRODUCTION_JOJO"] == 1) addButton(7, "Stop Harvest", stopHarvestJojoDraft);
	
	//if (flags["COC.FOLLOWER_AT_FARM_JOJO"] == 1) addButton(14, "Back", kGAMECLASS.farm.farmCorruption.rootScene);
}

private function harvestJojoDraft():void
{
	clearOutput();
	showJojo();
	
	output("You tell Jojo that you want him hooked up to a cock milker whenever possible; you need his fluids.");

	output("\n\n“<i>Th-that’s why you wanted me to come out here? To... harvest me?</i>” Jojo’s mouth opens to the monstrosity of it, even as his dick strains helplessly to the selfsame idea.");
	
	if (int(flags["COC.FARM_UPGRADES_REFINERY"]) == 0) output("\n\n“<i>I-I’m sorry [pc.master], but there’s no device around here that could be used t-to do that. Talk to Mistress Whitney, maybe she can have one built.</i>”");
	else output("\n\n“<i>As you wish [pc.master],</i>” he whispers.");
	
	if (flags["COC.FARM_UPGRADES_REFINERY"] == 1) flags["COC.FOLLOWER_PRODUCTION_JOJO"] = 1;
	
	//addNextButton(kGAMECLASS.farm.farmCorruption.rootScene);
	addNextButton();
}

private function stopHarvestJojoDraft():void
{
	clearOutput();
	showJojo();
	
	output("You tell Jojo to stop producing incubus draft; you’re practically drowning in the stuff. Jojo closes his eyes, and you grin as you envisage the image you’ve just planted in his mind.");

	output("\n\n“<i>Would you like that, Jojo? To literally drown in your [pc.master]’s fluids? Well, maybe later. For now, when you’re fapping to the idea, squirt your useless cum somewhere other than into a bottle, got that?</i>”");

	output("\n\n“<i>Yes [pc.master],</i>” says Jojo lowly.");

	flags["COC.FOLLOWER_PRODUCTION_JOJO"] = undefined;
	
	//addNextButton(kGAMECLASS.farm.farmCorruption.rootScene);
	addNextButton();
}

private function sendJojoToFarm():void
{
	clearOutput();
	showJojo();
	
	output("You tell your pet mouse");
	if (tentacleJojo()) output("-come-tentacle-beast");
	output( " that he is to head towards the lake, find a farm, present himself to the lady who works there and do as she says.");

	output("\n\nA mixture of expressions vie for control of Jojo’s face as he swallows this information; you grin as you realize that being at the farm will simply amplify the fact he is both delighted and horrified at being away from you.");

	output("\n\n“<i>I need you to be doing more than jacking off to the thought of servicing me, frankly. Don’t worry though, slut, I will always be close by, and if you’re really lucky and work hard, I might come and fuck you so rotten you can’t walk every now and then. Go on now!</i>”");

	output("\n\n“<i>As... as you wish [pc.master],</i>” whispers Jojo, and shakily walks off towards the lake. He will make a decent worker for Whitney, you think, and his haunted midnight pacing will at least add a bit of vigilance to the farm.");
	
	flags["COC.FOLLOWER_AT_FARM_JOJO"] = 1;
	
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function backJojoToCamp():void
{
	clearOutput();
	showJojo();
	
	output("You tell him to head back to camp; there are things you need to do to him you can’t do whilst he’s here. Repeatedly. Jojo trembles, manages a bow, and then slowly trails off towards camp.");
	
	flags["COC.FOLLOWER_AT_FARM_JOJO"] = undefined;
	
	//addNextButton(kGAMECLASS.farm.farmCorruption.rootScene);
	addNextButton();
}

private function jojoMutationOfferYes():void {
	showJojo();
	clearOutput();
	pc.addKeyValue("Marae's Lethicite", 2, 1);
	output("There's no question about it, this is a great idea.  It might be coming from the corruption in your blood, but why bother to fight it?  You take Marae's lethicite and grab one of the larger crystalline protrusions.  With a hard yank, you break it off from the main cluster, sending tiny crystalline shards over the campsite.  They vanish into the ground before you have a chance to gather them.\n\n");
	output("Whether by luck or some unconscious demonic magic, the smaller piece of lethicite is rather phallic. If it weren't for the sharp corners and hard edges, it would look like a large dildo with a pair of balls at the base.  You put away the larger piece, focusing this tool and your plans for your pet.\n\n");
	output("You lick the sharp crystalline dildo, slathering it with spit.  You aren't sure, but you seem unable to stop.  It's as if some demonic force guides you.  It's difficult to focus on much beyond your own arousal and the tingling feeling that spreads through your body as you taste this piece of a goddess' essence.  Your mind drifts off into a perverted fantasy, unable to cope with total loss of control and oral debauchery.\n==========================================\n<i>");
	//[Male]
	if (!pc.hasVagina()) {
		output("In your fantasy you're fucking Jojo again, bottoming out against his cute girlish ass over and over.  His dick spurts mouse-milk with each thrust, feeding a dozen growing puddles underneath him as they slowly merge together.  He writhes and squirms, a pair of crystalline balls against his chin while he deep-throats a massive dildo.  You blast another wave into his overloaded spunk-dumpster, forcing a thick jet out of him and into the cum-puddles underneath you.\n\n");
		output("Tired of the foreplay, you pull out of him, watching a river of your cum escape from the uncorked opening.  You pull him up, watching the crystal cock slide out of his mouth, the bulge along his throat slowly disappearing as each inch escapes.  He staggers, completely exhausted, but still hard and horny judging by the look in his eye.\n\n");
		output("You shove him over a log and grab his spit-slick toy, dragging it through the puddled cum until it's white and dripping.  Jojo whimpers, his disproportional member stuck between his legs and twitching with anticipation.  The dildo slides into his well-stretched hole with ease, sealing the rest of your tainted seed deep inside his bowels as your magic begins to change him...</i>\n==========================================\n");
		output("You snap out of the fantasy with a start.  The crystal shard is sitting on the ground in front of you, but it is no longer a shard – it's the dildo from your fantasy, complete with a thick covering of your cum.  You manage to pry your hand away from your softening member");
		if (pc.cockTotal() > 1) output("s");
		output(" and take the tainted artifact, now ready to be used.</i>\n");
	}
	//[Female] 
	else {
		output("In your fantasy, you're riding Jojo hard, milking his swollen dick with your pussy");
		if (!pc.isLactating()) output(" while your tits cover his head, nearly suffocating him");
		else output(" while he suckles one of your breasts hungrily, sucking down your [pc.milkNoun]");
		output(". A crystalline dildo is buried hilt-deep in his ass, held in place by a harness of your own design that twists it around every time he moves.  You cum again, relishing the desperate and needy look the poor mouse is giving.  Your spasming pussy is immediately filled with even more warmth, and you feel the thick spunk forcing its way into your core until you feel bloated.\n\n");
		output("You calm your trembling body and stand up off of him, soaking him with his own escaping fluids.  Jojo moans and starts pumping his dick, wriggling his hips while his orgasm is dragged on by the dildo squeezing his prostate.  You curl up alongside his ear and begin whispering into his mind, watching as your words soak in and begin to change him with the aid of the crystalline cock's magic.</i>\n==========================================\n");
		output("You snap out of your fantasy with a start.  The crystal shard is sitting on the ground in front of you, but it's no longer a shard – it's the dildo from your fantasy, now slick with pussy juices.  You touch your sore cunt and gasp when you realize where it went.  ");
		if (pc.vaginas[0].hymen) output("(Yet somehow your virginity remains intact).  ");
		output("The dildo disappears back into your inventory, and you smile in wicked anticipation of your next meeting with Jojo.\n");
	}
	output("\n<b>You just can't wait!  You'll call him over now...</b>");
	addNextButton(mutateJojo);
}

private function mutateJojo():void {
	showJojo();
	clearOutput();
	output("You call out, and Jojo obediently pads into the camp.  At some point he decided to switch to wearing a loin-cloth, for all the good it has done him – it drapes over his member, barely covering half of it as it twitches and throbs from your presence.  You gesture for him to remove that tiny cloth, and he does immediately.  When he gets within a few feet of you, he drops to his knees with his hands behind his back, his head down submissively.  You see little tics and twitches run through his body as he fights to resist touching himself, so you drag it out and see how long he can wait.\n\n");
	output("It doesn't take long.  A plaintive whine escapes him as his hand creeps around his waist.  You grin and push him onto his back, stepping onto his wrist to pin his hand in place.  You drop the crystal dildo onto his chest with a single command, \"<i>Use it</i>\".\n\n");
	output("Jojo shivers and takes your offering with his free hand, slowly hefting it and dragging it lower.  He looks up at you questioningly, and you gesture impatiently at him to quit wasting your time.  The dildo's crown presses against his sphincter, stopping for a second as the bitch-boy relaxes, and then begins its long journey inward.  Jojo's eyes roll up a bit and his prick starts pumping out a clear stream of his pre-cum, wetting most of his belly.  Finally the pinkish-hued balls press against his bum.  He's taken the whole thing.\n\n");
	output("While you still have one of the mouse's hands pinned under your " + pc.foot() + ", his other has already released the tainted sex-toy, and journeyed up to his pre-cum spurting cock.  You waste no time and push his hand away as you jump on top of him, being sure to grind your [pc.crotch] against his slick boner.  He keeps whining plaintively and wriggling his hips against you, but you deny him any further stimulation, instead focusing on keeping him horny while the tainted dildo settles in.\n\n");
	output("Jojo's moans reach a fevered pitch as a soft buzzing begins to fill the air behind you.  You turn around and see that the lethicite-crafted dildo has begun to vibrate inside of him!  Somehow you can feel that this is the time to change him – that his form is malleable and ready.  Your hand finds itself wrapped around the base of his cock, bottling him up until you're ready, while you lean up to his cute mouse-ears and start to whisper, \"<i>Aww, does my little rodent-bitch want to cum?</i>\"\n\n");
	output("He shakes his head and whines again, trembling underneath you.\n\n"); 
	output("\"<i>Too bad slut,</i>\" you say while you give his balls a squeeze, \"<i>you can't cum until I've changed you into the perfect fuck-toy.  A toy that can just keep cumming, more than once.  A toy who can fill more than one hole at a time.  A toy I could share with my friends, who could keep up with a succubus and an incubus simultaneously.  You'll be that toy for me.  My delicious fuck-puppet that cums on command with tentacle-dicks and pussy-vines aplenty.</i>\"\n\n");
	output("Jojo's eyes roll back until all you can see is the whites.  His mouth lolls open from pleasure and lets loose a constant stream of pants and moans.  Already you can feel his cock squirming in your hand, thrashing to get free.  The dildo starts vibrating louder, and his pre-cum manages to start spurting free again, despite your tight grip on his member.  You see his shoulders bulge as something starts wriggling under his skin, thrashing back and forth until they sprout free as a pair of tentacles.\n\n"); 
	output("Uncontrolled, the tentacles curl down to Jojo's vine-like member, wrapping it in coils until your hand is forced off and wriggling around it.  You note each of his new appendages is developing a flare at their tips, and the puddle of pre seems to be growing faster than it ever did before.\n\n");
	output("You whisper, \"<i>Good bitch, you'll be able to fuck every hole around you, won't you?  But all I see is an ass and a mouth for cocks.  You need some nice tight cock-sleeves don't you?</i>\"\n\n");
	output("On cue, you feel his tail curl up your back, already longer than it ever was before.  To your surprise the fur is vanishing, leaving you feeling smooth rubbery skin.  It splits three ways in an instant, but each grows thicker than his tail ever was before.  One curls over your shoulder as if looking for something, and reveals a strange sucking opening, sticky with some kind of fluid and filled with undulating fleshy ridges.\n\n");
	output("You smile and give the opening a lick – it's sweet – and turn back to his ear, \"<i>Now you're where I want you bitch.  Feel that dildo squeezing your prostate?  You'll cum just from that won't you?  Take those new tentacles off your dick and aim them at your face, I want to watch you give yourself a facial and cum all over yourself just from my other toy.</i>\"\n\n");
	output("Despite looking lost to the pleasure, his body obeys, releasing his dick and aiming his shoulder-tentacles at his open mouth.  You can see now that each is a dark green color, and capped with a shiny purplish head, just like the vines in the corrupted glade.  Each of them starts flaring wider, and you feel his cock snake up between your ");
	if (pc.biggestTitSize() < 1) output("bodies");
	else output(pc.allBreastsDescript());
	output(", until it pops out just under his chin, looking like a fatter version of the twins on his shoulders.  All three start flaring wider in preparation, and you know he is about to erupt.\n\n");
	output("\"<i>Good toy,</i>\" you whisper, \"<i>cum for your [pc.master].</i>\"\n\n");
	output("He submits happily, a smile overtaking his face in spite of his eyes rolled back and his tongue drooling all over his muzzle.  His entire body quakes, and you feel bulges beginning to pass under your [pc.chest].  You can see them moving up the shoulder tentacles with agonizing slowness, until all three cock-vines erupt simultaneously, splattering Jojo's face with his own seed.  The perfect synchronization is broken immediately when his primary tentacle blasts a glob into his hair, and then the entire scene devolves into a mess of quivering tentacles and splattering spooge.  Jojo's mouth catches plenty, and he begins swallowing instinctively as his tentacles do their best to drown him.\n\n");
	output("You pull back and watch, ");
	if (pc.cockTotal() > 0) {
		output("stroking your own [pc.cocksLight] ");
		if (pc.hasVagina()) output("and ");
	}
	if (pc.hasVagina()) output("caressing your aching twat ");
	output("as the mouse slowly paints himself with spoo.  By the time he has finished, he is soaked from head to toe, and lying in a puddle of his own making.  The tentacles fall limp and slowly begin to retract, until the only visible indication of their presence is a small lump on each shoulder.  His tails seem to regrow their fur in an instant, but they stay separate, and retain their thicker size.  Last but not least, you see that his member has shrunk back down to almost a foot and a half long, but has thickened up nicely.  Most of it returns to his natural pink skin-tone, but the head remains an angry purple as it stays hard and keeps drooling.\n\n");
	output("The dildo is gone, leaving only a hot pink tinge on the fur around his pucker.  Whatever dark magic you managed to imbue it with was used up by the transformation.  Jojo is still out cold, probably unable to cope with the force of his altered orgasm, but his body is doing an admirable job of adjusting.  You even see his three tails curling together until they look like one larger tail.  Only close inspection would reveal the difference.\n\n");
	output("You turn back to your tent, turned on beyond all measure, and needing to masturbate NOW.  You wonder what Jojo's new additions will feel like on your body when he wakes up, but for now you'll have to get off another way.");
	//dynStats("lus", 300, "cor", 10);
	pc.lust(pc.lustMax(), true);
	pc.cor(10);
	//(LIMITED MASTURBATE MENU – No Jojo)
	flags["COC.JOJO_DISABLED"] = 1;
	flags["COC.JOJO_TENTACLES"] = 1;
	
	clearMenu();
	addButton(0, "Next", masturbateMenu, true);
}

//[POST TENTACLE DICKINGS]
public function useTentacleJojo():void {
	showJojo();
	var nippleSucking:Boolean = false;
	var clitSucking:Boolean = false;
	var mouthFucking:Boolean = false;
	var titFucking:Boolean = false;
	var cumPuddle:Boolean = false;
	var milkPuddle:Boolean = false;
	clearOutput();
	output("You call out, \"<i>Sluuuuuut!</i>\"\n\n");
	output("A few seconds later Jojo comes bounding into camp on all fours, blushing furiously and with his ass high in the air, trying to keep his tumescent mouse-member from dragging along the ground.  He presents himself to you, putting his hands behind his back and displaying his prick.  It squirms and wriggles obscenely in a way that nothing that thick should be able to move.  Jojo is biting his lip and blushing hard at his uncontrollable display.  You note that despite his blush, the tiny lumps on his shoulders are growing larger and taking on a purplish hue, while his three tails have begun to disentangle themselves behind him.\n\n");
	output("Desperation hangs thick about him in the air as his newfound additions react to your summons.  Somehow he knows you wanted to use them, but he's trying to hold himself back like a good bitch.  You egg him on a bit, taunting, \"<i>Awww, look at the cute little tentacles begging to come out and play,</i>\" while you begin to brush your fingertips along underside of his writhing cock.  Jojo's eye cross from the pleasure, his member growing longer and longer under your touches until it's swaying in the air, snake-like, with its flared purple tip lying in the palm of your hand.\n\n");
	output("You drop it, letting it smack into the floor with a wet-sound 'SPLAT' that creates a puddle of pre-cum on the ground.  With your hands free, it is easy to quickly remove your [pc.gear] and toss it back towards your tent.  By the time you turn back around, his snake-like member is curling up your thigh, towards your [pc.vagOrAss].  ");
	if (pc.hasVagina()) output("You feel it split in half, dividing in order to take you from both ends.  ");
	output("You marvel at just how hard it is to dominate someone who can fuck you from a few feet away and wrap you up with a half-dozen appendages before you just give in and decide to enjoy it.\n\n"); 
	output("You put your arms on your hips and say, \"<i>Go ahead and ravage me then, but if I don't love every second of it you'll regret it.</i>\"\n\n");
	output("Looking very much like a starving man looking at a steak, Jojo smiles serenely and lashes out with his shoulder-tentacles, grabbing your arms and pinning them to your waist.  They wrap about your middle and lift you off the ground with ease.  Suspended in front of him, you're effortlessly rotated in place until your " + pc.assholeDescript() + " is in the air and your legs splayed apart, with the mutant-mouse's primary tentacle getting ever closer to your " + pc.assholeDescript());
	if (pc.hasVagina()) output(" and " + pc.vaginaDescript(0));
	output(".\n\n");
	//REAL SECKS STARTS HERE
	if (pc.hasCock()) {
		output("Upside down, you're forced to watch as his tail-tentacles curl out from between his legs, and extend towards your vulnerable [pc.cocks].  All three of them pause a few inches away for what seems an eternity, revealing circular dripping orifices filled with slimy wriggling cilia.\n\n");
		if (pc.cockTotal() == 1) {
			//(1dick+balls = 
			if (pc.balls > 0) {
				output("One of them lashes forwards, ");
				if (pc.cockVolume(0) > cockVolume(60)) output("laboriously stretching around");
				else if (pc.cockVolume(0) >= cockVolume(20)) output("engulfing");
				else output("easily swallowing");
				output(" your " + pc.cockDescript(0) + " in a tight vise of pleasure.  The other two tentacles slide under, each taking a " + pc.ballDescript() + " partially inside their 'mouths' and massaging them softly.");
				output("\n\n");
			}
			//(1 dick no balls = 
			else {
				output("One of them lashes forwards, ");
				if (pc.cockVolume(0) > cockVolume(60)) output("laboriously stretching around");
				else if (pc.cockVolume(0) >= cockVolume(20)) output("engulfing");
				else output("easily swallowing");
				output(" your " + pc.cockDescript(0) + " in a tight vise of pleasure.  The other two tentacles slide under, ");
				if (!pc.hasVagina()) output("rubbing back and forth along your taint and smearing you with their slime.");
				else {
					output("rubbing against your thighs and smearing them with lubricant while one of them easily sucks your " + pc.clitDescript() + " inside.");
					//(If big clit – 
					if (pc.clitLength >= 4) output("  You nearly cum on the spot from the clitoral stimulation; it's like you have a super-sensitive cock being licked by a thousand tongues.");
				}
				output("\n\n");
			}
		}
		//(2 dicks + 
		if (pc.cockTotal() == 2) {
			//balls)
			if (pc.balls > 0) {
				output("Two of them lash forward, ");
				if (pc.cockVolume(0) > cockVolume(60)) output("laboriously stretching around");
				else if (pc.cockVolume(0) >= cockVolume(20)) output("engulfing");
				else output("easily swallowing");
				output(" your [pc.cocks] in tight vises of pleasure.  The remaining tentacle slides underneath, alternatively taking each of your " + pc.ballsDescript() + " partway into its 'mouth' and massaging them with its thousands of wriggling stimulators.\n\n");
			}
			//(2 dicks no balls) 
			else {
				output("Two of them lash forward, ");
				if (pc.cockVolume(0) > cockVolume(60)) output("laboriously stretching around");
				else if (pc.cockVolume(0) >= cockVolume(20)) output("engulfing");
				else output("easily swallowing");
				output(" your [pc.cocks] in tight vises of pleasure.  The remaining tentacle slides underneath, seeking ");
				if (pc.hasVagina()) {
					output("out your " + pc.clitDescript() + " and sucking it inside.");
					//(If big clit – 
					if (pc.clitLength >= 4) output("  You nearly cum on the spot from the clitoral stimulation; it's like you have a super-sensitive cock being licked by a thousand tongues.");
				}
				else output("to rub itself along your taint, massaging the sensitive skin with its slimy lubricants.");
				output("\n\n");
			}
		}
		//(3 dicks) 
		if (pc.cockTotal() >= 3) {
			output("All three of them lash forward, ");
			if (pc.cockVolume(0) > cockVolume(60)) output("laboriously working to swallow");
			else if (pc.cockVolume(0) >= cockVolume(20)) output("engulfing");
			else output("easily swallowing");
			output(" your [pc.cocks] in tight vises of pleasure.  The sensation is overwhelmingly pleasurable, like having three cocks being licked and sucked by a thousand tongues.");
			//(if extra: 
			if (pc.cockTotal() > 3) output("  The remaining [pc.cocksLight] pulse and throb with jealous desire, until one of the tentacles slips off and captures it.  They take turns, slipping off and capturing each of your offerings until you wish they'd just keep sucking forever.");
			output("\n\n");
		}
	}
	//(0 dicks but clit)
	if (pc.totalCocks() == 0 && pc.hasVagina()) {
		output("One of Jojo's tail-tentacles slides underneath his body, shooting forwards to seek out your " + pc.clitDescript() + ".  It pauses an inch or two away and opens up a horrific orifice full of wriggling tentacles and slick fluids.  The next moment it lunges forwards and sucks it inside.");
		//(If big clit – 
		if (pc.clitLength >= 4) output("  You nearly cum on the spot from the clitoral stimulation; it's like you have a super-sensitive cock being licked by a thousand tongues.");
		else output("  The sensation was unreal, and you find yourself wishing your clit was bigger so you could feel even more of the tendrils pleasure-hole.");
		output("\n\n");
	}
	//GET BUTT/VAGOO PENETRATED
	output("The ");
	if (pc.hasVagina()) output("pair of tentacles ");
	else output("tentacle ");
	output("hanging over your bottom decide");
	if (!pc.hasVagina()) output("s");
	output(" that now is a good time to penetrate your undefended opening");
	if (pc.hasVagina()) output("s");
	output(", and press against you, ");
	//Virgin taking
	if (pc.hasVirginVagina() || pc.analVirgin) {
		output("barely slipping inside your virginal opening");
		if (pc.hasVirginVagina() && pc.analVirgin) output("s");
	}
	//not virgin taking
	else {
		//With cunt
		if (pc.hasVagina()) {
			if (pc.vaginas[0].looseness() >= 5) output(" practically falling into your oversized cum-receptacles");
			else {
				if (pc.vaginas[0].wetness() >= 3) output(" sliding inside easily thanks to your copious lubrication");
				else output("forcing their way inside your " + pc.vaginaDescript(0) + " and " + pc.assholeDescript());
			}
		}
		//Just butt
		else {
			if (pc.ass.looseness() >= 4) output(" practically falling into your oversized cum-receptacle");
			else {
				if (pc.ass.wetness() >= 3) output(" sliding inside easily thanks to your copious lubrication");
				else output("forcing its way inside your " + pc.assholeDescript());
			}
		}
	}
	//ON WITH THE PENETRATION
	output(".  Your " + (pc.hasMuzzle() ? "muzzle" : "mouth") + " opens with a wordless cry of surprise ");
	if (pc.hasVagina()) output("and pleasure ");
	output("as Jojo's tentacle");
	if (pc.hasVagina()) output("s begin");
	else output(" begins");
	output(" thoroughly violating you, pistoning in and out relentlessly.");
	if (pc.hasCock()) {
		output("  You feel a strange pleasure every time it plunges deep into your ass, smacking into your prostate.  ");
		if (pc.cockTotal() == 1) output("  The tentacle on your [pc.cocks] seems appreciative, and begins sucking to swallow down all your pre.");
		if (pc.cockTotal() > 1) output("  The tentacles on your [pc.cocks] seem appreciative, and begin sucking to swallow down all your pre.");
	}
	if (pc.hasVagina()) output("  Your " + pc.vaginaDescript(0) + " spasms around the invader, clenching uncontrollably as it's plowed by the thick vine-prick.");
	output("\n\n");
	output("You feel the bindings around your waist sliding and twisting to free up some of their length.  The pair of tentacle-cocks rear up before your " + pc.allBreastsDescript() + " like hungry snakes eyeing a mouse.\n\n");
	//(Large tits &/or multitits with no lactation)
	if ((pc.biggestTitSize() >= 4) && !pc.isLactating()) {
		titFucking = true;
		output("The twin tentacles erupt like kinked up garden-hoses that have suddenly become free, splattering your chest with thick white goop.  They spurt until all of your " + pc.breastDescript(0) + " are painted white with warm dripping goop.  One of the purple-headed monsters slides into the mess, while the other ties itself around your " + pc.breastDescript(0) + ", squeezing its brother tightly between the walls of cum-slickened titflesh.  The swollen purple head bumps your chin, smearing you with its cum as it begins to fuck your tits.  Glob after glob of mouse-cum spatters up from your chest into your chin and mouth, eventually soaking your [pc.face] and neck.\n\n");
	}
	//(Lactating highly)
	if (pc.isLactating() && pc.milkQ() >= 1000) {
		nippleSucking = true;
		output("The heads split apart, dividing into quarters as they reveal wet openings with pink, tongue-like appendages.  [pc.Milk] begins to leak from your [pc.nipples] as their intent becomes clear, and you inwardly scold yourself for ");
		if (pc.cor() < 80) output("being such a wanton slut");
		else output("giving it up too easily");
		output(".  Jojo's dick-mouths latch on and suck hard, pulling your " + pc.nippleDescript(0) + "s deep into their internal reservoir and stimulating your breasts to release a torrent of [pc.milkNoun].  ");
		if (pc.cowScore() >= 5) output("You find yourself mooing in contentment as your fuck-slave works to milk you.  ");
		output("You watch with a happy smile, enjoying the sensations as the tentacles bulge and move milk-distended knots down their lengths towards Jojo.  They are so full that the sloshing whiteness actually becomes visible through the 'skin' of his tendrils.");
		if (pc.breastRows.length > 1) {
			//(NewPG if multirow)
			output("\n\nThere is nothing to do but enjoy the sensations until your " + pc.breastDescript(0) + " are emptied, but before that can happen, they detach, soaking your chest with excess milk, and move down to the next row.  It becomes clear they will keep milking you, moving from row to row to give each a chance to recover, so that they can feed indefinitely...");
		}
		output("\n\n");
	}
	//(NEITHER - JUST NIPS) 
	else if (pc.biggestTitSize() < 4 && rand(2) == 0) {
		nippleSucking = true;
		output("The heads split apart, dividing into quarters and revealing a wet pink opening with a writhing tongue in the center.  They latch on and suck hard, each pulling your entire " + pc.nippleDescript(0) + " into their interior.  Gasping at the sensations, you can only moan as the tentacular tongue twists itself around your nipple.  ");
		if (pc.isLactating()) output("A squirt of [pc.milk] escapes and is quickly sucked down by the hungry tentacles.  ");
		output("The sucking and teasing is relentless, keeping your nipples hard and incredibly sensative as Jojo has his way with you.\n\n");
	}
	//mouthfuck – if shoulder-tentacles are unoccupied – random
	else if (pc.biggestTitSize() < 4 && pc.milkQ() < 1000) {
		mouthFucking = true;
		output("You feel the bindings around your waist sliding and twisting to free up some of their length.  The pair of tentacle-cocks rear up in front of your face, dripping cum from their tainted purple heads.  One curls around the other, twirling around it until the two tentacles look more like some obscene double-headed dildo.  They smear against your lips, coating them with spunk and begging to be let inside.  Pushing harder and harder, they eventally work your jaw open and cram themselves inside.  An immediate jet of cum paints the back of your throat, nearly gagging you for a moment.  The sensation passes quickly, as if your gag reflex was somehow numbed.\n\n");
		output("Twinned dicks force themselves further into your throat, until you are sure they must be outlined and clearly visible to Jojo on your neck.  The mouse-dicks push further in, working their way down to the bottom of your esophagus before pulling back, dripping cum all the while.  Every now and then you get a feeling of fullness in your belly, and realize one of them must have shot off a load of spunk directly into you.  The brutal mouthfuck shows no sign of slowing down, forcing you to gasp in a breath through your nose every time the tentacles pull back.\n\n");
	}
	//Cumsplosion
	output("Jojo unleashes a howl of bestial pleasure, and you feel the ");
	if (pc.hasVagina()) {
		output("tentacles in your " + pc.vaginaDescript(0) + " and " + pc.assholeDescript() + " thicken perceptibly.  Bulges of cum work their way down the tentacles, spreading your " + pc.vaginaDescript(0) + " and " + pc.assholeDescript() + " wide before stuffing you full of mouse cream.  You can feel your bowels and uterus filling, expanding you until you look ");
		if (!pc.isPregnant()) output("mildly pregnant");
		else output("even more pregnant");
		output(".  Your body spasms around them, locked in the throes of orgasm");
		if (pc.isSquirter()) output(", and soaks him with a wave of puss juice.  ");
		else if (pc.wetness() >= 2) output(", as your drooling cunt forms a slick puddle.  ");
		else output(".  ");
		//(If big clit being sucked – 
		if (pc.cockTotal() <= 2 && pc.balls == 0) {
			output("The tentacle locked around your " + pc.clitDescript() + " bulges out a bit as your clit throbs from the orgasm, before it sucks harder, making your clitty even larger.  You squeal from the raw sensation until the tentacle pops off, satisfied, leaving your clit looking like an angry red cock.  ");
			pc.clitLength += .25;
		}
		output("Both tentacles pull out, still dripping whiteness that puddles in your holes.");
	}
	else {
		output("tentacle in your " + pc.assholeDescript() + " thickens perceptibly.  Bulges of cum work their way down the main tentacle, spreading your " + pc.assholeDescript() + " wide before stuffing you full of mouse cream.  You can feel your bowels filling, expanding you until you look mildly pregnant.  Your body spasms around them, locked in the throes of orgasm.  The tentacle pulls out, still dripping whiteness that puddles in your well-used hole.");
	}
	//Dick milkings ahoy!
	if (pc.cockTotal() > 0) {
		if (pc.cockTotal() == 1) {
			output("The tentacle working over your [pc.cock] clamps down and wriggles deliciously around you.  You can't help but cum from the assault, feeding the tentacle your hot spoogy load.  It drinks it down eagerly");
			if (pc.cumQ() >= 100) {
				output(", but after a few moments it begins to struggle with the sheer output.");
				if (pc.cumQ() >= 300) {
					output("  When you finally finish, it's bloated and dripping your [pc.cum] all over your crotch.");
					if (pc.cumQ() >= 600) {
						output("  You pump the tentacle so full it turns half-transparent and bloats obscenely, before suddenly releasing a backflow that soaks you in spunk from the waist down. It drops to the ground limp and spent");
						if (pc.cumQ() >= 800) output(" but you don't stop cumming until it lies in a deep puddle of jizz");
						output(".");
						cumPuddle = true;
						applyCumSoaked(pc);
					}
				}
			}
			else output(".");
		}
		if (pc.cockTotal() > 1) {
			output("The tentacles working over your [pc.multiCocks] clamp down and wriggle deliciously around you.  You can't help but cum from the assault, feeding the tentacles your hot spoogy load.  They drink it down eagerly");
			if (pc.cumQ() >= 100) {
				output(", but after a few moments they begin to struggle with the sheer output.");
				if (pc.cumQ() >= 300) {
					output("  When you finally finish, they're bloated and dripping your [pc.cum] all over your crotch.");
					if (pc.cumQ() >= 600) {
						output("  You pump the tentacles so full they turn half-transparent and bloat obscenely, before suddenly releasing a backflow that soaks you in spunk from the waist down. They drop to the ground limp and spent");
						if (pc.cumQ() >= 800) output(" but you don't stop cumming until they lie in a deep puddle of jizz");
						output(".");
						cumPuddle = true;
						applyCumSoaked(pc);
					}
				}
			}
			else output(".");
		}
	}
	//Breastgasm
	if (pc.milkQ() >= 1000 && nippleSucking) {
		output("Your " + pc.breastDescript(0) + " squirt milk even harder, pushing the tentacles clear off you with the force of your lactation.  Your " + pc.nippleDescript(0) + "s look like ");
		if (pc.nippleLength(0) >= 2) output("even larger");
		else output("obscene");
		output(" cow-teats from all the suction, fountaining [pc.milk] everywhere as it puddles on the ground.  The [pc.milkNoun] flow tapers off after a few seconds, leaving you stretched and sore.");
		if (pc.nippleLength(0) < 4 && pc.breastRows[0].breastRating() >= 1) {
			output("  Somehow you know they won't shrink the whole way back down to normal.");
			pc.nippleLengthRatio += .25;
		}
		else output("  Somehow you know they won't get any bigger from his rough treatment.");
		output("  Your " + pc.allBreastsDescript() + " finally feel emptied; it's a relief.\n\n");
		milkPuddle = true;
	}
	//Titfucking breastgasm
	if (titFucking) {
		output("The titfucking tentacles squeeze tighter against your " + pc.allBreastsDescript() + " before they cum again, much harder than before.  Each time it pops free of your flesh, a wave of spunk flows out with it, rolling off your chest to drip into your already soaked face and mouth.  ");
		if (pc.cor() >= 80 && pc.libido() >= 70) output("You lick your lips and swallow as much of it as possible, wallowing in the mouse-cream.  ");
		if (pc.hairLength > 0) output("He keeps unloading it until you feel it in your " + pc.hairDescript());
		else output("He keeps unloading it until you feel it on your head");
		output(", then both tentacles abruptly release, going flaccid.\n\n");
	}
	if (mouthFucking) {
		output("A wide bulge forces your jaw apart, distends your throat, and finally empties into your gut, filling you with warmth.  The action repeats until you feel bloated and full, far worse than before as you're now filled from BOTH ends.  You look more like ");
		if (!pc.isPregnant()) output("an eight month pregnant woman");
		else output("a brood-mother immobilized by her growing offspring");
		output(" than your old self at this point, and Jojo wastes no time in pulling out to paint your [pc.face] with his baby batter.\n\n");
		cumPuddle = true;
		pc.cor(0.5);
		pc.loadInMouth(jojo);
	}
	output("All of Jojo's tentacles seem to lose their strength, and he gently sets your violated body down ");
	if (cumPuddle) {
		applyCumSoaked(pc);
		if (milkPuddle) output("in the puddle of [pc.cumNoun] and [pc.milkNoun]");
		else output("in the puddle of [pc.cumNoun]");
	}
	else {
		if (milkPuddle) output("in the puddle of [pc.milkNoun]");
		else output("on the ground");
	}
	applyCumSoaked(pc);
	output(".  You moan in frustration, feeling the fluid soak into your skin, secretly wishing he could've fucked you into unconsciousness.  ");
	output("The mouse kneels over you and begins licking your body, cleaning you with his tongue.  The tentacles join in, noisily slurping up every ounce of fluid from your form until you're clean and sated.  Sighing dreamily from the attention, you close your eyes and murmer, \"<i>Good boy.</i>\" When you open them, he's trotting away towards the forest, his tentacles well-hidden again...\n\n");
	pc.buttChange(cockVolume(40), true);
	pc.loadInAss(jojo);
	if(pc.hasVagina()) {
		for (var i:int = 0; i < pc.vaginas.length; i++) {
			pc.cuntChange(i, cockVolume(40), true);
			pc.loadInCunt(jojo, i);
		}
	}
	processTime(45 + rand(25));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.cor(0.5);
	addNextButton();
}

//Jojo milk payments
private function jojoMilkPay(tentacle:Boolean = false):void {
	showJojo();
	flags["COC.JOJO_COCK_MILKING_COOLDOWN"] = timeAsStamp + 4 * 60;
	output("A loud 'ding' chimes and a panel displays ");

	//Set temp to liter amount produced.
	var payout:Number = 0;
	var cap:Number = 500;
	var cumQ:Number = 0;
	//Ez mode cap doubles
	//if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) cap *= 2;
	//if (debug) 
	//{
		//flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] = 0;
		//cap = 9999;
	//}
	//Get rid of extra digits
	cumQ = jojo.cumQ();
	if (tentacle) cumQ += 40000 + rand(1000);
	
	//10% randomization
	cumQ -= rand(cumQ / 10);
	cumQ = Math.round(cumQ);
	
	output(cumQ / 1000 + " Ls.  ");
		
	//Calculate payout
	if (cumQ > 100) {
		payout = 2 + int(cumQ / 200) * 2;
	}
	//Reduce payout if it would push past
	if (int(flags["COC.WHITNEY_GEMS_PAID_THIS_WEEK"]) + payout >= cap) {
		payout = cap - int(flags["COC.WHITNEY_GEMS_PAID_THIS_WEEK"]);
		output("It also shows a warning: <b>Not enough gems for full payment.  GEMS NOW EXHAUSTED.</b>  ");
	}
	//If over cap!
	else if (int(flags["COC.WHITNEY_GEMS_PAID_THIS_WEEK"]) >= cap) {
		payout = 0;
		output("It also shows a warning: <b>FUNDS EXHAUSTED.</b>  ");
	}
	if (payout > 0) {
		pc.credits += payout * 10;
		flags["COC.WHITNEY_GEMS_PAID_THIS_WEEK"] = int(flags["COC.WHITNEY_GEMS_PAID_THIS_WEEK"]) + payout;
		flags["COC.JOJO_TIMES_MILKED"] = int(flags["COC.JOJO_TIMES_MILKED"]) + 1;
		if (payout == 1) output(num2Text(payout, true) + " gem rolls out into a collection plate.  Whitney really put a lot of work into this!  You pocket the gem and g");
		else output(num2Text(payout, true) + " gems roll out into a collection plate.  Whitney really put a lot of work into this!  You pocket the gems and g");
	}
	else output("You g");
}

//Jojo - First Time Milking (edited)
private function milkJojoFirst():void {
	showJojo();
	var x:Number = pc.cockThatFits(cockVolume(40));
	clearOutput();
	output("A wicked idea comes to mind, and you call for your favorite mousey ");
	if (tentacleJojo()) output("tentacle");
	else output("boy");
	output("-toy.  He runs up as quickly as he can with his swollen, cum-dripping genitalia. With how big his balls are, it's a wonder he can run anywhere at all.  Jojo's eyes are fogged and lidded, his tongue is hanging out, and he's slowly stroking his swollen meat, moaning with each pump.  You take him by the clean hand and instruct him, \"<i>No cumming just yet, my toy; I'm going to give you a special treat today.</i>\"\n\n");
	
	output("The white-furred mouse mewls in disappointment, but he obeys reluctantly, slowing his constant stroking down to more measured caresses.  Without any further instruction, you start walking towards Whitney's farm, the corrupted vermin trailing behind you like a lost puppy.  The constant, lurid panting is the only clue you have that he's obeying you, though at this point you're confident you've fucked every single ounce of disobedience out of your plaything.  Maybe there's a puddle of it somewhere in the forest, helping to seed a corrupted glade.  No matter, you're almost there.\n\n");
	
	output("Looming over the next hill, you can see the large, well-maintained roof of Whitney's farm.  She does a fantastic job of keeping everything running considering it seems to be primarily a one-woman show.  Whatever the case, it doesn't look like she's near the barn right now.  It's the perfect time to introduce two of your favorite toys to one another!  Tugging on Jojo's ear, you start dragging him down the hillside towards the empty barn.  He doesn't fight at all, moaning and dripping behind you as if he knows what's coming.  Perhaps he learned a little about 'milking' from somewhere before you broke him?\n\n");
	
	output("Sliding easily, the barn door barely creaks as you push it open and send Jojo inside.  You glance around furtively, making sure you weren't seen, and then you close the door behind you.  Jojo has slumped down into some straw and started masturbating again, yanking on his corruption-bloated cock as if it's the only thing in the room that matters.  Slapping his balls to get his attention, you lead him towards your stall.  It's empty and clean as always");
	if (flags["COC.WHITNEY_FARM_COCK_MILKED"] > 0) output(", even though it reeks of the spunk you've spilled into the milker's mechanical embrace");
	output(".  Jojo shrugs and whines at you, pleading to be allowed to touch himself again.\n\n");
	
	output("You smirk and push him inside, tangling him up in the dangling milk-harness.  The surprised mouse struggles and looks back at you with a mix of confusion and lust warring in his pliant, submissive eyes.  Placing a reassuring fingertip on his nose, you make calming, shushing noises at him as you strap him in properly.  Thankfully the harness is quite adjustable, and you're able to give the corrupt fuck-beast a proper fitting before you milk him.  Each time you cinch one of the bands tight, you make sure to give his balls or his a cock a gentle squeeze.  The extra attention keeps Jojo calm as he is increasingly immobilized.  Only one fitting remains to be tightened, and knowing all too well what will happen, you give it a tug.\n\n");
	
	output("As soon as the white slut-mouse is secured, the machinery kicks in.  It starts with the harness whirring and rising, lifting Jojo up high enough that his arms and legs can't scrabble for purchase.  He's going to be completely immobilized the entire time, and there's nothing he can do about it.  Meanwhile, a hatch on the far wall pops open, revealing a tangled nest of wires.  A single hose with a slimy, pulsating texture on its interior worms out of the machinery, slithering across the floor like a snake.  ");
	if (pc.hasCock()) output("It starts to turn your way before it stops and rises, seeming to sniff at the rodent directly above.");
	else output("It slowly starts to rise, seeming to sniff at the rodent above as it orients itself.");
	output("  Rising upward and undulating through the air, it closes with Jojo's twitching, dripping erection a second later.\n\n");
	
	output("The purplish-pink interior writhes and jiggles when a droplet of Jojo's pre-cum lands in the hose's moist insides.  It truly does seem to be alive.  Perhaps in reaction to your mouse's leaky, drooling shaft, the milker's hose seems to dilate wider and lurch upward.  It slurps up Jojo's prick in an instant, the only evidence of its rapid dick-devouring being the loud wet 'slurrrp' that still echoes throughout the barn.  The slut boy immediately groans from the onslaught of sucking sensation, trying to pump his hips into the pulsating cock-tube.  Of course, it's a futile effort - the harness holds him quite firmly in place, keeping him nice and immobile while every drop of precious 'milk' is sucked from his body.\n\n");
	
	output("Bouncing up, down, back, and forth, the milker twitches with every change of pressure and beat of Jojo's furiously pounding heart.  He whines pitifully, the sound a mix of begging and intense, erotic pleasure.  You gently caress his twitching sack, letting the heavy orbs roll back and forth between your fingers.  They even bounce from time to time, drawn tight every time the machine edges him closer to orgasm.  What an absolute marvel of demon technology.  It's able to take a body to the very brink of release and then back off.  It keeps the victim on edge as long as possible in order to maximize the user's (or victim's?) eventual 'output'.\n\n");
	
	if (pc.hasCock()) {
		//(Cock - too big!)	
		if (x < 0) {
			x = pc.biggestCockIndex();
			if (flags["COC.WHITNEY_FARM_COCK_MILKED"] > 0) output("You know from experience that machine usually takes an hour before it will allow release");
			else output("You figure the machine will probably pump him for quite a while before it allows release");
			output(", and you're getting quite turned on from the show.  You shuck your [pc.gear] and pull out [pc.oneCock], feeling ");
			if (pc.lust() < 50) output("it stiffen in your hand");
			else output("it's rigidity with your hand");
			output(".  For his part, Jojo doesn't even notice.  He just moans, squirms, and twitches any time he's brought particularly close to orgasm.  You sigh, wishing you were small enough to fit inside him, but there's more than one way to fuck a mouse.  Resting your heavy male endowment between his asscheeks, you twirl his tail around your member and turn it into an impromptu cock-ring.  Jojo cranes his head back to see what's going on.  His blush seems to deepen three shades at the sight.  Giving him a wink, you start rocking back and forth.  His ass serves as the perfect hotdog 'bun' while the tightness of his tail keeps your " + pc.cockDescript(x) + " so hard it feels like it could burst.\n\n");
		}
		//(Cock - butt rape!)
		else {
			if (flags["COC.WHITNEY_FARM_COCK_MILKED"] > 0) output("You know from experience that machine usually takes an hour before it will allow release");
			else output("You figure the machine will probably pump him for quite a while before it allows release");
			output(", and you're getting quite turned on from the show.  You shuck your [pc.gear] and pull out [pc.oneCock], feeling ");
			if (pc.lust() < 50) output("it stiffen in your hand");
			else output("it's rigidity with your hand");
			output(".  For his part, Jojo doesn't even notice.  He just moans, squirms, and twitches any time he's brought particularly close to orgasm.  You smile and push forward, sheathing yourself inside Jojo's spasming asshole.  His happily convulsing muscles clamp tight around you, seizing your " + pc.cockDescript(x) + " in his hot innards.  Swatting his plump, furry cheeks, you start to fuck him, noting that the machine all but stops its rhythmic motions.  It seems pounding Jojo's prostate into mush is as effective at milking his dick as the unholy semen-seeking machinery.\n\n");
		}
		pc.orgasm();
	}
	//(Vagoozle!)
	else if (pc.hasVagina()) {
		if (flags["COC.WHITNEY_FARM_COCK_MILKED"] > 0) output("You know from experience that machine usually takes an hour before it will allow release");
		else output("You figure the machine will probably pump him for quite a while before it allows release");
		output(", and you're getting quite turned on from the show.  You shuck your [pc.gear] and reveal your " + pc.vaginaDescript() + ", feeling your " + pc.clitDescript() + " grow firm and hard.  For his part, Jojo doesn't even notice.  He just moans, squirms, and twitches any time he's brought particularly close to orgasm.  Seating yourself down below him, you let your fingers play across your now-wet folds, caressing your labia before you slide a few digits inside.  You brush your thumb against your clitoral hood and shudder from pleasure, enjoying watching your pet get milked as much as he's enjoying the milking.  ");
		if (pc.clitLength > 3) output("Your other hand grabs your penis-sized 'button' and begins to jack it, the action sending tremors of sensation through your " + pc.hipDescript() + ".  ");
		output("Feeling naughty, you sit up straight and lick at Jojo's twitching balls, observing his shame as he squirms on your nose.\n\n");
		pc.orgasm();
	}
	//(NEITHER!)
	else {
		if (flags["COC.WHITNEY_FARM_COCK_MILKED"] > 0) output("You know from experience that machine usually takes an hour before it will allow release");
		else output("You figure the machine will probably pump him for quite a while before it allows release");
		output(", and while you're getting quite turned on from the show, you lack the equipment to take care of your lusts in a satisfactory way.  Meanwhile, Jojo is just moaning, squirming, and twitching each time he's brought close to orgasm.  You sit down and watch the machinery take your mouse-toy to task, wishing you had similar endowments you could be taking care of right now.");
		applyDamage(new TypeCollection( { tease : 50 } ), jojo, pc);
		output("\n\n");
	}
	
	output("At long last, the appointed time has come, and Jojo lets out the most lewd-sounding squeak you've ever heard come from his mouth.  His ass-cheeks and legs clench and flex against their restraints");
	if (pc.hasCock()) output(", squeezing your " + pc.cockDescript(x) + " with agonizingly pleasurable pressure");
	output(".  His back arches in ecstasy.  Most noticeably, the tube slurping on his cock is suddenly distorting as thick, round globules of mousey seed are sucked towards the wall.  The bulges are quickly smoothed out into one long, hose-dilating river of rodent-spooge.");
	if (!pc.hasCock() && pc.hasVagina()) output("  His balls tremble and shrink in your mouth, pumping his prodigious semen out, wasting it in exchange for a pittance of gems.");
	output("\n\n");
	
	if (pc.hasCock()) {
		//(Too big dick: 
		if (pc.cockThatFits(cockVolume(40)) < 0) output("You release your cum all over Jojo's back, matting his white fur with cum.  Each successive splatter of spunk makes the mouse look even more like a semen-drenched whore.  It's a good look for him.");
		else output("You pull out and release your cum all over Jojo's back, matting his white fur with cum.  Each successive splatter of spunk makes the mouse look even more like a semen-drenched whore.  It's a good look for him.");
	}
	else if (pc.hasVagina()) output("You climax and clamp down on your fingers, squeezing your hand as your own cries of pleasure mix with your cock-toy's milked-out moans.");
	else output("You sigh wistfully as Jojo ejaculates his load, wishing you could feel such exquisite sensations.  Maybe you can find something to give you some proper sexual organs soon?");
	output("  Though he cums for minutes on end, the machinery doesn't seem to have much problem keeping up.  Eventually the hose pops off and drags back towards the wall, leaking a small trail of mouse-spunk on the floor.\n\n");
	
	output("Jojo is lowered to the ground and released.  He immediately nuzzles against you, still trembling from the force of his orgasm and clearly thankful for the treat.  ");
	
	//(COPY PASTA REGULAR MILKER STUFF: A loud 'ding' chimes and a panel displays 0.864 Ls.  Ten gems roll out into a collection plate.  Whitney really put a lot of work into this!  You pocket the gems and g
	jojoMilkPay();
	
	output("o on your way, dragging an exhausted mouse behind you as you head back towards camp.");
	processTime(40 + rand(15));
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function repeatMilkJojo(tentacle:Boolean = false):void {
	showJojo();
	clearOutput();
	//Jojo Repeat Milking - Non Tentacle (edited)
	if (!tentacle || !tentacleJojo()) {
		output("You call for your corruption-filled mouse-pet, and Jojo immediately bounds out of the woods on all fours, his bloated dick practically dragging the ground as it dribbles behind him. He looks up at you with eyes full of hope, still remembering the pleasure of his last trip to the farm.  You sigh and say, \"<i>Yes, I'm going to take you for another milking.  Are your balls nice and full?  I expect you to earn me a few gems, my little cum-cow.</i>\"\n\n");
		
		output("Jojo nods his head eagerly and sits up on his haunches, his hand darting down to fondle his dick for you and show you just how much it dribbles now.  He seems to be more than ready for another session.  You start leading him to the farm, listening to him moan and pant behind you.  Drops of pre-cum splatter into the ground with every movement, and you realize he seems to be leaking a little more heavily than the last time the two of you embarked on this journey.  Somehow either the milkers or what you did originally must be slowly increasing his 'productivity' the more he empties out.  Perfect!\n\n");
		
		output("In no time, the two of you are back inside the barn.  Jojo practically leaps into the stall, helping you strap him into the harness in record time.  His dick ");
		
		if (jojo.cumQ() < 1000) output("has already dripped everywhere, making a mess of the floor.");
		else if (jojo.cumQ() < 4000) output("is drizzling a steady flow of man-slime, puddling on the floor.");
		else output("is already pouring out a river of pre-cum, turning the floor into a slippery morass.");
		output("  The mouse is quickly immobilized and left to hang there, waiting on you to finish strapping him into his place.  You tune out his frantic whines and admire your handiwork.  Jojo is utterly restrained and hanging in the air.  His dick is throbbing and dripping in anticipation.  Even his balls are twitching and shuddering, aching to release their heavy cream.  You give his weighty orbs a squeeze and pull the last strap into place, activating the machinery.\n\n");
		
		output("Your white-furred slut is hauled up into the air, kept up high enough that he can't get any kind of traction.  He can barely move at all!  Well, most of him can barely move - the way his dick is bobbing around makes it clear that no matter how you tie him down, Jojo will find a way to squirm like a bitch.  Once again, the wall pops open and releases a thick tube.  Just looking at the pulsating purple opening, you can tell it will be a near-perfect fit for your fuckpet's throbbing erection.  The faint sounds of suction mix with wet squishes as the hose rises up, homing in on Jojo's bouncing shaft.\n\n");
		
		output("Lunging forward, the tube's opening slips around your mouse's cock-head, slurping it up as the sound of mechanized suction whines higher.  Jojo's own voice rises as well, matching the machine pitch for pitch as he moans in bliss.  Lurid slurps fill the barn as the tube greedily devours the mouse's boner, eventually coming to rest snugly against his groin and bouncing, squirming gonads.  Now that his member has been completely encapsulated by the machinery, Jojo sighs blissfully.  His hips are rocking gently against the restraints, as if it would somehow increase the pleasure coursing through his penis.  You know better - he gets to hang there on the edge for most of the next hour.\n\n");
		
		output("Giving your furry slut's clenching ass a smack, you walk around in front of him, nearly tripping over the bouncing tube as you change position.  Jojo's panting with his eyes nearly rolled back into his head.  Every fifteen seconds or so his body will clench, only to have the cock-sucker's motions slow torturously.  He squeals and squeaks each time as if it was the first time.  You scratch him behind his large, dish-shaped ears as words bubble up from within you.  \"<i>Good pet.  You love being milked.  Your balls get so full and heavy... so full of spunk.  They ache, don't they?  Yes... they hurt you so bad.  You get so much cum pent up in there, and you can't let it out, not without being sucked like this.  Shhh... shhh... it's okay.  Just enjoy how perfectly swollen your balls are getting.  You can let it out eventually.</i>\"\n\n");
		
		output("Jojo's eyes roll the whole way back for a moment, and his mouth begins to froth as he utterly caves in to his animal, pleasure-seeking instincts.  You lean back against a smooth part of the wall and shed your clothes, beginning to masturbate directly in front of your stall.  In time, your own pleasured moans draw your pet from his pleasure-induced stupor, and he watches with wide, bloodshot eyes as you bring yourself off to climax after climax");
		if (!pc.hasCock() && !pc.hasVagina()) output(", even though to do so you're forced to stimulate your " + pc.assholeDescript(), false);
		output(".  His twitching rodent-nose sniffs at the air wildly as he pants, inhaling your scent between long, forlorn sounding moans.\n\n");
		
		output("Jojo's muscles seize, and you can tell his orgasm has arrived.  You smirk and lean closer, tugging an ear close to your mouth for another dose of 'encouragement'.  \"<i>Cum for me, pet.  Let all that spunk clogging up your balls boil out into the milker.  Give it all up for me.  Just let out every... thick... pent-up... liter of your seed.  Empty it all!  Cum and squirt until your balls are as empty as your virtue!</i>\"\n\n");
		
		//(\"<i>Normal</i>\" Jojo cum) 
		if (jojo.cumQ() < 1000) {
			output("Your poor semen-slave does not disappoint.  His balls, looking far more swollen than when you arrived, tremble beneath him in time with his bouncing cock, convulsing as they begin to obey your commands.  Big spheres of cum suddenly distend the hose, stretching it with their liquid weight as they're pumped away toward the wall.  Jojo happily squeaks with each fresh burst he releases, though he rapidly devolves into just constantly screeching and moaning as his dick begins to continually twitch, unloading the rest of his spermy cargo in one thick deluge.  He hangs over the slightly dilated, whirring hose as it slurps down all of his cum.  Eventually, the mouse is totally drained, and his body goes limp in the harness.\n\n");
			output("The hose slides off Jojo's softening member and heads back to the wall, trailing mouse-slime as it goes.  At the same time, Jojo is lowered down to the floor.  He stands up on wobbling feet and stumbles down to kneel beneath you.  Looking up, he pants, \"<i>Did I cum enough?</i>\"\n\n");
			output("You pat his head and answer, \"<i>Yes, for now.  I expect your swollen balls can do better next time though, can't they?</i>\"\n\n");
		}
		//(\"<i>Big</i>\" Jojo Cum)
		else if (jojo.cumQ() < 4000) {
			output("Your poor, pent-up semen-slave does not disappoint.  His swollen balls look like heavy grapefruits, only with a much different juice inside them.  Trembling to obey your commands, the hefty spheres bounce and shake, starting to pump out their syrupy rodent-sludge into Whitney's retrofitted demonic machinery.  Just below his swollen tip, the hose massively distends with cum in one climactic moment, accompanied by a squeal of pleasure from your slut.  You can hear the device's humming jump an octave from the heavy load it's being forced to accept, but it seems to manage well enough.  The blob slowly flattens out as it's siphoned down the spunk-devouring tube, just in time for another fat sphere to bloat the hose.  Jojo's eyes roll back, showing you just the whites, and he simply sits and shakes, depositing an inhuman amount of jizm into the milker's ravenous tubing.  After a time, the drained mouse goes limp, his dick still releasing a little more cream even after he goes unconscious.\n\n");
			
			output("Finished, the hose slides off Jojo's hard, cum-drooling cock and retracts towards the wall, leaving a messy trail of mouse-spunk in its wake.  At the same time, Jojo is lowered down to the floor.  He finds his bearings, waking up to stumble over to kneel before you.  Looking up, he pants, \"<i>Was... was that enough?</i>\"\n\n");
			
			output("You pet him affectionately and answer, \"<i>Not too bad, pet.  I still think those balls of yours can do more.  Maybe someday you'll put out so much that the machine can't take it.  Only then will you be cumming enough for me.</i>\"\n\n");
		}
		//(\"<i>Victory</i>\" Jojo Cum)
		else {
			output("Your poor, pent-up semen-slave does not disappoint.  His swollen balls are huge and heavy, swaying back and forth as they shudder and shake with the massive amount of jism they've built up.  Suddenly, they convulse in sync, absolutely flooding the milker's tube with a torrential spurt of mouse-cum.  Globules of jizz leak out around the seal at Jojo's crotch, drizzling down his stretched sack to drip to the floor in gooey strands.  The hose doubles in size, more reminiscent of a rubber balloon than a mechanical device.  Jojo is simply cumming far too hard and too fast for the machinery to handle.  Meanwhile, the noise of the milker's motor jumps up three octaves, becoming an earsplitting whine.  With the seal around your slave's cock failing, the tube is starting to slide off.  He really did it this time!  You rush underneath Jojo and grab hold of the tube with both hands, ramming it back up his shaft in time for his next gigantic pulse of cum to wash through the tube.  Some of it sprays out around the seal, but you hang on for dear life as your mouse's amazing orgasm floods into the receptacles.  He quickly slumps in his hardness, but you keep the milker in place until every drop has been siphoned from his body.\n\n");
			
			output("Finally finished, you release the tube and let it slither towards its home in the wall.  It burps out a wave of cum that stains the floor as it goes.  Meanwhile, Jojo's dick is still rock-hard and dumping his alabaster slime.  Once lowered to the ground, he rouses from his state and drops to his knees, right in the middle of his spunk-puddle.  With heavy-lidded eyes, he asks, \"<i>Did I cum enough?</i>\"\n\n");
			
			output("You pet him affectionately and reply, \"<i>Yes you did.  You're such a good cum-slave.</i>\"\n\n");
		}
			
		jojoMilkPay();
	
		output("o on your way, dragging an exhausted mouse behind you as you head back towards camp.");
	}
	//TENTACLE JOJO MILKING (edited)
	else {
		output("You call for your mutated mouse, and Jojo immediately lumbers out of the woods on all fours, his bloated tentacle-cock dragging on the ground and painting a trail of spooge behind it.  He looks up at you with eyes full of hope, two indistinct bulges on his shoulders twitching in excitement as he remembers the last time you took him to the farm.  You sigh and ask, \"<i>I suppose you're thinking that I'll be giving your tentacles a nice, firm milking, huh slut?  Well it looks like you lucked out today, but you had better cum hard enough with those three cocks to impress me.</i>\"\n\n");
		
		output("Jojo nods his head, his shoulder-tentacles starting to engorge and lift out of his fur, already aching for another session.  You slap one of them, causing them to retract, and start leading him towards the farm.  The whole time he's dripping splatters of pre-cum everywhere, letting his swollen penis drag through the grass and leave a slimy trail in his wake.  What a mess.  You idly wonder if his time in the milkers has increased his virility, but as much cum as he leaks at any given time, it'd be hard to tell without an objective measurement.  Lucky for you, you're about to get one.\n\n");
		
		output("In no time, the two of you have slipped back inside Whitney's barn.  Jojo rushes to the stall, snuggling himself into the harness in no time.  His dick unspools from his crotch, hanging down to the floor while his two shoulder tentacles enlarge, slowly lowering themselves down alongside it.  All three start drizzling pre-cum as you work to buckle him the rest of the way into his harness.  Though he's immobile, he does not sit idly by while you secure his restraints.  Each of the three prehensile penises turns towards you and wraps around your " + pc.legs() + ", sliding along your body in a show of perverse affection.  Even his heavy balls are shaking in anticipation.  You give them a gentle caress as the last part of his harness is secured.\n\n");
		
		output("With a sudden lurch, Jojo is lifted towards the ceiling in order to immobilize him for his milking.  Obviously the designers of such machinery did not count on their victims' having lengthy tentacle-cocks.  As soon as the wall panel opens to release the hoses, Jojo's vine-like pricks go into a frenzy, tangling around each other as they await their chance to get milked.  Three hoses snake from the wall, sliding across the floor with odd undulations.  The tentacle-mouse in the harness doesn't seem inclined to wait, and in a blur of movement, he swiftly plugs each of his three penises into an appropriate orifice.  The purple, flesh-like interiors easily accommodate the sudden penetration, at least initially.  Jojo's penises keep pushing, and you're treated to a view of the tubes distending as they're forced to swallow several feet of mouse-cock.\n\n");
		
		output("Smiling, you begin stroking on one of the tentacles where it emerges from his shoulders, encouraging him to stuff yet more penile tissue inside the milker's sucking embrace.  Of course he's already trying, but the added stimulation can't hurt.  You've truly made this mouse into the perfect fuck-toy.  If only there was a way to suck the pussy-juice from his trio of tail-tentacles, it would be perfect!  Between Jojo's forceful thrusting and the milker's incessant advances, the mouse's three shafts are soon girded in flexible, flesh-lined tubing.  They flail around on the slick floor, motivated by the pulsating bursts of suction and your pet's frenzied spasms.\n\n");
		
		output("You carefully pace around the edge of the stall, moving carefully to avoid tripping up on the wildly-waving hoses.  Once you get in front of him, you grab the mutant rodent's ear and begin to whisper instructions to him.  \"<i>You need to flood this machine, pet.  Feel all that jizz, feel it building up inside you, backing up inside your swollen, cum-heavy nuts.  You're just filling up with spunk, aren't you?  Good.  Stay there and enjoy the cock-massages while you watch me masturbate.  I expect you to be messy enough to need a mop when we're done, understand?</i>\"  There's a dark undercurrent to your words, similar to the one you used when initially corrupting the mouse.  It destroys any doubts you had about his output - he'll be every bit as messy as you instructed him to be.\n\n");
		
		output("Leaning back, you let your fingers casually attend to your own growing needs.  Seeing Jojo's extraordinary form succumbing to its lusts has stirred up some arousal within your own ");
		if (pc.hasGenitals()) output("loins");
		else output("body");
		output(".  You close your eyes and forget about the mouse, stripping out of your clothes to expose your nudity to questing hands.  As you work yourself into a sexual frenzy, you become more aware of Jojo's lusty, panting gaze on your exposed skin.  ");
		if (pc.exhibitionism() >= 66) output("An exhibitionist thrill shivers through you at the thought of being watched while engaged in such a carnal act.  ");
		output("Your climax comes as fast as it is hard, breaking over you in a concussive wave of bliss.\n\n");
		
		output("Blinking the stars from your eyes, you look up to see Jojo hanging there, panting and shaking.  The ever-present mechanical hum incrementally increases in pitch, climbing all the way to a keening wail that would put a banshee to shame.  Swollen bulges of cum are coursing through the tentacle-slut's members, distending the shafts and the tubes struggling to encapsulate the newfound girth.  Jojo's eyes roll back while frothy spit drips from his open maw and dangling tongue.  His body strains at the harness' bindings, the huge, dangling orbs between his legs visibly contracting as their cargo is released.  Semen bubbles from the seals at the edges of hoses as your pet drowns the cock-milker in spooge.  Gauges on the wall rapidly switch to 'F', one after another.  The last meter tops out, and then the pressure is blasting the suckers off his dicks, sending the sperm-packed machinery flying from the sheer, cummy pressure.\n\n");
		
		output("Jojo sags down in the harness while his members finish releasing their load.  The leftovers from his orgasm easily fill the stall with at least a foot of cum.  You sigh at the realization that both you and your clothes are utterly drenched.  The harness unceremoniously dumps Jojo into the puddle of his own making, and as he rises, he hugs your " + pc.legs() + " and says, \"<i>Thank you.  Did... did I cum enough?  I'll do more next time, I promise!</i>\"\n\n");
		
		output("You scratch his jizz-slicked fur and let him know that he did great.  ");
		jojoMilkPay(true);
	
		output("o on your way, dragging an exhausted mouse behind you as you head back towards camp.");
	}
	processTime(40 + rand(15));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}
//Use Jojo to pay for Hair Care 
private function jojoPaysForPerms():void {
	showJojo();
	clearOutput();
	output("Lynnette the goblin answers the door and lets you in, waving you deeper into her shop.  Her shining black dress barely contains her fertile-hips and jiggling chest as she greets you, \"<i>Welcome back honey!  Who's the cutie?</i>\"\n\n");
	
	output("You answer that your pet mouse, Jojo will be taking care of payment for you today.  Lynnette looks doubtful, but she quickly drops to her knees in front of the mouse, determined to get her payment one way or another.  Jojo's forearm-length erection immediately makes itself apparent.  The goblin matron coos at the sight, humming happily once she sees the rivulets of pre-cum streaming down your slut's cock.  In one smooth motion, she devours the heavy mouse-shaft, sliding her lips down all the way to the base.\n\n");
	output("Jojo moans and reaches for Lynnette's hair, but you stop him with a sharp command.  He's paying for your services today, not getting a reward.  Big, lusty eyes look up at him from his loins, and he shudders, his heavy balls clenching and relaxing from the goblin's perfect throat-fuck.  She reaches up to caress them, ");
	if (jojo.cumQ() >= 4000) 
		output("and releases a surprised gurgle when she feels just how heavy and full they've gotten.  All that time at the milker has clearly done Jojo's body good, and Lynette is likely to leave with a mouse-milk mustache.");
	else if (jojo.cumQ() >= 1000) 
		output("and releases a surprised gurgle when she discovers their size.  Clearly all the trips to the milker have given Jojo an impressive set of testes.");
	else output("and rolls them back and forth in her fingers, expertly pleasuring Jojo.");
	output("  In no time flat he's reached the edge of his endurance.\n\n");
	
	output("Lynnette, for her part, has two wet stains on her blouse, but she ignores them as she gives the mouse's nuts a gentle squeeze.  He cums easily and hard from that little bit of extra stimulation.  The goblin's throat works to devour it all");
	if (jojo.cumQ() < 1000) 
		output(", readily swallowing most of it.  After a short time, she pulls back and lets him finish by filling her mouth.  In turn, she spits the sticky mess into a funnel that leads to who-knows-where.");
	else if (jojo.cumQ() < 4000) 
		output(", swallowing as much as she can.  Still, Jojo is pumping out enough that Lynette's belly quickly grows even more gravid, and the semen froths at the edges of her lips.  Eventually she just gives up and pulls off, aiming him at a funnel.  She keeps stroking his spit-slicked shaft as he's drained off that way, the goblin's grin growing a touch manic at the sight of that much seed being collected.");
	else 
		output(", but there's no way she can keep up with Jojo's ridiculous cum-production.  Two jets of seed leave her belly stretched to its limit, and the goblin matron quickly pulls back with a panicked look in her eyes, barely aiming Jojo's spunk-sprayer at the funnel in time for it to be filled by the next blast.  Watching with rapt attention, the green-skinned girl smiles wider and wider when she realizes just how much your pet can produce.  It's quite some time before his flow tapers off, but Lynnette doesn't seem to mind at all.");
	output("  Perhaps one of her daughters has the other end of that pipe jammed into her pussy?\n\n");
	output("Lynnete pants");
	if (jojo.cumQ() >= 1000 && jojo.cumQ() < 4000) 
		output(" with a smile");
	else if (jojo.cumQ() >= 4000) 
		output(" with a dazed, crazy-looking smile");
	output(", \"<i>What'll it be today?</i>\"\n\n");
	processTime(20 + rand(10));
	salonPurchaseMenu();
}

//Scene 1: Amily Teaches Jojo How To Give Blowjobs. (Z)
private function amilyTeachingJojoBJ():void {
	clearOutput();
	//First time version
	if (int(flags["COC.TIMES_AMILY_AND_JOJO_PLAYED_TIMES"]) == 0) {
		output("Your pet mice make an appearance as you're plotting your next move, Amily practically dragging Jojo behind her, ignoring the thick ropes of spunk he drizzles on the ground in his path.  He pants and whines, \"<i>-don't wanna suck cocks!  Fucking is totally better.</i>\"");
		output("\n\nAmily turns about and boxes his rebellious little muzzle.  \"<i>You need schooling in how to properly please our [pc.master].  Do you honestly think [he] will be satisfied with just plowing your ass or riding your thick... drooling... cock...</i>\" Amily's question trails off as she reaches down to caress Jojo's ever-present, cum-slicked boner.");
	}
	//Repeat
	else {
		output("It seems Amily and Jojo are together again, this time in the center of the camp.  Amily is holding Jojo's swollen balls in one hand as she graphically explains how a proper slave should swallow every drop of cum in order to please his [pc.master].  Jojo is panting, his tongue lolling from his mouth as he absently agrees with Amily's particularly pleasurable demonstration, too focused on her fingers to pay attention to her words.");
		output("\n\nThe corrupted girl's demon-like tail swishes angrily, and she squeezes his throbbing sac as she chides, \"<i>Are you even listening, cum-for-brains?!</i>\"  A thick rope of pre-spunk squirts from Jojo's cum-slit, splashing against her chin and sending a bone-deep shudder down her spine and into her over-sexed loins.");
	}
	IncrementFlag("COC.TIMES_AMILY_AND_JOJO_PLAYED_TIMES");
	//Universal Outro
	output("  She seems visibly distracted by the mouse's boner, and will likely wind up fucking him soon.");
	if (pc.hasCock()) output(" Do you surprise them both by allowing Amily to demonstrate on you?");
	else output(" Do you want to watch them fuck?");
	
	processTime(5+rand(2));
	clearMenu();
	if (pc.hasCock()) addButton(0, "Demonstrate", BJRidesGETYOUONE);
	else addDisabledButton(0, "Demonstrate", "Demonstrate", "This option requires you to have cock.");
	addButton(1, "Watch", amilyAndJojoFuck);
	addButton(14, "Leave", mainGameMenu);
}

//Scene 1 Result: Male Gets BJ (Z)
private function BJRidesGETYOUONE():void {
	amilySprite();
	clearOutput();
	output("You step into view and knowingly ask just what all the fuss is about.  Amily meekly prostrates herself before you, apologizing, \"<i>I'm sorry, [pc.master], I merely wanted to help your boyslut learn to satisfy your needs better.</i>\"  You wait, just long enough to make her nervous.  The pregnant pause hangs in the air as both your murine whores look increasingly worried, their large, radar-like ears twitching fitfully about as they await your response.  Laughing, you undo your [pc.gear] and ask Amily how she planned to teach without a proper 'teaching tool'.");
	output("\n\nThe succubus-tainted mouse looks up at you with lust pooling in her large, languid eyes.  \"<i>As you command, [pc.master],</i>\" she whispers eagerly as she rises her feet, her spaded tail curling behind Jojo's neck, dragging him closer to you.  Flopping free, [pc.oneCock] dangles enticingly in the air before them, swaying back and forth to a rhythm that seems almost hypnotic to your poor, corrupted sluts.  They zero in on your [pc.cock " + pc.biggestCockIndex() + "] as if it were the only thing in the world.  Even Jojo's reluctant attitude evaporates when faced with the irresistable allure of your swinging manhood.  He sits at your [pc.feet] as eagerly as his teacher, his expression an ecstatic portrait of mesmeric cock-worship.");
	output("\n\nTaking your [pc.cock " + pc.biggestCockIndex() + "] in hand, Amily begins to caress it in adoring reverence before beginning her lecture.  \"<i>It's important to make sure you've gotten your [pc.master]'s attention before really getting into it, particularly if [he] isn't fully hard yet.  As you can see, [pc.name] is already pleased by my devotion to [his] cock.  Of course, the direct approach can often work just as w-</i>\"  Amily cuts herself off by jamming ");
	if (pc.biggestCockVolume() > cockVolume(50)) 
		output("as much of your [pc.cock " + pc.biggestCockIndex() + "] as possible");
	else 
		output("your entire [pc.cock " + pc.biggestCockIndex() + "]");
	output(" into her mouth and throat.  The tight warmth of your pet's puffy, corruption-engorged cock-sucker shoots tingling thrills of delight through your maleness, and as she's careful to guide the sensitive underside along her tongue as she swallows, [pc.eachCock] soon stiffens to a full, throbbing erection.  You cannot help but groan at the skillful sucking, and when Amily pops off a moment later, she looks quite pleased with herself.");
	output("\n\n\"<i>Our [pc.master] very much enjoys the wet suction of a skilled mouth and gratifying [him] is a decadent pleasure in and of itself.  Just taking [him] inside my lips makes me so wet!</i>\" Amily cries as she resumes stroking you.  Jojo glances away from the handjob long enough to see the streamers of girl-honey hanging from Amily's nethers, and he moans lustily.  Amily barely notices, too intent on pleasuring your [pc.cock " + pc.biggestCockIndex() + "] to worry about Jojo's inattentiveness.  She jacks your spit-soaked tool with neat, even strokes all the way from [pc.sheath] to [pc.cockHead " + pc.biggestCockIndex() + "].  Sighing, you edge your [pc.hips] forwards to give her better access to and encouragement from your excited loins.");
	output("\n\nSensing your need, Amily begins to pump faster as she continues her instruction, \"<i>You have to pay attention to your [pc.master]'s body when you do this.  See the little twitches, how [his] [pc.hips] and shaft are bouncing for [his] little slut?  That means I'm being a good cum-slut.  I made [his] cock happy.</i>\"  Jojo nods and licks at his lips, watching in rapt study as Amily enthusiastically tends to your throbbing tool.  \"<i>You can't slow down here,</i>\" Amily continues, before spitting on her other hand and raising it to fondle your long member.  Your glossed prick slides easily through Amily's pink palms, filling the air with a wet squishing that brings drool to the lips of your mice.");
	output("\n\nJojo leans closer and closer to his female counterpart while the other works, nuzzling so close that they're soon cheek to cheek, ears flat against each other.  The feminine cum-junkie graciously points your [pc.cock " + pc.biggestCockIndex() + "] towards the former monk, and he nervously licks at your [pc.cockHead " + pc.biggestCockIndex() + "], each lap faster and more eager than the one before.  Soon he is slurping the entire tip into his maw and letting Amily squeeze the pre-cum onto his wiggling tongue.  Jojo's eyes cross to better watch the pumping passion under his nose, while your other cum-slut eggs him on with lewd, encouraging remarks. \"<i>You're a natural cock-sucker, Jojo.  The demons were right about us... we're meant to serve the powerful.</i>\"  She sighs and whispers, \"<i>...our [pc.master].</i>\"");
	output("\n\nYou groan at the dual sensations assaulting your [pc.cock " + pc.biggestCockIndex() + "].  Four eyes look up, happily twinkling as they service you, their eager devotion nearly drawing your orgasm right there, the temptation to gush your jetting spunk into their whorish little ");
	if (flags["COC.AMILY_NOT_FURRY"] == 1) 
		output("mouths ");
	else 
		output("muzzles ");
	output("almost too great to resist.  Amily seems to sense this, obediently offering their bodies for your release. \"<i>[pc.Master], would you like to fill your cum-slut's pussy or mouth?  Or maybe you want to give your bitch-boy a taste?</i>\"");
	//[Cum in Amily Mouth] [Cum in Amily Pussy] [Cum in Jojo Mouth]
	output("\n\nWhere do you cum?");
	processTime(14 + rand(6));
	//Pussy requires a minimum tallness?
	clearMenu();
	addButton(0, "Amily's Mouth", fillAmilysMouth);
	if (pc.tallness > 55) addButton(1, "Amily's Pussy", stuffAmilysMouthWithPostBJCUM);
	else addDisabledButton(1, "Amily's Pussy", "Amily's Pussy", "This option requires you to be at least 4' 7\" tall.");
	addButton(2, "Jojo's Mouth", fillJojosMouthWithHotStickyCum);
}

//Fill Amily's Mouth (Z)
private function fillAmilysMouth():void {
	amilySprite();
	clearOutput();
	output("You tell Amily to open wide, and she gleefully yanks your [pc.cock " + pc.biggestCockIndex() + "] away from Jojo.  He whines pathetically but, servile as he is, the mouse-boy");
	if (pc.balls > 0) output(" leans down to desperately suckle at your [pc.sack], subserviently worshipping your bloated testes and their liquid bliss one after another; tonguing, sucking, and moaning into the spunk - bloated mass of your ambrosial scrotum.");
	else output(" leans down to slurp needily at the bottom of your cock, licking it with languid tongue-strokes each time Amily gives him an opening.");
	output(" Amily looks up at you, her cute, succubi - like horns glinting in the light as she purrs, \"<i>Please, [pc.master], give slut a throat-thick load to swallow.  Fill your nympho's mouth-pussy with sticky baby batter and splatter her whorish face with oozing leftovers.</i>\"");
	output("\n\nThe mousette's chemically-engorged lips spread into an 'o', then happily devour most of your dick's straining length, leaving room at the base for her hands and Jojo's tongue to work.  She pumps you hard and fast, and you feel the telltale twitching of your internal muscles, signaling the crest of your onrushing orgasm.  Your [pc.hips] jerk spasmodically as the pleasure overwhelms your control, but Amily holds on like a pro.  She slides her hot, wet little tongue along your member's underside again as your urethra fills with goo, and in one explosive moment, you propel the thick rope of seed hard into the hungry addict's throat.  You see her jaw work breathlessly as she swallows [if (cumQuantity >= 250) most of|all of] it.  You cum and cum for her, packing her worthless throat with your gushing cream, unloading even as she does her best to wring you dry (with Jojo's help).");
	if (pc.cumQ() >= 500) output("  Before long, her belly is nicely rounded from all the seed she's swallowed, a happy little bump visible on her lithe frame.");
	if (pc.cumQ() >= 1000) output("  Too full to keep drinking, she releases your [pc.cock " + pc.biggestCockIndex() + "] with a zestful gasp and gladly takes the next spurt directly on her face and hair.  The huge blob of [pc.cum] soaks her ardent features, cataracts of jism cascading lazily towards the ground.");
	if (pc.cumQ() >= 3000) output("  You keep blasting her with ever-greater volumes of spooge until she's stained completely white with gobs of spunk and lounging euphorically in a deep puddle of it.");
	output("\n\nThe sperm-filled girl burps and turns to kiss Jojo, the once-pure monk eagerly returning the embrace and getting a good taste for your seed as Amily fervently tongues it into his mouth.  She eventually pulls back to encourage him with an overwrought sigh. \"<i>Maybe if you service [pc.master] better you'll be allowed to receive [pc.hisHer] seed next time.</i>\"  Jojo pants and licks at his lips, hands darting down to tend to his long-neglected phallus.");
	output("\n\nYour personal whore laughs and hugs your [pc.leg], whispering, \"<i>Cum-slut thanks you, [pc.master].</i>\"  You pull her up and smile at her, glad she's working to make your budding harem as sexually adept as possible.  She beams and grabs Jojo with her tail, no doubt eager to drag him off for more training.");
	processTime(4 + rand(3));
	pc.orgasm();
	addNextButton();
}

//Fill Amily's Twat (requires not short-ass, weak-ass nigga) (Z)
private function stuffAmilysMouthWithPostBJCUM():void {
	amilySprite();
	clearOutput();
	output("You tell Amily to hurry up and climb on.  With a squeak of joy, she bounds up into your arms, immediately sinking her plush little pussy onto your lap and swallowing your cocktip.  Surprising you with her control, she holds herself like that, restraining herself from taking in your whole [pc.cock " + pc.biggestCockIndex() + "] and instead bouncing up and down atop your peak while Jojo attends to the lower portion of your manhood with his eager tongue.  He tentatively licks along the swell of your shaft, sucking at the sensitive underside and planting desperate kisses over your length, lapping up Amily's freely flowing juices as she rides the crest of your pulsing tip.  The mouse-girl's ears tickle as they brush against you, her voice husky with desperate need.  \"<i>Please, [pc.master], give slut your seed.  Her cunny needs to be filled sooo badly.  Make me your pregnant, baby-bloated whore, [pc.master]!</i>\"");
	output("\n\nAs if you'd resist such an invitation!  You squeeze your demon mouse tightly and push her further down, impaling her juicy snatch ");
	output("on your rigid fuck-tool");
	output(".  She squeaks in surprise, her yelp turning into a high-pitched moan as your [pc.cockHead " + pc.biggestCockIndex() + "] widens in preparation for your looming orgasm.  Spunk forces your cum-slit open and sprays into Amily's clenching uterus, gorging her lascivious cunt with the virile seed it craves.  You hold her, impaled and squirming, as you continue to spray, inseminating her moist twat with squirt after squirt of oozing cock-nectar.[if (cumQuantity > 500)   Her belly rounds out delightfully from the extra stuffing.  You run a palm across it and smile when you feel your sperm churning under her stretched skin.][if (cumQuantity >= 1000) \"  Rivulets of spooge run from her overflowing pussy in thick cascades of pearl goo.  Jojo does his best to keep up, but even his growing lust for swallowing your cum can't match the volume of the salty surf foaming from the spasming girl's flush pussy.\"][if (cumQuantity >= 2000) \"  Amily's eyes roll back in complete pleasure as the pressure of your cum begins to cause the ejaculate to spout from her spunk-laden twat.  Jojo gives up on swallowing it all and leans back, opening wide to catch as much as possible as your second-hand seed showers the fallen monk, an ivory rain of hot slime splattering from your freshly stuffed slut's cream-sated cunny.\"]");
	output("\n\nSatisfied, you pull out and let Amily's insensate body slide off into the dirt.  She shivers and cups her box, trying to hold all the jizz inside her leaky quim as she comes down from the bliss of being your personal cock-sleeve.  Smirking, you work on getting dressed.  By the time you're ready to go, you realize Amily has stirred enough to pull Jojo between her legs.  His muzzle is lodged deep into the cum-slut's pussy, and she's moaning words of encouragement nonstop.  \"<i>Good boy... lick up [pc.master]'s cum.  Savor its taste, its texture.  Don't worry, you'll never get it out of my womb.  Just drink it down, and maybe - if you're a good little bitch - [pc.master] might let you have the next load.</i>\"");
	output("\n\nYou leave them behind with a spring in your step.  With a dedicated slave like that training your harem, you have no doubt that you'll be well taken care of.");
	//dynStats("sen", -1);
	//{DONT FORGET PREGNANCY CHECK}
	amilyPreggoChance();
	processTime(4 + rand(3));
	pc.orgasm();
	addNextButton();
}

//Fill Jojo's Mouth (Z)
private function fillJojosMouthWithHotStickyCum():void {
	showJojo();
	clearOutput();
	output("You point at Jojo and command, \"<i>Open wide.</i>\"  The former monk happily opens his muzzle broadly, so far open that his buck-teeth practically vanish into the roof of his mouth.  Amily looks disappointed, but then she consoles herself by [if ");
	if(pc.balls > 0) output("sinking down to covetously suck your swollen [pc.balls] while ")
	output("tugging on your shaft, squeezing it from stem to stern with hard, fast pumps.  Jojo's tongue slips out to lick the beading pre-cum from your [pc.cock " + pc.biggestCockIndex() + "] as it flexes powerfully in the other slut's grip.  Warmth races through your loins as you feel your orgasm approaching.");
	output("\n\nAn explosion of bliss burns in your head as [pc.eachCock] spews its load.  Thick waves of pent-up jism spray out from your cum-slit, filling Jojo's mouth with [pc.cum], and splatter across his nose and hair.  He gurgles as his mouth fills with your musky spunk and opens wider, keenly trying to catch as much of your seed as possible with his cum-dribbled face before he slurps it down in one sputtering gulp.");
	if (pc.cumQ() < 500) output(" You discharge your [pc.cumColor] lacquer again and again, washing his pale fur until his face seems little more than a glistening mask, dripping with your seething unguent.  Bound to your will, he patiently awaits your permission to swallow, his pacified mouth full to the brim, leaking out the sides in twin [pc.cumColor] cascades. You nod curtly and the tamed mouse-boy obeys happily, savoring the humbling [pc.cumFlavor] of your overpowering jizz as it rolls down his throat.");
	else output("  You spurt again and again, splattering heavy ropes of goo across his face and fur.  His mouth floods, too full of jizz to contain it all, giving the vanquished monk a thick glaze of [pc.cum] that very quickly leaves his body with an oily sheen.");
	if (pc.cumQ() >= 1000) output("  He swallows, taking a blast of spunk across his brow, and opens up again, giving you another hole to aim for.  Another eruption of your virile seed rushes past his lips and coats the back of his throat in your fluid ivory, nearly drowning him as the column of jism gushes into his windpipe and up his nostrils, surging out of his nose.  The domesticated mouse gulps desperately at your slimy passion while your fountaining cum arcs to dump fat globs on his shuddering body.");
	output("  You finish and shove your [pc.cock " + pc.biggestCockIndex() + "] into his throat for cleaning.  Jojo happily obliges.");
	output("\n\nWhile one of your mouse-toys is polishing your rod, the other is masturbating and panting.  \"<i>Please, [pc.master], may I... may I have some cum?  Can I... I lick him clean?  He's so...</i>\"  She inhales and luridly moans, \"<i>...messy.</i>\"  You give her your assent as you withdraw your spit-shined pecker from Jojo's maw, not caring how the two of them get their rocks off so long as your harem is kept well-trained and willing.");
	//dynStats("lib", -1, "cor", 1);
	pc.cor(1);
	processTime(4 + rand(3));
	pc.orgasm();
	addNextButton();
}
	
//Scene 2: Amily And Jojo Fuck (w/o Tentacles) (Z)
private function amilyAndJojoFuck():void {
	showJojo();
	clearOutput();
	output("You find a nearby rock to perch on as the two mice begin to get more lewd with their actions.  Amily uses her tail to sit Jojo down in front of her, squeezing his taut balls in her hand and gasping when he spews a thick stream of pre-cum.  You use the commotion as cover to squeeze out of your [pc.gear] and get comfortable.  Thankfully, neither of them hears you, or if they do, they don't care.  Amily titters, \"<i>Wow, no wonder [pc.master] keeps you around with a cum-fountain like that!</i>\"  She gently traces a fingertip along the swollen underside of Jojo's cock, giggling when he, over-stimulated, immediately starts dripping fluid on her fingers.");
	output("\n\nJojo moans, \"<i>Ugh... stop... please Amily, please, can I cum?</i>\"  Amily jerks and shakes her head in disappointment.  She mouths, \"<i>Not yet,</i>\" and stands back up, turning around and pulling Jojo's muzzle into her slippery twat with her demonic tail.  The former monk's protests are muffled by Amily's sodden quim, and he soon begins to eagerly slurp at her drooling cunny.  With each enthusiastic lick, she reaches between her knees to caress Jojo's corruption-engorged cock, egging him on to please her more thoroughly.");
	output("\n\n\"<i>R-right there,</i>\" Amily moans, \"<i>Lick my clit!  Suck it!  Suck it bitch!</i>\"  Jojo reaches around her to find her tits, and he begins to knead them in his hands while he eats her out, matching his movements to the rhythm of his graceful tongue and the pulsing suction of his mindless lust on her drenched joybuzzer.  She shudders and cries out in euphoric mastery. \"<i>Yes!  Fuck yes!  Good bitch! GOOD BIIITCH!</i>\"  Jojo's muzzle and face darken from a sudden onslaught of moisture, and you realize Amily has just cum so hard her gushing orgasm has soaked his face with her glistening honey.  She tumbles down onto her hands and knees, groaning and shuddering as the spasming climax wracks her body and mind.");
	output("\n\nJojo sees his opening, and with surprising speed, he's up and on top of Amily, mounting her from behind like a beast in rut.  Even as far away as you are, you can hear the wet squelching sound of his massive dick spearing through Amily's sopping folds, even louder than Amily's lascivious exultations of pleasure.  For one with such a small frame, Jojo's movements have surprising confidence and strength.  His white-furred hips start to thrust into Amily with hard, fast motions.  Without the leash of a dominating partner, he's become like a feral animal, fucking her with no regard for her pleasure- only the suffocating, all-consuming need to BREED.  The soft patter of mousey cunt-juice splattering on the ground alerts you to Amily's shared urgency - she's getting off on being mindlessly ridden like a beast, coarsely degraded and carnally ravaged like the worthless cum dump she's willingly become.");
	output("\n\nThe succubus-like mouse's restless demonic tail twitches back and forth between Jojo's legs, then strikes, serpent-like, towards his distended cum-sack.  It twists around the top of his scrotum, pulling it tightly to perfectly outline the shape of his massive gonads through the lightly-furred skin.  Distressed by the new development, yet not slowing from the rapid pace of his bestial pounding, he throws his head back and releases a shrill, feminine squeak of impotent displeasure.");
	output("\n\n\"<i>Don't... unf... be a... unf... baby,</i>\" the demonic woman chides in between each jarring impact against her snatch, \"<i>I don't... uh... want... oooh... you cummMMING... ahhh... too soon.</i>\"");
	output("\n\nOf course, hearing her voice rise and fall in time with his frenzied pounding drives Jojo onward, fueling the mad fires of his perverted lust.  The mouse's hips pump faster, and Amily's entire body begins to tremble from the force of his blows.  His bound nuts sway dangerously, slapping noisily against Amily's sodden mons with each hard smack of his swollen girth.  The girl stops doing much of anything but moaning and shaking from the experience, her voice finally muffled into grunts and squeaks of muted enjoyment as the relentless mouse-boy tames the over-bold female, breaking her to the dominating frenzy of his squelching bitch-tamer.");
	output("\n\nJojo grabs her hair and pulls as he fucks her, growling against her ear.  You can see his balls bobbing and twitching through their bondage.  They're trying so hard to cum, and yet, Amily's vice-tight tail is keeping all that spooge bottled up inside them.  Jojo's sack even appears to be swelling under the pressure of their liquid weight.  In his frenzied desperation, the male mouse begins to nip and bite Amily's ears, bringing her to heel with the feral gesture of dominance.  It seems to pay off, as the corrupted mouse-girl begins to shiver and shake, losing a bit of her muscle control as she orgasms.  Her tail loosens, not completely, but enough for Jojo's visibly-pulsating nut-sack to unleash the tidal-wave of spooge that's been backing up inside and force it open.  You see his eyes clench, and then Amily's belly begins to bulge slightly.  His hips shiver, and the bulge grows.  It goes for what seems like ages - Jojo giving little shifts and sighs of pleasure, Amily's belly becoming more and more pregnant with cum.  It doesn't really sink in just how big she's gotten until you realize her belly has touched the ground.  It trembles and wobbles with fluid girth before the former monk has finally had enough and withdraws to hose her down with the last few thick strands of his seed.");
	output("\n\nJojo stands back and smiles, observing his handwork.  His dick never even goes soft.  If anything, you see his balls swelling back up to their normal size - well, the norm since you changed him.  He starts leaking pre again, and as he runs off towards the woods, you have to wonder if he's off to visit the flower in the corrupted glade.  Amily lies on her side and cradles her cum-stuffed belly, squeaking soft bleats of happiness as she tries to recover.");
	output("\n\nYou stealthily slide down the rock and get dressed.");
	if (pc.hasVagina()) output(" It isn't until you notice how wet your crotch is that you come to the realization that you've masturbated yourself through a few orgasms as well.");
	else output(" It isn't until you notice how clearheaded you are that you come to the relaization that you've masturbated while watching the pair.");
	output(" Maybe you'll get to catch them in the act again?");
	processTime(20 + rand(10));
	pc.orgasm();
	//{DONT FORGET PREGNANCY CHECK}
	amilyPreggoChance();
	addNextButton();
}

public function jojoAtCampRape():void {
	showJojo();
	flags["COC.JOJO_NIGHT_WATCH"] = 0;
	flags["COC.JOJO_IN_CAMP"] = 0;
	clearOutput();
	output("You ask Jojo if he'd like to go on a hunt through the woods to clear out some of the corrupted creatures, and the mouse readily agrees.  He asks if you've been getting a bit stir-crazy from having your camp in one place as the two of you walk into the woods...");
	processTime(10 + rand(10));
	clearMenu();
	addButton(0, "Next", jojoRape, false);
}

public function defeatedJojo():void {
	showJojo();
	if (pc.lust() >= 33 && pc.hasGenitals()) {
		clearOutput();
		output("You smile in satisfaction as Jojo" + (enemy.HP() < 1 ? " collapses, unable to continue fighting" : " collapses and begins masturbating feverishly") + ".  Sadly you realize your own needs have not been met.  Of course, you could always rape the poor thing...\n\nDo you rape him?");
		clearMenu();
		addButton(0, "Yes", postCombatRape);
		addButton(1, "No", function():*{ processTime(10 + rand(10)); CombatManager.genericVictory(); });
	}
	else {
		processTime(10 + rand(10));
		CombatManager.genericVictory();
	}
}

private function postCombatRape():void {
	showJojo();
	output("  You disrobe and prepare to ");
	if (flags["COC.JOJO_STATE"] == 5)
		output("fuck your violent little slut senseless.  ");
	else output("teach the uppity monk a lesson...\n\n");
	clearMenu();
	addButton(0, "Next", jojoRape, true);
}

public function jojoRape(postCombat:Boolean = false):void {
	trace("jojoRape called");
	
	showJojo();
	//Track Jojo rapeage
	IncrementFlag("COC.JOJO_RAPED");
	switch (flags["COC.JOJO_STATE"]) {
		case 1:
			jojosFirstRape();
			break;
		case 2:
			jojosSecondRape();
			break;
		case 3:
			jojosThirdRape();
			break;
		case 4:
			jojosFourthRape();
			break;
		default:
			jojosFifthRape();
	}
	if (inCombat()) {
		processTime(10 + rand(10));
		CombatManager.genericVictory();
	}
	else {
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

private function jojosFirstRape():void {
	clearOutput();
	output("You pretend to agree, and follow Jojo into the woods.  You bide your time, waiting for him to relax.  Eventually the mouse stumbles, and you have your chance!\n\n");
	var x:int = pc.cockThatFits(jojo.analCapacity());
	if (x == -1 && pc.hasCock()) x = 0;
	
	processTime(35 + rand(10));
	
	if (pc.hasCock() && !pc.hasVagina())
	{
		output("You push him hard, following through to pin his small frame.  He struggles but you twist his arm expertly and hold him down with your larger bodyweight.  He squirms as you tear off the bottom of his outfit, protesting mightily as you force him into the dirt and expose his toned bottom.\n\n");
		if (pc.cockTotal() == 1) 
		{
			output("You grin and press your " + pc.cockDescript(x) + " against him, making him squeal in protest.  You press on, eager to violate his puckered asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.");
			pc.cockChange();
			jojo.buttChange(pc.cockVolume(x));
			output("  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your [pc.balls] feel full; a pulsing, squeezing tightness builds in your nethers as your " + pc.cockDescript(x) + " flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of [pc.cumNoun] up his ass, violating him to his core.");
			
			if (pc.milkQ() >= 100 && pc.milkQ() < 500)
			{
				output("  [pc.Milk] squirts from  your [pc.nipples], spraying him down with small droplets of your [pc.cumVisc] tit-treat.");
			}
			else if (pc.milkQ() >= 500 && pc.milkQ() < 1500)
			{
				output("  Streams of [pc.milk] spray from your [pc.nipples] in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");
			}
			else  if (pc.milkQ() >= 1500)
			{
				output("  Gouts of [pc.milk] erupt from your [pc.nipples], spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");
			}
			
			output("\n\nWith a satisfied sigh, you pull your " + pc.cockDescript(x) + " out with an audible 'pop'.  Your [pc.cum] begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard; he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
			pc.orgasm();
			//dynStats("lib", -10, "cor", 4);
			pc.slowStatGain("l", -10);
			pc.cor(4);
			flags["COC.JOJO_STATE"] += 1;
		}
		else 
		{
			output("You grin and press your [pc.multiCocks] against him, making him squeal in protest.  You press on, eager to violate his tight asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.");
			pc.cockChange();
			jojo.buttChange(pc.cockVolume(x));
			output("  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your [pc.balls] feel full, a pulsing squeezing tightness building in your nethers as your " + pc.cockDescript(x) + " flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of [pc.cumNoun] up his ass, violating him to his core.  [pc.Cum] sprays over his ass, the rest of your equipment soaking him as it cums as hard as the one you sank up into the mouse-hole.");
			
			if (pc.milkQ() >= 100 && pc.milkQ() < 500) output("  [pc.Milk] squirts from  your [pc.nipples], spraying him down with small droplets of your [pc.cumVisc] tit-treat.");
			else if (pc.milkQ() >= 500 && pc.milkQ() < 1500) output("  Streams of [pc.milk] spray from your [pc.nipples] in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");
			else  if (pc.milkQ() >= 1500) output("  Gouts of [pc.milk] erupt from your [pc.nipples], spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");
			
			output("\n\nWith a satisfied sigh, you pull your " + pc.cockDescript(x) + " out with an audible 'pop'.  Your cum begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard, he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
			pc.orgasm();
			//dynStats("lib", -10, "cor", 4);
			pc.slowStatGain("l", -10);
			pc.cor(4);
			flags["COC.JOJO_STATE"] += 1;
		}
	}
	else if (!pc.hasCock() && pc.hasVagina()) 
	{
		output("You smack the back of his head hard, dazing him.  You spin him around as you take his feet out from under him, one hand pulling his pants while the other slashes his belt.  He literally 'falls out of his pants' and onto the soft earth of the forest.  You pounce on the stunned monk, shedding your own clothes and pinning him to the ground.  He begins to resist, squirming under you, ");
		
		if (pc.wetness() < 2) 
		{
			output("but the sensation of you grinding your folds against him momemtarily breaks his will.  ");
		}
		else 
		{
			output("but the feeling of your " + pc.vaginaDescript(0) + " grinding against his hardening cock robs him of any will.  ");
		}
		
		output("You smile when you realize how large he is for his frame, and mount him, taking care to keep him pinned hard to the ground.");
		
		pc.cuntChange(0, jojo.cockVolume(), true, true, false);
		
		output("\n\nHe lets out little grunts and whines of protest as you ride him hard, but quickly cums.  The flood of warmth inside your canal only serves to spur you on, slamming your " + pc.vaginaDescript(0) + " down on him with brutal force.  You envision yourself raping others, corrupting all those you come across with your needy pussy.  You imagine what it must be like to be a succubus, fucking poor monks like this, your magics making your victim's manhood ever larger.  The thought breaks over you like a wave and you cum, hard; your " + pc.vaginaDescript(0) + " clamps down hard on Jojo's cock as he finds himself cumming again, eyes rolling back in his head.  You shudder and moan, cum squirting out of your fuck-hole with each bounce on the poor mouse.");
		
		if (pc.milkQ() >= 100 && pc.milkQ() < 500) output("  [pc.Milk] squirts from  your [pc.nipples], spraying him down with small droplets of your [pc.cumVisc] tit-treat.");
		else if (pc.milkQ() >= 500 && pc.milkQ() < 1500) output("  Streams of [pc.milk] spray from your [pc.nipples] in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");
		else  if (pc.milkQ() >= 1500) output("  Gouts of [pc.milk] erupt from your [pc.nipples], spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");
		
		output("\n\nYou stand on wobbly [pc.legs], happy to have so thoroughly fucked such a chaste and good-natured creature.  You vow to do it again soon, realizing you feel more clearheaded, if a bit more evil.");
		
		pc.orgasm();
		//dynStats("lib", -10, "cor", 4);
		pc.slowStatGain("l", -10);
		pc.cor(4);
		flags["COC.JOJO_STATE"] += 1;
		
		//Preggers chance!
		pc.loadInCunt(jojo);
		//pc.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
	}
	else if (pc.isHerm()) 
	{
		trace("gender3");
		
		output("You push him hard, following through to pin his small frame.  He struggles but you twist his arm expertly and hold him down with your larger bodyweight.  He squirms as you tear off the bottom of his outfit, protesting mightily as you force him into the dirt and expose his toned bottom.\n\n");
		if (pc.cockTotal() == 1) 
		{
			output("You grin and press your " + pc.cockDescript(x) + " against him, making him squeal in protest.  You press on, eager to violate his tight asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.");
			pc.cockChange();
			jojo.buttChange(pc.cockVolume(x));
			output("  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your balls feel full, a pulsing squeezing tightness building in your nethers as your " + pc.cockDescript(x) + " flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of [pc.cumNoun] up his ass, violating him to his core.  Your pussy quivers, cumming as well, feeling empty.  You resolve to take his cock's virginity next time.");
			
			if (pc.milkQ() >= 100 && pc.milkQ() < 500) output("  [pc.Milk] squirts from  your [pc.nipples], spraying him down with small droplets of your [pc.cumVisc] tit-treat.");
			else if (pc.milkQ() >= 500 && pc.milkQ() < 1500) output("  Streams of [pc.milk] spray from your [pc.nipples] in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");
			else  if (pc.milkQ() >= 1500) output("  Gouts of [pc.milk] erupt from your [pc.nipples], spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");
			
			output("\n\nWith a satisfied sigh, you pull your " + pc.cockDescript(x) + " out with an audible 'pop'.  Your [pc.cum] begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard, he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
			pc.orgasm();
			//dynStats("lib", -10, "cor", 4);
			pc.slowStatGain("l", -10);
			pc.cor(4);
			flags["COC.JOJO_STATE"] += 1;
		}
		else 
		{
			output("You grin and press your [pc.cocks] against him, making him squeal in protest.  You press on, eager to violate his tight asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.");
			pc.cockChange();
			jojo.buttChange(pc.cockVolume(x));
			output("  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your balls feel full, a pulsing squeezing tightness building in your nethers as your " + pc.cockDescript(0) + " flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of cum up his ass, violating him to his core.  Cum sprays over his ass, the rest of your equipment soaking him as it cums as hard as the one you sank up into the mouse-hole.  Your pussy quivers, cumming as well, feeling empty.  Mentally you resolve to take his cock's virginity next time.");
			
			if (pc.milkQ() >= 100 && pc.milkQ() < 500) output("  [pc.Milk] squirts from  your [pc.nipples], spraying him down with small droplets of your [pc.cumVisc] tit-treat.");
			else if (pc.milkQ() >= 500 && pc.milkQ() < 1500) output("  Streams of [pc.milk] spray from your [pc.nipples] in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");
			else  if (pc.milkQ() >= 1500) output("  Gouts of [pc.milk] erupt from your [pc.nipples], spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");
			
			output("\n\nWith a satisfied sigh, you pull your " + pc.cockDescript(0) + " out with an audible 'pop'.  Your [pc.cum] begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard, he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
			pc.orgasm();
			//dynStats("lib", -10, "cor", 4);
			pc.slowStatGain("l", -10);
			pc.cor(4);
			flags["COC.JOJO_STATE"] += 1;
		}
	}
}

private function jojosSecondRape():void {
	clearOutput();
	output("The poor mouse is already hard... his cock is throbbing eagerly as it protrudes through the opening in his robe, looking nearly eight inches long.  You're pretty sure it wasn't that big last time.\n\n");
	flags["COC.JOJO_STATE"] += 1;
	processTime(20 + rand(5));
	pc.orgasm();
	pc.slowStatGain("l", -10);
	pc.cor(4);
	var x:int = pc.cockThatFits(jojo.analCapacity());
	if (x == -1 && pc.hasCock()) x = 0;
	
	if (pc.hasCock() && !pc.hasVagina()) {
		output("You force Jojo over a log, running your hands through his fur and slapping his ass.  He grunts, but it's impossible to tell if it's in frustration, anger, or arousal.  You quickly force yourself back into his ass, finding it noticably stretched from your last incursion.");
		pc.cockChange();
		jojo.buttChange(pc.cockVolume(x));
		if (pc.cocks[x].thickness() >= 3) output("  It makes little difference to your " + pc.cockDescript(x) + ", he still feels tight as a virgin's cunt to you.");
		output("  You grab him by the waist and fuck him powerfully, slamming your " + pc.cockDescript(x) + " in brutally hard and fast.  You notice his hands are in his crotch, feverishly masturbating his disproportionately large cock like a slut.  You start leaking pre-cum like a sieve, realizing you're doing it, really doing it - making this virtuous mouse into a wanton slut!  You squeeze him tightly as you cum into his bowels, his belly distending slightly as your orgasm goes on and on.  Trails of [pc.cum] run down his fur as it becomes more than his ass can handle.");
		if (pc.cockTotal() > 1) output("  Your remaining equipment showers him with jizz, more than you ever thought you could produce.");
		if (pc.milkQ() >= 100 && pc.milkQ() < 500) output("  [pc.Milk] squirts from  your [pc.nipples], spraying him down with small droplets of your [pc.cumVisc] tit-treat.");
		else if (pc.milkQ() >= 500 && pc.milkQ() < 1500) output("  Streams of [pc.milk] spray from your [pc.nipples] in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");
		else  if (pc.milkQ() >= 1500) output("  Gouts of [pc.milk] erupt from your [pc.nipples], spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");
		output("  The mouse moans and cums himself, with loud moans and messy splurts coating the ground every time your hips meet.\n\n");
		output("Eventually it ends, and you drop him into the puddled spooge like a used condom.  He lays there, idly stroking himself in a daze, his prick still swollen with need and dripping fluids.  You can't wait to corrupt him some more.");
	}
	if (pc.hasVagina()) {
		output("You throw him on the soft soil of the forest and mount him, skillfully guiding his member towards your now dripping wet hole.");
		pc.cuntChange(0, jojo.cockVolume(), true);
		output("  As you slide down you marvel at how he feels larger and thicker than before, deliciously so.  Your " + pc.vaginaDescript(0) + " throbs in the most pleasant way as you rape his small form.  You play with your clit, watching Jojo's face flit between rapture and disgust.  You lick your lips and smile as the disgust vanishes, his hot jets of cum painting your cunt-walls.  You giggle and keep fucking him, hoping that somehow your corruption and lust are influencing him, turning him into your personal fucktoy.  The thought brings you over the edge.  You clamp down, your " + pc.vaginaDescript(0) + " milking, squeezing every last drop from him as his prick erupts inside you.  ");
		
		if (pc.milkQ() >= 100 && pc.milkQ() < 500) output("  [pc.Milk] squirts from  your [pc.nipples], spraying him down with small droplets of your [pc.cumVisc] tit-treat.");
		else if (pc.milkQ() >= 500 && pc.milkQ() < 1500) output("  Streams of [pc.milk] spray from your [pc.nipples] in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");
		else  if (pc.milkQ() >= 1500) output("  Gouts of [pc.milk] erupt from your [pc.nipples], spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");
		
		if (pc.isSquirter()) output("Your " + pc.vaginaDescript(0) + " drenches him with your squirting [pc.girlCum], mixed with his own seed.");
		if (pc.cockTotal() == 1) output("[pc.Cum] sprays onto his chest from your " + pc.cockDescript(0) + ".  ");
		if (pc.cockTotal() == 2) output("A hail of [pc.cum] splatters over Jojo from your [pc.cocks].  ");
		if (pc.cockTotal() == 3) output("A multitude of thick [pc.cumNoun]-streams splatter over Jojo from head to waist as [pc.eachCock] hose him down.  ");
		output("\n\nSatisfied at last, you pull yourself away from the dazed mouse.  His shaft is still swollen with need, his hands irresistibly stroking it, eyes vacant.  You're going to corrupt him so much more next time.\n\n");
		//Preggers chance!
		pc.loadInCunt(jojo);
		//pc.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
	}
}

private function jojosThirdRape():void {
	clearOutput();
	trace("Monk(3) rape");
	output("It's no wonder the monk's body has betrayed him so thoroughly, his " + enemy.cockDescript() + " is nearly ten inches long, pulsing with hot need.\n\n");
	
	processTime(35 + rand(10));
	
	var x:int = pc.cockThatFits(jojo.analCapacity());
	if (x == -1 && pc.hasCock()) x = 0;
	
	if (pc.hasCock() && !pc.hasVagina()) {
		output("You yank Jojo up from the ground and onto his knees, ");
		if (pc.cockTotal() == 1) {
			output("presenting your " + pc.cockDescript(x) + " to him.  ");
		}
		else output("presenting your [pc.multiCocks] to him.  ");
		output("The monk betrays his violated state of mind, licking his lips demurely and opening wide.  The invitation is all you need ");
		if (pc.cockTotal() == 1) output("to ram your " + pc.cockDescript(x) + " deep into his maw.  You roughly grab his ears, facefucking him hard, his tongue working hard to please.  ");
		if (pc.cockTotal() > 1) output("to cram two cocks deep into his maw, making his jaw stretch obscenely.  You roughly grab his ears, facefucking him hard, his tongue working hard to please you.  ");
		output("One of Jojo's paws is buried in his groin, stroking his " + enemy.cockDescript() + " with feverish intensity.  The hornier he gets, the more his throat seems to relax, allowing you to push deeper.  The glazed, lust-addled look on his face is so hot, you can't hold back any longer.  ");
		if (pc.cockTotal() == 1) output("Your " + pc.cockDescript(x) + " clenches tightly, erupting ");
		if (pc.cockTotal() > 1) output("Your twin dicks clench tightly, erupting ");
		output("hot seed into the now meek and subdued bitch-boy.  His throat squeezes around you as he presses his nose tightly against your crotch, pulling as much of you in as he can.");
		if (pc.milkQ() >= 250) output("  Every sensual peak within you is mirrored with small spurts of [pc.milk] from your nipples.");
		output("  Mouse-spunk spatters your [pc.legs] as he cums with you.\n\n");
		pc.orgasm();
		if ((pc.libido() > 60 || pc.lustMin() >= 33) && pc.cor() > 40) {
			output("You flip him onto his back, both of you still hard and ready for more.  He gets up on all fours and wiggles his bum tantalizingly.  You press on, violating his loosened sphincter, and begin to fuck him hard.");
			pc.cockChange();
			jojo.buttChange(pc.cockVolume(x));
			output("  He whimpers with a mixture of pain and pleasure, your spit-lubed [pc.cock " + x + "] pounding his prostate mercilessly.  Thick ropes of mousey-cum drool with each anus-stretching thrust of your cock, pooling below you.  You wickedly smile, slapping his ass, imagining him stretched further, his ass gaping, his cock huge and dripping with cum.  The strange thoughts filling your mind seem to travel straight to your balls and distill into pools of cum.  Like a long dormant volcano, you erupt, hot liquid spraying into Jojo, pumping his ass full and leaking down his legs.  He cums again, harder than before, his pulsing prick seeming to grow larger throughout his orgasm.\n\n");
		}
		output("You leave the exhausted mousey behind you, wondering how you'll take him next time.  ");
		pc.orgasm();
		if ((pc.libido() > 60 || pc.lustMin() >= 33) && pc.cor() > 50) {
			output("You smile as you hear him begin masturbating in the background.  There can be no doubt, you are tainting him more and more...");
			flags["COC.JOJO_STATE"] += 1;
			pc.slowStatGain("l", -10);
			pc.cor(4);
		}
		else
		{
			pc.slowStatGain("l", 2);
			pc.cor(1);
		}
	}
	if (!pc.hasCock() && pc.hasVagina()) {
		if (pc.isBiped()) output("You spread your [pc.legs] and crook your finger");
		else output("You crook your finger");
		output(", beckoning him towards your " + pc.vaginaDescript(0) + ".  He looks disheartened, but obediently kneels before you, his whiskers tickling your " + pc.vaginaDescript(0) + ", his wet nose bumping your clit, his tongue taking long licks between your lips.  ");
		if (pc.biggestTitSize() >= 2) {
			output("You sigh and knead your breasts in pleasure.  ");
			if (pc.milkQ() >= 250) output("Every sensual peak within you is mirrored with small spurts of [pc.milk] from your nipples.  It eventually trickles down to Jojo's tongue, spurring his efforts on.  ");
		}
		output("The mousey gets more and more in to eating your box, making it harder and harder to stave off an orgasm.  You wrap ");
		if (pc.isNaga()) output("your coils ");
		else if (pc.isGoo()) output("your jiggling goo ");
		else output("your thighs ");
		output("around his head and quiver with passion, ");
		if (pc.wetness() <= 1) output("squeezing him tightly into your " + pc.vaginaDescript(0) + ".");
		if (pc.wetness() > 1 && pc.wetness() <= 3) output("creaming his tongue liberally with [pc.girlCum].");
		if (pc.wetness() == 4) output("creaming all over him with your slobbering pussy.");
		if (pc.wetness() == 5) output("splattering him with [pc.girlCum] from your " + pc.vaginaDescript(0) + ".");
		output("\n\nYou pull the cunt-dazed mouse away reluctantly, and bend over,");
		if (pc.isBiped()) output(" spreading your legs and");
		output(" shaking your rump.  ");
		if (pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("Your [pc.tail] swishes back and forth teasingly.  ");
		output("Your tantalizing backside is too much for him.  He pounces your ass in a second, penetrating your " + pc.vaginaDescript(0) + " forcefully.  The knowledge that your demonic influence is responsible for his state nearly makes you cream all over his cock.  You fantasize about your cunt making his cock grow longer and fatter as it corrupts him further, transforming his morals and values into cock and cum.  Jojo thrashes against you, brutally pounding your " + pc.vaginaDescript(0) + " as he orgasms.  His " + enemy.cockDescript() + " erupts inside you, the feeling of being filled with mouse-spunk drives you over the edge with him.  More and more of his cum sprays inside you, unnatural amounts for a creature his size.  Thick streams of the stuff escape down your thighs as your belly distends.  ");
		pc.cuntChange(0, enemy.cockVolume(), true);
		output("\n\n");
		output("You let the drained mouse pop free, reveling in the sensation of cum pouring from");
		if (pc.isBiped()) output(" between your thighs"); 
		else output(" your cunt");
		output(".  Jojo has already passed out behind you.  ");
		pc.orgasm();
		if ((pc.libido() > 60 || pc.lustMin() >= 33) && pc.cor() > 50) {
			output("You lean down and whisper strange un-words as you stroke his cock.  It spasms and grows, cum pumping from it slowly but constantly.  You walk away, leaving him in a growing puddle of what was once his morals.  You don't know where the words came from, but you do know you're getting better at tempting and corrupting.");
			flags["COC.JOJO_STATE"] += 1;
			pc.slowStatGain("l", -10);
			pc.cor(4);
		}
		else
		{
			pc.slowStatGain("l", 2);
			pc.cor(1);
		}
		//Preggers chance!
		//pc.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
		pc.loadInCunt(enemy);
	}
	if (pc.isHerm()) {
		if (pc.isBiped()) output("You spread your [pc.legs] and crook your finger");
		else output("You crook your finger");
		output(", beckoning him towards your " + pc.vaginaDescript(0) + ".  He looks disheartened, but obediently kneels before you, his whiskers tickling, his wet nose bumping your clit, his tongue taking long licks between your lips.  ");
		if (pc.cockTotal() == 1) output("You sigh as your " + pc.cockDescript(x) + " droops over his head.  ");
		if (pc.cockTotal() > 1) output("You sigh as your [pc.cocks] pile atop his head.  ");
		if (pc.biggestTitSize() >= 2) {
			output("You sigh and knead your breasts in pleasure.  ");
			if (pc.milkQ() >= 250) output("Every sensual peak within you is mirrored with small spurts of [pc.milk] from your nipples.  It eventually trickles down to Jojo's tongue, spurring his efforts on.  ");
		}
		output("The mousey gets more and more into eating your box, making it harder and harder to stave off an orgasm.  You wrap your thighs around his head and quiver with passion, ");
		if (pc.wetness() <= 1) output("squeezing him tightly into your " + pc.vaginaDescript(0) + ".");
		if (pc.wetness() > 1 && pc.wetness() <= 3) output("creaming his tongue liberally with [pc.girlCum].");
		if (pc.wetness() == 4) output("creaming all over him with your slobbering pussy.");
		if (pc.wetness() >= 5) output("splattering him with [pc.girlCum] from your " + pc.vaginaDescript(0) + ".");
		if (pc.cockTotal() > 0) output("  Thick runners of your pre dribble down his neck, sticking to his fur.  ");
		output("\n\nYou pull the cunt-dazed mouse away reluctantly, and bend over,");
		if (pc.isBiped()) output(" spreading your legs and");
		output(" shaking your rump.  ");
		if (pc.hasTail() && pc.hasTailFlag(GLOBAL.FLAG_LONG)) output("Your tail swishes back and forth teasingly.  ");
		output("Your tantalizing backside is too much for him.  He pounces your ass in a second, penetrating your " + pc.vaginaDescript(0) + " forcefully.  The knowledge that your demonic influence is responsible for his state nearly makes you cream all over his cock.  You fantasize about your cunt making his cock grow longer and fatter as it corrupts him further, transforming his morals and values into cock and cum.  Jojo thrashes against you, brutally pounding your " + pc.vaginaDescript(0) + " as he orgasms.  His " + enemy.cockDescript() + " erupts inside you, the feeling of being filled with mouse-spunk drives you over the edge with him.  More and more of his cum sprays inside you, unnatural amounts for a creature his size.  Thick streams of the stuff escape down your thighs as your belly distends.  ");
		pc.cuntChange(0, enemy.cockVolume(), true);
		if (pc.cockTotal() == 1) output("Your " + pc.cockDescript(x) + " trembles in orgasm, squirting your load into the thick forest loam.  ");
		if (pc.cockTotal() > 1) output("Your [pc.cocks] tremble in orgasm, squirting their hot loads all over the thick forest loam.  ");
		output("\n\n");
		output("You let the drained mouse pop free, reveling in the sensation of cum pouring from ");
		if (pc.isBiped()) output("between your thighs");
		else output("your cunt");
		output(".  Jojo has already passed out behind you.  ");
		pc.orgasm();
		if ((pc.libido() > 60 || pc.lustMin() >= 33) && pc.cor() > 50) {
			output("You lean down and whisper strange un-words as you stroke his cock.  It spasms and grows, cum pumping from it slowly but constantly.  You walk away, leaving him in a growing puddle of what was once his morals.  You don't know where the words came from, but you do know you're getting better at tempting and corrupting.");
			flags["COC.JOJO_STATE"] += 1;
			pc.slowStatGain("l", -10);
			pc.cor(4);
		}
		else
		{
			pc.slowStatGain("l", 2);
			pc.cor(1);
		}
		//Preggers chance!
		//pc.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
		pc.loadInCunt(enemy);
	}
}

private function jojosFourthRape():void {
	clearOutput();
	output("Jojo flops down, eyes filled with anticipation.  His self-control has really slipped away.  The corrupted and horny mouse on display here is anathema to the studious monk you met before.  His cock is close to a foot long and over two inches thick, veiny with arousal.\n\n");
	
	processTime(35 + rand(10));
	
	var x:int = pc.cockThatFits(jojo.analCapacity());
	if (x == -1 && pc.hasCock()) x = 0;
	
	//Male Version
	if (pc.hasCock() && !pc.hasVagina()) {
		output("The mousy former-monk kneels as you disrobe, his will nearly broken by desire.  ");
		if (pc.cockTotal() == 1) {
			output("You touch his head softly and guide him to your " + pc.cockDescript(x) + ", smiling as he licks his lips with anticipation.  You gasp at the feeling of his soft lips and wet tongue as he pleasures you, your knees going weak from his efforts.  Jojo");
			if(pc.balls > 0) output(" cups your [pc.balls] and");
			output(" slips a fuzzy finger into your [pc.asshole].  He labors to take as much of you as possible into his mouth, panting warmly and wetly around your " + pc.cockDescript(x) + ".  You twitch in pleasure as he alternates pressure on your prostate with smooth strokes of his slick tongue.  ");
		}
		else {
			output("You touch his head softly and guide him to your [pc.cocks], smiling as he licks his lips in anticipation.  You gasp at the feelings of his soft lips and wet tongue on your heads as he pleasures you, your knees going weak from his efforts.  Jojo");
			if(pc.balls > 0) output(" cups your [pc.balls] and");
			output(" slips a fuzzy finger into your [pc.asshole].  He labors to take in two shafts, struggling to swallow them as deep as possible, panting wetly around you.  You twitch with pleasure as he alternates pressure on your prostate with smooth strokes of his slick tongue.  ");
		}
		//Too thick for him
		if (pc.cocks[x].thickness() > 3 || pc.hasKnot(x) && pc.knotThickness(x) > 3) output("Jojo is forced to back off of your " + pc.cockDescript(x) + " from time to time to come up for air, barely opening his jaw wide enough to take your girth back inside his mouth.  ");
		//Too long for him
		if (pc.cocks[x].cLength() > 10) output("He struggles not to gag on your [pc.cockNoun]'s length, opening his throat as far as he can.  ");
		output("You rock back and forth on his face as he expertly keeps you on the edge of orgasm.  ");
		if (pc.cumQ() > 25) output("Your constant stream of heavy pre practically chokes the poor mouse as he edges you mercilessly, his own equipment drizzling in sympathetic lust.  ");
		output("Jojo presses his paw hard into your ass, squeezing your prostate tightly as his hot muzzle dives deeply over your cock.  You feel the building tightness of your orgasm and pull him tightly against you as the pressure builds.  ");
		if (pc.cumQ() < 25) output("You buck against him as you orgasm, your small squirts of [pc.cumNoun] eagerly devoured by the slutty mouse.");
		if (pc.cumQ() >= 25 && pc.cumQ() < 250) output("You buck against him as you orgasm, the slutty mouse's throat squeezing against you as he works to swallow your seed.");
		if (pc.cumQ() >= 250 && pc.cumQ() < 500) output("You spasm against him as you orgasm, the pleasure erupting into the slut-mouse's throat as he tries to swallow it all.  Excess cum dribbles from the corners of his mouth as you fully spend yourself.");
		if (pc.cumQ() >= 500) output("You buck against him as you orgasm, the slutty mouse's cheeks bulging in surprise as your cum explodes into his mouth.  Thick streams escape from the corners of his muzzle, your seed pouring into him faster than he can swallow.  Eventually you finish, and see the mouse dripping with your spunk nearly to the waist, a small bulge in his belly.");
		output("  Jojo leans back, panting for breath, a dull smile on his face.  He spits a load of your [pc.cum] into his paw and begins jerking himself off with it, lewdly putting on a show for you.\n\n");
		if ((pc.libido() > 50 || pc.lustMin() >= 33) && pc.cor() > 80) {
			output("<b>You feel a familiar power growing within you and decide to unleash it.</b>  You grab the prayer beads from his outfit and spit on them, making them slick and wet.  Holding them below your flagging cock, you focus on the demonic visions in your mind, slowly but constantly milking larger and larger dollops of cum onto the once holy beads.  Jojo moans as he comes to understand your intent, and turns around, shaking his lithe mouse-bum at you.  You lean over him, whispering into his ear, \"<i>Each defiled bead I push into you is going to make you more of a willing slut.  More of a willing receptacle for demon cum.  More of a fountain of desire waiting to be tapped by Succubi.  More my toy.</i>\"\n\n");
			output("He whimpers as you slide the first bead in, his eyes growing foggy and his bum wiggling more eagerly.  You push the second bead inside him, and feel his asshole stretch and loosen, welcoming the corruption.  The third bead slips right in, and he moans, \"<i>sluuuut</i>,\" His cock grows longer and thicker throughout the moan, stopping at over a foot long and 3 inches thick, dribbling cum.  You whisper, \"<i>Cum, my Toy,</i>\" and push the remaining beads inside him.  His eyes roll back as his paws frantically milk his " + enemy.cockDescript() + ", cum spraying from him like a fountain.  Jojo trembles, losing complete control and falling away from you.  You still hold the end of his beads, and smile as they pop out, stained almost as dark as the poor mouse's soul.\n\n");
			output("You walk away, leaving your new pet to explore his outlook on life, and to test your awakened powers.  ");
			flags["COC.JOJO_STATE"] += 1;
			pc.orgasm();
			pc.slowStatGain("l", -10);
			pc.cor(4);
		}
		else {
			output("Jojo eventually cums violently, collapsing into a puddle of spent jizz.  You smile and walk away, hoping to encounter him again.  ");
			pc.orgasm();
			pc.slowStatGain("l", 2);
			pc.cor(1);
		}
	}
	//Female or Herm Version
	if (pc.hasVagina()) {
		//Oral
		output("The mousy once-monk kneels as you disrobe, his will nearly broken by desire.  ");
		output("You touch his head softly, guiding him to your " + pc.vaginaDescript(0) + ", lips breaking into a grin as he licks his mouth with desire.  You gasp at the feeling of his wet nose as it bumps against your groin, shooting thunderbolts of pleasure from your " + pc.clitDescript() + ".  He attacks with his tongue, thrusting strikes practically attacking your " + pc.vaginaDescript(0) + " with his long, practically serpentine, tongue.  You shudder, knowing a visible sign of corruption when you see it, moisture slicking the mouse's face.\n\n");
		output("Jojo moans into your folds as his " + enemy.cockDescript());
		if (pc.isBiped()) output(" brushes against your calf");
		else output(" brushes against your [pc.leg]");
		output(".  You get a devilish idea, ");
		if (pc.isGoo()) output("and push his " + enemy.cockDescript() + " in between folds of slime, sandwiching it in a mass of slippery, gooey tightness.  Holding his shoulder for balance, you slowly squeeze him, gently milking out small dribbles of pre.  He redoubles his efforts, burying his nose into your " + pc.vaginaDescript(0) + ", tongue swirling over your folds and around your " + pc.clitDescript() + ".  For every effort on his part you step up your own, squeezing and stroking him with your goo, doing your best to impart a fetish for being masturbated with someone's lower body on his slowly warping mind.  You feel a hot wetness in your slime, and it grows slicker and wetter every second. Jojo's cum drips out of you, glazing your jello-like form white.  ");
		else output("and push his " + enemy.cockDescript() + " with your " + pc.foot() + ", sandwiching it under one " + pc.foot() + " and on top of the other.  Holding his shoulder for balance, you slowly squeeze him, gently milking out small dribbles of pre.  He redoubles his efforts, burying his nose into your " + pc.vaginaDescript(0) + ", tongue swirling over your folds and around your " + pc.clitDescript() + ".  For every effort on his part you step up your own, squeezing and stroking him with your " + pc.feet() + ", doing your best to impart a " + pc.foot() + " fetish on his slowly warping mind.  You feel a hot wetness on your " + pc.feet() + ", and they grow slicker and wetter every second. Jojo's cum drips out from between them, glazing them white.  ");
		
		if (pc.wetness() <= 1) output("You clamp down on his muzzle as you writhe in orgasm.  ");
		if (pc.wetness() > 1 && pc.wetness() <= 3) output("Your [pc.legs] trap his muzzle in your " + pc.vaginaDescript(0) + " as orgasm wracks your body.  ");
		if (pc.wetness() == 4) output("Your [pc.legs] trap his muzzle in your " + pc.vaginaDescript(0) + ", slicking his muzzle with [pc.girlCum] as you spasm with bliss.  ");
		if (pc.wetness() >= 5) output("Your [pc.legs] squeeze him against your " + pc.vaginaDescript(0) + ", [pc.girlCum] erupting over his face and soaking him as you bliss out with orgasm  ");
		
		if (pc.cockTotal() == 1) output("Your " + pc.cockDescript(0) + " drizzles [pc.cum] in his hair, some dripping off by his ear.  ");
		if (pc.cockTotal() > 1) output("Your [pc.cocks] drizzle him with [pc.cum], covering his head with thick [pc.cumColor] streams of your jizz.  ");
		
		output("Twitching weakly with pleasure, you fall back.\n\n");
		//Fux!
		output("The pleasure was magnificent... but you want MORE.  You push yourself up, feeling pleased as you spy Jojo stroking his cum-slick " + enemy.cockDescript() + ", thick streams of cum leaking from the tip.  You pounce on him, pushing him down on the ground, and position your " + pc.vaginaDescript(0) + " over him, allowing him to scent your sex.  With a triumphant smile, you sink down onto him, impaling yourself on his " + enemy.cockDescript() + ".  ");
		if (pc.looseness() == 0) output("He is painfully large, so much so that you feel more pain than pleasure.  ");
		if (pc.looseness() == 1) output("He stretches you around him like a latex glove, pulling your " + pc.vaginaDescript(0) + " taught with his " + enemy.cockDescript() + ", the sensation riding a razor's edge between pleasure and pain.  ");
		if (pc.looseness() == 2) output("His " + enemy.cockDescript() + " stuffs you completely, filling your " + pc.vaginaDescript(0) + " to capacity.  ");
		if (pc.looseness() == 3) output("His " + enemy.cockDescript() + " fits you perfectly, burying deep inside your folds.  ");
		if (pc.looseness() == 4) output("You easily accomadate his member into your " + pc.vaginaDescript(0) + ".  ");
		if (pc.looseness() >= 5) output("His " + enemy.cockDescript() + " slips inside your " + pc.vaginaDescript(0) + " with little resistance, easily sinking in to the hilt.  You muse to yourself, \"<i>If only he were thicker...</i>\"  ");
		output("You ride him slowly, gyrating your hips in tiny grinding circles while you run your hands through his fur.  His hips bounce you gently with tiny twitching thrusts, cum pooling out of your " + pc.vaginaDescript(0) + " as it continues to drip from him.  ");
		output("He gradually ups the tempo, and you are forced to go along for the ride as you begin to bounce on his " + enemy.cockDescript() + ".  You grab fistfuls of his fur and hang on as he begins pounding your " + pc.vaginaDescript(0) + ", his huge balls slapping against you.  Cum squirts from your pussy with each of his violent thrusts, more pouring deep inside you continually.  Jojo squeals with glee and slams his hips into yours a final time, triggering an eruption of seed in your channel.  You feel it pouring into your womb, slowly distending your belly with every shuddering pump of cum.  You orgasm helplessly, fingering your " + pc.clitDescript() + " the whole time.  ");
		
		//Futacawk here
		if (pc.cockTotal() > 0) {
			//Single Cock
			if (pc.cockTotal() == 1) {
				//DogFun!
				if (pc.cocks[x].hasFlag(GLOBAL.FLAG_KNOTTED)) output("Your " + pc.cockDescript(0) + " feels an intense pressure, and begins bulging out obscenely above your [pc.sheath].  The knot thickens gratuitiously, filling as it pulses with need.  Cum drips from your [pc.cockHead] as it continues to bulge wider, filling you with unbearable pressure.  ");
				//Horsefun!
				else if (pc.cocks[x].hasFlag(GLOBAL.FLAG_FLARED)) output("Your " + pc.cockDescript(0) + " feels a building pressure, the whole thing pulsating wildly with each of your heartbeats, most noticably the tip, which flares out wildly.  Powerful contractions wrack your [pc.sheath] and " + pc.cockDescript(0) + " as pre practically fountains from it.  ");
				//Else
				else output("Your " + pc.cockDescript(0) + " twitches, muscle contractions slowly working their way up from the [pc.sheath].  ");
				//CUMSPLOISION
				if (pc.cumQ() < 25) output("Your body tenses and cums, spraying spurts of jizz over the mouse.  ");
				if (pc.cumQ() >= 25 && pc.cumQ() < 250) {
					if (pc.cocks[x].hasFlag(GLOBAL.FLAG_KNOTTED)) output("The terrible pressure in your " + pc.cockDescript(0) + " finally relents, in the form of a fountain of [pc.cumNoun], spraying out from your " + pc.cockDescript(0) + " in a steady stream that seems to last and last.  ");
					else if (pc.cocks[x].hasFlag(GLOBAL.FLAG_FLARED)) output(" Your " + pc.cockDescript(0) + " flares wildly as musky [pc.cumNoun] erupts from it, splattering over Jojo.  ");
					else output("Your body tenses and cums a thick eruption far beyond what a normal human could produce.  Jojo is splattered with the stuff.  ");
				}
				if (pc.cumQ() >= 250) {
					if (pc.cocks[x].hasFlag(GLOBAL.FLAG_KNOTTED)) output("Your " + pc.cockDescript(0) + " suddenly releases the pressure, a constant stream of [pc.cumNoun] spouting from your " + pc.cockDescript(0) + " like some kind of cum-hose.  It seems to go on endlessly, covering the mouse from the waist up with thick ribbons of spooge as your knot slowly shrinks to normal.  ");
					else if (pc.cocks[x].hasFlag(GLOBAL.FLAG_FLARED)) output("Your " + pc.cockDescript(0) + " ripples and bulges with animalistic vigor, [pc.cumNoun] splattering everywhere with each contraction.  The musky jizz never seems to stop pouring from your organ, soaking the mouse from the waist up.  ");
					else output("Your body tenses and cums a thick eruption far beyond what a normal human could produce.  Jojo is splattered with the stuff.  ");
				}
			}
			//Sorry multicocks, I'm donE!
			if (pc.cockTotal() > 1) {
				output("Your cocks feel a building pressure at their base. It only seems to get stronger and stronger, until at last it explodes out from you, [pc.cum] covering the poor mouse from the waist up.  ");
			}
		}
		
		//Milk here
		if (pc.milkQ() >= 100 && pc.biggestTitSize() >= 1) {
			if (pc.milkQ() < 500) output("[pc.Milk] sprays from your " + pc.breastDescript(0) + " in tiny streams, triggered by your orgasms.");
			else if (pc.milkQ() < 1000) output("[pc.Milk] erupts from your " + pc.breastDescript(0) + ", spraying out over the mouse, squirting out the contractions of each shuddering orgasm.");
			else if (pc.milkQ() < 2000) output("[pc.Milk] erupts from your " + pc.breastDescript(0) + ", spraying in pulsing blasts, soaking the mouse.  Each nerve-wracking orgasm seems to wring more and more [pc.milkNoun] from you, until it puddles around.");
			else  output("[pc.Milk] fountains from your " + pc.breastDescript(0) + ", soaking the mouse with a continuous river of cream.  For every blob of cum you feel pushing into your over-filled uterus, another torrent of [pc.milkNoun] sprays out.  As your mind-bending orgasms drag on, a small lake of [pc.milkNoun] forms around you.");
		}
		
		pc.cuntChange(0, enemy.cockVolume(), true);
		//Preggers chance!
		//pc.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
		pc.loadInCunt(enemy);
		//The end
		if ((pc.libido() > 50 || pc.lustMin() >= 33) && pc.cor() > 80) {
			output("\n\n<b>You feel a familiar power growing within you and decide to unleash it.</b>  You grab the prayer beads from his outfit and spit on them, making them slick and wet.  Holding them below his flagging cock, you focus on the demonic visions in your mind, slowly but constantly milking larger and larger dollops of cum onto the once holy beads.  Jojo moans as he comes to understand your intent, and turns around, shaking his lithe mouse-bum at you.  You lean over him, whispering into his ear, \"<i>Each defiled bead I push into you is going to make you more of a willing slut.  More of a willing receptacle for demon cum.  More of a fountain of desire waiting to be tapped by Succubi.  More my toy.</i>\"\n\n");
			output("He whimpers as you slide the first bead in, his eyes growing foggy and his bum wiggling more eagerly.  You push the second bead inside him, and feel his asshole stretch and loosen, welcoming the corruption.  The third bead slips right in, and he moans, \"<i>sluuuut</i>,\" His cock grows longer and thicker throughout the moan, stopping at over a foot long and 3 inches thick, dribbling cum.  You whisper, \"<i>Cum, my Toy,</i>\" and push the remaining beads inside him.  His eyes roll back as his paws frantically milk his " + enemy.cockDescript() + ", cum spraying from him like a fountain.  Jojo trembles, losing complete control and falling away from you.  You still hold the end of his beads, and smile as they pop out, stained almost as dark as the poor mouse's soul.\n\n");
			output("You walk away, leaving your new pet to explore his outlook on life, and to test your awakened powers.  ");
			flags["COC.JOJO_STATE"] += 1;
			pc.orgasm();
			pc.slowStatGain("l", -10);
			pc.cor(4);
		}
		else {
			output("\n\nExhausted, you pull yourself free from the mouse, drained of lust but feeling VERY naughty.  Jojo doesn't even bother getting up, he just keeps masturbating, lost in the scents of your slick juices and his cum.  As you walk away with a sexy wiggle, the sexual fluids are absorbed into the ground.");
			pc.orgasm();
			pc.slowStatGain("l", 2);
			pc.cor(1);
		}
	}
}

private function jojosFifthRape():void {
	clearOutput();
	output("Jojo smiles serenely, pleased at the outcome, a foot of tumescent mouse-meat bobbing at attention.\n\n");
	//Placeholder till I'm less lazy
	output("You fuck your mousey slut for what feels like hours, orgasming until both of you are tired and worn out.  ");
	processTime(120 + rand(60));
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	if (pc.libido() > 40) {
		output("When you're done you feel more clear-headed, but Jojo looks hornier than ever.");
		pc.slowStatGain("l", -4);
	}
}

public function loseToJojo():void {
	clearOutput();
	processTime(120 + rand(60));
	if (flags["COC.JOJO_STATE"] == 2 || flags["COC.JOJO_STATE"] == 3) {
		output("Jojo glares down at you, and begins praying, slowly laying prayer papers all over your battered form.  You feel rage that quickly dissipates, replaced with a calm sense of peace.  You quickly lose consciousness, but are happy he defeated you.\n\nWhen you wake, you discover a note:\n\"<i>The fighting allowed me to exorcise most of your inner demons.  A part of me wanted to seek revenge for what you had done to me, but I know it was the taint on your soul that was responsible.  If we meet again I would be happy to meditate with you.\n\n          -Jojo.</i>\"");
		pc.orgasm();
		//dynStats("lib", -10., "cor", -15);
		if(pc.libido() > 10) pc.slowStatGain("l", -10);
		pc.cor( -15);
		//if (pc.libidoRaw < 5) {
			//dynStats("lib", 15);
			//pc.libidoRaw = 5;
		//}
		//if (pc.cockTotal() == 1) pc.lib = 15;
		//if (pc.vaginas.length == 1) pc.lib += 10;
		//if (pc.cockTotal() > 1) pc.lib += 5;
		//if (pc.horseCocks() > 0) pc.lib += 3;
		//if (pc.dogCocks() > 0) pc.lib += 2;
		//if (pc.biggestLactation() >= 1) pc.lib += 2;
		flags["COC.JOJO_STATE"] = 1;
	}
	else {
		output("Jojo grins wickedly as he senses your defeat, " + enemy.cockDescript() + " throbbing hard.  ");
		if (pc.lustQ() >= 100) {
			if (pc.hasCock() && !pc.hasVagina()) {
				output("Too aroused to think, you just bend over, displaying your bum and letting your [pc.cocks] dangle freely.  The mouse doesn't hesitate, and he thrusts his " + enemy.cockDescript() + " with painful force.");
				pc.buttChange(enemy.cockVolume(0), true);
				output("  You stagger from the size and struggle to stay conscious as he fucks you like a mad beast, hammering your ass with incredible force.  ");
				if (pc.cockTotal() == 1) output("Pre and cum drip from your " + pc.cockDescript(0) + ", forced out of your prostate by the rough beating it's taking.  You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.");
				if (pc.cockTotal() > 1) output("Pre and cum drip from your " + pc.cockDescript(0) + "s, forced out of your prostate by the rough beating it's taking.  You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.");
				pc.loadInAss(enemy);
				pc.loadInAss(enemy);
			}
			if (pc.hasVagina()) {
				output("Too aroused to think, you bend over, displaying your bum and " + pc.vaginaDescript(0) + " to Jojo as open targets.  The mouse obliges, plunging himself into you, hard.");
				pc.cuntChange(0, enemy.cockVolume(), true);
				output("  He fucks you with abandon, pounding your wanton little pussy with no regard for your pleasure.  Despite yourself, you enjoy the rough treatment.  A spasm of warmth erupts inside you as Jojo cums.  You worry he might stop, but as the mouse's orgasm ends he resumes fucking with even greater energy. You cum powerfully, his jizz seeping down your thighs as you begin lose track of yourself.  ");
				if (pc.cockTotal() > 1) output("Your " + pc.cockDescript(0) + " splatters the ground with cum repeatedly, until both your genders are raw and sore.  ");
				else output("Your " + pc.vaginaDescript(0) + " cums on him many more times it until it is sore and tender, dripping with spunk.  ");
				output("You black out as Jojo cums AGAIN, forcing a river of spunk from your already over-filled uterus.");
				
				//Preggers chance!
				//pc.knockUp(PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.INCUBATION_MOUSE + 82, 101); //Jojo's kids take longer for some reason
				pc.loadInCunt(enemy);
				pc.loadInCunt(enemy);
			}
			if (!pc.hasGenitals()) {
				output("Too aroused to think, you just bend over, displaying your bum and wiggling enticingly.  The mouse doesn't hesitate, and he thrusts his " + enemy.cockDescript() + " with painful force.  You stagger from the size and struggle to stay conscious as he fucks you like a mad beast, hammering your ass with incredible force.");
				pc.buttChange(enemy.cockVolume(0), true);
				output("You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.");
				pc.loadInAss(enemy);
				pc.loadInAss(enemy);
			}
			pc.orgasm();
			pc.orgasm();
			pc.cor(1);
		}
		//HP Defeat
		else {
			output("You black out from the pain of your injuries.\n\n");
		}
	}
	CombatManager.genericLoss();
}

private function corruptJojoSexMenu():void {
	clearMenu();
	addDisabledButton(0, "Gentle BJ", "Gentle BJ", "This option requires you to have cock.");
	//addDisabledButton(1, "Give BJ"); // always on
	addDisabledButton(2, "Gentle Vaginal", "Gentle Vaginal", "This option requires you to have vagina.");
	addDisabledButton(3, "Gentle Anal", "Gentle Anal", "This option requires you to have cock.");
	addDisabledButton(5, "Cruel BJ", "Cruel BJ", "This option requires you to have cock.");
	addDisabledButton(6, "Breasts", "Breasts", "This option requires you to have at least B-cup breasts.");
	addDisabledButton(7, "Vag. Smother", "Vag. Smother", "This option requires you to have vagina.");
	addDisabledButton(8, "Cruel Anal", "Cruel Anal", "This option requires you to have genitals.");
	
	if (pc.hasVagina()) {
		addButton(2, "Gentle Vaginal", corruptJojoVaginalGentle);
		addButton(7, "Vag. Smother", corruptJojoVaginalSmother);
		addButton(8, "Anal Smother", corruptJojoAnalSmother);
	}
	if (pc.hasCock()) {
		addButton(0, "Gentle BJ", corruptJojoBJGentle);
		addButton(5, "Cruel BJ", corruptJojoBJCruel);
		addButton(3, "Gentle Anal", corruptJojoAnalGentle);
		if (pc.hasPerk("Whispered")) addButton(8, "Whisper", whisperJojobait);
		else addButton(8, "Cruel Anal", corruptJojoAnalCruel); //Overrides Anal Smother - Herms don't smother, they fuck
	}
	addButton(1, "Give BJ", corruptJojoCunnilingus);
	if (pc.biggestTitSize() >= 2) addButton(6, (pc.isLactating() > 1 ? "Suckle" : "Breasts"), corruptJojoBreasts); //All ya need is bewbs
	
	addButton(14, "Back", mainGameMenu);
}

private function corruptJojoBJCruel():void {
	showJojo();
	clearOutput();
	var x:int = pc.biggestCockIndex();
	output("You yell out into the jungle, \"<i>Slut!</i>\" Minutes later Jojo slips into your camp from the jungle's shadows, dropping to his knees with a timid look of fear in his eyes. You step forward and grip the fur between his shell-like ears firmly, hissing angrily, \"<i>When I call for you, you need to be here. Do I need to teach you your place again?</i>\"  ");
	output("He shakes his head as you say this, trying to marshal up the strength to resist you. You draw your teeth back in a snarl of anger at this resistance and punch the mouse in the gut, dropping him to his knees gasping for breath.  ");  
	if (pc.cocks[x].volume() < cockVolume(10))
		output("You grip the fur on his head tightly in one hand and pull his mouth over your " + pc.cockDescript(x) + ", thrusting into his muzzle with little concern for letting him catch his breath. You shove your length down his throat and start sawing away, making the mouse's eyes roll back from breathlessness. You can feel the muscles of his throat grip and spasm around your cock flesh as he chokes on the length, his thin lips trembling around your.  ");
	else if (pc.cocks[x].volume() < cockVolume(36))
		output("You grip the fur on his head tightly in one hand and pull his mouth over your " + pc.cockDescript(x) + ", thrusting into his muzzle with little concern for letting him catch his breath. The girth of your " + pc.cockDescript(x) + " nearly dislocates his jaw. You can feel his throat stretching around you, like a hot, wet, tight sleeve, trembling with the pulse of his racing heart as you grind in and out of his mouth.  ");
	else output("You grip the fur on his head tightly in one hand and pull his mouth over your " + pc.cockDescript(x) + ", thrusting against his muzzle with your " + pc.cockDescript(x) + ". You can feel his buck teeth scratching against the top and bottom of your [pc.cockHead " + x + "], but it does nothing to prevent what is to come. He lifts his hands to try to push your huge erection away, and since you can't fit your girth in his mouth, you decide to use that; grabbing hold of his hands and using them to stroke your length.  ");
	output("His eyes turn to you in fear and his body shudders for lack of breath, but it does nothing more than stoke the fires of your lust. You groan in pleasure as your balls draw up tight, churning with your corrupted seed, and in a rush you feed it to him, your orgasm overtaking you as surge after hot surge of [pc.cum] flares through your flesh and into his throat.  " + (pc.hasVagina() ? "A sympathetic orgasm hits your pussy, causing a surge of [pc.girlCum] to splash against his chest and dribble down your thighs lewdly.  " : ""));
	output("Your orgasm seems to last forever, filling his belly with your corrupted essence, causing his stomach to bulge slightly with the sheer volume of it. You pull away at last, letting him gasp for breath and fall to the ground, curling around his bloated belly.  ");
	output("You sneer at him and shake your head, hissing out, \"<i>It would be so much better for you if you didn't try to resist, my slut.</i>\"  ");
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	addNextButton();
}

private function corruptJojoBJGentle():void {
	showJojo();
	clearOutput();
	var x:int = pc.biggestCockIndex();
	output("As if on command, Jojo slips into your camp from the jungle's shadows, dropping to his knees with a timid look of fear in his eyes. You step forward and caress your fingers through the fur between his shell-like ears, whispering softly to him, \"<i>It's all right, my beautiful slut, it will all be over soon.</i>\"");
	output("  He whimpers as you say this, feeling the corruption flowing off of your body like an alluring musk, drawing him deeper into your service.  ");
	if (pc.cocks[x].volume() < cockVolume(10))
		output("He opens his mouth to protest, but you never give him the chance, sliding your " + pc.cockDescript(x) + " between his lips and down his throat. You can feel the muscles of his throat grip and spasm around your " + pc.cockDescript(x) + " as he chokes on the length, his thin lips trembling around your girth as his tongue slides across your vein-lined underside.  " + (pc.biggestTitSize() >= 2 ? "Your hands lift to massage your breasts and tug at your nipples, and you can see him watching transfixed as you fuck his throat.  " : ""));
	else if (pc.cocks[x].volume() < cockVolume(36))
		output("He opens his mouth to protest, but you never give him the chance, forcing your " + pc.cockDescript(x) + " between his lips and nearly dislocating his jaw with the girth of it. You can feel his throat stretching around you, like a hot, wet, tight sleeve, trembling with the pulse of his racing heart as you grind in and out of his mouth.  " + (pc.biggestTitSize() >= 2 ? "Your hands lift to massage your breasts and tug at your nipples, and you can see him watching transfixed as you fuck his throat.  " : ""));
	else output("He opens his mouth to protest, only to have your " + pc.cockDescript(x) + " mute him. You can feel his buck teeth scratching against the top and bottom of your " + pc.cockDescript(x) + "'s crown, but it does nothing to prevent what is to come. He lifts his hands to try to push your huge erection away, and since you can't fit your girth in his mouth, you decide to use that; grabbing hold of his hands and using them to stroke your length.  " + (pc.biggestTitSize() >= 2 ? "His eyes move from your massive member to your bouncing breasts above with a look of wanton desire that makes you laugh softly.  " : ""));
	output("His eyes turn to you in fear and awe, pleading for release, and a slip of your foot to his own straining erection lets you know how in need of an orgasm he is, but this time is yours. You groan in pleasure as your balls draw up tight, churning with your corrupted seed, and in a rush you feed it to him, your orgasm overtaking you as surge after hot surge of cum flares through your flesh and into his throat.  " + (pc.hasVagina() ? "A sympathetic orgasm hits your pussy, causing a surge of feminine juices to splash against his chest and dribble down your thighs lewdly.  " : ""));
	output("Your orgasm seems to last forever, filling his belly with your corrupted essence, causing his stomach to bulge slightly with the sheer volume of it. You pull away at last, letting him gasp for breath and fall to the ground, curling around his bloated belly.  ");
	if (pc.biggestTitSize() >= 2)
		output("You draw him to your bosom and kiss his forehead and then stand and go about your duties, leaving him to recover from the intense encounter and then retreat back into the jungle.  ");
	else output("You give him one last fond caress, running your fingers through his fur in an almost patronizing petting motion, then turn without another word and leave him to retreat back into the jungle.  ");
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	addNextButton();
}

private function corruptJojoCunnilingus():void {
	showJojo();
	clearOutput();
	output("You decide to finally reward your slut for all his service to you, summoning him to your camp for pleasure. He meekly appears at your bidding and you direct him to lie down on the ground before you. He does as you ask and you gently spread his legs, settling down between them.  ");
	output("He looks at you in confusion that turns to bliss as you start to lick and caress his sheath and balls, urging the male to a full erection.  ");
	switch (rand(3)) {
		case 0:
			output("You take the tip of his member into your mouth, suckling at it as your tongue curls at the crown and teases at the tiny slit at the tip. You take your time with him, letting your hands rub up and down his length, masturbating him slowly and giving his needy balls the occasional caress.  ");
			break;
		case 1: output("You take the tip of his member into your mouth and slowly start to bob your head, one hand squeezing at his balls tenderly as your other hand strokes the length of his cock that your lips don't reach. You let your pace quicken over time, mimicking a vigorous fucking.  ");
			break;
		default:
			output("You take the tip of his member into your mouth, and then take a deep breath through your nose, before dropping your head down, listening to him gasp as his cock slides all the way into your mouth and down your throat, until your nose presses against his musky sheath.  Your hands tease and squeeze at his balls, urging him to cum as your throat rhythmically swallows at his length in a milking motion.  ");
	}
	output("You work until your slut explodes, and then, keeping all his seed in your mouth, you lift your head and press your lips to his in a firm kiss, feeding him the load of cum that he just released. He blushes as you do so, but obediently takes it all in, swallowing it down as you feed it to him.  ");
	output("Once the vulgar kiss is finished, you stand and smile, dismissing him with a casual wave of your hand.  ");
	processTime(15 + rand(10));
	pc.cor(0.5)
	pc.lust(25);
	pc.loadInMouth(jojo);
	addNextButton();
}

private function corruptJojoVaginalGentle():void {
	showJojo();
	clearOutput();
	output("Feeling the urge to be filled, you summon your mouse slut to you and smile as he quickly responds, moving to kneel before you reverently. You let your hand caress the side of his head, then order him to lay back.  ");
	output("He swallows and nods, nervously obeying, stretching himself out on his back on the ground. He watches as you crawl slowly up his body and press a firm kiss to his muzzle, which he returns with the impossible lust you have planted within him. You can feel his member stirring between your legs, rising up firm against your " + (pc.hasCock() ? "own endowments" : "crotch") + " as you grind your dripping slit along it.  ");
	if (pc.vaginalCapacity() < cockVolume(10)) {
		output("You lower your hand to take hold of his cock, lining it up with your entrance, and then with a soft grunt, you start to lower your weight atop him.\n");
		pc.cuntChange(0, jojo.cockVolume(), true);
		output("\n\nYou can feel every vein and ridge in his thick erection, stretching your tight pussy open around him. You start to ride him the best you can, taking barely half his length into your tight body with the knowledge that neither of you will last long. He cums first, however, and you can feel the seed surging into your body past the tight seal of your internal muscles.  ");
	}
	else if (pc.vaginalCapacity() < cockVolume(36)) {
		output("You lower your hand to take hold of his cock, lining it up with your entrance, and then with a moan of pleasure, you lower your weight atop him. His cock slides into your pussy like a hand into a glove, fitting perfectly, as though he were made for you.\n");
		pc.cuntChange(0, jojo.cockVolume(), true);
		output("\n\nYou begin to rise and fall over him, setting a loving pace as you roll your hips. It doesn't last near as long as you would wish, however, as soon enough you can feel him cumming within your body, filling you with his seed. Not dissuaded, you grind at him, working your clit against his sheath and belly fur.  ");
	}
	else {
		output("You shift forward, and then tilt your hips and drive back, taking his length into your wide stretched body.\n");
		pc.cuntChange(0, jojo.cockVolume(), true);
		output("\n\nYou laugh at him, barely able to feel his dick within you, and whisper into his ear, \"<i>Just like a mouse to be tiny...</i>\" You watch his blush as you start to grind and roll atop his cock and belly, taking all the pleasure that you can from your slut.  ");
	}
	output("You cry out in pleasure as your orgasm floods through your body, causing your juices to splash out around your mouse slut's cock" + (pc.hasCock() ? ", and your own [pc.cocks] to explode with thick splashes of your hot cum across his chest and belly" : "") + ". You stay seated on his hips until your orgasm fades, then with a sigh of pleasure you stand off of him and dismiss him with a wave of your hand.  ");
	//Preggers chance!
	//pc.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	pc.loadInCunt(jojo);
	addNextButton();
}

private function corruptJojoVaginalSmother():void {
	showJojo();
	clearOutput();
	output("You feel the need to gain a little sexual relief and a mischievous idea comes to your mind, making you grin wickedly. You slip off into the jungle to seek out your monk mouse fuck toy, and when you find him, you practically pounce atop him, pinning him to his back. He struggles in surprise until he realizes that it is you, at which point he blushes and tries to look away, unable to help the erection that you are sitting against as you straddle him.  ");
	output("You crawl further up his body and grin down at him as you press your already dripping pussy to his mouth and command sharply, \"<i>Start licking if you want to breathe.</i>\" His eyes go wide, but you can feel his tongue already starting to work at your lusty slit.  ");
	if (pc.isSquirter())
		output("You moan as he works, your juices flowing liberally across his muzzle and into his mouth and nose, making him struggle not to drown in your pleasure as he focuses on giving you even more so.  ");
	else if (rand(2) == 0)
		output("You grind your slit against him as he eats you out, moaning with pleasure and writhing above him. You lift off of his face every so often, giving him just enough of a break to catch his breath before cutting it off with your pussy once again.  ");
	else output("You settle the full of your weight against his face and laugh as you feel him struggling to pleasure you, his nose and mouth trapped tight against your slit so that every attempt to breathe is halted, making him tremble breathlessly beneath you.  ");
	output("His tongue digs deep into your body, finally bringing you to an explosive climax that leaves you shuddering thoughtlessly above him. You actually forget you are sitting on his face for a moment, feeling him go still as he nearly passes out from lack of breath before you stand up.  ");
	output("He gasps for breath and coughs a few times, and once you are sure that he is safe, you laugh softly and walk back to your camp.  ");
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	addNextButton();
}

private function corruptJojoAnalCruel():void {
	showJojo();
	clearOutput();
	var x:int = pc.biggestCockIndex();
	output("You decided that it is time to seek out your pet monk slut, and stalk into the jungle after the mouse. It doesn't take long to find him, so you move silently to avoid his notice. You move with a predator's grace as you sneak up behind him, your hand reaching down to grab hold of his tail firmly as you shove him against a nearby tree.  ");
	output("You press your body up behind him" + (pc.biggestTitSize() >= 2 ? ", mashing your breasts against his back" : "") + " and hiss into his ear, \"<i>Hello slut...</i>\" You keep hold of the base of his tail, hiking it up to lift his ass enough that he has to go to his toes to stay standing. You listen to him whimper softly as he feels your stirring loins press against the cleft of his oh-so-fuckable ass.  ");
	if (pc.cocks[x].volume() < cockVolume(10))
		output("You saw your swelling erection between his ass cheeks a few times, and then with little warning, you shove yourself deep into his body, making the mouse gasp out as you fill his well used rear. You groan in pleasure as you feel his anal ring grip in flutters along your " + pc.cockDescript(x) + " as you spear in and out of him, fucking your slut toy with wild abandon.  ");
	else if (pc.cocks[x].volume() < cockVolume(36))
		output("You press the mouse hard against the tree, inhaling his scent and sliding your " + pc.cockDescript(x) + " between his firm cheeks.  There is little in the way of tenderness as you thrust deep into his body. You can hear him groan as your " + pc.cockDescript(x) + " forces his intestines to shift to accommodate you.  ");
	else output("You grin as your mouse slut cries out with your " + pc.cockDescript(x) + " spearing into his bowels. You can feel the weight of the tree against your " + pc.cockDescript(x) + " as you force his belly to bulge out vulgarly to accommodate the enormous girth.");
	pc.cockChange();
	jojo.buttChange(pc.cocks[x].volume());
	output("  You thrust away at your squirming and mewling mouse, taking out your pleasure on him with little concern for his own enjoyment, not that this is really a problem, as before you manage to cum, you feel him tense as he 'fertilizes' the tree you have him pressed against. The feel of his orgasm milks you to your own explosion within his belly, emptying your balls with a low groan of relief.  ");
	output("You pull out of Jojo's ass once your orgasm has subsided and wipe your " + pc.cockDescript(x) + " off on the fur of his back, then walk away to leave him to his own devices.  ");
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	addNextButton();
}

private function corruptJojoAnalGentle():void {
	showJojo();
	clearOutput();
	var x:int = pc.biggestCockIndex();
	output("You watch as Jojo slinks into your camp from the dense jungle, moving timidly with his eyes focused on your feet. The sight of such a once pious monk reduced to your submissive fuck toy stirs your loins and brings a smile to your lips.  ");
	output("You pull him against your body in a firm and possessive hug, and press your lips to his in a forceful kiss, laughing as you break the kiss to the sight of his discomfort. You pay it little mind as you gently force him back onto the ground and spread his legs. You can see in his eyes that he knows what is coming, and you can see that he is as eager for it as he is humiliated by that eagerness.  ");
	if (pc.cocks[x].volume() < cockVolume(10))
		output("You lift the mouse's balls out of the way and spit down onto the crinkled star of his anus, then lever your tip to the well used hole. There is little ceremony or foreplay, but his cock is already straining erect, and a blush colors his cheeks as you push into his ass, inch by inch. You set a slow and tender pace at first, but as your orgasm nears, your thrusts become more animal and needy.  ");
	else if (pc.cockVolume(x) < cockVolume(36))
		output("You slide your thick and drooling cockhead beneath the mouse's balls, working the musky drool of your pre-cum against the well used crinkle of his ass before forcing the thick vein-lined length of your " + pc.cockDescript(x) + " into him. You watch as inch after thick, vulgar inch disappears into his body, grinning as his face contorts in a mix of pain and pleasure from it, and then start to fuck him in earnest, watching as his belly bulges with each thrust of your massive prick.  ");
	else output("You force your " + pc.cockDescript(x) + " against the mouse's ass and watch as he shakes his head, silently begging you not to do it. You smile and grip his hips, then press forward hard, forcing his body to adapt to your girth, stretching his ass and belly dangerously. You can barely get more than a foot of your " + pc.cockDescript(x) + " into him before bottoming out against his diaphragm, so you just fuck him with what you can, churning his insides with each thrust.");
	pc.cockChange();
	jojo.buttChange(pc.cocks[x].volume());
	output("  You pound away at the mouse's tight body for as long as you can, then feel your orgasm hit you hard, your balls drawing up tight as your seed churns and pulses through you and into the mouse's ass, filling his belly with your lust and corruption. You watch his belly swell with the seed in a beautifully vulgar display.  ");
	output("His eyes glaze over from the intensity of the act, his teeth tightly grit, and then you can hear a keening groan from him as he falls over the edge into his own orgasm, his untouched mouse cock bouncing and jerking on his belly as his thick seed is sprayed across his chest and face lewdly. He blushes deep at the visible proof that he enjoyed what you did to him and trembles beneath you.  ");
	output("You can't help but laugh at the scene, and draw out of his ass with a groan of pleasure. You watch as he crawls back into the jungle in shame, leaving a trail of your cum the whole way.  ");
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	addNextButton();
}

private function corruptJojoAnalSmother():void {
	showJojo();
	clearOutput();
	output("You feel the need to gain a little sexual relief and a mischievous idea comes to your mind, making you grin wickedly. You slip off into the jungle to seek out your monk mouse fuck toy, and when you find him, you practically pounce atop him, pinning him to his back. He struggles in surprise until he realizes that it is you, at which point he blushes and tries to look away, unable to help the erection that you are sitting against as you straddle him.  ");
	output("You crawl further up his body and grin down at him as he stares at your exposed pussy. You suddenly spin, sitting down the other way, so that your ass cheeks envelope his muzzle, trapping his nose and mouth against your tight pucker. \"<i>Get that tongue up in there slut.</i>\"  ");
	switch (rand(3)) {
		case 0:
			output("You grind your ass against him as he eats you out, moaning with pleasure and writhing above him. You lift off of his face every so often, giving him just enough of a break to catch his breath before cutting it off with your ass once again.  ");
			break;
		case 1:
			output("You settle the full of your weight against his face and laugh as you feel him struggling to pleasure you, his nose and mouth trapped tight against your ass so that every attempt to breathe is halted, making him tremble breathlessly beneath you.  ");
			break;
		default:
			output("You moan as he takes you at your word, spearing his tongue deep into your anus and thrusting it in and out as though it were a sleek muscled shaft, making your body tremble in pleasure. It makes you wonder where he learned such a trick in his life as a pious monk.  ");
	}
	output("His tongue continues to work at your ass, finally bringing you to an explosive climax that leaves you shuddering thoughtlessly above him. You actually forget you are sitting on his face for a moment, feeling him go still as he nearly passes out from lack of breath before you stand up.  ");
	output("He gasps for breath and coughs a few times, and once you are sure that he is safe, you laugh softly and walk back to your camp.");
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	addNextButton();
}

private function corruptJojoBreasts():void { //Should only be available to players with biggestBreastSize > 2
	showJojo();
	clearOutput();
	output("You lay yourself out for a quiet moment of self pleasure, your hands moving to your breasts and fondling them gently, when the sound of a snapping twig brings your attention to the edge of camp. Jojo stands timidly, half hidden within the shadows just outside your encampment, watching you with a look of submissive desire. You smile and lift your hand, beckoning him towards you with a crook of your finger.  ");
	output("Your mouse slut obediently slips from the darkness and into your camp, approaching you and kneeling at your side. You can see the lust in his eyes as he looks at your breasts, longing and love reflecting wonderfully. You nod your approval and let him worship your bosom.  ");
	if (pc.isLactating()) { //For suckling the scene is the same regardless of player's gender
		output("He leans in and starts to kiss along your [pc.nipples] before taking one into his mouth. He gives a firm suckle at the engorged teat, and you can see his eyes open wider in surprise at the sudden surge of [pc.milkNoun] that fills his muzzle. He shivers and starts to suckle in earnest, drinking from first one breast, then the other, ");
		if (pc.totalBreasts() > 2) output("and then all the others, "); //Extra boob coverage
		output("partaking of your blessing until his belly is full.  ");
		pc.milked();
	}
	else if (pc.biggestTitSize() <= 5) {
		output("He leans in to nuzzle and kiss at your breasts, his hands moving to caress the soft and full orbs in gentle worship. His kissing and licking slowly circles in on your nipples, bringing them to firm points that send jolts of warm pleasure through your body when he at last takes them into his mouth. You reach down between your legs, " + (pc.hasCock() ? "taking hold of [pc.oneCock] and masturbating it lazily as he works.  " : "slipping your fingers into your slit as you lazily masturbate with the pleasure he brings.  "));
	}
	else {
		output("He leans in close and presses a kiss to first one nipple, then the other, starting to worship your breasts lovingly. You have other plans, however, and one hand grabs the fur at the back of his neck as the other slips beneath your breasts to pull them together to either side of his face as you press him in tight against the curves of your cleavage, forcing the mouse to fight for every breath.  ");
	}
	output("You can hear Jojo's breath quickening, then his body shudders as he climaxes spontaneously, splashing his seed across your hip and belly. You can't help the laugh that rises from within you at his submissive gesture, watching as shame washes across his face and his ears lay back.  ");
	output("He slinks back into the woods, chased by your amused laughter.");
	//if (flags["COC.JOJO_ANAL_XP"] < 3) IncrementFlag("COC.JOJO_ANAL_XP"); // why?
	processTime(15 + rand(10));
	pc.orgasm();
	pc.cor(0.5)
	addNextButton(returnToCampUseOneHour);
}

//Extra Scenes
//[Jojo Whispered Sex scene]
//(Requires the Whispered perk and Jojo as follower)
private function whisperJojobait():void {
	clearOutput();
	//output(images.showImage("akbal-deepwoods-male-jojosex"));
	var x:int = pc.biggestCockIndex();
	
	output("You close your eyes and begin to think of Jojo.  You can feel the former monk's presence far away in the forest, futilely trying to meditate and rid himself of the corruption you so generously bestowed upon him.  He is sitting with one paw on his knee, and the other on his rigid tool.\n\n");
	output("He flinches as a chorus of voices begin whispering in his ear.  He looks around, wondering if he truly heard something or if he's just imagining the many beings saying such lewd things about him.  As you begin to visualize his body being dominated and forcibly made to submit to your every twisted whim, he begins to squirm as a stream of clear mouse-pre starts leaking down his ridged shaft.  After a moment's hesitation, he starts to head in your direction.\n\n");
	output("You turn up the pressure with a wicked smile, and watch the mousey begin to walk in wide strides as his orbs slowly swell.  He is soon so devastatingly aroused that he falls to his knees with a cry.  Through your mind's eye, you see him wrapping his fists around his shaft. He tries to masturbate in a desperate bid to relieve himself, but it is to no avail.  Your spell numbs his member every time he reaches for it, teasing and frustrating the mouse as he becomes increasingly aware that only you can relieve him of his steadily growing lust.  Unable to walk straight anymore, he crawls towards your camp on his hands and knees, his mouth snapped shut to stop himself from calling out and attracting the attention of any demon or creature that is not his master.\n\n");
	output("Jojo enters the edge of your camp with a wail, his once proud voice breaking as he begs you to come have your way with him.  You concentrate harder on the spell, sitting down as Jojo howls his woe for all the world to hear.  He is clawing the ground, dragging his belly through the dirt.  His balls are swollen to a massive size, stopping all but the tips of his toes from touching the ground.  His large swollen phallus drags behind him, leaving a river of spunky pre in its wake.\n\n");
	output("When he does finally reach you, with a labored breath he presents himself to you as best he can.");
	output("\n\n");

	output("You bend down to pat Jojo's obscenely swollen sac; you're determined to empty them of the liquid you hear sloshing around inside.  Jojo yelps as you do, your spell having made his body overtly sensitive to your touch.  ");
	//[Tentacle Penis]
	if (pc.cocks[x].hasFlag(GLOBAL.FLAG_PREHENSILE)) {
		output("His rodent tail wraps around your waist as you get into position, causing your " + pc.cockDescript(x) + " to writhe even harder, searching for the hole Jojo's tail is pulling you towards.  As soon as you're close enough, your " + pc.cockDescript(x) + " pushes into Jojo, twisting around to widen the mouse's hole even further.  Jojo squirms as you brutally stretch him out, stiffening once his hole is stretched to the max.  After admiring the now obscenely gaping hole of your mouse slut, you begin to grind your member around, causing Jojo to scream in ectasy as your " + pc.cockDescript(x) + " goes ballistic inside of his hungry bowels.\n\n");
	}
	//[Small penis (7 inches or less)]
	else if (pc.cockVolume(x) < cockVolume(13)) {
		output("His hole flexes constantly, as if hungry for your " + pc.cockDescript(x) + ". Jojo's tail wraps around your waist as you get into position, and you sink your " + pc.cockDescript(x) + " into his hungry mouse hole.  The sensation of Jojo's hole quivering around your " + pc.cockDescript(x) + "makes you smile as you begin thrusting in and out of him.  Jojo groans beneath you like a whore in heat, his ass moving in time to meet your thrusts.  The sound of your bodies clapping together is an applause as you fuck the little mousey without reservation.\n\n");
	}
	//[Medium penis (8-12 inches)]
	else if (pc.cockVolume(x) < cockVolume(25)) {
		output("His tail possessively wraps itself around your waist as you tease him with your " + pc.cockDescript(x) + ", smearing your leaking pre all over his stretched tail hole.  You slide yourself into him with a sigh, feeling his hole quiver around your invading sex organ.  Jojo wails like a whore in heat beneath you, grunting as you begin to piston pump your swollen sex organ in and out of his greedy mousey hole.\n\n");
	}
	//[Large penis (13 inches and up)]
	else {
		output("Jojo's tail wraps around your waist as you get into position behind him, tightening possessively and trying to bring you closer.  You oblige the slut, sliding your " + pc.cockDescript(x) + ", up the mouse's spread cheeks, teasing his ass with the underside.  When you slip your oversized sex organ into his hungry hole, you feel a cringe ripple through his entire body.  You can soon feel the earth beneath Jojo's stomach as the slow invasion of your " + pc.cockDescript(x) + " is halted by the mouse's diaphragm; you're unable to fit more than a foot of its length into Jojo's overstuffed tail hole.  You withdraw slowly before suddenly shoving your hips forward, knocking the wind out of the little mousey.  Despite being stretched and filled beyond his limits, the mouse releases a pleased groan and begs for more.\n\n");
	}

	output("You feel the pressure building as you saw your " + pc.cockDescript(x) + " in and out of Jojo's tail hole, brutally fucking the mouse.  Jojo moans in both ecstasy and pain, releasing a shrill squeak with every thrust.  He claws at the ground, both hungry for more and desperate for release.  The tip of his tail unwraps from your rapidly thrusting hips and slides down your " + pc.buttDescript() + ", spurring you to jackhammer his insides faster. The tip slips into your " + pc.assholeDescript() + ", working your prostate as you abuse the mouse's.\n\n");

	//[With Fertility/Lots of Jizz Perk]
	if (pc.cumQ() >= 1500) {
		output("You let out a roar as you cum together with Jojo.  Your hips work through your orgasm, fucking your seed deeper into the ex-monk even as you pump gallons of your sperm into him.  His bowels and stomach are filled in no time at all, causing your every thrust to squirt spunk out of his over-filled body.\n\n");

		output("Jojo howls like a whore in heat, squirming around your still-pumping " + pc.cockDescript(x) + " as his fuzzy sac shrinks, your rough thrusts forcing his body flat against the ground once his sex organs have returned to normal size.\n\nAfter your orgasms have subsided, Jojo smiles up at you and thanks you over and over for 'saving' him.  You pull out, an ocean of [pc.cumColor] spilling down his already cum-splattered fur, framing his tail hole with leaking gobs of [pc.cumVisc] liquid.\n\n");
		output("As you move away from the mouse, you step into a huge puddle of Jojo's creamy rodent cum and look back. You see that his dick, still trapped under his body and pointing behind the two of you, blasted long ropes of thick mouse spunk far into the depths of the forest.  Feeling the after-effects of your titanic orgasm, you lay next to your mousey whore and close your eyes, allowing him to curl up next to you as you both fall asleep, exhausted and beyond satisfied.\n\n");
	}
	//Without Fertility/Lots of Jizz Perk]
	else {
		output("You grit your teeth as you cum together with Jojo.  With one last great thrust, you slam your trunk into his mousey tail hole and unload into his tightly clenched bowels.\n\n");

		output("Jojo's balls begin to shrink as he shoots his own seed, your weight forcing his body flat against the ground once his sac has shrunk to normal.  His tail still slides around inside your " + pc.buttDescript() + ", spurring you to reward him with a few post-orgasm thrusts.  His bowels are hot and wet from your load, and you grind your " + pc.cockDescript(x) + " around with a look of supreme bliss on your face.  Jojo groans as you pull out, releasing a stream of creamy white that slides down to his now normal sized balls. Well... normal for Jojo.\n\n");
		output("As you move away from the mouse, you step into a huge puddle of Jojo's creamy rodent cum and look back. You see that his dick, still trapped under his body and pointing behind the two of you, blasted long ropes of thick mouse spunk far into the depths of the forest.  Feeling beyond satisfied, you give your mouse slut a quick scratch behind the ear as he passes out – cum splattered and smiling.");
	}
	processTime(90 + rand(30));
	pc.orgasm();
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Bee on C. Jojo: Finished (Fenoxo) (Zedit)
private function beeEggsInCorruptJojo():void {
	clearOutput();
	output("Drawing Jojo close, you gently tease your fingertips along the soft fur of his cheeks, buzzing reassuring noises into his dish-shaped ears.  The greedy little slut perks up and nuzzles against you happily.  His hand, soft and delicate, reaches down inside your [pc.gear] to touch your groin.  Its partner strays south to the mouse's own erection, gathering his copious pre to smear a fresh layer across his hardness.  You let him be for now, allowing him to build your lust higher and higher.  The show draws your ovipositor out of its slit and fills it with fresh blood, hardening the tubular organ into an approximation of a large phallus.");
	output("\n\nJojo, for his part, seems oblivious to the swelling protrusion or your malicious grin.  Once fully hard, you whisper to him, instructing for him to get on all fours and let you fuck him.  ");
	if (!pc.hasCock()) {
		if (int(flags["COC.TIMES_EGGED_JOJO"]) == 0) output("Jojo looks confused at this; he knows you don't have a cock!  ");
		else output("Jojo looks confused at first, and then nods in understanding, remembering the last time you laid in him.  ");
	}
	output("He bends over, obedient slut that he is, lifting his ");
	if (tentacleJojo()) output("tentacle-");
	output("tail for you in an inviting motion.  His butt looks nice and cushy, a soft heart-shape just beckoning to be impaled on your rigid egg-tool.  You give the mouse-tush a hearty swat and smile at his squeak of surprise and winking anus.");
	
	output("\n\nMoving forward, you ");
	if (pc.isNaga()) output("slither around him");
	else if (pc.isGoo()) output("ooze over him");
	else if (pc.isTaur()) output("straddle him");
	else output("climb atop him");
	output(".  Jojo looks up over his shoulder trustingly, swaying a bit from trying to hold up your body weight.  He starts to reach for his corruption-fueled boner, but of course, he has to drop his arm to hold himself upright.  The rodent whines plaintively, begging you to take him, stroke him... ANYTHING!  You gently shush him and sink your stinger into his backside, rewarding his obedience with a flash of pain and injection of fresh, unnatural lust.  His arms begin to shake, his butt begins to wiggle, and he starts to drool all over the ground, panting in a way that reminds you more of a canine than a mouse.");
	output("\n\nYou withdraw one insectile spear from the slut-mouse's rump and replace it with another, thicker prong.  Your honeyed ovipositor slides right into Jojo's welcoming anus, his rectum stretching to welcome the egg-pipe's healthy width.  A trickle of lubricating, honey-like fluid dribbles from the tip to aid the penetration, and in no time flat, the mouse's ass is a slick fuck-tunnel that sweetly squishes with each pump of your abdomen.  His thick, foot-long mouse-cock actually softens slightly and flops around with each thrust, trailing trickles of stringing pre-cum as you squeeze it out of him.");
	output("\n\nJojo mewls in pleasure when you push particularly hard and bottom out the heavy ovipositor, your stinger nearly scratching his balls.  A huge wad of semi-opaque cum drizzles from his cocktip, and he begins to push back against you like the willing fuck-pet that he is.  You grab him by the ears and begin to fuck him faster; the wet squelches carry through your camp to let anyone nearby know exactly what's going on.  You'd worry if you weren't lost in the moment, tugging his back and lewdly kissing him while your honey-flow thickens and the eggs shift into position.");
	output("\n\n\"<i>Here it comes pet,</i>\" you coo, \"<i>Let's see just how many eggs you can hold, hrmm?</i>\"");
	output("\n\nJojo whimpers and nods, his dick dripping a bit quicker at your words.  What a whore!  Gasping in pleasure, you feel the first egg begin to slide through your fuck-tube, the muscular contractions coaxing it deeper and deeper inside your pet.  Your organ, made to stretch as it is, easily handles the passage, but Jojo's butthole doesn't fare quite as well.  He is liberally strained by it, his poor prostate pressed so hard that a rope of thick fluid squirts from his cock, not from orgasm or pleasure, but because there is no room in his body for it.");
	output("\n\nThe white mouse moans lustily, trying to hump back against you, actually seeking more pressure on his prostate even though you've stopped thrusting.  Fortunately for him, you can feel your next egg squeezing down into your ovipositor, even as the first pops out into the rodent's gut.  Jojo gasps at the change in pressure before resuming his panting moans.  Even before the second egg has traversed half your length, the third makes itself known, nestling into the base and beginning its slow, pleasure-filled journey out your prong and into your pet's behind.");
	output("\n\nLaying eggs feels so goddamn good!  ");
	if (pc.hasGenitals()) {
		output("Your ");
		if (pc.hasVagina()) output("[pc.vagina] ");
		if (pc.isHerm()) output(" and ");
		if (pc.hasCock()) output("[pc.eachCock] ");
		if (pc.isHerm() || pc.cockTotal() > 1) output("are");
		else output("is");
		output(" gushing all over Jojo's back, but you don't feel particularly inclined to deal with your regular genitals.  ");
	}
	output("You're utterly focused on the silky feel of those smooth spheres rolling out of you, being implanted into a host, willing or not.  Thankfully, Jojo is willing, creaming the ground, sputtering strings of spunk with each new egg that you force inside his once-tight anus.  Orb after orb slides inside him, drawing shivers of ecstasy from your alien-looking egg-cock.  With an explosive clench, you cum and force the remainder of your eggs into the mouse-bitch's butt-cunt.");
	if (pc.eggs > 30) output("  His belly is slightly rounded by the time you finish, with small, egg-shaped bumps visible through his fur.");
	
	output("\n\nYou pull out with a self-satisfied smile, the ovipositor swiftly retracting into your body.  A trickle of golden honey pours from the mouse's abused anus to mix with his puddling spunk.  The relief you feel is palpable - you're light on your [pc.feet] when you climb off him, and Jojo sighs, \"<i>Thank you for the orgasm!</i>\"");
	
	output("\n\nHe shambles off towards the woods when you dismiss him, his hard cock still dribbling mousey sperm the whole way.  You have to wonder if the eggs are sliding over his prostate with every step he takes?  Oh well, it's no concern of yours.");
	if (pc.fertilizedEggs > 0 && flags["COC.JOJO_EGGS_INCUBAATION"] == undefined) {
		flags["COC.JOJO_EGGS_INCUBAATION"] = 80 * 60 + timeAsStamp;
		//pregnancy.buttKnockUpForce(PregnancyStore.PREGNANCY_BEE_EGGS, 80);
	}
	IncrementFlag("COC.TIMES_EGGED_JOJO");
	processTime(15 + pc.eggs + rand(10));
	pc.orgasm();
	pc.dumpEggs();
	
	if (inCombat()) CombatManager.genericVictory()
	else {
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

//Jojo Got Laid With Fertilized Bee Eggs (Zedit)
public function jojoLaysEggs():void {
	clearOutput();
	output("While passing time, you hear grunts of pleasure from the direction of the forest.  You amble over to investigate and find Jojo bent over, ass-up.  He's tugging on his cock non-stop, firing ropes of cum one after another while heavy, honey-slicked eggs roll out of his gaped anus to form an amber pile.");
	output("\n\nYou watch idly as the mouse gathers up the drizzling honey for lube and smears it over his cock, turning his twitching, orgasmic prick golden.  He pumps faster and faster, squeezing and jerking, moaning in lurid, unrestrained bliss.  Jojo is focused utterly on laying eggs and getting off, or maybe he's just getting off from the act of laying.  He's not even supporting his upper body - he just sits there, face down in the dirt, laying and cumming, laying and cumming.  His eggs are even drizzled with his wasted spunk, a testament to the debauchery of their surrogate 'mother'.");
	output("\n\nThe mouse turns his head to meet your gaze and whimpers, \"<i>Did... did I do a good job?</i>\"");
	output("\n\nYou start to answer, but the exhausted, anal-gaped slut slumps onto his side and starts snoring, exhausted and dripping both white and yellow.  The whole thing makes you feel a little hot under the collar, but there's nothing to do for now but head back to camp.");
	flags["COC.JOJO_EGGS_INCUBAATION"] = undefined; //Clear Butt Pregnancy
	pc.lust(20);
	processTime(16 + rand(8));
	addNextButton();
}

public function corruptJojoEncounter():void {
	showJojo();
	clearOutput();
	output("You are enjoying a peaceful walk through the woods when Jojo drops out of the trees ahead, ");
	if (flags["COC.JOJO_STATE"] == 2) output("his mousey visage twisted into a ferocious snarl.  \"YOU!\" he screams, launching himself towards you, claws extended.");
	if (flags["COC.JOJO_STATE"] == 3) output("unsteady on his feet, but looking for a fight!");
	if (flags["COC.JOJO_STATE"] == 4) output("visibly tenting his robes, but intent on fighting you.");
	if (flags["COC.JOJO_STATE"] == 5) output("panting and nude, his fur rustling in the breeze, a twitching behemoth of a cock pulsing between his legs.");
	
	addNextButton(jojoCombatStart);
}

public function jojoCombatStart():void {
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(jojo);
	CombatManager.victoryScene(defeatedJojo);
	CombatManager.lossScene(loseToJojo);
	CombatManager.displayLocation("JOJO");
	CombatManager.beginCombat();
}