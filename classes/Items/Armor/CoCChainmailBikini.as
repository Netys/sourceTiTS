package classes.Items.Armor 
{
	import classes.Creature;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.StringUtil;
	import classes.GameData.TooltipManager;
	
	public class CoCChainmailBikini extends ItemSlotClass
	{
		public function CoCChainmailBikini() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			this.shortName = "ChBikni";
			
			this.longName = "revealing chainmail bikini";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a chainmail bikini";
			
			this.tooltip = "A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 7000;
			this.attack = 0;
			this.defense = 1;
			this.shieldDefense = 0;
			this.sexiness = 4;
			this.critBonus = 0;
			this.evasion = 2;
			this.fortification = 0;
			
			this.version = this._latestVersion;
		}
		
		override public function onEquip(targetCreature:Creature):void
		{
			if (targetCreature.isTaur()) {
				output(" There are no way it could cover your [pc.lowerBody], though.");
				this.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
				this.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
				this.hasRandomProperties = true;
			}
		}
		
		override public function onRemove(targetCreature:Creature):void
		{
			if(this.hasRandomProperties) {
				this.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
				this.deleteFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
				this.hasRandomProperties = false;
			}
		}
	}
}