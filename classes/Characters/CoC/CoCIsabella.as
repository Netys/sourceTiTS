package classes.Characters.CoC
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.kGAMECLASS;
	
	public class CoCIsabella extends Creature
	{
		//constructor
		public function CoCIsabella()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Isabella";
			this.originalRace = "cow-girl";
			this.a = "";
			this.capitalA = "";
			this.long = "Isabella is a seven foot tall, red-headed tower of angry cow-girl.  She's snarling at you from behind her massive shield, stamping her hooves in irritation as she prepares to lay into you.  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.  She wears a tight silk shirt and a corset that barely supports her bountiful breasts, but it's hard to get a good look at them behind her giant shield.";
			this.customDodge = "Your attack is blocked by shield!";
			this.customBlock = "Your attack is blocked by shield!";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "giant shield";
			this.meleeWeapon.attackVerb = "smash";
			this.meleeWeapon.attackNoun = "smash";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "giant shield";
			this.armor.defense = 0;
			this.armor.evasion = 25;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 1500;
			this.level = 15;
			this.credits = (rand(5) + 20) * 10;
			this.HPMod = 700;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 70 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 65 / 20 * this.level;
			this.willpowerRaw = 65 / 20 * this.level;
			this.libidoRaw = 65;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 40;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 7 * 12 + 6;
			this.thickness = 50;
			this.tone = 65;
			this.hairColor = "red";
			this.scaleColor = "gray";
			this.furColor = "gray";
			this.hairLength = 13;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "dusky";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_HUMAN;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_BOVINE;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_BOVINE;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 2;
			this.hornLength = 4;
			this.hornType = GLOBAL.TYPE_BOVINE;
			this.armType = GLOBAL.TYPE_HUMAN;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_BOVINE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_HOOVES, GLOBAL.FLAG_FURRED];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 0;
			this.tailType = GLOBAL.TYPE_BOVINE;
			this.tailCount = 1;
			this.tailFlags = [GLOBAL.FLAG_LONG];
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
			this.hipRatingRaw = 13;
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
			this.buttRatingRaw = 13;
			//No dicks here!
			this.cocks = new Array();
			
			this.createVagina();
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;
			this.vaginas[0].loosenessRaw = 4;
			this.vaginas[0].wetnessRaw = 4;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 10; // big EE
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_SMALL_MALEBITS,	GLOBAL.REALLY_LIKES_SEXPREF);
			//sexualPreferences.setRandomPrefs(2 + rand(3));
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			//-If below 70% HP, 50% chance of milk drinking
			if (HPQ() < 70 && rand(3) == 0) drankMalkYaCunt(target);
			//if PC has spells and isn't silenced, 1/3 chance of silence.
			else if (kGAMECLASS.hasSpells() && !target.hasStatusEffect("ThroatPunch") < 0 && rand(3) == 0) {
				isabellaThroatPunch(target);
			}
			//if PC isn't stunned, 1/4 chance of stun
			else if (!target.hasStatusEffect("Stunned") && rand(4) == 0) {
				isabellaStun(target);
			}
			else isabellaAttack(target);
		}
		
		//Isabella Combat texttttttsss
		public function isabellaAttack(target:Creature):void {
			//[Standard attack]
			output("Isabella snorts and lowers a shield a moment before she begins to charge towards you. Her hooves tear huge divots out of the ground as she closes the distance with surprising speed!  ");

			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output("Isabella blindly tries to charge at you, but misses completely.");
			}
			//Determine if dodged!
			else if (combatMiss(this, target)) {
				output("You duck aside at the last moment, relying entirely on your speed.\n");
			}
			else {
				output("She's coming too fast to dodge, and you're forced to try to stop her.  It doesn't work.  Isabella's shield hits you hard enough to ring your ears and knock you onto your back with bruising force. ");
				applyDamage(meleeDamage().rand(), this, target, "melee");
			}
		}
		
		public function isabellaStun(target:Creature):void {
			//[Stunning Impact]
			output("Isabella spins her shield back at you in a potent, steel-assisted backhand.  ");
			
			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output("Isabella blindly tries to charge at you, but misses completely.");
			}
			//Determine if dodged!
			else if (combatMiss(this, target)) {
				output("You duck aside at the last moment, relying entirely on your speed.");
			}
			else {
				//var damage:Number = 0;
				//damage = Math.round((weaponAttack + str) - rand(pc.tou+pc.armorDef));
				//if (damage < 0) {
					//output("You deflect her blow away, taking no damage.\n");
					//damage = 0;
				//}
				//else if (pc.findPerk(PerkLib.Resolute) >= 0 && pc.tou >= 75) {
					//output("You resolutely ignore the blow thanks to your immense toughness.\n");
					//damage = 0;
				//}
				//else {
					output("You try to avoid it, but her steely attack connects, rocking you back.  You stagger about while trying to get your bearings, but it's all you can do to stay on your feet.  <b>Isabella has stunned you!</b> ");
					applyDamage(meleeDamage().rand(), this, target, "melee");
					target.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
				//}
			}
		}

		public function isabellaThroatPunch(target:Creature):void {
			output("Isabella punches out from behind her shield in a punch aimed right at your throat!  ");

			//Blind dodge change
			if (hasStatusEffect("Blinded") && rand(3) < 2) {
				output("Isabella blindly tries to charge at you, but misses completely.");
			}
			//Determine if dodged!
			else if (combatMiss(this, target)) {
				output("You duck aside at the last moment, relying entirely on your speed.");
			}
			else {
				//var damage:Number;
				//damage = Math.round(str - rand(pc.tou+pc.armorDef));
				//if (damage <= 0) {
					//output("You manage to block her with your own fists.\n");
				//}
				//else if (pc.findPerk(PerkLib.Resolute) >= 0 && pc.tou >= 75) {
					//output("You resolutely ignore the blow thanks to your immense toughness.\n");
				//}
				//else {
					output("You try your best to stop the onrushing fist, but it hits you square in the throat, nearly collapsing your windpipe entirely.  Gasping and sputtering, you try to breathe, and while it's difficult, you manage enough to prevent suffocation. <b>It will be impossible to focus to cast a spell in this state!</b> ");
					applyDamage(meleeDamage().rand(), this, target, "melee");
					target.createStatusEffect("Silence", 2, 0, 0, 0, false, "Icon_Silence", "You can't talk when you are struggling to breath!", true, 0);
				//}
			}
		}

		//[Milk Self-Heal]
		public function drankMalkYaCunt(target:Creature):void {
			output("Isabella pulls one of her breasts out of her low-cut shirt and begins to suckle at one of the many-tipped nipples. Her cheeks fill and hollow a few times while you watch with spellbound intensity.  She finishes and tucks the weighty orb away, blushing furiously.  The quick drink seems to have reinvigorated her, and watching it has definitely aroused you.");
			applyDamage(new TypeCollection( { tease : 10 + target.libido() / 20 } ), this, target);
			HP(100);
			lust(5);
		}
	}
}