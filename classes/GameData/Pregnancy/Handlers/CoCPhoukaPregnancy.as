package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCPhoukaPregnancy extends BasePregnancyHandler
	{
		public function CoCPhoukaPregnancy() 
		{
			_handlesType = "CoCPhoukaPregnancy";
			_basePregnancyIncubationTime = 200 * 60; // 6 days
			_basePregnancyChance = 0.50;
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
			_definedAverageLoadSize = 25000;
			
			this.addStageProgression(170 * 60, function(pregSlot:int):void {
				if (kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 0)
					kGAMECLASS.eventBuffer += "\n\nYour belly still feels solid and heavy. Whatever is growing inside doesn't want you to move around very much. You might as well sit around at camp until you force it out.";
				else
					kGAMECLASS.eventBuffer += "\n\nYour belly still feels solid and heavy, but for some reason you feel energized and want to enjoy life. You could really go for a stroll through the forest.";
			}, true);
			
			this.addStageProgression(140 * 60, function(pregSlot:int):void {
				if (kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 0)
					kGAMECLASS.eventBuffer += "\n\nYour belly feels a bit softer now. Every once in a while you feel something tiny bump against the inside of your womb.";
				else
					kGAMECLASS.eventBuffer += "\n\nYour belly feels a bit softer now. Every once in a while you feel a fluttering against the wall of your womb, almost as if something is flying around in there.";
			}, true);
			
			this.addStageProgression(100 * 60, function(pregSlot:int):void {
				kGAMECLASS.eventBuffer += "\n\nYour belly feels like it's full of liquid, more like a normal pregnancy. ";
				if (kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 0)
					kGAMECLASS.eventBuffer += "That part is more comfortable for you. Too bad you feel like that liquid is stale and tainted. ";
				else
					kGAMECLASS.eventBuffer += "It's much more comfortable for you. Whenever you rub your belly you feel so full of life and vitality. ";
				kGAMECLASS.eventBuffer += "You've noticed that this pregnancy doesn't seem to be affecting your breasts. It's as if the child inside you has no use for your milk.";
			}, true);
			
			this.addStageProgression(60 * 60, function(pregSlot:int):void {
				if (kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 6)
					kGAMECLASS.eventBuffer += "\n\nWhatever unclean spawn is inside you hasn't grown very much. Your belly is still packed with tainted fluid and you find it difficult to keep food down. You constantly experience urges to drink alcohol, the stronger the better.";
				else if (kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 0)
					kGAMECLASS.eventBuffer += "\n\nWhatever unclean spawn is inside you hasn't grown very much. Your belly is still packed with fluid, though it somehow feels less saturated and perhaps a little less tainted.";
				else
					kGAMECLASS.eventBuffer += "\n\nWhatever kind of life is inside you hasn't grown very much. Your belly is still packed with fluid, though it somehow feels less saturated.";
			}, true);
			
			this.addStageProgression(36 * 60, function(pregSlot:int):void {
				kGAMECLASS.eventBuffer += "\n\nEven though your belly remains the same size you somehow feel that your pregnancy is drawing to a close. ";
				if (kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 6)
					kGAMECLASS.eventBuffer += "Despite the small size of your belly you spend most of your time feeling deeply ill and you can't wait to force this thing out.  You can feel a constant dull pain from your womb and ovaries, probably the result of the tainted fluid inside you.  Only drinking alcohol settles your stomach.";
				else if (kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 0)
					kGAMECLASS.eventBuffer += "\n\nDespite the relatively small size of your belly, you spend most of your time feeling mildly ill and you can't wait to force this thing out.";
				else
					kGAMECLASS.eventBuffer += "\n\nDespite being pregnant you still don't feel restricted or slowed in any way.  It's as if the tiny life inside is living in harmony with you.";
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
			kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] = 2;
			kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 25, true);
			
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
					kGAMECLASS.phoukaPregBirth(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			//StatTracking.track("coc/pregnancy/phouka", 1); // handled inside phoukaPregBirth
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