package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.addButton;
	import classes.Engine.Interfaces.addDisabledButton;
	import classes.Engine.Interfaces.clearOutput;
	import classes.GameData.CombatAttacks;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	
	public class CoCCeraph extends Creature
	{
		//constructor
		public function CoCCeraph()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Ceraph";
			this.originalRace = "demon";
			this.a = "";
			this.capitalA = "";
			this.long = "Ceraph the Omnibus is totally nude and reveling in it.  Her large yet perky breasts jiggle heavily against her chest as she moves.  The flawless purple skin of her twin mounds glistens with a thin sheen of sweat, inviting you to touch and rub your fingers along their slippery surface.  Her eyes are solid black, but convey a mix of amusement and desire, in spite of their alien appearance.  The demon's crotch is a combination of both genders – a drooling cunt topped with a thick demonic shaft, sprouting from where a clit should be.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attackVerb = "flame-whip";
			this.meleeWeapon.attackNoun = "lash";
			this.meleeWeapon.longName = "flaming whip";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 15;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "demonic skin";
			this.armor.defense = 15;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 25.0;
			baseHPResistances.drug.resistanceValue = 25.0;
			baseHPResistances.pheromone.resistanceValue = 25.0;
			baseHPResistances.tease.resistanceValue = 25.0;
			
			this.level = 9;
			this.XPRaw = bossXP();
			this.credits = (rand(5) + 38) * 10;
			this.HPMod = 200;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 80 / 20 * this.level;
			this.aimRaw = 80 / 20 * this.level;
			this.intelligenceRaw = 80 / 20 * this.level;
			this.willpowerRaw = 80 / 20 * this.level;
			this.libidoRaw = 75;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 100;

			this.femininity = 85;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "glowing amber";
			this.tallness = 5 * 12 + 6;
			this.thickness = 21;
			this.tone = 40;
			this.hairColor = "black";
			this.scaleColor = "blue";
			this.furColor = "blue";
			this.hairLength = 20;
			this.hairType = 0;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "purple";
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
			this.buttRatingRaw = 6;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(10);
			this.shiftCock(0, GLOBAL.TYPE_DEMONIC);
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
			this.vaginas[0].loosenessRaw = 4;
			this.vaginas[0].bonusCapacity = 20;
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			//this.fertility = 0;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 6;
			this.nippleColor = "cerulean";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 1;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 2;
			this.ass.bonusCapacity = 15;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.KINDA_DISLIKES_SEXPREF);
			
			_isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			if (kGAMECLASS.pc.hasStatusEffect("Grappled")) {
				kGAMECLASS.removeButton(3); // no static discharge option, since there are no direct contact
				addButton(4, "Wait", ceraphBoundWait);
			}
			
			if (hasStatusEffect("Uber"))
				addButton(8, "Wait", ceraphUberWait, undefined, "Wait", "Take defensive stance and wait.");
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var choice:Number = rand(4);
			if (target.hasStatusEffect("Grappled")) {
				ceraphSpecial2(target);
				return;
			}
			
			if (hasStatusEffect("Uber")) {
				ceraphSpecial1(target);
				return;
			}
			
			switch (choice) {
				case 0:
					CombatAttacks.MeleeAttack(this, target);
					break;
				case 1:
					ceraphSpecial1(target);
					break;
				case 2:
					ceraphSpecial2(target);
					break;
				case 3:
					ceraphSpecial3(target);
					break;
			}
		}
		
		//[IN COMBAT SPECIALS]
		//[SPECIAL 1] – Ubercharge!
		private function ceraphSpecial1(target:Creature):void
		{
			if (!hasStatusEffect("Uber")) {
				if (rand(2) == 0) {
					output("Ceraph winks and says, \"<i>Have you ever cum without being touched? You will.</i>\"\n\n");
				}
				else {
					output("Ceraph titters, \"<i>Let me show you the true power of an Omnibus.</i>\"\n\n");
				}
				output("Despite her sultry tease, you can tell she's starting to build up to something big...");
				createStatusEffect("Uber", CombatManager.getRoundCount(), 0, 0, 0, false, "LustUp", "An overcharged spell is under construction!");
			}
			else {
				//(Next Round)
				if (statusEffectv2("Uber") == 0) {
					addStatusValue("Uber", 2, 1);
					setStatusTooltip("Uber", "An overcharged spell is almost ready!");
					
					if (rand(2) == 0) output("The demonic hermaphrodite begins forging demonic symbols in the air before her, each glowing brilliant pink before they blur away in a haze.");
					else output("The demonette makes obscene motions with her hands, as if masturbating an imaginary cock or vagina while her hands are wreathed in pink flames.");
					
					output("  <b>She's about to unleash something huge!</b>");
					if (target.intelligence() > 30) output("  You should probably wait so you'll have a chance to avoid whatever's coming.");
				}
				//FIRE!
				else {
					//(Avoid!)
					if (statusEffectv3("Uber") > 0) {
						output("She throws her hands out, palms facing you, and a rush of pink flame washes towards you.  Thanks to your decision to wait, it's easy to avoid the onrushing flames and her attack.\n\n");
						output("Ceraph sighs and asks, \"<i>Why would you move?  It would make you feel soooo good!</i>\"");
					}
					//(AUTO-LOSE)
					else {
						output("She throws her hands out, palms facing you, and a rush of pink flame washes towards you.  Too busy with your own attack to effectively dodge, you're hit full on by the pink fire.  Incredibly, it doesn't burn.  The fire actually seems to flow inside you, disappearing into your skin.  You stumble, confused for a second, but then it hits you.  Every inch of your body is buzzing with pleasure, practically squirming and convulsing with sexual delight.  You collapse, twitching and heaving, feeling the constant sensation of sexual release running from your head to your [pc.feet].  Too horny and pleasured to resist, you lie down and tremble, occasionally rubbing yourself to enhance the bliss.");
						target.lust(target.lustMax(), true);
					}
					removeStatusEffect("Uber");
				}
			}
		}
		
		public function ceraphUberWait():void
		{
			clearOutput();
			output("Unsure what she is up to, you are assuming defensive stance.");
			addStatusValue("Uber", 3, 1);
			CombatManager.processCombat();
		}
		
		//[SPECIAL] – Whip Binding
		public function ceraphSpecial2(target:Creature):void
		{
			if (!target.hasStatusEffect("Grappled")) {
				output("Ceraph snaps her whip at you, lightning fast.  Unable to avoid the blinding speed of her attack, you find yourself wrapped from head to [pc.toes] in the strong leather of her whip.  Remarkably, the fire dies out everywhere the whip touches you, leaving you bound but unharmed.");
				//If player has l2 piercing
				if (kGAMECLASS.flags["COC.PC_FETISH"] >= 2) {
					output("  Gods this turns you on!");
					applyDamage(new TypeCollection( { tease : 5 } ), this, target);
				}
				
				target.createStatusEffect("Grappled", 2 + rand(4), 0, 0, 0, false, "Icon_Constricted", "You are bound!", true);
			}
			//[SPECIAL WHILE PC RESTRAINED]
			else {
				if (rand(2) == 0) {
					output("Ceraph cuddles up against you, embracing you tenderly.  Her more-than-ample bosom crushes against your flank, and her demonic prick grinds and rubs against your [pc.skinFurScales], smearing it with her juices.  Her hands slide over your bound form");
					if(!target.isExposed()) output(", sneaking underneath your [pc.clothes]");
					output(" to caress you more intimately while you're at her mercy.");
					
					applyDamage(new TypeCollection( { tease : 9 + target.libido() / 10 } ), this, target);
				}
				//[SPECIAL 2 WHILE PC RESTRAINED]
				else {
					output("Ceraph blows hot kisses in your [pc.ear] and slides and rubs against you as she slips over to embrace your front.  She holds up a finger, licks it, and wiggles it back and forth.  It begins to glow pink, dimly at first and then with increasing luminosity.  Once it's reached a brilliant intensity, the sparkling digit is roughly inserted into your mouth.  You can feel the dark magic soaking into your body just like water soaks into a sponge.  ");
					if (target.lustQ() < 33) output("It makes you feel warm and flushed.");
					else if (target.lustQ() < 60) output("It gets inside you and turns you on, stoking the flames of your desire.");
					else if (target.lustQ() < 80) output("It makes you very horny, and you begin to wonder if it's worth resisting.");
					else output("It makes you ache and tremble with need, practically begging for another touch.");
					
					applyDamage(new TypeCollection( { tease : 5 + target.cor() / 5 + target.libido() / 20 } ), this, target);
				}
			}
		}
		
		//(Struggle)
		public function doStruggleRecover(target:Creature):void
		{
			clearOutput();
			output("You wriggle in the tight binding, trying your best to escape.  ");
			if (target.statusEffectv1("Grappled") - 1 <= 0) {
				output("With a mighty twist and stretch, the whip gives and uncurls from you all at once.  You've regained your freedom");
				if (kGAMECLASS.flags["COC.PC_FETISH"] >= 2) {
					output(", though you miss the tight leathery embrace");
				}
				output("!");
				target.removeStatusEffect("Grappled");
			}
			else {
				output("Despite your frantic struggling, all you manage to do is chafe against her impressively taut leather whip.");
				if (flags["COC.PC_FETISH"] >= 2) {
					output("  You get nice and hot from being so effectively restrained, maybe you should just accept it?");
				}
				target.addStatusValue("Grappled", 1, -1);
				//Strong characters break free faster
				if (target.physique() >= 40 && rand(target.physique()) >= 35) {
					output("  Though you didn't break free, it seems like your mighty struggles loosened the whip slightly...");
					target.addStatusValue("Grappled", 1, -1);
				}
			}
			output("\n\n");
			CombatManager.processCombat();
		}
		
		//(Wait)
		public function ceraphBoundWait():void
		{
			clearOutput();
			var damage:Number = 0;
			var target:Creature = kGAMECLASS.pc;
			output("Why bother resisting?  The feeling of the leather wrapped tightly around you, digging into your [pc.skinFurScales], is intoxicating.");
			if (kGAMECLASS.flags["COC.PC_FETISH"] >= 2) {
				output("  You squirm inside the bindings as you get more and more turned on, hoping that Ceraph will");
				if(!target.isNude()) output("strip away your clothes and");
				output(" force you to parade around as her bound, naked pet.");
				damage += 5;
			}
			damage += target.libido() / 20 + 5 +rand(5);
			applyDamage(new TypeCollection( { tease : damage } ), this, target);
			output("\n\n");
			CombatManager.processCombat();
		}
		
		//[Double-Attack]
		private function ceraphSpecial3(target:Creature):void
		{
			//[Mini-cum] – takes place of double-attack if very horny
			if (lustQ() >= 75) {
				output("Ceraph spreads her legs and buries three fingers in her sopping twat, her thumb vigorously rubbing against the base of her bumpy prick.  Her other hand wraps around the meaty pole and begins jerking it rapidly.  In one practiced movement she stops jerking long enough to wrap the whip around her nodule-studded demon-cock, using it like a cockring.  The organ swells thanks to the forced blood-flow, and after a few more seconds of intense masturbation, the demoness cums hard.  Her cunny squirts all over her hand, dripping clear feminine drool down her thighs.  Ceraph's masculine endowment pulses and twitches, blasting out two big squirts of jizm before it slows to a trickle.\n");
				output("Letting out a throaty sigh, the demon unties her self-induced binding and gives you a wink.  Did you really just stand there and watch the whole thing?  Amazingly Ceraph actually seems stronger after such a crude display...");
				//(+10 str/toughness, 1 level, and 10 xp reward.)
				XPRaw += 100;
				level += 1;
				physique(5);
				HPRaw += 20;
				HP(20);
				lust(35, true);
				output("\n");
				return;
			}
			
			output("The demoness weaves her whip in the air until you can practically hear it slithering like a snake, cutting the air as it weaves back and forth, still magically alight with flames.  In a blink she lashes out twice in quick succession!\n");
			
			CombatAttacks.SingleMeleeAttackImpl(this, target, false);
			output("\n");
			CombatAttacks.SingleMeleeAttackImpl(this, target, false);
		}
	}
}