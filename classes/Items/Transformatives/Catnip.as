package classes.Items.Transformatives
{
    import classes.ItemSlotClass;
    import classes.Creature;
    import classes.kGAMECLASS;
    import classes.Characters.PlayerCharacter;
    import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.GLOBAL;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
    
    /**
     * Feline transformative
     *
     * @author Etis
     */
    public class Catnip extends ItemSlotClass
    {
        private var counter:int = 100;
        private var options:Array = [];
        
        public function Catnip(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 10;
            this.type = GLOBAL.PILL;
            //Used on inventory buttons
            this.shortName = "Catnip";
            //Regular name
            this.longName = "catnip";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a medipen loaded with Catnip";
            //Displayed on tooltips during mouseovers
            this.tooltip = "A new-gen targeted cosmetic transformative. Loosely based on mix of Kaithrit and wild cat genome, it causes the user to gain much more animalistic feline features. Solution does not include actual catnip.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            this.attackVerb = "";
            
            //Information
            this.basePrice = 800;
            this.attack = 0;
            this.defense = 0;
            this.shieldDefense = 0;
            this.shields = 0;
            this.sexiness = 0;
            this.critBonus = 0;
            this.evasion = 0;
            this.fortification = 0;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
        {
            counter = 100;
            options = [];
            var pc:Creature = target;
            kGAMECLASS.clearOutput();
            if(target is PlayerCharacter) {
                //Usage text:
                author("Etis");
                
                var buttons:int = 0;
                
                kGAMECLASS.clearMenu();
                kGAMECLASS.output("Pressing the activation stud is all it will take. You hold the tip against your arm and brace yourself, pushing the button. A quiet-sounding 'snick' hits your ears, but nothing else. Did it even work? You look where you had the pen held. There's a tiny red mark and nothing else. The pen's label displays the word ‘inactive’ in bold red text. It must have a built in painkiller. Suddenly, your codex beeps responding to connection request from injected nanobots.");
                
                kGAMECLASS.output("\n\nDetected feedback-compatible Biosign Monitor device. Aborting automated route. Debug mode activated. System is awaiting input. Please select certain route or confirm default settings. Please note: targeted route is less effective than automated, since it forces override of optimization algorithm.");
                
                kGAMECLASS.output("\n\nStatus report:");
                
                kGAMECLASS.output("\nMinor body functions: ");
                if (routeGeneralAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++, "Minor", routeGeneral, target, "Minor", "Set of minor changes in body complexion.");
                    options.push(routeGeneral);
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nEars: ");
                if (routeEarsAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++, "Ears", routeEars, target, "Ears", "Concentrate on ears.");
                    options.push(routeEars);
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nTail: ");
                if (routeTailAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++, "Tail", routeTail, target, "Tail", "Concentrate on tail.");
                    options.push(routeTail);
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nGenitals: ");
                if (routeGenitalsAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++, "Genitals", routeGenitals, target, "Genitals", "Concentrate on breasts and genitals.");
                    options.push(routeGenitals);
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nEyes: ");
                if (routeEyesAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++, "Eyes", routeEyes, target, "Eyes", "Concentrate on eyes.");
                    if(target.tailType == GLOBAL.TYPE_FELINE)
                        options.push(routeEyes);
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nArms: ");
                if (routeArmsAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++, "Arms", routeArms, target, "Arms", "Concentrate on arms.");
                    if(target.tailType == GLOBAL.TYPE_FELINE && target.earType == GLOBAL.TYPE_FELINE)
                        options.push(routeArms);
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nSkin: ");
                if (routeSkinAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++, "Skin", routeSkin, target, "Skin", "Concentrate on skin.");
                    if(target.tailType == GLOBAL.TYPE_FELINE && target.earType == GLOBAL.TYPE_FELINE)
                        options.push(routeSkin);
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nLegs: ");
                if (routeLegsAvailable(target) && (target.legCount <= 2 && target.legCountUnlocked(2) || target.legCount >= 3 && target.legCountUnlocked(4) || target.legCount >= 5 && target.legCountUnlocked(6))) {
                    kGAMECLASS.output("<b>route available</b>.");
                    if (target.legCount <= 2 && target.legCountUnlocked(2))
                    {
                        kGAMECLASS.addButton(buttons++, "Legs", routeLegs, target, "Legs", "Concentrate on legs.");
                        if(target.armType == GLOBAL.TYPE_FELINE)
                            options.push(routeLegs);
                    }
                    else
                    {
                        kGAMECLASS.output(" Please note, experimental tauric stances are not included into default route.");
                        if (target.legCountUnlocked(2))
                        {
                            kGAMECLASS.addButton(buttons++, "2 Legs", routeLegs, target, "Two Legs", "Concentrate on legs. Default bipedal humanoid stance route.");
                            if(target.armType == GLOBAL.TYPE_FELINE)
                                options.push(routeLegs);
                        }
                        if(target.legCountUnlocked(4))
                            kGAMECLASS.addButton(buttons++, "4 Legs", routeLegs4, target, "Four Legs", "Concentrate on legs. Experimental quadripedal tauric stance route.");
                        if(target.legCount > 4 && target.legCountUnlocked(6))
                            kGAMECLASS.addButton(buttons++, "6 Legs", routeLegs6, target, "Six Legs", "Concentrate on legs. Experimental hexapedal tauric stance route.");
                    }
                }
                else kGAMECLASS.output("route blocked.");
                
                kGAMECLASS.output("\nFace: ");
                if (routeFaceAvailable(target)) {
                    kGAMECLASS.output("<b>route available</b>.");
                    kGAMECLASS.addButton(buttons++,"Face",routeFace,target,"Face","Concentrate on face.");
                    if(target.skinType == GLOBAL.SKIN_TYPE_FUR && target.earType == GLOBAL.TYPE_FELINE && target.eyeType == GLOBAL.TYPE_FELINE)
                        options.push(routeFace);
                }
                else kGAMECLASS.output("route blocked.");
                
                if (options.length > 0)
                    kGAMECLASS.addButton(buttons++, "Default", routeDefault, target, "Default Route", "Choose random available option using default order.");
                
                
                kGAMECLASS.addButton(14, "Abort", kGAMECLASS.generalInventoryMenu);
                
                return true;
            }
            //Not player!
            else
            {
                kGAMECLASS.output(target.capitalA + target.short + " injects the Catnip to no effect.");
            }
            return false;
        }
        
        private function routeGeneralAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            var changes:int = 0;
            
            // should get rid of facial hair also
            if (target.thickness >= 30 && target.thicknessUnlocked(target.thickness - 10)) changes++;
            if (target.femininity >= 70 && target.femininityUnlocked(target.femininity - 10)) changes++;
            if (target.femininity <= 40 && target.femininityUnlocked(target.femininity + 10)) changes++;
            
            var buttLimit:Number = 3;
            if (target.mf("", "girl") == "girl") buttLimit = 5;
            if (target.buttRating() > buttLimit && target.buttRatingUnlocked(target.buttRating() - 1)) changes++;
            
            var hipLimit:Number = 3;
            if (target.mf("", "girl") == "girl") hipLimit = 5;
            if (target.hipRating() > hipLimit && target.hipRatingUnlocked(target.hipRating() - 1)) changes++;
            
            if (target.elasticity < (target.hasPerk("Elasticity") ? 4 : 3)) changes++;
            if    (target.ass.minLooseness > 1) changes++;
            
            return changes > 0;
        }
        
        private function routeGeneral(target:Creature, usingCreature:Creature = null):void
        {
            var changes:int = 0;
            
            // should get rid of facial hair also
            
            // decrease thicknes
            if (target.thickness >= 30 && target.thicknessUnlocked(target.thickness - 10))
            {
                kGAMECLASS.output("\n\nSomething is shifting inside you, and you suddenly feel you can move with less effort. <b>Looks like you lose some weight!</b> ");
                target.thickness -= 10;
                changes++;
                
                // increase definition as side effect
                if (target.tone <= 65 && target.toneUnlocked(target.tone + 10))
                {
                    kGAMECLASS.output("Your muscles become a little more obvious as you lose some fat.");
                    target.tone += 10;
                }
            }
            
            if (target.femininity >= 70 && target.femininityUnlocked(target.femininity - 10))
            {
                kGAMECLASS.output("\n\nYou feel slight changes in your facial structure. When they finish, <b>you feel less feminine</b>!");
                target.femininity -= 10;
                changes++;
            }
            
            if (target.femininity <= 40 && target.femininityUnlocked(target.femininity + 10))
            {
                kGAMECLASS.output("\n\nYou feel a slight change in your facial structure. When they finish, <b>you feel less masculine</b>!");
                target.femininity += 10;
                changes++;
            }
            
            var buttLimit:Number = 3;
            if (target.mf("", "girl") == "girl") buttLimit = 5;
            if (target.buttRating() > buttLimit && target.buttRatingUnlocked(target.buttRating() - 1))
            {
                kGAMECLASS.output("\n\nYour butt all of a sudden feels tight, as though you were wearing a pair of pants two sizes too small. You wince and grip your buttocks, and feel it losing mass under your hand. After a moment you're left with a much <b>smaller, less curvy butt.</b>");
                target.buttRating( -1);
                changes++;
            }
            
            var hipLimit:Number = 3;
            if (target.mf("", "girl") == "girl") hipLimit = 5;
            if (target.hipRating() > hipLimit && target.hipRatingUnlocked(target.hipRating() - 1))
            {
                kGAMECLASS.output("\n\nA sudden tightness overtakes your midsection. A searing pain flashes through you, as though your bones themselves were changing. Your hips reshape themselves, becoming more slender, leaving you <b>a little less curvy.</b>");
                target.hipRating( -1);
                changes++;
            }
            
            //elasticity+
            if (target.elasticity < (target.hasPerk("Elasticity") ? 4 : 3))
            {
                kGAMECLASS.output("\n\nYou shudder violently as waves of pleasure suddenly shoot up in your [pc.vagOrAss]. You guide your fingers inside, finding that <b>you can fit a little bit more inside than ever before</b>. Strangely, you still feel the same degree of stretching, but it is much more pleasurable and much less painful now.");
                target.lust(10+rand(5));
                target.elasticity += 1;
                changes++;
            }
            // ass looseness-
            else if(target.ass.minLooseness > 1) // no function for ass looseness lock?
            {
                kGAMECLASS.output("\n\nYou feel a rumbling in your gut and a strange half-pleasure sensation spreading up from your ass. <b>Giving your backdoor an experimental poke, your find it much more tight</b> than it was before!");
                target.ass.minLooseness--;
                if(target.ass.looseness() > target.ass.minLooseness) target.ass.looseness(target.ass.minLooseness,true);
                target.lust(10+rand(4));
                changes++;
            }
            
            // get a bit of reflexes... don't want this to be OP
            /*
            if(target.RQ() < 25 && changes < changeLimit && rand(3) == 0)
            {
                kGAMECLASS.output("\n\nEvery single one of your muscles begin to throb and pulse. You gasp out loud as the strange sensation wracks your entire body. What is going on--? When it finally subsides, you feel like you can move faster than before. <b>Your reflexes have increased!</b>");
                target.slowStatGain("reflexes",2);
                changes++;
            }
            */
            
            // perks! not actually implemented...
            if(9999 == 0 && target.tailType == GLOBAL.TYPE_FELINE && target.legType == GLOBAL.TYPE_FELINE && target.armType == GLOBAL.TYPE_FELINE && target.earType == GLOBAL.TYPE_FELINE && !target.hasPerk("Feline Flexibility"))
            {
                kGAMECLASS.output("\n\nYou feel something odd in your joints. After some experimental stretching you've found yourself able to fold in absolutely unnatural ways - you can easily touch base of your tail with your nose, folding both forward and backward alike! You already have kinky ideas of putting this into some use.");
                kGAMECLASS.output("\n\n(<b>Perk Gained: Feline Flexibility</b> - You can easily fold yourself in two.)");
                target.createPerk("Feline Flexibility",0,0,0,0,"You can easily fold yourself in two.");
                target.lust(20+rand(10));
                changes++;
            }
            if(9999 == 0 && target.tailType == GLOBAL.TYPE_FELINE && target.legType == GLOBAL.TYPE_FELINE && target.armType == GLOBAL.TYPE_FELINE && target.earType == GLOBAL.TYPE_FELINE && target.hasPerk("Feline Flexibility") && !target.hasPerk("Feline Reflexes"))
            {
                kGAMECLASS.output("\n\nYou suddenly realize how unusually quick and precise your movements are.");
                kGAMECLASS.output("\n\n(<b>Perk Gained: Feline Reflexes</b> - You have unnaturally quick reflexes.)");
                target.createPerk("Feline Reflexes",0,0,0,0,"You have unnaturally quick reflexes.");
                changes++;
            }
            
            afterTF(target);
        }
        
        private function routeGenitalsAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            var changes:int = 0;
            
            var maxSize:int = 4;
            if (target.hasPerk("Hung")) maxSize += 2;
            if (target.hasPerk("Mini")) maxSize -= 1;
            if (target.isTaur()) maxSize += 4;
            
            // Get a feline dick and change it's size towards target
            for(var x:int = 0; x < target.cockTotal(); x++)
                if (
                    (
                        (
                            target.cocks[x].cType != GLOBAL.TYPE_FELINE
                            || !target.hasCockFlag(GLOBAL.FLAG_TAPERED)
                            || !target.hasCockFlag(GLOBAL.FLAG_SHEATHED)
                        )
                        && target.cockTypeUnlocked(x, GLOBAL.TYPE_FELINE)
                    )
                    || (target.cocks[x].cLength() != maxSize && target.cockLengthUnlocked(x, maxSize))
                ) changes++;
            
            for (x = 0; x < target.totalVaginas(); x++)
                if (/*target.vaginas[x].vaginaColor != "pink" ||*/ target.vaginas[x].minLooseness > 1 && target.loosenessUnlocked(x, target.vaginas[x].minLooseness - 1)) changes++;
            
            //Ball shrinkage to 1.5 inch
            var limit:Number = 1.5;
            if (target.hasPerk("Bulgy")) limit = 2.5;
            if (target.isTaur()) limit += 1.5;
            if (target.balls > 0 && target.ballSizeRaw > limit) changes++;
            
            if (!target.hasStatusEffect("Uniball") && target.balls > 0 &&  target.ballSizeRaw <= limit) changes++;
            
            maxSize = target.hasVagina() ? 2 : 0;
            if(target.breastRows.length > 0 && target.breastRows[0].breastRatingRaw > maxSize && target.breastRatingUnlocked(0, maxSize)) changes++;
            
            return changes > 0;
        }
        
        private function routeGenitals(target:Creature, usingCreature:Creature = null):void
        {
            var changes:int = 0;
            
            //Feminine TFs
            for(var x:int = 0; x < target.totalVaginas(); x++)
            {
				/*
                if(target.vaginas[x].vaginaColor != "pink")
                {
                    kGAMECLASS.output("\n\nA tickling, teasing sensation flutters across your nether-lips");
                    if(target.totalVaginas() > 1)
                    {
                        kGAMECLASS.output(" - ");
                        if(target.totalVaginas() == 2) kGAMECLASS.output("both sets");
                        else kGAMECLASS.output("every single set of them");
                    }
                    kGAMECLASS.output(", leaving you intensely aware of your own movements. You peek down there to see what’s going on");
                    if(target.isCrotchGarbed()) kGAMECLASS.output(", taking special care to move your [pc.lowerGarments] out of the way");
                    kGAMECLASS.output(". <b>Your [pc.vaginas] ");
                    if(target.totalVaginas() == 1) kGAMECLASS.output("is");
                    else kGAMECLASS.output("are");
                    kGAMECLASS.output(" pink!</b>.");
                    
                    //Go through the list of unpink vags and make 'em pink!
                    // not actually sure about this one...
                    if (9999 == 0 && target.vaginas[x].type != GLOBAL.TYPE_FELINE && target.vaginaTypeUnlocked(x, GLOBAL.TYPE_FELINE)) {
                        target.shiftVagina(x, GLOBAL.TYPE_FELINE);
                    }
                    target.vaginas[x].vaginaColor = "pink";
                    changes++;
                }
				*/
                
                //Vaginal looseness-
                if (target.vaginas[x].minLooseness > 1 && target.loosenessUnlocked(x, target.vaginas[x].minLooseness-1))
                {
                    kGAMECLASS.output("\n\nYou feel a strange half-pleasure sensation spreading up from your cunt. <b>Giving your muff an experimental poke, your find it much more tight</b> than it was before!");
                    target.vaginas[x].minLooseness--;
                    if(target.looseness(x) > target.vaginas[x].minLooseness) target.vaginas[x].looseness(target.vaginas[x].minLooseness,true);
                    target.lust(10+rand(4));
                    changes++;
                }
            }
            
            var maxSize:int = target.hasVagina() ? 2 : 0;
            //if (target.hasPerk("Milky")) maxSize += 2; // not actually correct use of perk
            //if (target.isTaur()) maxSize += 1;
            
            //Breasts down to B-cup
            if(target.breastRows.length > 0 && target.breastRows[0].breastRatingRaw > maxSize && target.breastRatingUnlocked(0, maxSize))
            {
                var tittyDrop:int = 0;
                if(target.breastRows[0].breastRatingRaw >= 12) tittyDrop += target.breastRows[0].breastRatingRaw * .25;
                else if(target.breastRows[0].breastRatingRaw >= 8) tittyDrop += rand(3);
                tittyDrop += 1;
                if (target.breastRatingUnlocked(0, target.breastRows[0].breastRatingRaw - tittyDrop))
                {
                    //**Same as Zil TF, I guess?
                    kGAMECLASS.output("\n\nTipping backwards, you flail your arms frantically to keep your balance. Once you right, you realize what happened;  <b>your [pc.chest] have lost a bit of weight, dropping you down to a " );
                    target.breastRows[0].breastRatingRaw -= tittyDrop;
                    kGAMECLASS.output((target.breastRows[0].breastRatingRaw > 0 ? target.breastCup(0) : "flats") + ". </b>");
                    changes++;
                    //Other rows, go!
                    var bonusRowsTFed:int = 0;
                    for(x = 1; x < target.bRows(); x++)
                    {
                        if(target.breastRows[x].breastRatingRaw > maxSize)
                        {
                            //Figure out how much dat row will change!
                            if(target.breastRows[x].breastRatingRaw >= 12) tittyDrop += target.breastRows[x].breastRatingRaw * .25;
                            else if(target.breastRows[x].breastRatingRaw >= 8) tittyDrop += rand(3);
                            tittyDrop += 1;
                            //If that row is unlocked!
                            if (target.breastRatingUnlocked(0, target.breastRows[x].breastRatingRaw - tittyDrop))
                            {
                                bonusRowsTFed++;
                                target.breastRows[x].breastRatingRaw -= tittyDrop;
                            }
                        }
                    }
                    if(bonusRowsTFed == 1) kGAMECLASS.output(" Your second row of breasts shrink a bit as well.");
                    else if(bonusRowsTFed > 1) kGAMECLASS.output(" Your other breasts shrink a bit as well.");
                }
            }
            
            //Masculine TFs
            //Get a feline dick
            maxSize = 4;
            if (target.hasPerk("Hung")) maxSize += 2;
            if (target.hasPerk("Mini")) maxSize -= 1;
            if (target.isTaur()) maxSize += 4;
            
            for(x = 0; x < target.cockTotal(); x++)
            {
                // if type is not feline or lacks flags try major tf
                if(target.cocks[x].cType != GLOBAL.TYPE_FELINE || !target.hasCockFlag(GLOBAL.FLAG_TAPERED) || !target.hasCockFlag(GLOBAL.FLAG_SHEATHED))
                {
                    if (target.cockTypeUnlocked(x, GLOBAL.TYPE_FELINE))
                    {
                        kGAMECLASS.output("\n\nYour [pc.cock " + x + "] throbs suddenly ");
                        if(target.isCrotchGarbed()) kGAMECLASS.output("beneath your [pc.lowerGarments]");
                        else if(target.legCount == 1) kGAMECLASS.output("on your [pc.leg]");
                        else kGAMECLASS.output("between your [pc.legs]");
                        kGAMECLASS.output(" and begins to transform. You double over in a sick twist of pain and pleasure");
                        if(target.cocks[x].cockColor != "pink")
                        {
                            kGAMECLASS.output("as the flesh of your cock shifts color to a pink hue");
                            target.cocks[x].cockColor = "pink";
                        }
                        if(!target.hasCockFlag(GLOBAL.FLAG_TAPERED)) kGAMECLASS.output(", the skin melding strangely into a long, pointed shape, until the tip is barely wide enough to accommodate your urethra");
                        kGAMECLASS.output(".");
                        
                        if(!target.hasCockFlag(GLOBAL.FLAG_NUBBY))
                        kGAMECLASS.output(" Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base and shrink towards the tip. The smallest are barely visible. They are angled towards you, so pulling out now should be even more intense than pushing in.");
                        
                        //if cock was more than max size:
                        if(target.cockLengthUnlocked(x, maxSize)) {
                        if(target.cocks[x].cLength() > maxSize) {
                            kGAMECLASS.output(" Your prick shrinks. Well, big dicks aren't really what cats are known for.");
                            target.cocks[x].cLength( -Math.min(target.cocks[x].cLength() - maxSize, 2 + rand(4)));
                        }
                        else if(target.cocks[x].cLength() < maxSize) {
                            kGAMECLASS.output(" Your prick grows longer!");
                            target.cocks[x].cLength( Math.min(maxSize - target.cocks[x].cLength(), 2 + rand(4)));
                        }}
                        
                        kGAMECLASS.output(" The [pc.cockHead " + x + "] jumps, drooling a sticky [pc.cumColor] river from its engorged slit.");
                        
                        if (!target.hasCockFlag(GLOBAL.FLAG_SHEATHED) && !target.hasStatusEffect("Genital Slit"))
                        kGAMECLASS.output(" Finally, a sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.");
                            
                        kGAMECLASS.output("\n\nYou spend a few moments collecting yourself, cleaning the spunk off your <b>" + (target.cocks[x].cType != GLOBAL.TYPE_FELINE ? "new" : "improved") + " kitty pecker</b>.");
                        target.lust(20+rand(20));
                        changes++;
                        // target.shiftCock(x,GLOBAL.TYPE_FELINE); // not actually sure which way is better
                        target.cocks[x].cType = GLOBAL.TYPE_FELINE;
                        target.cocks[x].knotMultiplier = 1;
                        target.cocks[x].cockFlags = [GLOBAL.FLAG_NUBBY, GLOBAL.FLAG_TAPERED, GLOBAL.FLAG_SHEATHED];
                    } else {
                        kGAMECLASS.output(target.cockTypeLockedMessage());
                    }
                }
                // if already right type try only size change
                else if(target.cockLengthUnlocked(x, maxSize) && target.cocks[x].cLength() != maxSize)
                {
                    kGAMECLASS.output("\n\nYour [pc.cock " + x + "] tingles, making your groin feel a little lighter. ");
                    
                    if(target.cocks[x].cLength() > maxSize) {
                        kGAMECLASS.output("It <b>dwindles in size</b>, shrinking to its new size of ");
                        target.cocks[x].cLength( -Math.min(target.cocks[x].cLength() - maxSize, 1 + rand(3)));
                        kGAMECLASS.output(Math.round(target.cocks[x].cLength() * 10) / 10 + " inches. Well, big dicks aren't really what cats are known for.");
                    }
                    else if(target.cocks[x].cLength() < maxSize) {
                        kGAMECLASS.output(" Your prick <b>grows longer</b>, extending to its new size of ");
                        target.cocks[x].cLength( Math.min(maxSize - target.cocks[x].cLength(), 2 + rand(3)));
                        kGAMECLASS.output(Math.round(target.cocks[x].cLength() * 10) / 10 + " inches.");
                    }
                    changes++;
                    target.lust(10+rand(5));
                }
            }
            
            //Ball shrinkage to 1.5 inch
            var limit:Number = 1.5;
            if (target.hasPerk("Bulgy")) limit = 2.5;
            if (target.isTaur()) limit += 1.5;
            if (target.balls > 0 && target.ballSizeRaw > limit)
            {
                var newSize:Number = target.ballSizeRaw;
                newSize -= Math.min(target.ballSizeRaw - limit, 1 + rand(1));
                if (target.ballSizeRaw > 10) newSize -= 1 + rand(1);
                if (target.ballSizeRaw > 25) newSize -= 1 + rand(1);
                if (target.ballSizeRaw > 35) newSize -= 1 + rand(1);
                if (newSize < limit) newSize = limit;
                
                if (target.ballSizeUnlocked(newSize))
                {
                    kGAMECLASS.output("\n\nSomething pinches your [pc.balls] through your [pc.sack], but you can't seem to see anything that could possibly be hurting you down there. That riddle is solved when ");
                    if(target.balls > 1) kGAMECLASS.output("they start");
                    else kGAMECLASS.output("it starts");
                    kGAMECLASS.output(" to diminish before your very eyes, losing mass while your [pc.sack] ");
                    
                    if(target.hasStatusEffect("Uniball"))
                    {
                        kGAMECLASS.output("keeps tight around ");
                        if(target.balls == 1) kGAMECLASS.output("it");
                        else kGAMECLASS.output("them");
                    }
                    else
                    {
                        kGAMECLASS.output("keeps pace with ");
                        if(target.balls == 1) kGAMECLASS.output("it");
                        else kGAMECLASS.output("them");
                    }
                    if (target.hasStatusEffect("Uniball")) kGAMECLASS.output(" like a vacuum-sealed bag");
                    target.ballSizeRaw = newSize;
                    kGAMECLASS.output(". <b>You've got " + target.ballsDescript(false, true) + " now.</b>");
                    
                    changes++;
                }
                else if (!target.ballSizeUnlocked(newSize))
                {
                    kGAMECLASS.output(target.ballSizeLockedMessage());
                }
            }
            else if(!target.hasStatusEffect("Uniball") && target.balls > 0)
            {
                kGAMECLASS.output("\n\nYou gasp and bunch your fists as what feels like a soft vice clamps down on your balls, pushing them upwards and inwards. It’s not painful exactly but whatever is happening to them is intense enough for sweat to stand out on your brow. When the sensation dissipates somewhat you slide a hand downstairs uncertainly. <b>You’ve grown a tight-fitting pouch</b> which holds your “ + (pc.balls == 1 ? “ball” : “balls”) + “ up to the back of your thighs.");
                target.lust(10);
                target.createStatusEffect("Uniball", 0, 0, 0, 0, true, "", "", false, 0);
                changes++;
            }
            
            // chakat surprise
            /*
            if (9999 == 0 && target.isTaur()) // for full TF overdose only... this doesn't exactly fit this med prescription, so disabled
            {
                var genitalsGrow:Boolean = false;
                if (!target.hasCock() && changes < changeLimit && rand(3) == 0 && target.createCockUnlocked())
                {
                    kGAMECLASS.output("\n\nA swollen lump of flesh appears ");
                    if(target.hasVagina()) kGAMECLASS.output("right above your [pc.vaginas]");
                    else kGAMECLASS.output("in the center of your crotch");
                    kGAMECLASS.output(". It feels achy and a little painful but very, very sensitive, and it's getting bigger with alarming rapidity. The little knot is sticking an inch out past your [pc.skinFurScales], turning glossy and red as it does. You touch its tip and moan, assaulted by pleasure you barely understand, watching the bulge stretch out another inch in eager response. In seconds, you're rubbing and fondling it, coaxing more and more length from your crotch until ");
                    target.createCock();
                    target.cocks[0].cLengthRaw = 8;
                    if (target.hasPerk("Hung")) target.cocks[0].cLengthRaw += 2;
                    if (target.hasPerk("Mini")) target.cocks[0].cLengthRaw -= 1;
                    target.shiftCock(0, GLOBAL.TYPE_FELINE);
                    kGAMECLASS.output("<b>your hand is wrapped around a " + kGAMECLASS.num2Text(Math.round(target.cocks[0].cLengthRaw * 10) / 10) + "-inch long, twitching [pc.cockNounSimple 0].</b>");
                    changes++;
                    genitalsGrow = true;
                    if(target.hasVagina()) scoreAfter++; // dirty way to get chakat message
                }
                
                if (!target.hasVagina() && changes < changeLimit && rand(3) == 0 && target.createVaginaUnlocked())
                {
                    kGAMECLASS.output("\n\nSweat beads on your suddenly overheated brow. Your heart is pounding, and the air seems obscenely humid. Groaning in discomfort, you press your moist palms against your [pc.belly], feeling your body temperature rise even higher. Swaying uncertainly, you sink to the ground, confused and uncomfortable.");
                    kGAMECLASS.output("\n\nThen, you feel it - an unmistakable, pleasant wetness. It isn’t your seemingly omnipresent sweat either, but something else, something altogether slipperier. New-grown nerves revel in your new, slickened state, unveiling a whole new palette of exquisite feelings, revealing a fleshy, sensitive crease ");
                    if(target.balls == 0 && !target.hasCock()) kGAMECLASS.output("in your crotch");
                    else if(target.balls > 0) kGAMECLASS.output("just behind your [pc.balls]");
                    else kGAMECLASS.output("just underneath your [pc.cocks]");
                    kGAMECLASS.output(". Gingerly, you probe your blossoming vagina. It rewards you with an answering burst of hot, wet ecstasy.");
                    kGAMECLASS.output("\n\nFeeling much better, you gingerly remove your [pc.girlCum]-soaked digits from yourself and give the feminine addition a serious look. <b>");
                    
                    target.createVagina();
                    target.clitLength = .25;
                    target.vaginas[0].bonusCapacity += 20; // common taur bonus
                    target.vaginas[0].hymen = true;
                    target.shiftVagina(0, GLOBAL.TYPE_FELINE);
                    kGAMECLASS.output("You’ve got a pretty, pink pussy. </b> You’ll have to spend some quality time with it soon.");
                    
                    if(target.breastRows[0].breastRating() == 0 && target.breastRatingUnlocked(0, 1)) // buy vagina and get A-cup breasts for free!
                    {
                        target.breastRows[0].breastRatingRaw += 1;
                        kGAMECLASS.output("\n\nThe [pc.skin] of your once-flat chest burgeons, filling out. You cup your new tits, shuddering at the suddenly sensitive flesh around your [pc.nipples]. Oh, that's nice.... You now have [pc.breastCupSize]s!");
                        changes++;
                    }
                    
                    changes++;
                    genitalsGrow = true;
                    if (target.hasCock()) scoreAfter++; // dirty way to get chakat message
                }
                
                if(genitalsGrow)
                kGAMECLASS.output("\n\nWhat the hell was that? You check the instructions and find a note in fine print about possible side effects with tauric body. Well, this isn't worst thing which can happen...");
            }
            */
            
            afterTF(target);
        }
        
        private function routeTailAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            return target.tailType != GLOBAL.TYPE_FELINE && (target.tailTypeUnlocked(GLOBAL.TYPE_FELINE) || target.tailType == GLOBAL.TYPE_COCKVINE);
        }
        
        private function routeTail(target:Creature, usingCreature:Creature = null):void  
        {
            var changes:int = 0;
            
            //Grow feline tail. One tail, since this is not exactly Kaithrit TF. But will keep second Kaithrit tail, if you already have it.
            if(target.tailType != GLOBAL.TYPE_FELINE)
            {
                var vine:Boolean = false;
                // workaround for changing cockvine
                if (target.tailType == GLOBAL.TYPE_COCKVINE)
                {
                    target.tailType = GLOBAL.TYPE_FELINE;
                    target.addTailFlag(GLOBAL.FLAG_TAILCOCK);
                    target.libidoRaw -= 3;
                    vine = true;
                }
                
                if (target.tailTypeUnlocked(GLOBAL.TYPE_FELINE))
                {
                    //{If PC had a tail before: }
                    if(target.tailCount == 1) kGAMECLASS.output("\n\nYou feel something itching on your [pc.tail]. Twisting around, you watch in a mix of horror and excitement as " + target.furColor + " bristles, the beginnings of a thin coat of fur, sprout up across the length of your reforming posterior appendage. It starts curling and twisting as the change completes, leaving you with a <b>feline tail.</b>");
                    //Multitails
                    else if(target.tailCount > 1) kGAMECLASS.output("\n\nYour [pc.tails] knot together, torturing you with brief convulsions. A kind of numb heat spreads through them, forcing you to twist about for a visual inspection. They're merging together into a single, narrow entity. The flesh crawls eerily as it assume its new shape. Hairs sprout out of it while you watch, thickening into a coat of fur. <b>Your [pc.tails] have combined into a single feline tail.</b>");
                    //{If PC is tailless peasant: }
                    else
                    {
                        kGAMECLASS.output("\n\nOuch! A knot of discomfort forms just above your [pc.butt] as if it had suffered a nasty sting or bite, but no such injury occurred. You twist for a look at it");
                        if(target.isCrotchGarbed()) kGAMECLASS.output(", peeling back your [pc.underGarments]");
                        kGAMECLASS.output(". There's a raised, irritated lump there, and it's getting bigger. Wiggling slightly, it extends as new bones form within it, gently wagging as it lengthens. You're growing a tail! Fine hairs sprout on its [pc.skin], giving it a distinctly feline cast. When it finishes growing, it's long enough to begin curling and twisting vigorously; <b>you've obviously gained a feline tail.</b>");
                    }
                    
                    if (target.hasTailCock())
                    {
                        target.clearTailFlags();
                        target.tailGenitalColor = target.skinTone;
                        target.tailGenitalArg = GLOBAL.TYPE_FELINE;
                        target.tailGenital = GLOBAL.TAIL_GENITAL_COCK;
                        target.addTailFlag(GLOBAL.FLAG_TAILCOCK); // that's a hell load of flags...
                        target.addTailFlag(GLOBAL.FLAG_PREHENSILE);
                        target.addTailFlag(GLOBAL.FLAG_NUBBY); // not really sure how it should be actually handled
                        target.addTailFlag(GLOBAL.FLAG_TAPERED);
                        target.addTailFlag(GLOBAL.FLAG_SHEATHED);
                        kGAMECLASS.output(" The tip of your tail feels strange. After some probing you've found your tail genitalia still present, but totally unnoticeable under a furry sheath when not aroused");
                        if(vine) kGAMECLASS.output(" and much less prone to act by itself");
                        kGAMECLASS.output(".");
                    } else target.clearTailFlags();
                    
                    target.tailCount = 1;
                    target.tailType = GLOBAL.TYPE_FELINE;
                    target.addTailFlag(GLOBAL.FLAG_LONG);
                    target.addTailFlag(GLOBAL.FLAG_FURRED);
                    // FIXME: according to codex, felines should also have FLAG_PREHENSILE...
                    changes++;
                }
                else kGAMECLASS.output(target.tailTypeLockedMessage());
            }
            
            afterTF(target);
        }
        
        private function routeEarsAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            return target.earType != GLOBAL.TYPE_FELINE && target.earTypeUnlocked(GLOBAL.TYPE_FELINE);
        }
        
        private function routeEars(target:Creature, usingCreature:Creature = null):void
        {
            var changes:int = 0;
            
            //Grow cat ears!
            if(target.earType != GLOBAL.TYPE_FELINE)
            {
                if (target.earTypeUnlocked(GLOBAL.TYPE_FELINE))
                {
                    if (InCollection(target.earType, [GLOBAL.TYPE_HUMAN, GLOBAL.TYPE_HUMANMASKED, GLOBAL.TYPE_SYLVAN]))
                        kGAMECLASS.output("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. ");
                    else kGAMECLASS.output("\n\n");
                    
                    kGAMECLASS.output("Your ears begin to tingle. You reach up with one hand and gently rub them. Your ears twist and morph, growing a thin layer of " + target.furColor + " fur as they reshape into a pair of points, towering over your head. You experimentally move them, feeling them swivel about at your command. And you can hear so much better than before, every slight creak and rustle around you is so clear now! <b>You now have feline ears!</b>");
                    target.earType = GLOBAL.TYPE_FELINE;
                    changes++;
                }
                else kGAMECLASS.output(target.earTypeLockedMessage());
            }
            
            afterTF(target);
        }
        
        private function routeArmsAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            return target.armType != GLOBAL.TYPE_FELINE && target.armTypeUnlocked(GLOBAL.TYPE_FELINE) || target.armType == GLOBAL.TYPE_FELINE && !target.hasArmFlag(GLOBAL.FLAG_FURRED);
        }
        
        private function routeArms(target:Creature, usingCreature:Creature = null):void
        {
            var changes:int = 0;
            
            //Change arm type to furred. Only after tail and ears.
            if(target.armType != GLOBAL.TYPE_FELINE)
            {
                if (target.armTypeUnlocked(GLOBAL.TYPE_FELINE))
                {
                    if(!target.hasFur())
                    kGAMECLASS.output("\n\nYou feel a powerful itch spread across your arms. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a dark mat across your [pc.skin]. Within a few minutes, your arms are utterly covered in a thick, silky-smooth " + target.furColor + " fur! ");
                    else kGAMECLASS.output("\n\n")
                    kGAMECLASS.output("You ball a hand into a fist, only to feel the softest little pads pressing into your palm. Opening your digits, you marvel at the appearance of small, [pc.skinTone] pads on the tips of your fingers. A larger one stretches across the top of your palm. They’re soft as hell and might feel pretty good in certain... tender areas. <b>You’ve got feline arms, complete with retractable claws and padded palms!</b>");
                    // flag for padded palms would be nice
                    target.armType = GLOBAL.TYPE_FELINE;
                    target.clearArmFlags();
                    target.addArmFlag(GLOBAL.FLAG_FURRED);
                    changes++;
                }
                else kGAMECLASS.output(target.armTypeLockedMessage());
            }
            else if (target.armType == GLOBAL.TYPE_FELINE && !target.hasArmFlag(GLOBAL.FLAG_FURRED))
            {
                kGAMECLASS.output("\n\nYou feel a powerful itch spread across your arms. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a dark mat across your [pc.skin]. Within a few minutes, your arms are utterly covered in a thick, silky-smooth " + target.furColor + " fur! ");
                target.addArmFlag(GLOBAL.FLAG_FURRED);
                changes++;
            }
            
            afterTF(target);
        }
        
        private function routeLegsAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            return target.legType != GLOBAL.TYPE_FELINE && target.legTypeUnlocked(GLOBAL.TYPE_FELINE) || target.armType == GLOBAL.TYPE_FELINE && (!target.hasLegFlag(GLOBAL.FLAG_FURRED) || !target.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) || !target.hasLegFlag(GLOBAL.FLAG_PAWS));
        }
        
        private function routeLegs4(target:Creature, usingCreature:Creature = null, count:int = 2):void
        {
            routeLegs(target, usingCreature, 4);
        }
        
        private function routeLegs6(target:Creature, usingCreature:Creature = null, count:int = 2):void
        {
            routeLegs(target, usingCreature, 6);
        }
        
        private function routeLegs(target:Creature, usingCreature:Creature = null, count:int = 2):void
        {
            var changes:int = 0;
            
            // Change leg-type to furred feline, can retain tauric form
            if(target.legType != GLOBAL.TYPE_FELINE)
            {
                if (target.legTypeUnlocked(GLOBAL.TYPE_FELINE))
                {
                    if (!target.hasFur()) kGAMECLASS.output("\n\nYou feel a powerful itch spread across your [pc.legs]. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a " + target.furColor + " mat across your [pc.skin]. Within a few minutes, your legs are utterly covered in a thick, silky-smooth " + target.furColor + " fur! ");
                    
                    if(target.legCount < 2) // naga to biped
                    {
                        kGAMECLASS.output("\n\nYour [pc.leg] wobbles then folds, dropping you onto your [pc.butt]. It thrashes wildly around, uncontrolled and spasmatic. Something inside is changing, and you're helpless to do anything but clench your fists and hold on for the ride. A seam appears in your [pc.leg] a moment before it divides into <b>two leg-like shapes.</b>");
                        target.legCount = 2;
                    }
                    // More than biped to cat-taur/chakat, fix non-even leg count.
                    else if (target.legCount > 2)
                    {
                        kGAMECLASS.output("\n\nTwitching wildly, your [pc.legs] give out, dumping you to the floor in a heap of uncoordinated, splayed limbs. They twitch wildly as they reform, starting at your waist and spreading down. Their bones melt like butter as they flow into new shapes.");
                        
                        if (target.legCount > 4 && count == 4) // 50% to get "normal" taur body if have too much legs
                        {
                            kGAMECLASS.output(" The front four do anyway. <b>Your body shortens up behind them, becoming more traditionally tauric in shape and size.</b>");
                            target.legCount = 4;
                        }
                        else if (target.legCount > 6 && count == 6) // 6 legs is enough. Really.
                        {
                            kGAMECLASS.output(" The front six do anyway. <b>Your body shortens up behind them, becoming more traditionally tauric in shape and size.</b>");
                            target.legCount = 6;
                        }
                        else if ((target.legCount / 2) != Math.round(target.legCount / 2)) // 3/5 legs? I have no idea what the hell it can be.
                        {
                            target.legCount = count;
                            kGAMECLASS.output(" <b>Your body now has an even count of legs, becoming more traditionally tauric in shape and size.</b>");
                        }
                        else if(target.legCount != count)
                        {
                            target.legCount = 2;
                            kGAMECLASS.output(" You feel your bones and organs changing place, steadily mutating until it no longer resembles the body of a beast, but a human. Your additional legs are absorbed, drawing into your vanishing lower body until <b>you have a humanoid figure</b>, complete with two legs.");
                        }
                    } else
                    kGAMECLASS.output("\n\nYou drop to the ground as your [pc.legs] go boneless. The jarring impact is enough to make you wince, but of far more concern is what's happening below your bruised bottom. Your [pc.legs] are changing!");
                    
                    kGAMECLASS.output("\n\n Your joints feel very odd, and your soles reform into padded paws tipped by sharp-looking claws. It'll take a little bit of practice to get used to walking with these. After few steps you've found pads of your new paws incredibly sensitive, almost like your tongue - even just feeling ground texture under you is exquisite. You feel a compulsion to walk barefoot from now on. <b>You’ve got digitigrade feline legs, complete with claws and pads!</b>");
                    
                    target.legType = GLOBAL.TYPE_FELINE;
                    target.clearLegFlags();
                    target.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
                    target.addLegFlag(GLOBAL.FLAG_PAWS);
                    target.addLegFlag(GLOBAL.FLAG_FURRED);
                    changes++;
                }
                else kGAMECLASS.output(target.legTypeLockedMessage());
            }
			else if (target.armType == GLOBAL.TYPE_FELINE && (!target.hasLegFlag(GLOBAL.FLAG_FURRED) || !target.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) || !target.hasLegFlag(GLOBAL.FLAG_PAWS)))
			{
				if (!target.hasLegFlag(GLOBAL.FLAG_FURRED)) kGAMECLASS.output("\n\nYou feel a powerful itch spread across your [pc.legs]. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a " + target.furColor + " mat across your [pc.skin]. Within a few minutes, your legs are utterly covered in a thick, silky-smooth " + target.furColor + " fur! ");
				if (!target.hasLegFlag(GLOBAL.FLAG_PAWS) || !target.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE)) kGAMECLASS.output("\n\n Your joints feel very odd, and your soles reform into padded paws tipped by sharp-looking claws. It'll take a little bit of practice to get used to walking with these. <b>You’ve got digitigrade feline legs, complete with claws and pads!</b>");
				target.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
				target.addLegFlag(GLOBAL.FLAG_PAWS);
				target.addLegFlag(GLOBAL.FLAG_FURRED);
                changes++;
			}
            
            afterTF(target);
        }
        
        private function routeEyesAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            return target.eyeType != GLOBAL.TYPE_FELINE && target.eyeTypeUnlocked(GLOBAL.TYPE_FELINE);
        }
        
        private function routeEyes(target:Creature, usingCreature:Creature = null):void
        {
            var changes:int = 0;
            
            // Feline eyes! Need ears.
            if(target.eyeType != GLOBAL.TYPE_FELINE)
            {
                if (target.eyeTypeUnlocked(GLOBAL.TYPE_FELINE))
                {
                    if (!InCollection(target.eyeColor, ["emerald", "amber", "green", "blue", "gold"]))
                    {
                        var color:String = RandomInCollection(["emerald", "amber", "green", "blue", "gold"]);
                        if (target.eyeColorUnlocked(color)) target.eyeColor = color;
                    }
                    
                    kGAMECLASS.output("\n\nYour [pc.eyes] start to water, and no matter how much you blink, your vision just grows fuzzier and fuzzier for several moments before seeming to clear all of a sudden. You pull your Codex out and check your reflection: <b>a pair of [pc.eyeColor] cat-eyes stare back at you, slitted and brilliantly-bright!</b>");
                    target.eyeType = GLOBAL.TYPE_FELINE;
                    changes++;
                }
                else kGAMECLASS.output(target.eyeTypeLockedMessage());
            }
            
            afterTF(target);
        }
        
        private function routeSkinAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            return target.skinType != GLOBAL.SKIN_TYPE_FUR && target.skinTypeUnlocked(GLOBAL.SKIN_TYPE_FUR);
        }
        
        private function routeSkin(target:Creature, usingCreature:Creature = null):void
        {
            var changes:int = 0;
            
            //Grow fur
            if(target.skinType != GLOBAL.SKIN_TYPE_FUR && target.skinTypeUnlocked(GLOBAL.SKIN_TYPE_FUR))
            {
                //From scales
                if(target.skinType == GLOBAL.SKIN_TYPE_SCALES)
                {
                    kGAMECLASS.output("\n\nYou idly scratch at a loose scale, feeling it come loose under your fingers, but the one alongside it is also loose now. You flick it off just before you become aware that the sensation is spreading; scales are dropping like rain now, even without you touching them. Underneath, a lush carpet is springing up from your [pc.skin]. <b>You’re growing fur.</b> You pet yourself to try and get used to the sensation.");
                }
                //From skin
                else
                {
                    kGAMECLASS.output("\n\nYou idly scratch at your arm, but find yourself catching on something. Looking closer, you see a single hair growing from a normally hairless part of your body. A second later, another pops out alongside it... then another, and another... and another. They’re everywhere! Tiny hairs are surfacing all across your body, thickening into a layer of fur before your eyes. <b>You pet your fur as you try to get used to it.</b>");
                }
                target.skinType = GLOBAL.SKIN_TYPE_FUR;
                target.clearSkinFlags();
                changes++;
            }
            
            afterTF(target);
        }
        
        private function routeFaceAvailable(target:Creature, usingCreature:Creature = null):Boolean
        {
            return target.faceType != GLOBAL.TYPE_FELINE && target.faceTypeUnlocked(GLOBAL.TYPE_FELINE) 
			|| target.tongueType != GLOBAL.TYPE_FELINE && target.tongueTypeUnlocked(GLOBAL.TYPE_FELINE)
			|| target.faceType == GLOBAL.TYPE_FELINE && !target.hasFaceFlag(GLOBAL.FLAG_MUZZLED);
        }
        
        private function routeFace(target:Creature, usingCreature:Creature = null):void
        {
            var changes:int = 0;
            
            // feline muzzle
            if(target.faceType != GLOBAL.TYPE_FELINE && target.faceTypeUnlocked(GLOBAL.TYPE_FELINE))
            {
                kGAMECLASS.output("\n\nYou suddenly feel your facial flesh and bones melting and rearranging, reforming into something... different. You check your appearance with your codex's holocorder. <b>You've got a feline muzzle, complete with whiskers and moist nose!</b>");
                target.clearFaceFlags();
                target.faceType = GLOBAL.TYPE_FELINE;
                target.addFaceFlag(GLOBAL.FLAG_MUZZLED);
                changes++;
            }
			else if (target.faceType == GLOBAL.TYPE_FELINE && !target.hasFaceFlag(GLOBAL.FLAG_MUZZLED))
			{
				kGAMECLASS.output("\n\nYou suddenly feel your facial flesh and bones melting and rearranging, reforming into something... different. You check your appearance with your codex's holocorder. <b>Your face elongates into animalistic muzzle!</b>");
                target.addFaceFlag(GLOBAL.FLAG_MUZZLED);
                changes++;
			}
            
            // feline tongue
            if(target.tongueType != GLOBAL.TYPE_FELINE && target.tongueTypeUnlocked(GLOBAL.TYPE_FELINE))
            {
                kGAMECLASS.output("\n\nYour tongue feels strange. ");
                if (target.hasTongueFlag(GLOBAL.FLAG_TAPERED))
                    kGAMECLASS.output("It definitely changes towards a humanoid shape. ");
                kGAMECLASS.output("You gave your palm an experimental lick and found your tongue texture quite rough. It is also more sensitive than before. You feel compulsion to try it... ");
                if (target.hasPerk("Feline Flexibility")) kGAMECLASS.output("On yourself, maybe? ");
                kGAMECLASS.output("<b>You've got a bristly feline tongue!</b>");
                target.tongueType = GLOBAL.TYPE_FELINE;
                var wasLong:Boolean = target.hasTongueFlag(GLOBAL.FLAG_LONG);
                var wasPrehensile:Boolean = target.hasTongueFlag(GLOBAL.FLAG_PREHENSILE);
                target.clearTongueFlags();
                if (wasLong)
                {
                    target.addTongueFlag(GLOBAL.FLAG_LONG);
                    kGAMECLASS.output(" Strangely enough, it preserved its former length.");
                }
                if (wasPrehensile)
                    target.hasTongueFlag(GLOBAL.FLAG_PREHENSILE)
                // some flag would be nice too here...
                target.lust(10+rand(10));
                changes++;
            }
            
            afterTF(target);
        }
        
        private function routeDefault(target:Creature, usingCreature:Creature = null):void
        {
            if (counter == 100) counter = 0; // to allow multiple TFs
            var selectedTF:Function = RandomInCollection(options);
            //output("\n\n");
            options.splice(options.indexOf(selectedTF), 1);
            counter++;
            selectedTF(target);
        }
        
        protected function afterTF(target:Creature, usingCreature:Creature = null):void
        {
            if (options.length > 0 && (counter == 1 && rand(2) == 0 || counter == 2 && rand(4) == 0 || counter == 3 && rand(6) == 0))
            {
                routeDefault(target, usingCreature);
            }
            else
            {
                kGAMECLASS.clearMenu();
                kGAMECLASS.addButton(0, "Next", kGAMECLASS.useItemFunction);
            }
        }
        
        protected function rand(max: Number): Number {
             return int(Math.random() * max);
         }
    }
}
