package classes.Items.Armor
{
	import classes.Creature;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class CoCBeeArmor extends ItemSlotClass
	{
		public function CoCBeeArmor()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "BeeArmr";
			
			//Regular name
			this.longName = "sexy black chitin armor-plating";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a set of chitinous armor";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A suit of armor cleverly fashioned from giant bee chitin. It comes with a silken loincloth to protect your modesty.";
		
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 300;
			this.attack = 0;
			this.defense = 3;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 4;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.resistances.kinetic.resistanceValue = 30;
			this.resistances.electric.resistanceValue = 0;
			this.resistances.burning.resistanceValue = 0;
			this.resistances.freezing.resistanceValue = 0;
			this.resistances.corrosive.resistanceValue = 0;
			this.resistances.poison.resistanceValue = 0;
			
			resistances.addFlag(DamageFlag.PLATED);
			
			this.version = _latestVersion;
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