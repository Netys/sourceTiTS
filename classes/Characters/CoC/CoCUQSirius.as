package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.CoCReptilum;
	import classes.Items.Transformatives.CoCSnakeOil;
	import classes.kGAMECLASS;
	
	public class CoCUQSirius extends CoCNaga
	{
		//constructor
		public function CoCUQSirius()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Sirius";
			this.originalRace = "naga";
			this.a = "";
			this.capitalA = "";
			this.long = "A strange being with the upper torso of a human man topped with the head of a giant serpent stands before you, hissing in anger and occasionally letting a long, fork-tipped tongue flicker out past his lips.  An imperial-featured masculine human face regards you with an indifferent expression.  A ponytail of deep orange - almost bright red - hair falls down between his shoulders, held together by snake-styled circlets of silver, and matching bracelets of the same material and design adorn his wrists. Scales begin at his lower waist, concealing his manhood from you; he's completely naked otherwise.  His snake body is long and slender, covered in finely meshing scales of a rich orange-red shade, the red broken by a pattern of randomly thick or thin stripes of black.  His burning yellow eyes stare directly into yours, vertical slits of pupils fixated on your own as he undulates and coils in an eerily seductive manner.";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "bite";
			this.meleeWeapon.attackNoun = "bite";
			this.meleeWeapon.longName = "fangs";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "scales";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 0;
			this.level = 12;
			this.credits = 0;
			this.HPMod = 400;
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 75 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 92 / 20 * this.level;
			this.willpowerRaw = 92 / 20 * this.level;
			this.libidoRaw = 45;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.personality = 40;
			this.lustRaw = 30;

			this.femininity = 15;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "green";
			this.tallness = 5*12+10;
			this.thickness = 42;
			this.tone = 70;
			this.hairColor = "orange";
			this.scaleColor = "green";
			this.furColor = "";
			this.hairLength = 16;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "mediterranean-toned";
			this.skinFlags = [];
			
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_SNAKE;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 2;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = 0;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_NAGA;
			this.legCount = 1;
			this.legFlags = [GLOBAL.FLAG_PREHENSILE, GLOBAL.FLAG_TENDRIL, GLOBAL.FLAG_SCALED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_SNAKE;
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
			this.createCock(14);
			this.shiftCock(0, GLOBAL.TYPE_SNAKE);
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 1.5;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 2;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 4;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 998;
			this.cockVirgin = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.vaginas = [];
			this.elasticity = 2;
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "pink";
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 10;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Plot Fight");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_EXOTIC_BODYSHAPE,GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			kGAMECLASS.urtaAdditionalCombatMenuEntries();
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var attack:int = rand(4);
			if (target.hasStatusEffect("Blind")) attack = rand(3);
			if (attack == 0) MeleeAttack(target);
			if (attack == 1) poisonBite(target);
			if (attack == 2) manNagaTease(target);
			if (attack == 3) nagaSpitAttack(target);
		}
		
		override protected function MeleeAttack(target:Creature):void {
			output("Sirius readies his hands, undulating his body erratically with quick motions in order to catch you off-guard and strike at you.\n");
			
			if (combatMiss(this, target)) {
				output("With your trained eyes, you see through his feints and effectively block his first swipe, then quickly twist your body to kick him away.  He clutches his belly where you kicked him, but recovers quickly, eyes fixated on yours.");
			} else {
				output("You misjudge his pattern and wind up getting slashed by a series of swipes from his sharpened nails.  He distances himself from you in order to avoid retaliation and glares at you with his piercing yellow eyes, a hint of a smile on his face. ");
				applyDamage(meleeDamage().rand(), this, target)
			}
		}
		
		private function manNagaTease(target:Creature):void
		{
			output("The snake-man stares deeply into your eyes, seemingly looking past them, and for a moment your body goes numb.");
			//Miss:
			if (rand(10) == 0) {
				output("  You blink and shake yourself free of the effects of the snake-man's penetrating gaze.");
				return;
			}
			//Hit (Blind):
			if (target.hasStatusEffect("Blind")) {
				output("  Though your vision is still blurry, you feel yourself being sucked into the golden depths of those pupils, making you forget all your worries, if only for an instant.  All you can focus on is your growing arousal as you sink deeper into his gaze.  You shake your head, clearing your mind of the hypnotising effects the snake-man's eyes seem to possess, though the arousal remains.");
				applyDamage(new TypeCollection( { psionic : 5 + target.libido() / 10 + target.intelligence() / 20 } ), this, target);
			}
			//Hit:
			else {
				output("  Those pools of yellow suck you into their golden depths, making you forget all your worries, if only for an instant.  All you can focus on is your growing arousal as you sink deeper into his gaze.  You shake your head, clearing your mind of the hypnotising effects the snake-man's eyes seem to possess, though the arousal remains.");
				applyDamage(new TypeCollection( { psionic : 10 + target.libido() / 7 + target.intelligence() / 20 } ), this, target);
			}
		}

		private function nagaSpitAttack(target:Creature):void
		{
			output("Hissing loudly, Sirius suddenly curls his lips and spits at your eyes!  ");
			//{Hit:
			if (rangedCombatMiss(this, target)) {
				output("The vile spray hits your eyes and you scream in pain, clawing fiercely at your burning, watering, weeping eyes.  <b>You can't see!  It'll be much harder to fight in this state, but at the same time, his hypnosis won't be so effective...</b>");
				target.createStatusEffect("Blinded", 3, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
			}
			//Miss:
			else output("You quickly lean to the side, narrowly avoiding being blinded by the snake-man's spit!");
		}

		private function poisonBite(target:Creature):void
		{
			output("With a loud and vicious hiss, Sirius suddenly lunges at you, mouth distended impossibly wide and revealing four needle-like fangs dripping with venom!  ");
			//Miss:
			if (combatMiss(this, target)) {
				output("You dodge just in the nick of time, and deliver a punishing blow with the butt of your halberd as Sirius soars past, forcing him to slither past you to make himself ready to defend himself again.");
				return;
			}
			//Hit:
			output("The snake-man moves too quickly for you to evade and he sinks long fangs into your flesh, leaving a wound that burns with horrific pain. ");
			applyDamage(new TypeCollection( { kinetic : meleeDamage().rand().getTotal(), poison : meleeDamage().rand().getTotal() } ), this, target);
		}
	}
}
