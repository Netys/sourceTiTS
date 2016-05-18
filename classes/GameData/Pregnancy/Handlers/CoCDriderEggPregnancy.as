package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCDriderEggPregnancy extends BasePregnancyHandler
	{
		public function CoCDriderEggPregnancy() // basically simplified copy-paste
		{
			_handlesType = "CoCDriderEggPregnancy";
			_basePregnancyIncubationTime = 200 * 60; // 8 days
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
			
			this.addStageProgression(199 * 60, function(pregSlot:int):void {
				kGAMECLASS.eventBuffer += "\n\nAfter your session with the drider, you feel so nice and... full.  There is no outward change on your body, aside from the egg-packed bulge of your belly, but your " + player.assholeDescript() + " tingles slightly and leaks green goop from time to time. Hopefully it's nothing to be alarmed about.";
			}, true);
			
			this.addStageProgression(180 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nA hot flush works its way through you, and visions of aroused driders quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and packed completely full of eggs, stuffing your belly completely with burgeoning spheres of love.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?";
				
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen +1
				kGAMECLASS.pc.lust(20);
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is bulging from the size of the eggs growing inside you and gurgling just about any time you walk.  Green goo runs down your [pc.legs] frequently, drooling out of your pregnant asshole.";
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 2, true);
				
				kGAMECLASS.eventBuffer += "\n\nThe huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.";
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
					kGAMECLASS.birthSpiderEggsFromAnusITSBLEEDINGYAYYYYY(c_pregSlot);
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