package classes.Items.Melee 
{
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	
	public class CoCScarredBlade extends ItemSlotClass
	{
		public function CoCScarredBlade() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "ScarBlade";
			
			//Regular name
			this.longName = "scarred blade";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a scarred blade";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This saber, made from lethicite-imbued metal, eagerly seeks flesh; it resonates with disdain and delivers deep, jagged wounds as it tries to bury itself in the bodies of others. It only cooperates with the corrupt.";
			
			this.attackVerb = "slash";
			attackNoun = "slash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 1000;
			this.attack = 2;
			
			baseDamage.kinetic.damageValue = 10;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;

			this.version = _latestVersion;
		}
		
		//override public function get attack():Number { 
			//var temp:int = 10 + int((game.player.cor - 70) / 3)
			//if (temp < 10) temp = 10;
			//return temp; 
		//}
		//
		//override public function canUse():Boolean {
			//if (game.player.cor >= (70 - game.player.corruptionTolerance())) return true;
			//game.sheilaScene.rebellingScarredBlade(true);
			//return false;
		//}
	}
}