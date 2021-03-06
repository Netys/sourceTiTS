package classes.Items.Transformatives
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCSucMilk extends ItemSlotClass
	{
		public function CoCSucMilk(dataObject:Object=null)
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "SucMilk";
			//Regular name
			this.longName = "Succubi milk";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle of Succubi milk";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This milk-bottle is filled to the brim with a creamy white milk of dubious origin.  A pink label proudly labels it as \"<i>Succubi Milk</i>\".  In small text at the bottom of the label it reads: \"<i>To bring out the succubus in YOU!</i>\"";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			
			//Information
			this.basePrice = 60;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			return useIt(target, usingCreature, true);
		}
		
		public static function useIt(target:Creature, usingCreature:Creature = null, tainted:Boolean = true):Boolean
		{
			kGAMECLASS.clearOutput();
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			var changes:Number = 0;
			var rando:Number = Math.random() * 100;
			if (target.hasPerk("History: Alchemist")) rando += 10;
			if (target.hasPerk("Transformation Resistance")) rando -= 10;
			if (rando >= 90 && !tainted) rando -= 10;
			if (target.cor() < 35) output("You wonder why in the gods' names you would drink such a thing, but you have to admit, it is the best thing you have ever tasted.");
			if (target.cor() >= 35 && target.cor() < 70) {
				output("You savor the incredible flavor as you greedily gulp it down.");
				if (target.hasVagina()) {
					output("  The taste alone makes your [pc.vagina] feel ");
					if (target.vaginas[0].wetness() == 0) output("tingly.");
					if (target.vaginas[0].wetness() == 1) output("wet.");
					if (target.vaginas[0].wetness() == 2) output("sloppy and wet.");
					if (target.vaginas[0].wetness() == 3) output("sopping and juicy.");
					if (target.vaginas[0].wetness() >= 4) output("dripping wet.");
				}
				else if (target.hasCock()) output("  You feel a building arousal, but it doesn't affect your cock.");
			}
			if (target.cor() >= 70) {
				output("You pour the milk down your throat, chugging the stuff as fast as you can.  You want more.");
				if (target.hasVagina()) {
					output("  Your [pc.vagina]");
					if (target.vaginas.length > 1) output(" quiver in orgasm, ");
					if (target.vaginas.length == 1) output(" quivers in orgasm, ");
					if (target.vaginas[0].wetness() == 0) output("becoming slightly sticky.");
					if (target.vaginas[0].wetness() == 1) output("leaving your undergarments sticky.");
					if (target.vaginas[0].wetness() == 2) output("wet with girlcum.");
					if (target.vaginas[0].wetness() == 3) output("staining your undergarments with cum.");
					if (target.vaginas[0].wetness() == 4) output("leaving cunt-juice trickling down your leg.");
					if (target.vaginas[0].wetness() >= 5) output("spraying your undergarments liberally with slick girl-cum.");
					target.orgasm();
				}
				else if (target.hasGenitals()) {
					if (target.cocks.length == 1) output("  You feel a strange sexual pleasure, but your [pc.multiCockDescript] remains unaffected.");
					else output("  You feel a strange sexual pleasure, but your [pc.multiCockDescript] remain unaffected.");
				}
			}
			if (tainted) target.cor(1);
			target.lust(3);
			
			// Shrink cocks if you have them.
			if (target.cocks.length > 0) {
				output("\n\nYou feel a tingling along " + target.eachCock() + " and a slight withdrawal back into your " + target.skinFurScales() + ". Looking down, you realize ");
				if(target.smallestCockLength() >= 4) output("" + target.eachCock() + " has reduced in size by an inch!");
				else output("your " + target.cockDescript(target.smallestCockIndex()) + " has disappeared!");
				output("<b>");
				if(target.smallestCockLength() >= 4) 
				{
					output(" [pc.EachCock] has shrunk.");
					for(x = 0; x < target.cockTotal(); x++)
					{
						target.cocks[x].cLengthRaw--;
						if(target.hasPerk("Mini"))
						{
							if(target.cocks[x].cLengthRaw > 4) target.cocks[x].cLengthRaw--;
							else target.cocks[x].cLengthRaw = 3;
						}
					}
				}
				else 
				{
					output(" You no longer have a [pc.cock " + target.smallestCockIndex() + "]!");
					target.removeCock(target.smallestCockIndex(), 1);
					// If no more dicks, then remove balls!
					if(!target.hasCock() && target.balls > 0)
					{
						output("</b>");
						output("\n\nIn addition, the disappearance of your only manhood also seems to affect your [pc.sack]... With rhythmic pulses, the size of your package gradually diminishes until it vanishes completely!");
						output("<b>");
						if(target.balls == 1) output(" Your single [pc.ballNoun] has disappeared");
						else output(" You no longer have [pc.ballsNoun]");
						target.balls = 0;
						target.ballSizeRaw = 0;
					}

				}
				output("</b>")
				changes++;
			}
			
			//Breast growth
			if (rando <= 75) {
				//Temp stores the level of growth...
				temp = 1 + rand(3);
				if (target.breastRows.length > 0) {
					if (target.breastRows[0].breastRatingRaw < 2 && rand(3) == 0) temp++;
					if (target.breastRows[0].breastRatingRaw < 5 && rand(4) == 0) temp++;
					if (target.breastRows[0].breastRatingRaw < 6 && rand(5) == 0) temp++;
				}
				output("\n\n");
					
				if (target.breastRows.length == 0) { // SkySap copy/paste
					output("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					target.createBreastRow();
					target.breastRows[0].breasts = 2;
					target.breastRows[0].breastRatingRaw = 2;
					target.nipplesPerBreast = 1;
					output("\n", false);
				} else {
					target.breastRows[0].breastRatingRaw += 1 + rand(2);
					//Expanding a Current Rack (up to D cups)
					if(target.breastRows[0].breastRating() < 7)
					{
						output("\n\nYou feel a sudden tightness in your chest, just behind your tits. You grit your teeth through a flash moment of pain before it turns to pleasure. With a sigh of relief, you cup your expanding boobs");
						if(!target.isChestExposed()) output(" until it strains against your [pc.upperGarment], demanding release from the now-too-tight confines");
						output(". You now have a nice, firm pair of [pc.breastCupSize]s!");
						target.lust(9+rand(5));
					}
					//Expanding a Current Rack (Over D cups)
					else
					{
						output("\n\nA sudden tightness clenches behind your buxom breasts, making you wince in pain before it turns into a delightful pleasure. You sigh");
						if(!target.isChestExposed()) output(", shrugging out of your [pc.upperGarments]");
						output(" as your tits swell in size, urged to even greater size by the hormone and nanomachine combination. You can't stop yourself from cupping one and playing with it as it grows, pinching your [pc.nipple] as it grows even more sensitive. It takes every bit of willpower you have not to start masturbating on the spot, to find some release for the sexual tension coursing through your veins as the medicine does its work.");
						output("\n\nFinally, the growth in your - now very sizable - tits subsides, leaving them bouncing with your every breath, nice and huge.");
						if(!target.hasUpperGarment()) output(" You're probably going to want to invest in a bra, now... <i>or not</i> you think, giving yourself another squeeze.");
						output(" You now have a hefty pair of [pc.breastCupSize]s!");
						target.lust(9+rand(5));
					}
				}
			}
			if (!target.hasVagina() && (rand(3) == 0 || (rando > 75 && rando < 90))) {
				newVag(target);
			}
			//Increase pussy wetness or grow one!!
			else if (rando > 75 && rando < 90) {
				if (target.vaginas.length > 0) {
					output("\n\n", false);
					var x:int = 0; // TODO: dryest vag
					//0 = dry, 1 = wet, 2 = extra wet, 3 = always slick, 4 = drools constantly, 5 = female ejaculator
					if (target.vaginas[x].wetness() == 5) {
						if (target.vaginas.length == 1) output("Your [pc.vaginas] gushes fluids down your leg as you spontaneously orgasm.");
						else output("Your [pc.vaginas] gush fluids down your legs as you spontaneously orgasm, leaving a thick puddle of pussy-juice on the ground.  It is rapidly absorbed by the earth.");
						target.orgasm();
						//if (tainted) dynStats("cor", 1);
						if (tainted) target.cor(1);
					}
					if (target.vaginas[0].wetness() == 4) {
						if (target.vaginas.length == 1) output("Your pussy feels hot and juicy, aroused and tender.  You cannot resist as your hands dive into your [pc.vaginas].  You quickly orgasm, squirting fluids everywhere.  <b>You are now a squirter</b>.");
						if (target.vaginas.length > 1) output("Your pussies feel hot and juicy, aroused and tender.  You cannot resist plunging your hands inside your [pc.vaginas].  You quiver around your fingers, squirting copious fluids over yourself and the ground.  The fluids quickly disappear into the dirt.");
						target.orgasm();
						//if (tainted) dynStats("cor", 1);
						if (tainted) target.cor(1);
					}
					if (target.vaginas[0].wetness() == 3) {
						if (target.vaginas.length == 1) output("You feel a sudden trickle of fluid down your leg.  You smell it and realize it's your pussy-juice.  Your [pc.vaginas] now drools lubricant constantly down your leg.");
						if (target.vaginas.length > 1) output("You feel sudden trickles of fluids down your leg.  You smell the stuff and realize it's your pussies-juices.  They seem to drool lubricant constantly down your legs.");
					}
					if (target.vaginas[0].wetness() == 2) {
						output("You flush in sexual arousal as you realize how moist your cunt-lips have become.  Once you've calmed down a bit you realize they're still slick and ready to fuck, and always will be.");
					}
					if (target.vaginas[0].wetness() == 1) {
						if (target.vaginas.length == 1) output("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your [pc.vaginas] felt much wetter than normal.");
						else output("A feeling of intense arousal passes through you, causing you to masturbate furiously.  You realize afterwards that your [pc.vaginas] were much wetter than normal.");
					}
					if (target.vaginas[0].wetness() == 0) {
						output("You feel a tingling in your crotch, but cannot identify it.");
					}
					temp = target.vaginas.length;
					while (temp > 0) {
						temp--;
						if (target.vaginas[0].wetness() < 5) target.vaginas[temp].wetness(1);
					}
				}
			}
			if (rando >= 90) {
				if (target.skinTone == "blue" || target.skinTone == "purple" || target.skinTone == "indigo" || target.skinTone == "shiny black") {
					if (target.hasVagina()) {
						output("\n\nYour heart begins beating harder and harder as heat floods to your groin.  You feel your clit peeking out from under its hood, growing larger and longer as it takes in more and more blood.");
						if (target.clitLength > 3 && !target.hasPerk("Big Clit")) output("  After some time it shrinks, returning to its normal aroused size.  You guess it can't get any bigger.");
						if (target.clitLength > 5 && target.hasPerk("Big Clit")) output("  Eventually it shrinks back down to its normal (but still HUGE) size.  You guess it can't get any bigger.");
						if ((target.hasPerk("Big Clit") && target.clitLength < 6)
								|| target.clitLength < 3) {
							temp += 2;
							target.clitLength += (rand(4) + 2) / 10;
						}
						//dynStats("sen", 3, "lus", 8);
						target.lust(8);
					}
					else {
						newVag(target);
					}
				}
				else {
					temp = rand(10);
					if (temp == 0) target.skinTone = "shiny black";
					if (temp == 1 || temp == 2) target.skinTone = "indigo";
					if (temp == 3 || temp == 4 || temp == 5) target.skinTone = "purple";
					if (temp > 5) target.skinTone = "blue";
					output("\n\nA tingling sensation runs across your skin in waves, growing stronger as <b>your skin's tone slowly shifts, darkening to become [pc.skinColor] in color.</b>", false);
					if (tainted) target.cor(1);
				}
			}
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + target.cor() / 3 > 35 && tainted) demonChanges(target);
			if (tainted) {
				if(target.femininity < 100) output(target.modFem(2));
				if (rand(3) == 0 && target.tone > 15) output(target.modTone(-2));
			}
			else {
				if(target.femininity < 100) output(target.modFem(1));
				if (rand(3) == 0 && target.tone > 20) output(target.modTone(-2));
			}
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
        }
		
		public static function demonChanges(player:Creature):void
		{
			var target:Creature = player;
			
			//Change tail if already horned.
			if (player.tailType != GLOBAL.TYPE_DEMONIC && player.hasHorns(GLOBAL.TYPE_DEMONIC)) {
				if (player.hasTail()) {
					output("\n\n");
					if (player.tailType == GLOBAL.TYPE_ARACHNID || player.tailType == GLOBAL.TYPE_BEE) output("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip.  ");
					else output("You feel a tingling in your tail.  You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip.  ");
					output("<b>Your tail is now demonic in appearance.</b>");
				}
				else output("\n\nA pain builds in your backside... growing more and more pronounced.  The pressure suddenly disappears with a loud ripping and tearing noise.  <b>You realize you now have a demon tail</b>... complete with a cute little spade.");
				player.cor(4);				
				player.clearTailFlags();
				player.tailType = GLOBAL.TYPE_DEMONIC;
				player.addTailFlag(GLOBAL.FLAG_LONG);
				player.addTailFlag(GLOBAL.FLAG_PREHENSILE);
				player.addTailFlag(GLOBAL.FLAG_SMOOTH);
				//flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			
			//grow horns!
			if (!player.hasHorns() || (rand(player.horns + 3) == 0)) {
				if (player.horns < 12 && (!player.hasHorns() || player.hornType == GLOBAL.TYPE_DEMONIC)) {
					output("\n\n");
					if (!player.hasHorns()) {
						output("A small pair of demon horns erupts from your forehead.  They actually look kind of cute.  <b>You have horns!</b>");
						player.hornType = GLOBAL.TYPE_DEMONIC;
						player.hornLength = 1;
					}
					else output("Another pair of demon horns, larger than the last, forms behind the first row.");
					player.hornLength += 1;
					player.horns += 2;
					player.cor(3);
				}
				//Text for shifting horns
				else if (player.hasHorns() && !player.hasHorns(GLOBAL.TYPE_DEMONIC)) {
					output("\n\n");
					output("Your horns shift, shrinking into two small demonic-looking horns.");
					player.horns = 2;
					player.hornType = GLOBAL.TYPE_DEMONIC;
					player.hornLength = 2;
					player.cor(3);
				}
				//flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			
			//Nipples Turn Back:
			if (player.nippleColor != "dark purple" && rand(3) == 0) {
				output("\n\nSomething invisible brushes against your [pc.nippleColor], making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned dark purple.");
				player.nippleColor = "dark purple";
				//flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			
			//remove fur
			if ((player.faceType != GLOBAL.TYPE_HUMAN || player.skinType != GLOBAL.SKIN_TYPE_SKIN) && rand(3) == 0) {
				//Remove face before fur!
				if (player.faceType != GLOBAL.TYPE_HUMAN) {
					output("\n\nYour visage twists painfully, returning to a more normal human shape, albeit with flawless skin.  <b>Your face is human again!</b>");
					player.clearFaceFlags();
					player.addFaceFlag(GLOBAL.FLAG_SMOOTH);
					player.faceType = GLOBAL.TYPE_HUMAN;
				}
				//De-fur
				else if (player.skinType != GLOBAL.SKIN_TYPE_SKIN) {
					output("\n\nYour " + player.skinFurScales(false, true));
					if (player.skinType == GLOBAL.SKIN_TYPE_FUR) output(" suddenly feels itchy as your fur begins falling out in clumps, <b>revealing inhumanly smooth skin</b> underneath.");
					else if (player.skinType == GLOBAL.SKIN_TYPE_SCALES) output(" begin to itch as they begin falling out in droves, <b>revealing your inhumanly smooth [pc.skinTone] skin</b> underneath.");
					else output(" suddenly feels itchy... It changes to <b>inhumanly smooth [pc.skinTone] skin</b>.");
					player.skinType = GLOBAL.SKIN_TYPE_SKIN;
					player.clearSkinFlags();
					player.addSkinFlag(GLOBAL.FLAG_SMOOTH);
					player.skinAccent = "";
				}
				//flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			
			var demonSkinColor:Array = ["red", "purple", "indigo", "dark blue"];
			
			if (target.skinType == GLOBAL.SKIN_TYPE_SKIN && !InCollection(target.skinTone, demonSkinColor) && rand(3) == 0 && player.cor() >= 66)
			{
				var newSkinColor:String = RandomInCollection(demonSkinColor);
				
				if(target.skinToneUnlocked(newSkinColor))
				{
					output("You feel uncomfortably hot. Blood rises to your skin and you watch as it changes color to match how you feel. After a couple of minutes the sensation fades; your new pigmentation does not. You are now a sultry " + newSkinColor + " color.");
					
					target.skinTone = newSkinColor;
				}
				else output(target.skinToneLockedMessage());
			}
			
			var demonEyeColor:Array = ["crimson", "ruby", "gold", "platinum", "pearl", "glowing amber", "glowing red", "glowing white", "luminous yellow"];
			if (target.eyeType != GLOBAL.TYPE_DEMONIC && rand(3) == 0 && player.cor() >= 33)
			{
				var newEyeColor:String = RandomInCollection(demonEyeColor);
				
				if(target.eyeTypeUnlocked(GLOBAL.TYPE_DEMONIC))
				{
					output("The world wavers in front of you as your eyes seem to quiver, tightening and loosening in strange, intricate ways. You blink a few times once the transformation has finished, getting used to it. Your sight is much the same, except – you frown, turning this way and that, looking at sources of heat and light. You fancy your range of vision has extended slightly, allowing you to make out the ghost of infrared and ultraviolet now. You bet these guys will be great in the dark. You smile, creasing up your eyes with their black sclera, " + newEyeColor + " irises and inhuman, lizard pupils, pleased.");
					
					target.eyeType = GLOBAL.TYPE_DEMONIC;
					target.eyeColor = newEyeColor;
				}
				else output(target.eyeTypeLockedMessage());
			}
			
			//Demon tongue
			if (player.tongueType != GLOBAL.TYPE_DEMONIC && rand(3) == 0) {
				output("\n\nYour [pc.tongue] tingles.  It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out.  You find it easy to move and control, as natural as walking.  <b>You now have a long demon-tongue.</b>");
				player.tongueType = GLOBAL.TYPE_DEMONIC;
				player.clearTongueFlags();
				player.addTongueFlag(GLOBAL.FLAG_LONG);
				player.addTongueFlag(GLOBAL.FLAG_PREHENSILE);
				//flags[kFLAGS.TIMES_TRANSFORMED]++;
			}
			
			//foot changes - requires furless
			if (player.skinType == GLOBAL.SKIN_TYPE_SKIN && rand(4) == 0 && player.legCount > 1 && player.cor() >= 66) {
				if (player.legType != GLOBAL.TYPE_DEMONIC && player.isMasculine()) {
					output("\n\n");
					output("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [pc.feet]. Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>");
					player.legType = GLOBAL.TYPE_DEMONIC;
					player.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
					player.legCount = 2;
					player.genitalSpot = 0;
				}
				//Females/futa get high heels
				else if (player.legType != GLOBAL.TYPE_SUCCUBUS && player.isFeminine()) {
					output("\n\n");
					output("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your " + player.feet() + ". Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horn protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.");
					player.legType = GLOBAL.TYPE_SUCCUBUS;
					player.legFlags = [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_HEELS];
					player.legCount = 2;
					player.genitalSpot = 0;
				}
			}
			
			if (player.skinType == GLOBAL.SKIN_TYPE_SKIN && target.armType != GLOBAL.TYPE_DEMONIC && rand(4) == 0 && player.cor() >= 66) {
				if(target.armTypeUnlocked(GLOBAL.TYPE_DEMONIC))
				{
					output("A hot, prickly sensation picks at the tips of your fingers. You watch your fingernails lengthen, becoming four inch long talons.");
					if(target.mfn("m", "f", "n") == "m") output(" They thicken and curl slightly at the end. You swing your hands thoughtfully when they have finished growing, admiring your savage, thorn-like claws.");
					else output(" They remain straight and thin all the way down. Once they have finished growing you test one against a surface gingerly. Your new slut claws seem much firmer and stronger than fake nails: a sexy but vicious augmentation.");
					
					target.armType = GLOBAL.TYPE_DEMONIC;
					target.clearArmFlags();
					
					// Plated
					if(target.skinType != GLOBAL.SKIN_TYPE_CHITIN && rand(2) == 0)
					{
						output("\n\nThat’s not the end of your arms’ transformation, as the [pc.skinFurScalesNoun] on your forearms is covered by new sleek plates of jet-black chitin along the outside of each arm like a natural armguard. A few smaller pentagonal plates trail up your upper arms and over your shoulders. <b>You have armored arms!</b>");
						
						target.addArmFlag(GLOBAL.FLAG_CHITINOUS);
						target.addArmFlag(GLOBAL.FLAG_SMOOTH);
					}
					// Spiked:
					else
					{
						output("\n\nThat’s not the end for your arms transforming, as the [pc.skinFurScalesNoun] on your forearms parts around a set of short jet-black bone spikes that grow along the outside of each forearm and out of the back of your elbows, the latter fitting flush against your upper arms when your arm is held out straight. The spikes are too short and too awkwardly placed to fight with, but they certainly look imposing. <b>You have spiked arms!</b>");
						
						target.addArmFlag(GLOBAL.FLAG_SPIKED);
					}
				}
				else output(target.armTypeLockedMessage());
			}
			
			//Grow demon wings
			if (player.wingType != GLOBAL.TYPE_DEMONIC && rand(8) == 0 && player.cor() >= 50) {
				//grow smalls to large
				if (InCollection(player.wingType, GLOBAL.TYPE_SMALLDEMONIC) && player.cor() >= 75) {
					output("\n\n");
					output("Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body.  You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings.  <b>Your demonic wings have grown!</b>");
					player.shiftWings(GLOBAL.TYPE_DEMONIC, 2);
				}
				else if (InCollection(player.wingType, GLOBAL.TYPE_SHARK)) {
					output("\n\n");
					output("The muscles around your shoulders bunch up uncomfortably, changing to support the new bat-like wings growing from your back.  You twist your head as far as you can for a look and realize your fin has changed into ");
					output("small ");
					player.shiftWings(GLOBAL.TYPE_SMALLDEMONIC, 2);
					output("bat-like demon-wings!");
				}
				else if (player.hasWings() && !InCollection(player.wingType, GLOBAL.TYPE_SMALLDEMONIC)) {
					output("\n\n");
					output("The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight changing.  You twist your head as far as you can for a look and realize they've changed into ");
					if (InCollection(player.wingType, GLOBAL.TYPE_SMALLDRACONIC, GLOBAL.TYPE_SMALLBEE)) {
						output("small ");
						player.shiftWings(GLOBAL.TYPE_SMALLDEMONIC, 2);
					}
					else {
						output("large ");
						player.shiftWings(GLOBAL.TYPE_DEMONIC, 2);
					}
					output("<b>bat-like demon-wings!</b>");
				}
				//No wings
				else if (!player.hasWings()) {
					output("\n\n");
					output("A knot of pain forms in your shoulders as they tense up.  With a surprising force, a pair of small demonic wings sprout from your back");
					if(player.hasArmor()) output(", ripping a pair of holes in the back of your [pc.armor]");
					output(".  <b>You now have tiny demonic wings</b>.");
					player.shiftWings(GLOBAL.TYPE_SMALLDEMONIC, 2);
				//flags[kFLAGS.TIMES_TRANSFORMED]++;
				}
			}
		}
	
		public static function newVag(target:Creature):void {
			target.createVagina();
			target.clitLength = .25;
			target.shiftVagina(0, Mutator.guessVagType(target));
			output("\n\nAn itching starts in your crotch and spreads vertically. You reach down and discover an opening. You have grown a <b>new " + target.vaginaDescript(0) + "</b>!");
		}
	}
}