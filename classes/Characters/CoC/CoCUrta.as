package classes.Characters.CoC 
{
	import classes.Characters.PlayerCharacter;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GLOBAL;
	import classes.Items.Apparel.LeatherArmor;
	import classes.Items.Melee.CoCMinotaurAxe;
	import classes.Items.Melee.Rock;
	import classes.Util.*;
	
	public class CoCUrta extends PlayerCharacter
	{
		public function CoCUrta() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Urta";
			this.originalRace = "vulpine-morph";
			this.a = "";
			this.capitalA = "";
			this.long = "";
			this.customDodge = "";
			this.customBlock = "";
			
			this.meleeWeapon = new CoCMinotaurAxe();
			this.meleeWeapon.hasRandomProperties = true;
			this.meleeWeapon.longName = "halberd";
			
			this.armor = new LeatherArmor();
			
			this.rangedWeapon = new Rock();
			
			this.armor.longName = "skimpy robes";
			this.armor.defense = 0;
			this.armor.evasion = 10;
			this.armor.hasRandomProperties = true;
			
			this.level = 15;
			this.XPRaw = normalXP();
			this.credits = 1830;
			this.HPMod = 120;
			this.shieldsRaw = this.shieldsMax();
			this.HP(this.maxHP());
			this.energy(this.energyMax());
			
			this.physiqueRaw = 75 / 20 * this.level;
			this.reflexesRaw = 90 / 20 * this.level;
			this.aimRaw = 90 / 20 * this.level;
			this.intelligenceRaw = 55 / 20 * this.level;
			this.willpowerRaw = 55 / 20 * this.level;
			this.libidoRaw = 70;
			this.personality = 30;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 55;
			
			this.thickness = 30;
			this.tone = 50;
			this.femininity = 90;
			this.skinTone = "black";
			this.furColor = "gray";
			this.eyeColor = "green";
			this.lipColor = "black";
			this.nippleColor = "black";
			this.hairColor = "gray";
			
			this.skinType = GLOBAL.SKIN_TYPE_FUR;
			this.eyeType = GLOBAL.TYPE_VULPINE;
			this.tallness = 71;
			this.hairLength = 12;
			this.hairType = GLOBAL.HAIR_TYPE_REGULAR;
			this.beardLength = 0;
			this.beardStyle = 0;
			this.skinFlags = [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_FLUFFY];
			this.lipMod = 1;
			
			this.legType = GLOBAL.TYPE_VULPINE;
			this.legCount = 2;
			this.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_PAWS, GLOBAL.FLAG_FURRED];
			this.armType = GLOBAL.TYPE_VULPINE;
			this.armFlags = [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
			this.earType = GLOBAL.TYPE_VULPINE;
			this.faceType = GLOBAL.TYPE_VULPINE;
			this.faceFlags = [GLOBAL.FLAG_MUZZLED];
			this.tongueType = GLOBAL.TYPE_VULPINE;
			this.tailType = GLOBAL.TYPE_VULPINE;
			this.tailFlags = [GLOBAL.FLAG_LONG, GLOBAL.FLAG_FURRED, GLOBAL.FLAG_FLUFFY];
			this.tailCount = 1;
			
			this.hipRatingRaw = 12;
			this.buttRatingRaw = 12;
			
			this.cocks = [];
			this.createCock();
			this.shiftCock(0, GLOBAL.TYPE_EQUINE);
			this.cocks[0].cLengthRaw = 20;
			this.cocks[0].cThicknessRatioRaw = 0.9; // 3"
			this.balls = 2;
			this.ballSizeRaw = 3 * Math.PI;
			this.cumMultiplierRaw = 80;
			
			this.vaginas = [];
			this.createVagina();
			this.shiftVagina(0, GLOBAL.TYPE_CANINE);
			this.vaginas[0].bonusCapacity = 20; // 58 originally, TODO: recalculate
			this.vaginas[0].wetnessRaw = 4;
			this.vaginas[0].loosenessRaw = 2;
			this.vaginas[0].vaginaColor = "black";
			this.vaginas[0].hymen = false;
			this.vaginalVirgin = false;
			this.analVirgin = false;
			this.cockVirgin = false;
			this.clitLength = 1;
			
			this.ass.wetnessRaw = 0;
			this.ass.loosenessRaw = 2;
			this.ass.minLooseness = 2;
			
			this.breastRows = [];
			this.createBreastRow();
			this.breastRows[0].breastRatingRaw = 5;
			this.nippleLengthRatio = 1.5;
			this.milkMultiplier = 0;
			this.milkType = GLOBAL.FLUID_TYPE_MILK;
			this.milkRate = 10;
			
			this.ass.loosenessRaw = 1;
			this.ass.bonusCapacity = 100;
			
			//PERKS
			//this.createPerk(PerkLib.Resistance,0,0,0,0);
			//this.createPerk(PerkLib.Agility,0,0,0,0);
			//this.createPerk(PerkLib.WeaponMastery,0,0,0,0);
			//this.createPerk(PerkLib.Acclimation,0,0,0,0);
			//this.createPerk(PerkLib.Nymphomania,0,0,0,0);
			//this.createPerk(PerkLib.Precision,0,0,0,0);
			//this.createPerk(PerkLib.Seduction,0,0,0,0);
			//this.createPerk(PerkLib.Evade,0,0,0,0);
			//this.createPerk(PerkLib.Tactician,0,0,0,0);
			//this.createPerk(PerkLib.LungingAttacks,0,0,0,0);
			//this.createPerk(PerkLib.ImmovableObject,0,0,0,0);
			//this.createPerk(PerkLib.BrutalBlows,0,0,0,0);
			//this.createPerk(PerkLib.Brawler,0,0,0,0);
			//this.createPerk(PerkLib.Berzerker,0,0,0,0);
			//this.createPerk(PerkLib.Tank,0,0,0,0);
			//this.createPerk(PerkLib.HistoryFighter,0,0,0,0);
			
			
			//GEAR!
			//this.setWeapon(weapons.URTAHLB);
			//this.setArmor(armors.URTALTA);
			
			this.createPerk("Agility", 0, 0, 0, 0);
			this.createPerk("Brutal Blows", 0, 0, 0, 0);
			this.createPerk("Double Attack", 0, 0, 0, 0);
			this.createPerk("Evade", 0, 0, 0, 0);
			this.createPerk("Fortitude", 0, 0, 0, 0);
			this.createPerk("Hold With Both Hands", 0, 0, 0, 0);
			this.createPerk("Immovable Object", 0, 0, 0, 0);
			this.createPerk("Iron Fists", 0, 0, 0, 0);
			this.createPerk("Lunging Attacks", 0, 0, 0, 0);
			this.createPerk("Nymphomania", 0, 0, 0, 0);
			this.createPerk("Parry", 0, 0, 0, 0);
			this.createPerk("Tank", 0, 0, 0, 0);
			this.createPerk("Transformation Resistance", 0, 0, 0, 0, "You are extremely resistant to any transformatives.");
			
			this._isLoading = false;
		}
	}
}