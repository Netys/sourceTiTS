package classes.GameData.Pregnancy.Handlers 
{
	import classes.Creature;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.Pregnancy.BasePregnancyHandler;
	import classes.GameData.StatTracking;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.PregnancyData;
	
	public class CoCEmberPregnancy extends BasePregnancyHandler
	{
		public function CoCEmberPregnancy() 
		{
			_handlesType = "CoCEmberPregnancy";
			_basePregnancyIncubationTime = 336 * 60; // 14 days
			_basePregnancyChance = 1;
			_alwaysImpregnate = true;
			_ignoreInfertility = false;
			_ignoreMotherInfertility = false;
			_ignoreFatherInfertility = false;
			_allowMultiplePregnancies = false;
			_canImpregnateButt = false;
			_canImpregnateVagina = true;
			_canFertilizeEggs = false;
			_pregnancyQuantityMinimum = 1;
			_pregnancyQuantityMaximum = 1;
			_definedAverageLoadSize = 200;
			
			this.addStageProgression(330 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 1, true);
				
				if (kGAMECLASS.ember.hasPerk("Oviposition")) kGAMECLASS.eventBuffer += "\n\nYour belly has swollen, becoming larger - proof that Ember's seed did its work.  The dragon seems to be constantly checking you out, as if looking for the signs of weight gain.";
				else kGAMECLASS.eventBuffer += "\n\nYour belly is a bit swollen - either you're eating too much or Ember's seed really did the job.";
			}, true);
			
			this.addStageProgression(250 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 7, true);
				
				if (kGAMECLASS.ember.hasPerk("Oviposition")) kGAMECLASS.eventBuffer += "\n\nYour belly grows ever bigger, making your pregnancy noticeable; your belly also feels somewhat solid.  Ember casts pleased glances in your direction, whenever [ember.heShe] thinks you're not looking.";
				else kGAMECLASS.eventBuffer += "\n\nYour belly grows ever bigger, making your pregnancy noticeable.  Ember shoots you quick looks, trying to hide [ember.hisHer] smirk of success every time [ember.heShe] does.  You smirk right back at [ember.himHer], and occasionally make a subtle show of your gravid form, just to see [ember.himHer] get turned on by the sight.";
			}, true);
			
			this.addStageProgression(170 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 7, true);
				
				if (kGAMECLASS.ember.hasPerk("Oviposition")) {
					kGAMECLASS.eventBuffer += "You've grown a lot. Anyone is able to tell that you're pregnant with a single glance; and by the shape, you have no doubt that there's an egg in your womb; a big one.";
					//(If Corruption < 40)
					if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += " Part of you didn't really want to get knocked up, but it's for a good cause.  Besides, Ember looks very cute, trying to hide [ember.hisHer] happiness whenever [ember.heShe] glances at your belly...";
					//(If Corruption >= 40)
					else if (kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += " Considering the size of the egg, you hope it doesn't hurt when your child comes out.  You hope Ember will help you through this.";
					//(If Corruption >= 75)
					else kGAMECLASS.eventBuffer += " You think dreamily about the wild sex that helped conceive this little one.  Ember is such a great fuck.  Really, you're doing this world a favor by bringing more of Ember's offspring into it.";
				}
				else {
					kGAMECLASS.eventBuffer += "You've grown a lot, anyone is able to tell that you're pregnant with a single glance.  ";
					//If Corruption < 40
					if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "Part of you didn't really want to get knocked up.  However, Ember's look of satisfaction whenever [ember.heShe] gazes your way is rewarding despite that.  Plus, it is for a good cause.  You smirk in satisfaction - with a couple of dragons at your beck and call, things will look very different indeed.";
					//If Corruption >= 40
					else if (kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "You grin, savoring the strange, erotic sensations from the life inside your burgeoning womb and the promise of motherhood.  Mmm, if it feels this good, maybe you should \"<i>encourage</i>\" Ember to get you pregnant again.";
					else kGAMECLASS.eventBuffer += "You think dreamily about the wild sex that helped conceive this little one.  Ember is such a great fuck. Really, you're doing this world a favor by bringing more of Ember's offspring into it.";
				}
			}, true);
			
			this.addStageProgression(120 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 7, true);
				
				if (kGAMECLASS.ember.hasPerk("Oviposition")) kGAMECLASS.eventBuffer += "\n\nThough you're sure that this is the time when a regular baby would start moving about, your own belly simply sits there, heavy and full.  You'd be worried if you didn't remember that Ember hatched from an egg. Sometimes; a delightful, refreshing, chill spreads from your belly throughout your body; making you feel invigorated, ready for anything.";
				else {
					kGAMECLASS.eventBuffer += "Every once in awhile, you feel a kick from inside your bulging belly.  Right now, it's really kicking up a storm, and so you decide to sit down and take it easy.  You keep rubbing your belly, hoping to calm your child down and make it stop battering your innards.";
					kGAMECLASS.eventBuffer += "\n\nEmber approaches you, and casually asks, \"<i>So... is it kicking already?</i>\"";
					kGAMECLASS.eventBuffer += "\n\nYou admit that it is, stroking your stomach.  Casually, you ask if Ember would maybe like to touch your belly, wondering if [ember.heShe] will be able to bring [ember.himHer]self to do it.";
					kGAMECLASS.eventBuffer += "\n\n\"<i>Yes! Of course!</i>\" Ember replies";
					if (!kGAMECLASS.ember.hasScales()) kGAMECLASS.eventBuffer += ", blush at [ember.hisHer] own over-enthusiastic reply";
					kGAMECLASS.eventBuffer += ".  You just smile encouragingly at the dragon " + kGAMECLASS.ember.rawmf("-boy", "herm") + " and lean back slightly, sticking out your gravid midriff in open encouragement to its " + kGAMECLASS.ember.mf("father", "mother") + " to try and connect with [ember.hisHer] unborn child.";
					kGAMECLASS.eventBuffer += "\n\nEmber sets a clawed hand on your belly, careful not to hurt you with [ember.hisHer] claws.  Slowly [ember.heShe] rubs your belly, until [ember.heShe] feels a small kick and smiles in glee.  You smile at the look of joy on [ember.hisHer] face, even as [ember.heShe] realizes what [ember.heShe]'s doing and embarrassedly mumbles an excuse and walks away.";
				}
			}, true);
			
			this.addStageProgression(90 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 7, true);
				
				if (kGAMECLASS.ember.hasPerk("Oviposition")) kGAMECLASS.eventBuffer += "\n\nYou've somehow grown even larger, the egg's outline appearing through your tummy.  By now, you're quite bothered with how difficult it's getting to move.  Ember constantly shadows you around the camp, making sure you're all right, although if you ever question [ember.himHer] [ember.heShe]'ll just say you're both going in the same direction.";
				else {
					kGAMECLASS.eventBuffer += "You stop for a moment and sit down on a nearby rock.  Your belly feels much heavier than usual, and just walking about has become a chore.  Ember takes notice of your tiredness and quickly closes the distance between you two.  \"<i>[pc.name], are you feeling all right?</i>\"";
					kGAMECLASS.eventBuffer += "\n\nYou tell [ember.himHer] that you are, just worn out.  It's not easy carrying [ember.hisHer] child, after all.";
					kGAMECLASS.eventBuffer += "\n\nEmber sighs in relief.  \"<i>Good, is there anything I can do for you?</i>\"";
					kGAMECLASS.eventBuffer += "\n\nYou tap your lips thoughtfully, mulling it over.  ";
					//(Low Corruption)
					if (kGAMECLASS.pc.cor() <= 33) kGAMECLASS.eventBuffer += "There really isn't anything you feel like you need right now... maybe some water?  Or maybe you could have Ember help you to your " + camp.homeDesc() + " for a quick rest?";
					//(Medium Corruption)
					else if (kGAMECLASS.pc.cor() <= 66) kGAMECLASS.eventBuffer += "You wonder if you should take advantage of Ember - you've certainly been feeling a little on edge lately, and besides [ember.heShe] did say 'anything'.  You ponder this for a while longer.";
					//High Corruptio
					else kGAMECLASS.eventBuffer += "You  already thought up a perfect way for this sexy dragon to help you, but it's best not to rush.  It's not everyday that Ember says [ember.heShe]'ll do 'anything' for you.  A quick jab on your belly from your unborn child makes you recoil a bit though.  Maybe it would be better to wait until this little one is out of you, just so you can have another.  You ponder what to ask of [ember.himHer] a while longer.";
					kGAMECLASS.eventBuffer += "\n\nFinally, you decide there really isn't anything Ember can help you with, and tell [ember.himHer] so.  Though [ember.heShe] had better be ready to do [ember.hisHer] part when the baby is born and needs caring.";
					if (!kGAMECLASS.ember.hasVagina() && kGAMECLASS.ember.isLactating()) kGAMECLASS.eventBuffer += "  You can't resist smirking and patting one of your shemale dragon's bountiful breasts, noting that maybe you should let him do all the breast-feeding.";
					
					kGAMECLASS.eventBuffer += "\n\n";
					if (!kGAMECLASS.ember.hasScales()) kGAMECLASS.eventBuffer += "Ember blushes.  ";
					kGAMECLASS.eventBuffer += "\"<i>O-of course I'll do my part.  If you don't need me for anything, I'll be going then.</i>\" [ember.heShe] turns on [ember.hisHer] heels and walks away.  You watch [ember.himHer] go, pat yourself on the stomach, then painstakingly hoist yourself back upright and go on your way.";
				}
			}, true);
			
			this.addStageProgression(60 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 7, true);
				
				if (kGAMECLASS.ember.hasPerk("Oviposition")) {
					kGAMECLASS.eventBuffer += "The egg inside your belly seems to grow heavier each day that passes. ";
					//(If Corruption < 40)
					if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "It's quite a burden that you're carrying.  Still, it's a worthwhile sacrifice to make in order to restore Ember's race.";
					//(If Corruption >= 40)
					else if (kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "You wonder how much longer you have to wait.  This egg is quite burdensome.  Part of you is scared of its size, the other part is delighted to have produced such a big egg.";
					//If Corruption >= 75)
					else kGAMECLASS.eventBuffer += "You're eager to give birth, just so you can get impregnated again.  Particularly because that means more wild sex with Ember.";
				}
				else {
					kGAMECLASS.eventBuffer += "Besides being so huge you'd probably be asked if you were having twins back in Ingnam, your belly has grown stupidly heavy, ";
					if (kGAMECLASS.pc.cor() <= 33) kGAMECLASS.eventBuffer += "making you wonder more than ever if it really was a good idea to get pregnant with a dragon.  True, Ember looks ready to burst with pride at your fruitful bounty, but you feel ready to just plain burst yourself.";
					else if (kGAMECLASS.pc.cor() <= 66) kGAMECLASS.eventBuffer += "and you wonder how much longer you have to wait.  Despite being a bit bothersome, you're pleased your child is growing into a healthy, hopefully sexy, dragon; like its father.";
					else kGAMECLASS.eventBuffer += "and you're eager to give birth, so you can get impregnated again.  Particularly because that means more rowdy fucking from Ember.";
				}
			}, true);
			
			this.addStageProgression(30 * 60, function(pregSlot:int):void {
				kGAMECLASS.pc.addPregnancyBellyMod(pregSlot, 7, true);
				
				if (kGAMECLASS.ember.hasPerk("Oviposition")) {
					kGAMECLASS.eventBuffer += "You rub your hands over your ripe belly, lost in the sensations of motherhood.  ";
					//dynStats("sen", 5, "lus", (5+player.sens/20));
					kGAMECLASS.pc.lust(5 + kGAMECLASS.pc.libido() / 20);
					//If Corruption < 40
					if (kGAMECLASS.pc.cor() < 40) kGAMECLASS.eventBuffer += "Despite your initial reluctance, you've come to find a very real pleasure in being pregnant.  You hope Ember will want to have more children in the future...";
					//(If Corruption >= 40)
					else if (kGAMECLASS.pc.cor() < 75) kGAMECLASS.eventBuffer += "You smile, knowing you'll have your egg in your hands the next few days.  A part of you is almost sad that you'll be empty, but you can always entice Ember into getting you pregnant again.";
					//(If Corruption >= 75)
					else {
						kGAMECLASS.eventBuffer += "You find yourself daydreaming about giving birth, your belly swollen huge - bigger than it currently is - and the orgasmic sensation of many large, round eggs sliding out of your [pc.vagina].\n\nYou start to absently rub yourself as you envision eggs by the dozens coming from within you; you shall be mothergod for a whole new race of dragons...";
						pc.lust(35);
					}
					kGAMECLASS.eventBuffer += "\n\nEmber interrupts your musings with a question.  \"<i>How are you feeling? Do you need me to get you anything?</i>\"";
					kGAMECLASS.eventBuffer += "\n\nThe dragon's question is uncharacteristic of [ember.himHer].  Still, you do appreciate the attention you're getting, and so you ask Ember to fetch you some food and water.  The speed with which Ember dashes off to fulfill your requests is truly impressive!  In short moments Ember is back with a piece of roasted meat and a skin of water.";
					kGAMECLASS.eventBuffer += "\n\nAs you eat and drink your fill, Ember uses one wing to shield you off the sun.  You're starting to really enjoy all the attention, but seeing Ember give up on [ember.hisHer] usual antics is still very weird.";
				}
				else {
					kGAMECLASS.eventBuffer += "You rub your hands over your gloriously full, ripe belly, lost in the sensations of motherhood.  ";
					if (kGAMECLASS.pc.cor() <= 33) kGAMECLASS.eventBuffer += "Despite your initial reluctance, you've come to find a very real pleasure in being pregnant.  You hope Ember will want to have more children in the future.";
					else if (kGAMECLASS.pc.cor() <= 66) kGAMECLASS.eventBuffer += "You smile, knowing you'll meet your child in the next few days.  A part of you is almost sad that you'll be empty, but you can always entice Ember into getting you pregnant again.";
					else kGAMECLASS.eventBuffer += "You find yourself daydreaming about being the revered mother-queen of a huge army of dragons, visions of magnificent, sexy, scaly beasts sweeping across the land conquering it in your honor, offering up tribute to the ever-ripe womb that brought them forth; rolling around, as the musk of their fucking fills the air.  The image is so delicious you don't want to wake up from your fantasy.";
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
		}
		
		public static function OverrideOnDurationEnd(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			// Closure ensures that we will call the targetted output function (thus it will have access
			// to various pregnancy data) prior to cleaning up the pregnancy data itself. Magic.
			var tEventCall:Function = (function(c_mother:Creature, c_pregSlot:int, c_thisPtr:BasePregnancyHandler):Function
			{
				return function():void
				{
					kGAMECLASS.giveBirthToEmberKids(c_pregSlot);
					cleanupPregnancy(c_mother, c_pregSlot, c_thisPtr);
				}
			})(mother, pregSlot, thisPtr);
			
			kGAMECLASS.eventQueue.push(tEventCall);
		}
		
		public static function cleanupPregnancy(mother:Creature, pregSlot:int, thisPtr:BasePregnancyHandler):void
		{
			var pData:PregnancyData = mother.pregnancyData[pregSlot] as PregnancyData;
			
			mother.bellyRatingMod -= pData.pregnancyBellyRatingContribution;
			//StatTracking.track("coc/pregnancy/pc ember", 1); // handled in giveBirthToEmberKids
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