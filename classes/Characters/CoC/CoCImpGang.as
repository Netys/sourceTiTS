package classes.Characters.CoC
{
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	
	public class CoCImpGang extends CoCImp
	{
		public function CoCImpGang()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "imp gang";
			this.originalRace = "imp";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "The imps stand anywhere from two to four feet tall, with scrawny builds and tiny demonic wings. Their red and orange skin is dirty, and their dark hair looks greasy. Some are naked, but most are dressed in ragged loincloths that do little to hide their groins. Each of them have a " + randomSimpleCockNoun() + " as long and thick as a man's arm, far oversized for their bodies.";
			this.customBlock = "";
			this.isPlural = true;
			
			this.meleeWeapon.attackVerb = "claw";
			this.meleeWeapon.attackNoun = "claw";
			this.meleeWeapon.longName = "claws";
			this.meleeWeapon.baseDamage.kinetic.damageValue = 10;
			this.meleeWeapon.hasRandomProperties = true;
			
			this.armor.longName = "leathery skin";
			this.armor.defense = 3;
			this.armor.hasRandomProperties = true;
			
			baseHPResistances = new TypeCollection();
			baseHPResistances.tease.damageValue = 35.0;
			baseHPResistances.drug.damageValue = 35.0;
			baseHPResistances.pheromone.damageValue = 35.0;
			baseHPResistances.psionic.damageValue = 35.0;
			
			this.level = 10;
			this.XPRaw = bossXP();
			this.credits = (rand(15) + 25) * 10;
			this.HPMod = 300;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 70 / 20 * this.level;
			this.reflexesRaw = 75 / 20 * this.level;
			this.aimRaw = 75 / 20 * this.level;
			this.intelligenceRaw = 42 / 20 * this.level;
			this.willpowerRaw = 42 / 20 * this.level;
			this.libidoRaw = 55;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 30;
			this.personality = 100;
			
			this.cocks = [];
			this.createCock(12);
			this.createCock(25);
			this.createCock(25);
			this.shiftCock(1, GLOBAL.TYPE_EQUINE);
			this.shiftCock(2, GLOBAL.TYPE_CANINE);
			this.cocks[2].knotMultiplier = 2;
			
			this.cumMultiplierRaw *= 15;
			this.cumQualityRaw = 10;
			
			this.impregnationType = "CoCImpPregnancy";

			this.createStatusEffect("Disarm Immune");
			this.createStatusEffect("Flee Disabled", 0, 0, 0, 0, true, "", "", false, 0);
			
			this.inventory = [];
			
			this._isLoading = false;
		}
	}
}