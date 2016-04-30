package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Melee.CoCDagger;
	import classes.Items.Melee.Fists;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	
	public class CoCJojo extends Creature
	{
		public function CoCJojo() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Jojo";
			this.originalRace = "mouse";
			this.a = "";
			this.capitalA = "";
			this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon = new CoCDagger();
			
			this.armor = new ItemSlotClass();
			this.armor.longName = "rags";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances.psionic.resistanceValue = 10.0;
			baseHPResistances.drug.resistanceValue = 10.0;
			baseHPResistances.pheromone.resistanceValue = 10.0;
			baseHPResistances.tease.resistanceValue = 10.0;
			
			this.meleeWeapon = new Fists();
			
			this.XPRaw = 200;
			this.level = 4;
			this.credits = (rand(5) + 2) * 10;
			this.HPMod = 0;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 35 / 20 * this.level;
			this.reflexesRaw = 100 / 20 * this.level;
			this.aimRaw = 100 / 20 * this.level;
			this.intelligenceRaw = 55 / 20 * this.level;
			this.willpowerRaw = 55 / 20 * this.level;
			this.libidoRaw = 15;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 15;
			this.personality = int(kGAMECLASS.flags["COC.JOJO_STATE"]) <= 1 ? 0 : int(kGAMECLASS.flags["COC.JOJO_STATE"]) * 15;
			
			this.femininity = 20;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "brown";
			this.tallness = 4 * 12;
			this.thickness = 10;
			this.tone = 100;
			this.hairColor = "white";
			this.scaleColor = "none";
			this.furColor = "white";
			this.hairLength = 2;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FUR;
			this.skinTone = "white";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_MOUSE;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_MOUSE;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_MOUSE;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_MOUSE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_PLANTIGRADE];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_MOUSE;
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
			this.cocks = [];
			this.createCock(7.5);
			this.balls = 2;
			this.ballSizeRaw = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			
			if (kGAMECLASS.flags["COC.JOJO_STATE"] == 3) {
				this.lust(30);
				this.cocks[0].cLengthRaw += 1.5;
				if (int(kGAMECLASS.flags["COC.JOJO_ANAL_XP"]) > 0) this.ass.loosenessRaw = 2;
				this.willpower( -this.willpowerMax() * 0.15);
				this.ballSizeRaw += 1;
			}
			if (kGAMECLASS.flags["COC.JOJO_STATE"] == 4) {
				this.lust(40);
				this.cocks[0].cLengthRaw += 3.5;
				if (int(kGAMECLASS.flags["COC.JOJO_ANAL_XP"]) > 0) this.ass.loosenessRaw = 3;
				this.intelligence( -this.intelligenceMax() * 0.20);
				this.willpower( -this.willpowerMax() * 0.30);
				this.ballSizeRaw += 2;
			}
			if (kGAMECLASS.flags["COC.JOJO_STATE"] == 5) {
				this.lust(50);
				this.cocks[0].cLengthRaw += 5.5;
				if (int(kGAMECLASS.flags["COC.JOJO_ANAL_XP"]) > 0) this.ass.loosenessRaw = 4;
				this.physique( -this.physiqueMax() / 5);
				this.intelligence( -this.intelligenceMax() * 0.40);
				this.willpower( -this.willpowerMax() * 0.45);
				this.cor(10);
				this.HPMod += 60;
				this.HPRaw = this.HPMax();
				this.ballSizeRaw += 3;
				this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He's naked, with a large tainted throbbing member bouncing at attention.  A fuzzy sack with painfully large looking balls dangles between his legs.";
			}
			
			this.vaginas = [];
			
			this.breastRows[0].breastRatingRaw = 0;
			this.nippleColor = "pink";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.createStatusEffect("Disarm Immune");
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (int(kGAMECLASS.flags["COC.JOJO_STATE"]) > 1 && rand(2) == 0)
				selfCorruption(target); //Shouldn't do any self corruption at monk one. Otherwise a 50/50 chance
			else CombatAttacks.MeleeAttack(this, target);
		}
		
		private function selfCorruption(target:Creature):void {
			switch (int(kGAMECLASS.flags["COC.JOJO_STATE"])) {
				case 2:
					output("Jojo looks lost in thought for a moment, and fails to attack.  ");
					lust(4);
					break;
				case 3:
					output("Jojo blushes as he fights you, distracted by a stray thought.  You think you see a bulge in the loose cloth of his pants.  ");
					lust(8);
					break;
				case 4:
					output("Jojo stumbles, shakes his head, and pulls one of his hands away from the stiff tent in his pants.  ");
					lust(10);
					break;
				default:
					output("Jojo frantically jerks his " + cockDescript() + ", stroking the " + simpleCockNoun(0) + " as it leaks pre-cum at the sight of you.  ");
					lust(15);
			}
			
			if (lustQ() >= 100) {}
			else if (lustQ() >= 85) output("The mouse is panting and softly whining, each movement seeming to make his bulge more pronounced.  You don't think he can hold out much longer.  ");
			else if (lustQ() >= 70) output("The mouse is having trouble moving due to the rigid protrusion from his groin.  ");
			else if (lustQ() >= 60) output("The mouse's eyes constantly dart over your most sexual parts, betraying his lust.  ");
			else if (lustQ() > 50) output("The mouse's skin remains flushed with the beginnings of arousal.  ");
		}
		
		override public function cumQ():Number 
		{
			var cumQ:Number = 0;
			cumQ = 400;
			var miled:int = int(kGAMECLASS.flags["COC.JOJO_TIMES_MILKED"]);
			
			if (miled < 4) cumQ += miled * 200;
			else cumQ += miled * 100;
			
			if (kGAMECLASS.tentacleJojo()) cumQ += 500 + miled * 100;
			
			if (int(kGAMECLASS.flags["COC.JOJO_BLOWJOB_XP"]) < 10) cumQ += int(kGAMECLASS.flags["COC.JOJO_BLOWJOB_XP"]) * 50;
			else cumQ += 500;
			
			if (int(kGAMECLASS.flags["COC.JOJO_SEX_COUNTER"]) < 10) cumQ += int(kGAMECLASS.flags["COC.JOJO_SEX_COUNTER"]) * 25;
			else cumQ += 250;
			
			return cumQ;
		}
		
		override public function analCapacity():Number 
		{
			var capacity:int = 40;
			if (int(kGAMECLASS.flags["COC.JOJO_ANAL_XP"]) < 10) capacity += (int(kGAMECLASS.flags["COC.JOJO_ANAL_XP"]) * 3);
			else capacity += 30; //Caps at 70.
			return kGAMECLASS.cockVolume(capacity);
		}
		
		override public function buttChange(volume:Number, display:Boolean = true, spacingsF:Boolean = true, spacingsB:Boolean = false):Boolean 
		{
			kGAMECLASS.flags["COC.JOJO_ANAL_XP"] = int(kGAMECLASS.flags["COC.JOJO_ANAL_XP"]) + 1;
			return super.buttChange(volume, display, spacingsF, spacingsB);
		}
	}
}