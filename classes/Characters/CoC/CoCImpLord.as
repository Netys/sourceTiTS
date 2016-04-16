package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Utility.weightedRand;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	public class CoCImpLord extends CoCImp
	{
		public function CoCImpLord()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "imp lord";
			this.originalRace = "imp";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, lust-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works its way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe greater imp, like most imps wear very little clothing; only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.";
			this.customBlock = "";
			this.isPlural = false;
					
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 15;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "leathery skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 250;
			this.level = 7;
			this.credits = (rand(15) + 25) * 10;
			this.HPMod = 100;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 55 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 42 / 20 * this.level;
			this.willpowerRaw = 42 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 100;
			
			this.legType = GLOBAL.TYPE_DEMONIC;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_HOOVES, GLOBAL.FLAG_DIGITIGRADE];
			
			this.inventory = [];
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCSucMilk(), new CoCIncubiD(), new CoCImpFood(), new CoCMinotaurBlood(), new CoCLaBova()] ,
						[6,                6,                4,                1,                      1]));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var choices:Array = [impFire, impLordLustAttack2, impLordLustAttack, impLordHeavyEncounter, eAttack];
			choices[rand(choices.length)](target);
		}
		
		protected function eAttack(target:Creature):void
		{
			CombatAttacks.MeleeAttack(this, target);
		}
		
		
		//Special Attack 1
		protected function impFire(target:Creature):void
		{
			output("The imp mutters something to himself. Before you have time to react the demonic creature's hand is filled with a bright red fire that he hurls at you.  The flames lick at your body leaving a painful burn on you torso, as well as an arousing heat in your groin. ");
			//[-HP // +Lust(minor)]
			applyDamage(new TypeCollection( { burning : 40 + rand(10), psionic : 20 + target.cor() / 10 } ), this, target);
		}
		
		//Heavy Attack
		protected function impLordHeavyEncounter(target:Creature):void
		{
			output("The demonic creature slashes a clawed hand towards your stomach,");
			if (rangedCombatMiss(this, target)) output(" but you handily avoid it.");
			else {
				output("leaving a large gash. The attack leaves you slightly stunned, but you recover. ");
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(1.5);
				damageRand(damage, 15);
				applyDamage(damage, this, target);
			}
		}
		
		//Lust Attack
		protected function impLordLustAttack(target:Creature):void
		{
			output("Lowering his loincloth the imp reveals his " + cockDescript() + ".  He smirks and licks his lips as he gives his cock a squeeze, milking a few beads of clear pre from the " + cockHead() + ".  You shake your head and try to ignore your growing need.");
			//[+Lust]
			applyDamage(damageRand(new TypeCollection( { tease : 5 + target.cor() / 5 + target.libido() / 5 } ), 15), this, target);
		}

		//Lust and Light Attack
		protected function impLordLustAttack2(target:Creature):void
		{
			output("Reaching into his satchel the devilish creature pulls out a leather riding crop.  He quickly rushes forward, but somehow manages to get behind you.  Before you can react the imp lashes out, striking your [pc.butt] twice with the riding crop.  The strikes leave a slight burning feeling, as well as a strange sense of arousal. ");
			//[-HP(minor) // +Lust]
			applyDamage(damageRand(new TypeCollection( { psionic : 5 + target.cor() / 10 + target.libido() / 4, kinetic : 3 + rand(10) } ), 15), this, target);
		}
	}
}