package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	import classes.kGAMECLASS;
	
	public class CoCBeautifulSword extends ItemSlotClass
	{
		//constructor
		public function CoCBeautifulSword()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "B.Sword";
			
			//Regular name
			this.longName = "beautiful sword";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a beautiful shining sword";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This beautiful sword shines brilliantly in the light, showing the flawless craftsmanship of its blade.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this blade.";
			this.attackVerb = "slash";
			attackNoun = "slash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 4000;
			this.attack = 0;
			
			baseDamage.kinetic.damageValue = 10;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 10;
			this.evasion = 5;
			this.fortification = 0;

			this.version = _latestVersion;
		}
		
		//override public function get attack():Number { 
			//var temp:int = 7 + (10 - game.player.cor / 3);
			//if (temp < 5) temp = 5;
			//return temp; 
		//}		
		
		//override public function canUse():Boolean {
			//if (kGAMECLASS.pc.cor() < 35) return true;
			//outputText("You grab hold of the handle of the sword only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the sword must be displeased.  ");
			//return false;
		//}
	}
}