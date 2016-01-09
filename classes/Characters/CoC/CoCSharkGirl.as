package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Apparel.CoCSluttySwimwear;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.TITSSaveEdit.Data.CoCTypeDefs;
	
	public class CoCSharkGirl extends Creature
	{
		
		public function CoCSharkGirl() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Originally a clone of the zilpack
			// Needs a few things checked.
			this.short = "shark-girl";
			this.originalRace = "shark";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The shark girl stands just over 5'5\", with grey skin shimmering from water droplets catching the sunlight and slender muscles built for swimming.  Her shoulder-length silver hair brushes past her pretty face and her eyes are a striking shade of red. She has rows of intimidating sharp teeth glinting in the light. A fish-like tail protrudes from her backside, wrapping around her toned legs at every opportunity. She's wearing a rather skimpy black bikini, strings done in such a way that they move around her fin; though the swimwear itself barely covers her perky breasts and tight snatch.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 3;
			this.meleeWeapon.longName = "shark teeth";
			this.meleeWeapon.attackVerb = "bite";
			this.meleeWeapon.attackNoun = "tiny punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "tough skin";
			this.armor.defense = 5;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.physiqueRaw = 40/20;
			this.reflexesRaw = 55/20;
			this.aimRaw = 55/20;
			this.intelligenceRaw = 42/20;
			this.willpowerRaw = 42/20;
			this.libidoRaw = 45;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 40;
			
			this.XPRaw = 75;
			this.level = 4;
			this.credits = (rand(15) + 5) * 10;
			this.HPMod = 20;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_SHARK;
			this.eyeColor = "green";
			this.tallness = 35 + rand(4);
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "silver";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 4;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "gray";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_SHARK;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_SHARK;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_SHARK;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_SHARK;
			this.gills = true;
			this.wingType = GLOBAL.TYPE_SHARK;
			this.legType = GLOBAL.TYPE_SHARK;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_SHARK;
			this.tailCount = 1;
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
			this.hipRatingRaw = CoCTypeDefs.HIP_RATING_AMPLE+2;
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
			this.buttRatingRaw = CoCTypeDefs.BUTT_RATING_LARGE;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_SHARK;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 15;
			
			this.breastRows[0].breastRatingRaw = 4;
			this.nippleColor = "gray";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 40;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			if(rand(3) != 0)
				inventory.push(kGAMECLASS.WeightedRandom(
				[new CoCLustDraft(), new CoCSluttySwimwear(), new CoCSharkTooth()] ,
				[3,                  1,                       5]));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (target.lust() >= target.lustMax() * 0.6)
			{
				if (rand(3) == 0) CombatAttacks.MeleeAttack(this, target);
				else sharkTease(target);
			}
			else if (target.HP() <= target.HPMax() * 0.4)
			{
				if (rand(4) != 0) CombatAttacks.MeleeAttack(this, target);
				else sharkTease(target);
			}
			else
			{
				if (rand(3) != 0) CombatAttacks.MeleeAttack(this, target);
				else sharkTease(target);
			}
		}

		private function sharkTease(target:Creature):void {
			//game.spriteSelect(70);
			if(rand(2) == 0) {
				output("You charge at the shark girl, prepared to strike again, but stop dead in your tracks when she bends over and wiggles her toned ass towards you. It distracts you long enough for her tail to swing out and smack you to the ground. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				applyDamage(new TypeCollection( { tease: 5 + (target.libido() / 20) } ), this, target, "minimal");
				
			}
			else {
				output("You pull your [pc.mainWeapon] back, getting a running start to land another attack. The Shark girl smirks and pulls up her bikini top, shaking her perky breasts in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you to the ground.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				applyDamage(new TypeCollection( { tease: 5 + (target.libido() / 10) } ), this, target, "minimal");
			}
			
			var damage:TypeCollection = this.meleeDamage();
			damageRand(damage, 20);		
			applyDamage(damage, this, target);
		}
	}
}