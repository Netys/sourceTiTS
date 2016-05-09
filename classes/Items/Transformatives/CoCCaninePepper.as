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
	
	public class CoCCaninePepper extends ItemSlotClass
	{
		public function CoCCaninePepper(dataObject:Object=null)
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "CanineP";
			//Regular name
			this.longName = "Canine pepper";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a canine pepper";
			//Displayed on tooltips during mouseovers
			this.tooltip = "The pepper is shiny and red, bulbous at the base but long and narrow at the tip.  It smells spicy.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 100;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
		{
			CaninePepper(0, pc);
			return false;
		}
		
		public function CaninePepper(type:Number,pc:Creature):void
		{
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			var crit:Number = 1;
			//Set up changes and changeLimit
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Initial outputs & crit level
			clearOutput();
			if (type == 0) {
				if (rand(100) < 15) {
					crit = int(Math.random() * 20) / 10 + 2;
					output("The pepper tastes particularly potent, searingly hot and spicy.");
				}
				else output("The pepper is strangely spicy but very tasty.");
			}
			//Oversized pepper
			if (type == 1) {
				crit = int(Math.random() * 20) / 10 + 2;
				output("The pepper is so large and thick that you have to eat it in several large bites.  It is not as spicy as the normal ones, but is delicious and flavorful.");
			}
			//Double Pepper
			if (type == 2) {
				crit = int(Math.random() * 20) / 10 + 2;
				output("The double-pepper is strange, looking like it was formed when two peppers grew together near their bases.");
			}
			//Black Pepper
			if (type == 3) {
				crit = int(Math.random() * 20) / 10 + 2;
				output("This black pepper tastes sweet, but has a bit of a tangy aftertaste.");
			}
			//Knotty Pepper
			if (type == 4) {
				crit = int(Math.random() * 20) / 10 + 2;
				output("The pepper is a bit tough to eat due to the swollen bulge near the base, but you manage to cram it down and munch on it.  It's extra spicy!");
			}
			//Bulbous Pepper
			if (type == 5) {
				crit = int(Math.random() * 20) / 10 + 2;
				output("You eat the pepper, even the two orb-like growths that have grown out from the base.  It's delicious!");
			}
			//OVERDOSE Bad End!
			if (type <= 0 && crit > 1 && pc.hasFur() && pc.canineScore() >= 6 && rand(2) == 0 && kGAMECLASS.flags["COC.BAD_END_WARNING_DOG"] != undefined && !pc.hasPerk("Transformation Resistance")) {
				if (rand(2) == 0) {
					output("\n\nAs you swallow the pepper, you note that the spicy hotness on your tongue seems to be spreading. Your entire body seems to tingle and burn, making you feel far warmer than normal, feverish even. Unable to stand it any longer you tear away your clothes, hoping to cool down a little. Sadly, this does nothing to aid you with your problem. On the bright side, the sudden feeling of vertigo you've developed is more than enough to take your mind off your temperature issues. You fall forward onto your hands and knees, well not really hands and knees to be honest. More like paws and knees. That can't be good, you think for a moment, before the sensation of your bones shifting into a quadrupedal configuration robs you of your concentration. After that, it is only a short time before your form is remade completely into that of a large dog, or perhaps a wolf. The distinction would mean little to you now, even if you were capable of comprehending it. ");
					//if (pc.findPerk(PerkLib.MarblesMilk) >= 0) output("All you know is that there is a scent on the wind, it is time to hunt, and at the end of the day you need to come home for your milk.");
					//else 
						output("All you know is that there is a scent on the wind, and it is time to hunt.");
				}
				else output("\n\nYou devour the sweet pepper, carefully licking your fingers for all the succulent juices of the fruit, and are about to go on your way when suddenly a tightness begins to build in your chest and stomach, horrid cramps working their way first through your chest, then slowly flowing out to your extremities, the feeling soon joined by horrible, blood-curdling cracks as your bones begin to reform, twisting and shifting, your mind exploding with pain. You fall to the ground, reaching one hand forward. No... A paw, you realize in horror, as you try to push yourself back up. You watch in horror, looking down your foreleg as thicker fur erupts from your skin, a " + pc.furColor + " coat slowly creeping from your bare flesh to cover your body. Suddenly, you feel yourself slipping away, as if into a dream, your mind warping and twisting, your body finally settling into its new form. With one last crack of bone you let out a yelp, kicking free of the cloth that binds you, wresting yourself from its grasp and fleeing into the now setting sun, eager to find prey to dine on tonight.");
				kGAMECLASS.badEnd();
				return;
			}
			//WARNING, overdose VERY close!
			if (type <= 0 && pc.hasFur() && pc.canineScore() >= 5 && kGAMECLASS.flags["COC.BAD_END_WARNING_DOG"] != undefined && rand(3) == 0) {
				output("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			//WARNING, overdose is close!
			if (type <= 0 && pc.canineScore() >= 5 && kGAMECLASS.flags["COC.BAD_END_WARNING_DOG"] == undefined) {
				kGAMECLASS.flags["COC.BAD_END_WARNING_DOG"] = 1;
				output("<b>\n\nEating the pepper, you realize how dog-like you've become, and you wonder what else the peppers could change...</b>");
			}
			if (type == 3) {
				pc.libido(2 + rand(4));
				pc.lust(5 + rand(5));
				pc.cor(2 + rand(4));
				output("\n\nYou feel yourself relaxing as gentle warmth spreads through your body.  Honestly you don't think you'd mind running into a demon or monster right now, they'd make for good entertainment.");
				if (pc.cor() < 50) output("  You shake your head, blushing hotly.  Where did that thought come from?");
			}
			if (pc.PQ() < 50 && rand(3) == 0) {
				pc.slowStatGain("p", (crit) / 2);
				pc.modTone((crit) / 2, false);
				if (crit > 1) output("\n\nYour muscles ripple and grow, bulging outwards.");
				else output("\n\nYour muscles feel more toned.");
				changes++;
			}
			if (pc.RQ() < 30 && rand(3) == 0 && changes < changeLimit) {
				pc.slowStatGain("r", (crit) / 2);
				pc.modThickness( -(crit) / 2, false);
				if (crit > 1) output("\n\nYou find your muscles responding quicker, faster, and you feel an odd desire to go for a walk.");
				else output("\n\nYou feel quicker.");
				changes++;
			}
			if (pc.IQ() > 30 && rand(3) == 0 && changes < changeLimit && type != 3) {
				pc.intelligence((-0.5 * crit))
				output("\n\nYou feel ");
				if (crit > 1) output("MUCH ");
				output("dumber.");
				changes++;
			}
			if (pc.WQ() > 30 && rand(3) == 0 && changes < changeLimit) {
				pc.willpower((-0.5 * crit))
				output("\n\nThinking for yourself is so exhausting... May it be better to have master to follow?");
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
			//if(type != 2 && type != 4 && type != 5) output("\n");
			//Double Pepper!
			//Xforms/grows dicks to make you have two dogcocks
			if (type == 2) {
				//If already doubled up, GROWTH
				if (pc.cockTotal(GLOBAL.TYPE_CANINE) >= 2) {
					type = 1;
				}
				//If player doesnt have 2 dogdicks
				else {
					//If player has NO dogdicks
					if (!pc.hasCock(GLOBAL.TYPE_CANINE)) {
						//Dickless - grow two dogpeckers
						if (!pc.hasCock()) {
							pc.createCock(7 + rand(7));
							pc.createCock(pc.cocks[0].cLength());
							pc.shiftCock(0, GLOBAL.TYPE_CANINE);
							pc.shiftCock(1, GLOBAL.TYPE_CANINE);
							pc.cocks[0].knotMultiplier = 1.4;
							pc.cocks[1].knotMultiplier = 1.4;
							output("\n\nA painful lump forms on your groin, nearly doubling you over as it presses against your [pc.lowerGarmentOuter].  You rip open your gear and watch, horrified as the discolored skin splits apart, revealing a pair of red-tipped points.  A feeling of relief, and surprising lust grows as they push forward, glistening red and thickening.  The skin bunches up into an animal-like sheath, while a pair of fat bulges pop free.  You now have two nice thick dog-cocks, with decent sized knots.  Both pulse and dribble animal-pre, arousing you in spite of your attempts at self-control.");
						}
						//1 dick - grow 1 and convert 1
						else if (pc.cockTotal() == 1) {
							output("\n\nYour " + pc.cockDescript(0) + " vibrates, the veins clearly visible as it reddens and distorts.  The head narrows into a pointed tip while a gradually widening bulge forms around the base.  Where it meets your crotch, the skin bunches up around it, forming a canine-like sheath.  ");
							pc.shiftCock(0, GLOBAL.TYPE_CANINE)
							pc.cocks[0].knotMultiplier = 1.4;
							output("You feel something slippery wiggling inside the new sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							pc.createCock(pc.cocks[0].cLength());
							pc.shiftCock(1, GLOBAL.TYPE_CANINE)
							pc.cocks[1].knotMultiplier = 1.4;
						}
						//2 dicks+ - convert first 2 to doggie-dom
						else {
							output("\n\nYour crotch twitches, and you pull open your [pc.lowerGarmentOuter] to get a better look.  You watch in horror and arousal as your " + pc.cockDescript(0) + " and " + pc.cockDescript(1) + " both warp and twist, becoming red and pointed, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
							pc.shiftCock(0, GLOBAL.TYPE_CANINE);
							pc.shiftCock(1, GLOBAL.TYPE_CANINE);
							pc.cocks[0].cLength((pc.cocks[0].cLength() + pc.cocks[1].cLength()) / 2, true);
							pc.cocks[1].cLength(pc.cocks[0].cLength(), true);
							pc.cocks[0].knotMultiplier = 1.4;
							pc.cocks[1].knotMultiplier = 1.4;
						}
					}
					//If player has 1 dogdicks
					else {
						//if player has 1 total
						if (pc.cockTotal() == 1) {
							output("\n\nYou feel something slippery wiggling inside your sheath, and another red point peeks out.  In spite of yourself, you start getting turned on by the change, and the new dick slowly slides free, eventually stopping once the thick knot pops free.  The pair of dog-dicks hang there, leaking pre-cum and arousing you far beyond normal.");
							pc.createCock(pc.cocks[0].cLength());
							pc.shiftCock(1, GLOBAL.TYPE_CANINE);
							pc.cocks[1].knotMultiplier = pc.cocks[0].knotMultiplier;
						}
						//if player has more
						else if (pc.cockTotal() >= 1) {
							var x:int = pc.findFirstOfcType(GLOBAL.TYPE_CANINE);
							var y:int = x = 0 ? 1 : 0;
							output("\n\nYour crotch twitches, and you pull open your [pc.lowerGarmentOuter] to get a better look.  You watch in horror and arousal as your " + pc.cockDescript(y) + " warps and twists, becoming red and pointed, just like other dog-dick, growing thick bulges near the base.  When it stops you have two dog-cocks and an animal-like sheath.  The whole episode turns you on far more than it should, leaving you dripping animal pre and ready to breed.");
							pc.shiftCock(y, GLOBAL.TYPE_CANINE);
							pc.cocks[y].knotMultiplier = pc.cocks[x].knotMultiplier;
							pc.cocks[x].cLength((pc.cocks[x].cLength() + pc.cocks[y].cLength()) / 2, true);
							pc.cocks[y].cLength(pc.cocks[x].cLength(), true);
						}
						pc.libido(2);
						pc.lust(50);
					}
				}
			}
			//Knotty knot pepper!
			if (type == 4) {
				//Cocks only!
				if (pc.hasCock()) {
					//biggify knots
					if (pc.hasCock(GLOBAL.TYPE_CANINE)) {
						//set temp2 to first dogdick for initialization
						temp2 = pc.findFirstOfcType(GLOBAL.TYPE_CANINE);
						//Reset temp for nex tcheck
						temp = pc.cocks.length;
						//Find smallest knot
						while (temp > 0) {
							temp--;
							if (pc.cocks[temp].hasFlag(GLOBAL.FLAG_KNOTTED) && pc.cocks[temp].knotMultiplier < pc.cocks[temp2].knotMultiplier) temp2 = temp;
						}
						//Have smallest knotted cock selected.
						temp3 = (rand(2) + 5) / 20 * crit;
						if (pc.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
						if (pc.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
						if (pc.cocks[temp2].knotMultiplier >= 2) temp3 /= 5;
						pc.cocks[temp2].knotMultiplier += (temp3);
						output("\n\n");
						if (temp3 < .06) output("Your [pc.cockNoun " + temp2 + "] feels unusually tight in your sheath as your knot grows.");
						if (temp3 >= .06 && temp3 <= .12) output("Your [pc.cockNoun " + temp2 + "] pops free of your sheath, thickening nicely into a bigger knot.");
						if (temp3 > .12) output("Your [pc.cockNoun " + temp2 + "] surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
						pc.lust(5 * crit);
					}
					//Grow dogdick with big knot
					else {
						output("\n\nYour " + pc.cockDescript(0) + " twitches, reshaping itself.  The crown tapers down to a point while the base begins swelling.  It isn't painful in the slightest, actually kind of pleasant.  Your dog-like knot slowly fills up like a balloon, eventually stopping when it's nearly twice as thick as the rest.  You touch and shiver with pleasure, oozing pre-cum.");
						pc.shiftCock(0, GLOBAL.TYPE_CANINE);
						pc.cocks[0].knotMultiplier = 2.1;
					}
				}
				//You wasted knot pepper!
				else output("\n\nA slight wave of nausea passes through you.  It seems this pepper does not quite agree with your body.");
			}
			//GROW BALLS
			if (type == 5) {
				if (pc.balls < 1) {
					output("\n\nA spike of pain doubles you up, nearly making you vomit.  You stay like that, nearly crying, as a palpable sense of relief suddenly washes over you.  You look down and realize you now have a small sack, complete with two relatively small balls.");
					pc.balls = 2;
					pc.ballSizeRaw = 1;
					pc.libido(2);
					pc.lust(-10);
				}
				else {
					//Makes your balls biggah!
					pc.ballSizeRaw++;
					//They grow slower as they get bigger...
					if (pc.ballSizeRaw > 10) pc.ballSizeRaw -= .5;
					//Texts
					if (pc.ballSizeRaw <= 2) output("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + pc.ballsDescript() + " have grown larger.");
					if (pc.ballSizeRaw > 2) output("\n\nA sudden onset of heat envelops your groin, focusing on your " + pc.sackDescript() + ".  Walking becomes difficult as you discover your " + pc.ballsDescript() + " have enlarged again.");
					pc.libido(1);
					pc.lust(3);
				}
			}
			//Sexual Stuff Now
			//------------------
			//Man-Parts
			//3 Changes,
			//1. Cock Xform
			//2. Knot Size++
			//3. cumMultiplier++ (to max of 1.5)
			if (pc.hasCock()) {
				//Grow knot on smallest knotted dog cock
				if (type != 4 && pc.hasCock(GLOBAL.TYPE_CANINE) && ((changes < changeLimit && rand(1.4) == 0) || type == 1)) {
					temp = 0;
					//set temp2 to first dogdick for initialization
					while (temp < pc.cocks.length) {
						if (pc.cocks[temp].cType == GLOBAL.TYPE_CANINE) {
							temp2 = temp;
							break;
						}
						else temp++;
					}
					//Reset temp for nex tcheck
					temp = pc.cocks.length;
					//Find smallest knot
					while (temp > 0) {
						temp--;
						if (pc.cocks[temp].cType == GLOBAL.TYPE_CANINE && pc.cocks[temp].knotMultiplier < 2 && pc.cocks[temp].knotMultiplier < pc.cocks[temp2].knotMultiplier) temp2 = temp;
					}
					//Have smallest knotted cock selected.
					temp3 = (rand(2) + 1) / 20 * crit;
					if (pc.cocks[temp2].knotMultiplier >= 1.5) temp3 /= 2;
					if (pc.cocks[temp2].knotMultiplier >= 1.75) temp3 /= 2;
					pc.cocks[temp2].knotMultiplier += temp3;
					if (pc.cocks[temp2].knotMultiplier > 2) pc.cocks[temp2].knotMultiplier = 2;
					
					if (temp3 < .06) output("\n\nYour " + pc.cockDescript(temp2) + " feels unusually tight in your sheath as your knot grows.");
					if (temp3 >= .06 && temp3 <= .12) output("\n\nYour " + pc.cockDescript(temp2) + " pops free of your sheath, thickening nicely into a bigger knot.");
					if (temp3 > .12) output("\n\nYour " + pc.cockDescript(temp2) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.");
					pc.lust(5 * crit);
					changes++;
				}
				//Cock Xform if player has free cocks.
				if (pc.cockTotal(GLOBAL.TYPE_CANINE) < pc.cocks.length && ((changes < changeLimit && rand(1.6)) || type == 1) == 0) {
					//Select first human cock
					temp = pc.cocks.length;
					temp2 = 0;
					while (temp > 0 && temp2 == 0) {
						temp--;
						//Store cock index if not a dogCock and exit loop.
						if (pc.cocks[temp].cType != GLOBAL.TYPE_CANINE) {
							temp3 = temp;
							//kicking out of tah loop!
							temp2 = 1000;
						}
					}
					temp = 0;
					//Talk about it
					//Hooooman
					if (pc.cocks[temp3].cType == GLOBAL.TYPE_HUMAN) {
						output("\n\nYour " + pc.cockDescript(temp3) + " clenches painfully, becoming achingly, throbbingly erect.  A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath.  You shudder as the crown of your " + pc.cockDescript(temp3) + " reshapes into a point, the sensations nearly too much for you.  You throw back your head as the transformation completes, your [pc.cockNoun " + temp3 + "] much thicker than it ever was before.  <b>You now have a dog-cock.</b>");
						pc.lust(5 * crit);
					}
					//Horse
					else if (pc.cocks[temp3].cType == GLOBAL.TYPE_EQUINE) {
						output("\n\nYour " + pc.cockDescript(temp3) + " shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes into a more pointed form, a thick knotted bulge forming just above your sheath.  <b>You now have a dog-cock.</b>");
						//Tweak length/thickness.
						if (pc.cocks[temp3].cLength() > 6) pc.cocks[temp3].cLength(-2);
						else pc.cocks[temp3].cLength(-0.5);
						//pc.cocks[temp3].cockThickness += .5;

						pc.lust(5 * crit);
					}
					//Tentacular Tuesday!
					else if (pc.cocks[temp3].cType == GLOBAL.TYPE_TENTACLE) {
						output("\n\nYour " + pc.cockDescript(temp3) + " coils in on itself, reshaping and losing its plant-like coloration as it thickens near the base, bulging out in a very canine-looking knot.  Your skin bunches painfully around the base, forming into a sheath.  <b>You now have a dog-cock.</b>");
						pc.lust(5 * crit);
					}
					//Misc
					else {
						output("\n\nYour " + pc.cockDescript(temp3) + " trembles, reshaping itself into a shiny red doggie-dick with a fat knot at the base.  <b>You now have a dog-cock.</b>");
						pc.lust(5 * crit);
					}
					//Xform it!
					pc.shiftCock(temp3, GLOBAL.TYPE_CANINE);
					changes++;

				}
				//Cum Multiplier Xform
				if (pc.cumMultiplierRaw < 1.5 && rand(2) == 0 && changes < changeLimit) {
					temp = 1.5;
					//Lots of cum raises cum multiplier cap to 2 instead of 1.5
					//if (pc.findPerk(PerkLib.MessyOrgasms) >= 0) temp = 2;
					if (temp < pc.cumMultiplierRaw + .1 * crit) {
						changes--;
					}
					else {
						pc.cumMultiplierRaw += .1 * crit;
						//Flavor text
						if (pc.balls == 0) output("\n\nYou feel a churning inside your gut as something inside you changes.");
						if (pc.balls > 0) output("\n\nYou feel a churning in your [pc.balls].  It quickly settles, leaving them feeling somewhat more dense.");
						if (crit > 1) output("  A bit of milky pre dribbles from your [pc.cocksLight], pushed out by the change.");
					}
					changes++;
				}
				//Oversized pepper
				if (type == 1) {
					//GET LONGER
					//single cock
					if (pc.cocks.length == 1) {
						temp2 = pc.increaseCock(rand(4) + 3, 0);
						temp = 0;
						pc.lust(10);
						//dynStats("sen", 1, "lus", 10);
					}
					//Multicock
					else {
						//Find smallest cock
						//Temp2 = smallness size
						//temp = current smallest
						temp3 = pc.cocks.length;
						temp = 0;
						while (temp3 > 0) {
							temp3--;
							//If current cock is smaller than saved, switch values.
							if (pc.cocks[temp].cLength() > pc.cocks[temp3].cLength()) {
								temp2 = pc.cocks[temp3].cLength();
								temp = temp3;
							}
						}
						//Grow smallest cock!
						//temp2 changes to growth amount
						temp2 = pc.increaseCock(rand(4) + 3, temp);
						//dynStats("sen", 1, "lus", 10);
						pc.lust(10);
						//if (pc.cocks[temp].cockThickness <= 2) pc.cocks[temp].thickenCock(1);
					}
					if (temp2 > 2) output("\n\nYour " + pc.cockDescript(temp) + " tightens painfully, inches of bulging dick-flesh pouring out from your crotch as it grows longer.  Thick pre forms at the pointed tip, drawn out from the pleasure of the change.");
					if (temp2 > 1 && temp2 <= 2) output("\n\nAching pressure builds within your crotch, suddenly releasing as an inch or more of extra dick-flesh spills out.  A dollop of pre beads on the head of your enlarged " + pc.cockDescript(temp) + " from the pleasure of the growth.");
					if (temp2 <= 1) output("\n\nA slight pressure builds and releases as your " + pc.cockDescript(temp) + " pushes a bit further out of your crotch.");
				}
			}
			//Female Stuff
			//Multiboobages
			if (pc.breastRows.length > 0) {
				//if bigger than A cup
				if (pc.breastRows[0].breastRatingRaw > 0 && pc.vaginas.length > 0) {
					//Doggies only get 3 rows of tits! FENOXO HAS SPOKEN
					if (pc.breastRows.length < 3 && rand(2) == 0 && changes < changeLimit) {
						pc.createBreastRow();
						//Store temp to the index of the newest row
						temp = pc.breastRows.length - 1;
						//Breasts are too small to grow a new row, so they get bigger first
						//But ONLY if player has a vagina (dont want dudes weirded out)
						if (pc.vaginas.length > 0 && pc.breastRows[0].breastRatingRaw < pc.breastRows.length) {
							output("\n\nYour " + pc.breastDescript(0) + " feel constrained and painful against your top as they grow larger by the moment, finally stopping as they reach ");
							pc.breastRows[0].breastRatingRaw += 1;
							output(pc.breastCup(0) + " size.  But it doesn't stop there, you feel a tightness beginning lower on your torso...");
							changes++;
						}
						//Had 1 row to start
						if (pc.breastRows.length == 2) {
							//1 size below primary breast row!
							pc.breastRows[temp].breastRatingRaw = pc.breastRows[0].breastRatingRaw - 1;
							if (pc.breastRows[0].breastRatingRaw - 1 == 0) output("\n\nA second set of breasts forms under your current pair, stopping while they are still fairly flat and masculine looking.");
							else output("\n\nA second set of breasts bulges forth under your current pair, stopping as they reach " + pc.breastCup(temp) + "s.");
							output("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							//dynStats("sen", 6, "lus", 5);
							pc.lust(5);
							changes++;
						}
						//Many breast Rows - requires larger primary tits...
						if (pc.breastRows.length > 2 && pc.breastRows[0].breastRatingRaw > pc.breastRows.length) {
							//dynStats("sen", 6, "lus", 5);
							pc.lust(5);
							//New row's size = the size of the row above -1
							pc.breastRows[temp].breastRatingRaw = pc.breastRows[temp - 1].breastRatingRaw - 1;
							//If second row are super small but primary row is huge it could go negative.
							//This corrects that problem.
							if (pc.breastRows[temp].breastRatingRaw < 0) pc.breastRows[temp].breastRatingRaw = 0;
							if (pc.breastRows[temp - 1].breastRatingRaw < 0) pc.breastRows[temp - 1].breastRatingRaw = 0;
							if (pc.breastRows[temp].breastRatingRaw == 0) output("\n\nYour abdomen tingles and twitches as a new row of breasts sprouts below the others.  Your new breasts stay flat and masculine, not growing any larger.");
							else output("\n\nYour abdomen tingles and twitches as a new row of " + pc.breastCup(temp) + " " + pc.breastDescript(temp) + " sprouts below your others.");
							output("  A sensitive nub grows on the summit of each new tit, becoming a new nipple.");
							changes++;
						}
						//Extra sensitive if crit
						if (crit > 1) {
							if (crit > 2) {
								output("  You heft your new chest experimentally, exploring the new flesh with tender touches.  Your eyes nearly roll back in your head from the intense feelings.");
								//dynStats("sen", 6, "lus", 15, "cor", 0)
								pc.lust(15);
							}
							else {
								output("  You touch your new nipples with a mixture of awe and desire, the experience arousing beyond measure.  You squeal in delight, nearly orgasming, but in time finding the willpower to stop yourself.");
								//dynStats("sen", 3, "lus", 10);
								pc.lust(10);
							}
						}

					}
					//If already has max doggie breasts!
					else if (rand(2) == 0) {
						//Check for size mismatches, and move closer to spec!
						temp = pc.breastRows.length;
						temp2 = 0;
						var evened:Boolean = false;
						//Check each row, and if the row above or below it is
						while (temp > 1 && temp2 == 0) {
							temp--;
							//Gimme a sec
							if (pc.breastRows[temp].breastRatingRaw + 1 < pc.breastRows[temp - 1].breastRatingRaw) {
								if (!evened) {
									evened = true;
									output("\n");
								}
								output("\nYour " + num2Ordinal(temp) + " row of " + pc.breastDescript(temp) + " grows larger, as if jealous of the jiggling flesh above.");
								temp2 = (pc.breastRows[temp - 1].breastRatingRaw) - pc.breastRows[temp].breastRatingRaw - 1;
								if (temp2 > 5) temp2 = 5;
								if (temp2 < 1) temp2 = 1;
								pc.breastRows[temp].breastRatingRaw += temp2;
							}
						}
					}
				}
			}
			//Grow tits if have NO breasts/nipples AT ALL
			else if (rand(2) == 0 && changes < changeLimit) {
				output("\n\nYour chest tingles uncomfortably as your center of balance shifts.  <b>You now have a pair of B-cup breasts.</b>");
				output("  A sensitive nub grows on the summit of each tit, becoming a new nipple.");
				pc.createBreastRow();
				pc.breastRows[0].breastRatingRaw = 2;
				pc.breastRows[0].breasts = 2;
				//dynStats("sen", 4, "lus", 6);
				pc.lust(6);
				changes++;
			}
			//Go into heat
			if (rand(2) == 0 && changes < changeLimit) {
				if(Mutator.goIntoHeat(pc, true)) {
				  changes++;
				}
			}
			
			if (changes < changeLimit && pc.canineScore() >= 3 && rand(4) == 0) {
				changes++;
				output("\n\n");
				output("Images and thoughts come unbidden to your mind, overwhelming your control as you rapidly lose yourself in them, daydreaming of... ");
				//cawk fantasies
				if (pc.hasCock() || (pc.isHerm() && rand(2) == 0)) {
					output("bounding through the woods, hunting with your master.  Feeling the wind in your fur and the thrill of the hunt coursing through your veins intoxicates you.  You have your nose to the ground, tracking your quarry as you run, until a heavenly scent stops you in your tracks.");
					pc.lust(5 + pc.libido() / 20);
					//break1
					if (pc.cor() < 33 || pc.IQ() > 66 || !pc.hasCock()) output("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					else {
						output("  Heart pounding, your shaft pops free of its sheath on instinct, as you take off after the new scent.  Caught firmly in the grip of a female's heat, you ignore your master's cry as you disappear into the wild, " + pc.cockNounComplex(pc.findFirstOfcType(GLOBAL.TYPE_CANINE)) + " growing harder as you near your quarry.  You burst through a bush, spotting a white-furred female.  She drops, exposing her dripping fem-sex to you, the musky scent of her sex channeling straight through your nose and sliding into your " + pc.cockNounComplex(pc.findFirstOfcType(GLOBAL.TYPE_CANINE)) + ".");
						pc.lust(5 + pc.libido() / 20);
						//Break 2
						if (pc.cor() < 66) output("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						else {
							output("  Unable to wait any longer, you mount her, pressing your bulging knot against her vulva as she yips in pleasure. The heat of her sex is unreal, the tight passage gripping you like a vice as you jackhammer against her, biting her neck gently in spite of the violent pounding.");
							pc.lust(5 + pc.libido() / 20);
							//break3
							if (pc.cor() < 80) {
								if (pc.vaginas.length > 0) output("\nYou reluctantly pry your hand from your aching " + pc.vaginaDescript(0) + " as you drag yourself out of your fantasy.");
								else output("\nYou reluctantly pry your hand from your aching " + pc.cockDescript(pc.findFirstOfcType(GLOBAL.TYPE_CANINE)) + " as you drag yourself out of your fantasy.");
							}
							else {
								output("  At last your knot pops into her juicy snatch, splattering her groin with a smattering of her arousal.  The scents of your mating reach a peak as the velvet vice around your " + pc.cockNounComplex(pc.findFirstOfcType(GLOBAL.TYPE_CANINE)) + " quivers in the most indescribably pleasant way.  You clamp down on her hide as your whole body tenses, unleashing a torrent of cum into her sex.  Each blast is accompanied by a squeeze of her hot passage, milking you of the last of your spooge.  Your " + pc.legs() + " give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								pc.lust(5 + pc.libido() / 20);
							}
						}
					}
				}
				//Pure female fantasies
				else if (pc.hasVagina()) {
					output("wagging your dripping " + pc.vaginaDescript(0) + " before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at your fertile scent.");
					pc.lust(5 + pc.libido() / 20);
					//BREAK 1
					if (pc.cor() < 33 || pc.IQ() > 66) {
						output("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						output("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						pc.lust(5 + pc.libido() / 20);
						//BREAK 2
						if (pc.cor() <= 66) {
							output("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							output("  The feeling of all that hot wolf-spooge spilling from your overfilled snatch and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to breed you.");
							pc.lust(5 + pc.libido() / 20);
							//break3
							if (pc.cor() < 80) {
								output("\nYou reluctantly pry your hand from your aching " + pc.vaginaDescript(0) + " as you drag yourself out of your fantasy.");
							}
							else {
								output("  You growl with discomfort as he pushes into your abused wetness, stretching you tightly, every beat of his heart vibrating through your nethers.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								pc.lust(5 + pc.libido() / 20);
							}
						}
					}
				}
				else {
					output("wagging your [pc.asshole] before a pack of horny wolves, watching their shiny red doggie-pricks practically jump out of their sheaths at you after going so long without a female in the pack.");
					pc.lust(5 + pc.libido() / 20);
					//BREAK 1
					if (pc.cor() < 33) {
						output("\nYou shake your head to clear the unwanted fantasy from your mind, repulsed by it.");
					}
					else {
						output("  In moments they begin their advance, plunging their pointed beast-dicks into you, one after another.  You yip and howl with pleasure as each one takes his turn knotting you.");
						pc.lust(5 + pc.libido() / 20);
						//BREAK 2
						if (pc.cor() <= 66) {
							output("\nYou blink a few times, the fantasy fading as you master yourself.  That daydream was so strange, yet so hot.");
						}
						else {
							output("  The feeling of all that hot wolf-spooge spilling from your overfilled ass and running down your thighs is heavenly, nearly making you orgasm on the spot.  You see the alpha of the pack is hard again, and his impressive member is throbbing with the need to spend his lust on you.");
							pc.lust(5 + pc.libido() / 20);
							//break3
							if (pc.cor() < 80) {
								output("\nYou reluctantly pry your hand from your aching asshole as you drag yourself out of your fantasy.");
							}
							else {
								output("  You growl with discomfort as he pushes into your abused, wet hole, stretching you tightly, every beat of his heart vibrating through your hindquarters.  With exquisite force, he buries his knot in you and begins filling you with his potent seed, impregnating you for sure. Your knees give out as your fantasy nearly brings you to orgasm, the sudden impact with the ground jarring you from your daydream.");
								pc.lust(5 + pc.libido() / 20);
							}
						}
					}
				}
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && pc.eyeType != GLOBAL.TYPE_HUMAN) {
				//if (pc.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
					//output("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				//}
				//else {
					output("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + pc.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					//if (pc.eyeType == EYES_FOUR_SPIDER_EYES) output("  Your multiple, arachnid eyes are gone!</b>");
					output("  <b>You have normal, humanoid eyes again.</b>");
				//}
				pc.eyeType = GLOBAL.TYPE_HUMAN;
				changes++;
			}
			//Master Furry Appearance Order:
			//Tail -> Ears -> Paws -> Fur -> Face
			//Dog-face requires fur & paws  Should be last morph to take place
			if (rand(5) == 0 && changes < changeLimit &&
					pc.faceType != GLOBAL.TYPE_CANINE && pc.hasFur() &&
					pc.legType == GLOBAL.TYPE_CANINE) {
				output("\n\nYour face is wracked with pain.  You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different.  You find a puddle to view your reflection...<b>your face is now a cross between human and canine features.</b>");
				pc.faceType = GLOBAL.TYPE_CANINE;
				pc.clearFaceFlags();
				pc.addFaceFlag(GLOBAL.FLAG_MUZZLED);
				pc.tongueType = GLOBAL.TYPE_CANINE;
				pc.clearTongueFlags();
				changes++;
			}
			if (type == 3 && (pc.hairColor != "midnight black" || pc.furColor != "midnight black")) {
				if (pc.hasFur()) output("<b>\n\nYour fur and hair tingles, growing in thicker than ever as darkness begins to spread from the roots, turning it midnight black.</b>");
				else output("<b>\n\nYour [pc.skin] itches like crazy as fur grows out from it, coating your body.  It's incredibly dense and black as the middle of a moonless night.</b>");
				pc.skinType = GLOBAL.SKIN_TYPE_FUR;
				pc.hairColor = "midnight black";				
				pc.furColor = pc.hairColor;
			}
			
			//Become furred - requires paws and tail
			if (rand(4) == 0 && changes < changeLimit && pc.legType == GLOBAL.TYPE_CANINE && pc.tailType == GLOBAL.TYPE_CANINE && pc.skinType != GLOBAL.SKIN_TYPE_FUR && Mutator.changeSkin(pc, GLOBAL.SKIN_TYPE_FUR, ["brown", "chocolate", "auburn", "caramel", "orange", "black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white"], [], null, null, true)) changes++;
			
			// canine paw-arms - requires tail and ears
			if (changes < changeLimit && pc.armType != GLOBAL.TYPE_CANINE && pc.hasFur() && rand(4) == 0 && Mutator.changeArms(pc, GLOBAL.TYPE_CANINE, [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS], null, null, true)) changes++;
			
			//Change to paws - requires tail and ears
			if (rand(3) == 0 && pc.legType != GLOBAL.TYPE_CANINE && pc.tailType == GLOBAL.TYPE_CANINE && pc.earType == GLOBAL.TYPE_CANINE && changes < changeLimit) {
				if (pc.hasLegFlag(GLOBAL.FLAG_HOOVES)) output("\n\nYou feel your hooves suddenly splinter, growing into five unique digits.  Their flesh softens as your hooves reshape into furred paws.");
				//Feet -> paws
				else if (!pc.hasLegFlag(GLOBAL.FLAG_PAWS)) output("\n\nYou scream in agony as you feel the bones in your feet break and begin to rearrange. <b>You now have paws</b>.");
				//Hooves -> Paws
				else output("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on fur-covered paws!  <b>You now have dog-like paws</b>.");
				pc.legType = GLOBAL.TYPE_CANINE;
				pc.legCount = 2;
				pc.genitalSpot = 0;
				pc.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_PAWS, GLOBAL.FLAG_FURRED];
				changes++;
			}
			
			//Change to dog-ears!  Requires dog-tail
			if (rand(2) == 0 && pc.earType != GLOBAL.TYPE_CANINE && pc.tailType == GLOBAL.TYPE_CANINE && changes < changeLimit) {
				//if (pc.earType == -1) output("\n\nTwo painful nubs begin sprouting from your head, growing and opening into canine ears.  ");
				if (pc.earType == GLOBAL.TYPE_HUMAN) output("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head.  They shift and elongate, becoming canine in nature.  ");
				else if (pc.earType == GLOBAL.TYPE_EQUINE) output("\n\nYour equine ears twist as they transform into canine versions.  ");
				else output("\n\nYour ears transform, becoming more canine in appearance.  ");
				pc.earType = GLOBAL.TYPE_CANINE;
				output("<b>You now have dog ears.</b>");
				changes++;
			}
			
			//Grow tail if not dog-tailed
			if (rand(3) == 0 && changes < changeLimit && pc.tailType != GLOBAL.TYPE_CANINE) {
				if (!pc.hasTail()) output("\n\nA pressure builds on your backside.  You feel under your clothes and discover an odd bump that seems to be growing larger by the moment.  In seconds it passes between your fingers, bursts out the back of your clothes, and grows most of the way to the ground.  A thick coat of fur springs up to cover your new tail.  ");
				else if (pc.tailType == GLOBAL.TYPE_EQUINE) output("\n\nYou feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur.  ");
				else if (pc.tailType == GLOBAL.TYPE_DEMONIC) output("\n\nThe tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail.  ");
				//Generic message for now
				else output("\n\nYou feel your backside shift and change, flesh molding and displacing into a long puffy tail!  ");
				changes++;
				pc.tailType = GLOBAL.TYPE_CANINE;
				pc.tailCount = 1;
				pc.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FURRED, GLOBAL.FLAG_FLUFFY];
				output("<b>You now have a dog-tail.</b>");
			}
			
			if (changes < changeLimit && rand(3) == 0 && pc.hasVagina() && pc.vaginas[0].type != GLOBAL.TYPE_CANINE) {
				output("\n\nSomething invisible brushes against your sex, making you twinge.  ");
				if (!pc.isCrotchExposed()) output("Undoing your clothes, y");
				else output("Y");
				output("ou take a look at your vagina and find that it has turned into animalistic, canine form.");
				pc.shiftVagina(0, GLOBAL.TYPE_CANINE);
				changes++;
			}
			
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			
			//If no changes yay
			if (changes == 0) {
				output("\n\nInhuman vitality spreads through your body, invigorating you!\n");
				pc.HP(20);
				pc.lust(3);
			}
		}
	}	
}
