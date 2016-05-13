package classes.Characters.CoC
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.addButton;
	import classes.Engine.Interfaces.addDisabledButton;
	import classes.Engine.Interfaces.clearMenu;
	import classes.Engine.Interfaces.clearOutput;
	import classes.Engine.Utility.IncrementFlag;
	import classes.Engine.Utility.Mutator;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Transformatives.CoCLactaid;
	import classes.kGAMECLASS;
	
	public class CoCLethice extends Creature
	{
		//constructor
		public function CoCLethice()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Lethice";
			this.originalRace = "demon";
			this.a = "";
			this.capitalA = "";
			this.long = "OVERRIDE";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "whip-slash";
			this.meleeWeapon.longName = "whip";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "wraps";
			this.armor.defense = 2;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances.psionic.resistanceValue = 85.0;
			baseHPResistances.drug.resistanceValue = 85.0;
			baseHPResistances.pheromone.resistanceValue = 85.0;
			baseHPResistances.tease.resistanceValue = 85.0;
			
			this.level = 25;
			this.XPRaw = bossXP();
			this.credits = (rand(25) + 10) * 10;
			this.HPMod = 650;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 110 / 20 * this.level;
			this.reflexesRaw = 110 / 20 * this.level;
			this.aimRaw = 110 / 20 * this.level;
			this.intelligenceRaw = 110 / 20 * this.level;
			this.willpowerRaw = 110 / 20 * this.level;
			this.libidoRaw = 100;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 100;
			
			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "black";
			this.tallness = 12 * 9;
			this.thickness = 40;
			this.tone = 40;
			this.hairColor = "purple";
			this.scaleColor = "blue";
			this.furColor = "blue";
			this.hairLength = 13;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "pink";
			this.skinFlags = new Array();
			
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 1;
			this.earType = GLOBAL.TYPE_DEMONIC;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_DEMONIC;
			this.hornLength = 13;
			this.armType = GLOBAL.TYPE_DEMONIC;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_DRACONIC;
			this.legType = GLOBAL.TYPE_SUCCUBUS;
			this.legCount = 2;
			this.legFlags = new Array();
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_DEMONIC;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_TAILCOCK, GLOBAL.FLAG_SMOOTH, GLOBAL.FLAG_PREHENSILE, GLOBAL.FLAG_LONG];
			//Used to set cunt or dick type for cunt/dick tails!
			this.tailGenitalArg = 0;
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
			this.hipRatingRaw = 6;
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
			this.buttRatingRaw = 6;
			//No dicks here!
			this.cocks = new Array();
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 30;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 2;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 90;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 4182;
			this.cockVirgin = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.vaginas = new Array();
			this.createVagina();
			this.vaginas[0].hymen = false;
			this.vaginas[0].clits = 1;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].bonusCapacity = 30;
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			//this.fertility = 0;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 3;
			this.nippleColor = "cerulean";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 3;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 50;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			this.createPerk("Inhuman Desire", 80, 0, 0, 0, "");
			
			createPerk("Implant: Iron Body", 0, 20, 0, 0);
			createPerk("Implant: Wired Reflexes", 0, 20, 0, 0);
			createPerk("Implant: Tactical Analyzer", 0, 20, 0, 0);
			createPerk("Implant: Cognitive Coprocessor", 0, 20, 0, 0);
			createPerk("Implant: Mental Shield", 0, 20, 0, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			inventory = [];
			
			_isLoading = false;
		}
		
		override public function get long():String
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			var str:* = "";
			if (_fightPhase == 1) {
				str += "Lethice is the epitome of all things demonic. From her luxurious purple hair, interwoven with black roses, to her pink skin and goat-like horns, she is the perfect image of sensual, enticing corruption. Tall heels of bone complement her revealing"; 
				str += ", black clothes. They look almost like a nun’s habit, but pared down to an almost fetishistic extreme. Her slim breasts provide just a hint of shape to the diaphanous fabric, a promise of feminine delights instead of the garish acres of flesh her outfit displays.";  
				str += " Outsized wings, like those of a dragon, hold Lethice aloft as she zips about her throne room, gathering her corruptive magics. The strangely slit pupils of her black-rimmed eyes never seem to leave you.";
			}
			else if (_fightPhase == 2) {
				str += "You're completely surrounded by demons! The members of Lethice's corrupted court have flooded the throne hall like a sea of tainted flesh, crushing in on you with the sheer weight of bodies being thrown against you. Incubi, succubi, and forms between and combining them all grasp and thrust at you, trying to overwhelm you with desire for their inhuman bodies and the unspeakable pleasures only demons command.";
				if (hasStatusEffect("Blinded"))
				{
					str += " The demons have relented somewhat, clutching at their eyes and screaming in frustration and panic thanks to your potent spell!";
				}
				else if (hasStatusEffect("Burning") || hasStatusEffect("Burn"))
				{
					str += " More than a few of the court are screaming in terror, rolling on the ground and trying desperately to put out the flames you've bathed them in! Turns out Marethian demons aren't all that immune to fire!";
				}
			}
			else {
				str += "Lethice is the epitome of all things demonic. From her luxurious purple hair, interwoven with black roses, to her pink skin and goat-like horns, she is the perfect image of sensual, enticing corruption. Tall heels of bone complement her revealing";
				str += ", black clothes. They look almost like a nun’s habit, but pared down to an almost fetishistic extreme. Her slim breasts provide just a hint of shape to the diaphanous fabric, a promise of feminine delights instead of the garish acres of flesh her outfit displays.";  
				str += " Standing astride her throne";
				if (_wingsDestroyed)
				{
					str += ", her wings in tatters";
				}
				str += ", Lethice regards you with a snarl and a crack of her flaming whip. Her yellow-black eyes are wide with fury, the pointed tips of her teeth bared in a snarl. Gorged with lethicite, the enraged demon queen is determined to finish you. Her endurance can’t possible hold for too much longer. You can beat her!";
				if (_fightPhase == 3 && _defMode != 0)
				{
					if (_defMode == 1)
					{
						str += "\nLethice is standing ready for your next attack, ready to defend against any strike. Perhaps you could surprise her with something else?";
					}
					else if (_defMode == 2)
					{
						str += "\nLethice is smirking and confident, prepared to resist any sort of libidinous advance, but her posture is ill-suited to deflecting attacks.";
					}
				}
			}
			if (pc.hasStatusEffect("LethicesRapeTentacles"))
			{
				str += "\n\n<b>A forest of black tentacles sprout from the floor, snaring any demons unlucky enough to venture close - or any champions unlucky enough to be in the center of it all.";
				if (pc.statusEffectv3("LethicesRapeTentacles") != 0)
				{
					output(" Unfortunately, they’ve grabbed you. You need to break free to do anything!");
				}
				if ((pc.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_WHITEFIRE) > 0 || kGAMECLASS.isNineTails(pc))
				{
					output(" A blast of magical fire could probably dispel them, or you could rely on your");
					if (pc.canFly())
					{
						output(" flight");
					}
					else
					{
						output(" quickness");
					}
					output(" to stay safe. Either way, you’re free for now.</b>");
				}
			}
			if (hasStatusEffect("Shell")) // this.createPerk("Ranged Immune",0,0,0,0);
			{
				output("\n\n<b>Lethice is surrounded by a shimmering dome of magical energy. Spells and ranged attacks will be ineffective!</b>");
			}
			if (pc.hasStatusEffect("PigbysHands"))
			{
				output("\n\nInvisible hands roam over your body, stroking you in ways that no one but a lover ever should. They won’t stop, and they won’t slow. You’ll have to try to ignore their arousing caresses.");
			}
			return str;
		}
		
		private var _roundCount:int = 0;
		
		private var _fightPhase:int = 1;
		
		private var _wingsDestroyed:Boolean = false;
		
		private var _defMode:int = 0;
		private var _lastHP:int = 0;
		private var _lastLust:int = 0;
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			_roundCount++;
			switch(_fightPhase)
			{
				case 1:
					phase1();
					break;
				case 2:
					phase2();
					break;
				case 3:
					phase3();
					break;
				default:
					phase1();
			}
		}
		
		public function get fightPhase():int
		{
			return _fightPhase;
		}
		
		private function phase1():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			var atks:Array = [demonicArouse,demonfire];
			if (_roundCount % 10 == 3)
			{
				atks.push(rapetacles);
			}
			if (!pc.hasStatusEffect("Blinded"))
			{
				atks.push(wingbuffet);
			}
			atks[rand(atks.length)]();
		}
		
		private function demonicArouse():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("Lethice’s hands blur in a familiar set of arcane motions, similar to the magical gestures you’ve seen from the imps. Hers are a thousand times more intricate. Her slender fingers move with all the precision of a master artist’s brush, wreathed in sparks of black energy. ");
			var l:Number = pc.libido() / 10 + pc.cor() / 10 + 25;
			if (flags["COC.MINOTAURKINGS_TOUCH"] == 1)
			{
				l = l * 1.25;
			}
			applyDamage(new TypeCollection( { psionic : l } ), this, pc);
			if (pc.lustQ() <= 30)
			{
				output("\n\nYou feel strangely warm.");
			}
			else if (pc.lustQ() <= 60)
			{
				output("\n\nBlood rushes to your groin as a surge of arousal hits you, making your knees weak.");
			}
			else if (pc.lustQ() <= 75)
			{
				output("\n\nDespite the dire situation, your mind keeps filling with images of Lethice fully uncovered, her body poised just inches away. You can’t help but want her.");
			}
			else if (pc.lustQ() <= 90)
			{
				output("\n\nThe dark power forces ideas into your mind, thoughts of you on your knees, hands shackled behind you and your mistress’s perfect, pretty pussy in front of you, awaiting your tongue. You barely shake it off.");
			}
			else if (pc.lustQ() <= 100)
			{
				output("\n\nYour mind is filled with visions of lovely pussies, perfect tits, and one overriding emotion - submission. She’s making you want to give up and indulge in her tainted wiles, and the worst part is... you’re having a hard time coming up with a reason not to. You barely pull back from an all-consuming image of her slick, juicy snatch, shaking your head in wonderment. How can you possibly defeat her?");
			}
			else
			{
				output("You give yourself over to the alien imagery invading your mind, wallowing a dozen conflicting fantasies. In one, you’re tied to Lethice’s clit-piercing by a leash, lapping her spilled cunt-juice from the ground. In another, you’re begging her to let you tongue her asshole. Each is more perverse than the last, and they blend together into an endless tableau of submission.");
			}
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (hasPerk("Melee Immune")) addDisabledButton(0, "Attack", "Attack", "She is out of reach!");
			
			if (pc.hasStatusEffect("LethicesRapeTentacles") && pc.energy() >= 15 && (kGAMECLASS.isNineTails(pc) || kGAMECLASS.flags["COC.SPELL_WHITEFIRE"] == 1 && !kGAMECLASS.pc.hasStatusEffect("Silence"))) {
				addButton(10, "BurnTentacles", dispellRapetacles, null, "Burn Tentacles", "Get rid of that tentacles!");
			}
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", grappleStruggle, pc);
				addButton(4, "Do Nothing", grappleWait, pc);
			}
		}
		
		public function processHostileGroupActions():void {
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("LethicesRapeTentacles") && pc.statusEffectv3("LethicesRapeTentacles") > 0 && !(pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) {
				output("\n\nYou are grappled by tentacles, and they are caressing you! ");
				applyDamage(new TypeCollection( { tease : 3 } ), this, pc);
			}
			
			if (pc.hasStatusEffect("PigbysHands") && pc.statusEffectv3("LethicesRapeTentacles") > 0 && !(pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) {
				output("\n\nYou are groped by invisible hands! ");
				applyDamage(new TypeCollection( { tease : 5 } ), this, pc);
			}
		}
		
		private function rapetacles():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("Lethice gestures at the ground underfoot. A pulse of black mist rolls out around you for dozens of feet in every direction. The crowd of watching demons pulls back fearfully, save for a few foolish slaves who blithely step into the magic circle. A second later, hundreds of oily, black tentacles emerge from the floor, unspooling from whatever horrible dimension they were summoned from. They immediately attack every living creature within reach, wrapping around wrists and ankles, violating vaginas and assholes alike. They come at you from every direction!");
			if (pc.canFly())
			{
				output("\n\nYou laugh as you fly out of their reach, immune to their touches.");
				pc.createStatusEffect("LethicesRapeTentacles", 4 + rand(2), 0, 0, 0);
			}
			else if (combatMiss(this, pc, -5, 1.5))
			{
				output("\n\nYou manage to sidestep the grasping tentacles with ease.");
				pc.createStatusEffect("LethicesRapeTentacles", 4 + rand(2), 0, 0, 0);
			}
			else
			{
				output("\n\nYou aren’t fast enough to avoid them. They yank your arms and [pc.legs] taut.");
				if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
					output(" Some are sliding over your [pc.armor], fruitlessly seeking entry to your most sensitive, forbidden places.");
				else output(" Some burrow under your [pc.gear], crawling toward your most sensitive, forbidden places.");
				pc.createStatusEffect("LethicesRapeTentacles", 4 + rand(2), 0, 1, 0);
				pc.createStatusEffect("Grappled", pc.statusEffectv1("LethicesRapeTentacles"), 0, 0, 0); // handles actual grapple
			}
		}
		
		public function dispellRapetacles():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			clearOutput();
			if (pc.statusEffectv3("LethicesRapeTentacles") == 0)
			{
				output("You raise your arm and");
			}
			else
			{
				output("You struggle and manage to raise your arm against the tight grasp of the tentacles, managing to");
			}
			output(" spray forth a torrent of flame, burning the shadowy constructs away in the light of your pure, focused fire. In the span of seconds, Lethice’s spell is gone.");
			output("\n\n");
			
			pc.removeStatusEffect("LethicesRapeTentacles");
			pc.removeStatusEffect("Grappled");
			
			output(kGAMECLASS.onSpellCast(kGAMECLASS.pc));
			kGAMECLASS.pc.energy( -15);
			kGAMECLASS.updatePCStats();
			CombatManager.processCombat();
		}
		
		public function grappleStruggle():void
		{
			clearOutput();
			output("You pull with all your might against the grasping tentacles to no avail; their grip is simply too strong!");
			CombatManager.processCombat();
		}
		
		public function grappleWait():void
		{
			clearOutput();
			output("You can't bring yourself to fight back against Lethice's tentaclespawn. The sensuous, coiling grasp around your limbs, their questing, pliant tips digging around inside your [pc.gear]... you relax in their grip for a little while longer, too enticed by their movement to struggle right now.");
			CombatManager.processCombat();
		}
		
		private function demonfire():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Lethice narrows her eyes, focusing her mind with deadly intent. She snaps her fingers and a gout of black, twisting flames engulfs you! ");
			applyDamage(new TypeCollection( { burning : intelligence() + rand(25) } ), this, pc);
		}
		
		private function wingbuffet():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Lethice flutters toward a burning brazier and flaps her wings, causing the flames to flare and thick gusts of smoke to flow past the assembled demons, straight at you!");
			if (pc.hasBlindImmunity() || pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				output(" You are protected from such attacks!");
			}
			else if (rangedCombatMiss(this, pc))
			{
				output(" You manage to slide under the waves of smoke.");
			}
			else
			{
				output(" The cloying smoke gets in your eyes and your mouth, making you cough and sputter. Worst of all, you can’t see anything! ");
				applyDamage(new TypeCollection( { burning : 1 } ), this, pc);
				pc.createStatusEffect("Blinded", 2, 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
			}
		}
		
		private function claw():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Swooping low, the Demonic Queen takes a swipe at you with claws that are suddenly six inches long and as sharp as razors!");
			if (combatMiss(this, pc))
			{
				output("You manage to dodge her slash!");
			}
			else
			{
				output(" Damn, that hurts! ");
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(0.5);
				applyDamage(damage, this, pc);
			}
		}
		
		public function phase1Ends(hpVictory:Boolean):void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			clearOutput();
			if (hpVictory)
			{
				output("Unable to resist your brutal assault, Lethice lets loose a howl of frustration and swoops back to the earth, mounting her throne once again.");
				//if (pc.canFly())
				//{
					//output("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					//output(" Taking wing yourself, you slam into the demoness, striking a final blow that sends her toppling to the ground. She shrieks and spirals, crashing into the hard stone floor just before her throne.");
				//}
				//else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 1)
				//{
					//output("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					//output(" You draw your bowstring and let loose one last arrow, sending the missile hurtling through the air - and right into Lethice’s wing! The Demon Queen lets out an ear-piercing shriek of pain and, with her wing flopping weakly beside her, goes tumbling to the earth! She’s down!");
				//}
				//else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 2)
				//{
					//output("Unable to resist your arcane assault, Lethice lets loose a howl of frustration and swoops back to the earth, mounting her throne once again.");
				//}
				//else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 4)
				//{
					//output("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					//output(" You draw your bowstring and let loose one last arrow, sending the missile hurtling through the air - and right into Lethice’s wing! The Demon Queen lets out an ear-piercing shriek of pain and, with her wing flopping weakly beside her, goes tumbling to the earth! She’s down!");
				//}
			}
			else
			{
				output("Unable to resist your sensual assault, Lethice lets loose a howl of frustration and swoops back to the earth, mounting her throne once again.");
			}
			output("\n\n<i>“I tire of this game!”</i> she shouts, grasping at the arms of her towering throne. Suddenly, her gaze snaps from you, to the horde of demons clamoring in the stands. <i>“What are you waiting for, fools!? Get " + pc.mf("him", "her") + "!”</i>");
			output("\n\nOh, shit. You look up in time to see a cavalcade of demonic flesh swooping down from on high, bodies practically tumbling one over the other to get at you. The horde takes every physical form imaginable: towering, hulking brutish males, inhumanly curvaceous succubi, and the reverse of both - not to mention hermaphrodites masculine and feminine - and all with every sort of transformation. Bestial creatures, dragon-like incubi, and succubi whose skins range the colors of the rainbow and so, so much more come piling down the throne hall in a ceaseless barrage of flesh and decadence. They won’t stop until they’ve dragged you to the ground and fucked you into submission!");
			HP(maxHP());
			lust(10, true);
			_fightPhase = 2;
			a = "the ";
			short = "demons";
			isPlural = true;
			
			if (hasPerk("Melee Immune")) removePerk("Melee Immune");
			
			pc.shieldsRaw = pc.shieldsMax();
			alreadyDefeated = false;
			CombatManager.continueCombat();
		}
		
		private function phase2():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			var atks:Array = [demonLustMagic, dirtyDancing, hornyPoke, crushingBodies];
			if (rand(10) == 0 && !pc.hasStatusEffect("Blinded"))
			{
				atks.push(bukkakeTime);
			}
			atks[rand(atks.length)]();
		}
		
		private function demonLustMagic():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			var l:Number = pc.libido() / 10 + pc.cor() / 10 + 10;
			if (flags["COC.MINOTAURKINGS_TOUCH"] == 1) l = l * 1.25;
			
			output("Though the front rank of demons are compressed so tight against you by their cohorts that they can’t move, the second and third rings have more than ample room to move their arms about, tracing arcane runes in the air. You know you can resist the lust-magics of a mere demon, but so many at once...");
			if (rand(100) >= pc.libido() / 2)
			{
				output("\n\nYou close your eyes, focusing the entirety of your will inwards. Though a burn of arousal stings your flesh, you keep your mind centered long enough to resist the brunt of the demon's magic. Taking a deep breath, you let out a raging battle cry and shove the horde back, punishing those who dared try to ensorcell you.");
			}
			else if (pc.lustQ() <= 33)
			{
				output("\n\nYou try your hardest to push back the lustful, submissive thoughts that begin to permeate your mind, but against so many concentrated wills... even you can't hold back. You moan as the first hints of arousal spread through you, burning in your loins. What you wouldn't give for a fuck about now! ");
				applyDamage(new TypeCollection( { psionic : l } ), this, pc);
			}
			else if (pc.lustQ() <= 66)
			{
				output("\n\nAt first, you try to think of something else... but in your state, that just ends up being sex: hot, dirty, sweaty fucking surrounded by a sea of bodies. With a gasp, you realize you've left yourself open to the demons, and they're all too happy to flood your mind with images of submission and wanton debauchery, trying to trick you into letting them take you! ");
				applyDamage(new TypeCollection( { psionic : l } ), this, pc);
			}
			else
			{
				output("\n\nYou don't even try to resist anymore -- your mind is already a cornucopia of lustful thoughts, mixed together with desire that burns in your veins and swells in your loins, all but crippling your ability to resist. The demons only add to it, fueling your wanton imagination with images of hedonistic submission, of all the wondrous things they could do to you if you only gave them the chance. It's damn hard not to. ");
				applyDamage(new TypeCollection( { psionic : l } ), this, pc);
			}
		}
		
		private function dirtyDancing():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The demons closest to you are basically pinned between your body and those behind them, all surging forward to get at you - and half of them are being fucked or teased by the laggards, with cocks and over-sized clits thrusting with wild abandon. Nevertheless, the closest demons are just as determined as the others to make you theirs, even if their options are severely limited. So they do what they can: they dance and grind and thrust themselves against you, smearing your [pc.gear] with milk and feminine excitement and musky, salty pre-cum between showing you with ample, soft flesh and hard muscle.");
			if (rand(100) >= pc.libido() / 2)
			{
				output("\n\nYou push back as hard as you can, throwing back the whorish bodies trying to capture your attentions. Several succubi whine and moan at you, pouting that their lustful dances weren't satisfying to you -- like you just insulted them on a personal level. Others are quick to replace them, though, instantly filling the gaps you leave in the crushing tide of bodies.");
			}
			else
			{
				if (pc.lustQ() <= 33)
				{
					output("\n\nYou try and push back, to ignore the lustful bodies and lurid performances going on around you, but the effect they have on you is undeniable -- heat spreads like wildfire through your [skinFurScales], and your [pc.gear] suddenly feels a whole lot less comfortable. ");
				}
				else if (pc.lustQ() <= 66)
				{
					output("\n\nTry as you might to resist, the demons are having an effect on you! Your whole body is flushed with unbidden arousal, burning with lust for the demonic sluts pressing against you. The temptresses are almost enough to want to make you lay down your arms and bend one of them double for a good, hard fuck! ");
				}
				else
				{
					output("\n\nOh gods! The way their bodies undulate, caressing and cumming, moaning as they're fucked from behind and transfer all of that energy to you, makes your body burn with desire. It's almost too much to bear! ");
				}
				var l:Number = pc.libido() / 10 + pc.cor() / 10 + 10;
				applyDamage(new TypeCollection( { tease : l } ), this, pc);
			}
		}
		
		private function hornyPoke():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Several of the demons nearest you have grown immense sets of curling, sharp horns. When they can’t get at you to sexually provoke or hurl magic at you, they’re more than content to just give you an old-fashioned ram!");
			
			var damage:Number = 0;
			for (var i:int = 0; i < 10; i++) 
				if (!combatMiss(this, pc)) damage++;
			
			if (damage == 0)
			{
				output(" You deftly dodge out of the way!");
			}
			else
			{
				output(" Several of the big, stout horns slam into you, given all the more force thanks to the crushing waves of demons pushing them forward. You yelp in pain as they score your flesh! ");
				for (i = 0; i < damage; i++) applyDamage(damageRand(this.meleeDamage().multiply(0.2), 15), this, pc);
			}
		}
		
		private function crushingBodies():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("The sheer weight of a hundred demonic bodies crushing down on you is enough to make you cry out in discomfort, then pain. Are they just trying to crush you to death!?");
			if (combatMiss(this, pc))
			{
				output("\n\nYou drop to the ground, squirming between several of their legs until you get somewhere you can stand again -- this time without breaking your ribs. Howls of frustration and anger echo through the hall, and the horde just comes barreling down on your again!");
			}
			else
			{
				output(" You squirm out of their crushing embrace, trying to crawl away on the ground, but if they can't squeeze you down the demons seem happy to trample you! You scream in alarm and pain as dozens of feet, hooves, claws, and other appendages come crushing down on you! ");
				for (var i:int = 0; i < 10; i++) 
					if (!combatMiss(this, pc))
						applyDamage(damageRand(this.meleeDamage().multiply(0.2), 15), this, pc);
			}
		}
		
		private function bukkakeTime():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Considering how half of the demon host is just getting fucked by whoever’s behind them, it’s just a question of how long they last before the cum starts flowing. The answer just happens to be now! You gasp and gag as the air is suddenly flooded by the reek of potent, virile jizz, and ropes of thick white spunk start flying through the air. This is less of a gank mob and more of an orgy now!");
			
			if (rangedCombatMiss(this, pc))
			{
				output(" You grab the biggest incubus you can find and hide behind him, letting his burly back take the brunt of the demons’ load. He grunts in displeasure, giving you a rough shove back into the demonic gang-bang. <i>“No escape!”</i> ");
			}
			else if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				output(" Your armor keeps it out of your eyes! ");
				applyDamage(new TypeCollection( { tease : 1 + pc.libido() / 30 } ), this, pc);
			}
			else
			{
				output(" You take a huge, fat, musky glob of spunk right to the eyes! You yelp in alarm, trying to wipe the salty, burning demonic cock-cream out, but it's simply too thick! Yuck!");
				applyDamage(new TypeCollection( { tease : 2 + pc.libido() / 15 } ), this, pc);
				pc.createStatusEffect("Blinded", 2 + rand(2), 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
			}
		}
		
		public function phase2Ends(hpVictory:Boolean):void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			clearOutput();
			if (hpVictory)
			{
				output("The last of the demons falls to your [pc.mainWeapon], crumpling into an unconscious lump before you. A few are crawling haplessly away, retreating to the stands with the rest of their fellows - those too timid to fight at all.");
			}
			else
			{
				output("Lethice’s minions have all but turned into an orgy, completely forgetting their original intent, no matter how much their draconic queen screeches for them to attack.");
			}
			output("\n\nWhile the demons are down, and Lethice is still recovering from your first skirmish, you have a much-needed moment to relieve the tensions starting to grow within you. Or you could press the attack, and take the fight to the queen.");
			
			pc.shieldsRaw = pc.shieldsMax();
			clearMenu();
			addDisabledButton(0, "DemonFuck", "Demon Fuck", "This scene requires you to have genitals.");
			addDisabledButton(1, "Recover", "Recover", "This scene requires you to know healing techniques and be wounded.");
			if (pc.hasGenitals()) addButton(0, "DemonFuck", p2DemonFuck, hpVictory);
			if ((pc.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_HEAL) > 0 && pc.HP() < pc.maxHP() || kGAMECLASS.isNineTails(pc) && pc.energy() < pc.energyMax()) addButton(1, "Recover", p2Heal);
			addButton(2, "Next", p2Next);
		}
		
		private function p2DemonFuck(hpVictory:Boolean):void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			clearOutput();
			output("Rather than advance on Lethice, you turn your attention to the pile of demons");
			if (hpVictory)
			{
				output(" lying stunned and helpless");
			}
			else
			{
				output(" who’ve fallen into a frenzied orgy");
			}
			output(" on the floor. One in particular catches your attention: a purple-skinned harlot of an omnibus, with bone-formed high heels and voluptuous breasts and hips and a throbbing canine’s cock swinging between her legs, resting over a positively massive pair of balls, more like what you’d expect to be swinging under a centaur’s shaft. You reach down and grab her by her curling horns, pulling her off the crotch of another demon and pulling your [pc.gear] aside to reveal your own [pc.crotch].");
			output("\n\n<i>“O-oh my!”</i> she purrs, black eyes batting at you as you make your intentions clear. <i>“Here I thought you were saving this for the queen.”</i>");
			output("\n\nYou growl for her to get started, prompting her to slither out a forked tongue to");
			if (pc.hasCock())
			{
				output(" wrap around your [pc.cock]");
			}
			else
			{
				output(" lap across the lips of your [pc.vagina]");
			}
			output(". Shudders of pleasure almost instantly begin to wrack your body, reacting to the demoness’s talented touch. She’s certainly skilled with her tongue, flicking and licking and caressing your sex with vigorous determination. You guide her movements by her demonic horns at first, but soon find yourself too busy gasping and moaning to try and control her - there’s no point, when she’s this good at");
			if (!pc.hasCock())
			{
				output(" munching rug.");
			}
			else
			{
				output(" sucking cock.");
			}
			output("\n\nAround you, spurred on by your face-fucking the omnibus, the defeated demon court undulates in waves of orgiastic pleasure, gleefully sucking each other’s cocks, penetrating any hole they can find, or simply rolling on the floor locked in each other’s sensual embraces. Those that didn’t join the fight hoot and holler from the stands, encouraging you to fuck the omnibus like the eager slut she is. For her part, the horny demon just smirks up at you between long, loving licks across your sex.");
			
			clearMenu();
			addButton(0, "OralFinish", oralFinish);
			addDisabledButton(1, "FuckDemon", "Fuck Demon", "This scene requires you to have cock.");
			if (pc.hasCock()) addButton(1, "FuckDemon", fuckDemon);
			addButton(2, "RideCock", rideCock);
		}
		
		private function oralFinish():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			clearOutput();
			if (pc.hasCock())
			{
				output("You ignore the horde’s jeers, grinding your hips against the omnibus’s face until you feel the tell-tale rise of climax surging through you. Her throat bulges around your [pc.cock] and the load of salty spunk you pour down her gullet, right up until you pull out and give her face a showering for good measure.");
				output("\n\nSated, you give the well-used omnibus a shove back into the demon fuck-pile and ready your [pc.mainWeapon]. Confident in your readiness, you advance on Lethice.");
			}
			else
			{
				output("You disregard the demons’ demands, instead focusing on grinding your hips on the omnibus’s face, slathering her chin and cheeks with slick feminine excitement. She moans in appreciation, wrapping a hand around her over-sized doggy-cock and stroking it furiously to the same rhythm of her tongue’s exploration of your [pc.vagina]. With such single-minded intention, it doesn’t take the demon slut long at all to bring you to a well-deserved climax - and herself as well, spraying a thick, musky rope of cum across your [pc.feet] while you smear her face with orgasmic juices.");
				output("\n\nSated, you give the well-used omnibus a shove back into the demon fuck-pile and ready your [pc.mainWeapon]. Confident in your readiness, you advance on Lethice.");
			}
			pc.orgasm();
			beginPhase3(true);
		}
		
		private function fuckDemon():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			clearOutput();
			output("The demons’ urging tears down your self-control, and with a grunt of effort and desire, you shove the omnibus down on her back. She yelps with surprise, but her fall is cushioned by the massive, milky tits of a cow-girl-turned-demon behind her who’s busily sucking a pair of demonic dongs. Your omnibus recovers from her surprise in a heartbeat, turning it into a luxurious stretch that spreads her pussy-lips open under the hefty, churning weight of her equine-like balls.");
			output("\n\nYou lunge on her the moment you see that vermillion slit opening, driving your [pc.cock] to the hilt inside the sloppy twat and making the omnibus moan with delight. Her canid cock bobs up at full mast, poking at your [pc.chest]");
			if (pc.hasFuckableNipples())
			{
				output(" until you give her a wicked grin and guide the tip inside your [pc.nipple]");
			}
			else
			{
				output(" and smearing your [pc.skinFurScales] with pre");
			}
			output(". You grab her melon-sized tits and squeeze them as hard as you can while you hammer your [pc.hips] forward, taking advantage of the silky-wet vice of her twat to milk yourself to orgasm. She’s practically an ona-hole for you, only able to squirm around and moan while you pound away.");
			output("\n\nSuddenly, your entire body tenses, shivering with new sensation. You look over your shoulder in time to see another succubus crawling up behind you, running her tongue through the crack of your ass");
			if (pc.balls > 0)
			{
				output(" and around your balls");
			}
			else
			{
				output(" down to the base of your cock");
			}
			output(". Another demoness snuggles up behind you, pressing a hefty pair of jugs into your back and murmuring about how she wants to see you breed that hermaphroditic cum-slut under you.");
			output("\n\nWith more and more demons crawling up over you, urging you to cement your victory on their companion or adding to your pleasure with mouths and corrupted tongues, it’s not long before you surrender to your body’s carnal demands. Giving one last, mighty thrust into the omnibus’s twat, you grunt with the surging pleasure of cum swelling through your shaft, spilling out and basting the demoness’s womb. She cries out, bucking her hips against you and quickly following you with a shot of her own");
			if (!pc.hasFuckableNipples())
			{
				output(" that splatters all over your chest");
			}
			else
			{
				output(" right into your tit");
			}
			output("! You give her a reproachful look, still grinding your hips as the aftershocks of orgasm pass.");
			output("\n\n<i>“Not sorry,”</i> she giggles, running a finger around her cum-smeared twat and pushing every spare droplet back in as you pull out. <i>“Mmm, that’ll make for a lovely brood of imps, </i>Champion<i>!”</i>");
			output("\n\nShuddering at the thought, you grab your gear and stagger up and away, leaving the demons to finish each other off. Confident in your readiness, you advance on Lethice.");
			pc.orgasm();
			beginPhase3(true);
		}
		
		private function rideCock():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			clearOutput();
			output("Considering the demons seem intent on having you get down and dirty with their defeated compatriot, you figure you might as well get the most out of the moment. Lethice doesn’t seem to be in any hurry to resume your battle, after all!");
			output("\n\nYou give the buxom demon hermaphrodite down on her ass, letting her rest her head in the lap of another cow-girl demon who’s busy sucking off a two-cock’d incubus, and crawl up her shapely red body. <i>“Oooh,”</i> the omnibus coos as her throbbing red rocket is pressed between your bodies. <i>“Gonna go for a ride, Champion?”</i>");
			output("\n\nDamn right you are. You grab her tits, sinking your fingers into the soft, crimson udders as you straddle her hips and grind your [pc.vagOrAss] against the demon’s tumescent shaft. She’s hung like a stud, rock hard and ready to roll before you even get near her pointed crown. You feel her hands grasp your [pc.hips], guiding you down until your [pc.vagOrAss] is sinking onto her thick rod. Your belly bulges with the sheer length of cockflesh sliding into you, and your mind goes blank with overwhelming pleasure.");
			output("\n\nIt takes you a moment to recover from the initial shock, but when you do, you start moving with a vengeance, bouncing on the demonic doggy-cock with mounting speed. Its owner moans and squirms beneath you, too weakened from your fight to do anything but go along for the ride. Still, her big, black nipples are hard as rocks in your hand, and her pussy soaks both your thighs in her ever-rising excitement.");
			output("\n\nSuddenly, your entire body tenses, shivering with new sensation. You look over your shoulder in time to see another succubus crawling up behind you,");
			if (pc.hasVagina())
			{
				output(" licking at your [pc.vagina]");
			}
			else
			{
				output(" reaching around to give your unused [pc.cocks] a tug. Another demoness snuggles up behind you, pressing a hefty pair of jugs into your back and murmuring about how she wants to see you get bred by that hermaphroditic stud under you.");
			}
			output("\n\nWith more and more demons crawling up over you, urging you to cement your victory on their companion or adding to your pleasure with mouths and corrupted tongues, it’s not long before you surrender to your body’s carnal demands. You grind your hips hard and fast against the demoness’s mis-matched crotch, loving the way her churning black balls ride in your ass, the way her fist-thick knot hammers against your [pc.vagOrAss]. With so many sensations assaulting your body, it’s impossible to hold back. Screaming your ecstasy for the whole hall to hear, you climax, body shuddering and clenching hard around the thick demonic cock spreading you open.");
			output("\n\nThe demoness isn’t far behind. She grabs your hips hard enough that her nails score your flesh, and you feel a rush of sticky, wet heat flooding your");
			if (pc.hasVagina())
			{
				output(" womb");
			}
			else
			{
				output(" bowels");
			}
			output(". You only barely keep your wits about you enough to push her back down before she can force her knot inside you, though you’re treated to a veritable waterfall of white spunk pouring out of your well-bred hole instead.");
			output("\n\n<i>“I can see why they call you ‘Champion,’”</i> the demon purrs as her spunk-slathered red prick flops against her belly. <i>“Maybe after our queen beats you down, I’ll come visit you in the breaking tanks... I could always use another eager little broodmare.”</i>");
			output("\n\nYou shove the demoness away, suddenly reminded of her true nature. At least for now, you’re sated. Confident in your readiness, you advance on Lethice.");
			pc.orgasm();
			beginPhase3(true);
		}
		
		private function p2Heal():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			clearOutput();
			output("No foe dares challenge you during the brief lull in battle, enabling you to maintain perfect concentration.");
			
			if (kGAMECLASS.isNineTails(pc) && pc.energy() < pc.energyMax()) {
				if (pc.hasPerk("Corrupted Nine-tails"))
					output("\n\nTapping the world for it's essence is usual thing for you, but you have no time to do it safe, here and now. Instead of gently touching the flow");
				else if(pc.hasPerk("Enlightened Nine-tails"))
					output("\n\nMeditation is usually a quite long process of attuning to the world's flow, but you have no time to do it right, here and now. Instead of becoming part of the world");
				output(", you violently pull it into yorself, like demons do. You'll have to pay for it soon, but for now you just rush energy through your body, washing away fatigue. By the end you are ready for battle, but also feel much less like flesh and blood...");
				
				if (pc.lustQ() > 50) pc.lust(Math.max(pc.lustMin(), pc.lustMax() / 2), true); // calm a bit
				pc.energy(pc.energyMax()); // and recover energy
			}
			
			
			if ((pc.perkv1("Magic Affinity") & kGAMECLASS.KBIT_SPELL_HEAL) > 0) {
				output("\n\nDrawing on your magic, you use the opportunity to mend your wounds.");
				pc.HP((pc.level + pc.intelligence() / 1.5 + rand(pc.intelligence())) * 2);
			}
			
			CombatManager.showCombatUI();
			output("\n\nFeeling a bit better and ready for battle, you look to Lethice.");
			beginPhase3(true);
		}
		
		private function p2Next():void
		{
			clearOutput();
			output("<i>“Useless whelps,”</i> Lethice growls, rising back to her feet and spreading her");
			if (_wingsDestroyed)
			{
				output(" tattered");
			}
			output(" draconic wings behind herself, letting them flare out to their full majesty. She grabs a whip from her flank and uncoils it with a snap, cracking it just over your head. Black fire seethes on the length of the whip, burning with corrupt magics that make the air reek of sex and desire around her.");
			output("\n\n<i>“Very well, Champion,”</i> she snarls, throwing aside her goblet of Lethicite. The crystals go scattering as the vessel shatters on the flagstone, and in an instant even the defeated demons are scrambling for the gems, making the floor you fight on a rabid hell to walk through. <i>“I see I’ll have to finish you myself! Let us see what you’re really made of... before I rape your soul out of your body!”</i>");
			beginPhase3(false);
		}
		
		private function beginPhase3(doLethNext:Boolean):void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			_fightPhase = 3;
			HP(maxHP());
			lust(10, true);
			_defMode = 1;
			_lastHP = HP();
			_lastLust = lust();
			a = "";
			short = "Lethice";
			isPlural = false;
			
			clearMenu();
			if (doLethNext)
			{
				addButton(0, "Next", p2Next);
			}
			else
			{
				alreadyDefeated = false;
				CombatManager.continueCombat();
			}
		}
		
		private function phase3():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			var atks:Array = null;
			//Determine defense mode // FIXME: no way to do it without heavy core code changes
			if (_lastHP > HP() && rand(3) != 0)
				_defMode = 1;
			else if(_lastLust > lust() && rand(3) != 0)
				_defMode = 2;
				
			//Texts and effects
			if (_defMode == 1) {
				output("Lethice dabs at her injury, then licks her finger, smiling sensually. She seems excited and invigorated. Scales appear over her skin, and her spaded tail swishes back and forth in a blur, too fast to follow.\n\n");
				reflexes(400, true);
				armor.defense = 400;
				
				baseHPResistances.psionic.resistanceValue = -15.0;
				baseHPResistances.drug.resistanceValue = -15.0;
				baseHPResistances.pheromone.resistanceValue = -15.0;
				baseHPResistances.tease.resistanceValue = -15.0;
			}
			else {
				output("Shuddering, the Demon Queen steels herself. Her curves soften visibly as she prepares herself for additional arousing efforts, forgoing physical defense.\n\n");
				reflexes(80, true);
				armor.defense = 2;
				
				baseHPResistances.psionic.resistanceValue = 99.0;
				baseHPResistances.drug.resistanceValue = 99.0;
				baseHPResistances.pheromone.resistanceValue = 99.0;
				baseHPResistances.tease.resistanceValue = 99.0;
			}
			
			_lastHP = HP();
			_lastLust = lust();
			
			if (_roundCount == 5) {
				gropehands();
			}
			else
			{
				atks = [parasiteThrowingStars, whiptrip, sonicwhip];
				if (!pc.hasStatusEffect("Silence") < 0)
				{
					atks.push(whipchoke);
				}
				atks[rand(atks.length)]();
			}
		}
		
		private function parasiteThrowingStars():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			var l:Number = 0;
			output("Lethice retrieves three squirming, star-shaped creatures from beneath her clothes and flings them at you. A split second after they leave her hand, needles burst from their edges!");
			if (rangedCombatMiss(this, pc))
			{
				output(" The living throwing stars whistle by you, barely missing you.");
			}
			else
			{
				l = pc.libido() / 10 + pc.cor() / 10 + 10;
				if (kGAMECLASS.flags["COC.MINOTAURKINGS_TOUCH"] == 1) l = l * 1.25;
				
				
				output(" You can’t avoid them all! One clips you on its way past, ripping into your [pc.skin] and leaving you feeling... flushed and hot in its wake.");
				if (pc.hasCock() && rand(pc.willpower() + 50) < 25) {
					output(" There’s suddenly a dearth of room in the crotch of your [pc.gear], rubbing distractingly and slowing you with added weight. <b>[pc.EachCock] has grown bigger!</b> ");
					for (var i:int = 0; i < pc.cockTotal(); i++) pc.increaseCock(1, i);
				}
				else if (pc.biggestTitSize() <= 0 && rand(pc.willpower() + 50) < 25) {
					output(" The inside of your [pc.gear] is suddenly pressing back on your [pc.nipples]. <b>You’ve grown breasts!</b> That bitch! ");
					Mutator.growTits(pc, 3, pc.breastRows.length, false, 2);
				}
				else if (rand(pc.willpower() + 50) < 25) {
					output(" There’s suddenly a dearth of room in the chest of your [pc.gear]. Your [pc.chest] are expanding, bouncing distractingly and slowing you with the extra weight! ");
					Mutator.growTits(pc, 2, pc.breastRows.length, false, 2);
				}
				
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(0.5);
				damage.add(new TypeCollection( { drug : l } ));
				applyDamage(damage, this, pc);
			}
		}
		
		private function whiptrip():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("Lethice slashes her whip in a wide, low arc.");
			var minDamage:Boolean = false;
			
			if (combatMiss(this, pc)) {
				output(" You jump over it at the last second, the heat singing your [pc.feet]. ");
				minDamage = true;
			}
			else {
				output("You try to avoid it, but the burning weapon catches your [pc.leg], simultaneously scorching your flesh and attempting to pull you off balance. ");
				if (pc.isBiped() && !pc.hasPerk("Resolute") && rand(pc.physique()) <= 25) {
					output("The ground rushes up at you awful fast. Lethice has tripped you, <b>stunning you!</b> ");
					pc.createStatusEffect("Stunned", 1, 0, 0, 0, false, "Stun", "Cannot act.", true, 0, 0xFF0000);
				}
				else
					output("Lethice is going to need to pull a lot harder if she wants to trip you. ");
			}
			
			//all damage as burning
			applyDamage(new TypeCollection( { burning : damageRand(this.meleeDamage().multiply(minDamage ? 0.5 : 2), 15).getTotal() }), this, pc);
		}
		
		private function sonicwhip():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("Lethice raises her sizzling, flame-spitting whip high up overhead, then snaps her arm out and back in an instant, cracking the whip so hard that it gives birth to a shockwave of flame and cacophonous thunder. There’s no avoiding the all-encompassing wave of energy. There’s not even time to brace yourself. It slams into you, rattling bones and scorching flesh. ");
			
			//all damage as burning
			applyDamage(new TypeCollection( { burning : damageRand(this.meleeDamage().multiply(0.75), 15).getTotal() }), this, pc);
		}
		
		private function whipchoke():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("<i>“Silence your prattling, curr.”</i> Lethice strikes out with her whip, aimed at your neck!");
			if (combatMiss(this, pc))
			{
				output(" You barely avoid it.");
			}
			else
			{
				output("\n\nYou gasp when the burning cord encircles your throat, unable to speak and unable to discern why the licking flames haven’t scorched the flesh from your face. Laughing, the queen snaps her end of the whip off like a rotten cord, dropping the burning length to the ground with disdain. The unattached end loops around your neck again and again, binding tight. At the same time, fresh flame boils out of the tightly held handle, revealing a sinuously slithering implement of pain no worse for the wear. ");
				output("\n\n<b>You are effectively silenced!</b> ");
				
				//all damage as burning
				applyDamage(new TypeCollection( { burning : damageRand(this.meleeDamage().multiply(0.25), 15).getTotal() }), this, pc);
				pc.createStatusEffect("Silence", 3, 0, 0, 0, false, "Icon_Silence", "You can't talk!", true, 0);
			}
		}
		
		private function triplestroke():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("Lethice’s arm blurs in figure eights, snapping the whip at you from every sides. You’ll have a tough time avoiding so many strikes!");
			for(var i:int = 0; i < 3; i++)
			{
				if (combatMiss(this, pc))
				{
					output("\n");
					applyDamage(new TypeCollection( { kinetic : damageRand(this.meleeDamage().multiply(0.5), 15).getTotal() } ), this, pc);
				}
				else
				{
					output("\nYou duck and weave, barely managing to avoid a stinging slash from the whip!");
				}
			}
		}
		
		private function gropehands():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("<i>“Let’s see how you fight while you’re being groped, shall we? A shame Pigby isn’t around to see how I’ve improved his hands,”</i> Lethice murmurs. Cupping her hands into a parody of lecher’s grip, the corruptive Queen squeezes and chants. Immediately, you feel phantasmal hands all over your body, reaching through your armor to fondle your bare [pc.skinFurScales]. Digits slip into your [pc.butt]. Fingertips brush your [pc.nipples]. Warm palms slide down your quivering belly toward your vulnerable loins.");
			output("\n\nYou glare daggers at Lethice, but she merely laughs. <i>“A shame I never got to convince him that his hands were so much more effective when used like this.”</i>");
			applyDamage(new TypeCollection( { tease : 5 } ), this, pc);
			pc.createStatusEffect("PigbysHands", 0, 0, 0, 0, true, "", "", true, 0);
		}
	}
}