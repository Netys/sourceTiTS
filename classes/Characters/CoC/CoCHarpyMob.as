package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCHarpyMob extends CoCHarpy
	{
		public function CoCHarpyMob() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "harpy horde";
			this.originalRace = "harpy";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are surrounded by a wing of particularly large and muscular harpies, perhaps a dozen of them in total.  All of them are clad in simple brown shifts that give them good camouflage in the mountains, and are using their talon-like claws as weapons against you. While not a great threat to a champion of your ability individually, a whole brood of them together is... something else entirely.";
			this.customDodge = "";
			this.customBlock = "";
			this.isPlural = true;
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "talons";
			this.meleeWeapon.attackVerb = "slashing talons";
			this.meleeWeapon.attackNoun = "slash";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 15;
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 80.0;
			baseHPResistances.drug.resistanceValue = 80.0;
			baseHPResistances.pheromone.resistanceValue = 80.0;
			baseHPResistances.tease.resistanceValue = 80.0;
			
			this.armor.longName = "feathers";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 500;
			this.level = 18;
			this.credits = (rand(25) + 140) * 10;
			this.HPMod = 1000;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 50 / 20 * this.level;
			this.reflexesRaw = 120 / 20 * this.level;
			this.aimRaw = 120 / 20 * this.level;
			this.intelligenceRaw = 40 / 20 * this.level;
			this.willpowerRaw = 40 / 20 * this.level;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 50;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "yellow";
			this.tallness = 6 * 12 + 6;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "blue";
			this.scaleColor = "none";
			this.furColor = "blue";
			this.hairLength = 16;
			this.hairType = GLOBAL.HAIR_TYPE_FEATHERS;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FEATHERS;
			this.skinTone = "pink";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_AVIAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_AVIAN;
			this.legType = GLOBAL.TYPE_AVIAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FEATHERED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_HUMAN;
			this.tailCount = 0;
			this.tailFlags = new Array();
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
			this.hipRatingRaw = 20;
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
			this.buttRatingRaw = 13;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 5;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 2; // B
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Stun Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(3) == 0 && !(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) harpyHordeLustAttack(target);
			else if (rand(3) > 0) harpyHordeClawFlurry(target);
			else harpyHordeGangBangAttack(target);
		}
		
		//ATTACK ONE: Claw Flurry
		public function harpyHordeClawFlurry(target:Creature):void {
			output("The harpies lunge at you, a veritable storm of talons and claws raining down around you.  You stumble back, trying desperately to deflect some of the attacks, but there are simply too many to block them all!  Only a single harpy in the brood seems to be holding back...\n");
			var attacks:int = 2 + rand(3);
			for (var i:int = 0; i < attacks; i++) 
			{
				output("\n");
				CombatAttacks.SingleMeleeAttackImpl(this, target);
			}
		}
		
		//ATTACK TWO: Gangbang
		public function harpyHordeGangBangAttack(target:Creature):void {
			output("Suddenly, a pair of harpies grabs you from behind, holding your arms to keep you from fighting back! Taking advantage of your open state, the other harpies leap at you, hammering your chest with punches and kicks - only one hangs back from the gang assault.\n\n");
			target.createStatusEffect("Grappled", 0, 0, 0, 0, false, "Icon_Constricted", "You are held under harpy mass!", true);
			//(PC must struggle:
			harpyHordeGangBangStruggle(false);
		}
		
		public function harpyHordeGangBangStruggle(pcTurn:Boolean):void {
			//Failure: 
			//If fail:
			var pc:PlayerCharacter = kGAMECLASS.pc;
			if (rand(10) > 0 && pc.physique() / 3 + rand(20) < 23) {
				output("You struggle in the harpies' grasp, but can't quite get free.  The brood continues to hammer away at your defenseless self. ");
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(2);
				applyDamage(damage, this, pc);
			}
			//Success: 
			else {
				pc.removeStatusEffect("Grappled");
				output("With a mighty roar, you throw off the harpies grabbing you and return to the fight!");
			}
			if (pcTurn) CombatManager.processCombat();
		}
		
		public override function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", harpyHordeGangBangStruggle, true);
				return;
			}
		}
		
		//ATTACK THREE: LUSTY HARPIES!
		public function harpyHordeLustAttack(target:Creature):void {
			output("The harpies back off for a moment, giving you room to breathe - only to begin a mini strip-tease, pulling off bits of clothing to reveal their massive asses and hips or bearing their small, perky tits.  They caress themselves and each other, moaning lewdly.  Distracted by the burlesque, you don't notice a lipstick-wearing harpy approach you until it's too late!  She plants a kiss right on your lips, ");
			if (target.hasPerk("Luststick Adapted")) {
				output("doing relatively little thanks to your adaptation. ");
				applyDamage(new TypeCollection( { tease : 5 + target.libido() / 20 } ), this, target);
			}
			else {
				output("sending shivers of lust up your spine. ");
				applyDamage(new TypeCollection( { tease : 5 + target.libido() / 20,  drug : (target.hasCock() ? 20 : 10) } ), this, target);
			}
		}
	}
}