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
	
	public class CoCGodMead extends ItemSlotClass
	{
		//constructor
		public function CoCGodMead()
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
			this.basePrice = 300;
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
			target.cor( -1);
			//Health/HP(Large increase; always occurs):
			output("\n\nYou feel suddenly invigorated by the potent beverage, like you could take on a whole horde of barbarians or giants and come out victorious! ");
			var healing:int = target.HP();
			target.HP(target.maxHP() * .33);
			healing = int(target.HP() - healing);
			if (healing > 0) output(" <b>+" + healing + " HP</b>");
			
			healing = target.energy();
			target.energy(25);
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
			//Grow Beard [ONLY if PC has a masculine face & a dick.)( -- Why? Bearded ladies are also a fetish [That's just nasty.] (I want a lady beard)): A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. You now sport a fine [pc.HairColor] beard!
			if (rand(target.isMasculine() ? 3 : 9) == 0 && target.beardLength < 4) {
				if (target.beardLength <= 0) output("A sudden tingling runs along your chin. You rub it with your hand, and find a thin layer of bristles covering your lower face. <b>You now sport a fine " + target.hairColor + " beard!</b>");
				else output("\n\nA sudden tingling runs along your chin. You stroke your beard proudly as it slowly grows in length and lustre.");
				target.beardLength += 0.5;
			}
			target.imbibeAlcohol(35);
			return false;
		}
	}
}

