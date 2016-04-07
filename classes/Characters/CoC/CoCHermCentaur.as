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
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Guns.CoCKeltBow;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCHermCentaur extends Creature
	{
		public function CoCHermCentaur() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "herm centaur";
			this.originalRace = "centaur";
			this.a = "the ";
			this.capitalA = "The ";
			
			this.long = "Standing tall and proud just a few feet away is a massive demon unlike any others you've seen.  She's every bit a centaur - horse body, hooves, fur, and everything, but she's also massive in proportion - about nine feet tall and equally well endowed.  Heaving, jiggly E-cups jut proudly from her chest, unrestrained and bare to the world, thick nipples capping them like majestic, sexual crowns.  Under her belly, a thick equine cock slaps wetly against her fur with every step, heavy balls dangling behind.  A solid black horn juts from her forehead, a testament to the demonic corruption flowing through this monstrous woman's veins.  Still, without the horn, you'd never have guessed she was a demon.  Her gleaming fire-orange hair and pale, freckled skin look like something you would see on an innocent maid, not a bestial altar of corrupted decadence.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 1;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			baseHPResistances.psionic.resistanceValue = 40.0;
			baseHPResistances.drug.resistanceValue = 40.0;
			baseHPResistances.pheromone.resistanceValue = 40.0;
			baseHPResistances.tease.resistanceValue = 40.0;
			
			this.armor.longName = "wraps";
			this.armor.defense = 4;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 5000;
			this.level = 22;
			this.credits = (rand(50) + 75) * 10;
			this.HPMod = 800;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 100 / 20 * this.level;
			this.reflexesRaw = 65 / 20 * this.level;
			this.aimRaw = 65 / 20 * this.level;
			this.intelligenceRaw = 65 / 20 * this.level;
			this.willpowerRaw = 65 / 20 * this.level;
			this.libidoRaw = 85;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;
			
			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 9 * 12;
			this.thickness = 60;
			this.tone = 60;
			this.hairColor = "ginger";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 3;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "freckled";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 1;
			this.hornType = GLOBAL.TYPE_NARWHAL;
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
			this.hipRatingRaw = 15;
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
			this.buttRatingRaw = 13;
			
			this.cocks = new Array();
			this.createCock(36);
			this.shiftCock(0, GLOBAL.TYPE_EQUINE);
			
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 15;
			
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 10 * Math.PI;
			this.ballFullness = 100;
			
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 30;
			
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = this.ballDiameter() * 10 * 60;
			this.timesCum = 2478;
			this.cockVirgin = false;
			this.analVirgin = false;
			this.vaginalVirgin = false;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 7;
			
			this.vaginas = [];
			this.createVagina();
			this.shiftVagina(0, GLOBAL.TYPE_EQUINE);
			this.vaginas[0].bonusCapacity = 50;
			this.vaginas[0].hymen = false;
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 4;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 50;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_FEMININE,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HYPER,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_EXOTIC_BODYSHAPE,GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			
			this._isLoading = false;
		}
		
		// Gonna handle this a little differently than usual.
		// This is one of the advantages of containing monster detail in this manner, and encapsulating the
		// combat implemenation thereof with it- we can easily make use of the object to store things
		// we would normally use StatusEffects for, in instances where the only thing that will care 
		// about those Affects are the user/consumer of them.
		
		private var _usedGottaCum:Boolean = false;
		private var _usedHeal:Boolean = false;
		
		private var _chargingArouse:Boolean = false;
		private var _lustAtChargeStart:Number = -1;
		private var _arouseCooldown:int = 0;
		
		private var _hypnoCockUses:int = 0;
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			_arouseCooldown--;
			
			// Priority use
			if (_chargingArouse) arouseSpellCast();
			else if (this.lust() >= 60 && !_usedGottaCum) gottaCum();
			else if (this.HPQ() <= 50 && !_usedHeal) healUp();
			else if (rand(lust()) >= 40) this.hypnoCock();
			else
			{	
				// Selections
				var opts:Array = [feminineMusk, aphrodisiacSquirt];
				if (!_chargingArouse && _arouseCooldown <= 0) opts.push(arouseSpellCharge);
				
				opts[rand(opts.length)]();
			}
		}
		
		private function feminineMusk():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Turning about, the demonic centauress lifts her tail to reveal the slimy, lubricated lips of her puffy, black horse-cunt.  She arches her human body back to lie on her back, an incredible show of flexibility, allowing you to view the silhouette of her jutting nipples her tail lazily fans her corruption-enhanced pheromones in your direction.");
			
			if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("  Your sealed armor is protecting you well!");
				return;
			}
			
			output("  The air temperature seems to spike by a few degrees as the fan of biological lust washes over you.  Fragrant female moisture seems to seep into your very pores, and in spite of your desire to win out, ");
			
			if (pc.lustQ() <= 50) output(" your " + pc.skin() + " grows feverishly hot.");
			else 
			{
				output(" blood rushes to your loins, invigorating");
				if (pc.hasCock()) output(" [pc.eachCock] with the desire to plunge inside that juicy-hot hole.");
				else if (pc.hasVagina()) output(" your [pc.vagina] with the desire to submit while juices pool between your [pc.legs].");
				else output(" your anus until it puckers, craving something to fill it - anything.");
			}
			
			applyDamage(new TypeCollection( { pheromone : 8 + (pc.libido() / 10) + (pc.cor() / 10) } ), this, pc);
		}
		
		private function aphrodisiacSquirt():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The centaur grabs her heavy tits and casually squeezes the prodding, hard nipples that cap them.  A trickle of rose moisture trickles out, dripping down the underside of her bust to glisten wetly in the light.  Spellbound for the moment, you look on in wonder at the display of demonic lactations.");
			
			if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("  Then, she squeezes down to spray a torrent of pink-tinged breastmilk directly at you, splitting into so many forks of fluid that you have no hope to dodge. But you don't even flinch, trusting in your sealed armor.");
				return;
			}
			
			output("  A faint sweetness lingers in the air, and you lick your lips without meaning to.  Then, she squeezes down to spray a torrent of pink-tinged breastmilk directly at you, splitting into so many forks of fluid that you have no hope to dodge.");
			
			applyDamage(new TypeCollection( { drug : 8 + (pc.libido() / 10) + (pc.cor() / 10) } ), this, pc);

			if (pc.lustQ() < 30) output("\n\nYou close your mouth tight and endure the shimmering shower, trying your damnedest to resist the effects of this insidious liquid.  Wherever it strikes you, it vanishes soon after, absorbed directly into your body.");
			else if (pc.lustQ() < 40) output("\n\nYour heart beats faster.");
			else if (pc.lustQ() < 50) output("\n\nYour cheeks color as you try not to imagine how you could fuck such a beast.");
			else if (pc.lustQ() < 60) output("\n\nYour blink, but find your eyes staying closed a moment longer than you intended, visions of yourself suckling down the pink sweetness occupying your mind.");
			else if (pc.lustQ() < 70) 
			{
				output("\n\nYou groan in disappointment when you realize what's going to happen, but as soon as you're slicked with the aphrodisiac,");
				if (pc.hasCock()) output(" [pc.eachCock] awakens, filling itself towards full erection.");
				else if (pc.hasVagina()) output(" a wet heat answers in your loins, growing more insistent from moment to moment.");
				else output(" your [pc.asshole] tingles, craving something to fill it.");
			}
			else if (pc.lustQ() < 80) 
			{
				output("\n\nYou sigh and try to gain a better position during the pink rain");
				if (pc.hasCock()) output(" ignoring the stiffening pressure of [pc.eachCock]");
				else output(" ignoring the increasing wetness of your inner [pc.gear]");
				output(". It's getting harder to think straight with all this desire welling up inside you.  It isn't for a few moments that you realize you tongue is hanging out and drooling all over youself.  Gods, you want to fuck!");
			}
			else if (pc.lustQ() < 90)
			{
				output("\n\nPanting feverishly, you try to ignore the blush-colored downfall, but it's a futile gesture.  It makes your " + pc.skinFurScales() + " burn hot, wicking inside you with devilish efficiency to stoke the fires of your lust beyond normal limits.");
				if (pc.hasCock()) output("  Pre begins to dribble from your hot-and-ready cum-slit, eager to pour out in a deluge of sperm.");
				else if (pc.hasVagina()) output("  A flood of sopping moisture dribbles down your [pc.legs], the proof of your unholy desire to breed.");
				output(" You NEED to fuck soon.  You can barely contain yourself!");
			}
			else if (pc.lustQ() < 100) output("\n\nMoaning out loud, you smear the stuff across your [pc.chest] as it sprinkles you, the mounting desire almost at your limit.  You want to touch yourself SO BADLY, but you know that if you do, you'll wind up a mare to this centaur, perhaps forever.  You have to resist!  You can't fall victim to this... alluring creature.");
			else output(" Sinking to your knees, you start trying to tear your way out of your [pc.gear].  You don't care about winning anymore - fucking this woman... this beast... that's all that matters.  You don't care how she takes you, as long as you get to cum all over her!");
		}
		
		private function arouseSpellCharge():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			// one turn charge-up, can be interrupted by tease
			output("The centauress closes her eyes for a moment, then opens them.  Her eyes have gone completely, solidly black.  She's chanting low, though you see her dick bobbing beneath her in time with the mysterious utterances, leaking pre-cum.  You've got to stop her!");
			if (pc.intelligence() >= 40) output("  A tease attack would likely be the most effective method of attack.");
			
			_chargingArouse = true;
			_lustAtChargeStart = this.lust();
			_arouseCooldown = 7;
		}
		
		private function arouseSpellCast():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			_chargingArouse = false;
			
			if (this.lust() >= this._lustAtChargeStart + 10)
			{
				//(Interrupted)
				output("Shuddering, the demoness stumbles over her words, and a flash of ruby light envelops her form!  A low, lurid moan escapes the crimson-fogged outline, echoing with lust beyond measure as its owner's spell backfires on her.  Ropes of pre as thick as most men's cum-shots splatter into the grass and cobble while the herm's balls seem to double in size.  Even then, the heavy male orbs shine dully, absolutely soaked with dripping mare-lube.");
				
				applyDamage(new TypeCollection( { psionic : 10 + (pc.libido() / 12) + (pc.cor() / 12) } ), this, this);
			}
			else
			{
				//(OH SHIT YOU GUNNA GET FUKKED)
				output("The chanting reaches a crescendo before you can stop it, and as the nine-foot woman points at you, you barely have time to enunciate a single curse.  Her spell is upon you.  There's a flash of crimson light, seemingly as bright as the sun, and then you're hit with a wave of lust so strong it might as well be a physical force.  It slaps you hard enough to send you reeling, even while your heart pumps every spare drop of blood south.  You cry out at the forced arousal, blubbering wildly as the pleasure mounts and images of you and your foe locked together in every sexual position imaginable flood your consciousness.");
				
				applyDamage(new TypeCollection( { psionic : 20 + (pc.libido() / 6) + (pc.cor() / 6) } ), this, pc);
			}
			
			_lustAtChargeStart = -1;
		}
		
		private function hypnoCock():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			_hypnoCockUses++;
			
			if (_hypnoCockUses == 1)
			{
				output("THWACK! You start at the odd noise - neither of you were making contact with the other.  THWACKschlorp!  This time a ludicrously wet sound punctuates the noise.  The demonic centaur is smiling widely, her cheeks flushing slightly as the audible noises continue, each time deepening her blush.  What the hell?  TWHACKschhhlick!");
				output("\n\nYou glance lower in time to see her member slowly stretching away from her equine underside, seemingly held by thick strands of her heavy pre.  Only when it's hanging low enough for the shiny webs to snap does it move, surging upward with fresh lust to slap against her belly, spattering globules of pre-cum over the furry flesh.  There's a steady, undeniable tempo to it - every impact seems to follow the same hidden beat as the one before, echoing through the courtyard and into your vulnerable ears.");
				output("\n\nOnly after watching spellbound for a few moments do you realize that the demoness has begun to talk, speaking in low whispers, \"<i>Hard to look away isn't it?  I've been told it can be quite hypnotic... almost... spell-binding.</i>\"");
				output("\n\nWell, you can see that for yourself.  It's easy to watch it slowly lower, then smack up, ejecting a heavy load of pre-orgasmic fuck-juice.  You've got to look at her while you fight her anyway, so you don't mind that you're looking there.  You can keep an eye where she's most vulnerable.");
			}
			else
			{
				output("THWACK!  She's started thumping her cock against her belly again, and you look for the source of the noise again without thinking, spotting her turgid horse-cock just soon enough to watch it thump into her belly, a drizzle of pre running across its hard underside.  It slowly lowers, then rises again, slamming itself against her jizz-moistened underset with a wet slap.  The tempo is as steady and rhythmic as before, and the demon's voice doesn't help.");
				output("\n\n\"<i>Yes, your eyes do seem to lock onto it, don't they?  They see my hard cock and they have such a hard time doing anything but watching it, letting it fill their view entirely,</i>\" she muses quietly.");
				output("\n\nYes... it's quite mesmerizing.  You try to look up, but that cock just seems to slap itself right back into your view, the echo of the impact rattling around your skull.  The sultry centaur muses, \"<i>I can see you're quite taken with it.  Surely there's no harm in relaxing to watch it, is there?</i>\"");
			}

			// Resistance-esque check, idk I threw this terrible shit together
			if (pc.willpower() * (4 / _hypnoCockUses) > rand((pc.libido() / 3) + (pc.libido() / 3) + (pc.cor() / 3))) // was sens originally
			{
				if (pc.lustQ() <= 33) output("\n\nA warning thought jars you out of the cock-induced reverie with a start - this demon was going to hypnotize you, likely trying to seduce you into submission.  Not this time!  You tear yourself away and look her in the eye triumphantly.");
				else if (pc.lustQ() <= 66) output("\n\nA quiet voice pipes up somewhere inside you and warns that something is amiss.  It's enough to stir you from your stupor, kindling your willpower to wrest your view from your foe's gently bobbing fuck-log.  You look her in the eye triumphantly.");
				else output("\n\nA simpering voice begs you to look away from the deliciously-throbbing fuck-stick before you, but you nearly ignore it.  That fat cock looks so goddamn good - so hypnotic as it bounces and dances before you, enthralling you.  No!  You jerk your gaze up to look the demon in the eyes and frown when you see her gloating.  You might be primed to fuck, but you won't fall for her tricks this time!");
				
				applyDamage(new TypeCollection( { psionic : 2 + (pc.libido() / 20) + (pc.cor() / 20) } ), this, pc);
			}
			else
			{
				output("Down it bobs, slowly hanging lower and lower... SMACK!  Up it goes, taking your bedazzled eyes along for the ride.  \"<i>That's a good " + pc.mf("boy", "girl") + ",</i>\" the dick's director whispers, \"<i>Just follow the tempo and let it fill your mind, oozing inside you with each thump.</i>\"");
				output("\n\nFuck!  She's right, it's getting awfully hard to think about anything else.  You fixate further on the cock, unwilling or unable to look away.");
				output("\n\n\"<i>It's so easy to just watch and let your thoughts leak out of your head?</i>\" the voice asks.");
				output("\n\nYou nod.");
				output("\n\n\"<i>Each pendulous motion, every movement, it's so sexy, isn't it?</i>\"");
				output("\n\nAgain, you nod.");
				output("\n\nThe voice continues, \"<i>Every pulse, every sloppy discharge, every throb... they're all so sexy, so wet and hot.  The harder you watch, the more arousing it gets... the more you want to touch it.</i>\"");
				output("\n\nGods, you want to touch it.  One of the rigid veins pulsates, and you want to caress it so badly, to feel it twitch in your hand and drip all over you.  It looks so good, so powerful and lusty.  It's making you so horny just looking at it.  How would it feel to fuck it?  To ride it?  To bend over and present yourself to be willingly impaled?");
				
				applyDamage(new TypeCollection( { psionic : 20 + 2 * _hypnoCockUses + 2 + rand((pc.libido() / 10) + (pc.cor() / 10)) } ), this, pc);
	
				if (pc.lustQ() >= 100) output("\n\nYou whimper, too horny to care anymore.  You moan in anticipation when you realize she's going to breed you...");
				else
				{
					output("\n\nYou stumble forward, the movement actually startling you from your lusty haze.  It's just what you need to free yourself from the unholy compulsion, and you ready yourself anew to take down this troublesome foe.  Still, your gaze keeps flicking down.  You'll have a harder time fighting off any similar teases...");
					output("\n\n\"<i>Let's see the mighty 'Champion' resist me now,</i>\" the equine demon taunts, finally stopping her phallus's troublesome motion.");
				}
			}
		}
		
		private function gottaCum():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			_usedGottaCum = true;
			output("Sighing, the demoness gives you a lust glare and idly stomps at the ground with a hoof.  \"<i>Stop turning-unf-on you... you stupid... sexy...ungh, DAMNIT!</i>\" she protests, her rigid cock, slapping her belly while streamers of lady-jizz drip down the gleaming orbs that fill her black-skinned ballsack.  The centaur paws at her tits with unrepentant lust, tugging her large, hard nipples mercilessly while her hind legs stutter around, probably only moving in order to grind the thick, female lips together that much harder.");
			
			output("\n\nThe corruption-fouled, fair-skinned creature coos breathily, \"<i>Now you've got to watch me cum, Champion.</i>\"");
			
			output("\n\nHundreds of pounds of monstrous, equine bulk shift and contort, her body violently clenching with bliss as her cock flares, rigid beneath her belly.  She moans and dribbles pink milk from her hard nipples as her pussy explodes, releasing a torrent of slimy lady-spunk that splashes in the grass between her hooves, flooding the air with her scent.  A second later, her fully-dilated cockhead trembles, the moist cum-slit opening wide.  A surge of white bursts from that narrow hole, spattering over the cobbles in a messy tide, flooding the air with salty jizz-smell.  Quaking, her cum-inflated nuts slowly shrink with each spray of spunk until they're barely the size of large apples.");
			
			output("\n\nFlushing, the demoness whimpers, \"<i>...don't think I can do that again, but I don't think you'll be able to turn me on like that twice!</i>\"");
			
			this.lust(0, true);
			applyDamage(new TypeCollection( { tease : 15 } ), this, pc);
		}
		
		private function healUp():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			_usedHeal = true;
			
			output("Wiping a drop of blood from her wounds, the demon frowns in irritation.  \"<i>Do you have any idea how hard healing spells are to pull off when you're thinking about plowing a champion from behind?</i>\"  Her eyes flutter closed in concentration while sexual fluids run unimpeded from her mixed genitals.  At the same time, her wounds close up, covered with freshly grown horsehair or pale pink skin.  A few moments later, she wobbles slightly and mutters, \"<i>All better... hopefully you don't manage that twice.  I doubt I could pull it off again.  Then again, you'll likely be hilted on my dick or tongue-deep in my snatch by then, won't you?</i>\"");
			
			this.HP(this.maxHP());
		}
	}
}