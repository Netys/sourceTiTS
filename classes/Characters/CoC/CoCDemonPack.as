package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Utility.possessive;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.RandomInCollection;
	
	public class CoCDemonPack extends Creature
	{
		public function CoCDemonPack()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Originally a clone of the zilpack
			// Needs a few things checked.
			this.short = "demons";
			this.originalRace = "demon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The group is composed of roughly twenty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a bull head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small tribe carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders." + (kGAMECLASS.silly ? "  You spot an odd patch that reads, \"<i>41st Engineer Company: Vaginal Clearance</i>\" on his shoulder." : "");
			this.customBlock = "";
			this.isPlural = true;
					
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 8;
			this.meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "demonic skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.damageValue = 50.0;
			baseHPResistances.drug.damageValue = 25.0;
			baseHPResistances.pheromone.damageValue = 25.0;
			baseHPResistances.psionic.damageValue = 25.0;
			
			this.level = 6;
			this.XPRaw = bossXP();
			this.credits = (rand(25) + 10) * 10;
			this.HPMod = 200;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 80 / 20 * this.level;
			this.reflexesRaw = 10 / 20 * this.level;
			this.aimRaw = 10 / 20 * this.level;
			this.intelligenceRaw = 5 / 20 * this.level;
			this.willpowerRaw = 5 / 20 * this.level;
			this.libidoRaw = 50;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 80;
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "black";
			this.tallness = rand(8) + 70;
			this.thickness = 20;
			this.tone = 70;
			this.hairColor = "black";
			this.scaleColor = "";
			this.furColor = "";
			this.hairLength = 15;
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
			this.hipRatingRaw = 8;
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
			this.buttRatingRaw = 10;
			//No dicks here!
			this.cocks = new Array();
			this.createCock();
			this.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			this.cocks[0].cLengthRaw = 18;
			this.cocks[0].cThicknessRatioRaw = 1.75;
			this.cocks[0].cockColor = "red";
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 6;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 3;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 10;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 6;
			this.minutesSinceCum = 3650;
			this.timesCum = 321;
			
			this.vaginas = [];
			this.createVagina();
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 3;
			
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
			this.ass.wetnessRaw = 3;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity += 10;
			
			this.createStatusEffect("Disarm Immune");
			this.createPerk("Multiple Attacks", 5, 0, 0, 0, "");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [RandomInCollection(new CoCSucMilk(), new CoCIncubiD(), new CoCOvipositionElixir(), new CoCBookBlack())];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			
			if (rand(2) == 0) packAttack(target);
			else lustAttack(target);
		}
		
		public function teaseReactions(lustDelta:Number):String
		{
			if(lustDelta == 0) return (capitalA + short + " seems unimpressed.");
			else if(lustQ() <= 33) return ("The demons lessen somewhat in the intensity of their attack, and some even eye up your assets as they strike at you.");
			else if(lustQ() <= 66) return ("The demons are obviously steering clear from damaging anything you might use to fuck and they're starting to leave their hands on you just a little longer after each blow. Some are starting to cop quick feels with their other hands and you can smell the demonic lust of a dozen bodies on the air.");
			else return ("The demons are less and less willing to hit you and more and more willing to just stroke their hands sensuously over you. The smell of demonic lust is thick on the air and part of the group just stands there stroking themselves openly.");
		}
		
		public function packAttack(target:Creature):void {
			setPerkValue("Multiple Attacks", 1, rand((100 - Math.max(lustQ(), 100 - HPQ())) / 10) + 2);
			CombatAttacks.MeleeAttack(this, target);
		}
		
		public function lustAttack(target:Creature):void {
			if (target.lust() < 35) {
				output(capitalA + short + " press in close against you and although they fail to hit you with an attack, the sensation of their skin rubbing against yours feels highly erotic.");
			}
			else if (target.lust() < 65) {
				output("The push of " + capitalA + possessive(short) + " sweaty, seductive bodies sliding over yours is deliciously arousing and you feel your ");
				if (target.hasCock())
					output("[pc.cocksLight] hardening ");
				if (target.isHerm()) output("and your ");
				if (target.hasVagina()) output("[pc.vagina] get wetter ");
				output("in response to all the friction.");
			}
			else {
				output("As " + capitalA + short + " mill around you, their bodies rub constantly over yours, and it becomes harder and harder to keep your thoughts on the fight or resist reaching out to touch a well lubricated cock or pussy as it slips past.  You keep subconsciously moving your ");
				if (target.isHerm()) output("aching [pc.cocksLight] and thirsty pussy towards the nearest thing willing to fuck it.");
				else if (target.hasCock()) output("[pc.cocksLight] towards the nearest inviting hole.");
				else if (target.hasVagina()) output("[pc.vagina] towards the nearest swinging cock.");
				else output("groin, before remember there is nothing there to caress.");
			}
			applyDamage(new TypeCollection( { tease : 10 + target.libido() / 10 } ), this, target); // sens originally
		}
	}
}