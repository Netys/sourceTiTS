package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.CoCToughSpiderSilk;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.CoCBlackGossamer;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCCorruptedDrider extends CoCSpiderMorph
	{
		public function CoCCorruptedDrider() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "corrupted drider";
			this.originalRace = "drider";
			this.a = "the ";
			this.capitalA = "The ";
			this.nipplesPierced = rand(2);
			this.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, D-cup breasts with their shiny black nipples.  " + (this.nipplesPierced ? "Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  " : "") + "On her face and forehead, a quartet of lust-filled, [enemy.skinTone] eyes gaze back at you.  Behind her, the monster-girl's [enemy.hairColor] hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  From time to time it pulsates and grows, turning part-way into a demon-dick.  Her spider-half has eight spindly legs with black and [enemy.hairColor] stripes - a menacing display if ever you've seen one.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 30;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "carapace";
			this.armor.defense = 55;
			this.armor.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = pierced ? 75.0 : 60.0;
			//baseHPResistances.drug.resistanceValue = pierced ? 75.0 : 60.0;
			//baseHPResistances.pheromone.resistanceValue = pierced ? 75.0 : 60.0;
			//baseHPResistances.tease.resistanceValue = pierced ? 75.0 : 60.0;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 500;
			this.level = this.nipplesPierced ? 15 : 14;
			this.credits = this.nipplesPierced ? (rand(10) + 30) * 10 : (rand(10) + 20) * 10;
			this.HPMod = this.nipplesPierced ? 325 : 250;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 100 / 20 * this.level;
			this.reflexesRaw = 70 / 20 * this.level;
			this.aimRaw = 70 / 20 * this.level;
			this.intelligenceRaw = 100 / 20 * this.level;
			this.willpowerRaw = 100 / 20 * this.level;
			this.libidoRaw = 80;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;			
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_ARACHNID;
			this.eyeColor = RandomInCollection("yellow", "purple", "red", "turquoise");
			this.tallness = 10 * 12;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = RandomInCollection("red", "orange", "green");
			this.scaleColor = "black";
			this.furColor = "black";
			this.hairLength = 24;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_CHITIN;
			this.skinTone = this.eyeColor;
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_ARACHNID;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_DRIDER;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_ARACHNID;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_DRIDER;
			this.legCount = 8;
			this.legFlags = [];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_DRIDER;
			this.tailCount = 1;
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
			this.hipRatingRaw = 12;
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
			this.createCock(9, 2);
			this.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].vaginaColor = "black";
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 4;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 70;
			
			this.breastRows = [];
			this.createBreastRow();
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 6;
			this.breastRows[1].breastRatingRaw = 6;
			this.nippleColor = "black";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 70;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			var drop:* = kGAMECLASS.WeightedRandom(
						[new CoCBlackGossamer(), new CoCToughSpiderSilk(), null] ,
						[5,                      1,                        4]);
			
			if (drop != null) inventory.push(drop);
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (lust() > 70 && rand(4) == 0) {
				driderMasturbate(target);
			}
			else if(!target.hasStatusEffect("Web Silence") && rand(4) == 0) {
				spiderSilence(target);
			}
			else if(!target.hasStatusEffect("Disarmed") && target.hasEquippedWeapon() && rand(4) == 0) {
				spiderDisarm(target);
			}
			else if(target.reflexes() >= 2 || rand(2) == 0) {
				spiderMorphWebAttack(target);
			}
			else driderKiss(target);
		}

		//Drider kiss!
		public function driderKiss(target:Creature):void {
			output("The corrupted drider closes in on your web-bound form, cooing happily at you while you struggle with the sticky fibers.\n\n");
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output("She's too blind to get anywhere near you.\n");
			}
			//Dodge
			if (combatMiss(this, target)) {
				output("Somehow, you manage to drag yourself out of the way.  She sighs and licks her lips.  \"<i>");
				output(RandomInCollection(
					"I just wanted to give my delicious morsel a kiss...</i>\"\n",
					"Why won't you let me kiss you?</i>\"\n",
					"Mmm, do you have to squirm so much, prey?</i>\"\n",
					"Just look at my glossy, dripping lips.  Imagine how great it would feel to have them locked against you.  Why resist?</i>\"\n"));
			}
			// TODO: airtight armor case?
			else if(!target.hasStatusEffect("Drider Kiss")) {
				output("Before you can move, she's right on top of you, leaning ");
				if(target.tallness < 72) output("down");
				else output("over");
				output(" to plant a sloppy, wet kiss upon your lips.  Her glossy lip-venom oozes everywhere, dribbling down your collective chins and sliding into your mouth.  You shudder, trying to resist, but your tongue betrays you.  It slides between her moist, puffy entrance, lapping at her venom and making love to her tongue.  ");
				if (target.LQ() < 100) output("  Somehow, you work up the willpower to back away, but your body slowly begins to burn hotter and harder, afflicted with a slowly-building lust.  ");
				//(HIT? + 10 lust)
				applyDamage(new TypeCollection( { tease : 3, drug : 7 } ), this, target);
				target.createStatusEffect("Drider Kiss", 0, 0, 0, 0, true, "", "", true);
			}
			//Get hit 2nd time) 
			else {
				target.addStatusValue("Drider Kiss", 1, 1);
				if(target.statusEffectv1("Drider Kiss") == 1) {
					output("Again, the drider ties your mouth up in her syrupy lip-lock, seeming to bind your mouth as effectively as her webs bind your body.  Her sweet venom bubbles and froths at the corners of the oral embrace, dripping over her many-breasted bosom and your [pc.chest].");
					if(target.hasCock()) output("  [pc.EachCock] spews a rope of pre-cum into your [pc.gear], desperate to get out and fuck.");
					if(target.hasVagina()) output("  [pc.Femcum] dribbles down your [pc.legs] while your [pc.clit] gets so hard you think it'll explode.");
					output("  This time, the drider is the one to break the kiss.  She asks, \"<i>Are you ready, my horny little morsel?</i>\"\n");
					if(target.LQ() < 100) output("You shake your head 'no' and stand your ground!\n");
					
					//(HIT? + 15 lust)
					applyDamage(new TypeCollection( { tease : 5, drug : 10 } ), this, target);
				}
				//(Get hit 3rd+ time)
				else {
					output("This time you barely move.  Your body is too entranced by the idea of another venom-laced kiss to resist.  Glorious purple goo washes into your mouth as her lips meet yours, sealing tight but letting your tongue enter her mouth to swirl around and feel the venom drip from her fangs.  It's heavenly!  Your [pc.skin] grows hot and tingly, and you ache to be touched so badly.  Your [pc.nipples] feel hard enough to cut glass, and a growing part of you admits that you'd love to feel the drider's chitinous fingers pulling on them.  ");
					if(target.hasCock() || target.hasVagina()) {
						output("The moisture in your crotch only gets worse.  At this point, a ");
						if(target.wetness() < 3 && target.cumQ() < 200) output("small");
						else if(target.wetness() < 5 && target.cumQ() < 500) output("large");
						else output("massive");
						output(" wet stain that reeks of your sheer sexual ache has formed in your [pc.gear].  ");
						if(target.LQ() < 100) output("Amazingly, you resist her and pull back, panting for breath.  ");
					}
					//(HIT? + 20 lust)
					applyDamage(new TypeCollection( { tease : 7, drug : 13 } ), this, target);
				}
			}
		}
		
		public function driderMasturbate(target:Creature):void {
			//-Masturbate - (Lowers lust by 50, raises PC lust)
			output("The spider-woman skitters back and gives you a lusty, hungry expression.  She shudders and moans, \"<i>Mmm, just watch what you're missing out on...</i>\"\n\n");
			output("As soon as she finishes, her large clit puffs up, balloon-like.  A second later, it slides forward, revealing nine inches of glossy, girl-spunk-soaked shaft.  Nodules ring the corrupted penis' surface, while the tiny cum-slit perched atop the tip dribbles heavy flows of pre-cum.  She pumps at the fleshy organ while her other hand paws at her jiggling breasts, tugging on the hard ");
			if(nipplesPierced > 0) output("pierced ");
			output("nipple-flesh.  Arching her back in a lurid pose, she cries out in high-pitched bliss, her cock pulsing in her hand and erupting out a stream of seed that lands in front of her.\n\n");
			
			output("The display utterly distracts you until it finishes, and as you adopt your combat pose once more, you find your own needs harder to ignore, while hers seem to be sated, for now.  ");
			lust( -30);
			applyDamage(new TypeCollection( { tease : (10 + target.libido() / 20) } ), this, target);
		}
	}
}