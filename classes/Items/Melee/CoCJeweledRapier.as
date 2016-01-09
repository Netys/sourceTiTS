package classes.Items.Melee
{
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	import classes.kGAMECLASS;
	
	public class CoCJeweledRapier extends ItemSlotClass
	{
		public function CoCJeweledRapier()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.MELEE_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "JRapier";
			
			//Regular name
			this.longName = "jeweled rapier";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a jeweled rapier";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This jeweled rapier is ancient but untarnished.  The hilt is wonderfully made, and fits your [pc.hand] like a tailored glove.  The blade is shiny and perfectly designed for stabbing.";
			this.attackVerb = "slash";
			attackNoun = "slash";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 14000;
			this.attack = 5;
			
			baseDamage.kinetic.damageValue = 3;
			baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 20;
			this.evasion = 10;
			this.fortification = 0;

			this.version = _latestVersion;
		}
		
		//override public function get attack():Number {
			//var boost:int = 0;
			//if (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			//else boost += 4 + (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			//return (13 + boost); 
		//}
	}
}