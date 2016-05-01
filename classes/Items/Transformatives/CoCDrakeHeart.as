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
	
	public class CoCDrakeHeart extends ItemSlotClass
	{
		public function CoCDrakeHeart(dataObject:Object=null)
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "DrakHeart";
			//Regular name
			this.longName = "drake's heart's flower";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a drake's heart's flower";
			//Displayed on tooltips during mouseovers
			this.tooltip = "A rare, beautiful flower.  It could make an exquisite perfume.  According to a legend, dragons give this flower to the ones they intend to court.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 500;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			if (!(target is PlayerCharacter))
			{
				return false;
			}
			
			useIt(target, true);
			return false;
		}
		
		public static function useIt(target:Creature, drakesHeart:Boolean):Boolean
		{
			clearOutput();
			
			var temp:Number = 0;
			var changes:int = 0;
			var changeLimit:int = 2;
			if (target.hasPerk("History: Alchemist")) changeLimit++;
			if (target.hasPerk("Transformation Resistance")) changeLimit--;
			
			if(drakesHeart) output("You bring the flower up to your nose and smell it. It has exquisite smell. You suddenly have the strange desire to eat it. You pop the flower into your mouth and chew. It tastes like vanilla somehow.");
			
			//Gain Dragon Dick
			if (changes < changeLimit && target.totalCocks(GLOBAL.TYPE_DRACONIC) < target.totalCocks() && rand(3) == 0) {
				temp = 0;
				var choices:Array = [];
				var select:int;
				temp = target.cockTotal();
				//Build an array of all the locations for TF'able cocks.
				while (temp > 0) {
					temp--;
					if (target.cocks[temp].cType != GLOBAL.TYPE_DRACONIC) choices[choices.length] = temp;
				}
				//Randomly choose one of those locations
				select = choices[rand(choices.length)];
				output("\n\nYour " + target.cockDescript(select) + " tingles as pins and needles sweep across it.  You pull open your [pc.gear] to watch as it changes; the tip elongates and tapers, like a spear; a series of ridges form along the shaft, giving it an almost segmented look, and a prominent knot swells at its base.  You can't resist stroking it, until it begins dripping pre; ");
				output("but you sternly rein in your hands and tuck them into your armpits as the arousing changes run their course.");
				output("  <b>You now have a dragon penis.</b>");
				//lose lust if sens>=50, gain lust if else
				//dynStats("sen", 10, "lus", 10);
				target.shiftCock(select, GLOBAL.TYPE_DRACONIC)
				target.lust(10);
				changes++;
			}
			
			//Genital slit - Naleen copypaste
			if(!target.hasStatusEffect("Genital Slit") && changes < changeLimit && rand(3) == 0) {
				output("\n\nA ripple of pleasant heat radiates out from your stomach and down a little deeper to your loins, manifesting in the form of ");
				if(target.cockTotal() == 1) output("a rising erection");
				else output("rising erections");
				output(".");
				if(!target.isCrotchExposed()) {
					output(" You immediately pull your [pc.lowerGarments] to free yourself from the constricting pressure.");
				}
				if(target.cockTotal() == 1) output(" It's");
				else output(" They're");
				output(" pulsating and achingly hard, already drooling a steady trickle of pre-cum along ");
				if(target.cockTotal() == 1) output("its underside");
				else output("their undersides");
				output(". Then, the sinking sensation starts.");
				output("\n\n[pc.EachCock] is slowly drifting backwards, ");
				if(target.hasASheath()) output("folding into your sheath at first, then taking it along with your dick, ");
				output("disappearing further into your middle with each passing moment. In a fit of desperation, you grab hold");
				if(target.cockTotal() > 1) output(" of one");
				output(" and tug, trying to keep your [pc.cocks] from going away, but you're too slick with pre! The length slides right through your grip and up inside you. With barely half of ");
				if(target.cockTotal() == 1) output("its length remaining");
				else output("their lengths remaining");
				output(" exposed, you're forced to watch ");
				if(target.cockTotal() == 1) output("it");
				else output("them");
				output(" completely recede, leaving only a single slit in its place.");
				output("\n\nThe arousal fades as quickly as it came, leaving you there to consider your new genital slit. A quick, probing fingertip finds that your [pc.cocks] ");
				if(target.cockTotal() == 1) output("hasn't");
				else output("haven't");
				output(" vanished - ");
				if(target.cockTotal() > 1) output("they're");
				else output("it's");
				output(" just hiding inside the warm, wet channel. Oh... it feels kind of nice, and [pc.eachCock] starts to emerge. You stop before you wind up masturbating with <b>the new, reptilian slit that holds your [pc.cocks] when unaroused.</b>");
				target.lust(5)
				changes++;
				target.createStatusEffect("Genital Slit", 0, 0, 0, 0);
			}
			
			//Gain Dragon Head
			if (changes < changeLimit && rand(3) == 0 && (drakesHeart || int(kGAMECLASS.flags["COC.EMBER_ROUNDFACE"]) == 0) && Mutator.changeFace(target, GLOBAL.TYPE_DRACONIC, [GLOBAL.FLAG_MUZZLED])) changes++;
			
			//-Existing horns become draconic, max of 4, max length of 1'
			if ((target.hornType != GLOBAL.TYPE_DRACONIC || target.horns < 4 || target.hornLength < 12) && changes < changeLimit && rand(5) == 0) {
				//No dragon horns yet.
				if (!target.hasHorns(GLOBAL.TYPE_DRACONIC) && !target.hasHorns(GLOBAL.TYPE_LIZAN)) {
					//Already have horns
					if (target.hasHorns()) {
						// horns
						if (target.horns * target.hornLength >= 36) {
							output("\n\nYour [pc.horns] condense, twisting around each other and merging into different, pointed protrusions.  By the time they finish you have four draconic-looking horns, each about twelve inches long.");
							target.hornType = GLOBAL.TYPE_DRACONIC;
							target.hornLength = 12;
							target.horns = 4;
						}
						else {
							output("\n\nYou feel your [pc.horns] changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They must look something like the horns the dragons in your village's legends always had.");
							target.hornType = GLOBAL.TYPE_LIZAN;
							target.horns = 2;
							if (target.horns > 12) {
								output("  The change seems to have shrunken the horns, they're about a foot long now.");
								target.hornLength = 12;
							}
						}
						changes++;
					}
					//No horns
					else {
						//-If no horns, grow a pair
						output("\n\nWith painful pressure, the skin on the sides of your forehead splits around two tiny nub-like horns.  They're angled back in such a way as to resemble those you saw on the dragons in your village's legends.  A few inches of horn sprout from your head before stopping.  <b>You have about four inches of dragon-like horn.</b>");
						target.horns = 2;
						target.hornLength = 4;
						target.hornType = GLOBAL.TYPE_LIZAN;

						changes++;
					}
				}
				//ALREADY DRAGON
				else {
					if (target.hornLength < 12) {
						if (rand(2) == 0) {
							output("\n\nYou get a headache as an inch of fresh horn escapes from your pounding skull.");
							target.hornLength += 1;
						}
						else {
							output("\n\nYour head aches as your horns grow a few inches longer.  They get even thicker about the base, giving you a menacing appearance.");
							target.hornLength += 2 + rand(4);
						}
						if (target.hornLength >= 12) {
							output("  <b>Your horns settle down quickly, as if they're reached their full size.</b>");
							target.hornLength = 12;
						}
						changes++;
					}
					//maxxed out, new row
					else if(target.horns < 4 || target.hornType != GLOBAL.TYPE_DRACONIC) {
						//--Next horn growth adds second row and brings length up to 12\"
						output("\n\nA second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop.  A sense of finality settles over you.  <b>You have as many horns as a dragon can grow.</b>");
						target.hornType = GLOBAL.TYPE_DRACONIC;
						target.horns = 4;
						target.hornLength = 12;
						changes++;
					}
				}
			}
			
			//Gain Dragon Ears
			if (changes < changeLimit && rand(3) == 0 && Mutator.changeEars(target, GLOBAL.TYPE_DRACONIC, 0, false)) {
				output("\n\nA prickling sensation suddenly fills your ears; unpleasant, but hardly painful.  It grows and grows until you can't stand it any more, and reach up to scratch at them.  To your surprise, you find them melting away like overheated candles.  You panic as they fade into nothingness, leaving you momentarily deaf and dazed, stumbling around in confusion.  Then, all of a sudden, hearing returns to you.  Gratefully investigating, you find you now have a pair of reptilian ear-holes, one on either side of your head.  A sudden pain strikes your temples, and you feel bony spikes bursting through the sides of your head, three on either side, which are quickly sheathed in folds of skin to resemble fins.  With a little patience, you begin to adjust these fins just like ears to aid your hearing.  <b>You now have dragon ears!</b>");
				changes++;
			}
			
			//Gain Dragon Tongue
			if (changes < changeLimit && rand(3) == 0 && Mutator.changeTongue(target, GLOBAL.TYPE_DRACONIC, [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE], null, null, false)) {
				output("\n\nYour tongue suddenly falls out of your mouth and begins undulating as it grows longer.  For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb.  You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point it looks like a normal human tongue.  <b>You now have a draconic tongue.</b>");
				changes++;
			}
			
			//Gain Dragon Scales
			if (changes < changeLimit && rand(3) == 0 && Mutator.changeSkin(target, GLOBAL.SKIN_TYPE_SCALES, null, null, null, null, false)) {
				output("\n\nPrickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles.  You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments of your " + target.skinFurScales() + " hanging from your fingers.  Nevertheless you continue to scratch yourself, and when you're finally done, you look yourself over. New shield-like scales have grown to replace your peeled off " + target.skinFurScales() + ".  They are smooth and look nearly as tough as iron. <b>Your body is now covered in shield-shaped dragon scales.</b>");
			}
			
			//Gain Dragon Legs
			// FIXME: plantigrade or digitigrade?
			if (changes < changeLimit && rand(3) == 0 && Mutator.changeLegs(target, GLOBAL.TYPE_DRACONIC, [2, 6, 2, 2], [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_SCALED])) changes++;
			
			// hands?
			if (changes < changeLimit && rand(3) == 0 && Mutator.changeArms(target, GLOBAL.TYPE_HUMAN, [GLOBAL.FLAG_SCALED])) changes++;
			
			// eyes?
			if (changes < changeLimit && rand(3) == 0 && Mutator.changeEyes(target, GLOBAL.TYPE_SNAKE)) changes++;
			
			//Gain Dragon Tail
			if (changes < changeLimit && rand(3) == 0 && Mutator.changeTail(target, GLOBAL.TYPE_DRACONIC, 1, [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE, GLOBAL.FLAG_SCALED])) changes++;
			
			//Grow Dragon Wings
			if (!target.hasWings(GLOBAL.TYPE_DRACONIC) && changes < changeLimit && rand(3) == 0) {
				if (!target.hasWings()) {
					output("\n\nYou double over as waves of pain suddenly fill your shoulderblades; your back feels like it's swelling, flesh and muscles ballooning.  A sudden sound of tearing brings with it relief and you straighten up.  Upon your back now sit small, leathery wings, not unlike a bat's. <b>You now have small dragon wings.  They're not big enough to fly with, but they look adorable.</b>");
					target.shiftWings(GLOBAL.TYPE_SMALLDRACONIC, 2);
				}
				//(If Small Dragon Wings Present)
				else if (target.hasWings(GLOBAL.TYPE_SMALLDRACONIC)) {
					output("\n\nA not-unpleasant tingling sensation fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger.  You spread them wide - they stretch further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and almost lifting you off your feet.  <b>You now have fully-grown dragon wings, capable of winging you through the air elegantly!</b>");
					target.shiftWings(GLOBAL.TYPE_DRACONIC, 2);
				}
				else if (target.wingType == GLOBAL.TYPE_SHARK) {
					output("\n\nA sensation of numbness suddenly fills your fin.  When it does away, it feels... different.  Looking back, you realize that it has been replaced by new, small wings, ones that you can only describe as draconic.  <b>Your shark-like fin has changed into dragon wings.</b>");
					target.shiftWings(GLOBAL.TYPE_SMALLDRACONIC, 2);
				}
				//(If other wings present)
				else {
					output("\n\nA sensation of numbness suddenly fills your wings.  When it dies away, they feel... different.  Looking back, you realize that they have been replaced by new, small wings, ones that you can only describe as draconic.  <b>Your wings have changed into dragon wings.</b>");
					target.shiftWings(GLOBAL.TYPE_SMALLDRACONIC, 2);
				}
				changes++;
			}
			//Get Dragon Breath (Tainted version)
			//Can only be obtained if you are considered a dragon-morph, once you do get it though, it won't just go away even if you aren't a dragon-morph anymore.
			if (target.dragonScore() >= 4 && changes < changeLimit && target.tongueType == GLOBAL.TYPE_DRACONIC && !target.hasPerk("Dragonfire")) {
				output("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
				output("\n\nIt seems " + (drakesHeart ? "the flower" : "Ember's dragon blood") + " has awaked some kind of power within you... your throat and chest feel very sore, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragonfire!</b>)");
				target.createPerk("Dragonfire", 0, 0, 0, 0, "Allows access to a dragon breath attack.");
				if (Flag("COC.EMBER_AFFECTION") >= 75 && !drakesHeart) output("\n\nEmber immediately dives back in to soothe your battered throat and mouth with another kiss.");
				changes++;
			}
			if (target.dragonScore() >= 4 && rand(3) == 0 && target.hasGenitals()) {
				output("\n\nA sudden swell of lust races through your [pc.crotch], making you wish " + (drakesHeart ? "you had a dragon to go with." : "Ember hadn't run you off") + ".  All you can think about now is fucking a dragon-morph; ");
				if (target.hasCock() && kGAMECLASS.flags["COC.EMBER_GENDER"] >= 2) {
					if (drakesHeart) {
						output("filling a womb with your seed and fertilizing those eggs");
					}
					else {
						output("filling her womb with your seed and fertilizing her eggs");
						if (target.hasVagina() && kGAMECLASS.flags["COC.EMBER_GENDER"] == 3) output(" even while ");
					}
				}
				if (target.hasVagina() && (kGAMECLASS.flags["COC.EMBER_GENDER"] == 3 || kGAMECLASS.flags["COC.EMBER_GENDER"] == 1)) {
					output("taking that hard, spurting cock inside your own [pc.vagina]");
				}
				output("... too late, you realize that <b>" + (drakesHeart ? "the flower" : "Ember's blood") + " has sent your draconic body into ");
				if (target.hasCock() && (kGAMECLASS.flags["COC.EMBER_GENDER"] >= 2 || drakesHeart) && (rand(2) == 0 || !target.hasVagina())) { //If hermaphrodite, the chance is 50/50.
					output("rut");
					
					Mutator.goIntoRut(target, false);
					changes++;
				}
				else {
					output("heat");
					
					Mutator.goIntoHeat(target, false);
					changes++;
				}
				output("</b>.");
			}
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}
}
