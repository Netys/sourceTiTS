package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.CoCBookBlack;
	import classes.Items.Miscellaneous.CoCBookWhite;
	import classes.Items.Miscellaneous.CoCOvipositionElixir;
	import classes.Items.Miscellaneous.CoCTatteredScroll;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.Util.*;
	
	public class CoCSandWitch extends Creature
	{
		public function CoCSandWitch() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "sand witch";
			this.originalRace = "human";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "A sand witch appears to be totally human, an oddity in this strange land.  She has dirty blonde hair and a very tanned complexion, choosing to cover most of her body with robes of the same color as the desert sands, making her impossible to spot from afar.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "kick";
			this.meleeWeapon.attackVerb = "kick";
			this.meleeWeapon.attackNoun = "kick";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "robes";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 100;
			this.level = 3;
			this.credits = (5 + rand(15)) * 10;
			this.HPMod = 20;
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
			this.lustRaw = 30;	
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = rand(12) + 55;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "sandy-blonde";
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
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 2;
			this.vaginas[1].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[1].loosenessRaw = 2;
			this.vaginas[1].wetnessRaw = 2;
			
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
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [RandomInCollection([new CoCLactaid(), new CoCOvipositionElixir(), new CoCBookWhite(), new CoCBookBlack(), new CoCTatteredScroll(), new CoCLaBova()])];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (target.lust() >= target.lustMax() * 0.6)
			{
				if (rand(4) == 0) CombatAttacks.MeleeAttack(this, target);
				else CoCSandWitchLustMagicAttack(target);
			}
			else if (target.HP() <= target.HPMax() * 0.4)
			{
				if (rand(3) != 0) CombatAttacks.MeleeAttack(this, target);
				else CoCSandWitchLustMagicAttack(target);
			}
			else
			{
				if (rand(3) == 0) CombatAttacks.MeleeAttack(this, target);
				else CoCSandWitchLustMagicAttack(target);
			}
		}

		public function CoCSandWitchLustMagicAttack(target:Creature):void {
			output("The sand witch points at you, drawing a circle in the air and mouthing strange words.\n\n");
			if (target.hasStatusEffect("Vibrating Stone")) {
				output("The orb inside you grows warm, almost hot, suffusing your body with heat and arousal.  ");
				//game.dynStats("lus", 8 + int(player.sens) / 10);
				applyDamage(new TypeCollection( { tease: 8 + target.LQ() / 10 } ), this, target);
			}
			else if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("You feel the sands shift by your [pc.legs], and look down to see small stone slip out of the sands and slide over your armor in futile attempt to find a way in.  ");
			}
			else {
				output("You feel the sands shift by your [pc.legs], and look down to see something slip out of the sands and into your clothes!  It feels incredibly smooth and circular as it glides upward along your [pc.leg], its progress unaffected by your frantic effort to dislodge it.  ");
				if (target.hasVagina()) output("It glides up your thighs to the entrance of your sex, and its intentions dawn on you!\n\nToo late! You reach to stop it, but it pushes against your lips and slips inside your [pc.vagina] in an instant.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.");
				else output("It glides up your thighs, curving around your buttocks, and its intentions dawn on you.\n\nYou desperately grab for it, but are too late!  It pushes firmly against your rectum and slips inside instantaneously.  You groan in frustration as it begins pulsing and vibrating, sometimes even seeming to change size.");
				
				if (!target.hasStatusEffect("Vibrating Stone")) target.createStatusEffect("Vibrating Stone", 0, 0, 0, 0, false, "LustUp", "Vibrating stone is arousing you!", true);
				//game.dynStats("lus", 4 + int(player.sens) / 10);
				applyDamage(new TypeCollection( { tease: 4 + target.LQ() / 10 } ), this, target);
			}
		}
	}
}