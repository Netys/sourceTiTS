package classes.Items.Miscellaneous 
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.StringUtil;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.kGAMECLASS;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.inCombat;
	import classes.Engine.Interfaces.output;
	import classes.Engine.Interfaces.clearOutput;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class EMPGrenade extends ItemSlotClass
	{
		
		public function EMPGrenade() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.EXPLOSIVECONSUMABLE;
			
			this.shortName = "EMP Gren.";
			
			this.longName = "EMP grenade";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "an EMP grenade";
			
			this.tooltip = "Used by soldiers and police officers to quickly neutralize shielded or robotic opponents, modern EMP grenades temporarily fry electronics. Though individually expensive, these little babies pretty much pay for themselves when you're up against a heavily shielded enemy or an assassin droid!";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 100;
			baseDamage = new TypeCollection();
			baseDamage.electric.damageValue = 15;
			baseDamage.addFlag(DamageFlag.EXPLOSIVE);
			
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.combatUsable = true;
			this.targetsSelf = false;
			
			this.version = this._latestVersion;
		}
		
		override public function useFunction(targetCreature:Creature, usingCreature:Creature = null):Boolean
		{
			if (!inCombat())
			{
				if(!kGAMECLASS.infiniteItems()) quantity++;
				if (targetCreature == kGAMECLASS.pc)
				{
					clearOutput();
					output("Pulling the pin on a grenade without a target to throw it at would be pretty dumb now, wouldn't it?\n");
				}
				else
				{
					if(inCombat()) output("\n");
					else clearOutput();
					output(targetCreature.capitalA + targetCreature.short + " considers it unwise to use a grenade outside of combat.\n");
					output("\n");
				}
				return false;
			}
			else
			{
				// Player used an item
				if (usingCreature == kGAMECLASS.pc)
				{
					kGAMECLASS.clearOutput();
					playerUsed(targetCreature, usingCreature);
				}
				// Enemy used an item on the PC
				else if (targetCreature == kGAMECLASS.pc && usingCreature != kGAMECLASS.pc)
				{
					if(inCombat()) kGAMECLASS.output("\n\n");
					else kGAMECLASS.clearOutput();
					npcUsed(targetCreature, usingCreature);
				}
				else
				{
					throw new Error("Don't know how we got here. Exception for debugging.");
				}
				
				return false;
			}
		}
		
		public function playerUsed(targetCreature:Creature, usingCreature:Creature):void
		{
			kGAMECLASS.output("You throw the grenade at the " + targetCreature.short + "!");
			
			// Ideally, should probably rebuild this function on a per-item basis to weave item-specific text
			// into the combat, and lean on the shield/hp damage functions
			// Or possibly open up genericDamageApply to also accept override text for its output
			applyDamage(baseDamage, usingCreature, targetCreature);
			
			// Apply stun to types that are electronic in nature
			if (!targetCreature.hasStatusEffect("Blinded") && (targetCreature.originalRace == "robot" || targetCreature.originalRace == "Automaton"))
			{
				targetCreature.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "An electrical burst has temporarily stunned your target!", true, 0);
				kGAMECLASS.output("\n\nThe electronic burst from the grenade as temporarily disrupted " + targetCreature.a + targetCreature.short + "’s systems!");
			}
		}
		
		public function npcUsed(targetCreature:Creature, usingCreature:Creature):void
		{
			kGAMECLASS.output(usingCreature + " threw a grenade at");
			if (targetCreature == kGAMECLASS.pc) kGAMECLASS.output(" you!");
			else kGAMECLASS.output(" " + targetCreature.short);
			
			//kGAMECLASS.genericDamageApply(this.damage, usingCreature, targetCreature, this.damageType);
			applyDamage(baseDamage, usingCreature, targetCreature);
		}
	}

}
