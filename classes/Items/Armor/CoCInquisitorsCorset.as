package classes.Items.Armor
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCInquisitorsCorset extends ItemSlotClass
	{
		public function CoCInquisitorsCorset()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "I.Corst";
			
			//Regular name
			this.longName = "inquisitor's corset";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "an inquisitor's corset";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This sexualized and feminine red and gold ensemble carries with it the hopes of a shamed sorcerer.";
			//this.tooltip = "This sexualized and feminine red and gold ensemble carries with it the hopes of a shamed sorcerer.  Wearing it will cause spells to tax your health instead of exhausting you.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 20000;
			this.attack = 0;
			this.defense = 3;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 6;
			this.critBonus = 0;
			this.evasion = 1;
			this.fortification = 0;
			
			this.resistances.tease.resistanceValue = 50;
			this.resistances.psionic.resistanceValue = 50;
			
			this.resistances.addFlag(DamageFlag.NULLIFYING);
			
			this.version = _latestVersion;
		}
		
		
		override public function onEquip(targetCreature:Creature):void
		{
			output("\n\n");
			output("You remove the clothing you received from the underground chamber in the swamp.  The sexual nature of the clothing excites you a bit, as does the knowledge that it will be functional in combat.  You quickly disrobe, eager to try it on.\n\n");

			output("Checking to see whether the posture collar can be detached from the sleeves, you find a complete lack of any way to do so.  Shrugging, you slide your arms into the sleeves, sticking your middle fingers through the extended ends.  Golden embroidery down their length contains some of the most ornate and stylized pictures of dicks you have ever seen, culminating in an excessive amount of gold thread splayed in your palm, symbolizing the ejaculate.  You lift your chin to fit the posture collar in place, completely hiding your neck from view as you lace it from behind.  The dark red works nicely with your " + targetCreature.skinFurScales(true) + ".   A small amount of delight fills you as you realize the collar is not as unforgiving as a true posture collar, allowing you a comfortable amount of movement - though you do briefly wonder what a fight would be like if it didn't.\n\n");

			output("You fit the corset on next, wrapping it around your waist and chest, hiding your " + targetCreature.nipplesDescript(0) + " beneath more red and gold trim.  As you lace the corset up you realize that what you had taken for a stylized sword rising up between the cups bears a much greater resemblance to a prick.  Fair enough.  The belt practically attaches to the corset as though it were made to be a single article of clothing, clasping beneath a set of heavily stylized golden lines that you suspect are meant to be a face in the middle of either prayer or oral sex, or possibly both.\n\n");

			output("Earlier suspicions about the skirt prove correct - it does not conceal in the slightest.  It covers some skin to the right side, mostly in the back, but your front is on full display to the world.  The skirt feels as though it should go on a dancing showgirl rather than an inquisitor, but you made the choice you did and the results <i>are</i> arousing.  Golden trim takes on the form of waving and twisting tentacles as the bottom of the skirt gets closer, looking as though it wants to burst from the fabric and molest its wearer.\n\n");

			//[(if PC has human, demon, or bee feet)
			if (targetCreature.isBiped() && targetCreature.hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) {
				output("Finally you slide your legs into the boots.  The heel itself is hollow, to accommodate any natural spurs on the wearer's foot, and the rest of the boot seems surprisingly fitted to your dimensions.");
				output("  To a certain extent it feels as though it is reshaping itself as you enter - parts that initially feel tight loosen up in minutes, as if the boots were breaking themselves in.");
				//output("  If what the note said is true, and the armor adapts to he who finds it, perhaps even hooves and paws could have fit, given enough magical power used in the creation.");
				output("  Laces run up the side of each boot all the way to your thighs, resembling the corset they were paired with.  The front of them bear golden symbology, akin to the symbols  that sat on the front of the secret chamber.  Based on your previous decoding, they're halfway between a prayer and a exaltation of cock.  Standing up in them, you smile as your " + targetCreature.buttDescript() + " rises with their influence.");
			}
			// other than two is not exactly right amount
			else if (!targetCreature.isBiped())
				output("The final bit of the outfit is a pair of long-heeled lace-up boots, which, though decorated with gorgeous golden symbols spelling out what appears to be a hymn to sex, seem... relatively unusable in your current state.  You tuck them away someplace safe in case you ever become a biped again, then stand to your full height and assess yourself.");
			// not plantigrade
			// TODO: something for hooves/paws case, maybe something like hock greaves form
			else
				output("The final bit of the outfit is a pair of long-heeled lace-up boots, which, though decorated with gorgeous golden symbols spelling out what appears to be a hymn to sex, seem... relatively unusable in your current state.  You tuck them away someplace safe in case your " + targetCreature.feet(true, true) + " would ever change to more fitting form, then stand to your full height and assess yourself.");
			
			if (targetCreature.isTaur()) {
				output(" There are no way it could cover your [pc.lowerBody], but you have become accustomed to it already.");
				this.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_GROIN);
				this.addFlag(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
				this.hasRandomProperties = true;
			}
			
			output("\n\n");

			output("You feel sexy... and pious.\n\n");
			//output("You feel sexy... and pious.\n\n(<b>Perk Gained - Blood Mage</b>: Spells consume HP (minimum 5) instead of fatigue!)\n\n");
			//+lust
			targetCreature.lust(5);
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