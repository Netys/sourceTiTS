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
			if (!(target is PlayerCharacter))
			{
				return false;
			}
			
			useIt(true);
			return false;
		}
		
        public static function useIt(tainted:Boolean):void
        {
			clearOutput();
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			var temp:Number = 0;
			var changes:Number = 0;
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			if (rand(4) == 0) crit += rand(2) + 1;
			var changeLimit:Number = 1;
			//Chances to up the max number of changes
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Generic drinking text
			output("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (pc.cor() < 33) output("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (pc.cor() >= 66) output("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if ((pc.cor() < 50 || rand(2)) && tainted) {
				output("\n\nThe drink makes you feel... dirty.");
				temp = 1;
				//Corrupts the uncorrupted faster
				if (pc.cor() < 50) temp++;
				if (pc.cor() < 40) temp++;
				if (pc.cor() < 30) temp++;
				//Corrupts the very corrupt slower
				if (pc.cor() >= 90) temp = .5;
				pc.cor(temp);
				changes++;
			}
			
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (rand(1.5) == 0 && changes < changeLimit && pc.balls > 0) {
				//They grow slower as they get bigger...
				pc.ballSize(pc.ballSize() > 10 ? 0.5 : 1);
				//Texts
				if (pc.ballSize() <= 2) output("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your [pc.balls] have grown larger than a human's.");
				if (pc.ballSize() > 2) output("\n\nA sudden onset of heat envelops your groin, focusing on your [pc.sack].  Walking becomes difficult as you discover your [pc.balls] have enlarged again.");
				pc.slowStatGain("l", 1);
				pc.lust(3);
				changes++;
			}
			//Grow new balls!
			if (pc.balls < 2 && changes < changeLimit && rand(4) == 0) {
				if (pc.balls == 0) {
					pc.balls = 2;
					output("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your [pc.gear].  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
					pc.ballSizeRaw = 1;
				}
				changes++;
			}
			//Boost cum multiplier
			if (changes < changeLimit && pc.cumMultiplierRaw < 6 && rand(2) == 0 && pc.hasCock()) {
				//Lots of cum raises cum multiplier cap to 6 instead of 3
				//if (pc.findPerk(PerkLib.MessyOrgasms) >= 0) temp = 6;
				pc.cumMultiplierRaw += .4 * crit;
				//Flavor text
				if (pc.balls == 0) output("\n\nYou feel a churning inside your body as something inside you changes.");
				if (pc.balls > 0) output("\n\nYou feel a churning in your [pc.balls].  It quickly settles, leaving them feeling somewhat more dense.");
				if (crit > 1) output("  A bit of milky pre dribbles from your [pc.cocks], pushed out by the change.");
				pc.slowStatGain("l", 1);
				changes++;
			}
			//Fail-safe
			if (changes == 0) {
				output("\n\nYour groin tingles, making it feel as if you haven't cum in a long time.");
				pc.minutesSinceCum += 100 * 60;
				changes++;
			}
			if (pc.balls > 0 && pc.femininity >= 15 && rand(3) == 0) {
				output(pc.modFem( -3));
			}
		}
	}
}