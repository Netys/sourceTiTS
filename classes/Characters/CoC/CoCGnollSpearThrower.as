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
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.Items.Transformatives.CoCDyes.CoCDyeBlack;
	import classes.Items.Transformatives.CoCDyes.CoCDyeBrown;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCGnollSpearThrower extends Creature
	{
		public function CoCGnollSpearThrower() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "gnoll spear-thrower";
			this.originalRace = "gnoll";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "You are fighting a gnoll.  An amalgam of voluptuous, sensual lady and snarly, pissed off hyena, she clearly intends to punish you for trespassing.  Her dark-tan, spotted hide blends into a soft cream-colored fur covering her belly and two D-cup breasts, leaving two black nipples poking through the fur.  A crude loincloth is tied around her waist, obscuring her groin from view.  A leather strap cuts between her heavy breasts, holding a basket of javelins on her back.  Large, dish-shaped ears focus on you, leaving no doubt that she can hear every move you make.  Sharp, dark eyes are locked on your body, filled with aggression and a hint of lust.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "teeth";
			this.meleeWeapon.attackVerb = "bite";
			this.meleeWeapon.attackNoun = "bite";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 1;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.rangedWeapon.longName = "javelin";
			this.rangedWeapon.attackVerb = "javelin";
			this.rangedWeapon.attackNoun = "javelin";
			this.rangedWeapon.baseDamage.kinetic.damageValue = 10;
			this.rangedWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			this.rangedWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 65.0;
			//baseHPResistances.drug.resistanceValue = 65.0;
			//baseHPResistances.pheromone.resistanceValue = 65.0;
			//baseHPResistances.tease.resistanceValue = 65.0;
			
			this.armor.longName = "fur";
			this.armor.defense = 2;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 10;
			this.XPRaw = normalXP();
			this.credits = (10 + rand(5)) * 10;
			this.HPMod = 250;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 85 / 20 * this.level;
			this.reflexesRaw = 100 / 20 * this.level;
			this.aimRaw = 100 / 20 * this.level;
			this.intelligenceRaw = 50 / 20 * this.level;
			this.willpowerRaw = 50 / 20 * this.level;
			this.libidoRaw = 65;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 60;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "black";
			this.tallness = 72;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "black";
			this.scaleColor = "none";
			this.furColor = "tawny";
			this.hairLength = 22;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FUR;
			this.skinTone = "tawny";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_FELINE;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED]
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_FELINE;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_FELINE;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_FELINE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_PAWS, GLOBAL.FLAG_FURRED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_FELINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_FURRED];
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
			this.buttRatingRaw = 2;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 3;
			this.vaginas[0].wetnessRaw = 4;
			this.clitLength = 15;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 4; // D
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 25;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			if (rand(5) == 0) inventory.push(new CoCGroPlus());
			else if (rand(2) == 0) inventory.push(new CoCIncubiD());
			else inventory.push(new CoCDyeBrown());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			RandomInCollection(hyenaPhysicalAttack, hyenaJavelinAttack, hyenaSnapKicku, hyenaArousalAttack)(target);
		}
		
		private function hyenaPhysicalAttack(target:Creature):void {
			var damage:Number = 0;
			//Blind dodge change
			if(hasStatusEffect("Blinded") && rand(3) < 2) {
				output(capitalA + short + " completely misses you with a blind attack!\n");
				return;
			}
			//Determine if dodged!
			if(combatMiss(this, target)) {
				output("You see the gnoll's black lips pull back ever so slightly and the powerful muscles in her shapely thighs tense moments before she charges.  With a leap you throw yourself to the side, feeling the wind and fury pass through where you had just been standing.  You gracefully turn to face the hyena as she does the same, knowing that could have been very bad.  ");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			var d:TypeCollection = meleeDamage();
			damageRand(d, 15);
			var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
				
			if (damageResult.hpDamage == 0) {
				//Due to toughness or amor...
				output("You deflect and block every attack " + a + short + " throws at you.  ");
			}else if (damageResult.hpDamage < 10)
				output("The gnoll runs forward, fury in her dark eyes as twin fists glance off your chest.  The glancing blow sends her off balance and the flashing ivory jaws barely miss your throat.  You push back, stumbling away from the furious hyena.  ");
			else
				output("The gnoll rushes forward, almost too fast to detect before twin fists slam into your torso.  Before you can recover, ivory jaws flash before your eyes and you feel the sharp teeth start to clamp onto the [pc.skinFurScales] of your neck.  Blinding pain causes you to fling yourself backwards, away from the teeth and drawing angry scrapes as you escape the jaws.  You roll away before picking yourself up, the hyena moving confidently towards you as you try to shake off the pain from the blow.  ");
			outputDamage(damageResult);
			
			output("\n");
		}
		
		public function onCleanup():void {
			if (kGAMECLASS.pc.hasStatusEffect("Gnoll Spear")) {
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv1("Gnoll Spear"));
				kGAMECLASS.pc.removeStatusEffect("Gnoll Spear");
			}
		}
		
		//<Writers note: I recommend that the javelin have a chance to greatly decrease speed for the remaining battle.  I am writing the flavor text for this event if you choose to include it>
		private function hyenaJavelinAttack(target:Creature):void {
			var slow:int = 0;
			//<Hyena Attack 2 – Javelin – Unsuccessful – Dodged>
			//Blind dodge change
			if(hasStatusEffect("Blinded") && rand(3) < 2) {
				output("The gnoll pulls a javelin from behind her and throws it at you, but blind as she is, it goes wide.");
			}
			//Determine if dodged!
			else if(rangedCombatMiss(this, target)) {
				output("The gnoll pulls a long, dark wooden javelin from over her shoulder.  Her spotted arm strikes forward, launching the missile through the air.  The spear flashes through the distance towards your vulnerable form.  Even as you see doom sailing towards you, a primal instinct to duck pulls you down, and you feel the wind from the massive missile as it passes close to your ear.");
			}
			else {
				var d:TypeCollection = this.rangedDamage();
				damageRand(d, 15);
				var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
				
				//<Hyena Attack 2 – Javelin – Unsuccessful – Absorbed>
				if(damageResult.hpDamage == 0) {
					output("The gnoll pulls a long, dark wooden javelin from over her shoulder.  Her spotted arm strikes forward, launching the missile through the air.  The spear flashes through the air, but glancing blow slides without doing any damage.  It disappears into the grass.  ");
				}
				//<Hyena Attack 2 – Javelin – Successful – Player Entangled>
				else if(rand(3) >= 1) {
					output("The gnoll pulls a long, black javelin from over her shoulder.  Her spotted arm strikes forward, launching the missile through the air.  You attempt to dive to the side, but are too late.  The powerful shaft slams, hard, into your back.  Pain radiates from the powerful impact.  Instead of piercing you, however, the tip seems to explode into a sticky goo that instantly bonds with your [pc.gear].  The four foot, heavy shaft pulls down on you awkwardly, catching at things and throwing your balance off.  You try to tug the javelin off of you but find that it has glued itself to you.  It will take time and effort to remove; making it impossible to do while a dominant hyena stalks you.  ");
					if (!target.hasStatusEffect("Gnoll Spear")) target.createStatusEffect("Gnoll Spear", 0, 0, 0, 0, false, "Icon_Slow", "You are slowed down by javelin!");
					slow = 0.15 * target.reflexesMax();
					while(slow > 0 && target.reflexes() > 2) {
						slow--;
						target.addStatusValue("Gnoll Spear", 1, 1);
						target.reflexes( -1);
					}
				}
				//<Hyena Attack 2 – Javelin – Successful – Player Not Entangled>
				else {				
					output("The gnoll pulls a long, dark wooden javelin from over her shoulder.  Her spotted arm strikes forward, launching the missile through the air.  The javelin flashes through the intervening distance, slamming into your chest.  The blunted tip doesn't skewer you, but pain radiates from the bruising impact.  ");
				}
			
				outputDamage(damageResult);
			}
		}
		
		//<Writer's Note: With the third attack, I intend that the damage be increased based on the breast size of the pc.  Thus, the text will vary if the player is flat-chested as indicated by colored text.>
		private function hyenaSnapKicku(target:Creature):void {
			//Blind dodge change
			if(hasStatusEffect("Blinded") && rand(3) < 2) {
				output("The gnoll tries to catch you with a brutal snap-kick, but blind as she is, she completely misses.  ");
			}
			//Determine if dodged!
			if(combatMiss(this, target)) {
				output("The gnoll grins at you before striding forward and pivoting.  A spotted leg snaps up and out, flashing through the air towards your [pc.chest].  You step back just in time, robbing the blow of force.  The paw lightly strikes your torso before the female hyena springs back, glaring at you.  ");
			}
			//Determine damage - str modified by enemy toughness!
			else {
				var d:TypeCollection = this.meleeDamage();
				d.add(Math.min(target.biggestTitSize(), 20));
				damageRand(d, 15);
				var damageResult:DamageResult = calculateDamage(d, this, target, "melee");
				
				//No damage
				if(damageResult.hpDamage == 0) {
					output("The gnoll tries to catch your [pc.chest] with a snap-kick, but you manage to block the vicious blow.");
				}
				//<Hyena Attack 3 – Snap Kick – Successful>
				else {
					output("A glint enters the dark eyes of the gnoll before she strides forward and pivots.  A long, spotted leg snaps up and out to slam against your [pc.chest]");
					if(target.biggestTitSize() >= 1) output(", sending a wave of pain through the sensitive flesh");
					output(".  A small, traitorous part of you can't help but notice a flash of long, dark flesh beneath her loincloth even as you stagger back from the impact.  ");
				}
				
				outputDamage(damageResult);
			}
		}
		
		private function hyenaArousalAttack(target:Creature):void {
			//Success = cor+lib > rand(150)
			var chance:Number = rand(150);
			//<Hyena Attack 4 – Arousal Attack – Highly Successful>
			if(target.cor() + target.libido() > chance + 50) {
				output("A wry grin spreads across the gnoll's face before she sprints towards you.  Too fast to follow, she flies forward, and you desperately brace for an impact that doesn't come.  Instead of striking you, two spotted paws clamp behind your neck and pull your head down, planting your face against her leather loincloth.  A powerful, musky smell burns in your nose and the feel of firm flesh behind the flimsy leather leaves a tingling sensation along your face.  She holds you there, pressed against her groin for several moments, desire growing deep within your body, before you find the strength and will to pull away.  The amazon grins, letting you stumble back as you try to fight off the feel of her body.  ");
				applyDamage(new TypeCollection( { tease : 25 + target.libido() / 20 + target.libido() / 5 } ), this, target);
			}
			//<Hyena Attack 4 – Arousal Attack – Mildly Successful>
			else if(20 + target.cor() + target.libido() > chance) {
				output("A lazy grin spreads across the gnoll's face before she sprints towards you.  Too fast to follow, she flies forward, and you desperately brace for an impact that doesn't come.  Instead of striking you, two spotted paws clamp behind your neck and pull your head down, planting your face against her leather loincloth.  A powerful, musky smell burns in your nose and the feel of firm flesh behind the flimsy leather leaves a tingling sensation along your face.  Instinctively, you tear away from the hold, stumbling away from the sensations filling your mind, though some desire remains kindled within you.  ");
				applyDamage(new TypeCollection( { tease : 15 + target.libido() / 20 + target.libido() / 5 } ), this, target);
			}
			//<Hyena Attack 4 – Arousal Attack – Unsuccessful>
			else {
				output("A knowing glint fills the dark eyes of the gnoll before she sprints forward.  Your muscles tense as she reaches you and starts to lock two spotted paws behind your neck.  She pulls you down towards her musky crotch, but just as you brush her loincloth, you twist away.  The hyena snarls in frustration, and you're left wondering if that was her idea of foreplay.  ");
			}
		}
	}
}