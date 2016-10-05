package classes.Characters.CoC
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Transformatives.CoCLactaid;
	import classes.kGAMECLASS;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.Util.*;
	
	public class CoCSuccubusGardener extends Creature
	{
		//constructor
		public function CoCSuccubusGardener()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "succubus gardener";
			this.originalRace = "demon";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "This succubus has everything you would expect from one of her kind: a bust that would drive women wild with jealousy, hips that could melt a preacher's conviction, an ass so perfectly rounded that it seems designed to be cupped, and a smoldering visage that simultaneously entices whilst wearing a domineering grin. Her raven hair cascades around ram horns that gleam like polished ivory, and her red eyes greedily drink in your every motion. What clothing she wears is only designed to enhance her rampant sexuality, somehow making her look more naked than if she actually were.\n\nBehind her, the shrubbery itself has come to life, revealing corded vines with inhuman strength, some capped with oozing, phallus-like tips. A few are as thick as your arm and tipped with gasping, swollen lips or violet, blooming pussies. Others still bear no ornamentation at all. There is little rhyme or reason to the mass of vegetation: only a theme of rampant, overgrown sexuality encouraged to an obscene degree.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "lash";
			this.meleeWeapon.longName = "tentacles";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "tentaclothes";
			this.armor.defense = 10;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 100.0;
			baseHPResistances.drug.resistanceValue = 100.0;
			baseHPResistances.pheromone.resistanceValue = 100.0;
			baseHPResistances.tease.resistanceValue = 100.0;
			
			baseHPResistances.poison.resistanceValue = 50.0;
			baseHPResistances.corrosive.resistanceValue = 50.0;
			baseHPResistances.burning.resistanceValue = -50.0;
			baseHPResistances.freezing.resistanceValue = -50.0;
			
			this.level = 20;
			this.XPRaw = bossXP();
			this.credits = (rand(33) + 50) * 10;
			this.HPMod = 600;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 85 / 20 * this.level;
			this.reflexesRaw = 85 / 20 * this.level;
			this.aimRaw = 85 / 20 * this.level;
			this.intelligenceRaw = 100 / 20 * this.level;
			this.willpowerRaw = 100 / 20 * this.level;
			this.libidoRaw = 80;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 100;
			
			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "glowing amber";
			this.tallness = rand(9) + 60;
			this.thickness = 21;
			this.tone = 40;
			this.hairColor = "blond";
			this.scaleColor = "blue";
			this.furColor = "blue";
			this.hairLength = 13;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "blue";
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
			this.wingType = GLOBAL.TYPE_SMALLDEMONIC;
			this.legType = GLOBAL.TYPE_HUMAN;
			this.legCount = 2;
			this.legFlags = new Array();
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_DEMONIC;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_TAILCOCK,GLOBAL.FLAG_SMOOTH,GLOBAL.FLAG_PREHENSILE,GLOBAL.FLAG_LONG];
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
			this.buttRatingRaw = 9;
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
			
			this.breastRows[0].breastRatingRaw = 5;
			this.nippleColor = "cerulean";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 3;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 50;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("TentagrappleCooldown", 10, 0, 0, 0);
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			inventory = [];
			
			_isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			// The succubus gardener is a multistage fight. She starts off all but immune to lust damage. She has enough HP not to be one-shot and a heal move that takes priority over any stun. Once she is reduced to 60% HP, she either drinks from her tentacles or is force-fed by them (if stunned). This fully heals her but makes her 15% more vulnerable to lust.
			
			// Also, the more turned on she gets, the more aggressive she gets.
			
			// Her damage is all lust but in low amounts. This is something of a marathon fight.
			
			if (target.hasStatusEffect("Grappled")) return;
			
			if (hasStatusEffect("TentagrappleCooldown"))
			{
				addStatusValue("TentagrappleCooldown", 1, -1);
				if (statusEffectv1("TentagrappleCooldown") <= 0)
				{
					removeStatusEffect("TentagrappleCooldown");
				}
			}
			
			if (target.hasStatusEffect("Cum Shower"))
			{
				showerDotEffect();
				
				if (target.lustQ() >= 100) return;
			}
			
			if (this.HPQ() <= 60 && energy() > 0)
			{
				vineHeal();
			}
			else if (!hasStatusEffect("TentagrappleCooldown"))
			{
				tentagrapple();
			}
			else if (!target.hasStatusEffect("Gardener Sap") && this.hasStatusEffect("VineHealUsed"))
			{
				sapSpeed();
			}
			else
			{
				var opts:Array = [sicem, corruptiveShower, lustAuraCast];
				
				if (this.lust() <  40) opts.push(taunt);
				if (this.lust() >= 40) {
					opts.push(motorboat);
					opts.push(tasteTheEcstasy);
				}
				
				opts[rand(opts.length)]();
			}
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Grappled")) {
				addButton(0, "Struggle", grappleStruggle);
				addButton(4, "Do Nothing", grappleWait);
			}
		}
		
		public function onCleanup():void {
			cleanupEffects();
		}
		
		private function cleanupEffects():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			if (pc.hasStatusEffect("Grappled")) pc.removeStatusEffect("Grappled");
			if (pc.hasStatusEffect("Cum Shower")) pc.removeStatusEffect("Cum Shower");
			if (kGAMECLASS.pc.hasStatusEffect("Gardener Sap")) {
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv1("Gardener Sap"));
				kGAMECLASS.pc.removeStatusEffect("Gardener Sap");
			}
		}
		
		private function vineHeal():void
		{
			if (!hasStatusEffect("VineHealUsed"))
			{
				createStatusEffect("VineHealUsed", 0, 0, 0, 0);
			}
			
			if (!hasStatusEffect("Stunned"))
			{
				output("Tipping herself backward, the succubus gardener lets herself pitch into the writhing tendrils behind her, her mouth opened welcomingly. The tentacles gently catch her, and rather than ravishing her vulnerable form, they merely gather above her parted lips, dribbling thick flows of pink slime. Her throat bobs as she swallows, her injuries vanishing in seconds. The vines push her back up onto her feet. She's smiling a little dopily.");
				
				if (baseHPResistances.tease.resistanceValue >= 70)
				{
					output(" <b>You aren't sure, but she seems to be leering at you a little more openly.</b>");
				}
				else if (baseHPResistances.tease.resistanceValue >= 40)
				{
					output(" <b>She's definitely leering at you now.</b>");
				}
				else
				{
					output(" <b>There's no disguising the lecherous look on her face while she eye-humps you.</b>");
				}
				
				output(" Whatever is in that healing nectar must be weakening her self-control.");
			}
			else
			{
				output("Acting on some unseen signal, the forest of tentacles lurches into action, surrounding its insensate mistress in a veil of wiggling green. A bundle of slime-dripping vines can be spotted through gaps in the verdant veil, hanging over their demonic caretaker with remarkable care, leaking gooey strands of pink into her mouth. Her throat works to swallow it, and when she emerges a second later, her injuries have vanished and her eyes");
				
				if (baseHPResistances.tease.resistanceValue >= 70)
				{
					output(" are slightly glassy.");
				}
				else if (baseHPResistances.tease.resistanceValue >= 40)
				{
					output(" are even glassier.");
				}
				else 
				{
					output(" are dilated and a little slow.");
				}
				
				output(" Whatever is in that healing nectar must be weakening her self-control.");
			}
			
			
			this.HP(this.maxHP());
			
			baseHPResistances.psionic.resistanceValue -= 30.0;
			baseHPResistances.drug.resistanceValue -= 30.0;
			baseHPResistances.pheromone.resistanceValue -= 30.0;
			baseHPResistances.tease.resistanceValue -= 30.0;
			
			if(IQ() >= 40) {
				intelligence( -intelligenceMax() / 5);
				willpower( -willpowerMax() / 5);
			}
			
			this.energy( -20);
			if (energy() <= 0) { //Exhausted!
				output(" <b>It appears that the vines have run out of pink slime.</b>");
			}
		}
		
		private function tentagrapple():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			createStatusEffect("TentagrappleCooldown", 10, 0, 0, 0);
			
			//Used once every ten rounds
			output("A web of interwoven vines lashes out from behind the succubus, somehow leaving her untouched by the wave of advancing greenery. They're trying to grab you!");
			
			if (combatMiss(this, pc))
			{
				//Dodge
				output(" You slip aside at the last moment, barely avoiding being wrapped in the squirming mass. It snaps back, perhaps at the limits of its reach, leaving you once more eye to eye with the alluring gardener.");
			}
			else
			{
				//Do not dodddddddggggeee
				output(" You twist to the side, but one snags you by the wrist. Another loops around your [pc.leg], and an avalanche of slime-oozing tentacles falls across the rest of you, wrapping you up in snug coils. Their grip is equal parts iron grip and lover's caress. You'd better struggle free before they really start to work on you!");
				pc.createStatusEffect("Grappled", 4, 0, 0, 0, false, "Icon_Constricted", "You are entangled by tentacles!", true, 0, 0xFF0000);
			}
		}
		
		public function grappleStruggle():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			clearOutput();
			
			var numRounds:Number = pc.statusEffectv1("Grappled");
			
			if (rand(pc.physique()) > this.physique() / (1 + (numRounds / 2)))
			{
				output("You scrabble desperately against the tentacles enveloping your body, pulling against the cast-iron grip around your limbs. You tug against them again and again, and with one final mighty heave, you slip free of their grasp!");
				
				pc.removeStatusEffect("Grappled");
			}
			else
			{
				output("You scrabble desperately against the tentacles enveloping your body, pulling against the cast-iron grip around your limbs. You tug against them again and again");
				
				if (rand(2) == 0)
				{
					output(", but the vines encircling you squeeze you tighter, twisting and sliding across your [pc.skinFurScales] as they press more tightly around you. It gets hard to breathe, but at the same time, some of them are inside your [pc.gear], gliding across your most sensitive places with oiled ease that's made all the more arousing by the force behind it.");
				}
				else
				{
					output(". You're intimately aware of the vegetative masses pressing down on you from every angle, lavishing you with attentions so forceful that they threaten to squeeze the very breathe from your body. It's impossible to ignore. You do your best to breathe and ignore the undulated affections, but even you can't deny the way that it makes your heart beat faster.");
				}
				
				pc.addStatusValue("Grappled", 1, 1);
				
				var damage:Number = 75 + rand(15);
				var teaseDam:Number = 3 + rand(3);
				if (flags["COC.PC_FETISH"] >= 2) teaseDam += 5;
				applyDamage(new TypeCollection( { kinetic : damage, tease : teaseDam } ), this, pc);
			}
			CombatManager.processCombat();
		}
		
		public function grappleWait():void
		{
			clearOutput();
			squeeze();
		}
		
		private function squeeze():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			if (rand(2) == 0)
			{
				output("The vines encircling you squeeze you tighter, twisting and sliding across your [pc.skinFurScales] as they press more tightly around you. It gets hard to breathe, but at the same time, some of them are inside your [pc.gear], gliding across your most sensitive places with oiled ease that's made all the more arousing by the force behind it.");
			}
			else
			{
				output("You're intimately aware of the vegetative masses pressing down on you from every angle, lavishing you with attentions so forceful that they threaten to squeeze the very breathe from your body. It's impossible to ignore. You do your best to breathe and ignore the undulated affections, but even you can't deny the way that it makes your heart beat faster.");
			}
	
			pc.addStatusValue("Grappled", 1, 1);
			
			var damage:Number = 75 + rand(15);
			var teaseDam:Number = 3 + rand(3);
			if (flags["COC.PC_FETISH"] >= 2) teaseDam += 5;
			applyDamage(new TypeCollection( { kinetic : damage, tease : teaseDam } ), this, pc);
			CombatManager.processCombat();
		}
		
		private function sicem():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Jiggling oh so pleasantly, the gardener twirls and points in your direction. <i>“Sic 'em, pets!”</i> There is no time for a retort, only a wave of unrelenting greenery lashing in your direction!");
			//Ten very low damage attacks.
			// Geddynote- opted to convert to a lust-inducing attack, because LITERALLY EVERYTHING ELSE she does is lust-based.
			
			var damage:Number = 0;
			
			for (var i:int = 0; i < 10; i++)
			{
				if (!combatMiss(this, pc))
				{
					damage += 2 + rand(1 + pc.libido() / 20) + rand(1 + pc.cor() / 20); // originally sens, not cor
				}
			}
			
			if (damage >= 0)
			{
				output(" The sinuous plant-based tentacles lash at you like a dozen tiny whips! Preparing for stinging pain, you're somewhat taken aback when they pull back at the last moment, sensually caressing your most sensitive places!");
				applyDamage(new TypeCollection( { tease : damage } ), this, pc);
			}
			else
			{
				output(" The sinuous plant-based tentacles strike at you like a dozen tiny whips, but, somehow, you manage to avoid every single one of their lashes!");
			}
		}
		
		private function corruptiveShower():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The succubus lifts her hands up in the air, saying, <i>“Why not taste a sampling of the pleasures I offer?”</i> Above her, a canopy of corrupt, snarled greenery forms, oozing unmistakable sexual fluids - both male and female. Splatters of jism and pussy juice fall like curtains of corruptive rain, their scent lacing the air with their heady musk.");
			
			if (pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output(" Well, you guess that it should be - nothing can seep inside your armor!");
			}
			else if (combatMiss(this, pc))
			{
			//Dodge
				output(" Somehow, you manage to twist out from under the organic raincloud without getting stained by a single drop, though your breath has quickened, and not just from the physical effort.");
			}
			else
			{
				//Fail
				if (!pc.hasStatusEffect("Cum Shower"))
					pc.createStatusEffect("Cum Shower", 3, 0, 0, 0, false, "Icon_Splatter", "You are covered with sexual fluids!", true, 0, 0xFF0000);
				else
					pc.addStatusValue("Cum Shower", 1, 3);
				
				output(" You try your best to avoid the onslaught of off-white, but your efforts are in vain. Slick wetness splatters into and around you, making the ground itself so slippery that you nearly topple over. Unfortunately, the treacherous footing gives the gardener's plants plenty of time to work their foul work, layering you mixed slime until you're dripping. You groan in disappointment and building arousal, uncomfortably aware of the way the juices are exciting you as you they soak into your skin.");
				kGAMECLASS.applyCumSoaked(pc);
				kGAMECLASS.applyPussyDrenched(pc);
			}
		}
		
		private function showerDotEffect():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			pc.lust(2 + rand(2));
			
			pc.addStatusValue("Cum Shower", 1, -1);
			
				//Dot effect
			if (pc.lustQ() < 50) output("The tentacles' sex-juices are still covering you - still slowly arousing you. You've got a good handle on it for now.\n\n");
			else if (pc.lustQ() < 60) 
			{
				output("You try to wipe some of the fragrant seed from your palm, but all you succeed in doing is smearing it into your [pc.hips].");
				if (pc.cor() < 50) output(" You're ashamed");
				else output(" You're a little irritated"); 
				output(" to admit that it's starting to feel really good.\n\n");
			}
			else if (pc.lustQ() < 70)
			{
				output("You groan at the warm slipperiness enveloping your [pc.skinFurScales] as the tainted tentacles' fluids go to work on you. There's nothing you can do but try to endure it. If only it didn't feel so... hot to be drenched in. If you wind up losing, you hope she'll do this again....\n\n");
			}
			else if (pc.lustQ() < 80)
			{
				output("You whimper as the insidious plant-sperm works on your vulnerable [pc.skinFurScales], building pernicious desires in tiny, insistent increments. It's getting harder to focus... harder not to think about how good all those tentacles would feel in you and on you, caressing your most intimate places.\n\n");
			}
			else if (pc.lustQ() < 90)
			{
				output("You shudder in place, stumbling dazedly as your ardor rises to a fever pitch. Soon, you're going to wind up too turned-on to resist, and when that happens, those tentacles are going to take you. The worst part? It's starting to sound really, really... really good to you. Not struggling, no tension... just giving in to what your body craves and loving it.\n\n");
			}
			else if (pc.lustQ() < 100)
			{
				output("Ohhhh, you're close now. You can feel the need hammering inside of you, soaking in through your [pc.skinFurScales] to stoke the fires between your [pc.legs] into a blazing inferno, one you couldn't resist even if you wanted to. Then... then you'll be free to cum. You shake your head. Gotta hold it together");
				if (pc.hasCock())
				{
					output(", even while your rigid cock" + ((pc.cocks.length > 1) ? "s are":" is") + " drizzling ropes of pre unimpeded.");
				}
				else if (pc.hasVagina())
				{
					output(" soaked twat threatens to " + ((pc.wetness() == 4) ? "drown" : "further soak") + " your [pc.legs].");
				}
				else output(".");
			}
			else
			{
				output("Ohhh fuck, there's no holding it back now. You're gonna do it, and there's nothing you could do it stop it even if you wanted to. You're going to drop to your knees and take off your [pc.gear]. You're going to give this beautiful demoness what she wants. You're going to let her fuck you and use you, just so long as she allows you to cum. You'll be fine once you cum, even if it means throwing away a chance to defeat Lethice.\n\n");
				return;
			}
			
			if (pc.statusEffectv1("Cum Shower") <= 0)
			{
				pc.removeStatusEffect("Cum Shower");
				output("<b>The lust-inducing effects of the plant-spunk feel like they've dissipated...</b>\n\n");
			}
		}
		
		private function taunt():void
		{
			output("<i>“How do you expect to defeat me, [pc.name],”</i> the green-thumbed temptress asks with a quirk of her head. <i>“You are but one, and we are many. You have the frailties and weaknesses of a soul. I have power and experience beyond your comprehension. What is there for you to do but willingly submit?”</i> She purses her puffy lips, thinking. <i>“If you submit willingly, I'll allow you to lay your head between my breasts while my plants feed on you. It'll be quite the experience.”</i>");
		}
		
		private function motorboat():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("<i>“Oh fuck it,”</i> the demoness growls, stalking forward. <i>“We both need this, don't we, pet?”</i> She slips inside your guard, pressing her pendulous melons against your face");
			
			if (pc.tallness <= this.tallness - 6) output(", somehow short enough in spite of the height differences.");
			else if (pc.tallness >= this.tallness + 6) output(", somehow tall enough in spite of the height differences.");
			
			output(" They're so soft and pillowy that you can't help but enjoy the feel of them on your skin, and you take a deep, contented breath before remembering where you are and struggling out of the creamy valley.");
			
			output("\n\nYour foe giggles, favoring you with a blown kiss. Her nipples are obviously a little harder,");
			applyDamage(new TypeCollection( { tease : 2 + libido() / 20 + cor() / 25 } ).rand(), pc, this);
			output(" but then again, so are yours.");
			applyDamage(new TypeCollection( { tease : 2 + pc.libido() / 20 + pc.cor() / 25 } ).rand(), this, pc);
		}
		
		private function sapSpeed():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			//Used once after first orgasm
			// 9999 wot orgasm -- gonna assume it's used the heal at least once
			
			output("Cupping her breasts under the cover of her tentacular minions, the gardening succubus coos, <i>“Slow down a little and enjoy the sights, why don't you?”</i> She squeezes, and arcs of glittering milk (or is that sap?) erupt from her elongated nipples, spraying out in continuous streams towards your [pc.feet]. You try to evade at the last second, but the streams follow you every which way, eventually coating you in a layer amber milk-sap.");
			
			output("\n\nThe lactic adhesive effectively slows your movements. You won't be dodging around quite so nimbly anymore, but at least you get to watch the succubus moan and twist, kneading the last few golden droplets from her engorged tits. She licks a stray strand from her finger while watching you, smiling. <i>“Ready to give up yet?”</i>");
			
			// 20%?
			var speedSapped:Number = int(pc.reflexes() * 0.2);
			pc.reflexes( -speedSapped);
			pc.createStatusEffect("Gardener Sap", speedSapped, 0, 0, 0, false, "Icon_Slow", "Your movements are slowed down by sticky sap.", true, 0, 0xFF0000);
		}
		
		private function lustAuraCast():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The demoness blinks her eyes closed and knits her eyebrows in concentration.  The red orbs open wide and she smiles, licking her lips.   The air around her grows warmer, and muskier, as if her presence has saturated it with lust.");
			if (this.statusEffectv1("Lust Aura")) 
			{
				output("  Your eyes cross with unexpected feelings as the taste of desire in the air worms its way into you.  The intense aura quickly subsides, but it's already done its job.");
				
				applyDamage(new TypeCollection( { psionic : 8 + pc.libido() / 20 + pc.cor() / 25 } ), this, pc);
			}
			else 
			{
				createStatusEffect("Lust Aura", 0, 0, 0, 0, false, "Icon_LustUp", "She is surrounded by aura of lust.", true, 0, 0x00FF00);
			}
		}
		
		private function tasteTheEcstasy():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			//Strength check based lust damage, used when aroused only.
			output("Three tentacles stab out at you like organic spears, but you easily evade them... directly into the succubus' arms! Too late, you realize that the offensive was a feint! Her tremendous tits are pressing into your back, and you feel a trickle of wetness leaking down your [pc.leg] as she grinds against you. At the same time, she whispers into your ear, <i>“Just have a taste... sample the ecstasy. You'll see that indulging is the best thing you could possibly do.”</i>");
			
			output("\n\nOne of those tentacles is above you now, and it points down, its phallic shape clear. The slit at the end spreads open, and a blob of whitish goo appears. ");
			
			//Fail strength check!
			if (pc.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("\n\nIt hangs there for a moment before spraying you with the undoubtedly drugged jism. Good thing that your armor is watertight...");
			}
			else if (rand(pc.physique() - 30) + 30 > this.physique())
			{
				output("\n\nIt hangs there for a moment while the succubus yanks your mouth open, just in time to receive the undoubtedly drugged jism. It practically sizzles on your tongue, tasting of almonds and walnuts with a distinctly fruity aftertaste. Your mouth gulps it down automatically, and with slow-dawning comprehension, you understand how the succubus could be so obsessed with these plants. Your groin heats eagerly as the plant spunk absorbs into your system. Your pupils dilate. Gods, it feels good!");
				
				output("\n\nYou barely even realize that the temptress has stepped away. How can you fight this?");
				applyDamage(new TypeCollection( { psionic : 8 + pc.libido() / 20 + pc.cor() / 25 } ), this, pc);
				pc.cor(5);
			}
			else
			{
				//Succeed strength check
				output("\n\nThat's all the warning you need to redouble your efforts. Riding high on a surge of adrenaline, you tear your way out of the temptress' bonds before she can feed you any more corruption.");
				output("\n\nShe pouts. <i>“Come on, just a taste!”</i>");
			}
		}
	}
}