package classes.Items.Transformatives.CoCDyes
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	
	public class CoCDye extends ItemSlotClass
	{		
		//constructor
		public function CoCDye()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "WhiteD";
			//Regular name
			this.longName = "vial of white hair dye";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a vial of white hair dye";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This bottle of white dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 250;
			
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
			
			kGAMECLASS.clearMenu();
			
			var _color:String = this.shortName.substr(0, this.shortName.length - 1).toLowerCase();
			
			if (target.hairLength > 0) {
				output("You have " + target.hairColor + " hair.");
				if (target.hairColor != _color) kGAMECLASS.addButton(0, "Hair", dyeHair, target);
				else kGAMECLASS.addDisabledButton(0, "Hair", "Hair", "Your already have " + target.hairColor + " hair!");
			} else {
				kGAMECLASS.output("You have no hair.");
				kGAMECLASS.addDisabledButton(0, "Hair", "Hair", "You are bald!");
			}
			
			if (target.skinType == 1) {
				kGAMECLASS.output("\n\nYou have " + target.furColor + " fur.");
				if (target.furColor != _color) kGAMECLASS.addButton(1, "Fur", dyeFur, target);
				else kGAMECLASS.addDisabledButton(1, "Fur", "Fur", "Your already have " + target.furColor + " fur!");
			} else {
				kGAMECLASS.output("\n\nYou have no fur.");
				kGAMECLASS.addDisabledButton(1, "Fur", "Fur", "You have no fur!");
			}
			
			addButton(14, "Back", kGAMECLASS.inventory);
			return true;
		}
		
		private function consume(target:Creature):void {
			if (kGAMECLASS.infiniteItems()) return;
			this.quantity--;
			if (this.quantity <= 0 && target.inventory.indexOf(this) != -1)
			{
				target.inventory.splice(target.inventory.indexOf(this), 1);
			}
		}
		
		private function dyeHair(target:Creature):void {
			clearOutput();
			
			var _color:String = this.shortName.substr(0, this.shortName.length - 1).toLowerCase();
			
			kGAMECLASS.output("You rub the dye into your " + target.hairDescript() + ", then use a bucket of cool lakewater to rinse clean a few minutes later.  ");
			target.hairColor = _color;
			kGAMECLASS.output("You now have " + target.hairDescript(true, true) + ".");
			if (target.lust() > 50) {
				kGAMECLASS.output("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				target.lust( -15);
			}
			
			consume(target);
			
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function dyeFur(target:Creature):void {
			clearOutput();
			
			var _color:String = this.shortName.substr(0, this.shortName.length - 1).toLowerCase();
			
			kGAMECLASS.output("You rub the dye into your fur, then use a bucket of cool water to rinse clean a few minutes later.  ");
			target.furColor = _color;
			kGAMECLASS.output("You now have " + target.furColor + " fur.");
			if (target.lust() > 50) {
				kGAMECLASS.output("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				target.lust( -15);
			}
			
			consume(target);
			
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function dyeCancel():void {
			clearOutput();
			output("You put the dye away.\n\n");
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
	}
}