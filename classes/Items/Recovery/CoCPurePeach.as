package classes.Items.Recovery
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
	
	public class CoCPurePeach extends ItemSlotClass
	{
		//constructor
		public function CoCPurePeach()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			
			//Used on inventory buttons
			this.shortName = "PurPeac";
			
			//Regular name
			this.longName = "pure peach";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a pure peach";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a peach from Minerva's spring, yellowy-orange with red stripes all over it.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 100;
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
				output("You bite into the sweet, juicy peach, feeling a sensation of energy sweeping through your limbs and your mind.  You feel revitalized, refreshed, and somehow cleansed.  ");
			}
			else
			{
				output(target.capitalA + target.short + " bite into the sweet, juicy peach, feeling a sensation of energy sweeping through body and mind.\n");
			}
			
			target.energy(15);
			target.HP(target.maxHP() / 4);
			return false;
		}
	}
}
