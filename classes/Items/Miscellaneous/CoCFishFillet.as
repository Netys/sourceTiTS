package classes.Items.Miscellaneous
{
	import classes.Engine.Combat.inCombat;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCFishFillet extends ItemSlotClass
	{
		
		//constructor
		public function CoCFishFillet()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			
			//Used on inventory buttons
			this.shortName = "FishFil";
			
			//Regular name
			this.longName = "fish fillet";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a fish fillet";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 10;
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
			
			this.version = _latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{			
			var healing:Number = 0.25;
			if(target.HP() + target.maxHP() * 0.25 > target.maxHP())
				healing = 1 - (target.HP() / target.HPMax());
			healing = Math.round(healing * target.HPMax());

			if(target is PlayerCharacter)
			{
				kGAMECLASS.clearOutput();
				
				if (!inCombat()) output("You sit down and unwrap your fish fillet. It's perfectly flaky, allowing you to break it off in bite-sized chunks.  The salty meal disappears quickly, and your stomach gives an appreciative gurgle.");
				else output("You produce the fish fillet from your bag.  Rather than unwrap it and savor the taste as you normally would, you take a large bite out of it, leaf wrapping and all.  In no time your salty meal is gone, your stomach giving an appreciative gurgle.");

				if (kGAMECLASS.flags["COC.FACTORY_SHUTDOWN"] == 2) target.cor(0.5);
				else if (kGAMECLASS.flags["COC.FACTORY_SHUTDOWN"] == 1) target.cor(-0.1);
				else target.cor(0.1)
				
				if (healing > 0) output(" (<b>+" + healing + " Health</b>)");
				output("\n");
			}
			else
			{
				if(inCombat()) output("\n");
				else kGAMECLASS.clearOutput();
				output(target.capitalA + target.short + " unwraps a fish fillet and wolfs down the contents, getting a");
				if(healing > 0) output(" quick energy boost. (<b>+" + healing + " Health</b>)");
				else output(" full stomach in the process.");
				output("\n");
			}
			
			target.HP(target.maxHP() * healing);
			return false;
		}
	}
}
