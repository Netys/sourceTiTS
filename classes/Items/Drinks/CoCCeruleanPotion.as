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
	
	public class CoCCeruleanPotion extends ItemSlotClass
	{
		//public const CERUL_P:SimpleConsumable = mk("Cerul P","Cerulean P.", "a cerulean-tinted potion", m.ceruleanPotion, "This is a mysterious bottle filled with a sky-blue liquid that sloshes gently inside.  Supposedly it will make you irresistible, though to what or who you cannot say.");
		public function CoCCeruleanPotion()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			//Used on inventory buttons
			this.shortName = "Cerul P.";
			//Regular name
			this.longName = "cerulean-tinted potion";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a cerulean-tinted potion";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a mysterious bottle filled with a sky-blue liquid that sloshes gently inside.  Supposedly it will make you irresistible, though to what or who you cannot say.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 750;
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
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			if (target != kGAMECLASS.pc)
			{
				output(target.capitalA + target.short + " drinks the potion to no effect.");
				return false;
			}
			
			//Repeat genderless encounters
			if (!target.hasGenitals() && kGAMECLASS.flags["COC.CERULEAN_POTION_NEUTER_ATTEMPTED"] > 0) {
				output("You take another sip of the Cerulean Potion.  You find it soothing and become very excited about the possibility of another visit from the succubus.");
			}
			else if (target.isHerm() && kGAMECLASS.flags["COC.CERULEAN_POTION_FUTA_USES"] > 0) {
				output("With anticipation, you chug down another bottle of the Cerulean Potion. A warm sensation radiates out from your stomach as you feel the potion course through your body.");
			}
			//All else
			else {
				output("The liquid tastes rather bland and goes down easily. ");
				//Special repeat texts
				if (kGAMECLASS.flags["COC.CERULEAN_POTION_DREAMS"] > 0) output("You look forwards to tonight's encounter.");
				//First timer huh?
				else output("You do not notice any real effects.  Did the merchant con you?");
			}
			if (kGAMECLASS.flags["COC.CERULEAN_POTION_DOSES"] == undefined) kGAMECLASS.flags["COC.CERULEAN_POTION_DOSES"] = 0;
			if (kGAMECLASS.flags["COC.CERULEAN_POTION_DOSES"] < 3) kGAMECLASS.flags["COC.CERULEAN_POTION_DOSES"]++;
			
			return false;
		}
	}
}

