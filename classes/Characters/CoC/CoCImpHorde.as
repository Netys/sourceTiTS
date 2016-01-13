package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Apparel.CoCNurseOutfit;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.Util.RandomInCollection;
	
	
	public class CoCImpHorde extends Creature
	{
		public function CoCImpHorde()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Originally a clone of the zilpack
			// Needs a few things checked.
			this.short = "imp horde";
			this.originalRace = "imp";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "Imps of all shapes and sizes fill the room around you, keeping you completely surrounded by their myriad forms.  You can see more than a few sporting disproportionate erections, and there's even some with exotic dog-dicks, horse-pricks, and the odd spiny cat-cock.  Escape is impossible, you'll have to fight or seduce your way out of this one!";
			this.customBlock = "";
			this.isPlural = true;
					
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 12;
			this.meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.damageValue = 50.0;
			baseHPResistances.drug.damageValue = 25.0;
			baseHPResistances.pheromone.damageValue = 25.0;
			baseHPResistances.psionic.damageValue = 25.0;
			
			this.XPRaw = 1000;
			this.level = 10;
			this.credits = (20 + rand(25)) * 10;
			this.HPMod = 450;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 20 / 20 * this.level;
			this.reflexesRaw = 25 / 20 * this.level;
			this.aimRaw = 25 / 20 * this.level;
			this.intelligenceRaw = 12 / 20 * this.level;
			this.willpowerRaw = 12 / 20 * this.level;
			this.libidoRaw = 45;
			this.energyRaw = 100;
			this.lustRaw = 10;
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "black";
			this.tallness = 36;
			this.thickness = 20;
			this.tone = 70;
			this.hairColor = "black";
			this.scaleColor = "";
			this.furColor = "";
			this.hairLength = 1;
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
			this.hipRatingRaw = 2;
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
			this.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			this.cocks[0].cLengthRaw = 12;
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
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity += 10;

			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(5 + rand(3));
			
			inventory = [new CoCNurseOutfit()];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (hasStatusEffect("Uber Charge") && CombatManager.getRoundCount() > statusEffectv1("Uber Charge") + 1 || isImmobilized() || hasStatusEffect("Blinded")) {
				output("The imps in the back were unable to finish their spell!\n");
				removeStatusEffect("Uber Charge");
			}
			
			if (hasStatusEffect("Uber Charge"))
				ZetazCaveImpHordeUber(target);
			else if (lust() > 50 && rand(2) == 0)
				ZetazCaveImpHordeBukkake(target);
			else {
				if(rand(4) < 3) ZetazCaveImpHordeImtacularMultiHitzilla(target);
				else ZetazCaveImpHordeUber(target);
			}
			if(rand(2) == 0) {
				output("\nOne of the tiny demons latches onto your [pc.leg] and starts humping it.  You shake the little bastard off and keep fighting!  ");
				applyDamage(new TypeCollection( { tease : 1 } ), this, target);
			}
		}

		public function ZetazCaveImpHordeUber(target:Creature):void {
			if(!hasStatusEffect("Uber Charge")) {
				output("Three imps on the far side of the room close their eyes and begin murmuring words of darkness and power.  Your eyes widen, recognizing the spell.  Anything but that!  They're building up a massive arousal spell!  They keep muttering and gesturing, and you realize you've got one round to stop them!\n");
				createStatusEffect("Uber Charge", CombatManager.getRoundCount(), 0, 0, 0, false, "LustUp", "An overcharged spell is almost ready!");
			}
			else {
				//(OH SHIT IT GOES OFF) 
				//+50 lust!
				output("The imps in the back finish their spell-casting, and point at you in unison.  A wave of pure arousal hits you with the force of a freight train.   Your equipment rubs across your suddenly violently sensitive [pc.nipple]");
				if (target.isLactating()) output(" as they begin to drip [pc.milk]");
				output(".  The lower portions of your coverings ");
				if(target.cockTotal() > 0) {
					output("are pulled tight by your [pc.multiCocks], ");
					if(target.totalCocks() > 1) output("each ");
					output("beading a drop of pre-cum at the tip");
					if(target.hasVagina()) output(", and in addition, the clothes around your groin ");
				}
				if(target.hasVagina()) {
					output("become stained with feminine moisture");
					if(target.clitLength > 3) output(" as your [pc.clit] swells up in a more sensitive imitation of a cock");
				}
				if (!target.hasGenitals()) output("rub the sensitive skin of your thighs and featureless groin in a way that makes you wish you had a sex of some sort");
				output(".");
				applyDamage(new TypeCollection( { psionic : 50 } ), this, target);
				output("\n");
				removeStatusEffect("Uber Charge");
			}
		}

		public function ZetazCaveImpHordeBukkake(target:Creature):void {
			output("Many of the imps are overcome by the lust you've inspired.  They hover in the air around you, pumping their many varied demonic rods as they bring themselves to orgasm.\n");
			
			//(2-6 hits)
			var hits:Number = rand(5) + 2;
			//Initial damage variable.
			var damage:Number = 0;
			//Loop through and apply dodges and whatnot for each hit.
			while(hits > 0) {
				//+30% chance to avoid attack for evade
				//Clear damage from last loop
				damage = 0;
				//Blind dodge change
				if(hasStatusEffect("Blinded") && rand(3) < 2) {
					output("Their misguided spooge flies everywhere.  A few bursts of it don't even land anywhere close to you!\n");
				}
				//Determine if dodged!
				else if (rangedCombatMiss(this, target)) {
					output(RandomInCollection([
						"A wad of cum spatters into the floor as you narrowly sidestep it.\n",
						"One of the imps launches his seed so hard it passes clean over you, painting the wall white.\n",
						"You duck a glob of spooge and it passes harmlessly by.  A muffled grunt of disgust can be heard from behind you.\n",
						"You easily evade a blast of white fluid.\n"]));
				}
				else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
					output("Your sealed armor protects you! ");
				}
				//(2-6 hits for +10 lust each!) (-5 lust per successful hit)
				else {
					output(RandomInCollection([
						"A squirt of hot demonic cum splatters into your face! ",
						"Jet with thick demonic spunk hit your [pc.fullChest]! ",
						"Some of the fluid splatters into your midriff and drools down to your waist, making you slimy and wet. ",
						"Seed lands on your [pc.hair], slicking you with demonic fluid.\n",
						"Another blast of jizz splatters against your face, coating your lips and forcing a slight taste of it into your mouth. ",
						"The last eruption of cum soaks your thighs. "]));
				
					applyDamage(new TypeCollection( { pheromone : (7 + rand(target.libido() / 40 + target.cor() / 40)) } ), this, target);
					output("\n");
				}
				lust( -5);
				hits--;
			}
		}

		public function ZetazCaveImpHordeImtacularMultiHitzilla(target:Creature):void {
			//Multiattack:
			if(!hasStatusEffect("Blinded")) output("The imps come at you in a wave, tearing at you with claws!\n");
			//(ALT BLINDED TEXT)
			else output("In spite of their blindness, most of them manage to find you, aided by the clutching claws of their brothers.\n");
			//(2-6 hits for 10 damage each)
			var hits:Number = rand(5) + 2;
			//Initial damage variable.
			var damage:Number = 0;
			//Loop through and apply dodges and whatnot for each hit.
			while(hits > 0) {
				//Clear damage from last loop
				damage = 0;
				//Blind dodge change
				if(hasStatusEffect("Blinded") && rand(3) < 2) {
					output("The imp completely misses you with a blind attack!\n");
				}
				//Determine if dodged!
				else if(combatMiss(this, target)) {
					output("You dodge the imp's claws with superior quickness!\n");
				}
				//OH SHIT SON YOU GOT REAPED
				else {
					if (hits == 6) output("You're clawed viciously by an imp!");
					if (hits == 5) output("One bites your ankle!");
					if (hits == 4) output("An imp rakes his claws down your back.");
					if (hits == 3) output("One of the little bastards manages to scratch up your legs!");
					if (hits == 2) output("Another imp punches you in the gut, hard!");
					if (hits == 1) output("Your arm is mauled by the clawing!");
					output(" ");
					applyDamage(new TypeCollection( { kinetic : 20 - rand(target.RQ() / 10 ) } ), this, target);
					output("\n");
				}
				hits--;
			}
		}
	}
}