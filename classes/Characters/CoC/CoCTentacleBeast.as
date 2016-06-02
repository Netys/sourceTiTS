package classes.Characters.CoC
{
	import classes.Characters.PlayerCharacter;
	import classes.CockClass;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
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
			this.customBlock = "Your attack deflects off the beast's skin!";
			
			this.meleeWeapon.attackVerb = "lash";
			this.meleeWeapon.attackNoun = "tendrils";
			this.meleeWeapon.attack = 2;
			
			meleeWeapon.baseDamage.kinetic.damageValue = 4;
			meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			
			this.meleeWeapon.longName = "whip-tendril";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "bark";
			this.armor.defense = 1;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.resistanceValue = -20.0;
			baseHPResistances.kinetic.resistanceValue = 20.0;
			baseHPResistances.burning.resistanceValue = -50.0;
			
			this.level = 6;
			this.XPRaw = normalXP();
			this.credits = (rand(15) + 5) * 10;
			this.HPMod = 250;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 58 / 20 * this.level;
			this.reflexesRaw = 35 / 20 * this.level;
			this.aimRaw = 35 / 20 * this.level;
			this.intelligenceRaw = 45 / 20 * this.level;
			this.willpowerRaw = 45 / 20 * this.level;
			this.libidoRaw = 90;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;
			this.personality = 100;
			
			this.femininity = 50;
			this.tallness = rand(9) + 70;
			this.eyeType = 0;
			this.eyeColor = "red";
			this.thickness = 1;
			this.tone = 80;
			this.hairColor = "green";
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
			this.createCock(40);
			this.shiftCock(cocks.length - 1, GLOBAL.TYPE_TENTACLE);
			this.createCock(60);
			this.shiftCock(cocks.length - 1, GLOBAL.TYPE_TENTACLE);
			this.createCock(50);
			this.shiftCock(cocks.length - 1, GLOBAL.TYPE_TENTACLE);
			this.createCock(20);
			this.shiftCock(cocks.length - 1, GLOBAL.TYPE_TENTACLE);
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 3;
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
			this.cockVirgin = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
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
			this.ass.loosenessRaw = 1;
			this.ass.wetnessRaw = 4;
			
			this.fertilityRaw = 1.0;
			this.cumQualityRaw = 1.0;
			this.pregnancyMultiplierRaw = 1;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Force It Gender");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_LACTATION,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_VAGINAL_WETNESS,GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BALLS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			this._isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(4, "Do Nothing", tentacleEntice, pc);
			}
		}
		
		public function processHostileGroupActions():void
		{
			if (hasStatusEffect("TentacleCoolDown")) {
				addStatusValue("TentacleCoolDown", 1, -1);
				if (statusEffectv1("TentacleCoolDown") <= 0)
					removeStatusEffect("TentacleCoolDown");
			}
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (!hasStatusEffect("TentacleCoolDown") && !target.hasStatusEffect("Grappled") && rand(2) == 0)
				tentacleEntwine(target);
			else 
				tentaclePhysicalAttack(target);
		}
		
		private function tentaclePhysicalAttack(target:Creature):void {
			output("The shambling horror throws its tentacles at you with a murderous force.\n");
			var temp:int = int((PQ() + attack(true)) - Math.random() * (target.PQ()) - target.armor.defense);
			
			if(temp < 0) temp = 0;
			//Miss
			if(temp == 0 || combatMiss(this, target)) {
				output("However, you quickly evade the clumsy efforts of the abomination to strike you.  ");
			}
			//Hit
			else {
				output("The tentacles crash upon your body mercilessly.  ");
				CombatAttacks.MeleeAttack(this, target);
			}
		}
		
		private function tentacleEntwine(target:Creature):void {
			output("The beast lunges its tentacles at you from all directions in an attempt to immobilize you.\n");
			createStatusEffect("TentacleCoolDown", 3, 0, 0, 0, true, "", "", true);
			//Not Trapped yet
			if(!target.hasStatusEffect("Grappled")) {
				//Success
				if(rangedCombatMiss(this, target)) {  //if(int(Math.random()*(((player.spe)/2))) > 15 || (player.findPerk(PerkLib.Evade) >= 0 && int(Math.random()*(((player.spe)/2))) > 15)) {
					output("In an impressive display of gymnastics, you dodge, duck, dip, dive, and roll away from the shower of grab-happy arms trying to hold you. Your instincts tell you that this was a GOOD thing.\n");
				}
				//Fail
				else {
					output("While you attempt to avoid the onslaught of pseudopods, one catches you around your [pc.foot] and drags you to the ground. You attempt to reach for it to pull it off only to have all of the other tentacles grab you in various places and immobilize you in the air. You are trapped and helpless!!!\n\n");
					//Male/Herm Version:
					if(target.hasCock()) output("The creature, having immobilized you, coils a long tendril about your penis. You shudder as the creature begins stroking your cock like a maid at a dairy farm in an attempt to provoke a response from you. Unable to resist, [pc.eachCock] easily becomes erect, signaling to the creature that you are responsive to harsher stimulation.\n");
					//Female Version:
					else if(target.hasVagina()) output("The creature quickly positions a long tentacle with a single sucker over your clitoris. You feel the power of the suction on you, and your body quickly heats up.  Your clit engorges, prompting the beast to latch the sucker onto your [pc.clit].\n");
					//Genderless
					else output("The creature quickly positions a long tentacle against your [pc.asshole]. It circles your pucker with slow, delicate strokes that bring unexpected warmth to your body.\n");
					
					target.createStatusEffect("Grappled", 0, 0, 0, 0, false, "Icon_Constricted", "You are entangled by tentacles!", true);
					applyDamage(new TypeCollection( { tease : 8 + target.libido() / 20 } ), this, target);
				}
			}
		}
		
		private function tentacleEntice(target:Creature):void {
			//Spoiler for Entice Attack Male/Herm: 
			if(target.hasCock()) {
				if(rand(2) == 0) {
					output("  In an effort to distract the creature, you begin gyrating your hips and swinging your penis in a shameless imitation of MeatSpin. The Tentacled Horror briefly pauses to observe your actions and rears similar to a posturing spider, considering your next actions.  ");
					applyDamage(new TypeCollection( { tease : 10 + rand(5) } ), target, this);
				}
				//Failure:
				else output("  You grab your penis and shake it feverishly at the creature in order to distract it.  It swats a tentacle at you, forcing you to adroitly dodge the reprisal.  Apparently, the beast found you unimpressive.");
			}
			//Spoiler for Entice Attack-Female: 
			else {
				//Success:
				if(rand(2) == 0) {
					//GENDERLEZZ
					if(!target.hasGenitals()) output("  You brazenly turn your back on the creature and, glancing over your shoulder, begin bending over and presenting your " + target.buttDescript() + " to the beast. It pauses and observes while you bend over further, presenting a full view of both your back door and your " + target.assholeDescript() + ". You shift from side to side and observe the beast match your movements. You have obtained its attention to say the least.  ");
					//CHICKS
					else output("  You brazenly turn your back on the creature and, glancing over your shoulder, begin bending over and presenting your " + target.buttDescript() + " to the beast. It pauses and observes while you bend over further, presenting a full view of both your [pc.asshole] and your [pc.vagina]. You shift from side to side and observe the beast match your movements. You have obtained its attention to say the least.  ");
					applyDamage(new TypeCollection( { tease : 10 + rand(5) } ), target, this);
				}
				//Failure
				else {
					output("  You begin shaking your hips and grabbing your " + target.allBreastsDescript() + " to distract the creature. However, the near-miss from the tentacle it attempted to swat you with convinces you of its desire to beat your ass, rather than fuck it.  ");
				}
			}
		}
	}
}