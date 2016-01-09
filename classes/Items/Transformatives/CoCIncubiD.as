package classes.Items.Transformatives
{
	import classes.Engine.Utility.rand;
    import classes.ItemSlotClass;
    import classes.GLOBAL;
    import classes.Creature;
    import classes.kGAMECLASS;
    import classes.GameData.TooltipManager;
    import classes.StringUtil;
    import classes.Util.RandomInCollection;
    import classes.Util.InCollection;
	import classes.Engine.Utility.num2Text;
	import classes.CockClass;
	
    public class CoCIncubiD extends ItemSlotClass
    {
        public function CoCIncubiD(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "IncubiD";
            //Regular name
            this.longName = "Incubi draft";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "an Incubi draft";
            //Displayed on tooltips during mouseovers
            this.tooltip = "The cork-topped flask swishes with a slimy looking off-white fluid, purported to give incubi-like powers.  A stylized picture of a humanoid with a huge penis is etched into the glass.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
			return useIt(target, usingCreature, true);
		}
		
		public static function useIt(target:Creature, usingCreature:Creature = null, tainted:Boolean = true):Boolean
		{
			kGAMECLASS.clearOutput();
			var x:Number = 0;
			var temp:Number = 0;
			var temp2:Number = 0;
			var temp3:Number = 0;
			var rando:Number = rand(100);
			if (target.hasPerk("History: Alchemist")) rando += 10;
			if (target.hasPerk("Transformation Resistance")) rando -= 10;
			kGAMECLASS.output("The draft is slick and sticky");
			if (target.cor() <= 33) kGAMECLASS.output(", just swallowing it makes you feel unclean.");
			if (target.cor() > 33 && target.cor() <= 66) kGAMECLASS.output(", reminding you of something you just can't place.");
			if (target.cor() > 66) kGAMECLASS.output("deliciously sinful in all the right ways.");
			if (target.cor() >= 90) kGAMECLASS.output(".  You're sure it must be distilled from the cum of an incubus.");
			
			//Lowlevel changes
			if (rando < 50) {
				if (target.cocks.length == 1) {
					if (target.cocks[0].cType != GLOBAL.TYPE_DEMONIC) kGAMECLASS.output("\n\nYour [pc.cock] becomes shockingly hard.  It turns a shiny inhuman purple and spasms, dribbling hot demon-like cum as it begins to grow.");
					else kGAMECLASS.output("\n\nYour [pc.cock] becomes shockingly hard.  It dribbles hot demon-like cum as it begins to grow.");
					if (rand(4) == 0) temp = target.cocks[0].cLength(3);
					else temp = target.cocks[0].cLength(1);
					//dynStats("int", 1, "lib", 2, "sen", 1, "lust", 5 + temp * 3, "cor", tainted ? 1 : 0);
					if (tainted) target.cor(1);
					target.libido(2);
					target.lust(5 + temp * 3);
					if (temp < .5) kGAMECLASS.output("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp >= .5 && temp < 1) kGAMECLASS.output("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp >= 1 && temp <= 2) kGAMECLASS.output("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp > 2) kGAMECLASS.output("  You smile and idly stroke your lengthening [pc.cock] as a few more inches sprout.");
					//if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3, "cor", 1);
					//else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					if (target.cocks[0].cType != GLOBAL.TYPE_DEMONIC) kGAMECLASS.output("  With the transformation complete, your [pc.cock] returns to its normal coloration.");
					else kGAMECLASS.output("  With the transformation complete, your [pc.cock] throbs in an almost happy way as it goes flaccid once more.");
				}
				if (target.cocks.length > 1) {
					temp = target.cocks.length;
					temp2 = target.smallestCockIndex();
					if (int(Math.random() * 4) == 0) temp3 = target.cocks[0].cLength(3);
					else temp3 = target.cocks[0].cLength(1);
					//if (tainted) dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3, "cor", 1);
					//else dynStats("int", 1, "lib", 2, "sen", 1, "lus", 5 + temp * 3);
					if (tainted) target.cor(1);
					target.libido(2);
					target.lust(5 + temp * 3);
					//Grammar police for 2 cocks
					if (target.cockTotal() == 2) kGAMECLASS.output("\n\nBoth of your [pc.cocksLight] become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest [pc.cock " + temp2 + "] begins to grow.");
					//For more than 2
					else kGAMECLASS.output("\n\nAll of your [pc.cocksLight] become shockingly hard, swollen and twitching as they turn a shiny inhuman purple in color.  They spasm, dripping thick ropes of hot demon-like pre-cum along their lengths as your shortest [pc.cock " + temp2 + "] begins to grow.");

					if (temp3 < .5) kGAMECLASS.output("  It stops almost as soon as it starts, growing only a tiny bit longer.");
					if (temp3 >= .5 && temp3 < 1) kGAMECLASS.output("  It grows slowly, stopping after roughly half an inch of growth.");
					if (temp3 >= 1 && temp3 <= 2) kGAMECLASS.output("  The sensation is incredible as more than an inch of lengthened dick-flesh grows in.");
					if (temp3 > 2) kGAMECLASS.output("  You smile and idly stroke your lengthening [pc.cock " + temp2 + "] as a few more inches sprout.");
					kGAMECLASS.output("  With the transformation complete, your [pc.cocksLight] return to their normal coloration.");
				}
				//NO CAWKS?
				if (target.cocks.length == 0) {
					createCock(target);
					kGAMECLASS.output("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
					kGAMECLASS.output("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  Eventually the orgasm ends as your [pc.cock] fades to a more normal tone.");
					//if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
					//else dynStats("lib", 3, "sen", 5, "lus", 10);
					if (tainted) target.cor(5);
					target.libido(3);
					target.lust(10);
				}
				//TIT CHANGE 25% chance of shrinkage
				if (rand(4) == 0)
					shrinkTits(target);
			}
			//Mid-level changes
			if (rando >= 50 && rando < 93) {
				if (target.cocks.length > 1) {
					kGAMECLASS.output("\n\nYour cocks fill to full-size... and begin growing obscenely.  ");
					temp = target.cocks.length;
					while (temp > 0) {
						temp--;
						temp2 = target.cocks[temp].cThicknessRatio(0.05);
						temp3 = target.cocks[temp].cLength(3);
					}
					if (target.cocks.length > 1) kGAMECLASS.output("\n\nYour cocks feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
					else kGAMECLASS.output("\n\nYour [pc.cocks] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
				}
				if (target.cocks.length == 1) {
					kGAMECLASS.output("\n\nYour cock fills to its normal size and begins growing... ");
					temp3 = target.cocks[0].cThicknessRatio(0.05);
					temp2 = target.cocks[0].cLength(rand(3) + 2);
					if (target.cocks.length > 1) kGAMECLASS.output("  Your [pc.cocks] feel swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. They are definitely thicker.");
					else kGAMECLASS.output("  Your [pc.cock] feels swollen and heavy. With a firm, but gentle, squeeze, you confirm your suspicions. It is definitely thicker.");
				}
				if (target.cocks.length == 0) {
					createCock(target);
					kGAMECLASS.output("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
					kGAMECLASS.output("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  Eventually the orgasm ends as your [pc.cock] fades to a more normal tone.");
				}
				//if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 3);
				//else dynStats("lib", 3, "sen", 5, "lus", 10);
				if (tainted) target.cor(3);
				target.libido(3);
				target.lust(10);
				//Shrink breasts a more
				//TIT CHANGE 50% chance of shrinkage
				if (rand(2) == 0)
					shrinkTits(target);
			}
			//High level change
			if (rando >= 93) {
				if (target.cockTotal() < 10) {
					if (int(Math.random() * 10) < int(target.cor() / 25)) {
						kGAMECLASS.output("\n\n");
						growDemonCock(target, rand(2) + 2);
					}
					else {
						growDemonCock(target, 1);
					}
				}
				shrinkTits(target);
				//if (tainted) dynStats("lib", 3, "sen", 5, "lus", 10, "cor", 5);
				//else dynStats("lib", 3, "sen", 5, "lus", 10);
				if (tainted) target.cor(5);
				target.libido(3);
				target.lust(10);
			}
			//Demonic changes - higher chance with higher corruption.
			if (rand(40) + target.cor() / 3 > 35 && tainted) CoCSucMilk.demonChanges(target);
			
			if (tainted && target.femininity > 20) kGAMECLASS.outputText(target.modFem(-2));
			if (tainted && target.thickness > 30) kGAMECLASS.outputText(target.modThickness( -2));
			
			return false;
		}

		public static function growDemonCock(target:Creature,growCocks:Number):void
		{
			var temp:int = 0;
			while (growCocks > 0) {
				if (target.cocks.length >= 10) break;
				target.createCock();
				var cock:CockClass = target.cocks[target.cocks.length - 1];
				cock.cLength(rand(3) + 4);
				cock.cThicknessRatio(1.25);
				growCocks--;
				temp++;
			}
			kGAMECLASS.output("\n\nYou shudder as a pressure builds in your crotch, peaking painfully as a large bulge begins to push out from your body.  ");
			if (temp == 1) {
				kGAMECLASS.output("The skin seems to fold back as a fully formed demon-cock bursts forth from your loins, drizzling hot cum everywhere as it orgasms.  In time it fades to a more normal coloration and human-like texture.  ", false);
			}
			else {
				kGAMECLASS.output("The skin bulges obscenely, darkening and splitting around " +  num2Text(temp) + " of your new dicks.  For an instant they turn a demonic purple and dribble in thick spasms of scalding demon-cum.  After, they return to a more humanoid coloration.  ");
			}
			if (temp > 4) kGAMECLASS.output("Your tender bundle of new cocks feels deliciously sensitive, and you cannot stop yourself from wrapping your hands around the slick demonic bundle and pleasuring them.\n\nNearly an hour later, you finally pull your slick body away from the puddle you left on the ground.  When you look back, you notice it has already been devoured by the hungry earth.");
			target.orgasm();
        }
		
		public static function createCock(pc:Creature):void
		{ // throbb copy/paste
			pc.createCock();
			var arg:int = pc.cocks.length - 1;
			pc.cocks[arg].cLengthRaw = 5;
			if(pc.hasPerk("Hung")) pc.cocks[arg].cLengthRaw += 2+rand(4);
			
			var pcRace:String = pc.race();
			
			// Type changes
			if(InCollection(pcRace, "ausar", "half-ausar", "canine-morph"))
			{
				pc.shiftCock(arg,GLOBAL.TYPE_CANINE);
				if(pcRace.indexOf("ausar") != -1) pc.cocks[arg].delFlag(GLOBAL.FLAG_SHEATHED);
			}
			else if(InCollection(pcRace, "kaithrit", "half-kaithrit", "feline-morph")) pc.shiftCock(arg,GLOBAL.TYPE_FELINE);
			else if(InCollection(pcRace, "leithan", "half-leithan")) pc.shiftCock(arg,GLOBAL.TYPE_SNAKE);
			else if(InCollection(pcRace, "kui-tan", "half kui-tan")) pc.shiftCock(arg, GLOBAL.TYPE_KUITAN);
			else if(InCollection(pcRace, "horse-morph", "part horse-morph", "laquine", "ovir", "half-ovir", "minotaur", "centaur", "horse-taur", pc.mlpRace())) pc.shiftCock(arg, GLOBAL.TYPE_EQUINE);
			else if(pcRace == "vulpine-morph") pc.shiftCock(arg,GLOBAL.TYPE_VULPINE);
			else if(pcRace == "zil") pc.shiftCock(arg,GLOBAL.TYPE_BEE);
			else if(InCollection(pcRace, "naleen", "naga")) pc.shiftCock(arg,GLOBAL.TYPE_NAGA);
			else if(InCollection(pcRace, "raskvel", "raskvel-morph", "rask-morph")) pc.shiftCock(arg, GLOBAL.TYPE_RASKVEL);
			else if(InCollection(pcRace, "fanfir", "dragon-morph")) pc.shiftCock(arg, GLOBAL.TYPE_DRACONIC);
			else if(pcRace == "demon-morph") pc.shiftCock(arg, GLOBAL.TYPE_DEMONIC);
			else if(pcRace == "kangaroo-morph") pc.shiftCock(arg, GLOBAL.TYPE_KANGAROO);
			else if(pcRace == "simii") pc.shiftCock(arg, GLOBAL.TYPE_SIMII);
			else if(pcRace == "saurian") pc.shiftCock(arg, GLOBAL.TYPE_SAURIAN);
			else if(pcRace == "venus pitcher") pc.shiftCock(arg, GLOBAL.TYPE_VENUSPITCHER);
			else if(pcRace == "sydian") pc.shiftCock(arg, GLOBAL.TYPE_SYDIAN);
			else if(pcRace == "daynar") pc.shiftCock(arg, GLOBAL.TYPE_DAYNAR);
			else if(InCollection(pcRace, "gabilani", "goblin")) pc.shiftCock(arg, GLOBAL.TYPE_GABILANI);
			else if(pc.skinType == GLOBAL.SKIN_TYPE_GOO)
			{
				pc.shiftCock(arg, GLOBAL.TYPE_HUMAN);
				pc.cocks[arg].addFlag(GLOBAL.FLAG_GOOEY);
				pc.cocks[arg].cockColor = pc.skinTone;
			}
		}
		
		public static function shrinkTits(target:Creature):void
		{
			//if (!flags[kFLAGS.HYPER_HAPPY])
			//{
			// ManUp copypaste
			var x:int = target.biggestTitRow();
			
			kGAMECLASS.output("\n\nYour [pc.breasts] suddenly grow warmer and your [pc.nipples] feel more sensitive. You grab");
			if(target.totalBreasts() == 1) kGAMECLASS.output(" it");
			else kGAMECLASS.output(" one of them");
			kGAMECLASS.output(" and examine it, carefully avoiding your [pc.nipples]. No need to get");
			if(target.lust() < 10) kGAMECLASS.output(" horny.");
			else kGAMECLASS.output(" hornier.");
			kGAMECLASS.output(" It dawns on you what's happening when you feel its mass slowly receding into your body");
			if(target.totalBreasts() > 1)
			{
				kGAMECLASS.output(" and you can see its sister");
				if(target.totalBreasts() > 2) kGAMECLASS.output("s");
				kGAMECLASS.output(" following suit");
			}
			
			// Shrink all the boobies...  :C
			for (x = 0; x < target.breastRows.length; x++)
			{
				if(target.breastRows[x].breastRatingRaw >= 1) target.breastRows[x].breastRatingRaw--;
				if(target.breastRows[x].breastRatingRaw < 0) target.breastRows[x].breastRatingRaw = 0;
			}
			
			kGAMECLASS.output(". When it’s over you realize that <b>");
			if(target.biggestTitSize() < 1)
			{
				if(target.tone < 50)
				{
					kGAMECLASS.output("you’re now flat");
					if(kGAMECLASS.silly) kGAMECLASS.output(" as a pancake");
				}
				else
				{
					kGAMECLASS.output("you have an impressive");
					if(target.totalBreasts() == 2) kGAMECLASS.output(" pair of");
					else if(target.totalBreasts() > 2) kGAMECLASS.output(" set of");
					kGAMECLASS.output(" pec");
					if(target.totalBreasts() > 1) kGAMECLASS.output("s");
				}
			}
			else
			{
				kGAMECLASS.output("you’ve lost one cup size");
				if(target.breastRows.length > 1) kGAMECLASS.output(" in each row");
			}
			kGAMECLASS.output("!</b>");
			//}
		}
	}	
}
