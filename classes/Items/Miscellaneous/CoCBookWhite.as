package classes.Items.Miscellaneous
{
	import classes.Creature;
	import classes.Engine.Interfaces.clearOutput;
	import classes.Engine.Interfaces.output;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	
	public class CoCBookWhite extends ItemSlotClass
	{
		//constructor
		public function CoCBookWhite()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.ALL;
			
			//Used on inventory buttons
			this.shortName = "W. Book";
			
			//Regular name
			this.longName = "small book with a pristine white cover";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a small book with a pristine white cover";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 400;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.combatUsable = false;
			this.targetsSelf = true;
			
			this.version = _latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			output("You open the white tome, and discover it to be an instructional book on the use of white magic.  Most of it is filled with generic information about white magic - how it is drawn for mental focus, is difficult to use when tired or aroused, and can be used to create and control energy.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (target.IQ() < 30) {
				output("\n\nYou feel greatly enlightened by your time spent reading.");
			}
			else if (target.IQ() < 60) {
				output("\n\nSpending some time reading was probably good for you, and you definitely feel smarter for it.");
			}
			else if (target.IQ() < 80) {
				output("\n\nAfter reading the small tome your already quick mind feels invigorated.");
			}
			else {
				output("\n\nThe contents of the book did little for your already considerable intellect.");
			}
			target.slowStatGain("i", 4 * target.intelligenceMax() / 100);
				
			//Smart enough for Charge Weapon and doesnt have it
			if (target.IQ() >= 25 && kGAMECLASS.flags["COC.SPELL_CHARGE"] != 1) {
				output("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Charge Weapon.</b>");
				kGAMECLASS.flags["COC.SPELL_CHARGE"] = 1;
				return false;
			}
			//Smart enough for Blind and doesnt have it
			if (target.IQ() >= 30 && kGAMECLASS.flags["COC.SPELL_BLIND"] != 1) {
				output("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Blind.</b>");
				kGAMECLASS.flags["COC.SPELL_BLIND"] = 1
				return false;
			}
			//Smart enough for Whitefire and doesnt have it
			if (target.IQ() >= 40 && kGAMECLASS.flags["COC.SPELL_WHITEFIRE"] != 1) {
				output("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Whitefire.</b>");
				kGAMECLASS.flags["COC.SPELL_WHITEFIRE"] = 1
				return false;
			}
			return false;
		}
	}
}
