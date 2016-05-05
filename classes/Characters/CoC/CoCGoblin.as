package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.damageRand;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.GameData.CombatAttacks;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Transformatives.*;
	import classes.Items.Transformatives.CoCDyes.*;
	import classes.kGAMECLASS;
	
	public class CoCGoblin extends Creature
	{
		
		public function CoCGoblin() 
		{			
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			// Originally a clone of the zilpack
			// Needs a few things checked.
			this.short = "goblin";
			this.originalRace = "goblin";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The goblin before you is a typical example of her species, with dark green skin, pointed ears, and purple hair that would look more at home on a punk-rocker.  She's only about three feet tall, but makes up for it with her curvy body, sporting hips and breasts that would entice any of the men in your village were she full-size.  There isn't a single scrap of clothing on her, just lewd leather straps and a few clinking pouches.  She does sport quite a lot of piercings – the most noticeable being large studs hanging from her purple nipples.  Her eyes are fiery red, and practically glow with lust.  This one isn't going to be satisfied until she has her way with you.  It shouldn't be too hard to subdue such a little creature, right?";
			this.customDodge = "Goblin's small frame allows her to handily avoid your attack.";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "tiny punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "leather straps";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.physiqueRaw = 1;
			this.reflexesRaw = 3;
			this.aimRaw = 1;
			this.intelligenceRaw = 4;
			this.willpowerRaw = 2;
			this.libidoRaw = 45;
			this.personality = 60;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 50;
			
			this.XPRaw = 20;
			this.level = 1;
			this.credits = (5 + rand(5)) * 10;
			this.HPMod = 7;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_GABILANI;
			this.eyeColor = "green";
			this.tallness = 35 + rand(4);
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "purple";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 4;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "dark green";
			this.skinFlags = new Array();
			this.faceType = GLOBAL.TYPE_GABILANI;
			this.faceFlags = new Array();
			this.tongueType = GLOBAL.TYPE_HUMAN;
			this.lipMod = 0;
			this.earType = GLOBAL.TYPE_GABILANI;
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
			this.hipRatingRaw = 8;
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
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginas[0].type = GLOBAL.TYPE_GABILANI;
			this.vaginalVirgin = false;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].bonusCapacity = 40;
			
			this.breastRows[0].breastRatingRaw = 8; // E
			this.nippleColor = "purple";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 20;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setRandomPrefs(2 + rand(3));
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BALLS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_MASCULINE,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCGoblinAle(), new CoCLustDraft(), new CoCDyePink(), new CoCDyeBlue, new CoCDyeOrange(), new CoCDyePurple()] ,
						[5,                  1,                  1,                1,              1,                  1]));
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var options:Array = [];
			
			if (target.lust() >= target.lustMax() * 0.6)
			{
				if (rand(4) == 0) {
					CombatAttacks.MeleeAttack(this, target);
					return;
				}
				options.push(goblinDrugAttack);
				options.push(goblinDrugAttack);
				options.push(goblinTeaseAttack);
				options.push(goblinTeaseAttack);
				options.push(goblinTeaseAttack);
			}
			else if (target.HP() <= target.HPMax() * 0.4)
			{
				if (rand(2) == 0) {
					CombatAttacks.MeleeAttack(this, target);
					return;
				}
				options.push(goblinDrugAttack);
				options.push(goblinDrugAttack);
				options.push(goblinTeaseAttack);
				options.push(goblinTeaseAttack);
			}
			else
			{
				if (rand(3) == 0) {
					CombatAttacks.MeleeAttack(this, target);
					return;
				}
				options.push(goblinDrugAttack);
				options.push(goblinDrugAttack);	
			}
			
			options[rand(options.length)](target);
		}

		protected function goblinDrugAttack(target:Creature):void {
			var temp2:Number = rand(2);
			var multiplier:Number = 1; //Higher tier goblins have powerful potions.
			if (short == "goblin assassin") multiplier += 0.2;
			if (short == "goblin shaman") multiplier += 0.4;
			if (short == "goblin warrior") multiplier += 0.5;
			if (short == "goblin elder") multiplier += 1;
			//multiplier += pc.newGamePlusMod() * 0.5;
			if(this is CoCTamani) temp2 = rand(5);
			if(short == "Tamani's daughters") temp2 = rand(5);
			var color:String = "red";
			if(temp2 == 0) color = "red";
			if(temp2 == 1 && HP() < HPMax()) color = "blue";
			if(temp2 == 2) color = "green";
			if(temp2 == 3) color = "white";
			if(temp2 == 4) color = "black";
			//Throw offensive potions at the pc
			if(color != "blue") {
				if(short == "Tamani's daughters") output("Tamani uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.");
				else output(capitalA + short + " uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.");
			}
			//Drink blue pots
			else {
				if(short == "Tamani's daughters") {
					output("Tamani pulls out a blue vial and uncaps it, then douses the mob with the contents.");
					if(HP() < HPMax()) {
						output("  Though less effective than ingesting it, the potion looks to have helped the goblins recover from their wounds!\n");
						HP(80 * multiplier);
					}
					else output("  There doesn't seem to be any effect.\n");
					output("\n");
				}
				else {
					output(capitalA + short + " pulls out a blue vial and uncaps it, swiftly downing its contents.");
					if(HP() < HPMax()) {
						output("  She looks to have recovered from some of her wounds!\n");
						HP((HPMax() / 4) * multiplier);
						if (this is CoCTamani) HP((HPMax() / 4) * multiplier);
					}
					else output("  There doesn't seem to be any effect.\n");
				}
				return;
			}
			//Dodge chance!
			if (rangedCombatMiss(this, target, -1, 1.33)) {
				output("\nYou narrowly avoid the gush of alchemic fluids!\n");
			}
			else {
				//Get hit!
				if (color == "red") {
					//Temporary heat
					output("\nThe red fluids hit you and instantly soak into your skin, disappearing.  Your skin flushes and you feel warm.  Oh no...\n");
					//if (pc.findStatusAffect(StatusAffects.TemporaryHeat) < 0) pc.createStatusAffect(StatusAffects.TemporaryHeat, 0, multiplier, 0, 0);
					applyDamage(new TypeCollection( { drug : target.libido() / 10 + target.cor() / 10 + 10 } ), this, target);
				}
				//Green poison
				if (color == "green") {
					output("\nThe greenish fluids splash over you, making you feel slimy and gross.  Nausea plagues you immediately - you have been poisoned!\n");
					//if (pc.findStatusEffect(StatusEffects.Poison) < 0) pc.createStatusEffect(StatusEffects.Poison,0,0,0,0);
					applyDamage(new TypeCollection( { poison : damageRand(this.rangedDamage().multiply(1.5), 15).getTotal() } ), this, target);
				}
				//sticky flee prevention
				if (color == "white") {
					output("\nYou try to avoid it, but it splatters the ground around you with very sticky white fluid, making it difficult to run.  You'll have a hard time escaping now!\n");
					target.createStatusEffect("Flee Disabled", 0, 0, 0, 0, false, "Icon_Splatter", "You are all sticky and can't run away!", true, 0);
				}
				//Increase fatigue
				if (color == "black") {
					output("\nThe black fluid splashes all over you and wicks into your skin near-instantly.  It makes you feel tired and drowsy.\n");
					target.energy(-(10 + rand(25)));
				}
			}
		}
			
		protected function goblinTeaseAttack(target:Creature):void {
			if (this is CoCTamani && int(kGAMECLASS.flags["COC.TAMANI_TIMES_HYPNOTISED"]) > 0) {
				(this as CoCTamani).tamaniHypnoTease(target)
				return;
			}
			var det:Number = rand(3);
			if (short == "goblin" || short == "goblin assassin") {
				if (det == 0) output(capitalA + short + " runs her hands along her leather-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) output(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility.  She caresses her snatch and gives you a come hither look.");
				if (det == 2) output(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			else if (short == "goblin warrior") {
				if (det == 0) output(capitalA + short + " runs her hands along her metal-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) output(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility despite the armor she's wearing.  She caresses her snatch and gives you a come hither look.");
				if (det == 2) output(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			else if (short == "goblin shaman") {
				if (det == 0) output(capitalA + short + " runs her hands along her leather-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) output(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility.  She lifts her loincloth and caresses her snatch and gives you a come hither look.");
				if (det == 2) output(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			else if (short == "goblin elder") {
				if (det == 0) output(capitalA + short + " runs her hands along her bone-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.");
				if (det == 1) output(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility.  She lifts her loincloth and caresses her snatch and gives you a come hither look.");
				if (det == 2) output(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.");
			}
			var lustDmg:int = rand(target.libido() / 10) + 8;
			if (short == "goblin assassin") lustDmg *= 1.4;
			if (short == "goblin warrior") lustDmg *= 1.6;
			if (short == "goblin shaman") lustDmg *= 1.6;
			if (short == "goblin elder") lustDmg *= 2;
			applyDamage(new TypeCollection( { tease: lustDmg } ), this, target);
			output("  The display distracts you long enough to prevent you from taking advantage of her awkward pose, leaving you more than a little flushed.\n\n");
		}
	}
}