package classes.Items.Transformatives
{
	import classes.Characters.PlayerCharacter;
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
	
    public class CoCFoxJewel extends ItemSlotClass
    {
        public function CoCFoxJewel(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.PILL;
            //Used on inventory buttons
            this.shortName = "FoxJewl";
            //Regular name
            this.longName = "Fox Jewel";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a fox jewel";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A shining teardrop-shaped jewel.  An eerie blue flame dances beneath the surface.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 100;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			if (!(target is PlayerCharacter))
			{
				return false;
			}
			
			useIt(false);
			return false;
		}
		
        public static function useIt(mystic:Boolean):Boolean
        {
			clearOutput();
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			var changes:int = 0;
			var changeLimit:int = 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (mystic) changeLimit += 2;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			
			if (mystic) output("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie purple flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale lavender flames swirl around you, the air is filled with a sickly sweet scent that drips with the bitter aroma of licorice, filling you with a dire warmth.");
			else output("You examine the jewel for a bit, rolling it around in your hand as you ponder its mysteries.  You hold it up to the light with fascinated curiosity, watching the eerie blue flame dancing within.  Without warning, the gem splits down the center, dissolving into nothing in your hand.  As the pale azure flames swirl around you, the air is filled with a sweet scent that drips with the aroma of wintergreen, sending chills down your spine.");

			//**********************
			//BASIC STATS
			//**********************
			//[increase Intelligence, Libido and Sensitivity]
			if (pc.IQ() < 100 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0))) {
				output("\n\nYou close your eyes, smirking to yourself mischievously as you suddenly think of several new tricks to try on your opponents; you feel quite a bit more cunning.  The mental image of them helpless before your cleverness makes you shudder a bit, and you lick your lips and stroke yourself as you feel your skin tingling from an involuntary arousal.");
				//Raise INT, Lib, Sens. and +10 LUST
				//dynStats("int", 2, "lib", 1, "sen", 2, "lus", 10);
				pc.slowStatGain("i", 2);
				pc.slowStatGain("l", 1);
				pc.lust(10);
				changes++;
			}
			//[decrease Strength toward 15]
			if (pc.PQ() > 15 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				output("\n\nYou can feel your muscles softening as they slowly relax, becoming a tad weaker than before.  Who needs physical strength when you can outwit your foes with trickery and mischief?  You tilt your head a bit, wondering where that thought came from.");
				pc.physique(-1)
				if (pc.PQ() > 70) pc.physique( -0.33);
				if (pc.PQ() > 50) pc.physique( -0.33);
				if (pc.PQ() > 30) pc.physique( -0.33);
				changes++;
			}
			//[decrease Toughness toward 20]
			//if (pc.tou > 20 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				////from 66 or less toughness
				//if (pc.tou <= 66) output("\n\nYou feel your " + pc.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your " + pc.skinFurScales() + " won't offer you much protection.");
				////from 66 or greater toughness
				//else output("\n\nYou feel your " + pc.skinFurScales() + " becoming noticeably softer.  A gentle exploratory pinch on your arm confirms it - your hide isn't quite as tough as it used to be.");
				//dynStats("tou", -1);
				//if (pc.tou > 66) dynStats("tou", -1);
				//changes++;
			//}
			if (mystic && changes < changeLimit && rand(2) == 0 && pc.cor() < 100) {
				if (pc.cor() < 33) output("\n\nA sense of dirtiness comes over you, like the magic of this gem is doing some perverse impropriety to you.");
				else if (pc.cor() < 66) output("\n\nA tingling wave of sensation rolls through you, but you have no idea what exactly just changed.  It must not have been that important.");
				else output("\n\nThoughts of mischief roll across your consciousness, unbounded by your conscience or any concern for others.  You should really have some fun - who cares who it hurts, right?");
				//dynStats("cor", 1);
				pc.cor(1);
			}


			//**********************
			//MEDIUM/SEXUAL CHANGES
			//**********************
			//[adjust Femininity toward 50]
			//Your facial features soften as your body becomes more androgynous.
			if (((mystic && rand(2) == 0) || (!mystic && rand(4) == 0)) && changes < changeLimit && (pc.femininity < 45 || pc.femininity > 55)) {
				output(pc.modFem(pc.femininity > 50 ? -2 : 2));
				changes++;
			}
			//[decrease muscle tone toward 40]
			if (pc.tone >= 40 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0))) {
				output("\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles seem less visible, and various parts of you are pleasantly softer.");
				pc.tone -= 2 + rand(3);
				changes++;
			}

			//[Adjust hips toward 10 – wide/curvy/flared]
			//from narrow to wide
			if (pc.hipRating() < 10 && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && changes < changeLimit) {
				pc.hipRating(1);
				if (pc.hipRating() < 7) pc.hipRating(1);
				if (pc.hipRating() < 4) pc.hipRating(1);
				output("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have widened nicely!");
				changes++;
			}
			//from wide to narrower
			if (pc.hipRating() > 10 && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && changes < changeLimit) {
				pc.hipRating( -1);
				if (pc.hipRating() > 14) pc.hipRating( -1);
				if (pc.hipRating() > 19) pc.hipRating( -1);
				if (pc.hipRating() > 24) pc.hipRating( -1);
				output("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your hips have narrowed.");
				changes++;
			}

			//[Adjust hair length toward range of 16-26 – very long to ass-length]
			if ((pc.hairLength < 18 || pc.hairLength > pc.tallness / 1.4) && pc.hairType == GLOBAL.HAIR_TYPE_REGULAR && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && changes < changeLimit) {
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
			//[Increase Vaginal Capacity] - requires vagina, of course
			if (pc.hasVagina() && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0)) && pc.vaginas[0].bonusCapacity < 200 && changes < changeLimit) {
				output("\n\nA gurgling sound issues from your abdomen, and you double over as a trembling ripple passes through your womb.  The flesh of your stomach roils as your internal organs begin to shift, and when the sensation finally passes, you are instinctively aware that your [pc.vagina] is a bit deeper than it was before.");
				pc.vaginas[0].bonusCapacity += (3+rand(3)) * 10;
				changes++;
			}
			//[Vag of Holding] - rare effect, only if PC has high vaginal looseness
			else if (pc.hasVagina() && ((mystic) || (!mystic && rand(5) == 0)) && pc.vaginas[0].bonusCapacity >= 200 && pc.vaginas[0].bonusCapacity < 9000 && changes < changeLimit) {
				output("\n\nYou clutch your stomach with both hands, dropping to the ground in pain as your internal organs begin to twist and shift violently inside you.  As you clench your eyes shut in agony, you are overcome with a sudden calm.  The pain in your abdomen subsides, and you feel at one with the unfathomable infinity of the universe, warmth radiating through you from the vast swirling cosmos contained within your womb.");
				if (kGAMECLASS.silly) output("  <b>Your vagina has become a universe unto itself, capable of accepting colossal insertions beyond the scope of human comprehension!</b>");
				else output("  <b>Your vagina is now capable of accepting even the most ludicrously sized insertions with no ill effects.</b>");
				pc.vaginas[0].bonusCapacity = 9000;
				if (pc.vaginas[0].loosenessRaw > 1) pc.vaginas[0].loosenessRaw = 1;
				changes++;
			}


			//**********************
			//BIG APPEARANCE CHANGES
			//**********************
			//[Grow Fox Tail]
			if (!pc.hasTail(GLOBAL.TYPE_VULPINE) && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0))) {
				var vine:Boolean = pc.hasParasiteTail();
				if (pc.tailType == GLOBAL.TYPE_COCKVINE)
				{
					pc.tailType = GLOBAL.TYPE_VULPINE;
					pc.addTailFlag(GLOBAL.FLAG_TAILCOCK);
					pc.libidoRaw -= 3;
				}
				
				//if PC has no tail
				if (!pc.hasTail()) {
					output("\n\nA pressure builds on your backside.  You feel under your [pc.gear] and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it has a mind of its own.  <b>You now have a fox-tail.</b>");
				}
				//if PC has another type of tail
				else
					output("\n\nPain lances through your lower back as your [pc.tail] shifts and twitches violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox-tail.</b>");
				
				if (pc.hasTailCock())
				{
					pc.clearTailFlags();
					pc.tailGenitalColor = "red";
					pc.tailGenitalArg = GLOBAL.TYPE_VULPINE;
					pc.tailGenital = GLOBAL.TAIL_GENITAL_COCK;
					pc.addTailFlag(GLOBAL.FLAG_TAILCOCK); // that's a hell load of flags...
					pc.addTailFlag(GLOBAL.FLAG_KNOTTED);
					pc.addTailFlag(GLOBAL.FLAG_TAPERED);
					pc.addTailFlag(GLOBAL.FLAG_SHEATHED);
					kGAMECLASS.output(" The tip of your tail feels strange. After some probing you've found your tail genitalia still present, but totally unnoticeable under a furry sheath when not aroused");
					if(vine) kGAMECLASS.output(" and much less prone to act by itself");
					kGAMECLASS.output(".");
				} else pc.clearTailFlags();
					
				pc.tailType = GLOBAL.TYPE_VULPINE;
				pc.tailCount = 1;
				pc.addTailFlag(GLOBAL.FLAG_LONG);
				pc.addTailFlag(GLOBAL.FLAG_FURRED);
				pc.addTailFlag(GLOBAL.FLAG_FLUFFY);
				pc.addTailFlag(GLOBAL.FLAG_PREHENSILE); // unlike normal fox tails
				changes++;
			}
			if (!mystic && pc.earType == GLOBAL.TYPE_VULPINE && pc.hasTail(GLOBAL.TYPE_VULPINE) && pc.tailCount == 8 && rand(3) == 0) {
				output("\n\nYou have the feeling that if you could grow a ninth tail you would be much more powerful, but you would need to find a way to enhance one of these gems or meditate with one to have a chance at unlocking your full potential.");
			}
			//[Grow Addtl. Fox Tail]
			//(rare effect, up to max of 8 tails, requires PC level and int*10 = number of tail to be added)
			else if (pc.hasTail(GLOBAL.TYPE_VULPINE) && pc.tailCount < 8 && pc.tailCount + 1 <= pc.level && pc.tailCount + 1 <= pc.IQ() / 10 && pc.WQ() >= 33 && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				//if PC has 1 fox tail
				if (pc.tailCount == 1) {
					output("\n\nA tingling pressure builds on your backside, and your bushy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail splits into two!  <b>You now have a pair of fox-tails.</b>");
					//increment tail by 1
				}
				//else if PC has 2 or more fox tails
				else {
					output("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(pc.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(pc.tailCount + 1) + " fox-tails.</b>");
					//increment tail by 1
				}
				if(!pc.hasTailFlag(GLOBAL.FLAG_PREHENSILE))
					pc.addTailFlag(GLOBAL.FLAG_PREHENSILE);
				pc.tailCount++;
				changes++;
			}
			//[Grow 9th tail and gain Corrupted Nine-tails perk]
			else if (mystic && rand(4) == 0 && changes < changeLimit
					&& pc.earType == GLOBAL.TYPE_VULPINE 
					&& pc.hasTail(GLOBAL.TYPE_VULPINE) 
					&& pc.tailCount == 8 
					&& pc.tailCount <= pc.level 
					&& pc.IQ() >= 90
					&& pc.WQ() >= 33) {
				if (!pc.hasPerk("Enlightened Nine-tails") && !pc.hasPerk("Corrupted Nine-tails"))
				{
					output("Your bushy tails begin to glow with an eerie, ghostly light, and with a crackle of electrical energy, split into nine tails.  <b>You are now a nine-tails!  But something is wrong...  The cosmic power radiating from your body feels...  tainted somehow.  The corruption pouring off your body feels...  good.</b>");
					output("\n\nYou have the inexplicable urge to set fire to the world, just to watch it burn.  With your newfound power, it's a goal that is well within reach.");
					output("\n\n(Perk Gained: Corrupted Nine-tails - Grants two magical special attacks.)");
					
					pc.createPerk("Corrupted Nine-tails", 0, 0, 0, 0, "The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.");
					
					kGAMECLASS.validatePlayerKitsuneElderColor();
				}
				else { // regrow lost
					output("\n\nA tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(pc.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(pc.tailCount + 1) + " fox-tails.</b>");
					//increment tail by 1
				}
				//dynStats("lib", 2, "lus", 10, "cor", 10);
				pc.slowStatGain("l", 2);
				pc.lust(10);
				pc.cor(10);
				pc.tailCount = 9;
				changes++;
			}

			//[Grow Fox Ears]
			if (pc.hasTail(GLOBAL.TYPE_VULPINE) && ((mystic && rand(2) == 0) || (!mystic && rand(4) == 0)) && pc.earType != GLOBAL.TYPE_VULPINE && changes < changeLimit) {
				//if PC has non-animal ears
				if (pc.earType == GLOBAL.TYPE_HUMAN) output("\n\nThe sides of your face painfully stretch as your ears morph and begin to migrate up past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  You now have fox ears.");
				//if PC has animal ears
				else output("\n\nYour ears change shape, shifting from their current shape to become vulpine in nature.  You now have fox ears.");
				pc.earType = GLOBAL.TYPE_VULPINE;
				changes++;
			}
			//[Change Hair Color: Golden-blonde, SIlver Blonde, White, Black, Red]
			if (((mystic && rand(2) == 0) || (!mystic && rand(4) == 0)) && changes < changeLimit 
					&& !InCollection(pc.hairColor, kGAMECLASS.basicKitsuneHair, kGAMECLASS.elderKitsuneColors, kGAMECLASS.corruptKitsuneColors)) {
				
				if (pc.hasPerk("Enlightened Nine-tails")) pc.hairColor = RandomInCollection(kGAMECLASS.elderKitsuneColors);
				else if (pc.hasPerk("Corrupted Nine-tails")) pc.hairColor = RandomInCollection(kGAMECLASS.corruptKitsuneColors);
				else pc.hairColor = RandomInCollection(kGAMECLASS.basicKitsuneHair);
				
				output("\n\nYour scalp begins to tingle, and you gently grasp a strand, pulling it forward to check it.  Your hair has become the same " + pc.hairColor + " as a kitsune's!");
				changes++;
			}
			var tone:Array = mystic ? ["dark", "ebony", "ashen", "sable", "milky white"] : ["tan", "olive", "light", "pale", "fair"];
			//[Change Skin Type: remove fur or scales, change skin to Tan, Olive, or Light]
			if (((pc.skinType == GLOBAL.SKIN_TYPE_FUR 
					&& !InCollection(pc.furColor, kGAMECLASS.basicKitsuneFur, kGAMECLASS.elderKitsuneColors, kGAMECLASS.corruptKitsuneColors, ["orange and white", "black and white", "red and white", "tan", "brown"])
					)
				|| pc.skinType == GLOBAL.SKIN_TYPE_SCALES) && ((mystic) || (!mystic && rand(2) == 0))) {
				output("\n\nYou begin to tingle all over your " + pc.skinFurScales() + ", starting as a cool, pleasant sensation but gradually worsening until you are furiously itching all over.");
				
				if (pc.skinType == GLOBAL.SKIN_TYPE_FUR) output("  You stare in horror as you pull your fingers away holding a handful of " + pc.furColor + " fur!  Your fur sloughs off your body in thick clumps, falling away to reveal patches of bare, " + pc.skinTone + " skin.");
				else if (pc.skinType == GLOBAL.SKIN_TYPE_SCALES) output("  You stare in horror as you pull your fingers away holding a handful of dried up scales!  Your scales continue to flake and peel off your skin in thick patches, revealing the tender " + pc.skinTone + " skin underneath.");
				
				output("  Your skin slowly turns raw and red under your severe scratching, the tingling sensations raising goosebumps across your whole body.  Over time, the itching fades, and your flushed skin resolves into a natural-looking ");
				pc.skinType = GLOBAL.SKIN_TYPE_SKIN;
				if (!InCollection(pc.skinTone, tone)) pc.skinTone = RandomInCollection(tone);
				output(pc.skinTone + " complexion.");
				output("  <b>You now have " + pc.skin() + "!</b>");
				changes++;
			}
			//Change skin tone if not changed you!
			else if (pc.skinType == GLOBAL.SKIN_TYPE_SKIN && !InCollection(pc.skinTone, tone) && changes < changeLimit && ((mystic && rand(2) == 0) || (!mystic && rand(3) == 0))) {
				output("\n\nYou feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  Holding an arm up to your face, you discover that <b>you now have ");
				pc.skinTone = RandomInCollection(tone);
				output(pc.skin() + "!</b>");
				changes++;
			}
			//[Change Skin Color: add "Tattoos"]
			//From Tan, Olive, or Light skin tones
			else if (9999 == 0 && InCollection(pc.skinTone, tone) && changes < changeLimit) {
				output("You feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing tribal tattoos adorns your " + pc.skin() + ".  The glow gradually fades, but the distinctive ");
				if (mystic) output("angular");
				else output("curved");
				output(" markings remain, as if etched into your skin.");
				changes++;
				//9999 - pending tats system
			}
			if (changes == 0) {
				output("\n\nOdd.  You don't feel any different.");
			}
			
			kGAMECLASS.flags["COC.TIMES_TRANSFORMED"] += changes;
			return false;
		}
	}	
}
