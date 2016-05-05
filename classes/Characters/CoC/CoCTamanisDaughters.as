package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Drinks.CoCLustDraft;
	import classes.Items.Melee.Fists;
	import classes.Items.Transformatives.CoCDyes.CoCDyeBlue;
	import classes.Items.Transformatives.CoCDyes.CoCDyeOrange;
	import classes.Items.Transformatives.CoCDyes.CoCDyePink;
	import classes.Items.Transformatives.CoCDyes.CoCDyePurple;
	import classes.Items.Transformatives.CoCEggs.CoCBlueEggLarge;
	import classes.Items.Transformatives.CoCGoblinAle;
	import classes.Items.Transformatives.CoCIncubiD;
	import classes.Items.Transformatives.CoCReducto;
	import classes.kGAMECLASS;
	
	public class CoCTamanisDaughters extends CoCGoblin
	{
		public function CoCTamanisDaughters() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Tamani's daughters";
			this.originalRace = "goblin";
			this.a = "the group of  ";
			this.capitalA = "The group of  ";
			this.long = "A large grouping of goblin girls has gathered around you, surrounding you on all sides.  Most have varying shades of green skin, though a few have yellowish or light blue casts to their skin.  All are barely clothed, exposing as much of their flesh as possible in order to excite a potential mate.  Their hairstyles are as varied as their clothing and skin-tones, and the only things they seem to have in common are cute faces and curvy forms.  It looks like they want something from you.";
			this.skinTone = "greenish";
			this.hairColor = "black";
			this.hairLength = 16;
			this.tallness = 40;
			this.isPlural = true;
			
			this.meleeWeapon = new Fists();
			
			baseHPResistances.psionic.resistanceValue = 35.0;
			baseHPResistances.drug.resistanceValue = 35.0;
			baseHPResistances.pheromone.resistanceValue = 35.0;
			baseHPResistances.tease.resistanceValue = 35.0;
			
			this.XPRaw = 750;
			this.level = 8 + (Math.floor(kGAMECLASS.flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 20));
			this.credits = (rand(15) + 5) * 10;
			this.HPMod = 50 + (int(kGAMECLASS.flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 2) * 15);
			if (this.HPMod > 3350) this.HPMod = 3350;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 55 / 20 * this.level;
			this.reflexesRaw = 45 / 20 * this.level;
			this.aimRaw = 45 / 20 * this.level;
			this.intelligenceRaw = 50 / 20 * this.level;
			this.willpowerRaw = 50 / 20 * this.level;
			this.libidoRaw = 70;
			this.personality = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			
			this.vaginas[0].bonusCapacity = 40;
			this.ass.bonusCapacity = 20;
			
			inventory = []; // subclass of goblin, gonna clean up generic loot
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCGoblinAle(), new CoCLustDraft(), new CoCDyePink(), new CoCDyeBlue, new CoCDyeOrange(), new CoCDyePurple()],
						[5,                  1,                  1,                1,              1,                  1]));
			
			sexualPreferences.clearPrefs();
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BALLS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_MASCULINE,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			this._isLoading = false;
		}
		
		override public function get long():String 
		{
			if (kGAMECLASS.flags["COC.TAMANIS_DAUGHTERS_TAMANI_PRESENT"] == 1)
				return super.long = " <b>Tamani lurks in the back of the crowd, curvier than her brood and watching with a mixture of amusement and irritation.  She runs a hand through her pink and black hair, waiting for an opportunity to get involved...</b>";
			return super.long;
		}
		
		override public function set long(value:String):void 
		{
			super.long = value;
		}

		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			//mid-round madness!
			midRoundMadness(target);
			tamaniShowsUp(target);
			
			switch (rand(3)) {
				case 0:
					output("Several of the goblins leap forward!");
					var max:int = int(flags["COC.TAMANI_NUMBER_OF_DAUGHTERS"] / 20) + 3;
					for (var i:int = 0; i < max; i++)
					{
						output("\n");
						CombatAttacks.SingleMeleeAttackImpl(this, target, true);
					}
					break;
				case 1:
					goblinDrugAttack(target);
					break;
				case 2:
				default:
					goblinTeaseAttack(target);
					break;
			}
		}
		
		private function midRoundMadness(target:Creature):void {
			var selector:Number = rand(4);
			if (selector == 0) {
				output("A slender hand reaches");
				if (!target.isCrotchExposed()) output(" inside your [pc.lowerGarments]");
				else output(" your crotch ");
				output(" and gives ");
				if (target.balls == 0 || rand(2) == 0) output(target.oneCock());
				else output("your " + target.ballsDescript());
				output(" a gentle squeeze.  You twist away but your breathing gets a little heavier.");
			}
			else if (selector == 1) {
				output("A girl latches onto your " + target.legs() + " and begins caressing your [pc.skinFurScales] lovingly, humming happily.  You quickly shake her loose but the attention makes you blush a little more.");
			}
			else if (selector == 2) {
				output("One of your daughters launches onto your back and presses her hard, pierced nipples against your neck.  She whispers in your ear, \"<i>Twist my nipples dad!</i>\"");
				output("You reach back and throw her off, but her perverted taunts still leave you feeling a little hot under the collar.\n\n");
			}
			else {
				output("A daughter lays down in front of you and starts jilling herself on the spot.  It's impossible to not glance down and see her or hear her pleasured moans.  You step away to remove the distraction but it definitely causes some discomfort in your");
				if (!target.isCrotchExposed()) output(" [pc.lowerGarments].");
				else output(" crotch.");
			}
			applyDamage(new TypeCollection( { tease: 4 + target.libido() / 15 + target.cor() / 30 } ), this, target);
			output("\n\n");
		}
		
		private function tamaniShowsUp(target:Creature):void {
			if (kGAMECLASS.flags["COC.TAMANIS_DAUGHTERS_TAMANI_PRESENT"] == 1) {
				if (rand(4) == 0) goblinDrugAttack(target); //Tamani already there - chance of potion
			}
			else if (rand(6) == 0) {
				kGAMECLASS.flags["COC.TAMANIS_DAUGHTERS_TAMANI_PRESENT"] = 1;
				output("A high-pitched yet familiar voice calls out, \"<i><b>So this is where you skanks ran off to---wait a second.  Are you trying to poach Tamani's man!?</b></i>\"\n\n");
				output("You can see Tamani lurking around the rear of the goblin pack, visibly berating her daughters.  On one hand it sounds like she might help you, but knowing goblins, she'll probably forget about her anger and help them subdue you for more cum...\n\n");
				//(+5 mob strength)
				//str += 5;
				//(+5 mob toughness)
				//tou += 5;
				HP(10);
				//(-20 mob lust)
				lust(-20);
			}
		}
	}
}