package classes.GameData.Pregnancy.Handlers 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.PregnancyData;
	import classes.kGAMECLASS;
	import classes.Engine.Interfaces.ParseText;
	import classes.GameData.StatTracking;
	
	public class CoCAnemonePregnancy extends BasePregnancyHandler
	{
		
		public function CoCAnemonePregnancy() 
		{
			_handlesType = "CoCAnemonePregnancy";
			_basePregnancyIncubationTime = 10.25 * 24 * 60;
			_basePregnancyChance = 0.1;
			_alwaysImpregnate = false;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = false;
			_ignoreFatherInfertility = false;
			_allowMultiplePregnancies = false;
			_canImpregnateButt = false;
			_canImpregnateVagina = true;
			_canFertilizeEggs = true;
			_pregnancyQuantityMinimum = 1;
			_pregnancyQuantityMaximum = 1;
			_definedAverageLoadSize = 100;
			
			this.addStageProgression(240 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 3, true);
				kGAMECLASS.eventBuffer += "\n\nYou feel something shifting and moving inside you.  You start to think you might be pregnant.";
			}, true);
			
			this.addStageProgression(210 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 3, true);
				kGAMECLASS.eventBuffer += "\n\nThe fluttering of sensation inside you is getting stronger and more frequent.  At times it even feels as if the inner lining of your womb is tingling.";
				kGAMECLASS.pc.lust(5 + kGAMECLASS.pc.libido() / 20);
			}, true);
			
			this.addStageProgression(185 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 3, true);
			}, true);
			
			this.addStageProgression(154 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 3, true);
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 3, true);
				kGAMECLASS.pc.lust(10 + kGAMECLASS.pc.libido() / 20);
				kGAMECLASS.eventBuffer += "Your larger, squirming belly makes your pregnancy obvious for those around you and keeps you aroused from the constant tingling in your womb.";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 3, true);
				kGAMECLASS.pc.lust(10 + kGAMECLASS.pc.libido() / 20);
				kGAMECLASS.eventBuffer += "Your belly is noticeably distended, and constantly shifts and wriggles.  What manner of beast are you bringing into the world?";
			}, true);
			
			this.addStageProgression(48 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 3, true);
				kGAMECLASS.pc.lust(10 + kGAMECLASS.pc.libido() / 20);
				kGAMECLASS.eventBuffer += "\n\nYou note that your swollen belly is shifting awkwardly.";
			}, true);
			
			_onSuccessfulImpregnation = CoCAnemonePregnancyOnSuccessfulImpregnantion;
			_onDurationEnd = CoCAnemonePregnancyOnDurationEnd;
		}
		
		public static function CoCAnemonePregnancyOnSuccessfulImpregnantion(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			BasePregnancyHandler.defaultOnSuccessfulImpregnation(father, mother, pregSlot, thisPtr);
			
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			pData.pregnancyBellyRatingContribution += 2 * pData.pregnancyQuantity;
			mother.bellyRatingMod += 2 * pData.pregnancyQuantity;
		}
		
		public static function CoCAnemonePregnancyOnDurationEnd(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// Closure ensures that we will call the targetted output function (thus it will have access
			// to various pregnancy data) prior to cleaning up the pregnancy data itself. Magic.
			var tEventCall:Function = (function(c_mother:Creature, c_pregSlot:int, c_thisPtr:BasePregnancyHandler):Function
			{
				return function():void
				{
					kGAMECLASS.CoCAnemonePregnancyPregnancyBirthing(c_pregSlot);
					CoCAnemonePregnancy.cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
						
			pData.reset();
		}
	}

}