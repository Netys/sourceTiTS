package classes.Characters.CoC
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.clearOutput;
	import classes.GLOBAL;
	import classes.Items.Melee.Whip;
	import classes.Items.Transformatives.CoCLactaid;
	import classes.kGAMECLASS;
	
	public class CoCUQMilkySuccubus extends CoCSuccubus
	{
		//constructor
		public function CoCUQMilkySuccubus()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "milky succubus";
			this.originalRace = "demon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are fighting a milky, cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts three times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.  She's using a leather whip as a weapon.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon = new Whip();
			
			//baseHPResistances.psionic.resistanceValue = 70.0;
			//baseHPResistances.drug.resistanceValue = 70.0;
			//baseHPResistances.pheromone.resistanceValue = 70.0;
			//baseHPResistances.tease.resistanceValue = 70.0;
			
			this.XPRaw = 0;
			this.level = 16;
			this.credits = 0;
			this.HPMod = 700;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 75 / 20 * this.level;
			this.reflexesRaw = 125 / 20 * this.level;
			this.aimRaw = 125 / 20 * this.level;
			this.intelligenceRaw = 95 / 20 * this.level;
			this.willpowerRaw = 95 / 20 * this.level;
			this.libidoRaw = 90;
			this.energyRaw = 100;
			this.lustRaw = 40;
			this.personality = 99;
			
			this.tallness = 7 * 12;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_BOVINE;
			this.hornLength = 13;
			
			this.breastRows[0].breastRatingRaw = 15;
			this.milkMultiplier = 10;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 100;
			this.nipplesPerBreast = 4;
			this.nippleLengthRatio = 5;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			this.createStatusEffect("Plot Fight");
			
			inventory = [];
			
			_isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			kGAMECLASS.urtaAdditionalCombatMenuEntries();
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (hasStatusEffect("MilkyUrta")) {
				addStatusValue("MilkyUrta", 1, -1);
				if (statusEffectv1("MilkyUrta") <= 0) removeStatusEffect("MilkyUrta");
			}
			
			if (!hasStatusEffect("MilkyUrta") && rand(3) == 0) cowCubiMilkSprayAttack(target);
			else if (HP() < 400 && statusEffectv1("DrankMinoCum") <= 2) drinkMinoCum(target);
			else if (target.HP() <= 100) SuccubusWhipAttack(target);
			else if (target.lustQ() >= 90) succubusTease(target);
			else if (rand(2) == 0) succubusTease(target);
			else SuccubusWhipAttack(target);
		}
		
		private function cowCubiMilkSprayAttack(target:Creature):void
		{
			//Lasts a couple turns like the goblin lust poison?
			output("\"<i>How about a taste?</i>\"  The succubus asks, pressing her tits together.  Before you can reply, a veritable jet of milk sprays in your direction!\n");
			//Miss:
			if (rangedCombatMiss(this, target)) {
				output("With your trained reflexes, you manage to duck and roll, narrowly avoiding getting sprayed with milk.");
				output("\n\n\"<i>Such a waste.</i>\"  The succubus pouts.  \"<i>No worries, I'll just have Fido clean it up later... perhaps I'll even have you do it later, when you become mine.</i>\"  The succubus giggles.");
				applyDamage(new TypeCollection( { pheromone : 6 } ).rand(), this, target);
			}
			//Hit:
			else {
				output("All you manage to do is cover your face; the rest of you, however, gets completely soaked in the demon's corrupted milk.  Looking down at yourself, you realize that you are panting, and the places where the milk splashed your fur begin to heat up.  Oh no! <b>You'd better finish off this succubus before you succumb to your lusts!</b>");
				applyDamage(new TypeCollection( { drug : 15 } ).rand(), this, target);
				createStatusEffect("MilkyUrta", 3, 0, 0, 0);
			}
		}

		private function drinkMinoCum(target:Creature):void
		{
			output("Smiling wryly and licking her lips, the succubus-cow procures a bottle of her pet's cum with her probing tail.");
			//Success:
			if (!hasStatusEffect("DrankMinoCum")) {
				output("\n\nSmiling triumphantly, she takes the bottle and opens it with a pop, drinking the contents with glee.  When done, she throws the bottle away and smacks her lips.  \"<i>Nothing like a bottle of minotaur cum to get you back on your feet, right?</i>\"  She grins, her pussy dripping with more juices.");
				HP(400);
				lust(25);
				if (!hasStatusEffect("DrankMinoCum")) createStatusEffect("DrankMinoCum", 0, 0, 0, 0);
			}
			//Failure:
			else {
				output("\n\nShe frowns and looks behind her, pouting slightly when she turns to look back at you.  \"<i>Seems like I'm all out of cum.</i>\"  She grins evilly.  \"<i>I'll just have to get more after I'm done with you.</i>\"");
			}
			addStatusValue("DrankMinoCum", 1, 1);
		}
		
		private function succubusTease(target:Creature):void
		{
			if (rand(4) == 0) output("Turning around, the succubus begins to bounce her rather round derriere in your direction, the cheeks lewdly clapping together with each change in direction, exposing her dark anal star and juicy snatch, literally gushing forth a stream of lubricants.  Her eyes glow with faint, purple light as she whispers, \"<i>Don't you just want to... slide on in?</i>\"");
			else if (rand(3) == 0) output("The succubus squeezes her spotted, sweat-oiled breasts together, squirting out trickles of fresh, creamy, succubi milk.  Bending down, she laps at her own bounty, taking to meet your eyes, her own glowing violet.  You can feel her next words as much as hear them, reaching into your brain and stirring a familiar heat in your loins.  \"<i>Giving in would mean pleasure unending, my dear vixen.</i>\"");
			else if (rand(2) == 0) output("The succubus turns slightly and slowly bends over, sliding her hands down the sides of her milk laden jugs. \"<i>Mmm, would you help a poor girl relax? These things need some attention,</i>\" she says with a lust filled moan as her hands reach her multitude of nipples.");
			else output("The succubus leans forwards holding her tits, while wrapping her fingers around her nipples.  \"<i>My boobs are soo full.  Would you like to help me drain them?</i>\" she says with a husky voice.");
			applyDamage(new TypeCollection( { tease : 20 } ).rand(), this, target);
		}
		
		public function teaseReactionsFail():void
		{
			clearOutput();
			output(capitalA + short + " smiles, rubbing her hands across herself as she watches your display.  She does not seem affected by your show.");
		}
		
		public function teaseReactions(damage:Number):String
		{
			clearOutput();
			output(capitalA + short + " smiles, rubbing her hands across herself as she watches your display.  She does not seem greatly affected by your show - at least in the sense of increasing arousal.  She does seem oddly more... vital, as if she drew strength from the very display you put on.");
			applyDamage(new TypeCollection( { truelust : damage } ), kGAMECLASS.pc, this);
			physique(5);
			HP(50);
			
			return "ABORT";
		}
	}
}