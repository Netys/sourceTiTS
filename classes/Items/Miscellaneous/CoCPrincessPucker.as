package classes.Items.Miscellaneous
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCPrincessPucker extends ItemSlotClass
	{
		//constructor
		public function CoCPrincessPucker()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			
			//Used on inventory buttons
			this.shortName = "P.Pucker";
			
			//Regular name
			this.longName = "Princess Pucker";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a vial of pinkish fluid";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A vial filled with a viscous pink liquid. A label reads \"Princess Pucker\".";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 10;
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
		override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
		{			
			output("You uncork the bottle, and sniff it experimentally.  The fluid is slightly pink, full of flecks of gold, and smelling vaguely of raspberries.  Princess Gwynn said it was drinkable.\n\n");

			output("You down the bottle, hiccuping a bit at the syrupy-sweet raspberry flavor.  Immediately following the sweet is a bite of sour, like sharp lime.  You pucker your lips, and feel your head clear a bit from the intensity of flavor.  You wonder what Gwynn makes this out of.\n\n");

			output("Echoing the sensation in your head is an answering tingle in your body.  The sudden shock of citrusy sour has left you slightly less inclined to fuck, a little more focused on your priorities.\n\n");
			
			pc.lust( -20);
			pc.libido( -1);
			//if (rand(2) == 0)
			//{
				//dynStats("lus-", 20, "lib-", 2);
			//}
			//else
			//{
				//dynStats("lus-", 20, "sen-", 2);
			//}
			
			if (pc.hairColor != "pink" && pc.hasHair() && rand(5) == 0)
			{
				output("A slight tingle across your scalp draws your attention to your hair.  It seems your " + pc.hairDescript(false, true) + " is rapidly gaining a distinctly pink hue, growing in from the roots!\n\n");
				pc.hairColor = "pink";
			}
			return false;
		}
	}
}
