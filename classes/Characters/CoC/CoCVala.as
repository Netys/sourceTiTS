package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCVala extends Creature
	{
		public function CoCVala() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Vala";
			this.originalRace = "faerie";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "While the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat.  She seems fixated on mating with you, and won't take no for an answer.";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.attackVerb = "caresses";
			this.meleeWeapon.attackNoun = "caresses";
			this.meleeWeapon.hasRandomProperties = true;
			
			//baseHPResistances = new TypeCollection();
			//baseHPResistances.psionic.resistanceValue = 50.0;
			//baseHPResistances.drug.resistanceValue = 50.0;
			//baseHPResistances.pheromone.resistanceValue = 50.0;
			//baseHPResistances.tease.resistanceValue = 50.0;
			//if(game.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) lustVuln += .25;
			//if(game.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) lustVuln += .5;
			
			this.armor.longName = "skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.XPRaw = 500 / (Flag("COC.TIMES_PC_DEFEATED_VALA") + 1);
			this.level = 11;
			this.credits = (1) * 10;
			this.HPMod = 350;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 40 / 20 * this.level;
			this.reflexesRaw = 50 / 20 * this.level;
			this.aimRaw = 50 / 20 * this.level;
			this.intelligenceRaw = 60 / 20 * this.level;
			this.willpowerRaw = 10 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = Math.min(30 + Flag("COC.TIMES_PC_DEFEATED_VALA") * 10, 80);
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_HUMAN;
			this.eyeColor = "green";
			this.tallness = 4 * 12;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "purple";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 22;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "fair";
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
			this.wingType = GLOBAL.TYPE_SYLVAN;
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
			this.girlCumType = GLOBAL.FLUID_TYPE_GIRLCUM;
			this.vaginalVirgin = false;
			this.vaginas[0].type = GLOBAL.TYPE_HUMAN;			
			this.vaginas[0].loosenessRaw = 4;
			this.vaginas[0].wetnessRaw = 3;
			this.vaginas[0].bonusCapacity = 25;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 8;
			
			this.nippleColor = "pink";
			this.milkMultiplier = 100;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 2;
			this.ass.bonusCapacity = 10;
			
			this.createStatusEffect("Disarm Immune");
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.REALLY_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_BALLS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_GAPE,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_HYPER,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			this._isLoading = false;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			//VALA SPEAKS!
			valaCombatDialogue(target);
			//Select Attack
			//BLood magic special
			if (HPQ() < 85 && rand(3) == 0) valaSpecial1(target);
			//25% chance of milksquirt.
			else if (rand(4) == 0) valaSpecial2(target);
			else valaMasturbate(target);
		}

		//Blood magic?
		public function valaSpecial1(target:Creature):void {
			output("Vala dabs at one of her wounds and swoons.  Is she actually getting off from the wounds?  Damn she's damaged!  Vala licks the blood from her fingers, winks, and blows pink mist from her mouth.");
			//Lightly wounded.
			if(HPQ() > 70) {
				output("  The sweet-smelling cloud rapidly fills the room");
				if (!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) {
					output(", but the volume of mist is low enough that you don't end up breathing in that much of it.  It does make your pulse quicken in the most pleasant way though...  ");
					applyDamage(new TypeCollection( { pheromone : 5 + target.libido() / 20 } ), this, target);					
				} else output(".");
			}
			else if(HPQ() > 40) {
				output("  The rose-colored vapor spreads throughout the room");
				if (!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) {
					output(", forcing you to breathe it in or pass out from lack of air.  It smells sweet and makes your head swim with sensual promises and your crotch tingle with desire.  Panicked by the knowledge that you're being drugged, you gasp, but it only draws more of the rapidly disappating cloud into your lungs, fueling your lust.  ");
					applyDamage(new TypeCollection( { pheromone : 10 + target.libido() / 20 } ), this, target);
				} else output(".");
			}
			else {
				output("  The cloying, thick cloud of pink spools out from her mouth and fills the room with a haze of bubblegum-pink sweetness.");
				if (!(target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT))) {
					output("  Even the shallowest, most experimental breath makes your heart pound and your crotch thrum with excitement.  You gasp in another quick breath and sway back and forth on your feet, already on the edge of giving in to the faerie.  ");
					applyDamage(new TypeCollection( { pheromone : 30 + target.libido() / 10 } ), this, target);
				}
			}
		}
		
		//Milk magic
		public function valaSpecial2(target:Creature):void {
			output("With a look of ecstasy on her face, Vala throws back her head and squeezes her pillowy chest with her hands, firing gouts of thick faerie milk from her over-sized bosom!  You try to dodge, but she's squirting so much it's impossible to dodge it all, and in no time you're drenched with a thick coating of Vala's milk.");
			
			if (target.hasArmor() && target.armor.hasFlag(GLOBAL.ITEM_FLAG_AIRTIGHT)) {
				output("  Your armor is watertight!");
				return;
			}
			
			output("  She releases her breasts, shaking them back and forth for your benefit, and flutters her wings, blowing shiny, glitter-like flakes at you.  They stick to the milk on your skin, leaving you coated in milk and faerie-dust.");
			output("\nVala says, \"<i>Now you can be sexy like Vala!</i>\"\n");

			if(hasStatusEffect("Milk")) {
				addStatusValue("Milk", 1, 5);
				output("Your [pc.skin] tingles pleasantly, making you feel sexy and exposed.  Oh no!  It seems each coating of milk and glitter is stronger than the last!");
			}
			else {
				createStatusEffect("Milk", 5);
				output("You aren't sure if there's something in her milk, the dust, or just watching her squirt and shake for you, but it's turning you on.");
			}
			applyDamage(new TypeCollection( { tease : statusEffectv1("Milk") + target.libido() / 20 } ), this, target);
		}
		
		//Masturbation
		public function valaMasturbate(target:Creature):void {
			output("The mind-fucked faerie spreads her alabaster thighs and dips a finger into the glistening slit between her legs, sliding in and out, only pausing to circle her clit.  She brazenly masturbates, putting on quite the show.  Vala slides another two fingers inside herself and finger-fucks herself hard, moaning and panting lewdly.  Then she pulls them out and asks, \"<i>Did you like that?  Will you fuck Vala now?</i>\"  ");
			applyDamage(new TypeCollection( { tease : 4 + target.cor() / 10 } ), this, target);
		}


		//[Fight dialog]
		public function valaCombatDialogue(target:Creature):void {
			if(!hasStatusEffect("Vala")) {
				output("\"<i>Sluts needs to service the masters!</i>\" the fairy wails, flying high. \"<i>If they are not pleased, Bitch doesn't get any cum!</i>\"");
				createStatusEffect("Vala");
			}
			else {
				addStatusValue("Vala", 1, 1);
				if(statusEffectv1("Vala") == 1) output("\"<i>If you won't fuck Bitch, you must not be a master,</i>\" she realizes, the fight invigorating her lust-deadened brain. \"<i>You get to be a pet for the masters, too!</i>\"");
				else if(statusEffectv1("Vala") == 2) output("\"<i>If the masters like you, maybe they will let Bitch keep you for herself! Won't you like that?</i>\"");
				else if(statusEffectv1("Vala") == 3) output("\"<i>We obey the masters. They fed Bitch until she became big enough to please them. The masters love their pets so much, you'll see.</i>\"");
				else if(statusEffectv1("Vala") == 4) output("\"<i>Thoughts are so hard. Much easier to be a toy slut. Won't you like being a toy? All that nasty memory fucked out of your head.</i>\"");
				else if(statusEffectv1("Vala") == 5) output("\"<i>Bitch has given birth to many of the masters' children. She will teach you to please the masters. Maybe you can birth more masters for us to fuck?</i>\"");
				else output("\"<i>Bitch loves when her children use her as their fathers did. Sluts belong to them. Slut love them. You will love them too!</i>\"");
			}
			output("\n\n");
		}
	}
}