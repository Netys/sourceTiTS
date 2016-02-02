package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Utility.num2Text;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	public class CoCSandWitchMob extends Creature
	{
		public function CoCSandWitchMob()
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Originally a clone of the zilpack
			// Needs a few things checked.
			this.short = "sand witches";
			this.originalRace = "human";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are surrounded by a veritable tribe of sand witches.  Like the ones that roam the sands, they have simple robes, blond hair, and four big breasts that push at the concealing cloth immodestly.  Glowering at you hatefully, the pack of female spellcasters readies itself to drag you down with sheer numbers.";
			this.customBlock = "";
			this.isPlural = true;
					
			this.meleeWeapon.attackVerb = "punches";
			this.meleeWeapon.attackNoun = "punches";
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 1;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "robes";
			this.armor.defense = 1;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 50.0;
			baseHPResistances.drug.resistanceValue = 25.0;
			baseHPResistances.pheromone.resistanceValue = 20.0;
			baseHPResistances.tease.resistanceValue = 50.0;
			
			this.XPRaw = 500;
			this.level = 4;
			this.credits = (rand(15) + 5) * 10;
			this.HPMod = 80;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 25 / 20 * this.level;
			this.reflexesRaw = 35 / 20 * this.level;
			this.aimRaw = 35 / 20 * this.level;
			this.intelligenceRaw = 45 / 20 * this.level;
			this.willpowerRaw = 45 / 20 * this.level;
			this.libidoRaw = 55;
			this.energyRaw = 100;
			this.lustRaw = 30;
			
			this.femininity = 80;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "black";
			this.tallness = 66;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "sandy-blonde";
			this.scaleColor = "";
			this.furColor = "";
			this.hairLength = 16;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "bronzed";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_HUMAN;
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
			this.hipRatingRaw = 10;
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
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 2;
			
			this.breastRows = [];
			this.createBreastRow();
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 6; // DD
			this.breastRows[1].breastRatingRaw = 6; // DD
			
			this.nippleColor = "red";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity += 10;
			//this.inventory.push();

			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BREASTS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_MULTIPLES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_LACTATION,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NIPPLECUNTS,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (hasStatusEffect("Sandstorm"))
				if(!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)))
				{
					if(rand(4) == 0) {
						output("You eyes are full of sand and you barely can see!");
						target.createStatusEffect("Blinded", 2, 0, 0, 0, false, "Blind", "You're blinded by sand and cannot see! Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0);
						output("\n");
					}
					output("Raging sandstorm is fleecing you!  ");
					applyDamage(new TypeCollection( { kinetic : 1 } ), this, target);
					output("\n");
				} else {
					output("Your sealed armor keeps sand outside!\n");
				}
			if (target.hasStatusEffect("Lust Stones")) {
				
				output("Your body is teased by vibrating stones!  ");		
				applyDamage(new TypeCollection( { tease : target.statusEffectv1("Lust Stones") * 2 + 5 + target.libido() / 7 } ), this, target); // sens originally
				output("\n");
			}
			
			if(!hasStatusEffect("Sandstorm")) sandStormAttack(target);
			else if(rand(3) == 0 && HP() < maxHP() * .5) drankSomeMialk(target);
			else if(hasStatusEffect("Sandstorm") && rand(2) == 0 && !target.hasStatusEffect("Lust Stones")) sandstonesAreCool(target);
			else if(rand(3) == 0) headbuttABitch(target);
			else {
				//Sand Witch Mob Attacks:
				//Swarm
				//-Mob gangrushes the PC; multiple hits, light damage
				output("The witches close ranks and advance with raised fists, intent on beating you into submission!");
				//3-5 attacks.at half strength
				var attacks:int = 2 + rand(3);
				for (var i:int = 0; i < attacks; i++) 
				{
					output("\n");
					CombatAttacks.SingleMeleeAttackImpl(this, target);
				}
			}
		}

		//Headbutt
		//Single, high damage attack
		//High hit chance
		public function headbuttABitch(target:Creature):void {
			output("The crowd parts, and a stockier, sturdier sorceress ambles out, fists up and head cocked back.  She makes to punch at you before pulling her fist at the last second, snapping her head forward in a powerful headbutt!  You barely have time to react!");
			//Dodge
			if(combatMiss(this, target)) {
				output("\nThrowing yourself out of the way, you manage to avoid the hit.  Your foe doesn't seem nearly as pleased while she fades back in between her sisters.");
			}
			////Block
			//else if(damage <= 0) {
				//output("\nYou catch the hit on your forearm, stopping her cold.  The thuggish woman snarls as she fades back in between her sisters, disappointed at doing so little damage.");
			//}
			//Hit
			else {
				output("\nShe hits you square in the face, bloodying your face and sending you stumbling back in agony.  ");
				applyDamage(new TypeCollection( { kinetic : 15 + rand(10) }, DamageFlag.CRUSHING ), this, target);
			}
		}

		//Sand Stones
		//-Mob summons vibrating sands sands to  lust increase PCs lust
		//- Lust gained each round they use it is determined by how many naughty bits a PC has.
		//-For every dick, set of breast(nips?), cunts and ass-hole on a PC, the lust gain is increased by 3, Not accounting for lust resistance.
		//-Goo bodies will gain 30 Lust by default, not accounting lust resistance.
		//-Stones will randomly vibrate throughout the battle if they get the PC.

		public function sandstonesAreCool(target:Creature):void {
			output("The sandstorm whirling around the room suddenly ceases, and all the tiny sand particles gather together into balls, growing into several smooth stones.  Then, all the sand stones fall to the ground and slither towards you.");
			
			var bonus:int = 0;
			//[If attack misses]
			if (rangedCombatMiss(this, target)) {
				output("\nThe stones then make a ninety degree turn into the purple fire, and then nothing.  One sand-witch smacks another upside the head, yelling something about focusing.");
			}
			else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("\nThe stones can't get into your armor!");
			}
			//[If they attack lands]
			else {
				//[IF PC has solid body]
				if(!target.isGoo()) {
					output("\n\nThey crawl up your [pc.legs].  You try to swat them all off, but there are too many.");
					//If PC has 1 cock:
					if(target.cockTotal() == 1) output("  A stone crawls onto your [pc.cock].");
					//[If PC has multi-cocks: 
					if(target.cockTotal() > 1) output("  A bunch of the stones crawl onto your [pc.multiCocks].");
					if(target.hasCock()) bonus++;
					//[If PC has cunt]
					if(target.hasVagina()) {
						output("  One stone slides up your inner thigh");
						if(target.balls > 0) output(" behind your [pc.sack]");
						output(" and pops itself right into your [pc.vagina]");
						if(target.hasVirginVagina()) output(", robbing you of your virginity as a trickle of blood runs down your [pc.leg].");
						bonus++;
					}
					//[If PC has balls:
					if(target.balls > 0) {
						output("  A small set of stones settle on your [pc.balls].");
						bonus++;
					}
					output("  " + num2Text(target.totalNipples()) + " crawl up to your chest and over your top [pc.nipples 0]");
					if(target.bRows() > 1) {
						if(target.bRows() == 2) output(" and");
						else output(",");
						output(" your middle [pc.nipples 1]");
						bonus++;
					}
					if(target.bRows() > 2) {
						output(", and your bottom [pc.nipples 2]");
						bonus++;
					}
					output(".");
					output("  The last stone travels up the back of your [pc.legs] and slides right into your [pc.asshole].");
					output("\n\nYou try to get the stones off and out of you, but some kind of magic is keeping them stuck to you like glue.  One sand-witch snaps her fingers, and all the of the smooth stones begin vibrating, making numbing waves of pleasure that rattle your body.  <b>You have to end this quick, or else!</b>");
				}
				//[IF PC has goo body]
				else {
					output("\n\nThe stones launch themselves into your gooey body.  You try your best to dislodge these foreign objects from your insides, but some-kind of magic is holding them in place.  A sand-witch snaps her fingers and all the stones begin vibrating, sending ripples throughout your sentative gooey body.  It feels like your whole body is one, big pleasure-bomb right now.  You had better end this fight soon!");
					bonus = 5;
				}
				target.createStatusEffect("Lust Stones", bonus, 0, 0, 0, false, "LustUp", "Your body is teased by vibrating stones!", true);
				applyDamage(new TypeCollection( { tease : bonus * 2 + 5 + target.libido() / 7 } ), this, target); // sens originally
			}
			removeStatusEffect("Sandstorm");
		}

		//Milk is Good
		//-Mob's members start sucking on each other's tits. Arouses PC and restores health to mob, decreases (increases?) mob's lust.
		public function drankSomeMialk(target:Creature):void {
			output("One of the blonde beauties turns to another and asks, \"<i>A drink, sister?  Fighting this intruder has given me a powerful thirst.</i>\"  The other woman wordlessly opens her robe, baring her breasts, exposing four heaving, milk-fueled mounds to the air before the other woman claims a nipple for herself.  Three others crowd in on the exposed teats, their rumps shaking contentedly as they grab a quick snack.");
			output("\n\nAfter wiping the excess from their lips, they close their robes and resume a fighting stance, seeming healthier than before.  ");
			applyDamage(new TypeCollection( { tease : 4 + target.libido() / 10 } ), this, target);
			//+ 30 HP, +light lust damage to PC and mob
			HP(30);
		}

		//*Sandstorm
		//Creates a sandstorm that blinds the PC one out of every 3 rounds.  Used first turn. Deals light HP damage every turn.  Reduces breath attacks damage by 80%.  Makes bow miss 50% of the time.
		public function sandStormAttack(target:Creature):void {
			output("The witches link their hands together and begin to chant together, lifting their voices high as loose sand trickles in from every corner, every doorway, even the ceiling.  \"<i>Enevretni llahs tresed eht!</i>\"  Swirling around the chamber, a cloud of biting, stinging sand clouds your vision and bites into your skin.  It's going to keep blinding you and hurting you every round!");
			createStatusEffect("Sandstorm", 0, 0, 0, 0, false, "Icon_Confused", "Room is filled by cloud of sand!", true);
		}
	}
}