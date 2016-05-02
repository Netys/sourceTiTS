package classes.Characters.CoC 
{
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
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Armor.CoCChainmailBikini;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCScimitar;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCJeanClaude extends Creature
	{
		public function CoCJeanClaude() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Jean-Claude";
			this.originalRace = "basilisk";
			this.a = "";
			this.capitalA = "";
			this.long = "You are fighting Jean-Claude. He stands over seven feet tall and has a perfect frame, padded with hard, defined muscle despite not looking heavy on his feet in the slightest; the way he circles you, his thighs tensing and relaxing, his powerful tail swishing, ready to spring forward at the first hint of an opening, makes a deep, monkey part of your brain panic, warning you that you are battling an apex predator in his prime. He is dressed in a leather tunic, a bronze cuirass and a centurion’s helmet that combine to give him even more protection than his thick, green and purple mottled hide otherwise would. His eyes glow with a depthless yellow light, endlessly catching your own, enticing you to look further into them. He wields a stained-looking cutlass, which he swings by his side with mocking casualness as he moves; it mimics the movement of his dual, tumescent purple cocks, swaying beneath his tunic in crude suggestion.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 0;
			this.meleeWeapon.longName = "cutlass";
			this.meleeWeapon.attackVerb = "slash";
			this.meleeWeapon.attackNoun = "slash";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 30;
			this.meleeWeapon.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.psionic.resistanceValue = 40.0;
			baseHPResistances.drug.resistanceValue = 40.0;
			baseHPResistances.pheromone.resistanceValue = 40.0;
			baseHPResistances.tease.resistanceValue = 40.0;
			
			this.armor.longName = "leather tunic";
			this.armor.defense = 10;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 5000;
			this.level = 20;
			this.credits = (rand(55) + 300) * 10;
			this.HPMod = 400;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 80 / 20 * this.level;
			this.reflexesRaw = 80 / 20 * this.level;
			this.aimRaw = 80 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 60 / 20 * this.level;
			this.libidoRaw = 40;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 5;
			this.personality = 80;
			
			this.femininity = 10;
			this.eyeType = GLOBAL.TYPE_SNAKE;
			this.eyeColor = "yellow";
			this.tallness = 86;
			this.thickness = 40;
			this.tone = 75;
			this.hairColor = "gray";
			this.scaleColor = "gray";
			this.furColor = "none";
			this.hairLength = 0;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_SCALES;
			this.skinTone = "gray";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_LIZAN;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_LIZAN;
			this.tongueFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_PREHENSILE];
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_HUMAN;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_LIZAN;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_SCALED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_LIZAN;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_THICK, GLOBAL.FLAG_PREHENSILE];
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
			this.hipRatingRaw = 3;
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
			this.buttRatingRaw = 4;
			//No dicks here!
			this.cocks = new Array();
			this.createCock(6);
			this.shiftCock(0, GLOBAL.TYPE_SNAKE);
			
			this.balls = 2;
			this.ballSizeRaw = 2;
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.nippleColor = "green";
			this.milkMultiplier = 1;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.analVirgin = false;
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 30;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Genital Slit", 0, 0, 0, 0);
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			this.createPerk("Multiple Attacks", 2, 0, 0, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BALLS,			GLOBAL.KINDA_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HERMAPHRODITE,	0);
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			output("The monstrous basilisk suddenly lunges forward, snarling wordlessly as he swings his cutlass at you twice, the blows of a savage yet expert swordsman.\n\n");
			CombatAttacks.MeleeAttack(this, target);
		}
		
		public function teaseReactionsFail():void
		{
			teaseReactions(0);
		}
		
		public function teaseReactions(damage:Number):String
		{
			var ret:String = "";
			if (kGAMECLASS.pc.hasArmor() && !kGAMECLASS.pc.isExposed())
			{
				ret += ("Jean-Claude stops circling you, looking mildly surprised as you attempt to entice him with your body.");

				ret += ("\n\n“<i>This is the legendary Champion of Ignam?</i>” he husks. “<i>Flaunting themselves like the most amateur of Lethice’s strippers?</i>” His eyes glow orange. “<i>If that was your intent all along, interloper, you should not do it so half-assedly. You should take off all your clothes, embrace what you truly are, show me what you are really made of.</i>” The hypnotic compulsion presses upon you, commanding you to raise your hands to your [pc.gear]’s clasps...");
				
				if (damage == 0 || CoCBasilisk.canLookIntoEyes(false))
				{
					ret += ("\n\nYou grit your teeth, resist, and tear your hands away from your clothes. Jean-Claude snorts dismissively, gripping his cutlass anew.");
				}
				else
				{
					ret += ("\n\nYour intent is to arouse this creature. Surely the most arousing thing you can do right now is to take off all of your clothes. You smile at him, your eyes half-lidded as you slowly, sexily slide out of your [pc.gear], pushing your [pc.butt] out and sucking on a finger as you loosen first the top half, then the bottom half, letting it all slide off, piece by piece. The basilisk stands back and watches, grinning, his eyes a bonfire of lust, gripping one of his girthy dicks and slowly masturbating as you kick your underclothes outwards, smouldering at him and arching your back to display your [pc.chest].");

					ret += ("\n\n“<i>Very nice, interloper,</i>” Jean-Claude breathes. His wide smile turns ugly. “<i>Look forward to seeing that every night. I hope it is not too chilly in here for you.</i>” The basilisks which surround you snigger and you blink, the scales falling from your eyes as you realize what you have just done. There is no time to claw your clothes back on: Jean-Claude is upon you, forcing you to fall back, and you will have to fight the rest of this battle in the buff!");
					
					kGAMECLASS.pc.inventory.push(kGAMECLASS.pc.armor);
					kGAMECLASS.pc.armor = new EmptySlot();
					baseHPResistances.tease.resistanceValue -= 25.0;
					kGAMECLASS.pc.lust(CoCBasilisk.canLookIntoEyes(false) ? 5 : 20);
				}
			}
			else
			{
				ret += ("“<i>Even when made the fool, still you try it, still you think you can entice me with things I have seen a thousand times before,</i>” Jean-Claude sighs. “<i>Why not give up, interloper? You do these things because they arouse YOU, not because you hope they arouse me. Give up, and embrace the life you were born to lead.</i>” Despite these words his hungry eyes remain on your body. Perhaps he can’t help it. You can only hope...");
				
				kGAMECLASS.pc.lust(CoCBasilisk.canLookIntoEyes(false) ? 5 : 20);
			}
			return ret;
		}
	}
}