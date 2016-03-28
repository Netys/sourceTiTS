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
	
    public class CoCSweetGossamer extends ItemSlotClass
    {
        public function CoCSweetGossamer(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "S.Gossr";
            //Regular name
            this.longName = "bundle of pink, gossamer webbing";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a bundle of pink, gossamer webbing";
            //Displayed on tooltips during mouseovers
            this.tooltip = "These strands of gooey pink gossamer seem quite unlike the normal silk that spider-morphs produce.  It smells sweet and is clearly edible, but who knows what it might do to you?";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			Gossamer(pc, false);
			return false;
		}
		
		public static function Gossamer(pc:Creature, black:Boolean):void
		{
			clearOutput();
			
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//Consuming Text
			if (!black) output("You wad up the sweet, pink gossamer and eat it, finding it to be delicious and chewy, almost like gum.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");
			else if (black) output("You wad up the sweet, black gossamer and eat it, finding it to be delicious and chewy, almost like licorice.  Munching away, your mouth generates an enormous amount of spit until you're drooling all over yourself while you devour the sweet treat.");

			//*************
			//Stat Changes
			//*************
			//(If speed<70, increases speed)
			if (pc.RQ() < 70 && changes < changeLimit && rand(3) == 0) {
				output("\n\nYour reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air.  A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire.  Why would you ever want to do something like that?");
				pc.slowStatGain("r", 1.5);
				changes++;
			}
			//(If speed>80, decreases speed down to minimum of 80)
			if (pc.RQ() > 80 && changes < changeLimit && rand(3) == 0) {
				output("\n\nYou feel like resting high in the trees and waiting for your unsuspecting prey to wander below so you can take them without having to exert yourself.  What an odd thought!");
				pc.slowStatGain("r", -1.5);
				changes++;
			}
			//(increases sensitivity)
			//if (changes < changeLimit && rand(3) == 0) {
				//output("\n\nThe hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on.", false);
				//dynStats("sen", 1);
				//changes++;
			//}
			//(Increase libido)
			if (changes < changeLimit && rand(3) == 0) {
				output("\n\nYou suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth.  You wish there had been more.");
				pc.slowStatGain("l", 1);
				changes++;
			}
			//(increase toughness to 60)
			//if (changes < changeLimit && rand(3) == 0 && pc.tou < 60) {
				//output("\n\nStretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs.  How strange.  You probe at yourself, and while your " + pc.skinFurScales() + " doesn't feel much different, the underlying flesh does seem tougher.", false);
				//dynStats("tou", 1);
				//changes++;
			//}
			//(decrease strength to 70)
			if (pc.PQ() > 70 && rand(3) == 0) {
				output("\n\nLethargy rolls through you while you burp noisily.  You rub at your muscles and sigh, wondering why you need to be strong when you could just sew up a nice sticky web to catch your enemies.  ");
				if (!(pc.hasTail(GLOBAL.TYPE_ARACHNID) || pc.hasTail(GLOBAL.TYPE_DRIDER))) output("Wait, you're not a spider, that doesn't make any sense!");
				else output("Well, maybe you should put your nice, heavy abdomen to work.");
				pc.slowStatGain("p", -1);
				changes++;
			}
			//****************
			//Sexual Changes
			//****************
			//Increase venom recharge
			if ((pc.hasTail(GLOBAL.TYPE_ARACHNID) || pc.hasTail(GLOBAL.TYPE_DRIDER)) && pc.tailRecharge < 25 && changes < changeLimit) {
				changes++;
				output("\n\nThe spinnerets on your abdomen twitch and drip a little webbing.  The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.");
				pc.tailRecharge += 5;
			}
			//(tightens vagina to 1, increases lust/libido)
			if (pc.hasVagina()) {
				if (pc.looseness() > 1 && changes < changeLimit && rand(3) == 0) {
					output("\n\nWith a gasp, you feel your [pc.vagina] tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your [pc.vagina] excitedly. You can't wait to try this out!");
					pc.slowStatGain("l", 2);
					pc.lust(25);
					changes++;
					pc.vaginas[0].looseness(-1);
				}
			}
			//(tightens asshole to 1, increases lust)
			if (pc.ass.looseness() > 1 && changes < changeLimit && rand(3) == 0) {
				output("\n\nYou let out a small cry as your [pc.asshole] shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.");
				pc.slowStatGain("l", 2);
				pc.lust(25);
				changes++;
				pc.ass.looseness(-1);
			}
			//[Requires penises]
			//(Thickens all cocks to a ratio of 1\" thickness per 5.5\"
			//if (pc.hasCock() && changes < changeLimit && rand(4) == 0) {
				////Use temp to see if any dicks can be thickened
				//temp = 0;
				//counter = 0;
				//while (counter < pc.cockTotal()) {
					//if (pc.cocks[counter].cockThickness * 5.5 < pc.cocks[counter].cLength()) {
						//pc.cocks[counter].cockThickness += .1;
						//temp = 1;
					//}
					//counter++;
				//}
				////If something got thickened
				//if (temp == 1) {
					//output("\n\nYou can feel your [pc.cocksLight] filling out in your [pc.gear]. Pulling ", false);
					//if (pc.cockTotal() == 1) output("it", false);
					//else output("them", false);
					//output(" out, you look closely.  ", false);
					//if (pc.cockTotal() == 1) output("It's", false);
					//else output("They're", false);
					//output(" definitely thicker.", false);
					//var counter:Number;
					//changes++;
				//}
			//}
			//[Increase to Breast Size] - up to Large DD
			if (changes < changeLimit && rand(4) == 0 && Mutator.growTits(pc, 1, 1, true, 3, 6)) changes++;
			//[Increase to Ass Size] - to 11
			if (pc.buttRating() < 11 && changes < changeLimit && rand(4) == 0) {
				output("\n\nYou look over your shoulder at your [pc.ass] only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!");
				pc.buttRating(1);
				changes++;
			}
			//***************
			//Appearance Changes
			//***************
			//(Ears become pointed if not human)
			if (rand(4) == 0 && changes < changeLimit && Mutator.changeEars(pc, GLOBAL.TYPE_DRIDER)) changes++;
			//(Fur/Scales fall out)
			if (pc.earType == GLOBAL.TYPE_DRIDER && rand(4) == 0 && changes < changeLimit && Mutator.changeSkin(pc, GLOBAL.SKIN_TYPE_SKIN, ["pale white"])) changes++;
			//(Gain human face)
			if (pc.skinType == GLOBAL.SKIN_TYPE_SKIN && changes < changeLimit && rand(4) == 0 && Mutator.changeFace(pc, GLOBAL.TYPE_HUMAN)) changes++;
			//-Remove breast rows over 2.
			if (changes < changeLimit && pc.bRows() > 2 && rand(3) == 0) {
				changes++;
				output("\n\nYou stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + pc.breastDescript(pc.breastRows.length - 1) + " shrink down, disappearing completely into your ");
				if (pc.bRows() >= 3) output("abdomen");
				else output("chest");
				output(". The " + pc.nipplesDescript(pc.breastRows.length - 1) + " even fade until nothing but [pc.skinFurScales] remains. <b>You've lost a row of breasts!</b>");
				//dynStats("sen", -5);
				pc.removeBreastRow(pc.breastRows.length - 1, 1);
			}
			//-Nipples reduction to 1 per tit.
			if (pc.nipplesPerBreast > 1 && changes < changeLimit && rand(4) == 0) {
				output("\n\nA chill runs over your [pc.fullChest] and vanishes.  You stick a hand under your [pc.gear] and discover that your extra nipples are missing!  You're down to just one per ");
				if (pc.biggestTitSize() < 1) output("'breast'.");
				else output("breast.");
				changes++;
				pc.nipplesPerBreast = 1;
			}
			//Nipples Turn Black:
			if (pc.nippleColor != "black" && rand(6) == 0 && changes < changeLimit) {
				output("\n\nA tickling sensation plucks at your nipples and you cringe, trying not to giggle.  Looking down you are in time to see the last spot of flesh tone disappear from your [pc.nipples].  They have turned an onyx black!");
				pc.nippleColor = "black";
				changes++;
			}
			//eyes!
			if (pc.skinType == GLOBAL.SKIN_TYPE_SKIN && pc.faceType == GLOBAL.TYPE_HUMAN && rand(4) == 0 && changes < changeLimit && Mutator.changeEyes(pc, GLOBAL.TYPE_ARACHNID)) {
				pc.slowStatGain("a", 5); // int originally, but...
				changes++;
			}
			//(Gain spider fangs)
			//if (pc.faceType == FACE_HUMAN && pc.skinType == SKIN_TYPE_PLAIN && changes < changeLimit && rand(4) == 0) {
				//output("\n\nTension builds within your upper gum, just above your canines.  You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth.  It slides down while you're touching it, lengthening into a needle-like fang.  You check the other side and confirm your suspicions.  <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>", false);
				//pc.faceType = FACE_SPIDER_FANGS;
				//changes++;
			//}
			//(Arms to carapace-covered arms)
			if (changes < changeLimit && rand(4) == 0 && Mutator.changeArms(pc, GLOBAL.TYPE_ARACHNID, [GLOBAL.FLAG_CHITINOUS])) changes++;
			//Drider butt
			//if (black && pc.findPerk(PerkLib.SpiderOvipositor) < 0 && pc.isDrider() && pc.tailType == TAIL_TYPE_SPIDER_ADBOMEN && changes < changeLimit && rand(3) == 0 && (pc.hasVagina() || rand(2) == 0)) {
				//output("\n\nAn odd swelling sensation floods your spider half.  Curling your abdomen underneath you for a better look, you gasp in recognition at your new 'equipment'!  Your semi-violent run-ins with the swamp's population have left you <i>intimately</i> familiar with the new appendage.  <b>It's a drider ovipositor!</b>  A few light prods confirm that it's just as sensitive as any of your other sexual organs.  You idly wonder what laying eggs with this thing will feel like...");
				//output("\n\n(<b>Perk Gained:  Spider Ovipositor - Allows you to lay eggs in your foes!</b>)");
				////V1 - Egg Count
				////V2 - Fertilized Count
				//pc.createPerk(PerkLib.SpiderOvipositor, 0, 0, 0, 0);
				////Opens up drider ovipositor scenes from available mobs. The character begins producing unfertilized eggs in their arachnid abdomen. Egg buildup raises minimum lust and eventually lowers speed until the player has gotten rid of them.  This perk may only be used with the drider lower body, so your scenes should reflect that.
				////Any PC can get an Ovipositor perk, but it will be much rarer for characters without vaginas.
				////Eggs are unfertilized by default, but can be fertilized:
				////-female/herm characters can fertilize them by taking in semen; successfully passing a pregnancy check will convert one level ofunfertilized eggs to fertilized, even if the PC is already pregnant.
				////-male/herm characters will have a sex dream if they reach stage three of unfertilized eggs; this will represent their bee/drider parts drawing their own semen from their body to fertilize the eggs, and is accompanied by a nocturnal emission.
				////-unsexed characters cannot currently fertilize their eggs.
				////Even while unfertilized, eggs can be deposited inside NPCs - obviously, unfertilized eggs will never hatch and cannot lead to any egg-birth scenes that may be written later.
				//changes++;
			//}
			
			if (black && changes < changeLimit && pc.legType == GLOBAL.TYPE_DRIDER && rand(4) == 0 && Mutator.changeTail(pc, GLOBAL.TYPE_DRIDER, 1, [GLOBAL.FLAG_CHITINOUS, GLOBAL.FLAG_SMOOTH])) changes++;
			if (black && changes < changeLimit && !pc.hasTail(GLOBAL.TYPE_DRIDER) && (pc.legType == GLOBAL.TYPE_ARACHNID || pc.legType == GLOBAL.TYPE_DRIDER) && pc.armType == GLOBAL.TYPE_ARACHNID && rand(4) == 0 && Mutator.changeTail(pc, GLOBAL.TYPE_ARACHNID, 1, [GLOBAL.FLAG_CHITINOUS, GLOBAL.FLAG_SMOOTH])) changes++;
			
			// (Drider Item Only: Drider Legs), requires abdomen
			if (black && (pc.hasTail(GLOBAL.TYPE_ARACHNID) || pc.hasTail(GLOBAL.TYPE_DRIDER)) && changes < changeLimit && rand(4) == 0 && Mutator.changeLegs(pc, GLOBAL.TYPE_DRIDER, [4, 8, 8, 2], [GLOBAL.FLAG_CHITINOUS])) changes++;
			
			// Carapace-Clad Legs
			if (!black && changes < changeLimit && rand(4) == 0 && Mutator.changeLegs(pc, GLOBAL.TYPE_ARACHNID, 2, [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_CHITINOUS])) changes++;
			if (black && changes < changeLimit && rand(4) == 0 && pc.legType != GLOBAL.TYPE_ARACHNID && pc.legType != GLOBAL.TYPE_DRIDER && Mutator.changeLegs(pc, GLOBAL.TYPE_ARACHNID, 2, [GLOBAL.FLAG_PLANTIGRADE, GLOBAL.FLAG_CHITINOUS])) changes++;
			//(Tail becomes spider abdomen GRANT WEB ATTACK)
			if (!black && changes < changeLimit && pc.legType == GLOBAL.TYPE_ARACHNID && pc.armType == GLOBAL.TYPE_ARACHNID && rand(4) == 0 && Mutator.changeTail(pc, GLOBAL.TYPE_ARACHNID, 1, [GLOBAL.FLAG_CHITINOUS, GLOBAL.FLAG_SMOOTH])) changes++;
			
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
				pc.gills = false;
				changes++;
			}
			if (changes == 0) {
				output("\n\nThe sweet silk energizes you, leaving you feeling refreshed.");
				pc.energy(33);
			}
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}	
}
