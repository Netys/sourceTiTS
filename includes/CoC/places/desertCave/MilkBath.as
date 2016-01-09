import classes.GLOBAL;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//*Sand Witch Milk Bath -McGirt
public function milkBathsAhoy():void {
	clearOutput();
	output("Well, you can probably squeeze in a quick bath.  You've already dealt with the bulk of their number, and this area seems devoid of any more of them.  Your [pc.gear] easily slides into a pile alongside of rounded, stone tub while the dusky titty-monster looks on with anticipation.  Once nude, you hop down inside and say, \"<i>Bath Time.</i>\"");
	
	output("\n\nWith trembling anticipation, the black-skinned milk-slave reaches down for her teat-like nipples.  Her huge, plate-sized areola bead with white perspiration in anticipation, and the woman's hands nearly disappear into her chest-globes as she struggles to grasp her engorged nipples.  You drop the plug into the drain and look up.  Cooing in delight, the huge-breasted girl finally manages to get her shivering fingertips around each of her aching milk-spouts.  She massages her nipple-flesh for a moment, her eyes lidded and heavy from pleasure, and she releases the first heavy torrent of white into the tub.  Surprisingly, the fluid is thin and watery, less milk-like than you'd think.  Whether the witches or the woman's physiology is to blame you cannot tell.  Her eyes are too vacant to give any clues, and her mouth is too busy making sighs of relief to speak.");
	
	output("\n\nPearly fluid quickly fills the first few inches of the tub, spouting as it is in numerous forking streams from its mocha spouts.  Dark-skinned hands massage the soft female flesh with smooth, unbroken motions, squeezing each teat from base to tip before retreating back to the bottom.  The steady back-and-forth motions cause the streams to rise and fall to the tempo, but the flow stays thick and steady enough to splatter your [pc.hips] with white. You relax against one of the benches and idly trace your hands through the water, enjoying the feeling of the milk on your " + pc.skinFurScales() + " as it rises higher and higher.  Your only companion, the chocolate-skinned woman, continues to knead her engorged breasts as you watch, and you have to admit, you feel a sexual thrill sliding down your spine as you watch her heavy breasts work to fill your tub.");
	
	output("\n\nYou close your eyes and massage the stuff into your skin, feeling oddly serene and clean in spite of the heating of your loins.  Even as the cream flows over your ");
	if(pc.hasCock()) output("[pc.cocks]");
	else if(pc.hasVagina()) output("[pcvagina]");
	else output("[pcbutt]");
	output(", you resist the urge to touch yourself in a sexual way and focus on what you wanted to do - bathe.  The milk-slave lets out a satisfied groan, her breasts finally reduced enough for her to easily reach her tit-tips at last, fingers tugging and squeezing to feed the ecstatic release she must be feeling.  Still, the mammoth milkers are more than large enough to keep her pinned beside the tub.  At this rate she'll likely remain immobile, even after you're neck-deep in her delightful fluids.");
	output("\n\nParting slightly, the ebony woman's puffy lips let her tongue loll out to dangle obscenely.  She looks... pleased - almost orgasmically so.  Her hands, once steadily pumping, are now stroking her nipples with feverish intensity, stopping from time to time to caress the great mass of her chest and squeeze even more milk out.  She shivers and shudders, filling the tub for you, obedient even to the whims of a complete stranger.  Her blissful expression grows more and more pleased with every passing second, and then with a shudder (just as the milk reaches your [pc.chest]), she squeals and moans in ecstatic, body-shaking bliss, her muscles writhing, sending a titanic tremor through her now-jiggling jugs.  A huge spray of milk is released at the same time.  It rocks you back against the tub's wall and soaks your hair.  By the time it's over, the tub is full, and the delirious girl is panting happily.");
	
	output("\n\nThe milk-slave pulls back, licking her puffy lips smelling strongly of female arousal but obviously satisfied.  She whimpers, \"<i>I love bath time,</i>\" before starting to shift her breasts' bulk back towards her corner.");
	output("  You could probably masturbate in the tub if you wanted to, or maybe pull the dusky milk-maid in for company....  What do you do?");
	//{If can masturbate [Drink & Masturbate] [Milk Girl] [Relax]}
	//{otherwise [next] to relaxing}
	pc.energy(10);
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", finishMilkBath);
	addDisabledButton(1, "DrinkNFap", "Drink And Fap", "This scene requires you to have genitals.");
	if (pc.hasGenitals()) addButton(1, "DrinkNFap", drinkNFap, null, "DrinkNFap", "Drink some milk and masturbate.");
	addButton(2, "Milk Girl", grabTheMilkGirl, null, "Milk Girl", "Pull the milk girl into.");
}

//[Next] (Relax)
public function finishMilkBath():void {
	clearOutput();
	output("You sit in the tub for a while, letting the fragrant fluids soak into your " + pc.skinFurScales() + ".  Yet, you have work to do, and eventually, you tire of relaxing in the sand witches' endless white bounty.  You pull out the tub's plug and climb out, finding a towel on the wall.  Thankfully, the milk doesn't seem to leave behind any residue, and you feel clean and refreshed, if a bit horny.");
	//(+Lust, -Fatigue)
	//dynStats("lus", 10);
	pc.lust(10);
	pc.energy(50);
	processTime(5 + rand(5));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Milk Girl]
public function grabTheMilkGirl():void {
	clearOutput();
	output("You call out to the milk slave before she can slink away, and wade over to the side of the tub, leaving your face a few scant inches from her massive, milk-laden jugs. She cocks her head to the side, obviously unused to the attention, and quietly whispers, \"<i>" + pc.mf("M-master?","M-mistress?") + "</i>\"");
	output("\n\nYou flash her a mischievous grin before grabbing a handful of her giant tits and pulling, yanking her into the tub with you. The milk-maid lets out a sharp cry of surprise as she tumbles in, a huge splash of cream spraying over the rim of the tub, painting the walls white. Gasping, her head pops back over the surface of her own milk, long ebony hair dripping onto the tops of her seemingly-buoyant teats, which bob over the milky waves with a strangely serene, regal grace.  \"<i>" + pc.mf("M-master?","M-mistress?") + "</i>\" the slave girl repeats, her lower lip quivering with fright as she wades through her own lactation, slowly retreating to the edge of the tub. Smiling, you reach out and stroke her cheek, telling her it's all right, that you thought she might like a bath, too. She starts to reply in her broken dialect, but you cut her off with a playful stroke of her massive mounds, urging her over toward you. Though still nervous, she does as you ask, sliding up under your arm and onto your lap. Once seated, she looks ups to you with saucer-like brown eyes until you cup her cheek and give her a short, tender kiss, pressing your lips to her dusky mounds. To your delight, she seems to melt at your touch, relaxing in an instant as you hold her as close as you can, seperated only by her prodigious chest");
	if(pc.biggestTitSize() >= 8) output(", pressing deep into your own huge rack, your nipples flicking across her own leaky tits");
	output(".");
	
	output("\n\n\"<i>O-oh,</i>\" she moans, just on the edge of hearing, her cheeks flushing hotly in your hand. The cute little slave turns aside, moving her udders out of the way so that she can rest her head on your chest, obviously enjoying the simple act of your arm around her shoulders and the odd gentle touch. You let her enjoy it for a few long, pleasurable minutes, content in the silent company of the milky girl. From time to time you gently stroke her cow-like teats, or reach down to rub her thick, rich milk into your loins, enjoying the incredible texture of it on your ");
	if(pc.isHerm()) output("[pc.cock] and [pc.vagina]");
	else if(pc.hasCock()) output("[pc.cock]");
	else if(pc.hasVagina()) output("[pc.vagina]");
	else output("sexless crotch, still burning hotly with your desires");
	output(".  After a time, though, you give the girl a gentle little push, having her rest her arms and tits on the edge of the pool.  You shift around behind her, cupping up handfuls of her milk.  You start to pour it down her back and shoulders, getting her nice and soaked in her own sweet cream before you close in, starting to massage her back, rubbing it in nice and slow until she's shivering quietly.  She moans under her breath as your fingers sink into her soft, yielding flesh, gently kneading her shoulders and hips, giving special attention to her full, round ass, tentatively slipping a few fingers around her leg to caress along her slick vulva and the bud of her clit.");
	
	output("\n\nShe tenses when you brush against her, ");
	if(pc.cor() < 70) output("and you're quick to pull back, not wanting to force her, but to your surprise and delight, she reaches back and takes your hand in hers, moving you back to finger her");
	// if Corrupt> 70:
	else output("and grinning with lusty fervor, you push harder, slipping your fingers into her with ease, her milk providing the perfect lubricant to penetrate her.  The slave girl trembles at your sexual advance, but either does not want to stop you out of well-trained fear, or just doesn't want you to stop");
	output(".  Before you can get too far, though, the slave girl turns on a heel, her huge rack pushing you back through the milky pool and then against the rim.  You're dazed for only a brief second before her breasts press firmly into your back, pressed so hard that a new streak of milk pours from her teats, wetting your back much as you did hers.  You relax against the rim as the slave cups up handfuls of milk, rubbing it into your own hair and shoulders, deft fingers massaging every muscle in your back with the skill of the greatest masseuses, and you can feel the tension bleeding from your muscles. You yawn powerfully, resting your chin on your arms and letting the milky girl massage you, coating your " + pc.skinFurScales() + " in her rich, delicious milk.");
	
	//{If PC has a dick: 
	if(pc.hasCock()) {
		output("\n\nOne of the milk girl's hands brushes against your thigh, slipping around your [pc.leg]; slender fingers wrap around your [pc.cock], milky lubricant making her soft strokes all the more pleasurable.  You groan in lusty delight as her fingers slide up and down your quickly-hardening length");
		if(pc.balls > 0) output(", her other hand cupping your [pc.balls], rolling the " + num2Text(pc.balls) + " orbs in her palm with surprising dexterity");
		output(".  Leaning over the two titanic teats between you, she traces a line of kisses down your back, licking up stray drops of milk between affectionate caresses.");
	}
	//{If PC has cooch:
	if(pc.hasVagina()) {
		output("\n\nHer hands shift downwards, delicate fingertips slipping across the slit of your [pc.vagina]. You gasp, shivering as her milk-slick fingers easily slip into your sodden box, her thumb swirling gently around your [pc.clit].  Her other hand traces upwards, carressing your [pc.hips] and [pc.butt] before finally arriving at your [pc.chest], which she massages with well-practiced skill.");
		if(pc.biggestTitSize() >= 1) output("  She cups your breasts, having to reach so far around both your rack and hers that she's straining her arms to rub your [pc.nipples], but she does so valiantly, stroking them with her incredibly deft fingers.");
		if(pc.lactationQ() >= 200) output("  A spurt of milk escapes your own full jugs, joining the pool-full of your new friend's.  She gasps with surprise and delight, quickly nuzzling herself into your back and going to work, milking you just as she would herself, letting the hefty flow of your motherly fluids pour into the pool, odd trickles smearing down your chest, staining your chest as white as her own.");
	}
	//[Fuck Her](PC must have gender; if cooch, also C+ cups) [Don't]
	clearMenu();
	//dynStats("lus", 33, "resisted", false);
	processTime(10 + rand(5));
	pc.lust(33);
	addDisabledButton(0, "Dick Fuck", "Dick Fuck", "This scene requires you to have cock.");
	addDisabledButton(1, "Lady Fuck", "Lady Fuck", "This scene requires you to have vagina and gropable breasts.");
	if (pc.hasCock()) addButton(0, "Dick Fuck", fuckMilkbabeWithPenor, null, "Dick Fuck", "Fuck the milk slave with your penis.");
	if (pc.hasVagina() && pc.biggestTitSize() >= 3) addButton(1, "Lady Fuck", ladyFucks, null, "Lady Fuck", "Have some vaginal and boob play.");
	addButton(2, "Don't Fuck", dontFuckMilkBathBabe, null, "Don't Fuck", "Skip the fucking.");
}

//[Don't]
public function dontFuckMilkBathBabe():void {
	clearOutput();
	output("You allow the girl to continue for a long, long while until your entire body feels deeply refreshed, her milk having soaked into your body and making you feel fresh and revitalized. You start to thank the milk girl for the pleasurable company, but when you open your mouth, she slips into your arms and presses her lips to yours.  Chuckling to yourself, you hold the girl as tight against yourself as her udders will allow, turning her to the side to let her nuzzle her cheek into your [pc.chest], kissing the top of her head before the two of you climb from the pool.  You have to help her out, her massive extra weight nearly dragging her back in except for your quick reflexes.  You gather your [pc.gear] and ruffle the milk slave's hair before turning back to the task at hand.");
	//[+Lust, +HP, -Fatigue]
	processTime(5 + rand(5));
	pc.HP(pc.maxHP() * 0.33);
	pc.energy(20);
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Fuck Her] (PC has a Dick)
public function fuckMilkbabeWithPenor():void {
	clearOutput();
	var x:int = pc.cockThatFits(50);
	if(x < 0) {
		x = pc.smallestCockIndex();
	}
	
	output("You turn around and pull the milk-slut against you, her massive teats pressing hard against your [pc.chest] until they spurt milk.  You stroke her cheeks, bringing her lips up to yours. Her hand finds your [pc.cock] again, stroking you with mounting speed as your tongue finds its way into her mouth, your hands wandering down to grope her sizable ass and flared, breeder's hips.  Your milk maid sighs heavily, breath filled with lust as you push her up against the rim of the tub, her legs spreading wide for easy access to her milk-lubed cunt.  She locks her arms around your shoulder, moaning happily as you press into her, your [pc.cock " + x + "] sliding easily into her sodden box.");
	output("\n\nSubmerged beneath a sea of creamy milk, it's so very, very easy to slide into the slave girl, ");
	if(pc.cockVolume(x) < 30) output("hilting her in one long stroke");
	else if(pc.cockVolume(x) < 50) output("pushing your many inches into her until your hips join, her nice and loose cunt easily taking your length");
	else output("your cock gaining as much entrance as your massive member can, the excess dickmeat embraced in cream between you");
	output(".  With your prick buried in her, the milk slave hooks her legs around your [pc.hips] and starts to rock her hips gently, letting you take the initiative. Smiling at the meek girl, you sink your fingers into milk-yielding titflesh and start to move your hips, thrusting into her with measured ease, letting milk flood into her channel and coat your dick to lubricate each and every motion.");
	
	output("\n\n\"<i>S-so good, [pc.Master],</i>\" she moans, \"<i>[pc.Master] makes bath slut feel so great.  Oh!</i>\"");
	output("\n\nYou pick up the pace, thrusting in harder and harder, sloshing waves of cream into the valley of her cleavage and right over the edge of the pool.  Your lover clings tightly to you, leaking milk and a clear trail of fem-lube from her cunt as you hammer into her.  Punctuating your thrusts, you lean in and press your lips to hers, silencing her ecstatic moaning with a drawn-out kiss.  When you break it, trails of spit and milk still connect her full, dusky lips to yours, her tongue slightly lolled from her mouth with sexual bliss.  Her entire body begins to shudder, massive chest heaving as she approaches the edge.  You let yourself go as she cums, and as her first orgasmic moans echo out, you roar with primal lust and join her, smearing her milk-slick cunt with a thick glob of semen, letting another and another join it, filling her womb with your potent seed.");
	
	output("\n\nYou allow the girl to continue for a long, long while, quivering with sexual release as you shudder out the last drops of your cum inside her. With a heavy sigh, you slump forward, burying your head into her prodigious bust to recover. You grin as the milk girl wraps her arms around you, holding you tight against herself.");
	
	output("\n\nYour entire body feels deeply refreshed, her milk having soaked into your body and making you feel fresh and revitalized, and every muscle seems to have relaxed thanks to your blissful coitus.  You start to thank the milk girl for the pleasurable company, but when you open your mouth, she presses her lips to yours for a long, tongue-filled kiss.  Chuckling to yourself, you hold the girl as tightly as her udders will allow, turning her to the side to let her nuzzle her cheek into your [pc.chest], kissing the top of her head before the two of you climb from the pool.  You have to help her out, her massive extra weight nearly dragging her back in except for your quick reflexes.  You gather your [pc.gear] and ruffle the milk slave's hair before turning back to the task at hand.");
	//[+Lust, +HP, -Fatigue]
	pc.orgasm();
	//fatigue(-15);
	pc.energy(15);
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}

//[Fuck Her] (PC has Cooch & C+cups)
public function ladyFucks():void {
	clearOutput();
	output("You turn around in the milky pool, pulling the cute little slave tight against you.  She gasps with surprise, but settles as soon as you press your lips to hers, your hands wandering across her huge teats and supple, milky body.  She nuzzles up against you, her head resting on your [pc.chest] as you hold her against yourself, stroking her dark hair.  After a few moments of such a simple pleasure, the little slave girl shifts her cheek along your breast, wrapping her full, dusky lips around your [pc.nipple].  You let out a long moan as she suckles gently");
	if(pc.lactationQ() >= 200) output(", drawing out a trickle of milk from your motherly reserves.  She gulps deeply, smiling up at you as a trickle of your milk runs down her chin, dripping into the pool of her own");
	output(".  Her hand slips up your body, brushing your vulva and [pc.clit] before cupping your other breast, delicate fingers wrapping around your [pc.nipple].  With deft, practiced motion, she works your teats between her fingers, working your breast like she might her own");
	if(pc.lactationQ() >= 200) output(", milking you with skill beyond anything you've ever experienced before; and why not, when her entire existence revolves around that self-same skill?");
	else output(".");
	
	output("\n\nYou lean back against the rim, putting your arms up against the lip and letting the girl put her skills to use on you, your chest soon heaving and quivering to her every touch.  You barely notice as the girl's other hand vanishes beneath the milky waves, surely going to tend to herself as her tongue and fingers squeeze and caress your ");
	if(pc.lactationQ() >= 200) output("milky ");
	output("teats in the most incredible ways.  You moan and groan as she tweaks and massages, suckles and kisses your rock-hard peaks, sending electric shivers of pleasure through your chest until your entire body quivers.  Almost unconsciously you wrap your [pc.legs] around the milky girl's waist, holding her tighter and tighter against your sodden body, forcing as much of your [pc.nipple] into her so wonderfully skilled mouth as you can.");
	
	output("\n\nSoon, you can feel a strange pressure welling up through your tits.  It takes you a moment to recognize the boobgasm, but when it hits, you throw your head back in animalistic pleasure");
	if(pc.lactationQ() >= 200) output(", spraying milk all over yourself and the milkmaid who caused your explosive pleasure");
	output(".  You run your fingers through the girl's hair, urging her sexual skills on as your chest heaves and quavers, riding out the massive boobgasm as fem-cum spurts from your cunt and into the milky pool below.");
	output("\n\nYour entire body feels deeply refreshed, her milk having soaked into your body and making you feel fresh and revitalized, and every muscle seems to have relaxed thanks to your blissful coitus.  You start to thank the milk girl for the pleasurable company, but when you open your mouth, she presses her lips to yours for a long, tongue-filled kiss.  Chuckling to yourself, you hold the girl as tightly as her udders will allow, turning her to the side to let her nuzzle her cheek into your [pc.chest], kissing the top of her head before the two of you climb from the pool.  You have to help her out, her massive extra weight nearly dragging her back in except for your quick reflexes.  You gather your [pc.armor] and ruffle the milk slave's hair before turning back to the task at hand.");
	//[+Lust, +HP, -Fatigue]
	pc.orgasm();
	pc.energy(15);
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}
	
//[Drink & Masturbate]
public function drinkNFap():void {
	clearOutput();
	output("\"<i>Wait,</i>\" you call out to the ebony woman, letting the milk obscure your hands as you begin to masturbate, \"<i>I want a drink.</i>\"  Sheepishly, the milk slave obliging shifts to drag her tits back into place.");
	output("\n\nShe begs, \"<i>Forgiveness please, [pc.Master].  Bath slut would love to give you more milk.</i>\"  She rolls her shoulders, sending an enticing jiggle through the milk-weighted fluid-factories on the edge of the tub, the sable flesh of her nipples blotted by fresh drops of white.  The milky morsels roll down the undercurve of the black slut's tits before dripping into the tub and sending tiny waves of cream through the tub.  Her well-used teat looks almost over-engorged by this point, puffy, swollen, and a little red, even through her coal-dark skin.  Thick streams of her alabaster nectar start to run from each of her nipple-tips as you lean closer, the anticipation already too much for the ever-full milk-machine of a woman.");
	
	output("\n\nTaking her nipple in, you give it an experimental lick.  It's sweet from the pearly fluid, but her skin tastes faintly of her body's salts as well, not unpleasantly.  You look down at the boob before you and realize that even with the milk-spout in your mouth, you've only devoured a small portion of her teat.  The majority of her areola spreads out before you, nearly the size of a dinner plate but far more exciting.  After taking a few swallows of her body's watery treat, you reach down to your ");
	if(pc.hasVagina()) output("[pc.vagina] and idly stroke your puffy, lust-engorged vulva");
	else output("[pc.cock] and idly stroke the turgid mass");
	output(", inadvertently drawing a lewd moan from yourself.  The fat nipple stuffed in your mouth does an adequate job of muffling your pleasurable vocalizations");
	if(pc.hasCock()) output(", but it does little to hide the swelling of [pc.eachCock] - you have the milk for that");
	output(".");
	
	output("\n\nAn excited moan worms out of the inky slave-girl's puffy lips, a testament to the raw sensitivity of her milk-bloated jugs.  As your tongue swirls over the leaky nozzle's pebbly skin, she releases another breathy pant of delight.  The vocal tremors seem to coo all the way down to your loins, joining with your fingers' caresses to stir you to aching, trembling arousal.");
	//{Fork, no new PG}
	//(DA HERMS) 
	if(pc.isHerm()) {
		output("  Your [pc.cock] throbs painfully in your hand, so hot and hard that you're sure you must have begun to leak precum, but any fluid is swiftly washed away by the ever-present milk.");
		if(pc.cockTotal() > 1) output("  You make sure to fondle each of your members equally, caressing, squeezing, and stroking to the tempo of your swelling passion.");
		output("  With your off-hand, you rub your cream-lubricated fingers through your sodden gash, the flesh parting easily to allow a few of your questing fingers inside.  Delicious bliss unfolds from your [pc.clit] as it pushes free of its hood, fully engorging, faintly throbbing from aching need.  You brush the button a few times before going back to fingering your box, yet you make sure to strum your thumb across your clit every few moments to keep yourself as close to peak as possible.  Truly, being a hermaphrodite is bliss.");
	}
	//(DA SCHLICKS)
	else if(pc.hasVagina()) output("  Your pussy juices mix freely with the tub's white-colored 'waters', allowing your cream-lubed fingers to plunge into your [pc.vagina] with ease.  You stroke your lips and caress the interior of your birth canal with the intimate familiarity of a skilled lover, playing with your body until you feel your control slipping, so wound up with lust that you feel like an over-tightened guitar string vibrating out of control.");
	//(DA DUDES)
	else {
		output("  Your [cock] throbs painfully in your hand, so hot and hard that you're sure you must have begun to leak precum, but any fluid is swiftly washed away by the ever-present milk.  ");
		if(pc.cockTotal() > 1) output("You make sure to fondle each of your members equally, caressing, squeezing, and stroking to the tempo of your swelling passion.");
		else output("  With your offhand, you cradle your [pc.sack], hefting your [pc.balls] as you feel your desire churning to new levels.");
	}
	//(TOGETHER)
	output("\n\nA spray of warmth impacts off your shoulders, and you turn into it, delighted to see the captive woman's other teat unloading yet another potent blast of silky goodness.  With a little regret, you pull off, earning a hair-drenching facial, and switch to the fountaining tit-tip in a heartbeat.  You work your throat to keep up with the flow, cheeks bulging from the pressure.  Ultimately, between your limited ingurgitating ability and the spiraling waves of pleasure rolling out from your groin, you fail to get all the milk down, and it sprays from the corners of your mouth while runnels of fluid leak down to your chin.");
	
	output("\n\nThe tub is dangerously full by this point, milk lapping at the edges like the tide coming in, and as you climax, you briefly wonder if perhaps, it has.  White-hot heat rockets through your middle, lazily climbing your spine to make an assault on your brain.  Your jaw locks, inadvertently biting down on the chocolate-toned nipple to momentarily staunch its flow.  Pistoning seemingly of their own volition, your [pc.hips] sway back and forth, stirring up creamy waves that splash about the room, soaking the floor and your gear with milk.");
	if(pc.hasCock()) {
		output("  [pc.EachCock] releases its own gooey load, sputtering and spurting to add to the pearly deluge.");
		if(pc.cumQ() >= 500) output("  With every torrent of seed you release, you can see it lift partway out of the tub, propelled by your incredible virility towards the nearest female specimen.");
		if(pc.cumQ() >= 3000) output("  Soon, the tub's fluid contents break out of their confines to stain your companion's dusky flesh white, an alabaster glaze that would entice you to further feats of debauchery were it not for the pleased contentment your maleness now radiates.");
	}
	if(pc.hasVagina()) {
		output("  Meanwhile, your juiced-up cunny feels like it's doing backflips inside you, contorting and squeezing as it gushes with fluid, feminine joy.  One brush on your [pc.clit] knocks your [pc.legs] out from underneath you, but thankfully, you float out the rest of your orgasm.");
	}
	output("\n\nA drawn out, low coo of contentment emanates from the other girl as you separate from her, and she bashfully whispers, \"<i>Thank you,</i>\" as she drags her gigantic tits over the puddly, milk-slicked floor.  Smirking and sexually sated, you pop the drain in the tub and stand there while the sex-scented lactic bathwater runs out the drain.  A quick toweling off later, and you're ready to go, feeling slightly refreshed and fairly sated.  It does take you a little longer to get your [pc.gear] equally dry and back in place, but you manage.");
	
	pc.energy(15);
	pc.orgasm();
	//dynStats("sen", -3);
	processTime(15 + rand(10));
	clearMenu();
	addButton(0, "Next", mainGameMenu);
}