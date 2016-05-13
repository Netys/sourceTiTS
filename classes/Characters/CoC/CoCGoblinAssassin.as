package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.Items.Transformatives.CoCDyes.*;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	public class CoCGoblinAssassin extends CoCGoblin
	{
		public function CoCGoblinAssassin() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Originally a clone of the zilpack
			// Needs a few things checked.
			this.short = "goblin assassin";
			this.originalRace = "goblin";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "Her appearance is that of a regular goblin, curvy and pale green, perhaps slightly taller than the norm. Her wavy, untamed hair is a deep shade of blue, covering her pierced ears and reaching just above her shoulders. Her soft curves are accentuated by her choice of wear, a single belt lined with assorted needles strapped across her full chest and a pair of fishnet stockings reaching up to her thick thighs. She bounces on the spot, preparing to dodge anything you might have in store, though your eyes seem to wander towards her bare slit and jiggling ass. Despite her obvious knowledge in combat, she’s a goblin all the same – a hard cock can go a long way.";
			this.customDodge = "Goblin's small frame allows her to handily avoid your attack.";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "needles";
			this.meleeWeapon.attackVerb = "throw";
			this.meleeWeapon.attackNoun = "tiny punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "leather straps";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.physiqueRaw = 45 / 20 * this.level;
			this.reflexesRaw = 110 / 20 * this.level;
			this.aimRaw = 110 / 20 * this.level;
			this.intelligenceRaw = 95 / 20 * this.level;
			this.willpowerRaw = 95 / 20 * this.level;
			this.libidoRaw = 65;
			this.personality = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 50;
			
			this.level = 10;
			this.XPRaw = normalXP();
			this.credits = (rand(50) + 25) * 10;
			this.HPMod = 70;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.createStatusEffect("Disarm Immune");
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var options:Array = [];
			
			if (target.lust() >= target.lustMax() * 0.6)
			{
				if (rand(4) == 0) {
					CombatAttacks.MeleeAttack(this, target);
					return;
				}
				options.push(goblinDrugAttack);
				options.push(goblinDrugAttack);
				options.push(goblinTeaseAttack);
				options.push(lustNeedle);
				options.push(lustNeedle);
			}
			else if (target.HP() <= target.HPMax() * 0.4)
			{
				if (rand(2) == 0) {
					CombatAttacks.MeleeAttack(this, target);
					return;
				}
				options.push(goblinDrugAttack);
				options.push(goblinDrugAttack);
				options.push(goblinTeaseAttack);
				options.push(lustNeedle);
				options.push(goblinExplosion);
				options.push(dualShot);
				options.push(dualShot);
			}
			else
			{
				if (rand(3) == 0) {
					CombatAttacks.MeleeAttack(this, target);
					return;
				}
				options.push(goblinDrugAttack);
				options.push(goblinDrugAttack);
				options.push(goblinExplosion);
				options.push(lustNeedle);
				options.push(dualShot);
			}
			
			options[rand(options.length)](target);
		}
		
		protected override function goblinDrugAttack(target:Creature):void {
			var color:String = RandomInCollection("red", "green", "blue", "white", "black");
			//Throw offensive potions at the player
			if (color != "blue") {
				output(capitalA + short + " uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.");
			}
			//Drink blue pots
			else {
				output(capitalA + short + " pulls out a blue vial and uncaps it, swiftly downing its contents.");
				if (HPQ() < 100) {
					output("  She looks to have recovered from some of her wounds!\n");
					HP(maxHP() / 4);
				}
				else output("  There doesn't seem to be any effect.\n");
			}
			//Dodge chance!
			if (rangedCombatMiss(this, target, -1, 1.33)) {
				output("\nYou narrowly avoid the gush of alchemic fluids!\n");
			}
			//Get hit!
			//Temporary heat
			if (color == "red") {
				output("\nThe red fluids hit you and instantly soak into your skin, disappearing.  Your skin flushes and you feel warm.  Oh no...\n");
				//if (pc.findStatusEffect(StatusEffects.TemporaryHeat) < 0) pc.createStatusEffect(StatusEffects.TemporaryHeat,0,0,0,0);
				applyDamage(new TypeCollection( { drug : target.libido() / 10 + target.cor() / 10 + 10 } ), this, target);
			}
			//Green poison
			if (color == "green") {
				output("\nThe greenish fluids splash over you, making you feel slimy and gross.  Nausea plagues you immediately - you have been poisoned!\n");
				//if (pc.findStatusEffect(StatusEffects.Poison) < 0) pc.createStatusEffect(StatusEffects.Poison,0,0,0,0);
				applyDamage(new TypeCollection( { poison : damageRand(this.rangedDamage().multiply(1.5), 15).getTotal() } ), this, target);
			}
			//sticky flee prevention
			if (color == "white") {
				output("\nYou try to avoid it, but it splatters the ground around you with very sticky white fluid, making it difficult to run.  You'll have a hard time escaping now!\n");
				target.createStatusEffect("Flee Disabled", 0, 0, 0, 0, false, "Icon_Splatter", "You are all sticky and can't run away!", true, 0);
			}
			//Increase fatigue
			if (color == "black") {
				output("\nThe black fluid splashes all over you and wicks into your skin near-instantly.  It makes you feel tired and drowsy.\n");
				target.energy(-(10 + rand(25)));
			}
		}
		
		//Lust Needle
		protected function lustNeedle(target:Creature):void {
			output("With a swift step, the assassin vanishes, her movements too quick for you to follow. You take a sharp breath as you feel her ample thighs clench your head in between them, her slick cunt in full view as you take in her scent.");
			//Miss
			if (combatMiss(this, target))
			{
				//Miss: 
				output("\nYou’ve already prepared, however, as you hold your breath and grab the goblin by her sides. Unhindered by her advance, you take the opportunity to move backwards, throwing the goblin off balance and leaving you only faintly smelling of her pussy.");
				applyDamage(damageRand(new TypeCollection( { tease : target.libido() / 10 + 4 } ), 15), this, target);
			}
			//Hit: 
			else 
			{
				output("\nYou’re far too distracted to notice the needle injected into the back of your neck, but by the time she flips back into her original position you already feel the contents of the syringe beginning to take effect.");
				applyDamage(damageRand(new TypeCollection( { tease : target.libido() / 10 + 4, drug : target.libido() / 2 + 16 } ), 15), this, target);
			}
		}
		
		//Dual Shot
		protected function dualShot(target:Creature):void {
			output("The assassin throws a syringe onto the ground, shattering it and allowing the dissipating smoke from its contents to distract you long enough for her to slip underneath you. With a quick flick of her wrists two needles are placed into her hands, though you’ve already caught wind of her movements.");
			//Miss: 
			if (combatMiss(this, target)) 
			{
				output("\nYou jump backwards, far enough to avoid her quick thrust upwards as she attempts to lick the area in which your crotch once stood. Realising her situation, she quickly removes herself from the ground and faces you, more determined than before.");
			}
			//Hit: 
			else {
				output("\nBefore you can do anything to stop her, she lifts her head and takes a swift lick of your crotch, taking a small moan from you and giving her enough time to stab into the back of your knees. She rolls out of the way just as you pluck the two needles out and throw them back to the ground. They didn’t seem to have anything in them, but the pain is enough to make you stagger. ");
				//(Medium HP loss, small lust gain)
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(1.5);
				damage.add(new TypeCollection( { tease : 1 + target.libido() / 20 } ));
				damageRand(damage, 15);
				applyDamage(damage, this, target);
			}
		}
		
		//Explosion
		protected function goblinExplosion(target:Creature):void {
			output("Without a second thought, the assassin pulls a thin needle from the belt wrapped around her chest and strikes it against the ground, causing a flame to erupt on the tip. She twirls forward, launching the needle in your direction which subsequently bursts apart and showers you with heat.");
			output("\nYou shield yourself from the explosion, though the goblin has already lit a second needle which she throws behind you, launching your body forwards as it explodes behind your back. ");
			//(High HP loss, no lust gain)
			applyDamage(damageRand(new TypeCollection( { burning : 15 + rand(25), kinetic : 15 + rand(25) }, DamageFlag.EXPLOSIVE ), 15), this, target);
		}
	}
}