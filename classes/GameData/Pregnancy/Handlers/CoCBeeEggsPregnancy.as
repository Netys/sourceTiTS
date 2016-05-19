package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCBeeEggsPregnancy extends BasePregnancyHandler
	{
		public function CoCBeeEggsPregnancy()
		{
			_handlesType = "CoCBeeEggsPregnancy";
			_basePregnancyIncubationTime = 48 * 60; // 2 days
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
			
			this.addStageProgression(36 * 60, function(pregSlot:int):void {
				kGAMECLASS.eventBuffer += "\n\nYou feel bloated, your bowels shifting uncomfortably from time to time.";
			}, true);
			
			this.addStageProgression(20 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				kGAMECLASS.eventBuffer += "\n\nA honey-scented fluid drips from your rectum.</b>  At first it worries you, but as the smell fills the air around you, you realize anything with such a beautiful scent must be good. ";
				if (kGAMECLASS.pc.cockTotal() > 0) {
					if (kGAMECLASS.pc.cockTotal() == 1) {
						kGAMECLASS.eventBuffer += "The aroma seems to permeate your very being, slowly congregating in your [pc.cockNoun]";
						if (kGAMECLASS.pc.cocks[0].hasFlag(GLOBAL.FLAG_FLARED)) kGAMECLASS.eventBuffer += ", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your [pc.cock] is twitching and dripping, the flare swollen and purple. ";
						else if (kGAMECLASS.pc.cocks[0].hasFlag(GLOBAL.FLAG_KNOTTED)) kGAMECLASS.eventBuffer += ", each inhalation making it thicker, harder, and firmer.  You suck in huge lungfuls of air, desperate for more, until your [pc.cock] is twitching and dripping, its knot swollen to the max. ";
						else if (kGAMECLASS.pc.cocks[0].hasFlag(GLOBAL.FLAG_TAPERED)) kGAMECLASS.eventBuffer += ", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air until your [pc.cock] is twitching and dripping. ";
						else kGAMECLASS.eventBuffer += ", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your [pc.cock] is twitching and dripping, the head swollen and purple. ";
					}
					if (kGAMECLASS.pc.cockTotal() > 1) kGAMECLASS.eventBuffer += "groin. [pc.EachCock] fill and grow with every lungful of the stuff you breathe in.  You suck in great lungfuls of the tainted air, desperate for more, your cocks twitching and dripping with need.  ";
				}
				kGAMECLASS.eventBuffer += "You smile knowing you couldn't stop from masturbating if you wanted to.";
				kGAMECLASS.pc.slowStatGain("i", -0.5);
				kGAMECLASS.pc.lust(kGAMECLASS.pc.lustMax(), true);
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
			StatTracking.track("coc/pregnancy/bees", 1);
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