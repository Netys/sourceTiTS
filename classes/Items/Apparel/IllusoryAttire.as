package classes.Items.Apparel 
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.DamageFlag;
	import classes.Engine.Interfaces.output;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;

	public class IllusoryAttire extends ItemSlotClass
	{
		public static var descBasic:String = "A set of ornate bands designed to be worn on feet and tails by Kitsune in feral or semi-feral form and enchanted with distracting unfocused attention glamour. Can be worn on wrists and shins as well.";
		public static var descDefault:String = "\n\nAs long as your body is animalistic enough, you won't be accused of public indecency while wearing them. As a side effect they can partially protect you from psionic attacks, but nothing else. The illusion requires several specific body points for proper work: fur or scales, long tail, digitigrade paws or another sort of inhuman legs, C-cup or smaller breasts. Also, it only can hide your male parts if your have genital slit or sheath and your balls are not too large.";
		public static var descNineTails:String = " You won't be accused of public indecency while wearing them.\n\nSince they are worn by Kitsune, their potential is fully unleashed. The magic barrier is powerful enough to provide some protection from any threat, and any body type requirements are lifted.";
		public static var descPsionic:String = " You won't be accused of public indecency while wearing them.\n\nSince they are worn by psionic, their potential is fully unleashed. The psionic barrier is powerful enough to provide some protection from any threat, and any body type requirements are lifted.";
		
		public function IllusoryAttire() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "Illus.Attire";
			
			this.longName = "illusory attire";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "an illusory attire";
			
			this.tooltip = descBasic + descDefault;
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 5000;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.sexiness = 4;
			this.critBonus = 0;
			this.evasion = 2;
			this.fortification = 0;
			
			this.resistances.addFlag(DamageFlag.NULLIFYING);
			
			this.itemFlags = [GLOBAL.ITEM_FLAG_EXPOSE_FULL, GLOBAL.ITEM_FLAG_SWIMWEAR];
			
			this.version = this._latestVersion;
		}
		
		public static function isActive(target:Creature):Boolean {
			if (kGAMECLASS.isNineTails(target) || target.isPsionic()) return true; // when owned by psionic or Nine-tails all limitations are lifted
			
			if (!target.hasFur() && !target.hasScales()) return false;
			if (target.hasLegFlag(GLOBAL.FLAG_PLANTIGRADE)) return false;
			if (!(target.hasTail() && target.hasTailFlag(GLOBAL.FLAG_LONG)) && !target.isNaga()) return false;
			if (target.biggestTitSize() > 3 && target.isChestExposed()) return false; // taurs variant: garbed chest and exposed crotch
			
			if (target.hasStatusEffect("Genital Slit") || !target.isCrotchExposed()) return true; // no further checks if all genitals are hidden
			
			if (target.balls > 0 && target.balls * target.ballVolume() * (target.hasStatusEffect("Uniball") ? 0.75 : 1) > 200) return false;
			if (target.hasCock() && !target.hasFullSheaths()) return false;
			
			return true;
		}
		
		override public function onEquip(targetCreature:Creature):void
		{
			var validate:String = onValidate(targetCreature, false);
			if (targetCreature.isExposed()) {
				if (isActive(targetCreature)) {
					output(" While not covering anything, this bands still somehow give you decent appearance.");
				}
				else output(" With these bands, your appearance is even more provoking than mere nudity.");
			}
			if(validate != "") output(validate);
		}
		
		public function onValidate(target:Creature, showOutput:Boolean = true):String { // actually, this should be override of a generic function
			if (!target.hasArmor() || !target.armor is IllusoryAttire) return "";
			
			var isNineTails:Boolean = kGAMECLASS.isNineTails(target);
			var ret:String = "";
			
			if (hasRandomProperties && !isNineTails && !target.isPsionic()) {
				ret += "\n\nWithout your power flowing through your bands, they are little more than just decorations.";
				target.armor = new IllusoryAttire(); // reset stats
				TooltipManager.addTooltip(shortName, tooltip);
			}
			else if (isNineTails || target.isPsionic()) {
				if(!hasRandomProperties) { // first time message
					ret += "\n\nYou feel your power resonating with your bands... You are fully in tune with them! Enchantment is now powerful enough to provide some real protection from attacks as well, and glamour effect is more effective too.";
				}
				type = GLOBAL.ARMOR;
				tooltip = descBasic + (isNineTails ? descNineTails : descPsionic);
				defense = Math.ceil(target.level / 4) + 2; // 7 on level 20
				shieldDefense = defense;
				evasion = Math.ceil(target.level / 2) + 2; // 12 on level 20
				sexiness = Math.ceil(target.level / 4) + 4; // 9 on level 20
				resistances.psionic.resistanceValue = 20; // 40 effective with nullifying flag
				hasRandomProperties = true;
				TooltipManager.addTooltip(shortName, tooltip);
			}
			
			if (showOutput && !target.hasStatusEffect("In Creation")) kGAMECLASS.eventBuffer += ret;
			
			return ret;
		}
	}
}
