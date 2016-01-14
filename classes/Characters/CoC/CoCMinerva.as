package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Apparel.CoCTubeTop;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCMinerva extends Creature
	{
		public function CoCMinerva() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Minerva";
			this.originalRace = "siren";
			this.a = "";
			this.capitalA = "";
			this.long = "You're fighting the tainted siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a dark navy blue, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  Orange and white stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing red and orange mix.  She wears a tube-top that hold back her double d-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "halberd";
			this.meleeWeapon.attackVerb = "slash";
			this.meleeWeapon.attackNoun = "slash";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 30;
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 80.0;
			//baseHPResistances.drug.resistanceValue = 80.0;
			//baseHPResistances.pheromone.resistanceValue = 80.0;
			//baseHPResistances.tease.resistanceValue = 80.0;
			
			this.armor = new CoCTubeTop();
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1000;
			this.level = 16;
			this.credits = (rand(25) + 10) * 10;
			this.HPMod = 470;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 50 / 20 * this.level;
			this.reflexesRaw = 95 / 20 * this.level;
			this.aimRaw = 95 / 20 * this.level;
			this.intelligenceRaw = 75 / 20 * this.level;
			this.willpowerRaw = 75 / 20 * this.level;
			this.libidoRaw = 30;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 8 * 12 + 4;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "red";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 25;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "blue";
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
			this.wingType = GLOBAL.TYPE_AVIAN;
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
			this.buttRatingRaw = 9;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(16);
			this.shiftCock(0, GLOBAL.TYPE_ANEMONE);
			
			this.balls = 2;
			this.ballSizeRaw = 3;
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 3;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 6; // DD
			
			this.nippleColor = "green";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 0;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			
			//this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [new CoCPurePeach()];
			
			
			if (flags["COC.MINERVA_PURIFICATION_PROGRESS"] >= 10) {
				this.long = "You're fighting the purified siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a golden yellow, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  White stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing white and .  She wears a tube-top that hold back her G-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.";
				//cor = 0; //Set to 0 corruption if purified.
				this.breastRows[0].breastRatingRaw = 16; // G
				this.ballSizeRaw += 2;
			}
			
			if (flags["COC.MINERVA_CORRUPTION_PROGRESS"] >= 10) {
				this.long = "You're fighting the corrupted siren, Minerva.";
				//cor = 80; //Set to 80 corruption if corrupted.
				this.breastRows[0].breastRatingRaw = 8; // E
				this.ballSizeRaw += 2;
				this.createCock(16);
				this.shiftCock(1, GLOBAL.TYPE_ANEMONE);
			}
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (findStatusAffect(StatusAffects.SirenSong) >= 0) sirensSong();
			else if (rand(25) == 0 || (HP < 100 && rand(2) == 0)) sirensSong();
			//Else choose randomly!
			else {
				var choices:Array = [lickDatPole,
					bootyShortInYoFaceSon,
					kiteFire,
					minervaUsesHalberdCHOP,
					minervaUsesHalberdStab,
					tailWhip,
					minervaKnowsKungfu,
					minervaBite];
				choices[rand(choices.length)]();
			}
		}
		
		//Normal Attacks for all Minerva Types
		//Shark-bite:
		private function minervaBite():void
		{
			output("The siren paces around you in circles, waiting for the right moment to strike.  Unexpectedly quick thanks to her clawed feet, she propels herself toward you at full speed.  Her maw opens wide to chomp on you, showing off multiple rows of glinting, razor-sharp teeth.");
			var damage:int = int((str + 85) - rand(pc.tou) - pc.armorDef);
			if (pc.getEvasionRoll()) {
				output("  You get out of the way just in time, Minerva making a loud chomping sound as she only catches the air.");
			}
			else if (combatBlock(true)) {
				output("  You raise your " + pc.shieldName + " just in time, deflecting her bite.");
			}
			//[else block]
			else if (damage <= 0) output("  Your hands lash out, knocking her head to the side as she tries to bite you.  With the bite deflected, Minerva makes a loud chomping sound as she only bites the air.");
			//[if attack lands]
			else {
				output("  Her teeth dig right into your arm!  It's a bit of a struggle, but you're able to free yourself.  The damage doesn't look too serious. ");
				pc.takeDamage(damage, true);
			}
			combatRoundOver();
		}

//Flying kick:
		private function minervaKnowsKungfu():void
		{
			output("The blue beauty flaps her wings and launches herself into the air.  Once she's gained as much altitude as she can, she dive-bombs you, her demon-clawed feet leading the attack.");

			var damage:int = int((str + weaponAttack + 100) - rand(pc.tou) - pc.armorDef);
			spe -= 70;
			if (pc.getEvasionRoll()) {
				output("  You jump out of the landing zone just in time, piles of dirt exploding in all directions as Minerva slams into the ground.");
			}
			//[else block]
			else if (damage <= 0) output("  Steadying yourself, you reach up, grabbing hold of Minerva as she attempts to land a heavy blow on you.  Grunting hard, you pull against her and toss the siren aside completely, halting her attack.");
			//[if attack lands]
			else {
				output("  She hits you square in the chest, knocking you to the ground as her entire weight lands on you.  The bombshell of a woman jumps off your chest, ready to keep fighting. ");
				damage = pc.takeDamage(damage, true);
			}
			spe += 70;
			combatRoundOver();
		}

//Tail-whip
		private function tailWhip():void
		{
			var damage:int = int((str + 35) - rand(pc.tou) - pc.armorDef);

			output("She runs at you, holding the weapon like she's about to chop into your side.  You brace yourself, but when she's only a few feet away, she starts to turn her body.");
			//[else block]
			if (damage <= 0) output("  Lashing out with a fierce kick you intercept the tail-whip, your [foot] impacting against her strong appendage and totally neutralizing its momentum.");

			//[if attack lands]
			else {
				output("  Her shark tail whacks you, knocking you to the ground.  You quickly struggle back into position");
				if (pc.armorDef > 0) output(", but your defense has been reduced");
				output("! ");
				pc.takeDamage(damage, true);
				if (findStatusAffect(StatusAffects.TailWhip) >= 0) addStatusValue(StatusAffects.TailWhip, 1, 10);
				else createStatusAffect(StatusAffects.TailWhip, 10, 0, 0, 0);
			}
			combatRoundOver();
		}

//Halberd stab:
		private function minervaUsesHalberdStab():void
		{
			output("Minerva charges at you, brandishing her halberd's sharp tip toward you.");
			var damage:int = int((str + weaponAttack) - rand(pc.tou));

			if (pc.getEvasionRoll()) output("  You sidestep the attack just as she thrusts the point past your face.");

			//[else block]
			else if (damage < 0) output("  With all your strength, you swing your [pc.mainWeapon], the blow landing on the side of Minerva's halberd and deflecting the goring strike away from you.");

			//[if attack lands]
			else {
				output("  She pierces you right in the shoulder!  You wince in pain and step back, out of her reach again.");
				pc.takeDamage(damage, true);
			}
			combatRoundOver();
		}

//Halberd CHOP:
		private function minervaUsesHalberdCHOP():void
		{
			output("She moves in close, practically right in front of you and raises the halberd.");
			var damage:int = int((str + 100) - rand(pc.tou) - pc.armorDef);

			if (pc.getEvasionRoll()) output("  You get out of the way quickly, her attack chopping deeply into the earth. ");

			//[else block]
			else if (damage < 0) output("  In a mad show of pure skill, you lift your hands, clamping them down on the cheeks of the halberd blade and stop Minerva's attack cold, bewildering the siren in the process.");

			//[if attack lands]
			else {
				output("  You don't have time to avoid the downward chop and the axe head lands right in your shoulder blade!  You cry out in pain, but you can still move your arm despite the brutal blow.");
				pc.takeDamage(damage, true);
			}
			combatRoundOver();
		}

//White Fire
		private function kiteFire():void
		{
			output("The siren holds her hand out, flashing you a cunning smirk and snapping her fingers.  Your entire body is engulfed in white-hot flames, searing flesh and burning your [pc.gear].  The sudden flash of heat and fire elicit panic from deep within you, causing you to cry out and roll on the ground to put the fires out.  The burns aren't too severe, but you know you can't keep getting hit like that! ");
			var damage:int = int(10 + (inte / 3 + rand(inte / 2)) * 1.5);
			pc.takeDamage(damage, true);
			combatRoundOver();
		}

//Lust Attacks for tainted Minerva
//Booty-shorts
		private function bootyShortInYoFaceSon():void
		{
			output("The blue beauty turns around and bends over so far that she uses her halberd like a pole to support herself.  She lifts her shark tail up so you can see her short-shorts hugging perfectly against her ample bottom.  Her tail waves to the left and to the right as she does a little booty shake for you.  The siren gives her big ass a nice, hard slap that echoes off the tower walls, and making it jiggle even more.  She quickly turns around to face you, smirking at what she just did. ");
			game.dynStats("lus", 20 + pc.lib / 10 + rand(5));
			combatRoundOver();
		}

//Lust Attacks for all Minervas
//Pole licking
		private function lickDatPole():void
		{
			output("Minerva stands, holding her halberd straight up next to her as she looks it over with a seductive stare.  Giving you a suggestive look she rolls out a two-foot long tongue from her mouth, licking a good length of the massive weapon, even wrapping her tongue around it a few times.  Suddenly she sucks her tongue back into her mouth and gives you a little smirk, almost to say \"<i>Yeah, I can do that... and more.</i>\" ");
			game.dynStats("lus", 20 + pc.lib / 10 + rand(5));
			combatRoundOver();
		}

//Special attack
		private function sirensSong():void
		{
			//The Siren's Song (2-part attack) (Rarely used or when she's desperate aka: Less than 10% hp)
			//[part 1]
			if (findStatusAffect(StatusAffects.SirenSong) < 0) {
				output("Minerva begins to hum a pleasant tune.  It might be better to stand back to see what she's up to!");
				createStatusAffect(StatusAffects.SirenSong, 0, 0, 0, 0);
			}
			//[part 2]
			else {
				output("Her hum becomes a song.  A magnificent song without words, a sound that should be impossible for any human, or creature for that matter, to make naturally.");
				//If wait:
				if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) output("  You cover your ears before she even opens her lips, wary of its power.  Judging by the dim feeling of pleasure simmering through you with the little sound you're picking up regardless, it probably was for the better.");
				//No wait - insta loss:
				else {
					output("  Your mind clouds over as the song flows through your ears and fills your mind with sweet bliss.  You lower your [pc.mainWeapon] and dreamily walk into the siren's sweet embrace.  You absent-mindedly disrobe yourself as you move in closer, the song getting louder with each step you take, until you finally bury yourself into the siren's soft bosom and she wraps her feathery arms around your body.  She stops singing her beautiful song and whispers into your ear, \"<i>You're all mine now.</i>\"");
					game.dynStats("lus", 999);
				}
				removeStatusAffect(StatusAffects.SirenSong);
			}
			combatRoundOver();
		}
	}
}