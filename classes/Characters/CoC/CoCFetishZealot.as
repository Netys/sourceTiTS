package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCLustDagger;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCFetishZealot extends Creature
	{
		public function CoCFetishZealot() 
		{	
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "fetish zealot";
			this.originalRace = "human";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.";
			this.customDodge = "";
			this.customBlock = "";
			
			//this.meleeWeapon = new CoCLustDagger();
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "wavy dagger";
			this.meleeWeapon.attackVerb = "stab";
			this.meleeWeapon.attackNoun = "stab";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 3;
			this.meleeWeapon.baseDamage.addFlag(DamageFlag.PENETRATING);
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 25.0;
			baseHPResistances.drug.resistanceValue = 25.0;
			baseHPResistances.pheromone.resistanceValue = 25.0;
			baseHPResistances.tease.resistanceValue = 25.0;
			
			this.armor.longName = RELIGIOUS_CLOTHES;
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 200;
			this.level = 5;
			this.credits = (5 + rand(10)) * 10;
			this.HPMod = 20;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 35 / 20 * this.level;
			this.reflexesRaw = 30 / 20 * this.level;
			this.aimRaw = 30 / 20 * this.level;
			this.intelligenceRaw = 1 / 20 * this.level;
			this.willpowerRaw = 1 / 20 * this.level;
			this.libidoRaw = 75;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 25;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 6 * 12;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "black";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 4;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "tan";
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
			this.hipRatingRaw = 1;
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
			this.createCock(7);
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 3;
			this.ass.bonusCapacity = 40;
			
			//this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	GLOBAL.KINDA_LIKES_SEXPREF);
			
			if(rand(10) < 4)
				inventory.push(kGAMECLASS.WeightedRandom(
							[new CoCLustDagger(), new CoCLustDraft()], // TODO: C_CLOTH with weight 1
							[1,                   4]));
			
			this._isLoading = false;
		}

		private static const RELIGIOUS_CLOTHES:String = "religious clothes";
		private static const PIRATE_CLOTHES:String = "pirate clothes";
		private static const MILITARY_CLOTHES:String = "military clothes";
		private static const LEATHER_CLOTHES:String = "leather clothes";
		private static const STUDENTS_CLOTHES:String = "student's clothes";
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var changed:Boolean = false;			
			//Fetish Zealot Update!
			switch (rand(5)) {
				case 0:
					//Religious outfit!
					if (armor.longName != RELIGIOUS_CLOTHES) {
						long = "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none of them included the large slit at the front that lets his above average sized human dick stick out of the front.";
						this.armor.longName = RELIGIOUS_CLOTHES;
						changed = true;
					}
					break;
				case 1:
					//Pirate Outfit
					if (armor.longName != PIRATE_CLOTHES) {
						this.armor.longName = PIRATE_CLOTHES;
						long = "You are faced with one of the strangest things you have ever seen in your life.  A stereotypical pirate, who has not replaced his hand with a hook, but rather a collection of sex toys.  You can see at least two dildos, a fleshlight, and numerous other toys that you're incapable of recognizing.";
						changed = true;
					}
					break;
				case 2:
					//Military Uniform
					if (armor.longName != MILITARY_CLOTHES) {
						long = "In front of you is someone wearing a green military uniform.  They obviously aren't in any military you've ever heard of, as on his shoulder he has emblazoned <i>FF Army Sex Instructor</i>.  It seems you are his latest recruit...";
						this.armor.longName = MILITARY_CLOTHES;
						changed = true;
					}
					break;
				case 3:
					//Leather fetish shiiiiite
					if (armor.longName != LEATHER_CLOTHES) {
						long = "The Zealot has taken on an appearance that seems more suitable for the level of perversion he exudes.  He is wearing a full-body suit of leather, with a cock case over his crotch; you can clearly see a large zipper on it.  The zipper handle is far bigger than you think is absolutely necessary.";
						this.armor.longName = LEATHER_CLOTHES;
						changed = true;
					}
					break;
				case 4:
					//Student
					if (armor.longName != STUDENTS_CLOTHES) {
						long = "The Zealot seems to have taken on the appearance of a young adult wearing a student uniform of sorts; of course, this isn't any less perverted than any of the other costumes this man wears.  This one includes a number of loose straps that you're certain would cause large sections of his clothes to fall off if somebody pulled on them.";
						this.armor.longName = STUDENTS_CLOTHES;
						changed = true;
					}

					break;
			}
			
			//Talk abouts it mang!
			if(changed) output("The fetish zealot's clothing shifts and twists, until he is wearing " + this.armor.longName + ".\n\n");
			lust(5);
			
			if (rand(3) != 0) lustDaggerAttack(target); // 66% to use dagger
			else if (rand(2) == 0) zealotSpecial1(target); // else even chances to use specials
			else zealotSpecial2(target);
		}
		
		
		private function lustDaggerAttack(target:Creature):void
		{
			var before:Number = target.HP();
			CombatAttacks.SingleMeleeAttackImpl(this, target);
			if (target.HP() < before) {
				output("\nYou notice that some kind of unnatural heat is flowing into your body from the wound");
				if (target.IQ() > 50) output(", was there some kind of aphrodisiac on the knife?");
				else output(".  ");
				
				applyDamage(new TypeCollection( { drug : target.libido() / 20 + 5 } ), this, target);
			}
		}
		
		//Special1: Tease
		//See Costumes section for text
		private function zealotSpecial1(target:Creature):void {
			//Costumes
			//This foe periodically switches between outfits; this determines what text is displayed when they use tease.
			
			//Perverted religious costume;
			if(armor.longName == RELIGIOUS_CLOTHES) {
				//The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.
				output("The zealot cries out \"<i>Child, are you ready to present your offering to the holy rod?</i>\" while indicating his [enemy.cock] sliding between his robes.  The whole scene leaves you distracted for a few moments and significantly aroused.  ");
			}	
			//A pirate costume; 
			if(armor.longName == PIRATE_CLOTHES) {
				//You are faced with one of the strangest things you have ever seen in your life.  A stereotypical pirate, who has not replaced his hand with a hook, but rather a collection of sex toys.  You can see at least two dildos, a fleshlight, and numerous other toys that you're incapable of recognizing.
				output("The zealot turns to the side holding his prosthetic towards you and doing something that sends the devices spinning and clicking.  <i>So that's how that would work...<i> you find yourself thinking for a few moments before realizing that he had both distracted and aroused you.  ");
			}
			//Military attire;
			if(armor.longName == MILITARY_CLOTHES) {
				//In front of you is someone wearing a green military uniform.  They obviously aren't in any military you've ever heard of, as on his shoulder he has emblazoned <i>FF Army Sex Instructor</i>.  It seems you are his latest Recruit...
				output("He suddenly barks, \"<i>Let's see those genitals, soldier!</i>\" ");
				//[player is corrupt] 
				if(target.cor() > 50) output("You eagerly cry out \"<i>Yes, sir!</i>\" and show yourself off to the best of your ability.  The whole act is extremely arousing.  ");
				//[player is not corrupt] 
				else output("You have no idea why, but you promptly display yourself in the most provocative way possible.  After a moment you realize what you're doing and quickly stop, flushed with embarrassment and arousal.  ");
			}
			//Gimp gear;
			if(armor.longName == LEATHER_CLOTHES) {
				//The Zealot has taken on an appearance that seems more suitable for the level of perversion he exudes.  He is wearing a full-body suit of leather, with a cock case over his crotch; you can clearly see a large zipper on it.  The zipper handle is far bigger than you think is absolutely necessary.
				output("The Zealot turns around and gives you a full view of his tight leather clad body.  He smacks his ass and says \"<i>You like what you see, don't you " + target.mf("stud","slut") + "?</i>\"  You can't help but be incredibly aroused by the scene.  ");
			}
			//Well dressed and well groomed student in uniform;
			if(armor.longName == STUDENTS_CLOTHES) {
				//The Zealot seems to have taken on the appearance of a young adult wearing a student uniform of sorts; of course, this isn't any less perverted than any of the other costumes this man wears.  This one includes a number of loose straps that you're certain would cause large sections of his clothes to fall off if somebody pulled on them.
				output("The Zealot student looks at you a little shyly and sticks a pencil in his mouth while pushing a hand in front of his groin, trying to hide a rather obvious bulge.  The whole scene is rather cute, and you feel incredibly aroused afterwards.  ");
			}
			
			applyDamage(new TypeCollection( { tease : 7 + rand(target.libido() / 20 + target.cor() / 20) } ), this, target);
		}
		
		//Special2: Lust transfer spell, it becomes more and 
		//more likely that he will use this power as his lust gets 
		//higher, but he can use it at any time (like the cultist).
		private function zealotSpecial2(target:Creature):void {
			output("The zealot suddenly cries out and extends his arms towards you; your mind is suddenly overwhelmed with a massive wave of arousal as images of every kind of fetish you can imagine wash over you, all blended together.  After a moment you are able to recover, but you notice that the Zealot doesn't seem to be as aroused as before. ");
			applyDamage(new TypeCollection( { psionic : lust() / 2 } ), this, target);
			lust(-(lust() / 2));
		}
	}
}