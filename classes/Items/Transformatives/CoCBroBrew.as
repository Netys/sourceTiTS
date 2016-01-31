package classes.Items.Transformatives
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	import classes.Util.*;
	
	public class CoCBroBrew extends ItemSlotClass
	{
		public function CoCBroBrew()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.DRUG;
			//Used on inventory buttons
			this.shortName = "BroBrew";
			//Regular name
			this.longName = "can of Bro Brew";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a can of Bro Brew";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This aluminum can is labelled as 'Bro Brew'.  It even has a picture of a muscly, bare-chested man flexing on it.  A small label in the corner displays: \"Demon General's Warning: Bro Brew's effects are as potent (and irreversible) as they are refreshing.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 10000;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.combatUsable = false;
			this.targetsSelf = true;
			
			this.addFlag(GLOBAL.NOT_CONSUMED_BY_DEFAULT);
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			
			if (!(target is PlayerCharacter))
			{
				output(target.capitalA + target.short + " refuses to drink it.");
				return false;
			}
			
			//if (target.hasPerk("Futa Form") || target.hasPerk("Bro Body") || target.isBro()) {
				//output("Ugh.  This stuff is so, like... Maybe you can find someone else to feed it to?");
				//return false;
			//}
			
			this.quantity--; // ugh... where are .consume function?
			if (this.quantity <= 0 && target.inventory.indexOf(this) != -1)
			{
				target.inventory.splice(target.inventory.indexOf(this), 1);
			}
			
			BroBrewEffect(target);
			return false;
		}
		
		public static function BroBrewEffect(target:Creature, display:Boolean = true):void {
			var buffer:String = "";
			
			//no drink for bimbos!
			if (target.hasPerk("Bimbo Body")) {
				buffer += "The stuff hits you like a giant cube, nearly staggering you as it begins to settle.";
				if (target.tallness < 77) {
					target.tallness = 77;
					buffer += ".. Did the ground just get farther away?  You glance down and realize, you're growing!  Like a sped-up flower sprout, you keep on getting taller until finally stopping around... six and a half feet, you assume.  Huh.  You didn't expect that to happen!";
				}
				if (target.tone < 100) { // Intenionally skipped maxTone check - BroBrew can make bodybuilder even from goo!
					buffer += "  A tingling in your arm draws your attention just in time to see your biceps and triceps swell with new-found energy, skin tightening until thick cords of muscle run across the whole appendage.  Your other arm surges forward with identical results.  To compensate, your shoulders and neck widen to bodybuilder-like proportions while your chest and abs tighten to a firm, statuesque physique.  Your [pc.legs] and glutes are the last to go, bulking up to proportions that would make any female martial artist proud.  You feel like you could kick forever with legs this powerful.";
					target.tone = 100;
				}
				buffer += "\n\n";

				//female
				if (!target.hasCock()) {
					buffer += "The beverage isn't done yet, however, and it makes it perfectly clear with a building pleasure in your groin.  You can only cry in ecstasy and loosen the bottoms of your [pc.gear] just in time for a little penis to spring forth.  You watch, enthralled, as blood quickly stiffens the shaft to its full length – then keeps on going!  Before long, you have a quivering 10-inch maleness, just ready to stuff into a welcoming box.";
					target.createCock(10);
					if (target.balls == 0) {
						buffer += "  Right on cue, two cum-laden testicles drop in behind it, their contents swirling and churning.";
						target.balls = 2;
						target.ballSizeRaw = 3 * Math.PI;
					}
					buffer += "\n\n";
				}
				else if (target.balls == 0) {
					buffer += "A swelling begins behind your man-meat, and you're assailed with an incredibly peculiar sensation as two sperm-filled balls drop into a newly-formed scrotum.  Frikkin' sweet!\n\n";
					target.balls = 2;
					target.ballSizeRaw = 3 * Math.PI;
				}
				buffer += "Finally, you feel the transformation skittering to a halt, leaving you to openly roam your new chiseled and sex-ready body.  So what if you can barely form coherent sentences anymore?  A body like this does all the talking you need, you figure!";
				if (target.IQ() > 35) {
					target.intelligence(target.intelligenceMax() * 0.35, true);
				}
				target.slowStatGain("libido", 50);
				buffer += "\n\n";
				if (target.hasPerk("Bimbo Brains")) buffer += "<b>(Lost Perk - Bimbo Brains)\n";
				if (target.hasPerk("Bimbo Body"))  buffer += "<b>(Lost Perk - Bimbo Body)\n";
				
				target.removePerk("Bimbo Body");
				target.removePerk("Bimbo Brains");
				target.createPerk("Futa Faculties", 0, 0, 0, 0, "It's super hard to think about stuff that like, isn't working out or fucking!");
				target.createPerk("Futa Form", 0, 0, 0, 0, "Ensures that your body fits the Futa look (Tits DD+, Dick 8\"+, & Pussy).  Also keeps your lusts burning bright and improves the tease skill.");
				
				buffer += "(Gained Perks - Futa Form, Futa Faculties)</b>";
				if (display) output(buffer);
				return;
			}
			
			//HP restore for bros!
			if (target.hasPerk("Bro Body") || target.hasPerk("Futa Form")) {
				buffer += "You crack open the can and guzzle it in a hurry.  Goddamn, this shit is the best.  As you crush the can against your forehead, you wonder if you can find a six-pack of it somewhere?\n\n";
				target.removeStatusEffect("Sore");
				target.energy(target.energyMax());
				target.HP(target.HPMax());
				if (display) output(buffer);
				return;
			}
			
			buffer += "Well, maybe this will give you the musculature that you need to accomplish your goals.  You pull on the tab at the top and hear the distinctive snap-hiss of venting, carbonating pressure.  A smoky haze wafts from the opened container, smelling of hops and alcohol.  You lift it to your lips, the cold, metallic taste of the can coming to your tongue before the first amber drops of beer roll into your waiting mouth.  It tingles, but it's very, very good.  You feel compelled to finish it as rapidly as possible, and you begin to chug it.  You finish the entire container in seconds.\n\n";

			buffer += "A churning, full sensation wells up in your gut, and without thinking, you open wide to release a massive burp. It rumbles through your chest, startling birds into flight in the distance.  Awesome!  You slam the can into your forehead hard enough to smash the fragile aluminum into a flat, crushed disc.  Damn, you feel stronger already";
			if (target.IQ() > 50) buffer += ", though you're a bit worried by how much you enjoyed the simple, brutish act";
			buffer += ".\n\n";

			//(Tits b' gone)
			if (target.biggestTitSize() >= 1) {
				buffer += "A tingle starts in your [pc.nipples] before the tight buds grow warm, hot even.  ";
				if (target.canLactate()) buffer += "Somehow, you know that the milk you had been producing is gone, reabsorbed by your body.  ";
				buffer += "They pinch in towards your core, shrinking along with your flattening [pc.fullChest].  You shudder and flex in response.  Your chest isn't just shrinking, it's reforming, sculping itself into a massive pair of chiseled pecs.  ";
				if (target.breastRows.length > 1) {
					buffer += "The breasts below vanish entirely.  ";
					while (target.breastRows.length > 1) {
						target.removeBreastRow(target.breastRows.length - 1, 1);
					}
				}
				
				if (!InCollection(target.breastRows[0].nippleType, GLOBAL.NIPPLE_TYPE_NORMAL, GLOBAL.NIPPLE_TYPE_FLAT, GLOBAL.NIPPLE_TYPE_INVERTED)) target.breastRows[0].nippleType = GLOBAL.NIPPLE_TYPE_NORMAL;
				target.breastRows[0].breastRatingRaw = 0;
				target.nippleLengthRatio = 1;
				target.nipplesPerBreast = 1;
				target.milkMultiplier = 0;
				target.milkFullness = 0;
				buffer += "All too soon, your boobs are gone.  Whoa!\n\n";
			}

			buffer += "Starting at your hands, your muscles begin to contract and release, each time getting tighter, stronger, and more importantly - larger.  The oddness travels up your arms, thickens your biceps, and broadens your shoulders.  Soon, your neck and chest are as built as your arms.  You give a few experimental flexes as your abs ";
			if (target.tone >= 70) buffer += "further define themselves";
			else buffer += "become extraordinarily visible";
			if(target.hasLegs()) buffer += ".  The strange, muscle-building changes flow down your [pc.legs], making them just as fit and strong as the rest of you";
			buffer += ".  You curl your arm and kiss your massive, flexing bicep.  You're awesome!\n\n";

			buffer += "Whoah, you're fucking ripped and strong, not at all like the puny weakling you were before.  Yet, you feel oddly wool-headed.  Your thoughts seem to be coming slower and slower, like they're plodding through a marsh.  You grunt in frustration at the realization.  Sure, you're a muscle-bound hunk now, but what good is it if you're as dumb as a box of rocks?  Your muscles flex in the most beautiful way, so you stop and strike a pose, mesmerized by your own appearance.  Fuck thinking, that shit's for losers!\n\n";

			//(has dick less than 10 inches)
			if (target.hasCock()) {
				if (target.cocks[0].cLength() < 10) {
					buffer += "As if on cue, the familiar tingling gathers in your groin, and you dimly remember you have one muscle left to enlarge.  If only you had the intelligence left to realize that your penis is not a muscle.  In any event, your [pc.cock] swells in size, ";
					buffer += "lengthening until it's ten inches long and almost three inches wide.  Fuck, you're hung!  ";
					target.cocks[0].cLength(10, true);
				}
				//Dick already big enough! BALL CHECK!
				if (target.balls > 0) {
					buffer += "Churning audibly, your [pc.sack] sways, but doesn't show any outward sign of change.  Oh well, it's probably just like, getting more endurance or something.";
				}
				else {
					buffer += "Two rounded orbs drop down below, filling out a new, fleshy sac above your [pc.legs].  Sweet!  You can probably cum buckets with balls like these.";
					target.balls = 2;
					target.ballSizeRaw = 3 * Math.PI;
				}
				buffer += "\n\n";
			}
			//(No dick)
			else {
				buffer += "You hear a straining, tearing noise before you realize it's coming from your underwear.  Pulling open your [pc.gear], you gasp in surprise at the [pc.cock] that now lies between your [pc.hips].  It rapidly stiffens to a full, ten inches, and goddamn, it feels fucking good.  You should totally find a warm hole to fuck!";
				if (target.balls == 0) buffer += "  Two rounded orbs drop down below, filling out a new, fleshy sac above your [pc.legs].  Sweet!  You can probably cum buckets with balls like these.";
				buffer += "\n\n";
				target.createCock(12);
				target.shiftCock(0, Mutator.guessCockType(target));
				if (target.balls == 0) {
					target.balls = 2;
					target.ballSizeRaw = 3 * Math.PI;
				}
			}
			//(Pussy b gone)
			if (target.hasVagina()) {
				buffer += "At the same time, your " + target.vaginaDescript() + " burns hot, nearly feeling on fire.  You cuss in a decidedly masculine way for a moment before the pain fades to a dull itch.  Scratching it, you discover your lady-parts are gone.  Only a sensitive patch of skin remains.\n\n";
				target.removeVaginas();
			}
			
			//(below max masculinity)
			if (target.femininity > 0) {
				buffer += "Lastly, the change hits your face.  You can feel your jawbones shifting and sliding around, your skin changing to accommodate your face's new shape.  Once it's finished, you feel your impeccable square jaw and give a wide, easy-going grin.  You look awesome!\n\n";
				target.femininity = 0;
			}
			buffer += "You finish admiring yourself and adjust your [pc.gear] to better fit your new physique.  Maybe there's some bitches around you can fuck.  Hell, as good as you look, you might have other dudes wanting you to fuck them too, no homo.\n\n";
			//max tone.  Thickness + 50
			target.tone = 100; // Intenionally skipped maxTone check - BroBrew can make bodybuilder even from goo!
			Mutator.modThickness(target, 100, 50, false);
			//Bonus cum production!
			
			if (!target.hasPerk("Bro Body")) {
				buffer += "<b>(Bro Body - Perk Gained!)\n";
				target.createPerk("Bro Body", 0, 0, 0, 0, "Grants an ubermasculine body that's sure to impress.");
			}
			if (!target.hasPerk("Bro Brains")) {
				buffer += "(Bro Brains - Perk Gained!)\n";
				target.createPerk("Bro Brains", 0, 0, 0, 0, "Makes thou... thin... fuck, that shit's for nerds.");
				if (target.IQ() > target.intelligenceMax() / 5) {
					target.intelligence(target.intelligenceMax() / 5 + target.intelligenceMax() * target.IQ() / 500);
				}
			}
			
			target.slowStatGain("physique", 33);
			target.slowStatGain("libido", 4);
			target.lust(40);
			//dynStats("str", 33, "tou", 33, "int", -1, "lib", 4, "lus", 40);
			
			if (display) output(buffer);
		}
	}
}