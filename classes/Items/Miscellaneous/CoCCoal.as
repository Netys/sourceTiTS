package classes.Items.Miscellaneous
{
	import classes.Engine.Combat.inCombat;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCCoal extends ItemSlotClass
	{
		//constructor
		public function CoCCoal()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "Coal";
			//Regular name
			this.longName = "two pieces of coal";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "the two pieces of coal";
			//Displayed on tooltips during mouseovers
			this.tooltip = "These two pieces of coal may look ordinary but it makes you wonder what happens when you rub them.";

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
			output("You handle the coal rocks experimentally and they crumble to dust in your hands!  You cough as you breathe in the cloud, sputtering and wheezing.  After a minute of terrible coughing, you recover and realize there's no remaining trace of the rocks, not even a sooty stain on your hands!");
			
			//Try to go into intense heat and/or rut
			if(!Mutator.goIntoHeat(target, true, 2) && !Mutator.goIntoRut(target, true)) {
				//Boost anal capacity without gaping
				if (target.ass.bonusCapacity < 80) {
					target.ass.bonusCapacity += 5;
					output("\n\nYou feel... more accommodating somehow.  Your [pc.asshole] is tingling a bit, and though it doesn't seem to have loosened, it has grown more elastic.");
				}
				else {
					output("\n\nYour whole body tingles for a moment but it passes.  It doesn't look like the coal can do anything to you at this point.");
				}
			}
			return false;
		}
	}
}

