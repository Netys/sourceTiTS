package classes.Items.Transformatives
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	
	public class CoCBimboLiqueur extends ItemSlotClass
	{		
		public function CoCBimboLiqueur()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.DRUG;
			//Used on inventory buttons
			this.shortName = "BimboLq";
			//Regular name
			this.longName = "bottle of 'Bimbo Liqueur'";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a bottle of 'Bimbo Liqueur'";
			//Displayed on tooltips during mouseovers
			this.tooltip = "This small bottle of liqueur is labelled 'Bimbo Liqueur'.  There's a HUGE warning label about the effects being strong and usually permanent, so you should handle this with care.";
			
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
			
			if (target.hasPerk("Futa Form") || target.hasPerk("Bimbo Body") || target.isBimbo()) {
				output("Ugh.  This stuff is so, like... last year.  Maybe you can find someone else to feed it to?");
				return false;
			}
			
			this.quantity--; // ugh... where are .consume function?
			if (this.quantity <= 0 && target.inventory.indexOf(this) != -1)
			{
				target.inventory.splice(target.inventory.indexOf(this), 1);
			}
			
			
			if (target.isBro()) {
				output("You wince as the stuff hits your stomach, already feeling the insidious effects beginning to take hold.  A lengthy belch escapes your lips as your stomach gurgles, and you giggle abashedly to yourself.");
				if (target.tallness < 77) {
					output(" ...Did the ground just get farther away?  You glance down and realize, you're growing!  Like a sped-up flower sprout, you keep on getting taller until finally stopping around... six and a half feet, you assume.  Huh.  You didn't expect that to happen!");
					target.tallness = 77;
				}
				
				if (target.breastRows[0].breastRatingRaw < 7) {
					if (target.breastRows[0].breastRatingRaw < 1)
						output("  Tingling, your chest begins to itch, then swell into a pair of rounded orbs.  ");
					else output("  You feel a tingling inside your breasts.  ");
					output("They quiver ominously, and you can't help but squeeze your tits together to further appreciate the boobquake as another tremor runs through them.  Unexpectedly, the shaking pushes your hands further apart as your tits balloon against each other, growing rapidly against your now-sunken fingers.  The quakes continue until calming at around an " + target.breastCup(0) + ".");
					target.breastRows[0].breastRatingRaw = 7;
				}
				
				//(If vagina = 2tight:
				if (!target.hasVagina()) {
					output("  Before you can even take a breath, an extremely peculiar sensation emanates from your crotch.  You ");
					if (!target.isCrotchExposed()) output("can't see through your [pc.lowerGarmentOuter], but you ");
					output("can certainly feel the vagina splitting " + (target.balls > 0 ? "from behind your testicles" : "your groin") + ".  Luckily, the cunt-forming doesn't yield any discomfort - on the contrary, you feel yourself falling farther into your chemically-dulled, libido-fueled rut.");
					if (target.hipRating() < 12 || target.buttRating() < 12) output("  As if realizing the necessity of womanly proportions to attract the hard cocks your body now craves, your waist pinches slightly inward and your hips and butt swell.  You can't help but run a hand across your newly-feminized pelvis, admiring it.");
					target.createVagina();
					target.clitLength = 0.25;
					if (target.hipRating() < 12) target.hipRating( 12, true);
					if (target.buttRating() < 12) target.buttRating( 12, true);
				}
				output("\n\n");
				output("A wave of numbness rolls through your features, alerting you that another change is happening.  You reach up to your feel your jaw narrowing, becoming more... feminine?  Heavy, filling lips purse in disappointment as your face takes on a very feminine cast.  You're probably pretty hot now!\n\n");
				if (target.femininity < 80) target.femininity = 80;

				output("Your surging, absurdly potent libido surges through your body, reminding you that you need to fuck.  Not just bitches, but guys too.  Hard cocks, wet pussies, hell, you don't care.  They can have both or a dozen of either.  You just want to get laid and bone something, hopefully at the same time!");
				output("\n\n<b>(Perks Lost: Bro Body");
				if (target.hasPerk("Bro Brains")) output(", Bro Brains");
				output(")\n");
				output("(Perks Gained: Futa Form, Futa Faculties)\n");
				target.removePerk("Bro Body");
				target.removePerk("Bro Brains");
				target.createPerk("Futa Faculties", 0, 0, 0, 0, "It's super hard to think about stuff that like, isn't working out or fucking!");
				target.createPerk("Futa Form", 0, 0, 0, 0, "Ensures that your body fits the Futa look (Tits DD+, Dick 8\"+, & Pussy).  Also keeps your lusts burning bright and improves the tease skill.");
				if (target.IQ() > 35) {
					target.intelligence(target.intelligenceMax() * 0.35, true);
				}
				target.slowStatGain("libido", 50);
			}
			else {
				output("You pop the cork from the flask and are immediately assaulted by a cloying, spiced scent that paints visions of a slutty slave-girl's slightly-spread folds.  Wow, this is some potent stuff!  Well, you knew what you were getting into when you found this bottle!  You open wide and guzzle it down, feeling the fire of alcohol burning a path to your belly.  The burning quickly fades to a pleasant warmth that makes you light-headed and giggly.\n\n");
				if (target.hairColor != "platinum blonde") {
					output("The first change that you notice is to your [pc.hair].  It starts with a tingling in your scalp and intensifies ");
					if (target.hairLength < 36) {
						output("as you feel the weight of your hair growing heavier and longer.");
						target.hairLength = 36;
					}
					else output("as your hair grows thicker and heavier.");
					output("  You grab a lock of the silken strands and watch open-mouthed while streaks so blonde they're almost white flow down the [pc.hairColor] hair.  It goes faster and faster until your hair has changed into perfectly bimbo-blonde, flowing locks.\n\n");
					target.hairColor = "platinum blonde";
				}

				output("Moaning lewdly, you begin to sway your hips from side to side, putting on a show for anyone who might manage to see you.   You just feel so... sexy.  Too sexy to hide it.  Your body aches to show itself and feel the gaze of someone, anyone upon it.  Mmmm, it makes you so wet!  ");
				if (!target.hasVagina()) {
					target.createVagina();
					target.clitLength = 0.25;
					target.vaginas[0].wetness(3);
					if (target.isTaur()) output("Wait!? Wet? You wish you could touch yourself between the [pc.legsNoun], but you can tell from the fluid running down your hind-legs just how soaked your new vagina is.");
					else output("Wait!?  Wet?  You touch your groin and groan when your fingers sink into a sloppy, wet cunt.");
				}
				else {
					if (target.isTaur()) {
						output("You wish you could sink your fingers into your sloppy, wet cunt, but you can't quite reach.");
						if (target.vaginas[0].wetness() < 3)
							target.vaginas[0].wetness(3, true);
					}
					else {
						output("You sink your fingers into your ");
						if (target.vaginas[0].wetness() < 3) {
							output("now ");
							target.vaginas[0].wetness(3, true);
						}
						output("sloppy, wet cunt with a groan of satisfaction.");
					}
				}
				if (target.balls > 0) {
					output("\n\nThere's a light pinch against your [pc.sack] that makes you gasp in surprise, followed by an exquisite tightness that makes your [pc.vagina] drool.  Looking down, <b>you see your balls slowly receding into your body, leaving nothing behind but your puffy mons.</b>");
					target.balls = 0;
					target.ballSizeRaw = 3 * Math.PI;
					if(target.cumMultiplierRaw < 2) target.cumMultiplierRaw = 2;
				}
				if (target.hasCock()) {
					output("\n\nYour [pc.multiCocks] seems to be responding to the liqueur in its own way.  Clenching and relaxing obscenely, your genitals begin to drizzle cum onto the ground in front of you, throwing you into paroxysms of bliss.  The flow of cum is steady but weak, and each droplet that leaves you lets [pc.eachCock] go more flaccid.  Even once you're soft and little, it doesn't stop.  You cum your way down to nothing, a tiny droplet heralding your new, girlish groin.  <b>You no longer have ");
					if (target.cockTotal() == 1) output("a penis");
					else output("penises");
					output("!</b>");
					while (target.hasCock()) {
						target.removeCock(0, 1);
					}
				}
				output("  Somehow, you feel like you could seduce anyone right now!\n\n");

				output("Another bubbly giggle bursts from your lips, which you then lick hungrily.  You, like, totally want some dick to suck!  Wow, that came out of left field.  You shake your head and try to clear the unexpected, like, words from your head but it's getting kind of hard.  Omigosh, you feel kind of like a dumb bimbo after, like, drinking that weird booze.  Oh, well, it doesn't matter anyhow – you can, like, still stop the demons and stuff.  You'll just have to show off your sexy bod until they're offering to serve you.\n\n");

				output("You sigh and run one hand over your [pc.nipples]");
				if (target.breastRows[0].breastRatingRaw < 10) {
					target.breastRows[0].breastRatingRaw += 5 + rand(5);
					output(", surprised at how large and rounded your expanding breasts have become while fresh tit-flesh continues to spill out around your needy fingers.  They feel so supple and soft, but when you let them go, they still sit fairly high and firm on your chest.  The newer, more generous, " + target.breastCup(0) + " cleavage has you moaning with how sensitive it is, pinching a nipple with one hand ");
				}
				else {
					target.breastRows[0].breastRatingRaw += 5 + rand(5);
					output(", admiring how sensitive they're getting.  The big breasts start getting bigger and bigger, soft chest-flesh practically oozing out between your fingers as the squishy mammaries sprout like weeds, expanding well beyond any hand's ability to contain them.  The supple, " + target.breastCup(0) + " boobs still manage to sit high on your chest, almost gravity defying in their ability to generate cleavage.  You pinch a nipple with one hand");
				}
				//game.dynStats("sen", 20);
				if(!target.isTaur()) {
					output(" while the other toys with the juicy entrance of your folds.  Mmmm, it, like, feels too good not to touch yourself, and after being worried about getting all dumb and stuff, you need to relax.  Thinking is hard, but sex is so easy and, like, natural!  You lean back and start grunting as you plunge four fingers inside yourself, plowing your [pc.vagina] like no tomorrow.  By now, your [pc.clit] is throbbing, and you give it an experimental ");
					if (target.clitLength >= 3) output("jerk ");
					else output("caress ");
					output("that makes your " + target.legs() + " give out as you cum, splattering female fluids as you convulse nervelessly on the ground.\n\n");

					output("Though the orgasm is intense, you recover a few moments later feeling refreshed, but still hot and horny.  Maybe you could find a partner to fuck?  After all, sex is, like, better with a partner or two.  Or that number after two.  You brush a lengthy, platinum blonde strand of hair out of your eyes and lick your lips - you're ready to have some fun!\n\n");
				} else output(".\n\n");

				if (target.hipRating() < 12 || target.buttRating() < 12) {
					output("As you start to walk off in search of a sexual partner, you feel your center of balance shifting.");
					if (target.hipRating() < 12 && target.buttRating() < 12) {
						output("  Your ass and hips inflate suddenly, forcing you to adopt a slow, swaying gait.  You find that rolling your hips back and forth comes naturally to you.  You make sure to squeeze your butt-muscles and make your curvy tush jiggle as you go.");
						target.buttRating(12, true);
						target.hipRating(12, true);
					}
					else if (target.hipRating() < 12) {
						output("  Your hips widen suddenly, forcing you to adopt a slow, swaying gait.  You find that rolling yours hips back and forth comes naturally to you, and your big, obscene ass seems to jiggle all on its own with every step you take.");
						target.hipRating(12, true);
					}
					else {
						output("  Your [pc.butt] swells dramatically, the puffy cheeks swelling with newfound weight that jiggles along with each step.  Clenching your glutes to make the posh cheeks jiggle a little more enticingly becomes second nature to you in a few seconds.");
						target.buttRating(12, true);
					}
					output("\n\n");
				}
				if (target.tone > 0) {
					output("Like, weirdest of all, your muscles seem to be vanishing!  Before your eyes, all muscle tone vanishes, leaving your body soft and gently curvy.  You poke yourself and giggle!  Everyone's totally going to want to, like, rub up against you at every opportunity.  Your thighs are so soft you bet you could squeeze a pair of dicks to orgasm without even touching your moist cunny.");
					target.tone = 0;
					if (target.PQ() >= 30) {
						if (target.PQ() >= 90) target.physique( -target.physiqueMax() / 10);
						if (target.PQ() >= 70) target.physique( -target.physiqueMax() / 10);
						if (target.PQ() >= 50) target.physique( -target.physiqueMax() / 10);
						target.physique( -target.physiqueMax() / 10);
						output("  It does get a bit harder to carry yourself around with your diminished strength, but that's, like, what big strong hunks are for anyways!  You can just flirt until one of them volunteers to help out or something!  Besides, you don't need to be strong to jerk off cocks or finger slutty pussies!");
					}
					output("\n\n");
				}
				if (!target.hasPerk("Bimbo Body")) {
					output("<b>(Bimbo Body - Perk Gained!)\n");
					target.createPerk("Bimbo Body", 0, 0, 0, 0, "Gives the body of a bimbo.  Tits will never stay below a 'DD' cup, libido is raised, lust resistance is raised, and upgrades tease.");
				}
				if (!target.hasPerk("Bimbo Brains")) {
					output("(Bimbo Brains - Perk Gained!)\n");//int to 20.  max int 50)
					target.createPerk("Bimbo Brains", 0, 0, 0, 0, "Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!");
					if (target.IQ() > target.intelligenceMax() / 5) {
						target.intelligence(target.intelligenceMax() / 5 + target.intelligenceMax() * target.IQ() / 500);
					}
				}
				target.orgasm();
				//game.dynStats("int", -1, "lib", 4, "sen", 25);
				target.slowStatGain("libido", 4);
				//FULL ON BITCHFACE
				target.femininity = 100; // forced override of max feminity
				//Body
				//Tease/Seduce Boost
				//*boosts min lust and lust resistance)
				//*Tit size
				//Brain
				//Max int - 50
			}
			return false;
		}
	}
}