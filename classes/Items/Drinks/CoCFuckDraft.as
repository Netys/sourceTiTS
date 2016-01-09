package classes.Items.Drinks
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCFuckDraft extends ItemSlotClass
	{
		//constructor
		public function CoCFuckDraft()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.DRUG;
			
			//Used on inventory buttons
			this.shortName = "F.Draft";
			
			//Regular name
			this.longName = "Fuck Draft";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a vial of roiling red fluid labeled \"Fuck Draft\"";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This vial of red fluid bubbles constantly inside the glass, as if eager to escape.  It smells very strongly, though its odor is difficult to identify.  The word \"Fuck\" is inscribed on the side of the vial.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 250;
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
			clearOutput();
			output("You drink the red potion, and its unnatural warmth immediately flows to your groin.");
			target.lust(30 + rand(target.libido() / 10));

			//Try to go into intense heat.
			kGAMECLASS.goIntoHeat(true, 2);
			//Males go into rut
			kGAMECLASS.goIntoRut(true);
				
			output("\n\n");
			return false;
		}
	}
}
