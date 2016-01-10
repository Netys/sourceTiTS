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
	
    public class CoCMinotaurBlood extends ItemSlotClass
    {
        public function CoCMinotaurBlood(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "MinoBlo";
            //Regular name
            this.longName = "vial of Minotaur blood";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a vial of Minotaur blood";
            //Displayed on tooltips during mouseovers
            this.tooltip = "You've got a scratched up looking vial full of bright red minotaur blood.  Any time you move it around it seems to froth up, as if eager to escape.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			MinotaurBlood(pc);
			return false;
		}
		
		public function MinotaurBlood(pc:Creature):void
		{
			clearOutput();
			//Changes done
			var changes:Number = 0;
			//Change limit
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			if (changeLimit == 1) changeLimit = 2;
			//Temporary storage
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Set up output
			output("You drink the bubbling red fluid, tasting the tangy iron after-taste.");
			//STATS
			//Strength h
			if (rand(3) == 0 && changes < changeLimit) {
				//weaker characters gain more
				if (pc.PQ() <= 50) {
					output("\n\nPainful aches ripple through your body, flooding you with pain as your muscles flex and bulge, growing much stronger and more well-defined.");
					//very weak players gain more
					pc.slowStatGain("p", 2);
				}
				//stronger characters gain less
				else {
					output("\n\nYour muscles grow tighter, bulging outwards powerfully as you get even stronger!");
					pc.slowStatGain("p", 1);
				}
				//Chance of speed drop
				if (rand(2) == 0 && pc.PQ() > 50) {
					output("\n\nYou begin to feel that the size of your muscles is starting to slow you down.");
					pc.slowStatGain("r", -1);
				}
				changes++;
			}
			//Toughness (chance of - sensitivity)
			//if (rand(3) == 0 && changes < changeLimit) {
				////weaker characters gain more
				//if (pc.tou <= 50) {
					//output("\n\nYour hide... skin... whatever... you can feel it getting tougher as it thickens perceptibly.", false);
					////very weak players gain more
					//if (pc.tou <= 20) dynStats("tou", 3);
					//else dynStats("tou", 2);
				//}
				////stronger characters gain less
				//else {
					////small growth if over 75
					//if (pc.tou >= 75) dynStats("tou", .5);
					////faster from 50-75
					//else dynStats("tou", 1);
					//output("\n\nYour tough hide grows slightly thicker.", false);
				//}
				////chance of less sensitivity
				//if (rand(2) == 0 && pc.sens > 10) {
					//if (pc.tou > 75) {
						//output("\n\nIt becomes much harder to feel anything through your leathery skin.", false);
						//dynStats("sen", -3);
					//}
					//if (pc.tou <= 75 && pc.tou > 50) {
						//output("\n\nThe level of sensation from your skin diminishes noticeably.", false);
						//dynStats("sen", -2);
					//}
					//if (pc.tou <= 50) {
						//output("\n\nYour sense of touch diminishes due to your tougher hide.", false);
						//dynStats("sen", -3);
					//}
				//}
				//changes++;
			//}
			//SEXUAL
			//Boosts ball size MORE than equinum :D:D:D:D:D:D:
			if (changes < changeLimit && rand(2) == 0 && (pc.ballSize() <= 5 || pc.balls == 0) && pc.cockTotal(GLOBAL.TYPE_EQUINE) > 0) {
				//Chance of ball growth if not 3" yet
				if (pc.balls == 0) {
					pc.balls = 2;
					pc.ballSizeRaw = 1;
					pc.removeStatusEffect("Uniball");
					output("\n\nA nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed [pc.sack].");
					//dynStats("lib", 2, "lus", 5);
					pc.libido(2);
					pc.lust(5);
				}
				else {
					pc.ballSizeRaw++;
					if (pc.ballSize() <= 2) output("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your [pc.balls] have grown larger than a human's.");
					else output("\n\nA sudden onset of heat envelops your groin, focusing on your [pc.sack].  Walking becomes difficult as you discover your [pc.balls] have enlarged again.");
					//dynStats("lib", 1, "lus", 3);
					pc.libido(1);
					pc.lust(3);
				}
				changes++;
			}
			////-Remove feather-arms (copy this for goblin ale, mino blood, equinum, canine pepps, demon items)
			//if (changes < changeLimit && pc.armType == ARM_TYPE_HARPY && rand(4) == 0) {
				//output("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving " + pc.skinDesc + " behind.", false);
				//pc.armType = ARM_TYPE_HUMAN;
				//changes++;
			//}
			////-Remove chitin-arms (copy this for goblin ale, mino blood, equinum, canine pepps, demon items)
			//if (changes < changeLimit && pc.armType == ARM_TYPE_SPIDER && rand(4) == 0) {
				//output("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving " + pc.skinDesc + " behind.", false);
				//pc.armType = ARM_TYPE_HUMAN;
				//changes++;
			//}
			//+hooves MinoCharge copypaste
			if ((pc.legType != GLOBAL.TYPE_BOVINE || !pc.hasLegFlag(GLOBAL.FLAG_HOOVES))) {
				if (changes < changeLimit && rand(3) == 0) {
					//PC was a naga:
					if (pc.isNaga())
					{
						output("\n\nA strange sensation runs through your serpentine lower body, followed by a wracking pain. You double over, hugging yourself to your coiling snake-body as the Bovinium decides to rob you of your serpent-half. The transformation is quick, but thoroughly unpleasant: your [pc.leg] splits apart wholesale, its outer parts flaking off to reveal taut, [pc.skinColor] skin. <b>You now have bipedal legs!</b>");

						output("\n\nThat’s not enough for the drug, though. Not by a long shot! After a few moments, you see <b>thick, curly fur starts to grow on your new-grown legs</b>, covering them up to the upper thighs. At least you’ll be warm in the winter!");

						output("\n\nThe bottoms of your legs take form: <b>rather than feet, they mutate into distinctly animalistic hooves.</b> You spend a good long while standing up and adjusting to your new gait, wobbling around until you get your footing. Or hoofing, as the case may be.");
						pc.legType = GLOBAL.TYPE_BOVINE;
						pc.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_HOOVES, GLOBAL.FLAG_FURRED];
						pc.legCount = 2;
						pc.genitalSpot = 0;	
					}
					//PC was a taur:
					else if (pc.isTaur())
					{
						output("\n\nYour bestial lower body is wracked with pain, and the mass of it starts convulsing, breaking apart at the seams. From the waist down, your body changes, becoming more and more humanoid as the minutes pass. When the transition ends, <b>you’re left with bipedal legs,</b> distinctly human in appearance.");
						output("\n\nThat’s not enough for the drug, though. Not by a long shot! After a few moments, you see <b>thick, curly fur starts to grow on your new-grown legs</b>, covering them up to the upper thighs. At least you’ll be warm in the winter!");
						output("\n\nThe bottoms of your legs take form: <b>rather than feet, they mutate into distinctly animalistic hooves.</b> You spend a good long while standing up and adjusting to your new gait, wobbling around until you get your footing. Or hoofing, as the case may be.");
						pc.legType = GLOBAL.TYPE_BOVINE;
						pc.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_HOOVES, GLOBAL.FLAG_FURRED];
						pc.legCount = 2;
						pc.genitalSpot = 0;	
					}
					//PC was bipedal already:
					else
					{
						output("\n\nYou feel your [pc.legOrLegs] shifting, the [pc.skinFurScales] on them squirming and moving. After a few tense moments, <b>a thick coating of curly fur sprouts from your [pc.legOrLegs], covering them to the upper thigh</b>.");
						//if not already hooves: 
						if(!pc.hasLegFlag(GLOBAL.FLAG_HOOVES)) output(" Your feet curl in, starting to become covered by a thick, black covering. You grunt and moan, rubbing your transforming body as your feet change. When they’re done, <b>you have a pair of cow-like hooves!</b>.");
						pc.legType = GLOBAL.TYPE_BOVINE;
						pc.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_HOOVES, GLOBAL.FLAG_FURRED];
						pc.legCount = 2;
						pc.genitalSpot = 0;	
					}
					pc.slowStatGain("r", 1);
					//dynStats("spe", 1);
					changes++;
				}
			}
			//Kills vagina size (and eventually the whole vagina)
			if (pc.vaginas.length > 0) {
				if (pc.vaginas[0].loosenessRaw > 1) {
					//tighten that bitch up!
					output("\n\nYour [pc.vagina] clenches up painfully as it tightens up, becoming smaller and tighter.");
					pc.vaginas[0].loosenessRaw--;
				}
				else {
					output("\n\nA tightness in your groin is the only warning you get before your <b>[pc.vagina] disappears forever</b>!");
					//Goodbye womanhood!
					pc.removeVagina(0, 1);
					if (pc.cocks.length == 0) {
						output("  Strangely, your clit seems to have resisted the change, and is growing larger by the moment... shifting into the shape of a small ribbed minotaur-like penis!  <b>You now have a horse-cock!</b>");
						pc.createCock();
						pc.shiftCock(0, GLOBAL.TYPE_EQUINE);
						pc.cocks[0].cLength(pc.clitLength + 2);
						pc.clitLength = .25;
					}
				}
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && pc.bRows() > 1 && rand(3) == 0) {
				changes++;
				output("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most [pc.lowestBreasts] shrink down, disappearing completely into your ");
				if (pc.bRows() >= 3) output("abdomen");
				else output("chest");
				output(". The [pc.nipples " + (pc.bRows() - 1) + "] even fade until nothing but [pc.skinFurScales] remains. <b>You've lost a row of breasts!</b>");
				//dynStats("sen", -5);
				pc.removeBreastRow(pc.breastRows.length - 1, 1);
			}
			//Shrink boobages till they are normal
			else if (rand(2) == 0 && changes < changeLimit && pc.breastRows.length > 0) {
				//Single row
				if (pc.breastRows.length == 1) {
					//Shrink if bigger than B cups
					if (pc.breastRows[0].breastRatingRaw >= 1) {
						temp = 1;
						pc.breastRows[0].breastRatingRaw--;
						//Shrink again if huuuuge
						if (pc.breastRows[0].breastRatingRaw > 8) {
							temp++;
							pc.breastRows[0].breastRatingRaw--;
						}
						//Talk about shrinkage
						if (temp == 1) output("\n\nYou feel a weight lifted from you, and realize your [pc.breasts] have shrunk to [pc.breastCupSize]s.");
						if (temp == 2) output("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to [pc.breastCupSize]s.");
						changes++;
					}
				}
				//multiple
				else {
					//temp2 = amount changed
					//temp3 = counter
					temp = 0;
					temp2 = 0;
					temp3 = 0;
					if (pc.biggestTitSize() >= 1) output("\n");
					while (temp3 < pc.breastRows.length) {
						if (pc.breastRows[temp3].breastRatingRaw >= 1) {
							pc.breastRows[temp3].breastRatingRaw--;
							temp2++;
							output("\n", false);
							//If this isn't the first change...
							if (temp2 > 1) output("...and y", false);
							else output("Y", false);
							output("our " + pc.breastDescript(temp3) + " shrink, dropping to " + pc.breastCup(temp3) + "s.");
						}
						temp3++;
					}
					if (temp2 == 2) output("\nYou feel so much lighter after the change.");
					if (temp2 == 3) output("\nWithout the extra weight you feel particularly limber.");
					if (temp2 >= 4) output("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
					if (temp2 > 0) changes++;
				}
			}
			//Boosts cock size up to 36"x5".
			if (changes < changeLimit && rand(2) == 0 && pc.cocks.length > 0) {
				var selectedCock:int = -1;
				for (var i:int = 0; i < pc.cocks.length; i++)
				{
					if (pc.cocks[i].cType == GLOBAL.TYPE_EQUINE && pc.cocks[i].cLength() < 36)
					{
						selectedCock = i;
						break;
					}
				}
				
				//Length first
				if (selectedCock != -1) {
					//Just length...
					//Increase by 2 + rand(8), and store the actual amount in temp
					temp = pc.increaseCock(2 + rand(8), selectedCock);
					//Comment on length changes
					if (temp > 6) output("\n\nGasping in sudden pleasure, your [pc.cock " + selectedCock + "] surges free of its sheath, emerging with over half a foot of new dick-flesh.");
					if (temp <= 6 && temp >= 3) output("\n\nYou pant in delight as a few inches of [pc.cock " + selectedCock + "] pop free from your sheath, the thick new horse-flesh still slick and sensitive.");
					if (temp < 3) output("\n\nGroaning softly, you feel a pleasurable change in your groin.  Looking down, you see [pc.cock " + selectedCock + "] grow slightly longer.");
					changes++;
				}
			}
			//Morph dick to horsediiiiick
			if (pc.cocks.length > 0 && rand(2) == 0 && changes < changeLimit) {
				var selectedCockValue:int = -1; //Changed as selectedCock and i caused duplicate var warnings
				for (var indexI:int = 0; indexI < pc.cocks.length; indexI++)
				{
					if (pc.cocks[indexI].cType != GLOBAL.TYPE_EQUINE)
					{
						selectedCockValue = indexI;
						break;
					}
				}
				
				if (selectedCockValue != -1) {
					//Text for humandicks or others
					//Text for dogdicks
					//if (pc.cocks[selectedCockValue].cockType == CockTypesEnum.DOG) output("\n\nYour " + Appearance.cockNoun(CockTypesEnum.DOG) + " begins to feel odd...  You pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + Appearance.cockNoun(CockTypesEnum.DOG) + " as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond its traditional size.  You notice your knot vanishing, the extra flesh pushing more fresh horsecock out from your sheath.  <b>Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + "</b>, and you jerk yourself off, splattering thick ropes of cum with intense force.", false);
					output("\n\nYour [pc.cock " + selectedCock + "] begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.");
					pc.shiftCock(selectedCockValue, GLOBAL.TYPE_EQUINE);
					pc.increaseCock(4, selectedCockValue);
					//dynStats("lib", 5, "sen", 4, "lus", 35);
					pc.libido(5);
					pc.lust(35);
					output("<b>  You now have a");
					if (pc.cockTotal(GLOBAL.TYPE_EQUINE) > 1) output("nother")
					output(" horse-penis.</b>");
					changes++;
				}
			}
			
			//Males go into rut
			if (rand(4) == 0) {
				kGAMECLASS.goIntoRut(true);
			}
			
			//Anti-masturbation status
			if (rand(4) == 0 && changes < changeLimit && !pc.hasStatusEffect("Dysfunction") < 0 && pc.hasGenitals()) {
				if (pc.cocks.length > 0) output("\n\nYour [pc.cock] tingles abruptly, then stops.  Worried, you reach down to check it, only to discover that it feels... numb.  It will be very hard to masturbate like this.");
				else if (pc.hasVagina()) output("\n\nYour [pc.vagina] tingles abruptly, then stops.  Worried, you reach down to check it, only to discover that it feels... numb.  It will be very hard to masturbate like this.");
				pc.createStatusEffect("Dysfunction", 0, 0, 0, 0, false, "Icon_LustDown", "Your genitals feels... numb.  It will be very hard to masturbate like this.", false, 60 * 96);
				changes++;
			}
			//Appearance shit:
			//Tail, Ears, Hooves, Horns, Height (no prereq), Face
			//+height up to 9 foot
			if (changes < changeLimit && rand(2) == 0 && pc.tallness < 108) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (pc.tallness > 90) temp = Math.floor(temp / 2);
				//Never 0
				if (temp == 0) temp = 1;
				//Flavor texts.  Flavored like 1950's cigarettes. Yum.
				if (temp < 5) output("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 5 && temp < 7) output("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 7) output("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				pc.tallness += temp;
				changes++;
			}
			//Face change, requires Ears + Height + Hooves
			if (pc.earType == GLOBAL.TYPE_BOVINE && pc.legType == GLOBAL.TYPE_BOVINE && pc.faceType != GLOBAL.TYPE_BOVINE && pc.tallness >= 90 && changes < changeLimit && rand(3) == 0) {
				output("\n\nBones shift and twist painfully as your visage twists and morphs to resemble that of the beast whose blood you now drink.  <b>You now have a minotaur-like face.</b>");
				changes++;
				pc.faceType = GLOBAL.TYPE_BOVINE;
				pc.faceFlags = [GLOBAL.FLAG_MUZZLED, GLOBAL.FLAG_LONG];
			}
			//+mino horns require ears/tail
			if (changes < changeLimit && rand(3) == 0 && pc.earType == GLOBAL.TYPE_BOVINE && pc.tailType == GLOBAL.TYPE_BOVINE) {
				temp = 1;
				//New horns or expanding mino horns
				if (pc.hasHorns(GLOBAL.TYPE_BOVINE) || !pc.hasHorns()) {
					//Get bigger if player has horns
					if (pc.hasHorns(GLOBAL.TYPE_BOVINE)) {
						//Fems horns don't get bigger.
						if (pc.hasVagina() > 0) {
							if (pc.hornLength > 4) {
								output("\n\nYou feel a pressure in your head around your horns, but they don't grow any larger.  ");
								output("Your headache clears as lust washes through you unnaturally.  You feel as if you haven't cum in months.");
								pc.minutesSinceCum += 200 * 60;
								//dynStats("lus", 20);
								pc.lust(20);
							}
							else {
								output("\n\nYour small horns get a bit bigger, stopping as medium sized nubs.");
								pc.hornLength += 3;
							}
							changes++;
						}
						//Males horns get 'uge.
						else {
							temp = 1 + rand(3);
							pc.hornLength += temp;
							if (temp == 0) changes--;
							if (temp == 1) output("\n\nAn aching pressure builds in your temples as you feel your horns push another inch of length from your skull.  ");
							if (temp == 2) output("\n\nA powerful headache momentarily doubles you over.  With painful slowness, you feel your horns push another two inches of length out from your brow, gradually thickening as they grow.  ");
							if (temp == 3) output("\n\nAgony overwhelms you as a headache of terrifying intensity sweeps through your skull.  You squeeze your eyes shut from the pain, but it does little to help.  The torture intensifies before finally diminishing as you feel an inch or two of new horn force its way out of your forehead.  The headache remains despite this, and desperate for relief, you grab hold of your horns and tug, pulling another inch of new horn free.  At last the pain fades, leaving you with significantly enhanced head-spikes.  ", false);
							if (pc.hornLength < 3) output("They are the size of tiny nubs.");
							if (pc.hornLength >= 3 && pc.hornLength < 6) output("They are similar to what you would see on a young bull.");
							if (pc.hornLength >= 6 && pc.hornLength < 12) output("They look like the horns on a grown bull, big enough and dangerous enough to do some damage.");
							if (pc.hornLength >= 12 && pc.hornLength < 20) output("They are large and wicked looking.");
							if (pc.hornLength >= 20) output("They are huge, heavy, and tipped with dangerous points.");
							//boys get a cum refill sometimes
							if (rand(2) == 0 && changes < changeLimit) {
								output("  Your headache clears as lust washes through you unnaturally.  You feel as if you haven't cum in months.");
								pc.minutesSinceCum += 200 * 60;
								//dynStats("lus", 20);
								pc.lust(20);
							}
							changes++;
						}
					}
					//If no horns yet..
					else {
						output("\n\nWith painful pressure, the skin on your forehead splits around two tiny nub-like horns, similar to those you would see on the cattle back in your homeland.");
						pc.hornType = GLOBAL.TYPE_BOVINE;
						pc.hornLength = 1;
						pc.horns = 2;
						changes++;
					}
				}
				//Not mino horns, change to cow-horns
				if (pc.hasHorns() && !pc.hasHorns(GLOBAL.TYPE_BOVINE)) {
					output("\n\nYour horns vibrate and shift as if made of clay, reforming into two horns with a bovine-like shape.");
					pc.hornType = GLOBAL.TYPE_BOVINE;
					pc.hornLength = 1;
					pc.horns = 2;
					changes++;
				}
			}
			//+cow ears	- requires tail
			if (pc.earType != GLOBAL.TYPE_BOVINE && changes < changeLimit && pc.tailType == GLOBAL.TYPE_BOVINE && rand(2) == 0) {
				output("\n\nYou feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like.  <b>You now have cow ears.</b>");
				pc.earType = GLOBAL.TYPE_BOVINE;
				pc.earLength = 1;
				changes++;
			}
			//+cow tail
			if (changes < changeLimit && rand(2) == 0 && pc.tailType != GLOBAL.TYPE_BOVINE) {
				if (!pc.hasTail()) output("\n\nYou feel the flesh above your [pc.ass] knotting and growing.  It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
				else output("\n\nYour tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
				
				pc.tailCount = 1;
				pc.tailType = GLOBAL.TYPE_BOVINE;
				pc.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FLUFFY];
				changes++;
			}
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.", false);
				pc.gills = false;
				changes++;
			}
			if (changes < changeLimit && rand(4) == 0 && !pc.hasPerk("Marae's Gift: Buttslut") && (pc.ass.loosenessRaw > 1 || pc.ass.wetnessRaw > 1)) {
				output("\n\nYou feel a tightening up in your colon and your [pc.asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades.  Your ass seems to have dried and tightened up.");
				if (pc.ass.wetnessRaw > 1) pc.ass.wetnessRaw--;
				if (pc.ass.loosenessRaw > 1) pc.ass.loosenessRaw--;
				changes++;
			}
			//Give you that mino build!
			if (rand(4) == 0 && pc.femininity > 5) output(pc.modFem(-10));
			if (rand(4) == 0 && pc.tone < 85) output(pc.modTone(3));
			if (rand(4) == 0 && pc.thickness < 70) output(pc.modThickness(4));
			//Default
			if (changes == 0) {
				output("\n\nMinotaur-like vitality surges through your body, invigorating and arousing you!\n");
				if (pc.balls > 0) {
					output("Your balls feel as if they've grown heavier with the weight of more sperm.\n");
					pc.minutesSinceCum += 200 * 60;
				}
				pc.lust(50);
				pc.HP(50);
			}
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}	
}
