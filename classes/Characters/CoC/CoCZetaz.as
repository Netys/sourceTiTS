package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	
	
	public class CoCZetaz extends Creature
	{
		public function CoCZetaz()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Zetaz";
			this.originalRace = "imp";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past time.  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.";
			this.customDodge = "";
			this.customBlock = "";
					
			this.meleeWeapon.attackVerb = "swipe";
			this.meleeWeapon.attackNoun = "claw-slash";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 18;
			this.meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "leathery skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.damageValue = 75.0;
			baseHPResistances.drug.damageValue = 50.0;
			baseHPResistances.pheromone.damageValue = 50.0;
			baseHPResistances.psionic.damageValue = 50.0;
			
			this.XPRaw = 1000;
			this.level = 12;
			this.credits = (rand(55) + 150) * 10;
			this.HPMod = 350;
			this.HPRaw = this.HPMax();
			this.shieldsRaw = this.shieldsMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 45 / 20 * this.level;
			this.aimRaw = 45 / 20 * this.level;
			this.intelligenceRaw = 52 / 20 * this.level;
			this.willpowerRaw = 52 / 20 * this.level;
			this.libidoRaw = 55;
			this.energyRaw = 100;
			this.lustRaw = 40;
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_DEMONIC;
			this.eyeColor = "black";
			this.tallness = 4 * 12 + 1;
			this.thickness = 20;
			this.tone = 70;
			this.hairColor = "black";
			this.scaleColor = "";
			this.furColor = "";
			this.hairLength = 3;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SKIN;
			this.skinTone = "red";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_DEMONIC;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_DEMONIC;
			this.lipMod = 0;
			this.earType = 0;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_DEMONIC;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_DEMONIC;
			this.legType = GLOBAL.TYPE_DEMONIC;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
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
			this.hipRatingRaw = 2;
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
			this.createCock();
			this.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			this.cocks[0].cLengthRaw = rand(2) + 11;
			this.cocks[0].cThicknessRatioRaw = 1.75;
			this.cocks[0].cockColor = "red";
			//balls
			this.balls = 2;
			this.cumMultiplierRaw = 6;
			//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
			this.cumQualityRaw = 1;
			this.cumType = GLOBAL.FLUID_TYPE_CUM;
			this.ballSizeRaw = 1;
			this.ballFullness = 1;
			//How many "normal" orgams worth of jizz your balls can hold.
			this.ballEfficiency = 10;
			//Scales from 0 (never produce more) to infinity.
			this.refractoryRate = 6;
			this.minutesSinceCum = 3650;
			this.timesCum = 321;
			
			//Goo is hyper friendly!
			this.elasticity = 1;
			//Fertility is a % out of 100. 
			this.fertilityRaw = 1.05;
			this.clitLength = .5;
			this.pregnancyMultiplierRaw = 1;
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "red";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			//The rate at which you produce milk. Scales from 0 to INFINITY.
			this.milkRate = 0;
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity += 500;
			//this.inventory.push();

			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(5+rand(3));
			inventory = [new CoCBimboLiqueur()];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			//Zetaz taunts.
			zetazTaunt(target);
			output("\n\n");
			//If afflicted by blind or whispered and over 50% lust,
			//burns lust and clears statuses before continuing with 
			//turn.
			if(lustQ() > 50 && (hasStatusEffect("Fear") || hasStatusEffect("Blind"))) {
				removeStatusEffect("Fear");
				removeStatusEffect("Blind");
				lust(-10);
				output("Zetaz blinks and shakes his head while stroking himself.  After a second his turgid member loses some of its rigidity, but his gaze has become clear.  He's somehow consumed some of his lust to clear away your magic!");
			}
			
			//STANDARD COMBAT STATUS AFFECTS HERE
			if(hasStatusEffect("Stunned")) {
				output("Your foe is too dazed from your last hit to strike back!");
				removeStatusEffect("Stunned");
				return;
			}
			var select:Number=1;
			var rando:Number=1;
			//Exgartuan gets to do stuff!
			//if(player.findStatusAffect(StatusAffects.Exgartuan) >= 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0 && rand(3) == 0) {
				//game.exgartuan.exgartuanCombatUpdate();
				//outputText("\n\n", false);
			//}
			//if(findStatusAffect(StatusAffects.Constricted) >= 0) {
				////Enemy struggles - 
				//outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.", false);
				//if(statusAffectv1(StatusAffects.Constricted) <= 0) {
					//outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.", false);
					//removeStatusAffect(StatusAffects.Constricted);
				//}
				//addStatusValue(StatusAffects.Constricted,1,-1);
				//combatRoundOver();
				//return;
			//}
			//STANDARD COMBAT STATUS AFFECTS END HERE
			//-If over 50 lust and below 50% hp
			//--burns 20 lust to restore 20% hp. 
			if(lustQ() > 50 && HP() < maxHP() / 2) {
				output("The imp lord shudders from his wounds and the pulsing member that's risen from under his tattered loincloth.  He strokes it and murmurs under his breath for a few moments.  You're so busy watching the spectacle of his masturbation that you nearly miss the sight of his bruises and wounds closing!  Zetaz releases his swollen member, and it deflates slightly.  He's used some kind of black magic to convert some of his lust into health!  ");
				HP(maxHP() / 4);
				lust( -20);
				applyDamage(new TypeCollection( { tease : 2 } ), this, target);
			}
			else {
				var attackChoice:Number = rand(3);
				if(attackChoice == 0) {
					//Chucks faux-heat draft ala goblins. - 
					output("Zetaz grabs a bottle from a drawer and hurls it in your direction!  ");
					if(rangedCombatMiss(this, target)) {
						output("You sidestep it a moment before it shatters on the wall, soaking the tapestries with red fluid!  ");
					}
					else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
						output("Your sealed armor protects you! ");
					}
					else {
						output("You try to avoid it, but the fragile glass shatters against you, coating you in sticky red liquid.  It seeps into your [pc.skin] and leaves a pleasant, residual tingle in its wake.  Oh no...  ");
						//[Applies: "Temporary Heat" status]
						//if(player.findStatusAffect(StatusAffects.TemporaryHeat) < 0) player.createStatusAffect(StatusAffects.TemporaryHeat,0,0,0,0);
						applyDamage(new TypeCollection( { drug : 10 + rand(10) } ), this, target);
					}
				}
				else if(attackChoice == 1) {
					//'Gust' – channels a pidgy's spirit to beat 
					//his wings and kick up dust, blinding the PC 
					//next turn and dealing light damage. - 
					output("The imp leaps into the air with a powerful spring, beating his wings hard to suspend himself in the center of his bedchamber.  Dust kicks up into the air from the force of his flight and turns the room into a blinding tornado!  Small objects smack off of you, causing little damage ");
					if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
						output(", but your sealed armor protects your eyes from dust cloud!  ");
					} else {
						output("while the dust gets into your eyes, temporarily blinding you!  ");
						target.createStatusEffect("Blind", 2, 0, 0, 0, false, "Blind", "You're blinded and cannot see! Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0);
					}
					applyDamage(new TypeCollection( { kinetic : 1 + rand(6) } ), this, target);
				}
				//Gigarouse – A stronger version of normal imp's 
				//'arouse' spell. - copy normal arouse text and 
				//spice it up with extra wetness!
				else {
					gigaZetazArouse(target);
				}
			}
		}

		public function gigaZetazArouse(target:Creature):void {
			output("You see Zetaz make familiar arcane gestures at you, but his motions seem a lot more over the top than you'd expect from an imp.\n");
			if (target.lustQ() < 30) output("Your nethers pulse with pleasant warmth that brings to mind pleasant sexual memories.  ");
			if (target.lustQ() >= 30 && target.lustQ() < 60) output("Blood rushes to your groin in a rush as your body is hit by a tidal-wave of arousal.  ");
			if (target.lustQ() >= 60) output("Your mouth begins to drool as you close your eyes and imagine yourself sucking off Zetaz, then riding him, letting him sate his desires in your inviting flesh.  The unnatural visions send pulses of lust through you so strongly that your body shivers.  ");
			applyDamage(new TypeCollection( { psionic : rand(target.libido() / 10) + target.cor() / 10 + 15 } ), this, target);
			output("\n\n");
			
			if(target.hasCock()) {
				if (target.lustQ() >= 60 && target.cocks.length > 0) output("You feel [pc.multiCocks] dribble pre-cum, bouncing with each beat of your heart and aching to be touched.  ");
				if (target.lustQ() >= 30 && target.lustQ() < 60 && target.cocks.length == 1) output("Your [pc.multiCocks] hardens and twitches, distracting you further.  ");
			}
			if(target.hasVagina()) {
				if (target.lustQ() >= 60 && target.wetness() == 1 && target.vaginas.length == 1) output("Your [pc.vagina] dampens perceptibly, feeling very empty.  ");
				if (target.lustQ() >= 60 && target.wetness() == 2 && target.vaginas.length > 0) output("Your crotch becomes sticky with girl-lust, making it clear to Zetaz just how welcome your body finds the spell.  ");
				if (target.lustQ() >= 60 && target.wetness() == 3 && target.vaginas.length == 1) output("Your [pc.vagina] becomes sloppy and wet, dribbling with desire to be mounted and fucked.  ");
				if (target.lustQ() >= 60 && target.wetness() == 4 && target.vaginas.length > 0) output("Thick runners of girl-lube stream down the insides of your thighs as your crotch gives into the demonic magics.  You wonder what Zetaz's cock would feel like inside you?  ");
				if (target.lustQ() >= 60 && target.wetness() == 5 && target.vaginas.length == 1) output("Your [pc.vagina] instantly soaks your groin with the heady proof of your need.  You wonder just how slippery you could Zetaz's dick when it's rammed inside you?  ");
			}
		}


		public function zetazTaunt(target:Creature):void {
			var round:int = CombatManager.getRoundCount();
			if(round == 1) {
				output("Zetaz asks, \"<i>Do you even realize how badly you fucked up my life, Champion?  No, of course not.  That's the kind of attitude I'd expect from one of you!</i>\"");
			}
			else if(round == 2) output("\"<i>I lost my post!  And when you screwed up the factory?  I barely escaped with my life!  You ruined EVERYTHING!</i>\" screams Zetaz.");
			else if(round == 3) output("Zetaz snarls, \"<i>Do you know how hard it is to hide from Lethice?  DO YOU HAVE ANY IDEA!?  I've had to live in this fetid excuse for a jungle, and just when I found some friends and made it livable, you show up and DESTROY EVERYTHING!</i>\"");
			else if(round == 4) output("Zetaz explains, \"<i>I won't let you go.  I'm going to break you.</i>\"");
			else if(round == 5) output("\"<i>Would it have been that bad to go along with me?  You've seen the factory.  We would've kept you fed, warm, and provided you with limitless pleasure.  You would've tasted heaven and served a greater purpose.  It's not too late.  If you come willingly I can make sure they find a good machine to milk you with,</i>\" offers the imp lord.");
			else if(round == 6) output("\"<i>Why won't you fall?</i>\" questions Zetaz incredulously.");
			else if(round == 7) output("The imp lord suggests, \"<i>If you give up and let me fuck your ass maybe I'll let you go.</i>\"");
			else if(round == 8) output("Zetaz pants, \"<i>Just give up!  I'm nothing like the weakling you met so long ago!  I've been through hell to get here and I'm not giving it up just because you've shown up to destroy my hard work!</i>\"");
			else output("He glares at you silently.");
		}
	}
}