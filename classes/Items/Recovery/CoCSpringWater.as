package classes.Items.Recovery
{
	import classes.Engine.Combat.inCombat;
	import classes.Engine.Interfaces.output;
	import classes.Engine.Utility.rand;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCSpringWater extends ItemSlotClass
	{
		//constructor
		public function CoCSpringWater()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			
			//Used on inventory buttons
			this.shortName = "SpringWtr";
			
			//Regular name
			this.longName = "waterskin filled with spring water";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a waterskin filled with spring water";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A waterskin full of purified water from Minerva's spring.  It's clean and clear, with a faint sweet scent to it.  You're sure it would be a very refreshing drink.";
			
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
			
			this.version = _latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			if(inCombat()) output("\n");
			else kGAMECLASS.clearOutput();
				
			if(target is PlayerCharacter)
			{
				output("The water is cool and sweet to the taste, and every swallow makes you feel calmer, cleaner, and refreshed.  You drink until your thirst is quenched, feeling purer in both mind and body. ");
			}
			else
			{
				output("The water is cool and sweet to the taste, and every swallow makes " + target.capitalA + target.short + " feel calmer, cleaner, and refreshed.\n");
			}
						
			target.energy(10);
			target.lust( -25);
			target.cor( -0.5);
			target.HP(20 + (5 * target.level) + rand(5 * target.level))
			if (target.cor() > 50) target.cor( -1);
			if (target.cor() > 75) target.cor( -1);
			return false;
		}
	}
}
