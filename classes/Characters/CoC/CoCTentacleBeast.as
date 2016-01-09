package classes.Characters.CoC
{
	import classes.CockClass;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	
	public class CoCTentacleBeast extends Creature
	{
		//constructor
		public function CoCTentacleBeast()
		{	
			this._latestVersion = 1;
			this.version = this._latestVersion;
			this._neverSerialize = true; // Setting this will stop a given NPC class from ever being serialized.
			
			this.short = "tentacle beast";
			this.originalRace = "abomination";
			this.a = "the ";
			this.capitalA = "The ";
			this.tallness = 24 + rand(36);
			this.scaleColor = "green";
			this.long = "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
			this.customDodge = "The tentacle beast sways aside at the last second!";
			this.customBlock = "Your attack deflects off the cock vine's bark!";
			
			this.meleeWeapon.attackVerb = "lash";
			this.meleeWeapon.attackNoun = "tendrils";
			this.meleeWeapon.attack = 2;
			
			meleeWeapon.baseDamage.kinetic.damageValue = 4;
			meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.meleeWeapon.longName = "whip-tendril";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "rubbery skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.physiqueRaw = 12;
			this.reflexesRaw = 15;
			this.aimRaw = 3;
			this.intelligenceRaw = 1;
			this.willpowerRaw = 1;
			this.libidoRaw = 90;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.resistanceValue = -20.0;
			baseHPResistances.kinetic.resistanceValue = 50.0;
			baseHPResistances.burning.resistanceValue = -50.0;
			
			this.XPRaw = 250;
			this.level = 6;
			this.credits = rand(150)+50;
			this.HPMod = 0;
			this.HPRaw = this.HPMax();
			
			this.femininity = 50;
			this.eyeType = 0;
			this.eyeColor = "red";
			this.thickness = 1;
			this.tone = 80;
			this.hairColor = "red";
			this.furColor = "tawny";
			this.hairLength = 0;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "green";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_COCKVINE;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_COCKVINE;
			this.lipMod = 1;
			this.earType = GLOBAL.TYPE_COCKVINE;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = 0;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_COCKVINE;
			this.legCount = 1;
			this.legFlags = [GLOBAL.FLAG_TENDRIL];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_COCKVINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_SCALED, GLOBAL.FLAG_LONG, GLOBAL.FLAG_THICK, GLOBAL.FLAG_PREHENSILE];
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = GLOBAL.TYPE_COCKVINE;
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
			this.buttRatingRaw = 0;
			//No dicks here!
			this.cocks = new Array();
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 2;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 10;
			this.ballFullness = 200;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 4;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 1;
			this.minutesSinceCum = 9000;
			this.timesCum = 122;
			this.cockVirgin = true;
			this.vaginalVirgin = false;
			this.analVirgin = true;
			//Goo is hyper friendly!
			this.elasticity = 3;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "green";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 0;
			
			this.fertilityRaw = 1.0;
			this.cumQualityRaw = 1.0;
			this.pregnancyMultiplierRaw = 1;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Force It Gender");
			
			this.cocks = [];
			this.createCock();
			(this.cocks[0] as CockClass).cLengthRaw = 8;
			(this.cocks[0] as CockClass).cType = GLOBAL.TYPE_COCKVINE;
			
			sexualPreferences.setRandomPrefs(5+rand(3));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			// Reset the struggle-indicator
			if (target.statusEffectv2("Tentacle Bind") == 1)
			{
				target.setStatusValue("Tentacle Bind", 2, 0);
			}
			
			// Trigger various effects based on grip-level
			if (target.statusEffectv1("Tentacle Bind") == 0)
			{
				if (target.hasStatusEffect("Evasion Reduction")) target.removeStatusEffect("Evasion Reduction");
				if (target.hasStatusEffect("Grappled")) target.removeStatusEffect("Grappled");
			}
			else
			{
				if (target.statusEffectv1("Tentacle Bind") == 1)
				{
					if (!target.hasStatusEffect("Evasion Reduction")) target.createStatusEffect("Evasion Reduction", 10, 0, 0, 0, true, "", "", true, 0);
					else target.setStatusValue("Evasion Reduction", 1, 10);
				}

				if (target.statusEffectv1("Tentacle Bind") >= 2)
				{
					if (!target.hasStatusEffect("Evasion Reduction")) target.createStatusEffect("Evasion Reduction", 20, 0, 0, 0, true, "", "", true, 0);
					else target.setStatusValue("Evasion Reduction", 1, 20);

					target.energyRaw -= 5;
					target.lustRaw += 2 + rand(target.libido() / 15);
				}

				if (target.statusEffectv1("Tentacle Bind") == 3)
				{
					target.createStatusEffect("Grappled", 1000, 0, 0, 0, true, "", "", true, 0);
				}
			}
			
			if (target.statusEffectv1("Tentacle Bind") <= 0 && rand(3) == 0) tentacleEntwine(target);
			else tentaclePhysicalAttack(target);
		}

		public function tentaclePhysicalAttack(target:Creature):void {
			output("The shambling horror throws its tentacles at you with a murderous force.\n");
			//Miss
			if(target.statusEffectv1("Tentacle Bind") <= 0 && combatMiss(this, target)) {
				output("However, you quickly evade the clumsy efforts of the abomination to strike you.");
			}
			//Hit
			else {
				output("The tentacles crash upon your body mercilessly. ");
				var damage:TypeCollection = new TypeCollection( { kinetic: 15 * (0.5 + (target.statusEffectv1("Tentacle Bind") / 2)) }, DamageFlag.CRUSHING);
				applyDamage(damage, this, target);
			}
		}

		public function tentacleEntwine(target:Creature):void {
			output("The beast lunges its tentacles at you from all directions in an attempt to immobilize you.\n");
			//Not Trapped yet
			if(target.statusEffectv1("Tentacle Bind") < 0) {
				//Success
				if(rand(Math.max(target.RQ(), target.PQ())) > 65) {
					output("In an impressive display of gymnastics, you dodge, duck, dip, dive, and roll away from the shower of grab-happy arms trying to hold you. Your instincts tell you that this was a GOOD thing.\n");
				}
				//Fail
				else {
					output("While you attempt to avoid the onslaught of pseudopods, one catches you around your [pc.foot] and drags you to the ground. You attempt to reach for it to pull it off only to have all of the other tentacles grab you in various places and immobilize you in the air. You are trapped and helpless!!!\n\n");
					//Male/Herm Version:
					if(target.hasCock()) output("The creature, having immobilized you, coils a long tendril about your penis. You shudder as the creature begins stroking your cock like a maid at a dairy farm in an attempt to provoke a response from you. Unable to resist, your [pc.cocks] easily becomes erect, signaling to the creature that you are responsive to harsher stimulation.\n");
					//Female Version:
					else if(target.hasVagina()) output("The creature quickly positions a long tentacle with a single sucker over your clitoris. You feel the power of the suction on you, and your body quickly heats up.  Your clit engorges, prompting the beast to latch the sucker onto your [pc.clit].\n");
					//Genderless
					else output("The creature quickly positions a long tentacle against your [pc.asshole]. It circles your pucker with slow, delicate strokes that bring unexpected warmth to your body.\n");
					applyDamage(new TypeCollection( { tease: (8 + target.libido() / 20) } ), this, target, "minimal");
					target.addStatusValue("Tentacle Bind", 1, 1);
				}
			}
		}

		private function tentacleEntice(target:Creature):void {
			//Spoiler for Entice Attack Male/Herm: 
			if(target.hasCock()) {
				if(rand(2) == 0) {
					output("In an effort to distract the creature, you begin gyrating your hips and swinging your penis in a shameless imitation of MeatSpin. The Tentacled Horror briefly pauses to observe your actions and rears similar to a posturing spider, considering your next actions.\n\n");
					applyDamage(new TypeCollection( { tease: (10 + rand(5)) }), target, this, "minimal");
				}
				//Failure:
				else output("You grab your penis and shake it feverishly at the creature in order to distract it.  It swats a tentacle at you, forcing you to adroitly dodge the reprisal.  Apparently, the beast found you unimpressive.\n\n");
			}
			//Spoiler for Entice Attack-Female: 
			else {
				//Success:
				if(rand(2) == 0) {
					//GENDERLEZZ
					if(!target.hasGenitals()) output("You brazenly turn your back on the creature and, glancing over your shoulder, begin bending over and presenting your [pc.asshole] to the beast. It pauses and observes while you bend over further, presenting a full view of your [pc.asshole]. You shift from side to side and observe the beast match your movements. You have obtained its attention to say the least.\n\n");
					//CHICKS
					else output("You brazenly turn your back on the creature and, glancing over your shoulder, begin bending over and presenting your [pc.ass] to the beast. It pauses and observes while you bend over further, presenting a full view of both your back door and your honey hole. You shift from side to side and observe the beast match your movements. You have obtained its attention to say the least.\n\n");
					applyDamage(new TypeCollection( { tease: (10 + rand(5)) }), target, this, "minimal");
				}
				//Failure
				else {
					output("You begin shaking your hips and grabbing your [pc.fullChest] to distract the creature. However, the near-miss from the tentacle it attempted to swat you with convinces you of its desire to beat your ass, rather than fuck it.\n\n");
				}
			}
		}
	}
}