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
	
    public class CoCFoxBerry extends ItemSlotClass
    {
        public function CoCFoxBerry(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "FoxBerry";
            //Regular name
            this.longName = "Fox Berry";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a fox berry";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This large orange berry is heavy in your hands.  It may have gotten its name from its bright orange coloration.  You're certain it is no mere fruit.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 100;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			FoxBerry(false, pc);
			return false;
		}
		
		public static function FoxBerry(enhanced:Boolean,pc:Creature):void
		{
			clearOutput();
			if (!enhanced) output("You examine the berry a bit, rolling the orangish-red fruit in your hand for a moment before you decide to take the plunge and chow down.  It's tart and sweet at the same time, and the flavors seem to burst across your tongue with potent strength.  Juice runs from the corners of your lips as you finish the tasty snack.");
			else output("You pop the cap on the enhanced \"Vixen's Vigor\" and decide to take a swig of it.  Perhaps it will make you as cunning as the crude fox Lumi drew on the front?");
			var temp:Number = 0;
			var changes:int = 0;
			var changeLimit:int = 1;
			if (enhanced) changeLimit += 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Used for dick and boob TFs
			var counter:int = 0;

			if (pc.faceType == GLOBAL.TYPE_VULPINE && pc.hasTail(GLOBAL.TYPE_VULPINE) && pc.tailCount < 9 && pc.earType == GLOBAL.TYPE_VULPINE && pc.legType == GLOBAL.TYPE_VULPINE && pc.armType == GLOBAL.TYPE_VULPINE && pc.hasFur() && rand(3) == 0 && !pc.hasPerk("Transformation Resistance")) {
				if (kGAMECLASS.flags["COC.FOX_BAD_END_WARNING"] == undefined) {
					kGAMECLASS.output("\n\nYou get a massive headache and a craving to raid a henhouse.  Thankfully, both pass in seconds, but <b>maybe you should cut back on the vulpine items...</b>");
					kGAMECLASS.flags["COC.FOX_BAD_END_WARNING"] = 1;
				}
				else {
					output("\n\nYou scarf down the ");
					if (enhanced) output("fluid ");
					else output("berries ");
					output("with an uncommonly voracious appetite, taking particular enjoyment in the succulent, tart flavor.  As you carefully suck the last drops of ochre juice from your fingers, you note that it tastes so much more vibrant than you remember.  Your train of thought is violently interrupted by the sound of bones snapping, and you cry out in pain, doubling over as a flaming heat boils through your ribs.");
					output("\n\nWrithing on the ground, you clutch your hand to your chest, looking on in horror through tear-streaked eyes as the bones in your fingers pop and fuse, rearranging themselves into a dainty paw covered in coarse black fur, fading to a ruddy orange further up.  You desperately try to call out to someone - anyone - for help, but all that comes out is a high-pitched, ear-splitting yap.");
					if (pc.tailVenom > 1) output("  Your tails thrash around violently as they begin to fuse painfully back into one, the fur bristling back out with a flourish.");
					output("\n\nA sharp spark of pain jolts through your spinal column as the bones shift themselves around, the joints in your hips migrating forward.  You continue to howl in agony even as you feel your intelligence slipping away.  In a way, it's a blessing - as your thoughts grow muddied, the pain is dulled, until you are finally left staring blankly at the sky above, tilting your head curiously.");
					output("\n\nYou roll over and crawl free of the [pc.gear] covering you, pawing the ground for a few moments before a pang of hunger rumbles through your stomach.  Sniffing the wind, you bound off into the wilderness, following the telltale scent of a farm toward the certain bounty of a chicken coop.");
					kGAMECLASS.badEnd();
					return;
				}
			}
			//[increase Intelligence, Libido and Sensitivity]
			if (changes < changeLimit && rand(3) == 0 && (pc.libido() < 80 || pc.IQ() < 80 || pc.WQ() < 80/* || pc.sens < 80*/)) {
				output("\n\nYou close your eyes, smirking to yourself mischievously as you suddenly think of several new tricks to try on your opponents; you feel quite a bit more cunning.  The mental picture of them helpless before your cleverness makes you shudder a bit, and you lick your lips and stroke yourself as you feel your skin tingling from an involuntary arousal.");
				if (pc.IQ() < 80) pc.slowStatGain("i", 2);
				if (pc.WQ() < 80) pc.slowStatGain("w", 1);
				if (pc.libido() < 80) pc.slowStatGain("l", 1);
				//if (pc.sens < 80) dynStats("sen", 1);
				//gain small lust also
				pc.lust(10);
				changes++;
			}
			//[decrease Strength] (to some floor) // I figured 15 was fair, but you're in a better position to judge that than I am.
			if (changes < changeLimit && rand(3) == 0 && pc.PQ() > 40) {
				output("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can outwit your foes with trickery and mischief?  You tilt your head a bit, wondering where that thought came from.");
				pc.physique( -0.5);
				if (pc.PQ() > 60) pc.physique( -0.5);
				if (pc.PQ() > 80) pc.physique( -0.5);
				if (pc.PQ() > 90) pc.physique( -0.5);
				changes++;
			}
			////[decrease Toughness] (to some floor) // 20 or so was my thought here
			//if (changes < changeLimit && rand(3) == 0 && pc.tou > 30) {
				//if (pc.tou < 60) output("\n\nYou feel your skin becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your supple skin isn't going to offer you much protection.");
				//else output("\n\nYou feel your skin becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your hide isn't quite as tough as it used to be.");
				//dynStats("tou", -1);
				//if (pc.tou > 60) dynStats("tou", -1);
				//if (pc.tou > 80) dynStats("tou", -1);
				//if (pc.tou > 90) dynStats("tou", -1);
				//changes++;
			//}

			//[Change Hair Color: Golden-blonde or Reddish-orange]
			var fox_hair:Array = ["golden blonde", "reddish-orange", "silver", "white", "red", "black"];
			if (!InCollection(pc.hairColor, fox_hair) && !InCollection(pc.hairColor, kGAMECLASS.basicKitsuneHair, kGAMECLASS.elderKitsuneColors, kGAMECLASS.corruptKitsuneColors) && changes < changeLimit && rand(4) == 0) {
				if (pc.hasTail(GLOBAL.TYPE_VULPINE) && pc.tailCount > 1)
					if(pc.tailVenom < 9) pc.hairColor = RandomInCollection(kGAMECLASS.basicKitsuneHair);
					else pc.hairColor = pc.hasPerk("Enlightened Nine-tails") ? RandomInCollection(kGAMECLASS.elderKitsuneColors) : RandomInCollection(kGAMECLASS.corruptKitsuneColors);
				else pc.hairColor = RandomInCollection(fox_hair);
				output("\n\nYour scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become " + pc.hairColor + "!");
			}
			//[Adjust hips toward 10 – wide/curvy/flared]
			if (changes < changeLimit && rand(3) == 0 && pc.hipRating() != 10) {
				//from narrow to wide
				if (pc.hipRating() < 10) {
					output("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has widened into [pc.hips]!");
					pc.hipRating(1);
					if (pc.hipRating() < 7) pc.hipRating(1);
				}
				//from wide to narrower
				else {
					output("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has narrowed, becoming [pc.hips].");
					pc.hipRating( -1);
					if (pc.hipRating() > 15) pc.hipRating( -1);
				}
				changes++;
			}
			//[Remove tentacle hair]
			//required if the hair length change below is triggered
			if (changes < changeLimit && pc.hairType != GLOBAL.HAIR_TYPE_REGULAR && rand(3) == 0) {
				//-insert anemone hair removal into them under whatever criteria you like, though hair removal should precede abdomen growth; here's some sample text:
				output("\n\nEerie flames of the jewel migrate up your body to your head, where they cover your [pc.hair].  Though they burned nowhere else in their lazy orbit, your head begins to heat up as they congregate.  Fearful, you raise your hands to it just as the temperature peaks, but as you touch your hair, the searing heat is suddenly gone - along with your inhuman hair!  <b>Your hair is normal again!</b>");
				pc.hairType = GLOBAL.HAIR_TYPE_REGULAR;
				changes++;
			}
			//[Adjust hair length toward range of 16-26 – very long to ass-length]
			if (pc.hairType == GLOBAL.HAIR_TYPE_REGULAR && (pc.hairLength < 18 || pc.hairLength > pc.tallness / 1.4) && changes < changeLimit && rand(4) == 0) {
				//from short to long
				if (pc.hairLength < 18) {
					pc.hairLength += 3 + rand(3);
					output("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has lengthened, becoming " + pc.hairDescript(true) + ".");
				}
				//from long to short
				else {
					pc.hairLength -= 3 + rand(3);
					output("\n\nYou experience a tingling sensation in your scalp.  Feeling a bit off-balance, you discover your hair has shed a bit of its length, becoming " + pc.hairDescript(true) + ".");
				}
				changes++;
			}
			
			if (changes < changeLimit && rand(10) == 0 && pc.foxScore() > 5 && pc.energy() >= 10) {
				output("\n\nYou sigh as the exotic flavor washes through you, and unbidden, you begin to daydream.  Sprinting through the thicket, you can feel the corners of your muzzle curling up into a mischievous grin.  You smell the scent of demons, and not far away either.  With your belly full and throat watered, now is the perfect time for a little bit of trickery.   As the odor intensifies, you slow your playful gait and begin to creep a bit more carefully.");
				output("\n\nSuddenly, you are there, at a demonic camp, and you spy the forms of an incubus and a succubus, their bodies locked together at the hips and slowly undulating, even in sleep.  You carefully prance around their slumbering forms and find their supplies.  With the utmost care, you put your razor-sharp teeth to work, and slowly, meticulously rip through their packs - not with the intention of theft, but with mischief.  You make sure to leave small holes in the bottom of each, and after making sure your stealth remains unbroken, you urinate on their hooves.");
				output("\n\nThey don't even notice, so lost in the subconscious copulation as they are.  Satisfied at your petty tricks, you scurry off into the night, a red blur amidst the foliage.");
				changes++;
				pc.energy( -10);
			}

			//dog cocks!
			if (changes < changeLimit && rand(3) == 0 && pc.cockTotal(GLOBAL.TYPE_VULPINE) < pc.cocks.length) {
				var choices:Array = [];
				counter = pc.cockTotal();
				while (counter > 0) {
					counter--;
					//Add non-dog locations to the array
					if (pc.cocks[counter].cType != GLOBAL.TYPE_VULPINE) choices[choices.length] = counter;
				}
				if (choices.length != 0) {
					var select:int = choices[rand(choices.length)];
					
					output("\n\nYour [pc.cock " + select + "] clenches painfully, becoming achingly, throbbingly erect.  ");
					if (!pc.cocks[select].hasFlag(GLOBAL.FLAG_SHEATHED))
						output("A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath.  ");
					if (!pc.cocks[select].hasFlag(GLOBAL.FLAG_TAPERED))
						output("You shudder as the crown of your [pc.cock " + select + "] reshapes into a point, the sensations nearly too much for you.  ");
					pc.shiftCock(select, GLOBAL.TYPE_VULPINE);
					output("You throw back your head as the transformation completes.  <b>You now have animalistic fox-cock.</b>");

					pc.lust(5);
					changes++;
				}

			}
			//Cum Multiplier Xform
			if (pc.cumQ() < 5000 && rand(3) == 0 && changes < changeLimit && pc.hasCock()) {
				temp = 2 + rand(4);
				//Lots of cum raises cum multiplier cap to 2 instead of 1.5
				//if (pc.findPerk(PerkLib.MessyOrgasms) >= 0) temp += rand(10);
				pc.cumMultiplierRaw += temp;
				//Flavor text
				if (pc.balls == 0) output("\n\nYou feel a churning inside your gut as something inside you changes.");
				if (pc.balls > 0) output("\n\nYou feel a churning in your [pc.balls].  It quickly settles, leaving them feeling somewhat more dense.");
				output("  A bit of pre dribbles from your [pc.cocksLight], pushed out by the change.");
				changes++;
			}
			if (changes < changeLimit && pc.balls > 0 && pc.ballSizeRaw > 3 * Math.PI && rand(3) == 0) {
				output("\n\nYour [pc.sack] gets lighter and lighter, the skin pulling tight around your shrinking balls until you can't help but check yourself.");
				if (pc.ballSizeRaw > 10) pc.ballSizeRaw -= 5;
				if (pc.ballSizeRaw > 20) pc.ballSizeRaw -= 4;
				if (pc.ballSizeRaw > 30) pc.ballSizeRaw -= 4;
				if (pc.ballSizeRaw > 40) pc.ballSizeRaw -= 4;
				if (pc.ballSizeRaw > 50) pc.ballSizeRaw -= 8;
				if (pc.ballSizeRaw > 60) pc.ballSizeRaw -= 8;
				if (pc.ballSizeRaw > 2 * Math.PI) pc.ballSizeRaw--;
				changes++;
				output("  You now have a [pc.balls].");
			}
			//Sprouting more!
			if (changes < changeLimit && enhanced && pc.bRows() < 4 && pc.breastRows[pc.bRows() - 1].breastRatingRaw > 1) {
				output("\n\nYour belly rumbles unpleasantly for a second as the ");
				if (!enhanced) output("berry ");
				else output("drink ");
				output("settles deeper inside you.  A second later, the unpleasant gut-gurgle passes, and you let out a tiny burp of relief.  Before you finish taking a few breaths, there's an itching below your " + pc.allChestDesc() + ".  You idly scratch at it, but gods be damned, it hurts!  You peel off part of your [pc.gear] to inspect the unwholesome itch, ");
				if (pc.biggestTitSize() >= 8) output("it's difficult to see past the wall of tits obscuring your view.");
				else output("it's hard to get a good look at.");
				output("  A few gentle prods draw a pleasant gasp from your lips, and you realize that you didn't have an itch - you were growing new nipples!");
				output("\n\nA closer examination reveals your new nipples to be just like the ones above in size and shape");
				if (pc.nipplesPerBreast > 1) output(", not to mention number");
				else if (pc.hasFuckableNipples()) output(", not to mention penetrability");
				output(".  While you continue to explore your body's newest addition, a strange heat builds behind the new nubs. Soft, jiggly breastflesh begins to fill your cupped hands.  Radiant warmth spreads through you, eliciting a moan of pleasure from your lips as your new breasts catch up to the pair above.  They stop at " + pc.breastCup(pc.bRows() - 1) + "s.  <b>You have " + num2Text(pc.bRows() + 1) + " rows of breasts!</b>");
				pc.createBreastRow();
				pc.breastRows[pc.bRows() - 1].breastRatingRaw = pc.breastRows[pc.bRows() - 2].breastRatingRaw;
				pc.breastRows[pc.bRows() - 1].nippleType = pc.breastRows[pc.bRows() - 2].nippleType;
				//dynStats("sen", 2, "lus", 30);
				pc.lust(30);
				changes++;
			}
			//Find out if tits are eligible for evening
			var tits:Boolean = false;
			counter = pc.bRows();
			while (counter > 1) {
				counter--;
				//If the row above is 1 size above, can be grown!
				if (pc.breastRows[counter].breastRatingRaw <= (pc.breastRows[counter - 1].breastRatingRaw - 1) && changes < changeLimit && rand(2) == 0) {
					if (tits) output("\n\nThey aren't the only pair to go through a change!  Another row of growing bosom goes through the process with its sisters, getting larger.");
					else {
						var select2:Number = rand(3);
						if (select2 == 1) output("\n\nA faint warmth buzzes to the surface of your " + pc.breastDescript(counter) + ", the fluttering tingles seeming to vibrate faster and faster just underneath your " + pc.skin() + ".  Soon, the heat becomes uncomfortable, and that row of chest-flesh begins to feel tight, almost thrumming like a newly-stretched drum.  You " + pc.nippleDescript(counter) + "s go rock hard, and though the discomforting feeling of being stretched fades, the pleasant, warm buzz remains.  It isn't until you cup your tingly tits that you realize they've grown larger, almost in envy of the pair above.");
						else if (select2 == 2) output("\n\nA faintly muffled gurgle emanates from your " + pc.breastDescript(counter) + " for a split-second, just before your flesh shudders and shakes, stretching your " + pc.skinFurScales() + " outward with newly grown breast.  Idly, you cup your hands to your swelling bosom, and though it stops soon, you realize that your breasts have grown closer in size to the pair above.");
						else {
							output("\n\nAn uncomfortable stretching sensation spreads its way across the curves of your " + pc.breastDescript(counter) + ", threads of heat tingling through your flesh.  It feels as though your heartbeat has been magnified tenfold within the expanding mounds, your " + pc.skin() + " growing flushed with arousal and your " + pc.nippleDescript(counter) + " filling with warmth.  As the tingling heat gradually fades, a few more inches worth of jiggling breast spill forth.  Cupping them experimentally, you confirm that they have indeed grown to be a bit more in line with the size of the pair above.")
						}
					}
					//Bigger change!
					if (pc.breastRows[counter].breastRatingRaw <= (pc.breastRows[counter - 1].breastRatingRaw - 3))
						pc.breastRows[counter].breastRatingRaw += 2 + rand(2);
					//Smallish change.
					else pc.breastRows[counter].breastRatingRaw++;
					output("  You do a quick measurement and determine that your " + num2Ordinal(counter + 1) + " row of breasts are now " + pc.breastCup(counter) + "s.");

					if (!tits) {
						tits = true;
						changes++;
					}
					//dynStats("sen", 2, "lus", 10);
					pc.lust(10);
				}
			}
			//HEAT! If heat libido bonus is below 30.
			if (pc.statusEffectv2("Heat") < 30 && rand(6) == 0 && changes < changeLimit) {
				if(Mutator.goIntoHeat(pc, true)) {
						changes++;
				}
			}
			//[Grow Fur]
			//FOURTH
			if ((enhanced || pc.legType == GLOBAL.TYPE_VULPINE) && pc.skinType != GLOBAL.SKIN_TYPE_FUR && changes < changeLimit && rand(4) == 0) {
				//from scales
				if (pc.skinType == GLOBAL.SKIN_TYPE_SCALES) output("\n\nYour skin shifts and every scale stands on end, sending you into a mild panic.  No matter how you tense, you can't seem to flatten them again.  The uncomfortable sensation continues for some minutes until, as one, every scale falls from your body and a fine coat of fur pushes out.  You briefly consider collecting them, but when you pick one up, it's already as dry and brittle as if it were hundreds of years old.  <b>Oh well; at least you won't need to sun yourself as much with your new fur.</b>");
				//from skin
				else output("\n\nYour [pc.skinFurScales] itches all over, the sudden intensity and uniformity making you too paranoid to scratch.  As you hold still through an agony of tiny tingles and pinches, fine, luxuriant fur sprouts from every bare inch of your skin!  <b>You'll have to get used to being furry...</b>");
				pc.skinType = GLOBAL.SKIN_TYPE_FUR;
				
				if (pc.kitsuneScore() >= 4)
					if(InCollection(pc.hairColor, kGAMECLASS.basicKitsuneFur, kGAMECLASS.elderKitsuneColors, kGAMECLASS.corruptKitsuneColors))
						pc.furColor = pc.hairColor;
					else
						if (pc.hasPerk("Enlightened Nine-tails")) pc.furColor = RandomInCollection(kGAMECLASS.elderKitsuneColors);
						else if (pc.hasPerk("Corrupted Nine-tails")) pc.furColor = RandomInCollection(kGAMECLASS.corruptKitsuneColors);
						else pc.furColor = RandomInCollection(kGAMECLASS.basicKitsuneFur);
				else
					pc.furColor = RandomInCollection("orange and white", "orange and white", "orange and white", "red and white", "black and white", "white", "tan", "brown");
					
				changes++;
			}
			if ((enhanced || pc.earType == GLOBAL.TYPE_VULPINE) && changes < changeLimit && rand(5) == 0 && Mutator.changeArms(pc, GLOBAL.TYPE_VULPINE, [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS])) changes++;
			//[Grow Fox Legs]
			//THIRD
			if ((enhanced || pc.earType == GLOBAL.TYPE_VULPINE) && pc.legType != GLOBAL.TYPE_VULPINE && changes < changeLimit && rand(5) == 0) {
				//n*ga please
				if (pc.isNaga()) output("\n\nYour scales split at the waistline and begin to peel, shedding like old snakeskin.  If that weren't curious enough, the flesh - not scales - underneath is pink and new, and the legs it covers crooked into the hocks and elongated feet of a field animal.  As the scaly coating falls and you step out of it, walking of necessity on your toes, a fine powder blows from the dry skin.  Within minutes, it crumbles completely and is taken by the ever-moving wind.  <b>Your legs are now those of a fox!</b>");
				//red drider bb gone
				else if (pc.isDrider()) output("\n\nYour legs buckle under you and you fall, smashing your abdomen on the ground.  Though your control deserts and you cannot see behind you, still you feel the disgusting sensation of chitin loosening and sloughing off your body, and the dry breeze on your exposed nerves.  Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible.  When you try to part them, you find you cannot.  Several minutes pass uncomforably until you can again bend your legs, and when you do, you find that all the legs of a side bend together - <b>in the shape of a fox's leg!</b>");
				//goo home and goo to bed
				else if (pc.isGoo()) output("\n\nIt takes a while before you notice that your gooey mounds have something more defined in them.  As you crane your body and shift them around to look, you can just make out a semi-solid mass in the shape of a crooked, animalistic leg.  You don't think much of it until, a few minutes later, you step right out of your swishing gooey undercarriage and onto the new foot.  The goo covering it quickly dries up, as does the part you left behind, <b>revealing a pair of dog-like fox legs!</b>");
				else
				{
				//4 legs good, 2 legs better
					if (pc.isTaur()) output("\n\nYou shiver as the strength drains from your back legs.  Shaken, you sit on your haunches, forelegs braced wide to stop you from tipping over;  their hooves scrape the dirt as your lower body shrinks, dragging them backward until you can feel the upper surfaces of your hindlegs with their undersides.  A wave of nausea and vertigo overtakes you, and you close your eyes to shut out the sensations.  When they reopen, what greets them are not four legs, but only two...");
					//other digitigrade
					if (pc.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE))
						output("\n\nYour legs twitch and quiver, forcing you to your seat.  As you watch, the ends shape themselves into furry, padded toes.  <b>You now have fox feet!</b>  Rather cute ones, actually.");
					//reg legs, not digitigrade
					else {
						output("\n\nYour hamstrings tense painfully and begin to pull, sending you onto your face.  As you writhe on the ground, you can feel your thighs shortening and your feet stretching");
						if (pc.hasLegFlag(GLOBAL.FLAG_CHITINOUS)) output(", while a hideous cracking fills the air");
						output(".  When the spasms subside and you can once again stand, <b>you find that your legs have been changed to those of a fox!</b>");
					}
				}
				pc.legType = GLOBAL.TYPE_VULPINE;
				pc.legCount = 2;
				pc.genitalSpot = 0;
				pc.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_PAWS, GLOBAL.FLAG_FURRED];
				changes++;
			}
			//Grow Fox Ears]
			//SECOND
			if ((enhanced || pc.hasTail(GLOBAL.TYPE_VULPINE)) && pc.earType != GLOBAL.TYPE_VULPINE && changes < changeLimit && rand(4) == 0) {
				output("\n\nYour ears change, shifting from their current shape to become vulpine in nature.  <b>You now have fox ears.</b>");
				pc.earType = GLOBAL.TYPE_VULPINE;
				changes++;
			}
			//[Grow Fox Tail](fairly common)
			//FIRST
			if (!pc.hasTail(GLOBAL.TYPE_VULPINE) && changes < changeLimit && rand(4) == 0) {
				//from no tail
				if (!pc.hasTail()) output("\n\nA pressure builds on your backside.  You feel under your [pc.armor] and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own.  <b>You now have a fox's tail!</b>");
				//from another type of tail
				else output("\n\nPain lances through your lower back as your tail shifts violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox's tail!</b>");
				pc.tailType = GLOBAL.TYPE_VULPINE;
				pc.tailCount = 1;
				pc.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FURRED, GLOBAL.FLAG_FLUFFY];
				changes++;
			}
			//[Grow Fox Face]
			//LAST - muzzlygoodness
			//should work from any face, including other muzzles
			if (pc.skinType == GLOBAL.SKIN_TYPE_FUR && pc.faceType != GLOBAL.TYPE_VULPINE && changes < changeLimit && rand(5) == 0) {
				output("\n\nYour face pinches and you clap your hands to it.  Within seconds, your nose is poking through those hands, pushing them slightly to the side as new flesh and bone build and shift behind it, until it stops in a clearly defined, tapered, and familiar point you can see even without the aid of a mirror.  <b>Looks like you now have a fox's face.</b>");
				if (kGAMECLASS.silly) output("  And they called you crazy...");
				changes++;
				pc.faceType = GLOBAL.TYPE_VULPINE;
				pc.faceFlags = [GLOBAL.FLAG_MUZZLED];
			}
			if (pc.tone > 40 && changes < changeLimit && rand(2) == 0) {
				output("\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles seem less visible, and various parts of you are pleasantly softer.");
				pc.tone -= 4;
			}
			//Debugcunt
			if (changes < changeLimit && rand(3) == 0 && pc.hasVagina() && pc.vaginas[0].type != GLOBAL.TYPE_CANINE) {
				output("\n\nSomething invisible brushes against your sex, making you twinge.  ");
				if (!pc.isCrotchExposed()) output("Undoing your clothes, y");
				else output("Y");
				output("ou take a look at your vagina and find that it has turned into animalistic, vulpine form.");
				pc.vaginas[0].type = GLOBAL.TYPE_CANINE;
				changes++;
			}
			if (changes == 0) {
				output("\n\nWell that didn't do much, but you do feel a little refreshed!");
				pc.energy(5);
			}
			//pc.refillHunger(15);
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}	
}
