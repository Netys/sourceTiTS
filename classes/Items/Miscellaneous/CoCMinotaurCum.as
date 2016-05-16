package classes.Items.Miscellaneous
{
	import classes.Engine.Combat.inCombat;
	import classes.Engine.Utility.rand;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class CoCMinotaurCum extends ItemSlotClass
	{
		public function CoCMinotaurCum()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.DRUG;
			
			//Used on inventory buttons
			this.shortName = "MinoCum";
			
			//Regular name
			this.longName = "bottle of minotaur cum";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a sealed bottle of minotaur cum";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "This bottle of minotaur cum looks thick and viscous.  You know it has narcotic properties, but aside from that its effects are relatively unknown.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 600;
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
			useMinoCum(target, false);
			return false;
		}
		
		public static function useMinoCum(target:Creature, purified:Boolean):void
		{	
			kGAMECLASS.clearOutput();
			//Minotaur cum addiction
			//if (!purified) pc.minoCumAddiction(7);
			//else pc.minoCumAddiction(-2);
			kGAMECLASS.output("As soon as you crack the seal on the bottled white fluid, a ");
			
			if (kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_STATE"] > 0 && target.hasPerk("Minotaur Cum Resistance") && target.baseHPResistances.drug.resistanceValue < 100)  kGAMECLASS.output("heavenly scent fills your nostrils.");
			else kGAMECLASS.output("potent musk washes over you.");
			
			if (!purified) {
				if (kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_TRACKER"] < 50) kGAMECLASS.output("  It makes you feel dizzy, ditzy, and placid.", false);
				else kGAMECLASS.output("  It makes you feel euphoric, happy, and willing to do ANYTHING to keep feeling this way.");
			}
			else kGAMECLASS.output("  You know that the bottle is purified and you're positive you won't get any addictiction from this bottle.");
			
			kGAMECLASS.output("  Unbidden, your hand brings the bottle to your lips, and the heady taste fills your mouth as you convulsively swallow the entire bottle.");
			//-Raises lust by 10.
			//-Raises sensitivity
			//dynStats("sen", 1, "lus", 10);
			target.lust(10);
			//-Raises corruption by 1 to 50, then by .5 to 75, then by .25 to 100.
			if (!purified) {
				if (target.cor() < 50) target.cor(1);
				else if (target.cor() < 75) target.cor(0.5);
				else target.cor(0.25);
			}
			kGAMECLASS.output("\n\nIntermittent waves of numbness wash through your body, turning into a warm tingling that makes you feel sensitive all over.  The warmth flows through you, converging in your loins and bubbling up into lust.");
			if (target.hasCock()) {
				kGAMECLASS.output("  ");
				if (target.cockTotal() == 1) kGAMECLASS.output("Y");
				else kGAMECLASS.output("Each of y");
				kGAMECLASS.output("our [pc.cocksLight] aches, flooding with blood until it's bloating and trembling.");
			}
			
			if (target.hasVagina()) {
				kGAMECLASS.output("  Your [pc.clits] engorges, ");
				if (target.clitLength < 3) kGAMECLASS.output("parting your lips.");
				else kGAMECLASS.output("bursting free of your lips and bobbing under its own weight.");
				if (target.wetness() < 2) kGAMECLASS.output("  Wetness builds inside you as your [pc.vaginas] tingles and aches to be filled.");
				else if (target.wetness() < 3) kGAMECLASS.output("  A trickle of [pc.girlcum] escapes your [pc.vaginas] as your body reacts to the desire burning inside you.");
				else if (target.wetness() < 4) kGAMECLASS.output("  Wet [pc.girlcum] leak down your thighs as your body reacts to this new stimulus.");
				else kGAMECLASS.output("  Slick [pc.girlcum] soak your thighs as your body reacts to this new stimulus.");
			}
			
			//(Minotaur fantasy)
			if (!inCombat() && rand(10) == 1 && (!purified && target.hasPerk("Minotaur Cum Resistance")) && target.baseHPResistances.drug.resistanceValue < 100) {
				kGAMECLASS.output("\n\nYour eyes flutter closed for a second as a fantasy violates your mind.  You're on your knees, prostrate before a minotaur.  Its narcotic scent fills the air around you, and you're swaying back and forth with your belly already sloshing and full of spunk.  Its equine-like member is rubbing over your face, and you submit to the beast, stretching your jaw wide to take its sweaty, glistening girth inside you.  Your tongue quivers happily as you begin sucking and slurping, swallowing each drop of pre-cum you entice from the beastly erection.  Gurgling happily, you give yourself to your inhuman master for a chance to swallow into unthinking bliss.", false);
				target.libido(1);
				target.lust(rand(5) + target.cor() / 20 + kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_TRACKER"] / 5);
			}
			
			//(Healing – if hurt and uber-addicted (hasperk))
			if (target.HP() < target.maxHP() && target.hasPerk("Minotaur Cum Addict")) {
				kGAMECLASS.output("\n\nThe fire of your arousal consumes your body, leaving vitality in its wake.  You feel much better!");
				target.HP(target.HPMax() / 4);
			}
			
			//Uber-addicted status!
			if (target.hasPerk("Minotaur Cum Addict") && kGAMECLASS.flags["COC.MINOTAUR_CUM_REALLY_ADDICTED_STATE"] == undefined && !purified && target.baseHPResistances.drug.resistanceValue < 100) {
				kGAMECLASS.flags["COC.MINOTAUR_CUM_REALLY_ADDICTED_STATE"] = 3 + rand(2);
				kGAMECLASS.output("\n\n<b>Your body feels so amazing and sensitive.  Experimentally you pinch yourself and discover that even pain is turning you on!</b>", false);
			}

			//Clear mind a bit
			if (purified && (target.hasPerk("Minotaur Cum Addict") || kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_TRACKER"] >= 40)) {
				kGAMECLASS.output("\n\nYour mind feels a bit clearer just from drinking the purified minotaur cum. Maybe if you drink more of these, you'll be able to rid yourself of your addiction?");
				if (target.hasPerk("Minotaur Cum Addict") && kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_TRACKER"] <= 50) {
					kGAMECLASS.output("  Suddenly, you black out and images flash in your mind about getting abducted by minotaurs and the abandonment of your quest that eventually leads to Lethice's success in taking over Mareth. No, it cannot be! You wake up and recover from the blackout, horrified to find out what would really happen if you spend the rest of your life with the Minotaurs! You shake your head and realize that you're no longer dependent on the cum.  ");
					kGAMECLASS.output("\n<b>(Lost Perk: Minotaur Cum Addict!)</b>");
					target.removePerk("Minotaur Cum Addict");
				}
			}
		}
	}
}
