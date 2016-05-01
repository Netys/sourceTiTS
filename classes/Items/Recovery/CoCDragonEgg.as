package classes.Items.Recovery
{
	import classes.Engine.Combat.inCombat;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCDragonEgg extends ItemSlotClass
	{
		//public const DRGNEGG:SimpleConsumable = mk("DrgnEgg","DrgnEgg","an unfertilized dragon egg", m.eatEmberEgg,"A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.");
		public function CoCDragonEgg()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.FOOD;
			
			//Used on inventory buttons
			this.shortName = "DrgnEgg";
			
			//Regular name
			this.longName = "unfertilized dragon egg";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "an unfertilized dragon egg";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A large, solid egg, easily the size of your clenched fist.  Its shell color is reddish-white, with blue splotches.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 60;
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
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			if(inCombat()) output("\n");
			else kGAMECLASS.clearOutput();
			
			if(target is PlayerCharacter)
			{
				output("You crack the shell easily and swallow the large yolk and the copious amounts of albumen - the yolk is blue, while the rest is crimson-tinted.  It tastes like... well, it tastes mostly of spiced mint, you think.");
				
				if (target.hasPerk("Dragonfire")) {
					if (target.hasStatusEffect("DragonfireCD")) target.removeStatusEffect("DragonfireCD");
					else {
						if (!target.hasStatusEffect("DragonBreathBoost")) target.createStatusEffect("DragonBreathBoost");
					}
					//(if PC has breath weapon)
					//Boosts the special effect of Dragonbreath by 20% for 1 use. ie: if Tainted's breath weapon has a 80% chance to stun on hit, +20% equals 100% chance to stun.
					output("\n\nA sudden surge of energy fills your being and you feel like you could blast anything to atoms with a single breath, like the mighty dragons of legends.");
				}
			}
			else
			{
				output(target.capitalA + target.short + " cracks the shell easily and swallows the large yolk and the copious amounts of albumen.\n");
			}
			
			target.energy(20);
			
			return false;
		}
	}
}
