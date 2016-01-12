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
	
    public class CoCKangaFruit extends ItemSlotClass
    {
        public function CoCKangaFruit(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "KangaFruit";
            //Regular name
            this.longName = "piece of kanga fruit";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a piece of kanga fruit";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A yellow, fibrous, tubular pod.  A split in the end reveals many lumpy, small seeds inside.  The smell of mild fermentation wafts from them.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			useKangaFruit(pc, false);
			return false;
		}
        
        public static function useKangaFruit(pc:Creature, enchanted:Boolean):void
        {
			clearOutput();
			output("You squeeze the pod around the middle, forcing the end open.  Scooping out a handful of the yeasty-smelling seeds, you shovel them in your mouth.  Blech!  Tastes like soggy burnt bread... and yet, you find yourself going for another handful...");
			//Used to track changes and the max
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (enchanted) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Used as a holding variable for biggest dicks and the like
			var biggestCock:Number;
			//****************
			//General Effects:
			//****************
			//-Int less than 10
			if (pc.IQ() < 10 && !pc.hasPerk("Transformation Resistance")) {
				if (pc.IQ() < 8 && pc.kangaScore() >= 5) {
					output("\n\nWhile you gnaw on the fibrous fruit, your already vacant mind continues to empty, leaving nothing behind but the motion of your jaw as you slowly chew and swallow your favorite food.  Swallow.  Chew.  Swallow.  You don't even notice your posture worsening or your arms shortening.  Without a single thought, you start to hunch over but keep munching on the food in your paws as if were the most normal thing in the world.  Teeth sink into one of your fingers, leaving you to yelp in pain.  With the last of your senses, you look at your throbbing paw to notice you've run out of kanga fruit!");
					output("\n\nStill hungry and licking your lips in anticipation, you sniff in deep lungfuls of air.  There's more of that wonderful fruit nearby!  You bound off in search of it on your incredibly muscular legs, their shape becoming more and more feral with every hop.  Now guided completely by instinct, you find a few stalks that grow from the ground.  Your belly rumbles, reminding you of your hunger, as you begin to dig into the kanga fruits...");
					output("\n\nLosing more of what little remains of yourself, your body is now entirely that of a feral kangaroo and your mind has devolved to match it.  After you finish the handful of fruits you found, you move on in search for more of the tasty treats.  Though you pass by your camp later on, there's no memory, no recognition, just a slight feeling of comfort and familiarity.  There's no food here so you hop away.");
					//[GAME OVER]
					kGAMECLASS.badEnd();
					return;
				}
				output("\n\nWhile chewing, your mind becomes more and more tranquil.  You find it hard to even remember your mission, let alone your name.  <b>Maybe more kanga fruits will help?</b>");
			}
			//-Speed to 70
			if (pc.RQ() < 70 && rand(3) == 0) {
				//2 points up if below 40!
				pc.slowStatGain("r", 2);
				output("\n\nYour legs fill with energy as you eat the kanga fruit.  You feel like you could set a long-jump record!  You give a few experimental bounds, both standing and running, with your newfound vigor.  Your stride seems longer too; you even catch a bit of air as you push off with every powerful step.");
				changes++;
			}
			//-Int to 10
			if (pc.intelligence() > 2 && rand(3) == 0 && changes < changeLimit) {
				changes++;
				//Gain dumb (smart!)
				if (pc.IQ() > 30) output("\n\nYou feel... antsy. You momentarily forget your other concerns as you look around you, trying to decide which direction you'd be most likely to find more food in.  You're about to set out on the search when your mind refocuses and you realize you already have some stored at camp.");
				//gain dumb (30-10 int):
				else if (pc.IQ() > 10) output("\n\nYour mind wanders as you eat; you think of what it would be like to run forever, bounding across the wastes of Mareth in the simple joy of movement.  You bring the kanga fruit to your mouth one last time, only to realize there's nothing edible left on it.  The thought brings you back to yourself with a start.");
				//gain dumb (10-1 int):
				else output("\n\nYou lose track of everything as you eat, staring at the bugs crawling across the ground.  After a while you notice the dull taste of saliva in your mouth and realize you've been sitting there, chewing the same mouthful for five minutes.  You vacantly swallow and take another bite, then go back to staring at the ground.  Was there anything else to do today?");
				pc.slowStatGain("i", -1)
			}
			//****************
			//Appearance Effects:
			//****************
			//-Hip widening funtimes
			if (changes < changeLimit && rand(4) == 0 && pc.hipRating() < 40) {
				output("\n\nYou weeble and wobble as your hipbones broaden noticeably, but somehow you don't fall down.  Actually, you feel a bit MORE stable on your new widened stance, if anything.");
				pc.hipRating(1);
				changes++;
			}
			
			if (pc.hasFur() && changes < changeLimit && rand(4) == 0 && Mutator.changeArms(pc, GLOBAL.TYPE_KANGAROO, [GLOBAL.FLAG_FURRED])) changes++;
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeHair(pc, GLOBAL.HAIR_TYPE_REGULAR)) changes++;
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeEyes(pc, GLOBAL.TYPE_HUMAN)) changes++;

			//****************
			//Sexual:
			//****************
			//-Shrink balls down to reasonable size (3?)
			if (pc.ballSizeRaw >= 4 && changes < changeLimit && rand(2) == 0) {
				pc.ballSizeRaw--;
				pc.cumMultiplierRaw++;
				output("\n\nYour [pc.sack] pulls tight against your groin, vibrating slightly as it changes.  Once it finishes, you give your [pc.balls] a gentle squeeze and discover they've shrunk.  Even with the reduced volume, they feel just as heavy.");
				changes++;
			}
			//-Shorten clits to reasonable size
			if (pc.clitLength >= 4 && changes < changeLimit && rand(5) == 0) {
				output("\n\nPainful pricks work through your [pc.clit], all the way into its swollen clitoral sheath.  Gods, it feels afire with pain!  Agony runs up and down its length, and by the time the pain finally fades, the feminine organ has lost half its size.", false);
				pc.clitLength /= 2;
				changes++;
			}
			//Find biggest dick!
			biggestCock = pc.biggestCockIndex();
			//-Shrink dicks down to 8\" max.
			if (pc.hasCock()) {
				if (pc.cocks[biggestCock].cLength() >= 16 && changes < changeLimit && rand(5) == 0) {
					output("\n\nA roiling inferno of heat blazes in your [pc.cock " + biggestCock + "], doubling you over in the dirt.  You rock back and forth while tears run unchecked down your cheeks.  Once the pain subsides and you're able to move again, you find the poor member has lost nearly half its size.");
					pc.cocks[biggestCock].cLength(pc.cocks[biggestCock].cLength() / 2, true);
					changes++;
				}
				//COCK TF!
				if (pc.cockTotal(GLOBAL.TYPE_KANGAROO) < pc.cockTotal() && (enchanted && rand(2) == 0) && changes < changeLimit) {
					output("\n\nYou feel a sharp pinch at the end of your penis and whip down your clothes to check.  Before your eyes, the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into ", false);
					if (pc.hasSheath()) output("your sheath", false);
					else output("a sheath that forms at the base of it", false);
					output(".  <b>You now have a kangaroo-penis!</b>", false);
					var cockIdx:int = 0;
					//Find first non-roocock!
					while (cockIdx < pc.cockTotal()) {
						if (pc.cocks[cockIdx].cType != GLOBAL.TYPE_KANGAROO) {
							pc.shiftCock(cockIdx, GLOBAL.TYPE_KANGAROO);
							break;
						}
						cockIdx++;
					}
					changes++;
				}
			}
			//****************
			//Big Kanga Morphs
			//type 1 ignores normal restrictions
			//****************
			//-Face (Req: Fur + Feet)
			if ((pc.hasFur() && pc.legType == GLOBAL.TYPE_KANGAROO || enchanted) && changes < changeLimit && rand(4) == 0 && Mutator.changeFace(pc, GLOBAL.TYPE_KANGAROO, [GLOBAL.FLAG_LONG, GLOBAL.FLAG_MUZZLED])) changes++;
			
			//-Fur (Req: Footsies)
			if (!pc.hasFur() && (pc.legType == GLOBAL.TYPE_KANGAROO || enchanted) && changes < changeLimit && rand(4) == 0 && Mutator.changeSkin(pc, GLOBAL.SKIN_TYPE_FUR, ["brown"], [])) changes++;
			
			//-Roo footsies (Req: Tail)
			if (pc.legType != GLOBAL.TYPE_KANGAROO && (enchanted || pc.hasTail(GLOBAL.TYPE_KANGAROO)) && changes < changeLimit && rand(4) == 0 && Mutator.changeLegs(pc, GLOBAL.TYPE_KANGAROO, 2, [GLOBAL.FLAG_PAWS, GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FURRED])) changes++;
			
			//-Roo tail (Req: Ears)
			if (!pc.hasTail(GLOBAL.TYPE_KANGAROO) && changes < changeLimit && rand(4) == 0 && (enchanted || pc.earType == GLOBAL.TYPE_KANGAROO) && Mutator.changeTail(pc, GLOBAL.TYPE_KANGAROO, 1, [GLOBAL.FLAG_LONG, GLOBAL.FLAG_THICK])) changes++;
			
			//-Roo ears
			if (pc.earType != GLOBAL.TYPE_KANGAROO && changes < changeLimit && rand(4) == 0 && Mutator.changeEars(pc, GLOBAL.TYPE_KANGAROO)) changes++;
			
			////UBEROOOO
			////kangaroo perk: - any liquid or food intake will accelerate a pregnancy, but it will not progress otherwise
			//if (pc.findPerk(PerkLib.Diapause) < 0 && pc.kangaScore() > 4 && rand(4) == 0 && changes < changeLimit && pc.hasVagina()) {
				////Perk name and description:
				//pc.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
				//output("\n\nYour womb rumbles as something inside it changes.\n<b>(You have gained the Diapause perk.  Pregnancies will not progress when fluid intake is scarce, and will progress much faster when it isn't.)", false);
				//changes++;
				////trigger effect: Your body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.
			//}
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			if (changes == 0) {
				output("\n\nIt did not seem to have any effects, but you do feel better rested.");
				pc.energy(40);
			}
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return;
		}
	}	
}
