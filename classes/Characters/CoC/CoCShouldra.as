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
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Apparel.ComfortableClothes;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCShouldra extends Creature
	{
		public function CoCShouldra() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = flags["COC.TIMES_POSSESSED_BY_SHOULDRA"] >= 1 ? "ghost girl" : "plain girl";
			this.originalRace = "human";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "Her face has nothing overly attractive about it; a splash of freckles flits across her cheeks, her brows are too strong to be considered feminine, and her jaw is a tad bit square. Regardless, the features come together to make an aesthetically pleasing countenance, framed by a stylish brown-haired bob. Her breasts are obscured by her grey, loose-fitting tunic, flowing down to reach the middle of her thigh. Her legs are clad in snug, form-fitting leather breeches, and a comfortable pair of leather shoes shield her soles from the potentially harmful environment around her.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.poison.resistanceValue = 100.0;
			baseHPResistances.freezing.resistanceValue = 100.0;
			baseHPResistances.corrosive.resistanceValue = 100.0;
			baseHPResistances.electric.resistanceValue = -33.0;
			baseHPResistances.burning.resistanceValue = -33.0;
			baseHPResistances.kinetic.resistanceValue = 40.0;
			
			baseHPResistances.psionic.resistanceValue = 33.0;
			baseHPResistances.drug.resistanceValue = 100.0;
			baseHPResistances.pheromone.resistanceValue = 100.0;
			baseHPResistances.tease.resistanceValue = -25.0;
			
			this.armor = new ComfortableClothes();
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 100;
			this.level = 4;
			this.credits = 0;
			this.HPMod = 30;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 45 / 20 * this.level;
			this.reflexesRaw = 5 / 20 * this.level;
			this.aimRaw = 5 / 20 * this.level;
			this.intelligenceRaw = 110 / 20 * this.level;
			this.willpowerRaw = 110 / 20 * this.level;
			this.libidoRaw = 100;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;
			this.personality = 33;
			
			this.femininity = 60;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 65;
			this.thickness = 40;
			this.tone = 60;
			this.hairColor = "white";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 3;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "white";
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
			this.hipRatingRaw = 6;
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
			this.buttRatingRaw = 5;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 1;
			this.vaginas[0].bonusCapacity = 9000;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 4;
			
			this.nippleColor = "white";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 9000;
			
			this.createStatusEffect("Disarm Immune");
			this.createPerk("Incorporeality");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_HYPER,			GLOBAL.REALLY_LIKES_SEXPREF); // loves hyper things
			sexualPreferences.setPref(GLOBAL.SEXPREF_GAPE,			GLOBAL.KINDA_LIKES_SEXPREF);
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BREASTS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BUTTS,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_WIDE_HIPS,		GLOBAL.KINDA_LIKES_SEXPREF);
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		0); // not very excited by females, but ok with them
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_SMALL_BUTTS,	GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_SMALL_BREASTS,	GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NARROW_HIPS,	GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_SMALL_MALEBITS,GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			if (rand(3) == 0) inventory.push(new CoCEctoplasm());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var attack:Number = rand(3);
			if (attack == 0) shouldrattack(target);
			else if (attack == 1) shouldraLustAttack(target);
			else shouldraMagicLazers(target);
		}
		
		private function shouldrattack(target:Creature):void {
			var damage:Number = 0;
			//Determine if dodged!
			if (combatMiss(this, target)) {
				output("The girl wades in for a swing, but you deftly dodge to the side. She recovers quickly, spinning back at you.");
				return;
			}
			var damageResult:DamageResult = calculateDamage(meleeDamage().rand(), this, target);
			if (damageResult.totalDamage <= 0) {
				output("You deflect and block every " + this.meleeWeapon.attackVerb + " " + a + short + " throws at you.");
			}
			else {
				var choice:Number = rand(3);
				//(regular attack 1)
				if (choice == 0) output("Ducking in close, the girl thunders a punch against your midsection, leaving a painful sting. ");
				//(regular attack 2)
				else if (choice == 1) output("The girl feints a charge, leans back, and snaps a kick against your " + target.hipDescript() + ". You stagger, correct your posture, and plunge back into combat. ");
				//(regular attack 3)
				else if (choice == 2) output("You momentarily drop your guard as the girl appears to stumble. She rights herself as you step forward and lands a one-two combination against your torso. ");
				outputDamage(damageResult);
			}
		}

		//(lust attack 1)
		private function shouldraLustAttack(target:Creature):void {
			if (rand(2) == 0) output("The girl spins away from one of your swings, her tunic flaring around her hips. The motion gives you a good view of her firm and moderately large butt. She notices your glance and gives you a little wink.");
			else output("The girl's feet get tangled on each other and she tumbles to the ground. Before you can capitalize on her slip, she rolls with the impact and comes up smoothly. As she rises, however, you reel back and raise an eyebrow in confusion; are her breasts FILLING the normally-loose tunic? She notices your gaze and smiles, performing a small pirouette on her heel before squaring up to you again. Your confusion only heightens when her torso comes back into view, her breasts back to their normal proportions. A trick of the light, perhaps? You shake your head and try to fall into the rhythm of the fight.");
			applyDamage(new TypeCollection( { tease : 8 + target.libido() / 10 } ).rand(), this, target);
		}
		
		//(magic attack)
		private function shouldraMagicLazers(target:Creature):void {
			output("Falling back a step, the girl raises a hand and casts a small spell. From her fingertips shoot four magic missiles that slam against your skin and cause a surprising amount of discomfort. ");
			applyDamage(new TypeCollection( { freezing : 16 + level + rand(10) } ).rand(), this, target);
		}
	}
}