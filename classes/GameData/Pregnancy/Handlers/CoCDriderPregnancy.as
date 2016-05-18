package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCDriderPregnancy extends BasePregnancyHandler
	{
		public function CoCDriderPregnancy() // basically spider copy-paste
		{
			_handlesType = "CoCDriderPregnancy";
			_basePregnancyIncubationTime = 400 * 60; // 16 days
			_basePregnancyChance = 0.15;
			_alwaysImpregnate = false;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = false;
			_ignoreFatherInfertility = false;
			_allowMultiplePregnancies = false;
			_canImpregnateButt = false;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 8;
			_pregnancyQuantityMaximum = 12;
			_definedAverageLoadSize = 100;
			_pregnancyChildType = GLOBAL.CHILD_TYPE_EGGS;
			
			this.addStageProgression(399 * 60, function(pregSlot:int):void {
				kGAMECLASS.eventBuffer += "\n\nAfter your session with the spider, you feel much... fuller.  There is no outward change on your body as far as you can see but your womb feels slightly tingly whenever you move.  Hopefully it's nothing to be alarmed about.";
			}, true);
			
			this.addStageProgression(280 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly grumbles as if empty, even though you ate not long ago.  Perhaps with all the exercise you're getting you just need to eat a little bit more.";
			}, true);
			
			this.addStageProgression(250 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly looks a little pudgy";
				if (kGAMECLASS.pc.thickness > 60 && kGAMECLASS.pc.tone < 40) kGAMECLASS.eventBuffer += " even for you";
				kGAMECLASS.eventBuffer += ", maybe you should cut back on all the food you've been consuming lately?";
			}, true);
			
			this.addStageProgression(216 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is definitely getting bigger, and no matter what you do, you can't seem to stop yourself from eating at the merest twinge of hunger.  The only explanation you can come up with is that you've gotten pregnant during your travels.  Hopefully it won't inconvenience your adventuring.";
			}, true);
			
			this.addStageProgression(180 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nA hot flush works its way through you, and visions of aroused driders quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and mated with over and over, violated by a pack of horny males, each hoping to father your next brood.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?";
				
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen +1
				kGAMECLASS.pc.lust(20);
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly has gotten nice and big, perhaps as big as you remember the bellies of the pregnant women back home being.  The elders always did insist on everyone doing their part to keep the population high enough to sustain the loss of a champion every year.  You give yourself a little hug, getting a surge of happiness from your hormone-addled body.  Pregnancy sure is great!";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.  A sense of motherly pride wells up in your breast - you just know you'll have such wonderful babies.";
				if (kGAMECLASS.pc.cor() < 50) kGAMECLASS.eventBuffer += " You shudder and shake your head, wondering why you're thinking such unusual things.";
			}, true);
			
			var intermediate:Function = function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				if (kGAMECLASS.pc.breastRows[0].breastRating() >= 3 && kGAMECLASS.pc.breastsPerRow(0) > 1 && kGAMECLASS.pc.canLactate() && kGAMECLASS.pc.milkMultiplier < 100) {
					kGAMECLASS.eventBuffer += "\n\nYour breasts feel swollen with all the extra milk they're accumulating.";
					kGAMECLASS.pc.boostLactation(10);
				}
				if (kGAMECLASS.pc.breastRows[0].breastRating() >= 3 && kGAMECLASS.pc.breastsPerRow(0) > 1 && kGAMECLASS.pc.milkMultiplier > 0 && kGAMECLASS.pc.milkMultiplier < 50) {
					kGAMECLASS.eventBuffer += "\n\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.";
					kGAMECLASS.pc.boostLactation(60 - kGAMECLASS.pc.milkMultiplier);
				}
				if (kGAMECLASS.pc.breastRows[0].breastRating() >= 3 && kGAMECLASS.pc.breastsPerRow(0) > 1 && kGAMECLASS.pc.milkMultiplier == 0) {
					kGAMECLASS.eventBuffer += "\n\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.";
					kGAMECLASS.pc.boostLactation(50);
				}
				if (kGAMECLASS.pc.breastRows[0].breastRating() == 2 && kGAMECLASS.pc.breastsPerRow(0) > 1) {
					kGAMECLASS.eventBuffer += "\n\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.";
					Mutator.growTits(kGAMECLASS.pc, 1, 1, false, 3, 3);
				}
				if (kGAMECLASS.pc.breastRows[0].breastRating() == 1 && kGAMECLASS.pc.breastsPerRow(0) > 1) {
					kGAMECLASS.eventBuffer += "\n\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.";
					Mutator.growTits(kGAMECLASS.pc, 1, 1, false, 3, 2);
				}
			};
			
			this.addStageProgression(150 * 60, intermediate, true);
			this.addStageProgression(85 * 60, intermediate, true);
			this.addStageProgression(64 * 60, intermediate, true);
			this.addStageProgression(32 * 60, intermediate, true);
			
			_onTryImpregnate = OverrideOnTryImpregnate;
			_onSuccessfulImpregnation = OverrideOnSuccessfulImpregnantion;
			_onDurationEnd = OverrideOnDurationEnd;
		}
		
		public static function OverrideOnTryImpregnate(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):Boolean
		{
			if (mother.characterClass != GLOBAL.CLASS_ADVENTURER) return false; // only can be pregged if you are true champion
			
			if (pregSlot == 3) // butt preg is actually by oviposition
			{
				CoCDriderEggPregnancy.OverrideOnTryImpregnate(father, mother, pregSlot, thisPtr);
				return;
			}
			
			return defaultOnTryImpregnate(father, mother, pregSlot, thisPtr);
		}
		
		public static function OverrideOnSuccessfulImpregnantion(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			if (pregSlot == 3) // butt preg is actually by oviposition
			{
				CoCDriderEggPregnancy.defaultOnSuccessfulImpregnation(father, mother, pregSlot, thisPtr);
				return;
			}
			
			defaultOnSuccessfulImpregnation(father, mother, pregSlot, thisPtr);
			
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
		}
		
		public static function OverrideOnDurationEnd(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// Closure ensures that we will call the targetted output function (thus it will have access
			// to various pregnancy data) prior to cleaning up the pregnancy data itself. Magic.
			var tEventCall:Function = (function(c_mother:Creature, c_pregSlot:int, c_thisPtr:BasePregnancyHandler):Function
			{
				return function():void
				{
					kGAMECLASS.driderPregVagBirth(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			StatTracking.track("coc/pregnancy/drider", 1);
			StatTracking.track("coc/pregnancy/total births", 1);
			
			pData.reset();
		}
		
		override public function pregBellyFragment(target:Creature, slot:int):String
		{
			var pData:PregnancyData = target.pregnancyData[slot];
			var retString:String = "";
			
			//if(pData.pregnancyIncubation < 72 * 60) retString += "Your squirming belly makes your pregnancy obvious for those around you.";
			//else if(pData.pregnancyIncubation < 120 * 60) retString += "Your belly is noticeably distended, and constantly shifts and wriggles.";
			
			return retString;
		}
	}

}