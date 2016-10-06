package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCMinotaurAxe;
	import classes.Items.Miscellaneous.CoCMinotaurCum;
	import classes.Items.Transformatives.CoCMinotaurBlood;
	import classes.kGAMECLASS;
	
	public class CoCUQMinotaurLord extends CoCMinotaur
	{
		//constructor
		public function CoCUQMinotaurLord()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "minotaur lord";
			this.originalRace = "minotaur";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "Across from you is the biggest minotaur you've ever seen.  Fully eleven feet tall, this shaggy monstrosity has muscles so thick that they stand even through his thick, obscuring fur.  A leather collar with a tag indicates his status as 'pet' though it seems completely out of place on the herculean minotaur.  His legs and arms are like thick tree trunks, imposing and implacable, flexing fiercely with every movement.  This can only be a minotaur lord, a minotaur of strength and virility far beyond his lesser brothers. In his hands, a massive chain swings, connected to his collar, but used as an impromptu weapon for now.  A simple loincloth girds his groin, though it does little to hide the massive, erect length that tents it.  It winds up looking more like a simple, cloth condom than any sort of clothing, and it drips long strings of musky pre-slime in ribbons onto the ground.  Below, heavy testes, each easily the size of a basketball, swing in a taut, sloshing sack.  You can almost smell the liquid bounty he has for you, and the musk he's giving off makes it seem like a good idea...";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "chain-whip";
			this.meleeWeapon.attackNoun = "chain-whip";
			this.meleeWeapon.longName = "chain";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 20;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "thick fur";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			//baseHPResistances.psionic.resistanceValue = 66.0;
			//baseHPResistances.drug.resistanceValue = 66.0;
			//baseHPResistances.pheromone.resistanceValue = 66.0;
			//baseHPResistances.tease.resistanceValue = 66.0;
			
			this.XPRaw = 0;
			this.level = 15;
			this.credits = 0;
			this.HPMod = 700;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 125 / 20 * this.level;
			this.reflexesRaw = 30 / 20 * this.level;
			this.aimRaw = 30 / 20 * this.level;
			this.intelligenceRaw = 20 / 20 * this.level;
			this.willpowerRaw = 20 / 20 * this.level;
			this.libidoRaw = 70;
			this.energyRaw = 100;
			this.lustRaw = 50;
			this.personality = 85;
			
			this.tallness = 11 * 12;
			this.cocks[0].cLengthRaw = 36;
			this.ballSizeRaw = 8 * Math.PI;
			this.inventory = [];
			this.createStatusEffect("Plot Fight");
			
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
			
			if (HP() < 300 && statusEffectv1("MinoMilk") < 4) minotaurDrankMalk(target);
			else if (rand(4) == 0 && !target.hasStatusEffect("Disarmed")) minotaurDisarm(target);
			else if (!hasStatusEffect("Timer")) minotaurLordEntangle(target);
			else if (target.hasStatusEffect("Grappled")) minotaurCumPress(target);
			else {
				if (rand(2) == 0) minotaurPrecumTease(target);
				else CombatAttacks.MeleeAttack(this, target);
			}
		}

		private function minotaurDrankMalk(target:Creature):void //Only procs during Urta's quest.
		{
			output("The minotaur lord snorts audibly and turns to look at his mistress.  \"<i>What is it, Fido, boy?  You thirsty?</i>\"  The hulking minotaur nods.");
			//Success:*
			if (statusEffectv1("MinoMilk") < 3) {
				output("\"<i>Catch!</i>\"  The succubus throws a bottle containing a milky-white substance to the minotaur.  He grabs it and uncorks the bottle, quickly chugging its contents with obvious enjoyment.  After he is done he looks even more energetic and ready to fight, and his cock looks even harder!");
				HP(300);
				lust(10);
				if (!hasStatusEffect("MinoMilk")) createStatusEffect("MinoMilk", 0, 0, 0, 0);
			}
			//Failure:*
			else {
				output("\"<i>Well too bad!  We're all out of milk... but don't worry, my dear pet, I'll let you drink as much as you want after you're done with this bitch.</i>\"  The succubus replies, idly checking her elongated nails.");
				output("\n\nThe minotaur glares at you and snorts, obviously pissed at not getting his serving...");
			}
			addStatusValue("MinoMilk", 1, 1);
		}

		private function minotaurDisarm(target:Creature):void
		{
			output("The giant of a minotaur raises his chain threateningly into the air, clearly intent on striking you down.  With your trained reflexes, you quickly move to block his blow with your halberd.  You recoil as the chain impacts your halberd with a loud clang, wrapping around it.  You smile triumphantly at the minotaur, only to glance at his smirk.  With a strong pull, he rips the halberd off your hands and into a corner of the room. Shit!");
			output("\n\nThe succubus laughs maniacally.  \"<i>Good boy, Fido!  Take that fox slut's toys away so she'll be easier to play with!</i>\"  The minotaur puffs his chest, proud of himself for pleasing his mistress.");
			target.createStatusEffect("Disarmed", 3, 0, 0, 0, false, "Blocked", "Cannot use normal melee or ranged attacks!", true, 0);
		}

		private function minotaurLordEntangle(target:Creature):void
		{
			output("The minotaur lord lashes out with his chain, swinging in a wide arc!\n");
			createStatusEffect("Timer", 2 + rand(4), 0, 0, 0);
			//{dodge/whatever}
			if (rangedCombatMiss(this, target)) {
				output("You leap over the clumsy swing, allowing the chain to fly harmlessly underneath you!");
			}
			else {
				output("You try to avoid it, but you're too slow, and the chain slaps into your hip, painfully bruising you with the strength of the blow, even through your armor.  The inertia carries the back half of the whip around you, and in a second, the chain has you all wrapped up with your arms pinned to your sides and your movement restricted.");
				output("\n\n\"<i>Hahaha!  Good boy, Fido!  Leash that bitch up!</i>\"  The succubus laughs with glee.");
				target.createStatusEffect("Grappled", 0, 0, 0, 0, false, "Icon_Constricted", "You are entangled!", true);
			}
		}

		private function minotaurCumPress(target:Creature):void
		{
			output("The minotaur lord tugs on the end of the chain, pulling you toward him, making you spin round and round so many times that you're dazed and dizzy.  You can feel the links coming free of your " + target.skinFurScales() + ", and the closer you get, the more freedom of movement you have.  Yet, the dizziness makes it hard to do anything other than stumble.  You splat into something wet, sticky, and spongy.  You gasp, breathing a heavy gasp of minotaur musk that makes your head spin in a whole different way.  You pry yourself away from the sweaty, sperm-soaked nuts you landed on and look up, admiring the towering horse-cock with its three-rings of pre-puce along its length.  A droplet of pre-cum as fat as your head smacks into your face, staggering you back and dulling your senses with narcotic lust.");
			applyDamage(new TypeCollection( { drug : target.libido() / 4 + 22 } ).rand(), this, target);
			//kGAMECLASS.dynStats("lus", 22 + pc.lib / 8 + pc.sens / 8);
			output("You tumble to your knees a few feet away, compulsively licking it up.  Once it's gone, ");
			if (target.lustQ() > 99) output("you rise up, horny and hungry for more.");
			else {
				output("you realize what you've been doing.  Your embarrassment gives you the strength to re-adopt your fighting pose, but it's hard with how ");
				if (target.hasCock()) {
					output("rigid");
					if (target.lustQ() >= 80) output(" and drippy");
					output(" your cock has become.  ")
					
				}
				else if (target.hasVagina()) {
					output("wet your pussy has become.  ");
				}
				else {
					output("aroused you feel in your groin.  ");
				}
				output("You want another taste...");
			}
			target.removeStatusEffect("Grappled");
		}
		
		private function minotaurPrecumTease(target:Creature):void
		{
			output("The minotaur smiles at you and lifts his loincloth, flicking it at you.  Thick ropes of pre-cum fly through the air in a swarm,");
			if (rand(2) == 0) {
				output(" slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ");
				if (target.lustQ() >= 70) output("swallowing it into your mouth without thinking.  You greedily guzzle the potent, narcotic aphrodisiac down, even going so far as to lick it from each of your fingers in turn, sucking every drop into your waiting gullet.");
				else output("feeling your heart hammer lustily.");
				
				applyDamage(new TypeCollection( { pheromone : target.libido() / 4 + 15 } ).rand(), this, target);
				//kGAMECLASS.dynStats("lus", 15 + pc.lib / 8 + pc.sens / 8);
			}
			else {
				output(" right past your head, but the smell alone is enough to make you weak at the knees.");
				output("  The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin, stiffening your horse-cock to absurd degrees.");
				applyDamage(new TypeCollection( { pheromone : target.libido() / 10 + 11 } ).rand(), this, target);
				
				//kGAMECLASS.dynStats("lus", 11 + pc.lib / 10);
			}
			//(1)
			if (target.lustQ() <= 75) output("  You shiver with need, wanting nothing more than to bury your face under that loincloth and slurp out every drop of goopey goodness.");
			else output("  <b>You groan and lick your lips over and over, craving the taste of him in your mouth.</b>");
		}
	}
}