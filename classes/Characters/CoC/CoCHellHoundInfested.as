package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatAttacks;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	
	public class CoCHellHoundInfested extends CoCHellHound
	{
		//constructor
		public function CoCHellHoundInfested()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "infested hellhound";
			this.long = "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.";
			
			this.level = 5;
			this.XPRaw = normalXP();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 50 / 20 * this.level;
			this.aimRaw = 50 / 20 * this.level;
			this.intelligenceRaw = 1 / 20 * this.level;
			this.willpowerRaw = 1 / 20 * this.level;
			this.libidoRaw = 95;
			this.energyRaw = 100;
			this.lustRaw = 50;
			this.HPMod = 25;
			this.HPRaw = this.HPMax();
			this.personality = 100;
			
			this.ballSizeRaw = 5 * Math.PI;
			this.cumMultiplierRaw *= 2;
			this.createStatusEffect("Infested");
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(3) == 0) hellhoundFire(target);
			else if(!hasStatusEffect("Flee Disabled") && rand(3) == 0 && !target.hasWings()) hellhoundScent(target)
			else if(rand(3) == 0 && lust() >= 70) hellHoundWormCannon(target)
			else CombatAttacks.MeleeAttack(this, target);
		}
		
		//[Extra special attack]
		private function hellHoundWormCannon(target:Creature):void
		{
			output("The thing rears up onto its hind legs, revealing its more humanoid stature, and allowing it to use its flexible paws to caress its twinned-penises.  It lurches forwards powerfully, its thickness twitching and flaring as it launches a wave of worm-filled canine cum at you.");
			output("\n");
			if (rand(2) == 0) {
				//Get hit – 10+ lust
				var teasePower:Number = 5 + (target.libido() / 20);
				output("Taken off-guard by the unexpected sexual display, you fail to move out of the way, and the wormy jism splatters you from the chest down.");
				if (target.hasStatusEffect("Infested") && target.hasCock()) {
					output("  The worms inside you begin moving and squirming. A few of your cum-soaked parasites crawl out from your shivering [pc.multiCocks] as if attempting to meet the new arrivals.  You desperately want to brush them away, but the pleasure in your crotch is too good to fight, and you find yourself staying your hand as each and every one of the new worms makes it way into your [pc.cocks].");
					if (target.balls > 0) output("  Your [pc.balls] grow weightier as the worms settle into their new home, arousing you beyond measure.");
					else output("  You can feel them shifting around inside you as they adjust to their new home, arousing you beyond measure.");
					teasePower += 10;
				}
				else if (target.hasCock()) {
					output("  The worms wriggle and squirm all over you, working their way towards your groin.  It tickles pleasantly, but you brush them away before they can get inside you.  The thought of being turned into a worm-dispensing cum fountain is horrifying, but it leaves you hard.");
					teasePower += 5 + target.cor() / 20;
				}
				else if (target.hasVagina()) output("  Thankfully, the worms don't seem to want anything to do with you, and rapidly drop down to the ground.");
				
				applyDamage(new TypeCollection( { tease : teasePower } ).rand(), this, target, "minimal");
			}
			//Sidestep
			else {
				output("You sidestep the gush of wormy fluid, letting it splatter against the rocks behind you.");
				//(If infested +10 lust:  
				if (target.hasStatusEffect("Infested") && target.hasCock()) {
					output("  Despite avoiding the torrent of infected seed, your own wormy [pc.balls] wriggle");
					if (target.balls == 0 && target.cockTotal() == 1 || target.balls == 1) output("s");
					output(" hotly, expelling a few of your own worms in response along with a dribble of thick pre-cum.   You wonder what it would feel like to let his worms crawl inside you...");
					applyDamage(new TypeCollection( { tease : 5 + target.cor() / 20 } ).rand(), this, target, "minimal");
				}
				//if aroused by worms +5 lust:
				else if (kGAMECLASS.flags["COC.WORMS_ENABLED"] == 0) {
					output("  The idea of being covered in the beast's infested seed arouses you slightly, but you shake your head violently and clear away the unwelcome thought.");
					applyDamage(new TypeCollection( { tease : 2 + target.cor() / 20 } ).rand(), this, target, "minimal");
				}
			}
			lust( -25);
		}
	}
}