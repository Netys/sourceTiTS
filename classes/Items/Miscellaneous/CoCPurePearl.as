package classes.Items.Miscellaneous
{
	import classes.Engine.Interfaces.clearOutput;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCPurePearl extends ItemSlotClass
	{
		public function CoCPurePearl()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			
			//Used on inventory buttons
			this.shortName = "P.Pearl";
			
			//Regular name
			this.longName = "pure pearl";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a pure pearl";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "Marae gave you this pure pearl as a reward for shutting down the demonic factory.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 10000;
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
			
			this.version = _latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			output("You cram the pearl in your mouth and swallow it like a giant pill with some difficulty.  Surprisingly there is no discomfort, only a cool calming sensation that springs up from your core.");
			
			var libidoDiff:Number = -Math.min(5, target.libido() - 1);
			if (libidoDiff < 0) target.libido( libidoDiff);
			target.lust( -25);
			target.cor( -10);

			if(!target.hasPerk("Purity Blessing")) {
				output("\n\n<b>(New Perk Gained: Purity Blessing)</b>", false);
				target.createPerk("Purity Blessing", 0, 0, 0, 0, "Reduces the rate at which your corruption, libido, and lust increase. Reduces minimum libido slightly.");
			}
			return false;
		}
	}
}
