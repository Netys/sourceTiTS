package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.CoCBlackChitin;
	import classes.Items.Miscellaneous.CoCBookWhite;
	import classes.Items.Miscellaneous.CoCOvipositionElixir;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	public class CoCBeeGirl extends Creature
	{
		
		public function CoCBeeGirl() 
		{				
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "bee-girl";
			this.originalRace = "bee";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "A bee-girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			this.customDodge = "The bee girl tumbles out of the way with a swift contortion.";
			this.customBlock = "The bee's chitinous armor deflects your attack.";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "chitin-plated fist";
			this.meleeWeapon.attackVerb = "armored punch";
			this.meleeWeapon.attackNoun = "armored punch";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 2;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "chitinous plating";
			this.armor.defense = 9;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.drug.resistanceValue = 10.0;
			baseHPResistances.pheromone.resistanceValue = 10.0;
			baseHPResistances.tease.resistanceValue = 10.0;
			
			this.level = 4;
			this.XPRaw = normalXP();
			this.credits = (rand(15) + 1) * 10;
			this.HPMod = 4;
			
			this.physiqueRaw = 30 / 20 * this.level;
			this.reflexesRaw = 30 / 20 * this.level;
			this.aimRaw = 30 / 20 * this.level;
			this.intelligenceRaw = 20 / 20 * this.level;
			this.willpowerRaw = 20 / 20 * this.level;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 45;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			this.personality = 0;

			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_BEE;
			this.eyeColor = "black";
			this.tallness = 66;
			this.thickness = 45;
			this.tone = 40;
			this.hairColor = "black";
			this.scaleColor = this.scaleColor;
			this.furColor = "yellow";
			this.hairLength = 6;
			this.hairType = GLOBAL.TYPE_BEE;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_CHITIN;
			this.skinTone = "black";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_BEE;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_BEE;
			this.lipMod = 0;
			this.earType = 0;
			this.antennae = 2;
			this.antennaeType = GLOBAL.TYPE_BEE;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_BEE;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_BEE;
			this.legType = GLOBAL.TYPE_BEE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_BEE;
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
			this.hipRatingRaw = 13;
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
			this.girlCumType = GLOBAL.FLUID_TYPE_HONEY;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 4;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].type = GLOBAL.TYPE_BEE;
			this.vaginas[0].vaginaColor = "black and gold";
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 6;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_HONEY;
			this.ballSizeRaw = 0;
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

			this.breastRows[0].breastRatingRaw = 6;
			this.nippleColor = "black";
			this.milkMultiplier = 100;
			this.milkFullness = 100;
			this.milkType = GLOBAL.FLUID_TYPE_HONEY;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 2;
			this.ass.bonusCapacity += 15;
			this.createStatusEffect("Disarm Immune");
			
			credits = (rand(15) + 1) * 10;
			tallness = rand(14) + 59;
			hairColor = RandomInCollection("black", "black and yellow");
			lust(20 + rand(40), true);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_MALEBITS,	GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HYPER,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		0);
			
			if (rand(10) == 0) inventory.push(new CoCOvipositionElixir());
			else if (rand(10) == 0)inventory.push(new CoCBookWhite());
			else if (rand(2) == 0) inventory.push(new CoCBeeHoney());
			else inventory.push(new CoCBlackChitin());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			beeStingAttack(target);
		}

		private function beeStingAttack(target:Creature):void {
			//Blind dodge change
			if (hasStatusEffect("Blinded")) {
				output(capitalA + short + " completely misses you with a blind sting!!");
				return;
			}
			//Determine if dodged!
			if (combatMiss(this, target)) {
				output("You dodge " + a + short + "'s stinger with superior quickness!");
				return;
			}
			//determine if avoided with armor.
			if (target.hasArmor() && target.armor.defense >= 10 && rand(4) > 0) {
				output("Despite her best efforts, " + a + short + "'s sting attack can't penetrate your armor.");
				return;
			}
			//Sting successful!  Paralize or lust?
			//Lust 50% of the time
			if (rand(2) == 0) {
				output("Searing pain lances through you as " + a + short + " manages to sting you!  You stagger back a step and nearly trip, flushing hotly.  ");
				output("Oh no!  You've been injected with some kind of aphrodisiac.  You've got to keep focused, you can't think about... fucking... ");
				if (target.isHerm()) output("or cocks, tits, and puffy nipples. ");
				else if (target.hasCock()) output("or dripping honey-slicked cunts beckoning you. ");
				else if (target.hasVagina()) output("planting your aching sex over her face while you lick her sweet honeypot. ");
			applyDamage(new TypeCollection( { drug : 25 } ), this, target);
				
				if (target.lustQ() > 60) {
					output(" You shake your head and struggle to stay focused,");
					if (target.hasCock()) output(" but it's difficult with the sensitive bulge in your groin.");
					else if (target.hasVagina()) output(" but can't ignore the soaking wetness in your groin.");
					if (target.libido() > 50 && !target.isChestExposed()) output("  The sensitive nubs of your [pc.nipples] rub tightly under your [pc.upperGarments].");
				}
				else output(" You shake your head and clear the thoughts from your head, focusing on the task at hand.");
				//if (pc.findStatusAffect(StatusAffects.lustvenom) < 0) pc.createStatusAffect(StatusAffects.lustvenom, 0, 0, 0, 0);
			}
			//Paralise the other 50%!
			//else { // No normal debuff system? Screw this.
				//output("Searing pain lances through you as " + a + short + " manages to sting you!  You stagger back a step and nearly trip, finding it hard to move yourself.");
				//var paralyzeIndex:int = pc.findStatusAffect(StatusAffects.ParalyzeVenom);
				//if (paralyzeIndex >= 0) {
					//pc.statusAffect(paralyzeIndex).value1 += 2.9; //v1 - strenght penalty, v2 speed penalty
					//pc.statusAffect(paralyzeIndex).value2 += 2.9;
					//game.dynStats("str", -3, "spe", -3);
					//output("  It's getting much harder to move, you're not sure how many more stings like that you can take!");
				//}
				//else {
					//pc.createStatusAffect(StatusAffects.ParalyzeVenom, 2, 2, 0, 0);
					//game.dynStats("str", -2, "spe", -2);
					//output("  You've fallen prey to paralyzation venom!  Better end this quick!");
				//}
			//}
		}
	}
}