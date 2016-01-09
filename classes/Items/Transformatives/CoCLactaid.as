package classes.Items.Transformatives 
{
	import classes.Engine.Interfaces.*;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Utility.rand;
	
	public class CoCLactaid extends ItemSlotClass
	{
		public function CoCLactaid() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "LactAid";
			//Regular name
			this.longName = "bottle labelled \"LactAid\"";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a pink bottle labelled \"LactAid\"";
			//Displayed on tooltips during mouseovers
			this.tooltip = "Judging by the name printed on this bottle, 'Lactaid' probably has an effect on the ability to lactate, and you doubt that effect is a reduction.";
			
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
			
			this.version = this._latestVersion;
		}
		
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();

			if (!(target is PlayerCharacter))
			{
				output(target.capitalA + target.short + " drinks the LactAid to no effect.");
				return false;
			}

			output("You gulp down the bottle of lactaid, easily swallowing the creamy liquid.");
			
			
			if (target.breastRows.length == 0) {
				output("\n\nNo effect... Maybe you should grow breasts first?\n\n");
				return false;
			}
			
			if (!target.hasNipples()) {
				output("\n\nNo effect... Maybe you should grow nipples first?\n\n");
				return false;
			}			
			
			//Bump up size!
			if (target.biggestTitSize() < 8) {
				output("\n\n");
				if (target.breastRows.length == 1) kGAMECLASS.growTits((1 + rand(5)), 1, true, 1);
				else kGAMECLASS.growTits(1 + rand(2), target.breastRows.length, true, 1);
			}
			//Player doesn't lactate
			if (!target.isLactating()) {
				output("\n\nYou feel your [pc.nipples] become tight and engorged.  A single droplet of milk escapes each, rolling down the curves of your breasts.  <b>You are now lactating!</b>");
				if (!target.canLactate())
					target.milkMultiplier = 75;
				target.milkFullness = 100;
			}
			//Boost lactation
			else if (target.milkStorageMultiplier < 4)
			{
				output("\n\nMilk leaks from your [pc.nipples] in thick streams.  You're lactating even more!");
				target.milkStorageMultiplier += 0.5;
				if (target.milkStorageMultiplier > 4) target.milkStorageMultiplier = 4;
			}
			else {
				target.milkFullness = 100;
			}
			target.lust(10);
			if (rand(3) == 0) {
				output(target.modFem(1));
			}

			return false;
		}
	}
}