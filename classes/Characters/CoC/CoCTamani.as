package classes.Characters.CoC 
{
	import classes.Items.Drinks.*;
	import classes.Items.Transformatives.*;
	import classes.Items.Transformatives.CoCDyes.*;
	import classes.Items.Transformatives.CoCEggs.CoCBlueEggLarge;
	import classes.kGAMECLASS;
	
	public class CoCTamani extends CoCGoblin
	{
		
		public function CoCTamani() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "Tamani";
			this.originalRace = "goblin";
			this.a = "the ";
			this.capitalA = "The ";
			this.long = "She keeps her arms folded across her chest and glares at you.  The little thing is only about four feet tall, with pink and black dyed hair cut into a cute little 'do.  The greenish-gray skin of her breasts bulges out around her arms, supported by a few leather straps, amplifying her cleavage.  Her cunt lips are pierced multiple times, inflamed, and slightly parted.  There really isn't any clothing on her to hide them, just more of the ever-present straps wrapping around her thighs.";
			this.skinTone = "greenish gray";
			this.hairColor = "pink and black";
			this.hairLength = 16;
			this.tallness = 40;
			
			this.XPRaw = 200;
			this.level = 4;
			this.credits = (rand(25) + 5) * 10;
			this.HPMod = 40;
			this.shieldsRaw = this.shieldsMax();
			this.HPRaw = this.HPMax();
			
			this.physiqueRaw = 32 / 20 * this.level;
			this.reflexesRaw = 55 / 20 * this.level;
			this.aimRaw = 55 / 20 * this.level;
			this.intelligenceRaw = 62 / 20 * this.level;
			this.willpowerRaw = 62 / 20 * this.level;
			this.libidoRaw = 65;
			this.personality = 50;
			this.shieldsRaw = 0;
			this.energyRaw = 100;
			this.lustRaw = 20;
			
			this.vaginas[0].bonusCapacity = 55;
			this.ass.bonusCapacity = 40;
			
			inventory = []; // subclass of goblin, gonna clean up generic loot
			inventory.push(kGAMECLASS.WeightedRandom(
						[new CoCGoblinAle(), new CoCLustDraft(), new CoCIncubiD(), new CoCReducto(), new CoCBlueEggLarge(), new CoCDyePink(), new CoCDyeBlue, new CoCDyeOrange(), new CoCDyePurple()],
						[4,                  1,                  1,                1,                1,                     1,                1,              1,                  1]));
			
			//.addMany(1,
					//consumables.PINKDYE,
					//consumables.BLUEDYE,
					//consumables.ORANGDY,
					//consumables.PURPDYE,
			
			this._isLoading = false;
		}
		
		//New Tease option:
		//public function tamaniHypnoTease():void {
			//var selector:Number = rand(3);
			////Choose 1 of 3 variations
			//if(selector == 0) output("Tamani smiles and shifts her leather straps, pulling one into the puffy gash that is her vagina.  She groans out loud, sliding the studded leather band into her outer lips and sawing it along her clit.  Her whole body blushes as she pulls it free, running a fingertip up the now wet strip of leather, \"<i>Mmm, can't you see how much my pussy needs a man inside it?  Be a good husband and fuck Tamani full!  You know you want to.</i>\"\n\n");
			//if(selector == 1) output("Tamani saunters up to you, sliding her fingers down to each side of her pussy and spreading them.  Your eyes are drawn to her honeyed tunnel, unable to look away she gets closer.  She whispers, \"<i>Your cock knows what it needs.  Just be a good husband and obey your dick, it KNOWS how badly you need mistress's pussy.</i>\"\n\n");
			//if(selector == 2) output("Tamani turns around and bends down, pressing her hands into the dirt as she kicks her legs apart.  Your stare open-mouthed at her bouncy ass-cheeks and the tantalizingly wet entrance of her slit.  She smirks and offers, \"<i>You've cum so many times inside me, why resist when you can give in and feel that pleasure again today?  Come on husband, don't make Tamani beg...</i>\"\n\n");
//
			////REACTIONS
			////LOW HYPNO VALUE:
			//if(flags["COC.TAMANI_TIMES_HYPNOTISED"] < 5) {
				//selector = rand(3);
				//if(selector == 0) output("You reluctantly pull your stare away from the heavenly entrance between her legs.  There's an urge to walk over to her and plunge yourself inside her over and over, but you dismiss it.");
				//if(selector == 1) output("You find it hard to pull your gaze from her inviting twat, but you manage.  You shake your head, clearing away thoughts of fertilizing your wife.  Her rhetoric must be getting to you.");
				//if(selector == 2) output("No matter the case, her actions shifted a fair bit of your blood-flow to your groin.");
			//}
			////MEDIUM HYPNO VALUE:
			//else if(flags["COC.TAMANI_TIMES_HYPNOTISED"] < 10) {
				//selector = rand(2);
				//if(selector == 0) {
					//output("With effort you manage to wrench your eyes away from the inviting folds of Tamani's vagina.  ");
					//if(pc.totalCocks() > 1) output("Each of y");
					//else output("Y");
					//output("our [pc.cocks]");
					//if(pc.lust() > 80) output(" drips pre-cum");
					//else if(pc.lust() > 40) output(" grows harder");
					//else output(" hardens");
					//output(" from the sexual sight, and you feel a compulsion to rush to your wife and take her on the spot.  Obviously she's not really your wife, but after so many fuckings it kind of makes sense to think of her that way.");
					//if(pc.lust() < 70) output("  Still, you don't want to fuck her right now!");
				//}
				//else {
					//output("Struggling, you pull your eyes back into your head and away from Tamani's gorgeous slit.  You shudder, feeling ");
					//if(pc.totalCocks () > 1) output("each of ");
					//output("your [pc.cocks]");
					//if(pc.lust() <= 41) output(" thicken perceptibly");
					//else if(pc.lust() <= 81) output(" twitch eagerly");
					//else output("drip pre-cum");
					//output(", responding to the overly sensual goblin's body.  You start to approach her, but stop yourself, realizing you were about to pick up your wife and fuck her on the spot.  You know she's not really your wife, but you have a hard time thinking of her as anything else, save for maybe your mistress.");
					//if(pc.lust() < 70) output("  Regardless, you're resolute in your desire not to fuck her right now!");
				//}
			//}
			////HIGH HYPNO VALUE
			//else {
				//selector = rand(2);
				//if(selector == 0) {
					//output("You barely manage to step yourself from lunging forward to bury your mouth between your mistress's legs.  Hard and trembling between your legs, ");
					//if(pc.totalCocks() > 1) output("each of ");
					//output("your [pc.cocks] aches with need.  You battle with the compulsion to kneel before your short, stacked mistress and perform your duties as her breeder husband.");
				//}
				//else {
					//output("You wrench your gaze from the juicy mound before you with great difficulty.  The desire to submit to your wife and fuck her on the spot rages through your body, melting your resistance into liquid lust and pooling it in your groin.  ", false);
					//if(pc.totalCocks() > 1) output("Each of y");
					//else output("Y");
					//output("our [pc.cocks] pulses and dribbles pre-cum, aching to do its duty and fire load after load into Tamani's perfect pussy.");
				//}
			//}
			//applyDamage(new TypeCollection( { tease: (rand(pc.libido() / 5) + 3 + (flags["COC.TAMANI_TIMES_HYPNOTISED"])) } ), foes[0], pc, "minimal");
		//}
	}
}