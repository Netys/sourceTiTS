package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Armor.CoCChainmailBikini;
	import classes.Items.Drinks.*;
	import classes.Items.Guns.CoCCentaurBow;
	import classes.Items.Melee.CoCScimitar;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCHelspawn extends Creature
	{
		public function CoCHelspawn() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = kGAMECLASS.flags["COC.HELSPAWN_NAME"];
			this.originalRace = "salamander";
			this.a = "";
			this.capitalA = "";
			this.long = "OVERRIDE";
			this.customDodge = "";
			this.customBlock = "";
			
			if (kGAMECLASS.flags["COC.HELSPAWN_WEAPON"] == "bow")
				this.meleeWeapon = new EmptySlot();
			else this.meleeWeapon = new CoCScimitar();
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 20.0;
			baseHPResistances.drug.resistanceValue = 20.0;
			baseHPResistances.pheromone.resistanceValue = 20.0;
			baseHPResistances.tease.resistanceValue = 20.0;
			
			baseHPResistances.burning.resistanceValue = 75;
			baseHPResistances.freezing.resistanceValue = -50;
			
			this.armor.longName = "scales";
			this.armor.defense = 8;
			this.armor.hasRandomProperties = true;
			
			if (kGAMECLASS.flags["COC.HELSPAWN_WEAPON"] == "bow")
				this.rangedWeapon = new CoCCentaurBow();
			else this.rangedWeapon = new EmptySlot();
			
			this.level = 12;
			this.XPRaw = normalXP();
			this.credits = (10 + rand(5)) * 10;
			this.HPMod = 175;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 50 / 20 * this.level;
			this.reflexesRaw = 65 / 20 * this.level;
			this.aimRaw = 65 / 20 * this.level;
			this.intelligenceRaw = 40 / 20 * this.level;
			this.willpowerRaw = 40 / 20 * this.level;
			this.libidoRaw = 35;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 20;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "red";
			this.tallness = 90;
			this.thickness = 40;
			this.tone = 75;
			this.hairColor = "red";
			this.scaleColor = "dusky";
			this.furColor = "none";
			this.hairLength = 13;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "dusky";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_LIZAN;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_LIZAN;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_THICK, GLOBAL.FLAG_PREHENSILE];
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = 0;
			//tailGenital:
			//0 - none.
			//1 - cock
			//2 - vagina
			this.tailGenital = 0;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRatingRaw = 12;
			//buttRating
			//0 - buttless
			//2 - tight
			//4 - average
			//6 - noticable
			//8 - large
			//10 - jiggly
			//13 - expansive
			//16 - huge
			//20 - inconceivably large/big/huge etc
			this.buttRatingRaw = 9;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 1;
			this.vaginas[0].bonusCapacity = 85;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 12;
			
			this.nippleColor = "green";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.analVirgin = true;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 85;
			
			this.createStatusEffect("Disarm Immune");
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function get long():String 
		{
			return kGAMECLASS.flags["COC.HELSPAWN_NAME"] + " is a young salamander, appearing in her later teens.  Clad in " +
							(kGAMECLASS.flags["COC.HELSPAWN_PERSONALITY"] >= 50 ?
									"a slutty scale bikini like her mother's, barely concealing anything" :
									"a short skirt, thigh-high boots, and a sky-blue blouse, in stark contrast to her mother’s sluttier attire") +
							", she stands about six feet in height, with a lengthy, fiery tail swishing menacingly behind her. She's packing a " +
							{
								'bow': "recurve bow, using blunted, soft-tipped arrows",
								'scimitar': "scimitar, just like her mom's, and holds it in the same berzerk stance Helia is wont to use",
								'scimitar and shield': "scimitar and shield, giving her a balanced fighting style"
							}[kGAMECLASS.flags["COC.HELSPAWN_WEAPON"]] +
							".  Pacing around you, the well-built young warrior intently studies her mentor's defenses, readying for your next attack.";
		}
		
		override public function set long(value:String):void 
		{
			super.long = value;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var choices:Array = [];
			choices[choices.length] = helspawnTwinStrikes;
			//Bowmander only
			if (kGAMECLASS.flags["COC.HELSPAWN_WEAPON"] == "bow") choices[choices.length] = calledShot;
			//Zerker ability
			if (armor.defense > 0 || kGAMECLASS.flags["COC.HELSPAWN_WEAPON"] == "scimitar") choices[choices.length] = helSpawnBerserk;
			if (kGAMECLASS.flags["COC.HELSPAWN_WEAPON"] == "scimitar and shield") choices[choices.length] = helSpawnShieldBash; //Shield Bash (Shieldmander Only)
			if (kGAMECLASS.flags["COC.HELSPAWN_PERSONALITY"] >= 50) choices[choices.length] = sluttyMander; //Tease (Sluttymander Only)
			//Focus (Chastemander Only)
			//Self-healing & lust restoration
			if (kGAMECLASS.flags["COC.HELSPAWN_PERSONALITY"] < 50 && energy() >= 20) choices[choices.length] = helSpawnFocus;
			choices[rand(choices.length)](target);
			//Tail Whip
			if (rand(4) == 0) tailWhipShitYo(target);
		}

		//Basic Attack - Twin Strike
		// Two light attacks
		private function helspawnTwinStrikes(target:Creature):void {
			//if Bowmander
			if (kGAMECLASS.flags["COC.HELSPAWN_WEAPON"] == "bow") {
				output(short + " leaps back out of your reach and nocks a pair of blunted arrows, drawing them back together and loosing them at once!\n");
				CombatAttacks.SingleRangedAttackImpl(this, target, false);
				output("\n");
				CombatAttacks.SingleRangedAttackImpl(this, target, false);
			}
			else {
				output(short + " lunges at you, scimitar cleaving through the air toward your throat!\n");
				CombatAttacks.SingleMeleeAttackImpl(this, target, false);
				output("\n");
				CombatAttacks.SingleMeleeAttackImpl(this, target, false);
			}
		}
		
		public function onCleanup():void {
			if (kGAMECLASS.pc.hasStatusEffect("Crippling Shot")) {
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv1("Crippling Shot"));
				kGAMECLASS.pc.removeStatusEffect("Crippling Shot");
			}
		}
		
		//Called Shot (Bowmander Only)
		// Super-high chance of hitting. On hit, speed debuff
		private function calledShot(target:Creature):void {
			output(short + " draws back her bowstring, spending an extra second aiming before letting fly!");
			//standard dodge/miss text
			if (rangedCombatMiss(this, target, -1, 0.5)) output("\nYou avoid the hit!");
			else {
				output("\nOne of her arrows smacks right into your [pc.leg], nearly bowling you over.  God DAMN that hurt! You're going to be limping for a while! ");
				
				if (!target.hasStatusEffect("Crippling Shot") < 0) target.createStatusEffect("Crippling Shot", 0, 0, 0, 0, false, "Icon_Slow", "You are slowed down by an arrow in your knee!");
				var slow:Number = 0.15 * target.reflexesMax();
				while(slow > 0 && target.reflexes() > 2) {
					slow--;
					target.addStatusValue("Crippling Shot", 1, 1);
					target.reflexes( -1);
				}
				
				applyDamage(rangedDamage().multiply(2), this, target, "minimal");
			}
		}

		//Berzerkergang (Berzerkermander Only)
		//Gives Helspawn the benefit of the Berzerk special ability
		private function helSpawnBerserk(target:Creature):void {
			output(short + " lets out a savage warcry, throwing her head back in primal exaltation before charging back into the fray with utter bloodlust in her wild eyes!");
			meleeWeapon.baseDamage.kinetic.damageValue *= 2;
			armor.defense = 0;
			armor.evasion = 0;
		}

		//Shield Bash (Shieldmander Only)
		private function helSpawnShieldBash(target:Creature):void {
			clearOutput();
			// Stuns a bitch
			output(short + " lashes out with her shield, trying to knock you back!");
			//standard dodge/miss text
			if (combatMiss(this, target)) output("\nYou evade the strike.");
			else {
				output("\nHer shield catches you right in the face, sending you tumbling to the ground and leaving you open to attack! ");
				applyDamage(meleeDamage().multiply(0.7), this, target, "melee");
				if (rand(2) == 0 && !target.hasStatusEffect("Stunned")) {
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
					output(" <b>The hit stuns you.</b>");
				}
			}
		}
		
		//Tail Whip
		private function tailWhipShitYo(target:Creature):void {
			// Light physical, armor piercing (fire, bitch). Random chance to get this on top of any other attack
			output("\n" + short + " whips at you with her tail, trying to sear you with her brilliant flames!");
			//standard dodge/miss text
			if (combatMiss(this, target)) output("\nYou evade the strike.");
			else {
				output("\n" + short + "'s tail catches you as you try to dodge.  Your [pc.gear] sizzles, and you leap back with a yelp as she gives you a light burning. ");
				applyDamage(new TypeCollection( { kinetic : physique() / 3, burning : physique() / 3 } ), this, target, "minimal");
			}
		}

		//Tease (Sluttymander Only)
		private function sluttyMander(target:Creature):void {
			// Medium Lust damage
			output(short + " jumps just out of reach before spinning around, planting her weapon in the ground as she turns her backside to you and gives her sizable ass a rhythmic shake, swaying her full hips hypnotically.");
			//if no effect:
			if (rand(2) == 0) {
				output("\nWhat the fuck is she trying to do?  You walk over and give her a sharp kick in the kiester, \"<i>Keep your head in the game, kiddo.  Pick up your weapon!</i>\"");
				applyDamage(new TypeCollection( { kinetic : target.physique() / 4 } ), target, this, "minimal");
			}
			else {
				output("\nDat ass.  You lean back, enjoying the show as the slutty little salamander slips right past your guard, practically grinding up against you until you can feel a fire boiling in your loins!");
				applyDamage(new TypeCollection( { tease : 10 + target.libido() / 10 } ), this, target, "minimal");
			}
		}

		//Focus (Chastemander Only)
		//Self-healing & lust restoration
		private function helSpawnFocus(target:Creature):void {
			output("Seeing a momentary lull in the melee, " + short + " slips out of reach, stumbling back and clutching at the bruises forming all over her body.  \"<i>Come on, " + short + ", you can do this. Focus, focus,</i>\" she mutters, trying to catch her breath.  A moment later and she seems to have taken a second wind as she readies her weapon with a renewed vigor.");
			lust( -30);
			HP(maxHP() / 3);
			energy( -20);
		}
	}
}