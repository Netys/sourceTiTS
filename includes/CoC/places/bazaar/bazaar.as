import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

include "Benoit.as";
include "Cinnabar.as";
include "FapArena.as";
include "Greta.as";
include "GripingDemons.as";
include "Lilium.as";
include "Roxanne.as";
include "SlipperySqueeze.as";

public function showBazaar():void
{
	userInterface.showName("BIZZARE\nBAZAAR");
}

//[Find Travelling Bazaar]
public function findBazaar():void {
	clearOutput();
	showBazaar();
	if(IncrementFlag("COC.BAZAAR_ENCOUNTERED", false) == 0) {
		IncrementFlag("COC.BAZAAR_ENCOUNTERED");
		output("Warm, earthy breezes drift by as you explore the wind-blown grasses of the plains.  Though it seems you can see for miles, with the grasses subtly shifting between a few feet and over a dozen feet tall, it's impossible to tell what you'll stumble into next.  You trust your ears and your nose as much as your oft-blocked vision at this point, and before long you catch a whiff of blackened meat and aromatic spices.  There's some kind of camp not far away!\n\n");
		
		output("You [pc.readyWeapon] and cautiously creep through the towering vegetation, trying not to give your position away until you've ascertained just what type of people inhabit this camp.  Bright light flickers through the grass in front of you, and you part it to peek from between the blowing stalks.  There's a ring of brightly colored wagons set up here, with a tall, picketed fence erected around them.  Smoke curls up from the camp's center, twisting in the air like a viper in the grass.  Each of the wagons appears to be expanded, deployed into a small, self-contained structure.  Clearly this is some kind of traveling caravan or bazaar.\n\n");
		
		output("There's only one gap in the fence – a narrow gate watched by a ten-foot tall man with red skin and a pale, almost sky-blue turban.  He has a pair of scimitars that hang from a simple, leather belt.  The crimson-skinned man's clothing is a simple tunic and loose-fitting pants, but neither can conceal his obviously well-muscled frame.  He looks alert and attentive – a good sign since demons would have little need to post guards.");
	}
	else {
		output("Once again you smell a campfire through the tall grass, and as you close the distance you hear the familiar sounds of the traveling bazaar.  You peek through the weeds and behold the caravan's gate-keeper - a red-skinned, muscular giant of a man.");
	}
	output("\n\nDo you approach?", false);
	//[YES] [NOOOO]
	clearMenu();
	addButton(0, "Yes", approachBazaarGuard);
	addButton(1, "No", function ():* { processTime(10 + rand(10)); mainGameMenu(); } );
}

//[FUCK YES I WILL PUT IT IN YOUR BIZARRE ANUS]
private function approachBazaarGuard():void {
	clearOutput();
	showBazaar();
	output("You step from concealment and walk up to the strange man, calling out in greeting.  He folds his arms across his chest and looks you up and down, peering at you with intense, black eyes.  They aren't solid onyx, but his irises are just as dark as the seemingly bottomless depths of his pupils.  His appraising gaze watches you, unblinking as second after second ticks by.  Just when you start to wonder if he speaks your language, he interrupts you by saying, \"<i>");
	//if(pc.cor() < 33) output("Leave at once.  You are not yet ready for the wonders of the Bazaar.");
	//else 
	output("Welcome to the Bizarre Bazaar.  Enter, but be mindful of your actions within.");
	output("</i>\"");
	//if(cor() < 33) simpleChoices("FIGHT!",initiateFightGuard, "", null, "", null, "", null, "Leave",returnToCampUseOneHour);
	//else 
	clearMenu();
	addButton(0, "Enter", enterTheBazaar);
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

public function enterTheBazaar():void {
	flags["COC.BAZAAR_ENTERED"] = 1;
	//if (model.time.hours == 19 || model.time.hours == 20) {
		//flags[kFLAGS.COUNTDOWN_TO_NIGHT_RAPE]++;
		//if (flags[kFLAGS.COUNTDOWN_TO_NIGHT_RAPE] % 4 == 0 && (pc.gender == 1 || (pc.gender == 3 && pc.mf("m", "f") == "m"))) {
			//nightBazaarButtfuck();
			//return;
		//}
	//}
	processTime(10 + rand(10));
	enterTheBazaarAndMenu(true);
}

////Pure? You'll have to fight!
//public function initiateFightGuard():void {
	//output("You ready your " + pc.weaponName + " and assume a combat stance! He grabs his dual scimitars! It's a fight!", true);
	//startCombat(new BazaarGatekeeper());
//}	
//
//public function winAgainstGuard():void {
	//clearOutput();
	//output("With the gatekeeper defeated, you walk right past the unconscious guard and enter...", false);
	//cleanupAfterCombat(enterTheBazaarAndMenu);
//}

//[Enter]
public function enterTheBazaarAndMenu(demons:Boolean = false):void {
	//Make sure flags to allow entrance is set.
	flags["COC.BAZAAR_ENTERED"] = 1;
	clearOutput();
	showBazaar();
	//spriteSelect(-1);
	//output(images.showImage("location-bazaar"));
	output("You breeze past the crimson guard and enter the interior of the Bizarre Bazaar.  The ground is hard-packed, trampled as if walked over by hundreds of hooves, paws, and feet.  A massive bonfire rages in the center of the clearing, crackling and popping as it consumes its fuel gluttonously.  Surrounding the blazing behemoth are tiny, wheeled food-carts with vendors hawking everything from sausage to something called a 'marshmallow'.  Huge wagons ring the clearing, many set up to display exotic wares or services.  You can see everything from dancing centaurs to demons browsing the wares, but it seems an uneasy truce of sorts reigns here.  Then again, maybe the demons have just not had the chance to openly attack this place yet.");
	output("\n\nOne of the wagons proudly proclaims itself to be \"Greta's Garments,\" though both 'G's are emphasized with cute, stylized devil horns, and the 'S' is shaped in the form of a spaded, demonic tail.  Obviously it must some kind of clothing shop.");
	RoxanneAppearance();
	setBenoitShop();
	fapAppearance();
	//blackCock.blackCockDescription();
	//Set menu. The top row is always available.
	clearMenu();
	addButton(0, "Shops", shopMenu);
	addButton(1, (Flag("COC.FAP_ARENA_RULES_EXPLAINED") > 0 ? "Fap Arena" : "Tent"), fapArenaGOOOO);
	//addButton(2, "Food Tent", blackCock.enterTheBlackCock, null, null, null, "The incredible smell seems to come from that tent.", "The Black Cock");
	//addButton(4, "Back Alley", investigateBackAlley, null, null, null, "That back alley looks suspicious. Do you dare investigate?");
	//Cinnabar
	if (cinnabarAppearance(true) != null) addButton(5, (Flag("COC.CINNABAR_MET") > 0 ? "Cinnabar" : "Rat"), cinnabarGreeting);
	
	//Griping Demons
	if(Flag("COC.GRIPING_DEMONS_STATUS") == 0 && rand(4) == 0 && demons) {
		overHearDemonsAboutSyrena();
		return;
	}
	if((Flag("COC.GRIPING_DEMONS_STATUS") == 1 || Flag("COC.GRIPING_DEMONS_STATUS") == 2) && demons && rand(10) == 0) {
		//[Repeat Variant]
		outputText("\n\n<b>The familiar sounds of the two griping demons can be heard nearby.  Do you listen in again?</b>");
		addButton(6, "GripingDemons", overHearDemonsAboutSyrena, null, "Griping Demons", "Overhear the conversation of the two griping demons.");
	}
	
	//Lilium
	if (LiliumText(true) != null) addButton(7, (Flag("COC.UNKNOWN_FLAG_NUMBER_00267") > 0 ? "Lilium" : "Demon"), approachLilium);
	//Roxanne
	addButton(8, (Flag("COC.ROXANNE_MET") > 0 ? "Roxanne" : "Lizans"), (Flag("COC.ROXANNE_MET") > 0 ? RoxanneChooseApproachOrRepeat : Roxanne1stApproach));
	//Bimbo Niamh
	if (flags["COC.NIAMH_STATUS"] > 0 && flags["COC.NIAMH_MOVED_OUT_COUNTER"] == -1) {
		if (flags["COC.NIAMH_STATUS"] == 2) output("\n\nThe sounds of voices raised in song and girlish laughter makes it obvious where Niamh is holding a perpetual party.");
		addButton(9, "Niamh", bazaarNiamh);
	}
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

private function shopMenu():void {
	clearMenu();
	showBazaar();
	setBenoitShop(true);
	addButton(1, "G. Garments", gretasGarments);
	addButton(2, "S. Squeeze", theSlipperySqueeze);
	addButton(14, "Back", enterTheBazaarAndMenu);
}

////Visit the Bizarre Bazaar at night.
//public function nightBazaarButtfuck():void {
	//clearOutput();
	//output("While wandering the bazaar at night you feel an unease growing in your stomach. As you walk your dimly lit path, you pause and notice a rather dark pathway that you haven't seen before. Curiosity sparks in your wandering mind and you can't help but wonder how long it has been here and where it leads. Should you wander down this dark path despite the thoughts bubbling in your head that it's a bad idea?");
	//output("\n\nDismissing that nagging feeling in the back of your mind, you head down the unlit path toward adventures unknown.  You comfort yourself with the prospects of adventure and the excitement of exploration.  Your ever-optimistic mind is lost in wonder when a flap of a large tent to your side suddenly bursts open.  \"<i>Fine! I'm goin', I'm goin'! Put a fuckin' cock in it!</i>\"");
	//
	//output("\n\nYou turn your head to find the source of the gruff, yelling voice and find a large figure storming from the tent.  As you squint in the darkness to make out the figure, you think you see them fumble with the pockets of their pants.  You realize the figure has noticed you when two glowing, green eyes lock onto you.  \"<i>Why, hello there...</i>\"  The guttural voice utters slowly.  They draw closer, and soon the only sound in the alley that you can focus on is your heartbeat and the figure's shuffling footsteps over the dirty trail.  Your heart pounds as your mind races to figure out what to do.  In this isolated, dark pathway you can't help but feel the figure is going to try and take advantage of you.  Your back presses to the cold trunk of the adjacent tree as the figure drunkenly swaggers toward you.");
//
	//output("\n\nThe figure finally comes before you. Now that you're closer you can make him out better.  \"<i>What you doin' here?</i>\"  The large feline asks, a growl to his voice that leaves you wondering if he's annoyed or upset.  You do your best to calm yourself down and explain how you were just exploring the bazaar. To match the glowing eyes, a glinting grin of jagged teeth forms between the figure's black lips.  \"<i>I was just headin' there myself.  We should go together.  It's not safe to wander around at night, even for a big guy like me.</i>\"  A raspy snicker follows as a strong grip wraps around your shoulder.  \"<i>Let me just get some more cash and I'll treat ya.</i>\"  The feline purrs a generous offer as you feel him pulling you towards the tent he just exited from.  Your eyes peer around as the feline starts to drag you.  No one is around to help you.  The trail is completely vacant. An uneasy feeling quickly grows in the pit of your stomach.  Something is wrong.");
	////open options [Escape][Wait][Assault]
	//menu();
	//addButton(0,"Escape",escapeFromCertainRape);
	//addButton(1,"Wait",waitOnStuff);
	//addButton(2,"Assault",assaultYoRapistYo);
//}
//
////<Option 1 Escape>
//private function escapeFromCertainRape():void {
	//clearOutput();
	//output("You tear yourself away from the feline. Wide, surprised eyes stare at you as you make a break for it.  You run as quickly as your legs can carry you, the echoes of the feline's feet padding behind you urging you to run faster.  You flee through the trees mindlessly, darting down whatever path you see first.  In your panic, though, you quickly wear yourself out.  How far did you run? Where are you now?  You lean against a trunk and pant for breath.  Thankfully no one seems to be around, including your pursuer.  You pat yourself off as you notice the bright lights of the bazaar nearby and retreat back to the well-lit collection of tents.");
	////gtfo
	//menu();
	//addButton(0,"Next", enterTheBazaarAndMenu);
//}
//
////<Option 2 Wait>
//private function waitOnStuff():void {
	//clearOutput();
	//output("Uncertainty plagues you as you wait to see what happens.  The large feline reaches the entrance of the large tent.  His free hand grips the tent and, as you let out a loud yelp, you are shoved forcefully through.");
	////Pass go and collect 200 rape
	//menu();
	//addButton(0,"Next",collectSomeButtSmex);
//}
//
////<Option 3 Assault>
//private function assaultYoRapistYo():void {
	//clearOutput();
	////Strength Check
	////[(If strength is less than 50)
	//if(pc.str + rand(30) < 50) {
		//output("Intending to turn the tables, you grip the feline man's wrists and pull as hard as you can to wrest yourself away from the strange figure.  Your muscles fail you, though, and the feline quickly pins your arms behind your back.  Though you strain against them, the stronger hands hold you in place.  You spit silent curses at yourself for not spending more time at the gym.  \"<i>Nice try.  It was almost... Cute.</i>\" You hear the figure snicker again behind you before you are promptly shoved through the entrance to the large tent.");
		////Pass go collect 200 rape
		//menu();
		//addButton(0,"Next",collectSomeButtSmex);
	//}
	////<Option 3 Assault>
	////Strength Check
	////[(If strength is 50 or more)
	//else {
		//output("You huff your breath as the weaker figure tries to force you to cooperate.  You shake your head before quickly overpowering the figure. Your strong grip clenches him around the wrists, his fur soft under your fingers.  With a sharp grunt you bend them over and push their face into the dirt.  The feline snarls and attempts to yank his arms from your grasp as you hold both wrists in one hand.  You lean down to look him over, the light peeking through the nearby tent to reveal his orange fur with black stripes.  You have a large, burly tiger man pinned under you.  What do you do with him?");
		////open options [Leave][Abuse ass(70 or more corruption)]
		//menu();
		//addButton(4,"Leave", assaultWinAndLeave);
		//if(cor() >= 66 - cor()ruptionTolerance() || flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) addButton(0,"Abuse Ass",abuseHisAss);
	//}
//}
//
////<Option 1 Leave>
//private function assaultWinAndLeave():void {
	//clearOutput();
	//output("You shove the large tiger man across the dirt.  His annoyed growls are muffled by the dirt his face is sliding across.  You issue a warning about picking fights with those stronger than he is and leave him lying in the dirt, his pride battered and bruised.  The dirt under your heel grinds in the darkness as you turn and casually continue down the path until you find yourself back in the bazaar.");
	////gtfo
	//menu();
	//addButton(0,"Next", enterTheBazaarAndMenu);
//}
	//
////<Option 2 Abuse Ass(Visible with 70 or more corruption)>
//private function abuseHisAss():void {
	//clearOutput();
	//output("Your tongue flicks from your lips at all the possibilities that course through your mind.  \"<i>Lemme go!</i>\"  The feline barks out from under you, though you have better ideas.  You move your free hand back and roughly pull down his pants, exposing his muscled rump to the cool, night air.  Feeling a firm cheek beneath your hand, you rub and squeeze it almost affectionately before swatting the cheek roughly, coaxing a strained grunt from the tiger man's mouth.");
	//
	////[(If player doesn't have cock)
	//if(!pc.hasCock()) {
		//output("\n\nDeciding to humiliate the poor fool, you begin to spank your hand against the tiger man's rear.  Your swats grow steadily more forceful and your slaps begin to grow louder and louder, filling the night air with the sound of your hand slapping firm cheeks.  You reduce the defiant growls uttered by the tiger man to soft whimpers and he slowly ceases his struggles and submits.  Your hand grips a cheek firmly, fingers digging into the abused flesh and feeling the warmth of the sting you've inflicted.  Tilting your head over, you can't help but smirk as the tiger's erect manhood juts out between his legs.");
		//
		//output("\n\n\"<i>What's that racket?</i>\" You turn your head, hearing a low voice shout from inside the nearby tent.  With a snicker you shove the humiliated tiger to the ground and leave him exposed and aroused as the occupants of the tent pour out.  By the time they surround him you are long gone and back to the well-lit collection of tents in the bazaar.");
		////gtfo
		//menu();
		//addButton(0,"Next", enterTheBazaarAndMenu);
		//return;
	//}
	////[[[(If player does have cock)
	//output("\n\nYou decide to have a little fun with the muscular ass in front of you.  You hold the struggling tiger's wrists with one hand and fish out your " + multiCockDescriptLight()  + " free from your [pc.gear].  Your eyes drink in how the burly tiger man writhes under you.  He's completely at your mercy.");
	////[(If multicock)
	//if(pc.cockTotal() > 1) output("  Your hand strokes along your " + multiCockDescriptLight()  + " and press them to the warm cheeks exposed before you.");
	//else output("  You pump your [pc.cocksLight] and milk a pearl of pre-cum out to drip onto the enticing ass before you.");
	//output("  \"<i>O-OI!</i>\"  The tiger man shouts out, his head turning to try to see behind him.  With a grin on your lips you grip the hilt of [oneCock] and slap its length over the tiger's rump.  You can see the tint to the tiger man's cheek as he hears and feels your dick smacking his exposed ass.  Pre-cum drips down [oneCock] as you line yourself up, jamming it between the tiger's lovely mounds. He gives a surprised shout as your cockhead presses to his tiny, puckered hole.");
	//
	////Cocksize check
	////[[If smallest cock is over 16 inches)
	//if(pc.smallestCockLength() >= 16) {
		//output("\n\nYour lips part to let out a grunt of frustration.  Your cockhead is unable to break through the tiger man's tight resistance.  His struggles start to die down as [pc.eachCock] continues to drool over his muscled rear.");
		//if(pc.totalCocks() == 1) output("  You squeeze your [pc.cocksLight] between his warm ass cheeks, stroking yourself with his exposed bottom.  The tiger whimpers meekly under you.");
		//else output("  Your fattest cock grinds between the tiger man's rear, dripping spunk over his back and clothing while your other cocks make a sloppy mess of his ass.");
		//output("  The tiger man's muscled butt is soon glazed with your pre-cum.  Wet, slapping noises echo out into the alley as you grind your hips into his rear.  You can't help but think in the back of your head that the noise is stirring people inside the tent he came out of.");
	//}
	////[[(If largest cock is smaller than 16)
	//else {
		//output("\n\nYou jam your cockhead into the tiger man's tight ring.  He groans in displeasure under you as your persistent force pushes past his resistance.");
		////[(If multicock)
		//if(pc.cockTotal() > 1) output("  One of your cocks slips into his hot, constricting confines, the remaining lengths pressed fast to the tiger man's rear and leaving glistening trails of eager fluids like markings on a bitch's ass.");
		//else output("  Your " + multiCockDescriptLight()  + " pushes in, your pre-cum-slicked length sliding in with a wet noise.");
		//output("  The burly man under you whimpers in protest as you begin to rock against his fine ass.  His firm rear dimples and twitches under your hips, each slam");
		//if(pc.balls > 0) output(" swatting your " + ballsDescriptLight()  + " against him,");
		//output(" making him shout out in discomfort.  Your " + multiCockDescriptLight()  + " stretching him out");
		//if(pc.cockTotal() > 1) output(" while beating his rear");
		//output(".  All his shouting stirs whoever resides in the tent he came out of.");
	//}
	////(combine cock size paths)
	//output("\n\nAs you continue to use the burly tiger man pinned beneath you, three figures exit from the tent.  Two of the figures are large and bulky and are joined by a third, slender man.  They watch as you abuse the tiger under you.  You glance over at them and can't help but notice smiles on their faces.");
	//
	//output("\n\n\"<i>Good for you, mate, making friends while getting us booze.</i>\"  One of them calls out.  The three of them laugh out loud at the joke, and as they laugh your senses are assaulted with the aroma of alcohol wafting from them.  From the way the trio sways you can tell they've been hitting the bottle hard.  They make no movement to stop you, though, so you ignore them.  The tiger under you stares in their direction, embarrassment burning crimson in his cheeks while you use and abuse him.  The scene is proving too much for you, though, and soon your " + multiCockDescriptLight()  + " unloads your pent up spunk over the tiger and coats him in thick, musky spooge in front of his 'friends'.");
	//
	//output("\n\n\"<i>He's even enjoying himself!</i>\"  One of the figures bellows out.  You tilt your head to peer between the tiger's spread legs and, sure enough, the barbed cock throbs between his legs with each beat of his heart.  Without further ceremony you roll the abused tiger man on his cum-soaked back and tuck your " + multiCockDescriptLight()  + " back into your [pc.gear].  The trio are too drunk to stop you as you leave.  Turning your head back to glance at the tiger, you see the three figures surrounding the victim and your lips curl into a pleased smile.  Within moments you return to the lights of the Bazaar.");
	////gtfo
	//menu();
	//addButton(0,"Next", enterTheBazaarAndMenu);
//}
//
////((If waited, or failed assault  //Pass go collect 200 rape))
//private function collectSomeButtSmex():void {
	//clearOutput();
	//output("Your body crashes into a wooden table and you choke, feeling the wind knocked out of you.  You struggle to lift your head and catch your breath, only to find yourself laying in... poker chips?");
	//output("\n\n\"<i>The fuck ya doin'? This isn't booze!</i>\" A voice shouts.");
 	//output("\n\n\"<i>Might be better though.</i>\"");
	//output("\n\n\"<i>Shut yer traps!</i>\"");
	//
	//output("\n\nVoices surround you as you look around yourself.  A light hangs over you, the heat of the light bearing down on your body from overhead.  You shift and continue to disarray the poker table, moving chips and scattering playing cards across the table and onto the floor.  Your nose is assaulted with the stench of smoke and alcohol as you strain your sight on the figures around you.  A large bear, covered in brown fur from head to toe, barks out.  \"<i>What are you pulling?</i>\"");
	//
	//output("\n\nYou follow his gaze to see the feline figure walking into the light, revealing his features to be a cross of a man and a tiger.  His face looks humanoid but his body is covered in orange fur with dark stripes.  \"<i>Found it hanging around outside.</i>\" The tiger growls back.");
	//
	//output("\n\n\"<i>Nice, was getting tired of card games anyway.</i>\"  Behind you, a low tone sounds.  You spin your head to catch the sight of a burly, green male.  A tusked head sits atop muscular, bulky shoulders and torso.  You furrow your brows at all of these strange men.  Upon further inspection, you realize that they all must be regulars at the gym, since each shirtless torso is stacked with bulging and formidable muscles.  There isn't a single shirt in sight.");
	//
	//output("\n\n\"<i>I said shut yer traps!</i>\"  A commanding voice boomed out, making everyone (including you) fall silent and look in the speaker's direction.  A leanly built creature rises from his seat - another humanoid, with long, furred legs like a goat's.  Large curled horns protrude from his mass of curly brown hair. Beneath them, silver eyes look you over carefully and size you up.");
	//
	//output("\n\n\"<i>What are you doing?</i>\" the shirtless satyr asked with a demanding tone, his eyes fixed on the tiger man.");
	//
	//output("\n\n\"<i>He's my payment.  Worth more than a few drinks,</i>\" the tiger growls.  Your head is swamped with confusion as you wonder just what is going on.");
	//
	//output("\n\n\"<i>Not enough to cover all of it, too.  You'll have to do better than this.</i>\" the satyr says with a sigh.  \"<i>But... it's a start.</i>\"  You glance to the satyr just as he snaps his fingers and raises his hand in the air.  Before you can ask any questions or object, the orc's hands wrap around your wrists while the bear grips your ankles.  You struggle and try to flail your limbs, though the bear and orc are too strong.");
	//
	//output("\n\n\"<i>I suggest you try and relax, little chip.</i>\"  The satyr speaks while he uncorks a bottle of lust draft.  \"<i>And also to avoid dark pathways, but it's a little late for that.</i>\"  The satyr grins wickedly as his fingers clench around your nose.  Knowing what is coming, you hold your breath futilely.  Soon, you gasp and choke as the pink liquid is forced down your throat.  In moments your body begins to succumb to its effect.  Heat grows under your clothing and soon all four men are looking you over with hungry eyes.");
	//
	//output("\n\nYour [pc.gear] is quickly disposed of, putting your body on display for the four men.  Every breath is a whimpering pant as the effects of the lust draft take over your body.  Your eyes strain to remain focused.  The warmth and tingling floods your senses and washes down your skin to your loins, causing them to ache.");
	//if(pc.hasCock()) {
		//output("  [pc.EachCock] grows stiff as everyone watches.  You wince to try and fight off the draft, but soon you're driping pearls of pre-cum.");
	//}
	//if(pc.hasVagina()) output("  Your " + vaginaDescript(0)  + " grows slick in your excitement.");
	//if(pc.gender == 0) output("  Your skin heats and tingles, sweat wetting its surface.");
	//output("  The satyr runs his hand along your body and sizes you up with a lewd gaze and gentle touch, making you shudder under his fingertips from the effects of the draft.  \"<i>Not bad I suppose.  You could have done better, though.</i>\"  The satyr turns his head to the tiger man as the satyr's words strike at your pride, though the rebuttal on your lips is quickly silenced as his fingers");
	//if(pc.hasCock()) output(" wrap around your " + multiCockDescriptLight()  + ".");
	//else output(" rub over your " + assholeDescript()  + ".");
	//output("  His hand teases your body as the pair of muscled men holds you down in place.  You can only gasp out and wiggle your hips at the touch.  You turn your head and look pleadingly at your captors.  The large green man holding your wrists looks like an oversized goblin with yellow eyes.  His olive skin is stretched tight over his bulging muscles.  His bulky frame looks as powerful as he is tall, standing perhaps seven feet tall.  The equally built man holding down your lower body looks much like a bear man with piercing green eyes, shorter and stockier than the green orc by far.  The pair of 'gym bunnies' have matching bulges swelling in their pants as their eyes fix over your nude body");
	//if(pc.hasCock()) output(" and hard shaft");
	//if(pc.cockTotal() > 1) output("s");
	//output(".");
	//
	////[(If muticock 3 or more)
	//if(pc.cockTotal() >= 3) output("\n\nNot to be left out, each of the two men take a hand off of your limbs and grip one of your " + multiCockDescriptLight()  + ".  Your head swings back onto the table you're laid out on, mouth open wide as you moan and arch your back.  Each hand goes at an individual rhythm as sex overwhelms your thoughts.  The hands pinning you down are gone, though you're unable to focus on escaping.");
	//
	////(if cock(s)
	//if(pc.hasCock()) output("\n\nThe satyr pumps your length in his hand.  Your hips buck madly as the hand spreads your own pre-cum over your shaft with lewd schlicking noises.");
	//else output("\n\nHis fingers slip past your puckered flesh and dip into your " + assholeDescript()  + " and spread apart, loosening you for what feels like ages.");
	//output("  Without warning the hand is gone");
	//if(pc.cockTotal() > 1) output(" and your " + multiCockDescriptLight()  + " wetly slaps your stomach with need");
	//output(".  A whimper escapes your lips.  \"<i>This should be fine...</i>\"  The cool, collected voice of the satyr murmurs.");
	//
	//output("\n\n\"<i>I'm going to use the hole.</i>\"  The gruff voice behind you grunts out.  You turn to see the burly orc fumbling with his pants.  The size of his bulge sends a chill down your spine of ");
	//if(pc.lib < 50) output("fear");
	//else output("excitement");
	//output(".");
	//
	//output("\n\n\"<i>No.</i>\"  The satyr slaps his hand against the Orc's pectoral, making the pec jiggle faintly.  \"<i>If you go first you'll ruin it for the rest of us.  I'll go first.</i>\"  The group of captors hesitate a moment, then all nod in agreement.");
	//if(pc.isBiped()) output("  The bear shifts where he stands, grabbing your ankles and spreading your limbs almost painfully wide.  You wince from the sting of the strain on your leg muscles.");
	//output("  You hear the clopping of hooves on the floor as the satyr moves over to your " + buttDescript()  + ".  His hands grip over your " + hipDescript()  + " and drags you closer to the edge of the table so that your " + buttDescript()  + " hangs over the side of the table.  You raise your head to watch with a ");
	//if(pc.lib < 50) output("horrified");
	//else output("excited");
	//output(" expression as the satyr's hand strokes over his hard length.  It looks at least eight inches long, smooth like a human's cock and protruding from a forest of curly, brown fur.  The satyr lines himself up and rubs his stiff cockhead over your " + assholeDescript()  + ".");
	//
	//output("\n\nThe effects of the draft still fresh in your system, you moan out as your sensitive " + assholeDescript()  + " is poked and prodded.  The slick, hot satyr spunk clings to your pucker and eases your entrance open with his bulbous cockhead.  The satyr calmly takes his time until your hole is dripping and ready for him.  The seemingly endless torture has erstwhile driven you mad, seeming like the satyr has waited hours before finally deciding to plunge into you.  Once satisfied, the satyr shoves his hips forward and stuffs his cock into you roughly.  You wince at the sting and bite your lower lip, trying to keep from giving them the satisfaction of hearing your whimpers.  You shut your eyes and utter out a groan regardless, the feeling of the member pulsing against your silken walls making you utter a low moan");
	//if(pc.hasCock()) output(" while [pc.eachCock] twitches and leaks generously over your " + pc.skinFurScales());
	//output(".");
	//
	//output("\n\nYou gasp as something hot and wet presses to your face.  You open your eyes to be greeted with a stiff cock pressed against your cheek, the tiger man from before looming over you and rubbing his barbed, drooling shaft over your face.  \"<i>Should be obvious.</i>\" The tiger rumbles.  \"<i>But no biting, lest you want to be beaten and left outside this tent to lick your wounds.</i>\"  The tiger man growls as he insistently rubs his cock over your face.");
	//
	//output("\n\n\"<i>Get your dick off'a him. This is your payment to us.</i>\"  The bear bellows in a low tone.  You turn your head to see a thick bear cock dueling for the use of your face.  The orc remains out of sight behind you, though you hear noises of the brute moving around.  The bear and tiger continue to bicker as their cocks press to each side of your face forcefully, the rods sliding against each other and your lips to drool thick pre-cum over your skin.  They wet your lips with a taste of what is to come.");
	//
	//output("\n\nAll of this transpires as your " + buttDescript()  + " is slapped over and over by the low-hanging satyr balls.  The satyr lets out a pleased groan every now and then as your body shivers and trembles from his length hilting in you over and over and over.  He doesn't look like he'll stop anytime soon, though.  You turn your head to see the tiger's barbed, nine inch cock.  The stubby barbs make your skin tingle with each graze across your cheek.  On the other hand, the bear's cock looks shorter, about seven inches though by far the thickest meat in the bunch.  The massive girth would most likely hurt your jaw if you tried to wrap your mouth around it. What do you do?");
	////open menu of options [Suck tiger] [Suck bear] [Suck none]
	//menu();
	//addButton(0,"Suck Tiger",suckOffATiger);
	//addButton(1,"Suck Bear",suckOffABear);
	//addButton(2,"Suck None",suckOffNone);
//}
//
////<option 1 Suck tiger>
//private function suckOffATiger():void {
	//clearOutput();
	//output("You go with the barbed length.  You quickly take it into your mouth and suckle on the barbed tip.  The tiger's face melts from argument to pleasure.  \"<i>Looks like he likes mine better than your short sausage.</i>\"  The tiger gloats, the bear growling low and angrily.  Not to invite a fight over your face, you grip the bear's cock with one hand and begin to stroke over the thickness, though your fingers are unable to wrap all the way around it.  The pair give out pleased moans of resignation as you pleasure them.  The satyr still pounds away at your " + buttDescript()  + " as you suck off the tiger, his hands gripping your head as he throatfucks your eager mouth.  You slither your tongue under his shaft and let out a muffled moan as the barbs tingle over your throat, lips, and tongue.  With a rough thrust he buries your face into his furred groin, making his heavy sack slap your cheek.  The tiger man fucks your face furiously as you feel the satyr finishing in your ass.  Thick tiger cock continues to pound down your throat as warmth spreads within your gut, satyr cum flooding your inner walls.");
	////bumpy road
	//finalGayFinallee(0);
//}
//
////<option 2 Suck bear>
//private function suckOffABear():void {
	//clearOutput();
	//output("You turn your head and open wide, slowly squeezing the hefty bear cock past your lips.  Your jaw stretches to its limit around it and you suckle with wet, slurping noises.  You lavish all the attention you can on the fat rod in your mouth, using your tongue to lick and slurp the constant drool of pre-cum.  You flick your nimble tongue over the swollen cockhead and hear a low, pleased grunt from the bear.  Overhead, the tiger stares jealously.");
	//
	//output("\n\n\"<i>Bitches know the better cock when they see it.</i>\"  The bear lords over the tiger, making the angry feline snarl. Thinking quickly, you reach up a hand and begin to stroke along the barbed member while pushing the massive bear girth further past your lips, suppressing gags while the fat cockhead blunts against the back of your throat.  A hand grips the back of your head as the bear's hips begin to rock in and out of your wet mouth.  Soon, your lips are wet with the combination of saliva and copious bearspunk.  The hand on your head pushes you against the bear's groin, nestling your face in his furred, musky crotch while burying every inch of his fat cock down your mouth and plugging your throat.  Your eyes begin to water from the strain on your jaw and throat as the fat bear cock pulses, filling your mouth and pouring pre-cum straight down your gullet.  The bear begins to fuck your face, giving you a chance to gasp for breath every now and then.  This goes on for some time before you feel the satyr's cock pulse in your ass, spooge quickly filling you up.  Thick bear-cock pounds down your throat and distracts you from the satyr, though you can't help but feel the warmth of cum spreading deep within your gut and flooding your inner walls.");
	//
	////crazy steel jaw
	//finalGayFinallee(1);
//}
//
////<Option 3 Suck none>
//private function suckOffNone():void {
	//clearOutput();
	//output("Unwilling to wrap your lips around either of their lengths, you reach up with your hands and start to stroke the pair of arguing men off.  Each ceases their bickering to look down at you in confusion.  Their dazed expressions don't last long, quickly melting into pleasured, half-lidded gazes and moans.  Their drooling cockheads glaze your cheeks white with their pre-cum, making you reek of their strong, salty musk.  They seem eager for more and press their hard dicks over your face, prodding your closed lips with hot, pre-slicked cockheads.  You shut your eyes, one hand from each of them pressing the back of your head more into their needy cocks.  Your lips part just enough to taste their copious pre-cum, moans escaping your parted lips quietly as the satyr begins ramming his hips against you hard while his pent-up balls unload in your ass and paint your lower body with cum.");
	////no furry plx
	//finalGayFinallee(2);
//}
//
////all options lead to here for now
//private function finalGayFinallee(road:int = 0):void {
	//output("\n\nWith a wet pop, the satyr pulls his spent manhood from your " + assholeDescript()  + ".  He smears his softening cock over your " + buttDescript()  + " and leaves a white streak of cum across your cheeks.  He huffs a content breath and moves over to the side.  \"<i>I'm good, you guys decide who gets to fuck the slut next.</i>\"  You look up at the tiger and bear men.  Their eyes light up a moment before turning to look at your " + buttDescript()  + " with hungry lust.  Your spine shivers under their gaze, but before they can move a green blur runs past them.");
	//
	//output("\n\n\"<i>Zug want hole!</i>\" The large green orc runs to your behind, slapping his massive foot-long against your " + buttDescript()  + " as if to call 'dibs!'.  You bite your lips at the sight of the throbbing twelve inches sawing your ass cheeks apart, the dark olive flesh glistening with a thick layer of prespunk and slick, cool lubricant.  The orc's bulky muscles twitch menacingly as he stares the tiger and bear down.  The two of them stay where they are and, after a few moments, the orc grunts.  He looks down and lines himself up with your hole.  His thick, orcish girth presses against your " + assholeDescript()  + ", pushing in forcefully as the satyr's cum and rough pounding opened you just wide enough for the orc to slide in with little pain.");
	//
	//output("\n\nYou give a muffled groan as the giant orc cock impales you, the stiff erection grinding over your stretched-out, silken walls.  His fat orc sack swats your upturned " + buttDescript()  + ".  It coaxes whimpers from your lips as the green cock pulls out and slams back in, the brute of an orc focusing on getting further into you as his massive phallus plunges deeper and deeper with each thrust.  The colossal girth rides on the satyr's cum trails and pushes past it, stuffing you full to bursting with his orc meat.  His hands grip your hips and he roughly yanks you into a good angle as he begins to abuse your " + buttDescript()  + " with long, pummeling lunges.  He lets out guttural groans as his hefty cock drools orc cream, mixing it with the satyr's spooge as your hole begins to resemble a used condom.");
	//pc.buttChange(30,true,true,false);
	//output("\n\nYou can barely focus on pleasuring the two cocks in your hands as your lower body receives a slut's treatment.  \"<i>Ragh! Hole so tight around orc cock!  Make good orc bitch!</i>\"  The large green man groans and you feel his heavy sack clench against your cheeks.  Your eyes go wide as you're suddenly flooded with orc spunk, the sensation and sound of the cum overflowing from your hole to splatter against the Orc's balls and thighs overwhelming your senses.  The Orc lets out a \"<i>Wrahhg!</i>\" as he pins your hips, hilting his orc cock as he continues to unload his thick, fertile seed into you.  Your belly soon distends and bulges from the amount of cum shooting up your ass.  The orc man pants over you as you feel your " + assholeDescript()  + " dripping orc spunk like a leaking dam.");
	////now it's time for the choice before to matter, we got three endings here, one for each choice.
	////((Ending 1 , suck tiger, //bumpy road))
	//if(road == 0) {
		//output("\n\nYou are hardly able to focus on the barbed cock in your mouth, moaning around the hard cock as you look at the small bump on your belly.  With your hands servicing the bear as the tiger fills your mouth, the two men haven't left either side of your head.  With a wet pop, the tiger man pulls his saliva-coated prick from your mouth and he moves to the orc, shoving him aside with a grunt.  \"<i>My turn now.</i>\"  He grins impishly as he lines himself up with your hole, your " + assholeDescript()  + " looking like a well-used cum dump.  He rams in with ease and begins to pound away inside of you, making you moan with your mouth open wide.");
		//output("\n\nThe bear takes advantage of this, shoving his impossibly thick cock between your open lips.  Your lips vibrate around his shaft as you moan.  The bear climbs onto the table and begins to fuck your face while your " + assholeDescript()  + " is used for the third time in a row.  Your jaw stretches painfully around the girth of the bear's pride, your hands gripping at his legs as you look up at him with pleading eyes.  He only grins down at you as he watches his fat length slipping past your lips and bulging inside your throat.  Your throat constricts with gags and vibrates with moans as you involuntarily milk the bear's cock.  Each time the feline cock drills into you, the barbs leave you whimpering and gagging around the bearcock throatfucking you.  The barbs in your ass seem to bring a new sensation to the abuse as wet slapping noises echo in the tent.  Your " + buttDescript()  + " is wet with the combined cum of three males in a row, their cum and pre-cum dripping from your upturned " + buttDescript()  + " to form a growing puddle of lust on the floor and table.");
		//output("\n\nThe bear and tiger don't last long.  The bear finishes first as he pins your head between his hips and the table.  Your fingers clench over his furred legs as a deep groan rumbles from his belly.  You can feel his load shooting directly down your throat to fill your stomach.  The bear pulls out as the last lurch of his cock spits a rope of cum over your face, causing you to shut your eyes and wince as the hot liquid oozes down your cheeks.  With an amused grunt, the bear gets off the table to leave you with the tiger man.  With a raspy hiss the tiger is last, his flared barbs quivering over your cum soaked walls as he grows closer to adding his own spunk to your collection. He leans down over your laying form and gives you a wink.  ");
		//if(pc.hasCock()) output("His hand dips down to play with your " + multiCockDescriptLight()  + ", stroking you off as he gives a few more brutal pounds of his hips.  ");
		//else if(pc.hasVagina()) output("Fingers ram into your " + vaginaDescript(0)  + ", thrusting into you as he fucks your other hole.  ");
		//output("His face near yours, he licks your cheek and plants a brief kiss on your lips. You give him a confused look at the affection and he meets it with a wide grin.  \"<i>You're cute for a cocksucker.  Knew I had it made when I found you.</i>\" he snickers, causing you to blush.");
		//if(pc.gender > 0) output("  Your lips part as you moan, feeling your climax building before coating the tiger's hand and your lower body in your sex.  The tiger man just brings his hand up to his lips to taste your juices before hilting into you one last time.");
		//output("  A third wave  of warmth floods you, the pressure growing even higher as you resemble an overstuffed, breeding bitch.  Exhaustion catches up with you and you begin to feel your eyes grow heavy.  The last thing you see is the feline's face contorted in pleasurable orgasm before you nod off.");
 //
		//output("\n\nYou wake up with a start, the sound of morning birds echoing in the abandoned tent is all that greets you.  You try to get up quickly but immediately regret it.  Your body is sore from all the abuse you took last night.  You slide off the table and look around for your gear.  Shockingly enough, you find it folded up in a neat bundle");
		//if(pc.gems > 1) {
			//output(" with only a few gems missing");
			//pc.gems -= 3 + rand(4);
			//if(pc.gems < 0) pc.gems = 0;
		//}
		//output(".  You redress yourself before realizing something.  You have acquired something extra: a lust draft potion with an orange ribbon tied to it.  A note at the end reads: \"<i>Thanks for bailing me out of buying booze.  Your ass was amazing even after that orc had it.</i>\"  There's no name on the note but you have a good idea who left it for you, judging by the drawn tiger paw print in the corner.  You pocket the lust draft and leave the tent to head back to the bazaar in the morning light.\n\n");
		//pc.orgasm();
		//dynStats("sen", 5);
		//model.time.days++;
		//model.time.hours = 6;
		////Lust sated
		////Gained 1 lust draft, lost a few gems(9 or so?)
		//inventory.takeItem(consumables.L_DRAFT, returnToCampUseOneHour);
		////Time set to morning
		//statScreenRefresh();
	//}
	////((Ending 2 , suck bear, //crazy steel jaw))
	//else if(road == 1) {
		//output("\n\nYou are hardly able to focus on the girthy bear-cock in your mouth, moaning around the fat cock as you look at the small bump on your belly.  With your hands servicing the tiger as the bear fills your mouth, the two men haven't left either side of your head.  With a wet pop the bear pulls his saliva-coated prick from your mouth and he moves to the orc, shoving him aside with a grunt.  \"<i>My turn now.</i>\"  He grins impishly as he lines himself up with your hole, your " + assholeDescript()  + " looking like a well-used cum dump.  He rams in with ease and begins to pound away inside of you, making you moan with your mouth open wide.");
		//output("\n\nThe tiger takes advantage of this, shoving his barbed cock between your open lips.  Your lips vibrate around his shaft as you moan.  The tiger climbs onto the table and begins to fuck your face while your " + assholeDescript()  + " is used for the third time in a row.  The barbs scrape and tickle at your mouth and throat while your hands grip at the tiger's legs.  You look up at him with pleading eyes though he only grins down at you as he watches his barbed length slipping past your lips and bulging inside your throat.  Your throat constricts with gags and vibrates with moans as you involuntarily milk the tiger's cock.  Each time the bear cock drills into you, the thickness leave you whimpering and gagging around the tigercock throatfucking you.  Your throat vibrates around the tigercock with muffled moans as the thick bearcock makes your pucker ache from the strain.");
		//pc.buttChange(45,true,true,false);
		//output("\n\nHis hefty girth spreads you further than the orc, painfully spreading you apart while simultaneously driving you wild with the fuck.  Your " + buttDescript()  + " is wet with the combined cum of three males in a row, their cum and pre-cum dripping from your upturned " + buttDescript()  + " to form a growing puddle of lust on the floor and table.  The bear and tiger don't last long.  The tiger finishes first as he pins your head between his hips and the table.  Your fingers clench over his furred legs as a deep purr rumbles from his chest.  You can feel his load shooting directly down your throat to fill your stomach.  The tiger pulls out as the last lurch of his cock spits a rope of cum over your face, causing you to shut your eyes and wince as the hot liquid oozes down your cheeks.  With an amused grunt, the tiger gets off the table to leave you with the bear's cock in your ass.");
		//
		//output("\n\nWith a raspy growl the bear is last, his thick dick spasming as he grinds his fat cock over your cum soaked walls while he grows closer and closer to adding his own spunk to your collection.  He leans down over your laying form and gives you a wink.  ");
		////[(If cock(s))
		//if(pc.hasCock()) output("His hand dips down to play with your " + multiCockDescriptLight()  + ", stroking you off as he gives a few more brutal pounds of his hips.");
		//else if(pc.hasVagina()) output("Fingers ram into your " + vaginaDescript(0)  + ", thrusting into you as he fucks your other hole.");
		//output("  His face near yours, he licks your cheek and plants a brief kiss on your lips.  You give him a confused look at the affection and he meets it with a wide grin.  \"<i>You're cute for a cocksucker.  Loved the way you went right for my dick.</i>\"  He snickers, causing you to blush.");
		//if(pc.gender > 0) output("  Your lips part as you moan, feeling your climax building before coating the bear's hand and your lower body in your sex.  The bear just brings his hand up to his lips to taste your honey before hilting into you one last time.");
		//output("  A third wave of warmth floods you, the pressure growing even higher as you resemble an overstuffed, breeding bitch.  Exhaustion catches up with you and you begin to feel your eyes grow heavy.  The last thing you see is the bear's face contorted in pleasurable orgasm before you nod off.");
//
		//output("\n\nYou wake up with a start, the sound of morning birds echoing in the abandoned tent is all that greets you.  You try to get up quickly but immediately regret it.  Your body is sore from all the abuse you took last night.  You slide off the table and look around for your gear.  Shockingly enough, you find it folded up in a neat bundle");
		//if(pc.gems > 1) {
			//output(" with only a few gems missing");
			//pc.gems -= 3 + rand(4);
			//if(pc.gems < 0) pc.gems = 0;
		//}
		//output(".  You redress yourself before realizing something.  You have acquired something extra: A lust draft potion with an brown ribbon tied to it.  A note at the end reads: \"<i>I'll always remember the face you made trying to wrap your cute lips around my giant dick.</i>\"  There's no name on the note but you have a good idea who left it for you, judging by the drawn bear paw print in the corner.  You pocket the lust draft and leave the tent to head back to the bazaar in the morning light.\n\n");
		//pc.orgasm();
		//dynStats("sen", 5);
		//model.time.days++;
		//model.time.hours = 6;
		////Lust sated
		////Gained 1 lust draft, lost a few gems(9 or so?)
		//inventory.takeItem(consumables.L_DRAFT, returnToCampUseOneHour);
		////Time set to morning
		//statScreenRefresh();
	//}
	////((Ending 3 , suck none, //No furry plx))
	//else {
		//output("\n\nYou pant labored breaths as your skin tingles from the orc's flood of thick spunk.  Shakily, your hands continue to stroke off the bear and tiger's cocks and they continue to press to your cheeks and glaze your skin with pre-cum.  You feel the bear make a move towards the orc, but the green muscleman snarls and leans forward possessively.  \"<i>This Zug's hole!  Zug not done!</i>\"  The orc growls out as he protects his territory.  The bear backs away carefully and returns his dick to your face, pressing his cock back against your lips in determination to at least get some action.  The orc's fat cock stiffens as it revs back up for round two (Or in your case, round 3).  He pounds into your spunk-filled confines and you cry out in pleasure.  The two cocks in front of your face immediately thrust past your open lips, their cockheads rubbing together and filling your mouth with gushes of pre-cum.  Your tongue flicks over them to push them from your mouth but it only encourages them.");
		//output("\n\nYour hands frantically work over their shafts, squeezing and tugging at their hard erections while your nimble fingers dance over the stiff flesh.  Your efforts bear fruit as the two men groan out, one cumming and the other soon after, shooting into your mouth with twin streams of cum.  They shoot into your mouth and sloppily coat your lips and chin, pulling out to let a few ropes coat your face.  Your eyes shut as the two continue to give you a sperm facial.  Each new, hot rope of cum clings over your cheeks and warms your skin.  The tiger and bear move away as you reach up to clean the mess from your eyes and, as soon as you open them you're greeted with the sight of the large orc looming over you.  He grins oddly at you as his head leans down to lick the cum from your face, instead covering you in his saliva.  \"<i>Zug like you.  Zug know you love big orc cock.</i>\" His speech is simple and grunted, though the words make you feel a hot blush rise in your cheeks.");
		//
		//output("\n\nHe shouts out a war cry and starts brutally fucking you senseless.");
		//if(pc.hasCock()) output("  His hand drips down to clumsily play with your " + multiCockDescriptLight()  + ", stroking you off as he gives you a few more brutal pounds of his hips.");
		//else if(pc.hasVagina()) output("  Fingers dip into your " + vaginaDescript(0)  + ", ramming into you as he fucks your other hole.");
		//if(pc.gender > 0) output("  Your lips part as you feel your climax building, and soon you coat the orc's hand and your lower body in your lust.  The orc just brings his hand up to taste your juices before hilting into you one last time.");
		//output("  A third wave of warmth floods you and the pressure grows even higher as you resemble an overstuffed breeding bitch.  Exhaustion catches up with you and your eyes begin to grow heavy.  The last thing you see is the orc's face twisted in orgasmic pleasure before you pass out.");
		//
		//output("\n\nYou wake up with a start.  The sound of morning birds echoing in the abandoned tent is all that greets you.  You try to get up quickly but immediately regret it. Your entire body is sore from all the abuse you took last night.  Sliding off the table carefully, you look around for your gear.  ");
		//if(pc.gems > 1) {
			//output("The only thing missing is a few gems.  ");
			//pc.gems -= 3 + rand(4);
			//if(pc.gems < 0) pc.gems = 0;
		//}
		//output("You re-dress yourself quickly before realizing that you have something extra:  A bimbo potion with a green ribbon tied to it.  A note at the end of the ribbon reads: \"<i>Zug think you make good orc bitch. Drink this and Zug fuck all your holes!</i>\"  The writing is a childish scrawl, and you can barely make out the rest of the words.  By the stains on the paper, it's obvious the orc got too excited to properly finish his note, broken English or otherwise.  You pocket the bimbo potion and leave the tent to head back to the bazaar in the morning light.\n\n");
		////Lust sated
		////Gained 1 Bimbo brew, lost a few gems(9 or so?)
		////Time set to morning
		//pc.orgasm();
		//dynStats("sen", 5);
		//model.time.days++;
		//
		//model.time.hours = 6;
		////Lust sated
		////Gained 1 lust draft, lost a few gems(9 or so?)
		//inventory.takeItem(consumables.BIMBOLQ, returnToCampUseOneHour);
		//statScreenRefresh();
		////Time set to morning
	//}
//}
//
////Prisoner mod!
//private function investigateBackAlley():void {
	//clearOutput();
	//output("Your curiousity draws you half way down a dark alleyway between two tents. In the gloom ahead you see what appears to be a cage wagon, and hear the sounds of guttural voices engaged in boisterous conversation. Inexplicably you find yourself struck by an unwholesome sense of foreboding. <b>Even from here that cage looks like it is designed to carry people off to somewhere very unpleasant, some place where your life could be turned upside down and the rules you have become accustomed to in this world may no longer apply.</b> You take a long moment to consider turning back. Do you throw caution to the wind and investigate further?");
	//doYesNo(getGame().prison.goDirectlyToPrisonDoNotPassGoDoNotCollect200Gems, enterTheBazaarAndMenu);
//}