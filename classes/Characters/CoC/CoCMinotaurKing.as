package classes.Characters.CoC
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.CoCGodMeadPro;
	import classes.Items.Melee.CoCMinotaurAxe;
	import classes.Items.Miscellaneous.CoCMinotaurCum;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.CoCMinotaurBlood;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	
	public class CoCMinotaurKing extends CoCMinotaur
	{
		//constructor
		public function CoCMinotaurKing()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "minotaur king";
			this.originalRace = "minotaur";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "OVERRIDED";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon = new EmptySlot();
			this.meleeWeapon.attackVerb = "cleave";
			this.meleeWeapon.longName = "axe";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.armor = new EmptySlot();
			this.armor.longName = "rags";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 95.0;
			baseHPResistances.drug.resistanceValue = 95.0;
			baseHPResistances.pheromone.resistanceValue = 95.0;
			baseHPResistances.tease.resistanceValue = 95.0;
			
			baseHPResistances.kinetic.resistanceValue = 0.0;
			baseHPResistances.electric.resistanceValue = 0.0;
			baseHPResistances.poison.resistanceValue = 20.0;
			baseHPResistances.corrosive.resistanceValue = 0.0;
			baseHPResistances.burning.resistanceValue = 0.0;
			baseHPResistances.freezing.resistanceValue = 0.0;
			
			this.XPRaw = 250;
			this.level = 22;
			this.credits = (75 + rand(50)) * 10;
			this.HPMod = 850;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 100 / 20 * this.level;
			this.reflexesRaw = 50 / 20 * this.level;
			this.aimRaw = 50 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 60 / 20 * this.level;
			this.libidoRaw = 66;
			this.energyRaw = 100;
			this.lustRaw = 30;

			this.femininity = 0;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "glowing amber";
			this.tallness = 12 * 14;
			this.thickness = 100;
			this.tone = 100;
			this.hairColor = "brown";
			this.scaleColor = "";
			this.furColor = "brown";
			this.hairLength = 3;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "light brown";
			this.skinFlags = new Array();
			
			this.faceType = GLOBAL.TYPE_BOVINE;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_BOVINE;
			this.lipMod = 1;
			this.earType = GLOBAL.TYPE_BOVINE;
			this.antennae = 0;
			this.antennaeType = 0;
			this.horns = 2;
			this.hornType = GLOBAL.TYPE_BOVINE;
			this.hornLength = 13;
			this.armType = GLOBAL.TYPE_BOVINE;
			this.gills = false;
			this.wingType = 0;
			this.legType = GLOBAL.TYPE_BOVINE;
			this.legCount = 2;
			this.legFlags = new Array();
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_BOVINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG];
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
			this.createCock(24);
			this.shiftCock(0, GLOBAL.TYPE_EQUINE);
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.balls = 2;
			this.ballSizeRaw = 20;
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballFullness = 100;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 90;
			this.cumMultiplierRaw = 15;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 9999;
			this.minutesSinceCum = 9000;
			this.timesCum = 4182;
			this.cockVirgin = false;
			this.vaginalVirgin = true;
			this.analVirgin = true;
			this.vaginas = new Array();
			//Goo is hyper friendly!
			this.elasticity = 2;
			//Fertility is a % out of 100. 
			//this.fertility = 0;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "brown";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 200;
			
			//this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Stun Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BIG_BREASTS,	GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			this._lastSpellCastCount = kGAMECLASS.pc.perkv3("Magic Affinity");
			inventory = [new CoCGodMeadPro()];
			
			_isLoading = false;
		}
		 
		private var _milkDrinks:int = 0;
		
		private var _orgasms:int = 0;
		
		private var _lastRoundStun:Boolean = false;
		
		private var _lastSpellCastCount:int;
		
		private var excelliaHP:int = 700; //If knocked out, she won't be able to provide more milk.
		
		override public function get long():String
		{
			var str:* = null;
			if (_orgasms == 0)
			{
				return "Positioned between you and the Demon Queen is an opponent of singular size and stature - the Minotaur King. He is a beast beyond measure, covered in shaggy fur and a few scraps of leather that do nothing to hide the pillar of flared cuntplow between his legs. In his hands is a gigantic axe, though he seems loathe to use it, preferring to rely on the erotic scent emanating from between his legs. He smells virile, strong, and more alluring than you’d expect. You’d best be careful not to dwell on it.";
			}
			str = "Still standing between you and the Demon Queen, the Minotaur King is breathing heavily. His cock is slathered with the residue of his own potent orgasm. His immense, 14 foot tall form hunches slightly as he stares at you, one hand still clutching to his axe. Driving him back to his peak would undoubtedly push him even beyond his considerable endurance. The only problem is that alluring <i>aroma</i> that surrounds him, suffusing the air with the scent of sweaty bedroom romps and sizzling pleasure. You better finish him quick.";
			if (lust() < 40)
			{
				str += "\n\nBeneath his legs is a favorite slut, Excellia by name. She stays just out of his way, showcasing the curvaceous nature of her figure and the ripeness of her sex, occasionally running her fingers across a strange tattoo laid upon her belly. You’d best keep your attentions on the fight ahead.";
			}
			else if (lust() < 80)
			{
				str += "\n\nBeneath his legs is the fallen form of his favored slut, Excellia. He steps carefully around the insensate cow-girl but never lets her out of arm’s reach, his eyes flicking to the moistness of her sex from time to time.";
			}
			else
			{
				str += "\n\nBeneath his legs is the creampied form of his favored slut, Excellia. Milk-white cum puddles between her spread legs, matched only by the sheen of leaking lactose on her lewdly-jutting nipples. Her lord never lets her fallen form out of arm’s reach, just in case he needs a drink.";
			}
			
			if (_milkDrinks != 0)
			{
				if (_milkDrinks == 1)
				{
					str += "\n\n<b>The King has been glancing appreciatively in your direction ever since he took a drink from his slave-slut’s nipples. Perhaps he’s more vulnerable to baser needs...</b>";
				}
				else if (_milkDrinks < 10)
				{
					str += "\n\n<b>The King’s nostrils flare as he stares at you. It’s clear that with every drink he takes from his slave-slut’s nipples, he becomes more receptive to your advances.</b>";
				}
				else {
					str += "\n\n<b>The King's belly looks swollen, clearly full of the milk of his slut. It looks like he won't be able to drink any more milk.</b>";
				}
			}
			
			if (excelliaHP <= 0) {
				str += "\n\n<b>Excellia appears to be unconscious due to the injuries you've inflicted to her.</b>";
			}
			return str;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var atks:Array = null;
			if (_lastRoundStun)
			{
				_lastRoundStun = false;
				if (target.hasStatusEffect("Stunned") && !(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)))
				{
					dickslap();
					return;
				}
			}
			if (_lastSpellCastCount != kGAMECLASS.pc.perkv3("Magic Affinity"))
			{
				_lastSpellCastCount = kGAMECLASS.pc.perkv3("Magic Affinity");
				headbutt();
			}
			else
			{
				atks = [backhand, battleaxe, minoPheromones];
				atks[rand(atks.length)]();
			}
		}
		
		public function postHostileTurnActions():void {
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) return;
			output("\n\n<b>The smell of the minotaur pheronome is intense, turning you on. You should try to deal with him as soon as possible.</b>");
			applyDamage(new TypeCollection( { pheromone : 2 } ), this, pc);
		}
		
		public function get orgasms():int
		{
			return _orgasms;
		}
		
		public function get milkDrinks():int
		{
			return _milkDrinks;
		}
		
		private function backhand():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			output("Feinting with his axe, the Minotaur King flings a powerful backhand in your direction.");
			if (combatMiss(this, pc))
			{
				output(" Luckily, you dodge aside.");
			}
			else
			{
				output(" Damn, that hurts! ");
				applyDamage(new TypeCollection( { kinetic : physique() / 2 }, DamageFlag.CRUSHING ), this, pc);
			}
		}
		
		private function headbutt():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("<i>“Settle down,”</i> the brute growls, moments before attempting to slam his forehead into your own.");
			if (combatMiss(this, pc))
			{
				output(" Luckily, you dodge aside.");
			}
			else
			{
				_lastRoundStun = true;
				output(" He impacts with stunning force, leaving you reeling! ");
				applyDamage(new TypeCollection( { kinetic : physique() / 2 }, DamageFlag.CRUSHING ), this, pc);
				
				if (!pc.hasPerk("Resolute"))
				{
					output(" <b>You're left stunned by the force of the blow!</b>");
					pc.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
				}
			}
		}
		
		private function dickslap():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Before you can completely regain your wits, the brute is on you, easily holding your hand in one hand while he none-too-gently smacks his cock into your [pc.face], dragging his musky member back and forth across your cheeks before finally breaking contact.");
			if (_orgasms > 0)
			{
				output(" Strands of his");
				if (pc.hasPerk("Minotaur Cum Addict"))
					output(" god-like");
				output(" spunk hang from your nose until your [pc.tongue] lashes out to collect them.");
				if (pc.hasPerk("Minotaur Cum Addict"))
					output(" Delicious.");
				else
					output(" Why did you do that? And why did it feel so good?");
			}
			
			applyDamage(new TypeCollection( { drug : 15 + pc.libido() / 20 } ), this, pc);
		}
		
		private function battleaxe():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The Minotaur King carries his axe as if it weighed no more than a feather, brandishing it back and forth with such casual movements that you barely register his swing");
			if (combatMiss(this, pc))
				output(" in time to avoid it.");
			else {
				output(". By the time you notice, it’s too late. ");
				var damage:TypeCollection = this.meleeDamage();
				applyDamage(damage, this, pc);
			}
		}
		
		public function hpRestore():void
		{
			HP(maxHP());
			baseHPResistances.psionic.resistanceValue -= 15.0;
			baseHPResistances.drug.resistanceValue -= 15.0;
			baseHPResistances.pheromone.resistanceValue -= 15.0;
			baseHPResistances.tease.resistanceValue -= 15.0;
			
			lust(2);
			_milkDrinks++;
			output("Staggering back, the King wastes no time in appropriating his willing slave, lifting her up to his face as easily as one might heft a stein of fresh-brewed beer. One of her huge tits easily fits against the oversized minotaur’s lips, and you see him noisily gulping down a quick, milky pick-me-up. By the time he finishes, his wounds are closing, but his cock is twitching and leaking pre-cum like water from a sieve.");
			output("\n\n<b>He looks like he’d be easier to arouse. Whatever’s in her milk may restore his wounds, but leave him vulnerable to his animalistic needs.</b>");
			if (_milkDrinks >= 10) output("\n\n<b>It looks like the King's belly has completely swollen, too full to take any more milk.</b>");
			output("\n");
			
			CombatManager.continueCombat();
		}
		
		private function minoPheromones():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The minotaur smiles at you and lifts his loincloth, flicking it at you.  Thick ropes of pre-cum fly through the air, ");
			if (pc.hasArmor() && pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))
			{
				output("splattering over your airtight armor.  ");
				applyDamage(new TypeCollection( { tease : pc.libido() / 20 + 1 } ), this, pc);
				return;
			}
			else if (rand(3) == 0)
			{
				output("slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ");
				if (pc.lustQ() > 75)
				{
					output("swallowing it into your mouth without thinking.  ");
					applyDamage(new TypeCollection( { drug : 15 + pc.libido() / 10 } ), this, pc);
				}
				else
				{
					output("feeling your heart beat with desire as your [pc.tongue] licks the residue from your lips.  ");
					applyDamage(new TypeCollection( { drug : 7.5 + pc.libido() / 20 } ), this, pc);
				}
			}
			else
			{
				output("right past your head.  ");
			}
			output("The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin. ");
			applyDamage(new TypeCollection( { pheromone : 15 + pc.libido() / 20 } ), this, pc);
			
			if (pc.hasPerk("Minotaur Cum Addict") || kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_STATE"] == 2)
			{
				if (rand(2) == 0)
				{
					output("\n<b>You shiver with need, wanting nothing more than to bury your face under that loincloth and slurp out every drop of goopey goodness.</b> ");
				}
				else
				{
					output("\n<b>You groan and lick your lips over and over, craving the taste of him in your mouth.</b> ");
				}
				applyDamage(new TypeCollection( { tease : 5 + rand(5) } ), this, pc);
			}
		}
		
		public function lustDump():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			_orgasms++;
			output("The incredibly-aroused minotaur staggers, then looks down at the log of tumescence between his legs. It’s twitching, bouncing in the air with every beat of his heart. It must ache to be that hard, to be so full of lust it looks ready to erupt. One of his hands reaches toward it, and he drops to one knee. Have you done it? Have you defeated the brute once and for all?");
			output("\n\nA monstrous hand closes around Excellia’s torso, lifting her into the air. The curvy cow-slut does the only thing she can in such a situation - she moos and spreads her legs, a gleeful smile plastered across her excited visage. The Minotaur King doesn’t wait a second, impaling her on the spot, sliding what looks like three feet of virile cock deep into his favorite slut. His balls slap against her bulging belly once he’s fully inside, getting a coating of pussy-juice for their trouble.");
			output("\n\nThe brute fucks her casually, using her like little more than a super-sized sex-toy. Every sheath-hilting clap of hips to ass sends jiggles through the nubile slave. Flecks of pussy-juice and pre-cum froth around the entrance to her gaped cunt while stray droplets slick the floor below. It’s a bestial mating, the kind that leaves no room for words on either partner’s face. The kind that has the cow-girl quivering and shaking in the throes of indescribable ecstasy, rendered incapable of something as simple as moaning.");
			output("\n\nExcellia’s master joins her a second later. There’s little change in the sound of his grunts. You wouldn’t even know if it wasn’t for the sudden ballooning of her belly and the cascade of cum between her legs, coating her lord’s legs in a veneer of lusty white. The amount of spunk is absolutely gobsmacking. You watch in awe as Excellia’s formerly taut belly stretches into a gravid dome. She looks like she could give birth any moment now, yet there’s nothing in her womb but gallon upon gallon of tainted minotaur spunk.");
			if (pc.hasPerk("Minotaur Cum Addict") || kGAMECLASS.flags["COC.MINOTAUR_CUM_ADDICTION_STATE"] == 2)
			{
				output(" You’re jealous. All that cum must feel exquisite!");
			}
			output("\n\nWhatever spell this forceful mating cast, it breaks the moment Excellia slides off her lord’s still-hard phallus. You close your mouth and ready your grip on your [pc.mainWeapon] as the Minotaur King straightens, breathing heavily. He looks a little woozy for the effort, but still good to fight. Maybe if you can bring him back to the peak, he’ll fall for good?");
			output("\n");
			lust(0, true);
			
			CombatManager.continueCombat();
		}
		
		private function cowslutTeaseCocks():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			var sel:int = 0;
			if (pc.hasCock())
			{
				sel = rand(3);
				if (sel == 0)
				{
					output("Excellia crawls over to you while you’re distracted with her lord and wraps her arms around your waist, crushing her milk-swollen tits against your crotch. You can feel their warmth through your [pc.gear], promising nothing but bliss in their embrace. When you push her away, you become aware of the rivers of milk she poured down your");
					if (pc.isNaga())
					{
						output(" [pc.leg]");
					}
					else
					{
						output(" [pc.legs]");
					}
					output(", a reminder of the woman’s insane fuckability.");
				}
				else if (sel == 1)
				{
					output("Turning about, the cow-slave aims her bubbly ass in your direction and lifts her tail, revealing both her dripping delta and the puckered star of her asshole. She looks back over her shoulder and sensuously slides her tongue across her gold-gilt lips, blowing you a pouty kiss once her mouth is suitably shiny. If she meant to distract you, she was at least partially successful.");
				}
				else
				{
					output("Excellia rises up onto her knees and arches her back to display her monumental mammaries, letting their chocolatey nipples jut accusingly in your direction. Her fingers travel to them, squeezing out thin flows of milk that she gathers and smears across each orb in turn, rubbing it into her skin like high-grade massage oil. When she’s finished, her tits are shining, and you’re a little hotter under the collar.");
				}
				applyDamage(new TypeCollection( { tease : 5 } ), this, pc);
			}
		}
	}
}