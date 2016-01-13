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
	
    public class CoCNeonPinkEgg extends ItemSlotClass
    {
        public function CoCNeonPinkEgg(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "NPnkEgg";
            //Regular name
            this.longName = "neon pink egg";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a neon pink egg";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This is an oblong egg with an unnatural neon pink coloration.  It tingles in your hand with odd energies that make you feel as if you could jump straight into the sky.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			useNeonPinkEgg(pc);
			return false;
		}
        
        public static function useNeonPinkEgg(pc:Creature, pregnantChange:Boolean = false):void
        {			
			var changes:Number = 0;
			var changeLimit:Number = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(2) == 0) changeLimit++;
			if (pc.hasPerk("History: Alchemist")) changeLimit++;
			if (pc.hasPerk("Transformation Resistance")) changeLimit--;
			//If this is a pregnancy change, only 1 change per proc.
			if (pregnantChange) changeLimit = 1;
			else clearOutput();
			//If not pregnancy, mention eating it.
			if (!pregnantChange) output("You eat the neon pink egg, and to your delight it tastes sweet, like candy.  In seconds you've gobbled down the entire thing, and you lick your fingers clean before you realize you ate the shell – and it still tasted like candy.");
			//If pregnancy, warning!
			if (pregnantChange) {
				output("\n<b>Your egg-stuffed ");
				//if (pc.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
					output("womb ");
					//if (pc.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) output("and ");
				//}
				//if (pc.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) output("backdoor ");
				//if (pc.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY && pc.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) output("rumble");
				//else 
				output("rumbles");
				output(" oddly, and you have a hunch that something's about to change</b>.");
			}
			//STATS CHANGURYUUUUU
			//Boost speed (max 80!)
			if (changes < changeLimit && rand(3) == 0 && pc.RQ() < 80) {
				if (pc.RQ() < 30) output("\n\nTingles run through your muscles, and your next few movements seem unexpectedly fast.  The egg somehow made you faster!");
				else if (pc.RQ() < 50) output("\n\nYou feel tingles running through your body, and after a moment, it's clear that you're getting faster.");
				else if (pc.RQ() < 65) output("\n\nThe tight, ready feeling you've grown accustomed to seems to intensify, and you know in the back of your mind that you've become even faster.");
				else output("\n\nSomething changes in your physique, and you grunt, chopping an arm through the air experimentally.  You seem to move even faster than before, confirming your suspicions.");
				changes++;
				pc.slowStatGain("r", 2);
			}
			//Boost libido
			if (changes < changeLimit && rand(5) == 0) {
				changes++;
				pc.slowStatGain("l", 4)
				pc.lust(5 + pc.libido() / 7);
				//Lower ones are gender specific for some reason
				if (pc.libido() < 60) {
					//(Cunts or assholes!
					if (!pc.hasCock() || (pc.isHerm() && rand(2) == 0)) {
						if (pc.libido() < 30) {
							output("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (pc.cor() < 25) output("You're repulsed by such shameful thoughts.");
							else if (pc.cor() < 60) output("You worry that this place is really getting to you.");
							else if (pc.cor() < 90) output("You pant a little and wonder where the nearest fertile male is.");
							else output("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else output("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your [pc.vagOrAss], and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (pc.hasCock()) {
						if (pc.libido() < 30) {
							output("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) == 0) output("female hare until she's immobilized by all her eggs");
							else output("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							output(". ");
							if (pc.cor() < 25) output("You're repulsed by such shameful thoughts.");
							else if (pc.cor() < 50) output("You worry that this place is really getting to you.");
							else if (pc.cor() < 75) output("You pant a little and wonder where the nearest fertile female is.");
							else output("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else output("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to [pc.eachCock], and you groan from how tight and hard it feels.  The desire to squeeze it, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (pc.libido() < 80) {
					output("\n\nYou fan your neck and start to pant as your " + pc.skinTone + " skin begins to flush red with heat");
					if (pc.skinType != GLOBAL.SKIN_TYPE_SKIN) output(" through your " + pc.skinFurScales());
					output(".  ");
					if (pc.hasCock() && !pc.isHerm()) output("Compression tightens down on [pc.eachCock] as it strains against your [pc.gear].  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (!pc.hasGenitals()) output("Sexual hunger seems to gnaw at your [pc.asshole], demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (pc.hasVagina() && !pc.isHerm()) output("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else output("Steamy moisture and tight compression war for your awareness in your groin as [pc.eachCock] starts to strain against your [pc.gear].  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					output("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (pc.cor() < 33) output("You sigh, trying not to give in completely.");
					else if (pc.cor() < 66) output("You pant and groan, not sure how long you'll even want to resist.");
					else {
						output("You smile and wonder if you can ");
						if (pc.libido() < 100) output("get your libido even higher.");
						else output("find someone to fuck right now.");
					}
				}
			}
			//BIG sensitivity gains to 60.
			//if (pc.sens < 60 && changes < changeLimit && rand(3) == 0) {
				//changes++;
				//output("\n\n", false);
				////(low)
				//if (rand(3) != 2) {
					//output("The feeling of small breezes blowing over your " + pc.skinDesc + " gets a little bit stronger.  How strange.  You pinch yourself and nearly jump when it hurts a tad more than you'd think. You've gotten more sensitive!", false);
					//dynStats("sen", 5);
				//}
				////(BIG boost 1/3 chance)
				//else {
					//dynStats("sen", 15);
					//output("Every movement of your body seems to bring heightened waves of sensation that make you woozy.  Your [pc.gear] rubs your [pc.nipples] deliciously", false);
					//if (pc.hasFuckableNipples()) {
						//output(", sticking to the ", false);
						//if (pc.biggestLactation() > 2) output("milk-leaking nipple-twats", false);
						//else output("slippery nipple-twats", false);
					//}
					//else if (pc.biggestLactation() > 2) output(", sliding over the milk-leaking teats with ease", false);
					//else output(" catching on each of the hard nubs repeatedly", false);
					//output(".  Meanwhile, your crotch... your crotch is filled with such heavenly sensations from ", false);
					//if (pc.gender == 1) {
						//output(sMultiCockDesc() + " and your ", false);
						//if (pc.balls > 0) output(ballsDescriptLight(), false);
						//else output(assholeDescript(), false);
					//}
					//else if (pc.gender == 2) output("your [pc.vagina] and " + clitDescript(), false);
					//else if (pc.gender == 3) {
						//output(sMultiCockDesc() + ", ", false);
						//if (pc.balls > 0) output(ballsDescriptLight() + ", ", false);
						//output(vaginaDescript(0) + ", and " + clitDescript(), false);
					//}
					////oh god genderless
					//else output("you " + assholeDescript(), false);
					//output(" that you have to stay stock-still to keep yourself from falling down and masturbating on the spot.  Thankfully the orgy of tactile bliss fades after a minute, but you still feel way more sensitive than your previous norm.  This will take some getting used to!", false);
				//}
			//}
			//Makes girls very girl(90), guys somewhat girly (61).
			if (changes < changeLimit && rand(2) == 0 && pc.femininity < (pc.hasVagina() ? pc.femininityMax() : 61)) {
				output(pc.modFem(4));
				changes++;
			}

			//De-wettification of cunt (down to 3?)!
			if (pc.wetness() > 3 && changes < changeLimit && rand(3) == 0) {
				//Just to be safe
				if (pc.hasVagina()) {
					output("\n\nThe constant flow of fluids that sluice from your [pc.vagina] slow down, leaving you feeling a bit less like a sexual slip-'n-slide.");
					pc.vaginas[0].wetness(-1);
					changes++;
				}
			}
			//Fertility boost!
			if (changes < changeLimit && rand(4) == 0 && pc.fertilityRaw < 2 && pc.hasVagina()) {
				pc.fertilityRaw += (2 + rand(5)) * 0.01;
				changes++;
				output("\n\nYou feel strange.  Fertile... somehow.  You don't know how else to think of it, but you know your body is just aching to be pregnant and give birth.");
			}
			//-VAGs
			//if (pc.hasVagina() && pc.findPerk(PerkLib.BunnyEggs) < 0 && changes < changeLimit && rand(4) == 0 && pc.bunnyScore() > 3) {
				//output("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly.  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n\n", false);
				//output("(<b>Perk Gained: Bunny Eggs</b>)", false);
				//pc.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
				//changes++;
			//}
			//Shrink Balls!
			if (pc.balls > 0 && pc.ballSizeRaw > 5 && rand(3) == 0 && changes < changeLimit) {
				if (pc.ballSizeRaw < 10) {
					output("\n\nRelief washes through your groin as your [pc.balls] lose about an inch of their diameter.");
					pc.ballSizeRaw--;
				}
				else if (pc.ballSizeRaw < 25) {
					output("\n\nRelief washes through your groin as your [pc.balls] lose a few inches of their diameter.  Wow, it feels so much easier to move!");
					pc.ballSizeRaw -= (2 + rand(3));
				}
				else {
					output("\n\nRelief washes through your groin as your [pc.balls] lose at least six inches of diameter.  Wow, it feels SOOOO much easier to move!");
					pc.ballSizeRaw -= (6 + rand(3));
				}
				changes++;
			}
			//Get rid of extra balls
			if (pc.balls > 2 && changes < changeLimit && rand(3) == 0) {
				changes++;
				output("\n\nThere's a tightening in your [pc.sack] that only gets higher and higher until you're doubled over and wheezing.  When it passes, you reach down and discover that <b>one of your testicles is gone.</b>");
				pc.balls--;
			}
			//Boost cum production
			if ((pc.balls > 0 || pc.hasCock()) && pc.cumMultiplierRaw < 10 && rand(3) == 0 && changeLimit > 1) {
				changes++;
				pc.cumMultiplierRaw += (3 + rand(7)) * 0.01;
				if (pc.cumQ() >= 250) pc.lust(3);
				if (pc.cumQ() >= 750) pc.lust(4);
				if (pc.cumQ() >= 2000) pc.lust(5);
				//Balls
				if (pc.balls > 0) {
					//(Small cum quantity) < 50
					if (pc.cumQ() < 50) output("\n\nA twinge of discomfort runs through your [pc.balls], but quickly vanishes.  You heft your orbs but they haven't changed in size – they just feel a little bit denser.");
					//(medium cum quantity) < 250
					else if (pc.cumQ() < 250) {
						output("\n\nA ripple of discomfort runs through your [pc.balls], but it fades into a pleasant tingling.  You reach down to heft the orbs experimentally but they don't seem any larger.");
						if (pc.hasCock()) output("  In the process, you brush [pc.eachCock] and discover a bead of pre leaking at the tip.");
					}
					//(large cum quantity) < 750
					else if (pc.cumQ() < 750) {
						output("\n\nA strong contraction passes through your [pc.sack], almost painful in its intensity.  ");
						if (pc.hasCock()) output("[pc.EachCock] leaks and dribbles pre-cum down your " + pc.legs() + " as your body's cum production kicks up even higher.");
						else output("You wince, feeling pent up and yet unable to release.  You really wish you had a cock right about now.");
					}
					//(XL cum quantity) < 2000
					else if (pc.cumQ() < 2000) {
						output("\n\nAn orgasmic contraction wracks your [pc.balls], shivering through the potent orbs and passing as quickly as it came.  ");
						if (pc.hasCock()) output("A thick trail of slime leaks from [pc.eachCock] down your " + pc.leg() + ", pooling below you.");
						else output("You grunt, feeling terribly pent-up and needing to release.  Maybe you should get a penis to go with these balls...");
						output("  It's quite obvious that your cum production has gone up again.", false);
					}
					//(XXL cum quantity)
					else {
						output("\n\nA body-wrenching contraction thrums through your [pc.balls], bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  ");
						if (pc.hasCock()) output("pre-cum explodes from [pc.eachCock], running down your " + pc.leg() + " and splattering into puddles that would shame the orgasms of lesser " + pc.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
						else output("You pant and groan but the pleasure just turns to pain.  You're so backed up – if only you had some way to vent all your seed!");
					}
				}
				//NO BALLZ (guaranteed cock tho)
				else {
					//(Small cum quantity) < 50
					if (pc.cumQ() < 50) output("\n\nA twinge of discomfort runs through your body, but passes before you have any chance to figure out exactly what it did.");
					//(Medium cum quantity) < 250)
					else if (pc.cumQ() < 250) output("\n\nA ripple of discomfort runs through your body, but it fades into a pleasant tingling that rushes down to [pc.eachCock].  You reach down to heft yourself experimentally and smile when you see pre-beading from your maleness.  Your cum production has increased!");
					//(large cum quantity) < 750
					else if (pc.cumQ() < 750) output("\n\nA strong contraction passes through your body, almost painful in its intensity.  [pc.eachCock] leaks and dribbles pre-cum down your " + pc.legs() + " as your body's cum production kicks up even higher!  Wow, it feels kind of... good.", false);
					//(XL cum quantity) < 2000
					else if (pc.cumQ() < 2000) output("\n\nAn orgasmic contraction wracks your abdomen, shivering through your midsection and down towards your groin.  A thick trail of slime leaks from [pc.eachCock]  and trails down your " + pc.leg() + ", pooling below you.  It's quite obvious that your body is producing even more cum now.", false);
					//(XXL cum quantity)
					else output("\n\nA body-wrenching contraction thrums through your gut, bringing with it the orgasmic feeling of your body kicking into cum-production overdrive.  pre-cum explodes from [pc.eachCock], running down your " + pc.legs() + " and splattering into puddles that would shame the orgasms of lesser " + pc.mf("males", "persons") + ".  You rub yourself a few times, nearly starting to masturbate on the spot, but you control yourself and refrain for now.");
				}
			}
			
			//Bunny feet! - requirez earz
			if (pc.legType != GLOBAL.TYPE_LAPINE && changes < changeLimit && rand(5) == 0 && pc.earType == GLOBAL.TYPE_LAPINE && Mutator.changeLegs(pc, GLOBAL.TYPE_LAPINE, 2, [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_PAWS, GLOBAL.FLAG_FURRED])) changes++;
			//BUN FACE!  REQUIREZ EARZ
			if (pc.earType == GLOBAL.TYPE_LAPINE && pc.faceType != GLOBAL.TYPE_LAPINE && rand(3) == 0 && changes < changeLimit && Mutator.changeFace(pc, GLOBAL.TYPE_LAPINE)) changes++;
			//DAH BUNBUN EARZ - requires poofbutt!
			if (pc.earType != GLOBAL.TYPE_LAPINE && changes < changeLimit && rand(3) == 0 && pc.hasTail(GLOBAL.TYPE_LAPINE) && Mutator.changeEars(pc, GLOBAL.TYPE_LAPINE)) changes++;
			//DAH BUNBUNTAILZ
			if (!pc.hasTail(GLOBAL.TYPE_LAPINE) && rand(2) == 0 && changes < changeLimit && Mutator.changeTail(pc, GLOBAL.TYPE_LAPINE, 1, [GLOBAL.FLAG_FURRED])) changes++;
			
			if (rand(4) == 0 && pc.gills && changes < changeLimit) {
				output("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.", false);
				pc.gills = false;
				changes++;
			}
			//Bunny Breeder Perk?
			//FAILSAAAAFE
			if (changes == 0) {
				if (pc.libido() < 100) changes++;
				pc.slowStatGain("l", 4);
				pc.lust(5 + pc.libido() / 7);
				//Lower ones are gender specific for some reason
				if (pc.libido() < 60) {
					//(Cunts or assholes!
					if (!pc.hasCock() || (pc.isHerm() && rand(2) == 0)) {
						if (pc.libido() < 30) {
							output("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to breed until you're swollen and pregnant.  ");
							if (pc.cor() < 25) output("You're repulsed by such shameful thoughts.");
							else if (pc.cor() < 60) output("You worry that this place is really getting to you.");
							else if (pc.cor() < 90) output("You pant a little and wonder where the nearest fertile male is.");
							else output("You grunt and groan with desire and disappointment.  You should get bred soon!");
						}
						else output("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to your [pc.vagorAss], and you're struck by just how empty it feels.  The desire to be filled, not by a hand or a finger but by a virile male, rolls through you like a wave, steadily increasing your desire for sex.");
					}
					//WANGS!
					if (pc.hasCock()) {
						if (pc.libido() < 30) {
							output("\n\nYou squirm a little and find your eyes glancing down to your groin.  Strange thoughts jump to mind, wondering how it would feel to fuck a ");
							if (rand(2) == 0) output("female hare until she's immobilized by all her eggs");
							else output("herm rabbit until her sack is so swollen that she's forced to masturbate over and over again just to regain mobility");
							output(". ", false);
							if (pc.cor() < 25) output("You're repulsed by such shameful thoughts.");
							else if (pc.cor() < 50) output("You worry that this place is really getting to you.");
							else if (pc.cor() < 75) output("You pant a little and wonder where the nearest fertile female is.");
							else output("You grunt and groan with desire and disappointment.  Gods you need to fuck!");
						}
						else output("\n\nYour mouth rolls open as you start to pant with desire.  Did it get hotter?  Your hand reaches down to [pc.eachCock], and you groan from how tight and hard it feels.  The desire to have it squeezed, not with your hand but with a tight pussy or puckered asshole, runs through you like a wave, steadily increasing your desire for sex.");
					}
				}
				//Libido over 60? FUCK YEAH!
				else if (pc.libido() < 80) {
					output("\n\nYou fan your neck and start to pant as your " + pc.skinTone + " skin begins to flush red with heat");
					if (pc.skinType != GLOBAL.SKIN_TYPE_SKIN) output(" through your " + pc.skinFurScales());
					output(".  ");
					if (pc.hasCock() && !pc.isHerm()) output("Compression tightens down on [pc.eachCock] as it strains against your [pc.gear].  You struggle to fight down your heightened libido, but it's hard – so very hard.");
					else if (!pc.hasGenitals()) output("Sexual hunger seems to gnaw at your [pc.asshole], demanding it be filled, but you try to resist your heightened libido.  It's so very, very hard.");
					else if (pc.hasVagina() && !pc.isHerm()) output("Moisture grows between your rapidly-engorging vulva, making you squish and squirm as you try to fight down your heightened libido, but it's hard – so very hard.");
					else output("Steamy moisture and tight compression war for your awareness in your groin as [pc.eachCock] starts to strain against your [pc.gear].  Your vulva engorges with blood, growing slicker and wetter.  You try so hard to fight down your heightened libido, but it's so very, very hard.  The urge to breed lingers in your mind, threatening to rear its ugly head.");
				}
				//MEGALIBIDO
				else {
					output("\n\nDelicious, unquenchable desire rises higher and higher inside you, until you're having trouble tamping it down all the time.  A little, nagging voice questions why you would ever want to tamp it down.  It feels so good to give in and breed that you nearly cave to the delicious idea on the spot.  Life is beginning to look increasingly like constant fucking or masturbating in a lust-induced haze, and you're having a harder and harder time finding fault with it.  ");
					if (pc.cor() < 33) output("You sigh, trying not to give in completely.");
					else if (pc.cor() < 66) output("You pant and groan, not sure how long you'll even want to resist.");
					else {
						output("You smile and wonder if you can ");
						if (pc.libido() < 100) output("get your libido even higher.");
						else output("find someone to fuck right now.");
					}
				}
			}
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
		}
	}	
}
