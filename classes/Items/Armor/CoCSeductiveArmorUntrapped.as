package classes.Items.Armor 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.output;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.StringUtil;
	import classes.GameData.TooltipManager;
	
	public class CoCSeductiveArmorUntrapped extends ItemSlotClass
	{
		// super("SeductU","U.SeductA","untrapped seductive armor","a set of untrapped scandalously seductive armor",10,1,"A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.  This armor is not trapped.", "Heavy", PerkLib.SluttySeduction,5,0,0,0);
		public function CoCSeductiveArmor() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			this.shortName = "SeductU";
			
			this.longName = "untrapped seductive armor";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a set of untrapped scandalously seductive armor";
			
			this.tooltip = "A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.  This armor is not trapped.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 0;
			this.attack = 0;
			this.defense = 2;
			this.shieldDefense = 0;
			this.sexiness = 4;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			itemFlags.push(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
			
			this.version = this._latestVersion;
		}
	}
}