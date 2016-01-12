package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.Items.Transformatives.CoCDyes.CoCDyeBlack;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCGnoll extends Creature
	{
		public function CoCGnoll() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "gnoll";
			this.originalRace = "gnoll";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "This lanky figure is dappled with black spots across rough, tawny fur. Wiry muscle ripples along long legs and arms, all of it seeming in perpetual frenetic motion: every moment half flinching and half lunging.  The head bears a dark muzzle curled in a perpetual leer and bright orange eyes watching with a savage animal cunning.  Between the legs hang what appears at first to be a long, thin dong; however, on closer inspection it is a fused tube of skin composed of elongated pussy lips and clitoris.  The hyena girl is sporting a pseudo-penis, and judging by the way it bobs higher as she jinks back and forth, she's happy to see you!\n\nShe wears torn rags scavenged from some other, somewhat smaller, creature, and in one hand clutches a twisted club.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "twisted club";
			this.meleeWeapon.attackVerb = "smash";
			this.meleeWeapon.attackNoun = "smash";
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 65.0;
			//baseHPResistances.drug.resistanceValue = 65.0;
			//baseHPResistances.pheromone.resistanceValue = 65.0;
			//baseHPResistances.tease.resistanceValue = 65.0;
			
			this.armor.longName = "fur";
			this.armor.defense = 2;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1000;
			this.level = 14;
			this.credits = (10 + rand(5)) * 10;
			this.HPMod = 250;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 80 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 60 / 20 * this.level;
			this.libidoRaw = 65;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 6 * 12;
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
			this.clitLength = 12;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 3; // C
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			if (rand(5) == 0) inventory.push(new CoCReducto());
			else if (rand(2) == 0) inventory.push(new CoCSucMilk());
			else inventory.push(new CoCDyeBlack());
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (rand(2) == 0) gnollTease(target);
			else {				
				//Blind dodge change
				if (hasStatusEffect("Blind") && rand(3) < 2) {
					output(capitalA + short + " completely misses you with a blind attack!\n");
				}
				//Determine if dodged!
				else if (combatMiss(this, target)) {
					output("You dodge " + a + short + "'s " + this.meleeWeapon.attackVerb + " with superior quickness!\n");
				}
				else {
					var d:TypeCollection = meleeDamage();
					if (d.getTotal() < 1) {
						//Due to toughness or amor...
						output("You deflect and block every " + this.meleeWeapon.attackVerb + " " + a + short + " throws at you.");
					}
					else {
						var attack:Number = rand(6);
						var damage:Number = 0;
						//Gnoll Attack #1
						if (attack == 0) {
							output("The gnoll leaps forward, her jaws slamming shut across your upper arm.  She twists away before you can touch her, laughing the entire time.");
							damage += 10;
						}
						//Gnoll Attack #2
						else if (attack == 1) {
							output("With a shudder and lurch, the gnoll barrels forward into your gut, the claws of her free hand raking across your belly.");
							damage += 3;
						}
						//Gnoll Attack #3
						else if (attack == 2) {
							output("The gnoll tumbles to the ground, then comes up with a handful of sand.  The sand goes in your face; the club goes into your cheek.  Ow.");
							damage += 13;
						}
						//Gnoll Attack #4
						else if (attack == 3) {
							output("The hyena girl giggles and darts forward, teeth snapping.  Spittle flies everywhere, and the snapping teeth find purchase, drawing red lines across your body.");
							damage += 8;
						}
						//Gnoll Attack #5
						else if (attack == 4) {
							output("With a mocking laugh, the gnoll brings her club high and then down in a savage strike that catches you across the temple.");
							damage += 25;
						}
						//Gnoll Attack #6
						else {
							output("The gnoll waves her club threateningly, but it's her foot that snaps up from the dusty plain to connect with your gut.");
						}
						output(" ");
						d.add(damage);
						damageRand(d, 15);
						applyDamage(d, this, target, "melee");
					}
				}
			}
		}
		
		private function gnollTease(target:Creature):void {
			var tease:Number = rand(6);
			var bonus:Number = 0;
			//Gnoll Tease #1
			if(tease == 0) {
				output("The gnoll takes a moment to stretch her sleek, athletic body.  Her free hand runs up her side and she leers knowingly at you.  ");
				bonus += 5;
			}
			//Gnoll Tease #2
			else if(tease == 1) {
				output("With one hand, the hyena girl grasps her eight-inch clitoris and strokes it.  \"<i>I know you're curious!</i>\" she laughs.  \"<i>You want to try this.</i>\"  ");
				bonus += 5;
			}
			//Gnoll Tease #3
			else if(tease == 2) {
				output("The gnoll bounds forward, but instead of clobbering you she slides her lithe body against yours.  \"<i>We don't have to fight,</i>\" she titters.  \"<i>It's lots easier if I just fuck you.</i>\"  ");
				bonus += 10;
			}
			//Gnoll Tease #4
		 	else if(tease == 3) {
				output("The gnoll slides her fingers down the length of her pseudo-penis and collects the cream that drips from its end.  With two steps, she's inside your guard, but all she does is wave her hand in front of your nose.  The reek of sex nearly bowls you over.  ");
				bonus += 12;
			}
			//Gnoll Tease #5
			else if(tease == 4) output("\"<i>I love outlanders,</i>\" the gnoll confides in you as she circles.  \"<i>You have such interesting cries when you get fucked in a new way.</i>\"  She laughs, and the sound is far louder than it has any right to be.  ");
			//Gnoll Tease #6
			else {
				output("The gnoll dances forward, then back, her whole body alive with sensual movement.  She catches the way you watch her and smirks, throwing in a hip-shake just for you.  ");
				bonus += 6;
			}
			applyDamage(new TypeCollection( { tease : (bonus + target.libido() / 20 + rand(target.cor() / 20)) } ), this, target);
		}
	}
}