package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.calculateDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.DamageResult;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.outputDamage;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCIzumi extends Creature
	{
		public function CoCIzumi() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Izumi";
			this.originalRace = "oni";
			this.a = "";
			this.capitalA = "";
			this.long = "You're fighting the immense Oni, Izumi.  Standing around 9 feet tall and wielding little more than her fists, she is the picture of strength and power.  She is clad in a scandalous blue and white Kimono, the garment drawing your eyes to her humongous breasts, and her perfectly sculpted thighs.  A curious horn juts from her head, the texture of it almost lost amongst the rock lining the inside of the cave.\n\nA distinctly cocky grin is painted across her face, her undivided attention focused upon you.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fist";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 67.0;
			//baseHPResistances.drug.resistanceValue = 67.0;
			//baseHPResistances.pheromone.resistanceValue = 67.0;
			//baseHPResistances.tease.resistanceValue = 67.0;
			
			this.armor.longName = "silken kimono";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 5000;
			this.level = 22;
			this.credits = (25 + rand(25)) * 10;
			this.HPMod = 660;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 110 / 20 * this.level;
			this.reflexesRaw = 90 / 20 * this.level;
			this.aimRaw = 90 / 20 * this.level;
			this.intelligenceRaw = 80 / 20 * this.level;
			this.willpowerRaw = 80 / 20 * this.level;
			this.libidoRaw = 30;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 9 * 12;
			this.thickness = 80;
			this.tone = 80;
			this.hairColor = "golden";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 25;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "creamy-white";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 1;
			this.hornLength = 24;
			this.hornType = GLOBAL.TYPE_DEMONIC;
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
			this.buttRatingRaw = 2;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 3;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 14; // FF
			
			this.nippleColor = "pink";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 0;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			// Handle chokeslam mechanics
			if (target.hasStatusEffect("Choke Slam"))
			{
				target.addStatusValue("Choke Slam", 1, -1);
				
				if (target.statusEffectv1("Choke Slam") <= 0)
				{
					chokeSlamDamage(target);
					cleanupChokeslam();
				}
				return;
			}
			
			// Handle groundpound
			if (target.hasStatusEffect("Ground Pound"))
			{
				target.addStatusValue("Ground Pound", 1, -1);
				if (target.statusEffectv1("Ground Pound") <= 0)
					cleanupGroundpound();
			}
			
			// Handle titsmother
			if (target.hasStatusEffect("Tit Smother"))
			{
				return;
			}
			
			// Titsmother toggle; gonna need to play with this, it should only be used once per fight
			if ((this.HPQ() <= 25) && !hasStatusEffect("UsedTitsmother"))
			{
				createStatusEffect("UsedTitsmother", 0, 0, 0, 0, true, "", "", true);
				titSmother(target);
				return;
			}
			else
			{
				var actions:Array = [straightJab, straightJab, straightJab, roundhouseKick, roundhouseKick, roundhouseKick, chokeSlam]; 
				
				if (!target.hasStatusEffect("Ground Pound"))
				{
					actions.push(groundPound);
					actions.push(groundPound);
				}
				
				actions[rand(actions.length)](target);
			}
		}
		
		public function onPlayerVictory():void {			
			cleanupChokeslam()
			cleanupTitsmother();
			cleanupGroundpound();
		}
		
		public function onPlayerLoss():void {
			onPlayerVictory();
		}
		
		// Remove the effect post-combat
		public function cleanupTitsmother():void {
			kGAMECLASS.pc.removeStatusEffect("Tit Smother");
		}
		
		// Remove the effect post-combat
		public function cleanupChokeslam():void {
			kGAMECLASS.pc.removeStatusEffect("Choke Slam");
		}
		
		// Remove the effect post-combat, fixup stats
		public function cleanupGroundpound():void {
			if (kGAMECLASS.pc.hasStatusEffect("Ground Pound")) {
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv2("Ground Pound"));
				kGAMECLASS.pc.removeStatusEffect("Ground Pound");
			}
		}
		
		// Quick punch at the player
		// Light damage
		public function straightJab(target:Creature):void
		{
			output("Quick as a flash, Izumi lashes out with her free hand, aiming for your head.");

			if (combatMiss(this, target))
			{
				output("  You deftly dodge under the lightning-quick punch.  ");
				return;
			}
			
			var d:TypeCollection = this.meleeDamage();
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			
			if (damageResult.totalDamage == 0)
			{
				output("  You lash out and manage to deflect the blow before it can connect.  ");
			}
			else if(damageResult.hpDamage == 0)
				output("  Her fist connects with your chin with a mighty crack, but your shild holds!  ");
			else
			{
				output("  Her fist connects with your chin with a mighty crack, sending you sailing across the cave.  Izumi smirks at you as you");
				if (!target.isBiped()) output(" raise back up onto your [pc.legs]");
				else output(" stand");
				output(" and dust yourself off.  ");
			}
			outputDamage(damageResult);
		}

		// Roundhouse Kick
		// Milkd lust increase
		public function roundhouseKick(target:Creature):void
		{
			output("Izumi leaps backwards onto one foot, spinning around and unleashing a thundering roundhouse kick.  Luckily, you manage to duck just in time, avoiding what surely would have been a monstrously powerful blow.  Unfortunately, as Izumi’s leg scythes through the air over your head, you find your gaze naturally following the line of her thigh muscles until you’re staring directly up the fluttering folds of Izumi’s increasingly impractical kimono.\n\n");

			if (target.cor() >= 50 || target.libido() >= 50/* || pc.sens >= 50*/)
			{
				output("You fall backwards and stagger away, already feeling a flush of warmth colouring your cheeks, trying to drag your mind back to the fight and away from... other things.  ");
				applyDamage(new TypeCollection( { tease : 10 + target.libido() / 10 } ), this, target);
			}
			else
			{
				output("You furrow a brow at the Oni's ineffectual attack, not entirely sure if she was intending to hurt you or turn you on.  Her thighs did look rather tantalizing though...  ");
				applyDamage(new TypeCollection( { tease : 5 + target.libido() / 20 } ), this, target);
			}
		}
		
		public function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Choke Slam")) {
				clearMenu();
				addButton(0, "Struggle", chokeSlamStruggle, pc)
				addButton(1, "Wait", chokeSlamWait, pc)
				
				if (pc.hasPerk("Static Burst")  && pc.shields() > 0 && pc.energy() >= 5)
					addButton(3, "StaticBurst", doStaticBurst, pc)
			}
			
			if (pc.hasStatusEffect("Tit Smother")) {
				clearMenu();
				addButton(0, "Struggle", titSmotherStruggle, pc)
				addButton(1, "Wait", titSmotherWait, pc)
				
				if (pc.hasPerk("Static Burst")  && pc.shields() > 0 && pc.energy() >= 5)
					addButton(3, "StaticBurst", doStaticBurst, pc)
			}
		}
		
		private function doStaticBurst(target:Creature):void
		{
			clearOutput();
			target.energy(-5);
			output("You release a discharge of electricity, momentarily weakening Izumi's grip on you!\n\n");
			cleanupTitsmother();
			cleanupChokeslam();
			CombatManager.processCombat();
		}
		
		// Bind player for 3 turns. If the player doesn't break out in time, they take huge damage.
		// On escape, Izumi takes some damage
		public function chokeSlam(target:Creature):void
		{
			if (combatMiss(this, target))
			{
				output("Izumi surges towards you, closing the distance between you within the blink of an eye. You narrowly avoid her crushing grip, twisting away from her grasp at the last moment.  The enormous Oni lets loose a deep, satisfied laugh.");
			}
			else
			{
				output("Izumi surges towards you, smashing aside your guard and seizing you by the throat in the blink of an eye.  Lifting you above her head, you can only struggle to breathe as the enormous Oni grins at you like some sort of prize.");
				target.createStatusEffect("Choke Slam", 3, 0, 0, 0, true, "", "", true);
			}
		}
		
		// Struggle against izumi's chokeslam
		public function chokeSlamStruggle(target:Creature):void
		{	
			clearOutput();
			
			if (rand(target.physique()) > this.physique() / 2) {
				output("Scrabbling desperately against her wrist, you narrow your eyes at the Oni woman’s superior expression,");
				if (target.isNaga() || target.hasTail() && target.hasTailFlag(GLOBAL.FLAG_LONG) && target.hasTailFlag(GLOBAL.FLAG_PREHENSILE)) output(" raise your tail and slap her solidly");
				else if (target.isBiped()) output(" raise a [pc.leg] and kick her roundly");
				else output(" and slap her square");
				output(" in the face.  Izumi drops you, staggering back in surprise.  “Ow!”  She actually yelps, covering her face with her hands.\n\n");
				output("You drop to the ground and roll away, expecting some form of retribution.  Izumi glares at you from behind her hand for a moment, then snickers.  Slowly, she drops back into her fighting stance and gestures for your bout to continue.  ");
				cleanupChokeslam();
				
				applyDamage(target.meleeDamage(), target, this);
			}
			else
			{
				output("Izumi's grip around your throat continues to strangle the breath from your lungs as she holds you aloft.  Your fingers tighten in turn around the Oni's wrist, fighting against her");
				if (target.physique() < 90) output(" immense");
				else output(" impressive"); 
				output(" strength, in an attempt to free yourself from her crushing embrace, without success.  ");
				applyDamage(new TypeCollection( { kinetic : 75 + rand(15) } ), this, target);
			}
			CombatManager.processCombat();
		}
		
		// OH HEY ITS A THING
		public function chokeSlamWait(target:Creature):void
		{
			clearOutput();
			
			output("Your feet dangle uselessly in the air as Izumi holds you aloft.  Why bother resisting?  She's just so <i>strong</i>, her fingers wrapped so completely around your neck...  ");
			applyDamage(new TypeCollection( { kinetic : 75 + rand(15) } ), this, target);
			
			//if (flags[kFLAGS.PC_FETISH] >= 2)
			//{
				//output(" and to be honest, the grip isn't an entirely unplesent experience, either.  If only Izumi would stop playing around and just <i>take you</i> already.");
				//game.dynStats("lus", 5);
			//}
			//else
			//{
				//output(".");
			//}
			CombatManager.processCombat();
		}
		
		// Player fails to escape from the chokeslam, and after 3 rounds gets nailed to the fuckin floor
		public function chokeSlamDamage(target:Creature):void
		{
			output("With a grunt of effort, Izumi hauls you through the air, her iron-like grip around your throat providing the perfect anchor to propel you towards the ground.  Before you have a chance to react, the Oni drives you into the unforgiving stone lining the floor of the cave.\n\n");

			output("The hit is extreme enough to leave you dazed for a moment, splayed out across the floor.  When you rouse yourself back to full consciousness a few seconds later, the cave is still echoing with the sound of the impact, a testament to the strength of the Oni - and your resilience.  ");
			
			applyDamage(meleeDamage(), this, target);
		}
		
		// Groundslam, does damage and slows the player if they don't dodge the hit
		public function groundPound(target:Creature):void
		{
			output("Izumi raises one mighty foot and slams it to the ground with a victorious yell.  The ground itself actually shakes below your feet, threatening to knock you off balance.\n\n");
			
			if (rand(target.legCount) > 1) { // it is hard to knock drider off it's feet...
				output("You have enough legs to keep your stance, though.");
			}
			else if (target.isGoo() || target.isNaga()) {
				output("You have no legs to be knocked down from, though.");
			}
			else if (combatMiss(this, target))
			{
				output("Leaping to the side, you manage to steady yourself against the wall, keeping your footing.");
			}
			else
			{
				output("The rumbling actually knocks you off your feet, sprawling on the ground and banging your head.  As the shaking subsides, you pull yourself upright, but you feel a little unsteady on your [pc.feet] after the disorienting impact.");
				
				var spdReducedBy:int = int(target.reflexes() * 0.25);
				target.createStatusEffect("Ground Pound", 3, spdReducedBy, 0, 0, false, "Icon_Slow", "You feel a little unsteady on your [pc.feet] after the disorienting impact.");
				target.reflexes( -spdReducedBy);
			}
		}
		
		// Binding attack, mild lust increase per turn until the player breaks out. Not TOO hard to break out, though.
		// Attack will be used ONCE, when Izumi reaches ~25% hp.
		public function titSmother(target:Creature):void
		{
			// Attack will ALWAYS hit, but be relatively easy to break out of
			output("With a sudden burst of speed, the Oni woman bullrushes you, slapping aside your hasty defence.  You brace yourself for a powerful impact, but rather than strike you she instead thrusts her arm straight past your head.  Bemused, you turn your head to follow her fist, just in time to see her crook her elbow and yank you back towards her - hard.  Pulled right off your [pc.feet] by the sudden strike, you slam");
			if (target.hasMuzzle()) output(" muzzle-");
			else output(" face-");
			output("first into Izumi - specifically, into her chest.  Shocked by suddenly having your face rammed into the pillowy soft expanse of Izumi’s bust, you rear back only to be slammed straight back into the mountainous expanse by Izumi’s arm.  ");
			
			target.createStatusEffect("Tit Smother", 0, 0, 0, 0);
			applyDamage(new TypeCollection( { tease : 5 + target.libido() / 15 + rand(5) } ), this, target);
		}
		
		// Struggle handler for titsmother attack
		public function titSmotherStruggle(target:Creature):void
		{
			if (rand(target.physique()) > this.physique() / 4)
			{
				titSmotherEscape(target);
			}
			else
			{
				if (rand(2) == 0)
				{
					clearOutput();
					output("“Hah!  Say goodnight, ‘cause I’m going to choke the fight right out of you!”  She cries exuberantly, forcibly mashing your face into her bosom.  It would appear that she is trying to throttle you, but only having one hand is making the task difficult.  You can breathe just fine, but having your face forced into the constantly jostling mass of tit-flesh before you is distracting to say the least.\n\n");
					output("You scrabble desperately against Izumi’s grip, trying not to think about where you’re placing your hands, or how soft and pliant the flesh beneath you is, or any number of other upsetting little details - but to no avail.  Izumi’s grip is incredibly strong.  You hang there for a moment, trying to get your breath back for another attempt as Izumi jostles and presses against you from all sides.  ");
				}
				else
				{
					clearOutput();
					if (target.hasCock())
					{
						output("Assaulted by the sensation of being pressed against such warm flesh, you can already feel [pc.eachCock] starting to stiffen against your will.  Your hardening erection");
						if (target.totalCocks() > 1) output("s");
						output(" just makes things even more unbearable, as the harder");
						if (target.totalCocks() > 1) output(" they get");
						else output(" it gets");
						output(", the more insistently your");
						if (target.totalCocks() > 1) output(" erections throb");
						else output(" erection throbs");
						output(", pressed up against Izumi’s stomach muscles.  Her muscles ripple and undulate as she struggles to keep you in her grip, abs flexing, bumping, encircling your insistent erection");
						if (target.totalCocks() > 1) output("s");
						output(", stimulating you even further.  You realize in a flash of panic that if you don’t get out of this soon, you may actually... ");
					}
					else
					{
						output("Izumi’s bust encloses you on all sides, leaving you feeling like you’re trapped in some kind of breast sarcophagus.  The heat radiating from the soft flesh combines with the scent of whatever strange drug Izumi had been smoking, now hanging around her like some heady perfume.");
					}
				}
				
				applyDamage(new TypeCollection( { tease : 5 + target.libido() / 15 + rand(5) } ), this, target);
				CombatManager.processCombat();
			}
		}
		
		// Player breaks free of tiSmother and applies damage to Izumi
		public function titSmotherEscape(target:Creature):void
		{
			clearOutput();
			
			if (target.physique() < 90)
			{
				output("Straining with all your might, you still can’t quite manage to break Izumi’s grip, but you do manage to somehow slide upwards through the valley of her bust.  Izumi’s face looms into view, the enormous woman gritting her teeth as she attempts to crush the fight out of you.  In an act of desperation, you rear back and then knife forwards in a brutal headbutt.\n\n");
				output("“Ack!”  Your forehead connects with her chin in a collision that probably hurts you as much as her, judging by the searing pain that lances through your forehead as she drops you to the floor. Meanwhile, Izumi staggers back, rubbing at her chin.  “Ow.  That hurt, kid!”  She says reproachfully.  The two of you take a moment to shake the cobwebs from your heads before dropping back into your combat stances, a little more wary this time around.\n\n");
			}
			else
			{
				output("Locking your arms against Izumi’s shoulders, you heave with all your might against the musclebound Oni girl’s choke hold.  You can feel her arm straining to hold you, struggling to resist, giving ground....");
				
				if (target.isBiped()) 
				{
					output("  As soon as you can, you hike up your legs and place your feet firmly on Izumi’s stomach, adding your leg muscles to the effort.");
				}
				
				output("  Izumi grits her teeth and growls as she pulls with all her might, trying to force your limbs to give way, but to no avail - with a final thrust, Izumi lets out a yelp as you knock her arm aside and leap away.  Izumi rolls her arm around a little, massaging her shoulder as she regards you, thoughtfully.  Then she reaches up and fans at her face with one hand, grinning that suggestive grin.\n\n");
			}

			output("“Oh my,” she purrs, lasciviously. “Aren’t you the impressive one?  Keep surprising me like that and I might just forget about this handicap...” ");

			cleanupTitsmother();
			
			applyDamage(target.meleeDamage(), target, this);
			
			CombatManager.processCombat();
		}
		
		// Wait handler for titsmother attack
		public function titSmotherWait(target:Creature):void
		{
			clearOutput();
			
			output("With your face crushed into the Oni's cleavage, you can't help but wonder; why bother resisting?  She's just so <i>strong</i>, and her breasts feel so lushious against your [pc.face]...");
			
			applyDamage(new TypeCollection( { tease : 5 + target.libido() / 15 + rand(5) } ), this, target);
			
			//if (flags[kFLAGS.PC_FETISH] >= 2)
			//{
				//output(" and to be honest, her grip isn't an entirely unplesent experience, either.  If only Izumi would stop playing around and just <i>take you</i> already.");
				//game.dynStats("lus", 5);
			//}
			//else
			//{
				//output(".");
			//}
			CombatManager.processCombat();
		}
	}
}