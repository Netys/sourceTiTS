package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCJeweledRapier;
	import classes.Items.Miscellaneous.*;
	import classes.kGAMECLASS;
	
	
	public class CoCEncapsulationPod extends Creature
	{			
		//constructor
		public function CoCEncapsulationPod()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "pod";
			this.originalRace = "fungus";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "";
			this.customDodge = "";
			this.customBlock = "";
			
			isLustImmune = true;
			
			this.meleeWeapon.attackVerb = "pod";
			this.meleeWeapon.longName = "pod";
			this.meleeWeapon.attackNoun = "pod";
			
			this.armor.longName = "covering";
			this.armor.defense = 4;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.burning.resistanceValue = -50.0;
			baseHPResistances.freezing.resistanceValue = -25.0;
			baseHPResistances.kinetic.resistanceValue = 25.0;
			baseHPResistances.poison.resistanceValue = 100.0;
			
			this.level = 12;
			this.XPRaw = bossXP();
			this.credits = 0;
			this.HPMod = 150;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 100 / 20 * this.level;
			this.reflexesRaw = 0 / 20 * this.level;
			this.aimRaw = 0 / 20 * this.level;
			this.intelligenceRaw = 0 / 20 * this.level;
			this.willpowerRaw = 0 / 20 * this.level;
			this.libidoRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 40;
			this.personality = 100;

			this.femininity = 5;
			this.eyeType = 0;
			this.eyeColor = "red";
			this.tallness = 120;
			this.thickness = 50;
			this.tone = 50;
			this.hairColor = "none";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 0;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = 0;
			this.skinTone = "purple";
			this.skinFlags = new Array();
			
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 2;
			this.antennaeType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = 0;
			this.gills = false;
			this.wingType = 0;
			this.legType = 0;
			this.legCount = 0;
			this.legFlags = new Array();
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
			this.hipRatingRaw = 0;
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
			this.buttRatingRaw = 0;
			//No dicks here!
			this.cocks = new Array();
			//balls
			this.balls = 0;
			this.cumMultiplierRaw = 0;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 0;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 0;
			this.ballFullness = 0;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 0;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 0;
			this.minutesSinceCum = 9999;
			this.timesCum = 0;
			this.cockVirgin = true;
			this.vaginalVirgin = true;
			this.analVirgin = true;
			this.vaginas = new Array();
			this.cocks = new Array();
			//Goo is hyper friendly!
			this.elasticity = 0;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 0;
			this.clitLength = 0;
			this.pregnancyMultiplierRaw = 0;
			
			this.createStatusEffect("Infertile");
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "black";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 0;
			this.ass.bonusCapacity = 0;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Stun Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			this.createStatusEffect("Plot Fight");
			
			inventory = [new CoCJeweledRapier()];
			
			this._isLoading = false;
		}
		
		override public function isImmobilized():Boolean {
			return true;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			EncapsulationPodUpdateDescription(target);
			
			var round:int = CombatManager.getRoundCount();
			//[Round 1 Action]
			if(round == 1) {
				output("You shiver from the feeling of warm wetness crawling up your [pc.legs].   Tentacles brush against your ");
				if(target.balls > 0) {
					output("[pc.balls] ");
					if(target.hasVagina()) output("and ");
				}
				if(target.hasVagina()) output("[pc.vagina] ");
				else if(target.balls == 0) output("[pc.asshole] ");
				output("as they climb ever-further up your body.  In spite of yourself, you feel the touch of arousal licking at your thoughts.\n");
				if (target.lust() < target.lustMax() * 0.35) {
					target.lust(target.lustMax() * 0.35, true);
				}
			}
			//[Round 2 Action]
			else if(round == 2) {
				output("The tentacles");
				if(target.hasArmor()) output(" under your [pc.armor]");
				output(" squirm against you, seeking out openings to penetrate and genitalia to caress.  ");
				if(target.balls > 0) output("One of them wraps itself around the top of your [pc.sack] while its tip slithers over your [pc.balls].  Another ");
				else output("One ");
				if(target.cockTotal() > 0) {
					output("prods your [pc.cock] for a second before it begins slithering around it, snake-like.  Once it has you encircled from [pc.cockHead] to ");
					if(!target.hasSheath(0)) output("base");
					else output("sheath");
					output(", it begins to squeeze and relax to a pleasant tempo.  ");
				}
				else {
					if(target.hasVagina()) {
						output("prods at your groin, circling around your [pc.vagina] deliberately, as if seeking other toys to play with.  ");
						if(target.clitLength > 4) output("It brushes your [pc.clit] then curls around it, squeezing and gently caressing it with a slow, pleasing rhythm.  ");
					}
					else {
						output("prods your groin before curling around to circle your [pc.asshole] playfully.  The entire tendril pulses in a pleasant, relaxing way.  ");
					}
				}
				if(target.cockTotal() > 1) {
					output("Your other ");
					if(target.cockTotal() == 2) output("[pc.cock 1] gets the same treatment, and soon both of your [pc.multiCocks] are quite happy to be here.  ");
					else output("[pc.cocksLight] get the same treatment and soon feel quite happy to be here.  ");
				}
				if(target.hasVagina()) {
					output("The violation of your [pc.vagina] is swift and painless.  The fungus' slippery lubricants make it quite easy for it to slip inside, and you find your [pc.vagina] engorging with pleasure in spite of your need to escape.  The tentacle folds up so that it can rub its stalk over your [pc.clit], ");
					if(target.clitLength > 3) output("and once it discovers how large it is, it wraps around it and squeezes.  It feels good!  ");
					else output("and it has quite an easy time making your bud grow hard and sensitive.  The constant rubbing feels good!  ");
				}
				output("One 'lucky' stalk manages to find your [pc.asshole].  As soon as it touches your rear 'entrance', it lunges forward to penetrate you.  The fluids coating the tentacle make your muscles relax, allowing it to slide inside you with ease.\n\n");
				
				output("The rest of the mass continues to crawl up you.  They tickle at your ");
				if(target.isPregnant()) output("pregnant ");
				output("belly as they get closer and closer to your [pc.fullChest].  Gods above, this is turning you on!  Your lower body is being violated in every conceivable way and it's only arousing you more.  Between the mind-numbing smell and the sexual assault you're having a hard time focusing.\n");
				if(target.lust() < target.lustMax() * 0.65) {
					target.lust(target.lustMax() * 0.65, true);
				}
			}
			//[Round 3 Action]
			else if(round == 3) {
				output("The wet, warm pressure of the fungus' protrusion working their way up your body feels better than it has any right to be.  It's like a combination of a warm bath and a gentle massage, and when combined with the thought-numbing scent in the air, it's nigh-impossible to resist relaxing a little.  In seconds the mass of tentacles is ");
				if(!target.isChestExposed()) output("underneath your [pc.armor] and ");
				output("rubbing over your chest and [pc.nipples].  You swoon from the sensation and lean back against the wall while they stroke and caress you, teasing your sensitive [pc.nipples].");
				
				if(target.hasFuckableNipples()) output("  Proof of your arousal leaks from each [pc.nipple] as their entrances part for the probing tentacles.  They happily dive inside to begin fucking your breasts, doubling your pleasure.");
				output("  Moans escape your mouth as your hips begin to rock in time with the tentacles and the pulsing luminance of your fungus-pod.  It would be easy to lose yourself here.  You groan loudly enough to startle yourself back to attention.  You've got to get out!\n\n");
				
				output("The tentacles that aren't busy with your [pc.chest] are already climbing higher, and the slime has reached your waist.  If anything it actually makes the constant violation more intense and relaxing.  You start to sink down into it, but catch yourself and pull yourself back up.  No! You've got to fight!\n");
				if(target.lust() < target.lustMax() * 0.85) {
					target.lust(target.lustMax() * 0.85, true);
				}
			}
			//[Round 4 Action]
			else {
				kGAMECLASS.clearMenu();
				target.lust(target.lustMax(), true);
				output("What's happening to you definitely isn't rape.  Not any more.  You like it too much.  You lean back against a wall of the pod and thrust your [pc.hips] pitifully against a phantom lover, moaning lewdly as you're forcibly pleasured.  You grab hold of the fleshy walls with your hands and try to hold yourself up, but your [pc.legs] have the consistency of jello.   They fold neatly underneath you as you slide into the ooze and begin to float inside it.  It's comforting in an odd way, and while you're gasping in between moans, your balance finally gives out.  You sink deeper into the fluid and lose all sense of direction.  Up and down become meaningless constructs that no longer matter to you.\n\n");
				
				output("The thick slime passes over your lips and nose as you sink into the rising tide of bliss, and you find yourself wondering how you'll breathe.  Instinctively, you hold your breath.  Even riddled with sexual bliss and thought-obliterating drugs, you won't let yourself open your mouth when 'underwater'.  The lack of oxygen makes your heart hammer in your chest");
				if(target.totalCocks() > 0) {
					output(", and your [pc.multiCocks] bloats with blood, getting larger than ever");
				}
				output(".  Before you can pass out, the constant penetration forces a moan from your lips.\n\n");
				
				output("A tentacle takes the opportunity to slip into your mouth along with a wave of the slime.  You try to cough out the fluid, but there isn't any air left in your lungs to push it out.  The orally-fixated tendril widens and begins to pour more of it inside you, and with nowhere else to go, it packs your goo-filled lungs to the brim before you start to swallow.  You relax and exhale the last of your air from your nose as your body calms itself.  Somehow you can breathe the fungus-pod's fluids!\n\n");
				
				output("You're floating in pure liquid bliss.  Thoughts melt away before they can form, and every inch of your body is being caressed, squeezed, or penetrated by the warm, slime-slicked tentacles.  Nearly every muscle in your body goes completely slack as you're cradled with bliss.  Without your thoughts or stress bothering you, the pleasure swiftly builds to a crescendo.\n\n");
				
				output("The wave of need starts out inside your crotch, begging to be let out, but you can't even be bothered to move your [pc.hips] anymore.  Without your help, release stays just out of reach, but the tentacles working your body seem intent on spurring it on.  The one inside your [pc.asshole] begins to pump more quickly, and with the added pressure, you cum quickly.  ");
				if(!target.hasVagina()) {
					output("Your body twitches weakly, too relaxed to move while it gets off from anal penetration.");
				}
				else output("Your body twitches weakly, too relaxed to move while it gets off from being double-penetrated.");
				if(target.hasFuckableNipples()) {
					output("  Your [pc.nipples] squirt around their phallic partners, leaking sexual lubricant ");
					if(target.isLactating()) output("and [pc.milkNoun] ");
					output("while the fucking continues.");
				}
				if(target.cockTotal() > 0) {
					output("  The tentacles around your [pc.multiCocks] squeeze and rotate, screwing you silly through your orgasm while cum dribbles in a steady stream from your loins.  Normally it would be squirting out in thick ropes, but the muscle-relaxing drugs in your system make the spurts a steady, weak flow.");
					if(target.cumQ() > 800) output("  Of course with all the semen you produce, the flesh-pod's ooze clouds over quite quickly, blocking your vision with a [pc.cumColor] haze.");
				}
				if(target.isLactating()) {
					output(" Milk leaks out too, ");
					if(target.milkQ() < 500) output("though the slight dribble is barely noticeable to you.");
					else if(target.milkQ() < 1000) output("coloring things a little more [pc.milkColor].");
					else output("thickening your fluid-filled prison with nutrients.");
				}
				//[NEXT – CHOOSE APPRORIATE]
				kGAMECLASS.addButton(0, "Next", kGAMECLASS.EncapsulationPodLoseToThisShitPartII);
				return;
			}
		}

		public function EncapsulationPodUpdateDescription(target:Creature):void {
			//[Round 1 Description]
			var round:int = CombatManager.getRoundCount();
			if (round <= 1) {
				this.long = "You're totally trapped inside a pod!  The walls are slimy and oozing moisture that makes the air sickeningly sweet.  It makes you feel a little dizzy.  Tentacles are climbing up your [pc.legs] towards your crotch";
				if(target.hasArmor()) this.long += ", doing their best to get under you [pc.armor]"
				this.long += ".  There's too many to try to pull away.  Your only chance of escape is to create a way out!";
			}
			//[Round 2 Description]
			else if(round == 2) {
				this.long = "You're still trapped inside the pod!  By now the walls are totally soaked with some kind of viscous slime.  The smell of it is unbearably sweet and you have to put a hand against the wall to steady yourself.  Warm tentacles are curling and twisting underneath your armor, caressing every inch of your [pc.legs], crotch, and [pc.ass].";
			}
			//[Round 3 Description]
			else if(round == 3) {
				this.long = "You're trapped inside the pod and being raped by its many tentacles!   The pooling slime is constantly rising, and in a few moments it will have reached your groin.  The viscous sludge makes it hard to move and the smell of it is making it even harder to think or stand up.  The tentacles assaulting your groin don't stop moving for an instant, and in spite of yourself, some part of you wants them to make you cum quite badly.";
			}
			//[Round 4 Description]
			else {
				this.long = "You're trapped inside the pod and being violated by tentacles from the shoulders down!  The slime around your waist is rising even faster now.  It will probably reach ";
				this.long += "the underside of your [pc.fullChest] in moments.  You're being fucked by a bevy of tentacles while your nipples are ";
				if(!target.hasFuckableNipples()) this.long += "fondled ";
				else this.long += "fucked ";
				this.long += "by more of the slippery fungal protrusions.  It would be so easy to just relax back in the fluid and let it cradle you while you're pleasured.  You barely even smell the sweet, thought-killing scent from before, but your hips are rocking on their own and you stumble every time you try to move.  Your resistance is about to give out!";
			}
			//[DAMAGE DESCRIPTS – Used All Rounds]
			//[Greater than 80% Life]
			if(this.HP() > this.maxHP() * 0.8) {
				this.long += "  The pulsing luminescence continues to oscillate in a regular rhythm.  You haven't done enough damage to the thing to affect it in the slightest.";
			}
			//[Greater than 60% Life]
			else if(this.HP() > this.maxHP() * 0.6) {
				this.long += "  Your attacks have turned a part of the wall a sickly black color, and it no longer glows along with the rest of your chamber.";
			}
			//[Greater than 40% Life] 
			else if(this.HP() > this.maxHP() * 0.4) {
				this.long += "  You've dented the wall with your attacks.  It's permanently deformed and bruised solid black from your struggles.  Underneath the spongy surface you can feel a rock-solid core that's beginning to give.";
			}
			//Greater than 20% Life] 
			else if(this.HP() > this.maxHP() * 0.2) {
				this.long += "  You have to blink your eyes constantly because the capsule's bio-luminescent lighting is going nuts.  The part of the wall you're going after is clearly dead, but the rest of your fungal prison is flashing in a crazy, panicked fashion.";
			}
			//[Greater than 0% Life]
			else {
				this.long += "  You can see light through the fractured wall in front of you!  One more solid strike should let you escape!";
			}
		}
	}
}
