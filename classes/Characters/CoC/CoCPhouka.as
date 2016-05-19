package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.applyDamage;
	import classes.Engine.Combat.combatMiss;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.Engine.Combat.rangedCombatMiss;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Drinks.*;
	import classes.Items.Melee.CoCRidingCrop;
	import classes.Items.Miscellaneous.*;
	import classes.Items.Transformatives.*;
	import classes.Items.Transformatives.CoCDyes.CoCDyeBlack;
	import classes.kGAMECLASS;
	import classes.Util.*;
	
	public class CoCPhouka extends Creature
	{
		public function CoCPhouka() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = kGAMECLASS.phoukaName();
			this.originalRace = "faerie";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The " + this.short + " is flying around near you, waiting for an opening.  He has the general appearance of a faerie, though he is slightly larger and his skin and wings are coal black.  A large cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
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
			
			this.armor.longName = "skin";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			this.rangedWeapon = new EmptySlot();
			
			this.level = 14;
			this.XPRaw = normalXP();
			this.credits = 0;
			this.HPMod = 300;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 55 / 20 * this.level;
			this.reflexesRaw = 25 / 20 * this.level;
			this.aimRaw = 80 / 20 * this.level;
			this.intelligenceRaw = 40 / 20 * this.level;
			this.willpowerRaw = 40 / 20 * this.level;
			this.libidoRaw = 75;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 100;
			
			this.femininity = 75;
			this.eyeType = GLOBAL.TYPE_FELINE;
			this.eyeColor = "green";
			this.tallness = 5;
			this.thickness = 50;
			this.tone = 30;
			this.hairColor = "black";
			this.scaleColor = "none";
			this.furColor = "none";
			this.hairLength = 22;
			this.hairType = GLOBAL.TYPE_HUMAN;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinType = GLOBAL.TYPE_HUMAN;
			this.skinTone = "black";
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
			this.wingType = GLOBAL.TYPE_DARK_SYLVAN;
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
			this.vaginas = [];
			
			this.cocks = new Array();
			this.createCock(1); // yep, 1 inch... which is foot-long for his size
			
			this.breastRows = [];
			this.createBreastRow();
			
			this.nippleColor = "pink";
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 35;
			
			this.ass.wetnessRaw = 1;
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 10;
			
			this.createStatusEffect("Disarm Immune");
			
			inventory.push(kGAMECLASS.WeightedRandom( // shouls also have nothing with 20 weight...
						[new CoCDyeBlack(), new CoCRizzaRoot(), new CoCGroPlus(), new CoCSucDelight(), new CoCPhoukaWhiskey()] ,
						[20,                10,                 12,               13,                  35]));
			
			sexualPreferences.setPref(GLOBAL.SEXPREF_COCKS,			GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_PUSSIES,		GLOBAL.KINDA_LIKES_SEXPREF);
			sexualPreferences.setPref(GLOBAL.SEXPREF_NEUTER,		GLOBAL.REALLY_DISLIKES_SEXPREF);
			
			this._isLoading = false;
		}
		
		override public function cumQ():Number 
		{
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_HORSE) return 50000;
			else return 25000;
		}
		
		override public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			var target:Creature = selectTarget(hostileCreatures);
			if (target == null) return;
			
			var blinded:Boolean = hasStatusEffect("Blinded");
			
			if (!blinded && !target.hasStatusEffect("Silence") && rand(4) == 0) {
				phoukaTransformToPhouka(); //Change to faerie form so that it can lob the ball of muck at you
				phoukaFightSilence(target);
			}
			else {
				var transformChance:int = rand(9); //2 in 3 chance of staying in current form
				if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE) {
					if (blinded) transformChance = rand(3); //100% chance of change from blind phouka if not doing silence attack
					else transformChance = rand(4); //75% chance of change from phouka if not doing silence attack
				}
				switch (transformChance){
					case 0: phoukaTransformToBunny(); break;
					case 1: phoukaTransformToGoat(); break;
					case 2: phoukaTransformToHorse();
					default:
				}
				if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE)
					phoukaFightLustAttack(target); //Can only get here if the phouka isn’t blind
				else if ((kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY) && (rand(4) != 0) && (!blinded))
					phoukaFightLustAttack(target); //Bunny has a 75% chance of teasing attack, no teasing while blind
				else if ((kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_HORSE) && (rand(4) == 0) && (!blinded))
					phoukaFightLustAttack(target); //Horse has a 25% chance of teasing attack, no teasing while blind
				else phoukaFightAttack(target);
			}
		}
		
		protected function phoukaFightAttack(target:Creature):void
		{ 
			var damage:int;
			//Only the bunny, goat and horse forms make physical attacks
			if (hasStatusEffect("Blinded") && rand(3) < 1) {
				output(capitalA + short + " completely misses you due to his blindness!");
			}
			else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY) {
				//damage = Math.round((60 + 30 + 10) - rand(pc.tou) - pc.armorDef); //60 == Bunny Strength, 30 == Bunny Weapon Attack
				output("The bunny morph hops towards you.  At the last second he changes direction and throws a kick toward you with his powerful hind legs.");
				if (combatMiss(this, target))
					output("\nThrowing yourself out of the way, you manage to avoid the kick.  The " + this.short + " hops out of reach and prepares for another attack.");
				else {
					output("\nThe kick connects and leaves you reeling.");
					applyDamage(this.meleeDamage().rand(), this, target, "melee");
				}
			}
			else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_GOAT) {
				//damage = Math.round((80 + 40 + 10) - rand(pc.tou) - pc.armorDef); //80 == Goat Strength, 40 == Goat Weapon Attack
				output("The goat morph races toward you, head down.");
				if (combatMiss(this, target))
					output("\nThrowing yourself out of the way, you manage to keep from getting skewered.");
				else {
					output("\nIts head and horns crash into you, leaving you winded and bruised.");
					applyDamage(this.meleeDamage().multiply(1.25).rand(), this, target, "melee");
				}
			}
			else { //HORSE
				//damage = Math.round((95 + 55 + 10) - rand(pc.tou) - pc.armorDef); //95 == Horse Strength, 55 == Horse Weapon Attack
				output("The stallion charges you, clearly intending to trample you under its hooves.");
				if (combatMiss(this, target))
					output("\nAs the stallion passes you twist in place and manage to stay clear of its legs.");
				else {
					output("\nYou get clipped by the stallion's legs and hooves as he charges. As he comes around for another pass you check over your body, amazed none of your bones are broken after that.");
					applyDamage(this.meleeDamage().multiply(1.5).rand(), this, target, "melee");
				}
			}
		}
		
		protected function phoukaFightLustAttack(target:Creature):void
		{
			//Only the faerie, bunny and horse forms make lust attacks
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE)
				output("The " + this.short + " uses his wings to climb high up in the air above you.  Then he starts jerking his cock at you with one hand while fondling his balls with the other.  ");
			else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY)
				output("The bunny morph leaps forward, trying to catch you off guard and grapple you.  ");
			else output("The stallion rears up on his hind legs, waving his massive cock at you.  ");
			
			if (combatMiss(this, target)) {
				if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY)
					output("You throw yourself out of the way at the last moment and succeed in throwing the " + this.short + " off balance. He staggers away, his attempted attack ruined.");
				else output("You manage to look away in time and the " + possessive(this.short) + " lewd display has no real effect on you.");
			}
			else {
				if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE)
					output("A drizzle of precum rains down around you.  The sight of the " + this.short + " pumping his shaft along with the smell of the salty yet sweet fluids makes you wish you could stop fighting and concentrate on pleasuring yourself.");
				else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY)
					output("He grabs you and rubs up against your body.  For a moment you are lost in the feeling of his soft black fur.  Then you feel his cock pressing against your ribs and shove him away.");
				else output("You are hypnotized by the equine cock jabbing at the air.  Then the " + this.short + " charges past you and you can taste the musk in the air.");
				
				applyDamage(new TypeCollection( { tease : 15 + target.libido() / 10 + target.cor() / 5 + rand(10) } ), this, target, "melee");
			}
		}
		
		protected function phoukaFightSilence(target:Creature):void
		{
			//Reuses the statusEffect Web-Silence from the spiders
			output(this.capitalA + this.short + " scoops up some muck from the ground and rams it down over his cock.  After a few strokes he forms the lump of mud and precum into a ball and whips it at your face.  ");
			if (hasStatusEffect("Blinded") && rand(3) < 2)
				output("Since he's blind the shot goes horribly wide, missing you entirely.");
			else
			{
				if (rangedCombatMiss(this, target))
					output("You lean back and let the muck ball whip pass to one side, avoiding the attack.");
				else {
					output("The ball smacks into your face like a wet snowball.  It covers most of your nose and mouth with a layer of sticky, salty mud which makes it hard to breathe.  You'll be unable to use your magic while you're struggling for breath!\n");
					target.createStatusEffect("Silence", 3, 0, 0, 0, false, "Icon_Silence", "You can't talk with that sticky mud on yor face!", true, 0);
				}
			}
		}
		
		public function teaseReactions(damage:Number):void
		{
			if (damage >= 10)
				output("The " + this.short + " breaks off its attack in the face of your teasing.  Its drooling member leaves a trail of precum along the ground and you get the feeling it needs to end this fight quickly.");
			else if (damage >= 5)
				output("The " + this.short + " stops its assault for a moment.  A glob of precum oozes from its cock before it shakes its head and gets ready to attack again.");
			else if (damage > 0)
				output("The " + this.short + " hesitates and slows down.  You see its cock twitch and then it readies for the next attack.");
		}
		
		protected function phoukaTransformToBunny():void
		{
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY) return; //Already a bunny, so no change
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE) {
				output("The faerie suddenly drops out of the air.  A look of concentration sets in on its face and it begins to expand and warp.  You blink and see that in front of you there is now a 5 foot tall bunny morph.\n\n");
			}
			else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_GOAT) {
				output("As the goat morph charges towards you it starts to grow.  By the time it gets close it has changed completely and you now face a 5 foot tall bunny morph.\n\n");
			}
			else { //Was a horse
				output("As the horse morph charges towards you it quite suddenly shrinks.  You have to adjust your defence as a 5 foot tall bunny morph is now hopping your way.\n\n");
			}
			this.long = "The " + this.short + " is hopping around near you, waiting for an opening.  He has the general appearance of a bunny with coal black fur.  A large cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			//this.armorValue = 60;
			//this.spe = 90;
			kGAMECLASS.phoukaForm = kGAMECLASS.PHOUKA_FORM_BUNNY;
		}
		
		protected function phoukaTransformToGoat():void
		{
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_GOAT) return; //Already a goat, so no change
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE) {
				output("The faerie suddenly drops out of the air.  A look of concentration sets in on its face and it begins to expand and warp.  You blink and see that in front of you there is now a 4 foot tall goat morph.\n\n");
			}
			else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY) {
				output("The bunny morph hops back from you and starts to melt and change.  You blink and see that in front of you there is now a 4 foot tall goat morph.\n\n");
			}
			else { //Was a horse
				output("As the horse morph charges towards you it quite suddenly shrinks.  You have to adjust your defence as it is now a 4 foot tall goat morph.\n\n");
			}
			this.long = "The " + this.short + " is charging back and forth just out of reach, waiting for an opening.  He has the general appearance of a goat with coal black fur.  He has large glossy black horns and a large cock between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			//this.armorValue = 60;
			//this.spe = 70;
			kGAMECLASS.phoukaForm = kGAMECLASS.PHOUKA_FORM_GOAT;
		}
		
		protected function phoukaTransformToHorse():void
		{
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_HORSE) return; //Already a horse, so no change
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE) {
				output("The faerie suddenly drops out of the air.  A look of concentration sets in on its face and it begins to grow larger and larger.  You watch amazed as the creature's form stretches.  Finally it seems unable to grow further and settles into the form of a massive stallion.\n\n");
			}
			else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY) {
				output("The bunny morph hops back from you and starts to grow and melt.  You watch amazed as the creature's form stretches.  Finally it seems unable to grow further and settles into the form of a massive stallion.\n\n");
			}
			else { //Was a goat
				output("The goat morph eyes you then seems to think better of charging again.  It backs away and starts to grow larger and larger, its features and body shape twisting and reforming.  Finally it seems unable to grow further and settles into the form of a massive stallion.\n\n");
			}
			this.long = "The " + this.short + " is running in a wide circle around you, waiting for an opening.  He has the general appearance of a stallion with coal black fur.  A massive cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			//this.armorValue = 75;
			//this.spe = 55;
			kGAMECLASS.phoukaForm = kGAMECLASS.PHOUKA_FORM_HORSE;
		}
		
		protected function phoukaTransformToPhouka():void
		{
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_FAERIE) return; //Already a faerie, so no change
			if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_BUNNY) {
				output("The bunny morph hops back from you and starts to melt and shrink.  In seconds only a tiny faerie is left floating in the air where the bunny once was.\n\n");
			}
			else if (kGAMECLASS.phoukaForm == kGAMECLASS.PHOUKA_FORM_GOAT) {
				output("The goat morph bounds away from you and starts to melt and deform.  In seconds only a tiny faerie is left floating in the air where the goat once was.\n\n");
			}
			else { //Was a horse
				output("The horse morph charges past you.  You look over your shoulder and wonder where the stallion could have gone.  Then you see the tiny faerie zipping back for another attack.\n\n");
			}
			this.long = "The " + this.short + " is flying around near you, waiting for an opening.  He has the general appearance of a faerie, though he is slightly larger and his skin and wings are coal black.  A large cock stands erect between his legs.  His cat-like green eyes, filled with lust, follow your every motion.";
			//this.armorValue = 80;
			//this.spe = 80;
			kGAMECLASS.phoukaForm = kGAMECLASS.PHOUKA_FORM_FAERIE;
		}
		
		//override public function handleAwardItemText(itype:ItemType):void
		//{
			//output("  You are just about to leave when you remember that glint from the hollow of that nearby tree.");
			//if (itype == null)
				//output("\n\nYou take a look and curse the " + this.short + ".  Looks like it used a piece of a broken bottle to lure you in.  At least you learned more about fighting the little pests.  You gain " + this.XP + " XP from your victory.");
			//else output("\n\nYou look inside the hollow and are pleased to find " + itype.longName + ".  You also gain " + this.XP + " XP from your victory, since you learned a bit more about fighting these little pests.\n\n");
		//}
		//
		//override public function handleCombatLossText(inDungeon:Boolean, gemsLost:int):int
		//{
			//if (pc.gems > 1)
				//output("  Once free you check your gem pouch and realize the " + this.short + " took " + gemsLost + " of your gems.");
			//else if (pc.gems == 1)
				//output("  Once free you check your gem pouch and realize the " + this.short + " took your only gem.");
			//return 1; //Only use up one hour after combat loss
		//}
	}
}