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
		public static var descDefault:String = "\n\nAs long as your body is animalistic enough, you won't be accused in public indecency while wearing them. As side effect they can partially protect you from psionic attacks, but nothing else. Illusion requires several specific body points for proper work: fur or scales, long tail, digitigrade paws or other sort of inhuman legs, C-cup or smaller breasts. Also, it only can hide your male parts if your have genital slit or sheath and your balls are not too large.";
		public static var descNineTails:String = " You won't be accused in public indecency while wearing them.\n\nSince they are worn by Kitsune, their potential is fully unleashed. Magic barrier is powerful enough to provide some protection from any threat, and any body type requirements are lifted.";
		public static var descPsionic:String = " You won't be accused in public indecency while wearing them.\n\nSince they are worn by psionic, their potential is fully unleashed. Psionic barrier is powerful enough to provide some protection from any threat, and any body type requirements are lifted.";
		
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
			if (targetCreature.isExposed()) {
				if (isActive(targetCreature)) {
					output(" While not covering anything, this bands still somehow give you decent appearance.");
				}
				else output(" With this bands your appearance is even more provoking than simple nudity.");
			}
		}
	}
}
