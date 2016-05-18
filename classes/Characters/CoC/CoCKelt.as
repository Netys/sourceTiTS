package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Guns.CoCKeltBow;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCKelt extends Creature
	{
		public function CoCKelt() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			var breakLevel2:Boolean = Flag("COC.KELT_BREAK_LEVEL") == 2;
			this.short = "Kelt";
			this.originalRace = "centaur";
			this.a = "";
			this.capitalA = "";
			
			this.long = "You are fighting Kelt, centaur archer.";
			
			if(Flag("COC.KELT_BREAK_LEVEL") > 0)
				this.long = "Kelt has changed for the worse since your first meeting.  Gone is his muscular, barrel chest.  In its place is a softer frame, capped with tiny boobs - remnants of your last treatment.  His jaw is fairly square and chiselled (though less than before).  From the waist down, he has the body of a horse, complete with a fairly large pair of balls and a decent-sized dong.  Both are smaller than they used to be, however.  He has his bow strung and out, clearly intent on defending himself from your less than gentle touches." + (breakLevel2?"Kelt is looking less and less like the burly centaur from before, and more and more like a woman.  He looks more like an odd, androgynous hybrid than the beautiful woman you had turned him into.  He currently sports roughly B-cup breasts and a smallish, miniature horse-cock.  There's barely any hair on his human body, aside from a long mane of hair.  Each treatment seems to be more effective than the last, and you can't wait to see what happens after you tame him THIS time.":"");
			
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.rangedWeapon = new CoCKeltBow();
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 17.0;
			//baseHPResistances.drug.resistanceValue = 17.0;
			//baseHPResistances.pheromone.resistanceValue = 17.0;
			//baseHPResistances.tease.resistanceValue = 17.0;
			
			this.armor.longName = "tough skin";
			this.armor.defense = 4;
			this.armor.hasRandomProperties = true;
			
			this.level = 6;
			this.XPRaw = bossXP();
			this.credits = (rand(5) + 5) * 10;
			this.HPMod = 200;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 60 / 20 * this.level;
			this.reflexesRaw = 40 / 20 * this.level;
			this.aimRaw = 100 / 20 * this.level;
			this.intelligenceRaw = 20 / 20 * this.level;
			this.willpowerRaw = 20 / 20 * this.level;
			this.libidoRaw = 40;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 40;
			this.personality = 75;
			
			this.femininity = 10 + Flag("COC.KELT_BREAK_LEVEL") * 25;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 84;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "brown";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 3;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "tan";
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
			this.legType = GLOBAL.TYPE_EQUINE;
			this.legCount = 4;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_HOOVES];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_EQUINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FURRED];
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
			this.buttRatingRaw = 5;
			
			this.cocks = new Array();
			if(Flag("COC.KELT_BREAK_LEVEL") == 0)
				this.createCock(30);
			else if (Flag("COC.KELT_BREAK_LEVEL") == 1)
				this.createCock(24);
			else 
				this.createCock(12);
			this.shiftCock(0, GLOBAL.TYPE_EQUINE);
			
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 1.5;
			
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = (2 + rand(13)) * Math.PI;
			this.ballFullness = 100;
			
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 30;
			
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = this.ballDiameter() * 10 * 60;
			this.timesCum = 2478;
			this.cockVirgin = false;
			this.analVirgin = true;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = Flag("COC.KELT_BREAK_LEVEL");
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 50;
			
			//this.createStatusEffect("Disarm Immune");
			
			this.impregnationType = "CoCKeltPregnancy";
			
			if(Flag("COC.KELT_KILL_PLAN") == 1 || Flag("COC.KELT_BREAK_LEVEL") == 2) // fight to kick his ass or second breaking fight
				this.inventory.push(new CoCKeltBow());
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_FEMININE,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HYPER,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_EXOTIC_BODYSHAPE,GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (statusEffectv1("Bow Cooldown") > 0) {
				addStatusValue("Bow Cooldown", 1, -1);
				if (statusEffectv1("Bow Cooldown") <= 0) removeStatusEffect("Bow Cooldown");
			}
			else {
				if (rand(2) == 0 && Flag("COC.KELT_BREAK_LEVEL") >= 2) dayDreamKelly(target);
				else keltShootBow(target);
				return;
			}
			
			var select:int = rand(5);
			if (select <= 1) CombatAttacks.MeleeAttack(this, target);
			else if (select <= 3) KellyuraAttack(target);
			else keltTramplesJoo(target);
		}
		
		//Trample - once every five turns
		private function keltTramplesJoo(target:Creature):void {
			output("Before you know what's what, Kelt is galloping toward you, kicking up a cloud of dust in his wake.  He's trying to trample you!  ");
			//Miss:
			
			if(combatMiss(this, target)) {
				output("You roll out of the way at the last moment, avoiding his dangerous hooves.");
				return;
			}
			
			var sizeMod:Number = 100;
			var thickMod:Number = target.thickness / 100 + 0.5;
			var tallMod:Number = target.tallness;
			if(target.isDrider()) tallMod *= 2;
			else if (target.isTaur()) tallMod *= 3;
			else if (target.isNaga() || target.isGoo()) tallMod *= 1.5;
			sizeMod += tallMod * thickMod;
			
			// Block:
			if(sizeMod + target.physique() * 2 >= 500 || rand(sizeMod) + target.physique() * 2 > 250) {
				output("Incredibly, you brace yourself and dig in your [pc.feet].  Kelt slams into you, but you grind his momentum to a half.  His mouth flaps uncomprehendingly for a moment before he backs up, flushing from being so close to you.");
				lust(5);
				return;
			}
			
			var d:TypeCollection = this.meleeDamage();
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			
			//Hit:
			if(damageResult.totalDamage <= 0) {
				output("You roll out of the way at the last moment, avoiding his dangerous hooves.");
			}
			else {
				output("You can't get out of the way in time, and you're knocked down!  Kelt tramples overtop of you!  ");
				outputDamage(damageResult);
			}
		}

		//Arrow Attack
		private function keltShootBow(target:Creature):void {
			createStatusEffect("Bow Cooldown", 2);
			
			output("Kelt knocks and fires an arrow almost faster than you can track.  He's lost none of his talent with a bow, even after everything you've put him through.  ");
			
			//Miss:
			if(rangedCombatMiss(this, target)) {
				output("You manage to avoid the missile by the skin of your teeth!  ");
				return;
			}
			
			var d:TypeCollection = this.rangedDamage();
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			
			if(damageResult.totalDamage <= 0) {
				output("You deflect the hit, preventing it from damaging you.  ");
				return;
			}
			
			output("The arrow bites into you before you can react.  ");
			outputDamage(damageResult);
		}

		//Aura Arouse
		private function KellyuraAttack(target:Creature):void {
			var select:int = rand(3);
			//(1)
			if(select == 0) output("Kelt flashes his cockiest smile and gestures downward.  \"<i>Did you forget why you're here, slut?  Taking me by surprise once doesn't make you any less of a whore.</i>\"  ");
			//(2)
			else if(select == 2 && !(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) output("Grinning, Kelt runs by, trailing a cloud of his musk and pheremones behind you.  You have to admit, they get you a little hot under the collar...  ");
			//(3)
			else {
				output("Kelt snarls, \"<i>Why don't you just masturbate like the slut that you are until I come over there and punish you?</i>\"  ");
				if(target.lustQ() >= 80) output("Your hand moves towards your groin seemingly of its own volition.  ");
				else output("Your hands twitch towards your groin but you arrest them.  Still, the idea seems to buzz at the back of your brain, exciting you.  ");
			}
			applyDamage(new TypeCollection( { tease : target.libido() / 5 + rand(10) } ), this, target);
		}

		//Attacks as normal + daydream "attack"
		//DayDream "Attack"
		private function dayDreamKelly(target:Creature):void {
			if(rand(2) == 0) output("Kelt pauses mid-draw, looking you up and down.  He licks his lips for a few moments before shaking his head to rouse himself from his lusty stupor.  He must miss the taste of your sperm.  ");
			else output("Flaring 'his' nostrils, Kelt inhales deeply, his eyelids fluttering closed as he gives a rather lady-like moan.   His hands roam over his stiff nipples, tweaking them slightly before he recovers.  ");
			lust(5);
		}
	}
}