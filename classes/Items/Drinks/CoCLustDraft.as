package classes.Items.Drinks
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
	
	public class CoCLustDraft extends ItemSlotClass
	{
		
		//constructor
		public function CoCLustDraft()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 5;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "L.Draft";
			//Regular name
			this.longName = "Lust Draft";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a vial of roiling bubble-gum pink fluid";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.  It smells very sweet, and has \"Lust\" inscribed on the side of the vial.";

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
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{			
			clearOutput();
			output("You drink the pink potion, and its unnatural warmth immediately flows to your groin.");
			target.lust(30 + rand(target.libido() / 10));

			//ORGAZMO
			if (target.lust() >= target.lustMax() && !inCombat()) {
				output("\n\nThe arousal from the potion overwhelms your senses and causes you to spontaneously orgasm.  You rip off your [pc.gear] and look down as your ");
				if (target.hasCock()) {
					output("[pc.cocksLight] erupts in front of you, liberally spraying the ground around you.  ");
				}
				if (target.isHerm()) {
					output("At the same time your ");
				}
				if (target.hasVagina()) {
					output("[pc.vaginas] soaks your thighs.  ");
				}
				if (!target.hasGenitals()) output("body begins to quiver with orgasmic bliss.  ");
				output("Once you've had a chance to calm down, you notice that the explosion of pleasure you just experienced has rocked you to your core.  You are a little hornier than you were before.");
				target.orgasm();
				target.libido(2);
			}
			
			output("\n\n");
			return false;
		}
	}
}

