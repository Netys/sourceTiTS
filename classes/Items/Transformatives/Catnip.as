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
	 * Feline transformative.
	 * 
	 * Have 2 layers of effects. At first, basic layer it is cosmetic transformative, granting "little kitty" appearance, lean and androgynous.
	 * 
	 * Second layer is "legacy code" from another transformative used as base. It is only accessible with improper bypass of nanobots safety protocols. It grants cat-taur body, but much more practical than most tauric forms, with workarounds for most drawbacks of taur body. Based on chakat, but not exactly.
	 * Legacy body features (some can be lore-only, it is not original transformative after all):
	 *   Quadripedal taur with semi-prehensile forelegs.
	 *   Herm (for more effecient reproduction) with internal balls and genital slit (for protection of vulnerable organs).
	 *   Very, very flexible - not exactly at snake level, but can rival any other mammal (mostly lore feat, but makes possible to wave away some "how the fuck taur can do this").
	 *   Neat musclemass and tone balance - they are strong, but they are first of all sentients, so physique was considered secondary stat for them during development.
	 *   Long and prehensile tongue (one more limb? handy!).
	 *   Long and prehensile tail (same reason).
	 *   Note about lactation: they are mammals by all means, but leaking precious nutrients all the time is barely a viable survival strategy. Also, having extra useless weight on chest is not very practical too. They have naturally flat chest unless lactating, and their lactation is easily induced just by prolonged enough nipples stimulation, so anyone can feed a baby when have to, and quickly subsides (not hardlocked though, player can grow breasts by any other way).
	 * 
	 * Special racial feature: Mental Equilibrium. This is one of the "frontier species", and, as well as other of type, has it's attempt to create more stable community.
	 * 
	 * Lore effects:
	 *   They are very friendly (unless abused - they are far from being pacificts).
	 *   Are highly resistant to mind-affecting drugs and poisons (maybe even to point of rejecting bimbofication drugs).
	 *   They are designed to be totally fine without clothes in most but harshest environments, so they have predisposition to nudism, but not to exhibitionism (nakedness itself just doesn't matter for them, though they have no problems with humoring other races nudity taboos when on their territory).
	 * 
	 * Possible gameplay effects:
	 *   Can't have personality score above 60 (being assholes without good reason is nearly physically painful for them).
	 *   Libido gain/loss bonus/penalty pushing towards 30 (friendly in all ways, but not to the point when it becomes problem).
	 *   Extreme alcohol resistance.
	 *   Bonus to chemical-based lust damage resistance (pheromones and drugs), penalty to tease damage resistance, being damaged by foe reduces lust notably and grants stacking tease resistance until combat end (have hard times resisting pure teasers, but being physically attacked turns them off greatly).
	 *   Exhibitionism is hardlocked on "don't care" due to deeply hidden genitals and natural resilience to environmental hazards.
	 *   Have some minimal amount of defence as long as they have their fur. Especially resistant to freezing and possibly poisons.
	 *
	 * @author Etis
	 */
	public class Catnip extends ItemSlotClass
	{
		private var counter:int = 0;
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
			this.longName = "dose of catnip";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a medipen loaded with 'Catnip'";
			//Displayed on tooltips during mouseovers
			this.tooltip = "A new-gen designer transformative, featuring new level of efficiency and consistency. Based on old frontier colonization species project, it causes the user to gain sleek, flexible and very animalistic feline form without any known side effects. No actual catnip included.";
			
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
			counter = 0;
			options = [];
			var pc:Creature = target;
			clearOutput();
			if(target is PlayerCharacter) {
				output("Pressing the activation stud is all it will take. You hold the tip against your arm and brace yourself, pushing the button.");
				if (kGAMECLASS.flags["CATNIP_USED"] == undefined) {
					output(" A quiet-sounding 'snick' hits your ears, but nothing else. Did it even work? You look where you had the pen held. There's a tiny red mark and nothing else. The pen's label displays the word ‘inactive’ in bold red text. It must have a built in painkiller. Suddenly, your codex beeps responding to connection request from injected nanobots.");
					
					output("\n\nDetected feedback-compatible Biosign Monitor device. Aborting automated route. Debug mode activated. System is awaiting input. Please select specific route or confirm default settings. Please note: targeted route is less effective than automated, since it forces override of optimization algorithm.");
					
					kGAMECLASS.flags["CATNIP_USED"] = 1;
				}
				output("\n\n");
				routeMenu(target);
				return true;
			}
			//Not player!
			else
			{
				output(target.capitalA + target.short + " injects the Catnip to no effect.");
			}
			return false;
		}
		
		
		public function routeMenu(target:Creature, force:Boolean = false):void
		{
			author("Etis");
			
			var buttons:int = 1;
			var buffer:String = "";
			
			clearMenu();
			
			counter = 0;
			options = [];
			
			output("Status report:");
			
			if (!force) addButton(13, "Override", function():* { clearOutput(); routeMenu(target, true); }, null, "Override", "Enable override mode. System would attempt to execute route without checking it's availability. Warning: bypassing of safety protocols is not advised.");
			else {
				addButton(13, "Safe", function():* { clearOutput(); routeMenu(target, false); }, null, "Safe", "Enable safe mode. System would check route availability before executing it.");
				output(" status scan is bypassed.");
			}
			
			addButton(14, "Abort", kGAMECLASS.generalInventoryMenu);
			
			buffer += "\nMinor body functions: ";
			if (routeGeneralAvailable(target) || force) {
				buffer += "<b>route available</b>.";
				addButton(buttons++, "Minor", routeGeneral, target, "Minor", "Set of minor changes in body complexion.");
				options.push(routeGeneral);
			}
			else buffer += "route blocked.";
			
			buffer += "\nEars: ";
			if (routeEarsAvailable(target) || force) {
				buffer += "<b>route available</b>.";
				addButton(buttons++, "Ears", routeEars, target, "Ears", "Concentrate on ears.");
				options.push(routeEars);
			}
			else buffer += "route blocked.";
			
			buffer += "\nTail: ";
			if (routeTailAvailable(target) || force) {
				buffer += ("<b>route available</b>.");
				addButton(buttons++, "Tail", routeTail, target, "Tail", "Concentrate on tail.");
				options.push(routeTail);
			}
			else buffer += ("route blocked.");
			
			buffer += ("\nGenitals: ");
			if (routeGenitalsAvailable(target) || force) {
				buffer += ("<b>route available</b>.");
				addButton(buttons++, "Genitals", routeGenitals, target, "Genitals", "Concentrate on breasts and genitals.");
				options.push(routeGenitals);
			}
			else buffer += ("route blocked.");
			
			buffer += ("\nEyes: ");
			if (routeEyesAvailable(target) || force) {
				buffer += ("<b>route available</b>.");
				addButton(buttons++, "Eyes", routeEyes, target, "Eyes", "Concentrate on eyes.");
				if(target.hasTail(GLOBAL.TYPE_FELINE))
					options.push(routeEyes);
			}
			else buffer += ("route blocked.");
			
			buffer += ("\nArms: ");
			if (routeArmsAvailable(target) || force) {
				buffer += ("<b>route available</b>.");
				addButton(buttons++, "Arms", routeArms, target, "Arms", "Concentrate on arms.");
				if(target.hasTail(GLOBAL.TYPE_FELINE) && target.earType == GLOBAL.TYPE_FELINE)
					options.push(routeArms);
			}
			else buffer += ("route blocked.");
			
			buffer += ("\nSkin: ");
			if (routeSkinAvailable(target) || force) {
				buffer += ("<b>route available</b>.");
				addButton(buttons++, "Skin", routeSkin, target, "Skin", "Concentrate on skin.");
				if(target.hasTail(GLOBAL.TYPE_FELINE) && target.earType == GLOBAL.TYPE_FELINE)
					options.push(routeSkin);
			}
			else buffer += ("route blocked.");
			
			buffer += ("\nLegs: ");
			if (routeLegsAvailable(target) && (target.legCount <= 2 && target.legCountUnlocked(2) || target.legCount >= 3 && target.legCountUnlocked(4) || target.legCount >= 5 && target.legCountUnlocked(6)) || force) {
				buffer += ("<b>route available</b>.");
				if (target.legCount <= 2 && target.legCountUnlocked(2) || force)
				{
					addButton(buttons++, "Legs", routeLegs, target, "Legs", "Concentrate on legs.");
					if(target.armType == GLOBAL.TYPE_FELINE)
						options.push(routeLegs);
				}
				else
				{
					buffer += (" Please note, tauric stances are legacy and not included into default route.");
					if (target.legCountUnlocked(2))
					{
						addButton(buttons++, "2 Legs", routeLegs, target, "Two Legs", "Concentrate on legs. Default bipedal humanoid stance route.");
						if(target.armType == GLOBAL.TYPE_FELINE)
							options.push(routeLegs);
					}
					if(target.legCountUnlocked(4))
						addButton(buttons++, "4 Legs", routeLegs4, target, "Four Legs", "Concentrate on legs. Legacy quadripedal tauric stance route.");
					if(target.legCount > 4 && target.legCountUnlocked(6))
						addButton(buttons++, "6 Legs", routeLegs6, target, "Six Legs", "Concentrate on legs. Hexapedal version of legacy tauric stance route.");
				}
			}
			else buffer += ("route blocked.");
			
			buffer += ("\nFace: ");
			if (routeFaceAvailable(target) || force) {
				buffer += ("<b>route available</b>.");
				addButton(buttons++, "Face", routeFace, target, "Face", "Concentrate on face.");
				if(target.skinType == GLOBAL.SKIN_TYPE_FUR && target.earType == GLOBAL.TYPE_FELINE && target.eyeType == GLOBAL.TYPE_FELINE)
					options.push(routeFace);
			}
			else buffer += ("route blocked.");
			
			if (options.length > 0)
				addButton(0, "Default", routeDefault, target, "Default Route", "Let it detect and execute most effective route.");
				
			if (!force) output(buffer);
		}
		
		private function routeGeneralAvailable(target:Creature, usingCreature:Creature = null):Boolean
		{
			var changes:int = 0;
			
			// should get rid of facial hair also
			if (target.thickness > 30 && target.thicknessUnlocked(target.thickness - 10)) changes++;
			if (target.femininity < target.femininityMax() && target.femininityUnlocked(target.femininity + 1)) changes++;
			
			if (target.femininity >= target.femininityMax() && target.femininity < 100 && !target.hasPerk("Androgyny")) changes++;
			
			var buttLimit:Number = 2;
			if (target.mf("", "girl") == "girl") buttLimit = 4;
			if (target.buttRating() > buttLimit && target.buttRatingUnlocked(target.buttRating() - 1)) changes++;
			
			var hipLimit:Number = 2;
			if (target.mf("", "girl") == "girl") hipLimit = 4;
			if (target.hipRating() > hipLimit && target.hipRatingUnlocked(target.hipRating() - 1)) changes++;
			
			if (target.elasticity < (target.hasPerk("Elasticity") ? 4 : 3)) changes++;
			if (target.ass.minLooseness > 1) changes++;
			
			return changes > 0;
		}
		
		private function routeGeneral(target:Creature, usingCreature:Creature = null):void
		{
			if(counter <= 1) clearOutput();
			output("Executing route: body complexion.");
			var changes:int = 0;
			
			// should get rid of facial hair also
			
			// decrease thicknes
			if (target.thickness >= 30 && Mutator.modThickness(target, 30, 10, false))
			{
				output("\n\nSomething is shifting inside you, and you suddenly feel you can move with less effort. <b>Looks like you lose some weight!</b> ");
				changes++;
				
				// increase definition as side effect
				if (target.tone <= 65 && Mutator.modTone(target, 65, 10, false))
				{
					output("Your muscles become a little more defined as you lose some fat.");
				}
			}
			
			var hipLimit:Number = 2;
			if (target.mf("", "girl") == "girl") hipLimit = 4;
			if (target.hipRating() > hipLimit && target.hipRatingUnlocked(target.hipRating() - 1))
			{
				output("\n\nA sudden tightness overtakes your midsection. A searing pain flashes through you, as though your bones themselves were changing. Your hips reshape themselves, becoming more slender, leaving you <b>a little less curvy.</b>");
				target.hipRating( -1);
				changes++;
			}
			
			var buttLimit:Number = 2;
			if (target.mf("", "girl") == "girl") buttLimit = 4;
			if (target.buttRating() > buttLimit && target.buttRatingUnlocked(target.buttRating() - 1))
			{
				output("\n\nYour butt all of a sudden feels tight, as though you were wearing a pair of pants two sizes too small. You wince and grip your buttocks, and feel it losing mass under your hand. After a moment you're left with a much <b>smaller, less curvy butt.</b>");
				target.buttRating( -1);
				changes++;
			}
			
			if (Mutator.modFem(target, 100, 10, false))
			{
				output("\n\nYou feel a slight change in your facial structure. When they finish, <b>you feel less masculine</b>!");
				changes++;
			}
			
			// target is thin, animalistic lips with high overall feminity
			if (target.lipRating() > 0 && target.lipModUnlocked(target.lipMod - 1))
			{
				output("\n\nYou feel your [pc.lips] pucker reflexively, relaxing only to feel thinner and less pouty than before. <b>Your lips are less pronounced.</b>");
				changes++;
				target.lipMod--;
			}
			
			// hit cap and still going up!
			if (target.femininity >= target.femininityMax() && target.femininity < 100 && target.lipRating() <= 0 && !target.hasPerk("Androgyny")) {
				output("\n\nYour [pc.face] is now very confusing - it have imponderable tint of feminity, while lacking distinct femine features. You suspect you could make your apparent gender even more ambiguous.");
				target.createPerk("Androgyny", 0, 0, 0, 0, "No gender limits on facial masculinity or femininity.");
				output("\n\n(<b>Perk Gained: Androgyny</b>)");
			}
			
			//elasticity+
			var elasticityLimit:Number = target.hasPerk("Elasticity") ? 4 : 3;
			if (target.elasticity < elasticityLimit)
			{
				output("\n\nYou shudder violently as waves of pleasure suddenly shoot up in your [pc.vagOrAss]. You guide your fingers inside, finding that <b>you can stretch your insides more than ever before without discomfort</b> despite unaltered tightness.");
				target.lust(10 + rand(5));
				target.elasticity += 1;
				if (target.elasticity > elasticityLimit) target.elasticity = elasticityLimit;
				changes++;
			}
			
			// ass looseness-
			else if(target.ass.minLooseness > 1 || target.ass.wetnessRaw > 1) // no function for ass lock?
			{
				output("\n\nYou feel a rumbling in your gut and a strange half-pleasure sensation spreading up from your [pc.asshole]. <b>Giving your backdoor an experimental poke, your find it ");
				
				if (target.ass.minLooseness > 1) {
					kGAMECLASS.addToList("much more tight")
					target.ass.minLooseness--;
					if (target.ass.minLooseness < 1) target.ass.minLooseness = 1;
					if (target.ass.looseness() > target.ass.minLooseness) target.ass.looseness(target.ass.minLooseness, true);
				}
				if (target.ass.wetnessRaw > 1) {
					kGAMECLASS.addToList("much less wet")
					target.ass.wetnessRaw--;
					if (target.ass.wetnessRaw < 1) target.ass.wetnessRaw = 1;
				}
				output(kGAMECLASS.formatList() + "</b> than it was before!");
				
				target.lust(10+rand(4));
				changes++;
			}
			
			// perks! not actually implemented...
			if(9999 == 0 && target.hasTail(GLOBAL.TYPE_FELINE) && target.legType == GLOBAL.TYPE_FELINE && target.armType == GLOBAL.TYPE_FELINE && target.earType == GLOBAL.TYPE_FELINE && !target.hasPerk("Flexibility"))
			{
				output("\n\nYou feel something odd in your joints. After some experimental stretching you've found yourself able to fold in absolutely unnatural ways - you can easily touch base of your tail with your nose, folding both forward and backward alike! You already have kinky ideas of putting this into some use.");
				output("\n\n(<b>Perk Gained: Flexibility</b> - You can bend and stretch more than most other creatures.)");
				target.createPerk("Flexibility", 0, 0, 0, 0, "You can bend and stretch more than most other creatures.");
				target.lust(20+rand(10));
				changes++;
			}
			
			if(9999 == 0 && target.hasTail(GLOBAL.TYPE_FELINE) && target.legType == GLOBAL.TYPE_FELINE && target.armType == GLOBAL.TYPE_FELINE && target.earType == GLOBAL.TYPE_FELINE && target.hasPerk("Flexibility") && !target.hasPerk("Feline Reflexes"))
			{
				output("\n\nYou suddenly realize how unusually quick and precise your movements are.");
				output("\n\n(<b>Perk Gained: Feline Reflexes</b> - You have unnaturally quick reflexes.)");
				target.createPerk("Feline Reflexes", 0, 0, 0, 0, "You have unnaturally quick reflexes.");
				changes++;
			}
			
			if(9999 == 0 && changes == 0 && target.felineScore() >= 6)
			{
				output("\n\nYou suddenly realize how calm and confident you are.");
				output("\n\n(<b>Perk Gained: Mental Equilibrium</b> - Your mind is very stable and resists any derangements.)");
				target.createPerk("Mental Equilibrium", 0, 0, 0, 0, "Your mind is very stable and resists any derangements.");
				changes++;
			}
			
			afterTF(target);
		}
		
		private function routeGenitalsAvailable(target:Creature, usingCreature:Creature = null):Boolean
		{
			var changes:int = 0;
			
			var maxSize:Number = 4; // big dicks aren't really what cats are about
			if (target.isTaur()) maxSize += 8; // unless we are talking about cat-taurs, ofc
			if (target.hasPerk("Hung")) maxSize *= 1.5; // 6/18
			if (target.hasPerk("Mini")) maxSize *= 0.75; // 4/9
			
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
				if (/*target.vaginas[x].vaginaColor != "pink" ||*/ 
					target.vaginas[x].minLooseness > 1 && target.loosenessUnlocked(x, target.vaginas[x].minLooseness - 1)
					|| target.vaginas[x].wetnessRaw > 2 && target.wetnessUnlocked(x, target.vaginas[x].wetnessRaw - 1)
					) changes++;
				else if(target.vaginas[x].type != GLOBAL.TYPE_FELINE) changes++;
			
			//Ball shrinkage to 1.5 inch
			var limit:Number = 1.5;
			if (target.hasPerk("Bulgy")) limit = 2.5;
			if (target.isTaur()) limit += 6;
			if (target.balls > 0 && target.ballSizeRaw > limit) changes++;
			// uniball if small balls
			if (!target.hasStatusEffect("Uniball") && target.balls > 0 && target.ballSizeRaw <= limit) changes++;
			
			maxSize = target.hasVagina() ? 2 : 0;
			
			for (x = 1; x < target.breastRows.length; x++) {
				if (target.breastRows[x].breastRatingRaw > maxSize && target.breastRatingUnlocked(x, maxSize))  changes++;
				if (target.breastRows[x].nippleType != GLOBAL.NIPPLE_TYPE_INVERTED && target.nippleTypeUnlocked(x, GLOBAL.NIPPLE_TYPE_INVERTED)) changes++
			}
			
			return changes > 0;
		}
		
		private function routeGenitals(target:Creature, usingCreature:Creature = null):void
		{
			if(counter <= 1) clearOutput();
			output("Executing route: genitals.");
			var changes:int = 0;
			
			//Feminine TFs
			for(var x:int = 0; x < target.totalVaginas(); x++)
			{
				if(target.vaginas[x].vaginaColor != "pink" || target.vaginas[0].type != GLOBAL.TYPE_FELINE)
				{
					output("\n\nA tickling, teasing sensation flutters across your nether-lips");
					if(target.totalVaginas() > 1)
					{
						output(" - ");
						if(target.totalVaginas() == 2) output("both sets");
						else output("every single set of them");
					}
					output(", leaving you intensely aware of your own movements.");
					if (target.genitalSpot == 2) {
						output(" You use your Codex to check what's happening");
					}
					else {
						output(" You peek down there to see what’s going on");
						if (!target.isCrotchExposed()) output(", taking special care to move your [pc.lowerGarments] out of the way");
					}
					output(". <b>[pc.EachVagina] ");
					if(target.totalVaginas() == 1) output("is ");
					else output("are ");
					
					if (target.vaginas[0].type != GLOBAL.TYPE_FELINE)
						kGAMECLASS.addToList("thin-lipped")
					if (target.vaginas[x].vaginaColor != "pink")
						kGAMECLASS.addToList("pink")
					output(kGAMECLASS.formatList() + " now!</b>.");
					
					//Go through the list of unpink vags and make 'em pink!
					if (target.vaginas[x].type != GLOBAL.TYPE_FELINE && target.vaginaTypeUnlocked(x, GLOBAL.TYPE_FELINE)) {
						target.shiftVagina(x, GLOBAL.TYPE_FELINE); // need support everywhere to actually work... feline vaginas are generally nearly lipless
					}
					target.vaginas[x].vaginaColor = "pink";
					changes++;
				}
				
				// tighten to 1 and dry up to 2
				if (target.vaginas[x].minLooseness > 1 && target.loosenessUnlocked(x, target.vaginas[x].minLooseness - 1) || target.vaginas[x].wetnessRaw > 2 && target.wetnessUnlocked(x, target.vaginas[x].wetnessRaw - 1))
				{
					output("\n\nYou feel a strange half-pleasure sensation spreading up from your [pc.vagina " + x + "]. <b>Giving your muff an experimental poke, your find it ");
					
					if (target.vaginas[x].minLooseness > 1 && target.loosenessUnlocked(x, target.vaginas[x].minLooseness - 1)) {
						kGAMECLASS.addToList("much more tight")
						target.vaginas[x].minLooseness--;
						if (target.vaginas[x].minLooseness < 1) target.vaginas[x].minLooseness = 1;
						if (target.looseness(x) > target.vaginas[x].minLooseness) target.vaginas[x].looseness(target.vaginas[x].minLooseness, true);
					}
					if (target.vaginas[x].wetnessRaw > 2 && target.wetnessUnlocked(x, target.vaginas[x].wetnessRaw - 1)) {
						kGAMECLASS.addToList("much less wet")
						target.vaginas[x].wetnessRaw--;
						if (target.vaginas[x].wetnessRaw < 2) target.vaginas[x].wetnessRaw = 2;
					}
					output(kGAMECLASS.formatList() + "</b> than it was before!");
					
					target.lust(10 + rand(4));
					changes++;
				}
			}
			
			var maxSize:int = target.hasVagina() ? 2 : 0;
			//if (target.isTaur() && target.isHerm()) maxSize += 2; // chakat legacy, disabled, since not lore friendly
			
			//Breasts down to B-cup/flats, and, unlike Nepeta, you won't get any - this is animalistic TF, and animals, unlike that freaky homos, normally are flat unless lactating
			if(target.breastRows.length > 0 && target.breastRows[0].breastRatingRaw > maxSize && target.breastRatingUnlocked(0, maxSize))
			{
				var tittyDrop:int = 0;
				if(target.breastRows[0].breastRatingRaw >= 12) tittyDrop += target.breastRows[0].breastRatingRaw * .25;
				else if(target.breastRows[0].breastRatingRaw >= 8) tittyDrop += rand(3);
				tittyDrop += 1;
				if (target.breastRatingUnlocked(0, target.breastRows[0].breastRatingRaw - tittyDrop))
				{
					output("\n\nTipping backwards, you flail your arms frantically to keep your balance. Once you right, you realize what happened;  <b>your [pc.chest] have lost a bit of weight, dropping you down to " );
					target.breastRows[0].breastRatingRaw -= tittyDrop;
					output((target.breastRows[0].breastRating(0) > 0 ? target.breastCup(0) : "flats") + ". </b>");
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
					if(bonusRowsTFed == 1) output(" Your other row of breasts shrink a bit as well.");
					else if(bonusRowsTFed > 1) output(" Your other breasts shrink a bit as well.");
				}
			}
			
			// inverted nipples
			for (x = 1; x < target.breastRows.length; x++) {
				var nipLocked:Boolean = false;
				var nipChanged:Boolean = false;
				
				if (target.breastRows[x].nippleType != GLOBAL.NIPPLE_TYPE_INVERTED) {
					if (target.nippleTypeUnlocked(x, GLOBAL.NIPPLE_TYPE_INVERTED)) {
						nipChanged = true;
						target.breastRows[x].nippleType = GLOBAL.NIPPLE_TYPE_INVERTED;
					} else nipLocked = true;
				}
				
				if(nipChanged) {
					output("\n\nAn unpleasent twinge of nerves brings your attention to your [pc.nipples].");
					if(!target.isChestExposed())
						output(" You quickly undress to investigate...");
					output(" They go numb as a slick goo engulfs them. A few tingles replace the feeling and you reflexively wipe the gunk away to reveal that your nipples are gone, but you find what looks pinched holes in their place. Momentary panic subsides when a bit of rubbing has them poking out. <b>Your nipples are now inverted!</b>");
					changes++;
				}
				else if(nipLocked) output("\n\n" + target.nippleTypeLockedMessage());
			}
			
			//Masculine TFs
			//Get a feline dick
			maxSize = 4; // big dicks aren't really what cats are about
			if (target.isTaur()) maxSize += 8; // unless we are talking about cat-taurs, ofc
			if (target.hasPerk("Hung")) maxSize *= 1.5; // 6/18
			if (target.hasPerk("Mini")) maxSize *= 0.75; // 4/9
			
			for(x = 0; x < target.cockTotal(); x++)
			{
				// if type is not feline or lacks flags try major tf
				if(target.cocks[x].cType != GLOBAL.TYPE_FELINE || !target.hasCockFlag(GLOBAL.FLAG_TAPERED) || !target.hasCockFlag(GLOBAL.FLAG_SHEATHED))
				{
					if (target.cockTypeUnlocked(x, GLOBAL.TYPE_FELINE))
					{
						output("\n\nYour [pc.cock " + x + "] throbs suddenly ");
						if (target.cocks[x].hasFlag(GLOBAL.FLAG_SHEATHED)) output("in it's sheath");
						else if (!target.isCrotchExposed()) output("beneath your [pc.lowerGarments]");
						else if(target.legCount == 1) output("on your [pc.leg]");
						else output("between your [pc.legs]");
						output(" and begins to transform. You double over in a sick twist of pain and pleasure");
						if(target.cocks[x].cockColor != "pink")
							output("as the flesh of your cock shifts color to a pink hue");
						if(!target.hasCockFlag(GLOBAL.FLAG_TAPERED)) output(", the skin melding strangely into a long, pointed shape, until the tip is barely wide enough to accommodate your urethra");
						output(".");
						
						if(!target.hasCockFlag(GLOBAL.FLAG_NUBBY))
							output(" Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base and shrink towards the tip. The smallest are barely visible. They are angled towards you, so pulling out now should be even more intense than pushing in.");
						
						//if cock was more than max size:
						if(target.cockLengthUnlocked(x, maxSize)) {
							if(target.cocks[x].cLengthRaw > maxSize) {
								output(" Your prick shrinks. Well, big dicks aren't really what cats are known for.");
								target.cocks[x].cLengthRaw -= Math.min(target.cocks[x].cLength() - maxSize, target.cocks[x].cLengthRaw / 5 + 2 + rand(4));
							}
							else if(target.cocks[x].cLengthRaw < maxSize) {
								output(" Your prick grows longer! Looks like it is small even for cat...");
								target.cocks[x].cLengthRaw += Math.min(maxSize - target.cocks[x].cLength(), target.cocks[x].cLengthRaw / 5 + 2 + rand(4));
							}
							
							output(" It settles on a new length of " + num2Text(int(target.cocks[x].cLength())) + " inches.");
						}
						
						output(" The tip jumps, drooling a [pc.cumVisc] [pc.cumColor] river from its engorged slit.");
						
						if (!target.hasCockFlag(GLOBAL.FLAG_SHEATHED) && !target.hasStatusEffect("Genital Slit"))
							output(" Finally, a sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.");
							
						output("\n\nYou spend a few moments collecting yourself, cleaning the spunk off your <b>" + (target.cocks[x].cType != GLOBAL.TYPE_FELINE ? "new" : "improved") + " kitty pecker</b>.");
						target.lust(20 + rand(20));
						changes++;
						// target.shiftCock(x,GLOBAL.TYPE_FELINE); // not using it since it default function is for kaithrits
						target.cocks[x].cType = GLOBAL.TYPE_FELINE;
						target.cocks[x].cockColor = "pink";
						target.cocks[x].knotMultiplier = 1;
						target.cocks[x].cockFlags = [GLOBAL.FLAG_NUBBY, GLOBAL.FLAG_TAPERED, GLOBAL.FLAG_SHEATHED];
					} else {
						output(target.cockTypeLockedMessage());
					}
				}
				// if already right type try only size change
				else if(target.cockLengthUnlocked(x, maxSize) && target.cocks[x].cLength() != maxSize)
				{
					output("\n\nYour [pc.cock " + x + "] tingles, making your groin feel a little lighter. ");
					
					if(target.cocks[x].cLength() > maxSize) {
						output("It <b>dwindles in size</b>, shrinking to its new length of ");
						target.cocks[x].cLength( -Math.min(target.cocks[x].cLength() - maxSize, 1 + rand(3)));
						output(num2Text(int(target.cocks[x].cLength())) + " inches. Well, big dicks aren't really what cats are known for.");
					}
					else if(target.cocks[x].cLength() < maxSize) {
						output(" Your prick <b>grows longer</b>, extending to its new size of ");
						target.cocks[x].cLength( Math.min(maxSize - target.cocks[x].cLength(), 2 + rand(3)));
						output(num2Text(int(target.cocks[x].cLength())) + " inches.");
					}
					changes++;
					target.lust(10 + rand(5));
				}
			}
			
			//Ball shrinkage to 1.5 inch
			var limit:Number = 1.5;
			if (target.hasPerk("Bulgy")) limit = 2.5;
			if (target.isTaur()) limit += 6;
			if (target.balls > 0 && target.ballSizeRaw > limit)
			{
				var newSize:Number = target.ballSizeRaw;
				newSize -= Math.min(target.ballSizeRaw - limit, formatFloat((target.ballSizeRaw - limit) / 10 + 1 + rand(2), 2));
				if (newSize < limit) newSize = limit;
				
				if (target.ballSizeUnlocked(newSize))
				{
					output("\n\nSomething pinches your [pc.balls] through your [pc.sack], but you can't seem to see anything that could possibly be hurting you down there. That riddle is solved when ");
					if(target.balls > 1) output("they start");
					else output("it starts");
					output(" to diminish before your very eyes, losing mass while your [pc.sack] ");
					
					if(target.hasStatusEffect("Uniball"))
					{
						output("keeps tight around ");
						if(target.balls == 1) output("it");
						else output("them");
					}
					else
					{
						output("keeps pace with ");
						if(target.balls == 1) output("it");
						else output("them");
					}
					if (target.hasStatusEffect("Uniball")) output(" like a vacuum-sealed bag");
					target.ballSizeRaw = newSize;
					output(". <b>You've got " + target.ballsDescript(false, true) + " now.</b>");
					
					changes++;
				}
				else if (!target.ballSizeUnlocked(newSize))
				{
					output(target.ballSizeLockedMessage());
				}
			}
			else if(!target.hasStatusEffect("Uniball") && target.balls > 0)
			{
				output("\n\nYou gasp and bunch your fists as what feels like a soft vice clamps down on your balls, pushing them upwards and inwards. It’s not painful exactly but whatever is happening to them is intense enough for sweat to stand out on your brow. When the sensation dissipates somewhat you slide a hand downstairs uncertainly. <b>You’ve grown a tight-fitting pouch</b> which holds your [pc.balls] up to the back of your thighs.");
				target.lust(10);
				target.createStatusEffect("Uniball", 0, 0, 0, 0, true, "", "", false, 0);
				changes++;
			}
			
			// Chakat surprise, can only happen when you overdose with safety off.
			if (changes == 0)
			{
				output(" Exception: Route have no targets available. Requesting instructions from monitor... Exception: protocol not supported. Fallback route found, executing...");
				
				var surprise:Boolean = false;
				if (!target.hasCock() && target.createCockUnlocked())
				{
					output("\n\nA swollen lump of flesh appears ");
					if(target.balls > 0) output("right above your [pc.sack]");
					else if(target.hasVagina()) output("right above your [pc.vaginas]");
					else output("in the center of your crotch");
					output(". It feels achy and a little painful but very, very sensitive, and it's getting bigger with alarming rapidity. The little knot is sticking an inch out past your [pc.skinFurScales], turning glossy and red as it does. You touch its tip and moan, assaulted by pleasure you barely understand, watching the bulge stretch out another inch in eager response. In seconds, you're rubbing and fondling it, coaxing more and more length from your crotch until ");
					target.createCock();
					target.shiftCock(0, GLOBAL.TYPE_FELINE);
					target.cocks[0].cLengthRaw = 12;
					if (target.hasPerk("Hung")) target.cocks[0].cLengthRaw *= 1.5;
					if (target.hasPerk("Mini")) target.cocks[0].cLengthRaw *= 0.75;
					output("<b>your [pc.hand] is wrapped around a " + num2Text(int(target.cocks[0].cLength())) + "-inch long [pc.cockNounSimple 0].</b>");
					changes++;
					surprise = true;
				}
				
				// since it is "legacy code" of species designed for frontier, can't allow vilnerable organs to dangle free, especially since taurs can't quite defend themselves from behind
				// change anatomy to internal without harming production
				if (target.balls > 0 && target.ballsUnlocked(0))
				{
					output("\n\nA flash of sickening sensation ripples through your [pc.sack], and you can feel the skin pulling upward. The discomfort rises as you close your eyes and realize with some trepidation that your testicle");
					if (target.balls > 1) output("s are");
					else output(" is");
					output(" retreating upward, pulling into your body.");
					
					output(" They shift around, your internal anatomy rearranging to fit your new... configuration. Your testicle");
					if (target.balls > 1) output("s settle");
					else output(" settles");
					output(" in somewhere just above your dick, and all that's left beneath is a smooth patch of skin. No one would ever know you had balls.");
					
					target.makeBallsInternal();
					
					changes++;
					surprise = true;
				}
				
				if (!target.hasVagina() && target.createVaginaUnlocked())
				{
					output("\n\nSweat beads on your suddenly overheated brow. Your heart is pounding, and the air seems obscenely humid. Groaning in discomfort, you press your moist palms against your [pc.belly], feeling your body temperature rise even higher. Swaying uncertainly, you sink to the ground, confused and uncomfortable.");
					output("\n\nThen, you feel it - an unmistakable, pleasant wetness. It isn’t your seemingly omnipresent sweat either, but something else, something altogether slipperier. New-grown nerves revel in your new, slickened state, unveiling a whole new palette of exquisite feelings, revealing a fleshy, sensitive crease ");
					if(target.balls > 0) output("just behind your [pc.balls]");
					else if (target.hasCock()) output("just underneath your [pc.cocks]");
					else output("in your crotch");
					output(". Gingerly, you probe your blossoming vagina. It rewards you with an answering burst of hot, wet ecstasy.");
					output("\n\nFeeling much better, you gingerly remove your [pc.girlCumNoun]-soaked digits from yourself and give the feminine addition a serious look.");
					
					target.createVagina();
					target.shiftVagina(0, GLOBAL.TYPE_FELINE);
					target.clitLength = .25;
					target.vaginas[0].vaginaColor = "pink";
					target.vaginas[0].bonusCapacity = 200; // common taur bonus, and don't forget that elasticity gains
					target.vaginas[0].hymen = false; // this is designed species, no useless, bad design shit here - comes all ready!
					output(" <b>You’ve got a pretty, pink little pussy. </b> You’ll have to spend some quality time with it soon.");
					
					changes++;
					surprise = true;
				}
				
				//for (x = 0; i < target.breastRows.length;) {
					//if (target.breastRows[x].breastRatingRaw > 0 && target.breastRatingUnlocked(x, 0)) break;
					//i++;
				//}
				//if (changes == 0 && x > 0 && i != target.breastRows.length)
				//{
					//output("\n\nYour [pc.fullChest] are absorbed into your body!");
					//
					//for (x = 0; x < target.breastRows.length; x++)
						//if(target.breastRatingUnlocked(x, 0)) target.breastRows[x].breastRatingRaw = 0;
					//
					//if (target.biggestTitSize() > 0) output(" All that remains is [pc.milkNoun]-swollen bubbles beneath your [pc.nipples], which would appear flat witout being filled by [pc.milkNoun].");
					//else output(" All that remains is unremarkable set of [pc.nipples].");
					//
					//changes++;
					//surprise = true;
				//}
				
				// since it is "legacy code" of species designed for frontier, gotta get good protection for vulnerable organs!
				if (target.balls == 0 && target.hasGenitals() && !target.hasStatusEffect("Genital Slit"))
				{
					output("\n\nAn odd sensation overtakes you. Your entire body shivers as flesh is rippling around your [pc.crotch], forming a new... slit? After some experiments with internal muscles, you've found that you can pull your genitals in and push them out at will.");
					if(target.hasCock() && target.hasFullSheaths()) output(" Strangely enough, you still have animalistic sheath, unlike reptiles.");
					output(" Skin of your new folds is surprisingly taut when your genitals are retracted - looks like you have some good protection against low blows from now on!");
					output(" <b>Your genitals are now hidden inside protective slit.</b>");
					target.createStatusEffect("Genital Slit");
					changes++;
					surprise = true;
				}
				
				if(surprise) output("\n\nWhat the hell? Looks like bypassing safety is not always good idea... Well, this isn't worst thing which can happen. At least this surprise is not really unpleasant.");
			}
			
			afterTF(target);
		}
		
		private function routeTailAvailable(target:Creature, usingCreature:Creature = null):Boolean
		{
			return !target.hasTail(GLOBAL.TYPE_FELINE) && (target.tailTypeUnlocked(GLOBAL.TYPE_FELINE) || target.hasTail(GLOBAL.TYPE_COCKVINE));
		}
		
		private function routeTail(target:Creature, usingCreature:Creature = null):void  
		{
			if(counter <= 1) clearOutput();
			output("Executing route: tail.");
			var changes:int = 0;
			
			//Grow feline tail. One tail, since this is not exactly Kaithrit TF. But will keep second Kaithrit tail, if you already have it.
			if(!target.hasTail(GLOBAL.TYPE_FELINE))
			{
				if (target.tailTypeUnlocked(GLOBAL.TYPE_FELINE) || target.hasTail(GLOBAL.TYPE_COCKVINE))
				{
					//{If PC had a tail before: }
					if(target.tailCount == 1) output("\n\nYou feel something itching on your [pc.tail]. Twisting around, you watch in a mix of horror and excitement as [pc.furColor] bristles, the beginnings of a thin coat of fur, sprout up across the length of your reforming posterior appendage. It starts curling and twisting as the change completes, leaving you with a <b>feline tail.</b>");
					//Multitails
					else if(target.tailCount > 1) output("\n\nYour [pc.tails] knot together, torturing you with brief convulsions. A kind of numb heat spreads through them, forcing you to twist about for a visual inspection. They're merging together into a single, narrow entity. The flesh crawls eerily as it assume its new shape. Hairs sprout out of it while you watch, thickening into a coat of [pc.furColor] fur. <b>Your [pc.tails] have combined into a single feline tail.</b>");
					//{If PC is tailless peasant: }
					else
					{
						output("\n\nOuch! A knot of discomfort forms just above your [pc.butt] as if it had suffered a nasty sting or bite, but no such injury occurred. You twist for a look at it");
						if(!target.isAssExposed()) output(", peeling back your [pc.underGarments]");
						output(". There's a raised, irritated lump there, and it's getting bigger. Wiggling slightly, it extends as new bones form within it, gently wagging as it lengthens. You're growing a tail! Fine hairs sprout on its [pc.skin], giving it a distinctly feline cast. When it finishes growing, it's long enough to begin curling and twisting vigorously; <b>you've obviously gained a feline tail.</b>");
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
						output(" The tip of your tail feels strange. After some probing you've found your tail genitalia still present, but totally unnoticeable under a furry sheath when not aroused");
						if(target.tailType == GLOBAL.TYPE_COCKVINE) output(" and much less prone to act by itself");
						output(".");
					} else target.clearTailFlags();
					
					target.tailCount = 1;
					target.tailType = GLOBAL.TYPE_FELINE;
					target.addTailFlag(GLOBAL.FLAG_LONG);
					target.addTailFlag(GLOBAL.FLAG_FURRED);
					// FIXME: according to codex, felines should also have FLAG_PREHENSILE...
					changes++;
				}
				else output(target.tailTypeLockedMessage());
			}
			
			if (changes == 0 && target.hasTail(GLOBAL.TYPE_FELINE) && !target.hasTailFlag(GLOBAL.FLAG_PREHENSILE))
			{
				output(" Exception: Route have no targets available. Requesting instructions from monitor... Exception: protocol not supported. Fallback route found, executing...");
				
				output("\n\nYour [pc.tails] suddenly starts curling and twisting, growing even longer and notably thicker. <b>You [pc.tails] " + (target.tailCount > 1 ? "are" : "is") + " now prehensile.</b>");
				
				target.addTailFlag(GLOBAL.FLAG_PREHENSILE);
				changes++;
				
				output("\n\nLooks like bypassing safety can be a good idea sometimes! Your appendage" + (target.tailCount > 1 ? "s are" : " is") + " definitely better now.");
			}
			
			afterTF(target);
		}
		
		private function routeEarsAvailable(target:Creature, usingCreature:Creature = null):Boolean
		{
			return target.earType != GLOBAL.TYPE_FELINE && target.earTypeUnlocked(GLOBAL.TYPE_FELINE);
		}
		
		private function routeEars(target:Creature, usingCreature:Creature = null):void
		{
			if(counter <= 1) clearOutput();
			output("Executing route: ears.");
			var changes:int = 0;
			
			//Grow cat ears!
			if(target.earType != GLOBAL.TYPE_FELINE)
			{
				if (target.earTypeUnlocked(GLOBAL.TYPE_FELINE))
				{
					if (InCollection(target.earType, [GLOBAL.TYPE_HUMAN, GLOBAL.TYPE_HUMANMASKED, GLOBAL.TYPE_SYLVAN]))
						output("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. ");
					else output("\n\n");
					
					output("Your ears begin to tingle. You reach up with one hand and gently rub them. Your ears twist and morph, growing a thin layer of " + target.furColor + " fur as they reshape into a pair of points, towering over your head. You experimentally move them, feeling them swivel about at your command. And you can hear so much better than before, every slight creak and rustle around you is so clear now! <b>You now have feline ears!</b>");
					target.earType = GLOBAL.TYPE_FELINE;
					changes++;
				}
				else output(target.earTypeLockedMessage());
			}
			
			afterTF(target);
		}
		
		private function routeArmsAvailable(target:Creature, usingCreature:Creature = null):Boolean
		{
			return target.armType != GLOBAL.TYPE_FELINE && target.armTypeUnlocked(GLOBAL.TYPE_FELINE) || target.armType == GLOBAL.TYPE_FELINE && !target.hasArmFlag(GLOBAL.FLAG_FURRED);
		}
		
		private function routeArms(target:Creature, usingCreature:Creature = null):void
		{
			if(counter <= 1) clearOutput();
			output("Executing route: arms.");
			var changes:int = 0;
			
			//Change arm type to furred. Only after tail and ears.
			if(target.armType != GLOBAL.TYPE_FELINE)
			{
				if (target.armTypeUnlocked(GLOBAL.TYPE_FELINE))
				{
					if(!target.hasFur())
					output("\n\nYou feel a powerful itch spread across your arms. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a dark mat across your [pc.skin]. Within a few minutes, your arms are utterly covered in a thick, silky-smooth " + target.furColor + " fur! ");
					else output("\n\n")
					output("You ball a hand into a fist, only to feel the softest little pads pressing into your palm. Opening your digits, you marvel at the appearance of small, [pc.skinTone] pads on the tips of your fingers. A larger one stretches across the top of your palm. They’re soft as hell and might feel pretty good in certain... tender areas. <b>You’ve got paw-like feline arms, complete with retractable claws and padded palms!</b>");
					// actually, would be nice to have different color for pawpads... use nipple colors, maybe?
					target.armType = GLOBAL.TYPE_FELINE;
					target.clearArmFlags();
					target.addArmFlag(GLOBAL.FLAG_FURRED);
					target.addArmFlag(GLOBAL.FLAG_PAWS);
					changes++;
				}
				else output(target.armTypeLockedMessage());
			}
			else if (target.armType == GLOBAL.TYPE_FELINE && !target.hasArmFlag(GLOBAL.FLAG_FURRED))
			{
				output("\n\nYou feel a powerful itch spread across your arms. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a dark mat across your [pc.skin]. Within a few minutes, your arms are utterly covered in a thick, silky-smooth " + target.furColor + " fur! ");
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
			if(counter <= 1) clearOutput();
			output("Executing route: legs.");
			var changes:int = 0;
			
			// Change leg-type to furred feline, can retain tauric form
			if(target.legType != GLOBAL.TYPE_FELINE)
			{
				if (target.legTypeUnlocked(GLOBAL.TYPE_FELINE))
				{
					if (!target.hasLegFlag(GLOBAL.FLAG_FURRED) && !target.hasFur()) output("\n\nYou feel a powerful itch spread across your [pc.legs]. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a [pc.furColor] mat across your [pc.skin]. Within a few minutes, your legs are utterly covered in a thick, silky-smooth [pc.furColor] fur! ");
					
					if(target.legCount < 2) // naga to biped
					{
						output("\n\nYour [pc.leg] wobbles then folds, dropping you onto your [pc.butt]. It thrashes wildly around, uncontrolled and spasmatic. Something inside is changing, and you're helpless to do anything but clench your fists and hold on for the ride. A seam appears in your [pc.leg] a moment before it divides into <b>two leg-like shapes.</b>");
						target.legCount = 2;
					}
					// More than biped to cat-taur/chakat, fix non-even leg count.
					else if (target.legCount > 2)
					{
						output("\n\nTwitching wildly, your [pc.legs] give out, dumping you to the floor in a heap of uncoordinated, splayed limbs. They twitch wildly as they reform, starting at your waist and spreading down. Their bones melt like butter as they flow into new shapes.");
						
						if (target.legCount > 4 && count == 4) // 50% to get "normal" taur body if have too much legs
						{
							output(" The front four do anyway. <b>Your body shortens up behind them, becoming more traditionally tauric in shape and size.</b>");
							target.legCount = 4;
						}
						else if (target.legCount > 6 && count == 6) // 6 legs is enough. Really.
						{
							output(" The front six do anyway. <b>Your body shortens up behind them, becoming more traditionally tauric in shape and size.</b>");
							target.legCount = 6;
						}
						else if ((target.legCount / 2) != Math.round(target.legCount / 2)) // 3/5 legs? I have no idea what the hell it can be.
						{
							target.legCount = count;
							output(" <b>Your body now has an even count of legs, becoming more traditionally tauric in shape and size.</b>");
						}
						else if(target.legCount != count)
						{
							target.legCount = 2;
							output(" You feel your bones and organs changing place, steadily mutating until it no longer resembles the body of a beast, but a human. Your additional legs are absorbed, drawing into your vanishing lower body until <b>you have a bipedal humanoid figure</b>.");
						}
					}
					else output("\n\nYou drop to the ground as your [pc.legs] go boneless. The jarring impact is enough to make you wince, but of far more concern is what's happening below your bruised bottom. Your [pc.legs] are changing!");
					
					output("\n\n Your joints feel very odd, and your soles reform into padded paws with toes tipped by sharp-looking claws. It'll take a little bit of practice to get used to walking with these. After few steps you've found pads of your new paws incredibly sensitive, almost like your tongue - even just feeling ground texture under you is exquisite. You feel a compulsion to walk barefoot from now on. <b>You’ve got digitigrade feline legs, complete with soft paw pads and retractable claws!</b>");
					
					target.legType = GLOBAL.TYPE_FELINE;
					target.clearLegFlags();
					target.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
					target.addLegFlag(GLOBAL.FLAG_PAWS);
					target.addLegFlag(GLOBAL.FLAG_FURRED);
					changes++;
				}
				else output(target.legTypeLockedMessage());
			}
			else if (target.armType == GLOBAL.TYPE_FELINE && (!target.hasLegFlag(GLOBAL.FLAG_FURRED) || !target.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) || !target.hasLegFlag(GLOBAL.FLAG_PAWS)))
			{
				if (!target.hasLegFlag(GLOBAL.FLAG_FURRED) && !target.hasFur()) output("\n\nYou feel a powerful itch spread across your [pc.legs]. You clutch at them, scratching violently as your hair grows and thickens, spreading out into a [pc.furColor] mat across your [pc.skin]. Within a few minutes, your legs are utterly covered in a thick, silky-smooth [pc.furColor] fur! ");
				if (!target.hasLegFlag(GLOBAL.FLAG_PAWS) || !target.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE)) output("\n\n Your joints feel very odd, and your soles reform into padded paws with toes tipped by sharp-looking claws. It'll take a little bit of practice to get used to walking with these. <b>You’ve got digitigrade feline legs, complete with soft paw pads and retractable claws!</b>");
				target.addLegFlag(GLOBAL.FLAG_DIGITIGRADE);
				target.addLegFlag(GLOBAL.FLAG_PAWS);
				target.addLegFlag(GLOBAL.FLAG_FURRED);
				changes++;
			}
			
			if (changes == 0 && target.legType == GLOBAL.TYPE_FELINE && target.hasLegFlag(GLOBAL.FLAG_DIGITIGRADE) && target.legCount == 2 && target.legCountUnlocked(4))
			{
				output(" Exception: Route have no targets available. Requesting instructions from monitor... Exception: protocol not supported. Fallback route found, executing...");
				
				output("\n\nTerror overtakes you as you feel your backbone snap.  It doesn't stop, as you feel your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes. <b>You now have tauric lower half!</b>");
				
				target.legCount = 4;
				
				if (target.genitalSpot != 2) {
					if(target.hasGenitals()) output("  After taking a moment to get used to your new body, you notice that your genitals now reside between the hind legs of your [pc.lowerBody].");
					target.genitalSpot = 2;
				}
				
				output("\n\nYour forelegs aren't just legs - while not exactly prehensile, your toes are quite long and nimple, providing you with some portion of manual-like dexterity.");
				output("\n\nThat part of your body between pairs of your legs is just a little longer than your body above waist, so you can sit on your butt comfortably while ‘standing’ on your forelegs.");
				if (target.hasTail() && target.hasTailFlag(GLOBAL.FLAG_LONG)) output("You can't help but smile seeing your [pc.tails] instinctively wrapping your forelegs in adorably animalistic fashion while in such position.");
				output("\n\nJoint point where your back bends is very flexible, as well as your spine generally - you can effortlessly reach any part of your body. At least you can wipe up your ass without outside help.");
				changes++;
				
				output("\n\nLooks like bypassing safety is not always good idea... Well, at least you are not reduced to a puddle of goo, right?");
			}
			
			afterTF(target);
		}
		
		private function routeEyesAvailable(target:Creature, usingCreature:Creature = null):Boolean
		{
			return target.eyeType != GLOBAL.TYPE_FELINE && target.eyeTypeUnlocked(GLOBAL.TYPE_FELINE);
		}
		
		private function routeEyes(target:Creature, usingCreature:Creature = null):void
		{
			if(counter <= 1) clearOutput();
			output("Executing route: eyes.");
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
					
					output("\n\nYour [pc.eyes] start to water, and no matter how much you blink, your vision just grows fuzzier and fuzzier for several moments before seeming to clear all of a sudden. You pull your Codex out and check your reflection: <b>a pair of [pc.eyeColor] cat-eyes stare back at you, slitted and brilliantly-bright!</b>");
					target.eyeType = GLOBAL.TYPE_FELINE;
					changes++;
				}
				else output(target.eyeTypeLockedMessage());
			}
			
			afterTF(target);
		}
		
		private function routeSkinAvailable(target:Creature, usingCreature:Creature = null):Boolean
		{
			return target.skinType != GLOBAL.SKIN_TYPE_FUR && target.skinTypeUnlocked(GLOBAL.SKIN_TYPE_FUR);
		}
		
		private function routeSkin(target:Creature, usingCreature:Creature = null):void
		{
			if(counter <= 1) clearOutput();
			output("Executing route: skin.");
			var changes:int = 0;
			
			//Grow fur
			if(target.skinType != GLOBAL.SKIN_TYPE_FUR && target.skinTypeUnlocked(GLOBAL.SKIN_TYPE_FUR))
			{
				//From scales
				if(target.skinType == GLOBAL.SKIN_TYPE_SCALES)
				{
					output("\n\nYou idly scratch at a loose scale, feeling it come loose under your fingers, but the one alongside it is also loose now. You flick it off just before you become aware that the sensation is spreading; scales are dropping like rain now, even without you touching them. Underneath, a lush carpet is springing up from your [pc.skin]. <b>You’re growing fur.</b> You pet yourself to try and get used to the sensation.");
				}
				//From skin
				else
				{
					output("\n\nYou idly scratch at your arm, but find yourself catching on something. Looking closer, you see a single hair growing from a normally hairless part of your body. A second later, another pops out alongside it... then another, and another... and another. They’re everywhere! Tiny hairs are surfacing all across your body, thickening into a layer of fur before your eyes. <b>You pet your fur as you try to get used to it.</b>");
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
			if(counter <= 1) clearOutput();
			output("Executing route: face.");
			var changes:int = 0;
			
			// feline muzzle
			if(target.faceType != GLOBAL.TYPE_FELINE && target.faceTypeUnlocked(GLOBAL.TYPE_FELINE))
			{
				output("\n\nYou suddenly feel your facial flesh and bones melting and rearranging, reforming into something... different. You check your appearance with your codex's holocorder. <b>You've got a feline muzzle, complete with whiskers and moist nose!</b>");
				target.clearFaceFlags();
				target.faceType = GLOBAL.TYPE_FELINE;
				target.addFaceFlag(GLOBAL.FLAG_MUZZLED);
				changes++;
			}
			else if (target.faceType == GLOBAL.TYPE_FELINE && !target.hasFaceFlag(GLOBAL.FLAG_MUZZLED))
			{
				output("\n\nYou suddenly feel your facial flesh and bones elongating and protruding forward. You check your appearance with your codex's holocorder. <b>Your face elongates into animalistic muzzle!</b>");
				target.addFaceFlag(GLOBAL.FLAG_MUZZLED);
				changes++;
			}
			
			// feline tongue
			if(target.tongueType != GLOBAL.TYPE_FELINE && target.tongueTypeUnlocked(GLOBAL.TYPE_FELINE))
			{
				output("\n\nYour tongue feels strange. ");
				if (target.hasTongueFlag(GLOBAL.FLAG_TAPERED))
					output("It definitely changes towards a humanoid shape. ");
				output("You gave your [pc.hand] an experimental lick and found it's texture quite rough. It is also more sensitive than before. You feel compulsion to try it... ");
				if (target.hasPerk("Flexibility")) output("On yourself, maybe? ");
				output("<b>You've got a bristly feline tongue!</b>");
				
				var wasLong:Boolean = target.hasTongueFlag(GLOBAL.FLAG_LONG);
				var wasPrehensile:Boolean = target.hasTongueFlag(GLOBAL.FLAG_PREHENSILE);
				
				target.tongueType = GLOBAL.TYPE_FELINE;
				target.clearTongueFlags();
				target.addTongueFlag(GLOBAL.FLAG_NUBBY);
				
				if (wasLong || wasPrehensile)
				{
					output(" Strangely enough, it preserved its former ");
					
					enum.clear();
					if (wasLong) {
						enum.push("length")
						target.addTongueFlag(GLOBAL.FLAG_LONG);
					}
					if (wasPrehensile) {
						enum.push("dexterity")
						target.addTongueFlag(GLOBAL.FLAG_PREHENSILE);
					}
					output(enum.toString() + ".");
				}
				target.lust(10 + rand(10));
				changes++;
			}
			
			if (changes == 0 && target.faceType == GLOBAL.TYPE_FELINE && target.tongueType == GLOBAL.TYPE_FELINE && !(target.hasTongueFlag(GLOBAL.FLAG_LONG) && target.hasTongueFlag(GLOBAL.FLAG_PREHENSILE)))
			{
				output(" Exception: Route have no targets available. Requesting instructions from monitor... Exception: protocol not supported. Fallback route found, executing...");
				
				output("\n\nYour [pc.tongue] suddenly falls out of your mouth and begins undulating as it grows longer.  For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb.  You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point it looks like a normal tongue.  <b>You now have long, prehensile tongue.</b>");
				
				target.addTongueFlag(GLOBAL.FLAG_LONG);
				target.addTongueFlag(GLOBAL.FLAG_PREHENSILE);
				changes++;
				
				output("\n\nWell, this isn't worst thing which can happen - you already have some kinky ideas how to make use of this new ‘limb’...");
			}
			
			afterTF(target);
		}
		
		private function routeDefault(target:Creature, usingCreature:Creature = null):void
		{
			var selectedTF:Function = RandomInCollection(options);
			options.splice(options.indexOf(selectedTF), 1);
			counter++;
			selectedTF(target);
		}
		
		protected function afterTF(target:Creature, usingCreature:Creature = null):void
		{
			//trace("After TF: " + counter + ", " + options.length)
			if (options.length > 0 && counter > 0 && rand(counter + 1) == 0)
			{
				output("\n\n");
				routeDefault(target, usingCreature);
			}
			else
			{
				clearMenu();
				addButton(0, "Next", kGAMECLASS.useItemFunction);
			}
		}
	}
}
