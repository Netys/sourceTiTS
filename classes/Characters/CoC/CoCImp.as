package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Utility.weightedRand;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	
	public class CoCImp extends Creature
	{
		public function CoCImp()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "imp";
			this.originalRace = "imp";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.";
			this.customDodge = "The imp zips out of the way with a swift contortion of his small frame.";
			this.customBlock = "";
			this.isPlural = false;
					
			this.meleeWeapon.attackVerb = "swipe";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 1;
			this.meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "leathery skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.personality = 100;
			this.physiqueRaw = 3;
			this.reflexesRaw = 3;
			this.aimRaw = 2;
			this.intelligenceRaw = 1;
			this.willpowerRaw = 1;
			this.libidoRaw = 40;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 40;
			this.XPRaw = 20;
			this.level = 1;
			this.credits = (rand(5) + 5) * 10;
			this.HPMod = 7;
			this.HPRaw = this.HPMax();
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "black";
			this.tallness = 54;
			this.thickness = 20;
			this.tone = 70;
			this.hairColor = "black";
			this.scaleColor = "";
			this.furColor = "";
			this.hairLength = 3;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "red";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_DEMONIC;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_DEMONIC;
			this.lipMod = 0;
			this.earType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_DEMONIC;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_DEMONIC;
			this.legType = GLOBAL.TYPE_DEMONIC;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = 0;
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
			this.hipRatingRaw = 0;
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
			this.buttRatingRaw = 2;
			//No dicks here!
			this.cocks = new Array();
			this.createCock();
			this.shiftCock(0, weightedRand( { v: GLOBAL.TYPE_DEMONIC, w: 10 }, { v: GLOBAL.TYPE_CANINE, w: 3 }, { v: GLOBAL.TYPE_FELINE, w: 3 }, { v: GLOBAL.TYPE_EQUINE, w: 3 }, { v: GLOBAL.TYPE_TENTACLE, w: 1 }, { v: GLOBAL.TYPE_SNAKE, w: 1 } ));
			this.cocks[0].cLengthRaw = rand(2) + 11;
			this.cocks[0].cThicknessRatioRaw = 1.75;
			this.cocks[0].cockColor = "red";
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 6;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 1;
			this.ballFullness = 1;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 10;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 6;
			this.minutesSinceCum = 3650;
			this.timesCum = 321;
			
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1.05;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "red";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity += 500;

			this.createStatusEffect("Disarm Immune");
			
			isUniqueInFight = true;
			sexualPreferences.setRandomPrefs(5 + rand(3));
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCSucMilk(),	new CoCIncubiD(), new CoCImpFood()] ,
						[3, 4, 4]));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(3) == 0) LustAttack(target);
			else CombatAttacks.MeleeAttack(this, target);
		}

		private function LustAttack(target:Creature):void {
			output("You see " + a + uniqueName + " make sudden arcane gestures at you!\n\n");
			
			if (target.lust() < 30) output("You feel strangely warm.  ");
			if (target.lust() >= 30 && target.lust() < 60) output("Blood rushes to your groin as a surge of arousal hits you, making your knees weak.  ");
			if (target.lust() >= 60) output("Images of yourself fellating and fucking the imp assault your mind, unnaturally arousing you.  ");
			if (target.cocks.length > 0) {
				if (target.lust() >= 60)
					output("You feel your [pc.cocks] dribble pre-cum.");
				else if (target.lust() >= 30 && target.cocks.length == 1)
					output("Your [pc.cock] hardens, distracting you further.");
				else if (target.lust() >= 30 && target.cocks.length > 1)
					output("Your [pc.cocks] harden uncomfortably.");
				if (target.hasVagina()) output("  ");
			}
			if (target.lust() >= 60 && target.hasVagina()) {
				switch (target.highestWetness()) {
					case 0:
						break;
					case 1:
						output("Your [pc.vaginas] dampen" + (target.vaginas.length > 1 ? "" : "s") + " perceptibly.");
						break;
					case 2:
						output("Your crotch becomes sticky with girl-lust.");
						break;
					case 3:
						output("Your [pc.vaginas] become" + (target.vaginas.length > 1 ? "" : "s") + " sloppy and wet.");
						break;
					case 4:
						output("Thick runners of girl-lube stream down the insides of your thighs.");
						break;
					default:
						output("Your [pc.vaginas] instantly soak" + (target.vaginas.length > 1 ? "" : "s") + " your groin.");
				}
			}
			output(" ");
			applyDamage(new TypeCollection( { psionic: target.libido() / 10 + target.cor() / 10 + 10 } ), this, target);
			output("\n");
		}
	}
}