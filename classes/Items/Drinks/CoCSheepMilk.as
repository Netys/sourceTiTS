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
	
	public class CoCSheepMilk extends ItemSlotClass
	{
		//constructor
		public function CoCSheepMilk()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			//Used on inventory buttons
			this.shortName = "GodMead";
			//Regular name
			this.longName = "pint of god's mead";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a pint of god's mead";
			//Displayed on tooltips during mouseovers
			this.tooltip = "A horn of potent, honey-colored mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 600;
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
			output("You gulp the bottle's contents, and its sweet taste immediately invigorates you, making you feel calm and concentrated. ");
			//-30 fatigue, -2 libido, -10 lust]
			var healing:int = target.energy();
			target.energy(30);
			healing = int(target.energy() - healing);
			if (healing > 0) output(" <b>+" + healing + " Energy</b>");
			target.slowStatGain("l", -0.25);
			target.lust( -10);
			target.cor( -0.5);
			return false;
		}
	}
}

