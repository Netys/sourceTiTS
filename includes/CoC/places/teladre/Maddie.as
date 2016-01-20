import classes.GLOBAL;
import classes.Items.Drinks.CoCLustDraft;
import classes.Items.Transformatives.CoCBeeHoney;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//VARS
// 240- first time meeting procced? 1 yes
// 241- mino explained what he needs yet?
// 242- baking happaned?  1 = yes, -1 = snuck out, -2 = seen her escorted out
	//, 3 =stayed, 4 = epilogue'ed
//[Bakery One Off – Madeleine's Creation]
internal function procMaddieOneIntro():void {
	clearOutput();
	if(flags["COC.BAKERY_MADDIE_CHEF_OFFER"] == undefined) {
		output("You enter the bakery, savoring the sweet smells of sugar and baked goods.  A burly, hairy figure steps up beside you and places a strong hand on your shoulder.   The gravelly voice of the stranger says, \"<i>You ain't from around here.  Come.  I need your help.  Show you something.</i>\"  You turn to look, and are quite surprised when you see the horned visage of a minotaur ");
		if(pc.tallness < 72) output("looking down at");
		else if(pc.tallness < 100) output("staring levelly at");
		else output("glaring up at");
		output(" you. It releases your shoulder and starts walking towards an 'employees only' door.  Do you follow?\n\n");
		flags["COC.BAKERY_MADDIE_CHEF_OFFER"] = 1;
	}
	//(REPEAT) 
	else {
		output("You walk into the bakery and a burly, hair-covered arm grabs your shoulder.  The familiar voice of a minotaur barks, \"<i>You.  You can help.  Come.</i>\"  You turn, but he's already walking towards an 'employees only' door.  Do you follow?");
	}
	processTime(1);
	clearMenu();
	addButton(0, "Yes", followMinotaurIntoBackroom);
	addButton(1, "No", bakeryuuuuuu);
}

//[Follow] 
private function followMinotaurIntoBackroom():void {
	clearOutput();
	//	(Not yet explained) 
	if(flags["COC.BAKERY_MADDIE_CHEF_OFFER_EXPLAINED"] == undefined) {
		output("You follow the burly beast through the door, turning several times as he leads you through the blisteringly hot ovens.  The minotaur is sweating heavily by the time you reach his destination, and for that matter so are you.  With all the musk boiling off of him, you find yourself wondering if he was just setting up an elaborate ruse to lure you into a sexual situation.  He grabs a white, fluffy hat and drops it on his head, firmly dispelling that notion as he tries to explain in as few words as possible, \"<i>I am cook.  I make great éclairs, but making masterpiece now.  Need special ingredients.  You get to leave city.  Bring me lust draft and honey.  Not pure stuff, too strong. Go.</i>\"\n\n");
		output("You get a chance to look over his work station, noting the many bowls of batter, hundreds of massive eclairs, and the largest onahole you've ever seen.  ");
		if (pc.slut() >= 66 || pc.hasPerk("Minotaur Cum Addict")) output("You lick your lips when you realize you're meeting the source of the 'special' éclairs.");
		else output("You blush when you realize what he must be using for cream filling.");
		
		flags["COC.BAKERY_MADDIE_CHEF_OFFER_EXPLAINED"] = 1;
		processTime(3);
		clearMenu();
		//[Give Them] [Leave]
		if (pc.hasItem(new CoCBeeHoney()) && pc.hasItem(new CoCLustDraft())) {
			addButton(0, "Give Them", handOverIngredientsItBeBakingTimeYo);
			addButton(1, "Leave", nopeAintGotNoneODemSpeculIngredimathings);
		}
		else {
			addButton(0, "Next", bakeryuuuuuu);
		}
	}
	//(Explained) 
	else {
		output("You follow the burly chef through the door, winding through the familiar ovens.  By the time you reach his work area, you're both covered in a fine sheen of sweat and you find yourself responding to the minotaur musk unconsciously.  The strange chef turns to ask, \"<i>You have special ingredients now, yes?</i>\"");
		//[Yes] [Lie – No/Not Yet]
		processTime(2);
		clearMenu();
		if (pc.hasItem(new CoCBeeHoney()) && pc.hasItem(new CoCLustDraft())) {
			addButton(0, "Yes", handOverIngredientsItBeBakingTimeYo);
			addButton(1, "Lie - No", nopeAintGotNoneODemSpeculIngredimathings);
		}
		else {
			addDisabledButton(0, "Yes");
			addButton(1, "No", nopeAintGotNoneODemSpeculIngredimathings);
		}
	}
}

//[Not Yet/No]
public function nopeAintGotNoneODemSpeculIngredimathings():void {
	clearOutput();
	output("The chef sighs and slams a fist into the counter hard enough to dent the metal and throw the bowls full of dough inches into the air.  A number of empty éclairs bounce and roll everywhere.  The minotaur looks back at you and snorts, \"<i>Best you go.  Don't come without ingredients.</i>\"\n\n");
	
	output("Well, no point in ");
	if(pc.cor() > 50 || pc.isAss()) output("starting a fight inside Tel'Adre");
	else output("overstaying your welcome");
	output(" – you depart.");
	
	processTime(2);
	clearMenu();
	addButton(0, "Next", bakeryuuuuuu);
}

//[Yes – baking]
public function handOverIngredientsItBeBakingTimeYo():void {
	clearOutput();
	pc.destroyItem(new CoCBeeHoney());
	pc.destroyItem(new CoCLustDraft());
	output("You hand the lust draft and bottled honey to the minotaur, doing your best to ignore his potent, lust-inducing pheromones as you watch him work.  He grabs the batch of dough he had been kneading and pours in the lust draft, snorting aggressively once the bubbling drug's smell reaches his bovine nostrils.  Next, the bull-like chef reaches over to grab a bottle marked 'P.S.M.', uncorking and pouring it in one practiced motion.   The white fluid froths dangerously on contact with the pink lust draft, and a second later the honey is in there too.  Finally, he flips up his loincloth and reaches for the onahole.\n\n");
	
	output("The sex-toy drips with lubricant and twists in the minotaur's hands, indicating magical enhancement or goblin manufacture.  He slides in, sighing as his four, basketball-sized testes pull close to his body, twitching.  Two quick pumps later, he's howling, hips twitching as spurts of white leak from the onahole into the bowl.  With remarkable restraint, he stops himself after adding a cup of spunk, even though his balls are still huge and quivering.");
	if(pc.hasPerk("Minotaur Cum Addict")) output("  You lurch forward involuntarily, craving the rest of his jism, but he pushes you into the wall and grunts, \"<i>No,</i>\" in a tone that brooks no disagreement.  It actually shocks you out of your addicted haze.");
	output("\n\n");
	
	output("Grabbing a whisk, the bull-man starts stirring the sex-filled dough with vigor, mixing the thickening blend hard enough to make his biceps ripple.  A moment later, he lifts the bowl one-handed and pulls out a giant, novelty cupcake mold from the counter. After filling the mold, the chef throws it onto his burly shoulder and grabs a sack of actual icing.  A terse grunt instructs, \"<i>Wait at tables.  You can try some when done.</i>\"  ");
	if(pc.hasPerk("Minotaur Cum Addict")) output("  Your mouth salivates at the thought.");
	else output("You aren't sure you want to.");
	output("\n\n");
	
	processTime(4);
	clearMenu();
	if(pc.hasPerk("Minotaur Cum Addict")) addButton(0, "Next", waitForSlutCake);
	//[Wait] [Sneak Out]
	else {
		addButton(0, "Wait", waitForSlutCake);
		addButton(1, "Sneak Out", sneakAwayFromMaddie);
	}
}

//[Sneak Out]
private function sneakAwayFromMaddie():void {
	clearOutput();
	output("You get out before he can find you again.  Whatever he's making is nothing you ever want to taste.");
	//(No more mino chef)
	flags["COC.BAKERY_MADDIE_STATE"] = -2;
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Wait/Next]
private function waitForSlutCake():void {
	//spriteSelect(39);
	clearOutput();
	output("You walk back into the bakery proper, feeling more than a little ");
	if(pc.slut() < 33) output("antsy");
	else if(pc.slut() < 66) output("nervous about this whole thing");
	else output("intrigued by this whole thing");
	output(".  One of the waitresses brings you a glass of milk, and ");
	if(pc.slut() < 50) output("it smells normal enough, so you go ahead and sip on it");
	else output("you sip on it while you wait");
	
	output(".  After what feels like an eternity, you get sick of waiting and push through the door into the bakery's backrooms to see what the hold-up is.  The minotaur isn't at his usual workstation, and doesn't look to have been there in quite some time.\n\n");
	
	output("Where could he have gone?  You backtrack through the ovens, looking down side-paths and searching through the labyrinthine storage rooms.  Just when you're about to give up, you hear an airy, light-headed giggle from the next room.  You peek around the corner and gasp in absolute shock.  The minotaur is pinned to the wall, his wrists stuck in place by what looks like hardened, white icing.   On top of him is the strangest - no, ONLY, cupcake-woman you've ever seen.\n\n");
	
	output("She's taller than the imprisoned minotaur, and wider too.  The pastry-girl's skin is slightly porous, colored light chocolate and gleaming in the dim light where it isn't covered by shining, blue-iced 'clothes'.  Her hair is white as whipped cream, and tied back with a cinnamon bun.  Her curvaceous form turns, jiggling ever so slightly as she takes you in with her green, gum-drop eyes and revealing her whipped-cream bra.  The novelty cup-cake mold is balanced atop her head, worn like a comparatively tiny fez.\n\n");
	
	output("The minotaur chef is still wearing his poofy hat, but he's pinned completely and irrevocably under this baked behemoth as she bounces and grinds on his convulsing member.  While you watch, his balls shrink smaller and smaller, emptying their pent up, steamy cargo directly into the cupcake's soft, cushiony center.  She grows larger from the sudden intake of fresh jism, giggling as she drains every drop from her creator.  \"<i>Tee-hee!  Mmm, you're like, delicious and stuff, creat- cr... dad!  So sticky and yummy, just like me!</i>\" exclaims the fluffy slut-cake.\n\n");
	
	output("Utterly shocked and drained, the chef-o-taur's eyes roll back in his sockets.  He slumps weakly under his creation as she bounces a few last times, futilely trying to squeeze more cum from the slumping minotaur-dick.  The cupcake-girl rises at last, not with yeast, but with a new-found purpose.  The reflective, alien surface of her eyes locks against your groin as she takes one lumbering step after another in your direction.  Her massive, spongy tits wobble dangerously close to you, nearly entrancing you with their beautiful, unnatural curves.\n\n");
	
	output("Running seems like a very good idea.  Who knows what she has planned for you?");
	
	processTime(45);
	clearMenu();
	//[RUN] [TRY TO TALK]
	addButton(0, "Run Away", runAwayFromMaddiiiieee);
	addButton(1, "TryToTalk", talkToMaddie);
}
//[RUN DAFUQ AWAY]
private function runAwayFromMaddiiiieee():void {
	//spriteSelect(39);
	clearOutput();
	output("You turn tail to run, evacuating the room before that culinary catastrophe can have her way with you.  A high-pitched whine chases you away as the cupcake-girl cries, \"<i>Nooooo... come back!  I'm making so much filling for you!</i>\"  Her words lend you even greater speed, and you vacate the city in record time.\n\n");
	flags["COC.BAKERY_MADDIE_STATE"] = -1;
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
//[Followup to run away]
public function runAwayMaddieFollowup():void {
	//spriteSelect(39);
	clearOutput();
	flags["COC.BAKERY_MADDIE_STATE"] = -2;
	output("You return to a strange sight indeed.  Urta and Edryn are leading a procession of over thirty city guards, arranged in a loose circle around the cupcake-girl.  Her comparatively tiny, tin-foil fez is gone, along with most of her blue-iced 'armor'.  She looks weak, pathetic, and beaten as she's prodded with spears and escorted from the city, never to return again.  Vanilla-scented tears stain the pavement behind her, leaving a trail the whole way back to the bakery.\n\n");
	processTime(3);
	clearMenu();
	addButton(0, "Next", telAdreMenu);
}
	
//[TRY TO TALK]
private function talkToMaddie():void {
	//spriteSelect(39);
	clearOutput();
	output("You try to speak as calmly as you can in the face of a giant, jiggling sex-pastry, but she ignores your demands to 'wait', 'listen', or 'stop'.  Sponge-cake-soft fists envelop your arms, lifting you from the ground to pin you against some flour sacks.   The cherries covering the cupcake-girl's whipped-cream bra drop off, pushed away by two candy-pink nipples the size of water bottles.  As one, they discharge thick splorts of thick, gooey icing to splatter over the length of your exposed arms.  It hardens nigh-instantaneously in the comparatively cool air, and you're helpless to do anything but squirm as she applies the same treatment to your " + pc.legs() + ", immobilizing you completely.\n\n");
	output("The cock-crazed confection looks down at you and nods, a satisfied smile spreading over glistening, pale blue lips.  She breathlessly exclaims, \"<i>My creat- cr... Dad ");
	if(pc.hasCock()) output("is like, all out of icing mix!  So I'm going to borrow a few cups from you, 'kay?");
	else output("gave me so much icing mix, and you like, would look soooo much better with some vanil- van... yummy frosting!");
	output("</i>\"  She's... what!?\n\n");
	//(FORK BETWEEN MALE/NONMALE)
	//(MALE)
	if(pc.hasCock()) {
		var x:Number = pc.cockThatFits(60);
		if (x < 0) x = 0;
		output("\"<i>Dad said my name is Madeleine, but that's no fun.  Just call me Maddie.  You've got lots of icing like Dad, right?  I-I... need more icing.  It's in my recipe,</i>\" says Maddie.  The baked broad strips your [pc.gear] to expose your [pc.cocksLight].  Cooing with excitement, she examines your ");
		if(pc.lust() >= 75) output("rock-hard");
		else output("hardening");
		output(" shaft");
		if(pc.cockTotal() > 1) output("s");
		output(", running a sponge-soft hand over the love-muscle.  You rock your hips, trying to squirm away.  Maddie laughs, breathily chortling while her well-rounded breasts slide to either side of you and pin you to the wall.\n\n");
		
		output("\"<i>So is this like, where the icing spouts out right?</i>\" asks the confectionery cutey, squeezing you softly.  \"<i>Awww, how sad – yours is stuck, just like Daddy's!  I'll have to squeeze and rub it until it'll let out the icing.</i>\"\n\n");
		
		if(pc.slut() < 33) output("You muster as much authority as you can in such a compromising position and explain to Maddie that what comes out of there is NOT icing.");
		else if(pc.slut() < 66) output("You offhandedly mention that you don't actually make icing.");
		else output("You smirk and mention that what you squirt isn't quite icing.");
		output("  \"<i>Liar!  If that wasn't icing, then why would Daddy have put his in all those eclairs and me?</i>\" retorts the busty cupcake, continuing on to say, \"<i>I know, I can suck it out!</i>\"  She purses her jelly-like lips and plunges forward, slurping all " + num2Text(Math.floor(pc.cocks[x].cLength())) + " inches into her oven-warmed esophagus.  Your protests are cut off by the tightness squeezing around your [pc.cock " + x + "].  It milks you in rippling motions, buttery-slick and pulsing hungrily.\n\n");
		
		output("A half-melted tongue ");
		if(!pc.hasSheath(x)) output("encircles the base");
		else output("pokes and prods into your sheath");
		output(", leaving a syrupy residue trailing over your [pc.cock " + x + "].  You groan, sagging into the sugary suspension.  The strength is completely gone from your limbs, stolen by the pastry's prick-devouring maw.  Her shining eyes look up to gloat once she realizes how completely you've submitted to her ministrations, and in no time, her cake-soft hands catch and squeeze your [pc.cock " + x + "] into the gargantuan swell of her spongy breasts.  A smile crosses your face as you get pleasured by the motherly mounds and the familiar, sweet smell that Maddie exudes.\n\n");
		
		output("Suction starts, hollowing the cupcake-girl's plush cheeks into a concave, cock-slurping form.  The constant squeezing of your [pc.cock " + x + "] combines with the sucking to make you swell larger inside Maddie's gullet while she kisses your groin.  The confection's oral charms show no signs of stopping as she noisily slurps away at her treat, and her pillowy breasts are so spongy-soft and calming that you're happy to let her sample your 'icing' if it means you can feel like this.  Your [pc.hips] push back into the baby blue lips, pumping and thrusting as your instinct to fuck and breed takes over, working your [pc.cock " + x + "] in and out of the pastry's puckered mouth.\n\n");
		
		output("Maddie pushes further forward, her bosom crushing you against the wall to hold your hips immobile while she sucks harder and harder.  Your cock balloons from the suction, thickening inside her neck and beginning to twitch from the irresistible fellative pleasure. An orgasm grows in your [pc.balls]");
		if(pc.balls > 0) output(", the cum-heavy spheres bouncing in your twitching sack as they get ready to explode");
		output(".  Maddie squeezes her puckered cock-suckers tight around the turgid shaft while she whips her melty tongue in circles around it.  Your climax hits like a hammer-blow to the temple, knocking the thoughts from your head while you pump rope after rope of 'icing' down the cupcake's dick-gripping neck-hole.  The suction relaxes as you fill the ravenous pastry with your seed and let your head limply sink deeper against the cushion of her sponge-cake-soft breast.\n\n");
		
		output("Maddie milks you for what seems like ages");
		if(pc.cockTotal() == 1) output(", your [pc.cock " + x + "] emptying every drop of jizz into the baked cum-tank.");
		else {
			output(" while her skin absorbs the generous donation of your other member");
			if(pc.cockTotal() > 2) output("s");
			output(".");
		}
		output("  When the jizz-guzzling pastry-girl pulls back at last to free your empty member, it's coated from top to bottom in gooey blue jelly, though it's tinged white in places.  The milked-out member slowly softens");
		if(pc.cockTotal() > 1) {
			if(pc.cockTotal() == 2) output(" along with your other penis");
			else output(" along with your other dicks");
		}
		output(".  Satisfied, your body goes limp and sags against the wall while your face leans on the cupcake-girl's departing breast.\n\n");
		
		output("The cream-filled creation leans back and squirts some more icing onto the straps holding you, but instead of reinforcing the bonds, it eats through the hardened confection to release you into her waiting bosom.  She catches you in the pillowy chest-embrace, stroking your hair while she says in a sing-song voice, \"<i>Thanks for all the icing " + pc.mf("mister", "miss") + "!  I think I have enough for now.  I think I'll go like, check on my Dad and stuff.  Maybe he wants to add some icing to the recipe?</i>\"\n\n");
	
		output("Oven-warmed tiles kiss your exposed [pc.ass] as you're gently placed on the floor next to your discarded equipment.  Exhausted and satiated as you are, your eyes drift closed, lulling you into slumber.\n\n");
		
		output("<b>Later...</b>\n");
		output("You're woken by a furry hand squeezing your shoulder and violently shaking you around.  With such rough treatment, you snap to full alertness in no time.  The minotaur chef is smiling down at you, the expression looking quite strange on his bestial muzzle as he says, \"<i>Sorry.  Experiment backfired.  Glad you gave her what she needed.  Much calmer now.  Will make great assistant.</i>\"\n\n");
		output("Once the beast-man has finished talking you realize the cupcake-girl, Madeleine, is standing behind him.  Her blue-iced 'clothes' have been remade, shaped into a form-fitting apron that accentuates her massive, otherworldly curves.  The minotaur chef utters, \"<i>We go now.  Get dressed.  Maybe sometime can visit Maddie.</i>\"  Maddie claps her hands, bouncing and jiggling with excitement as the two of them leave you there to get dressed.");
	}
	//(FEMALE/Genderpoots) 
	else {
		output("\"<i>Dad said my name is Madeleine, but that's no fun.  Just call me Maddie!</i>\" exclaims the airheaded pastry.  You briefly wonder if the yeast is to blame for her state, but you stifle the involuntarily giggle that rises with the stray thought.  Now is hardly the time for such frivolous rambling!  You shout with equal parts terror and rage, demanding she remove her sugary bondage from you immediately.  She looks at you with her alien eyes full of confusion, as if she doesn't comprehend a word you're saying.\n\n");
		
		output("A nipple is forced between your still-protesting lips, plugging your noise-hole before you can complain further.  Maddie gleefully cheers, \"<i>There we go... now we just need to get some magic icing in you so you'll feel nice and yummy and like, relaxed!</i>\"  Oh no – you don't know what she means by magic icing, but whatever it is, it can't be good.  First, you try to spit the spongy areola out.  It pushes back with incessant pressure, flooding your mouth with cake-like sweetness immediately.  You try to bite down.  Maybe pain will make her draw back?  It doesn't work, and if anything, it just starts the flow of icing.\n\n");
		
		output("It's delicious – creamy, gooey, and sugary-sweet while at the same time as fluid as mother's milk. You swallow the first mouthful reflexively before you remember you were trying to avoid this exact fate.  The thick icing coats your esophagus with the cupcake's warm secretion. It radiates gentle, oven-like heat throughout you, clouding your mind and dulling your vision with its hazy warmth.  You relax against your saccharine bonds nervelessly and begin to drink of your own volition.\n\n");
		
		output("\"<i>Shhh, shhh... that's a good " + pc.mf("boy", "girl") + ".  Isn't my icing the absolute best?</i>\" she verbally gushes, just like the nipple between your teeth.  \"<i>Drink up");
		if(pc.thickness < 60) output(", you're looking awful thin");
		else if(pc.tone >= 70) output(", you look like you're carved from stone.  A little softness would do you good");
		else output(", you look like you'd better eat to keep up your gorgeous figure");
		output(".  Mmm, don't let it like, spill or nothing!  I'm making this icing special and yummy so you'll feel super good and stop struggling an' stuff.</i>\"  Her voice is as candy-sweet as the milk you're guzzling.  The sound of messy slurps and noisy, gulping swallows fills the air of the small back room.\n\n");
		
		output("The weighty breast and its spongy nipple retreat, popping from your questing lips.  You whine weakly in disappointment at the sudden disappearance of your treat, licking and smearing the white cream over your already icing-smeared mouth.  Maddie grabs her other tit with a two handed grip and struggles with the wobbling mass while she aims her unused nipple your way.  The areola heaves, bulging out like an overfilled balloon.  The nipple wiggles in place from the pressure, stretching out around the sides until it looks ready to rupture.  Creamy confection beads at the tip, slowly forming a fat, sticky drop that hangs down and threatens to fall to the floor.  Before it falls, the nipple pulses one last time and opens up a flow of icing.  It's like watching a dam burst – awe-inspiring for the first few seconds until the torrent of fluid begins to drown you.\n\n");
	
		output("You rock back as the gushing stream impacts your solar plexus, splattering the frosty white stuff into a spray of rain.  Goop rains and explodes all around, and Maddie just giggles and moans while she guides the flow over every inch of your form, drenching you in sugary sweetness.  You swallow nearly as much as you spit and sputter.  After a few moments you just kind of open wide and sigh, hoping she'll hold it in your mouth and hit you with enough force to pump it into your gurgling gut.\n\n");
	
		output("\"<i>Ohhh, you look good enough to eat!</i>\" exclaims Maddie.  Meanwhile, your restraints slowly liquify under the warm, sugary strikes.  They stretch lower and lower, letting you sink into the soft, half-melted pile of icing.  At last the icing-based bindings snap, letting you sink into the sweetened mass as if it was a giant cushion.  Maddie sighs, giving a few last, fickle squirts that splatter in your hair before her flow completely stops.\n\n");
		
		output("\"<i>Ooooh look at you!  You're all sticky-sweet and soft!  Gosh, I bet all the horny boys and girls would love to lick you right up!</i>\" exclaims the excited cupcake-girl.  She licks a drop of stray icing from one of her plump digits before she utters with a voice full of worry, \"<i>I'm all out of icing.  N- no one will like me if I don't have icing!  Thanks for playing, but I'd better go get some more cream filling from daddy.  You stay still and don't go anywhere until you've eaten all the icing, 'kay?</i>\"\n\n");
		
		output("The pudgy pastry flounces off, leaving you to wallow in the pile of syrupy cream she leaves behind.  You're so placid and relaxed from her drugged icing that you obey thoughtlessly, shoveling heaping handfuls into your mouth.  Handful after handful, you devour the creamy, drugged topping that's piled up around you.  Somehow it doesn't burst your belly with its sheer volume, but it does make your tummy rumble and protrude slightly ");
		if(pc.thickness < 60 || pc.tone >= 50) output("forward");
		else output("more forward than normal");
		output(".  After a time it overwhelms you and you fall into a fitful slumber.\n\n");
		
		output("<b>Later...</b>\n");
		output("You're woken by a furry hand squeezing your shoulder and violently shaking you around.  With such rough treatment, you snap to full alertness in no time.  The minotaur chef is smiling down at you, the expression looking quite strange on his bestial muzzle as he says, \"<i>Sorry.  Experiment backfired.  Glad you okay.  Gave her more filling and all calm now.  Will make great assistant.</i>\"\n\n");
		
		output("Once the beast-man has finished talking you realize the cupcake-girl, Madeleine, is standing behind him.  Her blue-iced 'clothes' have been remade, shaped into a form-fitting apron that accentuates her massive, otherworldly curves.  The minotaur chef utters, \"<i>We go now.  Get dressed.  Maybe sometime can visit Maddie.</i>\"  Maddie claps her hands, bouncing and jiggling with excitement as the two of them leave you there to get dressed.");
		output(pc.modThickness(10));
		output(pc.modTone(-10));  
	}
	flags["COC.BAKERY_MADDIE_STATE"] = 3;
	processTime(45);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Next visit to the bakery...]
internal function bakeryEpilogue():void {
	clearOutput();
	output("As soon as you enter the bakery, one of the waitresses pulls you aside.  She positively beams as she hands you a note and says, \"<i>One of our chefs wanted me to give you this.  I didn't even know he could write!  I mean, where does a minotaur learn to handle a pen?</i>\"  You smirk, waving her away before you open up the minotaur's note.\n\n");  
	output("\"<i>Thanks.  Figured out what went wrong with Maddie's help.  Made masterpiece.  Buy giant cupcake sometime.  Delicious!  Promise it's safe and non-addictive.  Expensive though.  Ingredients rare.\n\n");
	output("-X</i>\"");
	flags["COC.BAKERY_MADDIE_STATE"] = 4;
	clearMenu();
	addButton(0, "Next", bakeryuuuuuu);
}