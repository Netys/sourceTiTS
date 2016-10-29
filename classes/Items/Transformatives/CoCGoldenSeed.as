package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.Util.*;
	
    public class CoCGoldenSeed extends ItemSlotClass
    {
        public function CoCGoldenSeed(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "GoldSeed";
            //Regular name
            this.longName = "golden seed";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a golden seed";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This seed looks and smells absolutely delicious.  Though it has an unusual color, the harpies prize these nuts as delicious treats.  Eating one might induce some physical transformations.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			useGoldenSeed(pc, false);
			return false;
		}
        
        public static function useGoldenSeed(pc:Creature, enchanted:Boolean):void
        {
			clearOutput();
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (enchanted) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Generic eating text:
			clearOutput();
			output("You pop the nut into your mouth, chewing the delicious treat and swallowing it quickly.  No wonder harpies love these things so much!");
			//****************
			//Stats:
			//****************
			//-Speed increase to 100.
			if (pc.RQ() < 100 && rand(3) == 0) {
				changes++;
				if (pc.RQ() >= 75) output("\n\nA familiar chill runs down your spine. Your muscles feel like well oiled machinery, ready to snap into action with lightning speed.");
				else output("\n\nA chill runs through your spine, leaving you feeling like your reflexes are quicker and your body faster.");
				pc.slowStatGain("r", 1.5);
			}
			//-Toughness decrease to 50
			//if (pc.tou > 50 && rand(3) == 0 && changes < changeLimit) {
				//changes++;
				//if (rand(2) == 0) output("\n\nA nice, slow warmth rolls from your gut out to your limbs, flowing through them before dissipating entirely. As it leaves, you note that your body feels softer and less resilient.", false);
				//else output("\n\nYou feel somewhat lighter, but consequently more fragile.  Perhaps your bones have changed to be more harpy-like in structure?", false);
				//dynStats("tou", -1);
			//}
			
			//-Strength increase to 70
			if (pc.PQ() < 70 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				//(low str)
				if (pc.PQ() < 40) output("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
				//(hi str – 50+)
				else output("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
				pc.slowStatGain("p", 1);
			}
			//-Libido increase to 90
			if ((pc.libido() < 90 || rand(3) == 0) && rand(3) == 0 && changes < changeLimit) {
				changes++;
				if (pc.libido() < 90) pc.slowStatGain("l", 1)
				//(sub 40 lib)
				if (pc.libido() < 40) {
					output("\n\nA passing flush colors your " + pc.face() + " for a second as you daydream about sex. You blink it away, realizing the item seems to have affected your libido.");
					if (pc.hasVagina()) output(" The moistness of your [pc.vagina] seems to agree.");
					else if (pc.hasCock()) output(" The hardness of [pc.eachCock] seems to agree.");
					pc.lust(5);
				}
				//(sub 75 lib)
				else if (pc.libido() < 75) output("\n\nHeat, blessed heat, works through you from head to groin, leaving you to shudder and fantasize about the sex you could be having right now.\n\n");
				//(hi lib)
				else if (pc.libido() < 90) output("\n\nSexual need courses through you, flushing your skin with a reddish hue while you pant and daydream of the wondrous sex you should be having right now.\n\n");
				//(90+)
				else output("\n\nYou groan, something about the seed rubbing your libido in just the right way to make you horny. Panting heavily, you sigh and fantasize about the sex you could be having.\n\n");
				//(fork to fantasy)
				if (pc.libido() >= 40) {
					pc.lust((pc.libido() / 5 + 10));
					//(herm – either or!)
					//Cocks!
					if (pc.hasCock() && (!pc.isHerm() || rand(2) == 0)) {
						//(male 1)
						if (rand(2) == 0) {
							output("In your fantasy you're winging through the sky, [pc.eachCock] already hard and drizzling with male moisture while you circle an attractive harpy's nest. Her plumage is as blue as the sky, her eyes the shining teal of the sea, and legs splayed in a way that shows you how ready she is to be bred. You fold your wings and dive, wind whipping through your [pc.hair] as she grows larger and larger. With a hard, body-slapping impact you land on top of her, plunging your hard, ready maleness into her hungry box. ");
							if (pc.cockTotal() > 1) {
								output("The extra penis");
								if (pc.cockTotal() > 2) output("es rub ");
								else output("rubs ");
								output("the skin over her taut, empty belly, drooling your need atop her.  ");
								output("You jolt from the vision unexpectedly, finding [pc.eachCock] is as hard as it was in the dream. The inside of your [pc.gear] is quite messy from all the pre-cum you've drooled. Perhaps you can find a harpy nearby to lie with.");
							}
						}
						//(male 2)
						else {
							output("In your fantasy you're lying back in the nest your harem built for you, stroking your dick and watching the sexy bird-girl spread her thighs to deposit another egg onto the pile. The lewd moans do nothing to sate your need, and you beckon for another submissive harpy to approach. She does, her thick thighs swaying to show her understanding of your needs. The bird-woman crawls into your lap, sinking down atop your shaft to snuggle it with her molten heat. She begins kissing you, smearing your mouth with her drugged lipstick until you release the first of many loads. You sigh, riding the bliss, secure in the knowledge that this 'wife' won't let up until she's gravid with another egg. Then it'll be her sister-wife's turn. The tightness of [pc.eachCock] inside your [pc.gear] rouses you from the dream, reminding you that you're just standing there, leaking your need into your gear.");
						}
					}
					//Cunts!
					else if (pc.hasVagina()) {
						//(female 1)
						if (rand(2) == 0) {
							output("In your fantasy you're a happy harpy mother, your womb stretched by the sizable egg it contains. The surging hormones in your body arouse you again, and you turn to the father of your children, planting a wet kiss on his slobbering, lipstick-gilt cock. The poor adventurer writhes, hips pumping futilely in the air. He's been much more agreeable since you started keeping his cock coated with your kisses. You mount the needy boy, fantasizing about that first time when you found him near the portal, in the ruins of your old camp. The feeling of your stiff nipples ");
							if (pc.hasFuckableNipples()) output("and pussy leaking over ");
							else if (pc.isLactating()) output("dripping milk inside ");
							else output("rubbing inside ");
							output("your [pc.gear] shocks you from the dream, leaving you with nothing but the moistness of your loins for company. Maybe next year you'll find the mate of your dreams?");
						}
						//(female 2)
						else {
							output("In your fantasy you're sprawled on your back, thick thighs splayed wide while you're taken by a virile male. The poor stud was wandering the desert all alone, following some map, but soon you had his bright red rod sliding between your butt-cheeks, the pointed tip releasing runnels of submission to lubricate your loins. You let him mount your pussy before you grabbed him with your powerful thighs and took off. He panicked at first, but the extra blood flow just made him bigger. He soon forgot his fear and focused on the primal needs of all males – mating with a gorgeous harpy. You look back at him and wink, feeling his knot build inside you. Your aching, tender [pc.nipples] pull you out of the fantasy as they rub inside your [pc.gear]. Maybe once your quest is over you'll be able to find a shy, fertile male to mold into the perfect cum-pump.");
						}
					}
				}
			}
			//****************
			//   Sexual:
			//****************
			//-Grow a cunt (guaranteed if no gender)
			if (!pc.hasGenitals() || (!pc.hasVagina() && changes < changeLimit && rand(3) == 0)) {
				changes++;
				//(balls)
				if (pc.balls > 0) output("\n\nAn itch starts behind your [pc.balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [pc.sack], and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (pc.hasCock()) output("\n\nAn itch starts on your groin, just below your [pc.cocksLight]. You pull your manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else output("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your [pc.gear] to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				pc.createVagina();
				pc.clitLength = .25;
				//dynStats("sen", 10);
				//pc.genderCheck();
			}
			//-Remove extra breast rows
			if (changes < changeLimit && pc.breastRows.length > 1 && rand(3) == 0) {
				changes++;
				output("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + pc.breastDescript(pc.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (pc.breastRows.length >= 3) output("abdomen");
				else output("chest");
				output(". The " + pc.nippleDescript(pc.breastRows.length - 1, true) + " even fade until nothing but [pc.skinFurScales] remains. <b>You've lost a row of breasts!</b>");
				//dynStats("sen", -5);
				pc.removeBreastRow(pc.breastRows.length - 1, 1);
			}
			//-Shrink tits if above DDs.
			//Cannot happen at same time as row removal
			else if (changes < changeLimit && pc.breastRows.length == 1 && rand(3) == 0 && pc.breastRows[0].breastRatingRaw >= 7)
			{
				changes++;
				//(Use standard breast shrinking mechanism if breasts are under 'h')
				if (pc.breastRows[0].breastRatingRaw < 19)
				{
					Mutator.shrinkTits(pc);
				}
				//(H+)
				else {
					pc.breastRows[0].breastRatingRaw -= (4 + rand(4));
					output("\n\nYour chest pinches tight, wobbling dangerously for a second before the huge swell of your bust begins to shrink into itself. The weighty mounds jiggle slightly as they shed cup sizes like old, discarded coats, not stopping until they're " + pc.breastCup(0) + "s.");
				}
			}
			//-Grow tits to a B-cup if below.
			if (changes < changeLimit && pc.breastRows[0].breastRatingRaw < 2 && rand(3) == 0) {
				changes++;
				output("\n\nYour chest starts to tingle, the [pc.skin] warming under your [pc.gear]. Reaching inside to feel the tender flesh, you're quite surprised when it puffs into your fingers, growing larger and larger until it settles into a pair of B-cup breasts.");
				if (pc.breastRows[0].breastRatingRaw < 1) output("  <b>You have breasts now!</b>");
				pc.breastRows[0].breastRatingRaw = 2;
			}
			//Change cock if you have a penis.
			if (changes < changeLimit && pc.hasCock() && pc.cockTotal(GLOBAL.TYPE_AVIAN) < pc.cockTotal() && rand(enchanted ? 4 : 10) == 0 ) { //2.5x chance if magic seed.
				changes++;
				output("\n\nYou feel a strange tingling sensation in your cock as erection forms. You " + (pc.isCrotchExposed() ? "" : "open up your [pc.lowerGarmentOuter] and") + " look down to see " + (pc.cockTotal() == 1 ? "your cock" : "one of your cocks") + " shifting! By the time the transformation's complete, you notice it's tapered, red, and ends in a tip. When you're not aroused, your cock rests nicely in a newly-formed sheath. <b>You now have an avian penis!</b>");
				for (var i:int = 0; i < pc.cocks.length; i++) {
					if (pc.cocks[i].cType != GLOBAL.TYPE_AVIAN) {
						pc.shiftCock(i, GLOBAL.TYPE_AVIAN);
						break;
					}
				}
			}
			//****************
			//General Appearance:
			//****************
			//-Femininity to 85
			if (changes < changeLimit && rand(3) == 0 && Mutator.modFem(pc, 85, 3 + rand(5))) changes++;
			
			//-Skin color change – tan, olive, dark, light
			if (InCollection(pc.skinTone, "tan", "olive", "dark", "light") && changes < changeLimit && rand(5) == 0) {
				changes++;
				output("\n\nIt takes a while for you to notice, but <b>");
				if (pc.skinType == GLOBAL.SKIN_TYPE_FUR || pc.skinType == GLOBAL.SKIN_TYPE_SCALES || pc.skinType == GLOBAL.SKIN_TYPE_FEATHERS) output("the skin under ");
				else output("your [pc.skinFurScales]");
				output(" has changed to become ");
				pc.skinTone = RandomInCollection("tan", "olive", "dark", "light");
				output(pc.skinTone + " colored.</b>");
			}
			//-Grow hips out if narrow.
			if (pc.hipRating() < 10 && changes < changeLimit && rand(3) == 0) {
				output("\n\nYour gait shifts slightly to accommodate your widening [pc.hips]. The change is subtle, but they're definitely broader.");
				pc.hipRating(1);
				changes++;
			}
			//-Narrow hips if crazy wide
			if (pc.hipRating() >= 15 && changes < changeLimit && rand(3) == 0) {
				output("\n\nYour gait shifts inward, your [pc.hips] narrowing significantly. They remain quite thick, but they're not as absurdly wide as before.");
				pc.hipRating(-1);
				changes++;
			}
			//-Big booty
			if (pc.buttRating() < 8 && changes < changeLimit && rand(3) == 0) {
				pc.buttRating(1);
				changes++;
				output("\n\nA slight jiggle works through your rear, but instead of stopping it starts again. You can actually feel your [pc.gear] being filled out by the growing cheeks. When it stops, you find yourself the proud owner of a [pc.ass].");
			}
			//-Narrow booty if crazy huge.
			if (pc.buttRating() >= 14 && changes < changeLimit && rand(4) == 0) {
				changes++;
				pc.buttRating(-1);
				output("\n\nA feeling of tightness starts in your [pc.ass], increasing gradually. The sensation grows and grows, but as it does your center of balance shifts. You reach back to feel yourself, and sure enough your massive booty is shrinking into a more manageable size.");
			}
			//-Body thickness to 25ish
			if (changes < changeLimit && rand(3) == 0 && Mutator.modThickness(pc, 25, 3 + rand(4))) changes++;
			
			//Remove odd eyes
			if (changes < changeLimit && rand(5) == 0 && Mutator.changeEyes(pc, GLOBAL.TYPE_HUMAN)) changes++;
			
			//****************
			//Harpy Appearance:
			//****************
			//-Harpy legs
			if (changes < changeLimit && (enchanted || pc.hasTail(GLOBAL.TYPE_AVIAN)) && rand(4) == 0 && Mutator.changeLegs(pc, GLOBAL.TYPE_AVIAN, 2, [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FEATHERED])) changes++;
			
			//-Feathery Tail
			if (changes < changeLimit && (enchanted || pc.hasWings(GLOBAL.TYPE_AVIAN)) && rand(4) == 0 && Mutator.changeTail(pc, GLOBAL.TYPE_AVIAN, 1, [GLOBAL.FLAG_FEATHERED])) changes++;
			
			//-Propah Wings
			if (changes < changeLimit && (enchanted || pc.armType == GLOBAL.TYPE_AVIAN) && rand(4) == 0 && Mutator.changeWings(pc, GLOBAL.TYPE_AVIAN, 2)) changes++;
			
			//-Feathery Arms
			if (changes < changeLimit && (enchanted || pc.hairType == GLOBAL.HAIR_TYPE_FEATHERS) && rand(4) == 0 && Mutator.changeArms(pc, GLOBAL.TYPE_AVIAN, [GLOBAL.FLAG_FEATHERED])) changes++;
			
			//-Feathery Hair
			if (changes < changeLimit && (enchanted || pc.faceType == GLOBAL.TYPE_HUMAN) && rand(2) == 0 && Mutator.changeHair(pc, GLOBAL.HAIR_TYPE_FEATHERS)) changes++;
			
			//-Human face
			if (changes < changeLimit && (enchanted || (pc.earType == GLOBAL.TYPE_HUMAN || pc.earType == GLOBAL.TYPE_SYLVAN)) && rand(4) == 0 && Mutator.changeFace(pc, GLOBAL.TYPE_HUMAN)) changes++;
			
			//-Gain human ears (keep elf ears)
			if ((pc.earType != GLOBAL.TYPE_HUMAN && pc.earType != GLOBAL.TYPE_SYLVAN) && changes < changeLimit && rand(4) == 0 && Mutator.changeEars(pc, GLOBAL.TYPE_HUMAN)) changes++;
			
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.", false);
				pc.gills = false;
				changes++;
			}
			
			//SPECIAL:
			//Harpy Womb – All eggs are automatically upgraded to large, requires legs + tail to be harpy.
			if (!pc.hasPerk("Harpy Womb") && pc.legType == GLOBAL.TYPE_AVIAN && pc.hasTail(GLOBAL.TYPE_AVIAN) && rand(4) == 0 && changes < changeLimit) {
				pc.createPerk("Harpy Womb", 0, 0, 0, 0, "Increases all laid eggs to large size so long as you have harpy legs and a harpy tail.");
				output("\n\nThere's a rumbling in your womb, signifying that some strange change has taken place in your most feminine area. No doubt something in it has changed to be more like a harpy. (<b>You've gained the Harpy Womb perk! All the eggs you lay will always be large so long as you have harpy legs and a harpy tail.</b>)");
				changes++;
			}
			
			if (changes < changeLimit && rand(4) == 0 && (pc.ass.wetness() > 1 && pc.analWetnessUnlocked(pc.ass.wetness() - 1) || pc.ass.looseness() > 1)) {
				output("\n\nYou feel a tightening up in your colon and your [pc.asshole] sucks into itself.  You feel sharp pain at first but that thankfully fades. Your ass seems to have dried and tightened up.");
				if (pc.ass.wetness() > 1 && pc.analWetnessUnlocked(pc.ass.wetness() - 1)) pc.ass.wetness( -1);
				if (pc.ass.looseness() > 1) pc.ass.looseness(-1);
				changes++;
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && pc.hasVagina() && pc.vaginas[0].type != GLOBAL.TYPE_HUMAN) {
				pc.shiftVagina(0, GLOBAL.TYPE_HUMAN);
				output("\n\nSomething invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your [pc.vagina] and find that it has turned into totally human-like one.");
				changes++;
			}
			
			if (changes == 0) output("\n\nAside from being a tasty treat, it doesn't seem to do anything to you this time.");
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return;
		}
	}	
}
