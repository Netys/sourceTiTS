package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.CoCBookBlack;
	import classes.Items.Miscellaneous.CoCBookWhite;
	import classes.Items.Miscellaneous.CoCOvipositionElixir;
	import classes.Items.Miscellaneous.CoCTatteredScroll;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.Util.*;
	
	public class CoCCumWitch extends Creature
	{
		public function CoCCumWitch() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Cum Witch";
			this.originalRace = "human";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The Cum Witch is a moderately tall woman, almost six feet in height.  Her dark ebony skin is nearly as black as pitch, though it glitters with sweat from her recent sexual activities and the fight.  She has plump lips and long, smooth blonde hair, though much of it is hidden behind a pointed, wide-brimmed hat.  Her robes are even blacker than she is, but she wields an alabaster staff that fairly sizzles with magical might.  Of course, her garments don't do much to conceal her gigantic breasts.  Though there are only two, they're large enough to dwarf the four tits most sand witches are packing.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.attackVerb = "punches";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 20.0;
			baseHPResistances.drug.resistanceValue = 20.0;
			baseHPResistances.pheromone.resistanceValue = 20.0;
			baseHPResistances.tease.resistanceValue = 20.0;
			
			this.armor.longName = "robes";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 6;
			this.XPRaw = normalXP();
			this.credits = (5 + rand(15)) * 10;
			this.HPMod = 100;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 35 / 20 * this.level;
			this.reflexesRaw = 35 / 20 * this.level;
			this.aimRaw = 35 / 20 * this.level;
			this.intelligenceRaw = 85 / 20 * this.level;
			this.willpowerRaw = 85 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 30;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = rand(12) + 55;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "sandy-blonde";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 15;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "black";
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
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_HUMAN;
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
			this.buttRatingRaw = 8;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(12);
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 2;
			this.vaginas[0].bonusCapacity = 20;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 12;
			
			this.nippleColor = "green";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			
			this.impregnationType = "CoCSandWitchPregnancy";
			
			this.createStatusEffect("Disarm Immune");
			
			tallness = rand(12) + 55;
			credits = (rand(15) + 5) * 10;
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BREASTS,	GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_MULTIPLES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_LACTATION,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [RandomInCollection([new CoCLactaid(), new CoCOvipositionElixir(), new CoCBookWhite(), new CoCBookBlack(), new CoCTatteredScroll(), new CoCLaBova()])];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (this.hasStatusEffect("Shell")) {
				this.addStatusValue("Shell", 1, -1);
				if (this.statusEffectv1("Shell") <= 0) {
					this.removeStatusEffect("Shell")
					this.baseHPResistances.psionic.resistanceValue -= 100.0;
					this.baseHPResistances.electric.resistanceValue -= 100.0;
					this.baseHPResistances.burning.resistanceValue -= 100.0;
				}
			}
			
			//Hurt!
			if(this.HP() < this.HPMax() * .6 && this.energy() >= 10) {
				sandWitchCuntHeals(target);
				return;
			}
			
			var choices:Array = [];
			
			//Dicks only
			if(target.hasCock()) choices.push(cumMagicAttack);
			choices.push(cumWitchBukkakeAttack);
			choices.push(cumWitchCocknosisAttack);
			if(!this.hasStatusEffect("Shell")) {
				choices.push(cumWitchShellDefense);
				choices.push(cumWitchShellDefense);
				choices.push(cumWitchShellDefense);
			}
			//HERMS
			if(target.isHerm()) choices[choices.length] = cumWitchGenderConfusionAttack;
			//VAGOOZLES
			if(target.hasVagina()) choices[choices.length] = cumHungerAttack;
			choices[rand(choices.length)](target);
		}

		//*Attack: Bukkake
		public function cumWitchBukkakeAttack(target:Creature):void {
			//*Cum Witch hikes up her dress and bukkake's at PC.  Large # of chance for 'hits' for low individual damage.  Small reduction to sand witch lust.  Used more at high lust.
			output("The Cum Witch moans and daintily peels her robes away from her swollen cock-flesh.  A bubble of precum pops wetly from her urethra to splatter on the floor as her balls suddenly swell.  You look back up in time to see the telltale glow of magic surrounding her staff, but then she's thrusting her hips at you, lewdly humping the air as she unleashes rope after thick rope of potent jism in your direction!\n");
			var hits:int = 5 + rand(8);
			var bonus:int = 0;
			var damage:int = 0;
			while (hits > 0) {		
				if (rangedCombatMiss(this, target)) {
					output("\nYou roll away from some of the hermaphrodite spunk, easily evading it.");
				}
				else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
					output("\nThe spunk can't seep into your airtight armor!");
				}
				else {
					var temp:Number = rand(5);
					//Hit1
					if(temp == 0) output("\nA mass of jizz splatters into your [pc.hair], soaking it with thick, salty goo.");
					else if(temp == 1) output("\nOne jet of thick witch-cum hits you in the [pc.chest] before you can react.  You can feel it getting inside your [pc.gear], squishing and sliding over your [pc.nipples] as you try to fight.");
					else if(temp == 2) output("\nSome of the stuff spatters off your arm and soaks your hand, making it a slimy mess.");
					else if(temp == 3) output("\nA creamy deluge hits your [pc.legs], though rather than running down, it seems to come up, flowing into your [pc.gear] to squish wetly across your sensitive groin.");
					else {
						output("\nSpunk nearly blinds you as the Cum Witch's virile fluids take you in the face.  You spit some of it out, the smell of the stuff making your head swim.");
						//bonus damage!
						bonus = 3;
					}
					damage+= 2;
				}
				hits--;
			}
			if(damage+bonus > 0)
				applyDamage(new TypeCollection( { pheromone : damage+bonus } ), this, target);
		}

		//*Attack: Cum Magic
		public function cumMagicAttack(target:Creature):void {
			//*Used on males only, casts spell that causes balls to temporarily swell and increase lust by a moderate amount.  Unavoidable.
			output("Gesticulating with her free hand, the Cum Witch utters impossible to pronounce words before closing her fingers tightly into a fist.  That same instant, you feel an onset of warmth in your [pc.balls], a spreading heat that makes you tremble with growing lust.  A second later, [pc.eachCock] is throbbing, and a runner of cum trickles from the [pc.cockHeads], a hint of your temporarily-enhanced virility.  ");
			//(15-30 lust, based on libido)
			applyDamage(new TypeCollection( { psionic : 5 + target.libido() / 12 } ), this, target);
			target.minutesSinceCum += 60 * 100;
		}
		
		//*Attack: Cum Hunger
		//*Used on vagoozles, spell that causes womb to literally thirst for sperm.  Unavoidable moderate lust gain.  Pregnant character's are immune.
		public function cumHungerAttack(target:Creature):void {
			output("Moaning luridly, the Cum Witch swivels her staff and opens her hand to spread her fingers wide.  At the same time, you feel her magic slam into your midsection, burrowing into your womb.  ");
			if(target.isPregnant()) {
				output("Yet, whatever she tries to do fails, as her otherworldly conjuration falls apart as soon as soon as it reaches you.");
				return;
			}
			output("It worms around your uterus, tickling it faintly before gently kneading your ovaries.  Your [pc.legs] go weak as your womb throbs, hungering for something to fill it.  A trickle of wetness squirts from your [pc.vagina] as the magic fades, and you squirm as your lust rises. If only something would make you pregnant!  Your eyes dart unbidden to the Witch's groin before you yank them away.  ");
			applyDamage(new TypeCollection( { psionic : 5 + target.libido() / 12 } ), this, target);
		}

		//*Attack: Gender Confusion
		public function cumWitchGenderConfusionAttack(target:Creature):void {
			//*Used on genderless and hermaphrodite characters.  Mental attack that draws on disharmony with standard gender types to stun for one round.  3 turn cooldown
			output("Touching her alabaster staff to her brow, just under the brim of her hat, the Cum Witch makes a brief incantation and fixes you with her gaze.  Her eyes flash blindingly white, and then you feel her inside you, rifling through your memories, digging up memories of your childhood, your past, and throwing them against you.  ");
			if (target.WQ() / 5 + rand(15) + target.level / 2 < 18) {
				output("She batters your consciousness with conflicting memories of your gender, utterly dazing you.  How can you fight when you can barely tell who you are anymore?");
				target.createStatusEffect("Stunned", 1, 0, 0, 0, false, "Stun", "Cannot take action!", true, 0);
			}
			else {
				output("You parse the flood of information with mental focus and expel the intruder from your mind with a clenching of your sizable intellect.");
			}
		}
		//*Attack: Shell
		public function cumWitchShellDefense(target:Creature):void {
			//*Grants immunity to all magic-based attacks for the next two turns.
			output("The Cum Witch holds her staff in both hands and rotates it in a circle, chanting all the while.  Her voice rises in pitch and intensity until she's screaming out unwords of power.  With one final cry, she slams her staff down into the ground hard enough to kick up a puff of sandy dust.  It quickly settles, but the Cum Witch has some kind of glittering, reflective shield around herself now!");
			this.createStatusEffect("Shell", 3, 0, 0, 0, false, "DefenseUp", "Cum Witch has some kind of glittering, reflective shield around herself now!");

			this.baseHPResistances.psionic.resistanceValue += 100.0;
			this.baseHPResistances.electric.resistanceValue += 100.0;
			this.baseHPResistances.burning.resistanceValue += 100.0;
		}

		//*Attack: Cocknosis
		//*Intelligence dependant attack with possibility of very high lust gain.
		public function cumWitchCocknosisAttack(target:Creature):void {
			output("Lifting her robes enticingly, the Cum Witch reveals her ");
			if(this.lustQ() < 50) output("half-hard");
			else if(this.lustQ() < 70) output("hard");
			else if(this.lustQ() < 85) output("throbbing");
			else output("hard, dripping");
			output(" cock.  She gently begins to sway her hips, bouncing back and forth with near-mechanical precision, her softly bobbing cock catching your eyes with its metronome-like precision.  She softly begins to speak, enunciating each word to the time and tune of her movements.");
			
			output("\n\n\"<i>See my cock?  See the glistening thickness of it?  Watch how it sways and bobs for you, moving with such smooth and easy grace.  Can you feel your eyes following it, locking onto it and never letting go?</i>\"\n\n");
			
			if (target.WQ() / 5 + rand(15) >= 13) {
				output("You chuckle at her crude attempt to hypnotize you with her member.  She stomps her foot in irritation and drops her robes back into place.");
			}
			else {
				output("The Witch smirks, though you're too focused on her cock to see, and she continues, \"<i>Good " + target.mf("boy","girl") + ".  Watch it sway.  You're so focused on my cock now that the world is just falling away around it, sinking into nothingness, leaving only that wonderful cock behind for you to watch.  And since it's filling your view, you can feel it filling your mind as well, can't you?</i>\"");
				output("\n\nYou nod, your view rigidly attached to her equally rigid tool as you utterly and completely fixate on her penis, admiring its curves, its thickness, and the way it seems to pulsate happily for you whenever you look at it just right.  The Witch keeps talking, but it's her dick that's important.  You start to drool as your [pc.skin] flushes and your body heats.  Gods, her cock is gorgeous.  Reaching down, you begin to masturbate without thinking.  You don't know why, but it just feels like the right thing to do.  ");
				applyDamage(new TypeCollection( { tease : 20 } ), this, target);
				if(target.lustQ() <= 99) output("\n\nYou bump against something, startling yourself out of the cocknosis before you can completely fall for it.  Still, you keep seeing her dick every time you close your eyes, and your body is very turned on from how you were touching yourself.");
				else {
					target.lust(target.lustMax() - 1);
					output("\n\nYou play with yourself until you're on the very edge of orgasm.  At that moment, a loud *SNAP* startles you back to wakefulness, and as you look down at the cock bobbing just a few inches away, you realize it's hopeless.  You can't fight this.");
				}
				output("\n\nThe witch smiles knowingly.");
			}
		}

		//*Attack: Heal
		//*Restores one third of her HP.
		public function sandWitchCuntHeals(target:Creature):void {
			output("The Witch smirks at you and holds her free hand under her robes.  When she pulls it out, you realize she's gathered a handful of her cum.  She holds it up and exhales over it, the air making a slight whistle as it blows through her parted lips.  The ebony sorceress then smears the goop over her wounds, which seem to drink in the cum and vanish before your eyes.  She scolds, \"<i>Physical damage?  How artless.</i>\"");
			this.HP(this.HPMax() * 0.33);
			this.energy( -10);
		}
	}
}