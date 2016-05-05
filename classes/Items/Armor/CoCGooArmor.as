package classes.Items.Armor
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.output;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	
	public class CoCGooArmor extends ItemSlotClass
	{
		//constructor
		public function CoCGooArmor()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			//Used on inventory buttons
			this.shortName = "Goo Armor";
			
			//Regular name
			this.longName = "goo armor";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "Valeria, the goo-girl armor";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This shining suit of platemail is more than just platemail - it houses the goo-girl, Valeria!  Together, they provide one tough defense, but you had better be okay with having goo handling your junk while you fight if you wear this!";
		
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "null";
			
			//Information
			this.basePrice = 0;
			this.attack = 0;
			
			this.defense = 8;
			
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 2;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 20;
			
			resistances.kinetic.resistanceValue = 25.0;
			resistances.burning.resistanceValue = 25.0;
			resistances.corrosive.resistanceValue = 25.0;
			resistances.poison.resistanceValue = 25.0;
			resistances.freezing.resistanceValue = -25.0;
			resistances.electric.resistanceValue = -25.0;
			
			resistances.drug.resistanceValue = -20.0;
			resistances.tease.resistanceValue = -20.0;
			resistances.pheromone.resistanceValue = -20.0;
			resistances.psionic.resistanceValue = -20.0;
			
			this.version = _latestVersion;
		}
		
		override public function onEquip(targetCreature:Creature):void { //This item is being equipped by the player. Add any perks, etc.
			if (!(targetCreature is PlayerCharacter)) return;
			
			output("With an ecstatic smile, the goo-armor jumps to her feet and throws her arms around your shoulders.  \"<i>Oh, this is going to be so much fun!  Thank you thank you thank you!  I promise I'll keep you nice and snug and safe, don't you worry.  Oooh, a real adventure again!  WHEEE!</i>\"");
			output("\n\nBefore she can get too excited, you remind the goo that she's supposed to be your armor right about now.  Clasping her hands over her mouth in embarrassment, she utters a muted apology and urges you to just \"<i>put me on!</i>\"  Awkwardly, you strip out of your gear and open up the platemail armor and clamber in.  It's wet and squishy, making you shudder and squirm as you squash your new friend flat against the metal armor.");
			output("\n\nEventually, the two of you get situated. The goo-girl slips around your body inside the heavy armor, maneuvering so that your face is unobstructed and your joints, not protected by the armor, are soundly clad in squishy goo.  She even forms a gooey beaver on your new helm, allowing you to open and close her like a visor in battle.  Eventually, her goo settles around your [pc.crotch], encasing your loins in case you need a little mid-battle release, she says.");
			output("\n\nAfter a few minutes, you and your armor-friend are settled and ready to go.");
			if (int(kGAMECLASS.flags["COC.MET_VALERIA"]) == 0) {
				output("  As you ready yourself for the " + (kGAMECLASS.PhoenixTowerCleared() ? "adventures" : "dungeon") + " ahead, the goo giggles into your ear.  \"<i>Oh shit, silly me.  I forgot, my name's Valeria.  Ser Valeria, if you're feeling fancy.</i>\"  You introduce yourself, awkwardly shaking your own hand by way of pleasantries.");
				kGAMECLASS.flags["COC.MET_VALERIA"] = 1;
			}
			output("\n\n\"<i>Well alright then, [pc.name]!</i>\" Valeria says excitedly, \"<i>Let's go!</i>\"\n\n");
			//game.awardAchievement("Goo Armor", kACHIEVEMENTS.GENERAL_GOO_ARMOR);
			
			kGAMECLASS.flags["COC.VALARIA_AT_CAMP"] = 0;
		}
		
		override public function onRemove(targetCreature:Creature):void { //This item is being removed by the player. Remove any perks, etc.
			output("Valeria picks herself up and huffs, \"<i>Maybe we can adventure some more later on?</i>\" before undulating off towards your camp.\n\n(<b>Valeria now available in the followers tab!</b>)");
			kGAMECLASS.flags["COC.VALARIA_AT_CAMP"] = 1;
			quantity = 0; // can't put in inventory
		}
	}
}