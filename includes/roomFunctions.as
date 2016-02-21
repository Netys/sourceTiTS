﻿import classes.Characters.Anno;
import classes.Characters.PlayerCharacter;
import classes.Characters.Saendra;
import classes.Characters.SX1GroupPirates;
import classes.Characters.SX1Shotguard;
import classes.Characters.SX1Techguard;
import classes.Characters.ZilFemale;
import classes.Creature;
import classes.Engine.Combat.DamageTypes.DamageResult;
import classes.Items.Accessories.LightningDuster;
import classes.Items.Apparel.AtmaArmor;
import classes.Items.Apparel.NaleenArmor;
import classes.Items.Apparel.TSTArmorMkII;
import classes.Items.Apparel.UGCUniform;
import classes.Items.Armor.GooArmor;
import classes.Items.Guns.EagleHandgun;
import classes.Items.Guns.Goovolver;
import classes.Items.Guns.HoldOutPistol;
import classes.Items.Guns.LaserPistol;
import classes.Items.Guns.MyrBow;
import classes.Items.Guns.PlasmaPistol;
import classes.Items.Guns.ScopedPistol;
import classes.Items.Guns.TachyonBeamLaser;
import classes.Items.Guns.ZKRifle;
import classes.Items.Melee.ShockBlade;
import classes.Items.Miscellaneous.EmptySlot;
import classes.Items.Miscellaneous.FlashGrenade;
import classes.Items.Miscellaneous.GrayMicrobots;
import classes.Items.Miscellaneous.HorseCock;
import classes.Items.Miscellaneous.PHAccess;
import classes.Items.Miscellaneous.Pussyblossom;
import classes.Items.Miscellaneous.Silicone;
import classes.Items.Miscellaneous.TestGrenade;
import classes.Items.Miscellaneous.TestHPBooster;
import classes.Items.Miscellaneous.UthraSap;
import classes.Items.Protection.DBGShield;
import classes.Items.Protection.DecentShield;
import classes.Items.Apparel.TSTArmor;
import classes.Items.Accessories.JungleLure;
import classes.Items.Accessories.JungleRepel;
import classes.Items.Transformatives.Bovinium;
import classes.Items.Transformatives.OvirAce;
import classes.Util.RandomInCollection;
import classes.VaginaClass;

public function flyToTavros():void
{
	output("You fly to Tavros");
	if(leaveShipOK()) output(" and step out of your ship.");
}

public function flyToMhenga():void
{
	output("You fly to Mhen'ga");
	if(leaveShipOK()) output(" and step out of your ship.");
}

public function mhengaShipHangarFunc():Boolean
{
	if (annoIsCrew() && !syriIsCrew() && flags["ANNOxSYRI_EVENT"] == undefined)
	{
		annoFollowerFirstTimeOnMhenga();
		return true;
	}
	
	return false;
}
public function puntToShip():Boolean
{
	clearOutput();
	if(currentLocation == "POESPACE" && flags["POE_A_DISABLED"] == undefined)
	{
		landingOnPoeA();
		return true;
	}
	output("You really don't want to step out into the cold void of space. Maybe you should land somewhere?");
	currentLocation = "SHIP INTERIOR";
	generateMapForLocation(currentLocation);
	showName("SHIP\nINTERIOR");
	processTime(1);
	clearMenu();
	addButton(14,"Back",mainGameMenu);
	return true;
}
public function xenogenOutsideBlurb():Boolean
{
	variableRoomUpdateCheck();
	if(hours < 6 || hours >= 17)
	{
		output("\n\n<b>The doorway to the north is currently marked \"Closed.\"</b> A notice declares that it will be open again at 6:00 standard terran time.");		
	}
	else
	{
		output("\n\n<b>Xenogen Biotech is currently open!</b> Office hours are 6:00 to 17:00 standard terran time.");
	}
	return false;
}

public function hangarBonus():Boolean 
{
	output("You’re within a stuffy tube of metal and plastic. Steady, mechanical thrums suffuse the air around you. The inside of the cylinder-like lift is lined by a brass-hued railing, used to steady oneself during high speed travel through the kilometers-long station.\n\nThere’s a sturdy mechanical keypad with which to designate your target level. Right now, the only floors of interest are the hangar, merchant and residential levels.");
	
	if (flags["SAENDRA_XPACK1_STATUS"] == 1 || flags["SAENDRA_XPACK1_STATUS"] == 2)
	{
		output("\n\nYou also have the option to take the lift up to Deck 92 to meet up with Saendra");
		if(flags["SAENDRA_XPACK1_STATUS"] == 2) output(". You are sure taking your time about it though");
		output("--whatever she contacted you about, it sounded pretty urgent.");
		addButton(0, "Deck 92", saendraX1LiftGo); 
	}
	
	if(currentLocation == "LIFT: MERCHANT DECK") {
		output("\n\n<b>You are currently on the merchant deck.</b>");
		addButton(7,"Down",liftMove, "TAVROS LIFT");
		addButton(5,"Up",liftMove, "LIFT: RESIDENTIAL DECK");
	}
	else if(currentLocation == "TAVROS LIFT") {
		output("\n\n<b>You are currently on the hangar deck.</b>");
		addButton(5,"Up",liftMove, "LIFT: MERCHANT DECK");
	} 
	else if(currentLocation == "LIFT: RESIDENTIAL DECK") {
		output("\n\n<b>You are currently on the residential deck.</b>");
		addButton(7,"Down",liftMove, "LIFT: MERCHANT DECK");
	}
	return false;
}

public function tavrosHangarStuff():Boolean
{
	if(flags["MET_VAHN"] == undefined) {
		output("\n\nYou spot a blond, half-ausar technician standing next to your ship, looking down at a datapad.");
		addButton(0,"Tech",VahnTheMechanic);
	}
	else
	{
		output("\n\nVahn's around here somewhere, if you want to look for him.");
		addButton(0,"Vahn",VahnTheMechanic);
	}
	//Celise In Tavros
	if(celiseIsFollower() && !celiseIsCrew())
	{
		output("\n\nCelise is lounging here, just as green as ever and chatting amicably with one of the station's mechanics.");
		addButton(1,"Celise",approachNonCrewCelise);
	}
	if (bessAtTavros())
	{
		output("\n\n[bess.name] is here, waiting around and generally staying out of the way as best [bess.heShe] can.");
		addButton(2, bess.short, approachBessAtTavros);
	}
	if (flags["FALL OF THE PHOENIX STATUS"] == 1)
	{
		output("\n\n<i>The Phoenix</i> is nearby, only a stones-throw away from your own ship, docked in a much smaller neighboring hangar.");
		
		if (flags["SAENDRA PHOENIX AVAILABLE"] != undefined)
			addButton(7, "The Phoenix", move, "PHOENIX RECROOM");
		else
			addDisabledButton(7, "The Phoenix", "The Phoenix", "This ship is locked and cannot be entered.");
	}
	return false;
}

//Drop this shit in every Phoenix room cause Savin is a jerk.
public function phoenixLocationSetter():Boolean
{
	if(flags["FALL OF THE PHOENIX STATUS"] == 1)
	{
		rooms[currentLocation].planet = getPlanetName();
		rooms[currentLocation].system = "SYSTEM: " + getSystemName();
	}
	//Reset soz it updates automagically.
	setLocation(this.rooms[this.currentLocation].roomName,this.rooms[this.currentLocation].planet,this.rooms[this.currentLocation].system);
	return false;
}

public function liftMove(destination:String):void
{	
	clearOutput();
	output("Your stomach drops as the lift kicks into gear. The gentle, steady thrum of powerful machinery fills the metallic tube as you are brought to your destination, slowly decelerating when you arrive.");
	move(destination,false);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function debugMenus():void
{
	clearMenu();
	output("The room of debug. Where am I? How did I get here? What do you want?!\n\n");
	
	var msg:String = "This is some testing text that I need to pad out the length of the current text line, so that I can see just how dumb some of the functions available for the textfield are."
	
	var m:Array = msg.split(" ");
	
	var someDamage:DamageResult = new DamageResult();
	someDamage.shieldDamage = 9;
	//outputDamage(someDamage);
	
	for (var i:int = 0; i < m.length; i++)
	{
		output(m.slice(0, i).join(" "));
		outputDamage(someDamage);
		output("\n\n");
	}
	
	addButton(1, "AddVag", function():void {
		pc.vaginas.push(new VaginaClass());
	});
	
	// Need the buttons back to test other stuff.
	// NO END OF FUCKING COMPLAINTS I AM FUCKING CALLING IT NOW.
	
	//addButton(0, "Lights Out", startLightsOut, testVictoryFunc);
	
	addButton(0, "GiveMilky", thisIsWhyWeCantHaveNiceThings, undefined, "Give Milky", "Get the Milky perk.");
	
	addButton(9, "ForceError", thisIsWhyWeCantHaveNiceThings, undefined, "Force an Error", "Force an error to test error handling.");
	
	addButton(10, "ShipStorage", thisIsWhyWeCantHaveNiceThings);
	
	addButton(4, "Cashmoney", thisIsWhyWeCantHaveNiceThings, undefined, "Cashmoney", "Sauce says you are TURRIBLE.");
	
	addButton(5, "KeyItems", function():void {
		pc.createKeyItem("F");
		pc.createKeyItem("A");
		pc.createKeyItem("B");
		pc.createKeyItem("G");
		pc.createKeyItem("3");
	});
	
	addButton(6, "Pass Time", thisIsWhyWeCantHaveNiceThings);
}

public function debugMenusTwo():void
{
	clearMenu();
	output("The secondary room of debug. Because we can't have nice things.");
	
	addItemButton(0, new LightningDuster(), function():void {
		output("\n\nLightning Duster.\n");
		
		var foundLootItems:Array = new Array();
		foundLootItems.push(new LightningDuster());
		
		itemScreen = mainGameMenu;
		lootScreen = mainGameMenu;
		useItemFunction = mainGameMenu;
		
		itemCollect(foundLootItems);
	});
	
	addItemButton(1, new Pussyblossom(), function():void {
		output("\n\Pussyblossom.\n");
		
		quickLoot(new Pussyblossom());
	});
	
	addItemButton(2, new MyrBow(), function():void {
		output("\n\nMyr Bow.\n");
		
		quickLoot(new MyrBow());
	});
	
	addButton(3, "Goozooka", function(): void {
		output("\n\nGoozooka.\n");
		pc.createKeyItem("Goozooka");
	});
	
	addItemButton(4, new Goovolver(), function():void {
		output("\n\nGoovolver.\n");
		quickLoot(new Goovolver());
	});
	
	addButton(5, "OvirTF", function():void {
		var oa:OvirAce = new OvirAce();
		oa.quantity = 10;
		
		var op:OvirPositive = new OvirPositive();
		op.quantity = 5;
		
		quickLoot(oa);
	});
	
	addButton(7, "Creds", function():void {
		pc.credits += 100000;
	});
	
	addButton(8, "Time", function():void {
		processTime(24 * 60);
	});
	
	addItemButton(9, new GooArmor(), function():void {
		quickLoot(new GooArmor());
	});
}

public function debugFuckWithRival():void
{
	rival.short = "Jack/Jill";
}

public function debugMenusThree():void
{
	clearOutput();
	output("Debug combat room.");
	
	addButton(0, "1v1", pcVsOneEnemy);
	addButton(1, "1v2", pcVsTwoEnemies);
	addButton(2, "2v1", pcPlusAnnoVsOneEnemy);
	addButton(3, "2v2", pcPlusAnnoVsTwoEnemies);
	addButton(4, "CLUSTER", maximumClusterfuck);
	addButton(10, "SUPERTIME", superTimePassage);
}

public function superTimePassage():void
{
	clearOutput();
	output("Passing 30 days.");
	processTime(60*24*30);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function instaLossTestLust():void
{
	(pc as Creature).lustRaw = pc.lustMax();
	
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new ZilFemale());
	CombatManager.victoryScene(pcVsOneEnemyWin);
	CombatManager.lossScene(pcVsOneEnemyLoss);
	CombatManager.displayLocation("INSTANT LOSS LUST");
	
	clearOutput();
	output("INSTANT LOSS LUST");
	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function pcVsOneEnemy():void
{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters(new SX1GroupPirates());
	CombatManager.victoryScene(pcVsOneEnemyWin);
	CombatManager.lossScene(pcVsOneEnemyLoss);
	CombatManager.displayLocation("1V1 TEST");
	
	clearOutput();
	output("1 vs 1 test fight!");
	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function pcVsOneEnemyLoss():void
{
	clearOutput();
	output("(1v1) You lost, wakka wakka.");
	CombatManager.genericLoss();
}

public function pcVsOneEnemyWin():void
{
	clearOutput();
	output("(1v1) You won, woo.");
	CombatManager.genericVictory();
}

public function pcVsTwoEnemies():void
{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters(pc);
	CombatManager.setHostileCharacters([new SX1GroupPirates(), new SX1Techguard()]);
	CombatManager.victoryScene(pcVsTwoEnemiesWin);
	CombatManager.lossScene(pcVsTwoEnemiesLoss);
	CombatManager.displayLocation("1V2 TEST");
	
	clearOutput();
	output("1 vs 2 test fight!");
	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function pcVsTwoEnemiesLoss():void
{
	clearOutput();
	output("(1v2) You lost, wakka wakka.");
	CombatManager.genericLoss();
}

public function pcVsTwoEnemiesWin():void
{
	clearOutput();
	output("(1v2) You won, woo.");
	CombatManager.genericVictory();
}

public function pcPlusAnnoVsOneEnemy():void
{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters([pc, new Anno()]);
	CombatManager.setHostileCharacters(new SX1GroupPirates());
	CombatManager.victoryScene(pcPlusAnnoV1Win);
	CombatManager.lossScene(pcPlusAnnoV1Loss);
	CombatManager.displayLocation("2V1 TEST");
	
	clearOutput();
	output("2 vs 1 test fight!");
	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function pcPlusAnnoV1Win():void
{
	clearOutput();
	output("(2v1) You won, woo.");
	CombatManager.genericVictory();
}

public function pcPlusAnnoV1Loss():void
{
	clearOutput();
	output("(2v1) You lost, wakka wakka.");
	CombatManager.genericLoss();
}

public function pcPlusAnnoVsTwoEnemies():void
{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters([pc, new Anno()]);
	CombatManager.setHostileCharacters([new SX1GroupPirates(), new SX1Techguard()]);
	CombatManager.victoryScene(pcPlusAnnoV2Win);
	CombatManager.lossScene(pcPlusAnnoV2Loss);
	CombatManager.displayLocation("2V2 TEST");
	
	clearOutput();
	output("2 vs 2 test fight!");
	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function pcPlusAnnoV2Win():void
{
	clearOutput();
	output("(2v2) You won, woo.");
	CombatManager.genericVictory();
}

public function pcPlusAnnoV2Loss():void
{
	clearOutput();
	output("(2v2) You lost, wakka wakka.");
	CombatManager.genericLoss();
}

public function maximumClusterfuck():void
{
	CombatManager.newGroundCombat();
	CombatManager.setFriendlyCharacters([pc, new Anno(), new Saendra()]);
	CombatManager.setHostileCharacters([new SX1GroupPirates(), new SX1Techguard(), new SX1GroupPirates(), new SX1Shotguard()]);
	CombatManager.victoryScene(fuckfuckfuckWin);
	CombatManager.lossScene(fuckfuckfuckLoss);
	CombatManager.displayLocation("WHARGBL");
	
	clearOutput();
	output("WHARBL");
	clearMenu();
	addButton(0, "Next", CombatManager.beginCombat);
}

public function fuckfuckfuckWin():void
{
	clearOutput();
	output("WHARGBL WIN");
	CombatManager.genericVictory();
}

public function fuckfuckfuckLoss():void
{
	clearOutput();
	output("WHARGBL LOSS");
	CombatManager.genericLoss();
}

public function thisIsWhyWeCantHaveNiceThings():void
{
	clearOutput();
	
	output("This is why we can't have nice things.");
	
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

public function quickLoot(... args):void
{
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	
	itemCollect(args);
}

public function synthSapNoticeUnlock():Boolean
{
	return (flags["MET_VANAE_MAIDEN"] != undefined && flags["MET_VANAE_HUNTRESS"] != undefined && CodexManager.entryViewed("Vanae: History"))
}

public function mhengaActiveBounty():Boolean
{
	var openQuests:int = 0;
	
	if(flags["SEEN_JULIANS_AD"] == undefined) openQuests++;
	if(synthSapNoticeUnlock() && flags["SEEN_SYNTHSAP_AD"] == undefined) openQuests++;
	
	if(openQuests > 0) return true;
	return false;
}
public function bountyBoardExtra():Boolean
{
	output("\n\nA large bulletin board has been erected against the wall of the building to the north.");
	if(mhengaActiveBounty()) output(" <b>There are new notices there.</b>");
	addButton(0,"Bulletins",checkOutBountyBoard);
	return false;
}
public function checkOutBountyBoard():void
{
	clearOutput();
	output("The bounty board is covered in simple leaflets, papers, and all manner of other detritus. Most appear to be for mundane tasks like trading construction equipment, advertising repair services, or business advertisements. Still, there's at least one that stands out.");
	
	// Zil Capture
	output("\n\n");
	if(flags["SEEN_JULIANS_AD"] == undefined) {
		output("<b>New:</b>");
		flags["SEEN_JULIANS_AD"] = 1;
	}
	else {
		if(flags["SECOND_CAPTURED_ZIL_REPORTED_ON"] == 1) output("<b>Completed:</b>");
		else if(flags["ACCEPTED_JULIANS_ZIL_CAPTURE_MISSION"] == 1) output("<b>Accepted:</b>");
		else output("<b>Seen Before:</b>");
	}
	output(" Dr. Julian of the Xenogen Biotech labs on the south end of town is looking for 'a strapping, adventurous type' to brave the jungles in search of something he can use for his research.");
	if(flags["SECOND_CAPTURED_ZIL_REPORTED_ON"] == 1) output(" You know from experience that it's quite lucrative.");
	else output(" It seems like it could be quite lucrative.");
	// SynthSap
	if(synthSapNoticeUnlock())
	{
		output("\n\n");
		if(flags["SEEN_SYNTHSAP_AD"] == undefined)
		{
			output("<b>New:</b>");
			flags["SEEN_SYNTHSAP_AD"] = 1;
		}
		else
		{
			if(flags["SYNTHSAP_UNLOCKED"] != undefined) output("<b>Completed:</b>");
			else output("<b>Seen Before:</b>");
		}
		output(" Xenogen Biotech Labs is seeking samples of ‘Sky Sap’ from the vanae natives. They are offering a monetary reward to anyone who can provide a steady supply of this substance.");
	}
	
	processTime(2);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}
	
public function barBackRoomBonus():Boolean
{
	if((hours >= 17 || hours < 6))
	{
		if(flags["KELLY_MET"] == 1) kellyAtTheBar();
		else output("\n\nA bunny-girl is back here with another patron, too busy to pay any attention to you.")
	}
	return false;
}

public function anonsBarAddendums():Boolean {
	if (saendraBarAddendum(3))
	{
		return true;
	}
	anonsBarWaitressAddendum(0);
	alexManHermIntro(1);
	ShellyBlurb(2);
	annoAtAnonsAddendum(4);
	roamingBarEncounter(5);
	return false;
}

public function anonsBoardBonus():Boolean
{
	//If PC has done Fools Rush In: Part 2 (ie, helping Saendra rescue her friend), add [Call Girl] to Anon's Bar.
	zilCallGirlAddendum(0);
	return false;
}

public function firstTimeOnTarkusBonus():Boolean
{
	if(flags["BEEN_ON_TARKUS"] == undefined)
	{
		flags["BEEN_ON_TARKUS"] = 1;
		clearOutput();
		output("You step down out of your ship and into a crowd of tiny, scaly folk: only a few feet tall, they're all sporting lithe frames and ridiculously long ears that nearly drag around on the ground behind them, most bearing a variety of piercings and tattoos. As you leave your ship behind, you're quickly swarmed by several of these curious creatures, which your Codex helpfully identifies as the raskvel, the planet's native species (or one of them, anyway). They shower you with questions about name, sex, species, et cetera as one or two in very scruffy uniforms try to hand you some paperwork. You hurriedly scribble down your signature before pushing off some of the more outgoing raskvel climbing up your [pc.leg]. Eventually, another starship lands, leaving you in peace for a moment as they scurry off to see the next new and interesting thing.");
		CodexManager.unlockEntry("Raskvel");
		output("\n\n<b>You are on the starship Nova, now known as the raskvel's city, Novahome.</b>");
	}
	return returnToShipAfterRecruitingAnno();
}

public function BonusFunction210():Boolean
{
	if(flags["TARKUS_DESTROYED"] == undefined) output(" Shafts of outside light cut into the artificial brilliance of the tunnel's lamps to the west, indicating a way outside.");
	output("\n\nThe cargo elevator seems to be working down here - its doors sit open to the north, awaiting a passenger. Now if only the raskvel could get it to go to the hangar, you could save yourself a lot of walking.");
	return false;
}

public function bonusFunction213():Boolean
{
	if(flags["TARKUS_DESTROYED"] == undefined) output(" An enclosed bulkhead to the south houses a narrow entryway of some kind. Black marks around the perimeter of the door indicate at least one explosion has gone off on the other side.");
	else output(" A solid metal plate has been welded over a charred doorway to the south and a bright red \'X\' spraypainted across it.");
	return false;
}

/*
public function novaShipHangarElevator():Boolean
{
	if (flags["DECK13_COMPLETE"] == undefined)
	{
		output("\n\nYou step up to the elevator and press the call button. Immediately, the doors slide open, but no car comes.");
	}
	else
	{
		addButton(0, "Elevator", novaElevatorControlPanel);
	}
	return false;
}
*/

public function novaMainDeckElevator():Boolean
{
	if (flags["TARKUS_DESTROYED"] != undefined && flags["DECK13_SHIELDS_ON"] != 1)
	{
		output("\n\nYou step up to the elevator and press the call button. The doors don’t respond.");
		output("\n\nHm. The shaft must have been destroyed when the planet blew up, sealing the doors indefinitely....");
		
		return false;
	}
	if (flags["DECK13_COMPLETE"] == undefined)
	{
		output("\n\nYou step up to the elevator and press the call button. Immediately, the doors slide open, but no car comes.");
		
		return false;
	}
	
	addButton(0, "Elevator", novaElevatorControlPanel);
	
	return false;
}

public function novaElevatorControlPanel():void
{
	clearOutput();
	author("Gedan");
	showName("NOVA\nELEVATOR");
	
	output("You step into the cavernous elevator and take a look around. There's a heavily damaged control panel attached to a console beside the elevator's doors. Through the grime and rust you can just barely make out a set buttons, some of which <i>might</i> be in working order.");
	
	clearMenu();
	//if (currentLocation != "NOVA SHIP DECK ELEVATOR") addButton(0, "Hangar Deck", move, "NOVA SHIP DECK ELEVATOR");
	//else addDisabledButton(0, "Hangar Deck");
	
	if (currentLocation != "NOVA MAIN DECK ELEVATOR") addButton(0, "Main Deck", move, "NOVA MAIN DECK ELEVATOR");
	else addDisabledButton(0, "Main Deck");
	
	if (currentLocation != "DECK 13 ELEVATOR SHAFT") addButton(1, "Deck 13", move, "DECK 13 ELEVATOR SHAFT");
	else addDisabledButton(1, "Deck 13");
	
	addButton(14, "Back", mainGameMenu);
}

public function newTexasRoadFirstTime():Boolean
{
	if(!pc.hasStatusEffect("Disarmed")) 
	{
		customsFucksYourShitUp();
		return true;
	}
	//First time:
	if(flags["SEEN_TEXAS_SURFACE"] == undefined)
	{
		output("So this is New Texas, the pastoral paradise, huh? With the seemingly endless blue sky, rustic-looking structures, and rolling fields of grass and grain, you can see where it got its name. Presently you've stepped out onto a bumpy dirt road; it's fortunate the locals rely on hover-based transit over primitive wheel systems, or they'd need to invest a little more heavily into their infrastructure. A huge barn looms over you to the south. Just inside the doors, you know there's a customs checkpoint and more ships than you bother to count. To the north sits a ranch house, the kind with a big, elevated porch that would normally house a farmer and his extended family. This one is dressed up with a bit of extra flair. Signs declare it to be the official visitor's center.");
		flags["SEEN_TEXAS_SURFACE"] = 1;
	}
	//Repeat
	else
	{
		output("You recognize this spot on the dusty country road. It's where you got your first real look at New Texas' so-called pastoral paradise. The whole place is built up in the style of old terran farms. The hangar is designed to resemble a gigantic barn, despite its contents being made of gleaming metal instead of flesh. Off to the northeast is a fancy ranch house, replete with a fenced-in porch, rocking chairs, and a dazzlingly white coat of paint. In other directions are fenced off fields.");
	}

	return false;
}

public function manMilkerRoomBonusFunc():Boolean
{
	if (flags["MILK_BARN_COCKMILKER_BROKEN"] != undefined || flags["MILK_BARN_COCKMILKER_REPAIR_DAYS"] != undefined)
	{
		if(flags["MILK_BARN_COCKMILKER_BROKEN"] != undefined)
		{
			if(flags["MILK_BARN_COCKMILKER_SCANNED"] == undefined) addButton(0,"Fix Milker",yesFixDaMilkar,true,"Repair Milker","The male milker looks to be broken from your previous use... It'll need to be repaired before you can use it again.");
			else addButton(0,"Fix Milker",yesFixDaMilkar,false,"Repair Milker","The male milker looks to be broken from your previous use... You'll need to pay for the repairs before you can use it again.");
		}
		else if (flags["MILK_BARN_COCKMILKER_REPAIR_DAYS"] > 0) addDisabledButton(0,"Use Milker","OUT OF ORDER","The machine is currently being repaired. You'll have to wait for it to be fixed first!");
		else addButton(0,"Use Milker",useDaMilkar,undefined,"Use Milker","It looks like the male milker has finally been fixed. It looks good as new!");
	}
	else addButton(0,"Use Milker",useDaMilkar,undefined,"Use Milker","Use the male milker. It looks to function based off of prostate stimulation.");
	return false;
}

public function NTGiftShopBonusFunc():Boolean
{
	//First Time Entering the Shop
	if(flags["SEEN_ELLIES_SHOP"] == undefined)
	{
		flags["SEEN_ELLIES_SHOP"] = 1;
		output("You step into the gift shop, pushing the glass door open ahead of you. You all but recoil when the door slides open, and an almost overpowering aroma assails your senses. It feels like you've just been hit by a brick, right in the chest; catching your breath is almost impossible for a long moment. Your mind swims as the potent musk in the shop washes over you, and you suddenly manage to identify the odor: sex. Raw, untamed sexuality and need. Your skin flushes as the musky odor clings to you, feeling like a haze around you as you force yourself to walk, not run, into the gift shop.\n\n");
		//applyDamage(new TypeCollection( { tease: 10 } ), null, pc, "minimal");
		pc.lust(10);
	}
	else pc.lust(5);
	output("The gift shop looks like every other gift shop in the 'verse, with racks of memorabilia ranging from ten-gallon hats to holographic greeting cards. There's a pretty good line leading up to the cashiers, and the most popular item going out seems to be a small white medipen labeled \"The Treatment.\" ");
	if(flags["MET_ELLIE"] != undefined) output("Ellie");
	else output("A tauric woman with black scales on her lower body and a massive GG-cup rack, only barely restrained by a semi-translucent bra that's stained with milky moisture");
	output(" is overseeing the automated shopping terminals, occasionally distracted by a customer's query or a particularly flirty bull wandering through.");
	//Next, to room description. Add [Shopkeeper] button
	ellieApproachButtonSetup();
	return false;
}

//Big T.’s Barbeque Pit
public function NTBarbequeBonusFunc():Boolean
{
	clearOutput();
	author("Savin");
	showBust("HERMAN");
	showName("\nHERMAN");
	if(flags["MET_HERMAN"] == undefined) showName("BULL\nCHEF");
	//Fen: This’d be as good a place as any to stick Dane.
	output("The restaurant attached to the ranch house is a smoky, meaty-smelling BBQ joint, advertising authentic terran steaks, ribs, and roast beef sandwiches. An open grill dominates the far northern wall of the restaurant, with several tourists and cow-folk lined up to order some delicious barbeque. ");
	if(flags["MET_HERMAN"] != undefined) output("Herman the chef");
	else output("The chef");
	output(" is busily trying to fill the orders as they come in, clearly swamped with customers.");
	addButton(0,"Food",getFoodAtBigTs,undefined,"Food","See what's on the menu.");
	addButton(1,"Watch Screen",stephIrsonBySavinWhoSaysHesTiredOfTreatedCowBimbosThenMakesHerATreatedCowGirlForShitsAndGigglesWhyIsThisFunctionNameSoLong);
	return false;
}

public function randomBarnEntranceEventsFunc():Boolean 
{
	// Gonnae splice gobbles in here so it can be handled separately
	if (gobblesAvailable() && rand(3) == 0 && flags["GOBBLES_SEXYTIMES_STARTED"] == undefined)
	{
		supGobbles2014CanadaEdition();
		return true;
	}
	if (gobblesAvailable() && flags["GOBBLES_SEXYTIMES_STARTED"] == 1 && flags["GOBBLES_COOLDOWN"] != undefined && flags["GOBBLES_COOLDOWN"] >= 24 && rand(3) == 0)
	{
		trace("EVENT TRIGGERED!");
		canadaTheTurkeyRepeats();
		return true;
	}
	trace("SEXYTIMES?: " + flags["GOBBLES_SEXYTIMES_STARTED"] + " COOLDOWN? " + flags["GOBBLES_COOLDOWN"] + " GOBB AVAIL? " + gobblesAvailable());
	return false;
}

public function randomBarnEventFunc():Boolean
{
	var retVal:Boolean = false;
	
	//Chance to proc any one of these events when passing by a milking stall. Each can proc 1/day at most.
	if(flags["MILK_BARN_EVENT_TODAY"] == undefined && rand(10) == 0)
	{
		//Cured Reaha
		if(9999 == 0 && rand(3) == 0)
		{
			output("\n\n<b>Reaha steps out of the stall as you pass by,</b> rubbing her reddened nipples after a little time on the milker. \"<i>Oh, uh, hey [pc.name]!</i>\" she says, blushing a little");
			//if reaha clothed
			if(!chars["REAHA"].isNude()) output(" as she pulls on her clothes");
			output(". \"<i>When in Rome, right?</i>\"");
			output("\n\nYou give your cow an affectionate pat on the head and send her on her way back home.");
		}
		//Treated Reaha
		else if(9999 == 0 && rand(3) == 0)
		{
			output("\n\n<b>Reaha steps out of the stall as you pass by,</b> stretching her powerful muscles and wiping away a few trickles of milk still drooling from her huge bust. \"<i>Hey, [pc.name]!</i>\" she says, shooting you a big grin. \"<i>Figured I'd let the machine take a load off you this time. Don't get used to it, though,</i>\" she chuckles, giving you a playful punch on the shoulder");
			if(pc.physique() < chars["REAHA"].physique()) output(", though still hard enough to stagger you");
			output(".");
			output("\n\n\"<i>See ya back at the ship. Maybe I'll have a drink stored up for you... if you're lucky.</i>\"");
		}
		//Ellie
		else if(flags["MET_ELLIE"] != undefined && rand(5) == 0)
		{
			output("\n\nAs you pass by this stall, you hear a particularly lewd moan from inside, and can't stop yourself from peeking in the door, which has been left open. <b>Ellie's inside, awkwardly hooked up to the milkers</b> that were clearly made for bipedal cows. As she's getting milked, a particularly buff looking bull is making use of her animalistic hind-quarters, pounding away at her with abandon. Seeing you walking past, Ellie gives you a playful wink before the pressure on her tits distracts her into another series of moans and groans.");
		}
		//Ellie II
		else if(flags["MET_ELLIE"] != undefined && rand(5) == 0)
		{
			output("\n\n<b>Ellie is wandering out of this stall</b> as you pass by, fiddling with the straps on her bra, which is already soaked with milk still drooling from her saucer-sized teats. \"<i>Hey, sweet-thing!</i>\" she says, wiggling on up to you in a cloud of sex-scent.");
			//if sex'd:
			if(flags["ELLIE_SEXED"] != undefined) output(" \"<i>Wish I'd known you were out and about, I could have used a cute little thing to help me out instead of the rough old machine.</i>\"");
			else output(" \"<i>Have fun in the barn! I know I did!</i>\"");
			output("\n\nShe gives you a playful wink before meandering off, winking at you from the back-side, too.");
		}
		//Gianna
		else if(flags["MET_GIANNA"] != undefined && rand(4) == 0 && currentLocation != "512")
		{
			output("\n\n<b>Gianna is stepping out of the stall as you pass by,</b> a mop slung over her shoulder and a big pail of milk in her left hand, sloshing over with fullness. \"<i>Oh, hi, [pc.name],</i>\" she says, stopping to give you a bright smile. \"<i>Don't mind me, just doing a little bit of cleaning. Some of the cow-girls get a little... messy sometimes.</i>\"");
		}
		//Dane
		//Rare chance. Only outside of male milker. PC can't have beaten the Myrellion boss fight. 
		else if(flags["UNLOCKED_JUNKYARD_PLANET"] != undefined && rand(4) == 0 && currentLocation == "511")
		{
			output("\n\n<b>Of all the people to bump into... Dane, your cousin's bodyguard, is wandering out of the male-milker stall</b>. He gives a big yawn as he steps out, a towel slung over one broad shoulder. Behind him, ");
			if(StatTracking.getStat("milkers/prostate milker uses") == 0) output("the stall attendant");
			else output("Carrie");
			output(" pokes her head out and waves. \"<i>See you around, Dane!</i>\"");
			output("\n\nHe gives a lazy wave back over his shoulder, and all but crashes into you while he's distracted. \"<i>Gah! Oh, uh, hey, [pc.name]. Just getting some R&R. Don't tell your cuz.</i>\"");
			output("\n\nBefore you can question it, the four-armed ausar man walks off. Huh.");
		}
		else if (brynnRandomBarnEventFunc())
		{
			if (flags["BRYNN_AUTOENTER"] == 1)
			{
				retVal = true;
			}
		}
		else
		{
			//Amma and Ogram
			if(rand(2) == 0)
			{
				output("\n\n<b>You see Ogram standing outside this stall</b>, leaning against the door with his arms crossed over his broad chest. \"<i>Hey there, " + pc.mf("buddy","beautiful") + ",</i>\" he says, inclining his head to you as you pass. \"<i>Just waiting on the little lady in there.\"</i>");
				output("\n\nThrough the stall door, you can hear pleasured moans and cries as his partner gets a little lactic relief.");
			}
			//Amma and Ogram II
			else
			{
				output("\n\n<b>Amma is stepping out of the stall as you pass by</b>, buttoning her blouse back up after a little time on the milker. A few droplets of excess milk quickly stain through the fabric. \"<i>Hey, cutie!</i>\" she calls, shooting you a wink across the barn.");
				if(pc.biggestTitSize() >= 5) output(" \"<i>Come to spend a little time on the milker, too?</i>\"");
				else output(" \"<i>Come to see if any of the girls need a little </i>help<i> with their milkers? How sweet of you!</i>\"");
				output("\n\nAs she speaks, Ogram steps out from the stall behind her, zipping his jeans back up. \"<i>C'mon, you. Back to work before the big man sees we're gone!</i>\" He scoops Amma up under an arm like she weighs nothing at all, giving you a friendly wave before absconding with his giggling cow-girl partner.");
			}
		}
		flags["MILK_BARN_EVENT_TODAY"] = 1;
	}
	return retVal;
}

public function vanaeWarningBot():Boolean
{
	output("\n\n<b>A small, sleek drone bearing the U.G.C. Peacekeeper emblem is hovering here, puttering around in a small circle.</b> When you approach, the drone intones in a clearly mechanical voice: <i>“Peacekeeper Inoue has posted the following safety advisory: beyond this point, the southern area of jungle is classified as a level four threat and is to be avoided if at all possible.”</i>");
	addButton(0,"Drone",talkToWarningDrone);
	return false;
}

public function talkToWarningDrone():void
{
	clearOutput();
	author("Savin");
	showName("\nDRONE");
	showBust("\nDRONE");
	output("You step up to the drone and ask it for more information.");
	output("\n\n<i>“Peacekeeper Inoue has classified the local species ‘Vanae’ as a level four threat. This species is highly aggressive. Only well-equipped explorers with significant off-world experience should proceed beyond this point.”</i>");
	if(flags["SEXED_PENNY"] != undefined) output("\n\nAs you step back from the drone, it chirps and suddenly displays a holographic image of Penny. <i>“Hi, mate. I thought you might find this! Be safe out there, alright?”</i>\n\nYou smile and nod as the bonus message flickers off.");
	processTime(1);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function esbethFastTravelOfficeBonus():Boolean
{
	//Codex locked:
	if(!CodexManager.entryUnlocked("Leithan")) 
	{
		output(", and your codex beeps to inform you it's identified the leithan race");
		CodexManager.unlockEntry("Leithan");
	}
	output(".");

	addButton(0, (hasMetTanis() ? "Tanis" : "Scout"), mhengaScoutAuthority);
	return false ;
}

public function mhengaScoutAuthority():void
{
	clearOutput();
	showBust("TANIS");
	if (hasMetTanis()) showName("\nTANIS");
	author("Savin");
	
	if (flags["TANIS_APPROACHED"] != undefined && flags["TANIS_BOW_INTRO"] == undefined && pc.hasBowWeaponAvailable())
	{
		tanisBowIntro();
		return;
	}
	
	if(flags["SALVAGED VANAE CAMP"] != 2) 
	{
		output("When you step up to " + (hasMetTanis() ? "Tanis" : "the leithan man") + ", he looks up from his work on a holoscreen and gives you an apologetic grin. <i>\"Sorry, friend, we're just getting set up here on Mhen'ga. Jungle's a little too dense for the scout drones to map and plan landing zones, so there's no transports going out yet.\"</i>");
		output("\n\n<i>\"Ah. Sorry to bother you,”</i> you say, turning to leave.");
		output("\n\n<i>“No worries. <b>If you come across any inactive ones out there, get them going, and we’ll be able to get you anywhere they cover.</b>”</i>");
		processTime(1);
		clearMenu();

		addButton(0, "Next", mainGameMenu);
		if (hasMetTanis() && pc.hasBowWeaponAvailable()) addButton(1, "Bow Training", tanisBowTraining);
		
		flags["TANIS_APPROACHED"] = 1;
	}
	//[Scout] (PC has fixed a comm array)
	else
	{
		output("When you step up to " + (hasMetTanis() ? "Tanis" : "the leithan man") + ", he looks up from his work on a holoscreen and gives you a big grin. <i>\"Hey there! Welcome to the Scout Authority base. We're running light transports out into the jungle now that comm arrays are coming online. So, where can we take you, " + pc.mf("sir","ma'am") + "?\"</i>");
		processTime(1);
		clearMenu();
		if(pc.credits >= 40) addButton(0,"XenogenCamp",mhengaTaxiToXenogen,undefined,"Xenogen Camp","This taxi will take you to the abandoned camp you found in the jungle. It costs 40 credits.");
		else addDisabledButton(0,"XenogenCamp","Xenogen Camp","You don't have enough credits to ride there.");

		if (hasMetTanis() && pc.hasBowWeaponAvailable()) addButton(1, "Bow Training", tanisBowTraining);

		addButton(14, "Back", mainGameMenu);
		
		flags["TANIS_APPROACHED"] = 1;
	}
}

public function mhengaTaxiToXenogen():void
{
	clearOutput();
	showBust("TANIS");
	pc.credits -= 40;
	output("<i>“Alright. I’ll upload the coordinates to one of the transports. Just swipe your credit stick here and head out back.”</i>");
	output("\n\nYou do so, transferring your payment to the Scout Authority and walking out into the back lot behind the structure. Several small hover-cars are arrayed there, all jungle-patterned and manned by simplistic drone pilots. One of them hails you with a wave of its mechanical arm. You slip into the car, and a moment later you’re on your way, zipping across the jungle of Mhen’ga.");
	output("\n\nNot long after, you arrive at the camp, and disembark into the jungle. The hover-car zips away a minute later, leaving you behind.");
	currentLocation = "ABANDONED CAMP";
	generateMapForLocation(currentLocation);
	processTime(15);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//Tarkus U.G.C. Scout Authority
//Add to the flight deck of the Nova, 2 spaces east of the LZ. 
public function tarkusScoutAuthorityOffice():Boolean
{
	output("What was once the crew chief’s office overlooking the flight deck has been converted into a U.G.C. scout base, complete with maps and star charts hanging from the walls and a massive board map dominating the center, with landmarks and racial analysis printouts scattered over it. Behind the chief’s desk sits a buxom kaithrit with her bright orange hair pulled back into a long ponytail.");
	addButton(0,"Scout",tarkusScoutMenu,undefined,"Scout","Talk to the scout about security transportation to different parts of the planet.");
	//[Scout] (PC hasn’t fixed any comm arrays)
	return false;
}

public function tarkusScoutMenu():void
{
	clearOutput();
	author("Savin");
	showName("\nKAITHRIT\nSCOUT");
	showBust("KAITHRIT_SCOUT");
	if(flags["TARKUS_DESTROYED"] != undefined)
	{
		output("When you step up to the cat-girl, she looks up from her holoscreen and sighs. <i>“Sorry, there's not really anywhere to take a taxi to anymore.”</i>");
		clearMenu();
		addButton(0,"Next",mainGameMenu);
	}
	else if(flags["TARKUS_TAXI_STOP_UNLOCKED"] == undefined)
	{
		output("When you step up to the cat-girl, she looks up from her work on a holoscreen and gives you an apologetic grin. <i>“Sorry, friend, we’re just getting set up here on Tarkus. All the junk’s sending up so much interference that it’s taking ages to set up proper comm beacons, so there’s no transports going out yet.”</i>");
		output("\n\n<i>“Ah. Sorry to bother you,”</i> you say, turning to leave.");
		output("\n\n<i>“No worries. Come on back if any comm arrays go up, and we’ll be able to get you anywhere they cover.”</i>");
		processTime(1);
		clearMenu();
		addButton(0,"Next",mainGameMenu);
	}
	//[Scout] (PC has fixed a comm array)
	else
	{
		output("When you step up to the catgirl, she looks up from her work on a holoscreen and gives you a big grin. <i>“Hey there! Welcome to the Scout Authority base. We’re running light transports out into the wasteland now that comm arrays are coming online. So, where can we take you, " + pc.mf("sir","ma’am") + "?”</i>");
		tarkusTransitMenu();
	}
}

public function remoteTarkusScoutMenu():void
{
	clearOutput();
	output("You jab in a few commands, and a moment later, a holographic kaithrit appears onscreen. <i>“Need a lift?”</i> she offers.");
	output("\n\nYou nod.");
	output("\n\n<i>“No problem. Where do you want to go?”</i>");
	showName("\nKAITHRIT\nSCOUT");
	showBust("KAITHRIT_SCOUT");
	tarkusTransitMenu();
}

public function tarkusTransitMenu():void
{
	clearMenu();
	if(pc.credits >= 80) addButton(0,"Novahome",tarkusFlyTo,"TARKUS SCOUT AUTHORITY","Novahome","Secure a lift to Novahome for the low low price of 80 credits.");
	else addDisabledButton(0,"Novahome","Novahome","You can't afford the 80 credits it would cost to get a ride to Novahome.");
	if(pc.credits >= 80) addButton(1,"The Lift",tarkusFlyTo,"279","The Lift","Secure a ride to the great lift for the low low price of 80 credits.");
	else addDisabledButton(1,"The Lift","The Lift","You can't afford the 80 credits it would cost to get a ride to the great lift.");

	if(currentLocation == "279") 
	{
		addDisabledButton(1,"The Lift","The Lift","You're already at the great lift comm relay!");
	}
	else if(currentLocation == "TARKUS SCOUT AUTHORITY")
	{
		addDisabledButton(0,"Novahome","Novahome","You're already at the Novahome scout office.");
	}
	addButton(14,"Back",mainGameMenu);
}


//{Destination -- X Credits}
public function tarkusFlyTo(arg:String):void
{
	clearOutput();
	author("Savin");
	showName("\nKAITHRIT\nSCOUT");
	showBust("KAITHRIT_SCOUT");
	if(currentLocation == "TARKUS SCOUT AUTHORITY")
	{
		output("<i>“Alright. I’ll upload the coordinates to one of the transports. Just swipe your credit stick here and head back out into the flight deck. Can’t miss out transports right outside.”</i>");
		output("\n\nYou do so, transferring your payment to the Scout Authority and walking back into the hangar. Several small hover-cars are arrayed there, all desert-patterned and manned by simplistic drone pilots. One of them hails you with a wave of its mechanical arm. You slip into the car, and a moment later you’re on your way, zipping across the junkyards of Tarkus.");
		output("\n\nNot long after, you arrive at your destination, and disembark into the wasteland. The hover-car zips away a minute later, leaving you behind.");
	}
	else
	{
		output("<i>“Alright. I’ll upload the coordinates to one of the transports. Just swipe your credit stick here and we'll have a transport out in a few minutes.”</i>");
		output("\n\nTrue to the cat-girl's words, a desert-patterned hovercover arrives in minutes, piloted by a simplistic drone pilot that's already beginning to show signs of corrosion from Tarkus' toxic atmosphere. You slip into the car, and a moment later you’re on your way, zipping across the junkyards of Tarkus.");
		output("\n\nNot long after, you arrive at your destination, and disembark into the wasteland. The hover-car zips away a minute later, leaving you behind.");
	}
	pc.credits -= 80;
	currentLocation = arg;
	generateMapForLocation(currentLocation);
	processTime(15);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

public function eastTransitStationBonus():Boolean
{
	if(flags["TARKUS_TAXI_STOP_UNLOCKED"] == undefined)
	{
		output("\n\nA forgotten comm relay is sitting here, its antennas corroded with rust. If you knocked all the crud loose, it could probably get a signal again, allowing you to call for transport.");
		addButton(0,"Fix Comms",fixCommsOnTarkus);
	}
	else
	{
		output("\n\nThe comm relay you fixed is sitting here, holoscreen illuminated. You could use it to call for a taxi if you wanted.");
		addButton(0,"Call Taxi",remoteTarkusScoutMenu);
	}
	return false;
}

public function fixCommsOnTarkus():void
{
	clearOutput();
	output("A few well placed kinetic repairs knock the crust loose from the antennas. The screen lights up. Perfect!");
	flags["TARKUS_TAXI_STOP_UNLOCKED"] = 1;
	processTime(1);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//adds a Button for the Notice Board on the residential deck on Tavros
public function tavrosRDActiveNotice():Boolean
{
	var openNotice:int = 0;
	
	if(flags["AINA_NOTICE_1_READ"] == undefined) openNotice++;
	if(flags["FYN_NOTICE_1_READ"] == undefined) openNotice++;
	
	if(openNotice > 0) return true;
	return false;
}
public function tavrosResidentialDeckNoticeBoard():void
{
	output("\n\nA holographic board floats here, littered with community notices for deck residents. It seems anyone can put a message here, and quite a few people have taken advantage of it.");
	addButton(0,"NoticeBoard",displayNoticeBoardRD);
}
public function displayNoticeBoardRD():void {
	clearOutput();
	
	output("While this public notice board is holographic, it's easy to bring up a digipen and scribble whatever you want on it. There's a section for official notices to deck residents, informing them of maintenance schedules and other important events. The rest is for use by the public; filled with general requests or advertisements.");
	
	output("\n\n");
	if(flags["AINA_NOTICE_1_READ"] == undefined) {
		output("<b>New:</b>");
		flags["AINA_NOTICE_1_READ"] = true;
	}
	else output("<b>Seen Before:</b>");
	output(" It appears someone in the western walkway, room 154, is looking for a 'discreet individual' to help them with an unspecified problem. Pretty ambiguous.");
	
	output("\n\n");
	if(flags["FYN_NOTICE_1_READ"] == undefined) {
		output("<b>New:</b>");
		flags["FYN_NOTICE_1_READ"] = true;
	}
	else output("<b>Seen Before:</b>");
	output(" There's a notice for 'interested individuals' to visit the eastern walkway for 'lessons', room 112. There seems to have been more to the message, but someone else has placed their own holo notice over it.");
	
	output("\n\n");
	if(flags["SEMITH_NOTICE_1_READ"] == undefined) {
		output("<b>New:</b>");
		flags["SEMITH_NOTICE_1_READ"] = true;
	}
	else output("<b>Seen Before:</b>");
	output(" “Itching for a game of 4D chess?” reads one note, in tall, loopy cursive. “The north-west plaza has tables. Always around in the afternoons.”");
	
	processTime(2);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}
