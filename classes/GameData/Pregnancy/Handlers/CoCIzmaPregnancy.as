package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCIzmaPregnancy extends BasePregnancyHandler
	{
		public function CoCIzmaPregnancy() 
		{
			_handlesType = "CoCIzmaPregnancy";
			_basePregnancyIncubationTime = 300 * 60; // 12 days
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
			
			this.addStageProgression(275 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				if (kGAMECLASS.izmaFollower()) kGAMECLASS.eventBuffer += "\n\nYou wake up feeling kind of nauseous.  Izma insists that you stay in bed and won't hear a word otherwise, tending to you in your sickened state.  When you finally feel better, she helps you up.  \"<i>You know, [pc.name]... I think you might be pregnant.</i>\" Izma says, sounding very pleased at the idea. You have to admit, you do seem to have gained some weight...";
				else kGAMECLASS.eventBuffer += "\n\nYou wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some fish.";
			}, true);
			
			this.addStageProgression(250 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				kGAMECLASS.eventBuffer += "\n\nYour belly is getting more noticeably distended and squirming around.  You are probably pregnant.";
			}, true);
			
			this.addStageProgression(216 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				if (kGAMECLASS.izmaFollower()) kGAMECLASS.eventBuffer += "\n\nYour stomach is undeniably swollen now, and you feel thirsty all the time. Izma is always there to bring you water, even anticipating your thirst before you recognize it yourself. She smiles all the time now, and seems to be very pleased with herself.";
				else kGAMECLASS.eventBuffer += "There is no question you're pregnant; your belly is getting bigger and for some reason, you feel thirsty ALL the time.";
				
				kGAMECLASS.pc.slowStatGain("r", -1);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen 1
				kGAMECLASS.pc.lust(2);
			}, true);
			
			this.addStageProgression(180 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				if (kGAMECLASS.izmaFollower()) {
					kGAMECLASS.eventBuffer += "\n\nThere is no denying your pregnancy, and Izma is head-over-heels with your 'beautifully bountiful new body', as she puts it. She is forever finding an excuse to touch your bulging stomach, and does her best to coax you to rest against her.";
					if(kGAMECLASS.izma.hasCock()) kGAMECLASS.eventBuffer += "However, when you do sit against her, she invariably starts getting hard underneath you."
				}
				else kGAMECLASS.eventBuffer += "There is no denying your pregnancy. Your belly bulges and occasionally squirms as your growing offspring shifts position.";
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				if (kGAMECLASS.izmaFollower()) kGAMECLASS.eventBuffer += "\n\nYour stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling. Izma is always on hand now, it seems, and she won't dream of you fetching your own food or picking up anything you've dropped. She's always dropping hints about how you should try going around naked for comfort's sake. While you are unwilling to do so, you find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.";
				else kGAMECLASS.eventBuffer += "Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling.  You find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.";
				
				kGAMECLASS.pc.slowStatGain("r", -2);
				kGAMECLASS.pc.slowStatGain("l", 1);
				// sen 1
				kGAMECLASS.pc.lust(4);
			}, true);
			
			this.addStageProgression(72 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 5, true);
				
				if (kGAMECLASS.izmaFollower()) kGAMECLASS.eventBuffer += "\n\nYou dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in. Izma makes no secret of her pleasure and informs you that you should deliver soon.";
				else kGAMECLASS.eventBuffer += "You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in.  The time for delivery will probably come soon.";
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
					kGAMECLASS.pcPopsOutASharkTot(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			//StatTracking.track("coc/pregnancy/pc sharkgirls", 1); // handled in pcPopsOutASharkTot, possible tigershark
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