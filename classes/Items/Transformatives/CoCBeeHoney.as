package classes.Items.Transformatives
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCBeeHoney extends ItemSlotClass
	{
		//constructor
		public function CoCBeeHoney()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			
			//Used on inventory buttons
			this.shortName = "BeeHony";
			
			//Regular name
			this.longName = "vial of giant-bee honey";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a vial of giant-bee honey";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This fine crystal vial is filled with a thick amber liquid that glitters dully in the light.  You can smell a sweet scent, even though it is tightly corked.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 60;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.combatUsable = false;
			this.targetsSelf = true;
			
			this.version = _latestVersion;
		}
		
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			useHoney(target, false, false);
			return false;
		}		
		
		public static function useHoney(pc:Creature, pure:Boolean, special:Boolean):void
		{
			var player:PlayerCharacter = pc as PlayerCharacter;
			var changes:Number = 0;
			var changeLimit:Number = 1;
			clearOutput();
			//pc.slimeFeed();
			//Chances of boosting the change limit.
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Drink text
			if (special) {
				output("You uncork the bottle and pour the incredibly strong smelling concentrated honey down your throat.  Its taste is also mighty intense.  All at once you feel the effects of the substance start to course through your body.");
			}
			else { //Text for normal or pure
				output("Opening the crystal vial, you are greeted by a super-concentrated wave of sweet honey-scent.  It makes you feel lightheaded.  You giggle and lick the honey from your lips, having drank down the syrupy elixir without a thought.");
			}
			//pc.refillHunger(15);
			//if ((pure || special) && pc.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Pure or special honey can reduce the corruption of a phouka baby
				//if (getGame().flags[kFLAGS.PREGNANCY_CORRUPTION] > 1) { //Child is phouka, hates pure honey
					//output("\n\nYou feel queasy and want to throw up.  There's a pain in your belly and you realize the baby you're carrying didn't like that at all.  Then again, maybe pure honey is good for it.");
				//}
				//else if (getGame().flags[kFLAGS.PREGNANCY_CORRUPTION] < 1) { //Child is faerie, loves pure honey
					//output("\n\nA warm sensation starts in your belly and runs all through your body.  It's almost as if you're feeling music and you guess your passenger enjoyed the meal.");
				//}
				//else { //Child is on the line, will become a faerie with this drink
					//output("\n\nAt first you feel your baby struggle against the honey, then it seems to grow content and enjoy it.");
				//}
				//getGame().flags[kFLAGS.PREGNANCY_CORRUPTION]--;
				//if (pure) return(false); //No transformative effects for the player because the pure honey was absorbed by the baby - Special honey will keep on giving
			//}
			//Corruption reduction
			if (changes < changeLimit && pure) { //Special honey will also reduce corruption, but uses different text and is handled separately
				output("\n\n");
				changes++;
				if (pc.cor() > 80) output("Your head aches, as if thunder was echoing around your skull.  ");
				else if (pc.cor() > 60) output("You feel a headache forming just behind your eyes.  In no time flat it reaches full strength.  ");
				else if (pc.cor() > 40) output("A wave of stinging pain slices through your skull.  ");
				else if (pc.cor() > 20) output("A prickling pain spreads throughout your skull.  ");
				else output("You feel a mildly unpleasant tingling inside your skull.  ");
				output("It quickly passes, leaving you more clearheaded");
				pc.cor(-(1 + (pc.cor() / 20)));
				//Libido Reduction
				if (changes < changeLimit && rand(1.5) == 0 && pc.libido() > 40) {
					output(" and settling your overcharged sex-drive a bit");
					pc.libido( -3);
					pc.lust( -20);
					changes++;
				}
				output(".");
			}
			//bee item corollary:
			if (changes < changeLimit && pc.hairType == GLOBAL.HAIR_TYPE_TENTACLES && rand(2) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				output("\n\nAs you down the sticky-sweet honey, your head begins to feel heavier.  Reaching up, you notice your tentacles becoming soft and somewhat fibrous.  Pulling one down reveals that it feels and smells like the honey you just ate; you watch as it dissolves into many thin strands coated in the sugary syrup.  <b>Your hair is back to normal (well, once you wash the honey out)!</b>");
				pc.hairType = GLOBAL.HAIR_TYPE_REGULAR;
				changes++;
			}
			//(removes tentacle hair status, restarts hair growth if not prevented by reptile status)
			//Intelligence Boost
			if (changes < changeLimit && rand(2) == 0 && pc.IQ() < 80) {
				pc.slowStatGain("i", 0.1 * (80 - pc.IQ()));
				output("\n\nYou spend a few moments analyzing the taste and texture of the honey's residue, feeling awfully smart.");
				changes++;
			}
			//Sexual Stuff
			//No idears
			//Appearance Stuff
			//Hair Color
			if (changes < changeLimit && (pc.hairColor != "shiny black" && pc.hairColor != "black and yellow") && pc.hairLength > 10 && rand(5) == 0) {
				output("\n\nYou feel your scalp tingling, and you grab your hair in a panic, pulling a strand forward.  ");
				if (rand(9) == 0) pc.hairColor = "black and yellow";
				else pc.hairColor = "shiny black";
				output("Your hair is now [pc.hairColor], just like a bee-girl's!");
				changes++;
			}
			//Hair Length
			if (changes < changeLimit && pc.hairLength < 25 && rand(3) == 0) {
				pc.hairLength += rand(4) + 1;
				output("\n\nFeeling a bit off-balance, you discover your hair has lengthened, becoming [pc.hair].");
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && pc.bRows() > 2 && rand(3) == 0) {
				changes++;
				output("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most [pc.lowestBreasts] shrink down, disappearing completely into your ");
				if (pc.bRows() >= 3) output("abdomen");
				else output("chest");
				output(". The [pc.nipples " + (pc.breastRows.length - 1) + "] even fade until nothing but [pc.skinFurScales] remains. <b>You've lost a row of breasts!</b>");
				//getGame().dynStats("sen", -5);
				pc.removeBreastRow(pc.breastRows.length - 1, 1);
			}
			//Antennae
			if (changes < changeLimit && !pc.hasAntennae(GLOBAL.TYPE_BEE) && !pc.hasHorns() && rand(3) == 0) {
				output("\n\nYour head itches momentarily as two floppy antennae sprout from your [pc.hair].");
				pc.antennae = 2;
				pc.antennaeType = GLOBAL.TYPE_BEE;
				changes++;
			}
			//Horns
			if (changes < changeLimit && pc.hasHorns() && rand(3) == 0) {
				output("\n\nYour [pc.horns] crumble, falling apart in large chunks until they flake away to nothing.");
				pc.removeHorns();
				changes++;
			}

			// Zil copypaste.
			if(pc.eyeTypeUnlocked(GLOBAL.TYPE_BEE) && pc.eyeType != GLOBAL.TYPE_BEE && changes < changeLimit && rand(2) == 0) {
				// Colors: usually black, rare for gold
				if(rand(5) != 0) pc.eyeColor = "black";
				else pc.eyeColor = "gold";
				kGAMECLASS.output("\n\nA sudden flash of amber fills your vision. You give a few experimental blinks, but all you can see is pure yellow. It doesn't last very long as the color gradually dissolves away in a brilliant honey-combed pattern until your vision fully returns and your eyes refocus, leaving you wondering what just happened. You flip on your Codex to see what changed. <b>You now have " + pc.eyeColor + "-colored bee eyes!</b>");
				pc.eyeType = GLOBAL.TYPE_BEE;
				changes++;
			}
			else if (!pc.eyeTypeUnlocked(GLOBAL.TYPE_BEE))
			{
				kGAMECLASS.output("\n\n" + pc.eyeTypeLockedMessage());
			}
			//Tongue
			if(pc.tongueTypeUnlocked(GLOBAL.TYPE_BEE) && pc.tongueType != GLOBAL.TYPE_BEE && changes < changeLimit && rand(4) == 0) {
				kGAMECLASS.output("\n\nYou feel strange pulses eminating from your [pc.tongue]. The muscle gradually pokes past your [pc.lips] and slides out your mouth, inch after inch, until you can estimate it to be about a foot long by the time it stops and looking fully changed. The tongue itself is bright yellow in color and the tip seems to be a hollow tube, like a straw to suck in fluids with. As you try your best to reel in your new tongue, you are hit by a sudden craving for nectar... <b>You now have a bee tongue!</b>");
				pc.tongueType = GLOBAL.TYPE_BEE;
				pc.clearTongueFlags();
				pc.addTongueFlag(GLOBAL.FLAG_LONG);
				pc.addTongueFlag(GLOBAL.FLAG_HOLLOW);
				changes++;
			}
			//Black gold
			else if (!pc.tongueTypeUnlocked(GLOBAL.TYPE_BEE))
			{
				kGAMECLASS.output("\n\n" + pc.tongueTypeLockedMessage());
			}
			
			//Bee Arms
			if (changes < changeLimit && pc.armType != GLOBAL.TYPE_BEE && rand(4) == 0) {
				output("\n\nYour legs tremble with sudden unbearable pain, as if they're being ripped apart from the inside out and being stitched together again all at once.  You scream in agony as you hear bones snapping and cracking.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining black chitin from the thigh down, and downy yellow fuzz along your upper thighs.");
				pc.armType = GLOBAL.TYPE_BEE;
				pc.clearArmFlags();
				pc.addArmFlag(GLOBAL.FLAG_CHITINOUS);
				changes++;
			}
			//Bee Legs
			if (changes < changeLimit && pc.legType != GLOBAL.TYPE_BEE && rand(4) == 0) {
				output("\n\nYour legs tremble with sudden unbearable pain, as if they're being ripped apart from the inside out and being stitched together again all at once.  You scream in agony as you hear bones snapping and cracking.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining black chitin from the thigh down, and downy yellow fuzz along your upper thighs.");
				pc.clearLegFlags();
				pc.addLegFlag(GLOBAL.FLAG_PLANTIGRADE);
				pc.addLegFlag(GLOBAL.FLAG_SMOOTH);
				pc.addLegFlag(GLOBAL.FLAG_CHITINOUS);
				pc.legType = GLOBAL.TYPE_BEE;
				pc.legCount = 2;
				pc.genitalSpot = 0;
				changes++;
			}
			//-Nipples reduction to 1 per tit.
			if (pc.nipplesPerBreast > 1 && changes < changeLimit && rand(4) == 0) {
				output("\n\nA chill runs over your [pc.fullChest] and vanishes.  You stick a hand under your [pc.gear] and discover that your extra nipples are missing!  You're down to just one per ");
				if (pc.biggestTitSize() < 1) output("'breast'.");
				else output("breast.");
				pc.nipplesPerBreast = 1;
				changes++;
			}
			//Gain oviposition!
			//if (changes < changeLimit && pc.findPerk(PerkLib.BeeOvipositor) < 0 && pc.tailType == CoC.TAIL_TYPE_BEE_ABDOMEN && rand(2) == 0) {
				//output("\n\nAn odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous bee part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the stinger.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, black, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new bee ovipositor will feel like...");
				//output("\n\n(<b>Perk Gained:  Bee Ovipositor - Allows you to lay eggs in your foes!</b>)");
				//pc.createPerk(PerkLib.BeeOvipositor, 0, 0, 0, 0);
				//changes++;
			//}
			//Bee butt - 66% lower chance if already has a tail
			if (changes < changeLimit && !pc.hasTail(GLOBAL.TYPE_BEE) && (!pc.hasTail() || rand(3) == 0) && rand(4) == 0) {
				if (pc.hasTail()) output("\n\nPainful swelling just above your [pc.ass] doubles you over, and you hear the sound of your tail dropping off onto the ground!  Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a rounded bee-like abdomen grows in place of your old tail.  It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.");
				else output("\n\nPainful swelling just above your [pc.ass] doubles you over.  It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and rounding with a series of pops until you have a bulbous abdomen hanging just above your butt.  The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide.  You sigh as your stinger slides into place with a 'snick', finishing the transformation.  <b>You have a bee's abdomen.</b>");
				pc.clearTailFlags();
				pc.addTailFlag(GLOBAL.FLAG_SMOOTH);
				pc.addTailFlag(GLOBAL.FLAG_STINGER_TIPPED);
				pc.addTailFlag(GLOBAL.FLAG_CHITINOUS);
				pc.tailType = GLOBAL.TYPE_BEE;
				pc.tailCount = 1;
				changes++;
			}
			//Venom Increase
			if (changes < changeLimit && pc.hasTail(GLOBAL.TYPE_BEE) && pc.tailRecharge < 15 && rand(2)) {
				if (pc.tailRecharge < 5) pc.tailRecharge += 1;
				if (pc.tailRecharge < 10) pc.tailRecharge += 1;
				if (pc.tailRecharge < 15) pc.tailRecharge += 1;
				pc.tailVenom += 50;
				if (pc.tailVenom > 100) pc.tailVenom = 100;
				output("\n\nYour abdomen swells with vitality and a drop of venom escapes your stinger as it begins producing it in slightly larger quantities.");
				changes++;
			}
			//Wings
			//Grow bigger bee wings!
			if (changes < changeLimit && pc.hasWings(GLOBAL.TYPE_SMALLBEE) && rand(4)) {
				changes++;
				pc.shiftWings(GLOBAL.TYPE_BEE, 2);
				output("\n\nYour wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly!  <b>You now have large bee wings!</b>  You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.");
			}
			//Grow new bee wings if player has none.
			if (changes < changeLimit && !pc.hasWings() && rand(4)) {
				changes++;
				if (pc.wingType == GLOBAL.TYPE_SHARK) output("\n\nYou feel an itching on your large back-fin as something begins growing there.  You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably.  A sense of relief erupts from you as you feel something new grow out from your fin.  You hastily remove the top portion of your [pc.gear] and marvel as a pair of small bee-like wings sprout from your back, replacing the fin that once grew there.  Tenderly flexing your new muscles, you find you can flap them quite fast.  Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall.  A few quick modifications to your [pc.gear] later and you are ready to continue your journey with <b>your new bee wings</b>.");
				else output("\n\nYou feel an itching between your shoulder-blades as something begins growing there.  You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably.  A sense of relief erupts from you as you feel something new grow out from your body.  You hastily remove the top portion of your [pc.gear] and marvel as a pair of small bee-like wings sprout from your back.  Tenderly flexing your new muscles, you find you can flap them quite fast.  Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall.  A few quick modifications to your [pc.gear] later and you are ready to continue your journey with <b>your new bee wings</b>.");
				pc.shiftWings(GLOBAL.TYPE_SMALLBEE, 2);
			}
			//Melt demon wings!
			if (changes < changeLimit && (pc.hasWings(GLOBAL.TYPE_DEMONIC) || pc.hasWings(GLOBAL.TYPE_SMALLDEMONIC))) {
				changes++;
				output("\n\nYour demonic wings ripple, jelly-like.  Worried, you crane back to look, and to your horror, they're melting away!  Runnels of amber honey trail down the wings' edges, building into a steady flow.  <b>In a moment, the only remnant of your wings is a puddle of honey in the dirt</b>.  Even that is gone in seconds, wicked into the dry soil.");
				pc.removeWings();
			}
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			if (special) { //All the speical honey effects occur after any normal bee transformations (if the player wasn't a full bee morph)
				//Cock growth multiplier.
				var mult:int = 1.0;
				if (pc.cocks[0].volume() >= 140) mult -= 0.2;
				if (pc.cocks[0].volume() >= 180) mult -= 0.2;
				if (pc.cocks[0].volume() >= 220) mult -= 0.2;
				if (pc.cocks[0].volume() >= 260) mult -= 0.2;
				if (pc.cocks[0].volume() >= 300) mult -= 0.1;
				if (pc.cocks[0].volume() >= 400) mult -= 0.1; //Cock stops growing at that point.
				//Begin TF
				if (!pc.hasCock()) {
					pc.createCock(rand(3) + 8);
					output("\n\nYou double over in pain as the effects start to concentrate into your groin.  You need to get release, but what you’ve got just isn’t cutting it.  You fall to the ground and grab at your crotch, trying desperately to get the release you need.  Finally, it happens.  With a sudden burst of intense relief and sexual satisfaction, a new human looking penis bursts from your skin and sprays your seed all over the ground in front of you.  When you’re able to recover and take a look at your new possession.  <b>You now have an " + num2Text(pc.cocks[0].cLength()) + " inch long human cock that is very sensitive to stimulation.</b>");
					pc.orgasm();
					//getGame().dynStats("sen", 10);
				}
				else if (pc.cocks.length > 1) {
					var biggest:int = pc.biggestCockIndex();
					if (biggest == 0) biggest = pc.biggestCockIndex2();
					output("\n\nThe effects of the honey move towards your groin, and into your [pc.eachCock], causing them to stand at attention.  They quiver for a moment, and feel rather itchy.  Suddenly you are overwhelmed with pleasure as <b>your [pc.cock " + biggest + "] is merged with your [pc.cock]!</b>  You grab onto the merging cock and pump it with your hands as it increases in size and you cum in pleasure.  Your [pc.cock] seems a lot more sensitive now...");
					pc.cocks[0].cLength(pc.cocks[biggest].cLength() * (pc.cocks[biggest].thickness() / pc.cocks[0].thickness()));
					pc.removeCock(biggest, 1);
					pc.orgasm();
					//getGame().dynStats("sen", 5);
				}
				else if (pc.cocks[0].volume() < 100) {
					output("\n\nYour [pc.cock] suddenly becomes rock hard and incredibly sensitive to the touch.  You pull away your [pc.gear], and start to masturbate furiously as it rapidly swells in size.  When the change finally finishes, you realize that your [pc.cock] has both grown much longer and wider!  <b>");
					if (pc.cocks[0].volume() <= 20)
						output("It now swings as low as your knees!");
					else if (pc.cocks[0].volume() <= 50)
						output("While erect, your massive member fills the lower half of your vision.");
					else output("Your member is now simply huge, you wonder what in the world could actually take your massive size now?");
					output("</b>");
					pc.cocks[0].cLength((rand(3) + 4) * mult); //4 to 6 inches in length
					//getGame().dynStats("sen", 5);
				}
				else if (pc.cocks[0].cockType != GLOBAL.TYPE_BEE && pc.zilScore() >= 6) {
					output("\n\nYour huge member suddenly starts to hurt, especially the tip of the thing.  At the same time, you feel your length start to get incredibly sensitive and the base of your shaft starts to itch.  You tear off your [pc.gear] and watch in fascination as your [pc.cock] starts to change.  The shaft turns black, while becoming hard and smooth to the touch, while the base develops a mane of four inch long yellow bee hair.  As the transformation continues, your member grows even larger than before.  However, it is the tip that keeps your attention the most, as a much finer layer of short yellow hairs grow around it.  Its appearance isn’t the thing that you care about right now, it is the pain that is filling it.\n\n");
					output("It is entirely different from the usual feeling you get when you’re cock grows larger from imbibing transformative substances.  When the changes stop, the tip is shaped like a typical human mushroom cap covered in fine bee hair, but it feels nothing like what you’d expect a human dick to feel like.  Your whole length is incredibly sensitive, and touching it gives you incredible stimulation, but you’re sure that no matter how much you rub it, you aren’t going to cum by yourself.  You want cool honey covering it, you want tight walls surrounding it, you want to fertilize hundreds of eggs with it.  These desires are almost overwhelming, and it takes a lot of will not to just run off in search of the bee girl that gave you that special honey right now.  This isn’t good.\n\n");
					output("<b>You now have a bee cock!</b>");
					pc.shiftCock(0, GLOBAL.TYPE_BEE);
					pc.cocks[0].cLength(5 * mult);
					//getGame().dynStats("sen", 15);
				}
				else {
					if (mult > 0) {
						output("\n\nThe effects of the honey don’t seem to focus on your groin this time, but you still feel your [pc.cock] grow slightly under your [pc.gear].");
						pc.cocks[0].cLength((0.1 * rand(10) + 1) * mult);
					}
					else {
						output("\n\nThe effects of the honey don’t seem to focus on your groin this time and you have a feeling that your [pc.cock] hasn't grown at all! Perhaps you've reached the upper limit of cock growth from special honey?");
					}
					//getGame().dynStats("sen", 3);
				}
				if (pc.cor() >= 5) {
					output("\n\nYour mind feels surprisingly clear of the twisted thoughts that have plagued it as of late, but you find yourself feeling more and more aroused than usual.");
					var corLoss:int = Math.min(0.1 * pc.cor() + 5, pc.cor());
					pc.cor( -corLoss);
					pc.slowStatGain("l", corLoss);
					//getGame().dynStats("cor", -corLoss, "lib", corLoss); //Lose corruption and gains that much libido
				}
				else {
					output("\n\nYou find your mind is drifting to the thought of using your member to fertilize hundreds and hundreds of eggs every day.  You shake your head, the bizarre fantasy catching you completely off guard.");
					pc.cor(0, true);
					pc.slowStatGain("l", 5);
					//getGame().dynStats("cor=", 0, "lib", 5);
				}
				if (pc.femininity >= 60 || pc.femininity <= 40) {
					output("\n\nYour face shifts in shape, becoming more androgynous.");
					if (pc.femininity >= 60)
						pc.femininity -= 3;
					else pc.femininity += 3;
				}
				//getGame().dynStats("lust", 0.2 * pc.lib + 5);
				pc.lust(pc.libido() / 5 + 5);
			}
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}
}