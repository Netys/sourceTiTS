package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCAmilyPregnancy extends BasePregnancyHandler
	{
		public function CoCAmilyPregnancy() 
		{
			_handlesType = "CoCAmilyPregnancy";
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
			_definedAverageLoadSize = 50;
			
			this.addStageProgression(336 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some mixed nuts. And maybe a little cheese, too.";
			}, true);
			
			this.addStageProgression(280 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is getting more noticeably distended and squirming around.  You are probably pregnant.";
			}, true);
			
			this.addStageProgression(216 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nThere is no question you're pregnant; your belly is already as big as that of any pregnant woman back home.";
				if (kGAMECLASS.amilyFollower()) kGAMECLASS.eventBuffer += " Amily smiles at you reassuringly. \"<i>We do have litters, dear, this is normal.</i>\"";
				
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
				
				kGAMECLASS.eventBuffer += "\n\nYou feel (and look) hugely pregnant, now, but you feel content. You know the, ah, 'father' of these children loves you, and they will love you in turn.";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou jolt from the sensation of squirming inside your swollen stomach. Fortunately, it dies down quickly, but you know for a fact that you felt more than one baby kicking inside you.";
				
				kGAMECLASS.pc.slowStatGain("r", -3);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen +1
				kGAMECLASS.pc.lust(4);
			}, true);
			
			this.addStageProgression(48 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe children kick and squirm frequently. Your bladder, stomach and lungs all feel very squished. You're glad that they'll be coming out of you soon.";
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
					kGAMECLASS.pcBirthsAmilysKidsQuestVersion(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			//StatTracking.track("coc/pregnancy/pc amily", 1); // handled in pcBirthsAmilysKidsQuestVersion
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