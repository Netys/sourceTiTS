package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCBunnyPregnancy extends BasePregnancyHandler
	{
		public function CoCBunnyPregnancy() 
		{
			_handlesType = "CoCBunnyPregnancy";
			_basePregnancyIncubationTime = 200 * 60; // 8 days
			_basePregnancyChance = 1;
			_alwaysImpregnate = true;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = true;
			_ignoreFatherInfertility = true;
			_allowMultiplePregnancies = true;
			_canImpregnateButt = true;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 2;
			_pregnancyQuantityMaximum = 2;
			_definedAverageLoadSize = 1000;
			
			this.addStageProgression(198 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou realize your belly has gotten slightly larger.  Maybe there's some truth to what the bunny-girl said.";
			}, true);
			
			this.addStageProgression(178 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is getting more noticeably distended.   You are probably pregnant.";
			}, true);
			
			this.addStageProgression(156 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe unmistakable bulge of pregnancy is visible in your tummy. ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "You find yourself wondering what giving birth to bunny-girls is like.";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "You dreamily wonder if you could find a bunny willing to put more than two eggs inside you at once.";
				
				kGAMECLASS.pc.slowStatGain("r", -1);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen 1
				kGAMECLASS.pc.lust(2);
			}, true);
			
			this.addStageProgression(140 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe sudden impact of a kick from inside your womb startles you, and it's immediately followed by a second on the other side.";
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour ever-growing belly makes your pregnancy obvious for those around you.";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is painfully distended, ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "making it difficult to function.";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "and you wonder how much longer you have to wait.";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "and you're eager to give birth so you'll be able to get pregnant again.";
				
				kGAMECLASS.pc.slowStatGain("r", -3);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen +1
				kGAMECLASS.pc.lust(4);
			}, true);
			
			this.addStageProgression(48 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou rub your hands over your bulging belly, lost in the sensations of motherhood. ";
				if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "Afterwards you feel somewhat disgusted with yourself.";
				if (kGAMECLASS.pc.cor() >= 40 && kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "You estimate you'll give birth in the next few days.";
				if (kGAMECLASS.pc.cor() >= 75) kGAMECLASS.eventBuffer += "You find yourself daydreaming about birthing bunnies repeatedly, each time being re-impregnated with dozens of eggs from your lusty adolescent children.";
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
			if (mother.bunnyScore() < 4 || pregSlot == 3) // butt preg or not bunny enough results in TFing fake pregnancy
			{
				CoCBunnyEggPregnancy.defaultOnSuccessfulImpregnation(father, mother, pregSlot, thisPtr);
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
					kGAMECLASS.giveBirthToBunny(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			StatTracking.track("coc/pregnancy/bunny", 1);
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