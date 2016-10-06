package classes.Characters.CoC 
{
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.kGAMECLASS;
	
	public class CoCUQGoblinBroodmother extends CoCGoblin
	{
		public function CoCUQGoblinBroodmother() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "goblin broodmother";
			this.originalRace = "goblin";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "Thanks to their corruption, it's almost impossible to discern a goblin's age by their appearance, but it's quite obvious that this one is no horny young slut looking for her first dozen or so studs.  Standing before you is an obvious veteran breeder, a proud motherwhore who doubtlessly has a sizable tribe of slutty daughters somewhere not too far away.  Maybe three and a half feet tall, she has vibrant yellow skin - a rare shade, for goblins - and a wild mane of flamboyant neon pink and neon blue striped hair that falls down her back, her long, pointed ears barely visible amongst it.  Her many pregnancies have rendered her absurdly voluptuous. I-cup tits wobble absurdly in the air before her, their jiggling expanse so big that it's a wonder she can reach out to her blatant, teat-like purple nipples. Broodmother hips flare out from her waist, making her sashay from side to side with every step. A gloriously round and luscious bubble-butt, big enough to be DD-cup tits if it were on somebody's chest, jiggles enticingly with every motion.  Lewd leather straps fight to contain her exaggerated boobs and ass, serving more to house clinking pouches and bottles than to provide any protection of her modesty.  Piercings stud her lips, nose, eyebrows, ears, nipples and clit, and her fiery red eyes smoulder as she seductively licks her lips at you.\n\nYour treacherous horse-cock aches to bury itself into this ripe, ready slut, but you have to be strong - you rather doubt she'll let you go with a single fuck, even if you are incapable of giving her the babies she craves...";
			this.customBlock = "";
			
			this.meleeWeapon.attack = 1;
			this.meleeWeapon.longName = "fists";
			this.meleeWeapon.attackVerb = "punch";
			this.meleeWeapon.attackNoun = "tiny punch";
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "leather straps";
			this.armor.defense = 0;
			this.armor.hasRandomProperties = true;
			
			//baseHPResistances.psionic.resistanceValue = 50.0;
			//baseHPResistances.drug.resistanceValue = 50.0;
			//baseHPResistances.pheromone.resistanceValue = 50.0;
			//baseHPResistances.tease.resistanceValue = 50.0;
			
			this.rangedWeapon = new EmptySlot();
			
			this.physiqueRaw = 50 / 20 * this.level;
			this.reflexesRaw = 35 / 20 * this.level;
			this.aimRaw = 35 / 20 * this.level;
			this.intelligenceRaw = 100 / 20 * this.level;
			this.willpowerRaw = 100 / 20 * this.level;
			this.libidoRaw = 70;
			this.personality = 70;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 50;
			
			this.XPRaw = 0;
			this.level = 10;
			this.credits = 0;
			this.HPMod = 300;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.breastRows[0].breastRatingRaw = 24;
			
			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Plot Fight");
			
			inventory = [];
			
			this._isLoading = false;
		}
		
		public function additionalCombatMenuEntries():void
		{
			kGAMECLASS.urtaAdditionalCombatMenuEntries();
		}
	}
}