import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//Vala
public function loseToVala():void {
	spriteSelect(85);
	if(pc.gender == 3) loseToValaAsHerm();
	if(pc.gender == 1) loseToValaAsMale();
	if(pc.gender == 2) loseToValaFemale();
	if(pc.gender == 0) {
		clearOutput();
		output("Vala forces a bottle into your throat before your defeated form has a chance to react, and you grunt with pleasure as a new gash opens between your " + pc.legs() + "!", false);
		pc.createVagina();
		pc.gender = 2;
		doNext(loseToValaFemale);
	}
}
//Fight Loss-
//(Herm)
public function loseToValaAsHerm():void {
	spriteSelect(85);
	clearOutput();
	output("You collapse, no longer able to stand, and gasp weakly. The fairy took entirely too much delight in the fight, and her wet pussy is practically squirting with every heartbeat as she hovers over you, rubbing herself in anticipation. \"<i>The masters' will be happy. They will reward their Bitch with cum.</i>\" Her mouth drools as much as her slavering snatch. \"<i>Oh so much cum, and all for their good little pet.</i>\"\n\n", false);
	output("With a strength that seems out of place for the girl's rail-thin arms, she drags you to the center of the room and lifts your arms into the air. Licking up and down your " + pc.skinDesc + ", she grabs a pair of dangling manacles from the ceiling and claps them around your wrists with a metallic snap that seems horribly final to you. Responding to the sudden weight, the device the manacles are attached to begins to haul upward, pulling your chain into the air and lifting you by your arms into a slouched heap, dangling helplessly. The girl licks down your ribs, over your abdomen, and slathers your [pc.hips] in her saliva. More clapping irons puncture your weakened awareness and you jerk your body to find that she's bound your " + pc.legs() + " to the floor. You shiver, hanging in the rusty fetters, fearing what must surely be coming.\n\n", false);
	output("Expecting her to call for the imps at any moment, you are surprised when the fairy flies up to the ceiling and pulls down a long, cow skin hose. The leather pipe is stained, its stitching is crude at best, and bears a small, twistable spigot, but what worries you are the nozzles. Made of a blackened iron, the head of the hose branches into two, forking protrusions, both shaped like the foul, hooked cocks of imps. She licks the device reverently and lowers it toward her own, dripping pussy, nearly stuffing it inside her body before she remembers the rewards her masters are sure to shower her with, perhaps literally.\n\n", false); 
	output("At least the fairy's desire lubricated the thing, you think, giving yourself small comfort before the fairy brings the wicked, two-pronged device to your " + vaginaDescript(0) + " and " + assholeDescript() + ". You tremble at how cold it is, and try to shift away, but the chains and your own weakness leave you at the girl's mercies. She slides the dildo into your holes with agonizing slowness, giggling the whole time, until the metal cockheads are fully inside you. \"<i>It is good to be a toy,</i>\" she coos. \"<i>Good toys get used every day.</i>\" With a playful kiss on your rump, she gives the spigot the tiniest of turns and you hear a gurgling surge from somewhere above you. The hose comes alive in her hands and begins to twist and writhe in the air as some horrible fluid is pumped through it, toward the iron cocks and your defenseless nethers. You clench as hard as you can, trying to expel the penetrating shafts, but the fairy seems to be getting stronger and more mad the longer this goes on. You moan and try to prepare for the worst.\n\n", false);
	//[Next]
	doNext(loseToValaAsHermPartII);
}
public function loseToValaAsHermPartII():void {
	spriteSelect(85);
	clearOutput();
	output("It proves to be so much worse than you thought. Even though the nozzle is at its lowest setting, you can feel hot spunk flowing into your cunt and colon, the hose jerking as globs of the jizz begin to ooze into your recesses. The fairy laughs with a voice that is all the more wicked from the pure, clean, crystal tones it carries. \"<i>The masters' love is so sweet inside us. More future masters for us to birth and so many orgasms.</i>\" She begins to tweak her clit and turns up the crank a notch, the trickle of slimy goo becoming a regular pumping. If not for the coldness of the metal inside you, the heat of the cum would be unbearable. You have the horrible realization that imps must be filling the hidden reservoir even as their fairy slave guides it into you. You scream in disgust and wriggle your [pc.ass], trying to get the cursed toy out of you.\n\n", false);
	output("The fairy is too aroused by your bondage and she can't help herself from joining in. She pulls the cum pump from your sopping holes and flutters against your chest. Slamming herself on your [pc.cock], she twists the hooking tubes so that one plugs back into your spunk-drooling " + vaginaDescript(0) + " and the other into her ass. The girl screams right along with you, her mindless joy drowning out your dismay as she bucks against your [pc.hips] in time to the cum flooding the two of you. \"<i>We're good sluts,</i>\" she gurgles. \"<i>Maybe- ah- Bitch will keep you secret from t-t-the masters for a while longer. Prepare you- ooo- for them. You will be so o-O-OBEDIENT. You'll learn to love Vala,</i>\" she whispers, a gleam of intellect shining through her broken mind for an instant. She grips the iron shafts and jams them deeper into your bodies, her bloated labia squeezing your [pc.cock] all the tighter. The hooked glans at the tip of the pump drive her wild and she begins hard-fucking the two of you with it, parting your cervix even as you slam into hers.\n\n", false); 
	output("She kisses your [pc.nipple] and your spine shivers as you hear her twisting the spigot off of the base, releasing the flow. You try to scream, but your voice is ripped from your throat as a cascading geyser of fresh imp cum is blasted into your womb with enough force to launch you forward, straining against the mounted fairy, only held aloft by your chains. Your senses are assaulted by the unholy scene, the sound of creaming seed spurting against your womb carries over the pitched voices with a frothing gush. The firehose of jizz inflates your body with the foaming spunk even as it fills the fairy like an overused onahole, her fey waist bloating against your groin as your abdomen swells to meet it. The pressure of the straining cavities squishes some of the cum back out of your " + vaginaDescript(0) + ", just as you orgasm, splattering your seed into the overstuffed fairy. The mind-erasing cum flood pumping into you feels like it has lit a fire in your body that is searing your womb and working its way up your gut toward your head.\n\n", false); 
	output("You cry out desperately, but the fairy is the only one to hear your pleas and she is lost in her own sea of brainless orgasms. You resist the swarming sensations, trying to avoid the fairy's fate, but she's got you trapped between her twitching cunt and the jizz-blasting hose. All you can think of is the over-ripe sweetness of the fairy's fluids splashing against your thighs and the jack-hammering blasts of seed flooding your blazing cunt. The fire in your gut creeps up to your [pc.fullChest] and your heart pounds with as much force as the foot of cum-fed iron inside your overflowing " + vaginaDescript(0) + ". You try to promise yourself that you won't give in, but your captor twisting on your cumming cock and the barbed dildo inside your spunk-inflated womb drive the words from your mind. The heat in your breast surges into your head and it almost feels as if the seed blasting into your birth canal has made it up to your brain. You try to think, but it's too difficult. Thinking brings terrible pain, it's so much easier to surrender. To let yourself break. You look into the enslaved fairy's empty, pink eyes one more time and whisper a prayer of thanks to your Mistress. She seems started by the title and a slow smile spreads across her heart-shaped face. Then, all thought fades and your world becomes pink.\n\n", false);
	//[Go to Bad End 1]
	doNext(badEndValaNumber1);
}
//Fight Loss-
public function loseToValaAsMale():void {
	spriteSelect(85);
	output("You collapse, no longer able to stand, and gasp weakly. The fairy took entirely too much delight in the fight, and her wet pussy is practically squirting with every heartbeat as she hovers over you, rubbing herself in anticipation. \"<i>Bitch will show you the masters' pleasures. They will reward it with cum.</i>\" Her mouth drools as much as her slavering snatch. \"<i>Oh so much cum, and all for their good little slut.</i>\"\n\n", false);
	output("You are powerless to stop the fairy as she drags you to the south wall and up to the wooden rail secured a couple of feet off the ground. \"<i>When she was still growing, Bitch was too small and tight for the masters,</i>\" your captor tells you. \"<i>They blessed her with this ladder to make us big enough. You will feel their generosity.</i>\" Gripping you under the arms, the fairy's lust-fuelled strength lifts you off the ground and flies you directly over the bristling peg ladder.\n\n", false);
	//[Next]
	if(pc.ass.analLooseness < 2) doNext(loseToValaAsMaleIITight);
	else if(pc.ass.analLooseness < 3) doNext(loseToValaMaleIILoose);
	else if(pc.ass.analLooseness < 5) doNext(loseToValaMaleIIVeryLoose);
	else doNext(loseToValaMaleIIGape);
}
public function loseToValaAsMaleIITight():void {
	spriteSelect(85);
	clearOutput();
	//(tight ass)
//	if(pc.ass.analLooseness <= 1) {
	output("\"<i>It will never please them like that,</i>\" she scolds. \"<i>You must be made more to their liking or they will never grant you endless joy.</i>\" She grinds her button-stiff clit against your abdomen as she lowers you toward the smallest peg on the rail, an uncarved, lacquered wooden nub an inch wide and three inches long, barely larger than a finger. You try to attack the fairy before she can plug you in, but she simply drops you the rest of the way, and what should've been a relatively painless insertion becomes agonizing as you hit the peg and three inches of hardened wood fill your " + assholeDescript() + ". You gasp and try to get off the device, but the fairy has already grabbed you again and pulls you back into the air. You clench your muscles as you look at the far end of the ladder in horrified fascination at a wooden carving that would shame a minotaur. The fairy moves up a couple of notches.", false);
	//[Player gets looser ass, and move to next level]
	pc.ass.analLooseness = 2;
	//[Next]
	doNext(loseToValaMaleIILoose);
}
public function loseToValaMaleIILoose():void {
	spriteSelect(85);
	clearOutput();
	//(loose ass)
	output("\"<i>Sluts are trained well,</i>\" she sighs, happily. \"<i>This one knows only the pleasures of the masters, now.</i>\" The peg under you would be above average on a normal human- easily 7 inches long and two inches wide. Your " + assholeDescript() + " clenches and you writhe in the fairy's arms, but she lets gravity do her dirty work, lowering you onto the human-sized wooden cock, the varnished surface pulling apart your [pc.ass] and sliding into your nethers with an uncomfortable tight sensation. Despite the humiliation of the rape, the pressure on your prostate begins pumping blood into your [pc.cock], turning your body into a traitor. You don't dare try to pull off, for fear of the damage it might do to your anus, and you are forced to sit in shame on the wooden erection. The girl flutters down and laps at your stiffening cock, trying as hard as she can not to mount you then and there. Her hungry tongue takes some of the building pain from you. Finally, she decides you've had enough and lifts you into the air, but to your dismay, she takes you another few notches down the line.", false);
	//[Player's ass widens and go to next]
	pc.ass.analLooseness++;
	//[Next]
	doNext(loseToValaMaleIIVeryLoose);
}
//(Very loose ass)
public function loseToValaMaleIIVeryLoose():void {
	spriteSelect(85);
	clearOutput();
	output("The fairy suspends you over a bulbous cock, at least a foot long and three inches wide, carved to resemble an imp's barbed, demonic shaft. \"<i>The masters are very kind,</i>\" the girl promises, \"<i>They know a slut's limits and gladly help it exceed them. They will rebuild you to their liking.</i>\" The memory of her own training has overwhelmed her dulled expression and she can't help but mount you in the air, swinging her legs around your waist and guiding her slavering pussy to your [pc.cock]. Just as your head slides into her cunt, however, she loses her grip and you fall from her arms, landing atop the imp dick, drawing an agonized scream of pain. The twelve inches of wood worn down to a polished gleam vanish up your " + assholeDescript() + " and distort your intestines. You are so full that you feel like you've been speared through the gut, but your prostate does not care about your misery. Full penetration drives your cock wild and it surges to life, pulsing with every heartbeat. You can feel an orgasm building, but all you care about is the crushing pressure in your nethers. Just before you can cum, the fairy lifts you off the terrible prong and you actually sigh in relief, despite being denied release. Your cock twitches in the open air and it feels like a weight has been lifted from your chest. She giggles and flies you all the way to the last prong.\n\n", false);
	//[Player's ass widens and go to last]
	pc.ass.analLooseness = 5;
	//[Next]
	doNext(loseToValaMaleIIGape);
}
//(Gaping asshole)
public function loseToValaMaleIIGape():void {
	spriteSelect(85);
	clearOutput();
	output("The fairy takes you to the final peg along the rail. It is a nightmarish mix of horse, dog, and minotaur cock. It has a flared head, to make the initial penetration all the more painful, a bulging knot on the end to utterly destroy your spincter, and the whole thing stands a foot and a half tall, nearly five inches wide at the tip. You beg the fairy. You plead. There is no way you can go onto that, you say, it will kill you. All dignity flees as you pitifully sob up to her. You'll do whatever the imps want- whatever the Masters want, you correct yourself. You'll be their toy and cum dump, you'll drink every last bit of your masters' love until you can't taste anything else. You will surrender yourself to them, body and soul. Whatever it takes, you implore, just not that peg! The fairy doesn't respond, her pupil-less eyes unchanging and unmoved by your agony, just swirling with pink lust and trained obedience. She lowers you just enough for you to feel the hard, flared tip of the monstrous thing press against your " + assholeDescript() + " and your resolve fails you. You promise the fairy everything. She lifts you up off the terrible final peg and you laugh in relief.\n\n", false);
	output("Turning you around in her arms, the fairy lets you see the full depths of mindless depravity in her empty gaze. She strokes your [pc.cock], bringing it just shy of climax before mounting you, her sopping cunny softer and warmer than anything you can remember. \"<i>Silly toy,</i>\" she whispers to you. \"<i>It has nothing to give. The masters possess everything already.</i>\" She gives you a peck on the cheek and stops flapping her dragon-fly wings, letting the two of you plummet toward the monstrosity. Your world explodes into pain and your cock erupts with a mind-breaking orgasm inside the girl before your vision fails and the merciful oblivion of unconsciousness rushes over you.", false);
	//[Go to Bad End 2]
	doNext(badEndValaNumber2);
}
//Fight Loss-
//(Female)
public function loseToValaFemale():void {
	spriteSelect(85);
	clearOutput();
	output("You collapse, no longer able to stand, and gasp weakly. The fairy took entirely too much delight in the fight, and her wet pussy is practically squirting with every heartbeat as she hovers over you, rubbing herself in anticipation. \"<i>It will show you the masters' pleasures. They will reward it with cum.</i>\" Her mouth drools as much as her slavering snatch. \"<i>Oh so much cum, and all for their good little Bitch.</i>\"\n\n", false);
	output("The fairy paces around you, a look of false sympathy running across her face like a mask. \"<i>Does it hurt? Come, Bitch will make you feel better.</i>\" She loops one of your arms around her slim shoulders and lifts you with an ease that makes you shudder. With surprising strength, she flies you to a corner of the room and carefully sets you down atop a dingy, cum-stained pillow. Despite the disgusting conditions, it is more comfort than you expected at the mad girl's hands and you allow yourself a sigh as you gather your thoughts, trying to think of a way out of this predicament. You are startled when a loud clank breaks your reprieve and you try to rise, only to be jerked back down to your [pc.ass]. You claw at your neck and find that the fairy has slapped a steel collar around you, with barely two feet of chain keeping it off the ground.\n\n", false);
	output("\"<i>It is so tired after such a big day, aren't you?</i>\" she asks, sweetly. \"<i>Sluts just need a bath and a warm meal. We will be much happier soon.</i>\" The girl lifts her hand to a lever set cleverly into the wall so as to be nearly invisible. You tremble at the implications and are nearly relieved when all it produces is an ice-cold bath from a nozzle in the ceiling above. You gasp at the freezing water and struggle to get out of the downpour, but your collar keeps you under it, the water washing over you and stealing the warmth from your limbs. The cold turns your chest into a crushing weight that squeezes the breath from your lungs. When it finally relents, you pant desperately while the water washes down the drain in the center of the room. You feel like a soggy mess, " + hairDescript() + " wet and icy.\n\n", false);
	output("Trying to regain your composure after nearly being drowned and frozen in one go, you hardly even notice when the fairy places a big bucket in front of you. \"<i>All clean? The slut looks so pretty now. But it has to make itself presentable. The masters must enjoy your appearance and smell as much as your flesh. One warm meal for a good pet.</i>\" You curse the slave and knock the bucket over, spilling its vile contents onto the floor, seething spunk sliding down to the drain. The girl laughs, spritely voice like shattered crystal. \"<i>Bitch remembers when she was as defiant as you. If the sweet slut does not want her meal, perhaps another bath?</i>\" She slides her hand to another switch and leans on it, while licking her lips. Instead of rushing water, a curtain of white fills your eyes, nose, and mouth, a rush of seething heat pouring around you. Clawing at your face and the collar, you realize she's dumped a shower of splattering cum on you from some recessed reservoir in the ceiling. You scream and thrash, but the goo just keeps coming, burying you in a slimy shell, your defiance only allowing it to roll down your throat with hacking swallows. When you finally slump down and let it run over you, the fairy relents.", false);
	
	//[Next]
	doNext(loseToValueFemalePtII);
}
public function loseToValueFemalePtII():void {
	spriteSelect(85);
	clearOutput();
	output("You shiver uncontrollably and hug yourself like a wounded animal. Your [pc.nipple] and [pc.clit] burn under the pale goop, rock hard and pulsing with demands for stimulation. The fairy bitch happily places a new bucket next to you, this one fuller than the first. \"<i>It wants a meal?</i>\" she inquires doubtfully, perhaps hoping to keep it for herself. You reluctantly reach for the bucket, nearly lunging when it looks like the fairy is about to pull the lever again. You look into the bucket and shiver as the stench of the spooge assails your nostrils, even more potent than the jizz bath rolling down your bare skin in cream bulbs. You reluctantly take a glob between your fingers and thumb and with a timid motion, you raise your fistful of the odious syrup and spread it over your lips like a soapy lather. Rubbing the vile goo so close to your nose makes you nearly convulse at the reek and you hug at your slime-soaked body, trying to curl up, away from the reeking bucket. Your lower torso becomes a sloppy mess of pale, nearly clear fluid rolling off of your curves in blobby clumps.", false);
	
	output("You catch yourself rubbing the spooge against your " + pc.skinDesc + " and into your [pc.fullChest] and you shake your head, trying to clear your mind. Remember how horrible it smells, you stress to yourself. It's disgusting and you're only doing it to please the insane fairy. Still, you shiver when you reach your nipples and find your thumbs applying too much pressure to your yielding softness, rubbing the spunk across your " + pc.skinDesc + " in tight circles. Your next handful is larger and the next is larger still, until you drag the bucket closer to catch more of its dripping load with your flesh. You rub the warm jizz into your flesh, reveling in the heat it bleeds into your dripping body, the smell curling around your nostrils and filtering into your brain. You slop globs of oily cum across your face and head, rubbing it into your nostrils with your pinkies.\n\n", false);
	
	output("You lift the bucket, ready to slurp up the whole pail when the fairy makes an off-handed comment. \"<i>The masters mix their love with minotaur beasts, to make it seep into your mind,</i>\" she sighs, wistfully, looking terribly envious of your position. The girl seems to regret giving you the addictive cum, her words dulled by your jizz-drunk senses. Dimly, some part of your mind wonders if the minotaurs' drug-like seed is already working, but it hardly matters anymore. You're too far gone by now. You put the bucket in your lap and bend down, into it. Placing the tip of your nose against its lurid surface, you breathe deeply, drinking in the odor as much as savoring the moment. Then, with relish, you submerge your " + pc.face() + " into the inky abyss of the spunk bucket, inhaling the sweet honey with an open mouth, air escaping your throat and bubbling up as you suck down gulp after gulp from your full-facial meal. The imp juice shower set your skin on fire, but drinking their salty discharge fills your organs with a raging inferno that drives away your memories, one by one. You gulp mouthfuls down, without even pausing to breathe. Every swallow blanks a part of your mind, first your crusade against the demons of the cave, then the friends you've met in this world, and then even your home. The liquid passion fills your mind, burying all else. Every part of your personality is replaced by the need for ejaculate and your vision turns white as, finally, you can't seem to recall your name.", false);
	
	//[Go to Bad End 2]
	doNext(badEndValaNumber2);
}
//Fight Win-
public function fightValaVictory():void {
	spriteSelect(85);
	clearOutput();
	output("The fairy girl collapses, well-drilled obedience robbing her limbs of their fight. She squirms to a crouching bow, fully accepting you as her new " + pc.mf("Master","Mistress") + ". The warped fae's empty eyes look up at you, her face a mask of rapture as she anxiously awaits her punishment, wagging her butt in the air as lubrication gushes down her thighs. It seems being defeated has excited the broken creature to a breeding frenzy. Her endurance must be incredible to be this frisky after your battle.", false);
	flags[kFLAGS.TIMES_PC_DEFEATED_VALA]++;
	//[Fuck] [Leave]
	if(pc.gender > 0) {
		output(" What will you do?", false);
		simpleChoices("Fuck",vala.valaFightVictoryFuck,"", null,"", null,"", null,"Leave",cleanupAfterCombat);
	}
	else cleanupAfterCombat();
}



//BAD ENDS
public function badEndValaNumber1():void {
	spriteSelect(85);
	clearOutput();
	output("When you regain your senses, you're no longer in the cavernous dungeon you passed out in. You blink, trying to adjust to the bright light around you, but it doesn't help. Every sense is aflame and it's impossible for you to move without exciting some nerve ending, sending a thrill of pleasure radiating along your sensitive regions. You try to think, to reason out where you are, but holding a thought in your head for longer than a minute is extremely difficult, as if your mind was muffled by thick wool. You try to remember what happened, but that too is just out of your reach. All this mental exercise is giving you a headache, so you give up, and just drink in the sensations around your body. A shimmering, spritely face comes into view and a thought blazes a clear, white-hot path through your groggy brain. Recognition clears all your doubts and worries away. Your Mistress. This is your Mistress.\n\n", false);
	output("The fairy girl smiles broadly, stroking your face affectionately, her almond-shaped pink eyes full of sweet desire. \"<i>How is my Pet this morning?</i>\" she inquires, voice like silver chimes ringing in your head. \"<i>Aw, are you still waking up with headaches, Pet? Ooo, let your Mistress clear that poor head of yours.</i>\" She uncorks a small vial of pink fluid and places it against your lips, but you hardly need the encouragement. You wrap your mouth around the lust draft and drink greedily, sucking down the wine-sweet draught, fiery passion driving the pain from your mind in a second and you reach out to embrace your dear Mistress. She giggles and shoos you back down with a touch. \"<i>No no, Pet. It's meal time first, remember? Every day I steal more potions from those nasty demons, and we see what they do, don't you recall?</i>\"\n\n", false);
	output("Dimly, in some corner of your mind, you seem to recall having this conversation before, perhaps several times. And didn't your Mistress use to be the one who had difficulty thinking straight? Back before you were simply Pet, didn't people call you something else? A name floats just out of reach, but you shake it away as your Mistress produces a dizzying array of bottles. She feeds you a thick, green beer that fills your tummy with pleasant warmth and makes your head swim. You can feel your body changing, as your " + vaginaDescript(0) + " grows deeper and wider and you giggle, flicking your fingers in and out of your pussy, playing with the hot passage. Your Mistress takes a gulp of her own and coos as the thick white fluid rolls down her throat. She raises her voice in a spritely gasp of pleasant surprise and you can see her tiny joy buzzer of a clit growing longer and thicker before your eyes. It swells to six inches, then eight, before finally settling at 10\". Gradually, it gains definition and its tip broadens into a head, a small slit opening at the top, a bead of pearly cum rolling out and down the bright pink shaft. She strokes the newly grown dick with slim fingers and trembles in excitement, eyeing your body hungrily.", false);
	output("You giggle, mindlessly, and let your Mistress sate her unquenchable lust with your yielding body, savoring the submission. She rides you raw, fucking your drug and sex-addled body hard enough to knock the memories of the day out of your head, just as she did yesterday and the day before that. With each passing day, you lose more of yourself to your Mistress and, in time, all that is left is the warped fairy's broken Pet.", false);  
	//GAME OVER.
	getGame().gameOver();
}
public function badEndValaNumber2():void {
	spriteSelect(85);
	//(Imp)
	clearOutput();
	output("You come to with a splitting headache and the taste of something foul in your mouth. You struggle, but find that your limbs have been chained up and your " + pc.legs() + " bound by a thick, rubber coating, squeezing your lower body painfully. You've been fitted with several rubber pieces of the same sort, in fact- the most notable is the black corset that makes breathing difficult and binds your waist to a hyper-feminine fantasy. You've also been fitted with large, rubber fairy wings attached by straps around your shoulders that pull your chest forward, painfully. An O-ring gag has been latched around your face, connected to a long, clear tube that's been fed a foot or two down your throat. You try to shake it loose, but it's far too deep for you to have a hope of removing it without help.\n\n", false);
	output("Your struggles have alerted your captors that you've awakened. A large imp steps in front of your vision, his arms tucked behind his back, contemplatively, as he admires your predicament. Instead of speaking, he simply produces a bronze placard with your name engraved on it and taps a long finger on the metal plate. Then, he gestures at the contraption you've been hooked to. The tube leading into your mouth winds upward, to a large funnel, with a twistable knob on it. Above the funnel, the four-foot fairy is suspended by new chains, practically covered in a swarm of tiny imps. The demons are barely a foot tall, perhaps immature or half-breeds, and cling onto her skin with a mixture of lust for her flesh and fear of the drop, using any convenient hole both to fuck and keep from falling. Two are using her pussy at once, another at her ass, a fourth on her face, a pair fucking either hand, and half a dozen more, rubbing themselves across her armpits, the back of her knees, even just using her purple hair for added friction as they jerk themselves off. All the spunk from their frantic rutting splashes into a wide basin below, flowing into the funnel connected to your tube.\n\n", false);
	output("The large imp in front of you gives the knob on the funnel a twist and, to your horror, the sloshing flood of imp seed and fairy jizz comes washing down the winding pipe, sliding right past your undefended lips and down your penetrated gullet. Your stomach recoils at the infernal meal, but it just keeps pouring from the over-fucked fairy girl and her precariously perched offspring. As the cum washes down the hose, the silent imp uncorks a little black vial and pours it into the funnel, mixing it with the seething river running into your belly. You try to close your throat, to vomit, to bite through the gag, anything to keep the concoction from reaching you, but your attempts are in vain, and the sable fluid runs into your body. You shudder, mind racing for ways to escape, but your thoughts are interrupted when the apparent leader of the imps leans down and takes your chin in his hand, smiling a wicked grin of jagged, uneven teeth.", false);
	//[Next]
	doNext(badEndValaNumber2Pt2);
}
public function badEndValaNumber2Pt2():void {
	spriteSelect(85);
	clearOutput();
	output("\"<i>When we captured Vala, I entertained the thought of breaking her on my dick like a crystalline condom, but I'm rather glad I chose to raise her to be my pet instead.</i>\" The imp's voice is familiar and your mind lurches to the memory of that first violation you suffered when you stepped through the portal to this world. Zetaz. He said never to forget the name Zetaz. You eyes roll in panic, but he holds your chin, his leering face filling your vision. \"<i>As a reward to obedient little Vala, I've decided to remake you in her image. We'll crush all that fatty flesh from your waist, keep your torso bound until you're too weak to walk, and pump you so full of drugs and cum that even seeing your name will be painful,</i>\" he taps the bronze plaque he's prepared for you, a mirror to the fairy's. \"<i>Why, in a few months, we'll be hard pressed to tell the two of you apart.</i>\" A fresh wave of fairy-lubricated imp-seed pumps into your abdomen and the rubber girdle strains, but holds, washing the spunk back up, into your throat, until it feels like you might drown in the frothing cream.\n\n", false);
	output("There's no time to contemplate your fate, however, as the imp's black poison seems to take hold and you feel a burning all along your body. ", false);
	//(No vagina: 
	if(!pc.hasVagina()) {
		output("Between your thighs, a wet slurping tears through the air and a sudden seething heat fills your groin as a fresh pussy opens up, just under your dick.  ", false);
		pc.createVagina(true, 1, 0);
	}
	//(No breasts: 
	if(pc.biggestTitSize() < 1) output("You shudder and your chest feels like it's being flooded by the spooge floating at your tonsils. Before your eyes, the girdle around your chest is pushed down and a pair of swelling breasts fills your vision, filling heavily with milk just aching to be sucked from your distended nipples.  ", false);
	output("The space between your shoulder blades feels like it's been torn open and your muscles reknit themselves as gossamer wings burst from your skin, thin as a dragonfly's and nearly as long as you are tall, settling against their rubber counterparts. Every inch of your skin seems to blister as a feeling of molten glass pouring over you causes you to tremble with agonized shudders, your pores sealing and skin gaining a glossy sheen.\n\n", false);
	output("\"<i>You're looking more like her by the second,</i>\" Zetaz compliments, stroking your now-flawless face. \"<i>Don't worry about that pesky mind of yours- I don't like using drugs to wipe that imperfection away like some of my kin. No, we'll just use you until you break. Perhaps I'll let Vala have you from time to time, too. Won't that be fun? The two of you will grow to be inseparable, I'm sure.</i>\" Zetaz steps back and signals the imps clinging to the fairy to come down. \"<i>Why don't we get started?</i>\"", false);
	//GAME OVER.
	getGame().gameOver();
}		
