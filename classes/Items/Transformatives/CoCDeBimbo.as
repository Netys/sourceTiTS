package classes.Items.Transformatives
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCDeBimbo extends ItemSlotClass
	{		
		public function CoCDeBimbo()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.DRUG;
			//Used on inventory buttons
			this.shortName = "Debimbo";
			//Regular name
			this.longName = "Debimbo";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle marked as 'Debimbo'";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This draft is concocted from scholar's teas and who knows what else.  Supposedly it will correct the stupifying effects of Bimbo Liqueur, Bro Brew or similiar.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 2500;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.combatUsable = false;
			this.targetsSelf = true;
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
						
			if (!(target is PlayerCharacter))
			{
				output(target.capitalA + target.short + " refuses to drink it.");
				return false;
			}
			
			var perks:/*String*/Array = ["Bimbo Brains", "Futa Faculties", "Bro Brains", "Brute Speech", "Ditz Speech", "Weak Mind", "Fuck Sense", "Sexy Thinking"];
			var isRequired:Boolean = false;
			
			for each (var item:String in perks) 
			{
				if (target.hasPerk(item)) {
					isRequired = true;
					break;
				}
			}
			
			if (!isRequired) {
				output("It would be a waste to use it now!\n\n?");
				return false;
			}
			
			this.quantity--; // ugh... where are .consume function?
			if (this.quantity <= 0 && target.inventory.indexOf(this) != -1)
			{
				target.inventory.splice(target.inventory.indexOf(this), 1);
			}
			
			if(target.isBimbo()) {
				output("Well, time to see what this smelly, old rat was on about!  You pinch your nose and swallow the foul-tasting mixture with a grimace.  Oh, that's just <i>nasty!</i>  You drop the vial, which shatters on the ground, clutching at your head as a wave of nausea rolls over you.  Stumbling back against something for support, you close your eyes.  A constant, pounding ache throbs just behind your temples, and for once, you find yourself speechless.  A pained groan slips through your lips as thoughts and memories come rushing back.  One after another, threads of cognizant thought plow through the simple matrices of your bimbo mind, shredding and replacing them.");
				output("\n\nYou... you were an air-headed ditz!  A vacuous, idiot-girl with nothing between her ears but hunger for dick and pleasure!  You shudder as your faculties return, the pain diminishing with each passing moment.");
			}
			else if(target.isBro()) {
				output("You pinch your nose and swallow the foul-tasting mixture with a grimace.  Oh, that's just <i>nasty!</i>  You drop the vial, which shatters on the ground, clutching at your head as a wave of nausea rolls over you.  Stumbling back against something for support, you close your eyes.  A constant, pounding ache throbs just behind your temples, and for once, you find yourself speechless.  A pained groan slips through your lips as thoughts and memories come rushing back.  One after another, threads of cognizant thought plow through the simple matrices of your bro mind, shredding and replacing them.");
				output("\n\nYou... you were a brute who constantly thinks of working out and fucking!  You shudder as your faculties return, the pain diminishing with each passing moment.");
			} else {
				output("You pinch your nose and swallow the foul-tasting mixture with a grimace.  Oh, that's just <i>nasty!</i>  You drop the vial, which shatters on the ground, clutching at your head as a wave of nausea rolls over you. Thankfully, it passes quickly and you are now more clear-minded.");
			}
			
			
			if (target.isBimbo()) {
				output("\n\n(Your intelligence and speech patterns are no longer limited to that of a bimbo.</b>)");
			}
			else if (target.isBro()) {
				output("\n\n(Your intelligence and speech patterns are no longer limited to that of a male who constantly works out.</b>)");
			}
			
			for each (item in perks) 
			{
				target.removePerk(item);
			}
			
			
			return false;
		}
	}
}

