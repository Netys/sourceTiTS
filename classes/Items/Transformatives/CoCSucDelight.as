package classes.Items.Transformatives 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.Engine.Utility.rand;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.Util.*;
	
	public class CoCSucDelight extends ItemSlotClass
	{
		public function CoCSucDelight() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "S. Delight";
			//Regular name
			this.longName = "bottle of \"Succubi's Delight\"";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle of \"Succubi's Delight\"";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This precious fluid is often given to men a succubus intends to play with for a long time.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 60;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.version = this._latestVersion;
		}
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			if (!(target is PlayerCharacter)) {
				output(target.capitalA + target.short + " have no idea how to use " + longName + ".");
				return false;
			}
			
			useIt(target, true);
			return false;
		}
		
        public static function useIt(target:Creature, tainted:Boolean):void
        {
			clearOutput();
			
			var temp:Number = 0;
			var changes:Number = 0;
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			if (rand(4) == 0) crit += rand(2) + 1;
			var changeLimit:Number = 1;
			//Chances to up the max number of changes
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (target.hasPerk("History: Alchemist")) changeLimit++;
			if (target.hasPerk("Transformation Resistance")) changeLimit--;
			//Generic drinking text
			output("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (target.cor() < 33 && tainted) output("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (target.cor() >= 66) output("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if ((target.cor() < 50 || rand(2)) && tainted) {
				output("\n\nThe drink makes you feel... dirty.");
				temp = 1;
				//Corrupts the uncorrupted faster
				if (target.cor() < 50) temp++;
				if (target.cor() < 40) temp++;
				if (target.cor() < 30) temp++;
				//Corrupts the very corrupt slower
				if (target.cor() >= 90) temp = .5;
				target.cor(temp);
			}
			
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (rand(2) == 0 && changes < changeLimit && target.balls > 0) {
				//They grow slower as they get bigger...
				target.ballSize(target.ballSize() > 10 ? Math.PI / 4 : Math.PI / 2);
				//Texts
				if (target.ballSize() <= 2) output("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your [pc.balls] have grown larger than a human's.");
				if (target.ballSize() > 2) output("\n\nA sudden onset of heat envelops your groin, focusing on your [pc.sack].  Walking becomes difficult as you discover your [pc.balls] have enlarged again.");
				target.slowStatGain("l", 1);
				target.lust(3);
				changes++;
			}
			//Boost cum multiplier
			if (changes < changeLimit && rand(2) == 0 && target.hasCock()) {
				if (target.cumMultiplierRaw < 10) target.cumMultiplierRaw += .25 * crit;
				target.cumMultiplierRaw += .25 * crit;
				//Flavor text
				if (target.balls == 0) output("\n\nYou feel a churning inside your body as something inside you changes.");
				if (target.balls > 0) output("\n\nYou feel a churning in your [pc.balls].  It quickly settles, leaving them feeling somewhat more dense.");
				if (crit > 1) output("  A bit of [pc.cumColor] pre dribbles from your [pc.cocks], pushed out by the change.");
				target.slowStatGain("l", 1);
				changes++;
			}
			//Boost refactory
			if (changes < changeLimit && rand(2) == 0 && target.hasCock()) {
				if (target.refractoryRate < 10) target.refractoryRate += .1 * crit;
				target.refractoryRate += .1 * crit;
				//Flavor text
				if (target.balls == 0) output("\n\nThere's a heat rising in your gut, something warm and not altogether unpleasant. After a moment the heat passes and you feel... more productive, somehow.");
				if (target.balls > 0) output("\n\nThere's a heat rising in your [pc.sack], something warm and not altogether unpleasant. After a moment the heat passes and you feel... more productive, somehow.");
				changes++;
			}
			//Fail-safe
			if (changes == 0 && target.hasCock()) {
				output("\n\nYour groin tingles, making it feel as if you haven't cum in a long time.");
				target.minutesSinceCum += 100 * 60;
				changes++;
			}
			if (target.balls > 0 && rand(2) == 0 && Mutator.modFem(target, target.hasVagina() ? 50 : 15, 3, true)) changes++;
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}
}