package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCSandWitchPregnancy extends BasePregnancyHandler
	{
		public function CoCSandWitchPregnancy() 
		{
			_handlesType = "CoCSandWitchPregnancy";
			_basePregnancyIncubationTime = 360 * 60; // 12 days
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
			
			this.addStageProgression(336 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour breasts have felt unusually heavy recently, and a strange pulsing sensation occasionally emanates from them.  Your appetite is a little off; you could really go for some milk...";
			}, true);
			
			this.addStageProgression(280 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou've been having strange dreams recently, about seeds growing before your eyes into beautiful flowers; what's really weird is the sense of pride and maternal contentment that seeing them bloom makes you feel.  Your breasts are definitely heavier than normal, and sometimes you wake up to find them damp; are you ";
				if(!kGAMECLASS.pc.canLactate()) kGAMECLASS.eventBuffer += "starting to lactate";
				else kGAMECLASS.eventBuffer += "lactating more";
				kGAMECLASS.eventBuffer += "?  Your belly is even bulging a little bit more than food can explain.";
				
				kGAMECLASS.pc.boostLactation(Math.max(60 - kGAMECLASS.pc.milkMultiplier, 15));
				
			}, true);
			
			this.addStageProgression(216 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour breasts have definitely grown bigger, and they occasionally trickle milk.  More importantly than that, your stomach is bulging out in a small but unquestionable pot belly.  You're definitely pregnant.";
				
				Mutator.growTits(kGAMECLASS.pc, 1, 1, false, 3);
				kGAMECLASS.pc.boostLactation(Math.max(60 - kGAMECLASS.pc.milkMultiplier, 10));
			}, true);
			
			this.addStageProgression(180 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly continues to grow, the hormones triggering your milk's production to kick it up a notch.  Your breasts are so heavy and sensitive, aching to be used to feed life-giving milk to something.";
				
				Mutator.growTits(kGAMECLASS.pc, 1, 1, false, 3, 10);
				kGAMECLASS.pc.boostLactation(Math.max(60 - kGAMECLASS.pc.milkMultiplier, 10));
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYou sometimes catch yourself humming to your unborn child, stroking your belly like a contented mother.  At other times, you catch yourself proudly stroking your swollen breasts, admiring the way it makes the milk spurt and flow.";
				
				Mutator.growTits(kGAMECLASS.pc, 1, 1, false, 3, 10);
				kGAMECLASS.pc.boostLactation(Math.max(60 - kGAMECLASS.pc.milkMultiplier, 10));
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nMilk dribbles constantly out of your nipples now, in many ways being harder to deal with than the ever-increasing swell of your midriff.  The scent of milk hangs in the air around you constantly, giving you a craving to suckle almost as bad as your breasts' need to be suckled from.";
				
				Mutator.growTits(kGAMECLASS.pc, 1, 1, false, 3, 10);
				kGAMECLASS.pc.boostLactation(Math.max(60 - kGAMECLASS.pc.milkMultiplier, 10));
			}, true);
			
			this.addStageProgression(48 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour stomach hangs out, heavy and round as any full-term mother's back in Ingnam, your breasts feeling almost as taut and swollen, as if jealous of the life nearly grown inside your womb.  At morning, you find yourself milking your breasts until the cascading fluid ends up glazing your engorged stomach in a beautiful liquid white sheen, not that it seems to make much difference to your production.  You can only hope whatever's growing inside you will be hungry enough to keep up with all the food you'll have for it...";
				
				Mutator.growTits(kGAMECLASS.pc, 1, 1, false, 3, 10);
				kGAMECLASS.pc.boostLactation(Math.max(60 - kGAMECLASS.pc.milkMultiplier, 10));
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
					kGAMECLASS.birthAWitch(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			StatTracking.track("coc/pregnancy/pc sand witch", 1);
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