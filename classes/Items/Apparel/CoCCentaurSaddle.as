package classes.Items.Apparel 
{
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;

	public class CoCCentaurSaddle extends ItemSlotClass
	{
		public function CoCCentaurSaddle() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "Saddle";
			
			this.longName = "saddle set";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a saddle set";
			
			this.tooltip = "A set of horse harness complete with saddle, adapted for centaur.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 100;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.itemFlags = [GLOBAL.ITEM_FLAG_EXPOSE_FULL];
			
			this.targetsSelf = true;
			
			this.version = this._latestVersion;
		}
		
		//override public function get isUsable():Boolean {
			//return kGAMECLASS.pc.isTaur();
		//}
	}
}
