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
	
	public class CoCCalmMint extends ItemSlotClass
	{
		//constructor
		public function CoCCalmMint()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			
			//Used on inventory buttons
			this.shortName = "C. Mint";
			
			//Regular name
			this.longName = "calm mint";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a calm mint";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a sprig of silver-colored mint.  Its strong scent makes you feel calmer and less lustful.";
			
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
				output("Eating the sprig of raw mint is a bit of a stretch, but you manage to gulp it down.  As the strong minty flavor overwhelms your taste buds, your mind feels calmer, and a relaxed sensation spreads through your body.");
			}
			else
			{
				output("Eating the sprig of raw mint is a bit of a stretch, but " + target.capitalA + target.short + " manage to gulp it down.\n");
			}
			
			target.slowStatGain("i", 0.5);
			target.slowStatGain("l", -1);
			target.lust( -10);
			return false;
		}
	}
}
