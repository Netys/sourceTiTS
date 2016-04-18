package classes.Items.Transformatives
{
	import classes.CockClass;
	import classes.Creature;
	import classes.GameData.TooltipManager;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCEctoplasm extends ItemSlotClass
	{
		public function CoCEctoplasm(dataObject:Object=null)
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.POTION;
			//Used on inventory buttons
			this.shortName = "Ectoplasm";
			//Regular name
			this.longName = "bottle of ectoplasm";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle of ectoplasm";
			//Displayed on tooltips during mouseovers
			this.tooltip = "The green-tinted, hardly corporeal substance flows like a liquid inside its container. It makes you feel... uncomfortable, as you observe it.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 60;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			output("You grimace and uncork the bottle, doing your best to ignore the unearthly smell drifting up to your nostrils. Steeling yourself, you raise the container to your lips and chug the contents, shivering at the feel of the stuff sliding down your throat.  Its taste, at least, is unexpectedly pleasant.  Almost tastes like oranges.");
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Effect script 1:  (higher intelligence)
			if ((pc.IQ() < 100 || pc.WQ() < 100) && rand(3) == 0 && changes < changeLimit) {
				output("\n\nYou groan softly as your head begins pounding something fierce.  Wincing in pain, you massage your temples as the throbbing continues, and soon, the pain begins to fade; in its place comes a strange sense of sureness and wit.");
				if(pc.IQ() < 100 && (pc.WQ() >= 100 || rand(2) == 0)) {
					pc.slowStatGain("i", 1);
					if (pc.IQ() < 50) pc.slowStatGain("i", 1);
				} else {
					pc.slowStatGain("w", 1);
					if (pc.WQ() < 50) pc.slowStatGain("w", 1);
				}
				changes++;
			}
			//Effect script 2:  (lower sensitivity)
			//if (pc.sens >= 20 && rand(3) == 0 && changes < changeLimit) {
				//output("\n\nWoah, what the... you pinch your " + pc.skinFurScales() + " to confirm your suspicions; the ghostly snack has definitely lowered your sensitivity.", false);
				//dynStats("sen", -2);
				//if (pc.sens >= 75) dynStats("sen", -2);
				//changes++;
			//}
			//Effect script 3:  (higher libido)
			if (pc.libido() < pc.libidoMax() && rand(3) == 0 && changes < changeLimit) {
				//([if libido >49]
				if (pc.libido() < 50) output("\n\nIdly, you drop a hand to your crotch as");
				else output("\n\nWith a substantial amount of effort, you resist the urge to stroke yourself as");
				output(" a trace amount of the ghost girl's lust is transferred into you.  How horny IS she, you have to wonder...");
				pc.slowStatGain("l", 1);
				if (pc.libido() < 50) pc.slowStatGain("l", 1);
				changes++;
			}
			//Effect script a:  (human wang)
			if (pc.hasCock() && changes < changeLimit && rand(3) == 0 && pc.cockTotal() > pc.cockTotal(GLOBAL.TYPE_HUMAN)) {
				var x:int = 0;
				for (x = 0; x < pc.cockTotal() && !(pc.cocks[x].cType == GLOBAL.TYPE_HUMAN || pc.cockTypeUnlocked(x, GLOBAL.TYPE_HUMAN)); x++) { }
				if (x >= pc.cockTotal()) {
					output("\n\n" + pc.cockTypeLockedMessage());
				}
				else
				{
					output("\n\nA strange tingling begins behind your " + pc.cockDescript(x) + ", slowly crawling up across its entire length.  While neither particularly arousing nor uncomfortable, you do shift nervously as the feeling intensifies.  You resist the urge to undo your [pc.gear] to check, but by the feel of it, your penis is shifting form.  Eventually the transformative sensation fades, <b>leaving you with a completely human penis.</b>");
					pc.shiftCock(x, GLOBAL.TYPE_HUMAN);
					changes++;
				}
			}
			//Appearnace Change
			//Hair
			if (rand(4) == 0 && changes < changeLimit && pc.hairType != GLOBAL.HAIR_TYPE_TRANSPARENT && Mutator.changeHair(pc, GLOBAL.HAIR_TYPE_TRANSPARENT)) changes++;
			
			var skinColors:/*String*/Array = ["sable", "albino"]
			//Skin
			if (rand(4) == 0 && changes < changeLimit && (!InCollection(pc.skinTone, skinColors) || pc.skinType != GLOBAL.SKIN_TYPE_SKIN)) {
				var newColor:String = RandomInCollection(skinColors);
				if (pc.skinType != GLOBAL.SKIN_TYPE_SKIN && !pc.skinTypeUnlocked(GLOBAL.SKIN_TYPE_SKIN)) {
					output("\n\n" + pc.skinTypeLockedMessage());
				}
				else if (!InCollection(pc.skinTone, skinColors) && !pc.skinToneUnlocked(newColor)) {
					output("\n\n" + pc.skinToneLockedMessage());
				}
				else if (newColor == "albino") {
					output("\n\nA warmth begins in your belly, slowly spreading through your torso and appendages. The heat builds, becoming uncomfortable, then painful, then nearly unbearable. Your eyes unfocus from the pain, and by the time the burning sensation fades, you can already tell something's changed. You raise a hand, staring at the milky-white flesh. Your eyes are drawn to the veins in the back of your hand, darkening to a jet black as you watch. <b>You have white skin, with black veins!</b>");
					pc.skinTone = "albino";
					pc.skinType = GLOBAL.SKIN_TYPE_SKIN;
					pc.clearSkinFlags();
					changes++;
				}
				else {
					output("\n\nA warmth begins in your belly, slowly spreading through your torso and appendages. The heat builds, becoming uncomfortable, then painful, then nearly unbearable. Your eyes unfocus from the pain, and by the time the burning sensation fades, you can already tell something's changed. You raise a hand, staring at the sable flesh. Your eyes are drawn to the veins in the back of your hand, brightening to an ashen tone as you watch.  <b>You have black skin, with white veins!</b>");
					pc.skinTone = "sable";
					pc.skinType = GLOBAL.SKIN_TYPE_SKIN;
					pc.clearSkinFlags();
					changes++;
				}
			}
			//Legs
			if (changes < changeLimit && !pc.hasPerk("Incorporeality") && InCollection(pc.skinTone, skinColors) && pc.hairType == GLOBAL.HAIR_TYPE_TRANSPARENT) {
				//(ghost-legs!  Absolutely no problem with regular encounters, though! [if you somehow got this with a centaur it'd probably do nothing cuz you're not supposed to be a centaur with ectoplasm ya dingus])
				output("\n\nAn otherworldly sensation begins in your belly, working its way to your " + pc.hipDescript() + ". Before you can react, your " + pc.legs() + " begin to tingle, and you fall on your rump as a large shudder runs through them. As you watch, your [pc.lowerBody] shimmers, becoming ethereal, wisps rising from the newly ghost-like " + pc.legs() + ". You manage to rise, surprised to find your new, ghostly form to be as sturdy as its former corporeal version. Suddenly, like a dam breaking, fleeting visions and images flow into your head, never lasting long enough for you to concentrate on one. You don't even realize it, but your arms fly up to your head, grasping your temples as you groan in pain. As fast as the mental bombardment came, it disappears, leaving you with a surprising sense of spiritual superiority.  <b>You have ghost [pc.lowerBody]!</b>\n\n");
				output("<b>(Gained Perk:  Incorporeality</b>)");
				pc.createPerk("Incorporeality", 0, 0, 0, 0, "Allows you to fade into a ghost-like state and temporarily possess others.");
				changes++;
			}
			//Effect Script 8: 100% chance of healing
			if (changes == 0) {
				output("\n\nYou feel strangely refreshed, as if you just gobbled down a bottle of sunshine.  A smile graces your lips as vitality fills you.  ");
				pc.HP(pc.level * 5 + 10);
				changes++;
			}
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}
