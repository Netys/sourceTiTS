package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCSatyr extends Creature
	{
		public function CoCSatyr() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "satyr";
			this.originalRace = "satyr";
			this.a = "a ";
			this.capitalA = "A ";
			this.long = "From the waist up, your opponent is perfectly human, save his curling, goat-like horns and his pointed, elven ears.  His muscular chest is bare and glistening with sweat, while his coarsely rugged, masculine features are contorted into an expression of savage lust.  Looking at his waist, you notice he has a bit of a potbelly, no doubt the fruits of heavy drinking, judging by the almost overwhelming smell of booze and sex that emanates from him.  Further down you see his legs are the coarse, bristly-furred legs of a bipedal goat, cloven hooves pawing the ground impatiently, sizable manhood swaying freely in the breeze.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 70.0;
			//baseHPResistances.drug.resistanceValue = 70.0;
			//baseHPResistances.pheromone.resistanceValue = 70.0;
			//baseHPResistances.tease.resistanceValue = 70.0;
			
			this.armor.longName = "thick fur";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 14;
			this.XPRaw = normalXP();
			this.credits = (rand(25) + 25) * 10;
			this.HPMod = 300;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 75 / 20 * this.level;
			this.reflexesRaw = 110 / 20 * this.level;
			this.aimRaw = 110 / 20 * this.level;
			this.intelligenceRaw = 70 / 20 * this.level;
			this.willpowerRaw = 70 / 20 * this.level;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 45;
			
			this.femininity = 5;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = rand(37) + 64;
			this.thickness = 75;
			this.tone = 90;
			this.hairColor = RandomInCollection("black", "brown");
			this.scaleColor = "none";
			this.furColor = this.hairColor;
			this.hairLength = 3 + rand(20);
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "tan";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = [];
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_SYLVAN;
			this.earLength = 4;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_GOAT;
			this.hornLength = 6;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_GOAT;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_HOOVES];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_GOAT;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG];
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
			//No dicks here!
			this.cocks = new Array();
			this.createCock(rand(13) + 14);
			this.balls = 2;
			this.ballSizeRaw = 2 + rand(13);
			this.cumMultiplierRaw = 1.5;
			this.minutesSinceCum = this.ballSizeRaw * 10 * 60;
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		0);
			
			if (rand(2)) inventory.push(new CoCIncubiD());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if(lust() >= 75 && rand(2) == 0) highLustChugRape(target);
			else if(lust() < 75 && rand(2) == 0) {
				if(rand(2) == 0) satyrBate(target);
				else bottleChug(target);
			}
			else if(hasStatusEffect("Charged")) satyrCharge(target);
			else satyrAttack(target);			
		}
		
		private function satyrAttack(target:Creature):void {
			output("The satyr swings at you with one knuckled fist.  ");
			//Blind dodge change
			if(hasStatusEffect("Blind") && rand(3) != 0) {
				output(capitalA + short + " completely misses you with a blind punch!\n");
			}
			//Evade: 
			else if(combatMiss(this, target)) {
				output("He snarls as you duck his blow and it swishes harmlessly through the air.");
			}
			else {
				if(CombatAttacks.SingleMeleeAttackImpl(this, target)) {
					output("  It feels like you just got hit with a wooden club! ");
				}
				else output("You successfully block it.");
			}
		}
				
		private function satyrBate(target:Creature):void {
			output("He glares at you, panting while his tongue hangs out and begins to masturbate.  You can nearly see his lewd thoughts reflected in his eyes, as beads of pre form on his massive cock and begin sliding down the erect shaft.  ");
			//(small Libido based Lust increase, and increase lust)
			applyDamage(new TypeCollection( { tease : target.libido() / 5 + 4 } ), this, target);
			lust(5);
		}
		
		internal function satyrCharge(target:Creature):void {
			output("Lowering his horns, the satyr digs his hooves on the ground and begins snorting; he's obviously up to something. He charges at you with a loud bleat!  ");
			if(hasStatusEffect("Blind") && rand(3) < 1) {
				output(capitalA + short + " completely misses you due to blindness!\n");
			}
			else if(combatMiss(this, target)) {
				output("You nimbly dodge and strike a vicious blow with your [pc.meleeWeapon] in return that sends him crashing into the ground, hollering in pain.  ");
				var d:TypeCollection = target.meleeDamage();
				damageRand(d, 15);
				applyDamage(d, target, this, "melee");
			}
			else  if(CombatAttacks.SingleMeleeAttackImpl(this, target)) {
				output("\nHe catches you off-guard and sending you flying into the ground.");
				if(rand(2) == 0) {
					output("  The pain of the impact is so big you feel completely dazed, almost seeing stars.");
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for a turn.", true, 0);
				}
				output(" ");
			}
			else output("He charges at you, but you successfully deflect it at the last second.");
		}
			
		private function bottleChug(target:Creature):void {
			output("He whips a bottle of wine seemingly from nowhere and begins chugging it down, then lets out a bellowing belch towards you.  ");
			lust(5);
			
			if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				return;
			}
			
			output("  The smell is so horrible you cover your nose in disgust, yet you feel hot as you inhale some of the fetid scent.  ");			
			//(damage PC lust very slightly and raise the satyr's lust.)
			applyDamage(new TypeCollection( { tease : target.libido() / 5 } ), this, target);
		}
		
		//5:(Only executed at high lust) 
		private function highLustChugRape(target:Creature):void {
			output("Panting with barely-contained lust, the Satyr charges at you and tries to ram you into the ground.  ");
			if(hasStatusEffect("Blind") && rand(3) < 1) {
				output(capitalA + short + " completely misses you due to blindness!\n");
			}
			else if(combatMiss(this, target)) {
				output("As he charges you, you grab him by the horns and spin around, sending him away.");
			}
			else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("You fall with a <b>THUD</b> and the Satyr doesn't even bother to undress you before he begins rubbing his massive cock on your body until he comes, soiling your [pc.armor] with slimy, hot cum.  ");
				lust( -50);
				applyDamage(new TypeCollection( { tease : target.libido() / 5 } ), this, target);
			}
			else {
				output("You fall with a <b>THUD</b> and the Satyr doesn't even bother to undress you before he begins rubbing his massive cock on your body until he comes, soiling your [pc.gear] and " + target.skinFurScales() + " with slimy, hot cum.  As it rubs into your body, you shiver with unwanted arousal.");
				//large-ish sensitivity based lust increase if hit.)(This also relieves him of some of his lust, though not completely.)
				lust( -50);
				applyDamage(new TypeCollection( { tease : target.libido() / 5 + 20 } ), this, target); // sesn originally
			}
		}
	}
}