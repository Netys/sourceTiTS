﻿package classes {
	import classes.Characters.PlayerCharacter;
	import classes.Characters.PregnancyPlaceholder;
	import classes.Characters.Emmy;
	import classes.CockClass;
	import classes.DataManager.Errors.VersionUpgraderError;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GameData.SingleCombatAttack;
	import classes.Items.Guns.MyrBow;
	import classes.Items.Melee.Fists;
	import classes.Items.Melee.Rock;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Items.Miscellaneous.HorsePill;
	import classes.Items.Transformatives.Goblinola;
	import classes.Items.Transformatives.Clippex;
	import classes.Items.Transformatives.SemensFriend;
	import classes.Items.Accessories.TamWolf;
	import classes.Items.Accessories.TamWolfDamaged;
	import classes.Items.Accessories.Allure;
	import classes.VaginaClass;
	import classes.BreastRowClass;
	import classes.StorageClass;
	import classes.ItemSlotClass;
	import classes.DataManager.Serialization.ISaveable;
	import classes.DataManager.Serialization.VersionedSaveable;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import classes.GameData.StatTracking;
	import classes.Engine.Utility.num2Text;
	import classes.Engine.Utility.num2Ordinal;
	import flash.utils.ByteArray;
	import classes.GLOBAL;
	import classes.GameData.Pregnancy.PregnancyManager;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.Util.RandomInCollection;
	import classes.Util.InCollection;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Utility.plural;
	import classes.Engine.Utility.possessive;
	import classes.Engine.Combat.DamageTypes.DamageType;
	import classes.Engine.Utility.weightedRand;


	/**
	 * I cannot yet implement "smart" detection of which characters (or furthermore, what *properties* of which characters)
	 * actually need to be serialized, because the raw storage types used throughout the Creature class (f.ex Cocks Array) are
	 * not aware of their parent class. One of the next goals will be to replace the raw storage containers with some form of
	 * interface container that can be aware of it's parent, and tie back into the serialization state.
	 * This needs to be done ti chain the getSaveObject()/loadSaveObject() to completion anyway, but we can then also hook back
	 * into a property on the parent container to detect changes-over-default. This would enable "deltasaves" in effect, where
	 * the only values stored are values that differ from compile-time values for each creature.
	 * Note to self: mx.utils has some describeType caching which may be a thing to look at. It also has some handy-dandy features
	 * for checking class properties (isDynamic etc, mx.utils.ObjectUtil)
	 */
	public class Creature extends VersionedSaveable {
		/**
		 * NeverSerialize is a seperate flag that can be applied on a creature-by-creature basis. Any creature with the
		 * NeverSerialize flag set will be omitted from the save/load process. There are probably many Creatures that will
		 * never actually need persistent storage throughout the lifetime of the game, so storing their state in player saves
		 * seems much overkill.
		 */
		protected var _neverSerialize: Boolean = false;
		public function get neverSerialize(): Boolean {
			return _neverSerialize;
		}

		private static const STAT_CLAMP_VALUE:Number = 0;
		
		//Constructor
		public function Creature() {
			_ignoredFields.push(
				"neverSerialize", 
				"droneTarget", 
				"concentratedFireTarget",
				"uniqueName",
				"flags",
				"bustDisplay",
				"buttonText",
				"btnTargetText",
				"alreadyDefeated",
				"shieldDisplayName",
				"skipIntercept",
				"skipTurn",
				"_skipRound",
				"OnTakeDamageOutput",
				"isUniqueInFight"
			);
			
			cocks = new Array();
			vaginas = new Array();
			breastRows = new Array();
			breastRows[0] = new BreastRowClass();
			perks = new Array();
			statusEffects = new Array();
			keyItems = new Array();
			inventory = new Array();
			sexualPreferences = new SexualPreferences();
			
			pregnancyData = new Array();
			for (var i:int = 0; i < 4; i++)
			{
				pregnancyData.push(new PregnancyData());
			}
		}

		//For enemies
		public var short: String = "";
		public var originalRace: String = "human";
		public var a: String = "a ";
		public var long: String = "You scrawny, yo.";
		public var capitalA: String = "A ";

		//Is a creature a 'pluralize' encounter - mob, etc. 
		public var isPlural:Boolean = false;

		public var fluidSimulate:Boolean = false;
		public var statusSimulate:Boolean = false;

		public var customDodge: String = "";
		public var customBlock: String = "";

		//Clothing/Armor
		public var meleeWeapon: ItemSlotClass = new EmptySlot();
		public var rangedWeapon: ItemSlotClass = new EmptySlot();
		public var armor: ItemSlotClass = new EmptySlot();
		public var upperUndergarment: ItemSlotClass = new EmptySlot();
		public var lowerUndergarment: ItemSlotClass = new EmptySlot();
		public var accessory: ItemSlotClass = new EmptySlot();
		public var shield: ItemSlotClass = new EmptySlot();

		public var inventory: /*ItemSlotClass*/ Array = new Array();

		public var typesBought: /*int*/ Array = new Array();
		public var sellMarkup: Number = 1;
		public var buyMarkdown: Number = 1;
		public var keeperGreeting: String = "<i>“Hello and welcome to my shop. Take a gander and let me know if you see anything you like,”</i> " + a + short + " says with a smile.";
		public var keeperBuy: String = "What would you like to buy?\n";
		public var keeperSell: String = "What would you like to sell?\n";
		
		//Primary stats
		private var _physiqueRaw: Number = 3;
		public function get physiqueRaw():Number
		{
			return _physiqueRaw;
		}
		public function set physiqueRaw(v:Number):void
		{
			if (v < Creature.STAT_CLAMP_VALUE)
			{
				_physiqueRaw = Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				_physiqueRaw = v;
			}
		}

		private var _reflexesRaw: Number = 3;
		public function get reflexesRaw():Number
		{
			return _reflexesRaw;
		}
		public function set reflexesRaw(v:Number):void
		{
			if (v < Creature.STAT_CLAMP_VALUE)
			{
				_reflexesRaw = Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				_reflexesRaw = v;
			}
		}

		private var _aimRaw: Number = 3;
		public function get aimRaw():Number
		{
			return _aimRaw;
		}
		public function set aimRaw(v:Number):void
		{
			if (v < Creature.STAT_CLAMP_VALUE)
			{
				_aimRaw = Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				_aimRaw = v;
			}
		}

		private var _intelligenceRaw: Number = 3;
		public function get intelligenceRaw():Number
		{
			return _intelligenceRaw;
		}
		public function set intelligenceRaw(v:Number):void
		{
			if (v < Creature.STAT_CLAMP_VALUE)
			{
				_intelligenceRaw = Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				_intelligenceRaw = v;
			}
		}

		private var _willpowerRaw: Number = 3;
		public function get willpowerRaw():Number
		{
			return _willpowerRaw;
		}
		public function set willpowerRaw(v:Number):void
		{
			if (v < Creature.STAT_CLAMP_VALUE)
			{
				_willpowerRaw = Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				_willpowerRaw = v;
			}
		}

		private var _libidoRaw: Number = 3;
		public function get libidoRaw():Number
		{
			return _libidoRaw;
		}
		public function set libidoRaw(v:Number):void
		{
			if (v < Creature.STAT_CLAMP_VALUE)
			{
				_libidoRaw = Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				_libidoRaw = v;
			}
		}
		
		public var physiqueMod: Number = 0;
		public var reflexesMod: Number = 0;
		public var aimMod: Number = 0;
		public var intelligenceMod: Number = 0;
		public var willpowerMod: Number = 0;
		public var libidoMod: Number = 0;

		public var affinity: String = "intelligence";
		public var characterClass: int = GLOBAL.CLASS_SMUGGLER;
		public var personality: int = 50;
		public var exhibitionismRaw: Number = 0;

		//Combat Stats
		// I think some of my UI work has highlighted some areas where stats are doing things that aren't intended, or otherwise possibly broken.
		// The safest way I can think of fixing these issues, is to clamp the potential possible values given to the raw vars.
		
		// HP should probably never go BELOW 0, as it has implications on rest mechanics.
		private var _HPRaw: int = 0;
		
		public function get HPRaw():int { return _HPRaw; }
		public function set HPRaw(v:int):void
		{
			if (v < 0)
			{
				_HPRaw = 0;
			}
			else
			{
				_HPRaw = v;
			}
		}
		
		public var HPMod: int = 0;

		public var shieldsRaw: int = 0;
		public var lustRaw: Number = 0;
		public var lustMod: Number = 0;
		public var energyRaw: Number = 100;
		public var energyMod: Number = 0;
		public var teaseLevel: Number = 0;
		public var teaseXP: Number = 0;

		//Resistances
		public var baseHPResistances:TypeCollection = new TypeCollection();
		public var baseShieldResistances:TypeCollection = new TypeCollection();
		
		public function getShieldResistances():TypeCollection
		{
			var r:TypeCollection = baseShieldResistances.makeCopy();			
			if (!(shield is EmptySlot)) r.combineResistances(shield.resistances);
			if (hasPerk("Enhanced Dampeners"))
			{
				for (var i:uint = 0; i < DamageType.NUMTYPES; i++)
				{
					var type:DamageType = r.getType(i);
					if (type.resistanceValue < 0) type.resistanceValue /= 2;
				}
			}
			return r;
		}
		
		public function getHPResistances():TypeCollection
		{
			var r:TypeCollection = baseHPResistances.makeCopy();
			if (!(armor is EmptySlot)) r.combineResistances(armor.resistances);
			if (!(lowerUndergarment is EmptySlot)) r.combineResistances(lowerUndergarment.resistances);
			if (!(upperUndergarment is EmptySlot)) r.combineResistances(upperUndergarment.resistances);
			if (!(accessory is EmptySlot)) r.combineResistances(accessory.resistances);
			
			// Effect: Boosts max HP and poison resistance by 10% for 24 hours
			if (hasStatusEffect("Heart Tea")) r.poison.damageValue = r.poison.damageValue * 1.1;
			
			return r;
		}
		
		public function getLustResistances():TypeCollection
		{
			var r:TypeCollection = new TypeCollection();
			if (shieldsRaw > 0) r.combineResistances(getShieldResistances());
			r.combineResistances(getHPResistances());
			return r;
		}
		
		public var isLustImmune:Boolean = false;

		//Level Stats
		public var XPRaw: Number = 0;
		public var level: Number = 1;
		public var credits: Number = 500;
		//Perks used to store 'queued' perk buys
		public var perkPoints: Number = 0;

		//Appearance Variables
		public var femininity: Number = 50;
		public function femininityUnlocked(newFem:Number):Boolean 
		{
			return true;
		}
		public function femininityLockedMessage():String 
		{
			return "Your [pc.face] warms, but nothing happens.";
		}
		
		public var eyeType: Number = 0;
		public function eyeTypeUnlocked(newEyeType:int):Boolean 
		{
			if (eyeType == GLOBAL.TYPE_SYNTHETIC) return false;
			return true;
		}
		public function eyeTypeLockedMessage():String
		{
			return "Your [pc.eye] twitches, resisting a change.";
		}
		
		public var eyeColor: String = "";
		public function eyeColorUnlocked(newEyeColor:String):Boolean 
		{
			if (eyeType == GLOBAL.TYPE_SYNTHETIC) return false;
			return true;
		}
		public function eyeColorLockedMessage():String 
		{
			return "Your [pc.eye] twitches, resisting a change.";
		}
		
		public var tallness: Number = 0;
		public function tallnessUnlocked(newTallness:Number):Boolean
		{
			return true;
		}
		public function tallnessLockedMessage():String
		{
			return "You feel momentarily drawn out, stretched even. The sensation passes as soon as it came.";
		}

		public var thickness: Number = 0;
		public function thicknessMin():Number
		{
			return 0;
		}
		public function thicknessMax():Number
		{
			return 100;
		}
		public function thicknessUnlocked(newThickness:Number):Boolean
		{
			return true;
		}
		public function thicknessLockedMessage():String
		{
			return "You feel momentarily bloated. It passes without incident.";
		}

		public var tone: Number = 0;
		public function toneMin():Number
		{
			return 0;
		}
		public function toneMax():Number
		{
			if(hasSkinFlag(GLOBAL.FLAG_SQUISHY)) return 30;
			return 100;
		}
		public function toneUnlocked(newTone:Number):Boolean
		{
			if(hasSkinFlag(GLOBAL.FLAG_SQUISHY) && newTone > tone && newTone >= toneMax()) return false;
			return true;
		}
		public function toneLockedMessage():String
		{
			if(hasSkinFlag(GLOBAL.FLAG_SQUISHY)) return "You feel a slight soreness but nothing seems to come of it. Your squishy body makes it apparent that you can’t get any more tone than you are now!";
			return "You twitch, feeling momentarily sore. Nothing seems to come of it.";
		}

		public var hairColor: String = "no";
		public function hairColorUnlocked(newHairColor:String):Boolean
		{
			return true;
		}

		public function hairColorLockedMessage():String
		{
			return "Your scalp briefly tingles, but your [pc.hair] remains unchanged.";
		}

		public var scaleColor: String = "blue";
		public function scaleColorUnlocked(newScaleColor:String):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function scaleColorLockedMessage():String
		{
			return "Your scales briefly itch, but nothing happens.";
		}

		public var furColor: String = "brown";
		public function furColorUnlocked(newFurColor:String):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function furColorLockedMessage():String
		{
			return "Your fur briefly itches, but nothing happens.";
		}

		public var hairLength: Number = 0;
		public var hairStyle:String = "null";
		public function hairLengthUnlocked(newHairLength:Number):Boolean
		{
			if (hasPerk("Mane") && newHairLength <= 3) return false;
			if (hairType == GLOBAL.HAIR_TYPE_GOO && (skinType == GLOBAL.SKIN_TYPE_GOO || hasStatusEffect("Goo Vent"))) return false;
			return true;
		}
		public function hairLengthLockedMessage():String
		{
			if (hasPerk("Mane")) return "Your scalp briefly tingles, but your [pc.hair] refuses to change. It seems your mane can’t get any shorter!";
			return "Your scalp briefly tingles, but your [pc.hair] remains unchanged.";
		}

		public var hairType: Number = 0;
		public function hairTypeUnlocked(newhairType:Number):Boolean
		{
			if (hairType == GLOBAL.HAIR_TYPE_GOO && (skinType == GLOBAL.SKIN_TYPE_GOO || hasStatusEffect("Goo Vent"))) return false;
			return true;
		}
		public function hairTypeLockedMessage():String
		{
			return "Your scalp briefly tingles, but your [pc.hair] remains unchanged.";
		}
		
		public var beardLength: Number = 0;
		public function beardLengthUnlocked(newBeardLength:Number):Boolean
		{
			return true;
		}
		public function beardLengthLockedMessage():String
		{
			return "Your chin briefly tingles, but your [pc.beard] remains unchanged.";
		}

		public var beardStyle: Number = 0;
		public function beardStyleUnlocked(newBeardStyle:Number):Boolean
		{
			return true;
		}
		public function beardStyleLockedMessage():String
		{
			return "Your chin briefly tingles, but your [pc.beard] remains unchanged.";
		}

		public var skinType: Number = 0;
		public function skinTypeUnlocked(newSkinType:Number):Boolean
		{
			return true;
		}
		public function skinTypeLockedMessage():String
		{
			return "Your [pc.skin] briefly itches, but nothing happens.";
		}

		public var skinTone: String = "albino";
		public var skinAccent: String = "";
		public function skinToneUnlocked(newSkinTone:String):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function skinToneLockedMessage():String
		{
			return "Your [pc.skin] briefly itches, but nothing happens.";
		}

		public var skinFlags: Array = new Array();
		public function skinFlagsUnlocked(newFlags:*):Boolean
		{
			return true;
		}
		public function skinFlagsLockedMessage():String
		{
			return "Your [pc.skin] briefly itches, but nothing happens.";
		}

		public var faceType: Number = 0;
		public function faceTypeUnlocked(newFaceType:Number):Boolean
		{
			return true;
		}
		public function faceTypeLockedMessage():String
		{
			return "Your [pc.face] briefly itches, but nothing happens.";
		}

		public var faceFlags: Array = new Array();
		public function faceFlagsUnlocked(newFlags:*):Boolean
		{
			return true;
		}
		public function faceFlagsLockedMessage():String
		{
			return "Your [pc.face] briefly itches, but nothing happens.";
		}

		public var tongueType: Number = 0;
		public function tongueTypeUnlocked(newTongueType:Number):Boolean
		{
			return true;
		}
		public function tongueTypeLockedMessage():String
		{
			return "Your [pc.tongue] feels odd in your mouth but doesn't change.";
		}

		public var tongueFlags: Array = new Array();
		public function tongueFlagsUnlocked(newFlags:*):Boolean
		{
			return true;
		}
		public function tongueFlagsLockedMessage():String
		{
			return "Your [pc.tongue] feels odd in your mouth but doesn't change.";
		}

		public var lipMod:Number = 0;
		public function lipModUnlocked(newLipMod:Number):Boolean
		{
			return true;
		}
		public function lipModLockedMessage():String
		{
			return "Your [pc.lips] feel momentarily hot, but a quick lick confirms that nothing has changed.";
		}
		public var lipColor:String = "peach";

		public var earType: Number = 0;
		public var earLength:Number = 0;
		public function earTypeUnlocked(newEarType:Number):Boolean
		{
			return true;
		}
		public function earTypeLockedMessage():String
		{
			return "Your [pc.ears] are burning. Someone must be talking about you.";
		}

		public var antennae: Number = 0;
		public function antennaeUnlocked(newAntennaeNumber:Number):Boolean
		{
			return true;
		}
		public function antennaeLockedMessage():String
		{
			if(antennae == 0) return "Your forehead is burning but nothing changes.";
			if(antennae == 1) return "Your [pc.antenna] tingles for a moment. Someone must be thinking about you.";
			return "Your [pc.antennae] are burning. Someone must be thinking about you.";
		}
		
		public var antennaeType: Number = 0;
		public function antennaeTypeUnlocked(newAntennaeType:Number):Boolean
		{
			return true;
		}
		public function antennaeTypeLockedMessage():String
		{
			if(antennae == 0) return "Your forehead is burning but nothing changes.";
			if(antennae == 1) return "Your [pc.antenna] tingles for a moment. Someone must be thinking about you.";
			return "Your [pc.antennae] are burning. Someone must be thinking about you.";
		}
		
		public var horns: Number = 0;
		public function hornsUnlocked(newHornsNumber:Number):Boolean
		{
			return true;
		}
		public function hornsLockedMessage():String
		{
			if(horns == 0) return "You have a brief headache. It fades as quickly as it came, changing nothing.";
			return "You have a brief headache, centered around your [pc.horns]. It fades as quickly as it came, changing nothing.";
		}
		
		public var hornType: Number = 0;
		public function hornTypeUnlocked(newHornType:Number):Boolean
		{
			return true;
		}
		public function hornTypeLockedMessage():String
		{
			if(horns == 0) return "You have a brief headache. It fades as quickly as it came, changing nothing.";
			return "You have a brief headache, centered around your [pc.horns]. It fades as quickly as it came, changing nothing.";
		}
		
		public var hornLength: Number = 0;
		public function hornLengthUnlocked(newHornLength:Number):Boolean
		{
			return true;
		}
		public function hornLengthLockedMessage():String
		{
			if(horns == 0) return "You have a brief headache. It fades as quickly as it came, changing nothing.";
			return "You have a brief headache, centered around your [pc.horns]. It fades as quickly as it came, changing nothing.";
		}
		
		public var armType: Number = 0;
		public function armTypeUnlocked(newArmType:Number):Boolean
		{
			return true;
		}
		public function armTypeLockedMessage():String
		{
			return "Your [pc.arms] twitch yet resist changing.";
		}
		public var armFlags: Array = new Array();
		
		public var gills: Boolean = false;
		public function gillsUnlocked(newGills:Boolean):Boolean
		{
			return true;
		}
		public function gillsLockedMessage():String
		{
			if(!gills) return "Your neck tingles but nothing changes.";
			return "Your [pc.gills] flutter but do not change.";
		}
		
		public var wingType: Number = 0;
		public function wingTypeUnlocked(newWingType:Number):Boolean
		{
			return true;
		}
		public function wingTypeLockedMessage():String
		{
			if(wingType == 0) return "There is a tickling sensation around and between your shoulder blades, but nothing changes.";
			if(wingType == GLOBAL.TYPE_SHARK) return "Your [pc.wing] radiates with warmth but nothing about it changes.";
			return "Your [pc.wings] flutter but do not change.";
		}

		public var legType: Number = 0;
		public function legTypeUnlocked(newLegType:Number):Boolean
		{
			if (newLegType != GLOBAL.TYPE_HUMAN && (hasStatusEffect("Mimbrane Foot Left") || hasStatusEffect("Mimbrane Foot Right"))) return false;
			if (isGoo() && statusEffectv1("Gel Body") >= 1) return false;
			return true;
		}
		public function legTypeLockedMessage():String
		{
			if ((hasStatusEffect("Mimbrane Foot Left") && !hasStatusEffect("Mimbrane Foot Right")) || (!hasStatusEffect("Mimbrane Foot Left") && hasStatusEffect("Mimbrane Foot Right"))) return "Suddenly your toes flex and dig, showing faint signs of your impending transformation. The appearance subsides, however, and you’re left with your " + foot() + ". With a heavy sigh, it would seem your Mimbrane refuses to give up the shape of your feet to whatever was in store for you before.";
			if (hasStatusEffect("Mimbrane Foot Left") && hasStatusEffect("Mimbrane Foot Right")) return "Suddenly your toes flex and dig, showing faint signs of your impending transformation. The appearance subsides, however, and you’re left with your " + feet() + ". With a heavy sigh, it would seem your Mimbranes refuse to give up the shape of your feet to whatever was in store for you before.";
			if (isGoo() && statusEffectv1("Gel Body") >= 1) return "Your gooey carriage suddenly tingles. A warmth bubbles up and quickly fizzles out, making you feel very much like a carbonated soft-drink.... It seems whatever tried to change didn’t have an effect on you.";
			return "Despite the heat in your [pc.legOrLegs], nothing changes.";
		}
		
		public var legCount: Number = 2;
		public function legCountUnlocked(newLegCount:Number):Boolean
		{
			if (hasStatusEffect("Mimbrane Foot Left") || hasStatusEffect("Mimbrane Foot Right")) return false;
			return true;
		}
		public function legCountLockedMessage():String
		{
			if ((hasStatusEffect("Mimbrane Foot Left") && !hasStatusEffect("Mimbrane Foot Right")) || (!hasStatusEffect("Mimbrane Foot Left") && hasStatusEffect("Mimbrane Foot Right"))) return "Your " + foot() + " clenches to an uncomfortable degree, refusing to be removed. The Mimbrane surrounding the extremity seems to counteract any attempts to remove its home.";
			if (hasStatusEffect("Mimbrane Foot Left") && hasStatusEffect("Mimbrane Foot Right")) return "Your " + feet() + " clench to an uncomfortable degree, refusing to be removed. The Mimbranes surrounding the extremities seem to counteract any attempts to remove their home.";
			return "Despite the heat in your [pc.legOrLegs], nothing changes.";
		}
		
		public var legFlags: Array = new Array();
		public function legFlagsUnlocked(newFlags:*):Boolean
		{
			return true;
		}
		public function legFlagsLockedMessage():String
		{
			return "Despite the heat in your [pc.legOrLegs], nothing changes.";
		}
		
		public var cumType: Number = GLOBAL.FLUID_TYPE_CUM;
		public function cumTypeUnlocked(newCumType:Number):Boolean
		{
			if(cumType == GLOBAL.FLUID_TYPE_SPECIAL_GOO) return false;
			return true;
		}
		public function cumTypeLockedMessage():String
		{
			return "Your body fights an internal change, resisting a transformation.";
		}
		
		//0 - Waist
		//1 - Middle of a long tail. Defaults to waist on bipeds.
		//2 - Between last legs or at end of long tail.
		//3 - On underside of a tail, used for driders and the like, maybe?
		public var genitalSpot: Number = 0;
		public function genitalSpotUnlocked(newGenitalSpot:Number):Boolean
		{
			return true;
		}
		public function genitalSpotLockedMessage():String
		{
			return "Your body fights an internal change, resisting a transformation.";
		}

		public function genitalLocation(): Number {
			if (genitalSpot == 1 && legCount == 2) return 0;
			else if (genitalSpot == 3 && isDrider()) return 3;
			else return genitalSpot;
		}

		public var tailType: Number = 0;
		public function tailTypeUnlocked(newTailType:Number):Boolean
		{
			if (hasTail(GLOBAL.TYPE_VULPINE) && tailCount == 9 && (hasPerk("Enlightened Nine-tails") || hasPerk("Corrupted Nine-tails"))) return false;
			if (tailType == GLOBAL.TYPE_CUNTSNAKE) return false;
			if (tailType == GLOBAL.TYPE_COCKVINE) return false;
			return true;
		}
		public function tailTypeLockedMessage():String
		{
			var msg:String = "";
			if (hasTail(GLOBAL.TYPE_VULPINE) && tailCount == 9 && (hasPerk("Enlightened Nine-tails") || hasPerk("Corrupted Nine-tails"))) {
				msg += "You are startled by sudden burst of dazzling ";
				if (hasPerk("Enlightened Nine-tails")) msg += "azure";
				else msg += "purple";
				msg += " sparks from your [pc.tails], but nothing is changed.";
				return msg;
			}
			if (tailType == GLOBAL.TYPE_CUNTSNAKE || tailType == GLOBAL.TYPE_COCKVINE)
			{
				msg = "The creature masquerading as a tail seems pretty spooked about something all of a sudden;";
				if (isBiped()) msg += " it's wrapped itself around your [pc.thigh], clinging on tightly and chirping to itself quietly...."
				else msg += " it's busy chirping away to itself and thrashing around, almost as if it were trying to seek out a predator....";
				return msg;
			}
			return "Despite the heat at the base of your spine, nothing changes back there.";
		}
		

		public var tailCount: Number = 0;
		public function tailCountUnlocked(newTailCount:Number):Boolean
		{
			if (hasTail(GLOBAL.TYPE_VULPINE) && tailCount == 9 && (hasPerk("Enlightened Nine-tails") || hasPerk("Corrupted Nine-tails"))) return false;
			return true;
		}
		public function tailCountLockedMessage():String
		{
			var msg:String = "";
			if (hasTail(GLOBAL.TYPE_VULPINE) && tailCount == 9 && (hasPerk("Enlightened Nine-tails") || hasPerk("Corrupted Nine-tails"))) {
				msg += "You are startled by sudden burst of dazzling ";
				if (hasPerk("Enlightened Nine-tails")) msg += "azure";
				else msg += "purple";
				msg += " sparks from your [pc.tails], but nothing is changed.";
				return msg;
			}
			return "Despite the heat at the base of your spine, nothing changes back there.";
		}

		public var tailFlags: Array = new Array();
		public function tailFlagsUnlocked(newFlags:*):Boolean
		{
			return true;
		}
		public function tailFlagsLockedMessage():String
		{
			return "Despite the heat at the base of your spine, nothing changes back there.";
		}
		
		//Used to set cunt or dick type for cunt/dick tails!
		public var tailGenitalArg:Number = 0;
		public function tailGenitalArgUnlocked(newTailGenitalArg:Number):Boolean
		{
			return true;
		}
		public function tailGenitalArgLockedMessage():String
		{
			return "Despite the heat in your [pc.tails], nothing changes back there.";
		}
		
		//tailGenital:
		//0 - none.
		//1 - cock
		//2 - vagina
		public var tailGenital: int = 0;
		public function tailGenitalUnlocked(newTailGenital:Number):Boolean
		{
			return true;
		}
		public function tailGenitalLockedMessage():String
		{
			return "Despite the heat in your [pc.tails], nothing changes back there.";
		}
		
		public var tailGenitalColor:String = "pink";
		public function tailGenitalColorUnlocked(newTailGenitalColor:String):Boolean
		{
			return true;
		}
		public function tailGenitalColorLockedMessage():String
		{
			return "Despite the heat in your [pc.tails], nothing changes back there.";
		}

		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		public var tailVenom: Number = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		public var tailRecharge: Number = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		public var hipRatingRaw:Number = 0;
		public var hipRatingMod:Number = 0;
		
		public function hipRating(arg:Number = 0, apply:Boolean = false):Number
		{
			if (apply)
			{
				hipRatingRaw = arg;
			}
			else
			{
				hipRatingRaw += arg;
			}
			
			var bonus:Number = 0;
			if(hasPerk("Fecund Figure")) bonus += perkv1("Fecund Figure");
			
			var currHipRating:Number = hipRatingRaw + hipRatingMod + bonus;
			
			if (currHipRating < 0)
			{
				return 0;
			}
			else
			{
				return currHipRating;
			}
		}
		
		public function hipRatingUnlocked(newHipRating:Number):Boolean
		{
			return true;
		}
		public function hipRatingLockedMessage():String
		{
			return "Your [pc.hips] tremble, assaulted by sudden warmth, but it fades away without changing a thing. Your body resisted that transformation for some reason.";
		}

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
		public var buttRatingRaw:Number = 0;
		public var buttRatingMod:Number = 0;
		
		public function buttRating(arg:Number = 0, apply:Boolean = false):Number
		{
			if (apply)
			{
				buttRatingRaw = arg;
			}
			else if (arg != 0)
			{
				buttRatingRaw += arg;
			}
			
			var bonus:Number = 0;
			if(hasPerk("Fecund Figure")) bonus += perkv2("Fecund Figure");
			
			var currButtRating:Number = buttRatingRaw + buttRatingMod + bonus;
			
			if (currButtRating < 0)
			{
				return 0;
			}
			else
			{
				return currButtRating;
			}
		}
		
		public function buttRatingUnlocked(newButtRating:Number):Boolean
		{
			return true;
		}
		public function buttRatingLockedMessage():String
		{
			return "Your [pc.butt] warms, but nothing happens.";
		}
		
		//Key items
		public var keyItems: /*StorageClass*/ Array;

		//Piercings
		public var nipplesPierced: Number = 0;
		public var nipplesPShort: String = "";
		public var nipplesPLong: String = "";
		public var lipPierced: Number = 0;
		public var lipPShort: String = "";
		public var lipPLong: String = "";
		public var tonguePierced: Number = 0;
		public var tonguePShort: String = "";
		public var tonguePLong: String = "";
		public var eyebrowPierced: Number = 0;
		public var eyebrowPShort: String = "";
		public var eyebrowPLong: String = "";
		public var earsPierced: Number = 0;
		public var earsPShort: String = "";
		public var earsPLong: String = "";
		public var nosePierced: Number = 0;
		public var nosePShort: String = "";
		public var nosePLong: String = "";

		//Sexual Stuff
		public var cocks: /*CockClass*/ Array;
		public function cockLengthUnlocked(cockIndex:int, newCockLength:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function cockLengthLockedMessage():String
		{
			return "Your crotch warms, but nothing happens.";
		}

		public function cockThicknessUnlocked(cockIndex:int, newCockThickness:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function cockThicknessLockedMessage():String
		{
			return "Your crotch warms, but nothing happens.";
		}

		public function cockTypeUnlocked(cockIndex:int, newCockType:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function cockTypeLockedMessage():String
		{
			return "Your crotch warms, but nothing happens.";
		}

		public function knotMultiplierUnlocked(cockIndex:int, newKnotMulti:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function knotMultiplierLockedMessage():String
		{
			return "Your knot warms, but nothing happens.";
		}

		public function flaccidMultiplierUnlocked(cockIndex:int, newFlaccidMulti:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function flaccidMultiplierLockedMessage():String
		{
			return "Your crotch warms, but nothing happens.";
		}

		public function cockFlagsUnlocked(cockIndex:int, newFlags:*):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function cockFlagsLockedMessage():String
		{
			return "Your crotch warms, but nothing happens.";
		}

		//balls
		public var balls: Number = 0;
		public function ballsUnlocked(newBalls:Number):Boolean
		{
			if (newBalls == 0 && hasStatusEffect("Mimbrane Balls")) return false;
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function ballsLockedMessage():String
		{
			if (hasStatusEffect("Mimbrane Balls")) return "A powerful tug around your " + ballsDescript() + " keeps them from disappearing into your body. The Mimbrane encapsulating your " + sackDescript() + " seems poised to act against any attempts to fully remove your cum factories.";
			if(balls > 0) return "Despite the heat in your [pc.balls], nothing changed down there.";
			else return "Despite the heat in your groin, nothing changed down there.";
		}

		public var ballSizeRaw:Number = 1;
		public var ballSizeMod:Number = 1;
		
		public function ballDiameter():Number
		{
			return ballSize()/Math.PI;
		}

		public function ballVolume():Number
		{
			var radius:Number = ballDiameter()/2;
			return 4/3*Math.PI*radius*radius*radius;
		}

		public function ballSize(arg:Number = 0, apply:Boolean = false):Number
		{
			if (apply)
			{
				ballSizeRaw = arg;
			}
			else if (arg != 0)
			{
				ballSizeRaw += arg;
			}
			
			var currBallSize:Number = ballSizeRaw + ballSizeMod;
			
			if (currBallSize < 0)
			{
				return 0;
			}
			else
			{
				return currBallSize;
			}
		}
		
		public function ballSizeUnlocked(newBallSize:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function ballSizeLockedMessage():String
		{
			if(balls > 0) return "Despite the heat in your [pc.balls], nothing changed down there.";
			else return "Despite the heat in your groin, nothing changed down there.";
		}
		
		public function makeBallsInternal(): void
		{
			// Convert total ball cum volume to prostate cum volume--to simulate "internal" balls.
			if(balls > 0) 
			{
				//Cut the below due to it actually massively inflating internal ball size.
				//ballSizeRaw = ((ballSizeRaw * ballSizeRaw * balls) / 2);
				
				//If diameter is greater than six inches, reduce size to make diameter be six. Only so much room inside.
				//if(ballDiameter() >= 6) ballSizeRaw = 6*Math.PI;
				
				// WhyNotBoth.gif?
				ballSizeRaw = Math.min((6 * Math.PI), ((ballSizeRaw * ballSizeRaw * balls) / 2));
			}
			balls = 0;
		}
		
		// @FENCUMFIX - Switch these two blocks around if you want to easily stick a breakpoint on what this value is getting set to
		public var ballFullness: Number = 50;
		
		// Using getter/setters breaks my save/loading code iirc. To do with how I'm reflecting the class to find properties.
		// I THINK you can load/save with this code active instead of the raw property, but it MAY fuck stuff up, so I just do this when I need to debug
		// how a value is getting set.
		
		/*
		private var _ballFullness:Number = 50;
		public function get ballFullness():Number 
		{ 
			return _ballFullness;
		}
		public function set ballFullness(v:Number):void
		{
			if (v < 0)
			{
				trace("bp");
			}
			_ballFullness = v;
		}
		*/

		public function ballFullnessUnlocked(newBallFullness:Number):Boolean
		{
			return true;
		}
		public function ballFullnessLockedMessage():String
		{
			if(balls > 0) return "Despite the heat in your [pc.balls], nothing changed down there.";
			else return "Despite the heat in your groin, nothing changed down there.";
		}
		
		//Number of cumshots a day the PC can hold
		public var ballEfficiency: Number = 3;
		//Scales from 0 (never produce more) to infinity.
		public var refractoryRate: Number = 1;
		public var minutesSinceCum: Number = 0;
		public var timesCum: Number = 0;
		public var cockVirgin: Boolean = true;
		public var vaginas: /*VaginaClass*/ Array;

		public function vaginaTypeUnlocked(vagIndex:int, newVagType:int):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function vaginaTypeLockedMessage():String
		{
			return "Despite the heat in your groin, nothing changed down there.";
		}

		public function clitsUnlocked(vagIndex:int, newClitNumber:int):Boolean
		{
			// Vaginas always have one clit?
			if(vaginas[vagIndex].clits == 1 && newClitNumber < 1) return false;
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function clitsLockedMessage():String
		{
			return "Despite the heat in your groin, nothing changed down there.";
		}

		public function wetnessUnlocked(vagIndex:int, newWetness:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function wetnessLockedMessage():String
		{
			return "Despite the heat in your groin, nothing changed down there.";
		}
		
		public function analWetnessUnlocked(newWetness:Number):Boolean
		{
			return true;
		}
		public function analWetnessLockedMessage():String
		{
			return "Despite the heat in your groin, nothing changed down there.";
		}

		public function loosenessUnlocked(vagIndex:int, newLooseness:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function loosenessLockedMessage():String
		{
			return "Despite the heat in your groin, nothing changed down there.";
		}

		public var clitLength: Number = .5;
		public function clitLengthUnlocked(newClitLength:Number):Boolean
		{
			if(hasStatusEffect("Goo Crotch")) return false;
			return true;
		}
		public function clitLengthLockedMessage():String
		{
			return "Despite the heat in your groin, nothing changed down there.";
		}
		
		public var elasticity: Number = 1;
		
		public var girlCumType: Number = GLOBAL.FLUID_TYPE_GIRLCUM;
		public function girlCumTypeUnlocked(newGirlCumType:Number):Boolean
		{
			if(girlCumType == GLOBAL.FLUID_TYPE_SPECIAL_GOO) return false;
			return true;
		}
		public function girlCumTypeLockedMessage():String
		{
			return "Despite the heat in your groin, nothing changed down there.";
		}
		
		public var vaginalVirgin: Boolean = true;
		public var breastRows : /*BreastRowClass*/ Array;

		public function breastsUnlocked(bRowIndex:int, newBreastCount:Number):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function breastsLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}

		public function nippleTypeUnlocked(bRowIndex:int, newNippleType:Number):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function nippleTypeLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}

		public function breastRatingUnlocked(bRowIndex:int, newBreastRating:Number):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function breastRatingLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}

		public var nippleColor: String = "pink";
		public function nippleColorUnlocked(newNippleColor:String):Boolean
		{
			return true;
		}
		public function nippleColorLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}
		
		public var nipplesPerBreast: int = 1;
		public function nipplesPerBreastUnlocked(newNipplesPerBreast:int):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function nipplesPerBreastLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}
		
		public var nippleLengthRatio: Number = 1;
		public function nippleLengthRatioUnlocked(newNippleLengthRatio:Number):Boolean
		{
			return true;
		}
		public function nippleLengthRatioLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}
		
		public var nippleWidthRatio: Number = 1;
		public function nippleWidthRatioUnlocked(newNippleWidthRatio:Number):Boolean
		{
			return true;
		}
		public function nippleWidthRatioLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}
		
		public var dickNippleMultiplier: int = 3;
		public function dickNippleMultiplierUnlocked(newDickNippleMultiplier:int):Boolean
		{
			return true;
		}
		public function dickNippleMultiplierLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}
		
		public var dickNippleType: int = 0;
		public function dickNippleTypeUnlocked(newDickNippleType:int):Boolean
		{
			return true;
		}
		public function dickNippleTypeLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}
		//This tracks whether or not the PC is actually producing yet. 0 to 100 with milk lactation starting above 50.
		public var milkMultiplier: Number = 0;
		public var milkType: Number = 0;
		public function milkTypeUnlocked(newMilkType:Number):Boolean
		{
			return true;
		}
		public function milkTypeLockedMessage():String
		{
			if(biggestTitSize() < 1) return "Your [pc.chest] throbs and pulses but does not change. The unnatural sensations fade as quickly as they came.";
			else return "Your [pc.chest] throb and pulse but do not change. The unnatural sensations fade as quickly as they came.";
		}
		//This effects how much milk your tits can hold relative to human norms. High numbers = milk singularity
		public var milkStorageMultiplier:Number = 1;
		//This is a 1 to 100% measurement of how full yer tits are
		public var milkFullness:Number = 0;
		//The rate at which you produce milk. Scales from 0 to INFINITY.
		public var milkRate: Number = 10;

		public var ass:VaginaClass = new VaginaClass(false);
		public var analVirgin: Boolean = true;
		public var perks: /*StorageClass*/ Array;
		public var statusEffects: /*StorageClass*/ Array;		

		//Used for misc shit
		private var list:Array = new Array();

		public var sexualPreferences: SexualPreferences;

		//Functions
		//UTILITIES

		public function buysType(arg: int): Boolean {
			for (var x: int = 0; x < typesBought.length; x++) {
				if (typesBought[x] == GLOBAL.ALL) return true;
				if (arg == typesBought[x]) return true;
			}
			return false;
		}

		public function getDescription(arg: String, arg2: * ): String {
			//trace("Legacy! Please access object members directly!")
			var firstLetter: String = arg.substr(0, 1);
			firstLetter = firstLetter.toLowerCase();
			var restOfString: String = arg.substr(1, arg.length);
			var desc: String = firstLetter + restOfString;
			//var desc = arg;
			var buffer: String = "<b>Error, invalid description. Passed description call: \"" + arg + "\" with argument: \"" + arg2 + "\"</b>";
			if (!arg2) arg2 = 0;
			switch (desc) {
				case "height":
					buffer = height();
					break;
				case "gear":
					buffer = gearDescript();
					break;
				case "clothes":
					buffer = clothesDescript(); // isolates layer unlike gear -- armor if its there, otherwise both undergarments
					break;
				case "short":
				case "name":
					buffer = nameDisplay();
					break;
				case "fullName":
				case "fullname":
					buffer = short;
					if (this is PlayerCharacter) buffer += " Steele";
					break;
				case "race":
					buffer = race();
					break;
				case "armor":
					buffer = armor.longName;
					break;
				case "weapon":
					buffer = getWeaponName();
					break;
				case "meleeWeapon":
					buffer = meleeWeapon.longName;
					break;
				case "rangedWeapon":
					buffer = rangedWeapon.longName;
					break;
				case "mainWeapon":
				case "weaponMain":
				case "weaponStat":
					buffer = getWeaponName(true);
					break;
				case "draw":
					buffer = weaponActionReady(false, "stat", false);
					break;
				case "holster":
					buffer = weaponActionRelax(false, "stat", false);
					break;
				case "drawing":
					buffer = weaponActionReady(true, "stat", false);
					break;
				case "holstering":
					buffer = weaponActionRelax(true, "stat", false);
					break;
				case "drawWeapon":
				case "readyWeapon":
					buffer = weaponActionReady(false, "stat");
					break;
				case "holsterWeapon":
				case "relaxWeapon":
					buffer = weaponActionRelax(false, "stat");
					break;
				case "drawingWeapon":
				case "readyingWeapon":
					buffer = weaponActionReady(true, "stat");
					break;
				case "holsteringWeapon":
				case "relaxingWeapon":
					buffer = weaponActionRelax(true, "stat");
					break;
				case "readyMelee":
					buffer = weaponActionReady(false, "melee");
					break;
				case "relaxMelee":
					buffer = weaponActionRelax(false, "melee");
					break;
				case "readyingMelee":
					buffer = weaponActionReady(true, "melee");
					break;
				case "relaxingMelee":
					buffer = weaponActionRelax(true, "melee");
					break;
				case "readyRanged":
					buffer = weaponActionReady(false, "ranged");
					break;
				case "relaxRanged":
					buffer = weaponActionRelax(false, "ranged");
					break;
				case "readyingRanged":
					buffer = weaponActionReady(true, "ranged");
					break;
				case "relaxingRanged":
					buffer = weaponActionRelax(true, "ranged");
					break;
				case "move":
				case "walk":
					buffer = moveAction();
					break;
				case "lowerUndergarment":
					buffer = lowerUndergarment.longName;
					break;
				case "upperUndergarment":
					buffer = upperUndergarment.longName;
					break;
				case "upperGarment":
					buffer = upperGarmentDescript();
					break;
				case "upperGarmentOuter":
					buffer = upperGarmentOuterDescript();
					break;
				case "upperGarments":
					buffer = upperGarmentsDescript();
					break;
				case "lowerGarments":
				case "underGarments":
					buffer = lowerGarmentsDescript();
					break;
				case "lowerGarment":
				case "underGarment":
					buffer = lowerGarmentDescript();
					break;
				case "lowerGarmentOuter":
					buffer = lowerGarmentOuterDescript();
					break;
				case "skinNoun":
					buffer = skinNoun(true);
					break;
				case "skinFurScalesNoun":
					buffer = skinNoun(false);
					break;
				case "skinFurScalesColor":
					buffer = skinFurScalesColor();
					break;
				case "skinFurScales":
				case "skinfurscales":
					buffer = skinFurScales();
					break;
				case "skin":
					buffer = skin();
					break;
				case "skinColor":
				case "skinTone":
					buffer = skinTone;
					break;
				case "furColor":
					buffer = furColor;
					break;
				case "scaleColor":
					buffer = scaleColor;
					break;
				case "chitinColor":
					buffer = chitinColor("", true);
					break;
				case "chitinColorBody":
					buffer = chitinColor("body", true);
					break;
				case "chitinColorArm":
					buffer = chitinColor("arm", true);
					break;
				case "chitinColorLeg":
					buffer = chitinColor("leg", true);
					break;
				case "chitinColorTail":
					buffer = chitinColor("tail", true);
					break;
				case "ears":
					buffer = earsDescript();
					break;
				case "ear":
					buffer = earDescript();
					break;
				case "eyes":
					buffer = eyesDescript();
					break;
				case "eye":
					buffer = eyeDescript();
					break;
				case "eyePigment":
				case "eyeColor":
					buffer = eyeColor;
					break;
				case "hairsDescript":
					buffer = hairsDescript();
					break;
				case "hairDescript":
				case "hair":
					buffer = hairDescript();
					break;
				case "hairNoun":
					buffer = hairNoun();
					break;
				case "hairsNoun":
					buffer = hairsNoun();
					break;
				case "hairColor":
					buffer = hairColor;
					break;
				case "beard":
					buffer = beard();
					break;
				case "face":
					buffer = face();
					break;
				case "lips":
					buffer = plural(lipDescript());
					break;
				case "lipsChaste":
					buffer = plural(lipDescript(false,true));
					break;
				case "lip":
					buffer = lipDescript();
					break;
				case "lipChaste":
					buffer = lipDescript(false,true);
					break;
				case "lipColor":
					buffer = lipColor;
					break;
				case "tongue":
					buffer = tongueDescript();
					break;
				case "tongueNoun":
					buffer = tongueNoun();
					break;
				case "tongueNounSimple":
					buffer = tongueNoun(true,false);
					break;
				case "tonguePierced":
					buffer = tongueNoun(false,true);
					break;
				case "gills":
					buffer = gillsDesc();
					break;
				case "gill":
					buffer = gillDesc();
					break;
				case "tail":
					buffer = tailDescript();
					break;
				case "onetail":
				case "oneTail":
					buffer = oneTailDescript();
					break;
				case "eachtail":
				case "eachTail":
					buffer = eachTailDescript();
					break;
				case "tails":
					buffer = tailsDescript();
					break;
				case "crotch":
				case "groin":
					buffer = crotchDescript();
					break;
				case "base":
				case "sheath":
				case "sheathDescript":
					buffer = sheathDescript(arg2);
					break;
				case "biggestSheath":
				case "sheathBiggest":
					buffer = sheathDescript(biggestCockIndex());
					break;
				case "knot":
					buffer = knotDescript(arg2);
					break;
				case "knotBiggest":
					buffer = knotDescript(biggestCockIndex());
					break;
				case "multiCockDescript":
				case "multiCocks":
					buffer = multiCockDescript();
					break;
				case "cocks":
				case "cocksDescript":
					buffer = cocksDescript();
					break;
				case "cocksDescriptLight":
				case "cocksLight":
					buffer = cocksDescriptLight();
					break;
				case "cocksNounSimple":
					buffer = simpleCocksNoun();
					break;
				case "cockNounComplex":
					buffer = cockNounComplex(arg2);
					break;
				case "cockNounSimple":
				case "cockNoun":
					buffer = simpleCockNoun(arg2);
					break;
				case "cockNounBiggest":
					buffer = simpleCockNoun(biggestCockIndex());
					break;
				case "cockColor":
				case "dickColor":
					buffer = cockColor(arg2);
					break;
				case "vaginaColor":
				case "cuntColor":
				case "pussyColor":
					buffer = vaginaColor(arg2);
					break;
				case "cockHead":
				case "cockhead":
					buffer = cockHead(arg2);
					break;
				case "cockHeads":
					buffer = cockHeads(arg2);
					break;
				case "cockDescript":
				case "cock":
					buffer = cockDescript(arg2);
					break;
				case "biggestCockDescript":
				case "biggestCock":
				case "cockBiggest":
					buffer = cockDescript(biggestCockIndex());
					break;
				case "biggestCockHead":
				case "cockHeadBiggest":
					buffer = cockHead(biggestCockIndex());
					break;
				case "smellestCockDescript":
				case "smallestCock":
				case "cockSmallest":
					buffer = cockDescript(smallestCockIndex());
					break;
				case "cockShortest":
					buffer = cockDescript(shortestCockIndex());
					break;
				case "eachCockHead":
					buffer = eachCockHead();
					break;
				case "tailCock":
				case "cockTail":
					buffer = tailCockDescript();
					break;
				case "tailCocks":
				case "cockTails":
					buffer = tailCocksDescript();
					break;
				case "tailCockHead":
				case "cockTailHead":
					buffer = tailCockHead();
					break;
				case "cockOrStrapon":
					buffer = cockOrStrapon();
					break;
				case "cockOrStraponNoun":
					buffer = cockOrStrapon(-1);
					break;
				case "cockOrStraponFull":
					buffer = cockOrStrapon(1);
					break;
				case "nippleNoun":
					buffer = nippleNoun(arg2);
					break;
				case "nipplesNoun":
					buffer = plural(nippleNoun(arg2));
					break;
				case "nipple":
				case "nippleDescript":
					buffer = nippleDescript(arg2);
					break;
				case "nipples":
				case "nipplesDescript":
					buffer = nipplesDescript(arg2);
					break;
				case "milkyNipple":
					buffer = nippleDescript(arg2, false, true);
					break;
				case "milkyNipples":
					buffer = nipplesDescript(arg2, true);
					break;
				case "nippleCockDescript":
				case "nippleCock":
				case "dickNipple":
					buffer = nippleCockDescript();
					break;
				case "nippleCocksDescript":
				case "nippleCocks":
				case "dickNipples":
					buffer = plural(nippleCockDescript());
					break;
				case "nippleColor":
					buffer = nippleColor;
					break;
				case "eachCock":
					buffer = eachCock();
					break;
				case "oneCock":
					buffer = oneCock();
					break;
				case "oneCockHead":
					buffer = oneCockHead();
					break;
				case "erectCock":
				case "flaccidCock":
					buffer = cockDescript(arg2, true);
					break;
				case "erectCocks":
				case "flaccidCocks":
					buffer = cocksDescript(true);
					break;
				case "erectMultiCocks":
				case "flaccidMultiCocks":
					buffer = multiCockDescript(true);
					break;
				case "eachErectCock":
				case "eachFlaccidCock":
					buffer = eachCock(true);
					break;
				case "oneErectCock":
				case "oneFlaccidCock":
					buffer = oneCock(true);
					break;
				case "balls":
					buffer = ballsDescript();
					break;
				case "ballsNoun":
					buffer = ballNoun(true);
					break;
				case "ballNoun":
					buffer = ballNoun(false);
					break;
				case "ball":
					buffer = ballsDescript();
					break;
				case "sack":
					buffer = sackDescript();
					break;
				case "chestDesc":
				case "chest":
					buffer = chestDesc();
					break;
				case "chestSimple":
				case "chestNoun":
				case "breastsNoun":
					buffer = chestNoun();
					break;
				case "breastNoun":
				case "breast":
					buffer = breastNoun();
					break;
				case "breastCupSize":
					buffer = breastCup(arg2);
					break;
				case "allChestDescript":
				case "fullChest":
					buffer = allChestDesc();
					break;
				case "biggestBreastDescript":
					buffer = biggestBreastDescript();
					break;
				case "breasts":
				case "boobs":
				case "tits":
					buffer = breastDescript(arg2);
					break;
				case "lowestBreasts":
					buffer = breastDescript(bRows()-1);
					break;
				case "cockClit":
					buffer = cockClit(arg2);
					break;
				case "anus":
				case "assholeDescript":
				case "asshole":
					buffer = assholeDescript();
					break;
				case "buttDescript":
				case "butt":
				case "ass":
					buffer = buttDescript();
					break;
				case "buttsDescript":
				case "butts":
				case "asses":
					buffer = buttDescript(true);
					break;
				case "hipDescript":
				case "hip":
					buffer = hipDescript();
					break;
				case "hipsDescript":
				case "hips":
					buffer = hipsDescript();
					break;
				case "thighDescript":
				case "thigh":
					buffer = thighDescript();
					break;
				case "thighsDescript":
				case "thighs":
					buffer = thighsDescript();
					break;
				case "vagina":
				case "pussy":
				case "cunt":
					buffer = vaginaDescript(arg2);
					break;
				case "vaginaNounSimple":
				case "vaginaNoun":
				case "pussyNoun":
					buffer = vaginaNounDescript(arg2);
					break;
				case "vaginas":
				case "pussies":
				case "cunts":
					buffer = vaginasDescript();
					break;
				case "eachVagina":
				case "eachPussy":
				case "eachCunt":
					buffer = eachVagina();
					break;
				case "oneVagina":
				case "onePussy":
				case "oneCunt":
					buffer = oneVagina();
					break;
				case "biggestVagina":
				case "vaginaBiggest":
				case "cuntBiggest":
				case "biggestCunt":
					buffer = vaginaDescript(biggestVaginaIndex());
					break;
				case "vagOrAss":
				case "vagOrAsshole":
				case "pussyOrAsshole":
					buffer = vagOrAss(arg2);
					break;
				case "clit":
					buffer = clitDescript();
					break;
				case "eachClit":
					buffer = eachClit();
					break;
				case "oneClit":
					buffer = oneClit();
					break;
				case "oneClitPerVagina":
					buffer = oneClitPerVagina(arg2);
					break;
				case "clits":
					buffer = clitsDescript();
					break;
				case "tailVagina":
				case "tailCunt":
				case "cuntTail":
				case "tailgina":
					buffer = tailVaginaDescript();
					break;
				case "tailVaginas":
				case "tailCunts":
				case "cuntTails":
				case "tailginas":
					buffer = tailVaginasDescript();
					break;
				case "oneTailgina":
				case "oneTailCunt":
					buffer = oneTailVaginaDescript();
					break;
				case "milkNoun":
					buffer = fluidNoun(milkType);
					break;
				case "milkDescript":
				case "milk":
					buffer = milkDescript();
					break;
				case "cumDescript":
				case "cum":
					buffer = cumDescript();
					break;
				case "femCum":
				case "femcum":
				case "girlCumDescript":
				case "girlCum":
				case "girlcum":
					buffer = girlCumDescript();
					break;
				case "cumNoun":
					buffer = fluidNoun(cumType);
					break;
				case "girlCumNoun":
					buffer = fluidNoun(girlCumType);
					break;
				case "cumColor":
					buffer = cumColor();
					break;
				case "cumGem":
					buffer = cumGem();
					break;
				case "girlCumGem":
					buffer = girlCumGem();
					break;
				case "milkGem":
					buffer = milkGem();
					break;
				case "girlCumColor":
					buffer = girlCumColor();
					break;
				case "milkColor":
					buffer = milkColor();
					break;
				case "cumVisc":
					buffer = fluidViscosity(cumType);
					break;
				case "girlCumVisc":
					buffer = fluidViscosity(girlCumType);
					break;
				case "milkVisc":
					buffer = fluidViscosity(milkType);
					break;
				case "cumFlavor":
					buffer = fluidFlavor(cumType);
					break;
				case "girlCumFlavor":
					buffer = fluidFlavor(girlCumType);
					break;
				case "milkFlavor":
					buffer = fluidFlavor(milkType);
					break;
				case "wing":
					buffer = wingDescript();
					break;
				case "wings":
					buffer = wingsDescript();
					break;
				case "wingNoun":
					buffer = wingDescript(true);
					break;
				case "wingsNoun":
					buffer = wingsDescript(true);
					break;
				case "arm":
					buffer = armDescript();
					break;
				case "arms":
					buffer = armsDescript();
					break;
				case "armFull":
					buffer = armDescript(true);
					break;
				case "armsFull":
					buffer = armsDescript(true);
					break;
				case "armNoun":
					buffer = armNoun();
					break;
				case "armsNoun":
					buffer = armsNoun();
					break;
				case "hand":
					buffer = hand();
					break;
				case "hands":
					buffer = hands();
					break;
				case "finger":
					buffer = finger();
					break;
				case "fingers":
					buffer = fingers();
					break;
				case "lowerBody":
					buffer = lowerBody();
					break;
				case "leg":
					buffer = leg();
					break;
				case "legNoun":
					buffer = legNoun();
					break;
				case "legsNoun":
					buffer = legsNoun();
					break;
				case "legs":
					buffer = legs();
					break;
				case "leg(s)":
				case "legOrLegs":
					buffer = legOrLegs();
					break;
				case "legFurScales":
					buffer = legFurScales();
					break;
				case "knee":
					buffer = kneeDescript();
					break;
				case "knees":
					buffer = kneesDescript();
					break;
				case "footOrFeet":
				case "feet":
					buffer = feet();
					break;
				case "foot":
					buffer = foot();
					break;
				case "toes":
					buffer = toes();
					break;
				case "belly":
				case "stomach":
					buffer = bellyDescript();
					break;
				case "bellySize":
					buffer = bellyDescript(true);
					break;
				case "mistress":
				case "master":
					buffer = mf("master", "mistress");
					break
				case "man":
					buffer = mf("man", "woman");
					break
				case "guy":
					buffer = mf("guy","girl");
					break;
				case "he":
				case "she":
				case "heShe": // Shamelessly stole these from Alderbro. :3
				case "ey":
					buffer = mf("he", "she");
					break;
				case "him":
				case "himHer":
				case "em":
					buffer = mf("him", "her");
					break;
				case "himHerIt":
					buffer = mfn("him","her","it");
					break;
				case "his":
				case "hisHer":
				case "eir":
					buffer = mf("his", "her");
					break;
				case "hisHers":
				case "eirs":
					buffer = mf("his", "hers");
					break;
				case "manWoman":
					buffer = mf("man", "woman");
					break;
				case "boy":
				case "girl":
				case "boyGirl":
					buffer = mf("boy", "girl");
					break;
				case "guy":
				case "girl":
				case "guyGirl":
					buffer = mf("guy","girl");
					break;
				case "cockShape":
				case "cockshape":
				case "cockType":
				case "cocktype":
					buffer = cockShape(arg2);
					break;
				case "accurateCockName":
					buffer = accurateCockName(arg2);
					break;
				case "tailCockColor":
				case "tailCuntColor":
				case "tailGenitalColor":
					buffer = tailGenitalColorDesc();
					break;
				case "horn":
					buffer = hornDescript();
					break;
				case "eachHorn":
					buffer = eachHorn();
					break;
				case "oneHorn":
					buffer = oneHorn();
					break;
				case "horns":
					buffer = hornsDescript();
					break;
				case "hornNoun":
					buffer = hornNoun();
					break;
				case "hornsNoun":
					buffer = hornsNoun();
					break;
				case "antenna":
					buffer = antennaeDescript(false);
					break;
				case "antennae":
					buffer = antennaeDescript();
					break;
					
				default:
					// error production is now done up-stream in the parser
					// Gedan: I ain't seeing no errors, so I'm gonna Throw on unknown tags to make their presence 120% obvious when turbotesting scenes.
					//throw new Error("Unmatched tag descriptor: " + desc);
					trace("ERROR: Unmatched tag descriptor detected: " + desc);
					return null; // "<b>Error, invalid description. Passed description call: \"" + arg + "\" with argument: \"" + arg2 + "\"</b>";
					
					break;
			}
			if (arg.charCodeAt(0) > 64 && arg.charCodeAt(0) < 90) buffer = upperCase(buffer);
			// trace("BUFFER OUT: " + buffer);
			return buffer;
		}
		public function nameDisplay():String
		{
			if(this is PlayerCharacter) return short;
			else return a + short;
		}
		public function Num2Text(number: int): String {
			return upperCase(num2Text(number));
		}
		public function numTwoText(number: int): String {
			var returnVar: String = null;
			var numWords:Array = new Array("zero", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth");
			if (number > 10) {
				returnVar = "" + number + "th";
			} else {
				returnVar = numWords[number];
			}
			return (returnVar);
		}
		public function NumTwoText(number: int): String {
			return upperCase(numTwoText(number));
		}
		public function upperCase(str: String): String {
			var firstChar: String = str.substr(0, 1);
			var restOfString: String = str.substr(1, str.length);
			return firstChar.toUpperCase() + restOfString;
		}
		public function inventorySlots(): int {
			var slots:int = 10;
			if(accessory.shortName == "Cargobot") slots += 2;
			if(hasPerk("Hidden Loot")) slots += 2;
			return slots;
		}
		public function hasItem(arg:ItemSlotClass,amount:int = 1):Boolean
		{
			if(inventory.length == 0) return false;
			var foundAmount:int = 0;
			for(var x:int = 0; x < inventory.length; x++)
			{
				if(inventory[x].shortName == arg.shortName) foundAmount += inventory[x].quantity;
			}
			if(foundAmount >= amount) return true;
			return false;
		}
		/**
		 * Accepts String as name, ItemSlotClass object as name source, or Class for class comparation.
		 */
		public function itemCount(arg:*,amount:int = 1):int
		{
			if (inventory.length == 0) return 0;
			
			var key:String = (arg is ItemSlotClass) ? arg.shortName : key = arg;			
			var foundAmount:int = 0;
			for(var x:int = 0; x < inventory.length; x++)
			{
				if (key is String && inventory[x].shortName == key 
				|| key is Class && inventory[x] is (key as Class)
				) foundAmount += inventory[x].quantity;
			}
			return foundAmount;
		}
		public function hasItemByName(arg:String, amount:int = 1):Boolean
		{
			if (inventory.length == 0) return false;
			
			var foundAmount:int = 0;
			for(var x:int = 0; x < inventory.length; x++)
			{
				if(inventory[x].shortName == arg) foundAmount += inventory[x].quantity;
			}
			if(foundAmount >= amount) return true;
			return false;
		}
		public function hasItemByType(ref:Class, amount:int = 1):Boolean
		{
			var amt:int = 0;
			
			for (var i:uint = 0; i < inventory.length; i++)
			{
				if (inventory[i] is ref) amt += inventory[i].quantity;
			}
			if (amt >= amount) return true;
			return false;
		}
		public function destroyItemByName(arg:String,amount:int = 1):int
		{
			if(inventory.length == 0) return 0;
			var foundAmount:int = 0;
			for(var x:int = 0; x < inventory.length; x++)
			{
				//Item in the slot?
				if(inventory[x].shortName == arg) 
				{
					//If we still need to eat some, eat em up!
					while(amount > 0 && inventory[x].quantity > 0) 
					{
						foundAmount++;
						inventory[x].quantity--;
						amount--;
						if(inventory[x].quantity <= 0) inventory.splice(x,1);
					}
				}
			}
			return foundAmount;
		}
		public function destroyItem(arg:ItemSlotClass,amount:int = 1):int
		{
			if(inventory.length == 0) return 0;
			var foundAmount:int = 0;
			for(var x:int = 0; x < inventory.length; x++)
			{
				//Item in the slot?
				if(inventory[x].shortName == arg.shortName) 
				{
					//If we still need to eat some, eat em up!
					while(amount > 0 && inventory[x].quantity > 0) 
					{
						foundAmount++;
						inventory[x].quantity--;
						amount--;
						if(inventory[x].quantity <= 0) inventory.splice(x,1);
					}
				}
			}
			return foundAmount;
		}
		public function destroyItemByType(type:Class, amount:int = 1):void
		{
			if (inventory.length == 0) return;
			
			for (var i:int = 0; i < inventory.length; i++)
			{
				if (amount == 0) break;
				
				if (inventory[i] is type)
				{
					inventory[i].quantity -= amount;
					if (inventory[i].quantity <= 0)
					{
						if (inventory[i].quantity < 0) amount = Math.abs(inventory[i].quantity);
						inventory.splice(i, 1);
						i--;
					}
				}
			}
		}
		
		public function getWeaponName(fromStat:Boolean = false):String
		{
			if(!fromStat)
			{
				if (!(rangedWeapon is EmptySlot)) return rangedWeapon.longName;
				if (!(meleeWeapon is EmptySlot)) return meleeWeapon.longName;
			}
			else
			{
				if (hasMeleeWeapon() && (physique() > aim() || (physique() == aim() && affinity == "physique"))) return meleeWeapon.longName;
				else if (hasRangedWeapon()) return rangedWeapon.longName;
			}
			if((meleeWeapon is Rock) || (rangedWeapon is Rock)) return "rock";
			return "fist";
		}
		
		public function weaponActionReady(present:Boolean = false, weapon:String = "", full:Boolean = true):String
		{
			var desc:String = "";
			var actions:Array = [];
			var singular:Boolean = ((this is PlayerCharacter) || isPlural);
			var weaponName:String = getWeaponName();
			
			if (weapon == "stat")
			{
				if (hasMeleeWeapon() && (physique() > aim() || (physique() == aim() && affinity == "physique"))) weapon = "melee";
				else if (hasRangedWeapon()) weapon = "ranged";
			}
			else if (weapon == "default")
			{
				if (hasRangedWeapon()) weapon = "ranged";
				else if (hasMeleeWeapon()) weapon = "melee";
			}
			
			if (present) actions.push("readying", "preparing");
			else if (singular) actions.push("ready", "prepare");
			else actions.push("readies", "prepares");
			
			if (weapon == "ranged")
			{
				if(present) actions.push("taking out", "getting out", "pulling out");
				else if (singular) actions.push("take out", "get out", "pull out");
				else actions.push("takes out", "gets out", "pulls out");
				if (hasRangedEnergyWeapon())
				{
					if (present) actions.push("charging", "loading");
					else if (singular) actions.push("charge", "load");
					else actions.push("charges", "loads");
				}
				if (hasBowWeaponEquipped())
				{
					if (present) actions.push("drawing", "mounting", "equipping", "tightening");
					else if (singular) actions.push("draw", "mount", "equip", "tighten");
					else actions.push("draws", "mounts", "equips", "tightens");
				}
				else
				{
					if (present) actions.push("drawing", "loading", "cocking", "uncovering");
					else if (singular) actions.push("draw", "load", "cock", "uncover");
					else actions.push("draws", "loads", "cocks", "uncovers");
				}
				weaponName = rangedWeapon.longName;
			}
			else if (weapon == "melee")
			{
				if (present) actions.push("taking out", "getting out", "pulling out");
				else if (singular) actions.push("take out", "get out", "pull out");
				else actions.push("takes out", "gets out", "pulls out");
				if (hasMeleeEnergyWeapon())
				{
					if (present) actions.push("charging", "activating");
					else if (singular) actions.push("charge", "activate");
					else actions.push("charges", "activates");
				}
				if (meleeWeapon.attackNoun == "whip")
				{
					if(present) actions.push("unraveling", "loosening", "flourishing");
					else if(singular) actions.push("unravel", "loosen", "flourish");
					else actions.push("unravels", "loosens", "flourishes");
				}
				else
				{
					if (present) actions.push("drawing", "unsheathing", "brandishing", "flourishing", "wielding");
					else if (singular) actions.push("draw", "unsheathe", "brandish", "flourish", "wield");
					else actions.push("draws", "unsheathes", "brandishes", "flourishes", "wields");
				}
				weaponName = meleeWeapon.longName;
			}
			
			desc += RandomInCollection(actions);
			
			if (full)
			{
				if (this is PlayerCharacter) desc += " your " + weaponName;
				else if (isPlural) desc += " their " + weaponName;
				else desc += " " + mfn("his", "her", "its") + " " + weaponName;
			}
			return desc;
		}
		public function weaponActionRelax(present:Boolean = false, weapon:String = "", full:Boolean = true):String
		{
			var desc:String = "";
			var actions:Array = [];
			var singular:Boolean = ((this is PlayerCharacter) || isPlural);
			var weaponName:String = getWeaponName();
			
			if (weapon == "stat")
			{
				if (hasMeleeWeapon() && (physique() > aim() || (physique() == aim() && affinity == "physique"))) weapon = "melee";
				else if (hasRangedWeapon()) weapon = "ranged";
			}
			else if (weapon == "default")
			{
				if (hasRangedWeapon()) weapon = "ranged";
				else if (hasMeleeWeapon()) weapon = "melee";
			}
			
			if (present) actions.push("relaxing", "resting");
			else if (singular) actions.push("relax", "rest");
			else actions.push("relaxes", "rest");
			
			if (weapon == "ranged")
			{
				if (present) actions.push("putting away", "putting back", "placing back");
				else if (singular) actions.push("put away", "put back", "place back");
				else actions.push("puts away", "puts back", "places back");
				if (hasRangedEnergyWeapon())
				{
					if (present) actions.push("decharging", "powering down");
					else if (singular) actions.push("decharge", "power down");
					else actions.push("decharges", "powers down");
				}
				if (hasBowWeaponEquipped())
				{
					if (present) actions.push("retracting", "relinquishing", "renouncing", "loosening");
					else if (singular) actions.push("retract", "relinquish", "renounce", "loosen");
					else actions.push("retracts", "relinquishes", "renounces", "loosens");
				}
				else
				{
					if (present) actions.push("retracting", "locking", "storing", "holstering");
					else if (singular) actions.push("retract", "lock", "store", "holster");
					else actions.push("retracts", "locks", "stores", "holsters");
				}
				weaponName = rangedWeapon.longName;
			}
			else if (weapon == "melee")
			{
				if (present) actions.push("putting away", "putting back", "placing back");
				else if (singular) actions.push("put away", "put back", "place back");
				else actions.push("puts away", "puts back", "places back");
				if (hasMeleeEnergyWeapon())
				{
					if (present) actions.push("turning off", "deactivating");
					else if (singular) actions.push("turn off", "deactivate");
					else actions.push("turns off", "deactivates");
				}
				if (meleeWeapon.attackNoun == "whip")
				{
					if(present) actions.push("recoiling", "tightening", "packing away");
					else if(singular) actions.push("recoil", "tighten", "pack away");
					else actions.push("recoils", "tightens", "packs away");
				}
				else
				{
					if (present) actions.push("putting down", "sheathing", "stashing", "saving", "covering");
					else if (singular) actions.push("put down", "sheathe", "stash", "save", "cover");
					else actions.push("puts down", "sheathes", "stashes", "saves", "covers");
				}
				weaponName = meleeWeapon.longName;
			}
			
			desc += RandomInCollection(actions);
			
			if (full)
			{
				if (this is PlayerCharacter) desc += " your " + weaponName;
				else if (isPlural) desc += " their " + weaponName;
				else desc += " " + mfn("his", "her", "its") + " " + weaponName;
			}
			return desc;
		}
		public function moveAction():String
		{
			var desc:String = "";
			var actions:Array = ["move"];
			
			if(hasLegs()) actions.push("walk", "walk", "step");
			if(isGoo()) actions.push("slide", "crawl");
			if(isNaga()) actions.push("slither", "slink", "wriggle");
			if(isCentaur()) actions.push("gallop", "canter");
			if(isTaur()) actions.push("trot", "lope");
			if(isDrider()) actions.push("skitter", "flit");
			if(legType == GLOBAL.TYPE_MLP) actions.push("gallop", "canter", "trot", "lope", "hoof it");
			
			desc += RandomInCollection(actions);
			return desc;
		}
		public function shower():void
		{
			removeStatusEffect("Sweaty");
			removeStatusEffect("Mare Musk");
			removeStatusEffect("Cum Soaked");
			removeStatusEffect("Pussy Drenched");
		}
		public function canMasturbate():Boolean
		{
			// Effects that prevent maturbations:
			if
			(	hasStatusEffect("Myr Venom Withdrawal")
			||	hasStatusEffect("Grappled")
			||	hasStatusEffect("Stunned")
			||	hasStatusEffect("Paralyzed")
			||	hasStatusEffect("Dysfunction")
			)	return false;
			return true;
		}
		public function orgasm(): void {
			// NaN production was down to maxCum
			// if the player didn't have a cock, maxCum returns 0.
			// anything / 0 = NaN
			if (hasCock())
			{
				// @FENCUMFIX
				// How to fix this will depend on how you want to handle it Fen:
				// Either limit cumQ to never allow a value greater than currentCum()
				// Or allow CumQ to produce whatever, and simply clamp the ballFullness set value here to 0.
				
				//ballFullness = Math.round(((currentCum() - cumQ()) / maxCum()) * 100);
				var cumAmt:Number = Math.round(((currentCum() - cumQ()) / maxCum()) * 100);
				if (cumAmt < 0) cumAmt = 0;
				
				if(this is PlayerCharacter || fluidSimulate) ballFullness = cumAmt;

				//'Nuki Ball Reduction
				if(perkv1("'Nuki Nuts") > 0 && balls > 1 && this is PlayerCharacter)
				{
					kGAMECLASS.eventBuffer += "\n\nYour balls are back to their normal size once more. What an incredible relief!";
					ballSizeMod -= perkv1("'Nuki Nuts");
					setPerkValue("'Nuki Nuts",1,0);
					kGAMECLASS.nutStatusCleanup();
				}
				//Biomass vent
				if(statusEffectv1("Goo Vent") == 1)
				{
					kGAMECLASS.flags["GOO_BIOMASS"] = 0;
				}
				if(statusEffectv1("Nyrea Eggs") > 0 && hasOvipositor())
				{
					addStatusValue("Nyrea Eggs", 1, -1 * (6 + rand (5)));
					if(statusEffectv1("Nyrea Eggs") < 0) setPerkValue("Nyrea Eggs",1,0);
				}
			}
			
			if (this is PlayerCharacter) 
			{
				kGAMECLASS.mimbraneFeed("cock");
				kGAMECLASS.mimbraneFeed("vagina");
				StatTracking.track("sex/player/orgasms");
				removeStatusEffect("Blue Balls");
			}
			else
			{
				StatTracking.track("characters/" + short + "/orgasms");
			}
			
			if (hasStatusEffect("Dumbfuck"))
			{
				if(!hasStatusEffect("Dumbfuck Orgasm Procced"))
				{
					createStatusEffect("Dumbfuck Orgasm Procced", 0, 0, 0, 0, true, "", "", false, 0);
				}
				addStatusValue("Dumbfuck Orgasm Procced",1,1);
				trace("DUMBFUCK STATUS:" + statusEffectv1("Dumbfuck Orgasm Procced"));
			}
			
			lustRaw = 0;
			energy(-5);
			minutesSinceCum = 0;
			timesCum++;
		}
		public function mimbranePartDescript(mimType: String = ""): String {
			//Mimbrane additions in relation to face.
			var desc: String = "";
			var rando: Number = 0;
			var descripted: Number = 0;
			
			//Player character check--not sure if NPCs can get the Mims since the flags are probably global...
			if (this is PlayerCharacter)
			{
				// 50% trust and hunger-related description
				if(rand(2) == 0) {
					if(statusEffectv2(mimType) <= 0) desc += "mutinous";
					else if(statusEffectv1(mimType) <= 1) desc += "shifty";
					else if(statusEffectv1(mimType) <= 2) desc += "questionable";
					else if(statusEffectv1(mimType) <= 3) desc += "befriended";
					else if(statusEffectv1(mimType) <= 4) desc += "loyal";
					else desc += "devoted";
					desc += " and ";
					if(statusEffectv2(mimType) <= 0) desc += "satiated";
					else if(statusEffectv2(mimType) <= 1) desc += "well-fed";
					else if(statusEffectv2(mimType) <= 2) desc += "fed";
					else if(statusEffectv2(mimType) <= 3) desc += "slightly hungry";
					else if(statusEffectv2(mimType) <= 4) desc += "hungry";
					else if(statusEffectv2(mimType) <= 5) desc += "very hungry";
					else if(statusEffectv2(mimType) <= 6) desc += "starving";
					else desc += "irritable";
					descripted++;
				}
				// 50% sweatiness and combat-ready description
				if (rand(2) == 0) {
					if(kGAMECLASS.flags["PLAYER_MIMBRANE_SWEAT_ENABLED"] == 1 && statusEffectv1(mimType) >= 3) {
						if (descripted > 0) desc += ", ";
						rando = rand(10);
						if (rando == 0) desc += "glistening";
						else if (rando == 1) desc += "moist";
						else if (rando == 2) desc += "slippery";
						else if (rando == 3) desc += "self-lathering";
						else if (rando == 4) desc += "perspiring";
						else if (rando == 5) desc += "mucid";
						else if (rando == 6) desc += "sudoriferous";
						else if (rando == 7) desc += "clammy";
						else if (rando == 8) desc += "diaphoretic";
						else desc += "sweating";
						descripted++;
					}
					if (kGAMECLASS.flags["PLAYER_MIMBRANE_SPIT_ENABLED"] == 1 && statusEffectv1(mimType) >= 4) {
						if (descripted > 0) desc += " and ";
						rando = rand(4);
						if (rando == 0) desc += "lust-inducing";
						else if (rando == 1) desc += "lust-spraying";
						else if (rando == 2) desc += "lust-projecting";
						else desc += "lust-spitting";
						descripted++;
					}
				}
				if (descripted > 0) desc += " ";
				// Mimbrane descriptor
				rando = rand(10);
				if (rando == 0) desc += "parasite";
				else if (rando == 1) desc += "epidel";
				else if (rando == 2) desc += "graft";
				else if (rando == 3) desc += "second skin";
				else if (rando == 4) desc += "cum leech";
				else desc += "Mimbrane";
			}
			return desc;
		}
		/**
		 * Checks if all naughty bits are exposed. Allows exposing gear. Basically isCrotchExposed + isChestExposed.
		 */
		public function isExposed(): Boolean {
			if(hasStatusEffect("Temporary Nudity Cheat")) return true;
			return isCrotchExposed() && isChestExposed();
		}
		public function isNude(): Boolean {
			if(hasStatusEffect("Temporary Nudity Cheat")) return true;
			//return (armor.shortName == "" && lowerUndergarment.shortName == "" && upperUndergarment.shortName == "");
			return (!isCrotchGarbed() && !isChestCovered());
		}
		public function isCrotchGarbed(): Boolean {
			if(hasStatusEffect("Temporary Nudity Cheat")) return false;
			else if(armor is EmptySlot && lowerUndergarment is EmptySlot) return false;
			return true;
		}
		//Used to see if wing-wang-doodles and hatchet-wounds are accessible. Should probably replace most isCrotchGarbed() calls.
		public function isCrotchExposed(): Boolean {
			if(!isCrotchGarbed()) return true;
			return ((armor is EmptySlot || armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) && (lowerUndergarment is EmptySlot || lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)));
		}
		//Badonkadonk check
		public function isAssExposed():Boolean
		{
			if(!isCrotchGarbed()) return true;
			return ((armor is EmptySlot || armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) && (lowerUndergarment is EmptySlot || lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)));
		}
		public function isGroinCovered(): Boolean {
			return isCrotchGarbed();
		}
		public function isChestCovered(): Boolean {
			if(hasStatusEffect("Temporary Nudity Cheat")) return false;
			else if(armor is EmptySlot && upperUndergarment is EmptySlot) return false;
			return true;
		}
		//Used to see if boobs are hanging out instead of isChestGarbed/Covered.
		public function isChestExposed(): Boolean
		{
			if(!isChestCovered()) return true;
			return ((armor is EmptySlot || armor.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)) && (upperUndergarment is EmptySlot || upperUndergarment.hasFlag(GLOBAL.ITEM_FLAG_EXPOSE_FULL)));
		}
		public function isChestGarbed(): Boolean {
			return isChestCovered();
		}
		
		public function hasArmor():Boolean
		{
			return !(armor is EmptySlot);
		}
		
		public function hasUpperGarment():Boolean
		{
			return !(upperUndergarment is EmptySlot);
		}
		
		public function hasLowerGarment():Boolean
		{
			return !(lowerUndergarment is EmptySlot);
		}
		
		public function inSwimwear(strict:Boolean = false):Boolean
		{
			if(hasStatusEffect("Temporary Swimwear Cheat")) return true;
			// Armor/Outfit check:
			if (hasArmor() && armor.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR))
			{
				// Swimsuit outfits should not have undergarments on. That's not fashionable!
				if (hasUpperGarment() || hasLowerGarment()) return false;
				// Swimsuit outfits with no undies? Yes.
				return true;
			}
			// Undergarment check:
			if (!hasArmor() && (hasLowerGarment() || hasUpperGarment()))
			{
				// All undergarments are eligible swimwear, unless it's a strict check
				if (strict)
				{
					if (hasLowerGarment() && hasUpperGarment())
						return (lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR) && upperUndergarment.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR));
					if (hasLowerGarment())
						return (lowerUndergarment.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR));
					if (hasUpperGarment())
						return (upperUndergarment.hasFlag(GLOBAL.ITEM_FLAG_SWIMWEAR));
				}
				return true;
			}
			// Nope, no valid swim clothes (or is probably nude!).
			return false;
		}
		
		//STATS!
		//Personalities!
		public function isNice(): Boolean {
			if (hasPerk("Enlightened Nine-tails")) return false;
			if (hasPerk("Corrupted Nine-tails")) return false;
			
			return (personality <= 33);
		}
		public function isMischievous(): Boolean {
			if (hasPerk("Enlightened Nine-tails")) return true;
			if (hasPerk("Corrupted Nine-tails")) return false;
			
			return (personality <= 66 && personality > 33);
		}
		public function isAss(): Boolean {
			if (hasPerk("Enlightened Nine-tails")) return false;
			if (hasPerk("Corrupted Nine-tails")) return true;
			
			return (personality > 66);
		}
		//Placeholders for when i rework the personality system soon-ish."
		public function addHard(arg:Number):void
		{
			personality += arg;
			if(personality > 100) personality = 100;
		}
		public function addNice(arg:Number):void
		{
			personality -= arg;
			if(personality < 0) personality = 0;
		}
		public function addMischievous(arg:Number):void
		{
			var originalPersonality:Number = personality;
			if(personality < 50)
			{
				personality += arg;
				if(personality > 50) personality = 50;
			}
			else
			{
				personality -= arg
				if(personality < 50) personality = 50;
			}
		}
		public function isMasculine():Boolean
		{
			return (mf("m", "f") == "m");
		}
		public function isFeminine():Boolean
		{
			return (mf("m", "f") == "f");
		}
		public function isBimbo(perm:Boolean=false):Boolean
		{
			if (hasStatusEffect("Temporary Treatment") && !perm) return true;
			if (hasStatusEffect("Bimbo Champagne") && !perm) return true;
			if (hasPerk("Bimbo Brains")) return true;
			if (hasPerk("Futa Faculties")) return true;
			if (this is PlayerCharacter && kGAMECLASS.flags["DR_BADGER_BIMBOED_PC"] == 1) return true;
			return hasPerk("Ditz Speech");
		}
		public function isBro(perm:Boolean=false):Boolean
		{
			if(hasPerk("Bro Brains")) return true;
			return hasPerk("Brute Speech");	
		}
		/**
		 * Brynn has a bunch of shit that leans on this that kinda needs to be expanded.
		 * @Fen- if you decide how you're going to handle differentiating the type of treatment applied, remind me after to go through and clean it up to match.
		 * I'd suggest maybe doing something with args to filter it- maybe stuff the types into GLOBAL so you can do singular if (isTreated()) checks, and then break it
		 * into smaller chunks for each variant like if (isTreated(GLOBAL.FAUXCOW)) etc
		 * @return
		 */
		public function isTreated():Boolean
		{
			//Used for Millie's temporary treatment sampling.
			if(hasStatusEffect("Temporary Treatment")) return true;
			return hasStatusEffect("Treated");
		}
		
		// These are shit for the time being, as I assume you'd wanna divorce Physical & Mental changes (ie get a Female physical+mental change set, but then tf to male or some shit idk)
		public function isTreatedFemale():Boolean
		{
			if (isTreated() && mf("m", "f") == "f") return true;
			return false;
		}
		
		public function isTreatedMale():Boolean
		{
			if (isTreated() && mf("m", "f") == "m") return true;
			return false;
		}
		//Mild exhib scene: arg = +1;
		//Full exhib scene: arg = +2
		public function exhibitionism(arg:Number = 0):Number
		{
			var originalExhibtionism:Number = exhibitionismRaw;
			trace("Initial exhibition level: " + exhibitionismRaw);
			if(arg > 0)
			{
				//Mild exhib scene gainz! GET SWOLE
				if(arg <= 1)
				{
					//Diminishing returns at different thresholds
					if(exhibitionismRaw < 20) arg *= 2;
					else if(exhibitionismRaw < 40) {} //Nuttin'!
					else if(exhibitionismRaw < 50) arg /= 2;
					//Cannot push it past 50
					if(exhibitionismRaw < 50)
					{
						if(exhibitionismRaw + arg > 50) exhibitionismRaw = 50;
						else exhibitionismRaw += arg;
					}
					//Already at cap for this tier of exhibition gain
				}
				//Full exhib scene gainz. VERY SWOLE.
				else
				{
					if(exhibitionismRaw < 50) {} //No adjustments at this tier
					else if(exhibitionismRaw < 60) arg /= 2;
					else arg /= 4;
					//Cannot push it past 100
					if(exhibitionismRaw < 100)
					{
						if(exhibitionismRaw + arg > 100) exhibitionismRaw = 100;
						else exhibitionismRaw += arg;
					}
				}
				if(originalExhibtionism < 10 && exhibitionismRaw >= 10) kGAMECLASS.eventBuffer += "\n\nMaybe having sex in front of an audience wouldn't be that bad.";
				else if(originalExhibtionism < 20 && exhibitionismRaw >= 20) kGAMECLASS.eventBuffer += "\n\nYou're still feeling a little bit of residual thrill. Who knew audiences could be so... intriguing.";
				else if(originalExhibtionism < 33 && exhibitionismRaw >= 33) kGAMECLASS.eventBuffer += "\n\nYou've got to admit to yourself that you're developing a bit of an <b>exhibitionism fetish</b>. Sure, you get nervous as hell about the idea of showing yourself off, but you get horny as hell too. At least it's a pretty common, socially accepted fetish... in most places.";
				else if(originalExhibtionism < 50 && exhibitionismRaw >= 50) kGAMECLASS.eventBuffer += "\n\nYour mind keeps supplying you with excuses to bare a little [pc.skinFurScales] around others, or ways to risk getting caught mid-coitus. <b>If you don't stop caving into those thoughts you're going to wind up being a hard-core exhibitionist!</b>";
				else if(originalExhibtionism < 66 && exhibitionismRaw >= 66) kGAMECLASS.eventBuffer += "\n\nMaybe you could buy a stand for your Codex and rig up a live holostream for when you're getting naughty. It'd probably be too bulky to carry around all the time, but once you win your inheritance, you could probably turn a pretty penny banging ultraporn stars in front of a broadcasting prism. It's telling that <b>you've almost completely obliterated your inhibitions about exhibitionism.";
				else if(originalExhibtionism < 100 && exhibitionismRaw >= 100) kGAMECLASS.eventBuffer += "\n\nFuck, you love getting naked, particularly in front of an audience - the bigger the better. If you could, you'd bone in front of a full house at the TerraDome (brought to you by JoyCo). Maybe you'll be able to rent it out someday? <b>You're as much of an exhibitionist as anyone can be.</b>";
			}
			//Negative points
			else if(arg < 0) 
			{
				//no mods!
				exhibitionismRaw += arg;
				if(exhibitionismRaw < 0) exhibitionismRaw = 0;
			}
			trace("Final reported exhibition level: " + exhibitionismRaw);
			return exhibitionismRaw; // return corruption value, if higher?
		}
		
		public static const DEPENDANT_ANY:uint = 0;
		public static const DEPENDANT_MYRVENOM:uint = 1;
		public static const DEPENDANT_CUM:uint = 2;
		
		// Is the character dependant on some external drug/chemical/etc
		public function isDependant(dependantType:uint = DEPENDANT_ANY):Boolean
		{
			if(dependantType == DEPENDANT_MYRVENOM)
			{
				if(hasPerk("Venom Slut") || hasStatusEffect("Myr Venom Withdrawal")) return true;
			}
			return false;
		}
		
		public function cumflationEnabled():Boolean
		{
			return (fluidSimulate || this is PlayerCharacter);
		}
		public function maxOutCumflation(target:String, source:Creature):void
		{
			
		}
		
		//XP!
		public function XP(arg:int = 0):Number
		{
			XPRaw += arg;
			if (XPRaw >= XPMax()) XPRaw = XPMax();
			else if (XPRaw <= 0) XPRaw = 0;
			return XPRaw;
		}
		public function XPMax(): Number {
			return level * level * 100;
		}
		//HP
		public function HP(arg: Number = 0): Number {			
			HPRaw += arg;
			if (HPRaw > HPMax()) HPRaw = HPMax();
			return HPRaw;
		}
		public function HPMax(): Number {
			var bonus:int = 0;
			bonus = fortification();
			if (hasStatusEffect("Might")) bonus += statusEffectv2("Might");
			
			var hitPoints: Number = 15 + (level - 1) * 15 + HPMod + bonus;
			if (characterClass == GLOBAL.CLASS_MERCENARY)
				hitPoints += level * 5;
			if (characterClass == GLOBAL.CLASS_ENGINEER)
				hitPoints -= level * 5;
				
			if (hasStatusEffect("Heart Tea")) hitPoints *= 1.1;
				
			return hitPoints;
		}
		public function maxHP(): Number {
			return HPMax();
		}
		public function maxOutHP(): void {
			HPRaw = HPMax();
		}
		public function HPQ():Number
		{
			return Math.round(HP()/HPMax()*100);
		}
		//ENERGY
		public function energy(arg: Number = 0): Number {
			if(arg > 0 && hasStatusEffect("Sore")) arg /= 2;
			energyRaw += arg;
			if (energyRaw > energyMax()) energyRaw = energyMax();
			else if (energyRaw < energyMin()) energyRaw = energyMin();
			return energyRaw;
		}
		public function energyMax(): Number {
			var bonus:int = 0;
			bonus += statusEffectv1("Royal Nectar");
			if(hasPerk("Heroic Reserves")) bonus += 33;
			return energyMod + 100 + bonus;
		}
		public function energyMin(): Number {
			return 0;
		}
		public function maxOutEnergy(): void {
			energyRaw = energyMax();
		}
		/** % of max lust. Can be useful for determining self-control level. */
		public function lustQ():Number
		{
			return Math.round(lust()/lustMax()*100);
		}
		//Lust
		public function lust(arg:Number = 0, apply:Boolean = false): Number 
		{
			if (apply) 
			{
				lustRaw = arg;
			}
			else if (arg != 0) 
			{
				lustRaw += arg;
				if (lustRaw > lustMax()) 
				{
					lustRaw = lustMax();
				}
				if (lustRaw < lustMin()) 
				{
					lustRaw = lustMin();
				}
			}
			
			var currLust:int = lustRaw + lustMod;

			if (currLust > lustMax()) 
			{
				return lustMax();
			}
			else if (currLust < lustMin())
			{
				return lustMin();
			}
			else 
			{
				return currLust;
			}
		}
		//% of max. Useful for determining things like how strong a PC is for his/her level.
		public function PQ():Number
		{
			return Math.round(physique()/physiqueMax()*100);
		}
		public function physique(arg:Number = 0, apply:Boolean = false):Number 
		{
			if (apply) 
			{
				physiqueRaw = arg;
			}
			else if (arg != 0) 
			{
				physiqueRaw += arg;
				if (physiqueRaw > physiqueMax()) 
				{
					physiqueRaw = physiqueMax();
				}
			}

			var currPhys:int = physiqueRaw + physiqueMod;

			if (hasStatusEffect("Tripped")) currPhys -= 4;
			if (hasStatusEffect("Might")) currPhys += statusEffectv1("Might");

			if (currPhys > physiqueMax()) 
			{
				return physiqueMax();
			}
			else if (currPhys < Creature.STAT_CLAMP_VALUE)
			{
				return Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				return currPhys;
			}
		}
		public function RQ():Number
		{
			return Math.round(reflexes()/reflexesMax()*100);
		}
		public function reflexes(arg:Number = 0, apply:Boolean = false):Number
		{
			if (apply) 
			{
				reflexesRaw = arg;
			}
			else if (arg != 0) 
			{
				reflexesRaw += arg;
				if (reflexesRaw > reflexesMax())
				{
					reflexesRaw = reflexesMax();
				}
			}

			var currReflexes:int = reflexesRaw + reflexesMod;

			//Debuffs!
			if (hasStatusEffect("Tripped")) currReflexes -= 4;
			if (hasStatusEffect("Staggered")) currReflexes *= 0.8;
			if (hasStatusEffect("Watered Down")) currReflexes *= 0.9;
			if (hasStatusEffect("Pitch Black")) currReflexes *= 0.66;

			if (currReflexes > reflexesMax())
			{
				return reflexesMax();
			}
			else if (currReflexes < Creature.STAT_CLAMP_VALUE)
			{
				return Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				return currReflexes;
			}
		}

		public function aim(arg:Number = 0, apply:Boolean = false):Number 
		{
			if (apply)
			{
				aimRaw = arg;
			}
			else if (arg != 0)
			{
				aimRaw += arg;
				if (aimRaw > aimMax())
				{
					aimRaw = aimMax();
				}
			}
			
			var currAim:int = aimRaw + aimMod;
			
			if (hasStatusEffect("Staggered")) currAim *= 0.8;
			if (hasStatusEffect("Pitch Black")) currAim *= 0.66;
			
			if (currAim > aimMax())
			{
				return aimMax();
			}
			else if (currAim < Creature.STAT_CLAMP_VALUE)
			{
				return Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				return currAim;
			}
		}

		// HUE
		public function IQ():Number
		{
			return Math.round(intelligence()/intelligenceMax()*100);
		}
		
		public function AQ():Number
		{
			return Math.round(aim() / aimMax() * 100);
		}
		
		public function LQ():Number
		{
			return Math.round(libido() / libidoMax() * 100);
		}
		
		public function intelligence(arg:Number = 0, apply:Boolean = false):Number 
		{
			if (apply)
			{
				intelligenceRaw = arg;
			}
			else if (arg != 0)
			{
				//Certain bimbo TFs reduce gains by 50%.
				if(hasPerk("Drug Fucked") && arg > 0) arg /= 2;
				if (hasPerk("Weak Mind") && arg < 0) arg *= 2;
				intelligenceRaw += arg;
				if (intelligenceRaw > intelligenceMax())
				{
					intelligenceRaw = intelligenceMax();
				}
			}

			var currInt:int = intelligenceRaw + intelligenceMod;
			
			if (hasStatusEffect("Focus Pill")) currInt += 5;

			if (currInt > intelligenceMax())
			{
				return intelligenceMax();
			}
			else if (currInt < Creature.STAT_CLAMP_VALUE)
			{
				return Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				return currInt;
			}
		}
		public function WQ():Number
		{
			var val:Number = Math.round(willpower()/willpowerMax()*100);
			return val;
		}
		public function willpower(arg:Number = 0, apply:Boolean = false):Number 
		{
			if (apply)
			{
				willpowerRaw = arg;
			}
			else if (arg != 0)
			{
				if(arg < 0 && hasStatusEffect("Weak Will")) arg *= 2;
				if(hasPerk("Weak Mind") && arg < 0) arg *= 2;
				willpowerRaw += arg;
				if (willpowerRaw > willpowerMax())
				{
					willpowerRaw = willpowerMax();
				}
			}
			var currWill:int = willpowerRaw + willpowerMod;

			//Level 7 Merc Perk
			if(hasPerk("Iron Will")) currWill += Math.floor(physique()/5);
			//Roshan Blue gives 25% more xp and lowers willpower by 30% until next rest
			if(hasStatusEffect("Roshan Blue")) currWill -= Math.floor(currWill*0.3);
			
			if (currWill > willpowerMax())
			{
				return willpowerMax();
			}
			else if (currWill < Creature.STAT_CLAMP_VALUE)
			{
				return Creature.STAT_CLAMP_VALUE;
			}
			else
			{
				return currWill;
			}
		}

		public function libido(arg:Number = 0, apply:Boolean = false):Number 
		{
			if (apply)
			{
				libidoRaw = arg;
			}
			else if (arg != 0)
			{
				//Certain bimbo TFs double gains
				if(hasPerk("Drug Fucked") && arg > 0) arg *= 2;
				libidoRaw += arg;
				if (libidoRaw > libidoMax())
				{
					libidoRaw = libidoMax();
				}
				if (libidoRaw < libidoMin())
				{
					libidoRaw = libidoMin();
				}
			}
			
			var currLib:int = libidoMod + libidoRaw;
			if (hasStatusEffect("Myr Venom")) currLib += Math.floor(currLib * 0.15);
			if (accessory is Allure) currLib += 20;
			if (hasStatusEffect("Myr Venom Withdrawal")) currLib /= 2;
			if (hasStatusEffect("Heat")) currLib += statusEffectv2("Heat");
			if (hasStatusEffect("Rut")) currLib += statusEffectv2("Rut");
			if (hasStatusEffect("Uma's Massage") && statusEffectv1("Uma's Massage") == 0) currLib *= statusEffectv2("Uma's Massage");
			if (hasStatusEffect("Uma's Massage") && statusEffectv1("Uma's Massage") == 1) currLib *= statusEffectv2("Uma's Massage");
			if (hasStatusEffect("Mare Musk")) currLib += 10;
			
			if (currLib > libidoMax())
			{
				return libidoMax();
			}
			else if (currLib < libidoMin())
			{
				return libidoMin();
			}
			else
			{
				return currLib;
			}
		}

		public function lustMax(): Number {
			var bonus:int = 0;
			bonus += perkv1("Inhuman Desire");
			//trace("Max lust: " + (bonus + 100));
			if (hasPerk("Venom Slut") && hasStatusEffect("Red Myr Venom")) bonus += 35;
			if (hasPerk("Bimbo Body") || hasPerk("Bro Body") || hasPerk("Futa Form")) bonus += 20;
			if (hasPerk("Omnibus' Gift")) bonus += 15;
			return (100 + bonus);
		}
		public function lustMin(): Number {
			var bonus:int = 0;
			if (hasPerk("Drug Fucked")) bonus += 10;
			if (hasPerk("Bimbo Body") || hasPerk("Bro Body") || hasPerk("Futa Form")) {
				if(bonus > 40) bonus += 10;
				else if(bonus >= 20) bonus += 20;
				else bonus += 40;
			}
			if (hasPerk("Omnibus' Gift")) {
				if(bonus > 40) bonus += 10;
				else if(bonus >= 20) bonus += 20;
				else bonus += 35;
			}
			if (hasStatusEffect("Ellie's Milk")) bonus += 33;
			if (hasStatusEffect("Lane Detoxing Weakness"))
			{
				if (bonus < statusEffectv2("Lane Detoxing Weakness")) bonus = statusEffectv2("Lane Detoxing Weakness");
			}
			if (hasPerk("Pierced: Icestone")) bonus -= perkv1("Pierced: Icestone");
			if (hasPerk("Pierced: Crimstone")) bonus += perkv1("Pierced: Crimstone");
			if (hasStatusEffect("Pent Up")) bonus += statusEffectv1("Pent Up");
			//Venom brings minimum up to 35.
			if (bonus < 35 && hasStatusEffect("Red Myr Venom")) bonus = 35;
			if (bonus < 35 && hasStatusEffect("Luststick")) bonus = 35;
			return Math.max((0 + bonus), 0);
		}
		public function physiqueMax(): Number {
			var bonuses:int = 0;
			if (hasStatusEffect("Quivering Quasar")) bonuses += 5;
			if (hasStatusEffect("Might")) bonuses += statusEffectv1("Might");
			return level * 5 + bonuses;
		}
		public function reflexesMax(): Number {
			return level * 5;
		}
		public function aimMax(): Number {
			return level * 5;
		}
		public function intelligenceMax(): Number {
			var bonuses:int = 0;
			if(hasPerk("Cybernetic Synchronization")) bonuses += (perkv1("Cybernetic Synchronization") * cyborgScore());
			return level * 5 + bonuses;
		}
		public function willpowerMax(): Number {
			return level * 5;
		}
		public function libidoMax(): Number {
			return 100;
		}
		public function libidoMin(): Number {
			var bonus:int = 0;
			if(hasPerk("Drug Fucked")) bonus += 40;
			return (0 + bonus);
		}
		/**
		 * Method to alter base stats with diminishing returns.
		 * @param	stat one of supported stats: physique, reflexes, aim, intelligence, willpower, libido. Supports both full stat name or only first letter.
		 * @param	arg raw amount to apply, can be positive or negative, can be fractional.
		 * @return stat value after change.
		 */
		public function slowStatGain(stat:String, arg:Number = 0):Number {
			var statCurrent: Number = 0;
			var statMax: Number = 0;
			var change: Number = 0;
			var mod: Number = 0;
			// Affinity
			if(stat == affinity || stat == affinity.charAt(0))
			{
				arg *= arg >= 0 ? 1.5 : 0.66; // more gains and less losses for affinity stats
			}
			// Normal
			if (stat == "physique" || stat == "p") {
				statCurrent = physique();
				statMax = physiqueMax();
			}
			else if (stat == "reflexes" || stat == "r") {
				statCurrent = reflexes();
				statMax = reflexesMax();
			}
			else if (stat == "aim" || stat == "a") {
				statCurrent = aim();
				statMax = aimMax();
			}
			else if (stat == "intelligence" || stat == "i") {
				statCurrent = intelligence();
				statMax = intelligenceMax();
			}
			else if (stat == "willpower" || stat == "w") {
				statCurrent = willpower();
				statMax = willpowerMax();
			}
			else if (stat == "libido" || stat == "l") {
				if (hasPerk("Purity Blessing") && arg > 0) arg *= 0.75;
				statCurrent = libido();
				statMax = libidoMax();
			}
			else {
				output("ERROR: slowStatGain called with stat argument of " + stat + ". This isn't a real stat!");
				return 0;
			}
			
			// loss - diminishing loss on low stat
			while (arg < 0) {
				mod = Math.max(arg, -0.1); // breaking into multiple iterations for more smooth distribution
				arg -= mod;
				if(arg > 0) arg = 0;
				if (statCurrent + change < 0.05 * statMax) mod *= .1;
				else if (statCurrent + change < 0.10 * statMax) mod *= .15;
				else if (statCurrent + change < 0.15 * statMax) mod *= .2;
				else if (statCurrent + change < 0.20 * statMax) mod *= .25;
				else if (statCurrent + change < 0.25 * statMax) mod *= .3;
				else if (statCurrent + change < 0.30 * statMax) mod *= .4;
				else if (statCurrent + change < 0.35 * statMax) mod *= .5;
				else if (statCurrent + change < 0.40 * statMax) mod *= .6;
				else if (statCurrent + change < 0.50 * statMax) mod *= .7;
				else if (statCurrent + change < 0.60 * statMax) mod *= .8;
				else if (statCurrent + change < 0.70 * statMax) mod *= .9;
				else mod *= 1;
				change += mod;
			}
			
			// gain - diminishing gain on high stat
			while (arg > 0) {
				mod = Math.min(arg, 0.1); // breaking into multiple iterations for more smooth distribution
				arg -= mod;
				if(arg < 0) arg = 0;
				if (statCurrent + change < 0.30 * statMax) mod *= 1;
				else if (statCurrent + change < 0.40 * statMax) mod *= .9;
				else if (statCurrent + change < 0.50 * statMax) mod *= .8;
				else if (statCurrent + change < 0.60 * statMax) mod *= .7;
				else if (statCurrent + change < 0.65 * statMax) mod *= .6;
				else if (statCurrent + change < 0.70 * statMax) mod *= .5;
				else if (statCurrent + change < 0.75 * statMax) mod *= .4;
				else if (statCurrent + change < 0.80 * statMax) mod *= .3;
				else if (statCurrent + change < 0.85 * statMax) mod *= .25;
				else if (statCurrent + change < 0.90 * statMax) mod *= .2;
				else if (statCurrent + change < 0.95 * statMax) mod *= .15;
				else mod *= .1;
				change += mod;
			}
			
			if (stat == "physique" || stat == "p") return physique(change);
			else if (stat == "reflexes" || stat == "r") return reflexes(change);
			else if (stat == "aim" || stat == "a") return aim(change);
			else if (stat == "intelligence" || stat == "i") return intelligence(change);
			else if (stat == "willpower" || stat == "w") return willpower(change);
			else if (stat == "libido" || stat == "l") return libido(change);
			else {
				output("ERROR: slowStatGain got to the end with a stat that should've called the earlier error. Looks like the function has been changed, added to, or bugged. Make sure top stat list matches bottom!");
				return 0;
			}
		}
		public function hasWeapon(weaponName:String = "any"):Boolean
		{
			// Search on-hand
			if(hasEquippedWeapon())
			{
				if(weaponName == "any") return true;
				else if(weaponName == meleeWeapon.shortName || weaponName == rangedWeapon.shortName) return true;
			}
			// Search inventory
			if(inventory.length == 0) return false;
			for(var x:int = 0; x < inventory.length; x++)
			{
				if(InCollection(inventory[x].type, GLOBAL.MELEE_WEAPON, GLOBAL.RANGED_WEAPON, GLOBAL.EXPLOSIVECONSUMABLE))
				{
					if(weaponName == "any") return true;
					else if(inventory[x].shortName == weaponName) return true;
				}
			}
			// No weapons!
			return false;
		}
		public function hasEquippedWeapon():Boolean
		{
			return (hasMeleeWeapon() || hasRangedWeapon());
		}
		public function hasRangedWeapon():Boolean
		{
			return (!(rangedWeapon is EmptySlot) && !(rangedWeapon is Rock));
		}
		public function hasMeleeWeapon():Boolean
		{
			return (!(meleeWeapon is EmptySlot) && !(meleeWeapon is Rock));
		}
		public function hasEnergyWeapon():Boolean
		{
			return hasMeleeEnergyWeapon() || hasRangedEnergyWeapon();
		}
		public function hasMeleeEnergyWeapon():Boolean
		{
			if (meleeWeapon.baseDamage.hasFlag(DamageFlag.ENERGY_WEAPON) || meleeWeapon.baseDamage.hasFlag(DamageFlag.LASER) || meleeWeapon.hasFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON)) return true;
			return false;
		}
		public function hasRangedEnergyWeapon():Boolean
		{
			if (rangedWeapon.baseDamage.hasFlag(DamageFlag.ENERGY_WEAPON) || rangedWeapon.baseDamage.hasFlag(DamageFlag.LASER) || rangedWeapon.hasFlag(GLOBAL.ITEM_FLAG_ENERGY_WEAPON)) return true;
			return false;
		}
		public function hasCombatDrone():Boolean
		{
			if (hasPerk("Attack Drone") || (accessory is TamWolf) || (accessory is TamWolfDamaged) || hasStatusEffect("Varmint Buddy"))
			{
				if (hasStatusEffect("Combat Drone Disabled")) return false;
				return true;
			}
			return false;
		}
		public function hasBowWeaponAvailable():Boolean
		{
			if (hasBowWeaponEquipped()) return true;
			
			for (var i:uint = 0; i < inventory.length; i++)
			{
				if ((inventory[i] as ItemSlotClass).hasFlag(GLOBAL.ITEM_FLAG_BOW_WEAPON)) return true;
			}
			
			return false;
		}
		public function hasBowWeaponEquipped():Boolean
		{
			if (meleeWeapon.hasFlag(GLOBAL.ITEM_FLAG_BOW_WEAPON)) return true;
			if (rangedWeapon.hasFlag(GLOBAL.ITEM_FLAG_BOW_WEAPON)) return true;
			return false;
		}
		
		//Item bonus stats!
		public function attack(melee: Boolean = true): Number 
		{
			var temp: int = 0;
			if (melee) temp += meleeWeapon.attack;
			else temp += rangedWeapon.attack;
			//Bonus to hit for Tech Specialists above level 7!
			if(hasPerk("Fight Smarter")) temp += Math.round(intelligence()/7);
			temp += armor.attack + upperUndergarment.attack + lowerUndergarment.attack + accessory.attack + shield.attack;
			return temp;
		}
		
		public function meleeDamage():TypeCollection
		{ 
			var d:TypeCollection = damage(true); 
			d.add(physique() / 2);
			return d;
		}
		public function rangedDamage():TypeCollection 
		{ 
			var d:TypeCollection = damage(false);
			d.add(aim() / 2);
			return d;
		}
		
		public function damage(melee:Boolean = true):TypeCollection
		{
			var modifiedDamage:TypeCollection;
			
			if (melee) 
			{
				modifiedDamage = meleeWeapon.baseDamage.makeCopy();
				
				if(hasPerk("Low Tech Solutions") && !hasMeleeEnergyWeapon()) 
					modifiedDamage.multiply(1.2);
					
				if(hasPerk("Weapon Tweaks") && hasMeleeEnergyWeapon()) 
					modifiedDamage.multiply(1.2);
			}
			else 
			{
				modifiedDamage = rangedWeapon.baseDamage.makeCopy();
				
				if(hasPerk("Heavy Weapons") && !hasRangedEnergyWeapon()) 
					modifiedDamage.multiply(1.2);
					
				if(hasPerk("Gun Tweaks") && hasRangedEnergyWeapon()) 
					modifiedDamage.multiply(1.2);
					
				// Easiest way I can think of conveying base damage - might be better to add this as a flat bonus some other way.
				// Only add bonus if the weapons already doing SOME HP damage
				if (modifiedDamage.hasHPDamage())
				{
					modifiedDamage.unresistable_hp.damageValue += statusEffectv1("Concentrated Fire"); 
				}
			}
			
			modifiedDamage.add(armor.baseDamage);
			modifiedDamage.add(upperUndergarment.baseDamage);
			modifiedDamage.add(lowerUndergarment.baseDamage);
			modifiedDamage.add(accessory.baseDamage);
			modifiedDamage.add(shield.baseDamage);
			

			if(hasStatusEffect("Charge Weapon"))
				modifiedDamage.add(new TypeCollection( { electric : modifiedDamage.getTotal() * statusEffectv1("Charge Weapon") / 100 } ));
			//Add bonus to both melee and ranged attacks
			if (hasStatusEffect("Lightning Moves")) modifiedDamage.multiply(1.05);
			return modifiedDamage;
		}
		public function defense(): Number 
		{
			var temp: int = 0;
			temp += meleeWeapon.defense;
			temp += rangedWeapon.defense;
			temp += armor.defense + upperUndergarment.defense + lowerUndergarment.defense + accessory.defense + shield.defense;
			if (hasStatusEffect("Harden")) temp += 1;
			if (hasPerk("Armor Tweaks")) temp += Math.round(armor.defense * .2);
			if (hasStatusEffect("Crystal Coated")) temp += 4;
			if (hasStatusEffect("Burning")) 
			{
				temp -= 5;
				if(temp < 0) temp = 0;
			}
			return temp;
		}
		public function shieldDefense(): Number 
		{
			var temp: int = 0;
			temp += meleeWeapon.shieldDefense;
			temp += rangedWeapon.shieldDefense;
			temp += armor.shieldDefense + upperUndergarment.shieldDefense + lowerUndergarment.shieldDefense + accessory.shieldDefense + shield.shieldDefense;
			return temp;
		}
		public function shields(arg: Number = 0): Number {
			if(kGAMECLASS.easy && arg < 0 && this is PlayerCharacter) arg *= .5;
			shieldsRaw += arg;
			if (shieldsRaw > shieldsMax())
				shieldsRaw = shieldsMax();
			if (shieldsRaw < 0) shieldsRaw = 0;
			return shieldsRaw;
		}
		public function shieldsMax(): Number {
			var temp: int = 0;
			temp += meleeWeapon.shields;
			temp += rangedWeapon.shields;
			temp += armor.shields + upperUndergarment.shields + lowerUndergarment.shields + accessory.shields + shield.shields;
			if (hasPerk("Shield Tweaks")) temp += level * 2;
			if (hasPerk("Shield Booster")) temp += level * 8;
			if (hasPerk("Attack Drone") && !(accessory is TamWolf || accessory is TamWolfDamaged)) temp += level;

			//Debuffs!
			if(hasStatusEffect("Rusted Emitters")) temp = Math.round(temp * 0.75);
			//No proper shield generator? NO SHIELD!
			if(shield.shields == 0) temp = 0;
			return temp;
		}
		public function sexiness(): Number {
			var temp: int = 0;
			temp += meleeWeapon.sexiness;
			temp += rangedWeapon.sexiness;
			temp += armor.sexiness + upperUndergarment.sexiness + lowerUndergarment.sexiness + accessory.sexiness + shield.sexiness;
			//Sweaty penalties!
			if(hasStatusEffect("Sweaty"))
			{
				if(hasFur()) temp -= statusEffectv1("Sweaty") * 5;
				temp -= statusEffectv1("Sweaty") * 5;
			}
			//Apply sexy moves before flat boni effects
			if (hasStatusEffect("Sexy Moves")) temp *= 1.1;
			if (hasStatusEffect("Mare Musk")) temp += 2;
			//You cannot handle the Mango!
			if (hasStatusEffect("The Mango")) temp += statusEffectv1("The Mango");
			//Gain Sexy Thinking - gives sexiness bonus equal to (100-IQ-25)/20 + (100-WQ-25)/20
			if(hasPerk("Sexy Thinking"))
			{
				if(100 - IQ() - 25 >= 0) temp += Math.round((100 - IQ() - 25)/25);
				if(100 - WQ() - 25 >= 0) temp += Math.round((100 - WQ() - 25)/25);
			}
			//-10 is as bad as it gets
			if(temp < -10) temp = -10;
			return temp;
		}
		public function critBonus(melee: Boolean = true): Number {
			var temp: int = 5;
			if (melee) temp += meleeWeapon.critBonus;
			else temp += rangedWeapon.critBonus;
			if(hasPerk("Critical Blows")) temp += 10;
			temp += armor.critBonus + upperUndergarment.critBonus + lowerUndergarment.critBonus + accessory.critBonus + shield.critBonus;
			if(temp > 50) temp = 50;
			return temp;
		}
		public function evasion(): Number {
			var temp: int = 0;
			temp += meleeWeapon.evasion;
			temp += rangedWeapon.evasion;
			temp += armor.evasion + upperUndergarment.evasion + lowerUndergarment.evasion + accessory.evasion + shield.evasion;
			if (hasPerk("Agility")) {
				if ((temp *= .5) < 10) temp += 10;
				else temp = Math.round(temp * 1.5);
			}
			if (hasPerk("Improved Agility")) {
				temp += 10;
			}
			//Apply sexy moves before flat boni effects
			if (hasStatusEffect("Sexy Moves")) temp *= 1.1;
			if (hasStatusEffect("Riposting"))
			{
				temp += 15;
			}
			if (hasStatusEffect("Stealth Field Generator")) temp += 80;
			if (hasStatusEffect("Evasion Reduction")) temp -= statusEffectv1("Evasion Reduction");
			if (hasStatusEffect("Resolve")) temp += 50;
			if (hasStatusEffect("Water Veil")) temp += statusEffectv2("Water Veil");
			if (hasStatusEffect("Spear Wall")) temp += 50;
			//Nonspecific evasion boost status effect enemies can use.
			temp += statusEffectv1("Evasion Boost");
			
			if (temp > 90) temp = 90;
			if (temp < 1) temp = 1;
			
			return temp;
		}
		public function fortification(): Number {
			var temp: int = 0;
			temp += meleeWeapon.fortification;
			temp += rangedWeapon.fortification;
			temp += armor.fortification + upperUndergarment.fortification + lowerUndergarment.fortification + accessory.fortification + shield.fortification;
			return temp;
		}
		public function hasSkinFlag(arg:int): Boolean {
			var temp: int = 0;
			while (temp < skinFlags.length) {
				if (skinFlags[temp] == arg) return true;
				temp++;
			}
			return false;
		}
		public function addSkinFlag(arg:int): void {
			if (!hasSkinFlag(arg)) skinFlags[skinFlags.length] = arg;
		}
		public function clearSkinFlags(): void {
			skinFlags = new Array();
		}
		public function hasFaceFlag(arg:int): Boolean {
			var temp: int = 0;
			while (temp < faceFlags.length) {
				if (faceFlags[temp] == arg) return true;
				temp++;
			}
			return false;
		}
		public function removeFaceFlag(arg:int):void
		{
			if (hasFaceFlag(arg))
			{
				faceFlags = faceFlags.splice(faceFlags.indexOf(arg), 1);
			}
		}
		public function addFaceFlag(arg:int): void {
			if (!hasFaceFlag(arg)) faceFlags[faceFlags.length] = arg;
		}
		public function clearFaceFlags(): void {
			faceFlags = new Array();
		}
		public function hasTailFlag(arg:int): Boolean {
			for (var temp: int = 0; temp < tailFlags.length; temp++) {
				if (tailFlags[temp] == arg) return true;
			}
			return false;
		}
		public function addTailFlag(arg:int): void {
			if (!hasTailFlag(arg)) tailFlags[tailFlags.length] = arg;
		}
		public function clearTailFlags(): void {
			tailFlags = new Array();
		}
		public function hasArmFlag(arg:int): Boolean {
			for (var temp: int = 0; temp < armFlags.length; temp++) {
				if (armFlags[temp] == arg) return true;
			}
			return false;
		}
		public function addArmFlag(arg:int): void {
			if (!hasArmFlag(arg)) armFlags[armFlags.length] = arg;
		}
		public function clearArmFlags(): void {
			armFlags = new Array();
		}
		public function hasLegFlag(arg:int): Boolean {
			for (var temp: int = 0; temp < legFlags.length; temp++) {
				if (legFlags[temp] == arg) return true;
			}
			return false;
		}
		public function addLegFlag(arg:int): void {
			if (!hasLegFlag(arg)) legFlags[legFlags.length] = arg;
		}
		public function clearLegFlags(): void {
			legFlags = new Array();
		}
		public function hasLeg(): Boolean {
			return (hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) || hasLegFlag(GLOBAL.FLAG_PLANTIGRADE));
			return false;
		}
		public function hasLegs(): Boolean {
			return (hasLeg() && legCount > 1);
		}
		public function hasTongueFlag(arg:int): Boolean {
			var temp: int = 0;
			while (temp < tongueFlags.length) {
				if (tongueFlags[temp] == arg) return true;
				temp++;
			}
			return false;
		}
		public function clearTongueFlags():void
		{
			if (tongueFlags.length > 0) tongueFlags = [];
		}
		public function addTongueFlag(arg:int): void {
			if (!hasTongueFlag(arg)) tongueFlags[tongueFlags.length] = arg;
		}
		public function displayTallness(): String {
			var buffer: String = "";
			buffer = Math.floor(tallness / 12) + "'";
			if (Math.round(tallness % 12) != 0) buffer += Math.round(tallness % 12) + "\"";
			return buffer;
		}
		public function lipRating(): Number {
			return lipMod + femininity / 25;
		}
		public function lipsDescript(forcedAdjectives:Boolean = false, chaste:Boolean = false): String {
			return lipDescript(forcedAdjectives);
		}
		public function lipDescript(forcedAdjectives:Boolean = false, chaste:Boolean = false): String {
			//lipMod + some femininity divided by something to get result.
			var lips:int = lipRating();
			var result:String = "";
			var adjectives:int = 0;
			//Size Adjectives
			if(rand(3) == 0 || forcedAdjectives)
			{
				if(lips <= 1)
				{
					if(rand(3) == 0) result += "pencil-thin";
					else if(rand(2) == 0) result += "lean";
					else result += "slender";
				}
				else if(lips <= 2)
				{
					if(rand(3) == 0) result += "nice";
					else if(rand(2) == 0) result += "petite";
					else result += "supple";
				}
				else if(lips <= 3)
				{
					if(rand(4) == 0) result += "full";
					else if(rand(3) == 0) result += "pouting";
					else if(rand(2) == 0) result += "shapely";
					else result += "plump";
				}
				else if(lips <= 4)
				{
					if(rand(3) == 0) result += "succulent";
					else if(rand(2) == 0) result += "juicy";
					else result += "luscious";
				}
				else if(lips <= 5)
				{
					if(rand(3) == 0) result += "voluptuous";
					else if(rand(2) == 0) result += "bee-stung";
					else result += "swollen";
				}
				else if(lips <= 6)
				{
					if(rand(4) == 0) result += "hypnotic";
					else if(rand(3) == 0) result += "dazzling";
					else if(rand(2) == 0) result += "fat";
					else result += "exquisitely large";
				}
				else if(lips <= 7)
				{
					if(rand(3) == 0) result += "hyper-engorged";
					else if(rand(2) == 0) result += "constantly pursed";
					else result += "bloated";
				}
				else if(lips <= 8)
				{
					if(rand(3) == 0) result += "'o' shaped";
					else if(rand(2) == 0) result += "whorish";
					else result += "permanently puckered";
				}
				//Serious this is too big, bro
				else
				{
					if(rand(5) == 0) result += "jacquesian";
					else if(rand(4) == 0) result += "scylla-tier";
					else if(rand(2) == 0) result += "impossibly large";
					else result += "universe-distorting";
				}
				adjectives++;
			}
			//Color!
			if(rand(4) == 0 && lipColor != "peach")
			{
				if(adjectives > 0) result += ", ";
				result += lipColor;
				adjectives++;
			}
			//Nouns
			if(adjectives > 0) result += " ";
			var nouns:Array = new Array();
			//Build up the choices!
			nouns[nouns.length] = "lip";
			nouns[nouns.length] = "lip";
			nouns[nouns.length] = "lip";
			nouns[nouns.length] = "lip";
			if(!chaste)
			{
				//High libido sluttery
				if(lust() >= 80 && libido() >= 50 && lips >= 2 && (hasVagina() || femininity >= 75)) nouns[nouns.length] = "dick-sucker";
				if(lust() >= 80 && libido() >= 60 && lips >= 3 && (hasVagina() || femininity >= 75)) nouns[nouns.length] = "cock-sucker";
				if(lust() >= 80 && libido() >= 65 && lips >= 4) nouns[nouns.length] = "dick-pillow";
				if(lust() >= 80 && libido() >= 70 && lips >= 4) nouns[nouns.length] = "cock-pillow";
				if(lust() >= 80 && libido() >= 80 && lips >= 5) nouns[nouns.length] = "fuck-pillow";
				if(lust() >= 80 && libido() >= 90 && lips >= 5) nouns[nouns.length] = "oral fuck-cushion";
				if(lust() >= 80 && libido() >= 90 && lips >= 6) nouns[nouns.length] = "pleasure-pillow";
			}
			else
			{
				if(lips >= 4) nouns[nouns.length] = "pillow";
				if(lips >= 4) nouns[nouns.length] = "pucker";
			}
			//Tack the selected choice onto result
			result += nouns[rand(nouns.length)];
			return result;
		}
		public function hasLongEars(): Boolean
		{
			// For ear types that support the earLength value. At least 1 inch long or more to count.
			if(earLength >= 1 && InCollection(earType, GLOBAL.TYPE_SYLVAN, GLOBAL.TYPE_LEITHAN, GLOBAL.TYPE_RASKVEL, GLOBAL.TYPE_LAPINE, GLOBAL.TYPE_GABILANI, GLOBAL.TYPE_DEMONIC)) return true;
			return false;
		}
		public function earDescript(forcedAdjectives:Boolean = false, forcedRace:Boolean = false): String
		{
			var adjectives:Array = new Array();
			var nouns:Array = ["ear"];
			var description:String = "";
			switch (earType)
			{
				case GLOBAL.TYPE_CANINE:
					adjectives = ["canine", "pointed", "upraised", "anubis-like"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry");
					if (race().indexOf("ausar") != -1) adjectives.push("ausar");
					break;
				case GLOBAL.TYPE_EQUINE:
					adjectives = ["equine", "horse-like", "inhuman"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry", "bestial");
					break;
				case GLOBAL.TYPE_BOVINE:
					adjectives = ["bovine", "cow-like", "floppy"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("softly furred");
					break;
				case GLOBAL.TYPE_FELINE:
					adjectives = ["feline", "pointed", "cat-like", "cat-like"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry");
					break;
				case GLOBAL.TYPE_LIZAN:
					adjectives = ["reptilian", "small", "circular"];
					break;
				case GLOBAL.TYPE_LAPINE:
					adjectives = ["lapine", "bunny", "rabbit-like", "floppy"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry");
					break;
				case GLOBAL.TYPE_KANGAROO:
					adjectives = ["kangaroo", "oval-shaped", "elliptical", "pointed"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry");
					break;
				case GLOBAL.TYPE_VULPINE:
					adjectives = ["vulpine", "fox-like", "pointed", "triangular"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry");
					break;
				case GLOBAL.TYPE_DEMONIC:
					adjectives = ["demonic", "demon-like", "pointy", "inhuman", "pointed"];
					break;
				case GLOBAL.TYPE_DRACONIC:
					adjectives = ["draconic", "dragon-like", "fin-like", "fan-shaped"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("beastial");
					break;
				case GLOBAL.TYPE_KUITAN:
					adjectives = ["tanuki", "egg-shaped", "rounded"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry", "beastial");
					break;
				case GLOBAL.TYPE_MOUSE:
					adjectives = ["mousey", "mouse-like", "rounded", "circular"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry");
					break;
				case GLOBAL.TYPE_PANDA:
					adjectives = ["panda", "bear-like", "rounded"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("furry", "softly furred");
					break;
				case GLOBAL.TYPE_LEITHAN:
					adjectives = ["leithan", "elven", "pointy", "inhuman", "pointed"];
					break;
				case GLOBAL.TYPE_RASKVEL:
					adjectives = ["raskvel", "obscenely long", "oh-so sensitive", "lengthy"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("smooth-scaled");
					break;
				case GLOBAL.TYPE_SYLVAN:
					adjectives = ["elven", "sensitive", "pointy", "elvish"];
					break;
				case GLOBAL.TYPE_VANAE:
					adjectives = ["vanae", "pointy", "fin-like", "inhuman"];
					break;
				case GLOBAL.TYPE_DEER:
					adjectives = ["deer", "pointed", "oval-shaped", "pointy"];
					if(skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("softly furred");
					break;
				case GLOBAL.TYPE_GABILANI:
					adjectives = ["gabilani", "pointy goblin", "long triangular", "sharp alien", "elven"];
					break;
				case GLOBAL.TYPE_FROG:
					adjectives = ["amphibian", "frog-like", "dot", "hidden"];
					break;
			}
			if (hasLongEars()) adjectives.push(num2Text(Math.round(earLength)) + "-inch long");
			if (skinType == GLOBAL.SKIN_TYPE_GOO && rand(5) == 0) adjectives.push("gooey", "slimy", "slick");
			
			// if forced racial description show first adjective
			if(forcedRace && adjectives.length > 0) description = adjectives.shift();
			//Pick an adjective about 75% of the time
			else if ((rand(4) < 3 || forcedAdjectives) && adjectives.length > 0) {
				if (description.length > 0) description += ", "; // in case of forced race
				description += adjectives[rand(adjectives.length)];
			}
			if (description.length > 0) description += " ";
			//Pick a noun.
			description += nouns[rand(nouns.length)];
			return description;
		}
		public function earsDescript(forcedAdjectives:Boolean = false, forcedRace:Boolean = false): String {
			return plural(earDescript(forcedAdjectives, forcedRace));
		}
		public function eyeDescript(forcedAdjectives:Boolean = false): String {
			var adjectives:Array = new Array();
			var nouns:Array = ["eye"];
			var description:String = "";
			
			adjectives[adjectives.length] = eyeColor;

			//Show color 50% of the time
			if((forcedAdjectives || rand(2) == 0) && adjectives.length > 0) description = adjectives[rand(adjectives.length)] + " ";
			//Pick a noun.
			description += nouns[rand(nouns.length)];
			return description;
		}
		public function eyesDescript(): String {
			return plural(eyeDescript());
		}
		
		public function hasLongTongue():Boolean
		{
			return hasTongueFlag(GLOBAL.FLAG_LONG) || hasTongueFlag(GLOBAL.FLAG_PREHENSILE);
		}
		
		public function tongueDescript(): String {
			var adjectives:Array = new Array();
			var types:Array = new Array();
			var description:String = "";
			var descripted:int = 0;
			
			//Pick adjective
			if(hasTongueFlag(GLOBAL.FLAG_LONG))
			{
				adjectives.push("lengthy", "long", "extensive");
				if (InCollection(tongueType, GLOBAL.TYPE_LEITHAN, GLOBAL.TYPE_OVIR, GLOBAL.TYPE_FROG)) adjectives.push("extendable");
				else if (tongueType == GLOBAL.TYPE_DEMONIC) adjectives.push("two-foot long");
				else if (tongueType == GLOBAL.TYPE_DRACONIC) adjectives.push("four-foot long");
			}
			if(hasTongueFlag(GLOBAL.FLAG_PREHENSILE))
				adjectives.push("talented", "rapacious", "ravenous", "flexible", "voracious", "prehensile");
			if(hasTongueFlag(GLOBAL.FLAG_HOLLOW))
				adjectives.push("tubular", "hollow");
			if(hasTongueFlag(GLOBAL.FLAG_SMOOTH))
				adjectives.push("smooth", "sleek");
			if(hasTongueFlag(GLOBAL.FLAG_GOOEY) && tongueType != GLOBAL.TYPE_GOOEY)
				adjectives.push("slimy", "slick", "gooey");
			if(hasTongueFlag(GLOBAL.FLAG_STICKY))
				adjectives.push("sticky", "glutinous", "viscous");
			
			//Show adjective 50% of the time
			if(rand(2) == 0 && adjectives.length > 0) 
			{
				description += adjectives[rand(adjectives.length)];
				descripted++;
			}
			
			//Mention of piercings
			if (tonguePierced > 0)
			{
				if (descripted > 0) description += ", ";
				description += tongueNoun(false,true);
			}
			
			//Pick type
			switch (tongueType)
			{
				case GLOBAL.TYPE_HUMAN:
					if(faceType != GLOBAL.TYPE_HUMAN)
					{
						if(isHuman() || isHalfHuman())
						{
							if(rand(5) == 0) types.push("human", "terran");
						}
						else types.push("humanoid");
					}
					break;
				case GLOBAL.TYPE_NAGA:
					types.push("forked", "reptilian", "flitting", "snake-like");
					break;
				case GLOBAL.TYPE_DEMONIC:
					types.push("slowly undulating", "retractable", "demonic");
					break;
				case GLOBAL.TYPE_DRACONIC:
					types.push("thick", "fleshy", "draconic");
					break;
				case GLOBAL.TYPE_LEITHAN:
					types.push("narrow", "forked", "leithan");
					break;
				case GLOBAL.TYPE_OVIR:
					types.push("smooth", "ovir", "thick");
					break;
				case GLOBAL.TYPE_LAPINE:
					types.push("rabbit-like", "cute", "lapine");
					break;
				case GLOBAL.TYPE_EQUINE:
					types.push("horse-like", "equine");
					break;
				case GLOBAL.TYPE_CANINE:
					types.push("dog-like", "canine", "large", "floppy");
					if(race().indexOf("ausar") != -1) types.push("ausar");
					break;
				case GLOBAL.TYPE_FELINE:
					types.push("cat-like", "feline", "cute");
					if(race().indexOf("kaithrit") != -1) types.push("kaithrit");
					break;
				case GLOBAL.TYPE_BOVINE:
					types.push("cow-like", "taurine", "wide-set", "broad", "bovine");
					break;
				case GLOBAL.TYPE_RASKVEL:
					types.push("purple", "thick", "alien", "raskvel");
					break;
				case GLOBAL.TYPE_GOOEY:
					types.push("goo-like", "amorphous", "gelatinous", "slimy", "gooey");
					if(isRahn()) types.push("rahn");
					if(race() == "galotian") types.push("galotian");
					if(race() == "Conglomerate") types.push("nanomite");
					break;
				case GLOBAL.TYPE_BEE:
					types.push("bright yellow", "insectile", "straw-like", "bee-like");
					break;
				case GLOBAL.TYPE_FROG:
					types.push("frog", "whip-like", "thick");
					break;
			}
			
			//Show type 50% of the time
			if(rand(2) == 0 && types.length > 0) 
			{
				if (descripted > 0) description += ", ";
				description += types[rand(types.length)];
				descripted++;
			}
			if(descripted > 0) description += " ";
			//Pick a noun.
			description += tongueNoun(true,false);
			return description;
		}
		public function tongueNoun(bNoun:Boolean = true, bPiercings:Boolean = true): String {
			var nouns:Array = ["tongue"];
			var description:String = "";
			var descripted:int = 0;
			
			//Mention of piercings.
			if (bPiercings && tonguePierced > 0)
			{
				if (tonguePierced < 2) description += "pierced";
				else if (tonguePierced < 3) description += "double-pierced";
				else if (tonguePierced < 4) description += "triple-pierced";
				else if (tonguePierced < 7) description += "multi-pierced";
				else description += "heavily-pierced";
				descripted++;
			}
			
			if(tongueType == GLOBAL.TYPE_BEE) nouns[nouns.length] = "proboscis";
			
			//Pick a noun.
			if(bNoun)
			{
				if (descripted > 0) description += " ";
				description += nouns[rand(nouns.length)];
			}
			return description;
		}
		public function faceDesc(): String {
			var faceo: String = "";
			var hasSmallNose: Boolean = InCollection(faceType, GLOBAL.TYPE_HUMAN, GLOBAL.TYPE_NALEEN_FACE, GLOBAL.TYPE_LAPINE, GLOBAL.TYPE_HUMANMASKED, GLOBAL.TYPE_KUITAN, GLOBAL.TYPE_VULPINE, GLOBAL.TYPE_MOUSEMAN, GLOBAL.TYPE_MOUSE);
			if (hasPerk("Androgyny")) {
				faceo = "an androgynous " + face() + " that would work on either a male or a female and " + plural(lipDescript(true)) + faceLipMimbraneDescript();
				if (mfn("m", "f", "n") != "n")
					faceo += ". Despite that, your overall appearance leaves " + mf("boyish", "girly") + " impression";
			}
			//0-10
			else if (femininity < 10) {
				faceo = "a square chin";
				if(!hasBeard() && lipRating() > 2) faceo += ", " + plural(lipDescript(true)) + faceLipMimbraneDescript() + ", and chiseled jawline.";
				else if (!hasBeard()) faceo += " and chiseled jawline";
				else faceo += ", chiseled jawline, and " + beard();
			}
			//10+ -20
			else if (femininity < 20) {
				faceo = "a rugged looking " + face() + " ";
				if (hasBeard()) faceo += "and " + beard() + " that are";
				else if(lipRating() > 2) faceo += "and " + plural(lipDescript(true)) + faceLipMimbraneDescript() + " that are";
				else faceo += "that's";
				faceo += " surely handsome";
			}
			//21-28
			else if (femininity < 28) faceo = "a well-defined jawline, a pair of " + plural(lipDescript(true)) + faceLipMimbraneDescript() + ", and a fairly masculine profile";
			//28+-35
			else if (femininity < 35) faceo = "a somewhat masculine, angular jawline and " + plural(lipDescript(true)) + faceLipMimbraneDescript() + "";
			//35-45
			else if (femininity < 45) faceo = "a pair of " + plural(lipDescript(true)) + faceLipMimbraneDescript() + " and the barest hint of masculinity in its structure";
			//45-55
			else if (femininity <= 55) faceo = "an androgynous set of features that would work on either a male or a female and " + plural(lipDescript(true)) + faceLipMimbraneDescript() + "";
			//55+-65
			else if (femininity <= 65) faceo = "a tiny touch of femininity to it, with gentle curves and " + plural(lipDescript(true)) + faceLipMimbraneDescript() + "";
			//65+-72
			else if (femininity <= 72) faceo = "a nice set of cheekbones and " + plural(lipDescript(true)) + faceLipMimbraneDescript() + "";
			//72+-80
			else if (femininity <= 80) faceo = "a beautiful, feminine shapeliness that's sure to draw attention and " + plural(lipDescript(true)) + faceLipMimbraneDescript() + "";
			//81-90
			else if (femininity <= 90)
			{
				faceo = "a gorgeous profile with " + plural(lipDescript(true)) + faceLipMimbraneDescript();
				if (hasSmallNose) faceo += ", a button nose,";
				faceo += " and noticeable eyelashes";
			}
			//91-100
			else
			{
				faceo = "a jaw-droppingly feminine shape with " + plural(lipDescript(true)) + faceLipMimbraneDescript();
				if (hasSmallNose) faceo += ", an adorable nose,";
				faceo += " and long, beautiful eyelashes";
			}
			return faceo;
		}

		public function faceLipMimbraneDescript(): String {
			//Mimbrane additions in relation to face.
			var facemim: String = "";
			
			//Player character check--not sure if NPCs can get the Mims since the flag is probably global...
			if (this is PlayerCharacter)
			{
				//Birthmark
				if (kGAMECLASS.flags["MIMBRANE_FACE_APPEARANCE"] == 1) facemim = " adorned with beauty marks just above them";
				//Lip piercings
				else if (kGAMECLASS.flags["MIMBRANE_FACE_APPEARANCE"] == 2) facemim = " decorated with a pair of lip piercings";
			}
			
			return facemim;
		}
		//Modify femininity!
		public function modFem(change: Number, strength: Number = 1): String {
			var output: String = "";
			var old: String = faceDesc();
			//If already perfect!
			if (change == 0) return "";
			//Abord if at an end of the scale
			if (femininity <= femininityMin() && change < 0) return "";
			if (femininity >= femininityMax() && change > 0) return "";
			//Make the change!
			femininity += change;
			//Stay in bounds.
			if (femininity < femininityMin()) {
				change = (femininity - change) - femininityMin();
				femininity = femininityMin();
			}
			if (femininity > femininityMax()) {
				change = femininityMax() - (femininity - change);
				femininity = femininityMax();
			}
			//Large change
			if (Math.abs(change) > 5) {
				if (change > 0) output = "\n\n<b>Your facial features soften as your body becomes more feminine. (+" + Math.round(change * 10) / 10 + ")</b>";
				else output = "\n\n<b>Your facial features harden as your body becomes more masculine. (" + Math.round(change * 10) / 10 + ")</b>";
			}
			//Barely noticable change!
			else {
				if (change > 0) output = "\n\nThere's a tingling in your " + old + " as it changes imperceptibly towards being more feminine. (+" + Math.round(change * 10) / 10 + ")";
				else if (change < 0) output = "\n\nThere's a tingling in your " + old + " as it changes imperciptibly towards being more masculine. (" + Math.round(change * 10) / 10 + ")";
			}
			return output;
		}
		public function femininityMax(): Number {
			if (hasPerk("Androgyny")) return 100; // perk overrides other conditions
			//Herms + genderless
			if ((!hasVagina() && !hasCock()) || (hasCock() && hasVagina())) return 85;
			else if (hasCock() && !hasVagina()) return 70;
			else return 100;
		}
		public function femininityMin(): Number {
			if (hasPerk("Androgyny")) return 0; // perk overrides other conditions
			//Herms + genderless
			if ((!hasVagina() && !hasCock()) || (hasCock() && hasVagina())) return 20;
			else if (!hasCock() && hasVagina()) return 30;
			else return 000;
		}
		//Run this every hour to 'fix' femininity.
		public function fixFemininity(): String {
			var output: String = "";
			//BELOW MINIMUM! GET MORE GIRLY!
			if (femininity < femininityMin()) {
				output += "\n\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
				if (hasBeard()) {
					output += " As if that wasn't bad enough, your " + beard() + " falls out too!";
					removeBeard();
				}
				output += "</b>";
				femininity = femininityMin();
			}
			//ABOVE MAX! GET LESS GIRLY!
			else if (femininity > femininityMax()) {
				output += "\n\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>";
				femininity = femininityMax();
			}
			//LOSE DICK OR HAVE VAGINA? NO BEARD 4 U!
			if ((!hasCock() || hasVagina()) && hasBeard()) {
				output += "\n\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>";
				removeBeard();
			}
			return output;
		}
		public function hasBeard(): Boolean {
			if (beardLength > 0) return true;
			else return false;
		}
		public function beard(): String {
			if (hasBeard())
			{
				var description: String = "";
				var adjectives: Array = [];
				if (beardLength > 0.001 && beardLength <= 0.125) return RandomInCollection("stubble", "five o’clock shadow", "beard");
				if (rand(4) == 0)
				{
					if (beardLength < 1) adjectives.push("trim", "short");
					else adjectives.push(num2Text(Math.round(beardLength)) + "-inch long");
					if (beardLength >= 6) adjectives.push("lengthy", "long");
				}
				if (adjectives.length > 0 && rand(2) == 0) description += RandomInCollection(adjectives) + " ";
				// Beard styles
				if (description.length == 0 && beardStyle != 0 && rand(2) == 0)
				{
					description += beardStyles(true);
				}
				else description += "beard";
				return description;
			}
			else return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL FEN IMMEDIATELY.</b>";
		}
		public function beardStyles(wNoun:Boolean = false): String
		{
			var bStyle:String = "";
			// List of styles
			switch (beardStyle)
			{
				default:
					bStyle = "unstyled";
					if(wNoun) bStyle += " beard"
					break;
					
				case 1:
					bStyle = "braided";
					if(wNoun) bStyle = RandomInCollection("braided", "weaved") + " beard";
					break;
				case 2:
					bStyle = "curly";
					if(wNoun) bStyle = RandomInCollection("curly", "curled", "frizzy") + " beard";
					break;
				case 3:
					bStyle = "untamed";
					if(wNoun) bStyle = RandomInCollection("untamed", "wild") + " beard";
					break;
				case 4:
					bStyle = "anchor";
					if(wNoun) bStyle = RandomInCollection("anchor", "anchor-shaped") + " beard";
					break;
				case 5:
					bStyle = "mutton chops";
					if(wNoun) bStyle = RandomInCollection("mutton chop", "mutton-chop beard");
					break;
				case 6:
					bStyle = "boxed";
					if(wNoun) bStyle = RandomInCollection("boxed", "box-shaped") + " beard";
					break;
				case 7:
					bStyle = "chin strap";
					if(wNoun) bStyle = RandomInCollection("chin strap", "chin-strap beard");
					break;
				case 8:
					bStyle = "mustache";
					break;
				case 9:
					bStyle = "handlebars";
					if(wNoun) bStyle = "handlebar mustache";
					break;
				case 10:
					bStyle = "goatee";
					break;
			}
			return bStyle;
		}
		public function removeBeard():void
		{
			beardLength = 0;
			beardStyle = 0;
			return;
		}
		public function gillDesc(): String
		{
			var adjectives:Array = [];
			var nouns:Array = ["gill"];
			var description:String = "";
			
			if (9999 == 9999) adjectives.push("feathery");
			if (9999 == 0) adjectives.push("slit-like");
			if (9999 == 0) adjectives.push("fish-like");
			if (9999 == 0) adjectives.push("bulbous");
			if (9999 == 0) adjectives.push("dotted");
			if (9999 == 0) adjectives.push("slimy", "gooey");
			if (9999 == 0) adjectives.push("chitinous", "armored");
			if (9999 == 0) adjectives.push("scaly", "scaled");
			if (9999 == 0) adjectives.push("furry", "furred");
			if (9999 == 0) adjectives.push("smooth", "sleek");
			if (9999 == 0) adjectives.push("alien");
			
			if(rand(2) == 0 && adjectives.length > 0) description += adjectives[rand(adjectives.length)] + " ";
			
			description += nouns[rand(nouns.length)];
			return description;
		}
		public function gillsDesc(): String
		{
			return plural(gillDesc());
		}
		public function modThickness(change: Number, display:Boolean = true): String 
		{
			var oldN: Number = thickness;
			var minN: Number = thicknessMin();
			var maxN: Number = thicknessMax();
			
			// Mods to caps here
			
			//Check bounds
			if (change != 0) 
			{
				thickness += change;
				if (thickness > maxN) thickness = maxN;
				if (thickness < minN) thickness = minN;
			}
			change = thickness - oldN;
			if(display)
			{
				// Display 'U GOT FAT'
				if (change > 0) return "\n\nYour center of balance changes a little bit as your body noticeably widens. (+" + Math.round(change * 10) / 10 + " body thickness)";
				// GET THIN BITCH
				if (change < 0) return "\n\nEach movement feels a tiny bit easier than the last. Did you just lose a little weight!? (" + Math.round(change * 10) / 10 + " body thickness)";
			}
			return "";
		}
		public function modTone(change: Number, display:Boolean = true): String 
		{
			var oldN: Number = tone;
			var minN: Number = toneMin();
			var maxN: Number = toneMax();
			
			// Mods to caps
			if(hasSkinFlag(GLOBAL.FLAG_SQUISHY) && change > 0 && (tone + change) > maxN) return "\n\nBeing naturally squishy, your body refuses to get more solid than it is now.";
			
			//Check bounds
			if (change != 0) 
			{
				tone += change;
				if (tone > maxN) tone = maxN;
				if (tone < minN) tone = minN;
			}
			change = tone - oldN;
			if(display)
			{
				// Display BITCH I WORK OUT
				if (change > 0) return "\n\nYour body feels a little more solid as you move, and your muscles look slightly more visible. (+" + Math.round(change * 10) / 10 + " muscle tone)";
				// Display DERP I HAVE GIRL MUSCLES
				if (change < 0) return "\n\nMoving brings with it a little more jiggle than you're used to. You don't seem to have gained weight, but your muscles look less visible. (" + Math.round(change * 10) / 10 + " muscle tone)";
			}
			return "";
		}
		public function skinFurScalesColor():String
		{
			if(skinType == GLOBAL.SKIN_TYPE_FUR || skinType == GLOBAL.SKIN_TYPE_FEATHERS) return furColor;
			else if(skinType == GLOBAL.SKIN_TYPE_SCALES || skinType == GLOBAL.SKIN_TYPE_CHITIN) return scaleColor;
			else return skinTone;
		}
		public function chitinColor(part:String = "", bonus:Boolean = false):String
		{
			// Special types of chitinous anatomy return the scale color, otherwise it's a black color.
			var colors:Array = ["black"];
			if (bonus) colors.push("ebony", "midnight-hued", "obsidian", "onyx", "pitch");
			if (part == "body" || skinType == GLOBAL.SKIN_TYPE_CHITIN)
			{
				if (skinType != GLOBAL.SKIN_TYPE_CHITIN) return "null";
				return scaleColor;
			}
			if (part == "arm" || hasArmFlag(GLOBAL.FLAG_CHITINOUS))
			{
				if (!hasArmFlag(GLOBAL.FLAG_CHITINOUS)) return "null";
				if (hasArmFlag(GLOBAL.FLAG_GOOEY)) return scaleColor;
				if (InCollection(armType, GLOBAL.TYPE_MYR, GLOBAL.TYPE_LEITHAN)) return scaleColor;
				return RandomInCollection(colors);
			}
			if (part == "leg" || hasLegFlag(GLOBAL.FLAG_CHITINOUS))
			{
				if (!hasLegFlag(GLOBAL.FLAG_CHITINOUS)) return "null";
				if (hasLegFlag(GLOBAL.FLAG_GOOEY)) return scaleColor;
				if (InCollection(legType, GLOBAL.TYPE_MYR, GLOBAL.TYPE_GOOEY)) return scaleColor;
				return RandomInCollection(colors);
			}
			if (part == "tail" || hasTailFlag(GLOBAL.FLAG_CHITINOUS))
			{
				if (!hasTailFlag(GLOBAL.FLAG_CHITINOUS)) return "null";
				if (hasTailFlag(GLOBAL.FLAG_GOOEY)) return scaleColor;
				if (InCollection(tailType, GLOBAL.TYPE_MYR)) return scaleColor;
				return RandomInCollection(colors);
			}
			return "null";
		}
		public function legFurScales():String 
		{
			var output: String = "";
			var temp:*;
			var noun:String = "";
			var adjectives:Array = [];
			//Figure out if we're talking skin or fur.
			if(hasLegFur()) noun += "fur";
			else if(hasLegFlag(GLOBAL.FLAG_SCALED) || skinType == GLOBAL.SKIN_TYPE_SCALES) noun += "scales";
			else if(hasLegFlag(GLOBAL.FLAG_CHITINOUS) || skinType == GLOBAL.SKIN_TYPE_CHITIN) noun += "chitin";
			else if(legType == GLOBAL.TYPE_GOOEY || skinType == GLOBAL.SKIN_TYPE_GOO) noun += "goo";
			else if(hasLegFlag(GLOBAL.FLAG_FEATHERED)) noun += "feathers";
			else noun += "skin";

			//25% of the time, add an adjective.
			if (rand(4) == 0) {
				if (hasSkinFlag(GLOBAL.FLAG_SMOOTH) || hasLegFlag(GLOBAL.FLAG_SMOOTH)) adjectives.push("smooth");
				if (hasSkinFlag(GLOBAL.FLAG_THICK)) adjectives.push("thick");
				if (hasSkinFlag(GLOBAL.FLAG_STICKY)) adjectives.push("sticky");
				if (hasSkinFlag(GLOBAL.FLAG_FLUFFY))
				{
					if (noun == "fur") adjectives.push("fluffy");
					if (noun == "feathers") adjectives.push("downy");
				}
				output += RandomInCollection(adjectives);
			}
			//25% of time, describe tone.
			if (rand(4) == 0) {
				if (output != "") output += ", ";
				if (noun == "fur" || noun == "feathers") output += furColor;
				else if (noun == "scales" || noun == "chitin") output += scaleColor;
				else output += skinTone;
			}
			//Setup for words
			if (output != "") output += " ";
			//Set skin words.
			output += noun;
			return output;
		}
		public function skinFurScales(forceTone: Boolean = false, forceAdjective: Boolean = false, skin: Boolean = false): String {
			var output: String = "";
			var temp:*;
			var adjectives:Array = [];
			//33% of the time, add an adjective.
			if (forceAdjective || rand(3) == 0) {
				if (hasSkinFlag(GLOBAL.FLAG_SMOOTH)) adjectives.push("smooth");
				if (hasSkinFlag(GLOBAL.FLAG_THICK)) adjectives.push("thick");
				if (hasSkinFlag(GLOBAL.FLAG_STICKY)) adjectives.push("sticky");
				if (hasSkinFlag(GLOBAL.FLAG_FLUFFY) && !skin)
				{
					if (skinType == GLOBAL.SKIN_TYPE_FUR) adjectives.push("fluffy");
					if (skinType == GLOBAL.SKIN_TYPE_FEATHERS) adjectives.push("downy");
				}
				if(adjectives.length > 0) output += RandomInCollection(adjectives);
			}
			//25% of time, describe skin tone.
			if (forceTone || rand(4) == 0) {
				if (output != "") output += ", ";
				if ((skinType == GLOBAL.SKIN_TYPE_FUR || skinType == GLOBAL.SKIN_TYPE_FEATHERS) && !skin) output += furColor;
				else if ((skinType == GLOBAL.SKIN_TYPE_SCALES || skinType == GLOBAL.SKIN_TYPE_CHITIN) && !skin) output += scaleColor;
				else output += skinTone;
			}
			//Setup for words
			if (output != "") output += " ";
			//Set flag to cut down skin nouns to "normal" ones for appearance screens and the like.
			var appearance:Boolean = (forceAdjective || forceTone);
			output += skinNoun(skin,appearance);
			return output;
		}
		public function hasMuzzle():Boolean
		{
			return (hasFaceFlag(GLOBAL.FLAG_MUZZLED));
		}
		public function hasFur():Boolean
		{
			return (skinType == GLOBAL.SKIN_TYPE_FUR);
		}
		public function hasScales():Boolean
		{
			return (skinType == GLOBAL.SKIN_TYPE_SCALES);
		}
		public function hasChitin():Boolean
		{
			return (skinType == GLOBAL.SKIN_TYPE_CHITIN);
		}
		public function hasGooSkin():Boolean
		{
			return (skinType == GLOBAL.SKIN_TYPE_GOO);
		}
		public function hasFeathers():Boolean
		{
			return (skinType == GLOBAL.SKIN_TYPE_FEATHERS);
		}
		public function hasLegFur():Boolean
		{
			return (hasLegFlag(GLOBAL.FLAG_FLUFFY) || hasLegFlag(GLOBAL.FLAG_FURRED) || skinType == GLOBAL.SKIN_TYPE_FUR)
		}
		public function skinNoun(skin: Boolean = false,appearance:Boolean = false): String {
			var output: String = "";
			var temp: int = 0;
			//Set skin words.
			if (skinType == GLOBAL.SKIN_TYPE_SKIN || skin) {
				temp = rand(10);
				//if (temp <= 8) 
				output += "skin";
				//else output += "dermis";
			} else if (skinType == GLOBAL.SKIN_TYPE_FUR) {
				temp = rand(10);
				if (temp <= 7 || appearance) output += "fur";
				else if (temp <= 8) output += "pelt";
				else output += "coat";
			} else if (skinType == GLOBAL.SKIN_TYPE_SCALES) {
				temp = rand(10);
				if (temp <= 7 || appearance) output += "scales";
				else if (temp <= 8) output += "plates";
				else output += "lamina";
			} else if (skinType == GLOBAL.SKIN_TYPE_GOO) {
				if (temp <= 7 || appearance) output += "goo";
				else output += "membrane";
			} else if (skinType == GLOBAL.SKIN_TYPE_FEATHERS) {
				if (temp <= 7 || appearance) output += "feathers";
				else if (temp <= 8) output += "fringes";
				else output += "plumes";
			} else if (skinType == GLOBAL.SKIN_TYPE_CHITIN) {
				if (temp <= 7 || appearance) output += "chitin";
				else if (temp <= 8) output += "armor";
				else output += "carapace";
			}
			return output;
		}
		public function skin(forceTone: Boolean = false, forceAdjective: Boolean = false): String {
			return skinFurScales(forceTone, forceAdjective, true);
		}
		public function face(forceAdjectives: Boolean = false): String {
			var output: String = "";
			var adjectives:Array = [];
			//1 in 4 chance unless forcing adjectives
			if (rand(4) == 0 || forceAdjectives)
			{
				switch (faceType)
				{
					case GLOBAL.TYPE_CANINE: adjectives.push("canine", "dog-like"); break;
					case GLOBAL.TYPE_FELINE: adjectives.push("feline", "cat-like"); break;
					case GLOBAL.TYPE_EQUINE: adjectives.push("equine", "horse-like", "bestial"); break;
					case GLOBAL.TYPE_BOVINE: adjectives.push("bovine", "cow-like", "bestial"); break;
					case GLOBAL.TYPE_LIZAN: adjectives.push("lizan", "reptilian"); break;
					case GLOBAL.TYPE_DRACONIC: adjectives.push("draconic", "reptilian"); break;
					case GLOBAL.TYPE_LAPINE: adjectives.push("lapine", "rabbit-like", "bunny"); break;
					case GLOBAL.TYPE_NAGA: adjectives.push("naga", "snake-like"); break;
					case GLOBAL.TYPE_HUMANMASKED: adjectives.push("masked"); break;
					case GLOBAL.TYPE_KUITAN: adjectives.push("kui-tan", "tanuki-like", "raccoon-like"); break;
					case GLOBAL.TYPE_VULPINE: adjectives.push("vulpine", "fox-like", "foxy"); break;
					case GLOBAL.TYPE_MOUSEMAN: adjectives.push("mousey", "mouse-like"); break;
					case GLOBAL.TYPE_MOUSE: adjectives.push("mouse", "mousey", "mouse-like"); break;
					case GLOBAL.TYPE_PANDA: adjectives.push("panda", "bear-like"); break;
					case GLOBAL.TYPE_BADGER: adjectives.push("badger", "mustelid"); break;
					case GLOBAL.TYPE_KANGAROO: adjectives.push("kangaroo", "‘roo-like"); break;
					case GLOBAL.TYPE_FROG: adjectives.push("flat", "frog-like"); break;
				}
				if (hasFaceFlag(GLOBAL.FLAG_ANGULAR)) adjectives.push("angular");
				if (hasFaceFlag(GLOBAL.FLAG_LONG)) adjectives.push("long");
			}
			//Space if adjective'd
			if (adjectives.length > 0) output += RandomInCollection(adjectives) + " ";
			
			//Add Noun
			if (hasFaceFlag(GLOBAL.FLAG_MUZZLED) && rand(2) == 0)
				output += "muzzle";
			else if (hasFaceFlag(GLOBAL.FLAG_MUZZLED) && rand(2) == 0 && InCollection(faceType, GLOBAL.TYPE_LIZAN, GLOBAL.TYPE_DRACONIC, GLOBAL.TYPE_NAGA))
				output += "snout";
			else
				output += "face";
			
			return output;
		}
		public function isBiped(): Boolean {
			//Naga/Centaur
			if (legCount != 2) return false;
			return true;
		}
		public function isNaga(): Boolean {
			if (legCount == 1 && legType == GLOBAL.TYPE_NAGA) return true;
			if (legType == GLOBAL.TYPE_GOOEY && hasLegFlag(GLOBAL.FLAG_PREHENSILE)) return true;
			return false;
		}
		public function isTaur(): Boolean {
			if (isGoo() || isNaga()) return false;
			if (legCount == 4) return true;
			if (legCount == 6) return true;
			return false;
		}
		public function isCentaur(): Boolean
		{
			return(legCount == 4 && legType == GLOBAL.TYPE_EQUINE);
		}
		public function isDrider(): Boolean {
			return (legCount >= 4 && (legType == GLOBAL.TYPE_DRIDER || legType == GLOBAL.TYPE_ARACHNID));
		}
		public function isGoo(): Boolean {
			if (legType == GLOBAL.TYPE_GOOEY)
			{
				if (hasLegFlag(GLOBAL.FLAG_PREHENSILE)) return false;
				if (legCount == 1 || hasLegFlag(GLOBAL.FLAG_AMORPHOUS)) return true;
			}
			return false;
		}
		public function isImmobilized(): Boolean {
			return (hasStatusEffect("Stunned") || hasStatusEffect("Paralyzed") || isGrappled() || hasStatusEffect("Endowment Immobilized"));
		}
		public function isGrappled(): Boolean {
			return (hasStatusEffect("Grappled") || hasStatusEffect("Naleen Coiled") || hasStatusEffect("Cockvine Grip"));
		}
		public function legs(forceType: Boolean = false, forceAdjective: Boolean = false): String 
		{
			return plural(leg(forceType, forceAdjective, true));
		}
		public function legOrLegs(forceType: Boolean = false, forceAdjective: Boolean = false): String {
			if (legCount == 1) return leg(forceType, forceAdjective);
			else return legs(forceType, forceAdjective);
		}
		public function tailDescript(forceType: Boolean = false, forceAdjective: Boolean = false): String {
			var adjectives:Array = new Array();
			var nouns:Array = ["tail"];
			var description:String = "";
			// Types
			switch (tailType)
			{
				case GLOBAL.TYPE_LAPINE:
					adjectives = ["lapine", "twitching", "rabbit-like"];
					break;
				case GLOBAL.TYPE_EQUINE:
					adjectives = ["equine", "horse-like"];
					break;
				case GLOBAL.TYPE_CANINE:
					adjectives = ["canine", "dog-like"];
					if (race().indexOf("ausar") != -1) adjectives.push("ausar");
					break;
				case GLOBAL.TYPE_BOVINE:
					adjectives = ["bovine", "cow-like"];
					break;
				case GLOBAL.TYPE_CUNTSNAKE:
					adjectives = ["snake-like"];
					break;
				case GLOBAL.TYPE_PANDA:
					adjectives = ["panda", "bear-like"];
					break;
				case GLOBAL.TYPE_FELINE:
					adjectives = ["feline", "cat-like"];
					if (race().indexOf("kaithrit") != -1) adjectives.push("kaithrit");
					break;
				case GLOBAL.TYPE_DRIDER:
				case GLOBAL.TYPE_ARACHNID:
				case GLOBAL.TYPE_BEE:
				case GLOBAL.TYPE_MYR:
					nouns = ["abdomen"];
					if (tailType == GLOBAL.TYPE_DRIDER || tailType == GLOBAL.TYPE_ARACHNID) adjectives.push("arachnid", "spherical");
					if (tailType == GLOBAL.TYPE_BEE) adjectives.push("zil", "bee-like");
					if (tailType == GLOBAL.TYPE_MYR) adjectives.push("myr", "ant-like");
					adjectives.push("dangling", "insectile", "insect-like");
					break;
				case GLOBAL.TYPE_DEMONIC:
					adjectives = ["demonic", "spade-tipped", "whip-like", "inhuman"];
					break;
				case GLOBAL.TYPE_SHARK:
				case GLOBAL.TYPE_SIREN:
					adjectives = ["shark", "finned", "fish-like", "fin-tipped"];
					break;
				case GLOBAL.TYPE_LIZAN:
					adjectives = ["reptilian", "lizard-like"];
					break;
				case GLOBAL.TYPE_AVIAN:
					adjectives = ["avian", "bird-like"];
					break;
				case GLOBAL.TYPE_KANGAROO:
					adjectives = ["kangaroo", "‘roo-like"];
					break;
				case GLOBAL.TYPE_VULPINE:
					adjectives = ["vulpine", "fox-like", "fox"];
					break;
				case GLOBAL.TYPE_DRACONIC:
					adjectives = ["draconic", "dragon-like", "reptilian", "bestial"];
					break;
				case GLOBAL.TYPE_KUITAN:
					adjectives = ["tanuki", "racoon-like", "kui-tan"];
					break;
				case GLOBAL.TYPE_MOUSE:
					adjectives = ["mouse", "mousey", "mouse-like", "cute"];
					break;
				case GLOBAL.TYPE_BADGER:
					adjectives = ["badger", "mustelid", "tufted"];
					break;
				case GLOBAL.TYPE_RASKVEL:
					adjectives = ["raskvel", "reptilian"];
					break;
				case GLOBAL.TYPE_SNAKE:
					adjectives = ["reptilian", "snake-like", "serpent"];
					break;
				case GLOBAL.TYPE_SYDIAN:
					adjectives = ["sydian", "wicked-shaped"];
					break;
				case GLOBAL.TYPE_COCKVINE:
					adjectives = ["vine-like"];
					break;
				case GLOBAL.TYPE_OVIR:
					adjectives = ["ovir", "lizard-like"];
					break;
				case GLOBAL.TYPE_VANAE:
					adjectives = ["vanae", "tentacled-like", "sucker-lined"];
					break;
				case GLOBAL.TYPE_DEER:
					adjectives = ["deer", "tufted", "cute"];
					break;
				case GLOBAL.TYPE_FROG:
					adjectives = ["frog", "tadpole-like", "short", "nubby", "nubbed"];
					break;
			}
			// Flags
			if (hasTailCock())
				adjectives.push("writhing", "tentacle-like", "penis-tipped");
			if (hasTailCunt())
				adjectives.push("writhing", "tentacle-like", "pussy-tipped");
			if (hasTailFlag(GLOBAL.FLAG_PREHENSILE))
				adjectives.push("talented", "nimble");
			if (hasTailFlag(GLOBAL.FLAG_LONG))
				adjectives.push("lengthy", "long");
			if (hasTailFlag(GLOBAL.FLAG_FLUFFY))
				adjectives.push("fluffy", "soft");
			if (hasTailFlag(GLOBAL.FLAG_SMOOTH))
				adjectives.push("smooth", "sleek");
			if (hasTailFlag(GLOBAL.FLAG_TAILCOCK))
				nouns.push("tail-cock", "genitail");
			if (hasTailFlag(GLOBAL.FLAG_FURRED))
				adjectives.push("furry", "furred");
			if (hasTailFlag(GLOBAL.FLAG_SCALED))
				adjectives.push("scaled", "scaly");
			if (hasTailFlag(GLOBAL.FLAG_OVIPOSITOR))
				nouns.push("ovipositor");
			if (hasTailFlag(GLOBAL.FLAG_THICK))
				adjectives.push("thick", "girthy");
			if (hasTailFlag(GLOBAL.FLAG_STINGER_TIPPED))
				adjectives.push("stinger-tipped", "dangerous");
			if (hasTailFlag(GLOBAL.FLAG_CHITINOUS))
				adjectives.push("chitinous", "armored");
			if (hasTailFlag(GLOBAL.FLAG_TAPERED))
				adjectives.push("tapered", "conical");
			if (hasTailFlag(GLOBAL.FLAG_FEATHERED))
				adjectives.push("feathered", "feathery");
			if (hasTailFlag(GLOBAL.FLAG_GOOEY))
				adjectives.push("slimy", "slick", "gooey");
			if (hasTailFlag(GLOBAL.FLAG_STICKY))
				adjectives.push("sticky");
			
			// first adjective in list should be type
			if (forceType && adjectives.length > 0) description += adjectives.shift();
			//Show adjective 50% of the time
			if (rand(2) == 0 && adjectives.length > 0) {
				if (description.length > 0) description += ", ";
				description = adjectives[rand(adjectives.length)];
			}
			if (description.length > 0) description += " ";
			//Pick a noun.
			description += nouns[rand(nouns.length)];
			return description;
		}
		public function oneTailDescript(forceType: Boolean = false, forceAdjective: Boolean = false):String
		{
			if (tailCount == 0) return "ERROR: No tails!";
			else if (tailCount == 1) return "your " + tailDescript(forceType, forceAdjective);
			else return "one of your " + tailDescript(forceType, forceAdjective);
		}
		public function eachTailDescript(forceType: Boolean = false, forceAdjective: Boolean = false):String
		{
			if (tailCount == 0) return "ERROR: No tails!";
			else if (tailCount == 1) return "your " + tailDescript(forceType, forceAdjective);
			else return "each of your " + tailDescript(forceType, forceAdjective);
		}
		public function tailsDescript(forceType: Boolean = false, forceAdjective: Boolean = false):String {
			if(tailCount == 1) return tailDescript(forceType, forceAdjective);
			else if(tailCount > 1) return plural(tailDescript(forceType, forceAdjective));
			else return "<b>ERROR: Taildescript called with no tails present</b>";
		}
		public function wingDescript(nounOnly:Boolean = false):String
		{
			var adjectives:Array = new Array();
			var nouns: Array = ["wing"];
			var description:String = "";
			
			switch (wingType)
			{
				default:
					adjectives.push("non-existent");
					break;
					
				case GLOBAL.TYPE_SMALLBEE:
				case GLOBAL.TYPE_MYR:
					adjectives.push("small", mf("tiny", "cute"), "insect-like", "insectile", "shimmering");
					break;
					
				case GLOBAL.TYPE_BEE:
					adjectives.push("large", "insect-like", "insectile", "bee", "membrane-covered", "transparent");
					break;
					
				case GLOBAL.TYPE_SMALLDEMONIC:
					adjectives.push("small", mf("tiny", "cute"), "bat-like", "demon-like");
					break;
					
				case GLOBAL.TYPE_DEMONIC:
					adjectives.push("large", "bat-like", "demon-like", "demonic", "wicked", mf("incubus", "succubus"));
					break;
					
				case GLOBAL.TYPE_SHARK:
					adjectives.push("large", "shark-like");
					nouns = ["dorsal fin"];
					break;
					
				case GLOBAL.TYPE_AVIAN:
					adjectives.push("large", "bird-like", "avian", "feathery");
					break;

				case GLOBAL.TYPE_SMALLDRACONIC:
					adjectives.push("small", mf("tiny","cute"), "bat-like", "dragon-like", "scaled");
					break;

				case GLOBAL.TYPE_DRACONIC:
					adjectives.push("large", "bat-like", "dragon-like", "draconic", "scaled", "wicked", "magnificent", mf("mighty","majestic"));
					break;

				case GLOBAL.TYPE_DRAGONFLY:
					adjectives.push("large", "giant", "insectile", "dragonfly", "transparent", "iridescent");
					break;

				case GLOBAL.TYPE_SYLVAN:
					adjectives.push("sylvan", "delicate", "blue gossamer", "iridescent");
					break;

				case GLOBAL.TYPE_DARK_SYLVAN:
					adjectives.push("dark sylvan", "delicate", "black gossamer", "shadowy");
					break;
					
				case GLOBAL.TYPE_DOVETWO:
				case GLOBAL.TYPE_DOVEFOUR:
				case GLOBAL.TYPE_DOVESIX:
					adjectives.push("large", "bird-like", "dove-like", "soft", "feathery");
					break;
			}

			if (!nounOnly && rand(2) == 0 && adjectives.length > 0) description += RandomInCollection(adjectives) + " ";
			description += (nouns.length > 0 ? RandomInCollection(nouns) : "wing");
			return description;
		}
		public function wingsDescript(nounOnly:Boolean = false):String
		{
			if(wingType == GLOBAL.TYPE_SHARK) return wingDescript(nounOnly);
			return plural(wingDescript(nounOnly));
		}
		public function armsDescript(forceAdjective: Boolean = false):String {
			return plural(armDescript(forceAdjective));
		}
		public function armDescript(forceAdjective: Boolean = false):String
		{
			var output: String = "";
			var adjective:Array = [];
			var type:Array = [];
			
			// Adjectives
			if (hasArmFlag(GLOBAL.FLAG_SMOOTH)) adjective.push("smooth");
			if (hasArmFlag(GLOBAL.FLAG_AMORPHOUS)) adjective.push("amorphous", "gooey");
			if (hasArmFlag(GLOBAL.FLAG_FURRED)) adjective.push("furred", "furry");
			if (hasArmFlag(GLOBAL.FLAG_SCALED)) adjective.push("scaled", "scaly");
			if (hasArmFlag(GLOBAL.FLAG_CHITINOUS)) adjective.push("chitinous", "armored");
			if (hasArmFlag(GLOBAL.FLAG_FEATHERED)) adjective.push("feathered", "feathery");
			if (hasArmFlag(GLOBAL.FLAG_GOOEY)) adjective.push("slimy", "slick", "gooey");
			if (hasArmFlag(GLOBAL.FLAG_SPIKED)) adjective.push("spiked", "spiky", "prickly");
			if (hasArmFlag(GLOBAL.FLAG_STICKY)) adjective.push("sticky");
			
			// Build
			if ((forceAdjective || rand(2) == 0) && adjective.length > 0) output += RandomInCollection(adjective);
			// Noun
			if (output != "") output += " ";
			output += armNoun();
			
			return output;
		}
		public function armsNoun():String {
			return plural(armNoun());
		}
		public function armNoun():String {
			return "arm";
		}
		public function hands(): String {
			return plural(hand());
		}
		public function hand(): String {
			var output: String = "";
			var adjective:Array = [];
			// Adjectives: 50%
			if(rand(2) == 0)
			{
				if (hasClawedHands()) adjective.push("clawed");
				if (hasPaddedHands()) adjective.push("padded");
				if (armType == GLOBAL.TYPE_FROG) adjective.push("webbed", "sticky");
				if (InCollection(armType, GLOBAL.TYPE_FELINE, GLOBAL.TYPE_BADGER, GLOBAL.TYPE_EQUINE, GLOBAL.TYPE_PANDA) || hasArmFlag(GLOBAL.FLAG_PAWS)) adjective.push("bestial");
				if (hasArmFlag(GLOBAL.FLAG_PAWS)) adjective.push("paw-like");
				if (hasArmFlag(GLOBAL.FLAG_GOOEY)) adjective.push("slimy", "slick", "gooey");
				else if (InCollection(armType, GLOBAL.TYPE_ARACHNID, GLOBAL.TYPE_DRIDER, GLOBAL.TYPE_BEE, GLOBAL.TYPE_LEITHAN)) adjective.push("chitinous");
			}
			// Build
			if (rand(2) == 0 && adjective.length > 0) output += RandomInCollection(adjective);
			//Noun
			if (output != "") output += " ";
			output += "hand";
			return output;
		}
		public function fingers(): String {
			return plural(finger());
		}
		public function finger(): String {
			var output: String = "";
			var adjective:Array = [];
			// Adjectives: 50%
			if(rand(2) == 0)
			{
				if (hasClawedHands()) adjective.push("clawed");
				if (hasPaddedHands()) adjective.push("padded");
				if (armType == GLOBAL.TYPE_FROG) adjective.push("webbed", "sticky");
				if (InCollection(armType, GLOBAL.TYPE_EQUINE)) adjective.push("hoof-tipped");
				if (hasArmFlag(GLOBAL.FLAG_GOOEY)) adjective.push("slimy", "slick", "gooey");
				else if (InCollection(armType, GLOBAL.TYPE_ARACHNID, GLOBAL.TYPE_DRIDER, GLOBAL.TYPE_BEE, GLOBAL.TYPE_LEITHAN)) adjective.push("chitinous");
			}
			// Build
			if (adjective.length > 0 && rand(2) == 0) output += RandomInCollection(adjective);
			// Noun
			if (output != "") output += " ";
			output += "finger";
			return output;
		}
		public function hasClawedHands(): Boolean {
			return InCollection(armType, GLOBAL.TYPE_CANINE, GLOBAL.TYPE_FELINE, GLOBAL.TYPE_BADGER, GLOBAL.TYPE_PANDA, GLOBAL.TYPE_LEITHAN, GLOBAL.TYPE_DEMONIC);
		}
		public function hasPaddedHands(): Boolean {
			if (hasArmFlag(GLOBAL.FLAG_PAWS)) return true;
			return InCollection(armType, GLOBAL.TYPE_KUITAN, GLOBAL.TYPE_PANDA);
		}
		public function lowerBody():String {
			var output: String = "";
			// Status
			if (isImmobilized()) output += "immobilized ";
			// Variants
			if (isGoo()) output += RandomInCollection(["gooey base", "lower half of goo", "lower body"]);
			else if (isNaga()) output += RandomInCollection(["snake-like half", "slithery lower half", "lower body"]);
			else if (isTaur()) output += RandomInCollection(["tauric half", "bestial lower half", "lower body"]);
			else if (isDrider()) output += RandomInCollection(["drider half", "arachnid lower half", "lower body"]);
			else output += "lower body";
			return output;
		}
		public function leg(forceType: Boolean = false, forceAdjective: Boolean = false, pluralAdjective: Boolean = false): String
		{
			var output: String = "";
			var adjectives:Array = [];
			//SPECIAL CASES.
			if (legType == GLOBAL.TYPE_SNAKE) return RandomInCollection(["snake tail", "snake tail", "snake tail", "snake tail", "flexible tail", "flexible tail", "coiled bottom half", "coiled bottom half", "tail", "prehensile tail"]);
			else if(legType == GLOBAL.TYPE_GOOEY && hasLegFlag(GLOBAL.FLAG_PREHENSILE)) return RandomInCollection(["goo tail", "goo tail", "gel tail", "gel tail", "flexible tail", "flexible tail", "coiled bottom half", "coiled bottom half", "tail", "prehensile tail"]);
			else if (legType == GLOBAL.TYPE_GOOEY && hasLegFlag(GLOBAL.FLAG_AMORPHOUS)) return RandomInCollection(["mound of goo", "gelatinous mound", "gooey base", "semi-solid mass"]);
			//NORMAL CASES.
			else
			{
				//Type 1/4 of the time.
				if (rand(4) == 0 || forceType)
				{
					switch (legType)
					{
						case GLOBAL.TYPE_EQUINE: adjectives = ["equine", "equine", "horse-like", "hoof-capped"]; break;
						case GLOBAL.TYPE_BOVINE: adjectives = ["bovine", "bovine", "cow-like", "hoof-capped"]; break;
						case GLOBAL.TYPE_CANINE:  adjectives = ["canine", "canine", "dog-like", "paw-footed"]; break;
						case GLOBAL.TYPE_FELINE: adjectives = ["feline", "feline", "cat-like", "graceful"]; break;
						case GLOBAL.TYPE_VULPINE: adjectives = ["vulpine", "vulpine", "fox-like", "foxy"]; break;
						case GLOBAL.TYPE_BEE: adjectives = ["chitinous", "armored", "insect-like", "carapace-covered"]; break;
						case GLOBAL.TYPE_ARACHNID: adjectives = ["chitinous", "armored", "insect-like", "carapace-covered"]; break;
						case GLOBAL.TYPE_DRIDER: adjectives = ["chitinous", "armored", "insect-like", "carapace-covered", "pointed"]; break;
						case GLOBAL.TYPE_LAPINE: adjectives = ["lapine", "lapine", "rabbit-like", "bunny"]; break;
						case GLOBAL.TYPE_AVIAN: adjectives = ["avian", "avian", "bird-like", "raptor"]; break;
						case GLOBAL.TYPE_DRACONIC: adjectives = ["draconic", "draconic", "dragon-like", "reptilian"]; break;
						case GLOBAL.TYPE_LIZAN: adjectives = ["lizan", "lizan", "reptile-like", "reptilian"]; break;
						case GLOBAL.TYPE_DEMONIC: adjectives = ["demonic", "demon-like", "demon-like", "claw-footed"]; break;
						case GLOBAL.TYPE_SUCCUBUS: adjectives = ["sensual", "alluring", "seductive", "sexy"]; break;
						case GLOBAL.TYPE_GOOEY: adjectives = ["gooey", "semi-solid", "gelatinous", "jiggly"]; break;
						case GLOBAL.TYPE_KANGAROO: adjectives = ["kangaroo-like", "kangaroo-like", "powerful", "‘roo"]; break;
						case GLOBAL.TYPE_TANUKI: adjectives = ["tanuki-like", "tanuki-like", "dexterous", "nimble"]; break;
						case GLOBAL.TYPE_DEER: adjectives = ["deer-like", "deer-like", "hooved", "nimble"]; break;
						case GLOBAL.TYPE_PANDA: adjectives = ["panda", "panda", "bear-like", "thick"]; break;
						case GLOBAL.TYPE_MLP: adjectives = ["pony", "pony-like", "cartoony", "cute"]; break;
						case GLOBAL.TYPE_RASKVEL: adjectives = ["reptilian"]; break;
						case GLOBAL.TYPE_OVIR: adjectives = ["human-like"]; break;
						case GLOBAL.TYPE_MYR: adjectives = ["chitinous", "armored", scaleColor + "-armored", "chitinous"]; break;
						case GLOBAL.TYPE_FROG: adjectives = ["frog", "amphibious", "frog-like", "powerful"]; break;
						case GLOBAL.TYPE_NYREA: adjectives = ["chitinous", "armored", "insect-like", "carapace-covered"]; break;
					}
				}
				//ADJECTIVE!
				else if (rand(3) == 0 || forceAdjective)
				{
					if (pluralAdjective && legCount > 2 && rand(2) == 0) { adjectives.push("numerous"); }
					//Coulda sworn there was a reason I didn't include these originally, but it's slipping away from me now.
					if (hasLegFlag(GLOBAL.FLAG_AMORPHOUS)) adjectives.push("amorphous", "fluid", "ever-changing");
					if (hasLegFlag(GLOBAL.FLAG_SCALED)) adjectives.push("scaled", "scaly");
					if (hasLegFlag(GLOBAL.FLAG_FURRED)) adjectives.push("furry", "fuzzy", "fur-covered");
					if (hasLegFlag(GLOBAL.FLAG_TENDRIL)) adjectives.push("wiggling", "wriggling", "tendril-like");
					if (hasLegFlag(GLOBAL.FLAG_PREHENSILE)) adjectives.push("prehensile");
					if (hasLegFlag(GLOBAL.FLAG_SMOOTH)) adjectives.push("smooth");
					if (hasLegFlag(GLOBAL.FLAG_CHITINOUS)) adjectives.push("chitinous", "armored", "carapace-covered");
					if (hasLegFlag(GLOBAL.FLAG_FEATHERED)) adjectives.push("feathered", "feathery");
					if (hasLegFlag(GLOBAL.FLAG_GOOEY) && legType != GLOBAL.TYPE_GOOEY) adjectives.push("slimy", "slick", "gooey");
					if (hasLegFlag(GLOBAL.FLAG_STICKY)) adjectives.push("sticky");
				}
				//Random goes here!
				if (adjectives.length > 0) output += RandomInCollection(adjectives) + " ";
				//NOUN IT UP BITCHES!
				output += legNoun();
			}
			return output;
		}
		
		public function legNoun():String
		{
			if (legType == GLOBAL.TYPE_SNAKE || (legType == GLOBAL.TYPE_GOOEY && hasLegFlag(GLOBAL.FLAG_PREHENSILE))) return "coil";
			if (legType == GLOBAL.TYPE_GOOEY && hasLegFlag(GLOBAL.FLAG_AMORPHOUS)) return "mound";
			return "leg";
		}
		public function legsNoun():String
		{
			return plural(legNoun());
		}
		public function footAdjectives(forceType: Boolean = false, forceAdjective: Boolean = false):String
		{
			var output: String = "";
			var adjectives:Array = [];
			//ADJECTIVE!
			if (rand(3) == 0 || forceAdjective)
			{
				if (hasLegFlag(GLOBAL.FLAG_SCALED)) adjectives.push("scaled", "scaly");
				else if (hasLegFlag(GLOBAL.FLAG_FURRED)) adjectives.push("furry", "fuzzy", "fur-covered");
				else if (hasLegFlag(GLOBAL.FLAG_TENDRIL)) adjectives.push("wiggling");
				else if (hasLegFlag(GLOBAL.FLAG_CHITINOUS)) adjectives.push("chitinous", "armored", "carapace-covered");
				//Random goes here!
				if (adjectives.length > 0) output += RandomInCollection(adjectives);
			}
			//Type! 1/5 times
			if (rand(5) == 0 || forceType)
			{
				if(output != "") output += ", ";
				if (legType == GLOBAL.TYPE_EQUINE)
					adjectives = ["equine", "horse-like", "bestial"];
				else if (legType == GLOBAL.TYPE_BOVINE)
					adjectives = ["bovine", "cow-like", "bestial"];
				else if (legType == GLOBAL.TYPE_CANINE)
					adjectives = ["canine", "dog-like"];
				else if (legType == GLOBAL.TYPE_FELINE)
					adjectives = ["feline", "cat-like"];
				else if (legType == GLOBAL.TYPE_VULPINE)
					adjectives = ["vulpine", "fox-like", "foxy"];
				else if (legType == GLOBAL.TYPE_BEE)
					adjectives = ["chitinous", "armored", "insect-like", "carapace-covered"];
				else if (legType == GLOBAL.TYPE_ARACHNID)
					adjectives = ["chitinous", "armored", "insect-like", "carapace-covered"];
				else if (legType == GLOBAL.TYPE_DRIDER)
					adjectives = ["chitinous", "armored", "insect-like", "carapace-covered", "pointed"];
				else if (legType == GLOBAL.TYPE_LAPINE)
					adjectives = ["lapine", "rabbit-like", "bunny"];
				else if (legType == GLOBAL.TYPE_AVIAN)
					adjectives = ["avian", "bird-like", "taloned"];
				else if (legType == GLOBAL.TYPE_DRACONIC)
					adjectives = ["draconic", "clawed", "reptilian"];
				else if (legType == GLOBAL.TYPE_LIZAN)
					adjectives = ["lizan", "clawed", "reptilian"];
				else if (legType == GLOBAL.TYPE_DEMONIC)
					adjectives = ["corrupted-looking", "demonic", "clawed"];
				else if (legType == GLOBAL.TYPE_SUCCUBUS)
					adjectives = ["spike-supported", "sexy"];
				else if (legType == GLOBAL.TYPE_GOOEY)
					adjectives = ["gooey", "semi-solid", "gelatinous", "jiggly"];
				else if (legType == GLOBAL.TYPE_KANGAROO)
					adjectives = ["kangaroo-like", "powerful", "‘roo"];
				else if (legType == GLOBAL.TYPE_TANUKI)
					adjectives = ["tanuki-like", "dexterous", "nimble"];
				else if (legType == GLOBAL.TYPE_DEER)
					adjectives = ["deer-like", "nimble"];
				else if (legType == GLOBAL.TYPE_PANDA)
					adjectives = ["panda", "panda", "bear-like", "thick"];
				else if (legType == GLOBAL.TYPE_MLP)
					adjectives = ["pony", "pony-like", "cartoony", "cute"];
				else if (legType == GLOBAL.TYPE_RASKVEL)
					adjectives = ["reptilian", "clawed"];
				else if (legType == GLOBAL.TYPE_OVIR)
					adjectives = ["human-like"];
				else if (legType == GLOBAL.TYPE_MYR)
					adjectives = ["chitinous", "armored", scaleColor + "-chitin"];
				else if (legType == GLOBAL.TYPE_NYREA)
					adjectives = ["chitinous", "armored", "insect-like", "carapace-covered"];
				//Random goes here!
				if (adjectives.length > 0) output += RandomInCollection(adjectives);
			}
			return output;
		}
		public function height():String
		{
			var buffer:String = "";
			buffer += Math.floor(tallness / 12) + " feet";
			if(tallness % 12 != 0) buffer += " and " + tallness % 12 + " inches";
			return buffer;
		}
		
		public function shortHeight():String
		{
			var retStr:String = "";
			retStr += Math.floor(tallness / 12) + "’";
			if (tallness % 12 > 0) retStr += " " + tallness % 12 + "”";
			return retStr;
		}
		
		public function feet(forceType: Boolean = false, forceAdjective: Boolean = false): String {
			// Plural check:
			if(legCount == 1) return foot(forceType,forceAdjective);
			
			// Default:
			var select: Number = 0;
			var output: String = "";
			output = footAdjectives(forceType, forceAdjective);
		
			//Noun
			if (output != "") output += " ";
			if (hasLegFlag(GLOBAL.FLAG_HOOVES)) output += "hooves";
			else if (hasLegFlag(GLOBAL.FLAG_PAWS) && rand(10) < 8) output += "paws";
			else if (hasLegFlag(GLOBAL.FLAG_AMORPHOUS) && legType == GLOBAL.TYPE_GOOEY) output += "cilia";
			else if (hasLegFlag(GLOBAL.FLAG_HEELS) && rand(2) == 0) output += "high-heels";
			else if (legType == GLOBAL.TYPE_LIZAN) output += "footclaws";
			else if (legType == GLOBAL.TYPE_NAGA && tallness >= 84) output += "underbelly";
			else if (legType == GLOBAL.TYPE_NAGA && tallness >= 48) output += "tails";
			else if (legType == GLOBAL.TYPE_NAGA) output += "tail-tips";
			else if (legType == GLOBAL.TYPE_FROG && rand(2) == 0) output += "webbed feet";
			else output += "feet";
			return output;
		}
		public function foot(forceType: Boolean = false, forceAdjective: Boolean = false): String {
			var select: Number = 0;
			var output: String = "";
			output = footAdjectives(forceType, forceAdjective);
			//Noun
			if (output != "") output += " ";
			if (hasLegFlag(GLOBAL.FLAG_HOOVES)) output += "hoof";
			else if (hasLegFlag(GLOBAL.FLAG_PAWS) && rand(10) < 8) output += "paw";
			else if (hasLegFlag(GLOBAL.FLAG_AMORPHOUS) && legType == GLOBAL.TYPE_GOOEY) output += "undercarriage";
			else if (hasLegFlag(GLOBAL.FLAG_HEELS) && rand(2) == 0) output += "high-heel";
			else if (legType == GLOBAL.TYPE_LIZAN) output += "footclaw";
			else if (legType == GLOBAL.TYPE_NAGA && tallness >= 84) output += "underbelly";
			else if (legType == GLOBAL.TYPE_NAGA && tallness >= 48) output += "tail";
			else if (legType == GLOBAL.TYPE_NAGA) output += "tail-tip";
			else if (legType == GLOBAL.TYPE_FROG && rand(2) == 0) output += "webbed foot";
			else output += "foot";
			return output;
		}
		public function toes(): String {
			var select: Number = 0;
			var output: String = "";
			//Noun
			if (hasLegFlag(GLOBAL.FLAG_HOOVES)) output += "hoof-tips";
			else if (hasLegFlag(GLOBAL.FLAG_PAWS) && rand(2) == 0) output += "paw-toes";
			else if (hasLegFlag(GLOBAL.FLAG_AMORPHOUS) && legType == GLOBAL.TYPE_GOOEY) output += "cilia";
			else if (hasLegFlag(GLOBAL.FLAG_HEELS) && rand(2) == 0) output += "pointed toes";
			else if (legType == GLOBAL.TYPE_LIZAN) output += "claws";
			else if (legType == GLOBAL.TYPE_FROG && rand(2) == 0) output += "webbed toes";
			else output += "toes";
			return output;
		}
		public function hasKnees():Boolean
		{
			return (hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) || hasLegFlag(GLOBAL.FLAG_PLANTIGRADE));
		}
		public function hasFeet():Boolean
		{
			return (hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) || hasLegFlag(GLOBAL.FLAG_PLANTIGRADE));
		}
		public function hasToes():Boolean
		{
			if(hasLegFlag(GLOBAL.FLAG_AMORPHOUS) || hasLegFlag(GLOBAL.FLAG_HOOVES) || legType == GLOBAL.TYPE_NAGA) return false;
			return true;
		}
		public function kneesDescript(): String 
		{
			if (hasLegFlag(GLOBAL.FLAG_AMORPHOUS) && legType == GLOBAL.TYPE_GOOEY) return "cilia";
			else if (legCount == 1) return kneeDescript();
			else return plural(kneeDescript());
		}
		public function kneeDescript(): String {
			var select: Number = 0;
			var output: String = "";
			//Noun
			if (hasLegFlag(GLOBAL.FLAG_AMORPHOUS) && legType == GLOBAL.TYPE_GOOEY) output += "cilium";
			else if (legType == GLOBAL.TYPE_NAGA) output += "trunk";
			else output += "knee";
			return output;
		}
		// Placeholder shit, sue me. Calling the ill excuse etc.
		public function bellyDescript(bForceSize:Boolean = false): String {
			var sBuilder:String = "";

			var belly:Number = bellyRating();
			//Wide fat PCs got da belly
			var toneMod:Number = thickness - tone;
			//Prevent negatives for the uberfit:
			if(toneMod < 0) toneMod = 0;
			//Worst = 100. Scale down by factor of 5
			toneMod /= 5;
			//Add to our working belly amount for funtimes:
			belly += toneMod;

			var sizeDescripts:Array = new Array();
			var pregDescripts:Array = new Array();

			//engorged, swollen, stuffed
			//cumflated only: cum-bloated (could even be wildcarded for honeycum or other things, depending on your tracking), cum-inflated, sloshing,
			if(isPregnant())
			{
				if(belly < 10) {}
				else if(belly < 20)
				{
					pregDescripts[pregDescripts.length] = "fruitful";
					pregDescripts[pregDescripts.length] = "fecund";
				}
				else
				{
					pregDescripts[pregDescripts.length] = "expectant";
					pregDescripts[pregDescripts.length] = "pregnant";
				}
				if(belly >= 50)
				{	
					pregDescripts[pregDescripts.length] = "gravid";
				}
			}
			if (belly <= 5)
			{
				if(tone >= 75)
				{
					sizeDescripts[sizeDescripts.length] = "ripped";
					sizeDescripts[sizeDescripts.length] = "chiseled";
					sizeDescripts[sizeDescripts.length] = "rock-hard";
					sizeDescripts[sizeDescripts.length] = "washboard";
					sizeDescripts[sizeDescripts.length] = "ab-lined";
					sizeDescripts[sizeDescripts.length] = "well-toned";
				}
				if(tone >= 50)
				{
					sizeDescripts[sizeDescripts.length] = "toned";
					sizeDescripts[sizeDescripts.length] = "sculpted";
				}
				else if(tone >= 30)
				{
					sizeDescripts[sizeDescripts.length] = "lightly-toned";
					sizeDescripts[sizeDescripts.length] = "tight";
				}
				if(tone < 50)
				{
					sizeDescripts[sizeDescripts.length] = "flat";
					sizeDescripts[sizeDescripts.length] = "slim";
				}
			}
			else if (belly <= 10)
			{
				sizeDescripts[sizeDescripts.length] = "soft";
				sizeDescripts[sizeDescripts.length] = "cushy";
			}
			else if (belly <= 15)
			{
				sizeDescripts[sizeDescripts.length] = "paunched";
				sizeDescripts[sizeDescripts.length] = "pudgy";
			}
			else if (belly <= 20)
			{
				sizeDescripts[sizeDescripts.length] = "large";
				sizeDescripts[sizeDescripts.length] = "hefty";
			}
			else if (belly <= 30)
			{
				sizeDescripts[sizeDescripts.length] = "considerable";
				sizeDescripts[sizeDescripts.length] = "generous";
				if(!isPregnant()) sizeDescripts[sizeDescripts.length] = "pregnant-looking";
			}
			else if (belly <= 40)
			{
				sizeDescripts[sizeDescripts.length] = "full";
				sizeDescripts[sizeDescripts.length] = "round";
				sizeDescripts[sizeDescripts.length] = "bulky";
				
			}
			else if (belly <= 50)
			{
				sizeDescripts[sizeDescripts.length] = "spacious";
				sizeDescripts[sizeDescripts.length] = "extensive";
				sizeDescripts[sizeDescripts.length] = "expansive";
			}
			else if (belly <= 60)
			{
				sizeDescripts[sizeDescripts.length] = "inflated";
				sizeDescripts[sizeDescripts.length] = "excessive";
				sizeDescripts[sizeDescripts.length] = "whopping";
				
			}
			else if (belly <= 70)
			{
				sizeDescripts[sizeDescripts.length] = "distended";
				sizeDescripts[sizeDescripts.length] = "immense";
				sizeDescripts[sizeDescripts.length] = "bloated";
			}
			else if (belly <= 80)
			{
				sizeDescripts[sizeDescripts.length] = "over-inflated";
				sizeDescripts[sizeDescripts.length] = "jumbo-sized";
			}
			else if (belly <= 90)
			{
				sizeDescripts[sizeDescripts.length] = "very distended";
				sizeDescripts[sizeDescripts.length] = "monumental";
				sizeDescripts[sizeDescripts.length] = "massive";
			}
			else
			{
				sizeDescripts[sizeDescripts.length] = "ginormous";
				sizeDescripts[sizeDescripts.length] = "over-inflated";
				sizeDescripts[sizeDescripts.length] = "blimp-like";
			}
			//Bonus pregsizes
			if(isPregnant() && belly > 50)
			{
				sizeDescripts[sizeDescripts.length] = "stuffed";
				sizeDescripts[sizeDescripts.length] = "swollen";
			}
			//Size: 50%
			if(rand(2) == 0 || bForceSize)
			{
				sBuilder += sizeDescripts[rand(sizeDescripts.length)];
				//Pregnant stuff & Size: 50% or 25% overall odds.
				if(isPregnant() && rand(2) == 0)
				{
					sBuilder += ", ";
					sBuilder += pregDescripts[rand(pregDescripts.length)] + " ";
				}
				else sBuilder += " ";
			}
			//Pregnant Stuff - 25% chance (note there's a 25% chance of occurring with belly size for 50% total)
			else if(isPregnant() && pregDescripts.length > 0 && (rand(2) == 0 || bForceSize))
			{
				sBuilder += pregDescripts[rand(pregDescripts.length)] + " ";
			}
			
			//Noun selection:
			if(belly < 10 && tone >= 40 && rand(5) == 0) sBuilder += "six pack";
			else if(belly < 10 && rand(4) == 0) sBuilder += "midriff";
			else if(belly < 20 && rand(3) == 0) sBuilder += "middle";
			else sBuilder += "belly";
			
			return sBuilder;
		}

		//Create a perk
		public function createPerk(keyName: String, value1: Number, value2: Number, value3: Number, value4: Number, desc: String = ""): void 
		{
			var newPerk:StorageClass = new StorageClass();
			newPerk.storageName = keyName;
			newPerk.value1 = value1;
			newPerk.value2 = value2;
			newPerk.value3 = value3;
			newPerk.value4 = value4;
			newPerk.tooltip = desc;
			
			perks.push(newPerk);
			
			perks.sortOn("storageName", Array.CASEINSENSITIVE);
		}
		//Create a status
		public function createStatusEffect(statusName: String, value1: Number = 0, value2: Number = 0, value3: Number = 0, value4: Number = 0, hidden: Boolean = true, iconName: String = "", tooltip: String = "", combatOnly: Boolean = false, minutesLeft: Number = 0, iconShade:uint = 0xFFFFFF): void {
			
			if (hasStatusEffect(statusName)) {
				trace("Status '" + statusName + "' already present on " + short);
				return;
			}

			var newStatusEffect:StorageClass = new StorageClass();
			newStatusEffect.storageName = statusName;
			newStatusEffect.value1 = value1;
			newStatusEffect.value2 = value2;
			newStatusEffect.value3 = value3;
			newStatusEffect.value4 = value4;
			newStatusEffect.hidden = hidden;
			newStatusEffect.iconName = iconName;
			newStatusEffect.tooltip = tooltip;
			newStatusEffect.combatOnly = combatOnly;
			newStatusEffect.minutesLeft = minutesLeft;
			newStatusEffect.iconShade = iconShade;
			
			statusEffects.push(newStatusEffect);
			
			statusEffects.sortOn("storageName", Array.CASEINSENSITIVE);

			trace("New status applied to " + short + ": " + statusName);
		}
		//Create a keyItem
		public function createKeyItem(keyName: String, value1:Number = 0, value2:Number = 0, value3:Number = 0, value4:Number = 0, description: String = ""): void {
			var newKeyItem:StorageClass = new StorageClass();
			newKeyItem.storageName = keyName;
			newKeyItem.value1 = value1;
			newKeyItem.value2 = value2;
			newKeyItem.value3 = value3;
			newKeyItem.value4 = value4;
			newKeyItem.tooltip = description;
			
			keyItems.push(newKeyItem);
			
			keyItems.sortOn("storageName", Array.CASEINSENSITIVE);
			
			trace("New key item applied to " + short + ": " + keyName);
		}
		//REMOVING THINGS!
		//status
		public function removeStatusEffect(statusName: String): void {
			removeStorageSlot(statusEffects, statusName);
		}
		//statuses
		public function removeStatuses(): void {
			removeStorage(statusEffects);
		}
		public function clearCombatStatuses(): void {
			
			//trace("Removing combat statuses.");
			if (hasStatusEffect("Sensor Link"))
			{
				removeStatusEffect("Sensor Link");
				aimMod -= 5;
			}
			if (hasStatusEffect("Gassed"))
			{
				removeStatusEffect("Gassed");
				aimMod += 5;
				reflexesMod += 5;
			}
			if (hasStatusEffect("Reduced Goo"))
			{
				removeStatusEffect("Reduced Goo");
				armor.defense += 5;
			}
			for (var x: int = statusEffects.length-1; x >= 0; x--) {
				if (statusEffects[x].combatOnly)
				{
					//trace("Removed: " + statusEffects[x].storageName + " at position " + x + ".");
					statusEffects.splice(x,1);
				}
				//else trace("Not a combat status: " + statusEffects[x].storageName + " at position " + x + ".");
			}
			
			droneTarget = null;
			concentratedFireTarget = null;
		}
		//perk
		public function removePerk(perkName: String): void {
			removeStorageSlot(perks, perkName);
		}
		//perks
		public function removePerks(): void {
			removeStorage(perks);
		}
		//key item
		public function removeKeyItem(itemName: String): void {
			removeStorageSlot(keyItems, itemName);
		}
		//key items
		public function removeKeyItems(): void {
			removeStorage(keyItems);
		}
		//remove all of a stored array
		public function removeStorage(array:Array): void {
			var counter: Number = array.length;
			while (counter > 0) {
				counter--;
				array.splice(counter, 1);
			}
		}
		//General function used by all
		public function removeStorageSlot(array:Array, storageName:String): void {
			trace("Removing storage slot...");
			var counter: Number = array.length;
			//Various Errors preventing action
			if (array.length <= 0) {
				trace("Attempted to remove storage slot " + storageName + " on " + short + " but chosen array has no members.");
				return;
			}
			while (counter > 0) {
				counter--;
				if (array[counter].storageName == storageName) {
					array.splice(counter, 1);
					trace("Removed \"" + storageName + "\" from a storage array on " + short + ".");
					counter = 0;
				}
			}
		}
		//CHECKING IF HAS A SPECIFIC STORAGE ITEM
		//Status
		public function hasStatusEffect(statusName: String): Boolean {
			return hasStorageName(statusEffects, statusName);
		}
		public function hasStatusEffectCount(statusName:String):Number
		{
			var counter: Number = statusEffects.length;
			var amount:int = 0;
			if (statusEffects.length <= 0) return 0;
			while (counter > 0) {
				counter--;
				if (statusEffects[counter].storageName == statusName) amount++;
			}
			return amount;
		}
		//Perk
		public function hasPerk(perkName: String): Boolean {
			return hasStorageName(perks, perkName);
		}
		public function hasKeyItem(keyName: String): Boolean {
			return hasStorageName(keyItems, keyName);
		}
		//General function.
		public function hasStorageName(array:Array, storageName: String): Boolean {
			var counter: Number = array.length;
			if (array.length <= 0) return false;
			while (counter > 0) {
				counter--;
				if (array[counter].storageName == storageName) return true;
			}
			return false;
		}

		//MODIFYING STORAGE VARIABLES WITH SET OR ADD.
		public function setStatusValue(storageName: String, storageValueNum: int, newValue:*):void {
			setStorageValue(statusEffects, storageName, storageValueNum, newValue);
		}
		public function getStatusMinutes(storageName: String):Number
		{
			var counter: Number = statusEffects.length;
			//Various Errors preventing action
			if (statusEffects.length <= 0) return -1;
			while (counter > 0) {
				counter--;
				//Find it, report it.
				if (statusEffects[counter].storageName == storageName) {
					return statusEffects[counter].minutesLeft;
				}
			}
			return -1;
		}
		public function hasCombatStatusEffect(storageName: String):Boolean {
			var array:Array = statusEffects;
			var counter: Number = array.length;
			if (array.length <= 0) return false;
			while (counter > 0) {
				counter--;
				if (array[counter].storageName == storageName && array[counter].combatOnly) return true;
			}
			return false;
		}
		public function setStatusMinutes(storageName: String, newMinutes:int):void
		{
			var counter: Number = statusEffects.length;
			//Various Errors preventing action
			if (statusEffects.length <= 0) return;
			while (counter > 0) {
				counter--;
				//Find it, change it, quit out
				if (statusEffects[counter].storageName == storageName) {
					if (newMinutes < 0) {
						trace("ERROR: Change storage value with invalid value for given slot or invalid slot.");
						return;
					}
					statusEffects[counter].minutesLeft = newMinutes;
					return;
				}
			}
			trace("ERROR: Looking for status '" + storageName + "' to change minutes, and " + short + " does not have the status affect.");
			return;
		}
		public function setStatusTooltip(storageName: String, newTooltip:String):void
		{
			var counter: Number = statusEffects.length;
			//Various Errors preventing action
			if (statusEffects.length <= 0) return;
			while (counter > 0) {
				counter--;
				//Find it, change it, quit out
				if (statusEffects[counter].storageName == storageName) {
					statusEffects[counter].tooltip = newTooltip;
					return;
				}
			}
			trace("ERROR: Looking for status '" + storageName + "' to change tooltip but couldn't find it.");
			return;
		}
		
		public function setStatusIconShade(storageName:String, iconShade:uint):void
		{
			for (var i:int = 0; i < statusEffects.length; i++)
			{
				if (statusEffects[i].storageName == storageName)
				{
					statusEffects[i].iconShade = iconShade;
					return;
				}
			}
			trace("ERROR: Unable to find '" + storageName +"' to update icon shade.");
		}
		
		public function addStatusMinutes(storageName: String, newMinutes:int):void
		{
			var counter: Number = statusEffects.length;
			//Various Errors preventing action
			if (statusEffects.length <= 0) return;
			while (counter > 0) {
				counter--;
				//Find it, change it, quit out
				if (statusEffects[counter].storageName == storageName) 
				{
					statusEffects[counter].minutesLeft += newMinutes;
					if (statusEffects[counter].minutesLeft < 0) {
						statusEffects[counter].minutesLeft = 0;
					}
					return;
				}
			}
			trace("ERROR: Looking for status '" + storageName + "' to add minutes, and " + short + " does not have the status affect.");
			return;
		}
		public function setKeyItemValue(storageName:String, storageValueNum:int, newValue:*):void {
			setStorageValue(keyItems, storageName, storageValueNum, newValue);
		}
		public function setPerkValue(perkName: String, perkValueNum: Number = 1, newNum: Number = 0):void {
			setStorageValue(perks, perkName, perkValueNum, newNum);
		}
		public function setPerkTooltip(perkName: String, perkTooltip: String):void
		{
			var counter: Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0) return;
			while (counter > 0) {
				counter--;
				//Find it, change it, quit out
				if (perks[counter].storageName == perkName) {
					perks[counter].tooltip = perkTooltip;
					return;
				}
			}
			trace("ERROR: Looking for status '" + perkName + "' to change value " + perkTooltip + ", and " + short + " does not have the status affect.");
			return;
		}
		public function setStorageValue(array: Array, storageName: String, storageValueNum: int, newValue:*):void {
			var counter: Number = array.length;
			//Various Errors preventing action
			if (array.length <= 0) return;
			while (counter > 0) {
				counter--;
				//Find it, change it, quit out
				if (array[counter].storageName == storageName) {
					if (storageValueNum < 1 || storageValueNum > 5 || (storageValueNum == 5 && !newValue is String) || (storageValueNum > 0 && storageValueNum < 5 && !newValue is Number)) {
						trace("ERROR: Change storage value with invalid value for given slot or invalid slot.");
						return;
					}
					if (storageValueNum == 1) array[counter].value1 = newValue;
					else if (storageValueNum == 2) array[counter].value2 = newValue;
					else if (storageValueNum == 3) array[counter].value3 = newValue;
					else if (storageValueNum == 4) array[counter].value4 = newValue;
					else if (storageValueNum == 5) array[counter].description = newValue;
					return;
				}
			}
			trace("ERROR: Looking for status '" + storageName + "' to change value " + storageValueNum + ", and " + short + " does not have the status affect.");
			return;
		}
		public function addStatusValue(statusName: String, statusValueNum:Number, newNum:Number):void {
			addStorageValue(statusEffects, statusName, statusValueNum, newNum);
		}
		public function addPerkValue(perkName: String, perkValueNum:Number, newNum:Number):void {
			addStorageValue(perks, perkName, perkValueNum, newNum);
		}
		public function addKeyValue(statusName: String, statusValueNum:Number, newNum:Number):void {
			addStorageValue(keyItems, statusName, statusValueNum, newNum);
		}
		public function addStorageValue(array:Array, storageName: String, storageValueNum:Number, newNum:Number):void {
			var counter: Number = array.length;
			//Various Errors preventing action
			if (array.length <= 0) {
				return;
				//trace("ERROR: Looking for storage '" + storageName + "' to add value " + storageValueNum + ", and " + short + " has no storage in array.");
			}
			while (counter > 0) {
				counter--;
				//Find it, change it, quit out
				if (array[counter].storageName == storageName) {
					if (storageValueNum < 1 || storageValueNum > 4) {
						trace("ERROR: AddStorageValue called with invalid status value number.");
						return;
					}
					if (storageValueNum == 1) array[counter].value1 += newNum;
					if (storageValueNum == 2) array[counter].value2 += newNum;
					if (storageValueNum == 3) array[counter].value3 += newNum;
					if (storageValueNum == 4) array[counter].value4 += newNum;
					return;
				}
			}
			trace("ERROR: Looking for status '" + storageName + "' to add value " + storageValueNum + ", and " + short + " does not have the status affect.");
			return;
		}

		private function storageValue(array:Array, storageName:String, targetValue:*): Number {
			//trace("Finding storage value.");
			if (array.length == 0) return 0;
			if (!hasStorageName(array, storageName)) return 0;
			for (var counter: int = 0; counter < array.length; counter++) {
				//trace("Loop through once");
				if (array[counter].storageName == storageName) break;
			}
			//trace("Finished Loop");
			if (targetValue == 1) return array[counter].value1;
			else if (targetValue == 2) return array[counter].value2;
			else if (targetValue == 3) return array[counter].value3;
			else if (targetValue == 4) return array[counter].value4;
			return 0;
		}
		public function statusEffectv1(statusName: String): Number {
			return storageValue(statusEffects, statusName, 1);
		}
		public function statusEffectv2(statusName: String): Number {
			return storageValue(statusEffects, statusName, 2);
		}
		public function statusEffectv3(statusName: String): Number {
			return storageValue(statusEffects, statusName, 3);
		}
		public function statusEffectv4(statusName: String): Number {
			return storageValue(statusEffects, statusName, 4);
		}
		public function perkv1(statusName: String): Number {
			return storageValue(perks, statusName, 1);
		}
		public function perkv2(statusName: String): Number {
			return storageValue(perks, statusName, 2);
		}
		public function perkv3(statusName: String): Number {
			return storageValue(perks, statusName, 3);
		}
		public function perkv4(statusName: String): Number {
			return storageValue(perks, statusName, 4);
		}
		public function keyItemv1(statusName: String): Number {
			return storageValue(keyItems, statusName, 1);
		}
		public function keyItemv2(statusName: String): Number {
			return storageValue(keyItems, statusName, 2);
		}
		public function keyItemv3(statusName: String): Number {
			return storageValue(keyItems, statusName, 3);
		}
		public function keyItemv4(statusName: String): Number {
			return storageValue(keyItems, statusName, 4);
		}

		public function getStatusEffect(statusName:String):StorageClass
		{
			for (var i:int = 0; i < statusEffects.length; i++)
			{
				if (statusEffects[i].storageName == statusName) return statusEffects[i];
			}
			
			return null;
		}

		//Grow
		public function increaseCock(increase: Number, cockNum: Number): Number {
			if (hasPerk("Big Cock")) increase *= perkv1("Big Cock");
			if (hasPerk("Phallic Potential")) increase *= 1.5;
			if (hasPerk("Phallic Restraint")) increase *= .25;
			return cocks[cockNum].growCock(increase);
		}
		//BreastCup
		public function breastCup(rowNum: Number = 0, ratingCheck: int = -1): String {
			//Error catching.
			if (ratingCheck == -1 && rowNum + 1 > breastRows.length) return "ERROR-cup";
			//Set the breastRating to be checked or the artifical ratingCheck if not -1.
			var check: int = breastRows[rowNum].breastRating();
			if (ratingCheck >= 0) check = ratingCheck;
			//Get a cup size.
			if (check < 1) return "0-cup";
			else if (check < 2) return "A-cup";
			else if (check < 3) return "B-cup";
			else if (check < 4) return "C-cup";
			else if (check < 5) return "D-cup";
			else if (check < 6) return "DD-cup";
			else if (check < 7) return "big DD-cup";
			else if (check < 8) return "E-cup";
			else if (check < 9) return "big E-cup";
			else if (check < 10) return "EE-cup";
			else if (check < 11) return "big EE-cup";
			else if (check < 12) return "F-cup";
			else if (check < 13) return "big F-cup";
			else if (check < 14) return "FF-cup";
			else if (check < 15) return "big FF-cup";
			else if (check < 16) return "G-cup";
			else if (check < 17) return "big G-cup";
			else if (check < 18) return "GG-cup";
			else if (check < 19) return "big GG-cup";
			else if (check < 20) return "H-cup";
			else if (check < 21) return "big H-cup";
			else if (check < 22) return "HH-cup";
			else if (check < 23) return "big HH-cup";
			else if (check < 24) return "HHH-cup";
			else if (check < 25) return "I-cup";
			else if (check < 26) return "big I-cup";
			else if (check < 27) return "II-cup";
			else if (check < 28) return "big II-cup";
			else if (check < 29) return "J-cup";
			else if (check < 30) return "big J-cup";
			else if (check < 31) return "JJ-cup";
			else if (check < 32) return "big JJ-cup";
			else if (check < 33) return "K-cup";
			else if (check < 34) return "big K-cup";
			else if (check < 35) return "KK-cup";
			else if (check < 36) return "big KK-cup";
			else if (check < 37) return "L-cup";
			else if (check < 38) return "big L-cup";
			else if (check < 39) return "LL-cup";
			else if (check < 40) return "big LL-cup";
			else if (check < 41) return "M-cup";
			else if (check < 42) return "big M-cup";
			else if (check < 43) return "MM-cup";
			else if (check < 44) return "big MM-cup";
			else if (check < 45) return "MMM-cup";
			else if (check < 46) return "large MMM-cup";
			else if (check < 47) return "N-cup";
			else if (check < 48) return "large N-cup";
			else if (check < 49) return "NN-cup";
			else if (check < 50) return "large NN-cup";
			else if (check < 51) return "O-cup";
			else if (check < 52) return "large O-cup";
			else if (check < 53) return "OO-cup";
			else if (check < 54) return "large OO-cup";
			else if (check < 55) return "P-cup";
			else if (check < 56) return "large P-cup";
			else if (check < 57) return "PP-cup";
			else if (check < 58) return "large PP-cup";
			else if (check < 59) return "Q-cup";
			else if (check < 60) return "large Q-cup";
			else if (check < 61) return "QQ-cup";
			else if (check < 62) return "large QQ-cup";
			else if (check < 63) return "R-cup";
			else if (check < 64) return "large R-cup";
			else if (check < 65) return "RR-cup";
			else if (check < 66) return "large RR-cup";
			else if (check < 67) return "S-cup";
			else if (check < 68) return "large S-cup";
			else if (check < 69) return "SS-cup";
			else if (check < 70) return "large SS-cup";
			else if (check < 71) return "T-cup";
			else if (check < 72) return "large T-cup";
			else if (check < 73) return "TT-cup";
			else if (check < 74) return "large TT-cup";
			else if (check < 75) return "U-cup";
			else if (check < 76) return "large U-cup";
			else if (check < 77) return "UU-cup";
			else if (check < 78) return "large UU-cup";
			else if (check < 79) return "V-cup";
			else if (check < 80) return "large V-cup";
			else if (check < 81) return "VV-cup";
			else if (check < 82) return "large VV-cup";
			else if (check < 83) return "W-cup";
			else if (check < 84) return "large W-cup";
			else if (check < 85) return "WW-cup";
			else if (check < 86) return "large WW-cup";
			else if (check < 87) return "X-cup";
			else if (check < 88) return "large X-cup";
			else if (check < 89) return "XX-cup";
			else if (check < 90) return "large XX-cup";
			else if (check < 91) return "Y-cup";
			else if (check < 92) return "large Y-cup";
			else if (check < 93) return "YY-cup";
			else if (check < 94) return "large YY-cup";
			else if (check < 95) return "Z-cup";
			else if (check < 96) return "large Z-cup";
			else if (check < 97) return "ZZ-cup";
			else if (check < 98) return "large ZZ-cup";
			else if (check < 99) return "ZZZ-cup";
			else if (check < 100) return "large ZZZ-cup";
			else if (check < 101) return "hyper A-cup";
			else if (check < 102) return "hyper B-cup";
			else if (check < 103) return "hyper C-cup";
			else if (check < 104) return "hyper D-cup";
			else if (check < 105) return "hyper DD-cup";
			else if (check < 106) return "hyper big DD-cup";
			else if (check < 107) return "hyper E-cup";
			else if (check < 108) return "hyper big E-cup";
			else if (check < 109) return "hyper EE-cup";
			else if (check < 110) return "hyper big EE-cup";
			else if (check < 111) return "hyper F-cup";
			else if (check < 112) return "hyper big F-cup";
			else if (check < 113) return "hyper FF-cup";
			else if (check < 114) return "hyper big FF-cup";
			else if (check < 115) return "hyper G-cup";
			else if (check < 116) return "hyper big G-cup";
			else if (check < 117) return "hyper GG-cup";
			else if (check < 118) return "hyper big GG-cup";
			else if (check < 119) return "hyper H-cup";
			else if (check < 120) return "hyper big H-cup";
			else if (check < 121) return "hyper HH-cup";
			else if (check < 122) return "hyper big HH-cup";
			else if (check < 123) return "hyper HHH-cup";
			else if (check < 124) return "hyper I-cup";
			else if (check < 125) return "hyper big I-cup";
			else if (check < 126) return "hyper II-cup";
			else if (check < 127) return "hyper big II-cup";
			else if (check < 128) return "hyper J-cup";
			else if (check < 129) return "hyper big J-cup";
			else if (check < 130) return "hyper JJ-cup";
			else if (check < 131) return "hyper big JJ-cup";
			else if (check < 132) return "hyper K-cup";
			else if (check < 133) return "hyper big K-cup";
			else if (check < 134) return "hyper KK-cup";
			else if (check < 135) return "hyper big KK-cup";
			else if (check < 136) return "hyper L-cup";
			else if (check < 137) return "hyper big L-cup";
			else if (check < 138) return "hyper LL-cup";
			else if (check < 139) return "hyper big LL-cup";
			else if (check < 140) return "hyper M-cup";
			else if (check < 141) return "hyper big M-cup";
			else if (check < 142) return "hyper MM-cup";
			else if (check < 143) return "hyper big MM-cup";
			else if (check < 144) return "hyper MMM-cup";
			else if (check < 145) return "hyper large MMM-cup";
			else if (check < 146) return "hyper N-cup";
			else if (check < 147) return "hyper large N-cup";
			else if (check < 148) return "hyper NN-cup";
			else if (check < 149) return "hyper large NN-cup";
			else if (check < 150) return "hyper O-cup";
			else if (check < 151) return "hyper large O-cup";
			else if (check < 152) return "hyper OO-cup";
			else if (check < 153) return "hyper large OO-cup";
			else if (check < 154) return "hyper P-cup";
			else if (check < 155) return "hyper large P-cup";
			else if (check < 156) return "hyper PP-cup";
			else if (check < 157) return "hyper large PP-cup";
			else if (check < 158) return "hyper Q-cup";
			else if (check < 159) return "hyper large Q-cup";
			else if (check < 160) return "hyper QQ-cup";
			else if (check < 161) return "hyper large QQ-cup";
			else if (check < 162) return "hyper R-cup";
			else if (check < 163) return "hyper large R-cup";
			else if (check < 164) return "hyper RR-cup";
			else if (check < 165) return "hyper large RR-cup";
			else if (check < 166) return "hyper S-cup";
			else if (check < 167) return "hyper large S-cup";
			else if (check < 168) return "hyper SS-cup";
			else if (check < 169) return "hyper large SS-cup";
			else if (check < 170) return "hyper T-cup";
			else if (check < 171) return "hyper large T-cup";
			else if (check < 172) return "hyper TT-cup";
			else if (check < 173) return "hyper large TT-cup";
			else if (check < 174) return "hyper U-cup";
			else if (check < 175) return "hyper large U-cup";
			else if (check < 176) return "hyper UU-cup";
			else if (check < 177) return "hyper large UU-cup";
			else if (check < 178) return "hyper V-cup";
			else if (check < 179) return "hyper large V-cup";
			else if (check < 180) return "hyper VV-cup";
			else if (check < 181) return "hyper large VV-cup";
			else if (check < 182) return "hyper W-cup";
			else if (check < 183) return "hyper large W-cup";
			else if (check < 184) return "hyper WW-cup";
			else if (check < 185) return "hyper large WW-cup";
			else if (check < 186) return "hyper X-cup";
			else if (check < 187) return "hyper large X-cup";
			else if (check < 188) return "hyper XX-cup";
			else if (check < 189) return "hyper large XX-cup";
			else if (check < 190) return "hyper Y-cup";
			else if (check < 191) return "hyper large Y-cup";
			else if (check < 192) return "hyper YY-cup";
			else if (check < 193) return "hyper large YY-cup";
			else if (check < 194) return "hyper Z-cup";
			else if (check < 195) return "hyper large Z-cup";
			else if (check < 196) return "hyper ZZ-cup";
			else if (check < 197) return "hyper large ZZ-cup";
			else if (check < 198) return "hyper ZZZ-cup";
			else if (check < 199) return "hyper large ZZZ-cup";
			else return "Jacques00-cup";
			return "Error-Cup (breastSize Error Number: " + check;
			//watermelon-sized
			//tent sized
			//truck sized
			//parachute sized
			//pool-sized
			//hanger-sized
			//town-sized
			//city-sized
			//state-sized
			//continent-sized
			//planet-sized
			//WTFISTHISWHYISNTITGAMEOVER?
		}
		public function bRows(): Number {
			return breastRows.length;
		}
		public function totalBreasts(): Number {
			var counter: Number = breastRows.length;
			var total: Number = 0;
			while (counter > 0) {
				counter--;
				total += breastRows[counter].breasts;
			}
			return total;
		}
		public function bRating(arg: int): Number {
			if (arg >= bRows()) return 0;
			else return breastRows[arg].breastRating();
		}
		public function bRatingRaw(arg:int):Number {
			if (arg >= bRows()) return 0;
			else return breastRows[arg].breastRatingRaw;
		}
		public function totalNipples(): Number {
			var counter: Number = breastRows.length;
			var total: Number = 0;
			while (counter > 0) {
				counter--;
				total += nipplesPerBreast * breastRows[counter].breasts;
			}
			return total;
		}
		public function totalNippleCocks():int
		{
			var count:int = 0;
			for (var i:int = 0; i < breastRows.length; i++)
			{
				if (breastRows[i].nippleType == GLOBAL.NIPPLE_TYPE_DICK)
				{
					count += nipplesPerBreast * breastRows[i].breasts;
				}
			}
			return count;
		}
		
		public function biggestTitSize(): Number {
			if (breastRows.length == 0) return -1;
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating() < breastRows[counter].breastRating()) index = counter;
			}
			return breastRows[index].breastRating();
		}
		public function smallestTitSize(): Number {
			if (breastRows.length == 0) return -1;
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating() > breastRows[counter].breastRating()) index = counter;
			}
			return breastRows[index].breastRating();
		}
		public function smallestTitRow(): Number {
			if (breastRows.length == 0) return -1;
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating() > breastRows[counter].breastRating()) index = counter;
			}
			return index;
		}
		public function biggestTitRow(): Number {
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating() < breastRows[counter].breastRating()) index = counter;
			}
			return index;
		}
		public function canTitFuck(big: Boolean = false): Boolean {
			var threshhold: int = 3;
			if (big) threshhold = 7;
			for (var x: int = 0; x < bRows(); x++) {
				if (breastRows[x].breastRating() >= threshhold && breastRows[x].breasts > 1) return true;
			}
			return false;
		}
		public function canTriboobTitFuck(big: Boolean = false): Boolean {
			var threshhold: int = 3;
			if (big) threshhold = 7;
			for (var x: int = 0; x < bRows(); x++) {
				if (breastRows[x].breastRating() >= threshhold && breastRows[x].breasts > 2) return true;
			}
			return false;
		}
		//Arg is "how many rows minimum". "big" is if target dick requires big ol jubblies.
		public function canMultiRowTitFuck(arg: Number = 2, big: Boolean = false): Boolean {
			var threshhold: int = 3;
			if (big) threshhold = 7;
			var eligibleRows: int = 0;
			for (var x: int = 0; x < bRows(); x++) {
				if (breastRows[x].breastRating() >= threshhold && breastRows[x].breasts > 1) eligibleRows++;
			}
			return (eligibleRows >= arg);
		}
		public function mostBreastsPerRow(): Number {
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts) index = counter;
			}
			return breastRows[index].breasts;
		}
		//No arg = average, otherwise ask by row.
		public function breastsPerRow(arg: int = -1): Number {
			if (arg >= 0 && arg < bRows()) {
				return breastRows[arg].breasts;
			}
			//Average!
			var av: Number = 0;
			for (var x: int = 0; x < bRows(); x++) {
				av += breastRows[x].breasts;
			}
			return Math.round((av /= bRows()) * 10) / 10;
		}
		public function averageNipplesPerBreast(): Number {
			var counter: Number = breastRows.length;
			var breasts: Number = 0;
			var nipples: Number = 0;
			while (counter > 0) {
				counter--;
				breasts += breastRows[counter].breasts;
				nipples += nipplesPerBreast * breastRows[counter].breasts;
			}
			if (breasts == 0) return 0;
			return Math.floor(nipples / breasts);
		}
		public function hasASheath(): Boolean {
			for (var x: int = 0; x < cocks.length; x++) {
				if (cocks[x].hasFlag(GLOBAL.FLAG_SHEATHED)) return true;
			}
			return false;
		}
		public function hasFullSheaths():Boolean {
			for (var x: int = 0; x < cocks.length; x++) {
				if (!cocks[x].hasFlag(GLOBAL.FLAG_SHEATHED)) return false;
			}
			return true;	
		}
		public function totalSheaths():Number
		{
			if (cocks.length <= 0) return 0;
			var total:int = 0;
			for(var x:int = 0; x < totalCocks(); x++)
			{
				if(hasSheath(x)) total++;
			}
			return total;
		}
		public function hasSheath(arg: int = 0): Boolean {
			if (arg >= cocks.length) return false;
			if (cocks[arg].hasFlag(GLOBAL.FLAG_SHEATHED)) return true;
			return false;
		}
		public function hasSheaths(arg: int = 2): Boolean {
			if (cocks.length <= 0) return false;
			var total:int = totalSheaths();
			return (total >= arg);
		}
		public function hasKnot(arg: int = 0): Boolean {
			if (arg > cockTotal() - 1 || arg < 0) 
			{
				trace("ERROR: tried to check for a knot on a penis (#" + arg + ") that doesn't exist.");
				return false;
			}
			return (cocks[arg].hasFlag(GLOBAL.FLAG_KNOTTED));
		}
		public function hasAKnot(): Boolean {
			for (var x: int = 0; x < cocks.length; x++) {
				if (cocks[x].hasFlag(GLOBAL.FLAG_KNOTTED)) return true;
			}
			return false;
		}
		public function totalKnots():Number
		{
			if (cocks.length <= 0) return 0;
			var total:int = 0;
			for(var x:int = 0; x < totalCocks(); x++)
			{
				if(hasKnot(x)) total++;
			}
			return total;
		}
		public function knotThickness(arg:int = 0):Number
		{
			if(arg < 0 || arg >= cockTotal()) return 0;
			return cocks[arg].thickness() * cocks[arg].knotMultiplier;
		}
		public function hasCockFlag(arg: int = 0, cockNum: int = 0): Boolean {
			if (cockNum > cockTotal() - 1 || cockNum < 0) return false;
			return (cocks[cockNum].hasFlag(arg));
		}
		public function hasACockFlag(arg:int = 0): Boolean {
			for (var x: int = 0; x < cocks.length; x++) {
				if (cocks[x].hasFlag(arg)) return true;
			}
			return false;
		}
		public function cockVolume(cockNum: Number, effective: Boolean = true): Number {
			if (cockNum >= cocks.length || cockNum < 0) return 0;
			if (effective) return (cocks[cockNum].effectiveVolume());
			else return (cocks[cockNum].volume());
		}
		public function cockTailVolume(effective: Boolean = true): Number {
			return tailCockVolume(effective);
		}
		public function tailCockVolume(effective: Boolean = true): Number {
			//Abstract size as a cylinder + half sphere for the tip.
			var cylinder: Number = Math.PI * 1.5 / 2 * 1.5 / 2 * (8 - 1.5);
			var tip: Number = (4 / 3 * Math.PI * 1.5 / 2 * 1.5 / 2 * 1.5 / 2) / 2;
			//If blunt, tip is converted to cylinder as well.
			if (tailGenitalArg == GLOBAL.TYPE_EQUINE) tip = (Math.PI * 1.5 / 2 * 1.5 / 2 * 1.5);
			//If flared, tip is multiplied by 1.3.
			if (tailGenitalArg == GLOBAL.TYPE_EQUINE) tip = tip * 1.3;
			//If tapered, reduce total by a factor of 75%
			if (tailGenitalArg == GLOBAL.TYPE_CANINE) {
				tip = tip * .75;
				cylinder = cylinder * .75;
			}
			var temp: Number = Math.round((tip + cylinder) * 100) / 100;
			if (effective) {
				//if(hasTailFlag(GLOBAL.FLAG_LUBRICATED)) temp *= .75;
				//if(hasTailFlag(GLOBAL.FLAG_STICKY)) temp *= 1.25;
			}
			return Math.round(temp * 100) / 100;
		}
		public function nippleCockVolume(effective: Boolean = true): Number {
			return dickNippleVolume(effective);
		}
		public function dickNippleVolume(effective: Boolean = true): Number {
			//Get length and width.
			var l: Number = nippleLength(0) * dickNippleMultiplier;
			var w: Number;
			if (l <= 10) w = l / 6;
			else if (l <= 30) w = (l - 10) / 10 + 10 / 6;
			else w = 20 / 10 + 10 / 6 + (l - 30) / 20;
			//Convert Width to radius
			var radius:Number = w/2;

			//Abstract size as a cylinder + half sphere for the tip.
			var cylinder: Number = Math.PI * radius * radius * (l - w);
			var tip: Number = (4 / 3 * Math.PI * radius * radius * radius) / 2;
			//If blunt, tip is converted to cylinder as well.
			if (tailGenitalArg == GLOBAL.TYPE_EQUINE) tip = (Math.PI * radius * radius * w);
			//If flared, tip is multiplied by 1.3.
			if (tailGenitalArg == GLOBAL.TYPE_EQUINE) tip = tip * 1.3;
			//If tapered, reduce total by a factor of 75%
			if (tailGenitalArg == GLOBAL.TYPE_CANINE) {
				tip = tip * .75;
				cylinder = cylinder * .75;
			}
			var temp: Number = Math.round((tip + cylinder) * 100) / 100;
			return Math.round(temp * 100) / 100;
		}

		public function biggestCockLength(): Number {
			if (cocks.length == 0) return 0;
			return cocks[biggestCockIndex()].cLength();
		}
		public function biggestCockThickness(): Number {
			if (cocks.length == 0) return 0;
			return cocks[biggestCockIndex()].thickness();
		}
		public function biggestCockVolume(effective: Boolean = true): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) < cockVolume(counter, effective)) index = counter;
			}
			return cockVolume(index, effective);
		}
		//Find the second biggest dick and it's area.
		public function biggestCockVolume2(effective: Boolean = true): Number {
			if (cocks.length <= 1) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			var index2: Number = -1;
			//Find the biggest
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) < cockVolume(counter, effective)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0) {
				counter--;
				//Is this spot claimed by the biggest?
				if (counter != index) {
					//Not set yet?
					if (index2 == -1) index2 = counter;
					//Is the stored value less than the current one?
					if (cockVolume(index2, effective) < cockVolume(counter, effective)) {
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2) return 0;
			return cockVolume(index2, effective);
		}
		public function longestCockIndex(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].cLength() < cocks[counter].cLength()) index = counter;
			}
			return index;
		}
		public function longestCockLength(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].cLength() < cocks[counter].cLength()) index = counter;
			}
			return cocks[index].cLength();
		}
		public function longestHorsecockLength(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if ((cocks[index].cType != GLOBAL.TYPE_EQUINE && cocks[counter].cType == GLOBAL.TYPE_EQUINE) || (cocks[index].cLength < cocks[counter].cLength() && cocks[counter].cType == GLOBAL.TYPE_EQUINE)) index = counter;
			}
			return cocks[index].cLength();
		}
		public function totalcThickness(): Number {
			var thick: Number = 0;
			var counter: Number = cocks.length;
			while (counter > 0) {
				counter--;
				thick += cocks[counter].thickness();
			}
			return thick;
		}
		public function cThickness(arg:int = 0):Number
		{
			if(arg >= cocks.length) return -1;
			if(arg < 0) return -1;
			return cocks[arg].thickness();
		}
		public function cLength(arg:int = 0, dynamicLength:Boolean = false):Number
		{
			if(arg >= cocks.length) return -1;
			if(arg < 0) return -1;
			if (dynamicLength) return cLengthFlaccid(arg, true);
			return cocks[arg].cLength();
		}
		public function cLengthFlaccid(arg:int = 0, dynamicLength:Boolean = false): Number
		{
			if(arg >= cocks.length) return -1;
			if(arg < 0) return -1;
			if (dynamicLength)
			{
				var lustRatio: Number = ((lust() - lustMin()) / (lustMax() - lustMin())); // no permaboner for characters with min lust
				lustRatio = Math.max(Math.min(lustRatio, 1), 0); // To avoid length out of bounds
				lustRatio = Math.pow(lustRatio, 2); // parabolic function to avoid notable boner on low lust
				return (cocks[arg].cLengthFlaccid() + ((cocks[arg].cLength() - cocks[arg].cLengthFlaccid()) * lustRatio));
			}
			return cocks[arg].cLengthFlaccid();
		}
		public function thickestCock(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].thickness() < cocks[counter].thickness()) index = counter;
			}
			return index;
		}
		public function totalGirth(): Number {
			if (cocks.length == 0) return 0;
			var counter: int = 0;
			for (var x: int = 0; x < cocks.length; x++) {
				counter += cocks[x].cLength();
			}
			return counter;
		}
		public function thickestCockThickness(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].thickness() < cocks[counter].thickness()) index = counter;
			}
			return cocks[index].thickness();
		}
		public function thinnestCockIndex(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].thickness() > cocks[counter].thickness()) index = counter;
			}
			return index;
		}
		public function thinnestCockRatioIndex(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].cThicknessRatio() > cocks[counter].cThicknessRatio()) index = counter;
			}
			return index;
		}
		public function smallestCockVolume(effective: Boolean = true): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) > cockVolume(counter, effective)) index = counter;
			}
			return cockVolume(index, effective);
		}
		public function smallestCockIndex(effective: Boolean = true): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) > cockVolume(counter, effective)) {
					index = counter;
				}
			}
			return index;
		}
		public function smallestCockLength(): Number {
			if (cocks.length == 0) return 0;
			return cocks[smallestCockIndex()].cLength();
		}
		public function shortestCockIndex(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].cLength() > cocks[counter].cLength()) index = counter;
			}
			return index;
		}
		public function shortestCockLength(): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cocks[index].cLength() > cocks[counter].cLength()) index = counter;
			}
			return cocks[index].cLength();
		}
		/**
		 * Find the biggest cock that fits inside a given value.
		 * @param	fits maximal target capacity.
		 * @param	type "area" (effective volume, actually) or "length".
		 * @return index of largest fitting cock or -1 if no appropriate found.
		 */
		public function cockThatFits(fits: Number = 0, type: String = "area"): Number {
			trace("Fits value: " + fits);
			if (cocks.length <= 0) return -1;
			var counter: Number = cocks.length;
			//Current largest fitter
			var index: Number = -1;
			while (counter > 0) {
				counter--;
				if (type == "area") {
					if (cockVolume(counter, true) <= fits) {
						//If one already fits
						if (index >= 0) {
							//See if the newcomer beats the saved small guy
							if (cockVolume(counter, true) > cockVolume(index, true))
								index = counter;
						}
						//Store the index of fitting dick
						else index = counter;
					}
				} else if (type == "length") {
					if (cocks[counter].cLength() <= fits) {
						//If one already fits
						if (index >= 0) {
							//See if the newcomer beats the saved small guy
							if (cockVolume(counter, true) > cockVolume(index, true)) {
								index = counter;
							}
						}
						//Store the index of fitting dick
						else index = counter;
					}
				}
			}
			return index;
		}
		//Find the 2nd biggest cock that fits inside a given value
		public function cockThatFits2(fits: Number = 0): Number {
			if (cockTotal() == 1) return -1;
			var counter: Number = cocks.length;
			//Current largest fitter
			var index: Number = -1;
			var index2: Number = -1;
			while (counter > 0) {
				counter--;
				//Does this one fit?
				if (cockVolume(counter, true) <= fits) {
					//If one already fits
					if (index >= 0) {
						//See if the newcomer beats the saved small guy
						if (cockVolume(counter, true) > cockVolume(index, true)) {
							//Save old wang
							if (index != -1) index2 = index;
							index = counter;
						}
						//If this one fits and is smaller than the other great
						else {
							if ((cockVolume(index2, true) < cockVolume(counter, true)) && counter != index) {
								index2 = counter;
							}
						}
						if (index >= 0 && index == index2) trace("FUCK ERROR COCKTHATFITS2 SHIT IS BROKED!");
					}
					//Store the index of fitting dick
					else index = counter;
				}
			}
			return index2;
		}
		public function smallestCockArea(effective: Boolean = true): Number {
			if (cockTotal() == 0) return -1;
			return cockVolume(smallestCockIndex(), effective);
		}
		public function smallestCock(effective: Boolean = true): Number {
			return cockVolume(smallestCockIndex(), effective);
		}
		public function biggestCockIndex(effective: Boolean = true): Number {
			if (cocks.length == 0) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) < cockVolume(counter, effective)) index = counter;
			}
			return index;
		}
		//Find the second biggest dick's index.
		public function biggestCockIndex2(effective: Boolean = true): Number {
			if (cocks.length <= 1) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			var index2: Number = 0;
			//Find the biggest
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) < cockVolume(counter, effective)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0) {
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index) index2 = counter;
				//Is the stored value less than the current one?
				if (cockVolume(index2, effective) < cockVolume(counter, effective)) {
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index) index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2) return 0;
			return index2;
		}
		public function smallestCockIndex2(effective: Boolean = true): Number {
			if (cocks.length <= 1) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			var index2: Number = 0;
			//Find the smallest
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) > cockVolume(counter, effective)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0) {
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index) index2 = counter;
				//Is the stored value less than the current one?
				if (cockVolume(index2, effective) > cockVolume(counter, effective)) {
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index) index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2) return 0;
			return index2;
		}
		//Find the third biggest dick index.
		public function biggestCockIndex3(effective: Boolean = true): Number {
			if (cocks.length <= 2) return 0;
			var counter: Number = cocks.length;
			var index: Number = 0;
			var index2: Number = -1;
			var index3: Number = -1;
			//Find the biggest
			while (counter > 0) {
				counter--;
				if (cockVolume(index, effective) < cockVolume(counter, effective)) index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0) {
				counter--;
				//If this index isn't used already
				if (counter != index) {
					//Has index been set to anything yet?
					if (index2 == -1) index2 = counter;
					//Is the stored value less than the current one?
					else if (cockVolume(index2, effective) < cockVolume(counter, effective)) {
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2 || index2 == -1) index2 = 0;
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0) {
				counter--;
				//If this index isn't used already
				if (counter != index && counter != index2) {
					//Has index been set to anything yet?
					if (index3 == -1) index3 = counter;
					//Is the stored value less than the current one?
					else if (cockVolume(index3, effective) < cockVolume(counter, effective)) {
						index3 = counter;
					}
				}
			}
			//If it fails for some reason.
			if (index3 == -1) index3 = 0;
			return index3;
		}
		protected function rand(max: Number): Number {
			return int(Math.random() * max);
		}
		public function wetness(arg: int = 0): Number {
			//If the player has no vaginas
			if (vaginas.length == 0 || arg >= vaginas.length) return 0;
			return vaginas[arg].wetness();
		}
		public function looseness(arg: int = 0): Number {
			//If the player has no vaginas
			if (vaginas.length == 0 || arg >= vaginas.length) return 0;
			return vaginas[arg].looseness();
		}
		public function lowestWetness(index:Boolean = false): Number {
			//If the player has no vaginas
			if (vaginas.length == 0) return 0;
			var wet:int = -1;
			for(var x:int = 0; x < vaginas.length; x++)
			{
				if(wet == -1) wet = x;
				if(vaginas[x].wetness < vaginas[wet].wetness) wet = x;
			}
			if(index) return wet;
			else return vaginas[wet].wetness;
		}
		public function lowestWetnessIndex():Number
		{
			return lowestWetness(true);
		}
		public function highestWetness(index:Boolean = false): Number {
			//If the player has no vaginas
			if (vaginas.length == 0) return 0;
			var wet:int = -1;
			for(var x:int = 0; x < vaginas.length; x++)
			{
				if(wet == -1) wet = x;
				if(vaginas[x].wetness > vaginas[wet].wetness) wet = x;
			}
			if(index) return wet;
			else return vaginas[wet].wetness;
		}
		public function highestWetnessIndex():Number
		{
			return highestWetness(true);
		}
		public function vaginalCapacity(arg: int = 0): Number {
			//If the player has no vaginas
			if (vaginas.length == 0) return 0;
			var amount:Number = vaginas[arg].capacity() * elasticity;
			if(isTaur()) amount += 400;
			return amount;
		}
		public function smallestVaginalCapacity(): Number {
			return vaginalCapacity(smallestVaginaIndex());
		}
		public function biggestVaginalCapacity(): Number {
			return vaginalCapacity(biggestVaginaIndex());
		}
		public function gapestVaginaLooseness(): Number {
			var counter: Number = vaginas.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (vaginas[index].looseness() < vaginas[counter].looseness()) index = counter;
			}
			return vaginas[counter].looseness();
		}
		public function tightestVaginalLooseness():Number
		{
			if (vaginas.length == 0) return -1;
			
			var vIdx:int = -1;
			
			for (var i:int = 0; i < vaginas.length; i++)
			{
				if (vIdx == -1) vIdx = 0;
				else
				{
					if (vaginas[i].looseness() < vaginas[vIdx].looseness()) vIdx = i;
				}
			}
			
			return vaginas[vIdx].looseness();
		}
		public function wettestVaginalWetness(): Number {
			var counter: Number = vaginas.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (vaginas[index].wetness() < vaginas[counter].wetness()) index = counter;
			}
			return vaginas[counter].wetness();
		}
		public function driestVaginalWetness(): Number {
			if(!hasVagina()) return -1;
			var counter: Number = vaginas.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (vaginas[index].wetness() > vaginas[counter].wetness()) index = counter;
			}
			return vaginas[counter].wetness();
		}
		public function biggestVaginaIndex(): int {
			if (vaginas.length == 0) return 0;
			var counter: Number = vaginas.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (vaginalCapacity(index) < vaginalCapacity(counter)) index = counter;
			}
			return index;
		}
		public function smallestVaginaIndex(): int {
			if (vaginas.length == 0) return 0;
			var counter: Number = vaginas.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (vaginalCapacity(index) > vaginalCapacity(counter)) index = counter;
			}
			return index;
		}
		//Find the biggest cock that fits inside a given value
		public function cuntThatFits(fits: Number = 0): Number {
			if (vaginas.length <= 0) return -1;
			var counter: Number = vaginas.length;
			//Current largest fitter
			var index: Number = -1;
			while (counter > 0) {
				counter--;

				if (vaginalCapacity(counter) >= fits) {
					//If one already fits
					if (index >= 0) {
						//See if the newcomer beats the saved small guy
						if (vaginalCapacity(counter) < vaginalCapacity(index)) {
							index = counter;
						}
					}
					//Store the index of fitting dick
					else index = counter;
				}
			}
			return index;
		}
		public function analCapacity(): Number {
			return ass.capacity() * elasticity;
		}
		//Goddamnit Savin
		public function cockCapacity(x:int = -1): Number
		{
			if(!hasCock()) return 0;
			if (x >= cocks.length || x < 0) return 0;
			return (cocks[x].volume() / 6 * elasticity);

		}
		public function hasTentacleNipples():Boolean {
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[counter].nippleType == GLOBAL.NIPPLE_TYPE_TENTACLED) return true;
			}
			return false;
		}
		public function hasCuntNipples(): Boolean {
			var counter: Number = breastRows.length;
			while (counter > 0) {
				counter--;
				if (breastRows[counter].nippleType == GLOBAL.NIPPLE_TYPE_FUCKABLE) return true;
			}
			return false;
		}
		public function hasFuckableNipples(): Boolean {
			var counter: Number = breastRows.length;
			while (counter > 0) {
				counter--;
				if (breastRows[counter].fuckable()) return true;
			}
			return false;
		}
		public function hasLipples(): Boolean {
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[counter].nippleType == GLOBAL.NIPPLE_TYPE_LIPPLES) index = counter;
			}
			if (breastRows[index].nippleType == GLOBAL.NIPPLE_TYPE_LIPPLES) return true;
			return false;
		}
		public function hasDickNipples(): Boolean {
			//trace("THIS FUNCTION IS THE REASON THEY INVENTED AIDS. WHRYYYYYYYYYY!!!!!!!!!!!!!1111one!");
			return hasNippleCocks();
		}
		public function hasNippleCocks(): Boolean {
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[counter].nippleType == GLOBAL.NIPPLE_TYPE_DICK) return true;
			}
			return false;
		}

		public function hasInvertedNipples(): Boolean
		{
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[counter].nippleType == GLOBAL.NIPPLE_TYPE_INVERTED) return true;
			}
			return false;
		}
		public function hasFlatNipples(): Boolean {
			var counter: Number = breastRows.length;
			var index: Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[counter].nippleType == GLOBAL.NIPPLE_TYPE_FLAT) return true;
			}
			return false;
		}
		public function hasBreasts(): Boolean {
			if (breastRows.length > 0) {
				if (biggestTitSize() >= 1) return true;
			}
			return false;
		}
		public function hasPiercedNipples():Boolean
		{
			return false;
		}
		public function hasPiercedCocks():Boolean
		{
			return false;
		}
		public function hasPiercedVaginas():Boolean
		{
			return false;
		}
		public function hasNipples(): Boolean {
			if(nipplesPerBreast > 0) return true;
			return false;
		}
		public function canLactate():Boolean
		{
			if(!hasNipples()) return false;
			//PC has reached lactation threshold!
			if(milkMultiplier > 50 || milkFullness >= 50) return true;
			return false;
		}
		public function isLactating(): Boolean {
			//PC can't be lactating unless they canLactate!
			if(canLactate())
			{
				//Is there enough milk in yer tits for lactation?
				if(milkFullness >= 10 || milkQ() >= 1000)
				{
					//yes? true!
					return true;
				}
			}
			//Didn't proc any trues? Not lactating.
			return false;
		}
		public function canMilkSquirt():Boolean
		{
			if(milkFullness >= 80) return true;
			return false;
		}
		public function isMilkTank():Boolean
		{
			//Check for infinite lactation perks!
			if(hasPerk("Honeypot")) return true;
			if(hasPerk("Milky") && hasPerk("Treated Milk")) return true;
			return false;
		}
		public function milkProduced(minutes: Number): Number {
			if(!canLactate()) return 0;
			//How many mLs produced?
			var mLsGained:Number = 1.73 * milkRate/10 * minutes;
			//Factor in current milkMultiplier
			mLsGained *= (milkMultiplier)/100;
			//Great. Now figure out how much fullness that adds.
			var fullnessDelta:Number = mLsGained / milkCapacity() * 100;
			
			//75% fullness notification
			if(!InCollection(milkType, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK) && milkFullness < 75 && milkFullness + fullnessDelta >= 75) createStatusEffect("Pending Gain Milk Note: 75");
			//100% notification!
			if(!InCollection(milkType, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK) && milkFullness < 100 && milkFullness + fullnessDelta >= 100) createStatusEffect("Pending Gain Milk Note: 100");

			//If we're going above 100.
			if(fullnessDelta + milkFullness > 100)
			{
				//Vanae milk just caps at 100.
				if(InCollection(milkType, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK)) milkFullness = 100;
				else
				{
					//If we start below 100, do that normally first
					if(milkFullness < 100)
					{
						var subHundredFullness:Number = 100 - milkFullness;
						milkFullness = 100;
						fullnessDelta -= subHundredFullness;
					}
					//150%
					if(milkFullness < 150 && milkFullness + fullnessDelta/2 >= 150) createStatusEffect("Pending Gain Milk Note: 150");
					//200%
					if(milkFullness < 200 && milkFullness + fullnessDelta/2 >= 200) createStatusEffect("Pending Gain Milk Note: 200");
					//Grow at half rate since we're over 100
					milkFullness += fullnessDelta/2;
				}
			}

			//Not going above 100? Just add it
			else milkFullness += fullnessDelta;

			//Just check to make sure there's a cap for top end and bottom end
			if(milkFullness > 200) milkFullness = 200;
			else if(milkFullness < 0) {
				//trace("ERROR: Flash sucks dicks at math and somehow got a negative milk fullness.");
				milkFullness = 0;
			}
			//trace("Breast milk produced: " + mLsGained + ", Fullness: " + milkFullness + " Total mLs Held: " + milkQ(99) + ", Max mLs: " + milkCapacity() + " Delta: " + fullnessDelta);
			return mLsGained;
		}
		public function milkCapacity(arg:int = -1):Number
		{
			//400mLs + breastRating/2*100
			var capacity:Number = 0;
			//if arg == -1, mLs produced by biggest row.
			if(arg == -1)
			{
				capacity = (400 + (breastRows[biggestTitRow()].breastRatingRaw + breastRows[biggestTitRow()].breastRatingHoneypotMod) / 2 * 100) * milkStorageMultiplier;
			}
			//if arg == 99, total mLs produced by all rows
			else if(arg == 99)
			{
				//Total it up!
				for(var x:int = 0; x < breastRows.length; x++)
				{
					capacity += (400 + (breastRows[x].breastRatingRaw + breastRows[x].breastRatingHoneypotMod)/ 2 * 100);
				}
				capacity *= milkStorageMultiplier;
			}
			//otherwise, mLs produced by arg # row.
			else
			{
				if(arg < 0 || arg >= breastRows.length) return 0;
				else capacity = (400 + (breastRows[arg].breastRatingRaw + breastRows[arg].breastRatingHoneypotMod)/ 2 * 100) * milkStorageMultiplier;
			}
			return capacity;
		}
		public function milkQ(arg:int = -1):Number {
			return lactationQ(arg);
		}
		public function lactationQ(arg:int = -1): Number {
			var total:Number = 0;
			//So much easier now - just a quick lookup.
			//Arg -1 = amount from biggest tits.
			if(arg == -1) return milkFullness/100 * milkCapacity();
			//Arg 99 = amount from all tits
			else if(arg == 99)
			{
				//Total it up!
				for(var x:int = 0; x < breastRows.length; x++)
				{
					//trace("Row " + x + " mLs: " + (milkFullness * milkCapacity(x)));
					total += milkFullness/100 * milkCapacity(x);
				}
				//trace("MilkQ total: " + total);
				return total;
			}
			//Specific row
			else
			{
				if(arg < 0 || arg >= breastRows.length) return 0;
				else return milkFullness/100 * milkCapacity(arg);
			}
			//Failsafe:
			return 0;
		}
		public function boostCum(amount:Number = 1):void
		{
			var total:* = amount;
			//Loop through one at a time!
			while(total > 0)
			{
				total--;
				amount = 1;
			
				if(cumMultiplierRaw > 10) amount /= 2;
				if(cumMultiplierRaw > 50) amount /= 2;
				if(cumMultiplierRaw > 100) amount /= 2;

				//Efficiency is always 3x Multiplier
				ballEfficiency += amount * 3;
				cumMultiplierRaw += amount;
				//Boost efficiency more if behind
				if(cumMultiplierRaw* 3 > ballEfficiency)
				{
					ballEfficiency += amount * 2;
					if(cumMultiplierRaw* 3 > ballEfficiency) ballEfficiency += amount * 2;
				}
				//Boost multiplier if way too low.
				else if(cumMultiplierRaw * 4 < ballEfficiency)
				{
					cumMultiplierRaw += amount;
					if(cumMultiplierRaw * 4 < ballEfficiency) cumMultiplierRaw += amount;
				}
			}
		}
		public function boostLactation(amount:Number = 1):void
		{
			//Record this for tracking change
			var originalMultiplier:* = milkMultiplier;
			//If below 100...
			if(milkMultiplier < 100) {
				//If we cross 100 threshold, set to 100 & go for slow grow.
				if(milkMultiplier + amount > 100) 
				{
					amount = 100 - milkMultiplier;
					milkMultiplier = 100;
				}
				//Otherwise add it up and zero out amount.
				else {
					milkMultiplier += amount;
					amount = 0;
				}
			}
			//Milk multiplier is over 100... slow gro.
			if(amount > 0)
			{
				if(milkMultiplier < 110) milkMultiplier += amount/5;
				else if(milkMultiplier < 125) milkMultiplier += amount/10;
			}
			//Queue threshold notes!
			if(originalMultiplier < 30 && milkMultiplier >= 30) createStatusEffect("Pending Gain MilkMultiplier Note: 30");
			if(originalMultiplier < 40 && milkMultiplier >= 40) createStatusEffect("Pending Gain MilkMultiplier Note: 40");
			if(originalMultiplier < 50 && milkMultiplier >= 50) createStatusEffect("Pending Gain MilkMultiplier Note: 50");
			if(originalMultiplier < 60 && milkMultiplier >= 60) createStatusEffect("Pending Gain MilkMultiplier Note: 60");
			if(originalMultiplier < 70 && milkMultiplier >= 70) createStatusEffect("Pending Gain MilkMultiplier Note: 70");
			if(originalMultiplier < 80 && milkMultiplier >= 80) createStatusEffect("Pending Gain MilkMultiplier Note: 80");
			if(originalMultiplier < 90 && milkMultiplier >= 90) createStatusEffect("Pending Gain MilkMultiplier Note: 90");
			if(originalMultiplier < 100 && milkMultiplier >= 100) createStatusEffect("Pending Gain MilkMultiplier Note: 100");
			if(originalMultiplier < 110 && milkMultiplier >= 110) createStatusEffect("Pending Gain MilkMultiplier Note: 110");
			if(originalMultiplier < 125 && milkMultiplier >= 125) createStatusEffect("Pending Gain MilkMultiplier Note: 125");
		}
		//PC has been milked for "amount" fullness.
		public function milked(amount:Number = 50):Number
		{
			var x:int;
			if(hasPerk("Milky")) amount *= 1.5;
			//Boost lactation by a relevant amount
			if(milkMultiplier < 125) boostLactation(1 + Math.round(amount/50));
			//Actually reduce held milk
			milkFullness -= amount;
			//Set boob swelling to new appropriate tier
			//trace("Milk fullness: " + milkFullness);
			if(milkFullness < 0) milkFullness = 0;
			//Honeypot reduction!
			for(var bb:int = 0; bb < bRows(); bb++)
			{
				breastRows[bb].breastRatingHoneypotMod = 0;
			}
			setBoobSwelling();
			return milkFullness;
		}
		public function setBoobSwelling():void
		{
			var x:int;
			//No swelling!
			if(milkFullness < 75) 
			{
				//Reset swelling
				for(x = 0; x < bRows(); x++)
				{
					breastRows[x].breastRatingLactationMod = 0;
				}
			}
			//75 - 99
			else if(milkFullness < 100)
			{
				for(x = 0; x < bRows(); x++)
				{
					if(breastRows[x].breastRatingRaw >= 5) breastRows[x].breastRatingLactationMod = 1.5;
					else breastRows[x].breastRatingLactationMod = 1;
				}
			}
			//100 - 149
			else if(milkFullness < 150)
			{
				for(x = 0; x < bRows(); x++)
				{
					if(breastRows[x].breastRatingRaw >= 5) breastRows[x].breastRatingLactationMod = 2.5;
					else breastRows[x].breastRatingLactationMod = 1.5;
				}	
			}
			else if(milkFullness < 200)
			{
				for(x = 0; x < bRows(); x++)
				{
					if(breastRows[x].breastRatingRaw >= 5) breastRows[x].breastRatingLactationMod = 3.5;
					else breastRows[x].breastRatingLactationMod = 2;
				}
			}
			else
			{
				for(x = 0; x < bRows(); x++)
				{
					if(breastRows[x].breastRatingRaw >= 5) breastRows[x].breastRatingLactationMod = 4.5;
					else breastRows[x].breastRatingLactationMod = 3;
				}
			}
		}
		//Body Type
		public function bodyType(): String {
			var desc: String = "";
			//SUPAH THIN
			if (thickness < 10) {
				//SUPAH BUFF
				if (tone > 90) desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75) desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50) desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25) desc += "a lithe body and only a little bit of muscle definition";
				else desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25) {
				if (tone > 90) desc += "a thin body and incredible muscle definition";
				else if (tone > 75) desc += "a narrow frame that shows off your muscles";
				else if (tone > 50) desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25) desc += "a narrow, soft body that still manages to show off a few muscles";
				else desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40) {
				if (tone > 90) desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75) desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50) desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25) desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60) {
				if (tone > 90) desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75) desc += "an average-sized frame and great musculature";
				else if (tone > 50) desc += "a normal waistline and decently visible muscles";
				else if (tone > 25) desc += "an average body and soft, unremarkable flesh";
				else desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			} else if (thickness < 75) {
				if (tone > 90) desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75) desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50) desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25) desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else desc += "a soft, plush body with plenty of jiggle";
			} else if (thickness < 90) {
				if (tone > 90) desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75) desc += "a burly form and plenty of muscle definition";
				else if (tone > 50) desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25) desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else {
					desc += "a wide, cushiony body";
					if (hasVagina() || biggestTitSize() > 3 || hipRating() > 7 || buttRating() > 7) desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else {
				if (tone > 90) desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75) desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50) desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25) {
					desc += "a very wide body";
					if (hasVagina() || biggestTitSize() > 4 || hipRating() > 10 || buttRating() > 10) desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				} else {
					desc += "a thick";
					if (hasVagina() || biggestTitSize() > 4 || hipRating() > 10 || buttRating() > 10) desc += ", voluptuous";
					desc += " body and plush, ";
					if (hasVagina() || biggestTitSize() > 4 || hipRating() > 10 || buttRating() > 10) desc += " jiggly curves";
					else desc += " soft flesh";
				}
			}
			return desc;
		}
		
		public var cumMultiplierRaw:Number = 1;
		public var cumMultiplierMod:Number = 0;
		public function cumMultiplier():Number
		{
			var multi:Number = cumMultiplierRaw + cumMultiplierMod;
			var bonus:Number = perkv1("Potent");
			multi += bonus;
			if (multi < 0) return 0;
			return multi;
		}
		
		//Calculate cum return
		public function cumQ(): Number {
			if (!hasCock()) return 0;
			var quantity: Number = 0;
			//lust - 50% = normal output. 0 = 75%. 100 = +125% output.
			var lustCoefficient: Number = ((lust() / 2) + 75) / 100;
			quantity = cumMultiplier() * lustCoefficient * maxCum() / ballEfficiency;
			//Rut means bigger, ball-draining orgasms.
			quantity += statusEffectv1("Rut");
			if (quantity > currentCum()) quantity = currentCum();
			//Round dat shit.
			quantity = Math.round(quantity / 10) * 10;
			if (quantity < 2) quantity = 2;
			//Super high refractory raises minimum.
			if (refractoryRate >= 3 && quantity < 15) quantity = 15;
			if (refractoryRate >= 5 && quantity < 30) quantity = 30;
			if (refractoryRate >= 8 && quantity < 50) quantity = 50;
			if (refractoryRate >= 10 && quantity < 100) quantity = 100;
			if (refractoryRate >= 15 && quantity < 251) quantity = 251;
			if (refractoryRate >= 20 && quantity < 1000) quantity = 1000;
			//You can't cum more than you can possibly have!
			if (quantity > maxCum()) quantity = maxCum();
			// unless you are using MAGIC
			if (hasPerk("Magical Virility")) quantity += perkv1("Magical Virility");
			
			//Overloaded nuki' nuts will fully drain
			if(hasPerk("'Nuki Nuts") && balls > 1 && perkv1("'Nuki Nuts") > 0 && quantity < currentCum()) quantity = currentCum();
			//BIOMASS ADDED LAST!
			if(statusEffectv1("Goo Vent") == 1) 
			{
				if(kGAMECLASS.flags["GOO_BIOMASS"] == undefined) kGAMECLASS.flags["GOO_BIOMASS"] = 0;
				quantity += kGAMECLASS.flags["GOO_BIOMASS"];
			}
			trace("Total produced: " + quantity);
			return quantity;
		}
		//Can hold about three average shots worth, since this is fantasy.
		public function maxCum(): Number {
			if (!hasCock()) return 0;
			var quantity: Number = 0;
			//Base value is ballsize*ballQ*cumefficiency by a factor of 2.
			//Other things that affect it: 
			//lust - 50% = normal output. 0 = 75%. 100 = +125% output.
			var lustCoefficient: Number = (lust() / 2 + 75) / 100;

			//Figure on 3x a cumshot value?
			if (balls == 0) quantity = Math.round(ballSize() * 2 * 2 * ballEfficiency);
			else quantity = Math.round(ballSize() * ballSize() * balls * 2 * ballEfficiency);
			return quantity;
		}
		public function currentCum(): Number {
			if(isNaN(ballFullness)) 
			{
				trace("ERROR: ballFullness is not a number. This has been rectified.");
				ballFullness = 0;
			}
			return Math.round(maxCum() * ballFullness/100);
		}
		public function cumProduced(minutes: Number): void {
			var cumDelta:Number = 0;
			var subDelta:Number = 0;
			//trace("MINUTES OF CUM CHARGING: " + minutes + " FULLNESS: " + ballFullness);
			if(isNaN(ballFullness)) 
			{
				trace("ERROR: ballFullness is not a number. This has been rectified.");
				ballFullness = 0;
			}
			
			// Why is this a loop? Just mul the final thing by total minutes. If we were firing events off that needed to be queued, or if the calculation depended on a value the algo actually changes (ie ballFullness was a part of the calc) then yeah, cycle minutes would be the /simple/ way to do it.
			cumDelta = refractoryRate / 60 * 2; // No balls == replace with 2 for purposes of the calc
			if(hasPerk("Breed Hungry")) cumDelta *= 2;
			
			//After 60% fullness, cut gains in half.
			if(ballFullness >= 60)
			{
				cumDelta /= 2;
			}
			//Crossing into 60% fullness? Hit 60, then cut in half.
			if(ballFullness < 60 && (ballFullness + (cumDelta * minutes)) >= 60)
			{
				//Find amount of change needed to hit 60.
				subDelta = 60 - ballFullness;
				//Set fullness to 60 and remove a portion of minutes equivalent to the change
				ballFullness = 60;
				minutes = minutes * subDelta/(minutes*cumDelta);
				//Half cumDelta for the remaining minutes
				cumDelta /= 2;
			}
			//Just hit full balls!
			if(balls > 0 && (ballFullness + (cumDelta * minutes)) >= 100 && ballFullness < 100 && this is PlayerCharacter)
			{
				trace("BLUE BALLS FOR: " + short);
				//Hit max cum - standard message
				kGAMECLASS.eventBuffer += "\n\nYou’re feeling a little... excitable, a little randy even. It won’t take much to excite you so long as your [pc.balls] ";
				if(balls == 1) kGAMECLASS.eventBuffer += "is";
				else kGAMECLASS.eventBuffer += "are";
				kGAMECLASS.eventBuffer += " this full.";
				if(hasPerk("'Nuki Nuts") && balls > 1) kGAMECLASS.eventBuffer += " Of course, your kui-tan physiology will let your balls balloon with additional seed. They've already started to swell. Just make sure to empty them before they get too big!";
				createStatusEffect("Blue Balls", 0,0,0,0,false,"Icon_Sperm_Hearts", "Take 25% more lust damage in combat!", false, 0,0xB793C4);
			}
			
			ballFullness += (cumDelta * minutes);
			
			//trace("AFTER FULLNESS: " + ballFullness);
			if (ballFullness >= 100) 
			{
				if(hasPerk("'Nuki Nuts") && balls > 1)
				{
					//Figure out a % of normal size to add based on %s.
					var nutChange:Number = (ballFullness/100) - 1;
					//Get the actual bonus number to add. Keep it to 2 decimals.
					var nutBonus:Number = Math.round(ballSizeRaw * nutChange * 100)/100;
					trace("NUT BONUS: " + nutBonus);
					//Apply nutbonus and track in v1 of the perk
					ballSizeMod += nutBonus;
					addPerkValue("'Nuki Nuts",1,nutBonus);
				}
				ballFullness = 100;
			}
			//if(this is PlayerCharacter) trace("Post Fullness: " + ballFullness)
		}
		public function isSquirter(arg: int = 0): Boolean {
			if (!hasVagina()) return false;
			if (arg < 0 || arg >= totalVaginas()) return false;
			if (vaginas[arg].wetness() >= 4) return true;
			return false;
		}
		//Placeholder
		public function girlCumQ(arg: int = -1):Number
		{
			// 9999
			if (!hasVagina()) return 0;
			var quantity: Number = 0;
			// lust - 50% = normal output. 0 = 75%. 100 = +125% output.
			var lustCoefficient: Number = ((lust() / 2) + 75) / 100;
			var girlCumMultiplier: Number = 0;
			var girlCumAmount: Number = 0;
			var squirterBonus: Number = 0;
			// For targetting a specific vagina, otherwise it's all inclusive.
			if (arg < 0)
			{
				for (arg = 0; arg < vaginas.length; arg++)
				{
					girlCumMultiplier += vaginas[arg].wetness();
					if (isSquirter(arg)) squirterBonus += vaginas[arg].wetness();
					girlCumAmount++;
				}
			}
			else
			{
				girlCumMultiplier += vaginas[arg].wetness();
				if (isSquirter(arg)) squirterBonus += vaginas[arg].wetness();
				girlCumAmount++;
			}
			// Scale values.
			girlCumMultiplier *= 1; // 1x per vagina's wetness level
			girlCumAmount *= 5; // 5 ml produced per vagina
			squirterBonus *= 10; // extra 10 mL produced per extra squirter bonus
			// Estimate initial quantity.
			quantity = girlCumMultiplier * lustCoefficient * (girlCumAmount + squirterBonus);
			// Heat means wetter orgasms.
			quantity += statusEffectv1("Heat");
			//GOO VENT BONUS!
			if(statusEffectv1("Goo Vent") == 1) 
			{
				if(kGAMECLASS.flags["GOO_BIOMASS"] == undefined) kGAMECLASS.flags["GOO_BIOMASS"] = 0;
				quantity += kGAMECLASS.flags["GOO_BIOMASS"];
			}
			// Round values.
			quantity = Math.round(quantity / 10) * 10;
			trace("Girl-cum produced: " + quantity);
			// Default minimum of 1mL
			if (quantity < 1) quantity = 1;
			return quantity;
		}
		public function totalClits(): Number {
			if (vaginas.length == 0) return 0;
			if (clitLength <= 0) return 0;
			var count: int = 0;
			
			for (var x:int = 0; x < vaginas.length; x++)
			{
				count += vaginas[x].clits;
			}
			
			return count;
		}
		public function hasClit():Boolean
		{
			return totalClits() > 0;
		}
		public function findFirstOfcType(type: Number = 0): Number {
			if(!hasCock()) return -1;
			var index: Number = 0;
			if (cocks[index].cType == type) return index;
			while (index < cocks.length) {
				if (cocks[index].cType == type) return index;
				index++;
			}
			trace("creature.findFirstOfcType ERROR - searched for cType: " + type + " and could not find it.");
			return -1;
		}
		//How many cocks?
		//Expanded to use an argument and replace horseCocks(), dogCocks(), etc.
		public function cockTotal(type: int = -1): Number {
			if (type == -1) return (cocks.length);
			var counter: int = 0;
			for (var x: int = 0; x < cocks.length; x++) {
				if (cocks[x].cType == type) counter++;
			}
			return counter;
		}
		//Alternate
		public function totalCocks(type: int = -1): Number {
			return cockTotal(type);
		}
		public function totalVaginas(type: int = -1): Number {
			if (type == -1) return (vaginas.length);
			var counter: int = 0;
			for (var x: int = 0; x < vaginas.length; x++) {
				if (vaginas[x].type == type) counter++;
			}
			return counter;
		}
		public function vaginaTotal(type: int = -1): Number {
			return totalVaginas(type);
		}
		//BOolean alternate
		public function hasCock(type:int = -1):Boolean {
			if (type == -1 && cocks.length > 0) return true;
		
			for (var i:int = 0; i < cocks.length; i++)
			{
				if ((cocks[i] as CockClass).cType == type) return true;
			}
			
			return false;
		}
		
		public function hasCocks(): Boolean {
			if (cocks.length > 1) return true;
			return false;
		}
		
		public function hasVaginas():Boolean
		{
			return vaginas.length > 1;
		}

		public function hasGenitals():Boolean
		{
			return (hasCock() || hasVagina());
		}
		public function isHerm():Boolean
		{
			return (hasCock() && hasVagina());
		}
		public function hasTail(tType:Number = 0): Boolean
		{
			if (tailCount > 0 && tailType != GLOBAL.TYPE_HUMAN)
			{
				// Specific type
				if (tType > 0 && tType == tailType) return true;
				// Any type
				if (tType == 0) return true;
			}
			return false;
		}
		public function hasTails(tType:Number = 0): Boolean
		{
			if (tailCount > 1 && tailType != GLOBAL.TYPE_HUMAN)
			{
				// Specific type
				if (tType > 0 && tType == tailType) return true;
				// Any type
				if (tType == 0) return true;
			}
			return false;
		}
		public function removeTails():void
		{
			tailCount = 0;
			tailType = 0;
			tailGenital = 0;
			tailGenitalArg = 0;
			tailGenitalColor = "";
			clearTailFlags();
			return;
		}
		public function hasParasiteTail(): Boolean {
			if (tailCount > 0 && InCollection(tailType, GLOBAL.TYPE_CUNTSNAKE, GLOBAL.TYPE_COCKVINE)) return true;
			return false;
		}
		public function hasTailCock(): Boolean {
			if (hasTailFlag(GLOBAL.FLAG_TAILCOCK) && tailCount > 0) return true;
			if (tailType == GLOBAL.TYPE_COCKVINE && tailCount > 0) return true;
			return false;
		}
		public function hasCockTail(): Boolean {
			return hasTailCock();
		}
		public function hasTailgina(): Boolean {
			return hasTailCunt();
		}
		public function hasCuntTail(): Boolean {
			return hasTailCunt();
		}
		public function hasTailCunt(): Boolean {
			if (tailType == GLOBAL.TYPE_CUNTSNAKE && tailCount > 0) return true;
			return false;
		}
		//In case there's ever different types of cuntTails available, we'll need different methods.
		public function hasCuntSnake(): Boolean {
			return hasTailCunt();
		}
		public function tailVaginaCapacity(): Number {
			return tailCuntCapacity();
		}
		public function tailCuntCapacity(): Number {
			if (!hasTailCunt()) return 0;
			if (vaginalCapacity(0) > 100) return vaginalCapacity(0);
			else return 100;
		}
		public function isBald(): Boolean {
			return (hairLength <= 0);
		}
		public function hasHair(): Boolean {
			return (hairLength > 0);
		}
		public function hasLivingHair(): Boolean {
			if (hasHair())
			{
				if (InCollection(hairType, GLOBAL.HAIR_TYPE_TENTACLES, GLOBAL.HAIR_TYPE_GOO)) return true;
			}
			return false;
		}
		public function hasSockRoom(): Boolean {
			var index: int = cockTotal();
			while (index > 0) {
				index--;
				if (cocks[index].sock == "") return true;
			}
			return false
		}
		public function hasSock(arg: String = ""): Boolean {
			var index: int = cockTotal();
			while (index > 0) {
				index--;
				if (cocks[index].sock != "") {
					if (arg == "" || cocks[index].sock == arg) return true;
				}
			}
			return false
		}
		public function canAutoFellate(arg: int = 0): Boolean {
			if (!hasCock()) return false;
			if (arg >= 0) {
				if (arg >= cocks.length) return false;
				return (cocks[arg].cLength() >= 1 / 6 && (hasCockFlag(GLOBAL.FLAG_PREHENSILE, arg) || cocks[arg].cLength() / tallness >= 1 / 3) && genitalLocation() <= 1);
			}
			//Negative is code for see if any can.
			else {
				for (var x: int = 0; x < cocks.length; x++) {
					if (cocks[x].cLength() >= 1 / 6 && (hasCockFlag(GLOBAL.FLAG_PREHENSILE, x) || cocks[x].cLength() / tallness >= 1 / 3) && genitalLocation() <= 1)
						return true;
				}
				return false;
			}
		}
		public function canSelfSuck(arg: int = 0): Boolean {
			return canAutoFellate(arg);
		}
		public function aCockToSuck(): int {
			var choices: Array = new Array();
			for (var x: int = 0; x < cocks.length; x++) {
				if (cocks[x].cLength() >= 1 / 6 && (hasCockFlag(GLOBAL.FLAG_PREHENSILE, x) || cocks[x].cLength() / tallness <= 1 / 3) && genitalLocation() <= 1)
					choices[choices.length] = x;
			}
			if (choices.length == 0) return 0;
			else return choices[rand(choices.length)];
		}
		//Change cunt type!
		public function shiftVagina(slot:int = 0, type:int = 0): void {
			if (slot + 1 > vaginas.length) return;
			else if (slot < 0) return;

			//Set type
			vaginas[slot].type = type;

			//Clear flags
			vaginas[slot].clearFlags();

			//Add bonus flags and shit.
			switch (type)
			{
				case GLOBAL.TYPE_HUMAN:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = "pink";
					break;
				case GLOBAL.TYPE_EQUINE:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = "black";
					vaginas[slot].minLooseness = 2;
					break;
				case GLOBAL.TYPE_BEE:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = "black and gold";
					break;
				case GLOBAL.TYPE_NAGA:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = "purple";
					break;
				case GLOBAL.TYPE_LEITHAN:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = "black";
					break;
				case GLOBAL.TYPE_VANAE:
					vaginas[slot].clits = 2;
					vaginas[slot].vaginaColor = "luminous violet";
					vaginas[slot].wetnessRaw = 4;
					break;
				case GLOBAL.TYPE_KUITAN:
					vaginas[slot].vaginaColor = "black";
					break;
				case GLOBAL.TYPE_SYNTHETIC:
					vaginas[slot].vaginaColor = RandomInCollection(["silver", "gray", "black"]);
					break;
				case GLOBAL.TYPE_LAPINARA:
					vaginas[slot].vaginaColor = RandomInCollection(["pink", "pink", "purple"]);
					break;
				case GLOBAL.TYPE_CANINE:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = "pink";
					vaginas[slot].wetnessRaw = 3;
					vaginas[slot].minLooseness = 3;
					break;
				case GLOBAL.TYPE_SIREN:
					vaginas[slot].vaginaColor = RandomInCollection(["blue", "aquamarine"]);
					vaginas[slot].addFlag(GLOBAL.FLAG_NUBBY);
					vaginas[slot].addFlag(GLOBAL.FLAG_TENDRIL);
					vaginas[slot].addFlag(GLOBAL.FLAG_APHRODISIAC_LACED);
					break;
				case GLOBAL.TYPE_GABILANI:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = RandomInCollection(["pink", "pink", "aquamarine", "purple"]);
					vaginas[slot].minLooseness = 1;
					vaginas[slot].addFlag(GLOBAL.FLAG_LUBRICATED);
					break;
				case GLOBAL.TYPE_NYREA:
					vaginas[slot].clits = 1;
					vaginas[slot].vaginaColor = "pink";
					vaginas[slot].wetnessRaw = 2;
					vaginas[slot].addFlag(GLOBAL.FLAG_LUBRICATED);
					break;
			}
		}
		//Change cock type
		public function shiftCock(slot: int = 0, type: int = -1): void {
			if (type == -1) // check if type was not passed, and if so, override with EQUINE
				type = GLOBAL.TYPE_EQUINE;
			if (slot + 1 > cocks.length) return;
			else if (slot < 0) return;

			//Set type
			cocks[slot].cType = type;

			//Clear flags
			cocks[slot].clearFlags();

			//Add bonus flags and shit.
			switch (type)
			{
				case GLOBAL.TYPE_HUMAN:
				case GLOBAL.TYPE_INHUMAN:
					cocks[slot].knotMultiplier = 1;
					if(InCollection(skinTone, "dark", "ebony", "chocolate")) cocks[slot].cockColor = "ebony";
					else cocks[slot].cockColor = "pink";
					break;
				case GLOBAL.TYPE_CANINE:
				case GLOBAL.TYPE_VULPINE:
					cocks[slot].knotMultiplier = 1.25;
					cocks[slot].cockColor = "bright red";
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					cocks[slot].addFlag(GLOBAL.FLAG_KNOTTED);
					cocks[slot].addFlag(GLOBAL.FLAG_SHEATHED);
					break;
				case GLOBAL.TYPE_FELINE:
					cocks[slot].knotMultiplier = 1;
					cocks[slot].cockColor = "pink";
					cocks[slot].addFlag(GLOBAL.FLAG_NUBBY);
					break;
				case GLOBAL.TYPE_EQUINE:
					cocks[slot].knotMultiplier = 1;
					cocks[slot].cockColor = RandomInCollection(["pink", "black", "mottled pink and black"]);
					cocks[slot].addFlag(GLOBAL.FLAG_BLUNT);
					cocks[slot].addFlag(GLOBAL.FLAG_FLARED);
					cocks[slot].addFlag(GLOBAL.FLAG_SHEATHED);
					break;
				case GLOBAL.TYPE_BEE:
					cocks[slot].cockColor = RandomInCollection(["amber", "black"]);
					cocks[slot].knotMultiplier = 1;
					cocks[slot].addFlag(GLOBAL.FLAG_SMOOTH);
					cocks[slot].addFlag(GLOBAL.FLAG_FORESKINNED);
					break;
				case GLOBAL.TYPE_NAGA:
					cocks[slot].cockColor = "purple";
					cocks[slot].knotMultiplier = 1;
					cocks[slot].addFlag(GLOBAL.FLAG_SMOOTH);
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					break;
				case GLOBAL.TYPE_KUITAN:
					cocks[slot].cockColor = "red";
					cocks[slot].knotMultiplier = 1.3;
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					cocks[slot].addFlag(GLOBAL.FLAG_KNOTTED);
					cocks[slot].addFlag(GLOBAL.FLAG_SHEATHED);
					break;
				case GLOBAL.TYPE_RASKVEL:
					cocks[slot].cockColor = "purple";
					cocks[slot].addFlag(GLOBAL.FLAG_SMOOTH);
					break;
				case GLOBAL.TYPE_DEMONIC:
					cocks[slot].cockColor = RandomInCollection(["red", "dark purple"]);
					cocks[slot].knotMultiplier = 1.4;
					cocks[slot].addFlag(GLOBAL.FLAG_KNOTTED);
					cocks[slot].addFlag(GLOBAL.FLAG_NUBBY);
					break;
				case GLOBAL.TYPE_TENTACLE:
					cocks[slot].cockColor = RandomInCollection(["green", "purple"]);
					cocks[slot].addFlag(GLOBAL.FLAG_PREHENSILE);
					cocks[slot].addFlag(GLOBAL.FLAG_FLARED);
					cocks[slot].addFlag(GLOBAL.FLAG_LUBRICATED);
					break;
				case GLOBAL.TYPE_ANEMONE:
				case GLOBAL.TYPE_SIREN:
					cocks[slot].cockColor = RandomInCollection(["blue", "aquamarine"]);
					cocks[slot].addFlag(GLOBAL.FLAG_APHRODISIAC_LACED);
					cocks[slot].addFlag(GLOBAL.FLAG_STINGER_BASED);
					break;
				case GLOBAL.TYPE_KANGAROO:
					cocks[slot].cockColor = RandomInCollection(["red", "pink"]);
					cocks[slot].addFlag(GLOBAL.FLAG_PREHENSILE);
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					break;
				case GLOBAL.TYPE_DRACONIC:
					cocks[slot].cockColor = RandomInCollection(["red", "green", "blue", "aquamarine", "purple", "yellow", "gray", "black"]);
					cocks[slot].knotMultiplier = RandomInCollection([1.25, 1.3]);
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					cocks[slot].addFlag(GLOBAL.FLAG_KNOTTED);
					cocks[slot].addFlag(GLOBAL.FLAG_RIBBED);
					break;
				case GLOBAL.TYPE_SIMII:
					cocks[slot].knotMultiplier = 1;
					cocks[slot].cockColor = "pink";
					break;
				case GLOBAL.TYPE_SAURIAN:
					cocks[slot].knotMultiplier = 1;
					cocks[slot].cockColor = "pink";
					if(cocks[slot].cLengthRaw < 20) cocks[slot].cLengthRaw = 20;
					if(cocks[slot].cThicknessRatioRaw < 3) cocks[slot].cThicknessRatioRaw = 3;
					break;
				case GLOBAL.TYPE_SYNTHETIC:
					cocks[slot].cockColor = RandomInCollection(["silver", "gray", "black"]);
					break;
				case GLOBAL.TYPE_VENUSPITCHER:
					cocks[slot].cockColor = RandomInCollection(["green", "purple", "olive green"]);
					cocks[slot].addFlag(GLOBAL.FLAG_PREHENSILE);
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					break;
				case GLOBAL.TYPE_NYREA:
					cocks[slot].cockColor = "pink";
					cocks[slot].knotMultiplier = 1.66;
					cocks[slot].addFlag(GLOBAL.FLAG_FLARED);
					cocks[slot].addFlag(GLOBAL.FLAG_KNOTTED);
					cocks[slot].addFlag(GLOBAL.FLAG_OVIPOSITOR);
					break;
				case GLOBAL.TYPE_DAYNAR:
					cocks[slot].cockColor = "purple";
					cocks[slot].knotMultiplier = 1;
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					break;
				case GLOBAL.TYPE_SYDIAN:
					cocks[slot].cockColor = RandomInCollection(["orange", "bright orange", "red orange"]);
					cocks[slot].knotMultiplier = 1;
					break;
				case GLOBAL.TYPE_COCKVINE:
					cocks[slot].cockColor = RandomInCollection(["green", "purple"]);
					cocks[slot].knotMultiplier = 1;
					cocks[slot].addFlag(GLOBAL.FLAG_PREHENSILE);
					break;
				case GLOBAL.TYPE_AVIAN:
					cocks[slot].cockColor = RandomInCollection(["red", "red", "bright red"]);
					cocks[slot].knotMultiplier = 1;
					cocks[slot].addFlag(GLOBAL.FLAG_TAPERED);
					cocks[slot].addFlag(GLOBAL.FLAG_SHEATHED);
					break;
				case GLOBAL.TYPE_GABILANI:
					cocks[slot].knotMultiplier = 1;
					cocks[slot].cockColor = RandomInCollection(["pink", "pink", "olive", "purple"]);
					cocks[slot].addFlag(GLOBAL.FLAG_DOUBLE_HEADED);
					break;
				case GLOBAL.TYPE_VANAE:
					cocks[slot].knotMultiplier = 1;
					cocks[slot].cockColor = "luminous violet";
					cocks[slot].addFlag(GLOBAL.FLAG_SMOOTH);
					cocks[slot].addFlag(GLOBAL.FLAG_LUBRICATED);
					break;
			}
		}
		//PC can fly?
		public function canFly(): Boolean {
			//web also makes false!
			if (hasStatusEffect("Web")) return false;
			if (InCollection(wingType, GLOBAL.TYPE_AVIAN, GLOBAL.TYPE_BEE, GLOBAL.TYPE_DEMONIC, GLOBAL.TYPE_DRACONIC, GLOBAL.TYPE_DRAGONFLY, GLOBAL.TYPE_SYLVAN, GLOBAL.TYPE_DARK_SYLVAN, GLOBAL.TYPE_DOVETWO, GLOBAL.TYPE_DOVEFOUR, GLOBAL.TYPE_DOVESIX)) return true;
			return false;
		}
		//PC can swim?
		public function canSwim(): Boolean {
			//Oh god, why Spiderman, why?!!!
			if (hasStatusEffect("Web")) return false;
			if (wingType == GLOBAL.TYPE_SHARK) return true;
			return true;
		}
		public function hasWings(wType:Number = 0): Boolean {
			if(wingType == GLOBAL.TYPE_SHARK) return false;
			if (wingType != 0)
			{
				// Specific type
				if (wType > 0 && wType == wingType) return true;
				// Any type
				if (wType == 0) return true;
			}
			return false;
		}
		//check for vagoo
		public function hasVagina(hole: int = 0): Boolean {
			if (vaginas.length > hole) return true;
			return false;
		}
		public function hasVaginaType(type: Number = 0): Boolean {
			if (vaginas.length == 0) return false;
			for (var x: int = 0; x < vaginas.length; x++) {
				if (vaginas[x].type == type) return true;
			}
			return false;
		}
		public function hasVirginVagina(): Boolean {
			return (vaginas.length > 0 && vaginalVirgin);
		}
		public function hasVirginCock(): Boolean {
			return (cocks.length > 0 && cockVirgin);
		}
		public function mfn(male: String, female: String, neuter: String): String {
			
			if (hasStatusEffect("Force Fem Gender")) return female;
			if (hasStatusEffect("Force Male Gender")) return male;
			
			//1/2 facial
			var weighting: Number = femininity;
			if (hasStatusEffect("Uma's Massage") && statusEffectv1("Uma's Massage") == 3) femininity += statusEffectv2("Uma's Massage");
			
			//Tits count up to their rating for femininity
			if (biggestTitSize() >= 1) {
				//trace("boobs confirmed");
				if (biggestTitSize() * 3 > 50) weighting += 50;
				else weighting += biggestTitSize() * 3;
			}
			//Flat chest + 20 masculine
			else if (biggestTitSize() == 0) {
				//trace("no boobs confirmed");
				weighting -= 10;
			}
			//Hips give small boost
			if (hipRating() >= 6) weighting += hipRating() * 1.5;
			else weighting -= (6 - hipRating()) * 3;
			if (hairLength > 8) weighting += (hairLength - 7) * 1.5;
			else weighting -= (8 - hairLength) * 1.5;
			if (tone > 70) weighting -= 10;
			if (tone < 30) weighting += 10;
			if (lipRating() > 1) weighting += lipRating() * 3;
			if (hasBeard()) weighting -= 100;
			//trace("Femininity Rating = " + weighting);
			//Neuters first!
			if (neuter != "") {
				if (weighting >= 45 && weighting <= 55 || hasStatusEffect("Force It Gender")) return neuter;
				else if (weighting < 45) return male;
				else return female;
			} else {
				if (weighting <= 49) return male;
				else return female;
			}
		}
		public function mf(male: String, female: String): String {
			return mfn(male, female, "");
		}
		public function rawmfn(male: String, female: String, neuter: String): String {
			
			//if (hasStatusEffect("Force Fem Gender")) return female;
			//if (hasStatusEffect("Force Male Gender")) return male;
			
			if (!hasCock() && !hasVagina()) return neuter;
			else return rawmf(male, female);
		}
		public function rawmf(male: String, female: String): String {
			if (!hasVagina()) return male;
			else return female;
		}
		//Create a cock
		public function createCock(clength: Number = 5.5, cthickness: Number = 1): Boolean {
			if (cocks.length >= 10) return false;
			var newCock:CockClass = new CockClass();
			cocks.push(newCock);
			cocks[cocks.length - 1].cThicknessRatioRaw = cthickness;
			cocks[cocks.length - 1].cLengthRaw = clength;
			return true;
		}
		public function createCockUnlocked(numCocks:int = 1):Boolean
		{
			return true;
		}
		public function createCockLockedMessage():String
		{
			return "Your crotch warms, but nothing happens.";
		}
		
		//create vagoo
		public function createVagina(): Boolean {
			if (vaginas.length >= 3) return false;
			var newVagina:VaginaClass = new VaginaClass();
			vaginas.push(newVagina);
			return true;
		}
		public function copyVagina(target:int, donor:int):void
		{
			if(target < 0 || donor < 0) return;
			if(target >= vaginas.length || donor >= vaginas.length) return;
			vaginas[target].type = vaginas[donor].type;
			vaginas[target].wetnessRaw = vaginas[donor].wetnessRaw;
			vaginas[target].loosenessRaw = vaginas[donor].loosenessRaw;
			vaginas[target].clits = vaginas[donor].clits;
			vaginas[target].vaginaColor = vaginas[donor].vaginaColor;
			vaginas[target].bonusCapacity = vaginas[donor].bonusCapacity;
			vaginas[target].minLooseness = vaginas[donor].minLooseness;
			vaginas[target].hymen = vaginas[donor].hymen;
			for(var y:int = 0; y < vaginas[donor].vagooFlags.length; y++)
			{
				vaginas[target].vagooFlags[y] = vaginas[donor].vagooFlags[y];
			}
			trace("Copying " + vaginaNounDescript(donor) + " to donor " + vaginaNounDescript(target) + " donor index: " + donor + " target index: " + target + " donor type: " + vaginas[donor].type + " target type: " + vaginas[target].type);
			return;
		}
		public function createVaginaUnlocked(numVag:int = 1):Boolean
		{
			if ((vaginas.length + numVag) > 3) return false;
			return true;
		}
		public function createVaginaLockedMessage():String
		{
			return "Your crotch warms, but nothing happens.";
		}
		
		//create a row of breasts
		public function createBreastRow(): Boolean {
			if (breastRows.length >= 10) return false;
			var newBreastRow:BreastRowClass = new BreastRowClass();
			breastRows.push(newBreastRow);
			return true;
		}
		public function createBreastRowUnlocked(numRows:int = 1):Boolean
		{
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function createBreastRowsLockedMessage():String
		{
			return "Your chest warms, but nothing happens.";
		}
		
		public function removeJunk(array:Array, arraySpot:int, totalRemoved:int): void {
			//Various Errors preventing action
			if (arraySpot < 0 || totalRemoved <= 0) {
				return;
			}
			if (array.length == 0) {
				//trace("ERROR: removeCock called but cocks do not exist.");
				return;
			}
			if (arraySpot > array.length - 1) {
				//trace("ERROR: removeCock failed - array location is beyond the bounds of the array.");
				throw new Error("removeJunk call failed. Target location to remove is out of array bounds.");
			} else {
				array.splice(arraySpot, totalRemoved);
				if (array == cocks) trace("Attempted to remove " + totalRemoved + " spots from cocks.");
				else if (array == vaginas) trace("Attempted to remove " + totalRemoved + " spots from vaginas.");
				else if (array == breastRows) trace("Attempted to remove " + totalRemoved + " spots from breastRows.");
			}
		}
		//Remove cocks
		public function removeCocks(): void {
			while (hasCock()) {
				removeCock(0, 1);
			}
		}
		public function removeCocksUnlocked():Boolean 
		{
			if (hasStatusEffect("Mimbrane Cock")) return false;
			return true;
		}
		public function removeCocksLockedMessage():String 
		{
			if (hasStatusEffect("Mimbrane Cock")) return "The Mimbrane surrounding your " + cockDescript(0) + " suddenly bursts to life and squeezes your dick for all it’s worth. Seems the parasite’s efforts are keeping you from losing your cock entirely.";
			else return "Your body practically glows with groin-focused effort, keeping you from losing your genitalia entirely.";
		}
		
		//Remove cock
		public function removeCock(arraySpot:int, totalRemoved:int = 1): void {
			removeJunk(cocks, arraySpot, totalRemoved);
			if(!hasCock())
			{
				removeStatusEffect("Blue Balls");
				removePerk("Firing Blanks");
			}
		}
		public function removeCockUnlocked(arraySpot:int = 0, totalRemoved:int = 1):Boolean
		{
			if (arraySpot == 0 && totalRemoved >= 1 && hasStatusEffect("Mimbrane Cock")) return false;
			return true;
		}
		public function removeCockLockedMessage():String
		{
			if (cocks.length == 1 && hasStatusEffect("Mimbrane Cock")) return "The Mimbrane surrounding your " + cockDescript(0) + " suddenly bursts to life and squeezes your dick for all it’s worth. Seems the parasite’s efforts are keeping you from losing your cock entirely.";
			else return "Your body practically glows with groin-focused effort, keeping you from losing your genitalia entirely.";
		}
		
		//Remove vaginas
		public function removeVaginas(): void {
			while (hasVagina()) {
				removeVagina(0, 1);
			}
		}
		public function removeVaginasUnlocked():Boolean
		{
			if (hasStatusEffect("Mimbrane Pussy")) return false;
			return true;
		}
		public function removeVaginasLockedMessage():String
		{
			if (hasStatusEffect("Mimbrane Pussy")) return "A powerful stretching overtakes your " + vaginaDescript(0) + ", your Mimbrane is doing everything in its power to keep the feminine canyon from vanishing. Seems you won’t be able to get rid of your pussy so long as the parasite is in control of it.";
			else return "Your body practically glows with groin-focused effort, keeping you from losing your genitalia entirely.";
		}

		//Remove vaginas
		public function removeVagina(arraySpot: int = 0, totalRemoved: int = 1): void {
			removeJunk(vaginas, arraySpot, totalRemoved);
			if(!hasVagina())
			{
				removePerk("Sterile");
			}
		}
		public function removeVaginaUnlocked(arraySpot:int = 0, totalRemoved:int = 1):Boolean
		{
			if (vaginas.length == 1 && hasStatusEffect("Mimbrane Pussy")) return false;
			if (isPregnant(arraySpot)) return false;
			return true;
		}
		public function removeVaginaLockedMessage():String
		{
			if (vaginas.length == 1 && hasStatusEffect("Mimbrane Pussy")) return "A powerful stretching overtakes your " + vaginaDescript(0) + ", your Mimbrane is doing everything in its power to keep the feminine canyon from vanishing. Seems you won’t be able to get rid of your pussy so long as the parasite is in control of it.";
			if (isPregnant()) return "A powerful sensation can be felt in your womb. Your body actively fights the change, keeping you from losing your pregnant vagina entirely.";
			else return "Your body practically glows with groin-focused effort, keeping you from losing your genitalia entirely.";
		}

		//Remove a breast row
		public function removeBreastRow(arraySpot:int, totalRemoved:int): void {
			if (hasStatusEffect("Boobswell Pads") && statusEffectv1("Boobswell Pads") == arraySpot)
			{
				kGAMECLASS.eventBuffer += "\n\nThe Boobswell pads you had been wearing on your " + num2Ordinal(arraySpot + 1) + " row of breast";
				if (breastRows[arraySpot].breasts != 1) kGAMECLASS.eventBuffer += "s";
				kGAMECLASS.eventBuffer += " disintegrate as the row was removed. <b>You're no longer under the effects of the Boobswell Pads!</b>";
				removeStatusEffect("Boobswell Pads");
			}
			removeJunk(breastRows, arraySpot, totalRemoved);
		}
		public function removeBreastRowUnlocked(arraySpot:int = 0, totalRemoved:int = 1):Boolean
		{
			if (breastRows.length == 1 && hasStatusEffect("Mimbrane Boobs")) return false;
			if (hasStatusEffect("Gel Body")) return false;
			return true;
		}
		public function removeBreastRowLockedMessage():String
		{
			if (breastRows.length == 1 && hasStatusEffect("Mimbrane Boobs")) return "Your " + allChestDesc() + " pulls from your body with a tremendous force, resisting the attempt to flatten your girlish curves. The Mimbrane mounds refuse to be deflated, it seems.";
			else return "Your body practically glows with chest-focused effort, keeping you from losing your [pc.chest].";
		}

		public function race(): String {
			//Temp vars
			var temp: Number = 0;
			var rando: Number = 0;
			var race:String = "human";
			//Determine race type
			if (horseScore() >= 3) race = equineRace(); // Horse-morphs
			if (lizardScore() >= 4) race = "lizan";
			if (kangaScore() >= 4) race = "kangaroo-morph";
			if (bunnyScore() >= 4) race = "bunny-" + mf("boy", "girl");
			if (harpyScore() >= 4) race = mf("avian", "harpy");
			if (spiderScore() >= 4) race = "spider-" + mf("boy", "girl");
			if (dragonScore() >= 5) race = faceType == GLOBAL.TYPE_DRACONIC ? "dragon-morph" : mf("dragon-man", "dragon-girl");
			if (foxScore() >= 4) race = faceType == GLOBAL.TYPE_VULPINE ? "fox-morph" : mf("fox-man", "fox-girl");
			if (kitsuneScore() >= 5 && (race.indexOf("fox") == -1 || tailCount > 1)) race = "kitsune";
			if (ovirScore() >= 3 && race == "human") race = "half-ovir";
			if (ausarScore() >= 2 && race == "human") race = "half-ausar"; // Fucking Ausar forever overriding other shit. EXTERMINATUS.
			if (kaithritScore() >= 3 && race == "human") race = "half-kaithrit";
			if (leithanScore() >= 3 && race == "human") race = "half-leithan";
			if (nukiScore() >= 2 && race == "human") race = "half kui-tan"
			if (raskvelScore() >= 2) race = "rask-morph";
			if (bovineScore() >= 3) race = bovineRace(); // Cow-morphs
			if (raskvelScore() >= 4) race = "raskvel-morph";
			if (pandaScore() >= 4) race = "panda-morph";
			if (ausarScore() >= 4) race = "ausar"
			if (canineScore() >= 4 && race != "ausar") race = faceType == GLOBAL.TYPE_CANINE ? "dog-morph" : mf("dog-man", "dog-girl");
			if (demonScore() >= 5) race = "demon-morph";
			if (gabilaniScore() >= 5) race = "gabilani";
			if (frogScore() >= 5) race = "kerokoras";
			if (kaithritScore() >= 6) race = "kaithrit";
			if (felineScore() >= 5 && race != "kaithrit") {
				if (hasTail(GLOBAL.TYPE_FELINE) && tailCount > 1) race = "nekomata";
				else if (dragonScore() >= 4)  race = "dragonne";
				else if (faceType == GLOBAL.TYPE_FELINE) race = "cat-morph";
				else race = rawmfn(mfn("cat-man", "cat-girl", "cat-boy"), "cat-girl", "feline");
			}
			if (leithanScore() >= 6) race = "leithan";
			if (nukiScore() >= 6) race = "kui-tan";
			if (vanaeScore() >= 6) race = "vanae-morph";
			if (raskvelScore() >= 6) race = "raskvel";
			if (zilScore() >= 6) race = "zil";
			if (badgerScore() >= 4) race = "badger";
			if (ovirScore() >= 5) race = "ovir";
			if (myrScore() >= 4) race = "myr";
			if (race == "myr" && goldMyrScore() >= 8) race = "gold myr";
			if (race == "myr" && redMyrScore() >= 8) race = "red myr";
			if (orangeMyrScore() >= 9) race = "orange myr";
			if (nyreaScore() >= 5) race = "nyrea";
			// Human-morphs
			if (race == "human" && cowScore() >= 4) race = mfn("cow-boy", "cow-girl", "hucow");
			// Centaur-morphs
			if (horseScore() >= 3 && isCentaur()) race = taurRace(equineRace());
			else if (bovineScore() >= 3 && isTaur()) race = rawmfn("bull", "cow", "bovine") + "-taur";
			else if (race == "human" && isCentaur()) race = "centaur";
			else if (race == "cat-morph" && isTaur() && isHerm()) race = "chakat";
			else if (isTaur()) race = taurRace(race); // Other taurs
			// Naga-morphs
			if (naleenScore() >= 5 && isNaga()) race = "naleen";
			else if (isNaga()) race = "naga";
			// Slime-morphs
			if (gooScore() >= 6) race = "goo-morph";
			if (gooScore() >= 8) race = "galotian";
			// MLP-morphs
			if (legType == GLOBAL.TYPE_MLP) race = mlpRace();
			// Amalgamations
			if (race == "human" && humanScore() < 4) race = "alien hybrid";
			
			return race;
		}
		public function equineRace():String
		{
			if (horseScore() >= 5)
			{
				if (hasHorns() && hasWings()) return "alicorn-morph";
				if (hasHorns() && horns == 1) return "unicorn-morph";
				if (hasWings()) return "pegasus-morph";
				return "horse-morph";
			}
			if (isCentaur()) return "horse-taur";
			return "part horse-morph";
		}
		public function bovineRace():String
		{
			if (bovineScore() >= 6 && femininity <= 60 && femininity >= 40) return "bovine-morph";
			if (hasLegFlag(GLOBAL.FLAG_HOOVES))
			{
				if (hasCock() && hasVagina()) return "futaurus";
				if (femininity < 40 && faceType == GLOBAL.TYPE_BOVINE) return "minotaur";
				if (femininity > 60) return "holstaurus";
				if (femininity > 30) return "minitaur";
			}
			if (femininity > 60)
			{
				if (hasCock() && !hasVagina() && hasBreasts()) return "cow-boi";
				if (hasCock() && !hasVagina()) return "bull-girl";
				if (!hasGenitals()) return "cow-morph";
				return "cow-girl";
			}
			if (femininity < 40)
			{
				if (hasCock() && hasVagina()) return "bull-futa";
				if (hasCock() && !hasVagina() && femininity < 20) return "bull-man";
				if (hasCock() && !hasVagina()) return "bull-boy";
				if (!hasCock() && hasVagina()) return "cow-boy";
				return "bull-morph";
			}
			return "part bovine-morph";
		}
		public function taurRace(race:String = ""):String
		{
			if (race.indexOf("leithan") != -1 || race.indexOf("taur") != -1) return race;
			if (race.indexOf("-morph") != -1) race = race.replace("-morph", "");
			return race + "-taur";
		}
		public function mlpRace():String
		{
			if (hasHorns() && hasWings()) return "alicorn";
			if (hasHorns() && horns == 1) return "unicorn";
			if (hasWings()) return "pegasus pony";
			return "terran pony";
		}
		
		public function isHuman():Boolean
		{
			return race() == "human";
		}
		
		public function isHalfHuman():Boolean
		{
			if (race().indexOf("half-") != -1) return true;
			if (race().indexOf("half ") != -1) return true;
			return false;
		}
		public function foxScore():Number
		{
			var foxCounter:Number = 0;
			if (faceType == GLOBAL.TYPE_VULPINE)
				foxCounter++;
			if (earType == GLOBAL.TYPE_VULPINE)
				foxCounter++;
			if (tailType == GLOBAL.TYPE_VULPINE)
				foxCounter++;
			if (legType == GLOBAL.TYPE_VULPINE)
				foxCounter++;
			if (armType == GLOBAL.TYPE_VULPINE || armType == GLOBAL.TYPE_CANINE && foxCounter > 0)
				foxCounter++;
			if (hasCock(GLOBAL.TYPE_VULPINE) || hasCock(GLOBAL.TYPE_CANINE) && foxCounter > 0)
				foxCounter++;
			if (hasVagina(GLOBAL.TYPE_VULPINE) || hasVagina(GLOBAL.TYPE_CANINE) && foxCounter > 0)
				foxCounter++;
			if (breastRows.length > 1 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 3 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 4 && foxCounter > 0)
				foxCounter++;
			//Fur only counts if some canine features are present
			if (hasFur() && foxCounter > 0)
				foxCounter++;
			return foxCounter;
		}
		//Determine kitsune Rating
		public function kitsuneScore():Number
		{
			var kitsuneCounter:int = 0;
			//If the character has fox ears, +1
			if (earType == GLOBAL.TYPE_VULPINE)
				kitsuneCounter++;
			//If the character has a fox tail, +1
			if (hasTail(GLOBAL.TYPE_VULPINE))
				kitsuneCounter++;
			//If the character has two or more fox tails, +2
			if (hasTail(GLOBAL.TYPE_VULPINE) && tailCount >= 2)
				kitsuneCounter += 2;
			if (hasTail(GLOBAL.TYPE_VULPINE) && tailCount == 9)
				kitsuneCounter += 1;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			//If the character's kitsune score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitsuneCounter > 0 && (faceType == GLOBAL.TYPE_HUMAN || faceType == GLOBAL.TYPE_VULPINE))
				kitsuneCounter++;
			//If the character's kitsune score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitsuneCounter > 0 && (InCollection(furColor, kGAMECLASS.basicKitsuneHair, kGAMECLASS.elderKitsuneColors, kGAMECLASS.corruptKitsuneColors)))
				kitsuneCounter++;
			//If the character's femininity is 40 or higher, +1
			if (kitsuneCounter > 0 && femininity >= 40)
				kitsuneCounter++;
			//If the character has fur of non-foxy type
			if (skinType == GLOBAL.SKIN_TYPE_FUR && !InCollection(furColor, kGAMECLASS.basicKitsuneFur, kGAMECLASS.elderKitsuneColors, kGAMECLASS.corruptKitsuneColors))
				kitsuneCounter--;
			if (skinType > GLOBAL.SKIN_TYPE_FUR)
				kitsuneCounter -= 2;  // Not skin or fur
			//If the character has abnormal legs, -1
			if (legType != GLOBAL.TYPE_HUMAN && legType != GLOBAL.TYPE_VULPINE)
				kitsuneCounter--;
			//If the character has a nonhuman face, -1
			if (faceType != GLOBAL.TYPE_HUMAN && faceType != GLOBAL.TYPE_VULPINE)
				kitsuneCounter--;
			//If the character has ears other than fox ears, -1
			if (earType != GLOBAL.TYPE_VULPINE)
				kitsuneCounter--;
			//If the character has tail(s) other than fox tails, -1
			if (hasTail() && tailType != GLOBAL.TYPE_VULPINE)
				kitsuneCounter--;
			return kitsuneCounter;
		}
		//Determine lizard rating
		public function lizardScore():Number
		{
			var lizardCounter:Number = 0;
			if (faceType == GLOBAL.TYPE_LIZAN)
				lizardCounter++;
			if (earType == GLOBAL.TYPE_LIZAN)
				lizardCounter++;
			if (tailType == GLOBAL.TYPE_LIZAN)
				lizardCounter++;
			if (legType == GLOBAL.TYPE_LIZAN)
				lizardCounter++;
			if (eyeType == GLOBAL.TYPE_SNAKE && lizardCounter > 0)
				lizardCounter++;
			if (cockTotal(GLOBAL.TYPE_SNAKE) > 0 && lizardCounter > 0)
				lizardCounter++;
			if (hasHorns(GLOBAL.TYPE_DRACONIC) && lizardCounter > 0)
				lizardCounter++;
			if (hasScales() && lizardCounter > 0)
				lizardCounter++;
			return lizardCounter;
		}
		//Kangascore
		public function kangaScore():Number
		{
			var kanga:Number = 0;
			if (cockTotal(GLOBAL.TYPE_KANGAROO) > 0)
				kanga++;
			if (earType == GLOBAL.TYPE_KANGAROO)
				kanga++;
			if (tailType == GLOBAL.TYPE_KANGAROO)
				kanga++;
			if (legType == GLOBAL.TYPE_KANGAROO)
				kanga++;
			if (faceType == GLOBAL.TYPE_KANGAROO)
				kanga++;
			if (kanga >= 2 && hasFur())
				kanga++;
			return kanga;
		}
		//Bunnyscore
		public function bunnyScore():Number
		{
			var bunnyCounter:Number = 0;
			if (faceType == GLOBAL.TYPE_LAPINE)
				bunnyCounter++;
			if (hasTail(GLOBAL.TYPE_LAPINE))
				bunnyCounter++;
			if (earType == GLOBAL.TYPE_LAPINE)
				bunnyCounter++;
			if (legType == GLOBAL.TYPE_LAPINE)
				bunnyCounter++;
			//More than 2 balls reduces bunny score
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			//Human skin on bunmorph adds
			if (skinType == GLOBAL.SKIN_TYPE_SKIN && bunnyCounter > 1)
				bunnyCounter++;
			//No wings and antennae a plus
			if (bunnyCounter > 0 && !hasAntennae())
				bunnyCounter++;
			if (bunnyCounter > 0 && !hasWings())
				bunnyCounter++;
			return bunnyCounter;
		}
		//Harpyscore
		public function harpyScore():Number
		{
			var harpy:Number = 0;
			if (armType == GLOBAL.TYPE_AVIAN)
				harpy++;
			if (hairType == GLOBAL.HAIR_TYPE_FEATHERS)
				harpy++;
			if (wingType == GLOBAL.TYPE_AVIAN)
				harpy++;
			if (hasTail(GLOBAL.TYPE_AVIAN))
				harpy++;
			if (legType == GLOBAL.TYPE_AVIAN)
				harpy++;
			if (harpy >= 2 && faceType == GLOBAL.TYPE_HUMAN)
				harpy++;
			if (harpy >= 2 && (earType == GLOBAL.TYPE_HUMAN || earType == GLOBAL.TYPE_SYLVAN))
				harpy++;
			return harpy;
		}
		public function spiderScore():Number
		{
			var score:Number = 0;
			if (eyeType == GLOBAL.TYPE_ARACHNID) score += 2;
			if (faceType == GLOBAL.TYPE_ARACHNID) score++;
			if (earType == GLOBAL.TYPE_SYLVAN) score++;
			if (armType == GLOBAL.TYPE_ARACHNID && hasArmFlag(GLOBAL.FLAG_CHITINOUS)) score++;
			if (legType == GLOBAL.TYPE_ARACHNID && hasLegFlag(GLOBAL.FLAG_CHITINOUS) && hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) score += 2;
			if (hasTail(GLOBAL.TYPE_ARACHNID)) score += 2;
			if (skinType != GLOBAL.SKIN_TYPE_SKIN && score > 0) score--;
			return score;
		}
		//Determine Dragon Rating
		public function dragonScore():Number
		{
			var dragonCounter:Number = 0;
			if (faceType == GLOBAL.TYPE_DRACONIC)
				dragonCounter++;
			if (earType == GLOBAL.TYPE_DRACONIC)
				dragonCounter++;
			if (hasTail(GLOBAL.TYPE_DRACONIC))
				dragonCounter++;
			if (tongueType == GLOBAL.TYPE_DRACONIC)
				dragonCounter++;
			if (cockTotal(GLOBAL.TYPE_DRACONIC) > 0)
				dragonCounter++;
			if (hasWings(GLOBAL.TYPE_DRACONIC) || hasWings(GLOBAL.TYPE_SMALLDRACONIC))
				dragonCounter++;
			if (legType == GLOBAL.TYPE_DRACONIC)
				dragonCounter++;
			if (hasHorns(GLOBAL.TYPE_DRACONIC) || hasHorns(GLOBAL.TYPE_LIZAN))
				dragonCounter++;
			if (skinType == GLOBAL.SKIN_TYPE_SCALES && dragonCounter > 0)
				dragonCounter++;
			if (hasPerk("Dragonfire"))
				dragonCounter++;
			return dragonCounter;
		}
		public function humanScore(): int {
			var counter: int = 0;
			if (skinType == GLOBAL.SKIN_TYPE_SKIN) counter++;
			if (armType == GLOBAL.TYPE_HUMAN && !hasArmFlag(GLOBAL.FLAG_GOOEY)) counter++;
			if (legType == GLOBAL.TYPE_HUMAN && legCount == 2 && hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) counter++;
			if (faceType == GLOBAL.TYPE_HUMAN) counter++;
			if (earType == GLOBAL.TYPE_HUMAN) counter++;
			if (eyeType == GLOBAL.TYPE_HUMAN) counter++;
			if (hasHair() && hairType != GLOBAL.HAIR_TYPE_REGULAR) counter--;
			if (hasTail()) counter--;
			if (wingType != 0) counter--;
			if (isGoo() || isTaur() || isNaga() || isDrider()) counter -= 2;
			return counter;
		}
		public function ausarScore(): int {
			var counter: int = 0;
			if (earType == GLOBAL.TYPE_CANINE) counter++;
			if (hasTail(GLOBAL.TYPE_CANINE) && hasTailFlag(GLOBAL.FLAG_LONG) && hasTailFlag(GLOBAL.FLAG_FLUFFY) && hasTailFlag(GLOBAL.FLAG_FURRED)) counter++;
			if (armType == GLOBAL.TYPE_CANINE) counter++;
			if (legType == GLOBAL.TYPE_CANINE && legCount == 2 && hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) counter++;
			if (counter > 0 && faceType == GLOBAL.TYPE_HUMAN) counter++;
			return counter;
		}
		public function kaithritScore(): int {
			var counter: int = 0;
			if (earType == GLOBAL.TYPE_FELINE) counter++;
			if (tailType == GLOBAL.TYPE_FELINE && tailCount == 1) counter++;
			if (tailType == GLOBAL.TYPE_FELINE && tailCount == 2) counter += 2;
			if (counter > 0 && faceType == GLOBAL.TYPE_HUMAN) counter++;
			if (counter > 1 && armType == GLOBAL.TYPE_FELINE && !hasArmFlag(GLOBAL.FLAG_FURRED)) counter++;
			if (counter > 2 && legType == GLOBAL.TYPE_HUMAN && legCount == 2 && hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) counter++;
			if (counter > 3 && eyeType == GLOBAL.TYPE_FELINE && faceType == GLOBAL.TYPE_HUMAN) counter += 2;
			if (counter > 5 && hasCock(GLOBAL.TYPE_FELINE)) counter++;
			if (femininity < 75) counter--;
			if (femininity < 50 && !hasBreasts()) counter--;
			return counter;
		}
		public function leithanScore():int {
			var counter:int = 0;
			if (earType == GLOBAL.TYPE_LEITHAN) counter++;
			if (legType == GLOBAL.TYPE_LIZAN && legCount == 6) counter += 2;
			if (armType == GLOBAL.TYPE_LEITHAN && hasArmFlag(GLOBAL.FLAG_CHITINOUS)) counter++;
			if (tongueType == GLOBAL.TYPE_LEITHAN) counter++;
			if (hasTail(GLOBAL.TYPE_LIZAN)) counter++;
			if (counter > 0 && skinType == GLOBAL.SKIN_TYPE_SCALES && scaleColor == "black") counter++;
			if (counter > 3 && eyeType == GLOBAL.TYPE_LEITHAN && faceType == GLOBAL.TYPE_HUMAN) counter += 2;
			if (eyeType != GLOBAL.TYPE_LEITHAN) counter--;
			return counter;
		}
		public function nukiScore(): int
		{
			var counter:int = 0;
			if (earType == GLOBAL.TYPE_KUITAN) counter++;
			if (hasTail(GLOBAL.TYPE_KUITAN) && hasTailFlag(GLOBAL.FLAG_LONG)) counter++;
			if (faceType == GLOBAL.TYPE_KUITAN) counter++;
			if (armType == GLOBAL.TYPE_KUITAN) counter++;
			if (legType == GLOBAL.TYPE_KUITAN) counter++;
			if (hasCock(GLOBAL.TYPE_KUITAN)) counter++;
			if (counter > 1 && hasCock() && balls >= 2) counter++;
			return counter;
		}
		public function gooScore():int
		{
			var counter:int = 0;
			if (legType == GLOBAL.TYPE_GOOEY)
			{
				counter += 2;
				if (hasLegFlag(GLOBAL.FLAG_AMORPHOUS)) counter += 2;
			}
			if (hairType == GLOBAL.HAIR_TYPE_GOO) counter++;
			if (hasStatusEffect("Goo Vent")) counter++;
			if (hasStatusEffect("Goo Crotch")) counter++;
			if (hasStatusEffect("Gel Body")) counter++;
			if (counter > 1 && skinType == GLOBAL.SKIN_TYPE_GOO) counter++;
			//if (counter > 2 && tongueType == GLOBAL.TYPE_GOOEY) counter++;
			return counter;
		}
		public function cowScore():int
		{
			var counter:int = 0;
			if (bovineScore() >= 2)
			{
				counter += bovineScore();
				if (isLactating()) counter++;
				if (hipRating() >= 20) counter++;
				if (nippleLengthRatio >= 2) counter++;
				if (nipplesPerBreast == 4) counter++;
				if (totalBreasts() >= 4) counter++;
				if (isMilkTank()) counter++;
			}
			return counter;
		}
		public function bovineScore():int
		{
			var counter:int = 0;
			if (earType == GLOBAL.TYPE_BOVINE) counter++;
			if (hasHorns(GLOBAL.TYPE_BOVINE)) counter++;
			if (hasTail(GLOBAL.TYPE_BOVINE) && hasTailFlag(GLOBAL.FLAG_LONG) && hasTailFlag(GLOBAL.FLAG_FLUFFY)) counter++;
			if (legType == GLOBAL.TYPE_BOVINE) counter++;
			//if (tongueType == GLOBAL.TYPE_BOVINE && hasTongueFlag(GLOBAL.FLAG_LONG)) counter++;
			if (faceType == GLOBAL.TYPE_BOVINE) counter += 2;
			if (hasScales()) counter--;
			return counter;
		}
		public function badgerScore():int
		{
			var counter:int = 0;
			if (hasTail(GLOBAL.TYPE_BADGER)) counter++;
			if (armType == GLOBAL.TYPE_BADGER) counter++;
			if (faceType == GLOBAL.TYPE_BADGER) counter++;
			if (counter > 0 && skinType == GLOBAL.SKIN_TYPE_FUR) counter++;
			return counter;
		}
		public function canineScore(): int {
			var counter: int = 0;
			if (earType == GLOBAL.TYPE_CANINE) counter++;
			if (hasTail(GLOBAL.TYPE_CANINE) && hasTailFlag(GLOBAL.FLAG_FURRED)) counter++;
			if (armType == GLOBAL.TYPE_CANINE && hasArmFlag(GLOBAL.FLAG_FURRED)) counter++;
			if (legType == GLOBAL.TYPE_CANINE && hasLegFlag(GLOBAL.FLAG_DIGITIGRADE)) counter++;
			if (faceType == GLOBAL.TYPE_CANINE) counter++;
			if (counter > 1 && cockTotal(GLOBAL.TYPE_CANINE) == cockTotal() && totalKnots() == cockTotal()) counter++;
			return counter;
		}
		public function demonScore(): int
		{
			var counter: int = 0;
			if (hasHorns(GLOBAL.TYPE_DEMONIC)) counter++;
			if (earType == GLOBAL.TYPE_DEMONIC) counter++;
			if (armType == GLOBAL.TYPE_DEMONIC) counter++;
			if (hasTail(GLOBAL.TYPE_DEMONIC)) counter++;
			if (wingType == GLOBAL.TYPE_DEMONIC || wingType == GLOBAL.TYPE_SMALLDEMONIC) counter++;
			if (counter > 1 && (legType == GLOBAL.TYPE_DEMONIC || legType == GLOBAL.TYPE_SUCCUBUS || legType == GLOBAL.TYPE_BOVINE)) counter++;
			if (counter > 2 && eyeType == GLOBAL.TYPE_DEMONIC && faceType == GLOBAL.TYPE_HUMAN) counter++;
			if (counter > 3 && hasCock(GLOBAL.TYPE_DEMONIC)) counter++;
			return counter;
		}
		public function felineScore(): int {
			var counter: int = 0;
			if (earType == GLOBAL.TYPE_FELINE) counter++;
			if (hasTail(GLOBAL.TYPE_FELINE)) counter++;
			if (faceType == GLOBAL.TYPE_FELINE || faceType == GLOBAL.TYPE_NALEEN_FACE) counter++;
			if (armType == GLOBAL.TYPE_FELINE && hasArmFlag(GLOBAL.FLAG_FURRED)) counter++;
			if (legType == GLOBAL.TYPE_FELINE && hasLegFlag(GLOBAL.FLAG_DIGITIGRADE)) counter++;
			if (eyeType == GLOBAL.TYPE_FELINE && faceType == GLOBAL.TYPE_FELINE) counter++;
			if (counter > 1 && cockTotal(GLOBAL.TYPE_FELINE) == cockTotal()) counter++;
			return counter;
		}
		public function frogScore(): int
		{
			var counter: int = 0;
			if (skinType == GLOBAL.SKIN_TYPE_SKIN && hasSkinFlag(GLOBAL.FLAG_LUBRICATED)) counter++;
			if (legType == GLOBAL.TYPE_FROG) counter++;
			if (armType == GLOBAL.TYPE_FROG) counter++;
			if (hasTail(GLOBAL.TYPE_FROG)) counter++;
			if (faceType == GLOBAL.TYPE_FROG) counter++;
			if (faceType == GLOBAL.TYPE_FROG || faceType == GLOBAL.TYPE_HUMAN)
			{
				if (eyeType == GLOBAL.TYPE_FROG) counter++;
				if (earType == GLOBAL.TYPE_FROG) counter++;
				if (tongueType == GLOBAL.TYPE_FROG) counter++;
			}
			if (hasFur() || hasFeathers()) counter--;
			if (!hasFlatNipples() && !hasInvertedNipples()) counter--;
			return counter;
		}
		public function gabilaniScore():int
		{
			var counter:int = 0;
			if (skinType == GLOBAL.SKIN_TYPE_SKIN && InCollection(skinTone, "green", "lime", "emerald", "aqua", "pale blue", "turquoise", "yellow", "amber", "topaz")) counter++;
			if (tallness >= 24 && tallness <= 48) counter++;
			if (earType == GLOBAL.TYPE_GABILANI) counter++;
			if (counter > 0 && faceType == GLOBAL.TYPE_GABILANI && !hasFaceFlag(GLOBAL.FLAG_MUZZLED))
			{
				counter++;
				if (eyeType == GLOBAL.TYPE_GABILANI) counter++;
				if (counter > 2 && isCyborg()) counter += cyborgScore();
			}
			if (counter > 3 && hasCock(GLOBAL.TYPE_GABILANI)) counter++;
			if (counter > 3 && hasVaginaType(GLOBAL.TYPE_GABILANI)) counter++;
			if (!isBiped() || !hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) counter--;
			if (tallness >= 72) counter--;
			if (tallness >= 84) counter--;
			if (tallness >= 96) counter--;
			return counter;
		}
		public function horseScore(): int
		{
			var counter:int = 0;
			if (earType == GLOBAL.TYPE_EQUINE) counter++;
			if (hasTail(GLOBAL.TYPE_EQUINE) && hasTailFlag(GLOBAL.FLAG_LONG)) counter++;
			if (faceType == GLOBAL.TYPE_EQUINE) counter++;
			if (armType == GLOBAL.TYPE_EQUINE) counter++;
			if (legType == GLOBAL.TYPE_EQUINE) counter++;
			if (counter > 2 && cockTotal(GLOBAL.TYPE_EQUINE) > 0) counter++;
			if (counter > 2 && vaginaTotal(GLOBAL.TYPE_EQUINE) > 0) counter++;
			if (counter > 3 && hairType == GLOBAL.HAIR_TYPE_REGULAR && hasPerk("Mane")) counter++;
			return counter;
		}
		public function myrScore(): int
		{
			var counter:int = 0;
			if (eyeType == GLOBAL.TYPE_MYR) counter++;
			if (armType == GLOBAL.TYPE_MYR) counter++;
			if (legType == GLOBAL.TYPE_MYR) counter++;
			if (antennae == 2 && antennaeType == GLOBAL.TYPE_MYR) counter++;
			if (counter > 0 && earType == GLOBAL.TYPE_SYLVAN) counter++;
			if (counter > 0 && canLactate() && milkType == GLOBAL.FLUID_TYPE_HONEY) counter++;
			if (hasFur() || hasScales()) counter--;
			return counter;
		}
		public function redMyrScore():int
		{
			var counter:int = myrScore();
			if (hasPerk("Myr Venom")) counter += 4;
			if (scaleColor == "red" && (armType == GLOBAL.TYPE_MYR || legType == GLOBAL.TYPE_MYR)) counter += 2;
			return counter;
		}
		public function goldMyrScore(): int
		{
			var counter:int = myrScore();
			if (hasPerk("Honeypot")) counter += 4;
			if (tailType == GLOBAL.TYPE_MYR && tailCount == 1) counter += 3;
			if (scaleColor == "gold" && (armType == GLOBAL.TYPE_MYR || legType == GLOBAL.TYPE_MYR)) counter += 2;
			return counter;
		}
		public function orangeMyrScore():int
		{
			var counter:int = myrScore();
			if (kGAMECLASS.flags["MCALLISTER_MYR_HYBRIDITY"] >= 3)
			{
				if (hasPerk("Honeypot") && hasPerk("Myr Venom")) counter += 4;
				if (tailType == GLOBAL.TYPE_MYR && tailCount == 1) counter++;
				if (scaleColor == "orange" && (armType == GLOBAL.TYPE_MYR || legType == GLOBAL.TYPE_MYR)) counter += 5;
			}
			return counter;
		}
		public function naleenScore(): int
		{
			var counter: int = 0;
			if (isNaga()) counter += 2;
			if (faceType == GLOBAL.TYPE_NALEEN_FACE)
			{
				counter++;
				if (eyeType == GLOBAL.TYPE_NAGA) counter++;
				if (earType == GLOBAL.TYPE_FELINE) counter++;
			}
			if (hasGenitals() && hasStatusEffect("Genital Slit"))
			{
				counter++;
				if (hasCock(GLOBAL.TYPE_NAGA)) counter++;
				if (hasVaginaType(GLOBAL.TYPE_NAGA)) counter++;
			}
			if (counter > 0 && skinType == GLOBAL.SKIN_TYPE_FUR) counter++;
			if (counter > 0 && armType == GLOBAL.TYPE_FELINE && hasArmFlag(GLOBAL.FLAG_FURRED)) counter++;
			return counter;
		}
		public function nyreaScore(): int
		{
			var counter:int = 0;
			if (eyeType == GLOBAL.TYPE_NYREA) counter++;
			if (armType == GLOBAL.TYPE_NYREA) counter++;
			if (legType == GLOBAL.TYPE_NYREA) counter++;
			if (faceType == GLOBAL.TYPE_HUMAN)
			{
				if (earType == GLOBAL.TYPE_SYLVAN) counter++;
				if (hasHair() && hairType == GLOBAL.HAIR_TYPE_QUILLS) counter++;
			}
			if (counter > 2 && hasCock(GLOBAL.TYPE_NYREA) && cumType == GLOBAL.FLUID_TYPE_NYREA_CUM) counter++;
			if (counter > 2 && hasVaginaType(GLOBAL.TYPE_NYREA) && girlCumType == GLOBAL.FLUID_TYPE_NYREA_GIRLCUM) counter++;
			if (hasFur() || hasScales()) counter--;
			return counter;
		}
		public function ovirScore():int
		{
			var score:int = 0;
			if (skinType == GLOBAL.SKIN_TYPE_SCALES && InCollection(scaleColor, "green", "purple", "red", "yellow", "brown", "tan", "olive green")) score++;
			if (hasTail(GLOBAL.TYPE_OVIR)) score++;
			if (eyeType == GLOBAL.TYPE_SNAKE && InCollection(eyeColor, "green", "blue", "yellow", "red", "gray")) score++;
			if (tongueType == GLOBAL.TYPE_OVIR) score++;
			if (legType == GLOBAL.TYPE_OVIR) score++;
			if (armType == GLOBAL.TYPE_OVIR && legType == GLOBAL.TYPE_OVIR) score++;
			if (hasCock(GLOBAL.TYPE_EQUINE) && (balls == 0 || hasStatusEffect("Uniball"))) score++;
			if ((hasCock(GLOBAL.TYPE_EQUINE) || hasVagina()) && hasStatusEffect("Genital Slit")) score++;
			if (score > 0 && (faceType == GLOBAL.TYPE_HUMAN && !hasFaceFlag(GLOBAL.FLAG_MUZZLED))) score++;
			return score;
		}
		public function pandaScore(): int
		{
			var counter:int = 0;
			if (earType == GLOBAL.TYPE_PANDA) counter++;
			if (hasTail(GLOBAL.TYPE_PANDA)) counter++;
			if (faceType == GLOBAL.TYPE_PANDA) counter++;
			if (armType == GLOBAL.TYPE_PANDA) counter++;
			if (legType == GLOBAL.TYPE_PANDA) counter++;
			if (counter > 0 && thickness >= 65) counter++;
			//if (cockTotal(GLOBAL.TYPE_PANDA) > 0) counter++;
			//if (vaginaTotal(GLOBAL.TYPE_PANDA) > 0) counter++;
			return counter;
		}
		public function raskvelScore(): int
		{
			var counter:int = 0;
			if (earType == GLOBAL.TYPE_RASKVEL) counter++;
			if (hasTail(GLOBAL.TYPE_RASKVEL) && hasTailFlag(GLOBAL.FLAG_SCALED)) counter++;
			if (legType == GLOBAL.TYPE_RASKVEL) counter++;
			if (counter > 0 && skinType == GLOBAL.SKIN_TYPE_SCALES) counter++;
			if (counter > 1 && hasCock(GLOBAL.TYPE_RASKVEL)) counter++;
			if (counter > 1 && hasVagina() && totalClits()/totalVaginas() == 2) counter++;
			if (counter > 2 && hairType == GLOBAL.HAIR_TYPE_FEATHERS) counter++;
			if (counter > 4 && hasTongueFlag(GLOBAL.FLAG_LONG) && hasTongueFlag(GLOBAL.FLAG_PREHENSILE)) counter++;
			return counter;
		}
		public function vanaeScore(): int
		{
			var counter:int = 0;
			if (earType == GLOBAL.TYPE_VANAE) counter++;
			if (hasTail(GLOBAL.TYPE_VANAE) && hasTailFlag(GLOBAL.FLAG_LONG)) counter++;
			if (hasVaginaType(GLOBAL.TYPE_VANAE)) counter++;
			if (totalVaginas(GLOBAL.TYPE_VANAE) == totalVaginas()) counter++;
			if (cockTotal(GLOBAL.TYPE_VANAE) == cockTotal()) counter++;
			if (balls > 0 && statusEffectv4("Vanae Markings") >= 1) counter++;
			if (InCollection(milkType, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK)) counter++;
			if (cumType == GLOBAL.FLUID_TYPE_VANAE_CUM) counter++;
			if (hasStatusEffect("Vanae Markings")) counter++;
			if (counter > 0 && hairType == GLOBAL.HAIR_TYPE_TENTACLES) counter++;
			return counter;
		}
		public function zilScore(): int
		{
			var counter: int = 0;
			if (armType == GLOBAL.TYPE_BEE) counter++;
			if (legType == GLOBAL.TYPE_BEE && legCount == 2) counter++;
			if (antennae == 2 && antennaeType == GLOBAL.TYPE_BEE) counter++;
			if (wingType == GLOBAL.TYPE_SMALLBEE || wingType == GLOBAL.TYPE_BEE) counter++;
			if (hasTail(GLOBAL.TYPE_BEE)) counter++;
			if (counter > 0 && faceType == GLOBAL.TYPE_HUMAN)
			{
				counter++;
				if (eyeType == GLOBAL.TYPE_BEE) counter++;
				if (tongueType == GLOBAL.TYPE_BEE) counter++;
			}
			if (counter > 0 && hasCock(GLOBAL.TYPE_BEE)) counter++;
			if (counter > 0 && hasVaginaType(GLOBAL.TYPE_BEE)) counter++;
			return counter;
		}
		public function isRahn(): Boolean {
			if(InCollection(race(), "rahn", "fuu'rahn", "zel'rahn", "loo'rahn", "doh'rahn", "go'rahn")) return true;
			else if (race().indexOf("rahn") != -1) return true;
			return false;
		}
		public function cyborgScore():int
		{
			var counter:int = 0;
			// List of valid synth/cyborg parts here!
			//if (skinType == 9999) counter++;
			//if (hairType == 9999) counter++;
			//if (faceType == 9999) counter++;
			//if (tongueType == 9999) counter++;
			if (eyeType == GLOBAL.TYPE_SYNTHETIC) counter++;
			//if (earType == 9999) counter++;
			//if (armType == 9999) counter++;
			//if (legType == 9999) counter++;
			//if (wingType == 9999) counter++;
			//if (tailType == 9999) counter++;
			if (cockTotal(GLOBAL.TYPE_SYNTHETIC) > 0) counter++;
			if (totalVaginas(GLOBAL.TYPE_SYNTHETIC) > 0) counter++;
			//if (milkType == 9999) counter++;
			if (cumType == GLOBAL.FLUID_TYPE_OIL) counter++;
			//if (girlCumType == 9999) counter++;
			return counter;
		}
		public function isCyborg(numParts:int = 1):Boolean
		{
			if(cyborgScore() >= numParts) return true;
			return false;
		}
		public function sackDescript(forceAdjectives: Boolean = false, adjectives: Boolean = true): String {
			var desc: String = "";
			if ((adjectives && rand(3) == 0) || forceAdjectives) {
				if (ballFullness <= 0) desc += "painfully empty ";
				else if (ballFullness <= 20) desc += "empty ";
				else if (ballFullness >= 80 && ballFullness < 100) desc += "mostly full ";
				else if (ballFullness >= 100) {
					var temp: int = rand(5);
					if (temp == 0) desc += "full ";
					else if (temp == 1) desc += "sloshing ";
					else if (temp == 2) desc += "stuffed ";
					else if (temp == 3) desc += "bloated ";
					else desc += "cum-packed ";
				}
			}
			if (balls == 0) return "prostate";
			temp = rand(2);
			if (temp == 0) desc += "scrotum";
			if (temp == 1) desc += "sack";
			return desc;
		}
		public function cockClit(number: int = 0): String {
			if (hasCock() && number >= 0 && number < cockTotal()) return cockDescript(number);
			else return clitDescript();
		}
		public function sheathDescript(arg: Number = 0): String {
			if (hasSheath(arg)) return "sheath";
			else return "base";
		}
		public function knotDescript(arg: Number): String {
			if (hasKnot(arg)) return "knot";
			else return "base";
		}
		public function chestDesc(): String {
			if (biggestTitSize() < 1 && rand(2) == 0)
			{
				var adjective:String = "";
				if (tone >= 100)
				{
					if (rand(4) == 0) adjective += mf("extremely pronounced","very pronounced");
					else if (thickness > 70) adjective += "immense";
					else if (thickness >= 30) adjective += "robust";
					else adjective += "chiseled";
				}
				else if (tone > 70)
				{
					if (rand(4) == 0) adjective += mf("well-defined","well-toned");
					else if (thickness > 70) adjective += "broad";
					else if (thickness >= 30) adjective += "healthy";
					else adjective += "fit";
				}
				else if (tone >= 30)
				{
					if (rand(4) == 0) adjective += mf("toned","lightly-toned");
					else if (thickness > 70) adjective += "thick";
					else if (thickness >= 30) adjective += "average";
					else adjective += "soft";
				}
				else
				{
					if (rand(4) == 0) adjective += "unremarkable";
					else if (thickness > 70) adjective += "wide";
					else if (thickness >= 30) adjective += "passable";
					else adjective += "flat";
				}
				if (rand(4) > 0 && adjective.length > 0) return (adjective + " chest");
				
				return "chest";
			}
			else if (biggestTitSize() < 1)
			{
				// Feminine/Andro, Low/Medium Tone
				if((mfn("m","f","n") != "m") && tone < 60) {
					if (rand(3) == 0) return "soft, flat chest";
					else if (rand(2) == 0) return "flat, girly chest";
					else return "smooth, featureless chest";
				}
				// Masculine, High Tone, High Thickness
				else if((mf("m","f") == "m") && tone >= 60 && thickness >= 60) {
					if (rand(3) == 0) return "manly, rippling chest";
					else if (rand(2) == 0) return "big, muscular chest";
					else return "beefcake chest";
				}
				// Masculine, Low Tone, High Thickness
				else if((mf("m","f") == "m") && tone <= 30 && thickness >= 60) {
					if (rand(3) == 0) return "broad, cuddly chest";
					else if (rand(2) == 0) return "bear-like chest";
					else return "fleshy, manly chest";
				}
				// Masculine/Feminine/Andro, High Tone, Low Thickness
				else if(tone >= 60 && thickness <= 30) {
					if (rand(3) == 0) return mf("tight, firm pecs","firm, flat chest");
					else if (rand(2) == 0) return mf("hard, sleek chest","athletic chest");
					else return mf("fine, flat pecs","sleek, firm chest");
				}
				// Default
				else {
					if (rand(3) == 0) return "plain chest";
					else if (rand(2) == 0) return "flat chest";
					else return "chest";
				}
			}
			else return biggestBreastDescript();
		}
		public function allChestDesc(): String {
			if (biggestTitSize() < 1) return chestDesc();
			else return allBreastsDescript();
		}
		public function eachCock(dynamicLength:Boolean = false): String {
			var desc: String = "";
			if (totalCocks() > 1) desc += "each of ";
			desc += "your " + cocksDescript(dynamicLength);
			return desc;
		}
		public function oneCock(dynamicLength:Boolean = false): String {
			var desc: String = "";
			if (totalCocks() > 1) desc += "one of ";
			desc += "your " + cocksDescript(dynamicLength);
			return desc;
		}
		public function ballsDescript(forceCount: Boolean = false, forceSize: Boolean = false, forceSingular: Boolean = false, appearance: Boolean = false): String {
			if (balls == 0) return "prostate";
			var descripted: int = 0;
			var rando: Number = 0;
			var desc: String = "";
			//Changed up the formatting here since this is only for appearance screens
			if (forceCount && !forceSingular) {
				if (balls == 1) {
					rando = rand(4);
					if (rando == 0) desc += "a single ";
					if (rando == 1) desc += "a solitary ";
					if (rando == 2) desc += "a lone ";
					if (rando == 3) desc += "an individual ";
				}
				else if (balls == 2) {
					rando = rand(3);
					if (rando == 0) desc += "a pair of ";
					if (rando == 1) desc += "two ";
					if (rando == 2) desc += "two ";
				}
				else if (balls == 3) {
					rando = rand(3);
					if (rando == 0) desc += "three ";
					if (rando == 1) desc += "three ";
					if (rando == 2) desc += "a trio of ";
				}
				else if (balls == 4) {
					rando = rand(3);
					if (rando == 0) desc += "a quartette of ";
					if (rando == 1) desc += "four ";
					if (rando == 2) desc += "four ";
				}
				else desc += num2Text(balls) + " ";
			}
			//Not in appearance screen? Okay
			else if (!hasStatusEffect("Uniball") && rand(5) == 0 && !forceSingular) {
				if (balls == 1) {
					rando = rand(3);
					if (rando == 0) desc += "single ";
					if (rando == 1) desc += "solitary ";
					if (rando == 2) desc += "lone ";
				}
				else if (balls == 2) {
					rando = rand(3);
					if (rando == 0) desc += "pair of ";
					if (rando == 1) desc += "two ";
					if (rando == 2) desc += "two ";
				}
				else if (balls == 3) {
					rando = rand(3);
					if (rando == 0) desc += "three ";
					if (rando == 1) desc += "triple ";
					if (rando == 2) desc += "trio of ";
				}
				else if (balls == 4) {
					rando = rand(3);
					if (rando == 0) desc += "quartette of ";
					if (rando == 1) desc += "four ";
					if (rando == 2) desc += "four ";
				}
				else desc += num2Text(balls) + " ";
			}
			//size!
			if (ballSize() > 1 && (rand(3) <= 1 || forceSize)) {
				if (descripted > 0) desc += ", ";
				if (ballDiameter() <= 1) {}
				else if (ballDiameter() < 2) desc += "large";
				else if (ballDiameter() < 3) desc += "baseball-sized";
				else if (ballDiameter() < 4) desc += "apple-sized";
				else if (ballDiameter() < 5) desc += "grapefruit-sized";
				else if (ballDiameter() < 7) desc += "cantaloupe-sized";
				else if (ballDiameter() < 9) desc += "soccerball-sized";
				else if (ballDiameter() < 12) desc += "basketball-sized";
				else if (ballDiameter() < 15) desc += "watermelon-sized";
				else if (ballDiameter() < 25) desc += "beachball-sized";
				else if (ballDiameter() < 40) desc += "barrel-sized";
				else if (ballDiameter() < 60) desc += "person-sized";
				else desc += "hideously swollen and oversized";
				if (ballDiameter() > 1) descripted++;
			}
			//Uniball
			if (hasStatusEffect("Uniball") && rand(3) == 0) {
				if (descripted > 0) desc += ", ";
				rando = rand(4);
				if (rando == 0) desc += "tightly-compressed";
				else if (rando <= 1) desc += "snug";
				else if (rando <= 2) desc += "cute";
				else if (rando <= 3) desc += "pleasantly squeezed";
				else desc += "compressed-together";
				descripted++;
			}
			//Descriptive
			if (ballFullness >= 100 && rand(3) == 0 && !forceSize) {
				if (descripted > 0) desc += ", ";
				rando = rand(3);
				if (rando == 0) desc += "overflowing";
				else if (rando == 1) desc += "swollen";
				else desc += "practically sloshing";
				descripted++;
			} else if (ballFullness >= 80 && rand(3) == 0 && !forceSize) {
				if (descripted > 0) desc += ", ";
				rando = rand(3);
				if (rando == 0) desc += "full";
				else if (rando == 1) desc += "heavy";
				else desc += "cum-engorged";
				descripted++;
			}
			//lusty
			else if (lust() > 90 && !descripted && rand(2) == 0 && !forceSize) {
				if (descripted > 0) desc += ", ";
				rando = rand(6);
				if (rando == 0) desc += "eager";
				else if (rando == 1) desc += "trembling";
				else if (rando == 2) desc += "needy";
				else if (rando == 3) desc += "desperate";
				else if (rando == 4) desc += "throbbing";
				else if (rando == 5) desc += "quaking";
				else desc += "heated";
				descripted++;
			}
			if (descripted) desc += " ";
			rando = rand(9);
			if (rando < 4) {
				if (balls == 4 && rand(2) == 0) desc += "quad ";
				desc += "ball";
			}
			if (rando >= 4 && rando < 6) desc += "testicle";
			if (rando == 6) desc += "teste";
			if (rando == 7) desc += "gonad";
			if (rando == 8) desc += "nut";
			if (balls > 0 || !forceSingular) desc += "s";
			return desc;
		}
		public function ballDescript(forceCount: Boolean = false, forcedSize: Boolean = false): String {
			return ballsDescript(forceCount, forcedSize, true);
		}
		public function ballNoun(asPlural:Boolean = true):String
		{
			var rando:int = 0;
			var desc:String = "";
			rando = rand(11);

			if (rando < 4) desc += "ball";
			else if (rando <= 6) 
			{
				if(!asPlural) desc += "testicle";
				else desc += "teste";
			}
			else if (rando <= 7) desc += "gonad";
			else desc += "nut";
			if (asPlural) desc = plural(desc);
			return desc;
		}
		public function assholeDescript(): String {
			var desc: String = "";
			var rando: Number = 0;
			var descripted: Number = 0;
			//25% tightness desc
			if (rand(4) == 0 || (ass.looseness() <= 1 && rand(4) <= 2)) {
				if (descripted > 0) desc += ", ";
				if (analVirgin) {
					if (rand(3) == 0) desc += "virgin";
					else if (rand(2) == 0) desc += "unspoiled";
					else desc += "unclaimed";
				} else if (ass.looseness() <= 1) {
					if (rand(2) == 0) desc += "tight";
					else desc += "narrow";
				} else if (ass.looseness() <= 2) {
					if (rand(2) == 0) desc += "pliant";
					else desc += "supple";
				} else if (ass.looseness() <= 3) {
					if (rand(2) == 0) desc += "loose";
					else desc += "welcoming";
				} else if (ass.looseness() <= 4) {
					if (rand(2) == 0) desc += "stretched";
					else desc += "broad";
				} else if (ass.looseness() <= 5) {
					if (rand(3) == 0) desc += "gaping";
					else if (rand(2) == 0) desc += "wide-open";
					else desc += "expansive";
				}
				//Account for larger values of loosness!
				else if (ass.looseness() > 5) {
					if (rand(3) == 0) desc += "elastically yawning";
					else if (rand(2) == 0) desc += "completely cavernous";
					else desc += "excessively agape";
				}
				descripted++;
			}
			//66% wetness description
			if (rand(3) <= 1 && ass.wetness() >= 2) {
				if (descripted > 0) desc += ", ";
				if (ass.wetness() <= 2) {
					if (rand(2) == 0) desc += "moist";
					else desc += "lubricated";
				} else if (ass.wetness() <= 3) {
					if (rand(2) == 0) desc += "slimy";
					else desc += "slick";
				} else if (ass.wetness() <= 4) {
					if (rand(2) == 0) desc += "lube-drooling";
					else desc += "soaked";
				} else if (ass.wetness() <= 5) {
					if (rand(2) == 0) desc += "slime-drooling";
					else desc += "immaculately lubricated";
				}
				//Account for larger values of wetness!
				else if (ass.wetness() > 5) {
					if (rand(2) == 0) desc += "lube-flooding";
					else desc += "slime-spilling";
				}
				descripted++;
			}
			
			if (descripted > 0) desc += " ";
			//Butt descriptor
			rando = rand(18);
			if (rando <= 2) desc += "ass";
			else if (rando <= 5) desc += "anus";
			else if (rando <= 7) desc += "pucker";
			else if (rando <= 10) desc += "asshole";
			else if (rando == 11) desc += "bum";
			else if (rando == 12) desc += "butthole";
			else if (rando == 13) desc += "sphincter";
			else if (rando <= 15) desc += "backdoor";
			else {
				if (tailType > 0) desc += "tailhole";
				else desc += "butthole";
			}
			return desc;
		}
		public function hipDescript(asPlural:Boolean = false):String 
		{
			var desc: String = "";
			var rando: Number = 0;
			if (hipRating() <= 1) {
				if (thickness > 70) {
					rando = rand(3);
					if (rando == 0) desc = "tiny ";
					else if (rando == 1) desc = "narrow ";
					else if (rando == 2) desc = "boyish ";
				}
				//Normal
				else if (thickness >= 30) {
					if (rand(2) == 0) desc = "boyish ";
					else desc = "tiny ";
				}
				//Uberthin
				else {
					rando = rand(3);
					if (rando == 0) desc = "tiny ";
					else if (rando == 1) desc = "narrow ";
					else if (rando == 2) desc = "boyish ";
				}
			} else if (hipRating() < 4) {
				rando = rand(3);
				if (rando == 0) desc = "slender ";
				else if (rando == 1) desc = "narrow ";
				else if (rando == 2) desc = "thin ";
				if (thickness < 30) {
					if (rand(2) == 0) desc = "slightly-flared ";
					else desc = "curved ";
				}
			} else if (hipRating() < 6) {
				rando = rand(2);
				if (rando == 0) desc = "well-formed ";
				else if (rando == 1) desc = "pleasant ";
				if (thickness < 30) {
					if (rand(2) == 0) desc = "flared ";
					else desc = "curvy ";
				}
			} else if (hipRating() < 10) {
				rando = rand(3);
				if (rando == 0) desc = "ample ";
				else if (rando == 1) desc = "noticeable ";
				else if (rando == 2) desc = "girly ";
				if (thickness < 30) {
					if (rand(2) == 0) desc = "flared ";
					else desc = "waspish ";
				}
			} else if (hipRating() < 15) {
				rando = rand(3);
				if (rando == 0) desc = "flared ";
				else if (rando == 1) desc = "curvy ";
				else if (rando == 2) desc = "wide ";
				if (thickness < 30) {
					if (rand(2) == 0) desc = "flared ";
					else desc = "waspish ";
				}
			} else if (hipRating() < 20) {
				if (femininity > 50 || hasVagina()) rando = rand(3);
				else rando = 0;
				if (thickness < 40) {
					if (rand(2) == 0) desc = "flared, ";
					else desc = "waspish, ";
				}
				if (rando == 0) desc += "voluptuous ";
				else if (rando == 1) desc += "fertile ";
				else if (rando == 2) desc += "child-bearing ";
			} else {
				if (femininity > 50 || hasVagina()) rando = rand(3);
				else rando = rand(2);
				if (thickness < 40) {
					if (rand(2) == 0) desc = "flaring, ";
					else desc = "incredibly waspish, ";
				}
				if (rando == 0) desc += "inhumanly-wide ";
				else if (rando == 1) desc += "cow-like ";
				else if (rando == 2) desc += "broodmother-sized ";
			}
			//Taurs
			if (isTaur() && rand(3) == 0) desc += "flank";
			//Non taurs or taurs who didn't roll flanks
			else {
				rando = rand(2);
				if (rando == 0) desc += "hip";
				else if (rando == 1) desc += "thigh";
			}
			if (asPlural) desc = plural(desc);
			return desc;
		}
		public function thighDescript():String {
			return "thigh";
		}
		public function thighsDescript():String {
			return plural(thighDescript());
		}
		public function hipsDescript(): String {
			return hipDescript(true);
		}
		public function buttDescript(asPlural:Boolean = false):String 
		{
			var desc: String = "";
			var rando: Number = 0;
			if (buttRating() <= 1) {
				if (tone >= 60) desc += "incredibly tight, perky ";
				else {
					if (rand(2) == 0) desc = "tiny";
					else if (rand(2) == 0) desc = "very small";
					else desc = "dainty";
					//Soft PC's buns!
					if (tone <= 30 && rand(3) == 0) desc += " yet soft";
					desc += " ";
				}
			} else if (buttRating() < 4) {
				if (tone >= 65) {
					rando = rand(6);
					if (rando == 0) desc = "perky, muscular ";
					else if (rando == 1) desc = "tight, toned ";
					else if (rando == 2) desc = "firm ";
					else if (rando == 3) desc = "compact, muscular ";
					else if (rando == 4) desc = "tight ";
					else if (rando == 5) desc = "muscular, toned ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(4);
					if (rando == 0) desc = "tight ";
					else if (rando == 1) desc = "firm ";
					else if (rando == 2) desc = "compact ";
					else if (rando == 3) desc = "petite ";
				}
				//FLABBAH
				else {
					rando = rand(7);
					if (rando == 0) desc = "small, heart-shaped ";
					else if (rando == 1) desc = "soft, compact ";
					else if (rando == 2) desc = "soft, heart-shaped ";
					else if (rando == 3) desc = "small, cushy ";
					else if (rando == 4) desc = "small ";
					else if (rando == 5) desc = "petite ";
					else if (rando == 6) desc = "snug ";
				}
			} else if (buttRating() < 6) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					rando = rand(6);
					if (rando == 0) desc = "nicely muscled ";
					else if (rando == 1) desc = "nice, toned ";
					else if (rando == 2) desc = "muscly ";
					else if (rando == 3) desc = "nice toned ";
					else if (rando == 4) desc = "toned ";
					else if (rando == 5) desc = "fair ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(2);
					if (rando == 0) desc = "nice ";
					else if (rando == 1) desc = "fair ";
				}
				//FLABBAH
				else {
					rando = rand(5);
					if (rando == 0) desc = "nice, cushiony ";
					else if (rando == 1) desc = "soft ";
					else if (rando == 2) desc = "nicely-rounded, heart-shaped ";
					else if (rando == 3) desc = "cushy ";
					else if (rando == 4) desc = "soft, squeezable ";
				}
			} else if (buttRating() < 8) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					rando = rand(7);
					if (rando == 0) desc = "full, toned ";
					else if (rando == 1) {
						if (asPlural) return "muscular, hand-filling ass cheeks";
						return "muscly handful of ass";
					} else if (rando == 2) desc = "shapely, toned ";
					else if (rando == 3) desc = "muscular, hand-filling ";
					else if (rando == 4) desc = "shapely, chiseled ";
					else if (rando == 5) desc = "full ";
					else if (rando == 6) desc = "chiseled ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(4);
					if (rando == 0) {
						if (asPlural) return "hand-filling ass cheeks";
						return "handful of ass";
					} else if (rando == 1) desc = "full ";
					else if (rando == 2) desc = "shapely ";
					else if (rando == 3) desc = "hand-filling ";
				}
				//FLABBAH
				else {
					rando = rand(8);
					if (rando == 0) desc = "somewhat jiggly ";
					else if (rando == 1) desc = "soft, hand-filling ";
					else if (rando == 2) desc = "cushiony, full ";
					else if (rando == 3) {
						if (asPlural) return "supple, hand-filling ass cheeks";
						return "supple, handful of ass";
					} else if (rando == 4) desc = "plush, shapely ";
					else if (rando == 5) desc = "full ";
					else if (rando == 6) desc = "soft, shapely ";
					else if (rando == 7) desc = "rounded, spongy ";
				}
			} else if (buttRating() < 10) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					rando = rand(9);
					if (rando == 0) desc = "large, muscular ";
					else if (rando == 1) desc = "substantial, toned ";
					else if (rando == 2) desc = "big-but-tight ";
					else if (rando == 3) desc = "squeezable, toned ";
					else if (rando == 4) desc = "large, brawny ";
					else if (rando == 5) desc = "big-but-fit ";
					else if (rando == 6) desc = "powerful, squeezable ";
					else if (rando == 7) desc = "large ";
					else if (rando == 8) desc = "callipygean ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(10);
					if (rando <= 2) desc = "squeezable ";
					else if (rando <= 6) desc = "large ";
					else if (rando <= 8) desc = "substantial ";
					else desc = "callipygean ";
				}
				//FLABBAH
				else {
					rando = rand(10);
					if (rando == 0) desc = "large, bouncy ";
					else if (rando == 1) desc = "soft, eye-catching ";
					else if (rando == 2) desc = "big, slappable ";
					else if (rando == 3) desc = "soft, pinchable ";
					else if (rando == 4) desc = "large, plush ";
					else if (rando == 5) desc = "squeezable ";
					else if (rando == 6) desc = "cushiony ";
					else if (rando == 7) desc = "plush ";
					else if (rando == 8) desc = "pleasantly plump ";
					else if (rando == 9) desc = "callipygean ";
				}
			} else if (buttRating() < 13) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					rando = rand(7);
					if (rando == 0) desc = "thick, muscular ";
					else if (rando == 1) desc = "big, burly ";
					else if (rando == 2) desc = "heavy, powerful ";
					else if (rando == 3) desc = "spacious, muscular ";
					else if (rando == 4) desc = "toned, cloth-straining ";
					else if (rando == 5) desc = "thick ";
					else if (rando == 6) desc = "thick, strong ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(4);
					if (rando == 0) desc = "jiggling ";
					else if (rando == 1) desc = "spacious ";
					else if (rando == 2) desc = "heavy ";
					else if (rando == 3) desc = "cloth-straining ";
				}
				//FLABBAH
				else {
					rando = rand(9);
					if (rando == 0) desc = "super-soft, jiggling ";
					else if (rando == 1) desc = "spacious, cushy ";
					else if (rando == 2) desc = "plush, cloth-straining ";
					else if (rando == 3) desc = "squeezable, over-sized ";
					else if (rando == 4) desc = "spacious ";
					else if (rando == 5) desc = "heavy, cushiony ";
					else if (rando == 6) desc = "slappable, thick ";
					else if (rando == 7) desc = "jiggling ";
					else if (rando == 8) desc = "spacious ";
					else if (rando == 9) desc = "soft, plump ";
				}
			} else if (buttRating() < 16) {
				//TOIGHT LIKE A TIGER
				if (tone >= 65) {
					rando = rand(8);
					if (rando == 0) desc = "expansive, muscled ";
					else if (rando == 1) desc = "voluminous, rippling ";
					else if (rando == 2) desc = "generous, powerful ";
					else if (rando == 3) desc = "big, burly ";
					else if (rando == 4) desc = "well-built, voluminous ";
					else if (rando == 5) desc = "powerful ";
					else if (rando == 6) desc = "muscular ";
					else if (rando == 7) desc = "powerful, expansive ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(4);
					if (rando == 0) desc = "expansive ";
					else if (rando == 1) desc = "generous ";
					else if (rando == 2) desc = "voluminous ";
					else if (rando == 3) desc = "wide ";
				}
				//FLABBAH
				else {
					rando = rand(11);
					if (rando == 0) desc = "pillow-like ";
					else if (rando == 1) desc = "generous, cushiony ";
					else if (rando == 2) desc = "wide, plush ";
					else if (rando == 3) desc = "soft, generous ";
					else if (rando == 4) desc = "expansive, squeezable ";
					else if (rando == 5) desc = "slappable ";
					else if (rando == 6) desc = "thickly-padded ";
					else if (rando == 7) desc = "wide, jiggling ";
					else if (rando == 8) desc = "wide ";
					else if (rando == 9) desc = "voluminous ";
					else if (rando == 10) desc = "soft, padded ";
				}
			} else if (buttRating() < 20) {
				if (tone >= 65) {
					rando = rand(6);
					if (rando == 0) desc = "huge, toned ";
					else if (rando == 1) desc = "vast, muscular ";
					else if (rando == 2) desc = "vast, well-built ";
					else if (rando == 3) desc = "huge, muscular ";
					else if (rando == 4) desc = "strong, immense ";
					else if (rando == 5) desc = "muscle-bound ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(5);
					if (rando == 0) desc = "huge ";
					else if (rando == 1) desc = "vast ";
					else if (rando == 2) desc = "giant ";
					else if (rando == 3) {
						if (asPlural) return "expansive, jiggling ass cheeks";
						return "jiggling expanse of ass";
					} else if (rando == 4) {
						if (asPlural) return "copious, fleshy ass cheeks";
						return "copious ass-flesh";
					}
				}
				//FLABBAH
				else {
					rando = rand(11);
					if (rando == 0) desc = "vast, cushiony ";
					else if (rando == 1) desc = "huge, plump ";
					else if (rando == 2) desc = "expansive, jiggling ";
					else if (rando == 3) desc = "huge, cushiony ";
					else if (rando == 4) desc = "huge, slappable ";
					else if (rando == 5) desc = "seam-bursting ";
					else if (rando == 6) desc = "plush, vast ";
					else if (rando == 7) desc = "giant, slappable ";
					else if (rando == 8) desc = "giant ";
					else if (rando == 9) desc = "huge ";
					else if (rando == 10) desc = "swollen, pillow-like ";
				}
			} else {
				if (tone >= 65) {
					rando = rand(7);
					if (rando == 0) desc = "ginormous, muscle-bound ";
					else if (rando == 1) desc = "colossal yet toned ";
					else if (rando == 2) desc = "strong, tremdously large ";
					else if (rando == 3) {
						if (asPlural) return "colossal, muscly ass cheeks";
						return "colossal, muscly ass";
					}
					else if (rando == 4) desc = "tremendous, muscled ";
					else if (rando == 5) desc = "ginormous, toned ";
					else if (rando == 6) desc = "colossal, well-defined ";
				}
				//Nondescript
				else if (tone >= 30) {
					rando = rand(4);
					if (rando == 0) desc = "ginormous ";
					else if (rando == 1) desc = "colossal ";
					else if (rando == 2) desc = "tremendous ";
					else if (rando == 3) desc = "gigantic ";
				}
				//FLABBAH
				else {
					rando = rand(13);
					if (rando == 0) desc = "ginormous, jiggly ";
					else if (rando == 1) desc = "plush, ginormous ";
					else if (rando == 2) desc = "seam-destroying ";
					else if (rando == 3) desc = "tremendous, rounded ";
					else if (rando == 4) desc = "bouncy, colossal ";
					else if (rando == 5) desc = "thong-devouring ";
					else if (rando == 6) desc = "tremendous, thickly padded ";
					else if (rando == 7) desc = "ginormous, slappable ";
					else if (rando == 8) desc = "gigantic, rippling ";
					else if (rando == 9) desc = "gigantic ";
					else if (rando == 10) desc = "ginormous ";
					else if (rando == 11) desc = "colossal ";
					else if (rando == 12) desc = "tremendous ";
				}
			}
			rando = rand(21);
			if(!asPlural)
			{
				if (rando <= 4) desc += "butt";
				else if (rando <= 9) desc += "ass";
				else if (rando <= 11) desc += "backside";
				else if (rando == 12) {
					if (buttRating() >= 10) desc += "booty";
					else desc += "derriere";
				} else if (rando == 13) desc += "rump";
				else if (rando == 14) desc += "bottom";
				else if (rando == 15) desc += "behind";
				else if (rando == 16) desc += "keister";
				else if (rando == 17) desc += mf("butt", "tush");
				else if (rando == 18) desc += "rear end";
				else if (rando == 19) desc += "heinie";
				else if (rando == 20) desc += "posterior";
			}
			else desc += "cheeks";
			return desc;
		}
		public function nipplesDescript(rowNum:int = 0, forceLactation:Boolean = false): String {
			if(totalNipples() == 1) return nippleDescript(rowNum, false, forceLactation);
			return nippleDescript(rowNum, true, forceLactation);
		}
		public function nippleDescript(rowNum:Number = 0, asPlural:Boolean = false, forceLactation:Boolean = false):String 
		{
			//DEBUG SHIT!
			if (rowNum > (breastRows.length - 1)) return "<B>Error: Invalid breastRows (" + rowNum + ") passed to nippleDescript()</b>";
			if (rowNum < 0) return "<B>Error: Invalid breastRows (" + rowNum + ") passed to nippleDescript()</b>";
			var descripted: Number = 0;
			var description: String = "";
			var rando: Number = 0;
			//Size descriptors 25% chance
			if (rand(4) == 0 && breastRows[rowNum].nippleType != GLOBAL.NIPPLE_TYPE_FUCKABLE && breastRows[rowNum].nippleType != GLOBAL.NIPPLE_TYPE_FLAT && breastRows[rowNum].nippleType != GLOBAL.NIPPLE_TYPE_INVERTED) {
				//TINAHHHH
				if (nippleLength(rowNum) < .25) {
					rando = rand(4);
					if (rando == 0) description += "tiny";
					else if (rando == 1) description += "itty-bitty";
					else if (rando == 2) description += "teeny-tiny";
					else if (rando == 3) description += "dainty";
				}
				//Prominant
				else if (nippleLength(rowNum) < 1) {
					rando = rand(5);
					if (rando == 0) description += "prominent";
					else if (rando == 1) description += "pencil eraser-sized";
					else if (rando == 2) description += "eye-catching";
					else if (rando == 3) description += "pronounced";
					else if (rando == 4) description += "striking";
				}
				//Big 'uns
				else if (nippleLength(rowNum) < 2) {
					rando = rand(4);
					if (rando == 0) description += "forwards-jutting";
					else if (rando == 1) description += "over-sized";
					else if (rando == 2) description += "fleshy";
					else if (rando == 3) description += "large protruding";
				}
				//'Uge
				else if (nippleLength(rowNum) < 3.2) {
					rando = rand(5);
					if (rando == 0) description += "elongated";
					else if (rando == 1) description += "massive";
					else if (rando == 2) description += "awkward";
					else if (rando == 3) description += "lavish";
					else if (rando == 4) description += "hefty";
				}
				//Massive
				else {
					rando = rand(5);
					if (rando == 0) description += "bulky";
					else if (rando == 1) description += "ponderous";
					else if (rando == 2) description += "thumb-sized";
					else if (rando == 3) description += "cock-sized";
					else if (rando == 4) description += "cow-like";
				}
				descripted++;
			}
			//Milkiness/Arousal/Wetness Descriptors 33% of the time
			if ((rand(3) == 0 || forceLactation) && descripted < 2) {
				//Fuckable chance first!
				if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_FUCKABLE) {
					if (descripted > 0) description += ", ";
					//Fuckable and lactating?
					if (isLactating()) {
						rando = rand(5);
						if (rando <= 3) description += "lactating";
						else description += "lactation-slicked";
					}
					//Just fuckable
					else {
						rando = rand(9);
						if (rando == 0) description += "wet";
						else if (rando == 1) description += "mutated";
						else if (rando == 2) description += "slimy";
						else if (rando == 3) description += "damp";
						else if (rando == 4) description += "moist";
						else if (rando == 5) description += "slippery";
						else if (rando == 6) description += "oozing";
						else if (rando == 7) description += "sloppy";
						else if (rando == 8) description += "dewy";
					}
					descripted++;
				}
				//Lipples
				else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_LIPPLES) {
					if (descripted > 0) description += ", ";
					if (isLactating()) {
						rando = rand(5);
						if (rando <= 3) description += "drooling";
						else description += "lactation-slicked";
					}
					//Just fuckable
					else {
						rando = rand(4);
						if (rando == 0) description += "puffy";
						else if (rando == 1) description += "pouty";
						else if (rando == 2) description += "parted";
						else if (rando == 3) description += "luscious";
					}
					descripted++;
				}
				//Dicknipples
				else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_DICK) {
					if (descripted > 0) description += ", ";
					rando = rand(3);
					if (rando == 0) description += "cock-concealing";
					else if (rando == 1) description += "dick-hiding";
					else if (rando == 2) description += "shaft-shrouding";
					descripted++;
				}
				//Flat
				else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_FLAT) {
					if (descripted > 0) description += ", ";
					rando = rand(4);
					if (rando == 0) description += "tipless";
					else if (rando == 1) description += "flat";
					else if (rando == 2) description += "puffy";
					else if (rando == 3) description += "pebbly";
					descripted++;
				}
				//Inverted
				else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_INVERTED) {
					if (descripted > 0) description += ", ";
					if (rando == 0) description += "inverted";
					descripted++;
				}
				//Just lactating!
				else if (isLactating() && milkFullness > 50) {
					if (descripted > 0) description += ", ";
					//Light lactation
					if (milkMultiplier < 65) {
						rando = rand(2);
						if (rando == 0) description += "moistened";
						else if (rando == 1) description += "slightly lactating";
					}
					//Moderate lactation
					else if (milkMultiplier <= 85) {
						rando = rand(3);
						if (rando == 0) description += "lactating";
						else if (rando == 1) description += "milky";
						else if (rando == 2) description += "milk-seeping";
					}
					//Heavy lactation
					else {
						rando = rand(4);
						if (rando == 0) description += "dripping";
						else if (rando == 1) description += "dribbling";
						else if (rando == 2) description += "milk-leaking";
						else if (rando == 3) description += "drooling";
					}
					descripted++;
				}
			}
			//Possible arousal descriptors
			else if (rand(3) == 0 && descripted < 2 && !InCollection(breastRows[rowNum].nippleType, GLOBAL.NIPPLE_TYPE_FLAT, GLOBAL.NIPPLE_TYPE_INVERTED, GLOBAL.NIPPLE_TYPE_LIPPLES, GLOBAL.NIPPLE_TYPE_FUCKABLE)) {
				if (lust() > 50 && lust() < 75) {
					if (descripted > 0) description += ", ";
					rando = rand(5);
					if (rando == 0) description += "erect";
					else if (rando == 1) description += "perky";
					else if (rando == 2) description += "erect";
					else if (rando == 3) description += "firm";
					else if (rando == 4) description += "tender";
					descripted++;
				}
				if (lust() >= 75) {
					if (descripted > 0) description += ", ";
					rando = rand(4);
					if (rando == 0) description += "throbbing";
					else if (rando == 1) description += "trembling";
					else if (rando == 2) description += "needy";
					else if (rando == 3) description += "throbbing";
					descripted++;
				}
			}
			if (descripted && rand(2) == 0 && nipplesPierced > 0 && rowNum == 0) {
				if (descripted > 0) description += ", ";
				if (nipplesPierced == 5) description += "chained ";
				else description += "pierced ";
				descripted++;
			}
			if (!descripted && skinType == GLOBAL.SKIN_TYPE_GOO) {
				if (descripted > 0) description += ", ";
				rando = rand(3);
				if (rando == 0) description += "slime-slick ";
				else if (rando == 1) description += "goopy ";
				else if (rando == 2) description += "slippery ";
			}
			/* 9999
			if (!descripted && InCollection(nippleColor, "black", "ebony", "obsidian", "onyx", "sable")) {
				rando = rand(4);
				if(rando == 0) description += "black ";
				else if(rando == 1) description += "ebony ";
				else description += "sable ";
				else description += nippleColor + " ";
			}
			*/
			//Nounsssssssss*BOOM*
			if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_FUCKABLE) {
				rando = rand(5);
				if (descripted > 0) description += ", ";
				if (rando == 0) description += "penetrable nipple";
				else if (rando == 1) description += "fuckable nip";
				else if (rando == 2) description += "fuckable nipple";
				else if (rando == 3) description += "pliable nipple-cunt";
				else if (rando == 4) description += "stretchy nipple-cunt";
			} else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_LIPPLES) {
				rando = rand(5);
				if (descripted > 0) {
					if (rando > 2) description += ", ";
					else description += " ";
				}
				if (rando <= 1) description += "lipple";
				else if (rando == 2) description += "lip-nipple";
				else if (rando == 3) description += "kissable nipple";
				else if (rando == 4) description += "mouth-like nipple";
			}
			//Normals
			else {
				rando = rand(5);
				if (descripted > 0) description += " ";
				if (rando <= 1) description += "nipple";
				else if (rando == 2) {
					if (isLactating() && nippleLength(rowNum) >= 1) description += "teat";
					else description += "nipple";
				}
				else if (rando == 3) {
					if (isLactating() && nippleLength(rowNum) >= 1) description += "teat";
					else description += "nipple";
				}
				else if (rando == 4) description += "bud";
			}
			if (asPlural) description = plural(description);
			return description;
		}
		public function nippleNoun(rowNum:int = 0):String
		{
			var description:String = "";
			var rando:int = 0;
			if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_FUCKABLE) {
				rando = rand(5);
				if (rando == 0) description += "penetrable nipple";
				else if (rando == 1) description += "fuckable nip";
				else if (rando == 2) description += "fuckable nipple";
				else if (rando == 3) description += "pliable nipple-cunt";
				else if (rando == 4) description += "stretchy nipple-cunt";
			} else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_LIPPLES) {
				rando = rand(5);
				if (rando <= 1) description += "lipple";
				else if (rando == 2) description += "lip-nipple";
				else if (rando == 3) description += "kissable nipple";
				else if (rando == 4) description += "mouth-like nipple";
			}
			else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_DICK)
			{
				description += RandomInCollection("dick-nipple", "cock-nipple", "nipple-cock");
			}
			else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_INVERTED)
			{
				description += RandomInCollection("inverted nipple", "hidden nip");
			}
			else if (breastRows[rowNum].nippleType == GLOBAL.NIPPLE_TYPE_FLAT)
			{
				description += RandomInCollection("tipless ", "flat ", "puffy ", "pebbly ");
				description += RandomInCollection("nipple", "nip");
			}
			//Normals
			else {
				rando = rand(5);
				if (rando <= 1) description += "nipple";
				else if (rando == 2) {
					if (isLactating() && nippleLength(rowNum) >= 1) description += "teat";
					else description += "nipple";
				}
				else if (rando == 3) {
					if (isLactating() && nippleLength(rowNum) >= 1) description += "teat";
					else description += "nipple";
				}
				else if (rando == 4) description += "bud";
			}
			//description = plural(description);
			return description;
		}
		public function areolaSizeDescript(): String {
			//Define areola size description by nippleWidth
			var areolasize: String = "";
			
			if(nippleWidth() <= 0) areolasize = "non-existent";
			else if(nippleWidth() <= .375) areolasize = "fairly tiny";
			else if(nippleWidth() <= .75) areolasize = "average-sized";
			else if(nippleWidth() <= 1.5) areolasize = "coin-sized";
			else if(nippleWidth() <= 3) areolasize = "rather huge";
			else if(nippleWidth() <= 6) areolasize = "saucer-sized";
			else if(nippleWidth() <= 9) areolasize = "appetizer plate-sized";
			else if(nippleWidth() <= 12) areolasize = "dinner plate-sized";
			else if(nippleWidth() <= 18) areolasize = "quite massive";
			else if(nippleWidth() <= 24) areolasize = "extremely elephantine";
			else if(nippleWidth() <= 36) areolasize = "manhole cover-sized";
			else if(nippleWidth() <= 72) areolasize = "person-sized";
			else if(nippleWidth() <= 120) areolasize = "hallway-clearing";
			else if(nippleWidth() <= 240) areolasize = "room-filling";
			else if(nippleWidth() <= 480) areolasize = "truly tremendous";
			else if(nippleWidth() <= 960) areolasize = "generously gargantuan";
			else if(nippleWidth() <= 1920) areolasize = "completely colossal";
			else if(nippleWidth() <= 3840) areolasize = "positively hyper-sized";
			else if(nippleWidth() <= 7680) areolasize = "stadium-sized";
			else if(nippleWidth() <= 15360) areolasize = "sky-scraping";
			else if(nippleWidth() <= 30720) areolasize = "airplane-catching";
			else if(nippleWidth() <= 61440) areolasize = "cloud-licking";
			else if(nippleWidth() <= 122880) areolasize = "solar-eclipsing";
			else if(nippleWidth() <= 491520) areolasize = "planet-engulfing";
			else if(nippleWidth() > 491520) areolasize = "galaxy-swallowing";
			
			return areolasize;
		}

		public function hairDescript(forceLength: Boolean = false, forceColor: Boolean = false): String {
			var descript: String = "";
			var descripted: Number = 0;
			//Bald folks get one-off quick description
			if (hairLength == 0) {
				if (hasFur()) {
					if (rand(2) == 0) descript += "furry ";
					else {
						if (forceColor || rand(2) == 0) descript += furColor;
						return descript + "head-fur";
					}
				}
				else if (hasScales()) {
					if (rand(2) == 0) descript += "scaly ";
				}
				else if (rand(2) == 0) descript += "shaved ";
				else descript += "bald ";
				descript += "head";
				return descript;
			}
			//50% odds of adjectives
			if ((forceLength || rand(2) == 0) && !InCollection(hairStyle, "afro", "mohawk")) {
				if (hairLength < 1) {
					if (rand(2) == 0) descript += "close-cropped";
					else descript += "trim";
				}
				else if (hairLength < 3) descript += "short";
				else if (hairLength < 6) {
					if (rand(2) == 0 || hairType == GLOBAL.HAIR_TYPE_TENTACLES) descript += "medium-length";
					else descript += "shaggy";
				}
				else if (hairLength < 10) {
					if (rand(2) == 0) descript += "moderately long";
					else descript += "shoulder-length";
				}
				else if (hairLength < 16) descript += "long";
				//Relativistic hair
				else if (hairLength < tallness / 2.5)
				{
					if(rand(3) == 0) descript += "very long";
					else if(rand(2) == 0) descript += "back-length";
					else descript += "lengthy";
				}
				else if (hairLength < tallness / 1.7) descript += "ass-length";
				else if (hairLength < tallness / 1.3) 
				{
					if(rand(2) == 0 && hasKnees()) descript += "knee-length"; 
					else descript += "delightfully long";
				}
				else if(hairLength < tallness) {
					if(rand(2) == 0 && hasKnees()) descript += "ankle-length";
					else descript += "exquisitely long";
				}
				else {
					if (rand(3) == 0) descript += "floor-length";
					else if(rand(2) == 0) descript += "obscenely long";
					else descript += "floor-dragging";
				}
				descripted++;
			}
			// COLORS
			if (forceColor || rand(2) == 0) {
				if (descripted > 0) descript += ", ";
				descript += hairColor;
				descripted++;
			}
			//Mane special stuff.
			if (hasPerk("Mane") && hairLength > 3 && rand(2) == 0) {
				//Oddball shit
				if (rand(2) == 0 && descripted < 2) {
					if (hairType == GLOBAL.HAIR_TYPE_TRANSPARENT) {
						if (descripted > 0) descript += ", ";
						descript += "transparent";
						descripted++;
					}
				}
				if (descripted > 0) descript += " mane";
				if (hairType == GLOBAL.HAIR_TYPE_FEATHERS) descript += " of feathers";
				if (hairType == GLOBAL.HAIR_TYPE_QUILLS) descript += " of quills";
				if (hairType == GLOBAL.HAIR_TYPE_GOO)
				{
					descript += " of goo";
					if (hairStyle == "tentacle") descript += "-tentacles";
				}
				if (hairType == GLOBAL.HAIR_TYPE_TENTACLES) descript += " of tentacles";
			}
			//Not manes
			else {
				//Oddball shit
				if (rand(2) == 0 && descripted < 2) {
					if (hairType == GLOBAL.HAIR_TYPE_TRANSPARENT) {
						if (descripted > 0) descript += ", ";
						descript += "transparent";
						descripted++;
					} else if (hairType == GLOBAL.HAIR_TYPE_GOO) {
						if (descripted > 0) descript += ", ";
						descript += "gooey";
						descripted++;
					}
				}
				if (descripted > 0) descript += " ";
				if (hairType == GLOBAL.HAIR_TYPE_TENTACLES || hairStyle == "tentacle")
				{
					if (hairType == GLOBAL.HAIR_TYPE_GOO && descript.indexOf("goo") == -1) descript += "gooey ";
					descript += "tentacle-hair";
				}
				else if (hairType == GLOBAL.HAIR_TYPE_FEATHERS) 
				{
					if(rand(2) == 0) descript += "plumage";
					else descript += "feather-hair";
				}
				else if (hairType == GLOBAL.HAIR_TYPE_QUILLS && rand(2) == 0)
				{
					if(rand(2) == 0) descript += "spiny-hair";
					else descript += "quill-hair";
				}
				else 
				{
					if(hairStyle == "ponytail") descript += "ponytail";
					else if(hairStyle == "pigtails") descript += "pigtailed hair";
					else if(hairStyle == "curls") descript += "curled hair";
					else if(hairStyle == "braided") descript += "braid";
					else if(hairStyle == "afro") descript += "afro";
					else if(hairStyle == "mohawk") descript += "mohawk";
					else descript += "hair";
				}
			}
			return descript;
		}
		public function hairNoun():String
		{
			var descript:String = "";
			//Mane special stuff.
			if (hasPerk("Mane") && hairLength > 3 && rand(2) == 0) {
				descript += "mane";
				if (hairType == GLOBAL.HAIR_TYPE_FEATHERS) descript += " of feathers";
				if (hairType == GLOBAL.HAIR_TYPE_QUILLS) descript += " of quills";
				if (hairType == GLOBAL.HAIR_TYPE_GOO) descript += " of goo";
				if (hairType == GLOBAL.HAIR_TYPE_TENTACLES) descript += " of tentacles";
			}
			//Not manes
			else {
				if ((hairType == GLOBAL.HAIR_TYPE_TENTACLES || hairStyle == "tentacle") && rand(2) == 0) descript += "tentacle-hair";
				else if (hairType == GLOBAL.HAIR_TYPE_FEATHERS) 
				{
					if(rand(2) == 0) descript += "plumage";
					else descript += "feather-hair";
				}
				else if (hairType == GLOBAL.HAIR_TYPE_QUILLS) descript += "quill-hair";
				else descript += "hair";
			}
			return descript;
		}
		public function hairsNoun():String
		{
			var descript:String = "";
			if (hairType == GLOBAL.HAIR_TYPE_TENTACLES || hairStyle == "tentacle") descript += "tentacles";
			else if (hairType == GLOBAL.HAIR_TYPE_FEATHERS) descript += "feathers";
			else if (hairType == GLOBAL.HAIR_TYPE_QUILLS) descript += "quills";
			else if (hairType == GLOBAL.HAIR_TYPE_GOO) descript += "locks of goo";
			else descript += "locks";
			return descript;
		}
		public function hairsDescript(forceLength: Boolean = false, forceColor: Boolean = false): String {
			var descript: String = "";
			var descripted: Number = 0;
			//Bald folks get one-off quick description
			if (hairLength == 0) {
				if (hasFur()) {
					if (rand(2) == 0) descript += "furry ";
					else {
						if (forceColor || rand(2) == 0) descript += furColor;
						return descript + "head-fur";
					}
				}
				else if (hasScales()) {
					if (rand(2) == 0) descript += "scaly ";
				}
				else if (rand(2) == 0) descript += "shaved ";
				else descript += "bald ";
				descript += "head";
				return descript;
			}
			//50% odds of adjectives
			if (forceLength || rand(2) == 0) {
				if (hairLength < 1) {
					if (rand(2) == 0) descript += "close-cropped";
					else descript += "trim";
				} else if (hairLength < 3) descript += "short";
				else if (hairLength < 6) descript += "shaggy";
				else if (hairLength < 10) {
					if (rand(2) == 0) descript += "moderately long";
					else descript += "shoulder-length";
				}
				else if (hairLength < 16) descript += "long";
				//Relativistic hair
				else if (hairLength < tallness / 2.5)
				{
					if(rand(3) == 0) descript += "very long";
					else if(rand(2) == 0) descript += "back-length";
					else descript += "lengthy";
				}
				else if (hairLength < tallness / 1.7) descript += "ass-length";
				else if (hairLength < tallness / 1.3) 
				{
					if(rand(2) == 0 && hasKnees()) descript += "knee-length"; 
					else descript += "delightfully long";
				}
				else if(hairLength < tallness) {
					if(rand(2) == 0 && hasKnees()) descript += "ankle-length";
					else descript += "exquisitely long";
				}
				else {
					if (rand(3) == 0) descript += "floor-length";
					else if(rand(2) == 0) descript += "obscenely long";
					else descript += "floor-dragging";
				}
				descripted++;
			}
			// COLORS
			if (forceColor || rand(2) == 0) {
				if (descripted > 0) descript += ", ";
				descript += hairColor;
				descripted++;
			}
			//Not manes
			//Oddball shit
			if (rand(2) == 0 && descripted < 2) {
				if (hairType == GLOBAL.HAIR_TYPE_TRANSPARENT) {
					if (descripted > 0) descript += ", ";
					descript += "transparent";
					descripted++;
				}
			}
			if (descripted > 0) descript += " ";
			if (hairType == GLOBAL.HAIR_TYPE_TENTACLES || hairStyle == "tentacle") descript += "tentacles";
			else if (hairType == GLOBAL.HAIR_TYPE_FEATHERS) descript += "feathers";
			else if (hairType == GLOBAL.HAIR_TYPE_QUILLS && rand(2) == 0) descript += "quills";
			else 
			{
				if(hairStyle == "ponytail") descript += "ponytail-bound locks";
				else if(hairStyle == "pigtails") descript += "pigtails";
				else if(hairStyle == "curls") descript += "curls";
				else if(hairStyle == "braided") descript += "braid-bound locks";
				else if(hairStyle == "afro") descript += "afro-puffed locks";
				else if(hairStyle == "mohawk") descript += "mohawk-shaped locks";
				else descript += "locks";
			}
			if (hairType == GLOBAL.HAIR_TYPE_GOO && rand(2) == 0) descript += " of goo";
			return descript;
		}
		public function eachClit(): String {
			if (totalClits() > 1) return "each of your " + plural(clitDescript());
			else return "your " + clitDescript();
		}
		public function oneClitPerVagina(arg:int = 0):String
		{
			if(arg >= vaginas.length) return "ERROR - OUT OF BOUNDS CHECK FOR ONECLITPERVAGINA()";
			else if(arg < 0) return "ERROR - OUT OF BOUNDS CHECK FOR ONECLITPERVAGINA()";
			else if(vaginas[arg].clits == 1) return "your " + clitDescript();
			else return "one of your " + plural(clitDescript());
			return "ERROR";
		}
		public function oneClit(): String {
			if (totalClits() > 1) return "one of your " + plural(clitDescript());
			else return "your " + clitDescript();
		}
		public function clitsDescript(): String {
			if (totalClits() > 1) return plural(clitDescript());
			else return clitDescript();
		}
		public function clitDescript(pussy: Number = 0): String {
			var descript: String = "";
			var randt: Number = rand(10);
			var descripted: Number = 0;
			//Length Adjective - 50% chance
			if (rand(3) == 0) {
				//small clits!
				if (clitLength <= .4) {
					if (randt < 3) descript += "tiny";
					else if (randt < 6) descript += "little";
					else if (randt < 8) descript += "petite";
					else if (randt == 8) descript += "diminutive";
					else descript += "miniature";
					descripted++;
				}
				//"average".
				else if (clitLength < 1) {
					//no size comment
				}
				//Biggies!
				else if (clitLength < 4) {
					if (randt < 4) descript += "large";
					else if (randt < 9) descript += "substantial";
					else descript += "considerable";
					descripted++;
				}
				//'Uge 
				else if (clitLength < 10) {
					if (randt < 2) descript += "dick-sized";
					else if (randt < 4) descript += "phallus-like";
					else if (randt < 6) descript += "cock-like";
					else if (randt < 8) descript += "banana-sized";
					else if (randt == 8) descript += "hulking";
					else descript += "bulky";
					descripted++;
				} else {
					if (randt < 3) descript += "monster";
					else if (randt < 6) descript += "tremendous";
					else if (randt < 8) descript += "colossal";
					else if (randt == 8) descript += "enormous";
					else descript += "oversized";
					descripted++;
				}
			}
			//Descriptive descriptions - 50% chance of being called
			if (rand(3) == 0 && descripted < 2) {
				//Elizabeth descriptors
				if (skinType == GLOBAL.SKIN_TYPE_FUR && hasVaginaType(GLOBAL.TYPE_VULPINE) && rand(3) <= 1) {
					if (descripted > 0) descript += ", ";
					descript += "foxy ";
					descripted++;
				}
				//Horny descriptors - 75% chance
				else if (lust() > 70 && rand(4) < 3 && !descripted) {
					if (descripted > 0) descript += ", ";
					randt = rand(3);
					if (randt == 0) descript += "throbbing";
					if (randt == 1) descript += "pulsating";
					if (randt == 2) descript += "hard";
					descripted++;
				}
				//High libido - always use if no other descript
				else if (libido() > 50 && rand(3) < 2 && !descripted) {
					if (descripted > 0) descript += ", ";
					randt = rand(4);
					if (randt == 0) descript += "insatiable";
					if (randt == 1) descript += "greedy";
					if (randt == 2) descript += "demanding";
					if (randt == 3) descript += "rapacious";
					descripted++;
				}
			}
			if (hasClit()) {
				if (vaginas[pussy].clits > 0 && vaginas[pussy].clitPierced > 0 && descripted < 2 && rand(3) < 2) {
					if (descripted > 0) descript += ", ";
					descript += "pierced";
					descripted++;
				}
			}
			else return ("ERROR: CLITDESCRIPT WITH NO CLIT");
			//Clit nouns
			if (descripted > 0) descript += " ";
			//HYPHENING SHIT ONTO DOSE NOUNS, YO!
			if (skinType == GLOBAL.SKIN_TYPE_FUR && hasVaginaType(GLOBAL.TYPE_CANINE) && rand(2) == 0) descript += "bitch-";
			//Horse descriptors - 50%
			else if (skinType == GLOBAL.SKIN_TYPE_FUR && hasVaginaType(GLOBAL.TYPE_EQUINE) && rand(3) <= 0) descript += "mare-";
			randt = rand(10);
			if (randt == 0) 
			{
				if (kGAMECLASS.silly && clitLength >= 12 && rand(2) == 0) descript += "clitosaurus";
				else if (clitLength >= 5) descript += "girl-pole";
				else descript += "clit";
			}
			else if (randt == 1) descript += "clitty";
			else if (randt == 2) descript += "button";
			else if (randt == 3) descript += "pleasure-buzzer";
			else if (randt == 4) descript += "clit";
			else if (randt == 5) descript += "clitty";
			else if (randt == 6) descript += "button";
			else if (randt == 7) descript += "clit";
			else if (randt == 8) descript += "clit";
			else if (randt == 9) descript += "button";
			return descript;
		}
		public function vagOrAss(arg: int = 0): String {
			if (hasVagina() && arg >= 0) return vaginaDescript(arg);
			else return assholeDescript();
		}
		//Vaginas + Descript
		public function oneTailVaginaDescript():String
		{
			var buffer:String = "";
			if(tailCount > 1) buffer += "one of ";
			buffer += "your ";
			if(tailCount > 1) buffer += plural(tailVaginaDescript());
			else buffer += tailVaginaDescript();
			return buffer;
		}
		public function tailVaginasDescript(forceAdjectives: Boolean = false, adjectives: Boolean = true): String {
			if(tailCount > 1) return plural(tailVaginaDescript(forceAdjectives,adjectives));
			else if(tailCount == 1) return tailVaginaDescript(forceAdjectives,adjectives);
			return "ERROR: TAIL DESCRIPT CALLED WITH NO TAILS PRESENT.";
		}
		public function tailVaginaDescript(forceAdjectives: Boolean = false, adjectives: Boolean = true): String {
			//Vars
			var vag: String = "";
			var descripted: int = 0;
			var temp: int = 0;
			var tailCuntHolder:VaginaClass = new VaginaClass();
			tailCuntHolder.type = tailGenitalArg;

			//low chance of size descriptor
			if ((adjectives && rand(100) <= 25) || forceAdjectives) {
				temp = rand(10);
				if (temp <= 3) vag += "tight";
				else if (temp <= 5) vag += "clingy";
				else if (temp <= 7) vag += "supple";
				else vag += "velvety-soft";
				descripted++;
			}
			//wetness descript - 30% display rate
			if (descripted < 2 && ((adjectives && rand(100) > 70) || forceAdjectives)) {
				if (descripted > 0) vag += ", ";
				temp = rand(17);
				if (temp <= 3) vag += "wet";
				else if (temp <= 5) vag += "sultry";
				else if (temp <= 8) vag += "sweltering";
				else if (temp <= 11) vag += "slippery";
				else if (temp <= 13) vag += "slick";
				else vag += "lube-leaking";
				descripted++;
			}
			//Elasticity references!
			if (descripted < 2 && elasticity >= 1.5 && ((adjectives && rand(3) == 0) || forceAdjectives)) {
				if (descripted > 0) vag += ", ";
				if (elasticity >= 5) {
					temp = rand(10);
					if (temp <= 3) vag += "stretchy";
					else if (temp <= 7) vag += "incredibly elastic";
					else vag += "powerfully pliable";
				} else {
					temp = rand(10);
					if (temp <= 1) vag += "stretchy";
					else if (temp <= 3) vag += "elastic";
					else if (temp <= 5) vag += "pliable";
					else if (temp <= 7) vag += "flexible";
					else vag += "pliant";
				}
				descripted++;
			}
			if (descripted < 2 && skinType == GLOBAL.SKIN_TYPE_GOO && ((adjectives && rand(3) == 0) || forceAdjectives)) {
				if (descripted > 0) vag += ", ";
				if (rand(2) == 0) vag += "gooey";
				else vag += "slimy";
				descripted++;
			}
			//10% of time, mention color.
			if (rand(10) == 0 && tailGenitalColor != "") {
				if (descripted > 0) vag += ", ";
				vag += tailGenitalColor;
			}
			//50% of time, simple cunt.
			if (rand(2) == 0) {
				if (descripted > 0) vag += " ";
				vag += vaginaNoun2(tailCuntHolder, true, "tail");
			}
			//50% of the time, complex cunt!
			else {
				if (descripted > 0) vag += ", ";
				vag += vaginaNoun2(tailCuntHolder, false, "tail");
			}
			return vag;
		}
		public function vaginaNounDescript(vaginaNum: Number = 0):String
		{
			if(vaginaNum > vaginas.length || vaginaNum < 0) return "ERROR, INVALID PUSSY";
			else return vaginaNoun2(vaginas[vaginaNum]);
		}
		public function vaginaNoun2(vag:VaginaClass, simple:Boolean = false, special:String = ""):String
		{
			var desc: String = "";
			var type:int = vag.type;
			if(special != "default")
			{
				//If tail mounted, give tail specials.
				if(special == "tail" && rand(2) == 0)
				{
					if(!simple)
						desc += RandomInCollection(["tail-mounted pussy","parasite pussy","tail-topping cunt","tail-mounted twat"]);
					else
						desc += RandomInCollection(["tail-vagina", "tail-pussy", "tail-pussy","tail-pussy","tail-pussy", "tail-cunt", "tail-cunt", "tail-slit", "tail-slit","tail-twat","tail-twat"]);
				}
				//Gooey override, Slimgina
				else if(rand(3) == 0 && vag.hasFlag(GLOBAL.FLAG_GOOEY))
				{
					if(!simple)
						desc += RandomInCollection(["sloppy gash", "gooey pussy", "sopping cunt", "slick snatch", "puddling pussy", "semi-solid snatch", "gooey cunt", "goo vagina", "slimy vagina", "gooey pussy", "slimy cunt", "syrupy hole", "juicy twat", "slimy gash", "gooey honeypot", "slimy snatch"]);
					else
						desc += RandomInCollection(["googina", "goo-hole", "fuck-hole", "slime-gina", "goo-pussy", "slime-cunt", "fuck-hole", "goo-twat", "slime-gash", "honeypot", "slime-snatch"]);
				}
				else if (type == GLOBAL.TYPE_EQUINE)
				{
					if (!simple)
						desc += RandomInCollection(["equine gash", "animalistic vagina", "animalistic cunny", "equine honeypot", "dusky snatch", "equine cunt", "pheromone-laden pussy", "musky mare-cunt"]);
					else
						desc += RandomInCollection(["horse-pussy", "mare-cunt", "fuck-hole", "horse-twat", "mare-twat", "centaur-snatch", "animal-pussy", "mare-pussy", "horse-cunt"]);
				}
				//Maybe doge?
				else if (type == GLOBAL.TYPE_CANINE || type == GLOBAL.TYPE_VULPINE)
				{
					if (!simple)
						desc += RandomInCollection(["canine gash", "small-lipped vagina", "animalistic cunny", "canine honeypot", "canine snatch", "canine cunt", "animalistic pussy", "fragrant dog-cunt"]);
					else
						desc += RandomInCollection(["dog-pussy", "bitch-cunt", "fuck-hole", "dog-twat", "animal-twat", "animal-pussy", "dog-pussy", "dog-cunt"]);
					if (foxScore() > 4) {
						desc = desc.replace("dog", "fox");
					}
				}
				else if (type == GLOBAL.TYPE_SIREN || type == GLOBAL.TYPE_ANEMONE)
				{
					if (!simple)
						desc += RandomInCollection(["wriggling gash", "stinger-ringed vagina", "cilia-filled cunny", "siren-like honeypot", "aphrodisiac-laced snatch", "tentacle-filled cunt", "alien pussy", "wiggly cunt"]);
					else
						desc += RandomInCollection(["siren-pussy", "siren-snatch", "fuck-hole", "venom-twat", "twat", "snatch", "venom-pussy", "siren-pussy", "cunt"]);
				}
				else if (type == GLOBAL.TYPE_BEE)
				{
					if (!simple)
						desc += RandomInCollection(["thick-lipped gash", "alien vagina", "inhuman cunt", "zil-like honeypot", "exceptionally smooth pussy", "exotic slit", "thick-lipped pussy", "seductive snatch"]);
					else
						desc += RandomInCollection(["zil-pussy", "honey-cunt", "honey-box", "zil-twat", "pussy", "xeno-snatch", "pussy", "zil-cunt", "twat"]);
				}
				else if (type == GLOBAL.TYPE_NAGA)
				{
					if (!simple)
						desc += RandomInCollection(["reptilian gash", "naleen-like slit", "snake-like cunt", "semi-concealed pussy", "supple pussy", "snake-like box", "alien cunt", "half-hidden twat"]);
					else
						desc += RandomInCollection(["naleen-cunt", "snake-pussy", "box", "snake-twat", "pussy", "xeno-cunt", "pussy", "slit", "slit"]);
				}
				else if (type == GLOBAL.TYPE_VANAE)
				{
					if (!simple)
						desc += RandomInCollection(["tentacle-laden gash", "writhing pussy", "human-like cunt", "vanae pussy", "supple pussy", "xeno-cunt", "alien pussy", "feeler-lined pussy", "caressing cunt", "stroking snatch", "massaging cunny", "licker-lined pussy", "silky twat"]);
					else
						desc += RandomInCollection(["vanae-cunt", "tenta-pussy", "box", "vanae-twat", "pussy", "xeno-cunt", "pussy", "twat", "cunt"]);
				}
				else if (type == GLOBAL.TYPE_LEITHAN)
				{
					if (!simple)
						desc += RandomInCollection(["puffy gash", "thick-lipped vagina", "leithan cunny", "inhuman honeypot", "dusky snatch", "swollen cunt", "pheromone-laden pussy", "musky mare-cunt"]);
					else
						desc += RandomInCollection(["taur-pussy", "mare-cunt", "fuck-hole", "xeno-twat", "mare-twat", "centaur-snatch", "alien-pussy", "mare-pussy", "leith-cunt"]);
				}
				else if (type == GLOBAL.TYPE_SYNTHETIC)
				{
					if (!simple)
						desc += RandomInCollection(["synth gash", "synthetic vagina", "robotic cunny", "robot honeypot", "synthetic snatch", "robotic cunt", "artificial pussy", "robo-cunt"]);
					else
						desc += RandomInCollection(["synth-pussy", "robo-cunt", "fuck-hole", "synth-twat", "robo-twat", "synth-snatch", "mecha-pussy", "robo-pussy", "synth-cunt"]);
				}
				else if (type == GLOBAL.TYPE_GABILANI)
				{
					if (!simple)
						desc += RandomInCollection(["gabilani gash", "dexterous vagina", "goblin cunny", "inhuman honeypot", "well muscled snatch", "capable cunt", "gabilani pussy", "dexterous goblin-cunt"]);
					else
						desc += RandomInCollection(["inhuman-pussy", "goblin-cunt", "fuck-hole", "xeno-twat", "goblin-twat", "goblin-snatch", "alien-pussy", "gabilani-pussy", "gabilani-cunt"]);
				}
				else if (type == GLOBAL.TYPE_NYREA)
				{
					if (!simple)
						desc += RandomInCollection(["nyrean vagina", "nyrean pussy", "nyrean cunt", "nyrean cunny", "nyrean snatch", "nyrean gash", "boy-pussy", "boy-cunt"]);
					else
						desc += RandomInCollection(["inhuman-pussy", "nyrean-cunt", "fuck-hole", "xeno-twat", "nyrean-snatch", "nyrean-pussy", "nyrean-cunt", "boy-pussy", "boy-cunt"]);
				}
				else
				{
					if (!simple)
					{
						if (type == GLOBAL.TYPE_HUMAN)
							desc += RandomInCollection(["human ", "human ", "terran ", "terran ", "terran "]);
						else
							desc += RandomInCollection(["human-like ", "human-like ", "exotic ", "exotic ", "inhuman "]);
					}
					desc += RandomInCollection(["vagina", "pussy", "pussy","pussy","pussy", "cunt", "cunt", "slit", "slit","twat", "gash", "cunny", "honeypot", "snatch"]);
				}
			}
			else
			{
				if (!simple)
				{
					if (type == GLOBAL.TYPE_HUMAN)
						desc += RandomInCollection(["human ", "human ", "terran ", "terran ", "terran "]);
					else
						desc += RandomInCollection(["human-like ", "human-like ", "exotic ", "exotic ", "inhuman "]);
				}
				desc += RandomInCollection(["vagina", "pussy", "pussy","pussy","pussy", "cunt", "cunt", "slit", "slit","twat", "gash", "cunny", "honeypot", "snatch"]);
			}
			return desc;
		}
		
		//Vaginas + Descript
		public function vaginaDescript(vaginaNum: Number = 0, forceAdjectives: Boolean = false, adjectives: Boolean = true): String {
			if (vaginaNum > (vaginas.length - 1)) return "<B>Error: Invalid vagina number (" + vaginaNum + ") passed to vaginaDescript()</b>";
			if (vaginaNum < 0) return "<B>Error: Invalid vaginaNum (" + vaginaNum + ") passed to vaginaDescript()</b>";
			//If no vaginas back the fuck out
			if (vaginas.length < 0) return "VAGINA ERROR";

			//Vars
			var vag: String = "";
			var descripted: int = 0;
			var bonus: int = 0;
			var temp: int = 0;

			//Bonus chance for virgins
			if (vaginalVirgin) bonus += 20
			//Color super low chance!
			if (adjectives && !forceAdjectives && rand(15) == 0)
			{
				if (vaginas[vaginaNum].vaginaColor.length > 0)
				{
					descripted++;
					/* 9999 CoC's black cunts. Might still use!
					if(InCollection(vaginas[vaginaNum].vaginaColor, "black", "ebony", "obsidian", "onyx", "sable") && rand(2) == 0) {
						if(descripted) vag += ", ";
						rand = Math.floor(Math.random() * 8);
						if(rand == 0) vag += "black";
						else if(rand == 1) vag += "onyx";
						else if(rand == 2) vag += "ebony";
						else if(rand == 3) vag += "dusky";
						else if(rand == 4) vag += "sable";
						else if(rand == 5) vag += "obsidian";
						else if(rand == 6) vag += "midnight-hued";
						else vag += "jet black";
						descripted = true;
					}
					else */
					vag += vaginas[vaginaNum].vaginaColor;
				}
				else
				{
					trace("Vagina doesn't have a color set!");
				}
			}
			//low chance of size descriptor
			if ((adjectives && rand(100) <= 25 + bonus) || forceAdjectives) {
				if (descripted > 0) vag += ", ";
				//Virgin overpowers other shit half the time.
				if (vaginalVirgin && rand(2) == 0) {
					temp = rand(11);
					if (temp <= 3) vag += "virgin";
					else if (temp <= 5) vag += "virginal";
					else if (temp <= 7) vag += "unclaimed";
					else if (temp <= 9) vag += "unspoiled";
					else vag += "pure";
				} else if (vaginas[vaginaNum].looseness() <= 1) {
					temp = rand(11);
					if (temp <= 4) vag += "tight";
					else if (temp <= 5) vag += "vice-like";
					else if (temp <= 6) vag += "constricting";
					else if (temp <= 8) vag += "unstretched";
					else vag += "narrow";
				} else if (vaginas[vaginaNum].looseness() <= 2) {
					temp = rand(10);
					//if (temp <= 5) vag += "average";
					//else 
					vag += "supple";
				} else if (vaginas[vaginaNum].looseness() <= 3) {
					temp = rand(10);
					if (temp <= 4) vag += "loose";
					else if (temp <= 6) vag += "slightly-stretched";
					else if (temp <= 8) vag += "loosened";
					else vag += "lax";
				} else if (vaginas[vaginaNum].looseness() <= 4) {
					temp = rand(11);
					if (temp <= 3) vag += "slightly-gaped";
					else if (temp <= 5) vag += "well-loosened";
					else if (temp <= 7) vag += "open";
					else if (temp <= 8) vag += "widened";
					else if (temp <= 9) vag += "barely-spread";
					else vag += "parted";
				} else {
					temp = rand(11);
					if (temp <= 4) vag += "gaped";
					else if (temp <= 8) vag += "cavernous";
					else if (temp <= 9) vag += "wide-open";
					else vag += "ruined";
				}
				descripted++;
			}
			//wetness descript - 30% display rate
			if (descripted < 2 && ((adjectives && rand(100) > 70) || forceAdjectives)) {
				if (descripted > 0) vag += ", ";
				if (vaginas[vaginaNum].wetness() <= 0) {
					temp = rand(10);
					if (temp <= 4) vag += "dry";
					else if (temp <= 7) vag += "unlubricated";
					else vag += "moistureless";
				} else if (vaginas[vaginaNum].wetness() <= 1) {
					temp = rand(10);
					if (temp <= 4) vag += "moist";
					else if (temp <= 7) vag += "sticky";
					else vag += "dewy";
				} else if (vaginas[vaginaNum].wetness() <= 2) {
					temp = rand(10);
					if (temp <= 3) vag += "wet";
					else if (temp <= 5) vag += "sultry";
					else if (temp <= 8) vag += "sweltering";
					else vag += "slippery";
				} else if (vaginas[vaginaNum].wetness() <= 3) {
					temp = rand(12);
					if (temp <= 3) vag += "slick";
					else if (temp <= 6) vag += "drenched";
					else if (temp <= 9) vag += "sopping";
					else vag += "soaked";
				} else if (vaginas[vaginaNum].wetness() <= 4) {
					temp = rand(9);
					if (temp <= 2) vag += "drooling";
					else if (temp <= 5) vag += "dripping";
					else vag += "lube-leaking";
				} else {
					temp = rand(12);
					if (temp <= 2) vag += "slavering";
					else if (temp <= 5) vag += "slobbering";
					else if (temp <= 8) vag += "puddling";
					else vag += "crotch-soaking";
				}
				descripted++;
			}
			//Elasticity references!
			if (descripted < 2 && elasticity >= 1.5 && ((adjectives && rand(3) == 0) || forceAdjectives)) {
				if (descripted > 0) vag += ", ";
				if (elasticity >= 5) {
					temp = rand(10);
					if (temp <= 3) vag += "super-stretchy";
					else if (temp <= 7) vag += "incredibly elastic";
					else vag += "powerfully pliable";
				} else {
					temp = rand(10);
					if (temp <= 1) vag += "stretchy";
					else if (temp <= 3) vag += "elastic";
					else if (temp <= 5) vag += "pliable";
					else if (temp <= 7) vag += "flexible";
					else vag += "pliant";
				}
				descripted++;
			}
			if (descripted < 2 && (skinType == GLOBAL.SKIN_TYPE_GOO || vaginas[vaginaNum].hasFlag(GLOBAL.FLAG_GOOEY)) && ((adjectives && rand(3) == 0) || forceAdjectives)) {
				if (descripted > 0) vag += ", ";
				if (rand(2) == 0) vag += "gooey";
				else vag += "slimy";
				descripted++;
			}
			//50% of time, simple cunt.
			if (rand(2) == 0) {
				if (descripted > 0) vag += " ";
				vag += vaginaNoun2(vaginas[vaginaNum], true);
			}
			//50% of the time, complex cunt!
			else {
				if (descripted > 0) vag += ", ";
				vag += vaginaNoun2(vaginas[vaginaNum]);
			}
			return vag;
		}
		//eachVagina
		public function eachVagina(): String {
			var desc: String = "";
			if (vaginas.length > 1) desc += "each of ";
			desc += "your " + vaginasDescript();
			return desc;
		}
		//oneVagina
		public function oneVagina(): String {
			var desc: String = "";
			if (vaginas.length > 1) desc += "one of ";
			desc += "your " + vaginasDescript();
			return desc;
		}
		//Allvagina descript
		public function vaginasDescript(): String {
			if (vaginas.length == 1) return vaginaDescript();
			if (vaginas.length > 1) 
			{
				//Matching cunts get type descriptor.
				if(vaginasMatch()) return plural(vaginaDescript(rand(vaginas.length)));
				//Mixed vaginas get plain result - vaginaNoun with oddball value results in plain shit.
				else
				{
					return plural(vaginaNoun2(vaginas[0],true,"default"));
				}
			}
			return "ERROR: vagina<b>s</b>Descript called with no vaginas.";
		}
		public function vaginasMatch():Boolean 
		{
			return matchedVaginas();
		}
		public function matchedVaginas():Boolean {
			for(var x:int = 0; x < totalVaginas(); x++)
			{	
				//After the first cooch, see if they match against the previous.
				if(x > 0)
				{
					//Don't match? NOT MATCHED. GTFO.
					if(vaginas[x].type != vaginas[x-1].type) return false;
					//Flag check
					if(vaginas[x].vagooFlags.length == vaginas[x-1].vagooFlags.length)
					{
						for(var i:int = 0; i < vaginas[x].vagooFlags.length; i++)
						{
							if(!vaginas[x-1].hasFlag(vaginas[x].vagooFlags[i])) return false;
						}
					}
					else return false;
				}
			}
			return true;
		}
		public function multiCockDescript(dynamicLength:Boolean = false): String {
			if (cocks.length < 1) return "<b>Error: multiCockDescript() called with no penises present.</b>";
			//Get cock counts
			var descript: String = "";
			var rando: Number = 0;
			var descripted: Boolean = false;

			//Single dick gets normal output
			if (cocks.length == 1) return cockDescript(0, dynamicLength);

			//Numbers!
			else if (cocks.length <= 2) {
				//For cocks that are the same
				if (hasSamecType()) {
					rando = rand(5);
					if (rando == 0) descript += "pair of ";
					if (rando == 1) descript += "two, ";
					if (rando == 2) descript += "brace of ";
					if (rando == 3) descript += "matching, ";
					if (rando == 4) descript += "twin, ";
				}
				//Nonidentical
				else {
					rando = rand(3);
					if (rando == 0) descript += "pair of ";
					if (rando == 1) descript += "two, ";
					if (rando == 2) descript += "brace of ";
				}
			} else if (cocks.length <= 3) {
				//For samecocks
				if (hasSamecType()) {
					rando = rand(5);
					if (rando == 0) descript += "three, ";
					if (rando == 1) descript += "group of ";
					if (rando == 2) descript += "menage a trois of ";
					if (rando == 3) descript += "triad of ";
					if (rando == 4) descript += "triumvirate of ";
				} else {
					rando = rand(2);
					if (rando == 0) descript += "three, ";
					if (rando == 1) descript += "group of ";
				}
			}
			//Large numbers of cocks!
			else {
				rando = rand(4);
				if (rando == 0) descript += "bundle of ";
				if (rando == 1) descript += "obscene group of ";
				if (rando == 2) descript += "cluster of ";
				if (rando == 3) descript += "wriggling bunch of ";
			}
			//Append Nounse
			if (hasSamecType()) descript += cockAdjective(-1, dynamicLength) + ", " + plural(cockNoun2(cocks[0], false, ""));
			else {
				rando = rand(4);
				if (rando == 0) descript += cockAdjective(-1, dynamicLength) + ", mutated cocks";
				if (rando == 1) descript += cockAdjective(-1, dynamicLength) + ", mutated dicks";
				if (rando == 2) descript += cockAdjective(-1, dynamicLength) + ", mixed cocks";
				if (rando == 3) descript += cockAdjective(-1, dynamicLength) + ", mismatched dicks";
			}
			return descript;
		}
		public function hasSamecType(): Boolean {
			if (cocks.length == 0) return false;
			var first: int = cocks[0].cType;
			for (var x: int = 0; x < cocks.length; x++) {
				if (cocks[x].cType != first) return false;
			}
			return true;
		}
		private function clearList(): void {
			list = new Array();
		}
		private function addToList(arg:*): void {
			list[list.length] = arg;
		}
		public function getListLength():uint
		{
			if (list == null) return 0;
			return list.length;
		}
		private function formatList(): String {
			var stuff: String = "";
			if (list.length == 1) return list[0];
			for (var x: int = 0; x < list.length; x++) {
				stuff += list[x];
				if (list.length == 2 && x == 0) {
					stuff += " and ";
				} else if (x < list.length - 2) {
					stuff += ", ";
				} else if (x < list.length - 1) {
					stuff += ", and ";
				}
			}
			list = new Array();
			return stuff;
		}
		public function isPsionic():Boolean
		{
			return false;
		}
		public function gearDescript(): String {
			clearList();
			if (armor.shortName != "") addToList(armor.longName);
			if (upperUndergarment.shortName != "") addToList(upperUndergarment.longName);
			if (lowerUndergarment.shortName != "") addToList(lowerUndergarment.longName);
			if (isNude()) addToList("gear");
			return formatList();
		}
		public function clothesDescript():String
		{
			if (!(armor is EmptySlot)) return armor.longName;
			else
			{
				clearList();
				if (!(upperUndergarment is EmptySlot)) addToList(upperUndergarment.longName);
				if (!(lowerUndergarment is EmptySlot)) addToList(lowerUndergarment.longName);
				return formatList();
			}
		}
		public function crotchDescript(dynamicLength:Boolean = false):String {

			clearList();
			
			//Nothing to talk about? K
			if(!hasCock() && !hasVagina()) 
			{
				if(rand(2) == 0) return "bare crotch";
				else return "bare groin";
			}
			//Make da list!
			if(hasCock()) addToList(cocksDescript(dynamicLength));
			if(balls > 0) addToList(ballsDescript());
			if(hasVagina()) addToList(vaginasDescript());
			
			return formatList();
		}
		public function lowerGarmentDescript(): String {
			if (lowerUndergarment.shortName != "") return lowerUndergarment.longName;
			else if (armor.shortName != "") return armor.longName;
			else return "nothing";
		}
		public function lowerGarmentOuterDescript(): String {
			if (armor.shortName != "") return armor.longName;
			else if (lowerUndergarment.shortName != "") return lowerUndergarment.longName;
			else return "nothing";
		}
		public function upperGarmentDescript(): String {
			if (upperUndergarment.shortName != "") return upperUndergarment.longName;
			else if (armor.shortName != "") return armor.longName;
			else return "nothing";
		}
		public function upperGarmentOuterDescript(): String {
			if (armor.shortName != "") return armor.longName;
			else if (upperUndergarment.shortName != "") return upperUndergarment.longName;
			else return "nothing";
		}
		public function upperGarmentsDescript(): String {
			if (upperUndergarment.shortName != "" && armor.shortName != "") return armor.longName + " and " + upperUndergarment.longName;
			else if (upperUndergarment.shortName != "") return upperUndergarment.longName;
			else if (armor.shortName != "") return armor.longName;
			else return "nothing";
		}
		public function lowerGarmentsDescript(): String {
			if (lowerUndergarment.shortName != "" && armor.shortName != "") return armor.longName + " and " + lowerUndergarment.longName;
			else if (lowerUndergarment.shortName != "") return lowerUndergarment.longName;
			else if (armor.shortName != "") return armor.longName;
			else return "nothing";
		}
		//Basic multiple cock description.
		public function cocksDescript(dynamicLength:Boolean = false): String {
			if (cocks.length < 1) return "<b>ERROR: NO WANGS DETECTED for cocksDescript()</b>";
			//Single dicks are normal.
			else if (cocks.length == 1) return cockDescript(0, dynamicLength);
			//Matched dicks get full cocknoun.
			if (hasSamecType()) return plural(cockAdjective(-1, dynamicLength) + ", " + cockNoun2(cocks[0], false));
			//Unmatched get default types
			else return plural(cockAdjective(-1, dynamicLength) + " " + randomSimpleCockNoun());
		}
		//Ultra-basic multiple cock description
		public function cocksDescriptLight(): String {
			var output: String = "";
			if (cocks.length < 1) return "<b>ERROR: NO WANGS DETECTED for cocksDescript()</b>";
			if (hasSamecType()) output += cockNoun2(cocks[0]);
			else output += randomSimpleCockNoun();
			//pluralize dat shit
			if (cockTotal() > 1) output = plural(output);
			return output;
		}
		public function simpleCockNoun(arg: Number): String {
			if (cocks.length < 1) return "<b>ERROR: NO WANGS DETECTED for simpleCockNoun()</b>";
			return cockNoun2(cocks[arg], true);
		}
		public function simpleCocksNoun():String {
			var output:String = "";
			
			if (cocks.length < 1) return "<b>ERROR: NO WANGS DETECTED for simpleCocksNoun()</b>";
			if (hasSamecType()) output += cockNoun2(cocks[0], true);
			else output += randomSimpleCockNoun();
			
			if (cocks.length > 1) output = plural(output);
			
			return output;
		}
		public function cockNounComplex(arg: Number): String {
			if (cocks.length < 1) return "<b>ERROR: NO WANGS DETECTED for cockNounComplex()</b>";
			return cockNoun2(cocks[arg], false);
		}
		//Spit back an accurate name for the cock
		public function accurateCockName(cockIndex:int):String
		{
			var collection:Array = new Array();
			var type:String = GLOBAL.TYPE_NAMES[cocks[cockIndex].cType];
			type = type.toLowerCase();
			var name:String = RandomInCollection(["prick","cock","cock","cock","penis","tool","member","pecker","dong","phallus","phallus","dick","dick","dick"]);
			
			return type + " " + name;
		}
		// Spit back a singular word related to the shape of the target cock, with the minimum
		// of ambiguity. Basically describe a very clear feature of the cock, either its type or a flag.
		// I didn't want to potentially fuck up an existing descriptor in the process, so I've opted to keep it separate.
		public function cockShape(cockIndex:int):String
		{
			var cock:CockClass = cocks[cockIndex];
			var collection:Array = [];
			
			// main shapes
			switch (cock.cType)
			{
				case GLOBAL.TYPE_HUMAN:
					collection = ["terran"];
					break;
				case GLOBAL.TYPE_CANINE:
					collection = ["canine"];
					break;
				case GLOBAL.TYPE_VULPINE:
					collection = ["vulpine"];
					break;
				case GLOBAL.TYPE_EQUINE:
				case GLOBAL.TYPE_KUITAN:
					collection = ["equine"];
					break;
				case GLOBAL.TYPE_DEMONIC:
					collection = ["demonic", "nodule-laden"]
					break;
				case GLOBAL.TYPE_TENTACLE:
					collection = ["tentacle"];
					break;
				case GLOBAL.TYPE_FELINE:
					collection = ["feline", "barbed"];
					break;
				case GLOBAL.TYPE_NAGA:
				case GLOBAL.TYPE_SNAKE:
					collection = ["snake", "reptilian"];
					break;
				case GLOBAL.TYPE_DRACONIC:
					collection = ["draconic"];
					break;
				case GLOBAL.TYPE_BEE:
					collection = ["zil"];
					break;
				case GLOBAL.TYPE_KANGAROO:
					collection = ["kangaroo"];
					break;
				case GLOBAL.TYPE_ANEMONE:
					case GLOBAL.TYPE_SIREN:
					collection = ["tentacled"];
					break;
				case GLOBAL.TYPE_SIMII:
					collection = ["simii"];
					break;
				case GLOBAL.TYPE_RASKVEL:
					collection = ["raskvel"];
					break;
				case GLOBAL.TYPE_VENUSPITCHER:
					collection = ["plant", "vine-like"];
					break;
				case GLOBAL.TYPE_SAURIAN:
					collection = ["saurian", "dinosaur"];
					break;
				case GLOBAL.TYPE_SYNTHETIC:
					collection = ["synthetic", "robotic"];
					break;
				case GLOBAL.TYPE_NYREA:
					collection = ["nyrean", "insectile"];
					break;
				case GLOBAL.TYPE_DAYNAR:
					collection = ["daynarian", "reptilian"];
					break;
				case GLOBAL.TYPE_SYDIAN:
					collection = ["sydian", "insectile"];
					break;
				case GLOBAL.TYPE_COCKVINE:
					collection = ["plant", "vine-like"];
					break;
				case GLOBAL.TYPE_GABILANI:
					collection = ["gabilani", "goblin"];
					break;
				case GLOBAL.TYPE_VANAE:
					collection = ["vanae", "cephalopod-like"];
					break;
				case GLOBAL.TYPE_INHUMAN:
					collection = ["inhuman", "human-like", "alien"];
					break;
				
				default:
					trace("Fallback cock shape used in cockShape() for type: " + GLOBAL.TYPE_NAMES[cock.cType]);
					collection = ["bestial"];
					break;
			}
			
			// flag overrides
			if (cock.hasFlag(GLOBAL.FLAG_KNOTTED)) collection.push("knotted");
			//if (cock.hasFlag(GLOBAL.FLAG_SHEATHED)) collection.push("sheathed");
			if (cock.hasFlag(GLOBAL.FLAG_FLARED)) collection.push("flared");
			if (cock.hasFlag(GLOBAL.FLAG_BLUNT)) collection.push("blunt");
			if (cock.hasFlag(GLOBAL.FLAG_PREHENSILE)) collection.push("prehensile");
			if (cock.hasFlag(GLOBAL.FLAG_TAPERED)) collection.push("tapered");
			if (cock.hasFlag(GLOBAL.FLAG_STINGER_BASED)) collection.push("stinger-based");
			if (cock.hasFlag(GLOBAL.FLAG_STINGER_TIPPED)) collection.push("stinger-tipped");
			if (cock.hasFlag(GLOBAL.FLAG_NUBBY)) collection.push("nubby");
			if (cock.hasFlag(GLOBAL.FLAG_AMORPHOUS)) collection.push("amorphous");
			if (cock.hasFlag(GLOBAL.FLAG_SMOOTH)) collection.push("smooth");
			if (cock.hasFlag(GLOBAL.FLAG_RIBBED)) collection.push("ribbed");
			//if (cock.hasFlag(GLOBAL.FLAG_LUBRICATED)) collection.push("lubricated");
			//if (cock.hasFlag(GLOBAL.FLAG_STICKY)) collection.push("sticky");
			if (cock.hasFlag(GLOBAL.FLAG_FORESKINNED)) collection.push("foreskinned", "foreskin-covered");
			//if (cock.hasFlag(GLOBAL.FLAG_APHRODISIAC_LACED)) collection.push("aphrodisiac-laced");
			if (cock.hasFlag(GLOBAL.FLAG_DOUBLE_HEADED)) collection.push("double-headed");
			if (cock.hasFlag(GLOBAL.FLAG_GOOEY)) collection.push("gooey");
			
			return RandomInCollection(collection);
		}
		//Special - "tail" - Tail description
		//Special - "nipple" - NipplecockDesc
		public function cockNoun2(cock:CockClass, simple:Boolean = true, special:String = ""): String
		{
			var descript: String = "";
			var nouns:Array = new Array();
			var adjectives:Array = new Array();
			var type:int = cock.cType;
			if (type == GLOBAL.TYPE_HUMAN) {
				if (!simple) adjectives.push("human","terran");
			} 
			else if (type == GLOBAL.TYPE_CANINE) {
				adjectives.push("pointed","knotty","bestial","animalistic","knotted","canine","canine");
				nouns.push("doggie-dong","dog-cock","puppy-pecker","dog-dick");
			} else if (type == GLOBAL.TYPE_VULPINE) {
				adjectives.push("pointed","knotty","bestial","animalistic","knotted","vulpine","vulpine");
				nouns.push("fox-dick","fox-cock","fox-prick","fox-tool","vixen-pricker");
			} else if (type == GLOBAL.TYPE_EQUINE) {
				adjectives.push("flared","equine","bestial","flat-tipped","animalistic","blunted","musky");
				nouns.push("horse-cock","horse-shaft","horse-member","stallion-prick","beast-cock","stallion-cock");
			} else if (type == GLOBAL.TYPE_DEMONIC) {
				adjectives.push("nub-covered","nubby","perverse","bumpy","demonic","cursed","infernal","unholy","blighted","fiendish");
				nouns.push("demon-dick","demon-cock","demon-prick","monster-member");
			} else if (type == GLOBAL.TYPE_TENTACLE || type == GLOBAL.TYPE_COCKVINE) {
				adjectives.push("twisting","wriggling","sinuous","squirming","writhing","smooth","undulating","slithering","vine-like");
				nouns.push("tentacle-prick","plant-shaft","tentacle-cock","cock-tendril","tentacle-pecker","plant-prick","tentacle-dick");
			} else if (type == GLOBAL.TYPE_FELINE) {
				adjectives.push("feline","spine-covered","spined","kitty","animalistic","soft-barbed","nubby","feline");
				nouns.push("cat-cock","kitty-cock","kitty-prick","cat-penis","kitten-prick");
			} else if (type == GLOBAL.TYPE_NAGA || type == GLOBAL.TYPE_SNAKE) {
				adjectives.push("reptilian","ophidian","inhuman","reptilian","herpetological","serpentine","bulbous","bulging");
				nouns.push("snake-cock","snake-shaft","snake-dick");
			} else if (type == GLOBAL.TYPE_RASKVEL) {
				adjectives.push("reptilian","alien","raskvel","reptilian","smooth","sleek","exotic");
				nouns.push("rask-cock");
			} else if (type == GLOBAL.TYPE_ANEMONE || type == GLOBAL.TYPE_SIREN) {
				adjectives.push("tentacle-ringed","stinger-laden","pulsating","stinger-coated","near-transparent","tentacle-ringed","squirming");
				nouns.push("anemone-dick","anemone-prick");
			} else if (type == GLOBAL.TYPE_KANGAROO) {
				adjectives.push("pointed","marsupial","tapered","curved");
				nouns.push("kangaroo-cock","kangaroo-dick","kanga-cock");
			} else if (type == GLOBAL.TYPE_DRACONIC) {
				adjectives.push("dragon-like","segmented","pointed","knotted","mythic","draconic","tapered");
				if (!cock.hasFlag(GLOBAL.FLAG_GOOEY) || skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("scaly");
				nouns.push("dragon-cock","dragon-dick","wyrm-cock");
			} else if (type == GLOBAL.TYPE_BEE) {
				adjectives.push("foreskin-covered","alien","vaguely human-like","smooth");
				if (!cock.hasFlag(GLOBAL.FLAG_GOOEY) || skinType != GLOBAL.SKIN_TYPE_GOO) adjectives.push("thick-skinned","fleshy","skin-shrouded");
				nouns.push("zil-dick","zil-prick","zil-cock","wasp-cock");
			} else if (type == GLOBAL.TYPE_KUITAN) {
				adjectives.push("alien","bulgy","knot-lined","extra knotty","bestial","kui-tan","inhuman","exotic","knotted");
				nouns.push("'nuki-dick","kui-cock","spunk-dispensor","xeno-cock");
			} else if (type == GLOBAL.TYPE_SIMII) {
				adjectives.push("simian");
				nouns.push("simii-dick","simii-cock");
			} else if (type == GLOBAL.TYPE_RASKVEL) {
				adjectives.push("raskvel");
				nouns.push("rask-dick","rask-cock","egg-fertilizer");
			} else if (type == GLOBAL.TYPE_VENUSPITCHER) {
				adjectives.push("floral");
				nouns.push("plant-dick","plant-cock","vine-dick","vine-cock");
			} else if (type == GLOBAL.TYPE_SAURIAN) {
				adjectives.push("dinosaur", "saurian");
				nouns.push("dino-dick","dino-cock","penisaurus","schlongosaur");
			} else if (type == GLOBAL.TYPE_SYNTHETIC) {
				adjectives.push("metallic", "synthetic", "mechanical", "robotic", "sleek");
				nouns.push("robo-dick","robo-cock","mecha-dick","mecha-cock");
			} else if (type == GLOBAL.TYPE_NYREA) {
				adjectives.push("nyrean", "insectile", "egg-laying", "nyrean", "insectile");
				nouns.push("ovipositor", "organ", "tool", "member", "tube");
			} else if (type == GLOBAL.TYPE_DAYNAR) {
				adjectives.push("daynarian", "reptilian", "inhuman", "reptilian");
				nouns.push("daynar-cock", "daynar-shaft", "daynar-dick");
			} else if (type == GLOBAL.TYPE_SYDIAN) {
				adjectives.push("sydian", "insectile", "inhuman", "bristly", "brush-like");
				nouns.push("bug-cock", "bug-shaft", "bug-dick");
			} else if (type == GLOBAL.TYPE_AVIAN) {
				adjectives.push("avian", "bird-like");
				nouns.push("bird-cock", "bird-shaft", "bird-dick");
			} else if (type == GLOBAL.TYPE_GABILANI) {
				adjectives.push("alien", "bulbous", "double-crowned", "gabilani", "goblin", "inhuman", "exotic", "two-headed");
				nouns.push("goblin-dick", "goblin-cock", "goblin-prick", "gabilani-dick", "gabilani-cock", "gabilani-prick");
			} else if (type == GLOBAL.TYPE_VANAE) {
				adjectives.push("vanae", "alien", "suckler-tipped", "vanae", "cephalopod-like", "inhuman", "exotic");
				nouns.push("vanae-dick", "vanae-cock", "vanae-prick");
			} else if (type == GLOBAL.TYPE_INHUMAN) {
				adjectives.push("inhuman", "human-like", "almost-human", "alien");
			} else {
				nouns.push("Error. Cock type does not have a cock noun configuration.");
			}
			
			if (cock.hasFlag(GLOBAL.FLAG_GOOEY)) {
				adjectives.push("gooey","self-lubricating","slick");
				nouns.push("goo-dick","goo-cock");
			}
			nouns.push("cock","cock","dick","prick","shaft","member","dong","tool","phallus");
			
			if(!simple && adjectives.length > 0) 
			{
				descript = RandomInCollection(adjectives);
				//Prevent duplicate "canine dog-cock" type deals.
				if(InCollection(descript,"gabilani","goblin","insectile","robotic","mechanical","dinosaur","saurian","floral","gooey","raskvel","simian","kui-tan","draconic","dragon-like","marsupial","reptilian","serpentine","kitty","feline","demonic","equine","vulpine","canine","gooey"))
				{
					descript += " " + RandomInCollection("cock","cock","dick","prick","shaft","member","dong","tool","phallus");
					return descript;
				}
				descript += " ";
			}
			if(special == "tail" && rand(2) == 0) descript += "tail-" + RandomInCollection(["cock","cock","dick","prick","phallus"]);
			else if(special == "dick" && rand(2) == 0) descript += RandomInCollection(["dick","cock","prick"] + "-nipple");
			else descript += RandomInCollection(nouns);
			
			return descript;
		}
		//New cock adjectives. The old one sucked dicks
		public function cockAdjective(cockNum: Number = -1, dynamicLength:Boolean = false):String {
			var descript: String = "";
			var rando: Number = 0;
			var multi: Boolean = false;
			//If used for multiple cocks, set multi flag
			if (cockNum < 0) {
				//Since we have multi dicks lets talk about the biggest!
				cockNum = biggestCockIndex();
				multi = true;
			}
			var cLength: Number = cLength(cockNum, dynamicLength);
			//Color: 1/15 chance
			if (!multi && rand(15) == 0)
			{
				descript += cocks[cockNum].cockColor;
			}
			//Bimbo flavor - 1/6 chance
			else if(rand(6) == 0 && isBimbo())
			{
				if(rand(7) == 8 && cLength < 6) descript += "cute";
				else if(rand(7) == 0) descript += "mouth-watering";
				else if(rand(6) == 0) descript += "totally sexy";
				else if(rand(5) == 0) descript += "super hot";
				else if(rand(4) == 0) descript += "delicious-looking";
				else if(rand(3) == 0 && cLength >= 10) descript += "awe-inspiring";
				else descript += "yummy";
			}
			//Pierced - 1/5 chance
			else if (!multi && rand(5) == 0 && cocks[cockNum].pierced > 0) {
				descript += "pierced";
			}
			//Cocksocks!
			else if (!multi && rand(5) == 0 && cocks[cockNum].sock != "") {
				rando = rand(6);
				if (rando == 0) descript += "sock-sheathed";
				else if (rando == 1) descript += "garment-wrapped";
				else if (rando == 2) descript += "smartly dressed";
				else if (rando == 3) descript += "cloth-shrouded";
				else if (rando == 4) descript += "fabric swaddled";
				else descript += "covered";
			}
			//Goo - 1/4 chance
			else if (skinType == GLOBAL.SKIN_TYPE_GOO || cocks[cockNum].hasFlag(GLOBAL.FLAG_GOOEY) && rand(4) == 0) {
				rando = rand(3);
				if (rando == 0) descript += "goopey";
				else if (rando == 1) descript += "gooey";
				else descript += "slimy";
			}
			//Knot - 1/5 chance. Only specifically called out if dick isn't dog, since knot shows up with the
			//canine nouns.
			else if(rand(5) == 0 && cocks[cockNum].hasFlag(GLOBAL.FLAG_KNOTTED) && cocks[cockNum].cType != GLOBAL.TYPE_CANINE && cocks[cockNum].cType != GLOBAL.TYPE_SNAKE && cocks[cockNum].cType != GLOBAL.TYPE_NAGA)
			{
				if(rand(3) == 0) descript += "knotted";
				else if(rand(2) == 0) descript += "bulbous";
				else descript += "knotty";
			}
			//Length 1/3 chance
			else if (rand(3) == 0) {
				if (cLength < 3) {
					rando = rand(4);
					if (rando == 0) descript = "little";
					else if (rando == 1) descript = "toy-sized";
					else if (rando == 2) descript = "mini";
					else if (rando == 3) descript = "budding";
					else descript = "tiny";
				} else if (cLength < 5) {
					rando = rand(2);
					if (rando == 0) descript = "short";
					else descript = "small";
				} else if (cLength < 7) {
					rando = rand(2);
					if (rando == 0) descript = "fair-sized";
					else descript = "nice";
				} else if (cLength < 11) {
					rando = rand(3);
					if (rando == 0) {
						if (cocks[cockNum].cType == GLOBAL.TYPE_EQUINE) descript = "pony-sized";
						else descript = "long";
					} else if (rando == 1) {
						if (cocks[cockNum].cType == GLOBAL.TYPE_EQUINE) descript = "colt-like";
						else descript = "lengthy";
					} else descript = "sizable";
				} else if (cLength < 14) {
					rando = rand(3);
					if (rando == 0) descript = "huge";
					else if (rando == 1) {
						if (cocks[cockNum].cType == GLOBAL.TYPE_CANINE) descript = "mastiff-like";
						else descript = "cucumber-length";
					} else descript = "foot-long";
				} else if (cLength < 18) {
					rando = rand(3);
					if (rando == 0) descript = "massive";
					else if (rando == 1) descript = "knee-length";
					else descript = "forearm-length";
				} else if (cLength < 30) {
					rando = rand(3);
					if (rando == 0) descript = "enormous";
					else if (rando == 1) descript = "giant";
					else descript = "arm-length";
				} else if (cLength < 50) {
					rando = rand(7);
					if (cocks[cockNum].cType == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "towering";
						else if (rando == 1) descript = "freakish";
						else if (rando == 2) descript = "monstrous";
						else if (rando == 3) descript = "imposing";
						else if (rando == 4) descript = "prodigious";
						else if (rando == 5) descript = "hyper";
						else descript = "massive";
					}
				} else if (cLength < 100) {
					rando = rand(8);
					if (cocks[cockNum].cType == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "person-sized";
						else if (rando == 1) descript = "ridiculously massive";
						else if (rando == 2) descript = "extremely prodigious";
						else if (rando == 3) descript = "overly imposing";
						else if (rando == 4) descript = "floor-dragging";
						else if (rando == 5) descript = "colossal";
						else if (rando == 6) descript = "very hyper";
						else descript = "monumental";
					}
				} else {
					rando = rand(6);
					if (cocks[cockNum].cType == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "car-sized";
						else if (rando == 1) descript = "vehicle-sized";
						else if (rando == 2) descript = "movement-impairing";
						else if (rando == 3) descript = "floor-dragging";
						else if (rando == 4) descript = "extremely hyper";
						else descript = "monumental";
					}
				}
			}
			//Hornyness 1/2
			else if (lust() > 75 && rand(2) == 0) {
				//Uber horny like a baws!
				if (lust() > 90) {
					//Weak as shit cum
					if (cumQ() < 50) {
						if (rand(2) == 0) descript += "throbbing";
						else descript += "pulsating";
					}
					//lots of cum? drippy.
					else if (cumQ() < 200) {
						rando = rand(3);
						if (rando == 0) descript += "dribbling";
						else if (rando == 1) descript += "drooling";
						else descript += "leaking";
					}
					//Tons of cum
					else {
						rando = rand(5);
						if (rando == 0) descript += "very drippy";
						else if (rando == 1) descript += "pre-gushing";
						else if (rando == 2) descript += "cum-bubbling";
						else if (rando == 3) descript += "pre-slicked";
						else descript += "pre-drooling";
					}
				}
				//A little less lusty, but still lusty.
				else if (lust() > 75) {
					if (cumQ() < 50) {
						rando = rand(5);
						if (rando == 0) descript += "turgid";
						else if (rando == 1) descript += "blood-engorged";
						else if (rando == 2) descript += "rock-hard";
						else if (rando == 3) descript += "stiff";
						else descript += "eager";
					}
					//A little drippy
					else if (cumQ() < 200) {
						rando = rand(10);
						if (rando == 0) descript += "turgid";
						else if (rando == 1) descript += "blood-engorged";
						else if (rando == 2) descript += "rock-hard";
						else if (rando == 3) descript += "stiff";
						else if (rando == 4) descript += "eager";
						else if (rando < 7) descript += "fluid-beading";
						else descript += "slowly-oozing";
					}
					//uber drippy
					else {
						rando = rand(4);
						if (rando == 0) descript += "dribbling";
						else if (rando == 1) descript += "drooling";
						else if (rando == 2) descript += "fluid-leaking";
						else descript += "leaking";
					}
				}
			}
			//Girth - fallback
			else {
				if (cocks[cockNum].thickness() <= .99) {
					rando = rand(3);
					if (rando == 0) descript += "thin";
					else if (rando == 1) descript += "slender";
					else descript += "narrow";
				} else if (cocks[cockNum].thickness() <= 1.2) {
					descript += "modest";
					
					//else if (rando == 1) descript += "fleshy";
					//else descript += "substantial";
				} else if (cocks[cockNum].thickness() <= 1.6) {
					rando = rand(3);
					if (rando == 0) descript += "ample";
					else if (rando == 1) descript += "meaty";
					else descript += "generously-proportioned";
				} else if (cocks[cockNum].thickness() <= 2) {
					rando = rand(4);
					if (rando == 0) descript += "broad";
					else if (rando == 1) descript += "girthy";
					else if (rando == 2) descript += "expansive";
					else descript += "thick";
				} else if (cocks[cockNum].thickness() <= 3.5) {
					rando = rand(4);
					if (rando == 0) descript += "fat";
					else if (rando == 1) descript += "wide";
					else if (rando == 2) descript += "voluminous";
					else descript += "distended";
				} else if (cocks[cockNum].thickness() > 3.5) {
					rando = rand(4);
					if (rando == 0) descript += "inhumanly distended";
					else if (rando == 1) descript += "bloated";
					else if (rando == 2) descript += "mammoth";
					else descript += "monstrously thick";
				}
			}
			return descript;
		}
		//New cock adjectives. The old one sucked dicks
		public function statCockAdjective(l: int, w: int, type: int = 0):String {
			var descript: String = "";
			var rando: Number = 0;
			var multi: Boolean = false;
			//Goo - 1/4 chance
			if ((skinType == GLOBAL.SKIN_TYPE_GOO) && rand(4) == 0) {
				rando = rand(3);
				if (rando == 0) descript += "goopey";
				else if (rando == 1) descript += "gooey";
				else descript += "slimy";
			}
			//Length 1/3 chance
			else if (rand(3) == 0) {
				if (l < 3) {
					rando = rand(4);
					if (rando == 0) descript = "little";
					else if (rando == 1) descript = "toy-sized";
					else if (rando == 2) descript = "mini";
					else if (rando == 3) descript = "budding";
					else descript = "tiny";
				} else if (l < 5) {
					rando = rand(2);
					if (rando == 0) descript = "short";
					else descript = "small";
				} else if (l < 7) {
					rando = rand(2);
					if (rando == 0) descript = "fair-sized";
					else descript = "nice";
				} else if (l < 11) {
					rando = rand(3);
					if (rando == 0) {
						if (type == GLOBAL.TYPE_EQUINE) descript = "pony-sized";
						else descript = "long";
					} else if (rando == 1) {
						if (type == GLOBAL.TYPE_EQUINE) descript = "colt-like";
						else descript = "lengthy";
					} else descript = "sizable";
				} else if (l < 14) {
					rando = rand(3);
					if (rando == 0) descript = "huge";
					else if (rando == 1) {
						if (type == GLOBAL.TYPE_CANINE) descript = "mastiff-like";
						else descript = "cucumber-length";
					} else descript = "foot-long";
				} else if (l < 18) {
					rando = rand(3);
					if (rando == 0) descript = "massive";
					else if (rando == 1) descript = "knee-length";
					else descript = "forearm-length";
				} else if (l < 30) {
					rando = rand(3);
					if (rando == 0) descript = "enormous";
					else if (rando == 1) descript = "giant";
					else descript = "arm-length";
				} else if (l < 50) {
					rando = rand(7);
					if (type == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "towering";
						else if (rando == 1) descript = "freakish";
						else if (rando == 2) descript = "monstrous";
						else if (rando == 3) descript = "imposing";
						else if (rando == 4) descript = "prodigious";
						else if (rando == 5) descript = "hyper";
						else descript = "massive";
					}
				} else if (l < 100) {
					rando = rand(8);
					if (type == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "person-sized";
						else if (rando == 1) descript = "ridiculously massive";
						else if (rando == 2) descript = "extremely prodigious";
						else if (rando == 3) descript = "overly imposing";
						else if (rando == 4) descript = "floor-dragging";
						else if (rando == 5) descript = "colossal";
						else if (rando == 6) descript = "very hyper";
						else descript = "monumental";
					}
				} else {
					rando = rand(6);
					if (type == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "car-sized";
						else if (rando == 1) descript = "vehicle-sized";
						else if (rando == 2) descript = "movement-impairing";
						else if (rando == 3) descript = "floor-dragging";
						else if (rando == 4) descript = "extremely hyper";
						//else if (rando == 5) descript += "virgin destroying";
						//else if (rando == 6) descript += "small asteroid sized";
						else descript = "monumental";
					}
				}
			}
			//Hornyness 1/2
			else if (lust() > 75 && rand(2) == 0) {
				//Uber horny like a baws!
				if (lust() > 90) {
					//Weak as shit cum
					if (cumQ() < 50) {
						if (rand(2) == 0) descript += "throbbing";
						else descript += "pulsating";
					}
					//lots of cum? drippy.
					else if (cumQ() < 200) {
						rando = rand(3);
						if (rando == 0) descript += "dribbling";
						else if (rando == 1) descript += "drooling";
						else descript += "leaking";
					}
					//Tons of cum
					else {
						rando = rand(5);
						if (rando == 0) descript += "very drippy";
						else if (rando == 1) descript += "pre-gushing";
						else if (rando == 2) descript += "cum-bubbling";
						else if (rando == 3) descript += "pre-slicked";
						else descript += "pre-drooling";
					}
				}
				//A little less lusty, but still lusty.
				else if (lust() > 75) {
					if (cumQ() < 50) {
						rando = rand(5);
						if (rando == 0) descript += "turgid";
						else if (rando == 1) descript += "blood-engorged";
						else if (rando == 2) descript += "rock-hard";
						else if (rando == 3) descript += "stiff";
						else descript += "eager";
					}
					//A little drippy
					else if (cumQ() < 200) {
						rando = rand(10);
						if (rando == 0) descript += "turgid";
						else if (rando == 1) descript += "blood-engorged";
						else if (rando == 2) descript += "rock-hard";
						else if (rando == 3) descript += "stiff";
						else if (rando == 4) descript += "eager";
						else if (rando < 7) descript += "fluid-beading";
						else descript += "slowly-oozing";
					}
					//uber drippy
					else {
						rando = rand(4);
						if (rando == 0) descript += "dribbling";
						else if (rando == 1) descript += "drooling";
						else if (rando == 2) descript += "fluid-leaking";
						else descript += "leaking";
					}
				}
			}
			//Girth - fallback
			else {
				if (w <= .99) {
					rando = rand(3);
					if (rando == 0) descript += "thin";
					else if (rando == 1) descript += "slender";
					else descript += "narrow";
				} else if (w <= 1.2) {
					rando = rand(3);
					if (rando == 0) descript += "ordinary";
					else if (rando == 1) descript += "fleshy";
					else descript += "substantial";
				} else if (w <= 1.6) {
					rando = rand(3);
					if (rando == 0) descript += "ample";
					else if (rando == 1) descript += "meaty";
					else descript += "generously-proportioned";
				} else if (w <= 2) {
					rando = rand(4);
					if (rando == 0) descript += "broad";
					else if (rando == 1) descript += "girthy";
					else if (rando == 2) descript += "expansive";
					else descript += "thick";
				} else if (w <= 3.5) {
					rando = rand(4);
					if (rando == 0) descript += "fat";
					else if (rando == 1) descript += "wide";
					else if (rando == 2) descript += "voluminous";
					else descript += "distended";
				} else if (w > 3.5) {
					rando = rand(4);
					if (rando == 0) descript += "inhumanly distended";
					else if (rando == 1) descript += "bloated";
					else if (rando == 2) descript += "mammoth";
					else descript += "monstrously thick";
				}
			}
			return descript;
		}
		public function nippleLength(row: int = 0): Number {
			if (row >= bRows()) return 0;
			else if (row < 0) return 0;
			else return (nippleLengthRatio * .25 * ((10 + breastRows[row].breastRating()) / 10));
		}
		public function nippleWidth(row: int = 0): Number {
			if (row >= bRows()) return 0;
			else if (row < 0) return 0;
			else return (nippleWidthRatio * .5 * ((10 + breastRows[row].breastRating()) / 10));
		}
		//New cock adjectives. The old one sucked dicks
		public function nippleCockAdjective(plural: Boolean = false):String {
			var descript: String = "";
			var rando: Number = 0;
			var l: Number = nippleLength(0) * dickNippleMultiplier;
			var w: Number;
			if (l <= 10) w = l / 6;
			else if (l <= 30) w = (l - 10) / 10 + 10 / 6;
			else w = 20 / 10 + 10 / 6 + (l - 30) / 20;
			//Nipple descriptions 1/4 of the time!
			if (rand(4) == 0) {
				if (rand(3) == 0) descript += "nipple-sheathed";
				else if (rand(2) == 0) descript += nippleColor + "-surrounded";
				else {
					if (plural) descript += "areola-wreathed";
					else descript += "areolae-wreathed";
				}
			}
			//Goo - 1/4 chance
			else if (skinType == GLOBAL.SKIN_TYPE_GOO && rand(4) == 0) {
				rando = rand(3);
				if (rando == 0) descript += "goopey";
				else if (rando == 1) descript += "gooey";
				else descript += "slimy";
			}
			//Length 1/3 chance
			else if (rand(3) == 0) {
				if (l < 3) {
					rando = rand(4);
					if (rando <= 1) descript = "little";
					else if (rando == 2) descript = "mini";
					else if (rando == 3) descript = "budding";
					else descript = "tiny";
				} else if (l < 5) {
					rando = rand(2);
					if (rando == 0) descript = "short";
					else descript = "small";
				} else if (l < 7) {
					rando = rand(2);
					if (rando == 0) descript = "fair-sized";
					else descript = "nice";
				} else if (l < 11) {
					rando = rand(3);
					if (rando == 0) {
						if (dickNippleType == GLOBAL.TYPE_EQUINE) descript = "pony-sized";
						else descript = "long";
					} else if (rando == 1) {
						if (dickNippleType == GLOBAL.TYPE_EQUINE) descript = "colt-like";
						else descript = "lengthy";
					} else descript = "sizable";
				} else if (l < 14) {
					rando = rand(3);
					if (rando == 0) descript = "huge";
					else if (rando == 1) {
						if (dickNippleType == GLOBAL.TYPE_CANINE) descript = "mastiff-like";
						else descript = "cucumber-length";
					} else descript = "foot-long";
				} else if (l < 18) {
					rando = rand(3);
					if (rando == 0) descript = "massive";
					else if (rando == 1) descript = "knee-length";
					else descript = "forearm-length";
				} else if (l < 30) {
					rando = rand(3);
					if (rando == 0) descript = "enormous";
					else if (rando == 1) descript = "giant";
					else descript = "arm-length";
				} else if (l < 50) {
					rando = rand(7);
					if (dickNippleType == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "towering";
						else if (rando == 1) descript = "freakish";
						else if (rando == 2) descript = "monstrous";
						else if (rando == 3) descript = "imposing";
						else if (rando == 4) descript = "prodigious";
						else if (rando == 5) descript = "hyper";
						else descript = "massive";
					}
				} else if (l < 100) {
					rando = rand(8);
					if (dickNippleType == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "person-sized";
						else if (rando == 1) descript = "ridiculously massive";
						else if (rando == 2) descript = "extremely prodigious";
						else if (rando == 3) descript = "overly imposing";
						else if (rando == 4) descript = "floor-dragging";
						else if (rando == 5) descript = "colossal";
						else if (rando == 6) descript = "very hyper";
						else descript = "monumental";
					}
				} else {
					rando = rand(6);
					if (dickNippleType == GLOBAL.TYPE_FELINE && rand(4) == 0) descript = "coiled ";
					else {
						if (rando == 0) descript = "car-sized";
						else if (rando == 1) descript = "vehicle-sized";
						else if (rando == 2) descript = "movement-impairing";
						else if (rando == 3) descript = "floor-dragging";
						else if (rando == 4) descript = "extremely hyper";
						else descript = "monumental";
					}
				}
			}
			//Hornyness 1/2
			else if (lust() > 75 && rand(2) == 0) {
				//Uber horny like a baws!
				if (lust() > 90) {
					//Weak as shit cum
					if (cumQ() < 50) {
						if (rand(2) == 0) descript += "throbbing";
						else descript += "pulsating";
					}
					//lots of cum? drippy.
					else if (cumQ() < 200) {
						rando = rand(3);
						if (rando == 0) descript += "dribbling";
						else if (rando == 1) descript += "drooling";
						else descript += "leaking";
					}
					//Tons of cum
					else {
						rando = rand(5);
						if (rando == 0) descript += "very drippy";
						else if (rando == 1) descript += "pre-gushing";
						else if (rando == 2) descript += "cum-bubbling";
						else if (rando == 3) descript += "pre-slicked";
						else descript += "pre-drooling";
					}
				}
				//A little less lusty, but still lusty.
				else if (lust() > 75) {
					if (cumQ() < 50) {
						rando = rand(5);
						if (rando == 0) descript += "turgid";
						else if (rando == 1) descript += "blood-engorged";
						else if (rando == 2) descript += "rock-hard";
						else if (rando == 3) descript += "stiff";
						else descript += "eager";
					}
					//A little drippy
					else if (cumQ() < 200) {
						rando = rand(10);
						if (rando == 0) descript += "turgid";
						else if (rando == 1) descript += "blood-engorged";
						else if (rando == 2) descript += "rock-hard";
						else if (rando == 3) descript += "stiff";
						else if (rando == 4) descript += "eager";
						else if (rando < 7) descript += "fluid-beading";
						else descript += "slowly-oozing";
					}
					//uber drippy
					else {
						rando = rand(4);
						if (rando == 0) descript += "dribbling";
						else if (rando == 1) descript += "drooling";
						else if (rando == 2) descript += "fluid-leaking";
						else descript += "leaking";
					}
				}
			}
			//Girth - fallback
			else {
				if (w <= .99) {
					rando = rand(3);
					if (rando == 0) descript += "thin";
					else if (rando == 1) descript += "slender";
					else descript += "narrow";
				} else if (w <= 1.2) {
					rando = rand(3);
					if (rando == 0) descript += "ordinary";
					else if (rando == 1) descript += "fleshy";
					else descript += "substantial";
				} else if (w <= 1.6) {
					rando = rand(3);
					if (rando == 0) descript += "ample";
					else if (rando == 1) descript += "meaty";
					else descript += "generously-proportioned";
				} else if (w <= 2) {
					rando = rand(4);
					if (rando == 0) descript += "broad";
					else if (rando == 1) descript += "girthy";
					else if (rando == 2) descript += "expansive";
					else descript += "thick";
				} else if (w <= 3.5) {
					rando = rand(4);
					if (rando == 0) descript += "fat";
					else if (rando == 1) descript += "wide";
					else if (rando == 2) descript += "voluminous";
					else descript += "distended";
				} else if (w > 3.5) {
					rando = rand(4);
					if (rando == 0) descript += "inhumanly distended";
					else if (rando == 1) descript += "bloated";
					else if (rando == 2) descript += "mammoth";
					else descript += "monstrously thick";
				}
			}
			return descript;
		}
		public function cumColor(): String {
			return fluidColor(cumType);
		}
		public function milkColor(): String {
			return fluidColor(milkType);
		}
		public function girlCumColor(): String {
			return fluidColor(girlCumType);
		}
		public function fluidFlavor(arg: int):String {
			var collection:Array = [];
			//CUM & MILK TYPES
			if (arg == GLOBAL.FLUID_TYPE_MILK) {
				collection = ["creamy","creamy","creamy","creamy","creamy","delicious","delicious","delicious","sweet","creamy"];
			} else if (arg == GLOBAL.FLUID_TYPE_CUM) {
				collection = ["salty","salty","salty","salty","salty","salty","salty","potent","potent","potent"];
				if(isBimbo()) collection.push("yummy","yummy","yummy","delicious","delicious","tasty");
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_HONEY, GLOBAL.FLUID_TYPE_NECTAR)) {
				collection = ["sweet","sweet","sweet","sweet","sweet","syrupy","syrupy","syrupy","sugary","sugary"];
			} else if (arg == GLOBAL.FLUID_TYPE_OIL) {
				collection = ["tasteless"];
			} else if (arg == GLOBAL.FLUID_TYPE_MILKSAP) {
				collection = ["creamy","creamy","creamy","creamy","creamy","sweet","sweet","sweet","sugary","delicious"];
			} else if (arg == GLOBAL.FLUID_TYPE_GIRLCUM) {
				collection = ["tangy","tangy","tangy","tangy","tangy","tangy","tangy","flavorful","flavorful","flavorful"];
			} else if (arg == GLOBAL.FLUID_TYPE_CUMSAP) {
				collection = ["salty-sweet","salty-sweet","salty-sweet","salty-sweet","salty-sweet","syrupy","syrupy","syrupy","salty","salty"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_CHOCOLATE_MILK, GLOBAL.FLUID_TYPE_CHOCOLATE_CUM)) {
				collection = ["creamy","creamy","creamy","delicious","delicious","sweet","chocolatey","cocoa-flavored","rich"];
			} else if (arg == GLOBAL.FLUID_TYPE_STRAWBERRY_MILK) {
				collection = ["creamy","creamy","creamy","delicious","delicious","sweet","strawberry-flavored","fruity","rich"];
			} else if (arg == GLOBAL.FLUID_TYPE_SYDIAN_CUM) {
				collection = ["citrusy","citrusy","citrusy","citrusy","citrusy","tangy","tangy","tangy","metallic","metallic"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK, GLOBAL.FLUID_TYPE_VANAE_CUM)) {
				collection = ["sweet","fruity"];
			} else if (arg == GLOBAL.FLUID_TYPE_LEITHAN_MILK) {
				collection = ["tangy","tangy","tangy","tangy","tangy","sweet","sweet","sweet","intoxicating","intoxicating"];
			} else if (arg == GLOBAL.FLUID_TYPE_VANILLA) {
				collection = ["sweet","sugary","creamy","vanilla"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_NYREA_CUM, GLOBAL.FLUID_TYPE_NYREA_GIRLCUM)) {
				collection = ["salty","salty","salty","salty","salty","salty","salty","potent","potent","potent"];
			} else if (arg == GLOBAL.FLUID_TYPE_GABILANI_CUM) {
				collection = ["salty","potent"];
			} else if (arg == GLOBAL.FLUID_TYPE_GABILANI_GIRLCUM) {
				collection = ["tangy","flavorful"];
			} else if (arg == GLOBAL.FLUID_TYPE_SPECIAL_GOO) {
				collection = ["sweet","tangy","citrusy"];
			}
			
			else collection = ["bland"];
			
			return RandomInCollection(collection);
		}
		public function fluidViscosity(arg: int):String {
			var collection:Array = [];
			
			//CUM & MILK TYPES
			if (InCollection(arg, GLOBAL.FLUID_TYPE_MILK, GLOBAL.FLUID_TYPE_CHOCOLATE_MILK, GLOBAL.FLUID_TYPE_STRAWBERRY_MILK, GLOBAL.FLUID_TYPE_VANILLA)) {
				collection = ["creamy"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_CUM, GLOBAL.FLUID_TYPE_SYDIAN_CUM, GLOBAL.FLUID_TYPE_VANAE_CUM)) {
				collection = ["thick","thick","thick","slick","creamy"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_HONEY, GLOBAL.FLUID_TYPE_NECTAR)) {
				collection = ["sticky","sticky","sticky","slick","slick"];
			} else if (arg == GLOBAL.FLUID_TYPE_OIL) {
				collection = ["slippery","slick"];
			} else if (arg == GLOBAL.FLUID_TYPE_MILKSAP) {
				collection = ["creamy","syrupy"];
			} else if (arg == GLOBAL.FLUID_TYPE_GIRLCUM) {
				collection = ["slick","slick","slick","slick","slick","slick","slick","slippery","slippery","slippery"];
			} else if (arg == GLOBAL.FLUID_TYPE_CUMSAP) {
				collection = ["slick","slick","slick","slick","slick","sticky","sticky","sticky","syrupy","syrupy"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK)) {
				collection = ["creamy","creamy","creamy","sticky","sticky"];
			} else if (arg == GLOBAL.FLUID_TYPE_LEITHAN_MILK) {
				collection = ["thick","thick","thick","creamy","creamy"];
			} else if (arg == GLOBAL.FLUID_TYPE_NYREA_CUM) {
				collection = ["thick","thick","thick","slick","creamy"];
				if(statusEffectv1("Nyrea Eggs") > 0) collection.push("egg-filled","eggy","bubbly","pulpy");
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_GABILANI_CUM, GLOBAL.FLUID_TYPE_GABILANI_GIRLCUM)) {
				collection = ["oily","coating"];
			} else if (arg == GLOBAL.FLUID_TYPE_SPECIAL_GOO) {
				collection = ["slick","viscous","slippery"]; /* "slimy", */
			} else if (arg == GLOBAL.FLUID_TYPE_CHOCOLATE_CUM) {
				collection = ["thick","sticky"];
			} else if (arg == GLOBAL.FLUID_TYPE_NYREA_GIRLCUM) {
				collection = ["thick","sticky"];
			}
			
			else collection = ["fluid"];
			
			return RandomInCollection(collection);
		}
		public function fluidColor(arg: int): String {
			var collection:Array = new Array();
			trace("BOOP DA SNOOT");
			//CUM & MILK TYPES
			if (InCollection(arg, GLOBAL.FLUID_TYPE_MILK, GLOBAL.FLUID_TYPE_CUM, GLOBAL.FLUID_TYPE_VANILLA)) {
				collection = ["white","white","white","white","white","alabaster","alabaster","alabaster","ivory","ivory"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_HONEY, GLOBAL.FLUID_TYPE_NECTAR)) {
				collection = ["amber","amber","amber","amber","amber","yellow","yellow","yellow","gold","tawny"];
			} else if (arg == GLOBAL.FLUID_TYPE_OIL) {
				collection = ["semi-transparent","semi-transparent","semi-transparent","semi-transparent","semi-transparent","transluscent brown","transluscent brown","transluscent brown","lucent","lucent"];
			} else if (arg == GLOBAL.FLUID_TYPE_MILKSAP) {
				collection = ["whitish-yellow","whitish-yellow","whitish-yellow","whitish-yellow","whitish-yellow","ivory gold","ivory gold","ivory gold","off-white","off-white"];
			} else if (arg == GLOBAL.FLUID_TYPE_GIRLCUM) {
				collection = ["transluscent","transluscent","transluscent","transluscent","transluscent","clear","clear","clear","semi-transparent","semi-transparent"];
			} else if (arg == GLOBAL.FLUID_TYPE_CUMSAP) {
				collection = ["off-white","off-white","off-white","off-white","off-white","pearl-marbled amber","pearl-marbled amber","pearl-marbled amber","ivory-amber","ivory-amber"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_CHOCOLATE_MILK, GLOBAL.FLUID_TYPE_CHOCOLATE_CUM)) {
				collection = ["chocolate","chocolate","chocolate","chocolate","chocolate","creamy brown, chocolate","creamy brown, chocolate","creamy brown, chocolate","dark, chocolate","dark, chocolate"];
			} else if (arg == GLOBAL.FLUID_TYPE_STRAWBERRY_MILK) {
				collection = ["pink","pink","pink","pink","pink","creamy pink","creamy pink","creamy pink","light, pink","light, pink"];
			} else if (arg == GLOBAL.FLUID_TYPE_SYDIAN_CUM) {
				collection = ["silvery","silvery","silvery","silvery","silvery","metallic silver","metallic silver","metallic silver","silver","silver"];
			} else if (arg == GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK) {
				collection = ["pink","pink","pink","pink","pink","milky-pink","milky-pink","milky-pink","pink-marbled cream","pink-marbled cream"];
			} else if (arg == GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK) {
				collection = ["violet","violet","violet","violet","violet","milky-violet","milky-violet","milky-violet","violet-marbled cream","violet-marbled cream"];
			} else if (arg == GLOBAL.FLUID_TYPE_VANAE_CUM) {
				collection = ["blue","blue","glowing blue","glowing blue","glow-in-the-dark"];
			} else if (arg == GLOBAL.FLUID_TYPE_LEITHAN_MILK) {
				collection = ["alabaster","alabaster","alabaster","alabaster","alabaster","semi-transparent","semi-transparent","semi-transparent","off-white","off-white"];
			} else if (arg == GLOBAL.FLUID_TYPE_NYREA_CUM) {
				collection = ["purple","purple"];
			} else if (arg == GLOBAL.FLUID_TYPE_NYREA_GIRLCUM) {
				collection = ["off-white","semi-transparent"];
			} else if (arg == GLOBAL.FLUID_TYPE_GABILANI_CUM) {
				collection = ["off-white", "semi-clear", "semi-transparent"];
			} else if (arg == GLOBAL.FLUID_TYPE_GABILANI_GIRLCUM) {
				collection = ["gray", "semi-clear", "semi-transparent"];
			} else if (arg == GLOBAL.FLUID_TYPE_SPECIAL_GOO) {
				if(skinType == GLOBAL.SKIN_TYPE_GOO) collection = [String(skinTone)];
				else if(hairType == GLOBAL.HAIR_TYPE_GOO) collection = [String(hairColor)];
				else collection = ["green","emerald"];
			}
			
			else collection = ["ERROR, INVALID FLUID TYPE."];
			
			return RandomInCollection(collection);
		}
		public function cumGem():String
		{
			return fluidGem(cumType);
		}
		public function milkGem():String
		{
			return fluidGem(milkType);
		}
		public function girlCumGem():String
		{
			return fluidGem(girlCumType);
		}

		public function fluidGem(arg:int):String
		{
			var fColor:String = fluidColorSimple(arg);
			switch(fColor)
			{
				case "white":
					return RandomInCollection("pearl","opal");
				case "pink":
					return "rose quartz";
				case "red":
					return RandomInCollection("Ruby","garnet");
				case "orange":
				case "yellow":
					return RandomInCollection("amber","citrine","topaz");
				case "green":
					return RandomInCollection("emerald","jade");
				case "blue":
					return RandomInCollection("aquamarine","sapphire");
				case "purple":
					return RandomInCollection("amethyst");
				case "transparent":
					return RandomInCollection("crystal","diamond");
				case "brown":
					return RandomInCollection("citrine");
				case "silver":
				case "gray":
					return RandomInCollection("silver");
				default:
					return RandomInCollection("pearl");		
			}
		}
		public function fluidColorSimple(arg: int):String
		{
			if (InCollection(arg, GLOBAL.FLUID_TYPE_LEITHAN_MILK, GLOBAL.FLUID_TYPE_CUMSAP, GLOBAL.FLUID_TYPE_MILK, GLOBAL.FLUID_TYPE_CUM, GLOBAL.FLUID_TYPE_VANILLA, GLOBAL.FLUID_TYPE_MILKSAP)) return "white";
			else if (InCollection(arg, GLOBAL.FLUID_TYPE_HONEY, GLOBAL.FLUID_TYPE_NECTAR)) return "yellow";
			else if (InCollection(arg, GLOBAL.FLUID_TYPE_OIL, GLOBAL.FLUID_TYPE_GIRLCUM)) return "transparent";
			else if (InCollection(arg, GLOBAL.FLUID_TYPE_CHOCOLATE_MILK, GLOBAL.FLUID_TYPE_CHOCOLATE_CUM)) return "brown";
			else if (InCollection(arg, GLOBAL.FLUID_TYPE_STRAWBERRY_MILK, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK)) return "pink";
			else if (arg == GLOBAL.FLUID_TYPE_SYDIAN_CUM) return "silver";
			else if (arg == GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK) return "purple";
			else if (arg == GLOBAL.FLUID_TYPE_VANAE_CUM) return "blue";
			else if (arg == GLOBAL.FLUID_TYPE_NYREA_CUM) return "purple";
			else if (arg == GLOBAL.FLUID_TYPE_NYREA_GIRLCUM) return "white";
			else if (arg == GLOBAL.FLUID_TYPE_GABILANI_CUM) return "white";
			else if (arg == GLOBAL.FLUID_TYPE_GABILANI_GIRLCUM) return "gray";
			else if (arg == GLOBAL.FLUID_TYPE_SPECIAL_GOO)
			{
				if(skinType == GLOBAL.SKIN_TYPE_GOO) return skinTone;
				else if(hairType == GLOBAL.HAIR_TYPE_GOO) return hairColor;
				else return "green";
			}
			return "white";
		}
		public function fluidNoun(arg: int): String {
			var collection:Array = [];
			
			//CUM & MILK TYPES
			if (arg == GLOBAL.FLUID_TYPE_MILK) {
				collection = ["milk","cream"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_CUM, GLOBAL.FLUID_TYPE_SYDIAN_CUM, GLOBAL.FLUID_TYPE_GABILANI_CUM, GLOBAL.FLUID_TYPE_CHOCOLATE_CUM, GLOBAL.FLUID_TYPE_VANAE_CUM)) {
				collection = ["cum"];
				if(isBimbo() || isBro()) collection.push("cum","spunk","spunk","jism","jizz");
			} else if (arg == GLOBAL.FLUID_TYPE_HONEY) {
				collection = ["honey"];
			} else if (arg == GLOBAL.FLUID_TYPE_OIL) {
				collection = ["oil"];
			} else if (arg == GLOBAL.FLUID_TYPE_MILKSAP) {
				collection = ["milk-sap"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_GIRLCUM, GLOBAL.FLUID_TYPE_GABILANI_GIRLCUM)) {
				collection = ["girl-cum"];
				if(isBimbo() || isBro()) collection.push("girl-cum","girl-lube","girl-lube","girl-juice","cunny-honey");
			} else if (arg == GLOBAL.FLUID_TYPE_CUMSAP) {
				collection = ["cum-sap","cum-sap","botanical spunk","floral jism"];
			} else if(InCollection(arg, GLOBAL.FLUID_TYPE_CHOCOLATE_MILK, GLOBAL.FLUID_TYPE_STRAWBERRY_MILK, GLOBAL.FLUID_TYPE_VANILLA)) {
				collection = ["milk"];
			} else if (InCollection(arg, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK)) {
				collection = ["milk"];
			} else if (arg == GLOBAL.FLUID_TYPE_NECTAR) {
				collection = ["nectar"];
			} else if (arg == GLOBAL.FLUID_TYPE_LEITHAN_MILK) {
				collection = ["milk"];
			} else if (arg == GLOBAL.FLUID_TYPE_NYREA_CUM) {
				collection = ["girl-cum"];
			} else if (arg == GLOBAL.FLUID_TYPE_NYREA_GIRLCUM) {
				collection = ["cum"];
			} else if (arg == GLOBAL.FLUID_TYPE_SPECIAL_GOO) {
				collection = ["slime","goo"];
			}
			
			else collection = ["ERROR: NONVALID FLUID TYPE PASSED TO fluidNoun."];
			
			return RandomInCollection(collection);
		}
		public function milkDescript(): String {
			var temp: int = rand(10);
			var desc: String = "";
			var described: Boolean = false;
			if (rand(3) == 0) {
				desc += fluidColor(milkType);
				described = true;
			}
			if (described) desc += " ";
			desc += fluidNoun(milkType);
			return desc;
		}
		public function cumDescript(): String {
			var temp: int = rand(10);
			var desc: String = "";
			var described: Boolean = false;
			if (rand(3) == 0) {
				desc += fluidColor(cumType);
				described = true;
			}
			if (described) desc += " ";
			desc += fluidNoun(cumType);
			return desc;
		}
		public function girlCumDescript(): String {
			var temp: int = rand(10);
			var desc: String = "";
			var described: Boolean = false;
			if (rand(3) == 0) {
				desc += fluidColor(girlCumType);
				described = true;
			}
			if (described) desc += " ";
			desc += fluidNoun(girlCumType);
			return desc;
		}
		public function nippleCockDescript(appearance: Boolean = false): String {
			var descript: String = "";
			//Set up a placeholder cock to pass for descripts
			var cock:CockClass = new CockClass();
			cock.cType = dickNippleType;
			//Non boring descriptions!
			//70% of the time add a descriptor
			if (rand(10) <= 6 && !appearance) {
				descript += nippleCockAdjective();
				//50% of the time add supplimental cock adjective with the noun.
				if(rand(2) == 0) descript += ", " + cockNoun2(cock, false, "nipple");
				//Otherwise normal
				else descript += " " + cockNoun2(cock, true, "nipple");
			}
			//These guys get a bonus adjective 70% of the time.
			else {
				if (rand(10) <= 6 && !appearance) descript += cockNoun2(cock, false, "nipple");
				else descript += cockNoun2(cock, true, "nipple");
			}
			return descript;
		}
		public function nippleCocksDescript(appearance: Boolean = false): String {
			return plural(nippleCockDescript(appearance));
		}
		public function cockColor(arg2:int = 0):String
		{
			if(!hasCock() || arg2 < 0 || arg2 >= cockTotal()) return "ERROR";
			else return cocks[arg2].cockColor;
		}
		public function vaginaColor(arg2:int = 0):String
		{
			if(!hasVagina() || arg2 < 0 || arg2 >= vaginaTotal()) return "ERROR";
			else return vaginas[arg2].vaginaColor;	
		}
		public function tailGenitalColorDesc(arg:int = 0):String
		{
			return tailGenitalColor;
		}
		public function hasHardLightEquipped():Boolean
		{
			return (lowerUndergarment.hardLightEquipped);
		}
		// Always picks the main anatomy--no need to complicate it!
		public function cockOrStrapon(forceAdjective: int = 0): String {
			var descript: String = "";
			var sAdjective:Array = [];
			var sNoun:Array = [];
			
			// Strapons! Always takes precedence, I guess!
			if(lowerUndergarment.hardLightEquipped)
			{
				sAdjective = ["hardlight", "hardlight", "hardlight", "hardlight", "holo-", "holo-", "holo-", "projected", "projected", "holographic"];
				sNoun = ["strapon", "strapon", "strapon", "dildo", "dildo"];
				if(kGAMECLASS.silly)
				{
					sAdjective.push("lite-brite");
					sAdjective.push("glow-in-the-dark");
					sNoun.push("beam saber");
					sNoun.push("lazer beam");
					sNoun.push("funstick");
					sNoun.push("disco stick");
					sNoun.push("pillar of ecstasy");
				}
				//Force an adjective
				if(forceAdjective == 1)
				{
					descript += RandomInCollection(sAdjective);
					if(descript != "holo-") descript += " ";
				}
				//Chance of adjective!
				else if(forceAdjective == 0 && rand(2) == 0)
				{
					descript += RandomInCollection(sAdjective);
					if(descript != "holo-") descript += " ";
				}
				descript += RandomInCollection(sNoun);
				return descript;
			}
			// Penis?
			else if(hasCock())
			{
				if(forceAdjective == 1 || (forceAdjective == 0 && rand(2) == 0)) descript += cockAdjective(0) + " ";
				descript += cockNoun2(cocks[0]);
				return descript;
			}
			// Giant Clits?
			else if(hasVagina() && vaginas[0].clits >= 1 && clitLength >= 4)
			{
				if(kGAMECLASS.silly && clitLength >= 12 && rand(2) == 0)
				{
					if(forceAdjective == 1 || (forceAdjective == 0 && rand(2) == 0)) descript += "mighty ";
					descript += "clitosaurus";
					return descript;
				}
				else
				{
					return clitDescript(0);
				}
			}
			// Error, return something though!
			else return "strapon";
		}
		public function cockDescript(cockNum: Number = 0, dynamicLength:Boolean = false): String {
			if (totalCocks() == 0) return "<b>ERROR: CockDescript Called But No Cock Present</b>";
			if (cockTotal() <= cockNum && cockNum != 99) return "<b>ERROR: CockDescript called with index of " + cockNum + " - out of BOUNDS</b>";

			var descript: String = "";
			//Non boring descriptions!
			if (cockNum != 99) {
				//70% of the time add a descriptor
				if (rand(10) <= 6) {
					descript += cockAdjective(cockNum, dynamicLength);
					//50% of the time add supplimental cock adjective with the noun.
					if (rand(2) == 0) {
						descript += ", " + cockNoun2(cocks[cockNum], false);
					}
					//Otherwise normal
					else descript += " " + cockNoun2(cocks[cockNum], true);
				}
				//These guys get a bonus adjective 70% of the time.
				else {
					if (rand(10) <= 6) descript += cockNoun2(cocks[cockNum], false);
					else descript += cockNoun2(cocks[cockNum]);
				}
			}
			//Boring descriptions. Mostly the same but kinda lame, actually.
			else {
				//70% of the time add a descriptor
				if (rand(10) <= 6) descript += cockAdjective(-1, dynamicLength) + " " + randomSimpleCockNoun();
				else descript += randomSimpleCockNoun();
			}
			return descript;
		}
		public function randomSimpleCockNoun():String
		{
			return RandomInCollection("cock","cock","cock","cock","dick","dick","phallus","phallus","prick","tool","member","shaft","dong");
		}
		public function tailCocksDescript(): String {
			if (tailCount > 1) return plural(tailCockDescript());
			else if (tailCount == 1) return tailCockDescript();
			return "ERROR: TAIL DESCRIPT CALLED WITH NO TAILS PRESENT.";
		}
		public function tailCockDescript(): String {
			var descript: String = "";
			//Placeholder for new cock stuff
			var cock:CockClass = new CockClass();
			cock.cType = tailGenitalArg;
			//Non boring descriptions!
			//70% of the time add a descriptor
			if (rand(10) <= 6) {
				descript += statCockAdjective(8, 2);
				//50% of the time add supplimental cock adjective with the noun.
				if (rand(2) == 0) descript += ", " + cockNoun2(cock, false, "tail");
				//or 10% of that time, mention color.
				else if (rand(10) == 0 && tailGenitalColor != "") descript += ", " + tailGenitalColor + " " + cockNoun2(cock, false, "tail");
				//Otherwise normal
				else descript += " " + cockNoun2(cock, false, "tail");
			}
			//These guys get a bonus adjective 70% of the time.
			else {
				if (rand(10) <= 6) descript += cockNoun2(cock, false, "tail");
				else descript += cockNoun2(cock, true, "tail");
			}
			return descript;
		}
		public function allBreastsDescript(): String {
			var storage: String = "";
			var temp: int;
			if (breastRows.length == 0) {
				temp = rand(5);
				if (temp == 0 && tone < 30) return "unremarkable chest muscles";
				else if (temp == 1) return "chest";
				else if (temp == 2) return "pectorals";
				else if (temp == 3 && tone < 30 && thickness < 30) return "flat chest";
				else return mf("manly", "boyish") + " chest";
			}
			if (breastRows.length == 2) {
				temp = rand(2);
				if (totalBreasts() == 4 && temp == 0) storage += "quad ";
				else if (totalBreasts() == 4) storage += "four ";
				else storage += "two rows of ";
			}
			if (breastRows.length == 3) {
				if (rand(2) == 0) storage += "three rows of ";
				else storage += "multi-layered ";
			}
			if (breastRows.length == 4) {
				if (rand(2) == 0) storage += "four rows of ";
				else storage += "four-tiered ";
			}
			if (breastRows.length == 5) {
				if (rand(2) == 0) storage += "five rows of ";
				else storage += "five-tiered ";
			}
			storage += biggestBreastDescript();
			return storage;
		}
		public function breastSize(val: Number): String {
			var descript: String = "";
			var choice: Number = 0;
			//Catch all for dudes.
			if (val < 1) {
				choice = rand(4);
				if (choice == 0) descript += "tight";
				else if (choice == 1) descript += "hard";
				else if (choice == 2) descript += "fine";
				else return "manly";
			}
			//A-cup
			else if (val == 1) {
				choice = rand(3);
				if (choice == 0) descript += "cute";
				else if (choice == 1) descript += "soft";
				else descript += "small";
			}
			//Small - A->B
			else if (val <= 2) {
				choice = rand(4);
				if (choice == 0) descript += "palmable";
				else if (choice == 1) descript += "tight";
				else if (choice == 2) descript += "perky";
				else if (choice == 3) descript += "baseball-sized";
			}
			//C-D
			else if (val <= 4) {
				choice = rand(4);
				if (choice == 0) descript += "nice";
				else if (choice <= 1) descript += "hand-filling";
				else if (choice <= 2) descript += "well-rounded";
				else descript += "supple";
				//else if(choice == 4) descript += "softball-sized";
			}
			//DD->big EE
			else if (val < 11) {
				choice = rand(5);
				if (choice == 0) descript += "big";
				else if (choice == 1) descript += "large";
				else if (choice == 2) descript += "pillowy";
				else if (choice == 3) descript += "jiggly";
				else if (choice == 4) descript += "volleyball-sized";
			}
			//F->big FF
			else if (val < 15) {
				choice = rand(4);
				if (choice == 0) descript += "soccerball-sized";
				else if (choice == 1) descript += "hand-overflowing";
				else if (choice == 2) descript += "generous";
				else if (choice == 3) descript += "jiggling";
			}
			//G -> HHH
			else if (val < 24) {
				choice = rand(4);
				if (choice == 0) descript += "basketball-sized";
				else if (choice == 1) descript += "whorish";
				else if (choice == 2) descript += "cushiony";
				else if (choice == 3) descript += "wobbling";
			}
			//I -> KK
			else if (val < 35) {
				choice = rand(4);
				if (choice == 0) descript += "massive motherly";
				else if (choice == 1) descript += "luscious";
				else if (choice == 2) descript += "smothering";
				else descript += "prodigious";
			}
			//K- > MMM+
			else {
				choice = rand(5);
				if (choice == 0) descript += "mountainous";
				else if (choice == 1) descript += "monumental";
				else if (choice == 2) descript += "back-breaking";
				else if (choice == 3) descript += "exercise-ball-sized";
				else descript += "immense";
			}
			return descript;
		}
		public function breastDescript(rowNum: Number): String {
			//ERROR PREVENTION
			if (breastRows.length - 1 < rowNum) return "<b>ERROR, breastDescript() working with invalid breastRow</b>";
			if (breastRows.length == 0) return "<b>ERROR, breastDescript() called when no breasts are present.</b>";

			var temp: int;
			var descript: String = "";
			var descripted: Boolean = false;
			if (breastRows[rowNum].breastRating() < 1) {
				temp = rand(10);
				if (temp <= 3)
				{
					if (tone < 30) return mf("pecs", "flat tits");
					return "pecs";
				}
				else if (temp <= 6) return "flat, almost non-existent breasts";
				else
				{
					if (tone < 30) return mf("pectoral muscles", "flat breasts");
					return "pectoral muscles";
				}
			}
			//50% of the time size-descript them
			if (rand(2) == 0) {
				descript += breastSize(breastRows[rowNum].breastRating());
				descripted = true;
			}
			if (isLactating()) {
				if (descripted) descript += ", ";
				if (InCollection(milkType, GLOBAL.FLUID_TYPE_MILK, GLOBAL.FLUID_TYPE_CHOCOLATE_MILK, GLOBAL.FLUID_TYPE_STRAWBERRY_MILK, GLOBAL.FLUID_TYPE_VANAE_MAIDEN_MILK, GLOBAL.FLUID_TYPE_VANAE_HUNTRESS_MILK, GLOBAL.FLUID_TYPE_LEITHAN_MILK)) {
					temp = rand(4);
					if (temp == 0) descript += "lactating";
					else if (temp == 1) descript += "milky";
					else if (temp == 2) descript += "milk-filled";
					else descript += "fluid-filled";
				} else if (milkType == GLOBAL.FLUID_TYPE_HONEY) {
					temp = rand(4);
					if (temp == 0) descript += "honey-filled";
					else if (temp == 1) descript += "honey-stuffed";
					else if (temp == 2) descript += "sweet";
					else descript += "fluid-filled";
				}
				//Generic catch all
				else {
					temp = rand(2);
					if (temp == 0) descript += "lactating";
					else descript += "fluid-filled";
				}
				descripted = true;
			}
			// A-cups
			if(breastRows[rowNum].breastRating() == 1) {
				if(descripted) descript += ", ";
				temp = rand(3);
				if (temp == 0) descript += "tiny ";
				else if (temp == 1) descript += "girly ";
				else descript += "waifish ";
				descript += RandomInCollection("breasts", "mammaries", "boobs", "tits");
			}
			else {
				if(descripted) descript += " ";
				descript += chestNoun(rowNum);
			}
			return descript;
		}
		public function breastNoun(rowNum:int = 99):String
		{	
			var noun:String = "";
			if(rowNum == 99) rowNum = 0;
			//Nouns!
			var temp:int = rand(14);
			if (temp == 0) noun += "breast";
			else if (temp <= 1) {
				if (isLactating()) noun += "udder";
				else noun += "breast";
			} else if (temp <= 3) {
				if (breastRows[rowNum].breastRating() > 4 && rand(2) == 0) noun += "tit";
				else noun += "breast";
			} else if (temp <= 6) noun += "tit";
			else if (temp <= 7) {
				if (!isLactating()) noun += "jug";
				else noun += "udder";
			} else if (temp <= 8) {
				if (breastRows[rowNum].breastRating() > 6) noun += "love-pillow";
				else noun += "boob";
			} else if (temp <= 9) {
				if (breastRows[rowNum].breastRating() > 6) noun += "tit";
				else noun += "breast";
			} else if (temp <= 11) noun += "mammary";
			else if (temp <= 12) noun += "melon";
			else noun += "mound";
			return noun;
		}
		public function chestNoun(rowNum:int = 99):String
		{
			var noun:String = "";
			if (rowNum == 99) rowNum = 0;
			//Nouns!
			var temp:int = rand(14);
			if (breastRows[rowNum].breastRating() <= 0) noun += "chest";
			else if (temp == 0) noun += "breasts";
			else if (temp <= 1) {
				if (isLactating()) noun += "udders";
				else noun += "breasts";
			} else if (temp <= 3) {
				if (breastRows[rowNum].breastRating() > 4 && rand(2) == 0) noun += "tits";
				else noun += "breasts";
			} else if (temp <= 6) noun += "tits";
			else if (temp <= 7) {
				if (!isLactating()) noun += "jugs";
				else noun += "udders";
			} else if (temp <= 8) {
				if (breastRows[rowNum].breastRating() > 6) noun += "love-pillows";
				else noun += "boobs";
			} else if (temp <= 9) {
				if (breastRows[rowNum].breastRating() > 6) noun += "tits";
				else noun += "breasts";
			} else if (temp <= 11) noun += "mammaries";
			else if (temp <= 12) noun += "melons";
			else noun += "mounds";
			return noun;
		}
		public function biggestBreastDescript(): String {
			return (breastDescript(biggestTitRow()));
		}
		public function eachCockHead(): String {
			if (cockTotal() == 1) return "your " + cockHead(-1);
			else return "each of your " + plural(cockHead(-1));
		}
		public function oneCockHead(): String {
			if (cockTotal() == 1) return "your " + cockHead(-1);
			else return "one of your " + plural(cockHead(-1));
		}
		public function cockHead(cockNum: Number = 0): String {
			var temp: int;
			var type: int;
			if (cocks.length == 0)
				return "ERROR. CockHead lookup with no cocks!";
			if (cockNum < 0) type = GLOBAL.TYPE_HUMAN;
			else type = cocks[cockNum].cType;
			if (cockNum > cocks.length - 1) return "ERROR";

			return cockHeadGetName(type);
		}
		public function cockHeads(cockNum:Number = 0):String {
			if(cockTotal() == 1) return cockHead(cockNum);
			else return plural(cockHead(cockNum));
		}
		public function tailCockHead(): String {
			if (!hasTailCock()) return "|||<b>ERROR:</b> No tail cock to describe |||";
			return cockHeadGetName(tailGenitalArg);
		}
		public function cockHeadGetName(type: int = 0): String {
			var temp: int;
			var type: int;
			
			if (type == GLOBAL.TYPE_EQUINE) {
				temp = rand(5);
				if (temp == 0) return "flare";
				else if (temp <= 1) return "blunt head";
				else if (temp <= 2) return "equine glans";
				else if (temp <= 3) return "flat tip";
				else return "cock-head";
			} else if (type == GLOBAL.TYPE_CANINE || type == GLOBAL.TYPE_VULPINE) {
				temp = rand(5);
				if (temp == 0) return "canine crown";
				else if (temp <= 1) return "pointed cock-head";
				else if (temp <= 2) return "narrow glans";
				else if (temp <= 3) return "tip";
				else return "cock-head";
			} else if (type == GLOBAL.TYPE_DEMONIC) {
				temp = rand(5);
				if (temp == 0) return "tainted crown";
				else if (temp <= 1) return "nubby head";
				else if (temp <= 2) return "demonic glans";
				else if (temp <= 3) return "nub-ringed tip";
				else return "cock-head";
			} else if (type == GLOBAL.TYPE_TENTACLE) {
				temp = rand(6);
				if (temp == 0) return "crown";
				else if (temp <= 1) return "tentacle-head";
				else if (temp <= 2) return "floral glans";
				else if (temp <= 3) return "tip";
				else if (temp <= 4) return "mushroom-like tip";
				else return "wide, plant-like crown";
			} else if (type == GLOBAL.TYPE_NAGA || type == GLOBAL.TYPE_LIZAN || type == GLOBAL.TYPE_SNAKE) {
				temp = rand(6);
				if (temp == 0) return "point";
				else if (temp <= 1) return "narrow tip";
				//else if (temp <= 2) return "purple, pointed glans";
				else if (temp <= 2) return "pointed glans";
				else if (temp <= 3) return "tip";
				//else if (temp <= 4) return "violet tip";
				else if (temp <= 4) return "pointed tip";
				else return "reptilian crown";
			} else if (type == GLOBAL.TYPE_ANEMONE || type == GLOBAL.TYPE_SIREN) {
				temp = rand(6);
				//if (temp == 0) return "blue tip";
				if (temp == 0) return "eye-catching tip";
				else if (temp == 1) return "tentacle-ringed glans";
				else if (temp == 2) return "exotic cock-head";
				else if (temp == 3) return "aphrodisiac-laced head";
				else return "wiggling crown";
			} else if (type == GLOBAL.TYPE_SAURIAN) {
				temp = rand(5);
				if (temp == 0) return "nubbed crown";
				else if (temp <= 1) return "nubby head";
				else if (temp <= 2) return "monstrous glans";
				else if (temp <= 3) return "nub-ringed tip";
				else return "cock-head";
			} else if (type == GLOBAL.TYPE_NYREA) {
				temp = rand(5);
				if (temp == 0) return "x-shaped crown";
				else if (temp <= 1) return "alien head";
				else if (temp <= 2) return "flared glans";
				else if (temp <= 3) return "exotic tip";
				else return "cock-head";
			} else if (type == GLOBAL.TYPE_GABILANI) {
				temp = rand(5);
				if (temp == 0) return "coupled crown";
				else if (temp <= 1) return "paired head";
				else if (temp <= 2) return "doubled glans";
				else if (temp <= 3) return "twinned tip";
				else return "doubled cock-head";
			} else if (type == GLOBAL.TYPE_VANAE) {
				temp = rand(5);
				if (temp == 0) return "suckler crown";
				else if (temp <= 1) return "suckered head";
				else if (temp <= 2) return "bowl-like glans";
				else if (temp <= 3) return "sucker tip";
				else return "suckered cock-head";
			}
			/*else if (type == 9999) {
				temp = rand(5);
				if (temp == 0) return "star tip";
				else if (temp == 1) return "blooming cock-head";
				else if (temp == 2) return "open crown";
				else if (temp == 3) return "alien tip";
				else return "bizarre head";
			}*/
			else {
				temp = rand(5);
				if (temp == 0) return "crown";
				else if (temp <= 1) return "head";
				else if (temp <= 2) return "glans";
				else if (temp <= 3) return "tip";
				else return "cock-head";
			}
		}

		/**
		 * Effectively an interface to define the default sexual preferences for a given creature.
		 * Ensure that the function is overridden before calling this (or the error can be replaced with a "default" set
		 * of possible sexprefs for ALL creatures.
		 */
		public function setDefaultSexualPreferences(): void
		{
			throw new Error("Sexual preferences must be configured on a per-creature basis before this function should be called! Override the function signature in the child creature class.");
		}
		
		/**
		 * These methods are stubs, intended to be overriden on a character-by-character basis.
		 * Check the PlayerCharacter class to see what I mean.
		 */
		
		public function loadInCunt(cumFrom:Creature = null, vagIndex:int = -1):Boolean
		{
			// Only run the knockup shit if the creature actually gets saved
			if (neverSerialize == false && cumFrom != null)
			{
				if(cumflationEnabled() && !isPregnant(vagIndex)) 
				{
					cumflationHappens(cumFrom,vagIndex);
					if(this is Emmy) 
					{
						if(hasStatusEffect("Drain Cooldown")) setStatusMinutes("Drain Cooldown",250);
						else createStatusEffect("Drain Cooldown",0,0,0,0,false,"PlaceholderIcon","Description",false,250);
					}
				}
				return tryKnockUp(cumFrom, vagIndex);
			}
			else
			{
				trace("WARNING: Attempting to call knockUp on a Creature class that isn't serialized to save data. Better check this shit yo.");
			}
			return false;
		}
		public function loadInAss(cumFrom:Creature = null):Boolean
		{
			if (neverSerialize == false && cumFrom != null)
			{
				if(cumflationEnabled()) cumflationHappens(cumFrom,3);
				return tryKnockUp(cumFrom, 3);
			}
			else
			{
				trace("WARNING: Attempting to call knockUp on a Creature class that isn't serialized to save data. Better check this shit yo.");
			}
			return false;
		}
		public function milkInMouth(cumFrom:Creature = null):Boolean
		{
			return false;
		}
		public function girlCumInMouth(cumFrom:Creature = null):Boolean
		{
			return false;
		}
		public function loadInMouth(cumFrom:Creature = null):Boolean
		{
			if(cumFrom != null && cumflationEnabled()) cumflationHappens(cumFrom,4);
			return false;
		}
		public function loadInNipples(cumFrom:Creature = null):Boolean
		{
			return false;
		}
		
		public function loadInCuntTail(cumFrom:Creature = null):Boolean
		{
			if (neverSerialize == false && cumFrom != null)
			{
				return tryKnockUp(cumFrom, 4);
			}
			else
			{
				trace("Warning: Attempting to call knockUp on a Creature class that isn't serialized to save data. Better check this shit yo.");
			}
			return false;
		}
		public function addBiomass(arg:Number):void
		{
			if(kGAMECLASS.flags["GOO_BIOMASS"] == undefined) kGAMECLASS.flags["GOO_BIOMASS"] = 0;
			kGAMECLASS.flags["GOO_BIOMASS"] += arg;
		}
		public function cumflationHappens(cumFrom:Creature, hole:Number):void
		{
			if(hole >= 0 && hole < 3)
			{
				if(!hasStatusEffect("Vaginally-Filled")) createStatusEffect("Vaginally-Filled",cumFrom.cumQ(),cumFrom.cumQ(),cumFrom.cumType,0,false,"Icon_Vagina","You've got some fluids inside you, leftovers from a recent lover.",false,0,0xB793C4);
				else
				{
					//Track the new type.
					setStatusValue("Vaginally-Filled",3,cumFrom.cumType);
					//Add the liquid volume.
					addStatusValue("Vaginally-Filled",1,cumFrom.cumQ());
					//If new high score, set it.
					if(statusEffectv1("Vaginally-Filled") > statusEffectv2("Vaginally-Filled")) setStatusValue("Vaginally-Filled",2,statusEffectv1("Vaginally-Filled"));
				}
			}
			else if(hole == 3)
			{
				if(!hasStatusEffect("Anally-Filled")) createStatusEffect("Anally-Filled",cumFrom.cumQ(),cumFrom.cumQ(),cumFrom.cumType,0,false,"Icon_Donut","You've got some fluids inside you, leftovers from a recent lover.",false,0,0xB793C4);
				else
				{
					//Track the hole it's in along with the new type.
					setStatusValue("Anally-Filled",3,cumFrom.cumType);
					//Add the liquid volume.
					addStatusValue("Anally-Filled",1,cumFrom.cumQ());
					//If new high score, set it.
					if(statusEffectv1("Anally-Filled") > statusEffectv2("Anally-Filled")) setStatusValue("Anally-Filled",2,statusEffectv1("Anally-Filled"));
				}
			}
			else
			{
				if(!hasStatusEffect("Orally-Filled")) createStatusEffect("Orally-Filled",cumFrom.cumQ(),cumFrom.cumQ(),cumFrom.cumType,0,false,"Icon_Lips_Glossed","You've got some fluids inside you, leftovers from a recent lover.",false,0,0xB793C4);
				else
				{
					//Track the hole it's in along with the new type.
					setStatusValue("Orally-Filled",3,cumFrom.cumType);
					//Add the liquid volume.
					addStatusValue("Orally-Filled",1,cumFrom.cumQ());
					//If new high score, set it.
					if(statusEffectv1("Orally-Filled") > statusEffectv2("Orally-Filled")) setStatusValue("Orally-Filled",2,statusEffectv1("Orally-Filled"));
				}
			}
		}
		
		/**
		 * Defined impregnation handler that this Creature will attempt to use.
		 */
		public var impregnationType:String = "";
		
		// Male-centric stuff (Father)
		public var cumQualityRaw:Number = 1;
		public var cumQualityMod:Number = 0;
		public function cumQuality():Number
		{
			var bonus:Number = 0;
			if (hasPerk("Magical Virility")) bonus += perkv2("Magical Virility");
			if (hasPerk("Virile")) bonus += perkv1("Virile");
			if (hasStatusEffect("Rut")) bonus += statusEffectv1("Rut") / 100;
			return (cumQualityRaw + cumQualityMod + bonus);
		}
		
		/**
		 * Virility should be the overall multiplier used to modify the basePregnancyChance of any given pregnancy.
		 * It should include all things that could possibly influence the raw "power" of virility.
		 * @return
		 */
		public function virility():Number
		{
			if (hasStatusEffect("Infertile") || hasPerk("Firing Blanks")) return 0;
			
			return cumQuality();
		}
		
		public var pregnancyIncubationBonusFatherRaw:Number = 1;
		public var pregnancyIncubationBonusFatherMod:Number = 0;
		public function pregnancyIncubationBonusFather():Number
		{
			return pregnancyIncubationBonusFatherRaw + pregnancyIncubationBonusFatherMod;
		}
		
		// Female-centric stuff (Mother)
		public var pregnancyMultiplierRaw:Number = 1;
		public var pregnancyMultiplierMod:Number = 0;
		public function pregnancyMultiplier():Number
		{
			var bonus:Number = 0;
			return (pregnancyMultiplierRaw + pregnancyMultiplierMod + bonus);
		}
		
		public var fertilityRaw:Number = 1;
		public var fertilityMod:Number = 0;
		public function fertility():Number
		{
			if (hasStatusEffect("Infertile") || hasPerk("Sterile")) return 0;
			
			var bonus:Number = 0;
			if (hasStatusEffect("Heat")) bonus += statusEffectv1("Heat") / 100;
			if (hasPerk("Magical Fertility")) bonus += perkv1("Magical Fertility");
			
			return fertilityRaw + fertilityMod + bonus;
		}
		
		public var pregnancyIncubationBonusMotherRaw:Number = 1;
		public var pregnancyIncubationBonusMotherMod:Number = 0;
		public function pregnancyIncubationBonusMother():Number
		{
			var bonus:Number = 0;
			if (hasPerk("Incubator")) bonus += perkv1("Incubator");
			if (hasPerk("Magical Fertility")) bonus += perkv2("Magical Fertility");
			if (hasPerk("Breed Hungry")) bonus += 1;
			return pregnancyIncubationBonusMotherRaw + pregnancyIncubationBonusMotherMod + bonus;
		}
		
		public var bellyRatingRaw:Number = 0;
		public var bellyRatingMod:Number = 0;
		public function bellyRating():Number
		{
			var bonus:Number = 0;
			var eggs:int = statusEffectv1("Nyrea Eggs");
			
			//if(hasPerk("Fecund Figure")) - don't need this. Should return 0 if the perk aint real.
			if(eggs > 50) bonus += (eggs - 50) * 0.01;
			bonus += perkv3("Fecund Figure");
			bonus += statusEffectv1("Anally-Filled")/1000;
			bonus += statusEffectv1("Vaginally-Filled")/1000;
			bonus += statusEffectv1("Orally-Filled")/1000;
			
			var currBellyRating:Number = bellyRatingRaw + bellyRatingMod + bonus;
			
			if (currBellyRating < 0)
			{
				return 0;
			}
			else
			{
				return currBellyRating;
			}
		}
		
		// Pregnancy Data Storage
		public var pregnancyData:/*PregnancyData*/Array = new Array();
		
		// Pregnancy Utility Methods
		
		/**
		 * Determine if a creature has a pregnancy. Optionally supply an index to check for a specific pregnancy slot.
		 * @param	slot	index to check, -1 for any
		 * @return			true/false
		 */
		public function isPregnant(slot:int = -1):Boolean
		{
			// Any pregnancy
			if (slot == -1)
			{
				for (var i:int = 0; i < pregnancyData.length; i++)
				{
					if ((pregnancyData[i] as PregnancyData).pregnancyType != "") return true;
				}
			}
			
			// Check the slot is in range
			if (slot < -1 || slot > 3)
			{
				throw new Error("isPregnant argument out of range. Expected -1 to 3, got " + slot);
			}
			
			// Find a pregnancy in a given slot
			if (slot >= 0 && slot <= 3)
			{
				if (!hasVagina(slot) && slot != 3)
				{
					return false;
				}
				
				if ((pregnancyData[slot] as PregnancyData).pregnancyType != "") return true;
			}
			
			return false;
		}
		public function hasPregnancy():Boolean { return isPregnant(); }
		
		//Argument is the same string as defined in the handler.
		//Example: VenusPitcherSeedCarrier
		public function hasPregnancyOfType(type:String):Boolean
		{
			for (var i:int = 0; i < pregnancyData.length; i++)
			{
				if ((pregnancyData[i] as PregnancyData).pregnancyType == type) return true;
			}
			return false;
		}
		
		public function getPregnancyOfType(type:String):PregnancyData
		{
			for (var i:int = 0; i < pregnancyData.length; i++)
			{
				if ((pregnancyData[i] as PregnancyData).pregnancyType == type) return pregnancyData[i];
			}
			return null;
		}
		
		public function findPregnancyOfType(type:String):int
		{
			for (var i:int = 0; i < pregnancyData.length; i++)
			{
				if ((pregnancyData[i] as PregnancyData).pregnancyType == type) return i;
			}
			return -1;
		}
		
		public function hasPregnancyOfChildType(type:uint):Boolean
		{
			return PregnancyManager.hasPregnancyOfChildType(this, type);
		}
		
		/**
		 * Find the total number of pregnancies for a given creature.
		 * @return			total pregnancies
		 */
		public function totalPregnancies():int
		{
			var count:int = 0;
			for (var i:int = 0; i < pregnancyData.length; i++)
			{
				if ((pregnancyData[i] as PregnancyData).pregnancyType != "") count++;
			}
			return count;
		}
		public function totalBabiesOfType(type:String):int
		{
			var count:int = 0;
			for (var i:int = 0; i < pregnancyData.length; i++)
			{
				if ((pregnancyData[i] as PregnancyData).pregnancyType == type) count += (pregnancyData[i] as PregnancyData).pregnancyQuantity;
			}
			return count;
		}
		
		/**
		 * Find the index of the first empty pregnancy slot
		 * @return			index of the first empty pregnancy slot, -1 if none available.
		 */
		public static const PREGSLOT_ANY:uint = 0;
		public static const PREGSLOT_VAG:uint = 1;
		public static const PREGSLOT_ASS:uint = 2;
		public function findEmptyPregnancySlot(type:uint):int
		{
			if (type == PREGSLOT_ANY || type == PREGSLOT_VAG)
			{
				for (var i:int = 0; i < vaginas.length; i++)
				{
					if ((pregnancyData[i] as PregnancyData).pregnancyType == "") return i;
				}
			}
			
			if (type == PREGSLOT_ANY || type == PREGSLOT_ASS)
			{
				if ((pregnancyData[3] as PregnancyData).pregnancyType == "") return 3;
			}
			
			return -1;
		}
		
		//Used for ovipositors
		public var eggs: int = 0;
		public var fertilizedEggs: int = 0;

		public function canOvipositSpider(): Boolean 
		{
			if (eggs >= 10 && hasTailFlag(GLOBAL.FLAG_OVIPOSITOR) && isDrider()) return true;
			return false;
		}
		
		public function canOvipositBee(): Boolean 
		{
			if (eggs >= 10 && hasTailFlag(GLOBAL.FLAG_OVIPOSITOR) && tailType == GLOBAL.TYPE_BEE) return true;
			return false;
		}
		
		public function canOviposit(): Boolean 
		{
			if (canOvipositSpider() || canOvipositBee()) return true;
			return false;
		}
		
		public function isCockOvipositor(slot:int = -1): Boolean 
		{
			if (slot >= 0 && cocks.length > 0 && cocks[slot].hasFlag(GLOBAL.FLAG_OVIPOSITOR)) return true;
			return false;
		}
		public function isVaginaOvipositor(slot:int = -1): Boolean 
		{
			if (slot >= 0 && vaginas.length > 0 && vaginas[slot].hasFlag(GLOBAL.FLAG_OVIPOSITOR)) return true;
			return false;
		}
		public function totalOvipositors(): int 
		{
			var x:int = 0;
			var count:int = 0;
			
			if (cocks.length > 0)
			{
				for(x = 0; x < cocks.length; x++)
				{
					if(isCockOvipositor(x)) count++;
				}
			}
			if (vaginas.length > 0)
			{
				for(x = 0; x < vaginas.length; x++)
				{
					if(isVaginaOvipositor(x)) count++;
				}
			}
			
			return count;
		}
		public function hasOvipositor(): Boolean 
		{
			if (totalOvipositors() > 0) return true;
			return false;
		}
		
		public function addEggs(arg: int = 0): int 
		{
			if (!canOviposit()) return -1;
			else {
				eggs += arg;
				if (eggs > 50) eggs = 50;
			}
			return eggs;
		}
		
		public function dumpEggs(): void 
		{
			if (!canOviposit()) return;
			eggs = 0;
			fertilizedEggs = 0;
		}
		
		public function setEggs(arg: int = 0): int 
		{
			if (!canOviposit()) return -1;
			else {
				eggs = arg;
				if (eggs > 50) eggs = 50;
				return eggs;
			}
		}
		
		public function fertilizeEggs(percent: Number = 50): int 
		{
			if (!canOviposit()) return -1;
			fertilizedEggs += eggs * percent / 100;
			if (fertilizedEggs > eggs) fertilizedEggs = eggs;
			return fertilizedEggs;
		}
		
		// Preg slot is the incubation slot we're gonna occupy, following the same rules as the array
		// 0 is butt, 1-3 are vagina(s)
		// This isn't perfect, but it's a start.
		/**
		 * Try to impregnate this creature.
		 * @param	cumFrom
		 * @param	pregSlot
		 * @return	success/failure
		 */
		public function tryKnockUp(cumFrom:Creature, pregSlot:int = -1):Boolean
		{
			// Vagina/butt slot checking
			if (pregSlot < -2 || (pregSlot >= 0 && pregSlot <= 2 && !hasVagina(pregSlot)) || pregSlot > 4)
			{
				throw new Error("Unexpected pregnancy slot used to call tryKnockUp.");
				return false;
			}
			
			// The array storing chars will just throw out a null if a key doesn't exist - catch that and shit out an obvious error.
			if (cumFrom == null)
			{
				throw new Error("Null creature used to call tryKnockUp. Does this creature actually have a defined statblock?");
				return false;
			}
			
			return PregnancyManager.tryKnockUp(cumFrom, this, pregSlot);
		}
		
		// Find the handler(s) dealing with the creatures current pregnancy(ies) and query them for descriptive output 
		public function pregBellyFragment():String
		{
			if (!isPregnant()) return "ERROR: No current pregnancies";
			
			var tarSlot:int = -1;
			
			for (var i:int = 0; i < 4; i++)
			{
				if (isPregnant(i))
				{
					if (tarSlot == -1) tarSlot = i;
					else if (pregnancyData[i].pregnancyBellyRatingContribution > pregnancyData[tarSlot].pregnancyBellyRatingContribution) tarSlot = i;
				}
			}
			
			if (tarSlot != -1)
			{
				return PregnancyManager.getPregBellyFragment(this, tarSlot);
			}
			
			return "ERROR: Couldn't find a valid pregnancy slot but the creature is defined as being pregnant. SHITS FUCKED YO.";
		}
		
		public function addPregnancyBellyMod(pregSlot:int, value:Number, perOffspring:Boolean = true):void
		{
			var pData:PregnancyData = pregnancyData[pregSlot];
			var addValue:Number = value;
			
			if (perOffspring) addValue *= pData.pregnancyQuantity;
			
			if (pData.pregnancyType != "")
			{
				pData.pregnancyBellyRatingContribution += addValue;
				bellyRatingMod += addValue;
				trace("Adding", addValue, "bellyRating from pregnancy in slot", pregSlot);
			}
			else
			{
				trace("Attempted to add bellyRating contribution to a null pregnancy.");
			}
		}
		
		public function cuntChange(arg:int, volume:Number, display:Boolean = true, spacingsF:Boolean = true, spacingsB:Boolean = false):Boolean 
		{
			//Notice for treated PCs with increased stretchiness.
			if(hasStatusEffect("Treatment Elasticity Report Needed"))
			{
				if(!hasStatusEffect("Treatment Elasticity Report Q'ed")) createStatusEffect("Treatment Elasticity Report Q'ed");
			}
			//Actually change.
			return holeChange(arg,volume,display,spacingsF,spacingsB);
		}
		
		public function buttChange(volume:Number, display:Boolean = true, spacingsF:Boolean = true, spacingsB:Boolean = false):Boolean 
		{
			//Notice for treated PCs with increased stretchiness.
			if(hasStatusEffect("Treatment Elasticity Report Needed"))
			{
				if(!hasStatusEffect("Treatment Elasticity Report Q'ed")) createStatusEffect("Treatment Elasticity Report Q'ed",1);
			}
			//Actually change.
			return holeChange(-1,volume,display,spacingsF,spacingsB);
		}
		
		public function cockChange(spacingsF:Boolean = true, spacingsB:Boolean = false):Boolean 
		{
			if (cockVirgin && hasCock())
			{
				cockVirgin = false;
				var msg:String = "";
				if(spacingsF) msg += " ";
				msg += "<b>"
				if (this is PlayerCharacter)
				{
					msg += "You have succumbed to your desires and lost your";
					if (hasVagina()) msg += " masculine";
					msg += " virginity.";
				}
				else
				{
					msg += capitalA + short + " has succumbed to " + mf("his", "her") + " desires and lost " + mf("his", "her");
					if (hasVagina()) msg += " masculine";
					msg += " virginity.";
				}
				msg += "</b>"
				if (spacingsB) msg += " ";
				output(msg);
				return true;
			}
			return false;
		}
		
		protected function output(msg:String):void
		{
			kGAMECLASS.output(msg);
		}
		
		public function holeChange(hole:int, volume:Number, display:Boolean = true, spacingsF:Boolean = true, spacingsB:Boolean = false):Boolean 
		{
			var stretched:Boolean = false;
			var devirgined:Boolean = false;
			var capacity:Number;
			var holePointer:VaginaClass;
			//Set capacity based on the hole.
			if(hole == -1) {
				capacity = analCapacity();
				holePointer = ass;
			}
			else {
				if(hole+1 > totalVaginas()) return false;
				else {
					capacity = vaginalCapacity(hole);
					holePointer = vaginas[hole];
				}
			}
			//cArea > capacity = autostreeeeetch.
			if(volume >= capacity) {
				if(holePointer.looseness() >= 5) {}
				else holePointer.looseness(1);
				stretched = true;
			}
			//If within top 10% of capacity, 50% stretch
			else if(volume >= .9 * capacity && rand(2) == 0) {
				holePointer.looseness(1);
				stretched = true;
			}
			//if within 75th to 90th percentile, 25% stretch
			else if(volume >= .75 * capacity && rand(4) == 0) {
				holePointer.looseness(1);
				stretched = true;
			}
			//If virgin
			if (holePointer.hymen || (hole < 0 && analVirgin) || (hole >= 0 && vaginalVirgin)) {
				if (display)
				{
					var msg:String = "";
					if (spacingsF) msg += " ";
					msg += "<b>";
					if (this is PlayerCharacter)
					{
						if (holePointer.hymen && hole >= 0)
						{
							msg += "Your hymen is torn";
							holePointer.hymen = false;
						}
						else msg += "You have been penetrated";
						
						if (hole >= 0 && vaginalVirgin) msg += ", robbing you of your vaginal virginity";
						else if (analVirgin) msg += ", robbing you of your anal virginity";
						msg += ".";
					}
					else
					{
						if (holePointer.hymen && hole >= 0)
						{
							msg += capitalA + possessive(short) + " hymen is torn";
							holePointer.hymen = false;
						}
						else msg += capitalA + short + " has been penetrated";
						
						if (hole >= 0 && vaginalVirgin)	msg += ", robbing " + mf("him", "her") + " of " + mf("his", "her") + " vaginal virginity";
						else if (analVirgin) msg += ", robbing " + mf("him", "her") + " of " + mf("his", "her") + " anal virginity";
						msg += ".";
					}
					msg += "</b>";
					if(spacingsB) msg += " ";
					output(msg);
				}
				
				if (hole >= 0 && vaginalVirgin) 
				{
					vaginalVirgin = false;
					holePointer.hymen = false;
				}
				else if (analVirgin) analVirgin = false;
				devirgined = true;
			}
			//Delay anti-stretching
			if(volume >= .35 * capacity) {
				if(hole >= 0) {
					holePointer.shrinkCounter = 0;
				}
				else {
					holePointer.shrinkCounter = 0;
				}
			}
			if(stretched) {
				trace(short + " HOLE CODE #:" + hole + " STRETCHED TO " + holePointer.looseness() + ".");
				//STRETCH SUCCESSFUL - begin flavor text if outputting it!
				if(display) {
					//Virgins get different formatting
					if(devirgined) {
						//If no spaces after virgin loss
						if(!spacingsB) output(" ");
					}
					//Non virgins as usual
					else if(spacingsF) output(" ");
					if (hole >= 0) {
						if (this is PlayerCharacter)
						{
							if(holePointer.looseness() >= 5) output("<b>Your " + vaginaDescript(hole) + " is stretched painfully wide, gaped in a way that practically invites huge monster-cocks to plow you.</b>");
							else if(holePointer.looseness() >= 4) output("<b>Your " + vaginaDescript(hole) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
							else if(holePointer.looseness() >= 3) output("<b>Your " + vaginaDescript(hole) + " is now somewhat loose.</b>");
							else if(holePointer.looseness() >= 2) output("<b>Your " + vaginaDescript(hole) + " is a little more used to insertions.</b>");
							else output("<b>Your " + vaginaDescript(hole) + " is stretched out a little bit.</b>");
						}
						else
						{
							if(holePointer.looseness() >= 5) output("<b>" + capitalA + possessive(short) + " " + vaginaDescript(hole) + " is stretched painfully wide, gaped in a way that practically invites huge monster-cocks to plow " + mf("him", "her") +".</b>");
							else if(holePointer.looseness() >= 4) output("<b>" + capitalA + possessive(short) + " " + vaginaDescript(hole) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
							else if(holePointer.looseness() >= 3) output("<b>" + capitalA + possessive(short) + " " + vaginaDescript(hole) + " is now somewhat loose.</b>");
							else if(holePointer.looseness() >= 2) output("<b>" + capitalA + possessive(short) + " " + vaginaDescript(hole) + " is a little more used to insertions.</b>");
							else output("<b>" + capitalA + possessive(short) + " " + vaginaDescript(hole) + " is stretched out a little bit.</b>");
						}
					}
					else {
						if (this is PlayerCharacter)
						{
							if(holePointer.looseness() >= 5) output("<b>Your " + assholeDescript() + " is stretched painfully wide, gaped in a way that practically invites huge monster-cocks to plow you.</b>");
							else if(holePointer.looseness() >= 4) output("<b>Your " + assholeDescript() + " painfully dilates, the pucker now able to gape slightly.</b>");
							else if(holePointer.looseness() >= 3) output("<b>Your " + assholeDescript() + " is now somewhat loose.</b>");
							else if(holePointer.looseness() >= 2) output("<b>Your " + assholeDescript() + " is a little more used to insertions.</b>");
							else output("<b>Your " + assholeDescript() + " is stretched out a little bit.</b>");
						}
						else
						{
							if(holePointer.looseness() >= 5) output("<b>" + capitalA + possessive(short) + " " + assholeDescript() + " is stretched painfully wide, gaped in a way that practically invites huge monster-cocks to plow " + mf("him", "her") +".</b>");
							else if(holePointer.looseness() >= 4) output("<b>" + capitalA + possessive(short) + " " + assholeDescript() + " painfully stretches, the lips now wide enough to gape slightly.</b>");
							else if(holePointer.looseness() >= 3) output("<b>" + capitalA + possessive(short) + " " + assholeDescript() + " is now somewhat loose.</b>");
							else if(holePointer.looseness() >= 2) output("<b>" + capitalA + possessive(short) + " " + assholeDescript() + " is a little more used to insertions.</b>");
							else output("<b>" + capitalA + possessive(short) + " " + assholeDescript() + " is stretched out a little bit.</b>");
						}
					}
					if(spacingsB) output(" ");
				}
			}
			return (stretched || devirgined);
		}
		
		public function imbibeAlcohol(alcoholRating:int = 1):void
		{
			//E'rrybody should have dis status yo, it's da TiTS.
			if(!hasStatusEffect("Alcohol")) createStatusEffect("Alcohol",0,0,0,0);
			//V1 stores the PC's current alcohol belly level.
			//V2 is the actual blood drunkeness
			addStatusValue("Alcohol",1,alcoholRating);
			//100% alcohol is yer cap
			if(statusEffectv1("Alcohol") >= 100) setStatusValue("Alcohol",1,100);
			tolerance(1);
		}
		public function alcoholTic():void
		{
			var currentLevel:Number;
			//Phase 1: Getting drunker - booze in da belly.
			if(statusEffectv1("Alcohol") > 0)
			{
				//Absorb some into blood.
				addStatusValue("Alcohol",1,-1);
				setStatusValue("Alcohol",3,0);
				//Nuki drunk takes twice as much to get drank!
				if(hasPerk("'Nuki Drunk")) addStatusValue("Alcohol",2,.5);
				//Normal folks don't!
				else addStatusValue("Alcohol",2,1);
				
				//Updated current hammered level
				currentLevel = statusEffectv2("Alcohol")
				//Hammered
				//+5 physique & -2 willpower/int/reflexes
				if(currentLevel >= 75 && hasStatusEffect("Drunk"))
				{
					//Adjust drunk effect
					removeStatusEffect("Drunk");
					//Int/reflexes already adjusted from buzzed
					physiqueMod += 1;
					reflexesMod -= 1;
					willpowerMod -= 1;
					intelligenceMod -= 1;
					createStatusEffect("Smashed",0,0,0,0, false, "Icon_DizzyDrunk", "You're three sheets to the wind, but you feel like you could flip a truck.\n\nThis status will expire as your alcohol levels drop.", false, 0,0xB793C4);
					kGAMECLASS.eventBuffer += "\n\nWalking is increasingly difficult, but you'll be damned if you don't feel like you can do anything. <b>You're smashed!</b>";
				}
				//Drunk
				//+4 physique & -1 willpower/int/reflexes
				else if(currentLevel >= 50 && hasStatusEffect("Buzzed"))
				{
					//Adjust buzzed effect
					removeStatusEffect("Buzzed");
					//Int/reflexes already adjusted from buzzed
					physiqueMod += 2;
					reflexesMod -= 1;
					createStatusEffect("Drunk",0,0,0,0, false, "Icon_DizzyDrunk", "You're feeling a little drunk at the moment. Your faculties and reflexes are dulled, but you feel like you could arm wrestle the world if you were so inclined.\n\nThis status will expire as your alcohol levels drop.", false, 0,0xB793C4);
					kGAMECLASS.eventBuffer += "\n\nYour sense of balance is slipping a little. <b>You might be a little drunk. Just a little, you assure yourself.</b>";
				}
				//Buzzed
				//+2 physique & -1 willpower/Intelligence
				else if(currentLevel >= 25 && !hasStatusEffect("Buzzed") && !hasStatusEffect("Drunk") && !hasStatusEffect("Smashed"))
				{
					createStatusEffect("Buzzed",0,0,0,0, false, "Icon_DizzyDrunk", "You're a little buzzed, leaving you feeling strong but a little slower of wit and weaker of will.\n\nThis status will expire as your alcohol levels drop.", false, 0,0xB793C4);
					physiqueMod += 2;
					willpowerMod -= 1;
					intelligenceMod -= 1;
					kGAMECLASS.eventBuffer += "\n\nDamn, that stuff you were drinking was awesome. <b>You're feeling pretty good right now. You must be buzzed.</b>";
				}
			}
			//Phase 2 - waiting for booze levels to drop.
			//v3 counts to 60, then starts dropping
			else if(statusEffectv3("Alcohol") < 60)
			{
				addStatusValue("Alcohol",3,1);
			}
			//Phase 3 - booze levels falling
			else if(statusEffectv2("Alcohol") > 0)
			{
				//Pee some out
				//Nuki drunk takes four times as long to sober up!
				if(hasPerk("'Nuki Drunk")) addStatusValue("Alcohol",2,-.25);
				else addStatusValue("Alcohol",2,-1);
				
				//Updated current hammered level
				currentLevel = statusEffectv2("Alcohol")
				//Hammered -> Drunk
				//+5 physique & -2 willpower/int/reflexes
				if(currentLevel < 75 && hasStatusEffect("Smashed"))
				{
					//Adjust smashed -> drunk
					removeStatusEffect("Smashed");
					//Int/reflexes already adjusted from buzzed
					physiqueMod -= 1;
					reflexesMod += 1;
					willpowerMod += 1;
					intelligenceMod += 1;
					createStatusEffect("Drunk",0,0,0,0, false, "Icon_DizzyDrunk", "You're feeling a little drunk at the moment. Your faculties and reflexes are dulled, but you feel like you could arm wrestle the world if you were so inclined.\n\nThis status will expire as your alcohol levels drop.", false, 0,0xB793C4);
					kGAMECLASS.eventBuffer += "\n\nYour head is starting to clear a little, but <b>you're still pretty drunk.</b>";
				}
				//Drunk -> Buzzed
				//+4 physique & -1 willpower/int/reflexes
				else if(currentLevel < 50 && hasStatusEffect("Drunk"))
				{
					removeStatusEffect("Drunk");
					//Int/reflexes already adjusted from buzzed
					physiqueMod -= 2;
					reflexesMod += 1;
					createStatusEffect("Buzzed",0,0,0,0, false, "Icon_DizzyDrunk", "You're a little buzzed, leaving you feeling strong but a little slower of wit and weaker of will.\n\nThis status will expire as your alcohol levels drop.", false, 0,0xB793C4);
					kGAMECLASS.eventBuffer += "\n\nThe more time passes, the more nimble you feel. Your reflexes are sharpening as the alcohol fades from your system. <b>You're only buzzed.</b>";
				}
				//Buzzed -> Nothing
				//+2 physique & -1 willpower/Intelligence
				else if(currentLevel < 25 && hasStatusEffect("Buzzed"))
				{
					removeStatusEffect("Buzzed");
					physiqueMod -= 2;
					willpowerMod += 1;
					intelligenceMod += 1;
					kGAMECLASS.eventBuffer += "\n\nBlinking, you realize that the alcohol has faded from your system. <b>You're no longer buzzed.</b>";
				}
			}
			else
			{
				removeStatusEffect("Alcohol");
			}
		}
		public function tolerance(arg:Number = 0):Number
		{
			if(!hasStatusEffect("Tolerance")) createStatusEffect("Tolerance",0,0,0,0);
			var currentTolerance:Number = statusEffectv1("Tolerance");
			if(arg != 0) 
			{
				addStatusValue("Tolerance",1,arg);
				//Bounds check
				if(currentTolerance + arg < 0) setStatusValue("Tolerance",1,0);
				else if(currentTolerance + arg > 100) setStatusValue("Tolerance",1,100);
			}
			return statusEffectv1("Tolerance");
		}
		public function isDrunk():Boolean
		{
			return (hasStatusEffect("Drunk") || hasStatusEffect("Smashed"));
		}
		public function isSmashed():Boolean
		{
			return hasStatusEffect("Smashed");
		}
		public function isBuzzed():Boolean
		{
			return (hasStatusEffect("Buzzed") || hasStatusEffect("Drunk") || hasStatusEffect("Smashed"));
		}
		
		public function hasHorns(hType:Number = 0):Boolean
		{
			if (horns > 0 && hornType != 0)
			{
				// Specific type
				if (hType > 0 && hType == hornType) return true;
				// Any type
				if (hType == 0 ) return true;
			}
			return (hasStatusEffect("Horn Bumps"));
		}
		public function removeHorns():void
		{
			hornType = 0;
			horns = 0;
			hornLength = 0;
			removeStatusEffect("Horn Bumps");
			return;
		}
		
		public function eachHorn():String
		{
			if (horns > 1) return "each of your " + plural(hornDescript());
			return "your " + hornDescript();
		}
		
		public function oneHorn():String
		{
			if (horns > 1) return "one of your " + plural(hornDescript());
			return "your " + hornDescript();
		}
		
		public function hornsDescript():String
		{
			if (horns > 1) return plural(hornDescript());
			return hornDescript();
		}
		
		public function hornDescript(): String 
		{
			var descript: String = "";
			var randt: Number = rand(10);
			var descripted: Number = 0;
			var types: Array = [];
	
			if(hasStatusEffect("Horn Bumps"))
			{
				if (rand(3) == 0)
				{
					if (randt < 5) descript += "visible ";
					else descript += "upraised ";
				}
				descript += "horn-bump";
			}
			else
			{
				//Length Adjective - 50% chance
				if (rand(3) == 0) {
					//tiny
					if (hornLength < 1) {
						if (randt < 3) descript += "tiny";
						else if (randt < 6) descript += "little";
						else if (randt < 8) descript += "petite";
						else if (randt == 8) descript += "diminutive";
						else descript += "miniature";
						descripted++;
					}
					//small
					else if (hornLength < 2) {
						if (randt < 5) descript += "one-inch";
						else descript += "small";
						descripted++;
					}
					//two-inch
					else if (hornLength < 3) {
						descript += "two-inch";
						descripted++;
					}
					//three-inch
					else if (hornLength < 4) {
						descript += "three-inch";
						descripted++;
					}
					//medium
					else if (hornLength < 5) {
						if (randt < 5) descript += "four-inch";
						else descript += "noticeable";
						descripted++;
					}
					//big
					else if (hornLength < 6) {
						if (randt < 5) descript += "five-inch";
						else descript += "big";
						descripted++;
					}
					//half-foot
					else if (hornLength < 8) {
						descript += "half-foot";
						descripted++;
					}
					//large
					else if (hornLength < 12) {
						if (randt < 4) descript += "long";
						else if (randt < 6) descript += "substantial";
						else descript += "large";
						descripted++;
					}
					//foot
					else if (hornLength == 12) {
						descript += "foot-long";
						descripted++;
					}
					//huge
					else if (hornLength < 20) {
						if (randt < 3) descript += "very large";
						else if (randt < 6) descript += "considerable";
						else if (randt == 9) descript += "hulking";
						else descript += "huge";
						descripted++;
					}
					//ginormous
					else {
						if (randt < 3) descript += "monster";
						else if (randt < 6) descript += "tremendous";
						else if (randt < 8) descript += "colossal";
						else if (randt == 8) descript += "enormous";
						else descript += "oversized";
						descripted++;
					}
				}
				//Descriptive descriptions - 50% chance of being called
				if (rand(3) == 0 && descripted < 2) {
					switch (hornType)
					{
						case GLOBAL.TYPE_DRACONIC:
							types.push("draconic");
							break;
						case GLOBAL.TYPE_DEMONIC:
							types.push("demonic", "sinister");
							break;
						case GLOBAL.TYPE_BOVINE:
							types.push("bovine");
							break;
						case GLOBAL.TYPE_LIZAN:
							types.push("reptilian");
							break;
						case GLOBAL.TYPE_DEER:
							types.push("deer-like");
							break;
						case GLOBAL.TYPE_GOAT:
							types.push("ram");
							break;
						case GLOBAL.TYPE_RHINO:
							types.push("rhino");
							if(horns > 2) types.push("dinosaur", "saurian");
							break;
						case GLOBAL.TYPE_NARWHAL:
							types.push("narwhal", "unicorn-like");
							break;
					}
					if(types.length > 0)
					{
						if (descripted > 0) descript += ", ";
						descript += RandomInCollection(types);
						descripted++;
					}
				}
				//Horn nouns
				if (descripted > 0) descript += " ";
				descript += hornNoun();
			}
			
			return descript;
		}
		public function hornsNoun():String 
		{
			if (horns > 1) return plural(hornNoun());
			else return hornNoun();
		}
		public function hornNoun():String 
		{
			//Horn nouns
			if(hornType == GLOBAL.TYPE_DEER) return "antler";
			return "horn";
		}
		
		public function hasAntennae(aType:Number = 0):Boolean
		{
			if (antennae > 0 && antennaeType != 0)
			{
				// Specific type
				if (aType > 0 && aType == antennaeType) return true;
				// Any type
				if (aType == 0) return true;
			}
			return false; 
		}
		public function removeAntennae():void
		{
			antennaeType = GLOBAL.TYPE_HUMAN;
			antennae = 0;
			return;
		}
		public function antennaeDescript(asPlural:Boolean = true): String 
		{
			var description:String = "";
			var adjectives:Array = [];
			var nouns:Array = ["antenna"];
			var noun:String = "antenna";
			
			switch (antennaeType)
			{
				default:
					adjectives.push("non-existent");
					break;
					
				case GLOBAL.TYPE_BEE:
					adjectives.push("zil", "bee-like", "insect-like", "insectile");
					nouns.push("feeler");
					break;
				case GLOBAL.TYPE_SYDIAN:
					adjectives.push("sydian", "brush-like", "bristly", "insectile");
					nouns.push("feeler");
					break;
				case GLOBAL.TYPE_MYR:
					adjectives.push("myr", "ant-like", "insect-like", "insectile");
					nouns.push("feeler");
					break;
			}
			
			if(adjectives.length > 0 && rand(2) == 0) description += RandomInCollection(adjectives) + " ";
			if(nouns.length > 1) noun = RandomInCollection(nouns);
			
			if(asPlural && antennae > 1)
			{
				if(noun == "antenna") noun += "e";
				else noun = plural(noun);
			}
			
			description += noun;
			
			return description;
		}
		
		/**
		 * Mareth corruption stat.
		 */
		public function cor(arg:Number = 0, apply:Boolean = false): Number 
		{
			if (!(this is PlayerCharacter)) return personality;
			
			if (kGAMECLASS.flags["COC.CORRUPTION"] == undefined) kGAMECLASS.flags["COC.CORRUPTION"] = 0;
			if (apply) 
				kGAMECLASS.flags["COC.CORRUPTION"] = arg;
			else if (arg != 0) 
			{
				if (arg > 0 && hasPerk("Purity Blessing")) arg *= 0.75;
				if (arg > 0 && hasSock("alabaster")) arg *= 0.9;
				if (arg < 0 && hasSock("alabaster")) arg *= 1.1;
			
				kGAMECLASS.flags["COC.CORRUPTION"] += arg;
				if (kGAMECLASS.flags["COC.CORRUPTION"] > 100)
					kGAMECLASS.flags["COC.CORRUPTION"] = 100;
				if (kGAMECLASS.flags["COC.CORRUPTION"] < 0) 
					kGAMECLASS.flags["COC.CORRUPTION"] =0;
			}
			return kGAMECLASS.flags["COC.CORRUPTION"];
		}
		
		/**
		 * Returns readiness for something especially lewd, like same stat from FoE. Derivative stat based on libido, corruption and some perks. Because "pure" == "shy" concept is not 100% right.
		 */
		public function slut():Number
		{
			var score:Number = exhibitionism() / 4;
			score += Math.max(libido(), cor()); // Should corruption work outside of Mareth? Not that this function would be used outside of Mareth...
			if (isBimbo() || isBro()) score += 100;
			return score;
		}
		
		// Calculates the value of body strength (carry threshold).
		public function bodyStrength():Number
		{
			// Raw body weight
			var nBodyWeight:Number = bodyWeight();
			// Muscles buff, how much extra body weight can PC lift
			var nMuscles:Number = ((tone * nBodyWeight) * (physique() / 100));
			// Assume weakest PC can lift their own body weight, each physique point adds 'm' more pounds
			var m:Number = 5;
			var nStrength:Number = nBodyWeight + nMuscles + (physique() * m);
			// Modifiers:
			if(hasStatusEffect("Buzzed")) nStrength += (m/2);
			if(hasStatusEffect("Drunk")) nStrength += m;
			if(hasStatusEffect("Smashed")) nStrength += (2*m);
			
			return nStrength;
		}
		// Calculates the body weight, without the extra bits.
		public function bodyWeight():Number
		{
			// Simple BMI: 20 is underweight, 25 is average, 30 is overweight
			var nBMI:Number = (25 + ((thickness - 50) / 10));
			// Raw body weight, assume without extra parts
			var nWeight: Number = ((tallness / 12) * nBMI * (tallness / 75));
			
			// Tiny boost for heeps
			if(hipRating() > 0) nWeight += (hipRating() * (tallness / 60) * 0.1);
			
			// Special bodies
			if(isGoo()) nWeight *= (0.75 + ((legCount - 1) * 0.125));
			else if(isTaur()) nWeight *= (1.75 + ((legCount - 4) * 0.125));
			else if(isNaga()) nWeight *= (1.5 + ((legCount - 1) * 0.125));
			else if(isDrider()) nWeight *= (1.25 + (legCount * 0.05));
			else if(legCount > 2) nWeight *= (1 + (legCount * 0.125));
			
			return nWeight;
		}
		public function fullBodyWeight():Number
		{
			return bodyPartWeight("total");
		}
		private function bodyPartParse(partName:String = "none"):String
		{
			// Parsing stuff:
			if(InCollection(partName, "total", "all", "body", "everything", "full")) partName = "total";
			else if(InCollection(partName, "breast", "breasts", "boob", "boobs", "tit", "tits")) partName = "breast";
			else if(InCollection(partName, "belly", "tummy", "stomach", "womb")) partName = "belly";
			else if(InCollection(partName, "butt", "ass", "booty", "rump", "rear", "hiney")) partName = "butt";
			else if(InCollection(partName, "clitoris", "clit", "clits", "button", "buzzer")) partName = "clitoris";
			else if(InCollection(partName, "penis", "penises", "cock", "cocks", "dong", "wiener")) partName = "penis";
			else if(InCollection(partName, "testicle", "testicles", "balls", "scrotum", "nuts", "prostate")) partName = "testicle";
			
			return partName;
		}
		// Calculates weight of a body part.
		public function bodyPartWeight(partName:String = "none", partNum: Number = -1):Number
		{
			// Initialize variables:
			var num: int = 0;
			var tempSize: Number = 0;
			var weight: Number = 0;
			var weightBreast: Number = 0;
			var weightBelly: Number = 0;
			var weightButt: Number = 0;
			var weightClitoris: Number = 0;
			var weightPenis: Number = 0;
			var weightTesticle: Number = 0;
			var weightFluid: Number = 0; // Used for fluid weight
			var weightFat: Number = 0; // Used for excess weight
			
			partName = bodyPartParse(partName);
			
			// Everything:
			if(partName == "total")
			{
				weight += bodyWeight();
				partNum = -1;
			}
			// Breasts:
			if(partName == "breast" || partName == "total")
			{
				// Get total size/volume:
				tempSize = 0;
				if(partNum >= 0)
				{
					tempSize += breastRows[partNum].breastRating() * breastRows[partNum].breasts;
				}
				else
				{
					for (num = 0; num < breastRows.length; num++)
					{
						tempSize += breastRows[num].breastRating() * breastRows[num].breasts;
					}
				}
				// Calculate weight: Simple, Each cup is 10/25th lbs.
				weightBreast += tempSize * 0.4;
				// Modifiers:
				if(hasPerk("Fertility")) weightBreast *= 0.75;
				if(milkQ() > 0)
				{
					weightFluid = fluidWeight(milkQ());
					if(isMilkTank()) weightFluid *= 0.5;
					else if(hasPerk("Milky") || hasPerk("Treated Milk")) weightFluid *= 0.75;
					if(partNum >= 0) weightFluid /= bRows();
					weightBreast += weightFluid;
				}
				if(thickness > tone)
				{
					weightFat = (thickness - tone) * 0.01;
					if(partNum >= 0) weightFat /= bRows();
					weightBreast += weightFat;
				}
			}
			// Belly:
			if(partName == "belly" || partName == "total")
			{
				// Get size/volume:
				tempSize = bellyRating() * (tallness / 60);
				// Calculate weight: Simple, Each size is half a pound.
				weightBelly += tempSize * 0.5;
				// Modifiers:
				if(isPregnant())
				{
					// offspring weight
					for (num = 0; num < pregnancyData.length; num++)
					{
						if(isPregnant(num))
						{
							tempSize = pregnancyData[num].pregnancyBellyRatingContribution;
							var pChildType:int = PregnancyManager.getPregnancyChildType(this, num);
							if(pChildType == GLOBAL.CHILD_TYPE_LIVE) tempSize *= 1;
							else if(pChildType == GLOBAL.CHILD_TYPE_EGGS) tempSize *= 0.50;
							else if(pChildType == GLOBAL.CHILD_TYPE_SEED) tempSize *= 0.35;
							weightBelly += tempSize;
						}
					}
					if(hasPerk("Breed Hungry")) weightBelly *= 0.75;
				}
				if(thickness > tone)
				{
					weightFat = (thickness - tone) * 0.01 * (tallness / 60);
					weightBelly += weightFat;
				}
			}
			// Butt:
			if(partName == "butt" || partName == "total")
			{
				// Get size/volume:
				tempSize = buttRating() * (tallness / 60);
				// Calculate weight: Simple, Each size is half a pound.
				weightButt += tempSize * 0.5;
				// Modifiers:
				if(thickness > tone)
				{
					weightFat = (thickness - tone) * 0.01 * (tallness / 60);
					weightButt += weightFat;
				}
			}
			// Clitoris:
			if(partName == "clitoris" || partName == "total")
			{
				// Get total length:
				tempSize = 0;
				if(partNum >= 0) tempSize += clitLength * vaginas[partNum].clits;
				else tempSize += clitLength * totalClits();
				// Calculate weight: Simple, Each inch of length is 1/80th lbs.
				weightClitoris += tempSize * 0.0125;
				// Modifiers:
				if(hasPerk("Hung")) weightClitoris *= 0.75;
			}
			// Penis:
			if(partName == "penis" || partName == "total")
			{
				// Get total size/volume:
				tempSize = 0;
				if(partNum >= 0)
				{
					tempSize += cockVolume(partNum);
				}
				else
				{
					for (num = 0; num < cocks.length; num++)
					{
						tempSize += cockVolume(num);
					}
				}
				// Calculate weight: Simple, Each volume unit is 1/20th lbs.
				weightPenis += tempSize * 0.05;
				// Modifiers:
				if(partNum >= 0)
				{
					if(hasKnot(partNum))
					{
						weightFat = cocks[partNum].thickness() * cocks[partNum].knotMultiplier * 0.25;
						weightPenis += weightFat;
					}
				}
				else
				{
					for (num = 0; num < cocks.length; num++)
					{
						if(hasKnot(num))
						{
							weightFat = cocks[num].thickness() * cocks[num].knotMultiplier * 0.25;
							weightPenis += weightFat;
						}
					}
				}
				if(hasPerk("Hung")) weightPenis *= 0.75;
			}
			// Testicles:
			if(partName == "testicle" || partName == "total")
			{
				// Get total size/volume:
				if(balls <= 0) num = 1;
				else num = balls;
				tempSize = ballVolume();
				// Calculate weight: Simple, Each volume unit is 1/80th lbs.
				weightTesticle += tempSize * num * 0.0125;
				// Modifiers:
				if(cumQ() > 0)
				{
					// Maybe only 50% is housed in the balls?
					weightFluid = fluidWeight(cumQ() * 0.5);
					if(hasPerk("Potent") && hasPerk("Breed Hungry")) weightFluid *= 0.5;
					else if(hasPerk("Potent") || hasPerk("Breed Hungry")) weightFluid *= 0.75;
					if(hasStatusEffect("Nyrea Eggs")) weightFluid += (0.125 * statusEffectv1("Nyrea Eggs"));
					if(partNum > 0 && partNum <= balls) weightFluid = (weightFluid / partNum);
					weightTesticle += weightFluid;
				}
				if(hasPerk("Bulgy")) weightTesticle *= 0.75;
			}
			
			// Add up all the weights
			weight += weightBreast;
			weight += weightBelly;
			weight += weightButt;
			weight += weightClitoris;
			weight += weightPenis;
			weight += weightTesticle;
			
			return weight;
		}
		// Calculates the weight of an amount of fluid.
		public function fluidWeight(fluidAmount: Number = 0):Number
		{
			if(InCollection(cumType, GLOBAL.FLUID_TYPE_HONEY, GLOBAL.FLUID_TYPE_MILKSAP, GLOBAL.FLUID_TYPE_CUMSAP, GLOBAL.FLUID_TYPE_NECTAR)) fluidAmount *= 0.005;
			else if(InCollection(cumType, GLOBAL.FLUID_TYPE_CUM, GLOBAL.FLUID_TYPE_GABILANI_CUM, GLOBAL.FLUID_TYPE_NYREA_CUM, GLOBAL.FLUID_TYPE_VANAE_CUM)) fluidAmount *= 0.0035;
			else fluidAmount *= 0.0025;
			
			return fluidAmount;
		}
		// Weight Quotient for comparisons between strength (weight load).
		public function weightQ(partName:String = "none", partNum: Number = -1):Number
		{
			partName = bodyPartParse(partName);
			
			var weight: Number = bodyPartWeight(partName, partNum);
			
			// Compare to strength:
			return Math.round((weight / bodyStrength()) * 100);
		}
		// Is a part of anatomy heavy?
		// partName: String, name of part, 'total' for everything.
		// partNum: Number, row number or array ID if 0 or higher.
		public function isHeavy(partName:String = "none", partNum: Number = -1):Boolean
		{
			if(weightQ(partName, partNum) > 50) return true;
			return false;
		}
		// Height Ratio for comparisons.
		public function heightRatio(partName:String = "none", partNum: Number = -1):Number
		{
			var nRatio: Number = 0;
			
			if(partName == "total") { /* Nothing! */ }
			else if(partName == "breast")
			{
				if(hasBreasts())
				{
					if(partNum >= 0) nRatio = bRating(partNum) / tallness;
					else nRatio = biggestTitSize() / tallness;
				}
			}
			else if(partName == "belly") nRatio = bellyRating() / tallness;
			else if(partName == "butt") nRatio = buttRating() / tallness;
			else if(partName == "clitoris")
			{
				if(hasVagina()) nRatio = clitLength / tallness;
			}
			else if(partName == "penis")
			{
				if(hasCock())
				{
					if(partNum >= 0) nRatio = cLength(partNum) / tallness;
					else nRatio = biggestCockLength() / tallness;
				}
			}
			else if(partName == "testicle")
			{
				if(balls > 0) nRatio = ballDiameter() / tallness;
			}
			
			return nRatio;
		}
		
		public function isDefeated():Boolean
		{
			if (HP() <= 0 || lust() >= lustMax()) return true;
			return false;
		}
		
		/**
		 * Core combat AI handling; this methods called on each creature present in a fight
		 * (excepting the player).
		 * The array names are relative to the creature in question, f.ex
		 * PC vs NPC1, NPC2 =>
		 * 		PC alliedCreatures(PC), hostileCreatures(NPC1, NPC2)
		 * 		NPC1 alliedCreatures(NPC1, NPC2), hostileCreatures(PC)
		 */
		public function CombatAI(alliedCreatures:Array, hostileCreatures:Array):void
		{
			throw new Error("Creature combat handler for " + this.short + " has not been overriden!");
		}
		
		/**
		 * Handy helper to select a potential target at random!
		 * TODO: Include some standard "weighting" effects to influence target selection
		 * f.ex prefer potential targets that have debuffs granting increased accuracy against them
		 * @param	otherTeam
		 * @return
		 */
		protected function selectTarget(otherTeam:Array):Creature
		{
			var selTarget:Creature = null;
			
			var posTargets:Array = [];
			
			for (var i:int = 0; i < otherTeam.length; i++)
			{
				// If it hasn't been defeated already this turn
				if (otherTeam[i].HP() > 0 && otherTeam[i].lust() < otherTeam[i].lustMax())
				{
					var posTarget:Object = { v: otherTeam[i], w: 10 };
					posTargets.push(posTarget);
					
					// Example "forced" effect selection
					if (otherTeam[i].hasStatusEffect("Focus Fire"))
					{
						selTarget = otherTeam[i];
					}
					
					// Smugglers are slightly less likely to be targeted
					if (otherTeam[i].characterClass == GLOBAL.CLASS_SMUGGLER)
					{
						posTarget.w -= 1;
					}
					// Mercs slightly more
					else if (otherTeam[i].characterClass == GLOBAL.CLASS_MERCENARY)
					{
						posTarget.w += 1;
					}
					
				}
			}
			
			if (posTargets.length == 0) selTarget = null;
			else if (posTargets.length == 1) selTarget = posTargets[0].v;
			else selTarget = weightedRand(posTargets);
			
			notifyTargetSelection(this, selTarget, this);
			
			return selTarget;
		}
		
		private function notifyTargetSelection(attacker:Creature, target:Creature, enemy:Creature):void
		{
			kGAMECLASS.setAttacker(attacker);
			kGAMECLASS.setTarget(target);
			kGAMECLASS.setEnemy(enemy);
		}
		
		/**
		 * Allow the energy cost of an attack to be potentially modified.
		 * @param	inCost
		 * @return
		 */
		public function CalculateEnergyCost(attack:SingleCombatAttack):Number
		{
			return attack.EnergyCost;
		}
		
		public function untypedDroneDamage():Number
		{
			return 1 + level + rand(2 + level / 2);
		}
		
		public function droneDamage():TypeCollection
		{
			var d:Number = untypedDroneDamage();
			if (accessory is TamWolfDamaged)
			{
				d -= -1;
				return new TypeCollection( { kinetic: d } );
			}
			if (hasStatusEffect("Varmint Buddy"))
			{
				d -= -1;
				var varmintDamage:TypeCollection = new TypeCollection();
				varmintDamage.kinetic.damageValue = Math.round(d * 0.75);
				varmintDamage.corrosive.damageValue = Math.round(d * 0.25);
				varmintDamage.addFlag(DamageFlag.PENETRATING);
				return varmintDamage;
			}
			return new TypeCollection( { electric: d } );
		}
		
		public var droneTarget:Creature = null; // Transient
		public var concentratedFireTarget:Creature = null; // Transient
		public var isUniqueInFight:Boolean = false;
		public var uniqueName:String = null; // Transient
		public function get flags():Dictionary { return kGAMECLASS.flags; } // Transient
		public var alreadyDefeated:Boolean = false; // Transient
		public var shieldDisplayName:String = "SHIELDS"; // Transient
		
		/**
		 * Return the name for the bust this character should display. This'll be used during combat, but also potentially
		 * useful for other things. A getter function to support introspection to vary busts based on lust etc.
		 */
		public function get bustDisplay():String
		{
			return "";
		}
		
		public function getCombatDescriptionExtension():void
		{
			// noop
		}
		
		public var btnTargetText:String // Base text used for buttons
		public var buttonText:String; // Transient version of ^ with a unique ID appended
		
		public function hasLipPiercing():Boolean
		{
			return false; // 9999
		}
		
		public function hasTonguePiercing():Boolean
		{
			return false; // 9999
		}
		public function statusTick():void {
			var expiredStatuses:Array = new Array();
			//For storing things that remove statuses AFTER parsing the status list - fixes counter mismatches
			var postRemovalEffects:Array = new Array();
			var gogoVenomShit:Boolean = false;

			for(var x:int = statusEffects.length-1; x >= 0; x--) 
			{
				if(this is PlayerCharacter)
				{
					//Some hardcoded removal stuff
					//Cut condensol if all cocks are gone.
					if(((statusEffects[x] as StorageClass).storageName == "Condensol-B" || (statusEffects[x] as StorageClass).storageName == "Condensol-A") && !hasCock())
					{
						expiredStatuses[expiredStatuses.length] = x;
					}
				}
				//trace("Checking status effect: " + x + " of " + (statusEffects.length-1));
				//If times, count dat shit down.
				if((statusEffects[x] as StorageClass).minutesLeft > 0) 
				{
					(statusEffects[x] as StorageClass).minutesLeft--;
					//Expired Statuses
					if((statusEffects[x] as StorageClass).minutesLeft <= 0) 
					{
						//PC specific status shit
						if (this is PlayerCharacter)
						{
							//CERTAIN STATUSES NEED TO CLEAR SOME SHIT.
							switch((statusEffects[x] as StorageClass).storageName)
							{
								case "Lane's Hypnosis":
									kGAMECLASS.baseHypnosisWearsOff((statusEffects[x] as StorageClass).storageName);
									break;
								case "Crabbst":
									physiqueMod -= (statusEffects[x] as StorageClass).value2;
									reflexesMod += (statusEffects[x] as StorageClass).value2;
									aimMod += (statusEffects[x] as StorageClass).value2;
									intelligenceMod += (statusEffects[x] as StorageClass).value2;
									willpowerMod += (statusEffects[x] as StorageClass).value2;
									break;
								case "Horse Pill":
									var pill:HorsePill = new HorsePill();
									kGAMECLASS.eventQueue[kGAMECLASS.eventQueue.length] = pill.lastPillTF;
									break;
								//Goblinola changes!
								case "Goblinola Bar":
									var gobbyTF:Goblinola = new Goblinola();
									kGAMECLASS.eventQueue[kGAMECLASS.eventQueue.length] = gobbyTF.itemEndGoblinTF;
									break;
								case "Gabilani Face Change":
									var gobbyFaceTF:Goblinola = new Goblinola();
									kGAMECLASS.eventQueue[kGAMECLASS.eventQueue.length] = gobbyFaceTF.itemGoblinFaceTF;
									break;
								//Clippex changes!
								case "Clippex Gel":
									var clippexTF:Clippex = new Clippex();
									if((statusEffects[x] as StorageClass).value2 > 1) kGAMECLASS.eventQueue[kGAMECLASS.eventQueue.length] = clippexTF.itemClippexTFPlus;
									else kGAMECLASS.eventQueue[kGAMECLASS.eventQueue.length] = clippexTF.itemClippexTF;
									break;
								//Semen's Friend changes!
								case "Semen's Candy":
									var semensTF:SemensFriend = new SemensFriend();
									if((statusEffects[x] as StorageClass).value2 > 1) kGAMECLASS.eventQueue[kGAMECLASS.eventQueue.length] = semensTF.itemSemensFriendTFPlus;
									else kGAMECLASS.eventQueue[kGAMECLASS.eventQueue.length] = semensTF.itemSemensFriendTF;
									break;
								case "Red Myr Venom":
									//Bit of a hacky solution
									gogoVenomShit = true;
									break;
								// Mhen'gan Mango finishes!
								case "The Mango":
									kGAMECLASS.eventBuffer += "\n\nYour attractive aura fades from you as your sexiness returns to normal levels.";
									if (kGAMECLASS.silly && rand(3) != 0) kGAMECLASS.eventBuffer += " You could no longer handle the mango!";
									else kGAMECLASS.eventBuffer += " The wild mango’s effect has worn off!";
									break;
								//Jaded wears off!
								case "Jaded":
									kGAMECLASS.eventBuffer += "\n\nNo longer bored from your previous whoring session, you feel a bit more refreshed now.";
									break;
								//Condensol ends!
								case "Condensol-A":
									if(hasCock())
									{
										kGAMECLASS.eventBuffer += "\n\nYou feel your groin relax, and check your [pc.cocks] to discover that everything is more or less as it should be. The Condensol must have worn off.";
										for(var y:int = 0; y < cockTotal(); y++)
										{
											cocks[y].cLengthRaw *= 2;
										}
									}
									break;
								case "Condensol-B":
									if(hasCock())
									{
										kGAMECLASS.eventBuffer += "\n\nYou feel your groin relax, and check your [pc.cocks] to discover that everything is more or less as it should be. The Condensol must have worn off.";
										for(var z:int = 0; z < cockTotal(); z++)
										{
											cocks[z].cLengthRaw *= 4;
										}
									}
									break;
								//Mighty Tight ends!
								case "Mighty Tight":
									kGAMECLASS.eventBuffer += "\n\nPausing for a moment, you feel your backdoor";
									if(hasVagina()) kGAMECLASS.eventBuffer += " and [pc.vaginas] relaxing";
									else kGAMECLASS.eventBuffer += " relax";
									kGAMECLASS.eventBuffer += " a bit. It is probably safe to say that you are no longer under the effects of Mighty Tight.";
									break;
								//Boobswell ends!
								case "Boobswell Pads":
									//Message text, last boob size increase. 7 days later.
									kGAMECLASS.eventBuffer += "\n\nUnfortunately, as you admire your now-larger bosom, you realize that the gentle, wet rumble of the pads has come to a stop. <b>It looks like you’ve exhausted the BoobSwell Pads";
									if(bRows() > 1) kGAMECLASS.eventBuffer += "on your " + kGAMECLASS.num2Text2((statusEffects[x] as StorageClass).value1+1) + " row of breasts";
									kGAMECLASS.eventBuffer += "!</b> You peel them off your [pc.skinFurScales] and toss them away.";
									break;
								//Treatment finishing.
								case "The Treatment":
									kGAMECLASS.eventBuffer += "\n\n<b>The Treatment is over.</b> You aren’t sure why or how you know, but you know it all the same. Well, there’s nothing left to do but enjoy your enhanced body to the fullest! ...While hunting for Dad’s probes, of course. It’s the best way to meet sexy new aliens.";
									kGAMECLASS.eventBuffer += "\n\nOnce you claim you fortune, you can retire on New Texas, maybe even get your own private milker.";
									break;
								//Sterilex/Infertile ends!
								case "Infertile":
									kGAMECLASS.eventBuffer += "\n\nA strange tingling sensation spreads through your loins as your microsurgeons are suddenly reinvigorated. Your codex then beeps to notify you that you have regained your";
									if(hasGenitals())
									{
										if(hasVagina()) kGAMECLASS.eventBuffer += " fertility";
										if(isHerm()) kGAMECLASS.eventBuffer += " and";
										if(hasCock()) kGAMECLASS.eventBuffer += " virility";
									}
									else kGAMECLASS.eventBuffer += " fertility and virility should you ever have the genitals for them";
									kGAMECLASS.eventBuffer += ". <b>Your ability to potentionally create life has been restored!</b>";
									break;
								case "Mead":
									physiqueMod -= (statusEffects[x] as StorageClass).value2;
									reflexesMod += (statusEffects[x] as StorageClass).value2 * .5;
									aimMod += (statusEffects[x] as StorageClass).value2 * .5;
									intelligenceMod += (statusEffects[x] as StorageClass).value2 * .5;
									willpowerMod += (statusEffects[x] as StorageClass).value2 * .5;
									break;
								case "X-Zil-rate":
									physiqueMod -= (statusEffects[x] as StorageClass).value2;
									break;
								case "Quivering Quasar":
									physiqueMod -= (statusEffects[x] as StorageClass).value2;
									break;
								case "Zil Sting":
									reflexesMod += (statusEffects[x] as StorageClass).value1;
									libidoMod -= (statusEffects[x] as StorageClass).value1;
									break;
								case "Naleen Venom":
									physiqueMod += (statusEffects[x] as StorageClass).value1;
									aimMod += (statusEffects[x] as StorageClass).value1;
									willpowerMod += (statusEffects[x] as StorageClass).value1;
									reflexesMod += (statusEffects[x] as StorageClass).value1;
									break;
								case "GaloMax":
									kGAMECLASS.eventQueue.push(kGAMECLASS.galoMaxTFProc);
									break;
							}
						}
						else if(this is Emmy)
						{
							//CERTAIN STATUSES NEED TO CLEAR SOME SHIT.
							switch((statusEffects[x] as StorageClass).storageName)
							{
								case "Massaging":
								case "Slow Fucking":
									kGAMECLASS.emmyTeaseCum();
									postRemovalEffects.push(kGAMECLASS.emmyTeaseCumEffects);
									break;
								case "Drain Cooldown":
									kGAMECLASS.emmyCumClearance();
									postRemovalEffects.push(kGAMECLASS.emmyCumStatusPurge);
									break;
							}
						}
						//Mark out the ones that need cut!
						expiredStatuses[expiredStatuses.length] = x;
						//trace("Marking slot: " + x + " to cut");
					}
				}
			}	
			
			//Cut the statuses that expired and need cut.
			while(expiredStatuses.length > 0)
			{
				trace("REMOVING " + (statusEffects[expiredStatuses[0]] as StorageClass).storageName + " in slot " + expiredStatuses[0] + " due to status effect time out.");
				statusEffects.splice(expiredStatuses[0],1);
				expiredStatuses.splice(0,1);
			}
			//Alright, now do the venom shit - since adding more statuses could fuck shit otherwise
			if(gogoVenomShit) kGAMECLASS.venomExpirationNotice();

			//Any post-functions to run?
			while(postRemovalEffects.length > 0)
			{
				postRemovalEffects[0]();
				postRemovalEffects.splice(0,1);
			}
		}
		//Cumflation
		//v1 = current in belly
		//v2 = most had in belly
		//v3 = most recent cum "type".
		public function cumFlationSimulate(timePassed:Number):void
		{
			//Vag filled
			var z:int = -1;
			//Anally Filled
			var a:int = -1;
			//Orally filled
			var o:int = -1;
			//Place to store draining notices.
			var notice:String = "";
			var amountVented:Number
			var removals:Array = new Array();
			var cumDrain:Boolean = !hasPerk("No Cum Leakage");

			//Find the index value for various types of cumflation.
			for(var x:int = 0; x < statusEffects.length; x++)
			{
				switch(statusEffects[x].storageName)
				{
					case "Anally-Filled":
						a = x;
						break;
					case "Vaginally-Filled":
						z = x;
						break;
					case "Orally-Filled":
						o = x;
						break;
				}
			}
			//If has vaginally-filled status effect!
			if(z >= 0)
			{
				if(cumDrain)
				{
					//Figure out how much cum is vented over time.
					//Should vent 1/2 the current amount over 30 minutes
					//+a small amount based off the maximum amount full you've been for this proc.
					amountVented = statusEffects[z].value1 / 4 / 2 + statusEffects[z].value2 / 48
					//Mult times minutes passed
					amountVented *= timePassed/60;
					//trace("CURRENT CUM BANKED: " + statusEffects[z].value1 + " VENTING: " + amountVented);
					//Apply to actual status
					statusEffects[z].value1 -= amountVented;
				}
				//Special notices!
				if(this is PlayerCharacter && notice == "")
				{
					if(amountVented >= 25000) 
					{
						notice += "\n\n" + upperCase(fluidViscosity(statusEffects[z].value3)) + " " + fluidNoun(statusEffects[z].value3) + " hoses out ";
						if(legCount > 1) notice += "from between your [pc.legs] ";
						else notice += "of you ";
						notice += "in a seemingly endless tide. You can't even move with wet gushes splattering onto the ground, marking a slut-shaming trail wherever you move.";
						if(!isCrotchExposed()) notice += " It wouldn't be so bad if most of it didn't wind up inside your [pc.lowerGarments], leaving you slick and musky with residual love.";
					}
					else if(amountVented >= 10000)
					{
						notice += "\n\nTrailing " + fluidNoun(statusEffects[z].value3) + " behind you like slime from a slug, clearly marking your passage more effectively than any tracking bug ever could. There's nothing you can do about it either, save for waiting for the boundless sexual effluvia to finish spilling from your soiled body.";
					}
					else if(amountVented >= 5000)
					{
						notice += "\n\nThere's so much " + fluidNoun(statusEffects[z].value3) + " sliding out of you. You can't ";
						if(isNaga() || isGoo()) notice += "slither a few feet";
						else notice += "take a step";
						notice += " without thick blobs of goo rolling down your [pc.leg] to the floor, advertising your sexual adventures to anyone close to enough to see, or smell, you."
					}
					else if(amountVented >= 2500)
					{
						notice += "\n\n" + upperCase(fluidNoun(statusEffects[z].value3)) + " is everywhere. It just won't stop coming out of you. Sure, the more " + fluidViscosity(statusEffects[z].value3) + " goop leaks out, the tighter your belly becomes, but it's just so damn messy! You're pretty sure you could've filled up a two liter bottle and then some if you were so inclined. Just how thoroughly did you get stuffed?";
					}
					else if(amountVented >= 1000)
					{
						notice += "\n\n" + upperCase(fluidNoun(statusEffects[z].value3)) + " gets all over the place. It keeps drooling down your [pc.legOrLegs]";
						if(!isCrotchExposed()) notice += " and getting all over your [pc.lowerGarments]";
						notice += ", squishing and sliding and making you absolutely reek of sex.";
					}
					else if(amountVented >= 500)
					{
						notice += "\n\nThere's no lack of " + fluidNoun(statusEffects[z].value3) + " dripping down your [pc.thighs], evidence of your recent and all-too sloppy encounter.";
					}
					//9999 apply cum-drenched flag as appropriate?
				}
				if(statusEffects[z].value1 <= 0) removals.push("Vaginally-Filled");
			}
			//If has anally-filled status effect!
			if(a >= 0)
			{
				if(cumDrain)
				{
					//Figure out how much cum is vented over time.
					//Should vent 1/2 the current amount over 30 minutes
					//+a small amount based off the maximum amount full you've been for this proc. 
					amountVented = statusEffects[a].value1 / 4 / 2 + statusEffects[a].value2 / 48
					//Mult times minutes passed
					amountVented *= timePassed/60;
					//Apply to actual status
					statusEffects[a].value1 -= amountVented;
				}
				//Special notices!
				if(this is PlayerCharacter && notice == "")
				{
					if(amountVented >= 25000) 
					{
						notice += "\n\n" + upperCase(fluidViscosity(statusEffects[a].value3)) + " " + fluidNoun(statusEffects[a].value3) + " hoses out ";
						if(legCount > 1) notice += "from between your [pc.legs] ";
						else notice += "of you ";
						notice += "in a seemingly endless tide. You can't even move with wet gushes splattering onto the ground, marking a slut-shaming trail wherever you move.";
						if(!isCrotchExposed()) notice += " It wouldn't be so bad if most of it didn't wind up inside your [pc.lowerGarments], leaving you slick and musky with residual love.";
					}
					else if(amountVented >= 10000)
					{
						notice += "\n\nTrailing " + fluidNoun(statusEffects[a].value3) + " behind you like slime from a slug, clearly marking your passage more effectively than any tracking bug ever could. There's nothing you can do about it either, save for waiting for the boundless sexual effluvia to finish spilling from your soiled body.";
					}
					else if(amountVented >= 5000)
					{
						notice += "\n\nThere's so much " + fluidNoun(statusEffects[a].value3) + " sliding out of you. You can't ";
						if(isNaga() || isGoo()) notice += "slither a few feet";
						else notice += "take a step";
						notice += " without thick blobs of goo rolling down your [pc.leg] to the floor, advertising your sexual adventures to anyone close to enough to see, or smell, you."
					}
					else if(amountVented >= 2500)
					{
						notice += "\n\n" + upperCase(fluidNoun(statusEffects[a].value3)) + " is everywhere. It just won't stop coming out of you. Sure, the more " + fluidViscosity(statusEffects[a].value3) + " goop leaks out, the tighter your belly becomes, but it's just so damn messy! You're pretty sure you could've filled up a two liter bottle and then some if you were so inclined. Just how thoroughly did you get stuffed?";
					}
					else if(amountVented >= 1000)
					{
						notice += "\n\n" + upperCase(fluidNoun(statusEffects[a].value3)) + " gets all over the place. It keeps drooling down your [pc.legOrLegs]";
						if(!isCrotchExposed()) notice += " and getting all over your [pc.lowerGarments]";
						notice += ", squishing and sliding and making you absolutely reek of sex.";
					}
					else if(amountVented >= 500)
					{
						notice += "\n\nThere's no lack of " + fluidNoun(statusEffects[a].value3) + " dripping down your [pc.thighs], evidence of your recent and all-too sloppy encounter.";
					}
					//9999 apply cum-drenched flag as appropriate?
				}
				if(statusEffects[a].value1 <= 0) removals.push("Anally-Filled");
			}
			//If has orally-filled status effect!
			if(o >= 0)
			{
				if(cumDrain)
				{
					//Figure out how much cum is vented over time.
					//Should vent 1/2 the current amount over 30 minutes
					//+a small amount based off the maximum amount full you've been for this proc. 
					amountVented = statusEffects[o].value1 / 8 / 2 + statusEffects[o].value2 / 48
					//Mult times minutes passed
					amountVented *= timePassed/60;
					//Apply to actual status
					statusEffects[o].value1 -= amountVented;
				}
				//Special notices!
				if(this is PlayerCharacter && notice == "")
				{
					//If Jacques00 or Geddy wants to write stuff for this, feel free, but I'm fine with it being more laid back.
					//9999 apply cum-drenched flag as appropriate?
				}
				if(statusEffects[o].value1 <= 0) removals.push("Orally-Filled");
			}
			//Remove if no more cum!
			while(removals.length > 0) 
			{
				removeStatusEffect(removals[0]);
				removals.splice(0,1);
			}
			kGAMECLASS.eventBuffer += notice;
		}

		// OnTakeDamage is called as part of applyDamage.
		// You should generate a message for /deferred/ display in the creature
		// rather than emitting text immediately. You should then emit it
		// during the CombatAI call before taking any other action. See
		// CrystalGooT1 for an example.
		protected var OnTakeDamageOutput:String;
		public function OnTakeDamage(incomingDamage:TypeCollection):void
		{
			
		}
	}
	
}
