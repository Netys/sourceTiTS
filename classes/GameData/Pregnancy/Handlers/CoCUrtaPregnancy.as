package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCUrtaPregnancy extends BasePregnancyHandler
	{
		public function CoCUrtaPregnancy() 
		{
			_handlesType = "CoCUrtaPregnancy";
			_basePregnancyIncubationTime = 515 * 60; // 21 day
			_basePregnancyChance = 0.15;
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
			
			this.addStageProgression(504 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou're feeling a bit nauseated.  Your mind floats to Urta and you wonder if maybe this means her seed took...";
			}, true);
			
			this.addStageProgression(432 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventQueue.push(function():*{ kGAMECLASS.urtaPregooUpdates(1); } );
			}, true);
			
			this.addStageProgression(360 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventQueue.push(function():*{ kGAMECLASS.urtaPregooUpdates(2); } );
			}, true);
			
			this.addStageProgression(288 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventQueue.push(function():*{ kGAMECLASS.urtaPregooUpdates(3); } );
			}, true);
			
			this.addStageProgression(216 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventQueue.push(function():*{ kGAMECLASS.urtaPregooUpdates(4); } );
			}, true);
			
			this.addStageProgression(144 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventQueue.push(function():*{ kGAMECLASS.urtaPregooUpdates(5); } );
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventQueue.push(function():*{ kGAMECLASS.urtaPregooUpdates(6); } );
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
					kGAMECLASS.PCGivesBirf(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			//StatTracking.track("coc/pregnancy/pc cotton", 1); // handled in birthingCottonsKids
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