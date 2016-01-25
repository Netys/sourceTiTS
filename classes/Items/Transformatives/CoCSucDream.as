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
	
	public class CoCSucDream extends ItemSlotClass
	{
		public function CoCSucDream() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "Suc.Dream";
			//Regular name
			this.longName = "bottle of 'Succubus' Dream'";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle of 'Succubus' Dream'";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This precious fluid is often given to men a succubus intends to play with for a long time, though this batch has been enhanced by Lumi to have even greater potency.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 200;
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
			
			useIt(target);
			return false;
		}
		
		
        public static function useIt(target:Creature):void
        {
			clearOutput();
			var temp:Number = 0;
			var changes:Number = 0;
			var crit:Number = 1;
			//Determine crit multiplier (x2 or x3)
			crit += rand(2) + 1;
			var changeLimit:Number = 1;
			//Chances to up the max number of changes
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (target.hasPerk("History: Alchemist")) changeLimit++;
			if (target.hasPerk("Transformation Resistance")) changeLimit--;
			//Generic drinking text
			output("You uncork the bottle and drink down the strange substance, struggling to down the thick liquid.");
			//low corruption thoughts
			if (target.cor() < 33) output("  This stuff is gross, why are you drinking it?");
			//high corruption
			if (target.cor() >= 66) output("  You lick your lips, marvelling at how thick and sticky it is.");
			//Corruption increase
			if (target.cor() < 50 || rand(2)) {
				output("\n\nThe drink makes you feel... dirty.");
				temp = 1;
				//Corrupts the uncorrupted faster
				if (target.cor() < 50) temp++;
				if (target.cor() < 40) temp++;
				if (target.cor() < 30) temp++;
				//Corrupts the very corrupt slower
				if (target.cor() >= 90) temp = .5;
				target.cor(temp + 2);
			}
			
			//NEW BALLZ
			if (changes < changeLimit && target.balls < 4) {
				if (target.balls > 0) {
					target.balls = 4;
					output("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your [pc.gear].  In shock, you barely register the sight before your eyes: <b>You have four balls.</b>");
				}
				if (target.balls == 0) {
					target.balls = 2;
					output("\n\nIncredible pain scythes through your crotch, doubling you over.  You stagger around, struggling to pull open your [pc.gear].  In shock, you barely register the sight before your eyes: <b>You have balls!</b>");
					target.ballSizeRaw = Math.PI;
					target.removeStatusEffect("Uniball");
				}
				changes++;
			}
			
			if(changes < changeLimit && target.hasStatusEffect("Uniball") && target.balls > 0)
			{
				kGAMECLASS.output("\n\nA tightness that you were barely aware of suddenly relaxes, centered low in your loins. You idly reach down to see what's going on, discovering that your [pc.balls] are dangling a little lower. The tight, trappy ballsack you once had as relaxed into a looser, more manly sperm satchel.");
				target.removeStatusEffect("Uniball");
				changes++;
			}
			
			//Makes your balls biggah! (Or cummultiplier higher if futa!)
			if (changes == 0 && target.balls > 0 && target.hasCock()) { // don't fire it if balls are just grown
				//They grow slower as they get bigger...
				target.ballSize(Math.PI);
				//Texts
				if (target.ballSize() <= 2) output("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your [pc.balls] have grown larger than a human's.");
				if (target.ballSize() > 2) output("\n\nA sudden onset of heat envelops your groin, focusing on your [pc.sack].  Walking becomes difficult as you discover your [pc.balls] have enlarged again.");
				target.slowStatGain("l", 1);
				target.lust(3);
			}
			//Boost cum multiplier
			if (changes < changeLimit && target.hasCock()) {
				target.cumMultiplierRaw += .4 * crit;
				//Flavor text
				if (target.balls == 0) output("\n\nYou feel a churning inside your body as something inside you changes.");
				if (target.balls > 0) output("\n\nYou feel a churning in your [pc.balls].  It quickly settles, leaving them feeling somewhat more dense.");
				if (crit > 1) output("  A bit of [pc.cumColor] pre dribbles from your [pc.cocksLight], pushed out by the change.");
				target.slowStatGain("l", 1);
				changes++;
			}
			//Boost refactory
			if (changes < changeLimit && target.refractoryRate < 100 && target.hasCock()) {
				target.refractoryRate += .4 * crit;
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
			if (target.balls > 0 && rand(2) == 0 && Mutator.modFem(target, target.hasVagina() ? 50 : 12, 5, true)) changes++;
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}
}