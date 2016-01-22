package classes.Characters.CoC 
{
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
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Apparel.CoCWizardRobes;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCSophie extends CoCHarpy
	{
		public function CoCSophie() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Sophie";
			this.originalRace = "harpy";
			this.a = "";
			this.capitalA = "";
			this.long = "Sophie is approximately the size of a normal human woman, not counting the large feathery wings that sprout from her back.  Her face is gorgeous, with large rounded eyes and glimmering amber lip-gloss painted on her lush, kissable lips.  In spite of her beauty, it's clear from the barely discernible laugh lines around her mouth that she's been around long to enough to have quite a few children.  Her feathers are light pink, though the downy plumage that comprises her 'hair' is brighter than the rest.  She moves with practiced grace despite the large, jiggling breasts that hang from her chest.  Judging from her confident movements, she's an experienced fighter.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "talons";
			this.meleeWeapon.attackVerb = "slashing talons";
			this.meleeWeapon.attackNoun = "slash";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 20;
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 70.0;
			//baseHPResistances.drug.resistanceValue = 70.0;
			//baseHPResistances.pheromone.resistanceValue = 70.0;
			//baseHPResistances.tease.resistanceValue = 70.0;
			
			this.armor.longName = "feathers";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.XPRaw = 750;
			this.level = 11;
			this.credits = (20 + rand(25)) * 10;
			this.HPMod = 250;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 55 / 20 * this.level;
			this.reflexesRaw = 110 / 20 * this.level;
			this.aimRaw = 110 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 60 / 20 * this.level;
			this.libidoRaw = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 10;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "amber";
			this.tallness = 5 * 12 + 5;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "blue";
			this.scaleColor = "none";
			this.furColor = "blue";
			this.hairLength = 16;
			this.hairType = GLOBAL.HAIR_TYPE_FEATHERS;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FEATHERS;
			this.skinTone = "pink";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.lipColor = "yellow";
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_AVIAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_AVIAN;
			this.legType = GLOBAL.TYPE_AVIAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FEATHERED];
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
			this.hipRatingRaw = 20;
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
			//No dicks here!
			this.cocks = new Array();
			
			this.vaginas = [];
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 5;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 5;
			
			this.nippleColor = "pink";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 0;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 10;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			//if (rand(10) == 0) inventory.push(new CoCWizardRobes()); // same as base
			//else inventory.push(new CoCGoldenSeed());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (hasStatusEffect("Level") || rand(2) == 0) {
				harpyUberCharge(target);
				return;
			}
			
			var options:Array = [];
			
			//Update attacks for girls/neuters
			if (!target.hasCock()/* || findStatusAffect(StatusAffects.BimboBrawl) >= 0*/) {
				options = [talonsSophie, batterAttackSophie];
			}
			//Dicks ahoy
			else {
				options = [harpyAttack, sophieKissAttack, sophieHarpyBoatsPC, sophieCompulsionAttack];
			}
			
			RandomInCollection(options)(target);
		}
		
		//Combat Attacks
		//ON DICK'ED PCz
		//Kiss (Only used on males) - +10 lust on kiss.  25% chance
		//per round of increasing lust by 20.  Repeat kisses add
		//+20 lust.  Each kiss adds 2 hours to length of status
		//affect.
		private function sophieKissAttack(target:Creature):void {
			//game.sophieBimbo.sophieSprite();
			output("Sophie bobs and weaves as she closes the distance between you in an instant.  ");
			//Blind dodge change
			if(hasStatusEffect("Blinded") && rand(3) < 2) {
				output(capitalA + short + " looks like she's trying to kiss you, but it's easy to avoid the blind harpy!\n");
				return;
			}
			//Determine if dodged!
			if(combatMiss(this, target, -1, reflexes() / target.reflexes())) { // highly affected by reflexes diff
				output("Sophie changes direction in a flash, trying to slip inside your guard, but you manage to sidestep the incredibly fast harpy's attack.\n");
				return;
			}
			else if (target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("Your sealed armor protects you from her touch!\n"); // maybe reroute to attack
				return;
			}
			//YOU GOT HIT SON
			output("Before you can react, she gives you a chaste peck on the lips.  The harpy pulls back with a sultry smile, watching you expectantly.  ");
			
			if (target.getLustResistances().drug.resistanceValue >= 100 || target.isLustImmune) {
				output("And... Nothing?\n");
				return;
			}
			
			//Already affected by it
			if(target.hasStatusEffect("Luststick")) {
				output("  Blood rushes to [pc.eachCock] as you grow so hard so fast that it hurts.  ");
				kGAMECLASS.luststickApplication(2);
				applyDamage(new TypeCollection( { drug : (12 + target.libido() / 10) } ), this, target);
				
				if(target.lustQ() < 70) output("The drugged lip-gloss is starting to get to you!\n");
				else if(target.lustQ() < 80) output("Her curvy thighs look so inviting.  You barely stop yourself before you climb in between them!\n");
				else if(target.lustQ() < 90) output("A trickle of pre-cum leaks from [pc.eachCock].  Sophie coos, \"<i>Why don't you give in and let mommy Sophie drain out all that juicy cum?</i>\"\n");
				else if(target.lustQ() < 100) output("[pc.EachCock] twitches and bounces in time with your heartbeat, practically pulling you towards Sophie's gaping, pink-linked snatch.\n");
				else output("So horny.  You need to copulate - no, fuck - right NOW.  Your hand touches [pc.oneCock] and you swoon, pumping your hips lewdly as you submit.\n");
			}
			else {
				output("  Your whole body blushes as your lips tingle with some unnatural sensation.  Her lips were drugged!  Your whole body flushes as arousal begins to course through your veins.  ");
				kGAMECLASS.luststickApplication(2);
				applyDamage(new TypeCollection( { drug : (8 + target.libido() / 10) } ), this, target);
				
				if(target.lustQ() < 70) output("The drugged lip-gloss is starting to get to you!\n");
				else if(target.lustQ() < 80) output("Her curvy thighs look so inviting.  You barely stop yourself before you climb in between them!\n");
				else if(target.lustQ() < 90) output("A trickle of pre-cum leaks from [pc.eachCock].  Sophie coos, \"<i>Why don't you give in and let mommy Sophie drain out all that juicy cum?</i>\"\n");
				else if(target.lustQ() < 100) output("[pc.EachCock] twitches and bounces in time with your heartbeat, practically pulling you towards Sophie's gaping, pink-linked snatch.\n");
				else output("So horny.  You need to copulate - no, fuck - right NOW.  Your hand touches your [pc.oneCock] and you swoon, pumping your hips lewdly as you submit.\n");
			}
		}
		
		//Harpy-Boating (Only used on males)
		//Takes off and flies directly at PC, locking her hips 
		//around PC's torso and smothering the PC with breasts 
		//for a few moments.
		//Easily dodged with evade or flexibility.
		private function sophieHarpyBoatsPC(target:Creature):void {
			//game.sophieBimbo.sophieSprite();
			output(capitalA + short + " flaps her wings and launches herself forwards with her talons up.  ");
			//Blind dodge change
			if(hasStatusEffect("Blinded") && rand(3) < 2) {
				output(capitalA + short + "'s talons are easy to avoid thanks to her blindness!\n");
				return;
			}
			//Determine if dodged!
			if(combatMiss(this, target, -1, reflexes() / target.reflexes())) { // highly affected by reflexes diff
				output(a + short + "'s movements are incredibly fast but you manage to sidestep them.\n");
				return;
			}
			
			//YOU GOT HIT SON
			output("She hits you hard, nearly bowling you over.  Thankfully, her talons passed to either side of your torso.  They lock together behind your back and your face is pulled tightly into Sophie's smotheringly large mounds!");
			if(rand(2) == 0) output("  She jiggles them around you pleasantly and coos, \"<i>Don't fight it baby.  Just let your body do what comes naturally.</i>\"\n");
			else output("  She runs her long fingernails through your hair as she whispers, \"<i>Why fight it?  I'll make you feel so good.  Just relax and play with momma Sophie's tits.</i>\"  ");
			applyDamage(new TypeCollection( { tease : (13 + target.libido() / 10) } ), this, target); // sens originally
		}
		
		//Compulsion (Male Only)
		private function sophieCompulsionAttack(target:Creature):void {
			//game.sophieBimbo.sophieSprite();
			output("Sophie spreads her thick thighs and slips four fingers into her slippery sex.  She commands, \"<i>Touch yourself for me.  Be a good pet and masturbate for me.</i>\"  ");
			//Autosucceeds if player inte < 40
			//autofails if player inte > 80
			//Player fails:
			if(target.WQ() < 40 || (target.WQ() < 80 && rand(40) > (target.WQ() - 40))) {
				output("You moan out loud as your arms move of their own volition.  They reach inside your [pc.gear] and stroke [pc.cock], caress the [pc.cockHead], and continue to fondle you a few moments.");
				output("Even after regaining control of your limbs, you're left far more turned on by the ordeal.");
				applyDamage(new TypeCollection( { tease : (15 + target.libido() / 20 + target.cor() / 20) } ), this, target);
			}
			//Player resists
			else {
				output("You can feel her words carrying the force of a magical compulsion behind them, but you focus your willpower and overcome it.");
			}
		}
		
		//ON FEMALE PCz
		//Talons (Female Only)
		//High damage attack easily avoided by evade/flexibility.
		private function talonsSophie(target:Creature):void {
			//game.sophieBimbo.sophieSprite();
			output("Sophie pulls her leg up, cocking her thigh dangerously.  Look out!  ");

			//Blind dodge change
			if(hasStatusEffect("Blinded") && rand(3) < 2) {
				output(capitalA + short + "'s talons are easy to avoid thanks to her blindness!\n");
				return;
			}
			//Determine if dodged!
			if(combatMiss(this, target, -1, reflexes() / target.reflexes())) { // highly affected by reflexes diff
				output(a + short + "'s tears through the air, but you manage to just barely dodge it.\n");
				return;
			}
			output("Her leg lashes forwards, lightning-quick");
			
			var d:TypeCollection = this.meleeDamage();
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
			
			if (damageResult.totalDamage == 0) output(", but you deflect the attack.  ");
			else if(damageResult.hpDamage == 0) output(", but your shild holds!  ");
			else output(", and tears bloody gashes into your [pc.skin] with her razor-sharp talons!  ");
			
			outputDamage(damageResult);
		}
		
		//Batter (Female Only)
		//Batters PC with wings – 4x attack impossible to dodge.*/
		private function batterAttackSophie(target:Creature):void {
			//game.sophieBimbo.sophieSprite();
			output("Sophie comes at you in a flurry of beating wings!  There's no way to dodge the flurry of strikes!");
			
			var d:TypeCollection = this.meleeDamage();
			d.multiply(0.66);
			
			output("\nHer left primary wing batters your head!  ");
			applyDamage(d, this, target, "melee");
			output("\nHer right, wing-like arm slaps at your torso!  ");
			applyDamage(d, this, target, "melee");
			output("\nHer other feathery arm punches at your shoulder!  ");
			applyDamage(d, this, target, "melee");
			output("\nHer right wing slams into the other side of your head!  ");
			applyDamage(d, this, target, "melee");
		}
	}
}