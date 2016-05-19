package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Interfaces.output;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.Items.Transformatives.CoCNeonPinkEgg;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCBunnyEggPregnancy extends BasePregnancyHandler
	{
		public function CoCBunnyEggPregnancy() 
		{
			_handlesType = "CoCBunnyEggPregnancy";
			_basePregnancyIncubationTime = 64 * 60; // 2 days
			_basePregnancyChance = 1;
			_alwaysImpregnate = true;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = true;
			_ignoreFatherInfertility = true;
			_allowMultiplePregnancies = true;
			_canImpregnateButt = true;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 1;
			_pregnancyQuantityMaximum = 1;
			_definedAverageLoadSize = 1000;
			_pregnancyChildType = GLOBAL.CHILD_TYPE_EGGS;
			
			this.addStageProgression(56 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, -5, false);
				
				if (pregSlot == 3) kGAMECLASS.eventBuffer += "\n\nYour gut gurgles strangely.";
				else kGAMECLASS.eventBuffer += "\n\nYour womb gurgles strangely.";
			}, true);
			
			this.addStageProgression(41 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, -5, false);
				
				CoCNeonPinkEgg.useNeonPinkEgg(kGAMECLASS.pc, true);
			}, true);
			
			this.addStageProgression(32 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, -5, false);
				
				if (pregSlot == 3) kGAMECLASS.eventBuffer += "\n\nYour gut feels full and bloated.";
				else kGAMECLASS.eventBuffer += "\n\nYour womb feels full and bloated.";
				
				kGAMECLASS.pc.slowStatGain("r", -1);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen 1
				kGAMECLASS.pc.lust(2);
			}, true);
			
			this.addStageProgression(21 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, -5, false);
				
				CoCNeonPinkEgg.useNeonPinkEgg(kGAMECLASS.pc, true);
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
			mother.addPregnancyBellyMod(pregSlot, 30, true);
			defaultOnSuccessfulImpregnation(father, mother, pregSlot, thisPtr);
			
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
		}
		
		public static function OverrideOnDurationEnd(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// not actual pregnancy, just clear it
			kGAMECLASS.eventBuffer += "\n\nAfter dealing with the discomfort and bodily changes for the past day or so, you finally get the feeling that the eggs in your womb have dissolved.";
			cleanupPregnancy(mother, pregSlot, thisPtr);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			// not actual pregnancy - no stats
			
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