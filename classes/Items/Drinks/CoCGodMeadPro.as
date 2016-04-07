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
	
	public class CoCGodMeadPro extends ItemSlotClass
	{
		//constructor
		public function CoCGodMeadPro()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			//Used on inventory buttons
			this.shortName = "ProMead";
			//Regular name
			this.longName = "pint of premium god's mead";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a pint of premium god's mead";
			//Displayed on tooltips during mouseovers
			this.tooltip = "A horn of incredibly potent, honey-colored mead. A single whiff makes your head swim and your thoughts turn to violence and heroism.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 1500;
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
			output("You take a hearty swig of mead, savoring the honeyed taste on your tongue.  Emboldened by the first drink, you chug the remainder of the horn's contents in no time flat.  You wipe your lips, satisfied, and let off a small belch as you toss the empty horn aside.  ");

			//Corruption: No desc., always decreases.
			target.cor( -3);
			//Health/HP(Large increase; always occurs):
			output("\n\nYou feel suddenly invigorated by the potent beverage, like you could take on a whole horde of barbarians or giants and come out victorious! ");
			var healing:int = target.HP();
			target.HP(target.maxHP());
			healing = int(target.HP() - healing);
			if (healing > 0) output(" <b>+" + healing + " HP</b>");
			
			healing = target.energy();
			target.energy(target.energyMax());
			healing = int(target.energy() - healing);
			if (healing > 0) output(" <b>+" + healing + " Energy</b>");
			
			if (rand(3) == 0) {
				output("\n\nThe alcohol fills your limbs with vigor, making you feel like you could take on the world with just your fists!");
				if (kGAMECLASS.silly) output("  Maybe you should run around shirtless, drink, and fight!  Saxton Hale would be proud.");
				target.slowStatGain("p", 1);
			}
			//Tough:
			else {
				output("\n\nYou thump your chest and grin - your foes will have a harder time taking you down while you're fortified by liquid courage.");
				target.slowStatGain("w", 1);
			}
			//Libido: No desc., always increases.
			target.slowStatGain("l", 1);
			
			
			healing = target.lust();
			target.lust(Math.max(20 + rand(6), target.lustMin()), true);
			healing = int(target.lust() - healing);
			
			if (healing != 0) {
				output("\n\nYou sudenly feel yourself a little randy... Just a little.");
				output(" <b>" + healing + " Lust</b>");
			}
			
			target.imbibeAlcohol(100);
			return false;
		}
	}
}

