package classes.Items.Transformatives
{
	import classes.GameData.TooltipManager;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCReducto extends ItemSlotClass
	{
		public function CoCReducto()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.DRUG;
			//Used on inventory buttons
			this.shortName = "Reducto";
			//Regular name
			this.longName = "Reducto";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a salve marked as 'Reducto'";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This container full of paste can be used to shrink a body part down by a significant amount.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 500;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.combatUsable = false;
			this.targetsSelf = true;
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			if (!(target is PlayerCharacter))
			{
				output(target.capitalA + target.short + " refuses to use Reducto.");
				return false;
			}			
			clearMenu();
			output("You ponder the paste in your hand and wonder what part of your body you would like to shrink.  What will you use it on?\n\n");
			
			kGAMECLASS.addDisabledButton(0, "Balls", "Balls", "You need large balls to use Reducto on them.");
			kGAMECLASS.addDisabledButton(1, "Breasts", "Breasts", "You need large breasts to us Reducto on them.");
			kGAMECLASS.addDisabledButton(2, "Butt", "Butt", "You need large butt to use Reducto on it.");
			kGAMECLASS.addDisabledButton(3, "Clit", "Clit", "You need large clit to use GroPlus on it.");
			kGAMECLASS.addDisabledButton(4, "Cock", "Cock", "You need large cock to use GroPlus on it.");
			kGAMECLASS.addDisabledButton(5, "Hips", "Hips", "You need large hips to use GroPlus on them.");
			kGAMECLASS.addDisabledButton(6, "Nipples", "Nipples", "You need large nipples to use GroPlus on them.");
			kGAMECLASS.addDisabledButton(7, "Horns", "Horns", "You need horns to use GroPlus on them.");
			
			addButton(14, "Nevermind" , function():*{
				kGAMECLASS.clearOutput();
				kGAMECLASS.clearMenu();
				kGAMECLASS.output("You put the salve away.\n\n");
				kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
			});
			
			if (target.balls > 0 && target.ballSizeRaw > 0.75) kGAMECLASS.addButton(0, "Balls", reductoBalls);
			if (target.breastRows.length > 0 && biggestTitSizeRaw() > 0) kGAMECLASS.addButton(1, "Breasts", reductoBreasts);
			if (target.buttRatingRaw > 2) kGAMECLASS.addButton(2, "Butt", reductoButt);
			if (target.hasClit() && target.clitLength > 0.25) kGAMECLASS.addButton(3, "Clit", reductoClit);
			if (target.hasCock() && target.biggestCockLength() > 3) kGAMECLASS.addButton(4, "Cock", reductoCock);
			if (target.hipRatingRaw > 2) kGAMECLASS.addButton(5, "Butt", reductoHips);
			if (target.hasNipples() && target.nippleLengthRatio > 1) kGAMECLASS.addButton(6, "Nipples", reductoNipples);
			if (target.horns > 0 && target.hornLength > 0) kGAMECLASS.addButton(7, "Horns", shrinkHorns);
			
			return true;
		}
		
		private function consume():void {
			this.quantity--;
			if (this.quantity <= 0 && kGAMECLASS.pc.inventory.indexOf(this) != -1)
			{
				kGAMECLASS.pc.inventory.splice(kGAMECLASS.pc.inventory.indexOf(this), 1);
			}
		}
		
		public function biggestTitSizeRaw(): Number {
			if (kGAMECLASS.pc.breastRows.length == 0) return -1;
			var counter: Number = kGAMECLASS.pc.breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (kGAMECLASS.pc.breastRows[index].breastRatingRaw < kGAMECLASS.pc.breastRows[counter].breastRatingRaw) index = counter;
			}
			return kGAMECLASS.pc.breastRows[index].breastRatingRaw;
		}
		
		private function reductoBalls():void {
			clearOutput();
			
			kGAMECLASS.output("You smear the foul-smelling paste onto your [pc.sack].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
			kGAMECLASS.pc.ballSizeRaw = formatFloat(kGAMECLASS.pc.ballSizeRaw * 2 / 3, 1);
			if (kGAMECLASS.pc.ballSizeRaw < 0.75) kGAMECLASS.pc.ballSizeRaw = 0.75;
			kGAMECLASS.output("You feel your scrotum shift, shrinking down along with your [pc.balls].  Within a few seconds the paste has been totally absorbed and the shrinking stops.");
			
			kGAMECLASS.pc.libido( -2);
			kGAMECLASS.pc.lust( -10);
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function reductoBreasts():void {
			clearOutput();
			kGAMECLASS.output("You smear the foul-smelling ointment all over your [pc.chest], covering them entirely as the paste begins to get absorbed into your [pc.skin].\n");
			if (biggestTitSizeRaw() >= 1) {
				output("\nThe effects of the paste continue to manifest themselves, and your body begins to change...");
				var power:int = Math.ceil(biggestTitSizeRaw() / Math.max(3, kGAMECLASS.pc.breastRows.length + 1));
				trace("Largest size:  " + biggestTitSizeRaw())
				trace("Reducto power: " + power)
				power = Math.max(power, 1);
				while (power-- > 0 && Mutator.shrinkTits(kGAMECLASS.pc, false)) {}
				output(Mutator.buffer);
			}
			kGAMECLASS.output("\n\nThe last of it wicks away into your skin, completing the changes.");
			
			kGAMECLASS.pc.lust( -5);
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function reductoButt():void {
			clearOutput();
			kGAMECLASS.output("You smear the foul-smelling paste onto your [pc.butt].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
			if (kGAMECLASS.pc.buttRatingRaw >= 15) {
				kGAMECLASS.pc.buttRatingRaw -= (3 + int(kGAMECLASS.pc.buttRatingRaw / 3));
				kGAMECLASS.output("Within seconds you feel noticeably lighter, and a quick glance shows your ass is significantly smaller.");
			}
			else if (kGAMECLASS.pc.buttRatingRaw >= 10) {
				kGAMECLASS.pc.buttRatingRaw -= 3;
				kGAMECLASS.output("You feel much lighter as your [pc.butt] jiggles slightly, adjusting to its smaller size.");
			}
			else {
				kGAMECLASS.pc.buttRatingRaw -= rand(3) + 1;
				if (kGAMECLASS.pc.buttRatingRaw < 1) kGAMECLASS.pc.buttRatingRaw = 1;
				kGAMECLASS.output("After a few seconds your [pc.butt] has shrunk to a much smaller size!");
			}
			kGAMECLASS.pc.libido( -2);
			kGAMECLASS.pc.lust( -10);
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function reductoClit():void {
			clearOutput();
			kGAMECLASS.output("You carefully apply the paste to your [pc.clits], being very careful to avoid getting it on your [pc.vaginas].  It burns with heat as it begins to make its effects known...\n\n");
			kGAMECLASS.output("Your [pc.clit] shrinks rapidly, dwindling down to almost half its old size before it finishes absorbing the paste.");
			kGAMECLASS.pc.clitLength /= 1.7;
			//Set clitlength down to 2 digits in length
			kGAMECLASS.pc.clitLength = int(kGAMECLASS.pc.clitLength * 100) / 100;
			
			kGAMECLASS.pc.lust( -10);
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function reductoCock():void {
			clearOutput();
			//if (game.pc.cocks[0].cockType == CockTypesEnum.BEE) {
				//output("The gel produces an odd effect when you rub it into your " + game.pc.cockDescript(0) + ".  It actually seems to calm the need that usually fills you.  In fact, as your " + game.pc.cockDescript(0) + " shrinks, its skin tone changes to be more in line with yours and the bee hair that covered it falls out.  <b>You now have a human cock!</b>");
				//game.pc.cocks[0].cockType = CockTypesEnum.HUMAN;
			//}
			//else {
				var newSize:int;
				output("You smear the repulsive smelling paste over your [pc.multiCocks].  It immediately begins to grow warm, almost uncomfortably so, as your [pc.cocksLight] begins to shrink.\n\n");
				if (kGAMECLASS.pc.cocks.length == 1) {
					kGAMECLASS.output("Your [pc.cock] twitches as it shrinks, disappearing steadily into your " + (kGAMECLASS.pc.hasSheath() ? "sheath" : "crotch") + " until it has lost about a third of its old size.");
					newSize = kGAMECLASS.pc.cocks[0].cLength() * 2 / 3;
					if (newSize < 3) newSize = 3;
					kGAMECLASS.pc.cocks[0].cLength(newSize, true);
				}
				else { //MULTI
					kGAMECLASS.output("Your [pc.cocksLight] twitch and shrink, each member steadily disappearing into your " + (kGAMECLASS.pc.hasFullSheaths() ? "sheath" : "crotch") + " until they've lost about a third of their old size.");
					for (var i:int = 0; i < kGAMECLASS.pc.cocks.length; i++) {
						newSize = kGAMECLASS.pc.cocks[i].cLength() * 2 / 3;
						if (newSize < 3) newSize = 3;
						kGAMECLASS.pc.cocks[i].cLength(newSize, true);
					}
				}
			//}
			
			kGAMECLASS.pc.lust( -10);
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function reductoHips():void {
			clearOutput();
			output("You smear the foul-smelling paste onto your [pc.hips].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
			if (kGAMECLASS.pc.hipRatingRaw >= 15) {
				kGAMECLASS.pc.hipRatingRaw -= (3 + int(kGAMECLASS.pc.hipRatingRaw / 3));
				kGAMECLASS.output("Within seconds you feel noticeably lighter, and a quick glance at your hips shows they've gotten significantly narrower.");
			}
			else if (kGAMECLASS.pc.hipRatingRaw >= 10) {
				kGAMECLASS.pc.hipRatingRaw -= 3;
				kGAMECLASS.output("You feel much lighter as your [hips] shift slightly, adjusting to their smaller size.");
			}
			else {
				kGAMECLASS.pc.hipRatingRaw -= rand(3) + 1;
				if (kGAMECLASS.pc.hipRatingRaw < 1) kGAMECLASS.pc.hipRatingRaw = 1;
				kGAMECLASS.output("After a few seconds your [hips] have shrunk to a much smaller size!");
			}
			
			kGAMECLASS.pc.libido( -2);
			kGAMECLASS.pc.lust( -10);
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function reductoNipples():void {
			clearOutput();
			output("You rub the paste evenly over your [pc.nipples], being sure to cover them completely.\n\n");
			//Shrink
			if (kGAMECLASS.pc.nippleLengthRatio / 2 < 1) {
				output("Your nipples continue to shrink down until they are proportional to your breasts.");
				kGAMECLASS.pc.nippleLengthRatio = 1;
			}
			else {
				output("Your [pc.nipples] get smaller and smaller, stopping when they are roughly half their previous size.");
				kGAMECLASS.pc.nippleLengthRatio /= 2;
			}
			kGAMECLASS.pc.lust( -5);
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		public function shrinkHorns():void {
			output("You doubt if the reducto is going to work but you apply the foul-smelling paste all over your horns anyways.\n\n");
			output("Incredibly, it works and you can feel your horns receding by an inch.\n\n")
			kGAMECLASS.pc.horns -= 1;
			kGAMECLASS.pc.hornLength -= 1;
			if (kGAMECLASS.pc.hornLength <= 0) {
				output("Actually, they are totally gone!")
				kGAMECLASS.pc.removeHorns();
			}
			consume();
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
	}
}

