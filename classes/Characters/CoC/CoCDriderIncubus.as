package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.addButton;
	import classes.Engine.Interfaces.clearOutput;
	import classes.GameData.CombatManager;
	import classes.GLOBAL;
	import classes.Items.Miscellaneous.CoCToughSpiderSilk;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.CoCBlackGossamer;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCDriderIncubus extends CoCSpiderMorph
	{
		public function CoCDriderIncubus() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "drider incubus";
			this.originalRace = "drider";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The drider incubus is a marvel of demonic perversions applied to inhuman flesh. His glittering dark skin is like a solid sheet of coal. Twisted obsidian horns spiral from his forehead like a pair of misshapen spears. Even his eyes are an eerie marvel, no longer windows to the soul, only pits of endless hunger. His evil visage pales in comparison to the monstrous form below his waist - that of a gigantic spider. Eight clattering legs skitter across the floor with his every move. A bulbous abdomen hangs behind them, covered with twitching spinnerets so full of silk that half-formed blobs of it dangle behind him.\n\nHanging from an impeccably made harness is a goblin, the only splash of color on the soulless abomination before you. She’s positioned against the larger male’s abdomen so that her bare crotch is impaled upon his turgid, writhing demon-dick, and by the looks of her frantic squirming, is doing her best to escape. Perhaps you could free her?";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.longName = "spear";
			this.meleeWeapon.attackVerb = "stab";
			this.meleeWeapon.attackNoun = "stab";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 19;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "chitin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			
			baseHPResistances.kinetic.resistanceValue = 40.0;
			baseHPResistances.electric.resistanceValue = 40.0;
			baseHPResistances.corrosive.resistanceValue = 60.0;
			baseHPResistances.corrosive.resistanceValue = 60.0;
			baseHPResistances.poison.resistanceValue = -20.0;
			baseHPResistances.freezing.resistanceValue = -20.0;
			
			baseHPResistances.psionic.resistanceValue = 55.0;
			baseHPResistances.drug.resistanceValue = 55.0;
			baseHPResistances.pheromone.resistanceValue = 55.0;
			baseHPResistances.tease.resistanceValue = 55.0;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 22;
			this.XPRaw = bossXP();
			this.credits = (75 + rand(50)) * 10;
			this.HPMod = 500;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 65 / 20 * this.level;
			this.reflexesRaw = 90 / 20 * this.level;
			this.aimRaw = 90 / 20 * this.level;
			this.intelligenceRaw = 70 / 20 * this.level;
			this.willpowerRaw = 70 / 20 * this.level;
			this.libidoRaw = 66;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			this.personality = 100;
			
			this.femininity = 10;
			this.eyeType = GLOBAL.TYPE_ARACHNID;
			this.eyeColor = "red";
			this.tallness = 9 * 12;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "black";
			this.scaleColor = "black";
			this.furColor = "black";
			this.hairLength = 24;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.SKIN_TYPE_CHITIN;
			this.skinTone = "black";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_ARACHNID;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_DRIDER;
			this.antennae = 0;
			this.antennaeType = GLOBAL.TYPE_HUMAN;
			this.horns = 0;
			this.hornType = 0;
			this.armType = GLOBAL.TYPE_ARACHNID;
			this.gills = false;
			this.wingType = GLOBAL.TYPE_HUMAN;
			this.legType = GLOBAL.TYPE_DRIDER;
			this.legCount = 8;
			this.legFlags = [];
			//0 - Waist
			//1 - Middle of a long tail. Defaults to waist on bipeds.
			//2 - Between last legs or at end of long tail.
			//3 - On underside of a tail, used for driders and the like, maybe?
			this.genitalSpot = 3;
			this.tailType = GLOBAL.TYPE_DRIDER;
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
			this.cocks = new Array();
			this.createCock(24, 1.2);
			this.shiftCock(0, GLOBAL.TYPE_DEMONIC);
			
			this.vaginas = [];
			
			this.breastRows = [];
			this.createBreastRow();
			this.nippleColor = "black";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 70;
			
			this.impregnationType = "CoCImpPregnancy";
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			
			inventory = [];
			
			this._isLoading = false;
		}
		 
		private var _goblinFree:Boolean = false;
		
		private var _combatRound:int = 0;
		
		private var _hpGains:int = 0;
		
		private var _seenResolute:Boolean = false;
		
		private var _goblinWebChain:Boolean = false;
		
		private var _goblinOiled:Boolean = false;
		
		public function get goblinFree():Boolean
		{
			return this._goblinFree;
		}
		
		public function set goblinFree(v:Boolean):void
		{
			if (v != this._goblinFree)
			{
				this.long = "The drider incubus is a marvel of demonic perversions applied to inhuman flesh. His glittering dark skin is like a solid sheet of coal. Twisted obsidian horns spiral from his forehead like a pair of misshapen spears. Even his eyes are an eerie marvel, no longer windows to the soul, only pits of endless hunger. His evil visage pales in comparison to the monstrous form below his waist - that of a gigantic spider. Eight clattering legs skitter across the floor with his every move. A bulbous abdomen hangs behind them, covered with twitching spinnerets so full of silk that half-formed blobs of it dangle behind him.";
				if (!v)
				{
					this.long = this.long + "Hanging from an impeccably made harness is a goblin, the only splash of color on the soulless abomination before you. She’s positioned against the larger male’s abdomen so that her bare crotch is impaled upon his turgid, writhing demon-dick, and by the looks of her frantic squirming, is doing her best to escape. Perhaps you could free her?";
				}
				else
				{
					this.long = this.long + "The goblin you freed heedlessly chases her demonic master around the room, doing everything she can to bring his rod off. She seems barely conscious of the ongoing conflict; it’s a wonder the drider hasn’t stepped on her yet.";
				}
			}
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			this._combatRound++;
			if (this.lust() < 65 && this.HPQ() < 33)
			{
				this.gainHpAndLust();
			}
			else if (this.lust() >= 65 && this.HPQ() >= 33)
			{
				this.dropHpAndLust();
			}
			
			if (rand(100) > lust() + 10)
			{
				this.spearStrike();
				output("\n\n");
				this.performPhysicalAttack();
			}
			else
			{
				this.performLustAttack();
			}
			
			if (this._goblinFree)
			{
				output("\n\n");
				this.goblinAI();
			}
		}
		
		private function performPhysicalAttack():void
		{
			var opts:Array = null;
			if (this._combatRound >= 3 && (this._combatRound % 6 == 0 || this._combatRound == 3))
			{
				this.stunningSpear();
			}
			else
			{
				opts = [this.bite, spiderMorphWebAttack, this.kick, this.kick, this.doubleStrike, this.doubleStrike];
				opts[rand(opts.length)]();
			}
		}
		
		private function performLustAttack():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			var opts:Array = null;
			if (this._combatRound >= 3 && (this._combatRound % 6 == 0 || this._combatRound == 3))
			{
				this.constrictingThoughts();
			}
			else
			{
				opts = [this.arouseSpell, this.arouseSpell];
				if (!pc.hasStatusEffect("Tainted Mind") && !this._seenResolute)
				{
					opts.push(this.taintedMind);
				}
				if (!this._seenResolute)
				{
					opts.push(this.purpleHaze);
				}
				opts[rand(opts.length)]();
			}
		}
		
		private function goblinAI():void
		{
			var opts:Array = [this.goblinHandjob, this.goblinTongueGrapple, this.bootyTwerking, this.webNipplechain];
			if (!this._goblinOiled)
			{
				opts.push(this.babyOilMeUp);
			}
			opts[rand(opts.length)]();
		}
		
		private function gainHpAndLust():void
		{
			this.HP(this.maxHP() * 0.1);
			this.lust(8);
			if (this._hpGains == 0)
			{
				output("<i>“You won’t defeat me so easily!”</i>");
			}
			else if (this._hpGains == 1)
			{
				output("<i>“I can keep this up longer than you, mortal!”</i>");
			}
			else if (this._hpGains == 2)
			{
				output("<i>“So stubborn! Lethice take you!”</i>");
			}
			else
			{
				output("<i>“Why won’t you give in?!”</i>");
			}
			this._hpGains++;
			output(" The demon gestures wildly, drawing a rune across his own chest. It flares, blood red and pulsing. Your foe’s wounds slowly edge close, fueled by magic. When the luminous symbol fades, the drider pants, his black skin flushing purple in places.");
			if (this.lustQ() > 65)
			{
				if (this._goblinFree)
				{
					output(" His dick is rigid and bouncing, so hard it looks like it could go off at any moment.");
				}
				else
				{
					output(" His balls are tensing underneath the goblin, and he keeps moaning under his breath.");
				}
				output(" You doubt he can keep drawing on his lust to heal himself without pushing himself over the edge!");
			}
			output("\n\n");
		}
		
		private function dropHpAndLust():void
		{
			this.HP(this.maxHP() * -0.08);
			this.lust( -10);
			output("The demon snarls and draws his spear back, placing it blade down against his arm. Grinning malevolently, he slides the razor-sharp edge along his skin, leaving a trail of glittering ruby on his wounded flesh. <i>“Pain brings clarity of mind - something you couldn’t understand.”</i> He grins wider, mastering his baser emotions. <i>“Let me teach you.”</i>\n\n");
		}
		
		private function spearStrike():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The drider rears back, lancing out with his spear.");
			
			if (combatMiss(this, pc))
			{
				output(" You barely slide out of the way.");
			}
			else
			{
				output(" The weapon bites deep. ");
			
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(0.75);
				applyDamage(damage, this, pc);
			}
		}
		
		public override function onCleanup():void {
			if (kGAMECLASS.pc.hasStatusEffect("Web")) {
				kGAMECLASS.pc.reflexes(kGAMECLASS.pc.statusEffectv1("Web"));
				kGAMECLASS.pc.removeStatusEffect("Web");
			}
			if (kGAMECLASS.pc.hasStatusEffect("Drider Venom")) {
				kGAMECLASS.pc.physique(kGAMECLASS.pc.statusEffectv2("Drider Venom"));
				kGAMECLASS.pc.removeStatusEffect("Drider Venom");
			}
			kGAMECLASS.pc.removeStatusEffect("Silence");
		}
		
		private function bite():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			var amount:Number = 0;
			if (pc.hasStatusEffect("Stunned") || pc.reflexes() <= 1 && pc.hasStatusEffect("Web"))
			{
				if (pc.hasStatusEffect("Drider Venom"))
					pc.addStatusValue("Drider Venom", 1, 5);
				else
					pc.createStatusEffect("Drider Venom", 5, 0, 0, 0, false, "Icon_Poison", "You are poisoned!", true, 0, 0xFF0000);
				amount = 15;
				if (pc.physique() - amount < 1)
					amount = pc.physique() - 1;
				pc.physique( -amount);
				pc.addStatusValue("Drider Venom", 2, amount);
				output("Taking his time, the arachnid demon bares his fangs, easily biting deeply into you. His tongue slides sensually around the wounds as he pumps you full of venom, tasting your fear and desperation. You wince while the venom robs you of your strength.");
				if (pc.physique() <= 15)
				{
					output(" It’s getting harder just to remain upright.");
				}
				else if (pc.physique() <= 1)
				{
					output(" You don’t think you can stand any longer, let alone resist.");
				}
				output("\n\nWhen he pulls out, he’s smiling and a little flushed. <i>“");
				if (pc.physique() > 15)
				{
					output("That should do.");
				}
				else
				{
					output("Soon you won’t have the strength to resist.");
				}
				output("”</i>");
			}
			else
			{
				output("Twisting over, the arachnid demon bares his fangs, attempting to bite you!");
				if (combatMiss(this, pc))
					output(" You avoid his venomous strike!");
				else {
					output(" Those needle-like canines punch into you, delivering their venomous payload! You already feel weaker, your muscles not responding as effectively.");
					output("<i>“I do love watching you struggle.”</i> He flashes a crooked smile.");
					
					if (pc.hasStatusEffect("Drider Venom"))
						pc.addStatusValue("Drider Venom", 1, 5);
					else
						pc.createStatusEffect("Drider Venom", 5, 0, 0, 0, false, "Icon_Poison", "You are poisoned!", true, 0, 0xFF0000);
					
					amount = 15;
					if (pc.physique() - amount < 1)
						amount = pc.physique() - 1;
					pc.physique( -amount);
					pc.addStatusValue("Drider Venom", 2, amount);
				}
			}
		}
		
		private function kick():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("While you’re busy with his spear, he nonchalantly snaps a kick in your direction!");
			if (combatMiss(this, pc))
			{
				output(" You twist out of the way at the last moment, evading with ease.");
			}
			else
			{
				output(" You go flying back into a pair of oiled-up slavegirls. They gasp in surprise as you tear your way back to the fight. Too late, they attempt to caress you, barely touching your [pc.leg] before you’re back in the fight. ");
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(1.15);
				applyDamage(damage, this, pc);
			}
		}
		
		private function stunningSpear():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Twirling his weapon until it appears a blurred disc, the drider pivots, bringing the haft around at your head!");
			
			if (combatMiss(this, pc))
			{
				output(" You duck in the nick of time.");
			}
			else
			{
				output(" You don’t feel the impact, but you do hear the crack of wood striking");
				output(" bone");
				output(".");
				if (!pc.hasPerk("Resolute"))
				{
					output(" <b>You’re left stunned by the blow!</b> It’ll be a moment before you can regain your wits. ");
					pc.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
				}
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(0.85);
				applyDamage(damage, this, pc);
				
				output(" You hear the crack of wood striking");
				output(" bone");
				output(", but you manage to deflect most of the force!");
			}
		}
		
		private function doubleStrike():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("He skitters forward and presses his attack, stabbing out with his spear once more.");
			if (combatMiss(this, pc))
			{
				output(" You barely slide out of the way.");
			}
			else
			{
				output(" The weapon bites deep. ");
				var damage:TypeCollection = this.meleeDamage();
				damage.multiply(1.1);
				applyDamage(damage, this, pc);
			}
		}
		
		private function arouseSpell():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The demonic drider mutters incomprehensible words that tickle at the back of your mind. Profane syllable mounts profane syllable until his mouth seems buried under the weight of the cacophony of corruption. His filth builds to a crescendo, and with a confident, arrogant gaze, he directs it at you.");
			output("\n\nAn invisible force falls upon you, infusing the most sensitive places of your body with desire, bringing your [pc.nipples] to life with need");
			if (pc.hasCock() || pc.hasVagina())
			{
				output(", making your");
				if (pc.hasCock())
					output(" [pc.cocks]");
				else
					output(" [pc.vagina]");
				output(" ache to be touched");
			}
			output(". ");
			applyDamage(new TypeCollection( { psionic : 15 + (pc.libido() / 10) + (pc.cor() / 10) } ), this, pc);
			output(" Your body rebels against you under the unholy influence");
			if (pc.lustQ() < 100)
				output(", but the effect is fleeting, thankfully. You try to ignore the residual tingles. You can’t afford to lose this close to your goal!");
			else
				output(".");
		}
		
		public override function additionalCombatMenuEntries():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Tainted Mind")) {
				addButton(0, "Attack?", taintedMindAttackAttempt);
				addButton(1, "Shoot?", taintedMindAttackAttempt);
			}
		}
		
		public function processHostileGroupActions():void {
			var pc:PlayerCharacter = kGAMECLASS.pc;
			
			if (pc.hasStatusEffect("Tainted Mind")) {
				pc.addStatusValue("Tainted Mind", 1, -1);
				if (pc.statusEffectv1("Tainted Mind") <= 0)
					pc.removeStatusEffect("Tainted Mind");
			}
		}
		
		private function taintedMind():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("<i>“You fight well, for a mortal... but can you fight like a demon?”</i> He claps his hands together, bathing the immediate area in a wave of energy. Some of the nearby slaves cry out in alarm, then settle into giggling, cooing messes. You don’t seem any worse for the wear in its wake, though something feels wrong about holding your [pc.mainWeapon].");
			if (pc.cor() <= 33)
				output(" What did he mean about fighting like a demon?");
			pc.createStatusEffect("Tainted Mind", 4, 0, 0, 0, false, "Icon_Confused", "Something feels wrong about holding your weapon.", true);
		}
		
		public function taintedMindAttackAttempt():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("You ready an attack, but find your hands groping your own body instead. Somehow the demon’s magic has made it impossible to strike at him, crossing wires that weren’t meant to be crossed. Frowning, you look down at your more aroused form, determined not to fall for this a second time. ");
			applyDamage(new TypeCollection( { psionic : 15 } ), pc, pc);
		}
		
		private function constrictingThoughts():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("<i>“Try this on for size!”</i> the corrupted arachnid shouts, waving his hand in your direction.");
			output("\n\nDisjointed, erotic thoughts claw at your mind’s defenses, worming their way in through what cracks they find, plunging sensuous fantasies of every shape and size in place of your own imaginings.");
			if (pc.hasPerk("Resolute") || kGAMECLASS.isNineTails(pc) || pc.hasPerk("Enlightened") && pc.cor() < 10 || pc.WQ() >= 100 && pc.affinity == "willpower")
			{
				this._seenResolute = true;
				output(" You marshal your mental discipline and discard the errant thoughts.");
			}
			else
			{
				output(" The intensity overwhelms your ability to act, arousing and stunning you.");
				applyDamage(new TypeCollection( { psionic : 15 + (pc.libido() / 15) + (pc.cor() / 15) } ), this, pc);
				pc.createStatusEffect("Stunned", 2, 0, 0, 0, false, "Stun", "Cannot act for 2 turns.", true, 0, 0xFF0000);
			}
		}
		
		private function purpleHaze():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("<i>“Try this on for size!”</i> The drider gestures in your direction, gathering his will into a palpable force. It presses on your mind like a coiled snake, crushing down on you from all sides.");
			if (pc.hasPerk("Resolute") || kGAMECLASS.isNineTails(pc) || pc.hasPerk("Enlightened") && pc.cor() < 10 || pc.WQ() >= 100 && pc.affinity == "willpower" || rand(3) >= 0)
			{
				this._seenResolute = true;
				output(" You flex your considerable will and feel the concentrated mental filth slough off. Whatever his attack was, it failed!");
			}
			else
			{
				output(" You concentrate to try and throw it off, but he overwhelms your mental defenses. Clouds of swirling pink filled with unsubtle erotic silhouettes fill your vision, effectively blinding you!");
				applyDamage(new TypeCollection( { psionic : 25 } ), this, pc);
				pc.createStatusEffect("PurpleHaze", 2 + rand(2), 0, 0, 0, true, "", "", true);
				pc.createStatusEffect("Blinded", pc.statusEffectv1("PurpleHaze"), 0, 0, 0, false, "Blind", "Accuracy is reduced, and ranged attacks are far more likely to miss.", true, 0, 0xFF0000);
			}
		}
		
		private function goblinHandjob():void
		{
			output("Somehow, the goblin manages to get both her mitts on the drider’s ever erect member. A gleeful expression occupies her face as she begins pumping, worshipfully tugging on her master’s rod again and again, her mouth open excitedly as if he could bust a nut at any moment.");
			output("\n\nUnfortunately for her, the demonic arachnid’s motions carry him away from her greedy fingers. He slips out of her grip with a wet pop, and she can do naught but pout and chase after him once more.");
		}
		
		private function goblinTongueGrapple():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("The determined goblin love-slave opens wide, launching a tongue that must be at least three feet long toward her master’s member with pinpoint accuracy. It makes contact with a wet ‘snap’ and wraps round the oozing, demonic length before either you or the drider can react. His motions slow from the attention, and he nearly stumbles, giving the goblin time to close to the distance, mummifying his member under layers of hot pink pleasure.");
			lust(5);
			if (lustQ() <= 100)
			{
				output("\n\nThe drider skitters back, the motion dropping the goblin to her knees. Her tongue stretches taut a long moment, then slips from his shaft, snapping back into her mouth hard enough to make her recoil. Both parties look disappointed with the outcome, none moreso than the goblin. Fortunately for her, she’ll get another chance - the drider is focusing on you once more.");
			}
			else
			{
				output("\n\nThe drider attempts to skitter back, but his legs are shaking to hard for proper movement. He looks longingly at his love slave, forgetting you for the moment.");
			}
		}
		
		private function bootyTwerking():void
		{
			output("The goblin gives up on her futile chase for the moment. Instead of trying to lay her hands on her treasured scepter, she spins around, raising her cushy-looking ass into the air. She twists and gyrates, making her voluminous asscheeks bounce independantly. Sometimes they audibly clap together. A few assembled demonic slaves applaud her performance, and the drider can’t help but spare her a few hungry glances.");
			lust(5);
		}
		
		private function webNipplechain():void
		{
			output("Every time she makes a grab for the demonic drider’s tool, he skitters aside, the ebb and flow of your fight keeping her from her objective. In a huff, she grabs hold of a hanging strand of web and affixes the sticky end to one of her nipples. Then, she gives the source spinnaret a squeeze, but not before pressing her other jiggling tit against it.");
			if (this._goblinWebChain == false)
			{
				output("\n\nShe comes away with an organic nipple chain, one that has her moaning with need as she shakes her diminutive body for her master’s pleasure. He tries his best to ignore her, even a demon can’t ignore a pair of white-plastered tits shaking a few feet away.");
				this._goblinWebChain = true;
			}
			else
			{
				output("\n\nThe goblin slave-girl shimmies and shakes once more, her arms pressing in on her tits from both sides to make the jiggling, web-painted mounds dance. Her eyes smoulder with desire, and her wanton smile promises nothing but hours of unending lewdness to her master. He does a double-take at the sight of it.");
			}
			lust(5);
		}
		
		public function get goblinOiled():Boolean
		{
			return this._goblinOiled;
		}
		
		private function babyOilMeUp():void
		{
			var pc:PlayerCharacter = kGAMECLASS.pc;
			output("Darting into the crowd, the goblin comes back with a bottle of unusual shape and design. She pops the cork and upends it across her petite but all-too-stacked form, smearing it across her more-than-ample tits with one hand, making them shine in the flickering candlelight. Her eyes are bright and mischievous while she spreads it over the rest of her form, leaving the whole of her body slick and ready for love.");
			output("\n\nShe dances and spins to the side, cooing, <i>“Don’t you want me anymore, baby? Look how ready I am”</i> Her nipples are taut and stiff, and the junction between her thighs absolutely drenched. Neither you nor your foe can keep from sparing lusty glances her way. ");
			applyDamage(new TypeCollection( { tease : 7 } ), this, pc);
			lust(7);
		}
		
		// FIXME: is it actually possible in vanilla?
		public function freeGoblin():void
		{
			clearOutput();
			this._goblinFree = true;
			output("You lunge in low, hooking your hands beneath the writhing greenskin’s armpits and pulling. Webs snap like gauze between her weight and the mighty tug you strain them with. Her eyes bulge open in horror. She screams as you pull her free, revealing an inhumanly soaked rod and one seriously puffy set of labia. The poor thing won’t be able to walk without squishing them against each other.");
			output("\n\nYou’re forced to drop her as the enraged drider prepares his counterattack. She lands on her feet, surprisingly enough.");
			output("\n\n<i>“Oh, forgive me master! I’ll still get you off - I promise!”</i> The green slut wiggles away from you, trying to get at her master’s loins.");
			output("\n\nWell... maybe she didn’t want free after all. At least she’ll make for a good distraction.");
			CombatManager.processCombat();
		}
	}
}