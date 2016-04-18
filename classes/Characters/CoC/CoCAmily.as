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
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	
	public class CoCAmily extends Creature
	{
		public function CoCAmily() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Amily";
			this.originalRace = "mouse";
			this.a = "";
			this.capitalA = "";
			this.long = "You are currently fighting Amily. The mouse-morph is dressed in rags and glares at you in rage, knife in hand. She keeps herself close to the ground, ensuring she can quickly close the distance between you two or run away.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon = new CoCDagger();
			
			this.armor = new ItemSlotClass();
			this.armor.longName = "rags";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new ItemSlotClass();
			this.rangedWeapon.longName = "blowpipe";
			this.rangedWeapon.attackVerb = "shot";
			this.rangedWeapon.attackNoun = "shot";
			this.rangedWeapon.baseDamage.kinetic.damageValue = 5;
			this.rangedWeapon.hasRandomProperties = true;
			
			this.XPRaw = 150;
			this.level = 4;
			this.credits = (rand(5) + 2) * 10;
			this.HPMod = 20;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 30 / 20 * this.level;
			this.reflexesRaw = 85 / 20 * this.level;
			this.aimRaw = 85 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 60 / 20 * this.level;
			this.libidoRaw = 45;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 10;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "brown";
			this.tallness = 40;
			this.thickness = 20;
			this.tone = 75;
			this.hairColor = "brown";
			this.scaleColor = "none";
			this.furColor = "gray";
			this.hairLength = 5;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_FUR;
			this.skinTone = "tawny";
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
			this.buttRatingRaw = 6;
			//No dicks here!
			this.cocks = new Array();
			this.cockVirgin = true;
			
			this.createVagina();
			this.vaginalVirgin = true;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 1;
			this.vaginas[0].wetnessRaw = 1;
			this.vaginas[0].bonusCapacity = 60;
			
			this.breastRows[0].breastRatingRaw = 1;
			this.nippleColor = "pink";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			this.analVirgin = false; // blame bees
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			if (!hasStatusEffect("Concentration") && rand(4) == 0) amilyConcentration(target);
			else if (rand(3) == 0) amilyDartGo(target);
			else if (rand(2) == 0) amilyDoubleAttack(target);
			else CombatAttacks.MeleeAttack(this, target);
		}
		
		//(Special Attacks)
		//-Double Attack: Same as a normal attack, but hits twice.
		public function amilyDoubleAttack(target:Creature):void {
			var dodged:Number = 0;
			if (combatMiss(this, target)) dodged++;
			if (combatMiss(this, target)) dodged++;
			
			//Get hit!
			if (dodged < 2) {
				//Blocked?
				if (dodged > 0) output("Amily dashes at you and quickly slashes you twice; you manage to avoid the first blow, but the second one hits home, cutting you! ");
				else {
					output("Amily dashes at you and slashes at you twice in the time it would take most to throw a single blow! ");
					applyDamage(meleeDamage().rand(), this, target, "minimal");
				}
				applyDamage(meleeDamage().rand(), this, target, "minimal");
			}
			//Dodge all!
			else output("Amily dashes at you and quickly slashes you twice, but you quickly sidestep her first blow and jump back to avoid any follow-ups.");
		}

		//-Poison Dart: Deals speed and str damage to the PC. (Not constant)
		private function amilyDartGo(target:Creature):void
		{
			if (rangedCombatMiss(this, target)) {
				output("Amily dashes at you and swipes her knife rather slowly. You easily dodge the attack; but it was all a feint, her other hands tries to strike at you with a poisoned dart. Luckily you manage to avoid it.");
			}
			//Else hit!
			else {
				output("Amily dashes at you and swipes her knife at you, surprisingly slowly.  You easily dodge the attack; but it was a feint - her other hand tries to strike at you with a poisoned dart. However, she only manages to scratch you, only causing your muscles to grow slightly numb.");
				//Set status
			if (!target.hasStatusEffect("Amily Venom")) target.createStatusEffect("Amily Venom", 0, 0, 0, 0, false, "Icon_Poison", "You are poisoned!", false, 999, 0x00FFAA);
				var poison:Number = 2 + rand(5);
				while (poison > 0) {
					poison--;
					if (target.physique() >= 2) {
						//Lose a point of str.
						target.physique( -1);
						target.addStatusValue("Amily Venom", 1, 1);
					}
					if (target.reflexes() >= 2) {
						//Lose a point of str.
						target.reflexes( -1);
						target.addStatusValue("Amily Venom", 2, 1);
					}
				}
				//If PC is reduced to 0 Speed and Strength, normal defeat by HP plays.
				if (target.reflexes() <= 2 && target.physique() <= 2) {
					output("  You've become so weakened that you can't even make an attempt to defend yourself, and Amily rains blow after blow down upon your helpless form. ");
					target.HP( -target.HP());
				}
			}
		}
		
		public function onCleanup():void {
			if (kGAMECLASS.pc.hasStatusEffect("Amily Venom")) {
				trace("Venom cleanup: " + kGAMECLASS.pc.statusEffectv1("Amily Venom") + " / " + kGAMECLASS.pc.statusEffectv2("Amily Venom"));
				kGAMECLASS.pc.physique(kGAMECLASS.pc.statusEffectv1("Amily Venom"));
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv2("Amily Venom"));
				kGAMECLASS.pc.removeStatusEffect("Amily Venom");
			}
		}
		
		//Concentrate: always avoids the next attack. Can be disrupted by tease/seduce.
		private function amilyConcentration(target:Creature):void {
			output("Amily takes a deep breath and attempts to concentrate on your movements.");
			createStatusEffect("Concentration", 0, 0, 0, 0, false, "Icon_DefUp", "She is concentrated on your movements.", true);
			createStatusEffect("Evasion Boost", 100, 0, 0, 0, true, "", "", true, 999);
		}
		
		//(if PC uses tease/seduce after this)
		//Deals big lust increase, despite her resistance.
		public function teaseReactions(lustDelta:Number):String
		{
			if (hasStatusEffect("Concentration") && lustDelta > 0) {
				output("Amily flushes hotly; her concentration only makes her pay more attention to your parts!");
				applyDamage(new TypeCollection( { tease : 25 + lustDelta } ), this, this);
				removeStatusEffect("Concentration");
				removeStatusEffect("Evasion Boost");
				return "ABORT";
			}
			return "";
		}
		
		override public function isPregnant(slot:int = -1):Boolean 
		{
			return flags["COC.AMILY_INCUBATION"] != undefined || flags["COC.AMILY_OVIPOSITED_COUNTDOWN"] != undefined;
		}
	}
}