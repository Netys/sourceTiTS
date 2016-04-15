package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.num2Text;
	import classes.Engine.Utility.rand;
	import classes.GameData.Pregnancy.PregnancyManager;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.Items.Transformatives.CoCEggs.*;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	import classes.GLOBAL;
	
	public class CoCOviElixEggs extends BasePregnancyHandler
	{
		
		public function CoCOviElixEggs() 
		{
			_handlesType = "CoCOviElixEggs";
			_basePregnancyIncubationTime = 50 * 60;
			_basePregnancyChance = 0.25;
			_alwaysImpregnate = false;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = false;
			_ignoreFatherInfertility = false;
			_allowMultiplePregnancies = true;
			_canImpregnateButt = false;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 5;
			_pregnancyQuantityMaximum = 7;
			_pregnancyChildType = GLOBAL.CHILD_TYPE_EGGS;
			
			var large:Boolean = kGAMECLASS.pc.statusEffectv2("MagicColorfulEggs") == 1;
			
			this.addStageProgression(10 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, large ? 2 : 1, true);
			}, true);
			
			this.addStageProgression(20 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, large ? 2 : 1, true);
			}, true);
			
			this.addStageProgression(30 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, large ? 2 : 1, true);
			}, true);
			
			this.addStageProgression(40 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, large ? 2 : 1, true);
			}, true);
			
			onTryImpregnate = oviOnTry;
			onSuccessfulImpregnation = oviOnSuccessfulImpregnantion;
			onDurationEnd = oviOnDurationEnd;
		}
		
		public static function oviOnTry(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):Boolean
		{
			return father == mother || defaultOnTryImpregnate(father, mother, pregSlot, thisPtr); // handled in elexir itself
		}
		public static function oviOnSuccessfulImpregnantion(father:Creature, mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// Check if we have a valid pregnancy slot defined
			if (pregSlot == -1)
			{
				// Find the first available pregnancy slot on the mother, else return a failure
				var slotType:uint;
				
				if (thisPtr.canImpregnateButt && thisPtr.canImpregnateVagina) slotType = Creature.PREGSLOT_ANY;
				else if (!thisPtr.canImpregnateButt) Creature.PREGSLOT_VAG;
				else if (!thisPtr.canImpregnateVagina) Creature.PREGSLOT_ASS;
				
				pregSlot = mother.findEmptyPregnancySlot(slotType);
				
				if (pregSlot == -1)
				{
					if (thisPtr.debugTrace) trace("No valid pregnancy slots available, aborting.");
					return;
				}
				
				if (thisPtr.debugTrace) trace("Autosetting pregnancy to slot " + pregSlot);
			}
			
			// Fail if the targetted hole is already pregnant
			if ((mother.pregnancyData[pregSlot] as PregnancyData).pregnancyType != "")
			{
				return;
			}
			
			BasePregnancyHandler.defaultOnSuccessfulImpregnation(father, mother, pregSlot, thisPtr);
			
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			pData.pregnancyBellyRatingContribution += 2 * pData.pregnancyQuantity;
			mother.bellyRatingMod += 2 * pData.pregnancyQuantity;
			if (!mother.hasStatusEffect("MagicColorfulEggs")) mother.createStatusEffect("MagicColorfulEggs", rand(6), 0, 0, 0);
			if (mother.hasPerk("Harpy Womb") && mother.legType == GLOBAL.TYPE_AVIAN && mother.hasTail(GLOBAL.TYPE_AVIAN)) mother.setStatusValue("MagicColorfulEggs", 2, 1);
		}
		
		public static function oviOnDurationEnd(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// Closure ensures that we will call the targetted output function (thus it will have access
			// to various pregnancy data) prior to cleaning up the pregnancy data itself. Magic.
			var tEventCall:Function = (function(c_mother:Creature, c_pregSlot:int, c_thisPtr:BasePregnancyHandler):Function
			{
				return function():void
				{
					CoCOviElixEggs.OviPregnancyBirthing(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			
			pData.reset();
		}
		
		public static function OviPregnancyBirthing(slot:int):void {
			kGAMECLASS.clearOutput();
			if(kGAMECLASS.pc.vaginas.length == 0) {
				kGAMECLASS.output("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n\n");
				kGAMECLASS.pc.createVagina();
			}
			var color:int = kGAMECLASS.pc.statusEffectv1("MagicColorfulEggs");
			var large:Boolean = kGAMECLASS.pc.statusEffectv2("MagicColorfulEggs") == 1;
			var pData:PregnancyData = kGAMECLASS.pc.pregnancyData[slot] as PregnancyData;
			var egg:ItemSlotClass = getEgg();
			var descript:String = num2Text(pData.pregnancyQuantity) + " " + egg.longName + "s";
			kGAMECLASS.pc.removeStatusEffect("MagicColorfulEggs");
			
			//Small egg scenes
			if(!large) {
				//light quantity
				if(pData.pregnancyQuantity < 10) {
					kGAMECLASS.output("You are interrupted as you find yourself overtaken by an uncontrollable urge to undress and squat.   You berate yourself for giving in to the urge for a moment before feeling something shift.  You hear the splash of fluid on the ground and look down to see a thick greenish fluid puddling underneath you.  There is no time to ponder this development as a rounded object passes down your birth canal, spreading your feminine lips apart and forcing a blush to your cheeks.  It plops into the puddle with a splash, and you find yourself feeling visibly delighted to be laying such healthy eggs.   Another egg works its way down and you realize the process is turning you on more and more.   In total you lay " + descript + ", driving yourself to the very edge of orgasm.");
					kGAMECLASS.pc.lust(kGAMECLASS.pc.lustMax(), true);
  				}
				//High quantity
				else {
					kGAMECLASS.output("A strange desire overwhelms your sensibilities, forcing you to shed your [pc.gear] and drop to your hands and knees.   You manage to roll over and prop yourself up against a smooth rock, looking down over your pregnant-looking belly as green fluids leak from you, soaking into the ground.   A powerful contraction rips through you and your legs spread instinctively, opening your [pc.vagina] to better deposit your precious cargo.   You see the rounded surface of an egg peek through your lips, mottled with strange colors.   You push hard and it drops free with an abrupt violent motion.  The friction and slimy fluids begin to arouse you, flooding your groin with heat as you feel the second egg pushing down.  It slips free with greater ease than the first, arousing you further as you bleat out a moan from the unexpected pleasure.  Before it stops rolling on the ground, you feel the next egg sliding down your slime-slicked passage, rubbing you perfectly as it slides free.  You lose count of the eggs and begin to masturbate, ");
					if(kGAMECLASS.pc.clitLength > 5) kGAMECLASS.output("jerking on your huge clitty as if it were a cock, moaning and panting as each egg slides free of your diminishing belly.  You lubricate it with a mix of your juices and the slime until ");
					if(kGAMECLASS.pc.clitLength > 2 && kGAMECLASS.pc.clitLength <= 5) kGAMECLASS.output("playing with your over-large clit as if it were a small cock, moaning and panting as the eggs slide free of your diminishing belly.  You spread the slime and cunt juice over it as you tease and stroke until ");
					if(kGAMECLASS.pc.clitLength <= 2) kGAMECLASS.output("pulling your folds wide and playing with your clit as another egg pops free from your diminishing belly.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself until ", false); 
					kGAMECLASS.output("you quiver in orgasm, popping out the last of your eggs as your body twitches nervelessly on the ground.   In total you lay " + descript + ".");
					kGAMECLASS.pc.orgasm();
				}
			}
			//Large egg scene
			else {
				kGAMECLASS.output("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees.  You realize something is about to be birthed, and you shed your [pc.gear] before it can be ruined by what's coming.  A contraction pushes violently through your midsection, ");
				if(kGAMECLASS.pc.vaginas[0].looseness() < 3) kGAMECLASS.output("stretching your tight cunt painfully, the lips opening wide ");
				else if(kGAMECLASS.pc.vaginas[0].looseness() >= 3 && kGAMECLASS.pc.vaginas[0].looseness() < 5) kGAMECLASS.output("temporarily stretching your cunt-lips wide-open ");
				else kGAMECLASS.output("parting your already gaping lips wide ");
				kGAMECLASS.output("as something begins sliding down your passage.  A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips.  You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.  The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably.   You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips.  The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure.  Aroused beyond reasonable measure, you begin to masturbate ");
				if(kGAMECLASS.pc.clitLength > 5) kGAMECLASS.output("your massive cock-like clit, jacking it off with the slimy birthing fluids as lube.   It pulses and twitches in time with your heartbeats, its sensitive surface overloading your fragile mind with pleasure.  ", false);
				if(kGAMECLASS.pc.clitLength > 2 && kGAMECLASS.pc.clitLength <= 5) kGAMECLASS.output("your large clit like a tiny cock, stroking it up and down between your slime-lubed thumb and fore-finger.  It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure.  ");
				if(kGAMECLASS.pc.clitLength <= 2) kGAMECLASS.output("your [pc.vagina] by pulling your folds wide and playing with your clit.  Another egg pops free from your diminishing belly, accompanied by an audible burst of relief.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself.  ", false);
				kGAMECLASS.output("You cum hard, the big eggs each making your cunt gape wide just before popping free.  You slump down, exhausted and barely conscious from the force of the orgasm.  ");
				if(pData.pregnancyQuantity >= 11) kGAMECLASS.output("Your swollen belly doesn't seem to be done with you, as yet another egg pushes its way to freedom.   The stimulation so soon after orgasm pushes you into a pleasure-stupor.  If anyone or anything discovered you now, they would see you collapsed next to a pile of eggs, your fingers tracing the outline of your [pc.vagina] as more and more eggs pop free.  In time your wits return, leaving you with the realization that you are no longer pregnant.  ");
				kGAMECLASS.output("\n\nYou gaze down at the mess, counting " + descript + ".");
				kGAMECLASS.pc.orgasm();
			}
			StatTracking.track("coc/pregnancy/unfertilized eggs", pData.pregnancyQuantity);
			kGAMECLASS.output("\n\n<b>You feel compelled to leave the eggs behind, ");
			if(kGAMECLASS.flags["COC.ATE_COLORED_EGG"] != undefined) kGAMECLASS.output("but you remember the effects of the last one you ate.\n</b>");
			else kGAMECLASS.output("but your body's intuition reminds you they shouldn't be fertile, and your belly rumbles with barely contained hunger.\n</b>");
			kGAMECLASS.pc.cuntChange(slot, 20, true);
			kGAMECLASS.clearMenu();
			kGAMECLASS.itemScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.lootScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.useItemFunction = kGAMECLASS.mainGameMenu;
			kGAMECLASS.itemCollect([egg]);
		}
		
		/*color descriptor
		0 - brown - ass expansion
		1 - purple - hip expansion
		2 - blue - vaginal removal and/or growth of existing maleness
		3 - pink - dick removal and/or fertility increase.
		4 - white - breast growth.  If lactating increases lactation.
		5 - rubbery black - 
		*/
		public static function getEgg():ItemSlotClass {
			var color:int = kGAMECLASS.pc.statusEffectv1("MagicColorfulEggs");
			var large:Boolean = kGAMECLASS.pc.statusEffectv2("MagicColorfulEggs") == 1;
			if (kGAMECLASS.pc.hasPerk("Harpy Womb") && kGAMECLASS.pc.legType == GLOBAL.TYPE_AVIAN && kGAMECLASS.pc.hasTail(GLOBAL.TYPE_AVIAN)) large = true;
			var egg:ItemSlotClass;
			switch(color)
			{
				case 0:
					egg = large? new CoCBrownEggLarge() : new CoCBrownEgg();
					break;
				case 1:
					egg = large? new CoCPurpleEggLarge() : new CoCPurpleEgg();
					break;
				case 2:
					egg = large? new CoCBlueEggLarge() : new CoCBlueEgg();
					break;
				case 3:
					egg = large? new CoCPinkEggLarge() : new CoCPinkEgg();
					break;
				case 4:
					egg = large? new CoCWhiteEggLarge() : new CoCWhiteEgg();
					break;
				case 5:
					egg = large? new CoCBlackEggLarge() : new CoCBlackEgg();
					break;
			}
			return egg;
		}
		
		override public function pregBellyFragment(target:Creature, slot:int):String
		{
			var pData:PregnancyData = target.pregnancyData[slot];
			var retString:String = "";
			
			retString += "You are carrying unfertilized eggs.";
			
			return retString;
		}
	}
}