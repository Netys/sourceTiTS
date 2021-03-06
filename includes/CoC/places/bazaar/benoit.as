import classes.Characters.CoC.CoCBenoit;
import classes.Characters.CoC.CoCTrader;
import classes.GameData.Pregnancy.Handlers.CoCBenoitPregnancy;
import classes.GLOBAL;
import classes.Items.Apparel.CoCBondageStraps;
import classes.Items.Apparel.CoCNurseOutfit;
import classes.Items.Apparel.CoCSluttySwimwear;
import classes.Items.Apparel.CoCWizardRobes;
import classes.Items.Drinks.CoCGodMead;
import classes.Items.Guns.CoCFlintlockPistol;
import classes.Items.Miscellaneous.*;
import classes.Items.Transformatives.*;
import classes.Items.Transformatives.CoCEggs.*;
import classes.Items.Transformatives.CoCEggs.CoCBlueEggLarge;
import classes.PregnancyData;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public function get benoit():CoCBenoit
{
	return chars["COC.BENOIT"];
}

private function benoitLover():Boolean {
	return flags["COC.BENOIT_TIMES_SEXED_FEMPCS"] >= 2;
}

public function benoitAffection(changes:Number = 0):Number {
	if (flags["COC.BENOIT_AFFECTION"] == undefined) flags["COC.BENOIT_AFFECTION"] = 0;
	
	if (changes != 0) {
		flags["COC.BENOIT_AFFECTION"] += changes;
		if(flags["COC.BENOIT_AFFECTION"] > 100) flags["COC.BENOIT_AFFECTION"] = 100;
		else if(flags["COC.BENOIT_AFFECTION"] < 0) flags["COC.BENOIT_AFFECTION"] = 0;
	}
	return flags["COC.BENOIT_AFFECTION"];
}

/**
	Return the "heaviness" of the pregnancy
*/
public function benoitPreggers():Boolean
{
	if (int(flags["COC.BENOIT_STATUS"]) == 0) return false;
	if (benoit.eggs > 0) return true;
	return false;
}

public function benoitRegularPreggers():Boolean
{
	if (int(flags["COC.BENOIT_STATUS"]) == 0) return false;
	if (benoit.eggs >= 1 && benoit.eggs <= 4) return true;
	return false;
}

public function benoitHeavyPreggers():Boolean
{
	if (int(flags["COC.BENOIT_STATUS"]) == 0) return false;
	if (benoit.eggs >= 5 && benoit.eggs <= 8) return true;
	return false;
}

public function benoitVeryHeavyPreggers():Boolean
{
	if (int(flags["COC.BENOIT_STATUS"]) == 0) return false;
	if (benoit.eggs >= 9 && benoit.eggs <= 12) return true;
	return false;
}

public function benoitExtremePreggers():Boolean
{
	if (int(flags["COC.BENOIT_STATUS"]) == 0) return false;
	if (benoit.eggs >= 13) return true;
	return false;
}

public function benoitInClutch():Boolean
{
	if (int(flags["COC.BENOIT_STATUS"]) == 0) return false;
	
	// Benoit enters "clutch" every 21 days, for 7 days
	var startDay:int = Flag("COC.FEMOIT_NEXTDAY_EVENT");
	var currDay:int = days;
	var diffDays:int = (currDay - startDay) % 28;

	if (diffDays >= 21) return true;
	return false;
}

/*
Cum to Clutch Equation:

Benoite becomes pregnant with 1 egg by default.

She can produce a max clutch of 16 eggs, and a PC can only make her pregnant with up to 12 eggs by cum quantity alone. Elven Bounty gives +1 to both min and max clutch size (so a PC with that perk will give her 2-13 eggs each time they fertilise her), Marae's Gift - Stud gives +2 to both min and max clutch size. These two perks stack.

Every 200mls of cum the PC produces above the first 200mls equals 1 extra egg fertilised. So, producing 2 eggs requires 400mls, 3 eggs requires 600mls, etc, all the way to 12 eggs at 2400mls.

1-4 Eggs equates to a Regular Pregnancy.
5-8 Eggs equates to a Heavy Pregnancy.
9-12 Eggs equates to a Very Heavy Pregnancy.
13-16 Eggs equates to an Extremely Heavy Pregnancy.
*/
public function benoitKnockUp():Boolean
{
	if (benoitPreggers()) return false;
	if (!benoitInClutch()) return false;

	// Calc the number of eggs
	var cumQ:int = pc.cumQ();
	
	var bounty:Boolean = pc.hasPerk("Elven Bounty");
	var stud:Boolean = pc.hasPerk("Marae's Gift: Stud");
	var alpha:Boolean = pc.hasPerk("Fera's Boon: Alpha");

	var eggMod:int = 0;
	if (bounty) eggMod += 1;
	if (stud) eggMod += 2;
	if (alpha) eggMod += 1;

	var numEggs:int = cumQ / 200;
	var minEggs:int = 1 + eggMod;
	if (numEggs > 12) numEggs = 12;
	if (numEggs < minEggs) numEggs = minEggs;

	numEggs += eggMod;

	benoit.eggs = numEggs;
	flags["COC.FEMOIT_INCUBATION"] = 168;

	return true;
}

public function clearBenoitPreggers():void
{
	if (benoit.eggs != 0)
	{
		flags["COC.FEMOIT_EGGS_LAID"] += benoit.eggs;
		benoit.eggs = 0;
		flags["COC.FEMOIT_INCUBATION"] = 0;
		flags["COC.FEMOIT_NEXTDAY_EVENT"] = days; // Cycle "resets" based off birth day.
	}
}

public function setBenoitShop(setButton:Boolean = false):void {
	if (hours >= 9 && hours <= 17) {
		if ((Flag("COC.FEMOIT_NEXTDAY_EVENT_DONE") == 1 && days >= Flag("COC.FEMOIT_NEXTDAY_EVENT")) || Flag("COC.FEMOIT_NEXTDAY_EVENT_DONE") != 1)
		{
			if (flags["COC.TIMES_IN_BENOITS"] == undefined) 
			{
				if (!setButton) output("\n\nYou notice a large market stall wedged between two wagons, swaddled in carpets and overflowing with all manner of objects.  On top of its looming fabric canopy is a wooden sign with the words \"<b>Geckos Garbidg</b>\" crudely scrawled upon them.  You wonder what that's all about.");
				else addButton(0, "Market Stall", benoitIntro);
			}
			else 
			{
				if (!setButton) output("\n\n[benoit.short] the basilisk's stall looks open for business.  You could go see what's on offer.");
				else addButton(0, benoit.short, benoitIntro);
			}
		}
	} else if (setButton) {
		addDisabledButton(0, flags["COC.TIMES_IN_BENOITS"] == undefined ? "Market Stall" : benoit.short, flags["COC.TIMES_IN_BENOITS"] == undefined ? "Market Stall" : benoit.short, "This shop is open from 9 to 17.");
	}
}

//Introduction Scenes
public function benoitIntro():void {
	clearOutput();
	clearMenu();
	
	var suggestText:String = "";
	var suggest:Function = null;
	var womb:Function = null;
	if(flags["COC.TIMES_IN_BENOITS"] == undefined) {
		output("You cautiously approach the stall.  The shadow thrown by its large, overhanging canopy makes it quite difficult to see into its interior, and getting inside is made even more hazardous by the sheer volume of objects which clutter the area around it and hang out of the shelves arranged along its wooden walls.  Everything Mareth has ever created or distilled seems to be here - or at least, everything Mareth has ever thrown out.  Pots, pans, ugly crockery, shelves stuffed with clothing, a spice rack bulging with all manner of suspect-looking potions... you imagine you could probably find anything you'd ever want in here - or something closely resembling it - if you looked hard enough.");
		output("\n\n\"<i>Allo?</i>\" says a raspy voice from further in the gloom.  \"<i>'Oo is zair?</i>\"  You can make out a counter constructed from crates, and a tall, thin shape behind it - a lizan, by the looks of his build and smooth scales.  Something about his shape makes you feel uneasy, though... you shift further in to take a closer look at the stall owner.  He's seated in the only area of his shop not taken up by junk, right next to a heap of rugs and robes, and has a fez perched on top of his blunt head.  It's when he turns his grey slit eyes to you that you realize what is putting you on edge - it's a basilisk!  Panic grips you as you try to wrench your eyes away... which you do, easily.  Curious despite yourself, you look back tentatively.  The creature's eyes seem oddly milky, and they seem to be staring beyond you.  Realisation takes hold when you see the white stick balanced carefully on the counter's side.");
		output("\n\n\"<i>Yes, go ahead, stare,</i>\" says the basilisk in a long-suffering tone, making you jump. \"<i>It is a funny joke, yes?  Believe me, I wake up laughing about it every morning.  At least here zey stare.  In ze mountains, zey are so embarrassed zey can't even look at me.  Or at least I assume zey can't.</i>\"  He straightens his back and sets his jaw.  \"<i>'Owever, my slack-jawed friend, zis is not a freak show.  Zis is Benoit's Spectacular Salvage Shop!  So if you are not 'ere to buy or sell salvage... kindly piss off.</i>\"");
		
		output("\n\nYou wonder how a blind anything can make it in such a rough and ready place as the Bazaar, but then Benoit curls [benoit.hisHer] claws protectively into what appears to be a pile of robes sitting next to [benoit.himHer], which opens dark brown eyes and sets its muzzle on the counter, looking at you plaintively.  The Alsatian buried within the cloth looks to you like a big softy, but you're willing to concede the point as made.");
	}
	else if(Flag("COC.BENOIT_SUGGEST_UNLOCKED") == 0 && pc.hasVagina() && (pc.hasStatusEffect("Heat") || pc.hasPregnancyOfType("CoCOviElixEggs") || pc.hasPerk("Harpy Womb") || pc.hasPerk("Oviposition")) && (pc.hasPregnancyOfType("CoCOviElixEggs") || !pc.isPregnant()) && (int(flags["COC.BENOIT_STATUS"]) == 0 || int(flags["COC.BENOIT_STATUS"]) == 3)) {
		benoitAndFemPCTalkAboutEggings();
	}
	else if (Flag("COC.FEMOIT_NEXTDAY_EVENT_DONE") == 1 && Flag("COC.FEMOIT_NEXTDAY_EVENT") <= days && int(flags["COC.BENOIT_STATUS"]) == 0)
	{
		femoitNextDayEvent();
	}
	else if (benoitInClutch() && Flag("COC.FEMOIT_READY_FOR_EGGS") == 0 && (int(flags["COC.BENOIT_STATUS"]) == 1 || int(flags["COC.BENOIT_STATUS"]) == 2))
	{
		Flag("COC.FEMOIT_READY_FOR_EGGS", 1, true);
		
		output("As you enter the stall Benoite looks up; though her blind, milky eyes make her harder to read, she looks excited. \"<i>Ah! [pc.name]; it iz good you are here... I had hope zat you would come for a vizit today.</i>\"");

		output("\n\nShe stands up somewhat nervously, and you realize that her stomach is visibly bulging, her typical outfit straining slightly to cover the bulk of her midriff. She pats it with a timid sense of pride. \"<i>I am wiz clutch. My womb, it haz created eggz, and zey are ready to be fertilized.  I... I could be a mother now. I-if I could find myzelf a willing partner...</i>\" She trembles, despite herself; it's clear that the idea of going from lone male to expectant mother in the space of a few days is a bit much for the basilisk.");

		output("\n\nYou ask if she's sure she's ready for this. Benoite stiffens her spine and draws herself up proudly. \"<i>I am ready. If it is your nerve zat is weak, well... I will be with eggs for anozer few days. After that, I won't be wizzem again for zome weeks. I can wait until you are ready, if you need.</i>\"");
	}
	else if (benoitPreggers() && Flag("COC.FEMOIT_INCUBATION") < 0)
	{
		// Missed it by a week
		if (Flag("COC.FEMOIT_INCUBATION") < -168)
		{
			output("When you enter the stall, you notice that Benoite's stomach is flat again. She gives you a toothy grin when you enter her stall. \"<i>I have good newz [pc.name]! You are a fazer! " + String(benoit.eggs) + " timez over in fact! Oh I wish zat you could have helped; but I was ztrong, ztrong enough get through it on my own.</i>\" she gushes, speaking at a mile-a-minute. She's clearly pleased with herself; and your virility.");

			output("\n\nShe takes a moment to compose herself, still giddy with the prospect of potentially finding the answer that could save her people; although the means might not be quite what she had in mind, she seems to be taking to the situation with gusto.");

			output("\n\nThe world continues on though, and she has a shop to run after all; especially if she wants to provide for the hungry mouths that will soon demand her attention.");

			output("\n\n\"<i>Zo [pc.name],</i>\" she starts, still a hint of excited energy prevalent in her voice, \"<i>what can Benoite azzist you wiz?</i>\"");

			clearBenoitPreggers();
			flags["COC.FEMOIT_NEXTDAY_EVENT"] -= 7;
		}
		else
		{
			femoitBirths();
		}
	}
	else if (!benoitInClutch() && !benoitPreggers() && (days - Flag("COC.FEMOIT_NEXTDAY_EVENT") >= 30) && (int(flags["COC.BENOIT_STATUS"]) > 0))
	{
		if (flags["COC.FEMOIT_FIRST_CLUTCH_MISSED"] == undefined)
		{
			flags["COC.FEMOIT_FIRST_CLUTCH_MISSED"] = 1;
			output("When you enter the stall, you are greeted by the smell of something cooking. Investigating further brings you to the blind basilisk's small kitchen, where she is busy frying something. Her nose preoccupied with her meal, she doesn't realize you're approaching until you touch her shoulder, yelping in shock.");

			output("\n\n\"<i>Don't do zat!</i>\" she complains when she recognizes it's you. \"<i>I almost brained you with zis skittle.</i>\"");

			output("\n\nYou ask her what she's making.");

			output("\n\n\"<i>My lunch; an omlette,</i>\" she says.");

			output("\n\nYour eyes are drawn almost magnetically to her now flat-again stomach and the realization sinks in just where she got the eggs. You ask how she could have done such a thing.");

			// output("\n\n\"<i>What? Zey were never fertilised, so, waste not want not.</i>\" she shrugs. When you protest that they could have been her children, she gives you a blank look - though you imagine being blind helps a lot in that regard. \"</i>The, how you say, groinal bleeding of mammal girls could have been their children too; do they get upset about it?</i>\" she asks as a hint of mischievousness sneaks into her smirk. \"<i>Want some?</i>\" she innocently asks, offering you the skillet.");

			output("\n\n\"<i>Do what exza- oh. Ooh. Aha, mon Dieu, [pc.name]!</i>\" Benoite chokes out between a mix of chortles and guffaws. \"<i>Non [pc.name], I know what it iz zat you are zinking. Aha,</i>\" she continues whilst still half laughing, but manages to calm herself down after a short pause, trying to return to some degree of seriousness. \"<i>I am just hungry. I am, how you say, having a craving for zees strange items one of my zuppliers has been selling lately. 'Cheeken eggz'? I guess my body knowz what it needs to replenish zat which it has lost?</i>\"");

			output("\n\nShe pats her midriff and you start to put the pieces together. \"<i>Oh. Oooh,</i>\" you mumble back as a response.");

			//output("\n\nYou turn her offer down and explain you came here for something else.");
		}
		else
		{
			output("The flat-bellied basilisk is tucking away into a plate laden with a heavy omlette when you arrive.");
			output("\n\n\"<i>Ah, [pc.name]! What can I azzist you wiz?</i>\"");
		}
	}
	else
	{
		//Subsequent Visit, Affection 0-10: 
		if(benoitAffection() <= 10) output("Once again, you carefully enter the gloom of Benoit's salvage shop.  The proprietor sniffs the air as you enter, and then looks at you sourly.  \"<i>Well?</i>\" [benoit.heShe] rasps.");
		//Benoit reacts after fucking the PC.
		else if(Flag("COC.BENOIT_TIMES_SEXED_FEMPCS") == 1 && Flag("COC.BENOIT_POST_FIRSTFUCK_TALK") == 0)
			firstTimeAfterBoningEncounterBenoit();
		else if(benoitAffection() < 35) output("Once again, you carefully enter the gloom of Benoit's salvage shop.  The proprietor sniffs the air as you enter, and then relaxes in [benoit.hisHer] seat.  \"<i>Allo again, " + pc.short + ".  What brings you 'ere?</i>\"");
		//Subsequent Visit, Affection 35+ but pre-lover/pre-fem: 
		else
		{
			output("Once again, you carefully enter the gloom of [benoit.short]'s salvage shop.  The proprietor sniffs the air as you enter, and then smiles widely.  \"<i>If it isn't my favorite customer!  Do not 'ang around out zere, [pc.name]; please, come in and let us, 'ow you say, chew ze fat.</i>\"");

			// Preggers stuff
			if (benoitInClutch() && !benoitPreggers()) output("\n\nAn obvious bulge in the female basilisk's apron-clad belly signals the presence of new eggs. If you were to have sex with her in this state then there's a good chance she'll end up with a belly full of fertilized eggs.");
			else if (benoitRegularPreggers()) output("\n\nThe basilisk's belly bulges out, big as any pregnant woman back home. Her apron merely highlights the fact she's carrying the eggs you fathered.");
			else if (benoitHeavyPreggers()) output("\n\nBenoite's pregnancy is unmistakable, and the number of eggs she's carrying is quite impressive. Her apron is strained to the limit to contain her distended belly, and you wonder how she manages to tie it up each morning.");
			else if (benoitVeryHeavyPreggers()) output("\n\nThe basilisk's belly is hugely swollen with fertilized eggs, and you notice that she tries to avoid moving unless she has to. She's so bloated that she has given up trying to tie her apron on, and instead lets it flap idly on her engorged midriff.")
			else if (benoitExtremePreggers()) output("\n\nYou can hardly believe just how pregnant Benoite is - you wouldn't have imagined it was possible to carry that many fertilized eggs. She's practically immobile, and when she does get up and shuffle along, her belly nearly drags along the ground; it's that swollen with your young. Needless to say, practicality demands she goes around naked.");
		}
	}

	IncrementFlag("COC.TIMES_IN_BENOITS");
	if (Flag("COC.BENOIT_LAST_RESTOCK") != days) updateBenoitInventory();
	shopkeep = benoit;

	//Core buttons
	addButton(0, "Buy", benoitsBuyMenu);
	addButton(1, "Sell", benoitSellMenu);
	addButton(2, "Talk", talkToBenoit);
	addButton(14, "Leave", enterTheBazaarAndMenu);
	
	if (Flag("COC.BENOIT_SUGGEST_UNLOCKED") > 0) {
		if (pc.hasCock() && pc.lust() >= 33) addButton(5, "Suggest", eggySuggest);
		else addDisabledButton(5, "Suggest", "Suggest", "This option requires you to have vagina and sufficient arousal.");
	}
	
	if (Flag("COC.BENOIT_PISTOL_BOUGHT") != 1)
		addOverrideItemButton(10, new CoCFlintlockPistol(), "Flintlock", buyFlintlock);
	
	//Feminize & Herminize
	if (Flag("COC.FEMOIT_UNLOCKED") == 1 && int(flags["COC.BENOIT_STATUS"]) == 0) addButton(3, "Feminize", benoitFeminise);
	if (int(flags["COC.BENOIT_STATUS"]) > 0 && int(flags["COC.BENOIT_STATUS"]) < 3) addButton(3, "Herminize", benoitHerminise);
	//Basilisk Womb
	if(Flag("COC.BENOIT_WOMB_TALK_UNLOCKED") == 1 && !pc.hasPerk("Basilisk Womb") && Flag("COC.BENOIT_TESTED_BASILISK_WOMB") == 0 && int(flags["COC.BENOIT_STATUS"]) == 0) addButton(4, "Basil. Womb", tryToConvertToBassyWomb);
	
	if (int(flags["COC.BENOIT_STATUS"]) > 0)
	{
		if (pc.hasCock() && pc.lust() >= 33) addButton(6, "Sex", femoitSexIntro);
		else addDisabledButton(6, "Sex", "Sex", "This option requires you to have cock and sufficient arousal.");
	}
}

//Buy or Sell First Time, only if prelover/prefem: You ask him what the deal is with his shop.
private function buyOrSellExplanationFirstTime(next:Function):void {
	clearOutput();
	flags["COC.BENOIT_EXPLAINED_SHOP"] = 1;
	output("\"<i>If you can see something you want in Benoit's Spectacular Salvage Shop, and you can walk away with it, it's yours,</i>\" replies Benoit, theatrically sweeping his claw to take in the entirety of his stall but almost knocking over a birdcage.  \"<i>Assuming you can pay whatever I've decided it's worth, of course.  If you want to unload your garbage 'ere?  Zis is also fine.  I cannot pay what ze fat cats in Tel'Adre can, though.  Check back every day; ze Spectacular Salvage Shop always 'as new zings to sell.</i>\"");
	addNextButton(next);
}

public function benoitsBuyMenu():void {
	if (flags["COC.BENOIT_EXPLAINED_SHOP"] == undefined) {
		buyOrSellExplanationFirstTime(benoitsBuyMenu);
		return;
	}
	
	buyItem();
}

private function benoitSellMenu():void {
	if (flags["COC.BENOIT_EXPLAINED_SHOP"] == undefined) {
		buyOrSellExplanationFirstTime(benoitSellMenu);
		return;
	}
	
	sellItem();
}

//All slots are reset each day.  Benoit buys items at 66% the rate Oswald does.  
public function updateBenoitInventory():void {
	benoit.inventory = [];
	
	//Slot 1 Any one of the following: Incubus Draft, Minotaur Blood, Minotaur Cum, Equinuum, Black Pepper, Vitalitea, Scholar's Tea, Double Pepper
	var item:Class = RandomInCollection(CoCIncubiD, CoCMinotaurBlood, CoCMinotaurCum, CoCEquinum, CoCCaninePepperBlack, CoCScholarsTea, CoCVitalityTincture, CoCCaninePepperDouble, CoCBeeHoney, CoCGodMead);
	if (item == CoCBeeHoney && rand(3) == 0) item = CoCBeeHoneyPure;
	
	benoit.inventory.push(new item());
	
	//Slot 2 Any one of the following: Succubus Milk, Whisker Fruit, Wet Cloth, Golden Seed, LaBova, Snake Oil, Pink Gossamer, Black Gossamer
	item = RandomInCollection(CoCSucMilk, CoCWhiskerFruit, CoCGoldenSeed, CoCLaBova, CoCSnakeOil, CoCSweetGossamer, CoCBlackGossamer, CoCDrakeHeart); // TODO: Wet Cloth
	
	if (rand(100) < 4) {
		//There is a 4% chance the following items will appear in Slot 2: Bimbo Liqueur, Large Pink Egg, Large Blue Egg, Bro Brew, T. Shark Tooth.
		item = RandomInCollection(CoCBimboLiqueur, CoCBroBrew, CoCPinkEggLarge, CoCBlueEggLarge); // TODO: T. Shark Tooth.
	}
	
	benoit.inventory.push(new item());
	
	//Slot 3 Any one of the following: Maid's Clothes, Wizard Robes, Tough Silk, Slutty Swimwear, Goo Chunk, Chitin Plate
	item = RandomInCollection(CoCWizardRobes, CoCSluttySwimwear, CoCGreenGel, CoCBlackChitin, CoCToughSpiderSilk); // CoCDragonScale? nope
	
	//There is a 10% chance the following items will appear in Slot 3: Bondage Straps, Nurse Outfit, Red Party Dress
	if (rand(10) == 0) {
		item = RandomInCollection(CoCBondageStraps, CoCNurseOutfit);
	}
	benoit.inventory.push(new item());
	//Slot 4 Herbal Contraceptive - 30 gems.  Only becomes available through PC fem path.  Reduces fertility by 90% for a week if taken.
	
	flags["COC.BENOIT_LAST_RESTOCK"] = days;
}

private function buyFlintlock():void {
	clearOutput();
	output("You wander [benoit.short]'s shop for a good while as you're searching for something interesting until you spot something interesting.");
	output("\n\nYou walk over to pick up whatever caught your attention and show it to [benoit.short].  \"<i>Zis?  I do know that zis a weapon and it originally belonged to a goblin from long time ago,</i>\" [benoit.heShe] says.");
	output("\n\nTime to test this weapon out.  You aim the pistol at one of the empty tin cans and pull the trigger.  A round launches from the pistol and hits the tin can, knocking it off shelf.  [benoit.short] looks in surprise and says, \"<i>It works?  500 gems and it can be yours.</i>\"");
	output("\n\nDo you buy the gun?  ");
	clearMenu();
	addButton(0, "Yes", buyFlintlockConfirmation);
	addButton(1, "No", benoitsBuyMenu);
}
private function buyFlintlockConfirmation():void {
	clearOutput();
	if (pc.credits < 5000) {
		output("You count out your gems and realize it's beyond your price range.");
		clearMenu();
		addButton(0, "Next", benoitsBuyMenu);
		return;
	}
	output("\"<i>Here you go.  I have no need for zis,</i>\" [benoit.short] says.");
	Flag("COC.BENOIT_PISTOL_BOUGHT", 1);
	//flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = 4;
	pc.credits -= 5000;
	
	itemScreen = benoitsBuyMenu;
	lootScreen = benoitsBuyMenu;
	useItemFunction = benoitsBuyMenu;
	itemCollect([new CoCFlintlockPistol()]);
}

//Talk
private function talkToBenoit():void {
	clearOutput();

	//(+5 Affection per day if used)
	if(int(flags["COC.BENOIT_TALKED_TODAY"]) != days) {
		flags["COC.BENOIT_TALKED_TODAY"] = days;
		benoitAffection(5);
	}
	//Basilisk Womb
	//Requires: Had sex with Benoit at least twice, have vagina, select talk
	if(benoit.hasCock() && ((flags["COC.BENOIT_TIMES_SEXED_FEMPCS"] > 2 && pc.IQ() >= 60 && int(flags["COC.BENOIT_WOMB_TALK_UNLOCKED"]) == 0) || int(flags["COC.BENOIT_TIMES_SEXED_FEMPCS"]) == 2) && pc.hasVagina()) {
		output("You ask [benoit.short] if [benoit.heShe] has ever thought about trying to do something to help his people's plight.");
		
		output("\n\nThe basilisk is silent for a time, running his claws along the counter pensively.  \"<i>Yes,</i>\" [benoit.heShe] says eventually, in a quiet tone.  \"<i>I 'ave.  Away from ze mountains, I 'ave 'ad time to sink.  I am not ze demons' slave anymore, and I am a funny joke of a basilisk anyway, so I 'ave often thought about... making certain zacrifices.  If we 'ad just one female, away from zeir corruption, zen...</i>\" [benoit.heShe] trails off, sighing heavily before smiling ruefully at you.  \"<i>Zose were ze kind of soughts I 'ad before I met you.  Crazy, yes?  Even more crazy to be still sinking zem when a good woman is giving me 'er love for no reason except through ze kindness of 'er 'art.  Still... it is so frustrating, being able to sink clearly about zese sings and not being able to do anysing about it.</i>\"");
		
		if(pc.IQ() >= 60) {
			output("\n\nYour mind wanders.  You doubt that even if you wanted to you could turn into a basilisk proper, but you wonder if there's some kind of transformation that would allow a human womb to mimic that of another race.");
			output("\n\nBenoit answers warily.  \"<i>A double dose of ovi-elixer, a bottle of reptilum, goblin ale and some basilisk blood would probably do... if you were so minded.  But, [pc.name], tell me you're not going to do somesing so reckless as experiment on your body?</i>\"");
			//toggle on "Bas. Womb" from benoit's main menu.
			flags["COC.BENOIT_WOMB_TALK_UNLOCKED"] = 1;
			output("\n\n(<b>Basilisk Womb option enabled in Benoit's menu!</b>)");
		}
		else {
			output("\n\nYou rack your brain but can't think of anything that could help Benoit, so you end up simply sympathising with [benoit.himHer].  \"<i>Do not beat yourself up over it,</i>\" says the basilisk, touching the tips of your fingers and smiling warmly.  \"<i>It is just foolishness.  And anyway, I told you: we are a race of bastards.  We are ze last guys who deserve someone sinking after us.</i>\"");
			//don't trigger event again until the PC is smart enough!
		}
		addNextButton(function():*{ processTime(5 + rand(2)); enterTheBazaarAndMenu(); } );
	}
	//First time Talk: 
	else if(int(flags["COC.BENOIT_TALKED_TO_PROPERLY"]) == 0) {
		flags["COC.BENOIT_TALKED_TO_PROPERLY"] = 1;
		output("You take a moment to look the strange merchant over.  Although blind, [benoit.heShe] doesn't seem very old - [benoit.heShe] retains the tight, thin muscular frame of other basilisks you've seen, but looks to be slightly shorter and for all his proud, cruel profile seems slightly shabby around the edges.  In what is presumably a nod towards civilized manners, [benoit.heShe] is wearing a pair of denim long johns as well as his fez, perched upon one of his head spines.  You introduce yourself, and then decide to ask [benoit.himHer] about basilisks.");
		
		output("\n\n\"<i>We were a proud race once,</i>\" sighs Benoit.  \"<i>A noble race, who carried our 'eads 'igh, and...</i>\" the blind basilisk bursts into throaty laughter, which eventually subsides into a coughing fit.  You watch, bemused.  \"<i>Hahaha!  Aha.  Sorry.  No, we were always a race of egg-thieving bastards.  The lizans,</i>\" [benoit.heShe] flicks his snout in the general direction of the bonfire with disdain, \"<i>absolutely 'ate us.  Zey drove us to live in ze mountains, far away from zeir precious clutches, to live like savages.  'Ze family with ze evil eye over it', zat's what zey call us.  Eh... in basilisk it's more snappy.</i>\"  Benoit pauses, running his fingers over the counter ruminatively.  \"<i>But it wasn't so bad, up zair.  We kept ze harpies under control, and we collected scrap, sold it to zose who were brave enough to trade blindfolded.  We've always been good at zat.  Zen ze demons came to ze mountains.</i>\"");
		
		output("\n\nHe shrugs. \"<i>What were we going to do?  Go down and throw ourselves on the mercy of the races 'oo despise us?  Ze demons offered to set us high in zeir service, augment our natural abilities if we agreed to help zem.  I suppose zey did, at zat.</i>\"  Benoit scratches a long groove in his counter, trembling with anger.  \"<i>By making us all male zey made sure we are always fixated on finding egg bearers, on keeping ze harpies down, and bringing scrap and statues to zem so zey don't do anysing worse to us.  We are just a brainless natural defence to zem now, in zeir mountain hideaways.  Don't go up ze mountain or ze evil basilisks will get you!  Bastards.  Bastards.</i>\"  Benoit finishes mutilating the wood in front of [benoit.himHer] and sighs.  \"<i>But zat is by ze by.  Are you going to buy sumsing or not?</i>\"");
	}
	// First time Femoit talk
	else if (int(flags["COC.FEMOIT_TALKED_TO"]) == 0 && int(flags["COC.BENOIT_STATUS"]) != 0)
	{
		IncrementFlag("COC.FEMOIT_TALKED_TO");
		output("You ask Benoite if she intends to go back to the mountains now.  She laughs long and hard at this.  One thing the transformation has certainly gifted her is an extraordinarily filthy laugh.");

		output("\n\n\"<i>Oh [pc.name], you are so silly,</i>\" she says fondly.  \"<i>'Ow long do you sink a blind female basilisk would last up zair, eh?  If I was really lucky ze minotaurs would get me before ze demons did.  No, I will stay ere.  Ze uzzer basilisks, I cannot trust zem - zey are always exposed to ze corruption, some of zem even like it.  I will lay eggs far away from zere, I will raise my children to be different; away from ze corruption and with equal numbers of males and females, it will be different.  Zere are many empty places in zis world now zey can go to and be left alone.</i>\"  She pauses. \"<i>Or at least zese sings will 'appen once I work up ze courage to find a, er, donor.</i>\"");

		if (!pc.hasCock())
		{
			output("You ask if she's had any thoughts on that front.  \"<i>Not really,</i>\" Benoite sighs.  \"<i>I 'ave many male customers but zey all 'ave - 'ow you say? Rough round edges.  You now 'ow it is, [pc.name], all men are pigs.</i>\"  You both laugh at this.  \"<i>I will find someone though, don't worry.  As I said before...</i>\" she points two fingers at her blind eyes and then at the stall entrance.  There's a distinct gleam in those cloudy grey depths you think would scare the hell out of most things with a penis.  \"<i>I 'ave a purpose now.</i>\"");
		}
		else
		{
			output("\n\nYou ask if she's had any thoughts on that front. \"<i>Well, I do 'ave zis one customer 'oo seems very kind.  And 'oo knows me a great deal better zan anyone else around 'ere,</i>\" Benoite mumbles, twiddling her fingers.  \"<i>But zis person 'as already done a great deal for me, so I don't know if... per'aps zis is asking too much. I will find someone though, never fear.  As I said before...</i>” Benoite points two fingers at her blind eyes and then at the stall entrance.  There’s a distinct gleam in those cloudy grey depths you think would scare the hell out of most things with a penis. “<i>I ‘ave a purpose now.</i>");

			clearMenu();
			addButton(0, "Yes", femoitFirstTimeYes);
			addButton(1, "No", femoitFirstTimeNo);
			return;
		}
	}
	else if (int(flags["COC.BENOIT_TALKED_TO_PROPERLY"]) != 0 && benoitAffection() >= 40 && (int(flags["COC.BENOIT_TIMES_SEXED_FEMPCS"]) == 0 || !pc.hasVagina()) && int(flags["COC.FEMOIT_UNLOCKED"]) == 0)
	{
		femoitInitialTalk();
		clearMenu();
		addButton(0, "Next", enterTheBazaarAndMenu);
		return;
	}
	//Subsequent Talk
	else {
		var choice:int;
		
		/* BUILD ZE CHOICES!*/
		var choices:Array = [0,1,2,3,4,5,6,7,8];
		//option 9 is non-lover non-fem only
		if(!benoitLover() && !benoit.hasVagina()) choices[choices.length] = 9;
		//Special male benoit fucker only talks
		if(benoitLover() && !benoit.hasVagina() && pc.hasVagina()) {
			choices[choices.length] = 10;
			choices[choices.length] = 11;
			choices[choices.length] = 12;
			choices[choices.length] = 13;
		}
		// Femoit specials
		if (int(flags["COC.BENOIT_STATUS"]) != 0)
		{
			choices.push(14);
			choices.push(15);
			if (benoitLover()) choices.push(16);
		}
		//trace("BENOIT CHOICE: " + choice);
		//Pick one and go!
		choice = choices[rand(choices.length)];
		//(Randomly generated)
		if(choice == 0) {
			output("You ask if all basilisks talk as [benoit.heShe] does.");
			output("\n\n\"<i>Only on zis side of ze mountain,</i>\" comes the reply.  \"<i>Ze uzzer side are all stuck-up snobs who speak 'orribly.  Zey are all pale and flabby too, and zeir cooking is terrible.  Pwah!</i>\"  [benoit.HeShe] makes an exasperated gesture with a claw.");
		}
		else if(choice == 1) {
			output("You ask [benoit.short] about the dog.");
			output("\n\n\"<i>Pierre 'asn't been giving you trouble, as 'e?  Big stupid mutt does not know 'is mouth from 'is arse.  Which is why 'e checks so often,</i>\" says the basilisk fondly, rubbing the Alsatian behind his ear.  \"<i>I found 'im prowling around eating scraps from ze food sellers when I first got ere; I sink 'e must 'ave belonged to anuzzer trader 'oo left [benoit.himHer] behind.  I do not sink I could run this shop without him - every evening I go out into the wilds with him and 'unt down more salvage.  'Ee is so good at finding perfectly good sings other people 'ave left behind.  Particularly cloze.  'E loves robes, Pierre.  Don't you, boy?</i>\"  Pierre whines.");
		}
		else if(choice == 2) {
			output("You ask [benoit.himHer] about the sign above the shop.");
			output("\n\n\"<i>It's good, isn't it?</i>\"  the trader says proudly.  \"<i>I got a catguy to do it when I first got 'ere and didn't know ze language so well.  'E suggested...</i>\"  [benoit.HeShe] spreads [benoit.hisHer] claws expressively.  \"<i>'Salamander's Salubrious Salvage'.  Because, everyone likes salamanders, and once zey get in and realize I am not a salamander and it is just a play on words, zey would be so entranced by what I am selling zey would not care.</i>\"  [benoit.short] taps the counter happily.  \"<i>In gold print, too!  It is a surprise it has not brought more customers in.</i>\"");
			output("\n\nYou decide not to disillusion the blind basilisk.");
		}
		else if(choice == 3) {
			output("You ask if [benoit.heShe] has always been blind.");
			output("\n\n\"<i>I don't know,</i>\" [benoit.heShe] says. \"<i>Ask me what red is.</i>\"");
			output("\n\nYou ask what red is.");
			output("\n\n\"<i>'Ow ze fuck should I know?</i>\" the basilisk replies, deadpan.  \"<i>Stop asking stupid questions.</i>\"");
			output("\n\nYou decide not to pursue the subject.");
		}
		else if(choice == 4) {
			output("You ask [benoit.short] how [benoit.heShe] got into this line of work.");
			output("\n\n\"<i>I 'ave always worked with salvage,</i>\" [benoit.heShe] shrugs.  \"<i>Back in ze mountains I worked in ze magpie room - obviously, because I was no good on ze outside.  You can tell from ze weight of sings, and 'ow zey smell, what it is and 'ow much it is worth.  More zan zat you can tell... what it meant to its last owner.  Zat is ze true worse of an object.</i>\"  [benoit.HeShe] taps his claws on the counter, lost in thought.  \"<i>Ze magpie room is amazing, [pc.name], I wish I could show it to you.  Such good acoustics, filled with ze sound and smell of a thousand pieces of junk - every day a new symphony.  And 'oo would ever steal ze demons' treasures?  You would 'ave to be mad to try to steal from a hall full of basilisks.  Or blind.</i>\"");
			output("\n\n[benoit.HeShe] laughs throatily, then sighs.  \"<i>Ah, but it was rotten, really - always a sour note underneath everysing.  A thousand basilisks, driven by nussing but greed and lust.  I got sick of it, being stuck in zat place with zose thoughts, zat 'opeless cycle, and one day ran away.  I took what I could carry and used zat to start up here.  Away from ze mountains, I can zink clearly.  I can say what ze uzzer basilisks only know at ze back of zeir minds.</i>\"  [benoit.short] slams a fist into the counter, making you jump.  \"<i>Don't ever make a deal with a demon, [pc.name],</i>\" [benoit.heShe] says, voice thick with rage.  \"<i>Even when you sink it is a win-win?  Zey will still find a way to fuck you good.</i>\"");
			pc.cor( -1);
		}
		else if(choice == 5) {
			output("You ask Benoit if [benoit.heShe] can tell you anything about the Bazaar.");
			
			output("\n\n\"<i>You are really asking zis question to a blind person?</i>\" comes the reply.  \"<i>Ok, I will tell you what I know, for what it is worth.  Over zeir by ze fire, I know zeir are lizans having a good time, because zey shout insults when zey get really drunk.  Zey would get violent with me I sink, if it weren't for Pierre.  Zeir leader has a big problem with her male hormones, judging from ze way she smells.</i>\"  [benoit.HeShe] sniggers with a distinct lack of sympathy.  \"<i>In ze uzzer direction, I can smell a lot of males together in one place.  Smell like zey are doing something very macho - and a bit painful, from ze sound of zeir walk afterwards.</i>\"  [benoit.HeShe] points in the opposite direction.  \"<i>Zerr are plenty of, ow you say, crumpets who work around here.  Some of zem can do some pretty wild sings for you, for a fee.  Or so I'm told.</i>\"  [benoit.HeShe] coughs.");
		}
		else if(choice == 6) {
			output("You ask [benoit.short] for any rumors going around.");
			//[Deep cave cleared: 
			if(flags["COC.DEFEATED_ZETAZ"] > 0) output("\n\n\"<i>Somesing strange did 'appen ze uzzer day, now you mention it,</i>\" [benoit.heShe] says, tapping a curved tooth.  \"<i>I got a big group of imps in ere.  I normally don't serve zem because zey are always stealing sings whilst one of zem is paying, but zese guys seemed too worked up to even sink about lifting ze shop - zey smelt of fear.  Zey were buying lots of food and survival gear - one of zem kept going on and on about ze fact zey left \"<i>ze fairy</i>\" behind, until one of ze uzzers slapped 'im and said if 'ee didn't shut up, 'ee would be ze fairy.</i>\"  [benoit.short] shrugs.  \"<i>Nasty little sings.  Tasty, though.</i>\"");
			//[Factory not cleared: 
			else if(!(flags["COC.FACTORY_SHUTDOWN"] > 0)) output("\n\n\"<i>Not anysing very interesting,</i>\" [benoit.heShe] shrugs.  \"<i>I get a few customers from ze desert city, Tel'Adre, coming in 'ere in secret to pick up a few sings zey cannot find back 'ome.  So zey are still a sing.  You 'ave to wonder ow much longer zey can keep hiding, though.</i>\"");
			else {
				//[Factory destroyed: 
				if(flags["COC.FACTORY_SHUTDOWN"] == 2){
					output("\n\n\"<i>I don't know what is 'appening exactly,</i>\" [benoit.heShe] says, leaning over the counter. \"<i>But ze demons 'oo I trade with, zey seem very worked up about sumsing.  Sumsing went wrong at one of zeir facilities, I sink.  I also get a number of shark ladies coming in ere, asking if I sell fresh water.  Zey also seem very unhappy.</i>\"");
				}
				else output("\n\n\"<i>I don't know what is 'appening exactly,</i>\" [benoit.heShe] says, leaning over the counter.  \"<i>But ze demons 'oo I trade with, zey seem very worked up about somesing.  Sumsing went wrong at one of zeir facilities, I sink.  I also hear a number of passers-by talking about ze lake.  Apparently it is much cleaner now; many are going back to use it for water.  Now if only someone could make zose crazy cultists go away, eh?</i>\"");
			}
		}
		else if(choice == 7) {
			output("You ask if [benoit.heShe]'s ever had any trouble with the demons who frequent the Bazaar.");
			output("\n\n\"<i>Not really,</i>\" [benoit.heShe] replies.  \"<i>I don't like zem, but zey are my main source of income.  Zey are always coming in here to sell zeir fluids.  The truth is it's worthless - I pour most of ze disgusting stuff away.  But it is worth paying for zeir custom because zey are always buying many more potions.  It isn't a good demon party unless you 'ave sprouted two new dicks and four new nipples for it, apparently.  Always one of zem is asking if zey can 'do ze dinosaur' as way of payment.  I 'ate zem so much.</i>\"");
			if(silly) output("\n\nThe basilisk rubs Pierre behind the ear as [benoit.heShe] thinks.  \"<i>I did once get a group of demons coming in ere, asking me what 'cheese omelette' is in basilisk.  When I told zem, zey ran away laughing, shouting 'Zat is all you can say! Zat is all you can say!'</i>\"  [benoit.HeShe] shrugs, irritated.  \"<i>Arseholes.</i>\"");
		}
		else if(choice == 8) {
			output("You ask [benoit.short] what results when basilisks mate with harpies.");
			output("\n\n\"<i>Most of ze time?  Basilisks,</i>\" [benoit.heShe] replies, carefully counting gems with [benoit.hisHer] fingers.  \"<i>Some of ze time?  'Arpies.  But ze arpies feed zeir basilisk children to zeir chicks if ze former do not get away in time, so it works out.  Really, we are doing zem and ze world a favor by stealing zeir eggs - if we weren't around ze 'ole world would be drowned in guano by now.</i>\"  Satisfied with the takings, [benoit.heShe] stows the money away underneath the counter.  \"<i>Very rarely, you get cockatrices.  Now ZEY are weird-looking.</i>\"");
		}
		else if(choice == 9) {
			//non-lover non-fem only
			output("You ask if [benoit.short] really can tell who you are just by smell.");
			
			if(pc.race() == "human") output("\n\n\"<i>Certainly!</i>\" [benoit.heShe] smiles.  \"<i>Ze smell of shaved monkey is distinctive.  I get very few 'uman customers, you know.</i>\"  The basilisk scratches [benoit.hisHer] jaw absent-mindedly.  \"<i>If you do not mind me saying so, [pc.name], you also smell... different.  Like you do not really belong 'ere.  In ze nicest possible way, of course.</i>\"");
			else output("\n\n\"<i>Certainly!</i>\" [benoit.heShe] smiles.  \"<i>Ze smell of shaved monkey is distinctive.  I get very few 'uman customers, you know.</i>\"  You look down at yourself, then back at the basilisk suspiciously, before saying you don't much look or feel human.  \"<i>Oh, I do not doubt zat,</i>\" says the trader.  \"<i>You 'umans and your flexible genes - zat makes you very alluring, as I am sure you 'ave already noticed, eh?  I am sure somebody 'oo relied upon sight would not be able to tell you are 'uman.  But 'oo you are underneath all zat, zat never changes, and I can smell zat.  All you are doing really is dressing up as something else.  If you wanted to, you could change back tomorrow, if you 'ad ze right ingredienns.</i>\"");
			//[(male Benoit only)
			if(!benoit.hasVagina()) output("  There's a hint of longing jealousy in the basilisk's voice and when [benoit.heShe] lapses into silence you decide not to push the subject.");
		}
		//Male Benoit Lover Talk options
		//(Randomly generated.  Added to normal talk options after PC has had sex with Benoit two times or more regardless of womb quest.)
		else if(choice == 10) {
			output("You ask Benoit there is anything useful [benoit.heShe] can tell you about the demon strongholds.");
			
			output("\n\n\"<i>I'm afraid I cannot be very 'elpful zeir, [pc.name],</i>\" [benoit.heShe] sighs.  \"<i>Unless you want me to tell you what zey smell like.  I do not sink you want to be knowing zis.  Ze demons, zey were not much in ze business of telling us what zeir plans were, and zey did not much like 'anging around us, which is understandable.   Zair is every treasure you can ever imagine in ze magpie room, but zeir is no way you could ever get at zem unless you could work out some way of making many undreds of basilisks close zeir eyes at once.</i>\"");
		}
		else if(choice == 11) {
			output("You ask Benoit if [benoit.heShe] can suggest anything to help you fight his brethren in the high mountains.");
			output("\n\n\"<i>You could carry a mirror with you,</i>\" [benoit.heShe] says, pointing.  \"<i>There's one over zair, isn't zair?</i>\" You report that it is cracked badly - at any rate, you're not carrying a bulky mirror up a mountain two or three times a day.  \"<i>I will give it to you half price,</i>\" [benoit.heShe] says hopefully.  \"<i>Sink 'ow useful it will be to check for transformations!  You could get somebody else to carry it for you... ok, alright, so you don't want ze mirror.  Most prey, my bruzzers are expecting zem to lash out in a panic.  So use sings which do not involve approaching.  We do not like magic or ranged sings, zey are too unpredictable - I suggest using zem.</i>\"");
		}
		else if(choice == 12) {
			output("\"<i>Gnoll.</i>\"");
			output("\n\n You make a gentle humming noise.");
			output("\n\n\"<i>Bee maiden,</i>\" says Benoit after a moment.");
			output("\n\nYou stamp your feet and snuffle and snort.");
			output("\n\n\"<i>Minotaur,</i>\" says Benoit immediately.  You sigh - [benoit.heShe]'s too good at this game, and you're running out of creatures.  Thinking briefly, you make a clop-clopping whilst slapping the counter, throwing in a bit of heavy breathing for good measure.");
			
			output("\n\n\"<i>What ze 'ell is zat supposed to be?</i>\" says Benoit, looking alarmed.  You tell him it's a ");
			output("Unitaur.");
			output("\n\n\"<i>A what?</i>\"");

			output("\n\nYou explain that a Unitaur is like a white centaur, only it has a horse's face.  It has massively strong human arms though, and it can cast magic better than anyone, and it can go faster than a cheetah, and... you can't help yourself and begin to giggle at the expression of terror that has emerged on Benoit's face.");
			
			output("\n\n\"<i>Oh, I see.  You are pulling my tail.  Very amusing.</i>\"  You laugh even harder at the expression of wounded dignity which replaces the terror.");
		}
		else if(choice == 13) {
			output("You ask Benoit if [benoit.heShe] really, <b>really</b> can tell who you are just by smell.");
			
			output("\n\n\"<i>Well, of course I can,</i>\" [benoit.heShe] says teasingly.  \"<i>When you end up smelling like someone else for several hours, it is a difficult sing to mistake.  It is a memento of you and it reminds me of 'appiness; I wish I could smell zat way for longer.  My sexy little shaved monkey.</i>\"");
		}
		else if (choice == 14)
		{
			output("You ask Benoite how she’s getting on with being the opposite sex.  Benoite stops cleaning the tarnished silver plate in her hands to think.");

			output("\n\n“<i>It is... different,</i>” she says eventually, before laughing at the platitude.  “<i>Ze ‘ole wizzing situation, zis is terrible for instance.  I do not know [pc.name], I am so busy during ze day and it ‘appened so suddenly, it is difficult to properly reflect.  Sometimes I am sinking somesing, like ‘ow somesing smells, and zen I catch myself sinking... would Benoit ‘ave sought zat? Is my perception different because I ‘ave different ‘ormones swirling around my ‘ead?</i>” She turns the plate around in her hands absently. “<i>Zerr are... uzzer sings, too.  Sometimes I am smelling a customer is finding me strange, and I realize I am doing somesing which is... male.  Like, somesing I would never ‘ave sought about before, walking with feet splayed instead of in a line.  A ‘undred and one sings to remember to not stand out.  Zat is wearying.</i>”");

			if (benoitLover() && pc.hasCock() && pc.hasVagina()) output("\n\nShe smiles shyly at you. “<i>I am very lucky in one respect zo, because I ‘ave not ‘ad to resink what I find attractive to lie wizz you.  Whatever you ‘ave between your legs you smell and feel female to me, and zat is a comfort.</i>”");
			else if (benoitLover() && pc.hasCock() && !pc.hasVagina())
			{
				output("She smiles shyly at you. “<i>One sing I ‘ave definitely ‘ad to resink is what I find attractive.  I did not find ze male form attractive before, so for my body to... respond... when you are close, zat is when I most feel ze disconnect between my experience and what I am now.  Per’aps zis is also why I ‘ave not sought about it too much; it is better just to rely on instinct.</i>”");
				output("\n\nCharming, you say.");
				output("\n\nBenoite grins wider at your affected hurt. “<i>Oh do not worry [pc.name], you ‘ave a beautiful personality.  And ow important exactly do you sink your personal appearance is to me?</i>”");
			}
			else
			{
				output("\n\nShe smiles shyly at you. “<i>Listen to me, ow you say, riveting on.  You I am guessing do not see what ze big fuss is- you ‘umans can chop and change whenever you feel like, so to speak.  Must be nice.</i>”");
				output("\n\nYou point out that your mutability is not always an advantage- it can be used against you, and this land is full of types who would be only too keen to do so.");
				output("\n\nBenoite nods thoughtfully. “<i>I never sought about it like zat.  Ze demons just love slaves zey can change wizzer a few potions, don’t zey? You are right [pc.name], I will count my blessings in ze future.</i>”");
			}
		}
		else if (choice == 15)
		{
			output("You ask Benoite if she isn’t worried that demon customers won’t notice what she is.");

			output("\n\n“<i>Zat is why I am wearing zis cunning disguise,</i>” she says, patting her large beret.  She lowers her voice to a growl. “<i>And I talk like zis when I am serving zem.  Grr.  To be honest I do not sink I ‘ave to be worrying much,</i>” she goes on in her normal tone, tightening her apron. “<i>Most of ze demons 'oo come 'ere are not very bright, zey are not very interested in anysing except when zey are next banging zair bits together.  Also I sink most mammals are 'aving trouble telling ze difference between male and female reptiles wizzout looking closely.  Am I right?</i>” She grins her long, meandering smile at you and you take her point.");
		}
		else if (choice == 16)
		{
			output("You ask Benoite if she really can tell who you are just by smell.");

			output("\n\n“<i>Well, of course I can, zilly,</i>” she says teasingly. “<i>When you end up smelling like someone else for several hours, it is a difficult sing to mistake.  It is a memento of you and it reminds me of appiness; I wish I could smell zat way for longer.  My sexy little shaved monkey.</i>”");
		}
	}
	processTime(10);
	clearMenu();
	addButton(0, "Next", enterTheBazaarAndMenu);
}


//Male Benoit x Female PC Interactions
//First talk
//Requires: PC has oviposition/ovi-elixered/in heat, Affection 35+
private function benoitAndFemPCTalkAboutEggings():void {
	flags["COC.BENOIT_SUGGEST_UNLOCKED"] = 1;
	output("[benoit.short] seems very on edge today.  [benoit.HeShe] paces up and down, returns your greeting with a stiff nod, and fiddles endlessly with the stock in reach of [benoit.hisHer] counter as you search for a topic.  You ask if there's something wrong.");
	
	output("\n\n\"<i>Nuzzing!</i>\" [benoit.heShe] barks angrily.  [benoit.HeShe] coughs.  \"<i>Nussing,</i>\" [benoit.heShe] says in a calmer tone.  You wait.  \"<i>It's just... ze way your body is right now,</i>\" [benoit.heShe] says eventually.  \"<i>It...speaks to me.  But zis is my problem,</i>\" [benoit.heShe] goes on, straightening [benoit.hisHer] neck and nervously tapping [benoit.hisHer] claws on the counter. \"<i>And I am not myself if I cannot control myself.  Please, [pc.name], ask your questions.</i>\" You look at the sad, proud basilisk and wonder when exactly the last time [benoit.heShe] got laid was.");
	
	output("\n\n(\"<i>Suggest</i>\" option added to [benoit.short]'s menu.)");
}

//Suggest: 
private function eggySuggest():void {
	clearOutput();
	if(flags["COC.BENOIT_TESTED_BASILISK_WOMB"] == .5) {
		suggestSexAfterBasiWombed(true);
		return;
	}
	if(flags["COC.BENOIT_TIMES_SEXED_FEMPCS"] > 0) {
		if(pc.isTaur()) {
			output("You silently reach across the counter to squeeze [benoit.hisHer] hands again.  [benoit.short] grins with deep affection at you and, hand in hand, the two of you quietly debunk to the store room again.");
			output("\n\nOnce again, you carefully inch your blind charge to a clear cranny and push [benoit.himHer] against a wooden wall, standing back to slowly peel off your [pc.gear].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit.himHer] to guess what it is by the sound it makes.  [benoit.HisHer] breathing comes heavier as your undergarments make a feathery sound as they fall.  As you take [benoit.hisHer] hands and lay them upon your naked [pc.skinFurScales], you think about how you want to go about this.");
		}
		else {
			output("You silently reach across the counter to squeeze [benoit.hisHer] hands again.  [benoit.short] beams at you and, hand in hand and without a word, the two of you depart to the store room again.");
		
			output("\n\nOnce again, you carefully inch your blind charge to a clear cranny and push [benoit.himHer] against a wooden wall, standing back to slowly peel off your [pc.gear].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit.himHer] to guess what it is by the sound it makes.  [benoit.HisHer] breathing comes heavier as your undergarments make a feathery sound as they fall.  As you take [benoit.hisHer] hands and lay them upon your naked [pc.skinFurScales], you think about how you want to go about this.");
		}
		clearMenu();
		addButton(0, "Let [benoit.HimHer]", repeatSexWithBenoitLetHim);
		addButton(1, "Take Charge", repeatBenoitFuckTakeCharge)
		return;
	}
	IncrementFlag("COC.BENOIT_TIMES_SEXED_FEMPCS");
	if(pc.isTaur()) { // WTF? taur scene is actually doubled, since non-taur one have taur chesks everywhere
		//Suggest: 
		output("You reach your fingers across the counter and lightly touch [benoit.short]'s hands, saying you don't mind working out a few natural urges, if [benoit.heShe]'s in the mood.");
		output("\n\n“You- I- what?” [benoit.heShe] replies, looking slightly stunned. “You don't? Are you...I don't know if...” you reach across and squeeze [benoit.short]'s hands until [benoit.hisHer] nervous babble dies out and hesitantly, [benoit.heShe] squeezes back.  Still holding [benoit.hisHer] hand, you move behind the crates and then gently lead [benoit.himHer] behind the stall's canopy.");
		output("\n\nWhat passes for [benoit.short]'s back office is perfect for your purposes; the two wagons between which [benoit.hisHer] stall is sandwiched close together here and the triangular space is filled with crates and unsorted salvage.  You carefully inch your blind charge to a clear cranny and push [benoit.himHer] against a wooden wall, standing back to slowly peel off your [pc.gear].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit.himHer] to guess what it is by the sound it makes.  [benoit.HisHer] breathing comes heavier as your undergarments make a feathery sound as they fall.");
		output("\n\n“Zis will sound strange,” says [benoit.short] in a thick voice, “But- would you mind if I just touched you a bit first? All I know about you is ze sound of your voice.”  You acquiesce and draw close, taking [benoit.hisHer] hands once again and gently laying them upon you.  You sigh as, holding [benoit.hisHer] index claws back, [benoit.heShe] begins to move them slowly up and down.");
		
		benoitExploresPc();
		
		// Herm: 
		if(pc.hasCock()) {
			output("\n\n[benoit.HisHer] hands travel down your behind until, with a sharp intake of breath, [benoit.heShe] touches [pc.oneCock].  “Aren't you just full of surprises,” [benoit.heShe] says dryly.  After a pause, [benoit.heShe] slowly wraps [benoit.hisHer] dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.");
			//[cock 10 inches or less: 
			if(pc.longestCockLength() <= 10) output("  Although this is evidently an uncanny experience for [benoit.himHer], [benoit.heShe] does manage a cocky smile as [benoit.hisHer] hand moves around your male sex. “Mine is bigger,” [benoit.heShe] teases.  Unable to reward [benoit.hisHer] cheek from where [benoit.heShe] is, you simply snort and shuffle your [pc.feet], impatient now with need.");
			//[cock  >10 inches: 
			else output("  This is evidently an uncanny experience for [benoit.himHer], the alien nature of it deepening as [benoit.hisHer] hands moves around your male sex. “Oly Gods [pc.name], you are a monster,” [benoit.heShe] says thickly.  You smile and stamp your [pc.feet], impatient now with need.");
		}
		output("\n\n[benoit.HisHer] hands trail upwards, moving over your bestial behind, exploring your soft flesh until [benoit.heShe] touches your lips.  You close your eyes and sigh as [benoit.heShe] slowly parts them with [benoit.hisHer] smooth fingers and slides into your [pc.vagina].  Although [benoit.hisHer] breath is becoming increasingly heavy [benoit.heShe] also seems genuinely curious about you; with surprising gentleness [benoit.hisHer] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit.heShe] does.  You let [benoit.himHer] know what pleases you by sighing when [benoit.heShe] touches a sweet spot, moving deliberately with [benoit.hisHer] finger's motions so [benoit.heShe] may give them better attention.  [benoit.HeShe] soon finds your [pc.clit], beginning to bulge with need; slowly [benoit.heShe] circles it and then flicks at it, gently frigging you.");
		//[In heat:]
		if(pc.hasStatusEffect("Heat")) output("  By now your vagina is practically gushing, your bodies' own deep seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration of your body.  You cannot stop thrusting yourself against [benoit.hisHer] soaked hand, announcing how badly you want this with heavy moans.");
			
		output("\n\nThe scent of your arousal is in the air and as [benoit.short] breathes it in [benoit.hisHer] own breath comes heavier.  [benoit.HisHer] erection bulges in [benoit.hisHer] long johns and you decide it's time for you to take charge; you back up, butting [benoit.himHer] insistently with your powerful body until you have [benoit.himHer] pinned against a space upon the opposite wall.  You watch [benoit.himHer] over your shoulder as [benoit.heShe] unbuckles himself and lets [benoit.hisHer] trousers fall.  Stoked by the pheromones simmering off your body, [benoit.hisHer] long, thin purple erection is straining and [benoit.heShe] arches [benoit.hisHer] back and opens [benoit.hisHer] mouth as you flare your [pc.butt] and press yourself against it.  You know just from looking at [benoit.hisHer] intense arousal you're going to have to go slow to stop [benoit.himHer] from shooting [benoit.hisHer] bolt straight away; with a wicked smile your partner can't see, you suppose such is your effect on [benoit.himHer] it may not even matter if [benoit.heShe] does.  Still, as [benoit.heShe] lays [benoit.hisHer] hands upon your flanks, and you lean back with a sigh and slowly slide [benoit.hisHer] length into your moistened [pc.vagina] as gently as you can.");
		pc.cuntChange(0, benoit.cockVolume(), true, true, false);
		output("\n\nBenoit's dick is incredibly smooth and you move down onto it with incredible, slick ease.  Rather than burying yourself onto it straight away you stop with only a third of it in your wet depths and slowly bring it out of you, dipping yourself slowly.  You stop with [benoit.hisHer] sensitive head just inside and work your [pc.hips] around deliberately, sighing as it rotates slowly around your slick walls.  [benoit.short] moans dryly and you feel [benoit.hisHer] body tense; immediately you stop your movements and wait, only gradually beginning to gyrate and thrust again when [benoit.heShe] has calmed down.  You slide more of [benoit.himHer] into you when you bend forwards again, this time leaving only [benoit.hisHer] base outside of you; you sigh as you feel [benoit.himHer] creeping further into your moist depths.  [benoit.HeShe] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit.himHer] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit.himHer].");
		
		//[Small capacity: 
		if(pc.looseness(0) <= 3) output("\n\nYou slide back down onto [benoit.himHer], cooing this time as you feel [benoit.himHer] bottom out with several inches of [benoit.himHer] still outside of you.  [benoit.HisHer] thin, long length could not be more perfect for your tight sex; [benoit.heShe] rubs your walls up and down as you dreamily thrust in and out of [benoit.hisHer] body, sending waves of pleasure flowing through you.");
		//Large capacity: 
		else output("\n\nYou slide back down onto [benoit.himHer], cooing this time as your groin meets [benoit.hisHer] muscled thighs with a wet kiss, your sex swallowing [benoit.hisHer] cock whole.  You begin to ride [benoit.himHer] hard and slow, bending [benoit.hisHer] cock upwards to push at your sensitive walls, waves of pleasure starting to flow through you.");
		
		output("\n\nYou keep at this slow ride for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit.short]; [benoit.heShe] pants, tenses and gasps to the wet movement of your [pc.vagina], [benoit.hisHer] face and chest red with extreme arousal, but [benoit.heShe] lets you stay in control, eventually unable to do anything but lie back and let you have your way with [benoit.himHer].");
		//[Lactation: 
		if(pc.lactationQ() >= 50) output("  The slow, sensual sex is enough for you to begin to bead milk from your sensitive [pc.nipples]; you moan as the flow intensifies until you are instinctively kneading your [pc.chest], spurting your sweet, warm fluids onto the floor.  [benoit.short] starts in genuine amazement at the sound.  “Mammals are so damn weird,” [benoit.heShe] mutters, making you giggle.");
		
		output("\n\nYour lust ratchets up as [benoit.hisHer] warm hands continue to move over your behind, and at last losing your discipline you begin to thrust into [benoit.himHer] with abandon, eager now for your peak.  [benoit.short] pants as you really begin to fuck [benoit.himHer] and thrusts with you; the wetness of your arousal spatters against [benoit.hisHer] thighs as your body slaps into the basilisk's tight muscles.  [benoit.HeShe] makes a harsh, bestial noise when [benoit.heShe] cums; [benoit.hisHer] blind eyes roll as [benoit.heShe] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit.hisHer] jizz and [benoit.hisHer] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal against the basilisk, clutching [benoit.himHer] back as you work [benoit.hisHer] dick for every last drop.");
		if(pc.isHerm()) output("  [pc.EachCock] thickens and spurts in sympathy to your female high, spattering the floor with [pc.cumColor] paint.");
	}
	else {
		output("You reach your fingers across the counter and lightly touch [benoit.short]'s hands, saying you don't mind working out a few natural urges, if [benoit.heShe]'s in the mood.");
		
		output("\n\n\"<i>You - I - what?</i>\" [benoit.heShe] replies, looking slightly stunned. \"<i>You don't?  Are you... I do not know if...</i>\"  You reach across and squeeze [benoit.short]'s hands until [benoit.hisHer] nervous babble dies out and hesitantly, [benoit.heShe] squeezes back.  Still holding [benoit.hisHer] hand, you move behind the crates and then gently lead [benoit.himHer] behind the stall's canopy.");

		output("\n\nWhat passes for [benoit.short]'s back office is perfect for your purposes; the two wagons between which [benoit.hisHer] stall is sandwiched close together here and the triangular space is filled with crates and unsorted salvage.  You carefully inch your blind charge to a clear cranny and push [benoit.himHer] against a wooden wall, standing back to slowly peel off your [pc.gear].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit.himHer] to guess what it is by the sound it makes.  [benoit.HisHer] breathing comes heavier as your undergarments make a feathery sound as they fall.");
		
		output("\n\n\"<i>Zis will sound strange,</i>\" says [benoit.short] in a low, thick voice, \"<i>But - would you mind if I just touched you a bit first?  All I know about you is your smell and ze sound of your voice.</i>\"  You acquiesce and draw close, taking [benoit.hisHer] hands once again and gently laying them upon your body.  You sigh as, holding [benoit.hisHer] index claws back, [benoit.heShe] begins to move them slowly up and down.");
		
		benoitExploresPc();
		
		if(pc.hasCock()) {
			output("\n\n[benoit.HisHer] hands travel downwards until, with a sharp intake of breath, [benoit.heShe] touches [pc.oneCock].  \"<i>Aren't you just full of surprises,</i>\" [benoit.heShe] says dryly.  After a pause, [benoit.heShe] slowly wraps [benoit.hisHer] smooth hand around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining."); 
			if(pc.cocks[pc.biggestCockIndex()].cLength() < 10) output("  Although this is evidently an uncanny experience for [benoit.himHer], [benoit.heShe] does manage a cocky smile as [benoit.hisHer] hand moves along your male sex.  \"<i>Mine is bigger,</i>\" [benoit.heShe] teases.  You reward [benoit.hisHer] cheek by doing some feeling yourself, grasping and pinching at [benoit.hisHer] tight, supple behind through [benoit.hisHer] trousers, making [benoit.himHer] gasp as you move into [benoit.himHer].");
			else output("  This is evidently an uncanny experience for [benoit.himHer], the alien nature of it deepening as [benoit.hisHer] hands moves along your male sex. \"<i>'Oly Gods, [pc.name]; you are a monster,</i>\" [benoit.heShe] says thickly.  You smile and decide it's time to do some feeling yourself; you grasp and pinch at [benoit.hisHer] tight, supple behind through [benoit.hisHer] trousers, making [benoit.himHer] gasp as you move into [benoit.himHer].");
		}
		output("\n\n[benoit.HisHer] hands trail further down, moving into your inner thighs, exploring your soft flesh until [benoit.heShe] touches your lips.  You close your eyes and sigh as [benoit.heShe] slowly parts them with [benoit.hisHer] smooth fingers and slides into your [pc.vagina].  Although [benoit.hisHer] breath is becoming increasingly heavy [benoit.heShe] also seems genuinely curious about you; with surprising gentleness [benoit.hisHer] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit.heShe] does.  You let [benoit.himHer] know what pleases you by sighing when [benoit.heShe] touches a sweet spot, moving deliberately with [benoit.hisHer] finger's motions so [benoit.heShe] may give them better attention.  [benoit.HeShe] soon finds your [pc.clit], beginning to bulge with need; slowly [benoit.heShe] circles it and then flicks at it, gently frigging you.");
		if(pc.hasStatusEffect("Heat")) output(" By now your vagina is practically gushing, your body's own deep-seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration.  You cannot stop yourself thrusting against [benoit.hisHer] soaked hand, announcing how badly you want this with heavy moans.");
		
		output("\n\nThe scent of your arousal is in the air and as [benoit.short] inhales it, [benoit.hisHer] own breath comes heavier.  [benoit.HisHer] erection bulges in [benoit.hisHer] long johns and you decide it's time for you to take charge; you push [benoit.himHer] against the wall, unbuckle [benoit.himHer] and let [benoit.hisHer] trousers fall.  Stoked by the pheromones simmering off your body, [benoit.hisHer] long, thin, purple erection is straining and [benoit.heShe] arches [benoit.hisHer] back and opens [benoit.hisHer] mouth as you lay a hand on it.  You know just from looking at [benoit.hisHer] straining prick you're going to have to go slow for [benoit.himHer] not to shoot [benoit.hisHer] bolt straight away; with a wicked smile your partner can't see, you suppose that such is your body's effect on [benoit.himHer] it may not even matter if [benoit.heShe] does.  As lost as the horny lizan is to the haze of [benoit.hisHer] pleasure, you remind [benoit.himHer] of reality the best way you know how, guiding [benoit.hisHer] hands to your [pc.hips] and with a sigh, slowly sliding [benoit.hisHer] length into your moistened [pc.vagina] with as much grace as your eagerness can stand.");

		pc.cuntChange(0, benoit.cockVolume(), true, true, false);
		
		output("\n\nBenoit's dick is incredibly smooth and you move down onto it with slick ease.  Rather than burying yourself onto it straight away, you stop with only a third of it in your wet depths and bring it out of you, dipping yourself slowly.  You stop with [benoit.hisHer] sensitive head just inside and work your thighs around deliberately, sighing as it rotates around your slick walls.  [benoit.short] moans and you feel [benoit.hisHer] body tense; immediately you halt your movements and wait, only gradually beginning to gyrate and thrust again when [benoit.heShe] has calmed down.  You slide more inside when you bend forwards again, this time leaving only [benoit.hisHer] base outside of you; a sigh rolls from you as you feel [benoit.himHer] creeping further into your moist depths.  [benoit.HeShe] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit.himHer] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit.himHer].");
		
		if(pc.vaginalCapacity() < cockVolume(15)) output("\n\nYou slide back down onto [benoit.himHer], cooing this time as you feel [benoit.himHer] bottom out with several inches still outside.  [benoit.HisHer] thin member could not be more perfect for your tight sex; [benoit.heShe] rubs your walls up and down as you dreamily thrust in and out of [benoit.hisHer] body, sending waves of pleasure washing through you.");
		else output("\n\nYou slide back down onto [benoit.himHer], cooing this time as your groin meets [benoit.hisHer] muscular thighs with a wet kiss, your sex swallowing [benoit.hisHer] cock whole.  You begin to ride [benoit.himHer] hard and slow, bending [benoit.hisHer] cock upwards to push at your sensitive walls, waves of pleasure starting to wash through you.");
		
		output("\n\nYou keep at this for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit.short]; [benoit.heShe] pants, tenses and gasps to the wet movement of your [pc.vagina], [benoit.hisHer] face and chest heaving with extreme arousal, but [benoit.heShe] lets you stay in command, eventually giving up on anything but lying back and letting you have your way with [benoit.himHer].  To give [benoit.himHer] something to do, you grab [benoit.hisHer] hands and lay them upon your [pc.chest]; after exploring your flesh for a time, [benoit.heShe] finds your [pc.nipple]s and begins to knead them, placing each nub between two fingers and rubbing them insistently.");
		if(pc.lactationQ() > 100) {
			output("  You moan as your breasts reward [benoit.hisHer] attention with spurts of milk; [benoit.heShe] starts in genuine amazement when they ");
			if(!pc.isTaur()) output("hit [benoit.himHer] in the face");
			else output("trickle over [benoit.hisHer] fingers");
			output(".  \"<i>Mammals are so damn weird,</i>\" [benoit.heShe] mutters, making you giggle.");
		}
		output("\n\nYour lust ratchets up as [benoit.hisHer] warm hands continue to move, and at last losing your discipline you thrust into [benoit.himHer] with abandon, eager now for your peak.  [benoit.short] pants as you really begin to fuck [benoit.himHer] and begins to thrust with you; you clutch [benoit.hisHer] neck and bite into [benoit.hisHer] shoulder as you pound into each other, the wetness of your arousal spattering against [benoit.hisHer] thighs as your body slaps into the basilisk's tight muscles.  [benoit.HeShe] makes a harsh, bestial noise when [benoit.heShe] cums; [benoit.hisHer] blind eyes roll as [benoit.heShe] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit.hisHer] jizz and [benoit.hisHer] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal on top of the basilisk, clutching [benoit.himHer] back as you work [benoit.hisHer] dick for every last drop of cum.");
		if(pc.hasCock()) {
			if(!pc.isTaur()) output("  Stuck between your two burning bodies, y");
			else output("Y");
			output("our [pc.cock] spurts in sympathy to your female high, soaking ");
			if(!pc.isTaur()) output("both of you");
			else output("the dry dirt");
			output(" with [pc.cumColor].");
		}
	}
	output("\n\nEventually, the two of you part, dripping your mixed fluids as you step back.  \"<i>Phew!</i>\" [benoit.short] says after [benoit.heShe]'s managed to catch [benoit.hisHer] breath.  \"<i>That was... somesing.  Mademoiselle, you are... amazing.</i>\"  You find yourself laughing at [benoit.hisHer] slightly shell-shocked expression, and the light, happy sound seems to bring [benoit.himHer] around a bit.  [benoit.HeShe] brushes your shoulder as [benoit.heShe] walks past you, feeling around the stock room until [benoit.heShe] finds a chest of drawers.  [benoit.HeShe] opens a compartment and withdraws a small woollen bag, stuffed with pungent green leaves.");
	output("\n\n\"<i>Ze shark ladies are always coming up from ze lake to sell me zis,</i>\" [benoit.heShe] says. \"<i>It is a very effective, 'ow you say, 'counter septic'?");
	pc.orgasm();
	processTime(40 + rand(20));
	clearMenu();
	if ((pc.hasPregnancyOfType("CoCOviElixEggs") || pc.hasPerk("Harpy Womb") || pc.hasPerk("Oviposition")) && (!pc.isPregnant() || pc.hasPregnancyOfType("CoCOviElixEggs"))) {
		output("  I would not inflict my children upon you.  Ere, take as much as you like.</i>\"");
		addButton(0, "Take It", takeBenoitsContraceptives);
		addButton(1, "Leave", dontTakeEggtraceptives);
	}
	else {
		output("  I cannot give you babies unless you 'ave eggs.  I guess I should think a bit more before I go digging for things...</i>\"");
		//, but if your body goes into 'eat again and you are afraid of 'aving... unwanted experiences... I can sell it to you.</i>\"]
		addButton(0, "Next", mainGameMenu);
	}
}

private function takeBenoitsContraceptives():void {
	clearOutput();
	output("You gladly accept the herbal contraceptive and push it into your mouth, enjoying the pleasantly sharp, citrus flavour.");
	//  \"<i>I can sell you ze stuff too,</i>\" he says, twiddling his claws.  \"<i>If you want.</i>\"
	benoit.impregnationType = "";
	pc.loadInCunt(benoit, 0);
	benoit.impregnationType = "CoCBenoitPregnancy";
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//No: 
private function dontTakeEggtraceptives():void {
	clearOutput();
	output("You smile and say you don't mind carrying and laying a few basilisk eggs. \"<i>You... you don't?</i>\" [benoit.heShe] says hesitantly.  [benoit.HeShe] faces you and for a moment looks like [benoit.heShe]'s going to say something else; but then [benoit.heShe] shakes [benoit.hisHer] head and puts the bag back into the drawer.");
	//\"<i>Well...if you are sure.  I can sell you ze stuff if you ever change your mind.</i>\"
	output("\n\nIn the warm afterglow you redress at leisure before leading [benoit.himHer] back inside the shop and, after squeezing [benoit.hisHer] hand, take your leave.");
	//[Herbal Contraceptive added to slot 4 of shop]
	//Standard basilisk preg odds
	//benoitKnocksUpPCCheck();
	pc.loadInCunt(benoit, 0);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Subsequent visit to the shop: 
private function firstTimeAfterBoningEncounterBenoit():void {
	clearOutput();
	//Set a flag here to make sure it only happens once.
	flags["COC.BENOIT_POST_FIRSTFUCK_TALK"] = 1;
	output("A strange, faint noise is emanating from the salvage shop.  It's only when you duck cautiously into the stall proper that you realize it's the sound of a basilisk humming.  [benoit.short] stops to sniff the air when you come in, immediately puts down the mug [benoit.heShe] is polishing, and beckons you inside.");

	output("\n\n\"<i>'Allo again, [pc.name]</i>\"!</i>\" [benoit.heShe] says brightly.  \"<i>'Ow pleasant it is to see you.  'Ow are we zis very fine day?</i>\"  There's something imperceptibly different about [benoit.short] today and it takes you a moment to work out what it is.  [benoit.HeShe] doesn't seem quite as shabby as [benoit.heShe] did before; [benoit.hisHer] scales gleam dully and you wonder if [benoit.heShe]'s taken a bath recently.  There's something else, too.");

	output("\n\n\"<i>Zis?  No.  Of course not!</i>\" [benoit.heShe] says, when you ask if [benoit.heShe]'s wearing the navy tie just for you.  \"<i>Is zere somesing wrong with a basilisk wanting to look 'is best?  Anyway, I am taking it off now.  It is very silly, I see zis now.  Now... what is it zat mademoiselle is after?</i>\" You try not to laugh at this display and consider what it is you're here for.");
	//[defaults to regular 30+ affection visit afterwards]
}

//Let [benoit.himHer](not for horses): 
private function repeatSexWithBenoitLetHim():void {
	clearOutput();
	if(pc.isTaur()) {
		output("\n\nFor the moment you don't do anything; you simply stand back and let [benoit.hisHer] hands slowly move across your frame.  One of [benoit.hisHer] hands comes to rest upon your [pc.nipples]; as [benoit.heShe] gently teases and kneads the soft, sensitive flesh [benoit.hisHer] other hand drift downwards, across your [pc.belly], around your waist and down your velvety back.  Although [benoit.heShe] is familiar with your frame by now [benoit.short] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit.hisHer] face as [benoit.hisHer] smooth hands move across your warm [pc.skinFurScales], as if [benoit.heShe] were mapping you in [benoit.hisHer] mind's eye.");
		output("\n\nThis slow, gentle pressure is all very well, but you can't help but wonder if you can't awaken something a bit more bestial in the timid basilisk.  The thought of making [benoit.himHer] lose [benoit.hisHer] self-control over you makes you grin, and tenderly but firmly you put your hands on [benoit.hisHer] claws and tell [benoit.himHer] to stop.  [benoit.HeShe] looks at you in puzzlement.  Smiling, you begin to give [benoit.himHer] some of [benoit.hisHer] own treatment; your hands drift softly over [benoit.hisHer] tight, smooth flesh, working down [benoit.hisHer] flat stomach until they reach [benoit.hisHer] long johns.  You slowly unbuckle them and let them fall, releasing [benoit.hisHer] long, thin erection.  With one hand you circle the base gently; even touching this least sensitive part of [benoit.hisHer] dick makes [benoit.himHer] grunt with need, the thump of [benoit.hisHer] heart reverberating through [benoit.hisHer] scales, and [benoit.heShe] involuntarily thrusts forwards, trying to get more of your hand upon [benoit.himHer].  Again, you tell [benoit.himHer] to be still.  You continue to almost-masturbate [benoit.himHer], your one hand rubbing the very base of [benoit.hisHer] cock and the lips from which it thrusts, whilst you very gently sway your powerful back hips, your [pc.vagina] beginning to moisten at the sight of the basilisk's intense arousal.  The scent of your sex is in the air and the fact you cannot reach back and do anything about it only intensifies your excitement.  [benoit.short] is clenching [benoit.hisHer] pointed teeth, trembling slightly like a pipe about to burst, [benoit.hisHer] tail thrashing fitfully as you ponderously turn and lead your rump into [benoit.himHer], smearing your essence over [benoit.hisHer] incredibly receptive nostrils.  All [benoit.heShe] can smell is your own arousal as you begin to talk huskily, saying you've been a naughty girl playing in the mountains, you've teased and run away and mocked every creature you've found but now a big bad basilisk has got you cornered, and what is the big bad basilisk going to do now it's got this naughty girl all to itself...?");
		
		output("\n\nBenoit surges forwards, grasps you by the [pc.butt], turns and pinions you to the wall.  Your laughs turn to gasps as with an almost pained growl, [benoit.short] thrusts himself straight into your moist twat.  You can only clutch at the wall of the wagon as [benoit.heShe] begins to fuck you with abandon, pushing your human front forwards as [benoit.heShe] levers your [pc.hips] upwards with each thrust.  [benoit.HeShe] is clumsy with lust as well as blind, uncaring of anything but the need to clench your body and hilt himself in your depths, unable to take hold of himself with your pussy juices coating [benoit.hisHer] nose and burning an unstoppable path to [benoit.hisHer] brain.  [benoit.HisHer] pheromone driven callousness and the discomfort of the wood against your hands ");
		if(pc.biggestTitSize() >= 1) output("and [pc.fullChest] ");
		output("augments the roughness of the fuck and you find yourself getting carried along with it, thrusting your powerful rump back against the basilisk and clenching [benoit.himHer] deeper into you, delighting in [benoit.hisHer] firm, dense mass pounding into you.  Your [pc.vagina] dribbles juices around [benoit.hisHer] impatient, straining dick, practically foaming as [benoit.hisHer] smooth length rubs forcefully all along your sensitive tunnel.");
		pc.cuntChange(0, benoit.cockVolume(), true, true, false);
		
		output("\n\nThe rough sex knocks the breath and sense out of you and you are dizzy with it by the time you reach your high, gasping and making guttural noises as [benoit.short]'s thumping makes your pussy clench and spasm around [benoit.himHer].  [benoit.HeShe] joins in with a thick, breathless growl, and you feel surge after surge of cum flood your depths with warmth.  After you have finished thrashing against each other you stay where you are, gathering your breath on each other.  It takes you a while to realize [benoit.heShe] hasn't gone soft, and is still embedded firmly within you; your mixed fluids are dripping down your thighs and your musk is still in the air.  [benoit.HeShe] grins at you and gives you a tiny thrust, making you bite your lip; ejaculating seems to have only taken the slightest edge off the rut you've induced in [benoit.himHer].  “You did not sink you would get away zat easily, did you?” [benoit.heShe] growls softly.");
		
		output("\n\nHe pulls out of you, trailing threads of semen as [benoit.heShe] goes, before slowly turning you around, painstakingly feeling around for a clear space with [benoit.hisHer] feet, and then putting you down, gently but firmly positioning you on your lower body.  [benoit.HisHer] hands descend upon your [pc.butt]; grinning, you poke it outwards invitingly, sighing with mock frustration as the blind basilisk painstakingly lines up [benoit.hisHer] next shot with your drooling, sticky sex.");
		
		output("\n\nWhen [benoit.heShe] slides into you [benoit.heShe] does so with virtually no resistance whatsoever; the two of you have turned your pussy into an inviting, gooey sleeve.  ");
		//[Tight: 
		if(pc.looseness(0) <= 3) output("You don't mind; your tight sex is a perfect fit for [benoit.hisHer] smooth, thin dick, and you work with [benoit.himHer] as [benoit.heShe] thrusts, pulling and pushing your walls in time with [benoit.hisHer] length, your lubrication allowing [benoit.himHer] to quickly increase the tempo until the two of you are once again bucking against each other gleefully, your fluids spattering against each other.");
		//Loose: 
		else output("Although [benoit.heShe] is long [benoit.heShe] barely even touches the sides of your encompassing twat.  The sensation isn't great for you until [benoit.heShe] really starts to go to town, ramming into you with all [benoit.heShe]'s got, beating a wet staccato against your [pc.butt], pushing against your [pc.clit] as [benoit.heShe] sheaths himself in you.  Your fluids begin to dribble onto your hooves as your slick pleasure button bulges with increasing delight.");
		output("\n\nThe difference in the position makes [benoit.hisHer] dick bend into you at a different angle, stroking a neglected spot which soon has you gasping with need.  [benoit.short] is not as maddened as [benoit.heShe] was the first time, and [benoit.heShe] has the composure to draw himself out; [benoit.heShe] slows himself down and then back up again, fucking you magisterially, withdrawing himself almost all the way out of you before slamming firmly back in, stopping whilst hilted in you until you beg and moan for [benoit.himHer] to continue.  You give yourself up to the dominant rut you've awoken in [benoit.himHer], thrusting back into [benoit.himHer] as you are fucked up to a second ecstatic height and then a third; everything disappearing underneath a timeless red haze, of having your [pc.butt] in the air and being given what a mare needs.");
		
		output("\n\nWhen [benoit.short] finally cums [benoit.heShe] sounds almost pained; [benoit.hisHer] aching cock delivers another load into your already packed womb, semen dribbling and spurting onto the floor.  You work [benoit.hisHer] dick for as long as you can until it finally droops out of your abused cunt.  Finally you sit up, turn around and cuddle into the basilisk, who pools onto the floor and responds tentatively.");
		
		output("\n\n“Zat was... wow,” [benoit.heShe] manages.  With [benoit.hisHer] dick wrung of every last drop of [benoit.hisHer] seed you can see [benoit.heShe] is returning to himself, and [benoit.hisHer] hand around your waist is cautious. “Was zat... all right for you? I do not know if... I get zese smells in my 'ead and zen...” You answer [benoit.himHer] by kissing [benoit.himHer] on the cheek and saying with teasing huskiness that it was good, but maybe next time [benoit.heShe] shouldn't hold back so much.  [benoit.HeShe] grins at this.  You spend a bit more time cuddling whilst recovering from the intense fuck, before finally clambering to your feet.  Your final act before dressing and taking your leave is to faintly brush your scent across [benoit.short]'s nose again, telling [benoit.himHer] you expect [benoit.himHer] to be ready and primed the next time this naughty girl pays a visit.  [benoit.HeShe] doesn't respond- maybe [benoit.heShe] is still privately ashamed about losing [benoit.hisHer] cool over you- but you can tell by the lines of [benoit.hisHer] face and the way [benoit.hisHer] head moves unconsciously to follow your path out of [benoit.hisHer] shop that [benoit.himHer] not being aroused by you isn't something you're ever going to have to worry about.");
	}
	else {
		output("For the moment you don't do anything; you simply stand back and let [benoit.hisHer] hands slowly move across your frame.  One of [benoit.hisHer] hands comes to rest upon your [pc.nipple]; as [benoit.heShe] gently teases and kneads the soft, sensitive flesh [benoit.hisHer] other hand drift downwards, across your belly, around over the crack of your [pc.butt] then down to cup your behind.  Although [benoit.heShe] is familiar with your frame by now, [benoit.short] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit.hisHer] face as [benoit.hisHer] smooth hands move across your warm skin, as if [benoit.heShe] were mapping you in [benoit.hisHer] mind's eye.");
		
		output("\n\nThis slow, gentle pressure is all very well, but you can't help but wonder if you can't awaken something a bit more bestial in the timid basilisk.  The thought of making [benoit.himHer] lose [benoit.hisHer] self-control over you causes you to grin, unseen, and tenderly but firmly you put your hands on [benoit.hisHer] claws and tell [benoit.himHer] to stop.  [benoit.HeShe] looks at you in puzzlement as you shift your bodies around, your hands sliding over [benoit.hisHer] shoulders and chest as you change position so that it is you with your back to the wall.  [benoit.HeShe] begins to move [benoit.hisHer] hands again and you tut mockingly, telling [benoit.himHer] to be still for now.  Smiling, you begin to give [benoit.himHer] some of [benoit.hisHer] own treatment; your hands drift softly over [benoit.hisHer] tight, smooth flesh, working down [benoit.hisHer] washboard stomach until they reach [benoit.hisHer] long johns.  You slowly unbuckle them and let them fall, releasing [benoit.hisHer] long, thin erection.  With one hand you circle the base gently; even touching this least sensitive part of [benoit.hisHer] dick makes [benoit.himHer] grunt with need, the thump of [benoit.hisHer] heart reverberating through [benoit.hisHer] scales, and [benoit.heShe] involuntarily thrusts forwards, trying to get more of your hand upon [benoit.himHer].  Again, you tell [benoit.himHer] to be still.  You continue to almost-masturbate [benoit.himHer], your one hand rubbing the very base of [benoit.hisHer] cock and the slit from which it thrusts, whilst with the other you reach down and touch your own slickening [pc.vagina].  You moan exaggeratedly as you dip first one finger and then two into your honey pot, gently frigging your [pc.clit] until you are in full spate, dripping your fluids onto the packed earth beneath you.  [benoit.short] is clenching [benoit.hisHer] pointed teeth, trembling slightly like a pipe about to burst, as you lift your coated fingers up and smear your essence over [benoit.hisHer] incredibly receptive nostrils.  [benoit.HisHer] tail thrashes fitfully as you continue to torment [benoit.hisHer] dick, just barely touching [benoit.hisHer] purple tip before returning to [benoit.hisHer] base.  All [benoit.heShe] can smell is your own arousal as you begin to talk huskily, saying you've been a naughty girl playing in the mountains, you've teased and mocked and run away from every creature you've found but now a big bad basilisk has got you cornered, and what is the big bad basilisk going to do now it's got this naughty girl all to itself...?");
		
		output("\n\nBenoit surges forward, grasps you by the [pc.butt] and pinions you to the wall.  Your laughs turn to gasps as [benoit.heShe] lifts your teasing hands upwards, pinning them out of the way with the mass of [benoit.hisHer] body and with an almost pained growl, thrusts himself straight into your moist twat.  You can only clutch at [benoit.hisHer] back as [benoit.heShe] begins to fuck you with complete abandon, smacking your back into the wall of the wagon and levering your [pc.hips] upwards with each thrust.  [benoit.HeShe] is clumsy with lust as well as blind, uncaring of anything but the need to clench your body and hilt himself in your depths, unable to take hold of himself with your pussy juices coating [benoit.hisHer] nose and burning an unstoppable path to [benoit.hisHer] brain.  [benoit.HisHer] pheromone-driven callousness and the discomfort of the wood rubbing against your back and butt augments the roughness of the fuck and you find yourself getting carried along with it, wrapping your thighs around the basilisk's thin waist and clenching [benoit.himHer] deeper into you, delighting in [benoit.hisHer] firm, dense mass pounding into you.  Your [pc.vagina] dribbles juices around [benoit.hisHer] impatient, straining dick, practically foaming as [benoit.hisHer] smooth length rubs forcefully all along your sensitive tunnel.");
		
		output("\n\nThe rough sex knocks the breath and sense out of you and you are dizzy with it by the time you reach your high, gasping and making guttural noises as [benoit.short]'s thumping makes your pussy clench and spasm around [benoit.himHer].  [benoit.HeShe] joins in with a thick, breathless growl, and you feel surge after surge of cum flood your depths with warmth.  After you have finished thrashing against each other, you stay still, gathering your breath on each other.  It takes you a while to realize [benoit.heShe] hasn't gone soft, that [benoit.hisHer] prick is still embedded firmly within you; your mixed fluids are dripping down your thighs and your musk is still in the air.  [benoit.HeShe] grins at you and gives you a tiny thrust, making you bite your lip; ejaculating seems to have only taken the slightest edge off the rut you've induced in [benoit.himHer].  \"<i>You did not sink you would get away zat easily, did you?</i>\" [benoit.heShe] growls softly.");
		
		
		output("\n\nHe pulls out of you, trailing threads of semen as [benoit.heShe] goes, before slowly turning you around, painstakingly feeling around for a clear space with [benoit.hisHer] feet, and then putting you down, gently but firmly positioning you on your hands and ");
		if(pc.isBiped()) output("knees");
		else output("lower body");
		output(".  [benoit.HisHer] hands descend upon your [pc.butt]; grinning, you poke it outwards invitingly, sighing with affected frustration as the blind basilisk painstakingly lines up [benoit.hisHer] next shot with your drooling, sticky sex.");
		
		output("\n\nWhen [benoit.heShe] slides into you [benoit.heShe] does so with virtually no resistance whatsoever; the two of you have turned your pussy into an inviting, gooey sleeve.  ");
		if(pc.looseness(0) <= 3) output("You don't mind; your tight sex is a perfect fit for [benoit.hisHer] smooth, thin dick, and you work with [benoit.himHer] as [benoit.heShe] thrusts, pulling and pushing your walls in time with [benoit.hisHer] length, your lubrication allowing [benoit.himHer] to quickly increase the tempo until the two of you are once again bucking against each other gleefully, your fluids spattering against each other.");
		else output("Although [benoit.heShe] is long, [benoit.heShe] barely even touches the sides of your encompassing twat.  The sensation isn't great for you until [benoit.heShe] really starts to go to town, ramming into you with all [benoit.heShe]'s got, beating a wet staccato against your [pc.butt].  You send a hand roaming back around and begin to finger your [pc.clit] as [benoit.heShe] sheaths himself in you, [benoit.hisHer] fluids running down your fingers as you work your slick, bulging pleasure button with increasing delight.");
		pc.cuntChange(0, benoit.cockVolume(), true, true, false);
		output("  The difference in the position makes [benoit.hisHer] dick bend into you at an angle, stroking a neglected spot which soon has you gasping with need.  [benoit.short] is not as maddened as [benoit.heShe] was the first time, and [benoit.heShe] has the composure to draw himself out; [benoit.heShe] slows himself down and then back up again, fucking you magisterially, withdrawing himself almost completely before slamming firmly back in, stopping whilst hilted in you until you beg and moan for [benoit.himHer] to continue.  You give yourself up to the dominant rut you've awoken in [benoit.himHer], thrusting back into [benoit.himHer] as you are fucked up to a second ecstatic height and then a third; everything disappearing underneath a timeless red haze, of being on your hands and knees with your [pc.butt] in the air and being given what a female animal needs.");
		
		output("\n\nWhen [benoit.short] finally cums [benoit.heShe] sounds almost pained; [benoit.hisHer] aching cock delivers another load into your already packed womb, semen dribbling and spurting onto the floor.  You work [benoit.hisHer] dick for as long as you can until it finally droops out of your abused cunt.  Finally you crawl into a sitting position and cuddle into the basilisk, who pools onto the floor and responds tentatively.");
		
		output("\n\n\"<i>Zat was... wow,</i>\" [benoit.heShe] manages.  With [benoit.hisHer] dick wrung of every last drop of [benoit.hisHer] seed you can see [benoit.heShe] is returning to himself, and [benoit.hisHer] hand on your shoulder is cautious.  \"<i>Was zat... alright for you?  I do not know if... I get zese smells in my 'ead and zen...</i>\"  You answer [benoit.himHer] by kissing [benoit.himHer] on the cheek and saying with teasing huskiness that it was good, but perhaps next time [benoit.heShe] shouldn't hold back so much.  [benoit.HeShe] grins at this.  You spend a bit more time cuddling whilst recovering from the intense fuck, before finally clambering to your feet.  Your final act before dressing and taking your leave is to dip a lazy finger into your cunt and faintly brush your scent across [benoit.short]'s nose again, telling [benoit.himHer] you expect [benoit.himHer] to be ready and primed the next time this naughty girl pays a visit.  [benoit.HeShe] doesn't respond - maybe [benoit.heShe] is still privately ashamed about losing [benoit.hisHer] cool over you - but you can tell by the lines of [benoit.hisHer] face and the way [benoit.hisHer] head moves unconsciously to follow your path out of [benoit.hisHer] shop that [benoit.himHer] not being aroused by you isn't something you're ever going to have to worry about.");
	}
	IncrementFlag("COC.BENOIT_TIMES_SEXED_FEMPCS");
	//benoitKnocksUpPCCheck();
	processTime(25);
	pc.loadInCunt(benoit);
	benoitAffection(2);
	pc.orgasm();
	
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Take charge: 
private function repeatBenoitFuckTakeCharge():void {
	clearOutput();
	if(pc.isTaur()) {
		output("nFor the moment you don't do anything; you simply stand back and let [benoit.hisHer] hands slowly move across your frame.  One of [benoit.hisHer] hands comes to rest upon your [pc.nipple]; as [benoit.heShe] gently teases and kneads the soft, sensitive flesh [benoit.hisHer] other hand drift downwards, across your belly, then slowly back along your vast tauric frame.  Although [benoit.heShe] is familiar with your frame by now [benoit.short] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit.hisHer] face as [benoit.hisHer] smooth hands move across your warm [pc.skinFurScales], as if [benoit.heShe] were mapping you in [benoit.hisHer] mind's eye.");
		
		//[Herm:
		if(pc.isTaur()) output("\n\n[benoit.HisHer] hands travel downwards until, with a small grin, [benoit.heShe] finds what [benoit.heShe] knows is there.  [benoit.HeShe] wraps [benoit.hisHer] dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.  You close your eyes and sigh, enjoying the masterful treatment that both of you can only feel, not see.");
		
		output("\n\n[benoit.HisHer] hands trail upwards, moving over your bestial behind, exploring your soft flesh until [benoit.heShe] touches your lips.  You close your eyes and sigh as [benoit.heShe] slowly parts them with [benoit.hisHer] smooth fingers and slides into your [pc.vagina].  Although [benoit.hisHer] breath is becoming increasingly heavy [benoit.heShe] also seems genuinely curious about you; with surprising gentleness [benoit.hisHer] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit.heShe] does.  You let [benoit.himHer] know what pleases you by sighing when [benoit.heShe] touches a sweet spot, moving deliberately with [benoit.hisHer] finger's motions so [benoit.heShe] may give them better attention.  [benoit.HeShe] soon finds your [pc.clit], beginning to bulge with need; slowly [benoit.heShe] circles it and then flicks at it, gently frigging you.");
		if(pc.hasStatusEffect("Heat")) output("  By now your vagina is practically gushing, your bodies' own deep seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration of your body.  You cannot stop thrusting yourself against [benoit.hisHer] soaked hand, announcing how badly you want this with heavy moans.");
		
		output("\n\nThe scent of your arousal is in the air and as [benoit.short] breathes it in [benoit.hisHer] own breath comes heavier.  [benoit.HisHer] erection bulges in [benoit.hisHer] long johns and you decide it's time for you to take charge; you back up, butting [benoit.himHer] insistently with your powerful body until you have [benoit.himHer] pinned against a space upon the opposite wall.  You watch [benoit.himHer] over your shoulder as [benoit.heShe] unbuckles himself and lets [benoit.hisHer] trousers fall.  Stoked by the pheromones simmering off your body, [benoit.hisHer] long, thin purple erection is straining and [benoit.heShe] arches [benoit.hisHer] back and opens [benoit.hisHer] mouth as you flare your [pc.butt] and press yourself against it.  You know just from looking at [benoit.hisHer] intense arousal you're going to have to go slow to stop [benoit.himHer] from shooting [benoit.hisHer] bolt straight away; with a wicked smile your partner can't see, you suppose such is your effect on [benoit.himHer] it may not even matter if [benoit.heShe] does.  Still, as [benoit.heShe] lays [benoit.hisHer] hands upon your flanks, and with a sigh you lead back and slowly slide [benoit.hisHer] length into your moistened [pc.vagina], it is as gently as you can.");
		
		output("\n\nBenoit's dick is incredibly smooth and you move down onto it with incredible, slick ease.  Rather than burying yourself onto it straight away you stop with only a third of it in your wet depths and slowly bring it out of you, dipping yourself slowly.  You stop with [benoit.hisHer] sensitive head just inside and work your [pc.hips] around deliberately, sighing as it rotates slowly around your slick walls.  [benoit.short] moans dryly and you feel [benoit.hisHer] body tense; immediately you stop your movements and wait, only gradually beginning to gyrate and thrust again when [benoit.heShe] has calmed down.  You slide more of [benoit.himHer] into you when you bend forwards again, this time leaving only [benoit.hisHer] base outside of you; you sigh as you feel [benoit.himHer] creeping further into your moist depths.  [benoit.HeShe] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit.himHer] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit.himHer].");
		
		output("\n\n");
		//[Small capacity:]
		if(pc.looseness(0) <= 3) output("You slide back down onto [benoit.himHer], cooing this time as you feel [benoit.himHer] bottom out with several inches of [benoit.himHer] still outside of you.  [benoit.HisHer] thin, long length could not be more perfect for your tight sex; [benoit.heShe] rubs your walls up and down as you dreamily thrust in and out of [benoit.hisHer] body, sending waves of pleasure flowing through you.");
		//Large capacity: 
		else output("You slide back down onto [benoit.himHer], cooing this time as your groin meets [benoit.hisHer] muscular thighs with a wet kiss, your sex swallowing [benoit.hisHer] cock whole.  You begin to ride [benoit.himHer] hard and slow, bending [benoit.hisHer] cock upwards to push at your sensitive walls, waves of pleasure starting to flow through you.");
		
		output("\n\nYou keep at this slow ride for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit.short]; [benoit.heShe] pants, tenses and gasps to the wet movement of your [pc.vagina], [benoit.hisHer] face and chest red with extreme arousal, but [benoit.heShe] lets you stay in control, eventually unable to do anything but lie back and let you have your way with [benoit.himHer].");
		pc.cuntChange(0, benoit.cockVolume(), true, true, false);
		//[Lactation: 
		if(pc.lactationQ() >= 50) output("  The slow, sensual sex is enough for you to begin to bead milk from your sensitive [pc.nipples]; you moan as the flow intensifies until you are instinctively kneading your [pc.chest], spurting your sweet, warm fluids onto the floor.  [benoit.short] starts in genuine amazement at the sound.  “Mammals are so damn weird,” [benoit.heShe] mutters, making you giggle.");
		
		output("\n\nYour lust ratchets up as [benoit.hisHer] warm hands continue to move over your behind, and at last losing your discipline you begin to thrust into [benoit.himHer] with abandon, eager now for your peak.  [benoit.short] pants as you really begin to fuck [benoit.himHer] and thrusts with you; the wetness of your arousal spatters against [benoit.hisHer] thighs as your body slaps into the basilisk's tight muscles.  [benoit.HeShe] makes a harsh, bestial noise when [benoit.heShe] cums; [benoit.hisHer] blind eyes roll as [benoit.heShe] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit.hisHer] jizz and [benoit.hisHer] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal against the basilisk, clutching [benoit.himHer] back as you work [benoit.hisHer] dick for every last drop.");
		//[Herm: 
		if(pc.hasCock()) output("  [pc.EachCock] thickens and spurts in sympathy to your female high, spattering the floor with [pc.cumColor] paint.");
		
		output("\n\nYou puddle onto the packed earth floor and cuddle for a while, holding each other as you bask in the afterglow, silently listening to the far away bustle and clatter of the carnival.");
		
		output("\n\n“I am not really sure what I did to deserve you,” says [benoit.short] eventually, [benoit.hisHer] voice barely above a raspy murmur in [benoit.hisHer] throat.  You give [benoit.himHer] a playful dig in the ribs and say you're only in it for the counter sceptic.  [benoit.HeShe] grins and the two of you get up, get dressed, and go your separate ways.");
	}
	else {
		output("For the moment you don't do anything; you simply stand back and let [benoit.hisHer] hands slowly move across your frame.  One of [benoit.hisHer] hands comes to rest upon your [pc.nipple]; as [benoit.heShe] gently teases and kneads the soft, sensitive flesh [benoit.hisHer] other hand drift downwards, across your belly, around over the crack of your [pc.butt] then down to cup your behind.  Although [benoit.heShe] is familiar with your frame by now [benoit.short] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit.hisHer] face as [benoit.hisHer] smooth hands move across your warm [pc.skinFurScales], as if [benoit.heShe] were mapping you in [benoit.hisHer] mind's eye.");
		
		if(pc.hasCock()) output("\n\n[benoit.HisHer] hands travel downwards until, with a small grin, [benoit.heShe] finds what [benoit.heShe] knows is there.  [benoit.HeShe] wraps [benoit.hisHer] dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.  You decide it's time to do some feeling yourself; you grasp and pinch at [benoit.hisHer] tight, supple behind through [benoit.hisHer] trousers, making [benoit.himHer] gasp as you move into [benoit.himHer].");
		
		//begin copypasta
		output("[benoit.HisHer] hands trail further down, moving into your inner thighs, exploring your soft flesh until [benoit.heShe] touches your lips.  You close your eyes and sigh as [benoit.heShe] slowly parts them with [benoit.hisHer] smooth fingers and slides into your [pc.vagina].  Although [benoit.hisHer] breath is becoming increasingly heavy [benoit.heShe] also seems genuinely curious about you; with surprising gentleness [benoit.hisHer] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit.heShe] does.  You let [benoit.himHer] know what pleases you by sighing when [benoit.heShe] touches a sweet spot, moving deliberately with [benoit.hisHer] finger's motions so [benoit.heShe] may give them better attention.  [benoit.HeShe] soon finds your [pc.clit], beginning to bulge with need; slowly [benoit.heShe] circles it and then flicks at it, gently frigging you.");
		if(pc.hasStatusEffect("Heat")) output("  By now your vagina is practically gushing, your body's own deep-seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration.  You cannot stop yourself thrusting against [benoit.hisHer] soaked hand, announcing how badly you want this with heavy moans.");
		
		output("\n\nThe scent of your arousal is in the air and as [benoit.short] inhales it, [benoit.hisHer] own breath comes heavier.  [benoit.HisHer] erection bulges in [benoit.hisHer] long johns and you decide it's time for you to take charge; you push [benoit.himHer] against the wall, unbuckle [benoit.himHer] and let [benoit.hisHer] trousers fall.  Stoked by the pheromones simmering off your body, [benoit.hisHer] long, thin, purple erection is straining and [benoit.heShe] arches [benoit.hisHer] back and opens [benoit.hisHer] mouth as you lay a hand on it.  You know just from looking at [benoit.hisHer] straining prick you're going to have to go slow for [benoit.himHer] not to shoot [benoit.hisHer] bolt straight away; with a wicked smile your partner can't see, you suppose that such is your body's effect on [benoit.himHer] it may not even matter if [benoit.heShe] does.  Still, as you once again lay [benoit.hisHer] hands upon you, brace [benoit.himHer] against the wall and, with a sigh, slowly slide [benoit.hisHer] length into your moistened [pc.vagina], it is as gently as your eagerness can stand.");
		pc.cuntChange(0, benoit.cockVolume(), true, true, false);

		output("\n\nBenoit's dick is incredibly smooth and you move down onto it with slick ease.  Rather than burying yourself onto it straight away, you stop with only a third of it in your wet depths and bring it out of you, dipping yourself slowly.  You stop with [benoit.hisHer] sensitive head just inside and work your [pc.hips] around deliberately, sighing as it rotates around your slick walls.  [benoit.short] moans and you feel [benoit.hisHer] body tense; immediately you halt your movements and wait, only gradually beginning to gyrate and thrust again when [benoit.heShe] has calmed down.  You slide more inside when you bend forwards again, this time leaving only [benoit.hisHer] base outside of you; a sigh rolls from you as you feel [benoit.himHer] creeping further into your moist depths.  [benoit.HeShe] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit.himHer] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit.himHer].");
		
		//[Small capacity: 
		if(pc.looseness(0) <= 3) output("\n\nYou slide back down onto [benoit.himHer], cooing this time as you feel [benoit.himHer] bottom out with several inches still outside.  [benoit.HisHer] thin member could not be more perfect for your tight sex; [benoit.heShe] rubs your walls up and down as you dreamily thrust in and out of [benoit.hisHer] body, sending waves of pleasure washing through you.");
		else output("\n\nYou slide back down onto [benoit.himHer], cooing this time as your groin meets [benoit.hisHer] muscled thighs with a wet kiss, your sex swallowing [benoit.hisHer] cock whole.  You begin to ride [benoit.himHer] hard and slow, bending [benoit.hisHer] cock upwards to push at your sensitive walls, waves of pleasure starting to wash through you.");

		output("\n\nYou keep at this for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit.short]; [benoit.heShe] pants, tenses and gasps to the wet movement of your [pc.vagina], [benoit.hisHer] face and chest heaving with extreme arousal, but [benoit.heShe] lets you stay in command, eventually giving up on anything but lying back and letting you have your way with [benoit.himHer].  To give [benoit.himHer] something to do, you grab [benoit.hisHer] hands and lay them upon your [pc.chest]; after exploring your flesh for a time, [benoit.heShe] finds your [pc.nipple]s and begins to knead them, placing each nub between two fingers and rubbing them insistently.");
		//[Lactation: 
		if(pc.lactationQ() > 100) {
			output("  You moan as your breasts reward [benoit.hisHer] attention with spurts of milk; [benoit.heShe] starts in genuine amazement when they ");
			if(!pc.isTaur()) output("hit [benoit.himHer] in the face");
			else output("trickle over [benoit.hisHer] fingers");
			output(".  \"<i>Mammals are so damn weird,</i>\" [benoit.heShe] mutters, making you giggle.");
		}
		
		output("\n\nYour lust ratchets up as [benoit.hisHer] warm hands continue to move, and at last losing your discipline you thrust into [benoit.himHer] with abandon, eager now for your peak.  [benoit.short] pants as you really begin to fuck [benoit.himHer] and begins to thrust with you; you clutch [benoit.hisHer] neck and bite into [benoit.hisHer] shoulder as you pound into each other, the wetness of your arousal spattering against [benoit.hisHer] thighs as your body slaps into the basilisk's tight muscles.  [benoit.HeShe] makes a harsh, bestial noise when [benoit.heShe] cums; [benoit.hisHer] blind eyes roll as [benoit.heShe] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit.hisHer] jizz and [benoit.hisHer] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal on top of the basilisk, clutching [benoit.himHer] back as you work [benoit.hisHer] dick for every last drop of cum.");
		if(pc.hasCock()) {
			//[(not horse)
			if(!pc.isTaur()) output("  Stuck between your two burning bodies, y");
			else output("Y");
			output("our [pc.cock] spurts in sympathy to your female high, soaking ");
			if(!pc.isTaur()) output("both of you");
			else output("the dry dirt");
			output(" with white.");
		}
		
		output("\n\nYou puddle onto the packed earth floor and cuddle for a while, holding each other as you bask in the afterglow, silently listening to the far away bustle and clatter of the carnival.");
		
		output("\n\n\"<i>I am not really sure what I did to deserve you,</i>\" says [benoit.short] eventually, [benoit.hisHer] voice barely above a raspy murmur in [benoit.hisHer] throat.  You give [benoit.himHer] a playful dig in the ribs and say you're only in it for the counter sceptic.  [benoit.HeShe] grins and the two of you get up, get dressed, and go your separate ways.");
	}
	processTime(25);
	//benoitKnocksUpPCCheck();
	benoitAffection(2);
	IncrementFlag("COC.BENOIT_TIMES_SEXED_FEMPCS");
	pc.orgasm();
	pc.loadInCunt(benoit);
	
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Bas. Womb (not for horses)
private function tryToConvertToBassyWomb():void {
	clearOutput();
	//[Ingredients not in inventory: ]
	//A double dose of ovi-elixer, a bottle of reptilum, goblin ale and some basilisk blood would probably do...
	if(!(pc.hasItem(new CoCOvipositionElixir(),2) && pc.hasItem(new CoCReptilum()) && pc.hasItem(new CoCGoblinAle()))) {
		output("You don't have the necessary ingredients to attempt this yet.  You recall [benoit.short] mentioning that you would need Reptilum, two Ovi Elixirs, and Goblin Ale.");
		clearMenu();
		addButton(0, "Next", benoitIntro);
	}
	/*else if(pc.isTaur()) {
		output("\"<i>Forgive me, [pc.name],</i>\" Benoit says, clearly troubled, as you begin hauling out the ingredients and announcing your plan.  \"<i>I sink your body is already stressed enough wis 'aving to pump so little blood so far... I would razer you not take furzer risks on my account until your form is more... compact.  I cannot be a part of zis... 'owever much I would like to.  You mean too much to me, you see.</i>\"");
		output("\n\nLeft speechless by [benoit.hisHer] frankness, you can only sweep the items back into your bag.");
		//return to shop menu
		doNext(benoitIntro);
	}*/
	//Ingredients in inventory: 
	else {
		pc.destroyItem(new CoCOvipositionElixir(),2);
		pc.destroyItem(new CoCReptilum());
		pc.destroyItem(new CoCGoblinAle());
		output("You ferret out the ingredients you have collected and begin to bang them onto the counter in front of [benoit.short], telling [benoit.himHer] that you've got what [benoit.heShe] needs.  Pierre barks excitedly at the noise.");
		
		output("\n\n\"<i>And what is zat?</i>\" the basilisk says, bewildered. You explain you can whip something up which will give you a basilisk womb - and hence, female basilisk kids.  [benoit.short] opens [benoit.hisHer] mouth then closes it again; it takes [benoit.himHer] a while to properly compute these words.  \"<i>But... but zat is completely impossible, [pc.name]!</i>\" [benoit.heShe] says eventually, wringing [benoit.hisHer] hands.  \"<i>'Ow do you know you won't just poison yourself?  Or, or turn yourself into a newt or somesing?  Please... don't 'urt... I should never 'ave said...</i>\"  [benoit.HeShe] lapses into silence as you grab a pewter bowl from a nearby shelf and a wooden spoon from a container full of old utensils, and begin to mix the various ingredients together.  You pour the ovi-elixers into the goblin ale, beating them together until a fairly unpleasant sulfuric smell fills the close market stall.  Carefully you dribble the reptilum in whilst continuing to stir, until the smell changes to that of cooking sherry.  You frown at the mixture.  It feels like it's missing something...  Casually, you ask [benoit.short] to open [benoit.hisHer] hand to you, whilst plucking a kitchen knife from the utensil container.  [benoit.HeShe] barks in pain as you run the blade across [benoit.hisHer] palm and then hold [benoit.hisHer] hand firmly over the bowl.  Drops of dark red blossom into the mixture, and as you carefully stir the potion turns a green-grey color: the color of [benoit.short]'s scales.");
		
		output("\n\n\"<i>You 'ave been in ze sun too long [pc.name],</i>\" says the basilisk harshly, clutching [benoit.hisHer] hand. \"<i>Go 'ave a lie down and zen resink drinking whatever it is you 'ave just concocted.  I never asked for you to try zis.</i>\" You feel a moment of doubt... but no, you've poured good ingredients into this and you sure as hell aren't going to wimp out now.  You give [benoit.short]'s uninjured hand a reassuring squeeze and say with as much confidence as you can muster that you know what you're doing.  With that, you cup the bowl, and with only a moment's hesitation, drink deeply.");
		
		output("\n\nThe mixture has a lingering bite of mint overlaying the all-consuming burn of alcohol; you are reminded vaguely of the sticky liqueurs that populated the recesses of cupboards back home.  You smack your lips and plonk the bowl back down with deliberate loudness after you have finished; [benoit.short] clutches the counter tensely as you wait.  You haven't died straight away, so that's a positive... an immense gurgle comes from your belly and you double over as your insides shift and the contents of your gut churn.  The sensation is not painful exactly but you feel like you've lost all control of your insides; you clutch your sides and try to breathe levelly as your stomach turns upside down and makes a sound like trapped gas.  Eventually you feel something like a bubble form just below your gut; slowly your insides settle as the bubble grows larger and larger, until the sensation slowly fades.  Cautiously you walk back and forth a few times, before poking your tummy.");
		//[No oviposition:
		if(!pc.hasPerk("Oviposition")) output("  You feel slightly bloated, but otherwise fine; you sense that you can lay eggs of your own volition now.");
		else output("You feel slightly bloated, but otherwise fine; you sense that were you to get impregnated by basilisk seed, the eggs you produce would be pure basilisk.");
		
		output("\n\n\"<i>[pc.name]?</i>\" says [benoit.short] nervously.  \"<i>Are you all right?  Shall I call ze sawbones? I will call ze sawbones.  'E is mostly good at taking people apart and putting zem back togezzer again, but I am sure 'e can give you a good purgative if we rush...</i>\"  You toy with the idea of staging a dramatic allergic reaction, but deciding not to fray [benoit.hisHer] nerves any further you tell [benoit.himHer] you feel absolutely fine.  Indeed, stroking your belly, you are almost certain that it worked.");
		
		output("\n\n\"<i>Really?</i>\"  The basilisk is off [benoit.hisHer] feet and around the counter faster than you gave [benoit.himHer] credit for.  \"<i>You are not just high from ze goblin ale?</i>\"  [benoit.HeShe] holds you around the waist and breathes you in slowly.  \"<i>You... you are not joking.</i>\"  [benoit.HeShe] sounds shell-shocked.  \"<i>You really did it.  You... really did mean to do zis.</i>\"");
		
		//put some tag here to track dis shit.
		flags["COC.BENOIT_TESTED_BASILISK_WOMB"] = .5;
		
		//[Lust 30 or more: 
		if(pc.lust() >= 33) {
			output("  You grin and say you're not sure it worked, but you suppose there's only one real way of finding out...");
			if(pc.tallness <= 78 && !pc.isTaur()) output("  The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and hoists you over [benoit.hisHer] shoulder.  You squeal in mock terror as [benoit.heShe] hauls you as fast as [benoit.heShe] can into the back room, knocking over half [benoit.hisHer] stock as [benoit.heShe] does.");
			else output("  The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and frenetically attempts to hoist you over [benoit.hisHer] shoulder.  You are far too big for [benoit.himHer] though; after several valiant attempts, [benoit.heShe] collapses against a shelf.  Laughing, you pick the stricken, panting reptile up, hoist [benoit.himHer] over your own shoulder, and navigate a path into the back room.");
			clearMenu();
			addButton(0, "Next", suggestSexAfterBasiWombed, false);
			return;
		}
		else output("  You grin and say you're not even sure it worked... but you'll be back at some point to try it out, and [benoit.heShe]'d better be ready for when you do.  You gently pry yourself out of [benoit.hisHer] grip and leave as deliberately as you can, aware of the beguiling, invisible scent you are leaving for the stunned, silent basilisk to simmer in.");
		clearMenu();
		addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
	}
}	


private function suggestSexAfterBasiWombed(later:Boolean = true):void {
	clearOutput();
	//Subsequent \"<i>Suggest</i>\" if initial sex option not taken: 
	if(later) {
		output("You smile coquettishly and ask if [benoit.heShe]'s interested in taking your new body for a... test drive.  ");
		//(6'6 or less: 
		if(pc.tallness <= 78 && !pc.isTaur()) output("The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and hoists you over [benoit.hisHer] shoulder.  You squeal in mock terror as [benoit.heShe] hauls you as fast as [benoit.heShe] can into the back room, knocking over half [benoit.hisHer] stock as [benoit.heShe] does.");
		else output("The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and frenetically attempts to hoist you over [benoit.hisHer] shoulder.  You are far too big for [benoit.himHer] though; after several valiant attempts, [benoit.heShe] collapses against a shelf.  Laughing, you pick the stricken, panting reptile up, hoist [benoit.himHer] over your own shoulder, and navigate a path into the back room.");
		output("\n\n");
	}
	if(!pc.isTaur()) {
		//Both go to: [>6'6: 
		if(pc.tallness > 78) output("You haul your lizard boy into the cramped space of the backroom before gently setting [benoit.himHer] down.  Now that your gut has settled you feel imbued with an odd, ripe sensation; your belly bulges ever-so-slightly with unfertilized eggs and you feel red, soft and ready.  You begin to disrobe eagerly; having recovered himself slightly, [benoit.short] shrugs out of [benoit.hisHer] trousers, reaching out to you before stopping.  Grinning kindly at the emasculated basilisk, you lower yourself onto the floor, spread your [pc.hips] casually and then ask if [benoit.heShe] see... smells anything interesting.");
		else output("[benoit.short] staggers into the back room, bumping into several things as [benoit.heShe] sets you down, thankfully onto a clear space on the ground.  [benoit.HeShe] leans into you, [benoit.hisHer] weight pushing you onto the ground, hands flying over your [pc.gear], fumbling off clasps and belts when [benoit.heShe] finds them.  Now that your gut has settled you feel imbued with an odd, ripe sensation; your belly bulges ever-so-slightly with unfertilized eggs and you feel red, soft and ready.  You work with [benoit.himHer], wriggling out of your clothes and ripping [benoit.hisHer] own trousers off, spreading your [pc.hips] eagerly as [benoit.hisHer] long, smooth prick springs to attention.");
		
		output("\n\nThe basilisk needs no further invitation.  In a moment [benoit.heShe] is upon you, [benoit.hisHer] tight, muscled chest pressed against your [pc.chest], [benoit.hisHer] flat stomach rubbing over your own fertile belly and the head of [benoit.hisHer] dick pushed against your moist lips.");
		if(pc.hasCock()) output("  [benoit.HeShe] deliberately rubs himself up and down your body, and the [pc.cock] trapped between your warm bodies quickly hardens against the warm, smooth friction.");
		output("  Despite [benoit.hisHer] blindness, [benoit.heShe] slides straight into your moist depths, making you coo as [benoit.hisHer] hard, smooth spur glides across your sensitive walls, slowly bringing himself out before thrusting himself in again, working more and more of [benoit.hisHer] length into you.  Never quite able to control himself around your body, it's obvious in the strain in [benoit.hisHer] face and the raggedness of [benoit.hisHer] breath against your skin that [benoit.heShe] is exercising every restraint [benoit.heShe] has not to fuck you into the ground; [benoit.heShe] pushes [benoit.hisHer] dick upwards with each return thrust to bump deliberately against your [pc.clit], sending irresistible spasms of pleasure chiming through you.  Pushed inexorably upwards you curl an arm around [benoit.hisHer] neck, kiss [benoit.hisHer] nose and grit your teeth, then whisper into [benoit.hisHer] ear to stop holding back.  [benoit.short] pauses for a moment to gather [benoit.hisHer] breath, hilted entirely in your wet cunt, then hooks [benoit.hisHer] hips around yours, entrapping you around [benoit.hisHer] body, before beginning to fuck your softened, ripe body like a jackhammer.  [benoit.HeShe] pounds into you with everything [benoit.heShe]'s got, clenching you as your gushing [pc.vagina] deliriously spatters fluids across your entwined bodies.  Lost in rut now, [benoit.short] licks your face with [benoit.hisHer] long tongue, the soft, sticky pressure against your reddened cheeks only seeming to make the contrasting sensation of [benoit.hisHer] long prick taking you deep even more overwhelming.");
		pc.cuntChange(0, benoit.cockVolume(), true, true, false);
		
		output("\n\nYou cannot stop yourself from screaming as your orgasm hits, your pussy clenching and wringing [benoit.short]'s smooth dick as [benoit.heShe] continues to slam himself into you until [benoit.heShe] can take your milking no longer and cums in sympathy, clutching you as [benoit.heShe] fountains thick, warm cum into your fertile depths.  Having your lower body held in place like this makes your orgasm all the more overpowering; you wriggle futilely against the basilisk's strong legs, unable to thrash away the unbearable pleasure.");
		
		output("\n\nAfter minutes of being locked in orgasm together, you finally ride the last of it out.  You stay entwined for the moment, your hands roaming over each other as you enjoy the afterglow.");
		
		output("\n\n\"<i>Do you sink it will really work?</i>\" says [benoit.short] eventually, [benoit.hisHer] voice so low it is barely above a murmur.  \"<i>What if I can only give you males?</i>\"  The thought has already occurred to you, but right now you are feeling in a playful mood.  [benoit.HisHer] dick is still inside you and has barely softened, despite the volume of cum it is plugging into you; grinning, you push into [benoit.hisHer] chest and slide your legs over [benoit.himHer] until you are on top of [benoit.himHer].  You very slowly work your hips in a circular motion, back and forth, deliberately working the cock wedged inside of you until it starts to inexorably harden again; [benoit.short] closes [benoit.hisHer] eyes and grunts as you abuse [benoit.hisHer] aching sex.  Not willing to let [benoit.himHer] simply sit back and take it, you slide your grip around [benoit.hisHer] wrists and silently place them on your [pc.nipples].  [benoit.HeShe] dumbly gets to work, gingerly moving [benoit.hisHer] hands, [benoit.hisHer] fingers pressing deep into your flesh.  As [benoit.heShe] brushes and squeezes you softly tell [benoit.himHer] that whether or not you are able to give birth to female basilisks, [benoit.heShe]'s the father to your children now, and that mommy needs - you thrust your hips as far as you can, bending [benoit.hisHer] dick backwards to make your point - service.  Lots and lots of service.  Driven by your words and your merciless sex, [benoit.short] closes [benoit.hisHer] eyes, squeezes your nipples between [benoit.hisHer] fingers and helplessly orgasms a second time, spurting one or two more gobs of cum into you before [benoit.hisHer] cock flexes fruitlessly against your sopping walls.");
		
		output("\n\nHaving milked your stud entirely dry, you dismount, clean yourself up and get dressed.  Before you can leave, [benoit.short] feels around and pulls you into a tight hug.");
		
		output("\n\n\"<i>Bring ze eggs 'ere,</i>\" [benoit.heShe] says huskily.  \"<i>'Owever zey turn out, I would be honored to raise ze shildren of such a woman as you.</i>\"  You give [benoit.himHer] a playful punch and say [benoit.heShe] may regret those words when [benoit.heShe]'s got a dozen tiny, scaly yous tearing up [benoit.hisHer] shop.  You part and take your leave, [benoit.hisHer] hoarse, slightly scared laughter in your ears.");
	}
	else {
		output("You haul your lizard boy into the cramped space of the backroom before gently setting [benoit.himHer] down.  Now that your gut has settled, you feel imbued with an odd, ripe sensation; your horse belly bulges ever so slightly with unfertilized eggs and you feel red, soft and ready.  You begin to shrug your clothes off eagerly; having recovered himself slightly [benoit.short] shrugs out of [benoit.hisHer] trousers, reaching out to you before stopping, blushing furiously.  Grinning kindly at the emasculated basilisk, you lower yourself onto the floor, flare your [pc.hips] casually and then ask if [benoit.heShe] see... smells anything interesting.");
		output("\n\nThe basilisk needs no further invitation.  In a moment [benoit.heShe] is upon you, [benoit.hisHer] tight, muscled chest is pressed against your [pc.ass], [benoit.hisHer] hands moving over your own fertile belly and the head of [benoit.hisHer] dick pushed against your moist [pc.vagina].");
		//[Herm:
		if(pc.hasCock()) output("  [benoit.HeShe] deliberately moves [benoit.hisHer] hand over [pc.oneCock] before trapping it in [benoit.hisHer] warm grasp.   It quickly hardens against [benoit.hisHer] warm, smooth friction.");
		output("  Used to your body now despite [benoit.hisHer] blindness, [benoit.heShe] slides straight into your moist depths, making you coo as [benoit.hisHer] hard, smooth spur glides across your sensitive walls, slowly bringing himself out before thrusting himself in again, working more and more of [benoit.hisHer] long length into you.   Never quite able to control himself around your body, it's obvious in the strain of the muscles pressed against you and the raggedness of [benoit.hisHer] breath upon your skin that [benoit.heShe] is exercising every restraint [benoit.heShe] has not to fuck you into the ground; [benoit.heShe] pushes [benoit.hisHer] dick downwards with each return thrust to bump deliberately against your [pc.clit], sending irresistible spasms of pleasure chiming through you.  You slowly move forwards until your arms are braced against the wall, before gritting over your shoulder to [benoit.himHer] to stop holding back.  [benoit.short] pauses for a moment to gather [benoit.hisHer] breath, hilted entirely in your wet cunt, then hooks [benoit.hisHer] strong arms around your back end, entrapping you around [benoit.hisHer] body, before beginning to fuck your softened, ripe body like a jackhammer.  [benoit.HeShe] pounds into you with everything [benoit.heShe]'s got, clenching you as your gushing [pc.vagina] deliriously spatters fluids across your entwined bodies."); 
		pc.cuntChange(0, benoit.cockVolume(), true, true, false);

		output("\n\nYou cannot stop yourself from screaming as your orgasm hits, your pussy clenching and wringing [benoit.short]'s smooth dick as [benoit.heShe] continues to slam himself into you until [benoit.heShe] cannot take your milking any longer and cums in sympathy, clutching you as [benoit.heShe] fountains thick, warm cum into your fertile depths.  Having your lower body held in place like this makes your orgasm all the more overpowering; you wriggle futilely against the basilisk's strong legs, unable to thrash away the unbearable pleasure.");
		
		output("\n\nAfter what seems like hours of being locked in orgasm together, you finally ride the last of it out.  You stay entwined for the moment, your hands roaming over each other as you enjoy the afterglow.");
		
		output("\n\n“Do you sink it will really work?” says [benoit.short] eventually, [benoit.hisHer] voice so low it is barely above a murmur. “What if I can only give you males?”  The thought has already occurred to you, but you are feeling in a playful mood.  [benoit.HisHer] dick is still inside you and has barely softened, despite the volume of cum it is plugging into you; grinning, you push backwards, sitting yourself down so that [benoit.heShe] is trapped under your bestial weight.  You look over your shoulder and lock eyes with [benoit.himHer] as you very slowly work your powerful hips in a circular motion, back and forth, deliberately working the cock wedged inside of you until it starts to inexorably harden again; [benoit.short] closes [benoit.hisHer] eyes and grunts as you abuse [benoit.hisHer] aching sex.  You softly tell [benoit.himHer] as you wring [benoit.himHer] that whether or not you are able to give birth to female basilisks, [benoit.heShe]'s the father to your children now and that mommy needs- you thrust your hips as far forwards as you can, bending [benoit.hisHer] dick backwards to make your point - service.  Lots and lots of service.  Driven by your words and your merciless sex, [benoit.short] closes [benoit.hisHer] eyes, clutches your flanks and helplessly orgasms a second time, spurting one or two more gobs of cum into you before [benoit.hisHer] cock flexes fruitlessly against your sopping walls.");
		
		output("\n\nHaving milked your stud entirely dry, you get to your hooves, clean yourself up and get dressed.  Before you can leave, [benoit.short] feels around and pulls your upper half into a tight hug.");
		
		output("\n\n“Bring ze eggs ere,” [benoit.heShe] says huskily.  “Owever zey turn out, I would be honored to raise ze shildren of such a woman as you.”  You give [benoit.himHer] a playful punch and say [benoit.heShe] may regret those words when [benoit.heShe]'s got a dozen tiny scaly yous tearing up [benoit.hisHer] shop.  You part and take your leave, [benoit.hisHer] hoarse, slightly scared laughter in your ears.");
	}
	flags["COC.BENOIT_TESTED_BASILISK_WOMB"] = 1;
	//benoitKnocksUpPCCheck();
	//(Oviposition perk added)
	pc.createPerk("Basilisk Womb", 0, 0, 0, 0, "Enables your eggs to be properly fertilized into basilisks of both genders!");
	output("\n\n(<b>Perk Unlocked: Basilisk Womb - You can now give birth to female basilisks.</b>)");
	if(!pc.hasPerk("Oviposition")) {
		pc.createPerk("Oviposition", 0, 0, 0, 0, "Causes you to regularly lay eggs when not otherwise pregnant.");
		output("\n(<b>Perk Unlocked: Oviposition - You will now regularly lay unfertilized eggs.</b>)");
	}
	//if (pc.pregnancyType == PregnancyStore.PREGNANCY_BASILISK) pc.knockUpForce(PregnancyStore.PREGNANCY_BENOIT, pc.pregnancyIncubation);
	pc.loadInCunt(benoit);
	//doNext(returnToCampUseOneHour);
	pc.orgasm();
	//dynStats("sen", -2);
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//PC laying
//happens only at night, after all other night events
//PC lays 2 eggs per 10 points of Fertility they have
public function popOutBenoitEggs(pregSlot:int):void {
	clearOutput();
	if (flags["COC.BENOIT_EGGS"] == undefined) flags["COC.BENOIT_EGGS"] = 0;
	var pData:PregnancyData = pc.pregnancyData[pregSlot] as PregnancyData;
	
	if (!pc.hasVagina(pregSlot)) {
		pc.createVagina();
		pregSlot = pc.vaginas.length - 1; // failsafe
		output("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a [pc.vagina " + pregSlot + "].");
		output("\n\n");
	}
	
	output("A sudden pressure in your belly rouses you, making you moan softly in pain as you feel your womb rippling and squeezing, the walls contracting around the ripe eggs inside you. You drag yourself from your bedding, divesting yourself of your lower clothes and staggering out into the middle of the camp.  Squatting upright, you inhale deeply and start to concentrate.");
	
	output("\n\nA thick, green slime begins to flow from your stretched netherlips, splatting wetly onto the ground below you and quickly soaking into the dry earth.  You settle easily into the rhythm of pushing with your contractions and breathing deeply when they ebb.  The eggs inside you move quickly, lubricated by the strange slime that cushioned them in your womb; sized and shaped just right, the pressure of their passage stretches you in the most delightful way, your [pc.clit] growing erect ");
	if(pc.hasCock()) output("and [pc.eachCock] starting to leak pre-cum ");
	output("as you find yourself being moved to climax by the birthing.  You see no point in resisting and reach down to begin fiddling with yourself, moaning in pain-spiked pleasure as the stimulus overwhelms you.  With an orgasmic cry, you release your eggs into the world amidst a gush of femcum");
	if(pc.hasCock()) output(" and a downpour of semen");
	output(".");
	
	output("\n\nWhen you find yourself able to stand, you examine what it is you have birthed: " + num2Text(pData.pregnancyQuantity) + " large, jade-colored eggs, the unmistakable shape of reptile eggs.  You pick one up and hold it gently against your ear; inside, you can hear a little heart, beating strong and quick; [benoit.short]'s child and yours.  You place the egg back down and gather them all up, moving them closer to the campfire to warm while you recover from your exertions.");
	
	output("\n\nWhen the light of day breaks, you gather your newly laid clutch and set off for [benoit.short]'s shop.  The blind basilisk is asleep when you arrive, forcing you to bang loudly on [benoit.hisHer] door to wake [benoit.himHer] up.");

	output("\n\n\"<i>What is it?!</i>\" [benoit.heShe] snarls, displaying [benoit.hisHer] fangs when [benoit.heShe] pops [benoit.hisHer] head irritably out of the door.  [benoit.HeShe] stops and inhales through [benoit.hisHer] nose, starting lightly when [benoit.heShe] recognizes your scent.  \"<i>Oops!  [pc.name], I am zo sorry, I did not think it would be you.  But why are you here at such an early hour?</i>\"");
	
	output("\n\nYou smile at your blind lover and tell [benoit.himHer] that [benoit.heShe]'s a father");
	if(flags["COC.BENOIT_EGGS"] > 0) output(" once more");
	output(".  Well, [benoit.heShe] will be when this ");
	if(flags["COC.BENOIT_EGGS"] > 0) output("latest ");
	output("clutch hatches, anyway.");
	
	//First Time: 
	if(flags["COC.BENOIT_EGGS"] == 0) {
		output("\n\nHe beams with joy, then looks confused.  \"<i>But... why have you brought zem 'ere?</i>\" [benoit.heShe] questions.");
		
		output("\n\nYou explain that you don't feel your camp is safe enough to keep them there, and [benoit.short] nods.  \"<i>Yes, I can see your point... come, give zem 'ere, and I shall look after them for ze both of us.</i>\"");
		
		output("\n\nHe opens the door and offers [benoit.hisHer] hand to help lead you in.  [benoit.HeShe] feels around the clutter of [benoit.hisHer] store room until [benoit.heShe] finds what [benoit.heShe]'s looking for: a battered old basket stuffed with a soft pillow.  You raise an eyebrow at the liberal amounts of dog hair the pillow is covered with and [benoit.short] coughs apologetically.");
		
		output("\n\n\"<i>'E isn't 'appy about me taking 'is bed, but to 'ell wizzim; 'e always gets is 'air on everysing anyway.</i>\"  You spend some time arranging the eggs where they will be safe and warm.  Although you know they can't be, [benoit.short]'s blind eyes seem to be fixed upon the brood when you have finished.");
		
		output("\n\n\"<i>And zese eggs are different?</i>\" [benoit.heShe] says hesitantly. \"<i>I - we will 'ave... daughters?</i>\"  You shrug and say even if they aren't female, at least [benoit.heShe]'ll have some sons [benoit.heShe] can keep away from the mountain.  [benoit.HeShe] sets [benoit.hisHer] jaw and nods.");
		
		output("\n\n\"<i>If zis works, [pc.name], you 'ave done my people a service I cannot repay.  Even if it doesn't, to do zis for me is...</i>\" [benoit.heShe] gestures futilely as words fail [benoit.himHer].  \"<i>All zis time I 'ave been trading potions, I could 'ave done it myself, and I never did.  Per'aps I sought I was too much a man or somesing.  Pah!  I was a coward, a cringing coward.  You 'ad ze idea, you 'ad ze courage, you 'ad ze strength, and because of zat, my people 'ave a chance.  Sank you.</i>\"  [benoit.HeShe] sounds slightly choked, and stops for a moment.  \"<i>It is very, very little, but for you I buy and sell sings at zeir true value.  If zeir is anysing I can do for you, ever, please just say.</i>\"  You are slightly embarrassed by [benoit.hisHer] effusiveness and mumble something.  Perhaps aware of the awkwardness, [benoit.short] gestures to the corner where [benoit.heShe] has put together a serviceable stove from scrap.\n\n\"<i>'Ungry?</i>\"");
		output("\n\nYou linger long enough to share breakfast with [benoit.himHer], and then return to camp.");
		
		benoit.buyMarkdown = 0.5;
		benoit.sellMarkup = 1.66;
	}
	//Subsequent: 
	else {
		output("\n\nBenoit smiles proudly.  \"<i>I cannot zank you enough for zis.  Do not worry, I shall keep zem as safe as I ave ze ozzeir clutches.</i>\"\n");
	}
	
	pc.orgasm();
	flags["COC.BENOIT_EGGS"] += Math.floor(pData.pregnancyQuantity);

	processTime(timeUntil(10 * 60));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Feminising

//Opening Talk
//Requires: Affection 40+, Have already talked to Benoit at least once, have not had sex with Benoit
public function femoitInitialTalk():void
{
	clearOutput();

	output("You ask [benoit.short] if [benoit.heShe] has ever thought about trying to do something to help [benoit.hisHer] people's plight.");

	output("\n\nThe basilisk is silent for a time, running [benoit.hisHer] claws along the counter pensively.  \"<i>Yes,</i>\" [benoit.heShe] says eventually, in a quiet tone.  \"<i>I 'ave.  Away from ze mountains, I 'ave 'ad time to sink.  I am not ze demons' slave anymore, and I am a funny joke of a basilisk anyway, so I 'ave often thought about making certain... zacrifices.  If we 'ad just one female, away from zeir corruption, zen...</i>\" [benoit.heShe] tails off, shrugging unhappily.  \"<i>But I just torment myself sinking about zis, [pc.name].  Ze demons made us very resistant to change.  I would need somesing very powerful for me to become... somesing useful.</i>\"");

	if (pc.IQ() >= 60)
	{
		output("\n\nYou reckon that even a resistant creature could be made to transform to the opposite sex, with a strong enough potion, and ask [benoit.short] about it.");

		output("\n\n\"<i>Well... if you got a double dose of purified zuccubus milk, a large pink egg, zome ovi-elixir and some reptilum, you could probably do it...</i>\"");

		output("\n\n(\"<i>Feminize</i>\" option added to [benoit.short]'s menu.)");

		flags["COC.FEMOIT_UNLOCKED"] = 1;
	}
	else
	{
		output("\n\nYou rack your brain but can't think of anything that could help [benoit.short], so end up simply sympathising with [benoit.himHer].  \"<i>Do not beat yourself up over it,</i>\" says the basilisk, with a smile.  \"<i>It is a foolish dream.  And anyway, I told you: we are a race of bastards.  We are ze last guys who deserve someone sinking after us.</i>\"");
	}
}

// Feminise

public function benoitFeminise():void
{
	clearOutput();

	// Ingredients not in inventory
	if (!pc.hasItem(new CoCSucMilkPure(), 2) || !pc.hasItem(new CoCPinkEggLarge()) || !pc.hasItem(new CoCOvipositionElixir()) || !pc.hasItem(new CoCReptilum()))
	{
		output("You don't have the necessary ingredients to attempt this yet.");
		output("\n\n<b>(Requires 2x Purified Succubus Milk, 1x Large Pink Egg, 1x Ovi Elixir, 1x Reptilium.)</b>");
		addNextButton(benoitIntro)
	}
	else
	{
		pc.destroyItem(new CoCSucMilkPure(), 2);
		pc.destroyItem(new CoCPinkEggLarge(), 1);
		pc.destroyItem(new CoCOvipositionElixir(), 1);
		pc.destroyItem(new CoCReptilum(), 1);
		
		output("You ferret out the ingredients you have collected and begin to bang them onto the counter in front of [benoit.short], telling [benoit.himHer] that you've got what [benoit.heShe] needs.  Pierre barks excitedly at the noise.");

		output("\n\n\"<i>I - what?</i>\" the basilisk says, bewildered.  \"<i>But... [pc.name], zat was just fantasy!  I was not expecting you to...</i>\"  [benoit.HeShe] lapses into silence as you grab a pewter bowl from a nearby shelf and a wooden spoon from a container full of old utensils, and begin to mix the various ingredients together.  You crack the egg against the bowl and then beat it into the milk; the goop takes on a pink cake-mix texture until you pour in the ovi-elixir, which thins it as well as filling the close market stall with a rather bad, sulfuric smell.  Carefully you drip in the reptilum whilst continuing to stir; eventually the liquid in front of you takes on a livid lime color.  When the scent changes to that of cooking sherry you stop and step back to admire your handiwork, before pushing the bowl gently across the counter until it touches the basilisk's claws.  [benoit.HeShe] slowly clasps [benoit.hisHer] fingers around it, staring blindly into the concoction.");

		output("\n\n\"<i>And you sink zis will actually work?</i>\" [benoit.heShe] says eventually.  \"<i>Zat it will... change me?</i>\" You honestly have no idea - and you're quite glad [benoit.short] can't see the color of it - but you tell [benoit.himHer] as confidently as you can that it will.  [benoit.HeShe] sighs raggedly, [benoit.hisHer] claws trembling slightly.  \"<i>Oh well, what is the worst that it could do - make me deaf?</i>\"  A look of horror settles on [benoit.hisHer] face as the words leave [benoit.hisHer] mouth, but [benoit.heShe] manages to shake the thought away and lifts the bowl to [benoit.hisHer] lips.  \"<i>Sante,</i>\" [benoit.heShe] manages with a small smile, and then drinks.");

		output("\n\nYou watch as the potion slides into [benoit.hisHer] mouth and down [benoit.hisHer] gullet.  When it is all gone [benoit.heShe] sets the bowl down and licks [benoit.hisHer] lips thoughtfully.");

		output("\n\n\"<i>Well... not ze worst sing I have ever tasted,</i>\" [benoit.heShe] says. \"<i>It could 'ave used more alcoh-hol zo.  Uh.  Uhhhhhhh...</i>\"  [benoit.HeShe] clenches the desk as a tremendous gurgling sound emanates from [benoit.hisHer] gut.  Pierre whines, and unconsciously both you and the dog back away from the basilisk as [benoit.heShe] begins to twitch and spasm.  There is a grinding noise as [benoit.hisHer] bones begin to shift; although [benoit.heShe] is holding onto the counter as hard as [benoit.heShe] can, [benoit.heShe] cannot stop knocking bottles and trinkets onto the floor as [benoit.hisHer] flesh begins to move.  [benoit.HisHer] torso sucks in, a great deal of mass moving downwards; the sound of long johns giving at the seams trades with an unpleasant cracking and popping sound as [benoit.hisHer] shoulders shift inwards.  There is a sprouting sound as iridescent red feathers emerge upon [benoit.hisHer] crown; below [benoit.hisHer] clenched teeth and eyes, [benoit.hisHer] jaw line softens and moves upwards.  The basilisk's now slighter front bulges faintly, and with that the transformation stops, or at least the transformation you can readily observe.  Judging by the way [benoit.hisHer] gut continues to groan and the way [benoit.heShe] continues to clutch the wooden surface hard enough to leave yet more claw marks, something fairly significant is happening in the ruins of [benoit.short]'s long johns.");

		output("\n\n\"<i>Zut.  Fucking.  Alors,</i>\" the basilisk manages at last.  The creature's voice has gone up by several octaves; although it is still deep, it now sounds rather... husky.  \"<i>Zat was almost as bad as zat time I tried goblin food.  Is... is zat me?</i>\" [benoit.short] puts a claw to [benoit.hisHer]... no, her throat in a panic.  Her hands then roam downwards and upwards, each new protuberance and crevice discovered amplifying her disquiet.  \"<i>Zis... zis can't be real,</i>\" she mutters.  \"<i>Zis can't actually 'ave 'appened...</i>\"  She turns as if to try and shake herself out of a dream, and knocks over a pile of books with her behind.  Your one salient thought as you watch is that whatever else you've managed to do to the blind basilisk, she certainly has it going on now.  She stands in the fairly impressive mess the two of you have created wringing her hands, apparently unwilling to move her new physique around for fear of knocking over even more of the stock.");

		output("\n\n\"<i>C... could you come back tomorrow?</i>\" says [benoit.short] unevenly.  \"<i>Zis is... I need some time to get my 'ead around zis.</i>\"  You put the books back on the counter, scratch a terrified-looking Pierre behind the ear, and take your leave.");

		flags["COC.FEMOIT_NEXTDAY_EVENT"] = days + 1;
		flags["COC.FEMOIT_NEXTDAY_EVENT_DONE"] = 1;

		addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
	}
}

public function femoitNextDayEvent():void
{
	clearOutput();

	flags["COC.BENOIT_STATUS"] = 1;
	flags["COC.FEMOIT_NEXTDAY_EVENT_DONE"] = 2;
	
	benoit.short = "Benoite";
	benoit.femininity = 75;
	benoit.hipRatingRaw = 12;
	benoit.buttRatingRaw = 8;
	benoit.hairLength = 4;
	benoit.breastRows[0].breastRatingRaw = 1;
	benoit.createVagina();
	benoit.shiftVagina(0, GLOBAL.TYPE_SNAKE);
	
	benoit.buyMarkdown = 0.5;
	benoit.sellMarkup = 1.66;
	
	output("A strange, faint sound is emanating from the salvage shop.  It's only when you duck cautiously into the stall proper that you realize it's the sound of a basilisk humming.  [benoit.short] stops to sniff the air when you come in, immediately puts down the mug she is polishing, and beckons you inside.");

	output("\n\n\"<i>[pc.name]!</i>\" she says brightly.  \"<i>Do not be standing around zere!  Come in, I want to talk to you.</i>\"  You work your way to the counter and take her in.  She is wearing a beret instead of a fez, and an apron over her front, which combine to more or less disguise her new feathers and small, ornamental chest bumps.  However it is easy, or at least it is to you, to notice in the basilisk's jaw-line and considerable new hips and butt that her gender has definitely changed... you can only assume that her sex has as well, concealed under that apron.  She doesn't seem to mind you checking her out, or maybe she just doesn't realize.  You ask how Ben- you stop.");

	output("\n\n\"<i>You can call me Benoite.  Ben - oy,</i>\" she says, smiling.  \"<i>Zat is easy to adapt to, yes?  And I am fine.  Better zan fine; your potion worked perfectly.  I feel like I 'ave a new life now - before I was a sad excuse of a basilisk, going nowhere.  Now I 'ave a purpose.  A raison d'etre.  Also, being female 'as made me realize 'ow badly zis place needs a clean.  I get more customers now!</i>\"");
	
	output("\n\nShe leans across the counter, her smile fading.  \"<i> Seriously, [pc.name], you 'ave done my people a service I cannot repay.  I can lay eggs, zere can be more female basilisks, away from Lethice and 'er thugs.  All zis time I 'ave been trading potions, I could 'ave done it myself, and I never did.  Per'aps I sought I was too much a man or somesing.  Pah!  I was a coward, a cringing coward.  You forced me to decide, and because of zat, my people 'ave a chance.  Sank you. </i>\"");
	
	output("\n\nShe sounds slightly choked, and stops for a moment. \"<i> It is very, very little, but for you I buy and sell sings at zeir true value.  If zere is anysing I can do for you, ever, please just say. </i >\"  You are slightly embarrassed by her effusiveness and mumble something along the lines of it being all her doing.  Perhaps aware of this, Benoite sits back down, hatches her fingers and smiles at you primly.  \"<i> Now... is " + pc.mf("sir", "madam") + " buying or selling? </i>\" ");

	//[Benoite buys at same rate Oswald does and sells at a 33% discount]
}

//Benoite Interactions

public function femoitFirstTimeNo():void
{
	clearOutput();
	output("You let her down as kindly as you can.");
	output("\n\n“<i>No, you are right,</i>” she says in a casual tone, although the color is still very high in her scales. “<i>It would be way too weird zat, wouldn’t it? I will find someone though, never fear.  As I said before...</i>” Benoite points two fingers at her blind eyes and then at the stall entrance.  There’s a distinct gleam in those cloudy grey depths you think would scare the hell out of most things with a penis. “<i>I ‘ave a purpose now.</i>”");
	output("\n\nCatching a subtle tone of dissapointment in Benoite's voice, you bid her a quick farewell and head back to camp, deciding to give her some time to recover.");
	
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function femoitFirstTimeYes():void
{
	IncrementFlag("COC.TIMES_FUCKED_FEMOIT");

	clearOutput();
	output("Smiling, you reach across the counter and squeeze Benoite's hands until her nervous babble dies out and she smiles back.  Still holding her hand, you move behind the crates and then gently lead her behind the stall's canopy.");

	output("\n\nWhat passes for Benoite's back office is perfect for your purposes; the two wagons between which her stall is sandwiched close together here and the triangular space is filled with crates and unsorted salvage.  You carefully inch your blind charge to a clear cranny and push her against a wooden wall, leaning into her as you gently undo her apron.  The excited bustle, thump and clatter of the carnival sounds like it's coming from a million miles away.");

	output("\n\n\"<i>Zis is so weird,</i>\" she mumbles as you drop the garment onto the packed dirt and slowly move your hands up her smooth body to take her beret; you can't imagine what's going through her head, but looking into Benoite's snub lizard face and cloudy grey eyes, you can only agree with the sentiment.  Still... your eyes are drawn to her softer jaw line, her swollen chest and her bright feathers.  The fact that you did this to her, literally emasculated her and that she now wants you to take her, touches something deep and you eagerly begin to peel off your [pc.gear], blood rushing to your groin. ");

	output("\n\n\"<i>Zis will sound strange,</i>\" says Benoite in a shivery voice, as you eventually stand before her naked, \"<i>But... would you mind if I just touched you a bit first?  All I know about you is ze sound of your voice.</i>\"  You acquiesce and draw close, sighing as she gently lays her hands upon you, holding her index claws back as she begins to move them slowly up and down.");

	benoitExploresPc();

	output("\n\nBenoite's hands travel down your torso until, with a sharp intake of breath, she touches your [pc.cock].  After a pause, she slowly wraps her dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.");
	if (pc.biggestCockLength() <= 10) output("  Although this is evidently an uncanny experience for her, she does manage a cocky smile as her hand moves around your sex.  \"<i>Mine was bigger,</i>\" she teases.  You reward her cheek by doing some feeling yourself, grasping her large, supple behind, making her squeak as you move into her.");
	else output("  This is evidently an uncanny experience for her, the alien nature of it deepening as her hands moves around your sex. \"<i>'Oly Gods, [pc.name]; you are a monster,</i>\" she says thickly.  You smile and decide it's time to do some feeling yourself; you grasp her large, supple behind, making her squeak as you move into her.");

	output("\n\nThe scent of your arousal is in the air and as Benoite inhales it in her own breath comes heavier.  Still grasping her butt, you spread her hips to reveal her genital slit, gleaming with wetness.  Bracing her against the wall, you press your [pc.cock] against her ready sex.  \"<i>Please be gentle,</i>\" says a husky, nervous voice below you.  You respond by slowly pushing open her lips and sliding your head into her warmth.");

	output("Benoite's pussy is virginally tight and you go as slowly as you can, lightly moving your hips as you work more of your length in.  Sharp claws grasp your back as you feel resistance that gives as you push more of yourself in; blood trickles down your shaft to drip onto the floor.  You keep working her slowly, withdrawing almost completely before sinking yourself in, using your head on the outward pull to tease at the clit hidden in her folds.  Benoite seems almost frozen by what's happening; she simply clutches at your back, breathing heavily and allowing you to do all the work.  You don't mind; whatever her mind is thinking her body is responding to your methodical treatment, her lips widening and slick moisture oiling your dick as you press into that tight, graspingly tight tunnel.");
	if (pc.biggestCockLength() < 15 && pc.balls == 0) output("  Eventually you manage to hilt yourself entirely in her depths, your stomach pressing against her own tight belly.");
	else if (pc.biggestCockLength() < 15 && pc.balls > 0) output("  Eventually you manage to hilt yourself in her depths, your [pc.balls] pressing into her sex as your stomach bumps into her own tight belly.");
	else if (pc.biggestCockLength() >= 15 && pc.balls == 0) output("  Eventually you manage to bottom out, your dick pressed against her cervix.");
	else if (pc.biggestCockLength() >= 15 && pc.balls > 0) output("  Eventually you manage to bottom out, your dick pressed against her cervix, your [pc.balls] swinging heavily below your shaft.");
	output("  Staying like that for a moment, you slowly withdraw almost all of the way out before pushing all the way in again, continuing the process, your grunts melding with Benoite's soft moans at the almost-agonizingly slow sex, exercising all the self-restraint you have not to begin pounding away at the basilisk's deliciously tight cunt.  Occasionally you pause at the deepest moment, waiting for your blood to cool down and letting Benoite get used to the sensation of being fully stuffed by you.");

	output("\n\nSlowly, eventually, Benoite gets into it, her frozen limbs thawing to your loving, careful movement.  Beginning to pant, she moves her powerful hips with you, trying to draw your dick further into her.  Gratefully you begin to pick up the pace, thrusting into her with increasing force.  Her claws grip your back painfully as she pushes herself into you, the soft leather of her chest bumps squeezing into your [pc.fullChest].");
	if (pc.isLactating()) output(" The pressure and arousal makes your [pc.nipples] dribble milk, spattering fluids across both of your chests.");
	output("  Soon the two of you are thrashing into each other, Benoite moaning huskily as you batter her against the wagon wall, both seeking your peak together, each pushing the other a bit further upwards.  Your world is lost to everything but the warm tightness around your [pc.cock] and the pressure against your chest.");

	output("\n\nBenoite howls as she orgasms, clutching you for dear life as she pushes as much of herself into you as she can.  The contractions around your cock are too much and with a bestial, wordless sound, you cum.  Your mind superseded by everything but that all-conquering animal imperative to breed, you hilt as much of yourself in Benoite, pushing as much of your seed upwards as you can, delivering rope after rope of cum until it dribbles out of her, dripping onto the floor to mingle with her blood.");

	output("\n\nEventually you pulse your last drop and return to yourself; slowly you lower Benoite to her feet.  She staggers slightly and clutches a stack of crates for support, your cum still beading out of her.");

	output("\n\n\"<i>Phew!</i>\" she says after she's managed to catch her breath.  \"<i>That was... somesing.</i>\" You're slightly worried you went a bit too far with her, but when she has recovered herself a bit she advances on you with a wide, blissed-out grin.  She feels around until she finds your hands.  You suppose the done thing at this point is to kiss her, but you're not entirely sure how to do that.  As you hesitate, she opens her mouth, unrolls her long tongue and licks your face.  The sensation is warm and sticky and you find yourself laughing at the strange tenderness of the gesture. ");

	output("\n\n\"<i>Sank you for zat, [pc.name],</i>\" she says huskily. \"<i>Of course, I will need you to do zat again if it doesn't take.  And again, once ze first clutch is done.  Basically we will be doing zis a lot.  Purely for ze purpose of procreation, you understand.</i>\"  Grinning, you lead her back inside the shop and after squeezing her hand, take your leave.");

	processTime(25);
	pc.orgasm();
	
	clearMenu();
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function benoitExploresPc():void
{
	//[Taur: 
	if (pc.isTaur()) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  \"<i>Good Gods,</i>\" [benoit.heShe] murmurs as [benoit.hisHer] hands lead back onto your flanks.  \"<i>Good Gods!</i>\" [benoit.heShe] cries out as [benoit.heShe] follows you all the way back to your mighty, powerful rear.  \"<i>I knew you were a taur because of all ze tramping,</i>\" [benoit.heShe] says, rubbing your flank back and forth in wonder.  \"<i>But to know it and actually feel it, zey are very different.</i>\"  [benoit.HeShe] sighs.  \"<i>Zis is going to be a bit... awkward, but I am guessing you are all too used to zat by now, yes?</i>\"");
	//[Drider:
	else if(pc.isDrider()) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  \"<i>Good Gods,</i>\" [benoit.heShe] murmurs as [benoit.hisHer] hands lead back onto your tough exoskeleton. \"<i>Good Gods!</i>\" [benoit.heShe] cries out as [benoit.heShe] follows your bulging abdomen all the way back to your spinnerets. \"<i>I knew you were a spider because of all ze click-clacking,</i>\" [benoit.heShe] says, [benoit.hisHer] fingers feeling around one of your intricate, many-jointed legs in wonder.  \"<i>But to know it and actually feel it, zey are very different.</i>\"");
	//[Demon: 
	else if(pc.demonScore() > 4 && pc.hasHorns() && pc.hasTail(GLOBAL.TYPE_DEMONIC)) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  [benoit.HeShe] touches your horns and pauses; [benoit.heShe] reaches around, finds and grips your tail, running [benoit.hisHer] pads up to the spaded point.  \"<i>So,</i>\" [benoit.heShe] says quietly.  \"<i>You are one of zem.</i>\"  [benoit.HeShe] is silent for a while before finding a warm smile.  \"<i>But I am being silly.  I know you are different inside.</i>\"");
	//[Dog enough for ears and tail: 
	else if(pc.earType == GLOBAL.TYPE_CANINE && pc.hasTail(GLOBAL.TYPE_CANINE) && pc.canineScore() >= 4) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  [benoit.HeShe] grins as [benoit.heShe] finds your floppy ears and outright laughs when [benoit.heShe] reaches around and touches your tail. \"<i>I like dogs, but not ZAT much, [pc.name],</i>\" [benoit.heShe] laughs.");
	//[Reptile/Naga: 
	else if(pc.skinType == GLOBAL.SKIN_TYPE_SCALES && (pc.lizardScore() >= 3 || pc.isNaga() || pc.dragonScore() >= 3)) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  [benoit.HeShe] starts slightly when [benoit.heShe] touches your scales, and then caresses the reptilian parts of your body with increasing interest.  \"<i>I cannot believe I did not realize you were a sister of ze scales,</i>\" [benoit.heShe] says huskily.  \"<i>Zat is very... interesting.</i>\"  You can see real arousal in the tense lines of [benoit.hisHer] face now.");
	//[Cat/Bunny enough for ditto: 
	else if((pc.bunnyScore() >= 4 && pc.earType == GLOBAL.TYPE_LAPINE && pc.hasTail(GLOBAL.TYPE_LAPINE))
		|| (pc.felineScore() >= 4 && pc.earType == GLOBAL.TYPE_FELINE && pc.hasTail(GLOBAL.TYPE_FELINE))
		|| (pc.vulpineScore() >= 4 && pc.earType == GLOBAL.TYPE_VULPINE && pc.hasTail(GLOBAL.TYPE_VULPINE))) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  [benoit.HeShe] grins as [benoit.heShe] finds your ears, outright laughs when [benoit.heShe] reaches around and touches your soft tail.  \"<i>I always wondered why Pierre gets all excited when 'e sees you,</i>\" [benoit.heShe] chuckles huskily.");
	//[Avian with wings and feet:  
	else if(pc.harpyScore() >= 4 && (pc.hasWings(GLOBAL.TYPE_AVIAN) || pc.hasWings(GLOBAL.TYPE_DOVE)) && pc.legType == GLOBAL.TYPE_AVIAN) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  [benoit.HeShe] finds your wings and follows them up as far as [benoit.heShe] can reach, making you twitch as [benoit.heShe] caresses your delicate pinfeathers; [benoit.heShe] carefully shifts [benoit.hisHer] feet forward to touch at your own clawed toes.  \"<i>So,</i>\" [benoit.heShe] sighs, a smile playing on [benoit.hisHer] lips as [benoit.heShe] touches your shoulder.  \"<i>What is in front of me is a terrible 'arpy.  Come from ze skies to ravish me.</i>\"");
	//[Bee: 
	else if(pc.zilScore() >= 4 && (pc.hasWings(GLOBAL.TYPE_BEE) || pc.hasWings(GLOBAL.TYPE_SMALLBEE) || pc.hasWings(GLOBAL.TYPE_DRAGONFLY) || pc.hasWings(GLOBAL.TYPE_SYLVAN) || pc.hasWings(GLOBAL.TYPE_DARK_SYLVAN)) && pc.hasLegFlag(GLOBAL.FLAG_CHITINOUS)) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  [benoit.HeShe] finds your diaphanous wings and follows them up as far as [benoit.heShe] can reach, [benoit.hisHer] grip on your sensitive membranes making you twitch a bit; then [benoit.heShe] sends [benoit.hisHer] hands trailing down your carapace-armored limbs.  \"<i>I sought you just liked wearing big boots,</i>\" [benoit.heShe] murmurs.  \"<i>But zis is actually a part of you?  'Ow... interesting.</i>\"");
	//[Slime: 
	else if (pc.isGoo()) output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  \"<i>I knew you were different from ze squishy sounds you made,</i>\" [benoit.heShe] murmurs as [benoit.hisHer] hands sink into your soft, amorphous mass.  \"<i>But zis is...good Gods, zis is strange.  And zis doesn't 'urt you at all?</i>\" [benoit.heShe] asks incredulously as [benoit.heShe] gently pokes a finger into you.  You answer [benoit.hisHer] question by giggling.  \"<i>Zat must come in very useful,</i>\" [benoit.heShe] says, shaking [benoit.hisHer] head in wonder.  You push yourself slowly up [benoit.hisHer] arms and tell [benoit.himHer] [benoit.heShe] has no idea.");
	//[Catch-all:
	else output("\n\n[benoit.HisHer] warm fingers travel over your body, brushing over your face, your belly, your [pc.hips]; you feel as though you're being read like a book.  \"<i>You 'umans are so squishy, fuzzy and 'ot,</i>\" [benoit.heShe] says huskily. \"<i>'Ow can you stand it?</i>\"");
}

// Subsequent Sex
// Requires: Benoite not pregnant
public function femoitSexIntro():void
{
	clearOutput();
	output("Once again, you take Benoite's hand and lead her into the back room.  Your free hand roams underneath her apron as you carefully pick out a path through the junk and Benoite is swiftly in on the game too; her fingers slide downwards to pinch and fondle at her favorite parts of you.  By the time you make it into the storage space you are practically falling over each other, laughing as you fumble off each other's clothes.");

	if (!benoitPreggers())
	{
		output("\n\nBenoite's fingers travel down your sides as you lift her apron off her, her warm, smooth touch eventually falling upon your [pc.cock]; already aware of every inch of you she rubs and coils you expertly, softly pumping you until your flesh is straining in her grasp. She circles a feather-light touch around your [pc.cockHead] with one finger ever so gently, grinning slyly as she does.  Grunting with need, you push her insistently down onto the packed soil, shaking out of the last of your underclothes; Benoite spreads her thighs for you, her genital lips widened and moist with readiness.");
		if (benoitInClutch()) output("  Her stomach bulges with clutch and the air is thick with female musk; the sight and smell of overwhelming ripeness speaks to your body in a way which bypasses your higher cognition entirely, sending you growling on top her, barely even hearing her giggle.");

 		output("\n\nYou cup her large, supple behind and push into her wet opening, sighing as you reach a comfortable depth before slowly sliding in and out.  Benoite's hands move over you, reminding herself of you with dry, smooth pressure as you find a slow, silky rhythm.  The basilisk arches her back and moans hoarsely as you push more and more of your wick into her depths; she moves with you, wriggling her body to gently work your [pc.cock] this way and that to enhance your sensation.");

		output("\n\n");
 		if (pc.biggestCockLength() < 15) output("Soon you are hilting yourself in her depths, making her gasp as you slap into her.");
 		else output("Soon you are bottoming out in her, making her gasp as your hulking length spreads her wide.");
 		output("  You quickly pick up the pace as you enter rut, thrusting into your basilisk lover with red-flecked abandon, her powerful thighs working with yours to make each return plunge into her warm depths more gratifying than the last.");
		
		output("\n\n");
 		if (!pc.isTaur())
		{
			output("Eventually, sweat dripping off you, you grab her thighs and heave them upwards so that you can really go to town, drawing yourself almost all the way out of her before smacking back into her,");
			if (!benoitInClutch()) output(" your stomach beating out a slapping rhythm against her own flat abdomen.  ");
			else output(" your stomach beating out a slapping rhythm against her bulging, gravid abdomen.  ");
		}
 		output("Benoite moans, squeals and eventually screams to your exertions, her fluids spurting and spattering against your groin");
 		if (pc.balls > 0) output(" and [pc.balls].  You tumble over your peak as her cunt suddenly tightens around yours, sending surge after surge of cum into her fertile depths, your body seized in a rictus of pleasure.");
 		if (pc.cumQ() >= 2500) output("  The quantity of it is such that it quickly dribbles back out around your cock and pools on the floor.");

		output("\n\nAfter you have both rode out the last of your mutual orgasm you lie for a time on the floor tangled together, enjoying the feeling of your smooth, scaly lover.");

		output("\n\n\"<i>Big, zilly stud,</i>\" she says fondly, as she moves her hands, painting a picture of you in this moment she can hold on the walls of her mind for days to come.  Eventually, you get up, redress and quietly take your leave.  In your haze you manage to feel glad that she didn't leave quite so many claw marks on your back this time.");
		
		processTime(35);
		benoitKnockUp();
		pc.orgasm();
	}
	else if (benoitRegularPreggers() && (!pc.isTaur() || (pc.isTaur() && (pc.tallness * (5/6) < pc.biggestCockLength()))))
	{
		clearOutput();
		output("Once you are both in the usual spot, neither of you waste any time undressing.  The pregnant basilisk stands there, staring blindly at you, and waiting for you to make the first move, tongue occasionally flicking past her lips to nervously wet them.");

		output("\n\nYou use this opportunity to examine your reptilian lover more closely, stepping forward and reaching out with your hands.  You gently trail your fingers across her jawline, then reach up and softly ruffle the feathery crest on her head, making her coo appreciatively.  Your fingers slide down the lines of her body to cup and stroke her small, rounded chest, and then inexorably continue onwards to the hard, round, swollen mass that is her egg-laden belly.  You place your palms flat against the distended orb, feeling the pressure that the sizable clutch is exerting on the interior of her womb, massaging her sides and making her moan softly; you'd almost swear you can hear her eggs softly clicking as you move them against each other.");

		output("\n\n\"<i>Enough foreplay; I sought zat we were going to fuck?</i>\" she playfully reprimands, and you smirk and nod your head, knowing guiltily that she can't see it.  Nimbly you skip around behind her, catching her tail and rubbing it affectionately against your cheek, then tell her to find something sturdy to support her; you want her to kneel down against it.");

		output("\n\n\"<i>So, zat is what you 'ave in mind?  Kinky " + pc.mf("boy","girl") +"...</i>\" Benoite replies.  Her long tongue flickers out to dart across your other cheek, and then she carefully lowers herself to the ground, making herself comfortable and groaning softly with relief. \"<i>I must say, zat is much more better on my poor feet... all zese eggs are 'eavy, you know?</i>\"");

		output("\n\nYou cup her buttocks, squeezing the delightfully full, feminine globes, and promise her that she'll forget all about the weight of her eggs soon enough.");

		output("\n\n\"<i>Promises, promises,</i>\" is the cheeky retort you get, which prompts you to playfully slap her right asscheek with your hand.  Your [pc.cock] is already begining to swell with arousal, and you tantalizingly brush it against the outer lips of Benoite's pussy, sliding it back and forth and occasionally bumping its tip into her swollen belly.  Soon, it's hard as a rock, and slick with both pre-cum and Benoite's feminine equivalent.  The genderbent reptilian moans and growls in the back of her throat, arching her magnificent ass towards you to make it easier for you to tantalise her, your hands instinctively moving to grope and squeeze her luscious cheeks.");

		output("\n\n\"<i>Enough with ze teasing, put ze damn thing in already!</i>\" she barks at you.  She lifts one hand off of the ground and begins to rub and squeeze her chest in frustrated pleasure.");

		output("\n\nDeciding you've had enough foreplay, you take a moment to properly position yourself and begin sliding gently into her cool, silky depths, trying to keep calm even as you work yourself deeper and deeper inside her.");
		if (pc.biggestCockLength() < 15) output("  Soon you are hilting yourself in her depths, making her gasp as you slap into her.");
		else output("  Soon you are bottoming out in her, making her gasp as your hulking length spreads her wide.");

		output("\n\nYou take a momentary pause to properly reposition yourself, placing your hands on Benoite's butt for assistance in balancing and causing her to place her free hand back on the ground, and then you begin to thrust. She groans and gasps as you slide yourself back and forth inside her, doing her best to meet your thrusts with her own, egg-laden belly sliding back and forth across the floor, the stimulation on her stretched, sensitive scales adding to her pleasure, her tail beating a tattoo of lust against your back.");

		output("\n\n\"<i>Yez!  Yez, oh, yez!  This iz zo good, [pc.name]!  Oh, fuck... I sink zat I am...</i>\"  You feel her rippling, squeezing pussy clenching tighter and tighter around you, striving to milk you dry.  \"<i>...I em c-c-cumming!</i>\" she cries out as climax ripples through her, belly jiggling against you as the pleasure makes her whole body quiver and shake.  She moans and growls throatily, then gives a gasp of relief, audibly spent...");

		output("\n\nBut you're not done yet, as enticing a display as that was, and so you continue to thrust, the juices from Benoite's orgasm making your cock wonderfully slick and easy to slide into her. Weak-kneed and overstimulated from her recent orgasm, the basilisk can only mewl and groan in equal parts pleasure and desperation.  She strives to massage and milk your cock with her wet cunt, aching to have you fill her with more of your potent seed.  The sight of her like this, her belly swollen with your fertilized clutch, down on her hands and knees and anxious to be bred anyway, is ultimately too much to resist and you find yourself exploding into the reptilian woman's snatch, triggering a second orgasm as your cum spurts inside her.");
		if (pc.cumQ() >= 2500) output("  Because her womb is already so jam-packed with eggs, the bulk of your deposit simply oozes messily back out of her, leaving her well and truly creampied.");

		output("\n\nNow it is your turn to slump down in a spent state, though you retain enough control to avoid adding any more weight to your already heavy lover.  The two of you remain there in the backgroom, gathering up your strength, letting the musk of your carnal pleasure roll over your still forms.");

		output("\n\nBenoite stirs first.  \"<i>Mmm... I guess being so pregnant is not such a bad sing if it means we can have sex like zis...</i>\" she murmurs, though it's quite obvious she intends for you to hear her. With a groan of effort, she heaves herself back upright.  \"<i>Come back and see me any time, lover-"+ pc.mf("boy","girl") +",</i>\" she tells you.  \"<i>But don't sink zat you need me to be pregnant to give me a good time, okay?</i>\"  Benoite smirks, striding across the floor and giving you a hand up before delicately flicking her tongue across your lips in a reptilian kiss.");

		output("\n\nYou redress yourself, give the trader a hand getting back to the front of the shop without knocking anything over - she may be familiar with her shop, but her distended belly still gives her problems - and then head back to camp.");
		
		processTime(35);
		pc.orgasm();
	}
	else if (benoitVeryHeavyPreggers() || benoitExtremePreggers())
	{
		clearOutput();
		if (pc.isTaur())
		{
			output("\"<i>No.  Non!  Absolutely non!</i>\" Benoite insists.  \"<i>You are my amazing stallion, [pc.name], but... it is simply too much.  Wis all zis weight on me, zere is simply no way we can do it.</i>\"");

			output("\n\nShe places a hand on you, working it up to your face cautiously until she's holding your cheek.  \"<i>Truly, I am sorry.  I am eager to see you again, my 'andsome 'orse... once our children are walking on their own feet.</i>\"");
			
			processTime(1);
			addNextButton(benoitIntro);
			return;
		}
		else
		{
			if (flags["COC.FEMOIT_SPOONED"] == undefined)
			{
				flags["COC.FEMOIT_SPOONED"] = 1;
				output("Benoite seems to peer at you, then places her clawed hand gently on her belly. \"<i>And I sought my eyes were the ones that didn't work... You can surely see how big I am, yes?  Do you really sink you could carry me for the sex?  Because there is no way I can let you sit on my lap with all zese eggs in me.</i>\"");

				output("\n\nYou assure her that you know a position that will work just fine, if she's willing to try.");

				output("\n\nThe egg-laden reptilian woman visibly thinks it over, then shrugs. \"<i>Well, I guess I'm willing to try if you are.</i>\"  She smirks softly.  \"<i>Drat zese 'ormonez; I am too 'orny for my own good.</i>\"");
			}
			else
			{
				output("Benoite smirks at you.  \"<i>Well, I guess ze last time was enjoyable enough.  Come, then; I am horny and you arrived in time to scratch my itch.</i>\"");
			}

			output("\n\nShe turns around slowly and waddles into the private part of her shop, tail waving over her admirable butt.");

			output("\n\nFortunately, Benoite sleeps in her shop these days, so you don't have to help her waddle far before she collapses gratefully into her bedding.  \"<i>Zut alors, I am such a 'og...</i>\" she murmurs, hands trying desperately to measure her huge belly.  While she is doing that, you slip out of your [pc.gear] and then quietly climb into the bed beside her.");

			output("\n\nShe starts in shock as your arms wrap around her waist. \"<i>Do not sneak up on me like zat!</i>\" she complains, her tail slapping forcefully against your [pc.ass] to emphasize her point. You apologize, but neither of you really mean what you're saying and you both know that.  You snuggle in close to your reptilian lover, pressing yourself against her back, feeling her cool scales against your [pc.skinFurScales].  Your roving hands caress her chest, making her croon at the attention, and are then drawn magnetically to her impossibly pregnant stomach.");

			output("\n\nIt's huge and heavy, solid like a rock, the scaly skin stretched so taut over the eggs inside you're certain you can actually feel them through her skin. There are too many of them jam-packed in there to actually move, though, signaling just how remarkably gravid Benoite is.  Your examinations are cut off when Benoite suddenly grinds her ass insistently against your crotch. \"<i>Ze snuggling is nice, lovair, but I am in ze mood for somesing a leetle more... active,</i>\" the basilisk comments, her tone light and airy.");

			output("\n\nYou feign offence, asking if it's so wrong for you to take such pride in having such an wonderfully, majestically fertile lover, caressing her distended belly with gentle sweeping strokes, sliding your fingers across her sensitive skin.  The basilisk moans softly, shivering with pleasure at the sensation, her tail sliding up to caress your [pc.hips]. \"<i>You are such a flatterer,</i>\" she tells you.  \"<i>Mmm... but I must confess zat zis is quite nice also...</i>\" she emphasizes her point by wriggling back against you, doing her best to nestle against your body.");

			output("\n\nOne hand continues to trace circles across her egg-laden womb, even as you move the other down to gently cup and squeeze her full bottom, rubbing the base of her tail before creeping down in between her legs. Dampness meets your probing fingers, letting you know your efforts have been rewarded, and you decide to give Benoite something a little more intense. Your [pc.cock] begins to poke into the she-lizard's luscious ass, making her laugh that oh-so-filthy laugh of hers.  \"<i>And 'ere I sought zat you were just wanting to snuggle?  Well, come on z'en, my lovair; if you sink you know 'ow to use zat properly?</i>\"");

			output("\n\nYou hold onto her swollen stomach as you maneuver your cock up under her ass, seeking her feminine orifice. After a few moments, you find yourself properly aligned and begin to gently push yourself in, being careful and patient to ensure that you are not hurting your lover in her most delicate of conditions.  She gasps and sighs as you reach a comfortable depth inside her dripping cunt; too heavy to really move herself, she must submissively take each and every thrust and release as you slide yourself in and out, working yourself progressively deeper inside of her.");

			if (pc.biggestCockLength() < 15) output("\n\nSoon you are hilting yourself in her depths, making her gasp as you slap into her.");
			else output("\n\nSoon you are bottoming out in her, making her gasp as your hulking length spreads her wide.");

			output("\n\nWith a surprising amount of languidness, you gently rock yourself back and forth inside of her, slowly drawing yourself out and then sliding back inside.  The basilisk's belly leaves her at your mercy, and you take full advantage of that, playing with her small nipples (after all, what other purpose do they have besides being used for her pleasure?) and stroking her belly.  She hisses and coos, but remains immobile; living proof of your virility, your sheer masculine potency.  Your hands cannot reach far enough to encompass all of her belly, so heavy is she with your offspring, and this merely spurs your pride and your arousal.  Only the need to avoid injuring her or her precious cargo keeps you from rutting her like a wild animal... though her desperate cries as she begs you to go faster, to do it harder, help quench the urges.  She is yours, totally and utterly, and you will have her as you want her.");

			output("\n\nSeeing that her pleas aren't getting her anywhere, Benoite manages to fight past her lust to try a different tack.  \"<i>C-Come on!  Is zis ze cock zat knocked me up?  Ze virile fuckstick zat made all zese eggs?</i>\"  She grinds her crotch into you as best she can, her slick cunt hungrily squeezing your intruding cock.  \"<i>I am not ze nervous leetle virgin anymore, [pc.name]; I am ze expectant mozzair.  Give me your cum; let me be warm and full of your seed again! Zat is, if you have ze balls to do eet?</i>\" she coos");
			if (pc.balls == 0) output(" with a smile, knowing damn well you don't, literally");
			output(".");

			output("\n\nYou can't resist it anymore; you slide yourself home in one final forceful thrust and cum, eliciting a delighted squawk from Benoite as jizz thunders from your cock into her depths, her own orgasm lost amidst the cascade of fluids churning and seething into her.  With her womb as jam-packed as it is, incapable of holding any more, the pressure just sends everything spurting back out of her cunt, drenching the pair of you in your seed.  Finally, your orgasm ends and you sigh in unison with her.");

			output("\n\n\"<i>Now zat is what I am talking about,</i>\" Benoite sighs softly.  \"<i>...I may 'ave to close ze shop early today.</i>\"");

			output("\n\nIn the end, it doesn't come to that, but it takes you quite a while to help Benoite get up, clean her off, tidy up the mess you made, and otherwise get her presentable again.  She gives you one of her reptilian kisses in appreciation, and sends you home again. ");
			
			processTime(35);
			pc.orgasm();
		}
	}
	IncrementFlag("COC.TIMES_FUCKED_FEMOIT");
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Benoite Gives Birth

public function femoitBirths():void
{
	clearOutput();
	output("As you enter Benoite's stall, you hear the sounds of gasps of pain from the backroom, mingling with the sounds of stock being knocked around. You race through and find Benoite, completely naked, leaning against a table and groaning in anguish, her tail slashing wildly through the air behind her.  \"<i>[pc.name]!  It.. it iz good zat you are here.  Ze eggs!  Zey come!</i>\"");

	output("\n\nShe lets out a howl of pain, claws digging deeply into the scarred wood of the tough old table she's leaning on, her huge belly hanging heavily over the floor. Instinct motivates you to help the soon-to-be mother of your children, and you dart around behind her.");

	// (First time: 
	if (flags["COC.FEMOIT_HELPED_LAY"] == undefined)
	{
		output("\n\nYou ask if she can think of any way for you to help her.");

		output("\n\n\"<i>Just catch ze eggs, and try to make zis stop hurting so much!</i>\" the basilisk whines, claws audibly carving into tough old wood.  She looks on the verge of hysteria.  \"<i>Why did I sink zis was a great idea?  Fuck my race, </i>nuzzing<i> is worth zis amount of pain!</i>\"");
	}
	else
	{
		output("\n\nRemembering what you did before leaves you with no doubt as to how you can help.");

		output("\n\nLooking around, you easily find an array of scrap and lost clothing, which you quickly assemble into a crude nest underneath the laboring basilisk.  It's not much, but it'll give you a place to put the eggs");
		if (benoitVeryHeavyPreggers() || benoitExtremePreggers()) output("... which is good, because you can tell there're a lot of them coming");
		output(".  That done, you squat down behind Benoite, keeping your head down to avoid having it slapped by her swishing tail, and reach up between her legs. She promptly lets out a shriek.");

		if (flags["COC.FEMOIT_HELPED_LAY"] == 1)
		{
			output("\"<i>What's the matter?</i>\" you blurt, alarmed.");

			output("\"<i>You... you 'ave cold 'ands!</i>\" she squeals, shuddering in displeasure.");
		}
		else
		{
			output("\"<i>What have I told you about warming zose hands?</i>\" she snaps angrily.");
		}
	}
	IncrementFlag("COC.FEMOIT_HELPED_LAY");

	output("\n\nYou apologize, but don't take your hands away; instead, you start to rub her netherlips, feeling how dilated they are and trying to gauge how close she is to laying.  You occasionally rub the underside of her straining, swollen stomach in an effort to provide some comfort.  Her labor is progressing fast; you're certain she'll start delivery soon.");

	output("\n\n\"<i>At least basilisks - Oh! - lay eggs!</i>\" she pants.  \"<i>It iz easier zan trying to push out a baby...</i>\" she winces as another contraction visibly ripples across her belly. \"<i>It still 'urts like 'ell, though.</i>\"");

	output("\n\nYou encourage her to breathe deeply, to try and focus on pushing in time with the contractions.  Benoite groans but does as you instruct, and within moments she is gritting her teeth as the unmistakable form of an egg bulges from her pussy");
	if (silly) output(".  It's shaped like a complex rhomboidal polygon with 15 sides.");
	else output(", the smoothly curved peak of a jade egg beginning to crest.");
	output("  With a strangled cry of orgasm tinged with pained relief, Benoite pushes it from her passage into your hands. Slick with juices, the egg makes for quite a handful and you find yourself struggling to safely cradle it within your grasp. You quickly place it into the makeshift next at her feet.");

	if (benoit.eggs >= 2)
	{
		output("\n\nFrom the continued distension of Benoite's midriff, though, it's obvious that this clutch contains multiple eggs.  She groans at the prospect, but continues to breathe and push.");

		if (benoitRegularPreggers())
		{
			output("\n\nHer labors are over quickly; the clutch isn't that big, and her muscles are already well prepared.  Soon, she's squatting over a pile of" + num2Text(benoit.eggs) + " eggs.");
		}
		else if (benoitHeavyPreggers())
		{
			output("\n\nThanks to the shape of her eggs and the fact she's already properly dilated, the rest of the clutch comes relatively quickly.  It's a pretty decent brood of children, you feel; "+ num2Text(benoit.eggs) +" eggs, all told.");
		}
		else if (benoitVeryHeavyPreggers())
		{
			output("\n\nYou're glad that giving birth is easier for Benoite than it would be for a mammal, as she needs all the help she can get.  Her huge stomach proves that she wasn't merely putting on weight as egg after egg pushes out of her stretched cunt.  By the time she's flat as a board again, you've counted her offspring; " + num2Text(benoit.eggs) + " eggs, each with a baby basilisk still growing inside it.");
		}
		else if (benoitExtremePreggers())
		{
			output("\n\nBenoite groans and moans like she's dying, but somehow finds the strength to soldier on as egg after egg after egg slides from her well-stuffed womb.  For a moment you wonder just how many she's got in there, but the cascade finally comes to an end; with a great deal of relief on both your parts.  While Benoite gasps for breath from her labors, you busy yourself counting your brood... "+ num2Text(benoit.eggs) +" eggs!")
		}
	}

	output("\n\nLaying done, Benoite heaves a great sigh of relief.  \"<i>Sank goodness zat's over,</i>\" she declares, even as she sinks to her knees, careful to avoid crushing the egg");
	if (benoit.eggs > 1) output("s");
	output(" she just laid.  You nod from behind her, and cautiously move around to give her a hug.  She is a very, very brave woman, and an even braver man for making the decision to do this in the first place.");

	output("\n\n\"<i>Flattery,</i>\" Benoite declares in her husky voice, a hint of a reptilian blush in her crest, suddenly flush against her head.  \"<i>Now, let us see ze fruits of zis crazy union, shall we?</i>\"  With your help, she repositions herself so that she can start feeling at the contents of your 'nest', allowing her to touch and count the numbers of her clutch.");

	if (benoitRegularPreggers()) output(" She sighs softly.  \"<i>A small clutch, this is... normal for my people, yes, but not very good for my mission, is it?  Still, a small step to freedom is still a step.</i>\"  She manages to smile.  \"<i>My children will be free, and that is something to celebrate.</i>\"");
	else if (benoitHeavyPreggers()) output(" \"<i>My, a nice big clutch we had together, didn't we?</i>\" she smiles, proudly.  \"<i>Yes, these will be strong children, I zink.</i>\"");
	else if (benoitVeryHeavyPreggers()) output(" \"<i>...Wow, you're quite ze stud, aren't you?</i>\" Benoite says, giving a throaty growl of lust.  \"<i>I chose well when I decided to let you fertilize my eggs... so many eggs, too.</i>\"");
	else if (benoitExtremePreggers()) output(" The basilisk stops after her counting, visibly stunned.  She recounts her eggs again, and then again, shaking her head in amazement.  \"<i>Incredible... simply, incredible.  I didn't think it was possible for one woman to lay zo many eggs!  Zut alors!</i>\"  A sudden look of horrified realization washes over her features.  \"<i>I'm going to be run off my feet with all zese little monsters, aren't I?</i>\" she murmurs to herself.");

	output("\n\nYou ask if Benoite will be alright now.");

	output("\n\nThe basilisk looks at you and smirks.  \"<i>I am not so fragile, [pc.name].  I can move like my old self again, and don't worry, I 'ave got somewhere nice and warm and safe picked out already.</i>\"  She pinches your [pc.ass], making you jump.");

	output("\n\nYou insist on helping Benoite put the egg");
	if (benoit.eggs > 1) output("s");
	output(" away safely, though, and the blind reptilian clearly appreciates the help.  Leaving her to admire her new clutch you head back to camp.");

	clearBenoitPreggers();

	processTime(50);
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Herminise Benoite.
public function benoitHerminise():void
{
	clearOutput();

	// Ingredients not in inventory
	if (!pc.hasItem(new CoCIncubiDPure(), 2) || !pc.hasItem(new CoCSucDelightPure()) || !pc.hasItem(new CoCReptilum()))
	{
		output("You don't have the necessary ingredients to attempt this yet.");
		output("\n\n<b>(Requires 2x Purified Incubi Draft, 1x Purified Succubi's Delight, 1x Reptilium.)</b>");
	}
	else
	{
		pc.destroyItem(new CoCIncubiDPure(), 2);
		pc.destroyItem(new CoCSucDelightPure(), 1);
		pc.destroyItem(new CoCReptilum(), 1);
		
		output("You tell her that she could use a new penis, just like her old form.");
		
		output("\n\nYou ferret out the ingredients you have collected and begin to bang them onto the counter in front of Benoite, telling her that you've got what she needs.  Pierre barks excitedly at the noise.");

		output("\n\n\"<i>Zis a good idea.</i>\" the basilisk says.  \"<i>Zat way, I can still lay eggs and you get to lay eggs.</i>\"  She lapses into silence as you grab a glass bottle from a nearby shelf and a wooden spoon from a container full of old utensils, and begin to mix the various ingredients together.  You pour the liquids into the glass bottle.  Carefully you drip in the reptilum whilst continuing to stir and; eventually the liquid in front of you takes on a livid lime color.  You shake the bottle to get it well-mixed.  When the scent changes to that of cooking sherry you stop and step back to admire your handiwork, before pushing the bowl gently across the counter until it touches the basilisk's claws.  She slowly clasps her fingers around it, staring blindly into the concoction.");

		output("\n\nYou instruct her to drink the concoction.  She nods and slowly drinks the concoction until the bottle is empty.  \"<i>I can feel it...</i>\" she slowly mutters.  A bulge starts to form under her robes. \"<i>Ohhh... It is coming!</i>\" she announces.  She opens her robes to reveal her new reptilian prick and a set of balls just above her vagina.  \"<i>Thank you.  Wis that, I can help you to lay some eggs,</i>\" she says.");
		
		output("\n\nYou assure her that she can do it someday when you're ready.");
		
		flags["COC.BENOIT_STATUS"] = 3; //Hermaphrodite Benoite.
		benoit.createCock(12, 0.5);
		benoit.shiftCock(0, GLOBAL.TYPE_SNAKE);
		benoit.balls = 2;
		benoit.ballSizeRaw = 2;

		processTime(25);
		clearMenu();
		addButton(0, "Next", benoitIntro);
	}
}