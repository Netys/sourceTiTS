package classes.Items.Drinks
{
	import classes.Engine.Utility.rand;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Combat.inCombat;
	
	public class CoCIsabellaMilk extends ItemSlotClass
	{
		//constructor
		public function CoCIsabellaMilk()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			//Used on inventory buttons
			this.shortName = "IzyMilk";
			//Regular name
			this.longName = "bottle of Isabella's milk";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle of Isabella's milk";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a bottle of Isabella's milk.  Isabella seems fairly certain it will invigorate you.";
			
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
			
			this.combatUsable = true;
			this.targetsSelf = true;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			output("You swallow down the bottle of Isabella's milk.");
			var healing:int = target.energy();
			target.energy(33);
			healing = int(target.energy() - healing);
			if (healing > 0) output(" <b>+" + healing + " Energy</b>");
			return false;
		}
	}
}

