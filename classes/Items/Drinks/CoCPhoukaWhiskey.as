package classes.Items.Drinks
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.IncrementFlag;
	import classes.Engine.Utility.rand;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	
	public class CoCPhoukaWhiskey extends ItemSlotClass
	{
		//constructor
		public function CoCPhoukaWhiskey()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			//Used on inventory buttons
			this.shortName = "Ph. Whiskey";
			//Regular name
			this.longName = "bottle of whiskey";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a small bottle of whiskey";
			//Displayed on tooltips during mouseovers
			this.tooltip = "A small, corked glass bottle with a dark amber liquid inside. The whiskey smells strongly of peat.";
			
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
			
			this.combatUsable = true;
			this.targetsSelf = true;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			phoukaWhiskeyDrink(target, true);
			return false;
		}
		
		public static function phoukaWhiskeyDrink(target:Creature, alone:Boolean = true):void
		{
			target.imbibeAlcohol(100); // strong stuff..
			
			//Child is a phouka or satyr, loves alcohol
			if (target.hasPregnancyOfType("CoCSatyrPregnancy") || target.hasPregnancyOfType("CoCPhoukaPregnancy") && kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] > 0) output("You uncork the bottle and drink some whiskey, hoping it will help with the gnawing hunger for alcohol you've had since this baby started growing inside you.\n\nYou down the booze in one shot and a wave of contentment washes over you. It seems your passenger enjoyed the meal.");
			//Child is a faerie but will become a phouka with this drink
			else if (target.hasPregnancyOfType("CoCPhoukaPregnancy") && kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] == 0) output("At first you feel your baby struggle against the whiskey, then it seems to grow content and enjoy it.");
			//Child is a faerie, hates phouka whiskey
			else if (target.hasPregnancyOfType("CoCPhoukaPregnancy") && kGAMECLASS.flags["COC.PREGNANCY_CORRUPTION"] < 0) output("You feel queasy and want to throw up. There's a pain in your belly and you realize the baby you're carrying didn't like that at all.");
			//Player isn't pregnant or has other type of pregnancy, originally pregnancy prevents use of this whiskey, but since there already are other types of alcohol without a check...
			else
			{
				output("You uncork the bottle and drink some whiskey, hoping it will let you relax for a while.\n\nIt's strong stuff and afterwards you worry a bit less about the future.  Surely things will right themselves in the end.");
				target.cor(rand(2) + 1);
				target.lust(rand(8) + 1);
			}
			
			output("\n\nOh, it tastes so good.  This stuff just slides down your throat.");
			
			//Faerie or phouka babies become more corrupted, no effect if the player is not pregnant or on other types of babies
			if(target.hasPregnancyOfType("CoCPhoukaPregnancy")) IncrementFlag("COC.PREGNANCY_CORRUPTION");
		}
	}
}

