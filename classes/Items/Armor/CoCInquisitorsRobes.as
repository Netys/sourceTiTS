package classes.Items.Armor
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCInquisitorsRobes extends ItemSlotClass
	{
		public function CoCInquisitorsRobes()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "I.Robes";
			
			//Regular name
			this.longName = "inquisitor's robes";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "an inquisitor's robes";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "These foreboding red and gold robes are embroidered with the symbols of a lost kingdom.";
			//this.tooltip = "These foreboding red and gold robes are embroidered with the symbols of a lost kingdom.  Wearing them will cause spells to tax your health instead of exhausting you.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 20000;
			this.attack = 5;
			this.defense = 6;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 5;
			this.evasion = 0;
			this.fortification = 0;
			
			this.resistances.burning.resistanceValue = 30;
			this.resistances.freezing.resistanceValue = 30;
			
			this.resistances.tease.resistanceValue = 30;
			this.resistances.psionic.resistanceValue = 30;
			
			this.resistances.addFlag(DamageFlag.NULLIFYING);
			
			this.version = _latestVersion;
		}
		
		
		override public function onEquip(targetCreature:Creature):void
		{
			output("\n\n");
			output("You unfold the robes you received from the secret chamber in the swamp and inspect them.  They have not changed since the last time you saw them - perhaps the transformative magic promised in the letter has been exhausted.  Looking at the two separate parts to the outfit, it becomes clear that the mantle is constructed of a thicker fabric and is intended to be the primary protection of the outfit - what protection a robe can provide, at least.  The undershirt is made of a much lighter material, and you dare say that it could prove quite a classy number on its own.  You strip naked and then slip into the robe.\n\n");
			
			output("The degree to which it fits you is moderately surprising.  For lack of a better word, it seems to be perfect.  The fabric does not cling to you, but gives you a full range of movement.  There is a clasp over the high collar, displaying a golden sword.  Though your arms are bare the holes through which your arms extend are comfortable, and have the same golden trim as the collar.  Along the middle of the robe the trim gathers around the waist, descending down the skirt in two lines.  As it reaches the bottom it explodes into elaborate embroidery circling around the back, patterning based on holy symbols and iconography that may have meant something long ago before the advent of demons.  Between the two lines of gold a sword is displayed, similar to the one on the collar's clasp.  You take a few dramatic movements to see how it responds, and find that you continue to enjoy free movement.\n\n");
			
			output("Taking the heavier coat, you slide your hands into the sleeves, and secure the belt firmly around your waist.  Your initial concern was that the sleeves would be too open, but in making a few quick motions with your hands you don't feel that the cloth gets in the way.  The weight of the gold-trimmed hood surprises you somewhat, but you quickly grow accustomed.  After attempting to move the hood down you realize that doing so is remarkably difficult; it's designed by clever stitching and wires to stay up, and straight.  You suppose that unless you're overheating there's no real need to adjust it.  The coat covers the undershirt's waist decorations, hiding them completely behind its belt.  Now-familiar sword imagery runs over your back, along your spine.  The loops of the belt meet twice - once behind your back, and once beneath the clasp.\n\n");
			
			output("To finish the look, you take the two fingerless alchemical gloves and slide them over your hands.  What seems to be a prayer is embroidered in gold on their back.\n\n");
			
			if (targetCreature.isTaur()) {
				output("There are no way it could cover your [pc.lowerBody], but you have become accustomed to it already.\n\n");
				this.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
				this.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
				this.hasRandomProperties = true;
			}
			
			output("You feel pious.\n\n");
			//output("You feel pious.\n\n(<b>Perk Gained - Blood Mage</b>: Spells consume HP (minimum 5) instead of fatigue!)\n\n");
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