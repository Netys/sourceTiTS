package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCHookedGauntlet;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	
	public class CoCIzma extends CoCSharkGirl
	{
		public function CoCIzma() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Originally a clone of the zilpack
			// Needs a few things checked.
			this.short = "Izma";
			this.originalRace = "shark";
			this.a = "";
			this.capitalA = "";
			this.long = "Izma the tigershark stands a bit over 6' tall, with orange skin bearing horizontal stripes covering most of her body.  Her silver-white hair cascades past her shoulders, draping over an impressive pair of DD-cup breasts barely restrained by a skimpy black bikini top.  Under the knee-length grass skirt below them rustles her beastly fifteen-inch penis and four-balled sack; you catch occasional glimpses of them as she moves.  She's tucked her usual reading glasses into her locker at the moment.";
			this.customDodge = "";
			this.customBlock = "";
			
			if (flags["COC.IZMA_TOOK_GAUNTLETS"] == undefined) this.meleeWeapon = new CoCHookedGauntlet();
			
			this.armor.longName = "bikini and grass skirt";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			baseHPResistances.psionic.resistanceValue = 50.0;
			baseHPResistances.drug.resistanceValue = 50.0;
			baseHPResistances.pheromone.resistanceValue = 50.0;
			baseHPResistances.tease.resistanceValue = 50.0;
			
			this.level = 15;
			this.XPRaw = normalXP();
			this.credits = (rand(5) + 1) * 10;
			this.HPMod = 330;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 80 / 20 * this.level;
			this.reflexesRaw = 85 / 20 * this.level;
			this.aimRaw = 85 / 20 * this.level;
			this.intelligenceRaw = 65 / 20 * this.level;
			this.willpowerRaw = 65 / 20 * this.level;
			this.libidoRaw = 75;
			this.personality = 40;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_SHARK;
			this.eyeColor = "green";
			this.tallness = 6 * 12 + 2;
			this.thickness = 60;
			this.tone = 80;
			this.hairColor = "silver";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 20;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "striped orange";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_SHARK;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_SHARK;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_SHARK;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_SHARK;
			this.gills = true;
			this.wingType = GLOBAL.TYPE_SHARK;
			this.legType = GLOBAL.TYPE_SHARK;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_SHARK;
			this.tailCount = 1;
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
			this.hipRatingRaw = 5;
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
			if(flags["COC.IZMA_NO_COCK"] != 1) {
				this.createCock(15);
				this.balls = 4;
				this.ballSizeRaw = 3 * Math.PI;
				this.cumMultiplierRaw = 4;
			}
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_SHARK;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 10;
			
			this.breastRows[0].breastRatingRaw = 5;
			this.nippleColor = "gray";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 10;
			
			this.impregnationType = "CoCIzmaPregnancy";
			
			this.createStatusEffect("Disarm Immune");
			if(flags["COC.IZMA_KIDS_ALLOW"] != 1) this.createStatusEffect("Infertile");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var choice:Number = rand(5);
			if (choice <= 1) eAttack(target);
			if (choice == 2) {
				if (target.energy() <= 20) choice = 3;
				else IzmaSpecials1(target);
			}
			if (choice == 3) {
				if (target.armor.defense < 10 || rand(3) == 0) IzmaSpecials2(target);
				else choice = 4;
			}
			if (choice == 4) IzmaSpecials3(target);
		}
		
		//[Special Attacks]
		private function IzmaSpecials1(target:Creature):void {
			//Determine if dodged!
			if (combatMiss(this, target)) {
				output("Izma attempts to get close, but you manage to side-step her before she can lay her gauntleted hands on you.\n");
				return;
			}
			output("Izma rushes you with impressive speed, striking a few precise locations on your joints with her fingertips before leaping back.  It doesn't hurt, but you feel tired and sore. \"<i>Pressure points...</i>\" she laughs, seeing your confused expression.");
			//(Fatigue damage)
			target.energy( -(20 + rand(20)));
		}

		private function IzmaSpecials2(target:Creature):void {
			//Determine if dodged!
			if (combatMiss(this, target)) {
				output("Izma tries to clinch you, but you use your speed to keep just out of reach.\n");
				return;
			}
			
			output("Izma ducks and jinks, working to close quarters, and clinches you. Unable to get your weapon into play, you can only ");
			if (target.armor.defense < 10 && !target.armor.resistances.hasFlag(DamageFlag.PLATED)) {
				//(armor-dependent Health damage, fullplate, chain, scale, and bee chitin armor are unaffected, has a chance to inflict 'Bleed' damage which removes 2-5% of health for the next three turns if successful)
				output("writhe as she painfully drags the blades of her glove down your back");
				if (!target.hasStatusEffect("Bleeding"))
				{
					target.createStatusEffect("Bleeding", 1, 3, 15, 0, false, "Icon_Crying", "You're bleeding!", true, 0);
				}
				else
				{
					// Add a stack and refresh duration
					target.addStatusValue("Bleeding", 1, 1);
					target.setStatusValue("Bleeding", 2, 3);
				}
			}
			else output("laugh as her blades scape uselessly at your armor-clad back");
			output(" before breaking her embrace and leaping away. ");
			
			if (target.armor.defense < 10 && !target.armor.resistances.hasFlag(DamageFlag.PLATED)) {
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(1 - (target.armor.defense / 10.));
				applyDamage(damage, this, target);
			}
		}
		
		private function IzmaSpecials3(target:Creature):void {
			output("Rather than move to attack you, Izma grins at you and grabs her breasts, massaging them as she caresses her long penis with one knee. Her tail thrashes and thumps the sand heavily behind her as she simulates an orgasm, moaning loudly into the air. The whole display leaves you more aroused than before.");
			//(lust gain)
			applyDamage(new TypeCollection( { tease : 20 + target.libido() / 5 } ), this, target);
		}

		private function eAttack(target:Creature):void
		{
			output("Izma slides up to you, throws a feint, and then launches a rain of jabs at you.\n");
			CombatAttacks.SingleMeleeAttackImpl(this, target, true);
			output("\n");
			CombatAttacks.SingleMeleeAttackImpl(this, target, true);
			output("\n");
			CombatAttacks.SingleMeleeAttackImpl(this, target, true);
		}
	}
}