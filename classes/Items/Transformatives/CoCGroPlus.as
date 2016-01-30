package classes.Items.Transformatives
{
	import classes.GameData.TooltipManager;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCGroPlus extends ItemSlotClass
	{
		public function CoCGroPlus()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.DRUG;
			//Used on inventory buttons
			this.shortName = "GroPlus";
			//Regular name
			this.longName = "GroPlus";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a needle filled with Gro+";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This is a small needle with a reservoir full of blue liquid.  A faded label marks it as 'GroPlus'.  Its purpose seems obvious.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 500;
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
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			if (!(target is PlayerCharacter))
			{
				output(target.capitalA + target.short + " refuses to use GroPlus.");
				return false;
			}
			clearMenu();
			output("You ponder the needle in your hand knowing it will enlarge the injection site.  What part of your body will you use it on?\n\n");
			
			kGAMECLASS.addDisabledButton(0, "Balls", "Balls", "You need balls to use GroPlus on them.");
			kGAMECLASS.addDisabledButton(1, "Breasts", "Breasts", "You need breasts to use GroPlus on them.");
			kGAMECLASS.addDisabledButton(2, "Clit", "Clit", "You need clit to use GroPlus on it.");
			kGAMECLASS.addDisabledButton(3, "Cock", "Cock", "You need cock to use GroPlus on it.");
			kGAMECLASS.addDisabledButton(4, "Nipples", "Nipples", "You need nipples to use GroPlus on them.");
			
			addButton(14, "Nevermind" , function():*{
				kGAMECLASS.clearOutput();
				kGAMECLASS.clearMenu();
				kGAMECLASS.output("You put the vial away.\n\n");
				kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
			});
			
			if (target.balls > 0) kGAMECLASS.addButton(0, "Balls", growPlusBalls);
			if (target.breastRows.length > 0) kGAMECLASS.addButton(1, "Breasts", growPlusBreasts);
			if (target.hasClit()) kGAMECLASS.addButton(2, "Clit", growPlusClit);
			if (target.hasCock()) kGAMECLASS.addButton(3, "Cock", growPlusCock);
			if (target.hasNipples()) kGAMECLASS.addButton(4, "Nipples", growPlusNipples);
			
			return true;
		}
		
		private function consume():void {
			this.quantity--;
			if (this.quantity <= 0 && kGAMECLASS.pc.inventory.indexOf(this) != -1)
			{
				kGAMECLASS.pc.inventory.splice(kGAMECLASS.pc.inventory.indexOf(this), 1);
			}
		}
		
		private function growPlusBalls():void {
			kGAMECLASS.clearOutput();
			consume();
			kGAMECLASS.output("You sink the needle deep into your [pc.sack].  It hurts like hell, but you push down the plunger and the pain vanishes as the needles contents flow into you.\n\n");
			//1 in 4 BIG growth.
			if (rand(4) == 0) {
				output("You feel a trembling in your [pc.balls] as the chemicals start to go to work.  You can tell they're going to be VERY effective.\n");
				kGAMECLASS.pc.ballSize(rand(4) + 2);
				output("They shift, stretching your [pc.sack] tight as they gain inches of size.  You step to steady yourself as your center of balance shifts due to your newly enlarged [pc.balls].  ");
			}
			else {
				kGAMECLASS.pc.ballSize(rand(2) + 1);
				output("You feel your testicles shift, pulling the skin of your [pc.sack] a little bit as they grow to [pc.balls].  ");
			}
			if (kGAMECLASS.pc.ballSize() > 10) output("Walking gets even tougher with the swollen masses between your [pc.legs].  Maybe this was a bad idea.");
			kGAMECLASS.pc.lust(10);
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}

		private function growPlusBreasts():void {
			kGAMECLASS.clearOutput();
			consume();
			kGAMECLASS.output("You sink the needle into the flesh of your [pc.fullChest] injecting each with a portion of the needle.\n\n");
			Mutator.growTits(kGAMECLASS.pc, rand(5) + 1, kGAMECLASS.pc.breastRows.length, true, 1);
			kGAMECLASS.pc.lust(10);
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}

		private function growPlusClit():void {
			kGAMECLASS.clearOutput();
			consume();
			kGAMECLASS.output("You sink the needle into your clit, nearly crying with how much it hurts.  You push down the plunger and the pain vanishes as your clit starts to grow.\n\n");
			kGAMECLASS.pc.clitLength += 1;
			kGAMECLASS.output("Your [pc.clit] stops growing after an inch of new flesh surges free of your netherlips.  It twitches, feeling incredibly sensitive.");
			//kGAMECLASS.dynStats("sen", 2, "lus", 10);
			kGAMECLASS.pc.lust(10);
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}

		private function growPlusCock():void {
			kGAMECLASS.clearOutput();
			consume();
			kGAMECLASS.output("You sink the needle into the base of your [pc.multiCocks].  It hurts like hell, but as you depress the plunger, the pain vanishes, replaced by a tingling pleasure as the chemicals take effect.\n\n");
			if (kGAMECLASS.pc.cocks.length == 1) {
				kGAMECLASS.output("[pc.EachCock] twitches and thickens, pouring extra inches of thick new length from your ");
				kGAMECLASS.pc.increaseCock(3 + rand(2), 0);
			}
			//MULTI
			else {
				kGAMECLASS.output("Your [pc.multiCocks] twitch and thicken, each member pouring extra inches of new length from your ");
				for (var i:int = 0; i < kGAMECLASS.pc.cocks.length; i++) {
					kGAMECLASS.pc.increaseCock(2 + rand(2), i);
				}
			}
			if (kGAMECLASS.pc.hasFullSheaths())
				kGAMECLASS.output("sheath.");
			else output("crotch.");
			//kGAMECLASS.dynStats("sen", 2, "lus", 10);
			kGAMECLASS.pc.lust(10);
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}

		private function growPlusNipples():void {
			kGAMECLASS.clearOutput();
			consume();
			kGAMECLASS.output("You sink the needle into each of your [pc.nippls] in turn, dividing the fluid evenly between them.  Though each injection hurts, the pain is quickly washed away by the potent chemical cocktail.\n\n");
			//Grow nipples
			kGAMECLASS.output("Your nipples engorge");
			if(!kGAMECLASS.pc.isChestExposed()) kGAMECLASS.output(" prodding hard against the inside of your [pc.upperGarment]");
			kGAMECLASS.output(".  Abruptly you realize they've grown more than an additional quarter-inch.\n\n");
			kGAMECLASS.pc.nippleLengthRatio += (rand(2) + 3) / 5;
			//NIPPLECUNTZZZ
			if (!kGAMECLASS.pc.hasFuckableNipples() && rand(4) == 0) {
				var nowFuckable:Boolean = false;
				for (var x:int = 0; x < kGAMECLASS.pc.breastRows.length; x++) {
					if (!kGAMECLASS.pc.breastRows[x].fuckable() && kGAMECLASS.pc.nippleLength(x) >= 2) {
						kGAMECLASS.pc.breastRows[x].nippleType = GLOBAL.NIPPLE_TYPE_FUCKABLE;
						nowFuckable = true;
					}
				}
				//Talk about if anything was changed.
				if (nowFuckable) kGAMECLASS.output("Your [pc.fullChest] tingle with warmth that slowly migrates to your nipples, filling them with warmth.  You pant and moan, rubbing them with your fingers.  A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free.  <b>You now have fuckable nipples!</b>\n\n");
			}
			kGAMECLASS.pc.lust(15);
			kGAMECLASS.clearMenu();
			kGAMECLASS.addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
	}
}

