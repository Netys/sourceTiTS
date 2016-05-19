package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCFrogPregnancy extends BasePregnancyHandler
	{
		public function CoCFrogPregnancy()
		{
			_handlesType = "CoCFrogPregnancy";
			_basePregnancyIncubationTime = 30 * 60; // just a day and you can go for more, you buttslut...
			_basePregnancyChance = 1;
			_alwaysImpregnate = true;
			_ignoreInfertility = true;
			_ignoreMotherInfertility = true;
			_ignoreFatherInfertility = true;
			_allowMultiplePregnancies = false;
			_canImpregnateButt = true;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 8;
			_pregnancyQuantityMaximum = 12;
			_definedAverageLoadSize = 100;
			_pregnancyChildType = GLOBAL.CHILD_TYPE_EGGS;
			
			this.addStageProgression(8 * 60, function(pregSlot:int):void {
				if (pregSlot != 3) // vaginal
				{
					if (kGAMECLASS.pc.hasVagina()) {
						kGAMECLASS.eventBuffer += "\n\nYour gut churns, and with a squelching noise, a torrent of transparent slime gushes from your [pc.asshole]. You immediately fall to your knees, landing wetly amidst the slime. The world around briefly flashes with unbelievable colors, and you hear someone giggling.\n\nAfter a moment, you realize that it’s you. Against your [pc.vagina], the slime feels warm and cold at the same time, coaxing delightful tremors from your [pc.clit]. Seated in your own slime, you moan softly, unable to keep your hands off yourself.";
						kGAMECLASS.pc.lust(kGAMECLASS.pc.lustMax(), true);
					}
					else kGAMECLASS.eventBuffer += "\n\nYour gut churns, but after a moment it settles. Your belly does seem a bit bigger and more gravid afterward, like you're filling up with fluid without any possible vent. You suddenly wonder if losing your pussy was such a great idea.";
				}
				else // anal
				{
					kGAMECLASS.eventBuffer += "\n\nYour gut churns, and with a squelching noise, a torrent of transparent slime gushes from your ass.  You immediately fall to your knees, landing wetly amidst the slime.  The world around briefly flashes with unbelievable colors, and you hear someone giggling.\n\nAfter a moment, you realize that it’s you.";
					if (kGAMECLASS.pc.hasVagina()) kGAMECLASS.eventBuffer += " Against your [pc.vagina], the slime feels warm and cold at the same time, coaxing delightful tremors from your [pc.clit].";
					else if (kGAMECLASS.pc.balls > 0) kGAMECLASS.eventBuffer += " Slathered in hallucinogenic frog slime, your [pc.balls] tingle, sending warm pulses of pleasure all the way up into your brain.";
					else if (kGAMECLASS.pc.hasCock()) kGAMECLASS.eventBuffer += " Splashing against the underside of your [pc.cocksLight], the slime leaves a warm, oozy sensation that makes you just want to rub [pc.eachCock] over and over and over again.";
					else kGAMECLASS.eventBuffer += " Your asshole begins twitching, aching for something to push through it over and over again.";
					kGAMECLASS.eventBuffer += " Seated in your own slime, you moan softly, unable to keep your hands off yourself.";
					kGAMECLASS.pc.lust(kGAMECLASS.pc.lustMax(), true);
				}
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
			
			kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 4, true);
		}
		
		public static function OverrideOnDurationEnd(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// Closure ensures that we will call the targetted output function (thus it will have access
			// to various pregnancy data) prior to cleaning up the pregnancy data itself. Magic.
			var tEventCall:Function = (function(c_mother:Creature, c_pregSlot:int, c_thisPtr:BasePregnancyHandler):Function
			{
				return function():void
				{
					if (c_pregSlot == 3) kGAMECLASS.birthFrogEggsAnal(c_pregSlot);
					else kGAMECLASS.layFrogEggs(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			StatTracking.track("coc/pregnancy/frog", 1);
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