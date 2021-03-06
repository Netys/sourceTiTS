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
			_basePregnancyChance = 0.15;
			_alwaysImpregnate = false;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = false;
			_ignoreFatherInfertility = false;
			_allowMultiplePregnancies = false;
			_canImpregnateButt = false;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 1;
			_pregnancyQuantityMaximum = 1;
			_definedAverageLoadSize = 100;
			
			this.addStageProgression(240 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				kGAMECLASS.eventBuffer += "\n\nYou feel something shifting and moving inside you.  You start to think you might be pregnant.";
			}, true);
			
			this.addStageProgression(210 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				kGAMECLASS.eventBuffer += "\n\nThe fluttering of sensation inside you is getting stronger and more frequent.  At times it even feels as if the inner lining of your womb is tingling.";
				kGAMECLASS.pc.lust(5 + kGAMECLASS.pc.libido() / 20);
			}, true);
			
			this.addStageProgression(185 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
			}, true);
			
			this.addStageProgression(154 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				kGAMECLASS.eventBuffer += "\n\nYou note that your swollen belly is shifting awkwardly.";
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				kGAMECLASS.pc.lust(10 + kGAMECLASS.pc.libido() / 20);
				kGAMECLASS.eventBuffer += "\n\nYour belly is noticeably distended, and constantly shifts and wriggles.  What manner of beast are you bringing into the world?";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				kGAMECLASS.pc.lust(10 + kGAMECLASS.pc.libido() / 20);
				kGAMECLASS.eventBuffer += "\n\nYour larger, squirming belly makes your pregnancy obvious for those around you and keeps you aroused from the constant tingling in your womb.";
			}, true);
			
			this.addStageProgression(48 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				kGAMECLASS.pc.lust(10 + kGAMECLASS.pc.libido() / 20);
			}, true);
			
			_onSuccessfulImpregnation = CoCAnemonePregnancyOnSuccessfulImpregnantion;
			_onDurationEnd = CoCAnemonePregnancyOnDurationEnd;
		}
		
		public static function CoCAnemonePregnancyOnSuccessfulImpregnantion(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			if (pregSlot == -1) pregSlot = mother.findEmptyPregnancySlot(Creature.PREGSLOT_VAG);
			
			BasePregnancyHandler.defaultOnSuccessfulImpregnation(father, mother, pregSlot, thisPtr);
			
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
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
			StatTracking.track("coc/pregnancy/anemones birthed", pData.pregnancyQuantity);
			StatTracking.track("coc/pregnancy/total births", pData.pregnancyQuantity);
			
			pData.reset();
		}
		
		override public function pregBellyFragment(target:Creature, slot:int):String
		{
			var pData:PregnancyData = target.pregnancyData[slot];
			var retString:String = "";
			
			if(pData.pregnancyIncubation < 72 * 60) retString += "Your squirming belly makes your pregnancy obvious for those around you.";
			else if(pData.pregnancyIncubation < 120 * 60) retString += "Your belly is noticeably distended, and constantly shifts and wriggles.";
			
			return retString;
		}
	}

}