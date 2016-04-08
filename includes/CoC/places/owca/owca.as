import classes.Characters.CoC.CoCFarmers;
import classes.Characters.CoC.CoCTrader;
import classes.GameData.CombatManager;
import classes.GLOBAL;
import classes.Items.Drinks.CoCSheepMilk;
import classes.Items.Miscellaneous.CoCMinotaurCum;
import classes.Items.Transformatives.CoCBroBrew;
import classes.Items.Transformatives.CoCGoblinAle;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//const DECLINED_TO_VISIT_REBECCS_VILLAGE:int = 500;
//const TIMES_IN_DEMON_PIT:int = 501;
//const TIMES_REFUSED_REBECCS_OFFER:int = 502;
//const OWCAS_ATTITUDE:int = 503;
//const VAPULA_SUBMISSIVENESS:int = 504;
//const DAYS_SINCE_LAST_DEMON_DEALINGS:int = 505;
//const OWCA_UNLOCKED:int = 506;
//const REBECCS_LAST_PLEA:int = 507;
//const OWCA_ANGER_DISABLED:int = 508;

//const VAPULA_HAREM_FUCK:int = 546;
//const VAPULA_THREESOMES:int = 547;
//const OWCA_SACRIFICE_DISABLED:int = 548;
//const VAPULA_FOLLOWER:int = 549;
//const VAPULA_DAYS_SINCE_FED:int = 551;
//const VAPULA_TEASE_COUNT:int = 552;
//const VAPULA_EARNED_A_SPANK:int = 634;

include "owcaPit.as";

public function gangbangVillageStuff():void {
	clearOutput();
	if(flags["COC.OWCA_UNLOCKED"] == 1) owcaMainScreenOn();
	else gangbangVillageFirstGoRound()
}

//First encounter (Z)
private function gangbangVillageFirstGoRound():void {
	clearOutput();
	
	if(flags["COC.DECLINED_TO_VISIT_REBECCS_VILLAGE"] == undefined && flags["COC.TIMES_REFUSED_REBECCS_OFFER"] == undefined && flags["COC.TIMES_IN_DEMON_PIT"] == undefined) {
		//[Attitude is set to 50]
		flags["COC.OWCAS_ATTITUDE"] = 50;
		flags["COC.VAPULA_SUBMISSIVENESS"] = 50;
		output("You wander for quite a while in an endless field of grass before spotting a commotion in the distance.  A myriad of creatures have gathered in the path ahead, waving to you enthusiastically, some still holding tightly to their farm tools.  It's quite an odd sight, all these happy farmhands extending a warm welcome.  You simply accept it as a gesture of kindness and make your way toward the crowd of smiling faces.");
		output("\n\nA female emerges from the group to greet you and tries to communicate her intentions, holding up a peace sign.  As she approaches, her features become more apparent.  Her appearance is strikingly similar to that of a human.   Her face is pale, with the appearance of porcelain.  Gazing lower, you see that she possesses a bountiful bosom that bulges against her crude peasant dress and hips that sway with grace as she approaches nonchalantly.  Only the two little nubs on her forehead and the long, white woolen mound of her hair suggest she's anything more than a stray village girl from a human town like your own.  The rest of the crowd is of similar appearance, and they begin to follow her lead, walking towards you.  Is this a herd of sheep people?  Or, if you could dare bring yourself to say it... sheeple?");
		output("\n\nThe girl closes the distance between you with three quick strides, and swiftly plants a peck on your cheek.  You straighten up a bit in surprise at such a friendly greeting from the inhabitants of this land.  Her cool breath smells like fresh dairy milk and her eyes are glinting as she speaks.  \"<i>Greetings!  You're not from this world, are you?  We've seen many a vagabond adventurer in this land.  My name's Rebecc, and we're always happy to meet your kind!</i>\"");
		output("\n\nYour curiosity gets the better of your caution, and you admit that you're indeed a traveller from another world, then introduce yourself.");
		output("\n\n\"<i>Of course, of course.  Why don't you follow us, valiant warrior?  We were just about to return home; we could use a little company.</i>\"  As she talks you can't help but notice she keeps readjusting her dress, subtly revealing a bit more of her cleavage at every shift.  You see she also takes repeated glances at your crotch, probably thinking she's being discreet enough.  Her nipples are hardening through her dress, her smile is teasing you; her entire body language seems to be an open invitation as well as a display of seduction.");
		output("\n\nDo you follow her?");
		clearMenu();
		addButton(0, "Yes", agreeToFollowRebecFirstTime);
		addButton(1, "No", dontGoToZeVillage);
	}
	
	//As long as you don't follow her once, display this on subsequent encounters (Z)
	else if(flags["COC.TIMES_IN_DEMON_PIT"] == undefined) {
		output("After wandering across the plains for a while, you spot Rebecc, the girl you met before, amongst a group of fellow farmers; she calls out to you.  \"<i>Hello again, traveler!  You seem lost... would you mind spending some time with us at our village?</i>\"");
		output("\n\nAs before, you notice while speaking with her that she keeps glancing at your crotch for a few seconds at a time.  She puts on a sultry smile as she nudges the edges of her dress, revealing more and more cleavage each time.  She's a bit shaky as well; it's almost as if she's attempting to seduce you, but is only with difficulty able to contain herself.  Will you spend time with her in the village?");
		//Yes/No
		clearMenu();
		addButton(0, "Yes", agreeToFollowRebecFirstTime);
		addButton(1, "No", dontGoToZeVillage);
	}
	//Second (and subsequent) encounter; only happens once PC accepted being sacrificed once (Z)
	else {
		output("Using the vivid memory of your last encounter, you easily find Owca village; the first houses are in sight when you spot someone rushing to you.  You recognize Rebecc, the girl you first met in the plains and who begged you for your help.  She is smiling, her arms open for a welcoming embrace.  Before you even try to say something she is already hugging you, pressing her warm body against yours as she takes you in her arms.  She holds you tightly for a minute before kissing you everywhere affectionately; you haven't said a single word and your cheeks and lips are already bearing the mark of her lipstick.");
		output("\n\n\"<i>Thank you!  Thank you so much, [pc.name]!  You are a wonderful person!  What you did was noble and selfless.  Our people will remember you for years to come!</i>\"");
		//[if corr >= 50] 
		if(pc.cor() >= 50) output("  You can't help but smile internally.  Let her think that, if she wants.");
		output("\n\nShe grabs your hand and drags you to her village, hopping joyfully as she keeps thanking you for your heroic gesture.  You finally reach her home; a handful of people join you, attracted by the noise she's been making.  People are everywhere showing unconditional gratitude, bowing down and muttering thankful words as you go by; it's almost as if they were intimidated - or ashamed - by someone worthier than them.  Eventually you are left alone with the charming farmer girl.");
		output("\n\n\"<i>My home is yours, hero; alongside everyone else's.  You will always be welcome here.  Don't hesitate to come to my place; you must feel all dirty and sullied from these corrupted monsters.  Don't worry, I'll clean you up.</i>\"  She winks at you and walks into her house, leaving her door open as an invitation.");
		output("\n\n(<b>Owca Village added to your 'Places' menu.</b>)");
		flags["COC.OWCA_UNLOCKED"] = 1;
		clearMenu();
		addButton(0, "Next", owcaMainScreenOn);
	}
}

private function dontGoToZeVillage():void {
	IncrementFlag("COC.DECLINED_TO_VISIT_REBECCS_VILLAGE");
	processTime(10 + rand(10));
	mainGameMenu();
}

//First plea (Z)
private function agreeToFollowRebecFirstTime():void {
	clearOutput();
	if(flags["COC.TIMES_REFUSED_REBECCS_OFFER"] == undefined) {
		output("How could you refuse an invitation from such an alluring girl?  You eagerly agree to go to her village; everyone sets out at once, chatting with each other jovially, but your attention is squarely focused on Rebecc.  She seems impressed by the tales of your adventures and has nothing but praise for your endless bravery, delivered while clinging to your arm and pressing her body against yours.  Her sweet scent is invigorating, and a significant amount of blood flows toward your ");
		if(!pc.hasGenitals()) output("regretfully bare ");
		output("groin as you feel the contact of her tender curves against your body.  Taking advantage of the effect you seem to have on her, you start questioning her about her village, her people and how she was affected by demons.");
		output("\n\n\"<i>There, we've almost arrived at Owca, our village; you can see the first houses.  As for demons... well, you know, they are the reason we wanted you to follow us.  You see, a large group of them have been harassing us.  At first they were just scavenging for food and various supplies, but soon they started claiming... another kind of prize.  You know these creatures, you know what they do.  There have been many battles to protect our rightful clay and hard-earned food, but there were simply too many of them.  Besides, they often use some kind of... black magic in order to subdue their foes and turn them into obedient slaves.  ");
		//[if silly mode on]
		if(silly) output("I-I don't think there's a single grown man or woman in our village that still has their anal virginity.");
		//[if silly mode off]
		else output("Th-they abused us.  They mistreated us.  They would gather in circles and... use us in every possible way.");
		output("</i>\"");
		//[if Corr < 20]
		if(pc.cor() < 20) {
			output("\n\nYou are shocked by this revelation. You wrap your arms around Rebecc's shoulders protectively, and tell her in a reassuring tone that ");
			//[[if silly mode on]
			if(silly) output("she'll never have to worry about her asshole again.");
			//[if silly mode off] 
			else output("she will never be abused again.");
			output("  If there's anything that can be done to hold off these evil creatures, you will do it.");
		}
		//[else if corr and libido both > 60]
		else if(pc.slut() > 60 && !pc.isNice() && pc.hasCock()) {
			//[if silly mode on and presence of penis]
			if (silly)
			{
				output("\n\nYou can't help but pop an enormous boner.");
				if(!pc.isCrotchExposed()) output("  [pc.EachCock] is pressing so hard against your [pc.lowerGarment] that you're afraid that one or the other might break.  ");
			}
			//end of local silly willy condition
			else output("\n\n");
			output("You are uncontrollably turned on by this revelation; your genitals actually hurt at your absurd level of arousal.  Just imagining groups of demons gathered around the helpless villagers, sometimes taking turns with each one and sometimes taking someone all at once, turns you on way more than it should.  You stupidly grin for a few seconds as your mind pictures vivid and lecherous scenes of collective ass-rape, but then you remember this is supposed to be bad news; you quickly recompose yourself and put on a false expression of worry.  Luckily she didn't notice the lust that temporarily filled your eyes");
			if(!pc.isCrotchExposed()) output("; neither does she spot the massive tent growing in your [pc.lowerGarment]");
			output(".  You ask her if there's anything you can do to meet these demons and 'handle' them on your own.");
			//end of condition about PC's corruption
		}
		output("\n\n\"<i>Well, a man from our village decided to go meet these demons at their camp in order to negotiate with them.  They agreed to a deal.  As you may guess, it was a... special kind of deal.</i>\"");
		output("\n\nYou know what kind of deal should be expected from these wicked creatures, but you let her take her time explaining.");
		output("\n\n\"<i>At the end of every week, one of us must be chained and left at the demons' disposal for the full night.  It must be someone different every night.  Chosen people usually come back battered and sore, and they have dirty fluids and unthinkable mixtures leaking from every hole of their body.  It's a difficult thing to think about, but it's necessary for our community.  But then...</i>\"  She wavers for a moment, before looking back to you with a desperate plea in her eyes.  \"<i>You're a brave, courageous adventurer; you just said you were willing to handle these demons!  It would almost be a blessing to us if you could help - not that you have to, but... it seems like we're beyond saving.</i>\"  The girl looks despondent, but then changes her composure when she turns back to the village.  \"<i>I might be being selfish, but you'd have my eternal gratitude if you helped.</i>\"");
		//[if corr < 50 and int >= 50]
		if(pc.cor() < 50 && pc.intelligence() >= 30) {
			output("\n\nSo this is what it has come to.  Her playfulness, her enticing gestures, her seductive play... she had been planning it all along.  She must have put on the same act for many people before you.  You feel slightly angry at yourself for having been fooled that easily; you feel angrier at her because she tried to use you as a mere disposable victim to be toyed with and manipulated; but you feel angriest at these demons for forcing honest folks to resort to infamous practices and deceptive seduction so they can live their lives as usual.");
			output("\n\nBut on second thought, she's right.  You're the champion of your own village; you're supposed to be selfless and resolute.  You were sent to this cursed land to prevent further corruption; your own physical integrity does not matter when other people are at stake.  Giving in to her demands would be certainly a noble and difficult act, something your elders would be proud of.  Of course it would seem like you had fallen for her trick, but do you really care?  You ponder your choices, thinking deeply");
			if(pc.libido() > 50) output("... and considering what Rebecc meant by 'gratitude'");
			output(".  Maybe it wasn't all an act?");
		}
		//[if corr < 50 and int < 50]
		else if(pc.slut() < 50) {
			output("\n\nYour eyes widen in surprise when you understand what she's asking of you, but after all, why not?  You're the champion; you're supposed to be selfless and resolute.  You were sent to this cursed land to prevent further corruption; your own physical integrity does not matter when other people are at stake.  Giving in to her demands would be certainly a noble and difficult act, something your elders would be proud of.  Of course it would seem like you had fallen for her trick, but do you really care?  You consider your choices");
			if(pc.libido() > 50) output("... and considering what Rebecc meant by 'gratitude'");
			output(".  Maybe it wasn't all an act?");
		}
		//[if corr >= 50]
		else {
			output("\n\nSo this is what it has come to.  Her playfulness, her enticing gestures, her seductive acting... she had been planning it all along.  She was doing it all on purpose, teasing you and tricking you into accepting her offer.  She must have put on the same act for many people before you.  You feel slightly angry at yourself for having been fooled that easily; you feel angrier at her because she tried to use you as a mere disposable victim to be toyed with and manipulated.  Well, if it comes down to that, you could probably agree and either beat the demons to take their place, or help them 'renegotiate' with the villagers...");
			//[[lib>=50]
			if(pc.slut() >= 50) {
				output("\n\nOn second thought, the prospect of meeting a full horde of horny, sexually-exploratory demons has appeal all on its own.  Your mind wanders a bit, thinking of all the luscious things they could do with your body; oh, the feeling of a half-dozen cocks and pussies working your every hole and pumping fluids in and out of you... perhaps you could even take a dominant position and fuck the demons until they pass out.");
			}
		}
		output("\n\nDo you accept?");
	}
	//Subsequent pleas upon first refusal (Z)
	else {
		output("\"<i>So, have you changed your mind yet?  Will you help us?  The demons will want another sacrifice soon, and we are afraid of what might happen if we don't comply!  Please, do accept this time!</i>\"");
		output("\n\nYou know very well what these people want: some meat to appease the demons.  Will you help them?");
	}
	//Yes/No
	clearMenu();
	addButton(0, "Yes", function():* { acceptRebeccsPlea(flags["COC.TIMES_IN_DEMON_PIT"] == undefined, true); } );
	addButton(1, "No", declineRebeccsPlea);
}

//Refuse plea (Z)
private function declineRebeccsPlea():void {
	clearOutput();
	output("You can't give in to her demand; you are a proud warrior fighting demons.  You were certainly not meant to serve as a scapegoat or sex-toy.  She sighs in disappointment.  \"<i>Well, I should have expected that.  I wasn't full of hope either.  No hard feelings.</i>\"  Everyone is looking at you with sad or apathetically hostile eyes, making you feel uncomfortable.  You quickly leave the village and return to your camp.");
	//[if more than 40 int, a warning after 4 consecutive refusals]
	//if(flags["COC.TIMES_REFUSED_REBECCS_OFFER"] >= 3 && pc.inte >= 40) output("\n\nThe villagers are growing impatient of your repeated refusals; you can hear them exchange hushed whispers as you depart.  Failing to grant their request again will probably anger them considerably.");
	//[Attitude is set to 50]
	flags["COC.OWCAS_ATTITUDE"] -= 5;
	if (flags["COC.OWCAS_ATTITUDE"] < 0) flags["COC.OWCAS_ATTITUDE"] = 0;
	IncrementFlag("COC.TIMES_REFUSED_REBECCS_OFFER");
	clearMenu();
	addButton(0, "Next", function():* { processTime(15 + rand(10)); mainGameMenu(); } );
}

//Accept plea (Z)
private function acceptRebeccsPlea(firstTime:Boolean = false, sacrificed:Boolean = false):void {
	clearOutput();
	flags["COC.OWCAS_ATTITUDE"] += 10;
	if (flags["COC.OWCAS_ATTITUDE"] > 100) flags["COC.OWCAS_ATTITUDE"] = 100;
	
	output("You tell the desperate girl that you're going to do as she asks.  As soon as you finish speaking, everyone cheers and applauds you, praising you as their savior.  Rebecc grabs hold of your shoulders and gives you a soft kiss on your lips; she whispers, \"<i>Thank you, champion.  We all owe you.  I promise that you will be rewarded for the heroic deed you're about to undertake.</i>\"");
	output("\n\nA group of the farmers then proceeds to lead you across the village to a strange circle-shaped pit.  It's about one meter deep and ten meters in diameter.  At the center of the pit stands a tall wooden pole, adorned with several dangling ropes and chains.  You grimace as you realize you will be tied up and bound to the crudely fashioned post in order to make sure you don't escape before the demons show up.");
	
	//[[if corr >70 and have gender]
	if(pc.slut() > 70 && pc.hasGenitals()) {
		output("\n\nYou lick your lips in anticipation, your [pc.crotch] already slickening with sexual juices; the sight of these restraints brings all kinds of perverted thoughts to your mind: dozens of ways to be used and deliciously abused like a sex-toy by wretched and well-endowed beings.");
	}
	//[else]
	else output("\n\nYou shrug and tell yourself it was to be expected; after all, they barely know you and must be afraid that you may flee at the last moment.  Maybe some previous victims had already done so, with disastrous consequences for the village folks.");
	//end of condition
	output("\n\nThis vivid thought only helps strengthen your determination and you resolutely march toward the pit and the tall pole at the center.  As you drop into it, you notice the ground is soft, wet and has slightly whitish stains here and there.  Your nose is immediately assaulted by a strong musk that you instantly recognize – the smell of semen.  The villagers, used as they must be to working on sullied land, seem unfazed by these details.  You decide it's wiser not to make any comment and let them chain you to the pole.  They silently work for a few minutes, being careful not to knot the ropes too tightly so they don't hurt you.  At last, they give you a few encouraging pats on your shoulder; some females give you chaste kisses on your head, others wish you good luck and give you a last thankful wave, and a few seconds later they're all gone. You're left alone and naked in a sex-scented pit, bound to a post, waiting for the arrival of lustful, soulless creatures.  The villagers have retained all of your equipment in the name of keeping it safe, assuring you that it'll be returned to you the next morning.");
	output("\n\nPutting your dread aside, you close your eyes and attempt to sleep, vowing to save your strength for the ordeal that awaits you tonight.");
	//Dusk transition text (Z)
	clearMenu();
	addButton(0, "Next", intoTheDemonPit, true);
}

//Main Owca Village menu (Z)
//[displayed after the second encounter text and right away in subsequent encounters]
private function owcaMainScreenOn():void {
	clearOutput();
	setLocation("\nVILLAGE", "\nOWCA", rooms[currentLocation].system)
	
	if(flags["COC.REBECCS_LAST_PLEA"] == 1/* && !kGAMECLASS.vapula.vapulaSlave()*/) {
		rebeccsLastPlea();
		return;
	}
	
	if(flags["COC.OWCAS_ATTITUDE"] <= 5 && flags["COC.OWCA_ANGER_DISABLED"] == undefined && flags["COC.OWCA_SACRIFICE_DISABLED"] == undefined) {
		desperateVillages();
		return;
	}
	
	//Desperate plea
	if(rand(10) <= 2 && flags["COC.DAYS_SINCE_LAST_DEMON_DEALINGS"] >= 7 && flags["COC.OWCA_SACRIFICE_DISABLED"] == undefined) {
		//(30% chance of spawning upon going to the village once a week has passed since last demon fight)
		//should happen instead of the normal village menu every week
		output("The village shows unusual signs of activity.  As you walk down the main road, people are all looking at you uncomfortably.  Some try to approach you but back off awkwardly at the last moment.  You don't understand until you stumble upon Rebecc, who seems on better terms with you than the rest of the village; she is displaying a worried face.");
		output("\n\n\"<i>" +pc.short+ ", this is a difficult thing to request, especially when you've done so much for us already.  But... the demons are insatiable, of course.  They want a sacrifice every now and then, you know.</i>\"  As you slowly come around to what must be next, she grows more and more anxious.  \"<i>Could you... this time too, please?  Oh, I know I'm asking too much, but it's not us... it's them.  Please, we need your help again!</i>\"");
		output("\n\nThis time you fully understand the consequences of another sacrifice.  Do you comply?");
		//Yes: Leads to Accept Plea scene. Attitude is raised by 5.
		//No: Leads to Refuse Plea scene. Attitude is lowered by 10.
		clearMenu();
		addButton(0, "Yes", function():* { acceptRebeccsPlea(false, true); } );
		addButton(1, "No", declineRebeccsPlea);
		return;
	}
	
	//[if attitude > 80]
	if(flags["COC.OWCAS_ATTITUDE"] > 80) output("Villagers greet you as you arrive, praising your courage and your heroism.  People shake your hands or ask you to kiss them, as if they hoped your nobility were somehow contagious.  Once they're done complimenting and flattering you in every way possible, they leave you to your business.");
	//[if 60<=attitude<80]
	else if(flags["COC.OWCAS_ATTITUDE"] > 60) output("Villagers greet you with a friendly smile as you arrive.  Some approach you and thank you for what you've done, before leaving awkwardly.  They're obviously not used to strangers.");
	//[if 40<=attitude<60]
	else if(flags["COC.OWCAS_ATTITUDE"] > 40) output("Villagers seem to accept your presence without comment now; though none go out of their way to greet you, neither do they avoid doing so when you pass by.");
	//[if 20<attitude <= 40]
	else if(flags["COC.OWCAS_ATTITUDE"] > 20) output("Villagers keep looking at you uncomfortably; no one seems to be willing to talk to you apart from Rebecc, your friend.");
	//[if attitude <= 20]
	else output("Villagers here appear to be openly hostile.  You keep hearing muffled whispers as you pass by, and people look at you rancorously.  They don't bother you, though.");
	//end variable display
	output("  The village is rather small.  A dozen humble thatched cottages are standing here and there, linked by dirt tracks and enclosed with small palisades.  There seems to be very little activity.");
	output("\n\nAt the end of the main road you notice the pit and the pole standing at the middle of it.  It looks rather sinister, reminding you of the permanent curse that lies on the villagers.  It is still unguarded.");
	//[if a week has passed since last sacrifice]
	if (flags["COC.DAYS_SINCE_LAST_DEMON_DEALINGS"] == days - 7 && flags["COC.OWCA_SACRIFICE_DISABLED"] == undefined) output("  A week");
	else if (flags["COC.DAYS_SINCE_LAST_DEMON_DEALINGS"] > days - 7 && flags["COC.OWCA_SACRIFICE_DISABLED"] == undefined) output("  More than a week");
	if (flags["COC.DAYS_SINCE_LAST_DEMON_DEALINGS"] >= days - 7 && flags["COC.OWCA_SACRIFICE_DISABLED"] == undefined) output(" has passed since the last offering to the demons; guarding the pit would certainly help improve your relations with the little town's denizens.");
	
	clearMenu();
	//Option: 
	if(hours >= 16 && flags["COC.OWCA_SACRIFICE_DISABLED"] == undefined) {
		//Pit. Requires 16:00 or later. Leads to the night gangbang (with possible fight) scene, this time fully equipped and clothed. Attitude is raised by 3.
		addButton(0, "Pit", zePit);
	}
	if(flags["COC.OWCAS_ATTITUDE"] >= 50) {
		//Option: Herds, needs 50 attitude.
		output("\n\nBeyond the tiny hamlet you see herders guarding a considerable amount of sheep.  You could probably join them and ask them for work.");
		addButton(1, "Herds", owcaHerds);
	}
	output("\n\nRebecc's house is nearby, and her door is open. She would probably welcome the chance to wash away any taint you've received from your time in the pit.");
	//Option: Rebecc. Leads to Rebecc Menu
	addButton(2, "Rebecc", rebeccMenu);
	if(flags["COC.OWCAS_ATTITUDE"] >= 10) {
		output("\n\nA tavern appears to be open; various Owca folk are drinking and chatting in it.  They give you friendly waves when you make eye contact.");
		//Option: Tavern. Leads to the Tavern, needs 10 attitude
		addButton(3, "Tavern", owcaTavern);
	}
	//[Pit][Herds][Rebecc][Tavern]
	addButton(14, "Leave", function():* { processTime(10 + rand(10)); mainGameMenu(); } );
}

//Tavern (Z)
public function owcaTavern():void {
	clearOutput();
	output("The tavern is nice and cozy; there are a few tables and chairs scattered around in no ordered pattern, and most clients here appear to belong to the same species.  By the crude wooden bar, you see a list of all the current drinks on sale:\n<i>");
	//SheepMk
	//var milk:Function = createCallBackFunction(owcaBuySetup, consumables.SHEEPMK);
	output("\nSheep Milk");
	//if((180 - flags["COC.OWCAS_ATTITUDE"]) > pc.gems) milk = null;
	
	//var goblin:Function = createCallBackFunction(owcaBuySetup,consumables.GOB_ALE);
	output("\nGoblin Ale");
	//if((60 - Math.round(flags["COC.OWCAS_ATTITUDE"]/2)) > pc.gems) goblin = null;
	
	//var cum:Function = createCallBackFunction(owcaBuySetup,consumables.MINOCUM);
	output("\nMinotaur Cum");
	//if((300 - flags["COC.OWCAS_ATTITUDE"]) > pc.gems) cum = null;
	
	//var brew:Function = createCallBackFunction(owcaBuySetup,consumables.BROBREW);
	//if(rand(10) > flags["COC.OWCAS_ATTITUDE"]/10) {
		output("\nBro Brew");
		//if((2000) > pc.gems) brew = null;
	//}
	//else brew = null;
	output("</i>");
	
	processTime(3);
	clearMenu();
	addButton(0, "Buy", owcaTavernShop);
	addButton(14, "Back", owcaMainScreenOn);
}


private function owcaTavernShop():void {
	//spriteSelect(37);
	shopkeep = new CoCTrader();
	shopkeep.short = "Barkeep";
	shopkeep.keeperBuy = "The tavern is nice and cozy; there are a few tables and chairs scattered around in no ordered pattern, and most clients here appear to belong to the same species.  By the crude wooden bar, you see a list of all the current drinks on sale:";
	shopkeep.sellMarkup = 1.6 - flags["COC.OWCAS_ATTITUDE"] / 200.;
	shopkeep.inventory = [new CoCSheepMilk(), new CoCGoblinAle(), new CoCMinotaurCum(), new CoCBroBrew()];
	shopkeepBackFunctor = owcaTavern;
	buyItem();
}

//Herds (Z)
private function owcaHerds():void {
	clearOutput();
	output("The herders greet you warmly.  \"<i>Welcome, champion!  It is indeed a pleasure to have the honor to talk to such a noble and revered hero.</i>\"  You reply with equal grace and ask in a more formal tone if there's anything you can do to help them out.");
	output("\n\n\"<i>Well, our sheep badly need to be sheared and we could really use an extra pair of hands to get the work done.</i>\"  The herder proceeds to hand you some tools, and redirects you to a group of villagers working actively.  You rapidly join them and soon enough you are having a pleasant conversation, chatting and laughing as you collect the wool, so much so that you don't see where time goes; in what seems like minutes you're already done.");
	//attitude +5, int +1
	flags["COC.OWCAS_ATTITUDE"] += 5;
	if (flags["COC.OWCAS_ATTITUDE"] > 100) flags["COC.OWCAS_ATTITUDE"] = 100;
	pc.slowStatGain("i", 1);
	//[if attitude > 70]
	if(flags["COC.OWCAS_ATTITUDE"] > 70) {
		output("\n\nThe villagers thank you for your hard work and one of them hands you a bottle of sheep milk.  \"<i>'Tis good for your health.  Don't worry, it won't... mutate you.</i>\"\n\n");
		//inventory.takeItem(consumables.SHEEPMK, returnToCampUseOneHour);
	}
	processTime(30 + rand(10));
	clearMenu();
	addButton(0, "Next", owcaMainScreenOn);
}

//Rebecc Menu (Z)
private function rebeccMenu():void {
	clearOutput();
	output("You knock and step into the old shack, accustoming yourself to the meager light.  As soon as you close the door behind you, you spot Rebecc stepping out of a little backroom.");
	output("\n\n\"<i>[pc.name]!  You came!  I was just preparing a hot bath.  My poor darling, you must have gone through a really perilous ordeal.  Here, do you want to get cleaned up?</i>\"");
	//Option: Appearance: Leads to Rebecc Descrpition.
	//Option: Bath: Leads to Rebecc Bath Scene.
	//Option: Rape: Leads to Rebecc Rape scene. Ends the quest. Requires sizable corruption score.
	//Option: Leave: Redirects PC to Owca Village.
	//[Appearance][Bath][Leave][Surprise Sex!]
	processTime(3);
	clearMenu();
	addButton(0, "Appearance", rebeccAppearance);
	addButton(1, "Bath", rebeccBathScene);
	if(pc.cor() >= 66) addButton(2, "Rape", rapeRebecc, false, "Surprise Sex", "You could try and force yourself on her, but you might not be welcome in town after...");
	addButton(14, "Leave", owcaMainScreenOn);
}

//Rebecc Appearance (Z)
private function rebeccAppearance():void {
	clearOutput();
	output("Rebecc is a 5-foot, 7-inch sheep-girl, with a cute human visage decorated by two little nubby horn protrusions and plush and fuzzy curled white hair that cascades down over her shoulders.  Her face is expressive, with her glinting blue eyes and avid mouth accurately reflecting her whole range of emotions.  Her complexion is extremely pale, although the exposed parts of her body are rather tanned due to hours of labor under the scorching sun.  She is currently wearing a coarse peasant dress, a layer of thin white cloth that clearly outlines her appealing curves.  Her fine hips and legs sway with elegance when she walks and you can guess a bountiful wiggly rump hides behind the back of her gown.");
	output("\n\nShe has a pair of ample, barely concealed breasts.  Although you can't see them outright, her thin clothing leaves little doubt that they're D-cups.  Her 0.5 inch nipples point through her dress whenever she's aroused.");
	output("\n\nShe has a pussy of dubious virginity but copious wetness between her legs.  Occasionally a damp patch will appear on her dress, betraying her arousal.");
	output("\n\nYou can't see her asshole, but it's safe to assume it's placed between her squeezable buttocks, right where it belongs.");
	clearMenu();
	addButton(0, "Next", rebeccMenu);
}

//Rebecc Bath scene (Z)
private function rebeccBathScene():void {
	clearOutput();
	output("She grabs your hand and leads you to her bathroom, a tiny place almost entirely occupied by an enormous circular container acting as a bathtub, full of hot steaming milk.  You watch her, puzzled.");
	output("\n\n\"<i>What?  Don't you bathe in milk in your village?  We have plenty of it here in Owca, you know; more than clean water.  We use it for everything; it has curing properties.</i>\"  Whispering seductively, she adds, \"<i>It's also ideal for purging brave demon fighters from any taint they may have caught.</i>\"");
	output("\n\nShe stares at you with insistent and playful eyes.  \"<i>Now come on, you know where I'm going with this.  Let me help you out of your clothes.</i>\"");
	output("\n\nYou don't resist, grinning as she enthusiastically removes your [pc.gear]; in her haste she gets tangled up until you hold her hand and help her with the fastenings.  A few seconds later you're completely naked and she covers your face and torso with soft kisses as she strips off.  You both giggle as she tries to squeeze both of you into the bathtub; at last she makes you sit in it, laughing and splashing milk everywhere.");
	output("\n\n\"<i>There.  Now let me wash you clean.</i>\"");
	output("\n\nShe grabs hold of a nearby soap and starts lathering it all over your naked body.  You can't see her hands under the moving milky surface but you feel very pleasant tingles in the most intimate places.  She tickles you a bit and you can't help but giggle some more as you feel her delicate hands working you over.");
	output("\n\n\"<i>Shhh... Relax now, soldier.  I'll take care of everything.</i>\"");
	output("\n\nShe first softly brushes your hair with her fingers and strokes your head, then massages every tense muscle at the edge of your face, making you sigh and moan in relief.  Before you even notice, her hands are squeezing and pinching the nape of your neck, completely releasing your tension.  You don't know where she learned to be so good at this, but it just feels so right.  Now her hands are moving downards...  Gods, she is so sweet, so delicate.  You let out another moan, making her chortle.  Putting her head just above yours, her perky tits press against your back.  You can feel her erect nipples gently scratching you as she slowly rubs her appreciable bosom against you; her expert ministrations are arousing you little by little");
	if(!pc.hasGenitals()) output("."); 
	else {
		//[if cock]
		if(pc.hasCock()) output("; [pc.eachCock] grows to full erect size");
		if(pc.hasVagina() && pc.hasCock()) output(" and ");
		else if(pc.hasVagina()) output("; ");
		if(pc.hasVagina()) output("your [pc.vagina] leaks a little trickle of girl-juice");
		output(".  She doesn't seem to notice the effect she has on you - or so you think.  Suddenly, you feel a hand darting between your legs.");
	}
	output("\n\n\"<i>Oooh, so you really like this, don't you?</i>\"");
	output("\n\nYou blush and groan in response as she keeps teasing you with her graceful hands.  Caught flat-footed, you feel yourself deflating in shame until she begins whispering tender reassurance in your ear.  \"<i>It's all right, dear.  I want to make sure you're enjoying it thoroughly.  You deserve it.</i>\"");
	output("\n\nHer hands stimulate and arouse you ever so slightly, until you tell her desperately you must be completely clean of any demon soiling by now.  You both laugh together awkwardly as you rise from the bathtub; she watches you greedily as you slowly don your [pc.gear].  You eventually leave her, a little saddened.  Rebecc gives you a chaste kiss on your cheek before bidding you farewell.  \"<i>And be sure to come back, hero.  I can't wait to clean you up again.</i>\"");
	//Lust +30, Corr -2, Lib +1, slimefeed
	pc.slowStatGain("l", 1);
	pc.lust(30);
	pc.cor( -2);
	processTime(40 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//Rebecc Rape scene (for discerning penises) (Z)
private function rapeRebecc(outside:Boolean = false):void {
	clearOutput();
	var x:int = pc.biggestCockIndex();
	if(pc.hasCock()) {
		output("Within three strides you are upon Rebecc; you slap her twice on her cheeks, brutally yank her hair and in a harsh gesture, you turn her around.  The woman yells, \"<i>W-what are you doing?  No, please stop!</i>\"  Completely caught unaware, she gasps and jolts in surprise, crying loudly until you slap her again to shut her up.");
		output("\n\nYou quickly proceed to denude her, tearing her peasant dress to reveal her bountiful, jiggling breasts.  This enormous rack is begging to be touched; you ruthlessly grope them, forcefully bringing her nipples into their erect state.  She tries to struggle away but you hold her tight, her resistance and endless writhing making [pc.eachCock] harder");
		if (!pc.isCrotchExposed()) output("; to better please yourself, you pull it free of your [pc.lowerGarments]");
		output(".  You grind against her plush butt through the coarse cloth of her dress until it is completely drenched with pre-cum, then feverishly remove it, tearing the poor girl's gown to rags in the process to give you a clear view of her ample buttocks.  Pressing yourself on her more, you thoroughly enjoy the soft touch of her healthy rump.  You pinch and grope her fat butt repeatedly, making her whimper in humiliation, until it goes red from your rough treatment.  Gods, this girl has a fine ass; you give it a few slaps here and there as it jiggles in the most enticing way.");
		output("\n\nThe sight of her glorious rear is too tempting a target to resist, and you quickly shove the tip of your [pc.cock " + x + "] between her plush cheeks, bracing yourself for torrid anal penetration.  She keeps whining, unable to break free of your iron grasp.  In her constant struggles you notice an opening between her buttocks - you thrust inside with all your might, devastating her backdoor entrance, stretching her holes, tearing her insides and grinding against her rugged anal walls in a extremely rough way.");
		//[if cock is too long, >12 inches]
		if(pc.cocks[x].cLength() > 12) output("  You keep burying more of your [pc.cockNoun " + x + "] deep inside her rectum until you reach her limit and can't fit more cock in.");
		else output("  Eventually the entirety of your prick is lodged inside her lush asshole.");
		output("  She trills and bleats in pain and flounders about in your arms, futilely trying to avoid the incoming butt-rape.  You lock her arms with yours, implacably kneading her tits, and her shivering flesh brings the most exquisite contact to your fingers; you toy with her nipples as well, making her scream savagely in forced pleasure.");
		output("\n\nAfter a few minutes of resistance, her body tenses up and you ease yourself into effectively butt-fucking her.  You pull her white fuzzy hair, seize her squeezable hips for more leverage and start raping her ass; the thrusts come hard and fast, almost bringing your [pc.cockNoun " + x + "] out before jamming it all the way inside again.  This forceful and tigerish motion makes her shriek in excruciating ecstasy; she groans and moans rhythmically at the pace of your regular ass-pounding.  The torment you're inflicting on her poor interior walls is too much to bear and she twists violently to escape the dick-beast dominating her pucker; however, all she can do is wave her appreciable butt, bringing extra sensations to your [pc.cock " + x + "] and adding extra spice to your already ardent anal-rape.");
		output("\n\nThe cadenced wobbling of her rump as well as your constant pumping is bringing you to a higher state of pleasure; the heavenly tingle your [pc.cockNoun " + x + "] is receiving is making you heedless of anything else but the burning heat of her insides cooking your meat.  You feel your lust rise as you keep riding the buttslut below you, ignoring her muffled complaints and whining, her tight confines gradually taking over any control you have over your rod.  You pound Rebecc's ass as if your life depended on it, clutching her curvy hips instinctively like an imp in rut.  Your groin impacts her buttocks with a loud SLAP at every thrust");
		//[if balls]
		if(pc.balls > 0) output(", and your [pc.balls] almost feel sore from colliding with her dribbling cunt");
		output(".  Finally, when you think you're about to pass out from exhaustion, you cum in a powerful jet, literally blasting Rebecc's ass with your spooge, globs of goo being propelled like projectiles into her colon and splattering her backside with huge [pc.cumColor] smears.");
		if(pc.cumQ() > 1500) output("  After completely filling up her rectum, your baby-batter erupts in thick spurts from her anus despite her instinctive ass-clenching efforts to hold as much semen as possible inside.  The sheer might of your cumshot is enough to send Rebecc over the edge, and she releases an absolutely torrential stream of girl-cum, squirting against her will all over your groins and mixing her own fluids with yours in a pathetic show of sluttiness.");
		output("  She unconsciously milks you of all your spunk, her anal muscles working on their own to massage your meat and extract every drop from your urethra.");
		output("\n\nWith a last, satisfied sigh, you fall over, [pc.cock] deeply buried inside Rebecc's butt as you feel her warm, curvy body slowly waggling below you.  ");
		if(outside) output("Some of the villagers are apathetically watching you, too stunned and bruised to intervene.  ");
		output("You silently remove your prick from your girl's ass, watch her contentedly as her exposed rectum is literally oozing with spooge and walk back to your camp.");
		output("\n\nThis is a more-than-appropriate goodbye gift");
		if(outside) output(" to these miserable people, and even moreso");
		output(" to the manipulative slut who kept teasing you.  Serves her right, to use her body in the most provocative ways and never let you actually have your way with her.  You're unlikely to ever see her again.");
		//minus lust, minus libido, plus corruption, Remove Owca Village from 'Places' menu.
		output("\n\n(<b>Owca removed from the places menu.</b>)");
	}
	//Rebecc Female Rape Scene (Z)
	else {
		//Requires: PC female and biped
		output("Within three strides you are upon Rebecc; you slap her twice on her cheeks, brutally yank her hair and in a harsh gesture, you turn her around.  The woman yells, \"<i>W-what are you doing?  No, please stop!</i>\"  Completely caught unaware, she gasps and jolts in surprise, crying loudly until you slap her again to shut her up.");
		output("\n\nYou quickly proceed to undress her, tearing her coarse peasant dress in order to reveal her bountiful, jiggling breasts.  This enormous rack is begging to be touched; you ruthlessly grope it, forcefully bringing her nipples into their erect state.  She tries to struggle away but you hold her tight, her resistance and endless writhing making your [pc.vagina] moist.");
		output("\n\nYou keep rubbing against her plush butt through her ragged cloth");
		if(!pc.isCrotchExposed()) output(" and your [pc.lowerGarmentOuter]");
		output(" until it is completely drenched with your juices; you feverishly remove them, tearing the poor girl's gown to rags in the process to give you a clear view of her ample buttocks.  You enjoy the soft touch of her healthy rump against your own skin, glorying in the other girl's helplessness to stop you from touching her however you want.  You pinch and grope her fat butt repeatedly, making her whimper in humiliation, until it goes red from your rough treatment.");
		if(pc.tone > 75) output("  The sheep girl's plush softness against your own toughened, toned physique manages to both arouse and anger you.  \"<i>This is what you were bred to be, isn't it bitch?</i>\" you hiss, your hands roaming over her inviting curves.  \"<i>Your fat ass hasn't had to work a day in its life.  The town whore, the cock-tease they wheel out when your people need a dupe, that's what you are.  How does it feel to be in the hands of a real woman?</i>\"");
		else output("  Gods, this girl has a fine ass; you give it a few slaps here and there as it jiggles in the most enticing way.");
		output("  Rebecc doesn't say anything as you continue to grope her; she simply quivers with her eyes tightly shut, apparently unwilling to believe this is even happening.");
		output("\n\nYou shove her tits-first to the floor, grinning at the pained squeal this draws from the sheep girl and the wave of motion it sends across her soft body, then stand over her.  She struggles pitifully as you slowly prise her legs open, but the weakling is no match for you and you soon have her spread wide, helplessly presenting her cute, pink pudenda to you.   The sight stokes your raging lust and you sink one finger roughly through her lips into her moist hole, testing her depths as you lower yourself onto her.   Rebecc whimpers again at the abrasive treatment, and with one last meek show of resistance closes her legs and turns away from you.  You grasp her shoulder and backhand her hard, being sure to wipe her own juices onto her face on the return stroke.  She ceases struggling as you slide one of your [pc.hips] over her own plump thigh, clinch her other lamb chop with your arm, and, having thus entrapped her with your burning body, lower your [pc.vagina] onto hers and begin to buck against her.");
		output("\n\nWet sounds fill the air as you thrust your needy cunt into Rebecc's own, your juices dribbling onto and into her, lubricating your unwilling toy.  She whines and again tries to struggle out of the merciless grip you have her in; the effect is to make her own cunt buck and thrust into yours, your slimy lips kissing and moving against each other, heightening your own pleasure and making you scissor into her all the more savagely, already working yourself to a high.  You shove her leg up ruthlessly high so you can really grind into her; you feel her tiny clit bump into your own [pc.clit] and suck in your breath as Rebecc squeals.  Irritated with her constant noise, you bend into the prostrate sheep girl and slap her again, before roaming your hand down her lush front, your fingers landing upon a dark nipple.  You squeeze it as you rub your clits together, her warm flesh wobbling against yours, her own juices dribbling now as you push her relentlessly along the boundary between pain and pleasure until she arches her back and moans in miserable ecstasy, her cunt spasming a gush of girlcum onto you.  You reward her with another slap as she twists in her involuntary orgasm, so that your red hand mark has a partner upon the other side of her face.  It's a good look for her.");
		//[big clit]
		if(pc.clitLength > 3) output("\n\nYou aren't done yet.  Your own clit has long since pushed out of its hood and is bulging with obscene need.  You rotate your hips, teasing Rebecc's dribbling entrance with it whilst immersing yourself in pleasure, rubbing every inch of your sensitive femcock over her lips and hole before forcing yourself against her own tiny pleasure button, making her twitch and moan.  Your lust stoked to incredible heights by the slick pressure on your clit and the sight and feeling of your yielding, insensate victim, you finally thrust it into her slick hole, eager for release.  Clutching her gelatinous ass and firm neck as you fuck her like a man, you're forced to grit your teeth against the unbearably pleasurable sensation of your clit rubbing on her tender inner walls.  Your [pc.vagina] drools in sympathy as you push your [pc.hips] into the sheep girl and drive her into the ground, fucking her with your clit-dick as hard as you can.   Your pelvises beat a rough staccato against each other as you bring yourself all the way out and then thrust yourself in again, spattering your mixed juices everywhere as you pick up the pace.  Your [pc.fullChest] are pushed into her own soft pillows as you rub every inch of yourself over her, determined in your lust craze to violate all of this slut's teasing body.");
		//[other] 
		else {
			output("\n\nYou aren't done yet.  Your own clit has long since pushed out of its hood and is bulging with need.   You rotate your hips, teasing Rebecc's dribbling entrance with it whilst immersing yourself in pleasure, rubbing every inch of your sensitive female nub over her lips and hole before forcing yourself against her own tiny pleasure button, making her twitch and moan.  Casually you slap her face again, making her start; the movement translates through her body into your own needy sex as her lips involuntary shrink and rub against yours.  What a lovely sensation!  Your lust stoked to incredible heights by the slick pressure on your clit and the sight and feeling of your yielding, insensate victim, you thrust against her slick hole, eager for your own release.  You scissor her as hard and as violently as you can, slapping into her brutalized sex a few times before embedding yourself and rotating, striking her face carelessly again and again and again.  Her shuddering and sobbing only serves to heighten your pleasure.");
		}
		output("\n\nEventually you reach your high.  You clutch Rebecc painfully hard as your pussy spasms around hers, soaking her with your juices.  The crashing orgasm just seems to go on and on and you ride it into your slutty victim, forcing her to feel what you are feeling.  Once the ecstatic contractions have murmured down to a warm buzz, you sigh and crawl onto your prone victim, who is crying quietly.  You are sure to wipe your drooling sex all along her belly, breasts, and finally face; the sheen of femcum and the red hand marks on her tearstained cheeks doubly mark her as your spent, worthless sex toy.  ");
		if(outside) output("Some of the villagers are apathetically watching you, too stunned and bruised to intervene.  ");
		output("You silently pick yourself up and dress, admiring the quivering, crying handiwork at your feet, before walking back to your camp.  This is a more-than-appropriate goodbye gift");
		if(outside) output(" to these miserable people, and even moreso");
		output(" to the manipulative slut who kept teasing you.  Serves her right, to use her body in the most provocative ways and never let you actually have your way with her.  You're unlikely to ever see her again.");
		output("\n\n(<b>Owca removed from the places menu.</b>)");
	}
	//minus lust, minus libido, plus corruption, remove village from places
	processTime(45 + rand(10));
	pc.orgasm();
	pc.slowStatGain("l", -2);
	pc.cor(5);
	flags["COC.OWCA_UNLOCKED"] = -1;
	
	if (CombatManager.inCombat) CombatManager.genericVictory();
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//Desperate Villagers (Z)
//[Dialogue once Attitude reaches 0 or less, pops automatically as you go to the village]
private function desperateVillages():void {
	clearOutput();
	output("As you approach the group of huts, you hear a vague rumble, as if many people were talking at the same time.  Walking closer, you see all the villagers gathering outside and arguing violently; among them you spot your friend, Rebecc.  As soon as she sees you she hurries over with desperate, wet eyes.");
	output("\n\n\"<i>They want to put you back into the pit by force!  I and some others have tried arguing with them but they won't hear anything!  The demons have been harassing us a lot due to the lack of sacrifices, please do something!</i>\"");
	output("\n\nShe is rudely pushed aside by a tall muscular man with a pitchfork in his hand.  He starts talking in a slow, harsh voice.  \"<i>You supposed to be brave.  Go ahead.  Make sacrifice.  Or do we need to make you brave, be it against your own will?</i>\""); 
	output("\n\nIt seems that these villagers have grown weary of your repeated refusals; they are likely to react angrily if you deny them another sacrifice.");
	output("\n\nDo you submit?");
	//Yes/No. Yes leads to Accept Plea, Attitude raised by 10. No to Villagers Fight
	clearMenu();
	addButton(0, "Yes", function():* { acceptRebeccsPlea(false, true); } );
	addButton(1, "No", fightZeVillagers);
}

private function fightZeVillagers():void{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new CoCFarmers());
	CombatManager.victoryScene(CoCFarmersPCVictory);
	CombatManager.lossScene(CoCFarmersPCLoss);
	CombatManager.displayLocation("FARMERS\nFLOCK");
	CombatManager.beginCombat();
}

//Defeat Villagers (only displayed if corruption >= 60ish) (Z)
public function CoCFarmersPCVictory():void {
	clearOutput();
	output("The last of the villagers drops his improvised weapon.  They are all lying defenseless before you.  At last, you notice Rebecc, the only one still conscious, curled up as she weeps uncontrollably.  She is clearly oblivious of her surroundings, undoubtedly shocked by the violent fight.  Even if she calls herself your friend, you don't think you'd be able to reason with her after pummeling her kin.  What do you do?\n\n");
	//Rape Rebbecc/Torch Village (needs Akbal's fire or Whitefire)/Leave
	clearMenu();
	addDisabledButton(0, "Rape Rebecc", "Rape Rebecc", "This scene requires you to have genitals, high enough corruption and lust.");
	addDisabledButton(1, "Torch Village", "Torch Village", "This scene requires you to have some fire magic knowledge.");
	if ((pc.cor() >= 33 || !pc.isNice()) && pc.hasGenitals() && pc.lust() >= 33) addButton(0, "Rape Rebecc", rapeRebecc, true);
	if(getKnownFireMagic() != null) addButton(1, "Torch Village", torchOwcaMotherFuckers);
	addButton(14, "Leave", leaveOwcaAfterWhupping);
}

//"Leave" redirects the PC to camp; next encounter is Rebecc's Last Plea.
private function leaveOwcaAfterWhupping():void {
	//tag for calling last plea
	flags["COC.REBECCS_LAST_PLEA"] = 1;
	processTime(25 + rand(10));
	CombatManager.genericVictory();
}

//Village Torching scene - requires a fire skill (Z)
private function torchOwcaMotherFuckers():void {
	clearOutput();
	output("These ignorant folks deserve to be punished for trying to take you by force.  You muster your strength and release a wave of " + getKnownFireMagic() + ".  The raw heat and energy is enough to set entire thatched roofs ablaze.  You ignite house after house, the poor constructions unable to withstand your fiery might, until there are enough burning that the wind can carry the flames to all other buildings nearby.  A few minutes later, the entire village is ablaze; hovels are crumbling under their own weight and the crude roads are being littered with fallen debris.  You watch Owca burn silently, arms crossed.  Finally, when the last building has been thoroughly reduced to a pile of rubble and ashes, you quickly search for any valuables among the villagers' belongings.  Fortunately their gems haven't been melted; you pack a substantial amount of them away before leaving.  You cast a thoughtful glance at the remains of what used to be a peaceful village; ironically enough, the only structure you preserved was the pole in the pit, an ultimate mockery of their futile struggles against forces that ridiculously outmatch them.");
	
	pc.credits += (900 + rand(150)) * 10;
	flags["COC.OWCA_UNLOCKED"] = -1;
	pc.cor(15);
	processTime(45 + rand(30));
	clearMenu();
	if(pc.hasGenitals() && pc.lust() >= 33) {
		output("You notice Rebecc is still weeping among the scattered bodies of the beaten villagers.  Do you abuse her?\n\n");
		
		addButton(0, "Abuse Her", rapeRebecc, true);
		addButton(14, "Leave", torchUpVillagersAndLeave);
	}
	else addButton(0, "Next", torchUpVillagersAndLeave);
}

//Fuck off village
private function torchUpVillagersAndLeave():void {
	clearOutput();
	output("You don't think you're going to see these villagers again, and you don't really want to.\n\n");
	pc.energyRaw = 0;
	processTime(25 + rand(10));
	CombatManager.genericVictory();
}

//End of quest
//Lose to Villagers (Z)
public function CoCFarmersPCLoss():void {
	clearOutput();
	output("You kneel down and then fall, overwhelmed by the villagers' fury and numbers.  Without hesitation, the angry mob jumps on you; you recoil in terror, persuaded that you're going to be beaten to death.  Instead, you are carelessly lifted and completely stripped off; ");
	if(pc.hasWeapon()) output("your weapons are taken away and ");
	output("you are being uncomfortably transported to a destination you can guess easily.  Too dazed to resist or even worry about it; you are promptly brought to the dreaded pit, where the villagers tie you up and rudely shackle you.  Then, before you even realize how desperate your situation is, they're all gone.  Your numerous bruises and fatigue get the better of you and you quickly fall asleep.");
	//redirect to dusk transition text, restore hp/fat consonant with sleeping until nightfall
	processTime((22 - hours) * 60 + rand(60));
	sleepHeal();
	flags["COC.LOST_VILLAGERS_SPECIAL"] = 1;
	//after nightly scene, next encounter is Post-Mob Encounter
	clearMenu();
	addButton(0, "Next", CoCLustyDemonsPCLoss);
}

//Post-Mob Encounter (Z)
private function morningAfterRape():void {
	flags["COC.LOST_VILLAGERS_SPECIAL"] = undefined;
	clearOutput();
	output("The village is utterly silent and almost deserted.  The few people you see look away when they spot you, probably ashamed of what they did last time.  Doors are locked and windows are closed as you pass by; everyone is obviously afraid of directly confronting their victim.  You head toward Rebecc's house, your last friend.  As you open her door, you hear a muffled wail; you recognize the pretty farmer's voice.  She is laying on her bed, weeping uncontrollably; once she finally notices your presence, she looks up to you with tear-filled eyes, sobbing convulsively as she talks.");
	output("\n\n\"<i>T-they forced you to be abused... I promise I didn't want that!  I tried to convince them... they wouldn't listen... they threw you to the pit... at least I made them give you back your belongings as usual... now you must hate me, don't you?  Oh, I'm so sorry!  It's all my fault!</i>\"");
	output("\n\nWhat do you do?");
	//Option: Forgive. Sets Attitude to 50, quest goes back to normal.
	//Option: Rape. Leads to Rebecc Rape scene and ends the quest. 
	//Option: Leave. Redirects PC to camp, next encounter leads to Rebecc's Last Plea
	processTime(10 + rand(10));
	clearMenu();
	addButton(0, "Forgive", forgiveOwca);
	if (pc.hasGenitals()) addButton(1, "Rape", rapeRebecc, false);
	else addDisabledButton(1, "Rape", "Rape", "This scene requires you to have genitals.");
	addButton(14, "Leave", fuckThisShit);
}

//Option: Forgive (Z)
private function forgiveOwca():void {
	clearOutput();
	output("Swallowing your pride, you tell her that it's all right and that you hold no grudge against her; the villagers were obviously desperate, to have resorted to such extreme measures.  You assure her");
	if(pc.cor() >= 50 || !pc.isNice()) output(", lying through your teeth,");
	output(" that you don't feel any resentment at all; she tried her best to help you, and you're grateful to her.");
	output("\n\nRebecc's face is overcome with joy as you speak.  \"<i>Thank you, thank you!  I've been filled with remorse and sorrow since this last awful encounter, you can't believe how relieved I am!</i>\"  You take her in your arms and hold her tight until the last of her tears finally dries up.  \"<i>I'm going to tell everyone in the village how great a person you are!  You will be acclaimed as our hero!</i>\"\n\n");
	//Corruption -8, Int +2, Attitude raised to 60, will never shrink below 1 (i.e. villagers won't get angry at you again)
	pc.slowStatGain("i", 2);
	pc.cor( -8);
	flags["COC.OWCAS_ATTITUDE"] = 60;
	flags["COC.OWCA_ANGER_DISABLED"] = 1;
	//To main owca menu
	processTime(10 + rand(10));
	if (CombatManager.inCombat) CombatManager.genericLoss();
	else {
		clearMenu();
		addButton(0, "Next", owcaMainScreenOn);
	}
}

//Option: Leave (Z)
private function fuckThisShit():void {
	clearOutput();
	output("You stare at the wretched, whimpering creature before you for a moment.  There's nothing to say.  Without a word, you head back to your camp, carefully closing Rebecc's door behind you as you leave.\n\n");
	flags["COC.REBECCS_LAST_PLEA"] = 1;
	processTime(10 + rand(10));
	if (CombatManager.inCombat) CombatManager.genericLoss();
	else {
		clearMenu();
		addButton(0, "Next", mainGameMenu);
	}
}

//Rebecc's Last Plea (Z)
private function rebeccsLastPlea():void {
	clearOutput();
	output("As you arrive on the border of the cursed village, you see someone is running in your direction.  You recognize Rebecc instantly; she seems to stumble and stagger at every step, and her face is tear-stricken.  Intrigued, you catch the crying woman by the waist as she runs past you sightlessly; she falls into your arms, nearly tripping as she abandons herself to your embrace.  Unsure of what to do, you ask her why she is panicking, though it takes a while before your words reach her.");
	output("\n\n\"<i>They... they chose me!</i>\" she wails, choking back.  \"<i>They voted and I was chosen to be thrown in the pit!  They're angry at me for befriending you and I was blamed for the recent troubles with the demons!  They think you've abandoned us and I'm responsible for all this... they hate me!  They hate you too!  I'm going to be tied up, abused and broken... and everyone will pretend nothing happened!  I don't want to go to the pit; I don't know what to do!</i>\"");
	output("\n\nWhat do you do?");
	//(You could rape her.) //Leads to Rebecc Rape scene. 
	//(You could face the villagers and demons in her stead.) 
	//(You could leave.) //End of quest.
	clearMenu();
	addButton(0, "Rape Her", rapeRebecc, true);
	addButton(1, "Face Them All", faceDownHordes);
	addButton(2, "Leave", leaveRebeccToBeRaped);
}
//Option: Leave (Z)
private function leaveRebeccToBeRaped():void {
	clearOutput();
	output("You tell Rebecc you don't want to have anything to do with her or her sick people and promptly turn around.  She wails and begs you at first but you're faster than the tear-blinded girl, and she soon falls behind.  Your safe, simple camp looms large in your thoughts, pushing out any desire to return to this wicked village and its wicked people.");
	//[Owca Village removed from "Places" menu.]
	output("\n\n(Owca has been removed from the places menu.)");
	processTime(10 + rand(10));
	clearMenu();
	flags["COC.OWCA_UNLOCKED"] = -1;
	addButton(0, "Next", mainGameMenu);
}