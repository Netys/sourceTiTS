package classes.Items.Transformatives
{
	import classes.CockClass;
	import classes.Creature;
	import classes.GameData.TooltipManager;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
    public class CoCEquinum extends ItemSlotClass
    {
        public function CoCEquinum(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "Equinum";
            //Regular name
            this.longName = "Equinum";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a vial of Equinum";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This is a long flared vial with a small label that reads, \"<i>Equinum</i>\".  It is likely this potion is tied to horses in some way.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			clearOutput();
			if (kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] == undefined) kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] = 0;
			
			//Changes done
			var changes:Number = 0;
			//Change limit
			var changeLimit:Number = 1;
			//Temporary storage
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Store location of cock to be changed
			var old:Number = 0;
			//Chancee to raise limit
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Used for random chances
			//Set up output
			output("You down the potion, grimacing at the strong taste.");
			
			//CHANCE OF BAD END - 20% if face/tail/skin/cock are appropriate.
			//If hooved bad end doesn't appear till centaured
			if (!pc.hasPerk("Transformation Resistance") && pc.horseScore() >= 5) {
				//WARNINGS
				//Repeat warnings
				if (kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] > 0 && rand(2) == 0) {
					if (kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] == 1) output("<b>\n\nYou feel a creeping chill down your back as your entire body shivers, as if rejecting something foreign.  Maybe you ought to cut back on the horse potions.</b>");
					if (kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] >= 2) output("<b>\n\nYou wonder how many more of these you can drink before you become a horse...</b>");
					kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"]++;
				}
				//First warning
				if (kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] == 0) {
					output("<b>\n\nWhile you drink the tasty potion, you realize how horse-like you already are, and wonder what else the potion could possibly change...</b>");
					kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] = 1;
				}
				//Bad End
				if (rand(4) == 0 && kGAMECLASS.flags["COC.BAD_END_WARNING_HORSE"] > 2) {
					//Must have been warned first...
					//If player has dicks check for horsedicks
					if (pc.cockTotal(GLOBAL.TYPE_EQUINE) > 0) {
						output("\n\nSoon after you drink the Equinum, a burning sensation fills your chest. You have consumed too much of the potion, and the overdose starts to provoke dramatic changes in your body.  You collapse suddenly, twitching in pain as all the bones and muscles in your body break and reform. Eventually, you pass out from the strain you are put through.\n\nYou wake up after a few minutes. Once you get up on your legs, doubt fills your mind. You rush to a nearby pond and look down, nearly jumping when the reflection of a ");
						if (!pc.hasGenitals() || pc.isHerm()) output("horse ");
						if (pc.hasCock()) output("stallion ");
						if (pc.hasVagina()) output("mare ");
						output(" with beautiful " + pc.hairColor + " [pc.skin] covering its body gazes back up at you.  That's you, and yet the doubt in your mind remains. Strange images fill your mind, and you feel as if you have not always been a horse, but some kind of funny fur-less creature standing on two legs. Your equine mind rapidly dismisses that doubt as a daydream however, and you trot away, oblivious to who you once were.\n\n");
						output("<b>One year later...</b>\n\nAs you graze upon the small plants that coat the open plains of your home, you hear a noise on your right side. As you raise your head to check where the noise comes from, preparing to run from a potential predator, you see a strange creature. It stands on its two feet, its furless pink skin appearing beneath its clothes.  With a start, you realize you can identify the strange creatures gender.  ");
						if (!pc.hasCock() && pc.hasVagina()) output("He is clearly a male, but you are somewhat confused as you can see not one but three bulges where his manhood would be.\n\n");
						if (pc.hasCock() && !pc.hasVagina()) output("She is clearly a female, as you can see her six breasts jiggle as she walks towards you, small stains appearing on her shirt where her nipples are.\n\n");
						if (!pc.hasGenitals() || pc.isHerm()) output("You are somewhat confused as you can see a bulge near her thighs but also huge boobs jiggling as she walks, and you can't say if she's a male or female.\n\n");
						output("As soon as you lay eyes on the creature, a wave of nostalgia overtakes you. Somehow, looking at that creature makes you sad, as if you forgot something important.\n\n\"<i>How strange to see a horse here all alone,</i>\" the creature muses, \"<i>In any case, you're still the least bizarre creature I've met here.  Not to mention the only one that hasn't tried to rape me,</i>\" it says with a sigh.\n\nYou answer with an interrogative whinny.\n\n\"<i>Hey, I've got an idea. I'll take you back to the camp. I'll feed you and in return you can help me complete my quest. What do you say?</i>\"\n\nInstinctively, you utter a happy and approving whinny.\n\nYou failed in your quest, losing your focus and more importantly, losing yourself.  But, even so, you found a new meaning to your life, and have a new chance to succeed where you once failed.");
					}
					//If player has no cocks
					else {
						output("\n\nSoon after you drink the Equinum, a burning sensation fills your chest. You have consumed too much of the drink, and the overdose starts to provoke dramatic changes in your body.  You collapse suddenly, twitching in pain as all the bones and all the muscles in your body break and reform. Eventually, you pass out from the strain you are put through.\n\nYou wake up after a few minutes. Once you get up on your legs, doubt fills your mind. You rush to a nearby pond and look down, nearly jumping when the reflection of a ");
						if (!pc.hasGenitals() || pc.isHerm()) output("horse ");
						if (pc.hasCock()) output("stallion ");
						if (pc.hasVagina()) output("mare ");
						output("with beautiful " + pc.hairColor + " [pc.skin] covering its body looks back at you.  That's you, and yet the doubt in your mind remains. Strange mental images fill your mind.  You feel as if you have not always been a horse, but some kind of funny fur-less creature standing on two legs. But your equine mind rapidly dismisses that doubt as a daydream, and you trot away, oblivious to who you once were.\n\n");
						output("<b>One year after...</b>\n\nAs you graze small plants in the open plains that became your home, you hear a noise on your right side. As you raise your head to check where the noise comes from, preparing to run from a potential predator, you see a strange creature. It stands on two feet, its furless pink skin appearing beneath its clothes.  ");
						if (!pc.hasCock() && pc.hasVagina()) output("He is clearly a male, but you are somewhat confused as you can see not one but three bulges where his manhood would be.\n\n");
						if (pc.hasCock() && !pc.hasVagina()) output("She is clearly a female, as you can see her six breasts jiggle as she walks towards you, small stains appearing on her shirt where her nipples are.\n\n");
						if (pc.isHerm()) output("You are somewhat confused as you can see a bulge near her thighs but also huge boobs jiggling as she walks, and you can't say if she's a male or female.\n\n");
						output("As soon as you lay eyes on the creature, a wave of nostalgia overtakes you. Somehow, looking at that creature makes you sad, as if you forgot something important.\n\n\"<i>How strange to see a horse here all alone,</i>\" the creature muses, \"<i>In any case, you're still the least bizarre creature I've met here.  Not to mention the only one that hasn't tried to rape me,</i>\" it says with a sigh.\n\nYou answer with an interrogative whinny.\n\n\"<i>Hey, I've got an idea. I'll take you back to the camp. I'll feed you and in return you can help me to complete my quest. What do you say?</i>\"\n\nInstictively, you utter a happy and approving whinny.\n\nYou failed in your quest, losing you focus and more importantly, losing yourself.  But, even so, you found a new meaning to your life, and have a new chance to achieve what you once failed.");
					}
					kGAMECLASS.badEnd();
					return false;
				}

			}
			//Stat changes first
			//STRENGTH
			if (rand(2) == 0) {
				//Maxxed
				if (pc.PQ() >= 60) {
					output("\n\nYou feel strong enough to single-handedly pull a fully-loaded wagon.");
				}
				//NOT MAXXED
				else {
					output("\n\nYour muscles clench and surge, making you feel as strong as a horse.");
					pc.physique(1);
					changes++;
				}
			}
			//TOUGHNESS
			//if (kGAMECLASS.rand(2) == 0) {
				////MAXXED ALREADY
				//if (pc.tou >= 75) {
					//kGAMECLASS.output("\n\nYour body is as tough and solid as a ", false);
					//if (pc.gender == 1 || pc.gender == 3) kGAMECLASS.output("stallion's.", false);
					//else kGAMECLASS.output("mare's.", false);
				//}
				////NOT MAXXED
				//else {
					//dynStats("tou", 1.25);
					//kGAMECLASS.output("\n\nYour body suddenly feels tougher and more resilient.", false);
					//changes++;
				//}
			//}
			//INTELLECT
			if (rand(3) == 0 && pc.intelligenceRaw >= 2) {
				if (pc.IQ() <= 5 || pc.intelligenceRaw <= 2)  {
					output("\n\nYou let out a throaty \"Neiiiigh\" as your animalistic instincts take over.");
				}
				if (pc.IQ() < 10 && pc.IQ() > 5) {
					pc.intelligence( -1);
					output("\n\nYou smile vacantly as you drink the potion, knowing you're just a big dumb animal who loves to fuck.");
					changes++;
				}
				if (pc.IQ() <= 20 && pc.IQ() >= 10) {
					pc.intelligence( -1);
					output("\n\nYou find yourself looking down at the empty bottle in your hand and realize you haven't thought ANYTHING since your first sip.");
					changes++;
				}
				if (pc.IQ() <= 30 && pc.IQ() > 20) {
					pc.intelligence( -1);
					output("\n\nYou smile broadly as your cares seem to melt away.  A small part of you worries that you're getting dumber.");
					changes++;
				}
				if (pc.IQ() <= 50 && pc.IQ() > 30) {
					pc.intelligence( -1.5);
					output("\n\nIt becomes harder to keep your mind focused as your intellect diminishes.");
					changes++;
				}
				if (pc.IQ() > 50) {
					pc.intelligence( -2);
					output("\n\nYour usually intelligent mind feels much more sluggish.");
					changes++;
				}
			}
			//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, canine pepps, demon items)
			if (changes < changeLimit && pc.armType == GLOBAL.TYPE_AVIAN && rand(4) == 0) {
				output("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving [pc.skinDesc] behind.");
				pc.clearArmFlags();
				pc.armType = GLOBAL.TYPE_HUMAN;
				changes++;
			}
			//-Remove chitin-arms (copy this for goblin ale, mino blood, equinum, canine pepps, demon items)
			if (changes < changeLimit && pc.hasArmFlag(GLOBAL.FLAG_CHITINOUS) && rand(4) == 0) {
				kGAMECLASS.output("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving [pc.skinDesc] behind.");
				pc.armType = GLOBAL.TYPE_HUMAN;
				pc.clearArmFlags();
				changes++;
			}
			//-Remove feathery hair (copy for equinum, canine peppers, Labova)
			if (changes < changeLimit && pc.hairType == GLOBAL.HAIR_TYPE_FEATHERS && rand(4) == 0) {
				//(long):
				if (pc.hairLength >= 6) output("\n\nA lock of your downy-soft feather-hair droops over your eye.  Before you can blow the offending down away, you realize the feather is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer feathery!</b>");
				//(short)
				else output("\n\nYou run your fingers through your downy-soft feather-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your feathers.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer feathery!</b>");
				changes++;
				pc.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			}
			//
			//SEXUAL CHARACTERISTICS
			//
			//MALENESS.
			if ((pc.hasCock()) && rand(3) != 0 && changes < changeLimit) {
				//If cocks that aren't horsified!
				if (pc.cockTotal() < pc.cockTotal(GLOBAL.TYPE_EQUINE)) {
					//Transform a cock and store it's index value to talk about it.
					//Single cock
					if (pc.cocks.length == 1) {
						temp = 0;
						//Use temp3 to track whether or not anything is changed.
						temp3 = 0;
						if (pc.cocks[0].cType == GLOBAL.TYPE_HUMAN) {
							output("\n\nYour " + pc.cockDescript(0) + " begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.");
						}
						else if (pc.hasSheath(0)) {
							output("\n\nYour [pc.cockNoun], begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your [pc.cockNoun], as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond it's traditional size.  You notice your knot vanishing, the extra flesh pushing more horsecock out from your sheath.");
						}
						else if (pc.hasCockFlag(GLOBAL.FLAG_LUBRICATED, 0)) {
							output("\n\nYour [pc.cockNoun], begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your [pc.cockNoun], as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.");
						}
						else {
							output("\n\nYour [pc.cockNoun], begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your [pc.cockNoun], as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.");
						}
						pc.shiftCock(0, GLOBAL.TYPE_EQUINE);
						temp2 = pc.increaseCock(rand(4) + 4, temp);
						output("  Your hands are drawn to the strange new [pc.cock], and you jerk yourself off, splattering thick ropes of cum with intense force.  <b>Your penis has transformed into a horse's!</b>");
						pc.orgasm();
						pc.lust(35);
						pc.libido(5);
					}
					//MULTICOCK
					else {
						for (temp = 0; temp < (pc.cockTotal()) && pc.cocks[temp].cType == GLOBAL.TYPE_EQUINE && !pc.cockTypeUnlocked(temp, GLOBAL.TYPE_EQUINE); temp++) {}
						output("\n\nOne of your penises begins to feel strange.  You pull down your clothes to take a look and see the skin of your " + pc.cockDescript(temp) + " darkening to a mottled brown and black pattern.");
						//Already have a sheath
						if (pc.hasSheath(temp)) output("  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.");
						else output("  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your " + pc.cockDescript(temp) + "'s root, tightening and pulling your " + pc.cockDescript(temp) + " inside its depths.");
						pc.shiftCock(temp, GLOBAL.TYPE_EQUINE);
						temp2 = pc.increaseCock(rand(4) + 4, temp);
						output("  The shaft suddenly explodes with movement, growing longer and developing a thick flared head leaking steady stream of animal-cum.");
						output("  <b>You now have a horse-cock.</b>");
					}
					
					pc.orgasm();
					pc.lust(35);
					pc.libido(5);
					changes++;
				}
				//Players cocks are all horse-type - increase size!
				else {
					//single cock
					if (pc.cocks.length == 1) {
						temp2 = pc.increaseCock(rand(3) + 1, 0);
						temp = 0;
						pc.lust(10);
					}
					//Multicock
					else {
						//Grow smallest cock!
						//temp2 changes to growth amount
						temp2 = pc.increaseCock(rand(4) + 1, pc.smallestCockIndex());
						pc.lust(10);
					}
					output("\n\n", false);
					if (temp2 > 2) output("Your " + pc.cockDescript(temp) + " tightens painfully, inches of taut horse-flesh pouring out from your sheath as it grows longer.  Thick animal-pre forms at the flared tip, drawn out from the pleasure of the change.");
					if (temp2 > 1 && temp2 <= 2) output("Aching pressure builds within your sheath, suddenly releasing as an inch or more of extra dick flesh spills out.  A dollop of pre beads on the head of your enlarged " + pc.cockDescript(temp) + " from the pleasure of the growth.");
					if (temp2 <= 1) output("A slight pressure builds and releases as your " + pc.cockDescript(temp) + " pushes a bit further out of your sheath.");
					changes++;
				}
				//Chance of thickness + daydream
				if (rand(2) == 0 && changes < changeLimit && pc.hasCock(GLOBAL.TYPE_EQUINE)) {
					temp = pc.thinnestCockRatioIndex();
					pc.cocks[temp].cThicknessRatio(.1);
					output("\n\nYour " + pc.cockDescript(temp) + " thickens inside its sheath, growing larger and fatter as your veins thicken, becoming more noticeable.  It feels right");
					if (pc.cor() + pc.libido() < 50) output(" to have such a splendid tool.  You idly daydream about cunts and pussies, your " + pc.cockDescript(temp) + " plowing them relentlessly, stuffing them pregnant with cum");
					if (pc.cor() + pc.libido() >= 50 && pc.cor() + pc.libido() < 80) output(" to be this way... You breath the powerful animalistic scent and fantasize about fucking centaurs night and day until their bellies slosh with your cum");
					if (pc.cor() + pc.libido() >= 75 && pc.cor() + pc.libido() <= 125) output(" to be a rutting stud.  You ache to find a mare or centaur to breed with.  Longing to spend your evenings plunging your " + pc.cockDescript(temp) + " deep into their musky passages, dumping load after load of your thick animal-cum into them.  You'd be happy just fucking horsecunts morning, noon, and night.  Maybe somewhere there is a farm needing a breeder..");
					if (pc.cor() + pc.libido() > 125) output(" to whinny loudly like a rutting stallion.  Your " + pc.cockDescript(temp) + " is perfect for fucking centaurs and mares.  You imagine the feel of plowing an equine pussy deeply, bottoming out and unloading sticky jets of horse-jizz into its fertile womb.  Your hand strokes your horsecock of its own accord, musky pre dripping from the flared tip with each stroke.  Your mind wanders to the thought of you with a harem of pregnant centaurs");
					output(".");
					if (pc.cor() < 30) output("  You shudder in revulsion at the strange thoughts and vow to control yourself better.");
					if (pc.cor() >= 30 && pc.cor() < 60) output("  You wonder why you thought such odd things, but they have a certain appeal.");
					if (pc.cor() >= 60 && pc.cor() < 90) output("  You relish your twisted fantasies, hoping to dream of them again.");
					if (pc.cor() >= 90) output("  You flush hotly and give a twisted smile, resolving to find a fitting subject to rape and relive your fantasies.");
					pc.libido(0.5);
					pc.lust(10);
				}
				//Chance of ball growth if not 3" yet
				if (rand(2) == 0 && changes < changeLimit && pc.ballSizeRaw <= 3 && pc.hasCock(GLOBAL.TYPE_EQUINE)) {
					if (pc.balls == 0) {
						pc.balls = 2;
						pc.ballSizeRaw = 2;
						output("\n\nA nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.");
						pc.libido(2);
						pc.lust(5);
					}
					else {
						pc.ballSizeRaw++;
						if (pc.ballSize() <= 2) kGAMECLASS.output("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + pc.ballsDescript() + " have grown larger than a human's.");
						if (pc.ballSize() > 2) kGAMECLASS.output("\n\nA sudden onset of heat envelops your groin, focusing on your " + pc.sackDescript() + ".  Walking becomes difficult as you discover your " + pc.ballsDescript() + " have enlarged again.");
						pc.libido(1);
						pc.lust(3);
					}
					changes++;
				}
			}
			//FEMALE
			if (pc.hasVagina()) {
				temp = 0;
				while (temp > 0) {
					temp--;
					if (pc.vaginas[temp].type != GLOBAL.TYPE_EQUINE) {
						break;
					}
				}
				if (pc.vaginas[temp].type != GLOBAL.TYPE_EQUINE && changes < changeLimit && rand(3) == 0 && pc.vaginaTypeUnlocked(temp, GLOBAL.TYPE_EQUINE)) {
					output("You stagger as your " + pc.vaginaDescript(temp) + " abruptly engorges, feeling utterly and completely swollen with blood. It feels even fuller and more plush than when you're turned on, most noticeably around the outer lips. It looks just like... well, a horse-cunt. <b>You've got a big, puffy horse-cunt</b>, perfectly sized to take a big, blunted member.");
					pc.shiftVagina(temp, GLOBAL.TYPE_EQUINE);
					pc.lust(10);
					changes++;
				}
				
				//determine least wet
				//temp - least wet
				//temp2 - saved wetness
				//temp3 - counter
				temp = 0;
				temp2 = pc.vaginas[temp].wetness();
				temp3 = pc.vaginas.length;
				while (temp3 > 0) {
					temp3--;
					if (temp2 > pc.vaginas[temp3].wetness() && pc.wetnessUnlocked(temp, pc.vaginas[temp].wetnessRaw + 1)) {
						temp = temp3;
						temp2 = pc.vaginas[temp].wetness();
					}
				}
				if (pc.vaginas[temp].wetnessRaw <= 2 && changes < changeLimit && rand(2) == 0 && pc.wetnessUnlocked(temp, pc.vaginas[temp].wetnessRaw + 1)) {
					output("\n\nYour " + pc.vaginaDescript(temp) + " moistens perceptably, giving off an animalistic scent.");
					pc.vaginas[0].wetness(temp);
					changes++;
				}
				//determine smallest
				//temp - least big
				//temp2 - saved looseness
				//temp3 - counter
				temp = 0;
				temp2 = pc.vaginas[temp].minLooseness;
				temp3 = pc.vaginas.length;
				while (temp3 > 0) {
					temp3--;
					if (temp2 > pc.vaginas[temp3].minLooseness) {
						temp = temp3;
						temp2 = pc.vaginas[temp].minLooseness;
					}
				}
				if (pc.vaginas[temp].minLooseness <= 4 && changes < changeLimit && rand(2) == 0 && pc.loosenessUnlocked(temp, pc.vaginas[temp].minLooseness + 1)) {
					pc.vaginas[temp].minLooseness++;
					if (pc.vaginas[temp].looseness() < pc.vaginas[temp].minLooseness) pc.vaginas[temp].looseness(1);
					if (pc.vaginas[temp].bonusCapacity < 500) pc.vaginas[temp].bonusCapacity += 15;
					output("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your " + pc.vaginaDescript(temp) + " has grown larger, in depth AND size.");
					changes++;
				}
					
				//if (pc.statusAffectv2(StatusAffects.Heat) < 30 && kGAMECLASS.rand(2) == 0 && changes < changeLimit) {
					//if (pc.goIntoHeat(true)) {
						//changes++;
					//}
				//}

				if (rand(2) == 0 && changes < changeLimit) {
					//Shrink B's!
					//Single row
					if (pc.breastRows.length == 1) {
						//Shrink if bigger than B cups
						if (pc.breastRows[0].breastRatingRaw > 3) {
							temp = 1;
							pc.breastRows[0].breastRatingRaw--;
							//Shrink again if huuuuge
							if (pc.breastRows[0].breastRatingRaw > 8) {
								temp++;
								pc.breastRows[0].breastRatingRaw--;
							}
							//Talk about shrinkage
							if (temp == 1) output("\n\nYou feel a weight lifted from you, and realize your " + pc.breastDescript(0) + " have shrunk to a " + pc.breastCup(0) + ".");
							if (temp == 2) output("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to " + pc.breastCup(0) + "s.");
							changes++;
						}

					}
					//multiple
					else {
						//temp2 = amount changed
						//temp3 = counter
						temp2 = 0;
						temp3 = pc.breastRows.length;
						if (pc.biggestTitSize() > 3) output("\n");
						while (temp3 > 0) {
							temp3--;
							if (pc.breastRows[temp3].breastRatingRaw > 3) {
								pc.breastRows[temp3].breastRatingRaw--;
								temp2++;
								output("\n");
								if (temp3 < pc.breastRows.length - 1) output("...and y");
								else output("Y", false);
								output("our " + pc.breastDescript(temp3) + " shrink, dropping to " + pc.breastCup(temp3) + "s.");
							}
						}
						if (temp2 == 2) output("\nYou feel so much lighter after the change.");
						if (temp2 == 3) output("\nWithout the extra weight you feel particularly limber.");
						if (temp2 >= 4) output("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
						if (temp2 > 0) changes++;
					}
				}
			}
			//NON - GENDER SPECIFIC CHANGES
			//Tail -> Ears -> Fur -> Face
			//possibly Centaur if hooved
			if (changes < changeLimit && rand(6) == 0 && pc.legType == GLOBAL.TYPE_EQUINE && !pc.isTaur() && pc.legCountUnlocked(4)) {
				changes++;
				output("\n\nImmense pain overtakes you as you feel your backbone snap.  The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns.  <b>You now have the lower body of a centaur</b>.");
				if (pc.hasGenitals()) {
					output("  After taking a moment to get used to your new body, you notice that your genitals now reside between the back legs on your centaur body.");
				}
				pc.reflexes(3);
				pc.legCount = 4;
				pc.genitalSpot = 2;
			}
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeArms(pc, GLOBAL.TYPE_EQUINE, [GLOBAL.FLAG_FURRED])) changes++;
			// legs
			if (changes < changeLimit && rand(4) == 0 && pc.legType != GLOBAL.TYPE_EQUINE && Mutator.changeLegs(pc, GLOBAL.TYPE_EQUINE, [2, 4, -1, 2], [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_HOOVES, GLOBAL.FLAG_FURRED])) changes++;
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && Mutator.changeEyes(pc, GLOBAL.TYPE_HUMAN, null, false)) {
				output("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + pc.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.  <b>You have normal, humanoid eyes again.</b>");
				changes++;
			}
			//HorseFace - Req's Fur && Ears
			if (pc.faceType != GLOBAL.TYPE_EQUINE && pc.hasFur() && changes < changeLimit && rand(5) == 0 && pc.earType == GLOBAL.TYPE_EQUINE && pc.faceTypeUnlocked(GLOBAL.TYPE_EQUINE)) {
				if(pc.hasFaceFlag(GLOBAL.FLAG_MUZZLED)) output("Your muzzle stretches outward and squares off at the end as it takes on more horse-like proportions. It doesn't even hurt, though when the transformation finishes, you're left with a blend of equine and humanoid features. <b>You have an anthropomorphic horse face.</b>");
				//Nonsnouted
				else output("Your eyes water like crazy as the bones in your face abruptly... flex. Blinking like mad, you try to watch your expanding, lengthening nose and jaw, but your eyes just aren't working right. You're left nearly blind while <b>your face is rearranged into a elongated horse face!</b>");
				changes++;
				pc.faceType = GLOBAL.TYPE_EQUINE;
				pc.clearFaceFlags();
				pc.addFaceFlag(GLOBAL.FLAG_LONG);
				pc.addFaceFlag(GLOBAL.FLAG_MUZZLED);
			}
			//Fur - if has horsetail && ears and not at changelimit
			if (pc.skinType != GLOBAL.SKIN_TYPE_FUR && changes < changeLimit && rand(4) == 0 && pc.tailType == GLOBAL.TYPE_EQUINE && pc.skinTypeUnlocked(GLOBAL.SKIN_TYPE_FUR)) {
				pc.skinType = GLOBAL.SKIN_TYPE_FUR;
				pc.clearSkinFlags();
				if(!InCollection(pc.furColor, ["chocolate", "ivory", "brown-dappled", "sable"]))
					pc.furColor = RandomInCollection(["chocolate", "ivory", "brown-dappled", "sable"]);
				
				//Scales
				if(pc.skinType == GLOBAL.SKIN_TYPE_SCALES) output("Your scales are flaking off! One after another, the shiny " + pc.scaleColor + " little plates are falling to the ground. In their place, [pc.skinFurScales] is springing up, thick and glossy. You brush the last of your scales away as your full-body fur finishes growing in. An odd desire to be brushed nags at your mind.");
				//Chitin
				else if(pc.skinType == GLOBAL.SKIN_TYPE_CHITIN) output("Your chitinous armor cracks loudly. Thankfully, it doesn't hurt even though the fractures are spreading across your body like breaking glass. You peel away a piece and discover [pc.skinFurScales] growing up out of the gap, and as you marvel at it, the rest of your chitin slowly sloughs off. <b>Your whole body is covered in fur, like a horse!</b> An odd desire to be brushed rises up within you.");
				//Skin or whatever!
				else output("Tiny hairs break through the surface of your [pc.skin], making you itch like crazy. It's enough to distract you for sure, and it only gets worse as more and more hair emerges. The ones that came out first are getting longer and thicker, with the newer additions following close behind. Before you know it, your [pc.skin] vanishes under your new coat of [pc.skinFurScales]. <b>You struggle with a strange desire to be brushed as you admire your new horse hair coat.</b>");
			}
			//Ears - requires tail
			if (pc.earType != GLOBAL.TYPE_EQUINE && pc.tailType == GLOBAL.TYPE_EQUINE && changes < changeLimit && rand(3) == 0 && pc.earTypeUnlocked(GLOBAL.TYPE_EQUINE)) {
				if (pc.earType == GLOBAL.TYPE_HUMAN) output("\n\nYour ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into a upright animalistic ears.  ");
				else if (pc.earType == GLOBAL.TYPE_CANINE) output("\n\nYour ears change shape, morphing into from their doglike shape into equine-like ears!  ");
				else output("\n\nYour ears change shape, morphing into teardrop-shaped horse ears!  ");
				pc.earType = GLOBAL.TYPE_EQUINE;
				output("<b>You now have horse ears.</b>");
				changes++;
			}
			//Tail - no-prereq
			if (pc.hasTail(GLOBAL.TYPE_EQUINE) && rand(2) == 0 && changes < changeLimit && pc.tailTypeUnlocked(GLOBAL.TYPE_EQUINE)) {
				//no tail
				if (!pc.hasTail()) {
					output("\n\nThere is a sudden tickling on your ass, and you notice you have sprouted a long shiny horsetail of the same " + pc.hairColor + " color as your hair.");
				}
				//if other animal tail
				else
					output("\n\nPain lances up your [pc.ass] as your tail shifts and morphs disgustingly.  With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
				output("  <b>You now have a horse-tail.</b>");
				pc.clearTailFlags();
				pc.addTailFlag(GLOBAL.FLAG_LONG);
				pc.tailCount = 1;
				pc.tailType = GLOBAL.TYPE_EQUINE;
				changes++;
			}
			if (rand(4) == 0 && pc.gills && changes < changeLimit && pc.gillsUnlocked(false)) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			if (rand(2) == 0 && pc.tone < 60) Mutator.modTone(pc, 60, 1, true);
			//FAILSAFE CHANGE
			if (changes == 0) {
				output("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				pc.HP(20);
				pc.lust(3);
			}
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}