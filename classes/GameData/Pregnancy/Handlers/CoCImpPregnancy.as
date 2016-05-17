package classes.GameData.Pregnancy.Handlers 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GLOBAL;
	import classes.PregnancyData;
	import classes.kGAMECLASS;
	import classes.Engine.Interfaces.ParseText;
	import classes.GameData.StatTracking;
	
	public class CoCImpPregnancy extends BasePregnancyHandler
	{
		
		public function CoCImpPregnancy() 
		{
			_handlesType = "CoCImpPregnancy";
			_basePregnancyIncubationTime = 432 * 60; // 18 days
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
			
			this.addStageProgression(336 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou realize your belly has gotten slightly larger. Maybe you need to cut back on the strange food.";
			}, true);
			
			this.addStageProgression(280 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is getting more noticeably distended. You are probably pregnant.";
			}, true);
			
			this.addStageProgression(216 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe unmistakable bulge of pregnancy is visible in your tummy. ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>";
				
				kGAMECLASS.pc.slowStatGain("r", -1);
				kGAMECLASS.pc.slowStatGain("l", 1);
				kGAMECLASS.pc.lust(2);
			}, true);
			
			this.addStageProgression(180 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe sudden impact of a kick from inside your womb startles you.";
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour ever-growing belly makes your pregnancy obvious for those around you.";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is painfully distended, ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "making it difficult to function.";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "and you wonder how much longer you have to wait.";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "and you're eager to give birth, so you can get impregnated again by corrupted or monstrous cum filling out your eager womb.";
				kGAMECLASS.pc.slowStatGain("r", -3);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen +1
				kGAMECLASS.pc.lust(4);
			}, true);
			
			this.addStageProgression(48 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou rub your hands over your bulging belly, lost in the sensations of motherhood. ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "Afterwards you feel somewhat disgusted with yourself.";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "You estimate you'll give birth in the next few days.";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "You find yourself daydreaming about birthing demons repeatedly, each time being re-impregnated by your hordes of lusty adolescent children.";
			}, true);
			
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
					kGAMECLASS.giveBirthToImps(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			StatTracking.track("coc/pregnancy/imps birthed", 1);
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