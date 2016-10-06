package classes.Items.Combat
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
	
	public class CoCLustStick extends ItemSlotClass
	{
		//constructor
		public function CoCLustStick()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "LustStk";
			//Regular name
			this.longName = "a tube of golden lipstick";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "tube of golden lipstick";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This tube of golden lipstick is used by harpies to keep males aroused. It has aphrodisiac properties on anyone with male genitalia and is most effective when applied to the lips or groin.";

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
			if (usingCreature != kGAMECLASS.pc)
			{
				output(usingCreature.capitalA + usingCreature.short + " considers it unwise to use drugged lipstick.");
				return false;
			}
			
			if (usingCreature.hasStatusEffect("LustStick Makeup")) {
				usingCreature.addStatusMinutes("LustStick Makeup", rand(12 * 60) + 12 * 60);
				output("You carefully open the sweet-smelling tube and smear the lipstick over the coat you already have on your lips. <b>No doubt another layer will make it last even longer!</b> ");
				output("You finish and pucker your lips, feeling fairly sexy with your new, thicker makeup on.");
			}
			else {
				usingCreature.createStatusEffect("LustStick Makeup", 0, 0, 0, 0, false, "Icon_Lips_Glossed", "You have a drugged lipstick allied to your lips.", false, 24 * 60, 0xFFD700);
				output("You carefully open the sweet-smelling tube and smear the lipstick over your lips. ");
				if (usingCreature.hasCock()) output("It tingles a little, but the drugs have little to no effect on you now.");
				else output("Honestly, it amazes you that something as little as a kiss can make a man putty in your hands.");
				output(" You finish and pucker your lips, feeling fairly sexy with your new makeup on.");
			}
			usingCreature.lust(1);
			return false;
		}
	}
}

