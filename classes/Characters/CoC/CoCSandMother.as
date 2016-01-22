package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.Util.*;
	
	public class CoCSandMother extends Creature
	{
		public function CoCSandMother() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Sand Mother";
			this.originalRace = "human";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The Sand Mother is a towering woman of imposing stature and bust.  She wears a much silkier, regal-looking robe than her sisters, and it barely serves to contain her four milk-laden breasts, straining under their jiggling weight.  Dangling around her in a way that reminds you oddly of a halo, the Sand Mother's blonde-white hair fans around her, hanging long behind her.  The queen witch is brandishing a pearly white scepter rather threateningly, though from the way she holds it, it's clear she doesn't intend to use it as a physical weapon.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.attackVerb = "punches";
			this.meleeWeapon.attackNoun = "punches";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "robes";
			this.armor.defense = 1;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 50.0;
			baseHPResistances.drug.resistanceValue = 10.0;
			baseHPResistances.pheromone.resistanceValue = 25.0;
			baseHPResistances.tease.resistanceValue = 50.0;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1000;
			this.level = 7;
			this.credits = (rand(15) + 55) * 10;
			this.HPMod = 130;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 25 / 20 * this.level;
			this.reflexesRaw = 35 / 20 * this.level;
			this.aimRaw = 35 / 20 * this.level;
			this.intelligenceRaw = 45 / 20 * this.level;
			this.willpowerRaw = 45 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 8 * 12 + 6;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "platinum-blonde";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 15;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "bronzed";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
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
			this.buttRatingRaw = 8;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 2;
			this.vaginas[0].bonusCapacity = 70;
			
			this.breastRows = [];
			this.createBreastRow();
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 6; // DD
			this.breastRows[1].breastRatingRaw = 6; // DD
			
			this.nippleColor = "green";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 50;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			//this.createPerk(PerkLib.Resolute,0,0,0,0);
			//this.createPerk(PerkLib.Focused,0,0,0,0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (this.hasStatusEffect("Earth Ehield")) {
				this.addStatusValue("Earth Ehield", 1, -1);
				if (this.statusEffectv1("Earth Ehield") <= 0) {
					output("Her earth shield is crumbling!\n");
					this.removeStatusEffect("Earth Ehield")
					this.baseHPResistances.kinetic.resistanceValue -= 50.0;
					this.baseHPResistances.electric.resistanceValue -= 50.0;
					this.baseHPResistances.burning.resistanceValue -= 50.0;
					this.baseHPResistances.corrosive.resistanceValue -= 50.0;
					this.baseHPResistances.freezing.resistanceValue -= 50.0;
				}
			}
			
			if (this.hasStatusEffect("Gigafire") && CombatManager.getRoundCount() > this.statusEffectv3("Gigafire") + 1 || this.isImmobilized() || this.hasStatusEffect("Blinded")) {
				output("Her powerful spell was interrupted!\n");
				this.removeStatusEffect("Gigafire");
				this.isLustImmune = false;
				this.armor.evasion += 100;
			}
			
			if (this.hasStatusEffect("Sandstorm"))
				if(!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)))
				{
					if(rand(4) == 0) {
						output("You eyes are full of sand and you barely can see!");
						target.createStatusEffect("Blinded", 2, 0, 0, 0, false, "Blind", "You're blinded by sand and cannot see! Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0);
						output("\n");
					}
					output("Raging sandstorm is fleecing you!  ");
					applyDamage(new TypeCollection( { kinetic : 1 } ), this, target);
					output("\n");
				} else {
					output("Your sealed armor keeps sand outside!\n");
				}
			else {
				sandWitchMotherSandStormAttack(target);
				return;
			}
			
			if (this.hasStatusEffect("Gigafire")) {
				sandWitchMotherGigaFire2(target);
				return;
			}
			
			var choices:Array = [];
			if(!target.hasStatusEffect("Whispered")) choices[choices.length] = sandWitchMotherGetWhispered;
			choices[choices.length] = sandWitchMotherEatALightningBolt;
			choices[choices.length] = sandMotherTelekinesis;
			choices[choices.length] = sandWitchMotherGigaFire;
			if(!this.hasStatusEffect("Earth Ehield")) choices[choices.length] = sandWitchMotherEarthShield;
			choices[rand(choices.length)](target);
		}
		//Earthshield
		public function sandWitchMotherEarthShield(target:Creature):void {
			//Surrounds the witch a vortex of stones, raising her defense greatly and conferring 25% block to standard attacks.
			output("Lowering her scepter towards the ground, the eight-foot tall sorceress suddenly grunts, lifting it as if carrying great weight.  As the small staff passes her chest, bits of stone and rock begin to lift out of the ground, accelerating into a vortex of earth that spins around her.  <b>It's going to be harder to hit her with physical attacks now!</b>");
			this.createStatusEffect("Earth Ehield", 3, 0, 0, 0, false, "DefenseUp", "Earth shield protects her!", true);
			this.baseHPResistances.kinetic.resistanceValue += 50.0;
			this.baseHPResistances.electric.resistanceValue += 50.0;
			this.baseHPResistances.burning.resistanceValue += 50.0;
			this.baseHPResistances.corrosive.resistanceValue += 50.0;
			this.baseHPResistances.freezing.resistanceValue += 50.0;
		}

		//*GigaFire
		public function sandWitchMotherGigaFire(target:Creature):void {
			//Begins focusing into her staff, which floats in front of her.  PC disrupt attack by attacking.  Attack hits at half strength if disrupted.
			output("Releasing the scepter, the Sand Mother spreads her hands, each glowing with eldritch, white flames.  Her heels slowly float up off the ground as she closes her eyes in concentration.  You can sense the power and heat rolling off her in waves, and if you don't do something to disrupt her, you'll likely be burned to a crisp.");
			if (target.IQ() > 40) output("  She's not even looking at you and seems steeled against lusty interruptions.  Perhaps you can hit her hard enough to shatter her concentration.");
			this.createStatusEffect("Gigafire", this.HP(), this.lustQ(), CombatManager.getRoundCount(), 0, false, "OffenseUp", "She is preparing something huge!", true);
			this.isLustImmune = true; // not looking and can not be teased
			this.armor.evasion -= 100; // but also can't evade
		}

		public function sandWitchMotherGigaFire2(target:Creature):void {
			var damage:int = 40 + rand(11);
			//Not interrupted:
			if(this.statusEffectv1("Gigafire") < this.HP() + 10 /*&& this.statusEffectv2("Gigafire") > this.LQ() - 10*/) { // not more than 10 points of damage inflicted during casting phase
				output("The Sand Mother grabs her scepter in both hands, combining the flames that wreath them into an immense, blinding conflagration.  She points at you, and the fire washes out in a wave like a serpent, twisting at you as you try to avoid it, doubling back on itself whenever it misses.  It's unavoidable!  You're enveloped in the consuming fire!");
				damage *= 3;
			}
			//Interrupted:
			else {
				output("Thumbling back to the ground from your damaging hit, the Sand Mother grabs at her head, one flame going out.  She recovers in time to grab the staff and fling it towards you, but it's at a fraction of the strength she intended.  Still, it burns all the same. ");
			}
			applyDamage(new TypeCollection( { burning : damage } ), this, target);
			this.removeStatusEffect("Gigafire");
			this.isLustImmune = false;
			this.armor.evasion += 100;
		}
			
		//*Telekinesis
		//Throws the PC against the wall.  Does more damage to shorter, thinner PCs.
		public function sandMotherTelekinesis(target:Creature):void {
			output("She narrows her eyes at you, and an immense, magical pressure reaches out, taking hold of you");
			
			var sizeMod:Number = 100;
			var thickMod:Number = target.thickness / 100 + 0.5;
			var tallMod:Number = target.tallness;
			if(target.isDrider()) tallMod *= 2;
			else if (target.isTaur()) tallMod *= 3;
			else if (target.isNaga() || target.isGoo()) tallMod *= 1.5;
			sizeMod += tallMod * thickMod;
			if (sizeMod < 140)
				output(".  It spins you in the air before slamming you into the walls!  You immediately wish you weren't so light, as you're sure she couldn't have flung a heavier champion nearly as easily.  ");
			else if (sizeMod >= 500) {
				output(".   Futile attempt - your mass is immense!  She gave up after a few inches of lifting, causing no damage.  "); {
				return;
			}
			}
			else if (sizeMod >= 200)
				output(".  It drags you through the air before slamming you into the wall!  You're glad for your mass, as she couldn't seem to accelerate you into the stone as fast as she'd like.  Sometimes eating plenty pays off.  ");
			else
				output(" and throwing you into the wall!  ");
			//0 thickness, 4' tall: 124
			//100 thickness, 4' tall: 172
			//0 thickness, 6' tall: 136
			//100 thickness, 6' tall: 208
			//0 thickness, 8' tall: 148
			//100 thickness, 8' tall: 244
			var multiplier:Number = sizeMod / 170;
			var damage:Number = 20;
			damage = multiplier * damage;
			applyDamage(new TypeCollection( { kinetic : damage }, DamageFlag.CRUSHING ), this, target);
		}

		//*Lightning Bolt
		//Unavoidable magic damage.
		public function sandWitchMotherEatALightningBolt(target:Creature):void {
			output("Holding her staff back, she lifts her free hand with her fingers outstretched in a fan.  Sparks dance between her slender digits, coiling around them like snakes.  In a flash, they rush to her palm and erupt in a lightning bolt, striking you instantly and unavoidably!  ");
			applyDamage(new TypeCollection( { electric : 30 + rand(10) } ), this, target);
		}
		//*Whisper:
		//As ackbal, stuns the PC 1 round.  Cannot be resisted.
		public function sandWitchMotherGetWhispered(target:Creature):void {
			output("Mouthing, \"<i>Can you hear me?</i>\" the witch's voice intrudes into your mind, matching her mouth word for word.  She floods your psyche with words and thoughts, all of your defeat or submission, each more degrading and more humiliating than the last.  Perhaps the worst are the ones where she turns you over to Lethice after you're broken...  The tumultous thoughts and emotions both stun and arouse you, preventing you from attacking while you try to clear your beleaguered consciousness.  ");
			applyDamage(new TypeCollection( { psionic : 15 + (100 - target.WQ()) / 10 } ), this, target);
			target.createStatusEffect("Stunned", 1, 0, 0, 0, false, "Stun", "Whispers in your head are preventing you from focusing on combat!", true, 0);
			//target.createStatusEffect("Whispered", 0, 0, 0, 0, false, "LustUp", "!", true);
		}
		public function sandWitchMotherSandStormAttack(target:Creature):void {
			output("With a smirk, the Sand Mother decrees, \"<i>You fight not just me, but the shifting sands as well.</i>\"  She casually flicks her wrist, and sand rises up from the floors, the walls, everywhere really.  It begins to spin about, blown by an unseen wind, and the entire chamber is wreathed in a shifting sandstorm.  The grit constantly tries to get into your eyes.  It's likely you're going to be blinded by it every now and then.");
			this.createStatusEffect("Sandstorm", 0, 0, 0, 0, false, "Icon_Confused", "Room is filled by cloud of sand!", true);
		}
	}
}