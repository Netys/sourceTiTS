package classes.Items.Transformatives
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	
	public class CoCHairSerum extends ItemSlotClass
	{
		//constructor
		public function CoCHairSerum()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "ExtSerm";
			//Regular name
			this.longName = "hair extension serum";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle of hair extension serum";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a bottle of foamy pink liquid, purported by the label to increase the speed at which the user's hair grows.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 60;
			
			this.combatUsable = false;
			this.targetsSelf = true;
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
			
			this.version = this._latestVersion;
		}

		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			kGAMECLASS.clearOutput();
			
			if (!(target is PlayerCharacter))
			{
				output(target.capitalA + target.short + " refuses to use it.");
				return false;
			}
			
			if (kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_TIME"] == undefined) kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_TIME"] = 0;
			if (kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] == undefined) kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] = 0;
			
			if (kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] >= 3)
			{
				kGAMECLASS.output("<b>No way!</b>  Your head itches like mad from using the rest of these, and you will NOT use another.");
				return false;
			}
			
			this.quantity--; // ugh... where are .consume function?
			if (this.quantity <= 0 && target.inventory.indexOf(this) != -1)
			{
				target.inventory.splice(target.inventory.indexOf(this), 1);
			}
			
			kGAMECLASS.output("You open the bottle of hair extension serum and follow the directions carefully, massaging it into your scalp and being careful to keep it from getting on any other skin.  You wash off your hands with lakewater just to be sure.");
			if (kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] <= 0) {
				kGAMECLASS.output("\n\nThe tingling on your head lets you know that it's working!");
				kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] = 1;
			}
			else if (kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] == 1) {
				kGAMECLASS.output("\n\nThe tingling intensifies, nearly making you feel like tiny invisible faeries are massaging your scalp.");
				kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] = 2;
			}
			else {
				kGAMECLASS.output("\n\nThe tingling on your scalp is intolerable!  It's like your head is a swarm of angry ants, though you could swear your hair is growing so fast that you can feel it weighing you down more and more!");
				kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"] = 3;
			}
			
			kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_TIME"] = 7 * 24 * kGAMECLASS.flags["COC.INCREASED_HAIR_GROWTH_SERUM_POWER"]; // from one to three ticks per day
			
			clearMenu();
			addButton(0, "Next", kGAMECLASS.inventory);
			
			//if (game.flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0 && game.player.hairType != 4) {
				//game.flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				//kGAMECLASS.output("\n\n<b>Somehow you know that your " + game.player.hairDescript() + " is growing again.</b>");
			//}
			
			return true;
		}
	}
}