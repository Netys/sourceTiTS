package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCMousePregnancy extends BasePregnancyHandler
	{
		public function CoCMousePregnancy() 
		{
			_handlesType = "CoCMousePregnancy";
			_basePregnancyIncubationTime = 350 * 60; // 14 days
			_basePregnancyChance = 0.15;
			_alwaysImpregnate = false;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = false;
			_ignoreFatherInfertility = false;
			_allowMultiplePregnancies = false;
			_canImpregnateButt = false;
			_canImpregnateVagina = true;
			_canFertilizeEggs = true;
			_pregnancyQuantityMinimum = 8;
			_pregnancyQuantityMaximum = 12;
			_definedAverageLoadSize = 100;
			
			this.addStageProgression(336 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.";
			}, true);
			
			this.addStageProgression(280 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is getting more noticeably distended and squirming around.  You are probably pregnant.";
			}, true);
			
			this.addStageProgression(216 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.";
				if (kGAMECLASS.flags["COC.JOJO_STATE"] > 0) {
					if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.";
					if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.";
					if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.";
				}
				
				kGAMECLASS.pc.slowStatGain("r", -1);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen 1
				kGAMECLASS.pc.lust(2);
			}, true);
			
			this.addStageProgression(180 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe sudden impact of a tiny kick from inside your distended womb startles you.  Moments later it happens again, making you gasp.";
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is painfully distended and overswollen with wriggling offspring, ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "making it difficult to function.";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "and you wonder how much longer you have to wait.";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.";
				
				kGAMECLASS.pc.slowStatGain("r", -3);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen +1
				kGAMECLASS.pc.lust(4);
			}, true);
			
			this.addStageProgression(48 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever is inside your overstretched womb seems to appreciate the attention and stops its incessant squirming. ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "Afterwards you feel somewhat disgusted with yourself.";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "You estimate you'll give birth in the next few days.";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "You find yourself daydreaming about birthing hundreds of little babies, and lounging around while they nurse non-stop on your increasingly sensitive breasts.";
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
			
			return defaultOnTryImpregnate(father, mother, pregSlot, thisPtr);
		}
		
		public static function OverrideOnSuccessfulImpregnantion(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
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
					kGAMECLASS.giveBirthToGenericMice(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			//StatTracking.track("coc/pregnancy/mice", 1); // handled in giveBirthToGenericMice
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