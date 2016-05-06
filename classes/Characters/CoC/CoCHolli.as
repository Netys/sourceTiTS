package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
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
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Apparel.CoCWizardRobes;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCHolli extends Creature
	{
		public function CoCHolli() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Holly";
			this.originalRace = "dryad";
			this.a = "";
			this.capitalA = "";
			this.long = "Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "branches";
			this.meleeWeapon.attackVerb = "branchy thwack";
			this.meleeWeapon.attackNoun = "branchy thwack";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 15;
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 30.0;
			baseHPResistances.drug.resistanceValue = 30.0;
			baseHPResistances.pheromone.resistanceValue = 30.0;
			baseHPResistances.tease.resistanceValue = 30.0;
			
			this.armor.longName = "bark";
			this.armor.defense = 20;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 2500;
			this.level = 20;
			this.credits = 0;
			this.HPMod = 1000;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 150 / 20 * this.level;
			this.reflexesRaw = 80 / 20 * this.level;
			this.aimRaw = 80 / 20 * this.level;
			this.intelligenceRaw = 85 / 20 * this.level;
			this.willpowerRaw = 85 / 20 * this.level;
			this.libidoRaw = 75;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 80;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "black";
			this.tallness = 6 * 12 + 6;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "blue";
			this.scaleColor = "none";
			this.furColor = "blue";
			this.hairLength = 16;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
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
			this.buttRatingRaw = 8;
			//No dicks here!
			this.cocks = new Array();
			createCock(24);
			createCock(24);
			createCock(24);
			createCock(24);
			createCock(24);
			createCock(24);
			shiftCock(0, GLOBAL.TYPE_TENTACLE);
			shiftCock(1, GLOBAL.TYPE_TENTACLE);
			shiftCock(2, GLOBAL.TYPE_TENTACLE);
			shiftCock(3, GLOBAL.TYPE_TENTACLE);
			shiftCock(4, GLOBAL.TYPE_TENTACLE);
			shiftCock(5, GLOBAL.TYPE_TENTACLE);
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 8;
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILKSAP;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (HP() < 50 && rand(2) == 0) healHolli(target);
			else if (rand(4) == 0 && !target.hasStatusEffect("Grappled")) holliConstrictAttack(target);
			else if (rand(2) == 0) fuckinJamanjiFlowerDarts(target);
			else CombatAttacks.MeleeAttack(this, target);
			holliBonusHealing(target);
		}
		
		/*Fight -Z
		 Marae's offshoot, [monster] stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.

		 stats:
		 -hella endurance, int, and str
		 -lots o' lust resist
		 -lots o' hp
		 -good armor and regenerates hp/lust every round; but much less so of all three if Jojo is burning her shit
		 -rooted in place, so med-low spd; however, if PC fails a run check he is automatically constricted
		 -not for pussies; this fight should be almost unwinnable without Jojo unless you are wicked lucky or have a super-sploity build
		 -basically requires luck plus any of firebreath level grindan, stun abuse, or blood mage whitefire/arouse abuse
		 */
		
		//Attack:
		//[monster] whips out at you with branches and roots!
		
		//attack noun: lash
		//Failing to Escape -Z
		public function runAwayFail():void
		{
			clearOutput();
			output("You ");
			if (kGAMECLASS.pc.canFly()) output("beat your [pc.wings] and ");
			output("try to escape, but " + short + " wraps one of her writhing roots around your [pc.leg], slamming you to the ground and tying you up with several more!  \"<i>And just where do you think you're going, my little meat?</i>\" she hisses.  Her bark splits open, exposing her body, and a green shaft snakes out of her crotch, sprouting thorns and blooming into a rose at the tip.  She holds the drooling blossom over your [pc.face] as she forces your mouth open with her roots! ");
			//hp loss, begin lust constrict next round
			applyDamage(new TypeCollection( { kinetic : 15 }, DamageFlag.CRUSHING), this, kGAMECLASS.pc, "minimal");
			output("\n\n");
			kGAMECLASS.pc.createStatusEffect("Grappled", 0, 0, 0, 0, false, "Icon_Constricted", "You are entangled by tentacles!", true);
		}
		
		//End of Round, if no Jojo Fire -Z
		public function holliBonusHealing(target:Creature):void
		{
			//(monster hp < 100%)
			if (!hasStatusEffect("HolliBurning")) {
				if (HPQ() < 100 && HP() > 1) {
					output("\n\nWhat wounds you have inflicted on the tree-demon overflow with sap, and begin to close!  You are left to watch helplessly as she recovers, knotting up her damaged bark until it looks as formidable as before.");
					HP(25);
				}
				//[(monster lust > 0)]
				if (lust() > 20 && lustQ() <= 99) {
					output("\n\nA single rent forms in the tree's armor-like surface; you can actually see the demon touching her pussy inside, and her eyes roll back as she comes!  It looks like teasing her won't be very effective if you can't distract her from pleasuring herself inside her shell.");
					lust( -10);
					//repair monster HP and lust by significant amounts
				}
			}
			//End of Round, Round 1 with Jojo Helping - make a little woodpile
			//output anything triggered under no Jojo Fire condition, then output
			if (hasStatusEffect("JojoIsAssisting")) {
				if (hasStatusEffect("HolliBurning")) {
					output("\n\nJojo continues to ferry firewood to stoke the blaze; flames lick at Holli, and her face contorts in anger.  Sap flows from her burn wounds, but much of it boils away before it can do her any good and her iron-hard bark is peeling in places.");
					//much less HP regain, no lust regain, monster armor lowered
					if (armor.defense > 0) armor.defense--;
					//if (tou > 50) tou = 50;
					//Reduced Regen
					HP(5);
					lust(-2);
					if (lust() < 20) lust(20, true);
				}
				else if (!hasStatusEffect("JojoPyre")) {
					output("\n\nJojo throws another handful of dry leaves and sticks on the growing pile at the demon's roots, then waves and calls to you.  \"<i>[pc.name]!  I've got enough dry wood at her base and I'm going to try to set it on fire!  Hold on just a bit longer; surcease is coming!</i>\"");
					createStatusEffect("JojoPyre");
				}
				//End of Round, Rounds 2 and 3 with Jojo Helping - light a spark
				else if (statusEffectv1("JojoPyre") <= 1) {
					//display applicable EOR outputs for fire not lit, then these
					//Round 2:
					if (statusEffectv1("JojoPyre") == 0) {
						output("\n\nJojo scurries toward the woodpile carrying a lit torch, but an eye opens on one of the demon's upper branches and she catches him with a root, sending him tumbling.  For a moment you lose hope, but the plucky monk rolls to the side before she can deliver another lash and from there to his feet.");
						addStatusValue("JojoPyre", 1, 1);
					}
					//Round 3:
					else {
						output("\n\nWary of the constant surveillance from above, Jojo serpentines toward the tree at high speed, dodging roots and branches with a burning stick held in his teeth.  Just as he gets close enough to throw, a root sweeps low and sends him sprawling onto his own torch, catching some of his fur alight!  Without hesitation, he rolls toward the tinder pile and shoves a burning hand into the leaf litter.  As the ring of flammable material catches and the demon screams her frustration, he retreats to the woods, beating his arm with his dirt-smeared robe to put it out.");
						createStatusEffect("HolliBurning");
					}
				}
			}
		}
		
		override public function OnTakeDamage(incomingDamage:TypeCollection):void 
		{
			if (incomingDamage.burning.damageValue > 0 && rand(100) < incomingDamage.burning.damageValue) {
				lightHolliOnFireMagically();
			}
			super.OnTakeDamage(incomingDamage);
		}
		
		//if player uses whitefire/firebreath successfully, suppress these, go to 'Fire Lit' EOR events, and output additional line after the attack:
		public function lightHolliOnFireMagically():void
		{
			if (hasStatusEffect("JojoIsAssisting")) {
				if (!hasStatusEffect("HolliBurning")) {
					output("The magical fire effectively ignites a wide swath of Jojo's tinder, and the demon howls in rage.  Seeing this, Jojo drops the burning torch he carries and turns back toward the forest to fetch more tinder.\n\n");
					createStatusEffect("HolliBurning");
				}
			}
		}
		
		//Monster Specials -Z
		//fuckin' Jumanji flower darts -Z
		private function fuckinJamanjiFlowerDarts(target:Creature):void
		{
			output("A blossom opens up on a high branch of the tree, revealing an evil-looking eye surrounded by vicious spines.  With a gesture, " + short + " fires several at you!");
			
			//Blinded - no hit penalty
			if (hasStatusEffect("Blinded") >= 0) output("  Though the demon herself is blinded, the fresh eye on the flower seems more than capable of aiming for her!");
			if (rangedCombatMiss(this, target)) {
				output("  Nimbly, you step aside and let the darts whistle by.");
			}
			//Hit
			else {
				output("  The darts find flesh, and you feel yourself slowing down drastically; all you want to do as the plant woman's poison takes you is fuck and sleep.  \"<i>Just give up,</i>\" Holli coos.  \"<i>Think how good it would be to fall into my arms and ");
				if (target.hasCock()) output("come inside me");
				else output("have me inside you");
				output(", forever...</i>\" ");
				//lust damage, fatigue damage, light HP damage
				target.energy( -10);
				applyDamage(new TypeCollection( { drug : 25, kinetic : 20 + rand(10) } ), this, target);
			}
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", struggleOutOfHolli, pc);
				addButton(4, "Do Nothing", waitForHolliConstrict, pc);
				return;
			}
		}
		
		//constrict -Z
		private function holliConstrictAttack(target:Creature):void
		{
			output("A forest of thick roots bursts from the ground and several lash toward your [pc.legs], trying to ensnare you!");
			//Blinded - hit penalty, but not 100%
			if (hasStatusEffect("Blinded") && rand(6) == 0) {
				output("  Luckily, the demon's blindness makes it fairly easy to dodge the grasping roots, though there are a few close scrapes.");
			}
			//Miss
			if (combatMiss(this, target)) {
				output("  It's a narrow thing, but you manage to avoid the roots - one of them almost grabs you, but you duck aside and let it find only its neighbor.");
			}
			//Hit
			else {
				output("  She latches onto you with a painful smack and several more root tentacles join the first; as she pulls you close, her bark opens and a long, phallic stalk extends from her crotch, wrapped in thorns and flowering with a rose!  It caresses your face, then dangles the blossom above your mouth, dripping her sap.  Several of the roots pry your jaws apart, forcing you to drink the tainted fluids from her pseudo-cock!  \"<i>What do you think of my little sap rose?</i>\" ");
				//plus med HP damage on turn one, plus med-heavy lust damage every turn while constricted
				//sap rose shitposting
				applyDamage(new TypeCollection( { drug : 15, kinetic : 10 + rand(5) } ), this, target);
				target.createStatusEffect("Grappled", 0, 0, 0, 0, false, "Icon_Constricted", "You are entangled by tentacles!", true);
			}
		}
		
		public function struggleOutOfHolli(target:Creature):void
		{
			clearOutput();
			//Boost odds of success. Round 3 guaranteed.
			target.addStatusValue("Grappled", 1, 9);
			//Struggle Succeed
			//if demon/dragon tongue, automatic success
			if (target.hasLongTongue()) {
				output("You can't move an arm nor a [pc.leg] to bat the flower away... but she's literally holding your mouth open.  Your long tongue rolls out, gripping and ripping out several of the petals on the end of her stalk!  Holli screams and her roots slacken, allowing you to batter your way out of them.");
				target.removeStatusEffect("Grappled");
			}
			//else if normal str-based success
			else if (target.physique() / 5 + rand(20) + 1 + target.statusEffectv1("Grappled") > 30) {
				output("You manage to force the roots open when the distracted Holli begins to stroke her plant-shaft, pulling out of the bindings just as a drop of sap oozes out and falls where you were standing.  You're free!");
				//sap rose pls go
				target.removeStatusEffect("Grappled");
			}
			//Struggle Fail/Wait
			else {
				output("You try to escape the entangling roots, but cannot break their grip!  ");
				waitForHolliConstrict(target, false);
				return;
			}
			CombatManager.processCombat();
		}
		
		public function waitForHolliConstrict(target:Creature, newScreen:Boolean = true):void
		{
			if (newScreen) clearOutput();
			output("The ominous roseate shaft hovers over you, and its owner strokes the base lewdly, moaning.  \"<i>Oooh, gonna... cum!</i>\" she shrieks.  As a low moan escapes her, the stalk bloats and begins to spill milky-white sap into your mouth!  Held rigid, you're eventually forced to swallow just to breathe; the sap slides into your stomach and warmth radiates to your midsection and groin, making you feel flushed and hot.  Holli sighs in satisfaction, evidently more relaxed after her climax.");
			//lower monster lust by medium-lots and apply med sens-based lust damage
			applyDamage(new TypeCollection( { drug : 15 + target.libido() / 5 } ), this, target);
			lust( -20);
			if (lust() < 20) lust(20, true);
			CombatManager.processCombat();
		}
		
		//heal -Z
		//used if monster HP < some level
		private function healHolli(target:Creature):void
		{
			clearOutput();
			output("The bark splits part way and the woman's mouth suddenly explodes with color, her lips folding out into a rather yonic-looking orchid.  Copious white-tinted sap oozes from the bloom, coating her bark and healing the lesions.  Petals rustle as she speaks wetly through it.  \"<i>Your efforts are nothing!  Throw yourself on my mercy; be my slave and do my bidding!</i>\"");
			//heal some fuckin' hp
			HP(200);
		}
		
		public function teaseReactionsFail():void
		{
			if (hasStatusEffect("HolliBurning")) {
				output("Holli doesn't even seem to notice, so concerned is she with defeating you before the mounting bonfire causes her any more pain.");
			}
		}
	}
}