package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.addButton;
	import classes.Engine.Interfaces.clearOutput;
	import classes.Engine.Utility.num2Text;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCMinotaurAxe;
	import classes.Items.Miscellaneous.CoCMinotaurCum;
	import classes.Items.Transformatives.CoCMinotaurBlood;
	import classes.kGAMECLASS;
	
	public class CoCMinotaurMob extends CoCMinotaur
	{
		//constructor
		public function CoCMinotaurMob()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "minotaurs";
			this.originalRace = "minotaur";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "OVERRIDE";
			this.customDodge = "";
			this.customBlock = "";
			this.isPlural = true;
			
			this.meleeWeapon.attackVerb = "punches";
			this.meleeWeapon.attackNoun = "punches";
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 6;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "thick fur";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			var lustVuln:Number = 0.45;
			if ((amount - 3) * 2 > 13) lustVuln = .3;
			else lustVuln -= (amount - 3) * 0.02;
			lustVuln = 100 - 100 * lustVuln;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.damageValue = lustVuln;
			baseHPResistances.drug.damageValue = lustVuln;
			baseHPResistances.pheromone.damageValue = lustVuln;
			baseHPResistances.psionic.damageValue = lustVuln;
			
			//ballz - here 'coz they are minotaur's true main stat
			this.balls = 2;
			this.ballSizeRaw = 2 + rand(13);
			
			this.level = Math.min(11 + Math.round((amount - 3) / 2), 14);
			this.XPRaw = bossXP();
			this.credits = (rand(15) + 45) * 10;
			this.HPMod = 340 + 50 * (amount - 3);
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 30 / 20 * this.level;
			this.aimRaw = 30 / 20 * this.level;
			this.intelligenceRaw = 20 / 20 * this.level;
			this.willpowerRaw = 20 / 20 * this.level;
			this.libidoRaw = 40;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 35;
			
			this.femininity = 15;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "amber";
			this.tallness = rand(37) + 84;
			this.thickness = 70;
			this.tone = 100;
			this.hairColor = "brown";
			this.scaleColor = "";
			this.furColor = "brown";
			this.hairLength = 3;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "light brown";
			this.skinFlags = new Array();
			
			this.faceType = GLOBAL.TYPE_BOVINE;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_BOVINE;
			this.lipMod = 1;
			this.earType = GLOBAL.TYPE_BOVINE;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_BOVINE;
			this.hornLength = 13;
			this.armType = GLOBAL.TYPE_BOVINE;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_BOVINE;
			this.legCount = 2;
			this.legFlags = new Array();
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_BOVINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG];
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = 0;
			//tailGenital:
			//0 - none.
			//1 - cock
			//2 - vagina
			this.tailGenital = 1;
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
			this.hipRatingRaw = 4;
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
			this.buttRatingRaw = 4;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(rand(13) + 24);
			this.shiftCock(0, GLOBAL.TYPE_EQUINE);
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 90;
			this.cumMultiplierRaw = 15;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 4182;
			this.cockVirgin = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.vaginas = new Array();
			//Goo is hyper friendly!
			this.elasticity = 2;
			//Fertility is a % out of 100. 
			//this.fertility = 0;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "brown";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 4;
			this.ass.loosenessRaw = 6;
			this.ass.bonusCapacity = 20;
			
			this.impregnationType = "CoCMinotaurPregnancy";
			
			this.createStatusEffect("Disarm Immune");
			
			if (rand(3) == 0) meleeWeapon = new CoCMinotaurAxe();
						
			ballSizeRaw = 2 + rand(13);
			minutesSinceCum = ballSize() * 600;
			HPMod = 40 + rand(ballSize() * 5);
			
			tallness = rand(37) + 84;
			lust(ballSize() * 3, true);
			libido(40 + ballSize() * 2, true);
			
			if (hasMeleeWeapon()) physique(physique() * 1.5, true);
			level = hasMeleeWeapon() ? 6 : 5;
			credits = (rand(5) + 5) * 10;
			
			HPRaw = HPMax();
			
			long = "An angry-looking minotaur looms over you.  Covered in shaggy [enemy.furColor] fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature." +
					(ballSize() > 4 ? "  Barely visible below the tattered shreds of loincloth are [enemy.balls], swollen with the minotaur's long pent-up need." : "") +	
					(hasMeleeWeapon() ? "  <b>This minotaur seems to have found a deadly looking [enemy.meleeWeapon] somewhere!</b>" : "");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BREASTS,	GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			if (rand(5) == 0) inventory.push(new CoCMinotaurCum());
			else inventory.push(new CoCMinotaurBlood());
			
			_isLoading = false;
		}
		
		override public function get long():String 
		{
			return num2Text(amount, true) + " shaggy beastmen stand around you in a loose circle.  Their postures aren't exactly threatening.  If anything, they seem to be standing protectively around you, as if their presence would somehow shelter you from the rest of the mountain.  All of their features share a brotherly similarity, though there's still a fair bit of differences between your minotaur sons.  One of them is a head above the rest, a massive hulk of muscle so big he seems to dwarf the rest.  In stark contrast, a feminine minitaur keeps his distance in the rear." + (amount >= 20 ? "  The tribe constantly makes hoots and cat-calls, fully expecting to be fucking you soon." : "");
		}
		
		override public function set long(value:String):void 
		{
			super.long = value;
		}
		
		public function get amount():int
		{
			return flags["COC.MINOTAUR_LAST_SONS_ADULT"];
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			removeStatusEffect("Busy");
			
			var select:Number = rand(7);
			if (rand(4) == 0) CoCMinotaurPheromones(target);
			else if (select <= 2) precumTease(target);
			else if (select <= 4) minotaurGangGropeAttack(target);
			else if (select == 5) minotaurGangGangGropeAttack(target);
			else minotaurGangWaste(target);
		}
		
		public function additionalCombatMenuEntries():void
		{
			if(hasStatusEffect("Busy")) addButton(14, "Run", runaway, null, "Run", "Sneak away while they are arguing.");
		}
		
		public function runaway():void {
			clearOutput();
			output("You slink away while the pack of brutes is arguing.  Once they finish that argument, they'll be sorely disappointed!");
			CombatManager.abortCombat();
			kGAMECLASS.processTime(15 + rand(10));
		}
		
		private function precumTease(target:Creature):void {
			var teased:Boolean = false;
			var damage:Number = 0;
			var oldLust:Number = target.lust();
			
			//(Big taur pre-cum tease)
			if (rand(2) == 0) {
				teased = true;
				if (rand(5) > 0) {
					output("The biggest lifts his loincloth, giving you a perfect view of his veiny hardness.  Pre-cum visibly bubbles from his flared tip, splattering wetly on the rocks and filling the air with his bestial musk.  He says, \"<i>See how much I need you?</i>\"");
					damage = 7 + target.libido() / 20;
				}
				//crit)
				else {
					output("The largest bull in the crowd flaps his cum-soaked loincloth up and wraps a massive, muscled hand around his incredible erection.  Shaking it back and forth, he flicks his bubbling pre-cum in your direction, letting it spatter noisily against the rocks around you.  A few droplets even land on your skin, fogging the air with minotaur pheromones.");
					damage = 13 + target.libido() / 20;
				}
				applyDamage(new TypeCollection( { pheromone : damage } ), this, target);
			}
			//(Middle Taur pre-cum tease)
			if (rand(2) == 0) {
				teased = true;
				if (rand(5) > 0) {
					output("\"<i>Hey, slut, look at this!</i>\" taunts one of the beast-men.  He shakes his hips lewdly, spinning his thick horse-cock in wide circles and sending his potent pre flying through the air.  Droplets rain down around you, filling the air with even more of that delicious smell.");
					damage = 3 + target.libido() / 30;
				}
				else {
					output("\"<i>Mom, you may as well spread your thighs now, I got a treat for ya!</i>\" announces a well-built minotaur.  He shifts his coverings and pumps on his swollen shaft, tugging hard enough over the iron-hard erection to blast out huge blobs of pre-seed in your direction.");
					if (target.reflexes() / 5 + rand(20) > 20) {
						output("You avoid most of them, the blobs splattering against the mountain and still getting a little on you.  Regardless, the air stinks of their heavy spunk.");
						damage = 6 + target.libido() / 20;
					}
					else {
						output("You try to avoid them, but one catches you in the face, a little getting into your mouth.  You swallow it reflexively and salivate some more, your eyes darting to look at the stained rocks around you.  Are you really considering licking it up from the ground?");
						damage = 15 + target.libido() / 20;
					}
				}
				applyDamage(new TypeCollection( { pheromone : damage } ), this, target);
			}
			//(Minitaur pre-cum tease)
			if (!teased || rand(3) == 0) {
				output("The smallest of the beastmen, the minitaur, moans and begs, \"<i>Please Mom, can we please fuck you?  I... I need it so bad.</i>\"  He raises the edge of his loincloth to show exactly what he's talking about.  His member is limp but leaking.  What really catches your eyes sits behind that drizzling shaft - a pair of balls looking swollen and pent up beyond belief.  A sticky web of his leavings hangs between his genitals and his loincloth, showing you just how much he's been leaking at the thought of fucking you.  Fanning the sopping garment, he inadvertently blows a wave of his pheromones your way.");
				damage = 9 + target.libido() / 20;
				applyDamage(new TypeCollection( { pheromone : damage } ), this, target);
			}
			
			damage = target.lust() - oldLust;
			//UNIVERSAL pre-cum RESULT:
			//(Low damage taken)
			if (damage <= 8) {
				output("Though your body is tingling from the show the horny beasts are giving you, it doesn't effect you as much as it could have.");
				if (target.lustQ() >= 100) output("  Still, you're too horny to fight any longer.");
			}
			//(Medium damage taken)
			else if (damage <= 14) {
				output("The powerful pheromones and scents hanging in the air around you make your body flush hotly.  Your [pc.nipples] grow harder");
				if (target.lust() > 70) output(", though you didn't think such a thing was possible");
				else if(!target.isChestExposed()) output(", feeling like two bullets scraping along the inside of your [pc.upperGarment]");
				output(", but it... it could have been worse.  You shudder as a little fantasy of letting them dribble it all over your body works through your mind.");
				if (target.lustQ() >= 100) output("  Fuck it, they smell so good.  You want, no, NEED more.");
				else output("  A growing part of you wants to experience that.");
			}
			//(high damage taken)
			else {
				output("All that potent pre-ejaculate makes your cunny ");
				if (target.wetness() <= 1) output("moisten");
				else if (target.wetness() <= 2) output("drip");
				else if (target.wetness() <= 3) output("drool");
				else output("juice itself");
				output(" in need.");
				//if (pc.minotaurNeed()) {
					//output("  You need a fix so bad!", false);
					//game.dynStats("lus", 5);
				//}
				//else {
					output("  You can understand firsthand just how potent and addictive that fluid is...");
				//}
				if (target.hasCock()) output("  [pcEachCock] twitches and dribbles its own pre-seed, but it doesn't smell anywhere near as good!");
				output("  Shuddering and moaning, your body is wracked by ever-increasing arousal.  Fantasies of crawling under the beast-men's soaked legs and lapping at their drooling erections inundate your mind, your body shivering and shaking in response.  ");
				if (target.lustQ() < 100) output("You pull back from the brink with a start.  It'll take more than a little drugged pre-cum to bring you down!");
				else output("You sigh and let your [pc.tongue] loll out.  It wouldn't so bad, would it?");
			}
		}

		//Grope
		private function minotaurGangGropeAttack(target:Creature):void {
			output("Strong hands come from behind and slide under your equipment to squeeze your [pc.chest].  The brutish fingers immediately locate and pinch at your [pc.nipples], the sensitive flesh on your chest lighting up with pain and pleasure.  You arch your back in surprise, utterly stunned by the violation of your body.  After a moment you regain your senses and twist away, but the damage is already done.  You're breathing a bit quicker now");
			if (target.lust() >= 80) output(", and your pussy is absolutely soaking wet");
			output(".");
			applyDamage(new TypeCollection( { tease : 5 + target.libido() / 10 } ), this, target);
		}
		
		//Gang Grope
		private function minotaurGangGangGropeAttack(target:Creature):void {
			output("Before you can react, hands reach out from multiple angles and latch onto your body.  One pair squeezes at your [pc.butt], the strong grip massaging your cheeks with loving touches.  Another set of hands are sliding along your tummy, reaching down for, but not quite touching, the juicy delta below.  Palms encircle your [pc.chest] and caress them, gently squeezing in spite of the brutish hands holding you.  You wriggle and squirm in the collective grip of the many minotaurs for a few moments, growing more and more turned on by the treatment.  At last, you shake out of their hold and stand free, panting hard from exertion and desire.");
			applyDamage(new TypeCollection( { tease : 15 + target.libido() / 10 } ), this, target);
		}
		
		//Waste  a turn
		private function minotaurGangWaste(target:Creature):void {
			output("\"<i>Oh man I can't wait to go hilt-deep in that pussy... I'm going to wreck " + target.mf("him", "her") + ",</i>\" promises one bull to his brother.  The other laughs and snorts, telling him how he'll have to do the deed during sloppy seconds.  It quickly escalates, and soon, every single one of the beast-men is taunting the others, bickering over how and when they'll get to have you.  While they're wasting their time, it's your chance to act!");
			createStatusEffect("Busy");
		}
	}
}