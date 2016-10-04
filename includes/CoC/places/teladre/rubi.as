import classes.Characters.CoC.CoCRubi;
import classes.CockClass;
import classes.GLOBAL;
import classes.Items.Apparel.*;
import classes.Items.Armor.CoCInquisitorsCorset;
import classes.Items.Recovery.CoCPurePeach;
import classes.Items.Transformatives.*;
import classes.ItemSlotClass;
import classes.Util.*;
import classes.Engine.Interfaces.*;
import classes.Engine.Utility.*;

//const RUBI_AFFECTION:int = 604;
//const RUBI_DISABLED:int = 605;

//0 = not admitted (she), 1 = "he", 2 = "she"
//const RUBI_ADMITTED_GENDER:int = 606;
//const RUBI_INTRODUCED:int = 607;
//const RUBI_BLU_BALLS:int = 608;
//const RUBI_ORGASM_DENIAL:int = 609;
//const RUBI_BIMBO:int = 610;
//const RUBI_INCUBUS_PROGRESS:int = 611;
//const RUBI_SUITCLOTHES:int = 612;
//const RUBI_FETISH_CLOTHES:int = 613;
//const RUBI_GREEN_ADVENTURER:int = 614;
//const RUBI_TUBE_TOP:int = 615;
//const RUBI_BODYSUIT:int = 616;
//const RUBI_LONGDRESS:int = 617;
//const RUBI_TIGHT_PANTS:int = 618;
//const RUBI_NURSE_CLOTHES:int = 619;
//const RUBI_SWIMWEAR:int = 620;
//const RUBI_PROSTITUTION:int = 621;
//const RUBIS_HOUSE_FIRST_TIME:int = 622;
//const RUBI_GOT_BIMBO_SKIRT:int = 623;
//const RUBI_PROFIT:int = 624;
//const RUBI_BIMBO_MINIDRESS:int = 625;
//const TIMES_RUBI_MASSAGED:int = 832;
//Third's horrible new shit
//const RUBI_BREAST_SIZE:int = 984;
//const RUBI_COCK_SIZE:int = 985;
//const RUBI_COCK_TYPE:int = 986;
//const RUBI_LOWERBODY:int = 987;
//const RUBI_HORNTYPE:int = 988;
//0 = normal, 1 = black
//const RUBI_NIPPLETYPE:int = 989;
//const RUBI_NO_CUNT:int = 990;
//const RUBI_CUNTTYPE:int = 991;
//const RUBI_EYE_DESCRIPT:int = 992;
//const RUBI_EYE_TYPE:int = 993;
//const RUBI_SKIN:int = 994;
//const RUBI_HAIR:int = 995;
//const RUBI_HAIR_LENGTH:int = 996;
//const RUBI_BALLS_TYPE:int = 997;
//const RUBI_EAR_TYPE:int = 998;
//const RUBI_HANDS:int = 999;
//const RUBI_WHISKERS:int = 1000;
//const RUBI_FEET:int = 1001;
//const RUBI_DEBIMBO:int = 1002;
//const RUBI_NIPPLE_TYPE:int = 1003;
//HE/SHE
//const RUBI_SHE:int = 1004;
//const TIMES_DISCUSSED_RUBIS_IDENTITY:int = 1005;
//const RUBI_ICECREAM_CONFESSION:int = 1006;
//const TIMES_RUBI_DATED:int = 1007;
//const RUBI_FANCY_CONFESSION:int = 1008;
//const RUBI_BAR_CONFESSION:int = 1009;
//const RUBI_TIMES_ANALLY_TRAINED:int = 1010;
//const RUBI_TIMES_GIVEN_AN_ITEM:int = 1011;
//const RUBI_BONDAGE_STRAPS:int = 1012;
//const RUBI_INQUISITORS_CORSET:int = 1013;
//const RUBI_SETUP:int = 1014;

public function get rubi():CoCRubi {
	return new CoCRubi();
}

private function rubiSprite():void {
	//if (rubi.hasHorns()) spriteSelect(102);
	//else spriteSelect(101);
	if (flags["COC.RUBI_INTRODUCED"] == undefined) userInterface.showName("\nWAITRESS");
	else userInterface.showName("\nRUBI");
}

private function rubiBalls():String {
	return "normal";
	return "swollen";
	return "massively engorged";
}

private function rubiIncubus():Boolean {
	return (flags["COC.RUBI_INCUBUS_PROGRESS"] == 3);
}

public function rubiAffection(delt:Number = 0):Number {
	if (flags["COC.RUBI_AFFECTION"] == undefined) flags["COC.RUBI_AFFECTION"] = 0;
	
	if (delt == 0) return flags["COC.RUBI_AFFECTION"];
	flags["COC.RUBI_AFFECTION"] += delt;
	if (flags["COC.RUBI_AFFECTION"] > 100) flags["COC.RUBI_AFFECTION"] = 100;
	else if (flags["COC.RUBI_AFFECTION"] < 0) flags["COC.RUBI_AFFECTION"] = 0;
	return flags["COC.RUBI_AFFECTION"];
}

//Major notes
//Rubi has a relationship rating, which goes from 0 to 40.  Players start at 0.  There are no ways to decrease relationship with Rubi currently.

//Potential future additions might allow the player to begin stalking Rubi after rejecting him.
//At relationship 0-9, the PC is a stranger to Rubi, and in fact thinks he is a she.
//At relationship 10-19, Rubi is warming up to the PC, and has more flirty dialogue.
//At relationship 20-39, Rubi is a friend and lover of the PC.  At this stage you can give him certain sets of clothing, which he'll randomly wear while working at the Bakery.
//At relationship 40, Rubi is in love with the PC, and the PC can talk him into damn near anything.  At this stage, the PC can give him bimbo liqueur or incubus drafts.

//Rubi can be found in the Tel'Adre bakery from 12:00 to 20:00.  He is available to everyone, regardless of gender, corruption or transformation.  Rubi, however, is not interested in Centaurs, Naga or Driders (as of yet), and such PCs won't be able to advance beyond Relationship 19.  If players gain such bodies after reaching this level, the option to go home with Rubi won't be available.

//When the player reaches Relationship 50, a special scene is triggered.
private function specialRelationship20scene():void {
	clearOutput();
	rubiSprite();
	output("As you're leaving the bakery, you hear the clicking of heels behind you.  Turning back you see Rubi rushing towards you shouting, \"<i>Hey, wait a second!</i>\"  You do, and wait for her to catch up.  Stopping in front of you, she puts her hands on her dainty knees and catches her breath.");

	output("\n\n\"<i>Phew, sorry I didn't catch you as you were leaving.  You were gone so fast,</i>\" she takes a deep breath.  \"<i>Look, I-I like you.</i>\"  Her face flushes brightly.  \"<i>But I need to tell you something.  Something about me.</i>\"");

	output("\n\nYou ask if it's about her being part demon and she shakes her head.  \"<i>No, it's not about that.</i>\"  You urge her to continue.");

	output("\n\nShe looks unsure for a moment, opening and closing her ruby red lips without speaking.  You notice she's clenched one hand in the other tight enough to make it go white, and her legs are trembling like trees in a storm.  Stepping forward, you put your hands on her shoulders firmly, look her straight in the eyes and say that she can tell you anything.");

	output("\n\nNodding, slightly relieved, Rubi continues, \"<i>I-I'm a... I've liked pretty dresses and heels and all that since I was a kid.  So when I came to Tel'Adre, I saw it as my chance to reinvent myself.  But it's been... hard to reveal my true self.  So what I mean to say is: I'm a boy.</i>\"  Her... HIS already flushed face seems to turn an even deeper shade of scarlet.");

	output("\n\nYou're a little surprised, but it does make sense.  She... he is pretty flat-chested, and you'd often wondered if you'd seen a bulge of some sort in her skirt from time to time...");
	rubi.createStatusEffect("Force Male Gender");
	//(Accept) or (Reject)
	clearMenu();
	addButton(0, "Accept", acceptRubi);
	addButton(1, "Reject", rejectRubi);
}
//[If Accept]
private function acceptRubi():void {
	clearOutput();
	rubiSprite();
	output("You wrap your arms around and pull him into a hug.  You declare that you like him no matter what sort of genitals he happened to be born with.");

	output("\n\nHe wipes a tear from his eye and smiles, clutching you tightly.  \"<i>Oh thank Marae, I was so worried you'd hate me after that.</i>\"");

	output("\n\nYou wonder curiously how anyone could hate such a cute and bubbly creature such as he, and tell him so.  He pulls back slightly from you and his smile widens.");

	output("\n\n\"<i>I—Thank you, [pc.name].  Just don't tell anyone about my secret, OK?  No sense in complicating my life here any further.</i>\"  You nod, and swear to keep his secret.");

	output("\n\nRubi gives you one last hug and walks back towards the bakery, his devilish tail swishing happily behind him.  \"<i>See you soon... babe,</i>\" he says, trying the name on for size.  You smile, and continue your journey back to camp.");
	rubiAffection(3);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//[If Reject]
private function rejectRubi():void {
	clearOutput();
	rubiSprite();
	output("With your hands on his shoulders you carefully keep him at arm's length.  Putting it as delicately as you can, you tell him that you're just not interested in him <i>that</i> way, not anymore at least.");
	output("\n\nRubi's eyes tear up, and you can see his lip quivering, but he puts on a brave face.  \"<i>I understand.  I just had to tell you.  Look, don't tell anyone else about this, OK?  I don't want my secret to get out.</i>\"  You confirm that you won't out him, and he gives you a small smile.");
	output("\n\nSniffing slightly, Rubi turns away and returns to the bakery, his devilish tail sullenly drooping behind him.");
	//(Will no longer encounter Rubi at the bakery.)
	flags["COC.RUBI_DISABLED"] = 1;
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Bakery Intro scenes
internal function rubiIntros():Function {
	if (flags["COC.RUBI_DISABLED"] > 0 || flags["COC.RUBI_PROSTITUTION"] == -2) return null;
	output("\n");
	//(Haven't met yet)
	if (int(flags["COC.RUBI_INTRODUCED"]) == 0) output("A cute human girl moves from table to table, bussing the empty ones and serving drinks to the occupied.  She's pretty flat-chested, and wears a pink and white frilly waitress uniform with an apron.  When she turns her back to you, you can tell she's not <i>entirely</i> human, what with the long red spaded tail coming out from under her dress.");
	//(Have met, relationship 0-19)
	else if (rubiAffection() < 30) output("Rubi is here, moving from table to table efficiently clearing the empty ones and serving new customers.  Her long red tail swishes back and forth, sometimes lifting her dress enough to get a peek at her panties.");
	//(Have met, relationship 40, Bimbo Rubi; cheating scene)
	else if (rubi.isBimbo() && int(flags["COC.RUBI_PROSTITUTION"]) == 0 && rand(9) == 0) {
		output("Strangely, even though you know it's time for Rubi's shift, she's not here.\n");
		//(Rubi button still active, goes to \"<i>Cheating Rubi</i>\" scene)
		//(Have met, relationship 40, Bimbo Rubi)
		return cheatingRubi;
	}
	else if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output("Rubi is here, moving from table to table, not quite as efficiently as [rubi.ey] used to, but with a lot more exuberance.  [rubi.Eir] long red tail swishes around, seemingly drawn towards the crotch of patrons and co-workers alike.");
	else output("Rubi is here, moving from table to table efficiently clearing the empty ones and serving new customers.  [rubi.Eir] long red tail swishes back and forth excitedly.");
	output("\n");
	return approachRubiScenes;
}

//Approach Rubi scenes
public function approachRubiScenes():void {
	//output(images.showImage("rubi-at-cafe"), false);
	clearOutput();
	rubiSprite();
	//(First time)
	if ((flags["COC.RUBI_INTRODUCED"]) == 0) {
		output("You take a seat at a table and within seconds a young girl is at your side.  She hooks a finger around her ear, pulling her short black hair back and wedging a pencil behind the ear.  Smoothing down the front of her pink and white waitress uniform, she gives you a chipper smile.  \"<i>Hey hun, welcome to the Tel'Adre Bakery, I'm Rubi,</i>\" she says, giving a little curtsey.  \"<i>If you want any pastries or anything, just head on up to the counter and they'll take care of you.  If you need anything to drink: milk, tea or coffee, just flag me down and I'd be happy to help.</i>\"");
		output("\n\n\"<i>Our milk goes excellently with the cookies and brownies, and we get it fresh every day.  We can serve it warm or cold, however you want it.  We have several fine teas and coffees available as well.  They just help melt the stress away.  Anyway, here's a list of what we have today,</i>\" she hands you a small paper menu, and you take note of her perfectly manicured nails painted pastel blue.  \"<i>Give me a shout if you need anything!</i>\"  she says and heads off to give the same speech to another table, her black heels clicking on the stone floor with wonderful tak-tak noises.");
		flags["COC.RUBI_INTRODUCED"] = 1;
	}
	//(Approach repeat, relationship 0-19)
	else if (rubiAffection() < 30) {
		output("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  ");
	}
	//(Approach repeat, relationship 20+.  At this stage, randomly select an outfit from what the PC has given him, plus his waitress outfit.  Variants included for Bimbo /Incubus Rubi.)
	else {
		var choices:Array = [1];
		if (rubi.hasItem(new CoCSuitclothes())) choices[choices.length] = 2;
		if (rubi.hasItem(new CoCRubberClothes())) choices[choices.length] = 3;
		//(Green Adventurer's Clothing (Normal)
		// There's NO content covering this outfit here, so I'm commenting it out.
		//There is content, but it is under Adventurer's Outfit.
		if (rubi.hasItem(new CoCAdvClth())) choices[choices.length] = 4;
		//(Tube Top (Normal))
		if (rubi.hasItem(new CoCTubeTop())) choices[choices.length] = 5;
		//(Bodysuit (Normal))
		if (rubi.hasItem(new CoCTransparentBodysuit())) choices[choices.length] = 6;
		//(Long Dress (Normal))
		if (rubi.hasItem(new CoCLongDress())) choices[choices.length] = 7;
		//(Tight Leather Pants (Normal))
		if (rubi.hasItem(new CoCLthrPnt())) choices[choices.length] = 8;
		//(Nurse Clothes (Normal))
		if (rubi.hasItem(new CoCNurseOutfit())) choices[choices.length] = 9;
		//(Slutty Swimwear (Normal))
		if (rubi.hasItem(new CoCSluttySwimwear())) choices[choices.length] = 10;
		if (rubi.hasItem(new CoCBimboSkirt())) choices[choices.length] = 11;
		if (rubi.hasItem(new CoCBondageStraps())) choices[choices.length] = 12;
		if (rubi.hasItem(new CoCInquisitorsCorset())) choices[choices.length] = 13;
		//RIsque waitress uniform
		if (flags["COC.RUBI_AFFECTION"] >= 100) choices[choices.length] = 14;
		
		var select:int = choices[rand(choices.length)];
		
		//trace("Rubi outfit selection = ", select);
		
		//(Random outfit selection: Waitress Outfit (Normal))
		if (select == 1) {
			//(Waitress Outfit (Bimbo))
			output(rubi.mf("He","She") + "'s dressed in [rubi.eir] usual waitress uniform: a pink blouse and skirt covered by a frilly white apron.");
			if (rubi.breastRows[0].breastRating() >= 4) output("  Rubi's breasts strain against the tight blouse, threatening to pop a button at any moment.");
			if (rubi.cocks[0].cLengthRaw >= 9) output("  You notice Rubi holds [rubi.em]self a little awkwardly, and it's only when [rubi.ey] sits down that you spy the slight bulge in [rubi.eir] skirt.");
		}
		//(Suit Clothes (Normal))
		else if (select == 2) {
			//(Suitclothes)
			output(rubi.mf("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a professional black and white suit with a loose tie, though [rubi.ey] still wears the waitress headband");
			if (rubi.hasHorns()) output("just behind the horns");
			output(".  In a sexy sort of way, [rubi.ey] looks like a girl dressed in her boyfriend's clothes");
			if (rubi.breastRows[0].breastRating() >= 4) output(", though with [rubi.eir] large bosom, [rubi.ey] can't quite button up all the way, giving the appearance of a sexy secretary");
			output(".");
		}
		else if (select == 3) {
			//(Rubber Fetish Outfit (Bimbo))
			//(Rubber Fetish Clothes)
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for a tight, black, rubber shirt, along with a skirt, and stockings.  The holes cut into the skirt, proudly displaying Rubi's [rubi.nippleColor] nipples, which stand at perky attention in the cool air.  Rubber straps crisscross the outfit in odd places, and the whole ensemble looks like something out of one of Mareth's many fetish dungeons.  The outfit draws attention to [rubi.eir]");
			if (rubi.breastRows[0].breastRating() >= 4) output(" impressive bosom, and sort of makes [rubi.em] look like the kind of rubber doll one might buy for those lonely nights.");
			else output(" relatively flat chest, though with the rest of [rubi.eir] figure, it's hard to imagine [rubi.em] as anything but a woman.");
		}
		else if (select == 5) {
			//(Tube Top)
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for a neon pink tube top and a pair of tiny denim shorts.");
			//(D breasts or higher)
			if (rubi.breastRows[0].breastRating() >= 4) output("  [rubi.Eir] breasts strain the fabric of the tube top, any wrong move threatening to have them burst forth.");
			//(dick 9" or higher)
			if (rubi.cocks[0].cLengthRaw >= 4) output("  [rubi.Eir] rather large bulge can't be concealed, however, and you sometimes catch Rubi holding [rubi.eir] notepad down across [rubi.eir] crotch when [rubi.ey] moves from table to table.");
			else output("[rubi.Eir] bulge is well concealed at least.  You're sure it would take a skilled eye, or someone who knew what to look for, to notice Rubi's little package.");
		}
		else if (select == 6) {
			//(Bodysuit)
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for an almost sheer bodysuit covering [rubi.em] from the groin up to the neck.  The lacy outfit is covered with flowers and swirling, colorful decorations in strategically placed locations.");
			if (rubi.cocks[0].cLengthRaw >= 9) output("  However, with an outfit this tight, it's almost impossible for [rubi.em] to hide [rubi.eir] impressive package.  Rubi's cock pokes straight upwards, creating a bulge from [rubi.eir] crotch up towards [rubi.eir] belly button.");
			else if (rubi.hasCock()) output("  However, with an outfit this tight you can see a slight outline where [rubi.eir] small package is tucked away.  You wonder how many other patrons have noticed the same thing.");
		}
		else if (select == 7) {
			//(Long Dress (Bimbo))
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for an elegant, sequined ballroom gown.");
			if (rubi.isBimbo()) output("  [rubi.Ey]'s even modified the dress with false gems and a slit up the side to show off [rubi.eir] leg.");
			output("  You are stunned by the breathtaking combination of classy and carnal.  You're sure [rubi.ey] would look great at a fancy ball, but here at the bakery [rubi.ey] looks out of place, especially as a waitress.");
			//(Breasts flat or A cup)
			if (rubi.breastRows[0].breastRating() <= 1) output("  The dress must have come with a padded bra, because you're surprised to see Rubi with  breasts.  Though small, they help to accentuate [rubi.eir] feminine figure.");
		}
		else if (select == 8) {
			//(Tight Leather Pants (Bimbo))
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for a loose silk white shirt with tight black leather pants.");
			if (rubi.breastRows[0].breastRating() >= 4) output("  With [rubi.eir] large rack, [rubi.ey] looks much like a busty piratess.  From the way [rubi.eir] breasts strain at the top, you're certain that one wrong breath could send a button flying across the room.");
			else output("  With [rubi.eir] relatively flat chest, however, you wonder if perhaps it makes [rubi.em] look a bit too much like a man.  An effeminate man, but a man nonetheless.");
			//Cock variants:
			//(9" or higher)
			if (rubi.cocks[0].cLengthRaw >= 9) output("  [rubi.Eir] generous cock is on display, much to [rubi.eir] chagrin, as a bulge running down the length of one pant leg.");
			else output("Luckily, given [rubi.eir] relatively small package, [rubi.eir] bulge is kept nice and secret even with the tightness of the clothing.");
		}
		else if (select == 9) {
			//(Nurse Clothes (Bimbo))
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for a tight, one-piece white dress with a red cross over the breast pocket, and atop her head is perched a little white hat with the same red cross.  [rubi.Ey] looks like the kind of nurse you'd expect to see in your dirty dreams, and you wonder how many bakery customers were thrown by Rubi's odd, albeit sexy, appearance today.");
			//(D breasts or higher)
			if (rubi.breastRows[0].breastRating() >= 4) output("  Rubi's large breasts strain the fabric, drawing the dress further up [rubi.eir] body and showing off more of [rubi.eir] legs and ass.");
		}
		//(Slutty Swimwear (Normal))
		else if (select == 10) {
			//(Slutty Swimwear)
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for an impossibly skimpy black bikini.  It's a cute swimsuit, and Rubi looks damn sexy in it, but you can't help but think it's more suited for a day at the beach and not a day working in a bakery.");
			//(D breasts or higher)
			if (rubi.breastRows[0].breastRating() >= 4) output("  Rubi's tremendous cleavage threatens to spill out of the skimpy bikini top with every movement, and from the red faces around the bakery, you wonder if that's already happened.");
			else if (rubi.breastRows[0].breastRating() <= 1) output("  The top only emphasizes Rubi's relatively flat chest, though with the rest of [rubi.eir] figure, [rubi.ey] still looks extremely feminine.");
		}
		//(Minidress Outfit (Bimbo))
		else if (select == 11) {
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for an impossibly short strapless pink mini-dress.  The top barely comes up to cover [rubi.eir] nipples, and you're sure [rubi.ey] has to adjust it constantly to avoid any wardrobe malfunctions.  The bottom is so short [rubi.ey]'s certainly giving a show to anyone behind [rubi.em] whenever [rubi.ey] leans forward.  All in all, Rubi looks like [rubi.ey]'s ready for a night on the town and not a day waiting tables.");
			if (rubi.hasCock()) output("  [rubi.Eir] skirt rides so high you catch glimpses of [rubi.eir] unsurprisingly unpantied crotch, and the enticing package held within.  You wonder how many people have gotten a surprise with their drinks today!");
		}
		//(Bondage Straps)
		else if (select == 12) {
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for a series of leather straps and hooks.  A series of leather belts cross [rubi.eir] body, covering strategic areas with thicker, more pliable straps.  You wonder how comfortable such an outfit could be, and as you do so you notice Rubi dig out a wedgie when [rubi.ey] thinks no one's looking.  How Rubi can continue to work at the bakery wearing this, you'll never know.");
		}
		//(Inquisitor's Corset)
		else if (select == 13) {
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for a tight red and gold corset, connected with garter straps to a pair of sheer black stockings.  The corset really enhances Rubi's naturally feminine figure, though you can't imagine it being too comfortable.  The black, opaque stockings come up to [rubi.eir] thighs have an inlaid gold corset pattern on the back, which lead up to a pair of bows that bounce perkily as Rubi walks.");
		}
		//(Risque Waitress Uniform)
		else if (select == 14) {
			output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for an extremely modified version.  The skirt wrapped around [rubi.eir] waist could be confused for a belt, and the apron (the only other thing covering [rubi.eir] torso) doesn't extend much further.  Any time Rubi takes a step or bends in any direction, anyone within sight is sure to get a good look at [rubi.eir] ");
			if (rubi.hasCock()) output("[rubi.cock], clad in a cute little frilly pink cocksock");
			if (rubi.hasVagina() && rubi.hasCock()) output(" and ");
			if (rubi.hasVagina()) {
				output("feminine mound trapped beneath a pair of pink panties");
				//(if Bimbo Brain)
				if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output(" trimmed feminine mons, free and open to the air");
			}
			output(".");
			//(D breasts or higher)
			if (rubi.breastRows[0].breastRating() >= 4) output("  Rubi's breasts, large as they are, show off a decent amount of sideboob and threaten to spill out at any moment.  Judging by the flushed faces of some customers, this may have already happened.");
			output("  This outfit, as risque as it is, is clearly something Rubi never would have worn before [rubi.ey] met you.  [rubi.Ey] must be really comfortable in [rubi.eir] body now!");
		}
		output("\n\n[rubi.Ey] hands you the usual menu and says, \"<i>");
		if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output("Like, h");
		else output("H");
		output("ere's the menu, babe.  Think about what you want and let me know when you're ready.</i>\"  [rubi.Ey] stands and moves to clean off a nearby table, [rubi.eir] red spaded tail swishing behind [rubi.em] sensually.");

		//(Adventurer's Outfit)
		if (select == 4) {
			 output("[rubi.Ey]'s dressed differently today, having foregone the normal waitress uniform for a large green tunic which looks more like a dress on [rubi.em], along with brown tights and a pointed green hat.  At [rubi.eir] waist is a wooden sword alongside [rubi.eir] normal notepad.  Were Rubi more masculine, you might think [rubi.ey] looks like an adventurer of some kind, but in reality [rubi.ey] looks like a normal girl in a strange hat.");
			if (rubi.breastRows[0].breastRating() >= 4) output("  In an odd sort of way, [rubi.ey] looks like an adventurer who met the wrong end of a witch's curse.");
		}
		//(Default Waitress Uniform)
		if (select == 1) {
			output("\n\nAs [rubi.ey] bends over, you get a good look up [rubi.eir] skirt, ");
			if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) {
				output("surprised to see [rubi.ey]'s wearing nothing at all underneath, showing off [rubi.eir] asshole");
				if (rubi.hasVagina() && !rubi.hasCock()) output(" and wet cunt");
				else if (!rubi.hasVagina() && rubi.hasCock()) output(" and limp cock");
				else output(", wet cunt, and limp cock");
				output(" to anyone behind [rubi.em]");
			}
			else output("excited to see Rubi's choice of frilly pink panties clinging to [rubi.eir] supple ass");
			output(".");
		}
		//(Dashing Outfit)
		else if (select == 8) output("\n\nAs [rubi.ey] bends over, you get a good look at [rubi.eir] ass, emphasized by the tight leather pants.");
		//(Adventurer's Outfit)
		else if (select == 15) {
			output("\n\nAs [rubi.ey] bends over, you get a good look up [rubi.eir] dress-like tunic, enjoying the sight of [rubi.eir] round ass emphasized by the dark tights.");
			//If Bimbo Body:
			if (rubi.isBimbo()) output("  You even spy a wet patch in the crotch, with rivulets of moisture running down the legs, which [rubi.ey] must have trouble hiding... if [rubi.ey] even bothers to try.");
		}
		//(Long Dress)
		else if (select == 7) {
			output("\n\nAs [rubi.ey] moves to another table, Rubi sways back and forth, as if dancing with an invisible partner.  ");
			if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output("And then [rubi.ey] begins to shake [rubi.eir] ass, making spanking motions and effectively ruining the air of sophistication.");
		}
		//(Nurse Uniform)
		else if (select == 9) {
			output("\n\nAs [rubi.ey] bends over, you get a good look up [rubi.eir] skirt, ");
			if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) {
				output("surprised to see [rubi.ey]'s wearing nothing at all underneath, showing off [rubi.eir] asshole");
				if (rubi.hasVagina() && !rubi.hasCock()) output(" and wet cunt");
				else if (!rubi.hasVagina() && rubi.hasCock()) output(" and limp cock");
				else output(", wet cunt, and limp cock");
				output(" to anyone behind [rubi.em]");
			}
			else output("excited to see Rubi's choice of frilly white panties clinging to [rubi.eir] supple ass");
			output(".");
		}
		//(Rubber Fetish Outfit)
		else if (select == 3) {
			output("\n\nAs [rubi.ey] bends over, you get a good look up [rubi.eir] skirt, ");
			if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) {
				output("surprised to see [rubi.ey]'s wearing nothing at all underneath, showing off [rubi.eir] asshole");
				if (rubi.hasVagina() && !rubi.hasCock()) output(" and wet cunt");
				else if (!rubi.hasVagina() && rubi.hasCock()) output(" and limp cock");
				else output(", wet cunt, and limp cock");
				output(" to anyone behind [rubi.em]");
			}
			else output("excited to see a pair of translucent rubber panties clinging to [rubi.eir] supple ass");
			output(".");
		}
		//(Suitclothes)
		else if (select == 2) {
			output("\n\nAs [rubi.ey] bends over, you get a good look at [rubi.eir] ass, despite the less-than-flattering cut of the trousers.");
		}
		//(Tube Top)
		else if (select == 5) {
			output("\n\nAs [rubi.ey] bends over, you get a good look at [rubi.eir] ass, emphasized by the tight denim shorts.");
		}
		//(Slutty Swimwear)
		else if (select == 10) {
			output("\n\nAs [rubi.ey] bends over, you get a good look at [rubi.eir] ass, emphasized by the tight bikini bottoms.");
		}
		//(Bimbo Minidress)
		else if (select == 11) {
			output("\n\nAs [rubi.ey] bends over, you get a good look up [rubi.eir] dress, ");
			if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) {
				output("surprised to see [rubi.ey]'s wearing nothing at all underneath, showing off [rubi.eir] asshole");
				if (rubi.hasVagina() && !rubi.hasCock()) output(" and wet cunt");
				else if (!rubi.hasVagina() && rubi.hasCock()) output(" and limp cock");
				else output(", wet cunt, and limp cock");
				output(" to anyone behind [rubi.em]");
			}
			else output("excited to see a cute, little thong wedged into [rubi.eir] supple ass");
			output(".");
		}
		//(Bodysuit)
		else if (select == 6) {
			output("\n\nAs [rubi.ey] bends over, you get a good look at [rubi.eir] ass, emphasized by the tight lace bodysuit.");
			//If Bimbo Body:
			if (rubi.isBimbo()) output("  You even spy a moist patch in the crotch, which must be impossible to hide... if [rubi.ey] even bothers to try.");
		}
		//(Bondage Straps)
		else if (select == 12) {
			output("\n\nAs [rubi.ey] bends over, you get a good look at [rubi.eir] ass, emphasized by a thick leather strap which runs between [rubi.eir] asscheeks like a thong.");
		}
		//(Inquisitor's Corset)
		else if (select == 13) {
			output("\n\nAs [rubi.ey] bends over, you get a good look at [rubi.eir] ass, emphasized by the gold-laced red panties.");
		}
		//(Risque Waitress Uniform)
		else if (select == 14) {
			output("\n\nAs [rubi.ey] bends over, you get a good look up [rubi.eir] sad excuse for a skirt, ");
			if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) {
				output("surprised to see [rubi.ey]'s wearing nothing at all underneath, showing off [rubi.eir] asshole");
				if (rubi.hasVagina() && !rubi.hasCock()) output(" and wet cunt");
				else if (!rubi.hasVagina() && rubi.hasCock()) output(" and limp cock");
				else output(", wet cunt, and limp cock");
				output(" to anyone behind [rubi.em]");
			}
			else output("excited to see a pair of pink frilly panties clinging to [rubi.eir] supple ass");
			output(".");
		}
	}
	//(add to the bottom of all:)
	output("\n\nYou look over the menu... what do you want?\n-----------------------\nMilk: 3 gems\nTea: 6 gems");
	//[Milk] [Tea] [Chat] [Rubi's Place (Relationship 20+)] [Leave]
	clearMenu();
	if (pc.credits >= 30) addButton(0, "Milk", buyRubiMilk);
	else addDisabledButton(0, "Milk", "Milk", "You cannot afford milk.");
	if (pc.credits >= 60) addButton(1, "Tea", getTeaFromRubi);
	else addDisabledButton(1, "Tea", "Tea", "You cannot afford tea.");
	addButton(2, "Chat", chatWithRubi);
	if (flags["COC.RUBI_ADMITTED_GENDER"] >= 1) addButton(3, "Rubi's Place", rubisFuckingHouseYouPervert);
	else addDisabledButton(3, "Rubi's Place");
	addButton(14, "Leave", bakeryuuuuuu);
}

//Choose Milk?
public function buyRubiMilk():void {
	clearOutput();
	rubiSprite();
	//(Increase thickness by a small amount?  +1 relationship)
	//(Relationship 0-19)
	if (rubiAffection() < 30) {
		output("You flag down Rubi and tell [rubi.em] you'd like to order some milk.  [rubi.Ey] nods and soon you're holding a glass of sweet smelling milk.  \"<i>We get it fresh every day,</i>\" [rubi.ey] says as you take a drink.  It is quite delicious.  You gulp it down, and find another glass placed in front of you.  \"<i>Free refills, hun.</i>\"");
		output("\n\nYou take it easier on the next couple glasses.  You chat with Rubi whenever [rubi.ey] comes by to top you off, and after a little while you find you've gotten to know [rubi.em] a bit better.  Feeling full enough, you excuse yourself and head back to camp.");
		//(Increase thickness by a small amount?  +1 relationship)
	}
	//(Bimbo Rubi)
	else if (rubi.isBimbo()) {
		output("You flag down Rubi and tell her you'd like to order some milk.  She nods and soon you're holding a glass of sweet smelling milk.  \"<i>We like, get it fresh every day,</i>\" she says and giggles as you take a drink.  It is quite delicious.  You gulp it down, and find another glass placed in front of you.  \"<i>Free refills, baby.</i>\"");
		output("\n\nYou take it easier on the next couple of glasses.  You chat with Rubi whenever she comes by to top you off, and it's not long before she's sitting on your lap and giggling as you make terrible jokes.  After a while, you excuse yourself and head back to camp.");
	}
	//(Relationship20+, normal Rubi)
	else {
		output("You flag down Rubi and tell [rubi.em] you'd like to order some milk.  [rubi.Ey] nods and soon you're holding glass of sweet smelling milk.  \"<i>We get it fresh every day,</i>\" [rubi.ey] says as you take a drink.  It is quite delicious.  You gulp it down, and find another glass placed in front of you.  \"<i>Free refills, babe.</i>\"");
		output("\n\nYou take it easier on the next couple glasses.  You chat with Rubi whenever [rubi.ey] comes by to top you off, it's not long before [rubi.ey]'s sitting with you and laughing as you make terrible jokes.  After a while, you excuse yourself and head back to camp.");
	}
	processTime(15);
	pc.credits -= 30;
 	rubiAffection(3);
	//pc.refillHunger(7);
	Mutator.modThickness(pc, 100, 1, true);
	if (rubiAffection() >= 30 && int(flags["COC.RUBI_ADMITTED_GENDER"]) == 0) addNextButton(specialRelationship20scene);
	else addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Choose Tea?
public function getTeaFromRubi():void {
	clearOutput();
	rubiSprite();
	//(Reduce arousal and fatigue slightly?  +1 relationship)
	//(Relationship 0-19)
	if (rubiAffection() < 30) {
		output("You flag Rubi down and tell her you'd like to order a cup of tea.  She nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's our relaxing blend, soothes the body and mind,</i>\" she says.  You take a sip and sigh.  It is indeed relaxing.");
		output("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to chat and check on you.  After a while you feel like you've gotten to know her a bit better.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	//(Bimbo Rubi)
	else if (rubi.isBimbo()) {
		output("You flag Rubi down and tell her you'd like to order a cup of tea.  She nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's like, our relaxing blend.  Supposed to sooth the body and mind or something,</i>\" she says and giggles.  You take a sip and sigh.  It is indeed relaxing.");
		output("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to gossip and check on you.  She even takes a break to give you a sensual shoulder massage, often pressing her large chest into your back.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	//(Relationship 20+, normal Rubi)
	else {
		output("You flag Rubi down and tell [rubi.em] you'd like to order a cup of tea.  [rubi.Ey] nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's our relaxing blend, soothes the body and mind,</i>\" [rubi.ey] says.  You take a sip and sigh.  It is indeed relaxing.");
		output("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to chat and check on you.  [rubi.Ey] even takes a small break to give your temples a brief massage.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	processTime(15);
	pc.credits -= 60;
	rubiAffection(5);
	//pc.refillHunger(7);
	//pc.changeFatigue(-25);
	pc.energy(25);
	if (rubiAffection() >= 30 && int(flags["COC.RUBI_ADMITTED_GENDER"]) == 0) addNextButton(specialRelationship20scene);
	else addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Choose Chat?
public function chatWithRubi():void {
	clearOutput();
	rubiSprite();
	//(+1 relationship)
	rubiAffection(2);
	//(Relationship 0-9)
	if (rubiAffection() < 15) {
		output("You decide not to order anything to drink, instead taking the chance to talk with your waitress, Rubi, whenever [rubi.ey]'s available.  You talk of pleasant but inconsequential things.  Rubi talks of growing up in a town far away, an actual human village, which was later raided by demons.  [rubi.Ey] lived off the land for a while, drinking down one too many bottles of mysterious milk which gave [rubi.em] the tail she now possesses.  [rubi.Ey] eventually found Tel'Adre and was taken in by a kindly trio of ferret-morphs.  [rubi.Ey] talks wistfully of home, and [rubi.eir] green eyes shimmer with a faraway look for a moment before [rubi.ey] snaps back to reality.");
		output("\n\nExcusing herself, [rubi.ey] moves to attend with other tables.  You decide this is a good time to head back to camp as well.");
	}
	//(Relationship 10-19)
	else if (rubiAffection() < 30) {
		rubiAffection(8);
		output("You decide not to order anything to drink, instead taking the chance to talk with Rubi whenever [rubi.ey]'s available.  You talk of pleasant but inconsequential things.  Rubi spends some time describing [rubi.eir] life living outside the safety of Tel'Adre.  [rubi.Ey]'d never been caught by the various creatures, but there have been close calls.  [rubi.Ey] met several people who helped her out, however.  [rubi.Ey] talks highly of a dogmorph that runs a farm not far away, and of an otter-girl that fishes along a nearby lake.  [rubi.Ey] laughs and reminisces about how good the otter-girl's cooking was, and that even now [rubi.ey] still can't find a decent fish filet.");
		output("\n\nEventually you run out of topics to discuss, and excuse yourself, heading back to camp.");
	}
	//(Relationship 20-39)
	else if (rubiAffection() < 100) {
		output("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever [rubi.ey] has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time describing life with [rubi.eir] three adoptive ferret parents.  Two males and a female, apparently, all lovers.  Rubi was taken in by them several years ago, and though [rubi.ey]'s since moved out, [rubi.ey] still keeps in contact with them.  [rubi.Ey] blushes and tells you of the times [rubi.ey]'s been unable to sleep, hearing the three of them going at it for hours on end.");
		output("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a kiss on the cheek before heading back to camp.");
	}
	//(Relationship 40, Bimbo Rubi)
	else if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) {
		output("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever [rubi.ey] has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time discussing the fashion movements of Tel'Adre and how they're nothing like the fashion in [rubi.eir] home village, an honest-to-goodness human village.  [rubi.Ey] mentions how everyone back 'home' dressed so conservatively, not like the sexy body-baring fashions here.  Rubi even says how glad [rubi.ey] is that demons attacked those years ago, so that [rubi.ey] could come here and start her new life with hot new clothes and a new body.");
		output("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a passionate kiss on the lips before heading back to camp.");
	}
	//(Relationship 40, normal Rubi)
	else {
		output("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever [rubi.ey] has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time discussing [rubi.eir] old village, an honest-to-goodness human village.  Life there was good, they had plenty of farms bringing in food, and very little corruption to contend with.  There were some residents with inhuman features, usually achieved willingly, but the majority were pureblood humans.  That changed years ago when a detachment of incubi, succubi and imps attacked.  Rubi and a handful made it out fine, but got split up along the way.  As far as Rubi knows, everyone else either perished or was corrupted in the aftermath.");
		output("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a kiss on the lips before heading back to camp.");
	}
	processTime(15);
	if (rubiAffection() >= 30 && int(flags["COC.RUBI_ADMITTED_GENDER"]) == 0) addNextButton(specialRelationship20scene);
	else addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Choose Rubi's Place?
public function rubisFuckingHouseYouPervert():void {
	//output(images.showImage("rubi-at-house"), false);
	clearOutput();
	rubiSprite();
	//(Not available to those with a centaur, naga or drider body.)
	//(First Time?)
	if (int(flags["COC.RUBIS_HOUSE_FIRST_TIME"]) == 0) {
		output("Rather than order anything, you stop Rubi as he's going by your table and pull [rubi.em] close.  \"<i>How about we get out of here?</i>\" you whisper into [rubi.eir] ear.");
		output("\n\n[rubi.Ey] blushes slightly and his tail swishes excitedly behind [rubi.em].  \"<i>Just,</i>\" [rubi.ey] looks around quickly, \"<i>Just let me find someone to cover my shift.</i>\"  [rubi.Ey] promptly heads off into the back room, returning minutes later with a young canine girl in a waitress uniform.  Rubi points out a few tables, says some things to his replacement and then returns to your side.");
		output("\n\n[rubi.Ey] clutches your arm tightly and says, \"<i>My place isn't far away, let's go.</i>\"   You stand and [rubi.ey] takes you by the arm through the streets of Tel'Adre.  [rubi.Ey] leads you over a couple blocks into a rather nice looking neighborhood, and up to a row of tightly packed houses.  The two of you continue through a carefully tended garden and through the front door.");
		output("\n\nRubi relinquishes [rubi.eir] grip on your arm and says, \"<i>Make yourself at home!</i>\"  as [rubi.ey] rushes off into another room.  You take this opportunity to look around.  The place seems tastefully decorated, with lots of cushions and pillows to sit or lay on, in a variety of colors.  On the mantel above the fireplace sits a slightly scorched portrait of two happy-looking humans with a very young boy.  You'd guess that's Rubi and [rubi.eir] family, before the demon attack.");
		output("\n\nYou don't have to wait for Rubi long, as [rubi.ey] comes back holding two glasses of wine.  [rubi.Ey] hands you one, and you take a sip, slightly surprised at the elegant flavors and delightful aroma.  The two of you drink and chat for a while, but then Rubi looks you in the eye and says, \"<i>So... You've got me alone.  What did you have in mind?</i>\"");
		flags["COC.RUBIS_HOUSE_FIRST_TIME"] = 1;
	}
	//Bimbo Shopping!
	else if (rubi.isBimbo() && pc.isBimbo() && rand(7) == 0) {
		processTime(45);
		if (!rubi.hasItem(new CoCBimboSkirt())) rubi.inventory.push(new CoCBimboSkirt());
		output("Rather than order anything, you stop Rubi as she's going by your table and pull her close.  \"<i>How about we get out of here?</i>\"  you whisper into her ear.");
		output("\n\nRubi's mouth pulls into a Cheshire-like grin and she nods.  \"<i>Like, for sure!  Just let me get Dia to cover my tables, kay?</i>\"  She promptly heads off into the back room, returning minutes later with the young canine waitress behind her.  Rubi points out a few tables, says some things to her replacement, and then returns to your side.");
		output("\n\n\"<i>Let's totally blow this joint,</i>\" she says and you head off towards her place.  However, you don't make it too far.  On your way to the neighborhood Rubi lives in, you pass a little tailor's shop with the cutest little outfit in the window.  Giggling to yourselves, and completely forgetting what you were doing, you enter the shop.");
		output("\n\nPretty fabrics are laid out on every surface, pinks and pastels, with frills and lace.  Cute little tops and matching bottoms hang up, and Rubi immediately darts to one section, going through the racks with gleeful abandon.  You can't help but giggle and join her, going through outfit after outfit, and comparing it to yourself or your airheaded companion.");
		output("\n\nAfter about a half hour of trying on various outfits, Rubi picks out a gorgeous little outfit and purchases it.");
		//(10% chance of finding the Bimbo Skirt; only happens once)
		if (int(flags["COC.RUBI_GOT_BIMBO_SKIRT"]) == 0) {
			flags["COC.RUBI_GOT_BIMBO_SKIRT"] = 1;
			output("\n\nMeanwhile, nothing really catches your eye... that is until you spot a pink, pleated skirt, with a pink and white halter top.  You squeal with delight as you pick it out.  It's just your size!");
			output("\n\n\"<i>Ooh, that looks so sexy, babe.  Let me get that for you.  My treat, for such a sexy beast,</i>\" Rubi exclaims, and passes the money to the tailor.  As you leave the shop, you thank your lover profusely, and then head back to camp.");
			output("\n\nIt's only once you get back that you realize you meant to fuck Rubi while you were in town!  You giggle and curse your airheadedness.  Oh well, you can always go into town again, there's always more shopping to be done!");
			//(Add Bimbo Skirt to inventory)
			itemScreen = mainGameMenu;
			lootScreen = mainGameMenu;
			useItemFunction = mainGameMenu;
			itemCollect([new CoCBimboSkirt()]);
			return;
		}
		//(If Bimbo Skirt not found)
		else {
			output("\n\nMeanwhile, nothing really catches your eye, and you end up leaving the shop feeling rather unfulfilled.  Your lover gives you a quick peck on the cheek and thanks you for a great time, and you go your separate ways again.");
			output("\n\nIt's only once you get back to camp that you realize you meant to fuck Rubi while you were in town!  You giggle and curse your airheadedness.  Oh well, you can always go into town again, there's always more shopping to be done!");
			addNextButton();
			return;
		}
	}
	//(Repeat, Bimbo Rubi)
	else if (rubi.isBimbo()) {
		//(If PC is also a Bimbo, there is a small chance to get the Bimbo Shopping encounter instead)
		output("Rather than order anything, you stop Rubi as she's going by your table and pull her close.  \"<i>How about we get out of here?</i>\"  you whisper into her ear.");
		output("\n\nRubi's mouth pulls into a Cheshire-like grin and she nods.  \"<i>Like, for sure!  Just let me get Dia to cover my tables, kay?</i>\"  She promptly heads off into the back room, returning minutes later with the young canine waitress behind her.  Rubi points out a few tables, says some things to her replacement, and then returns to your side.");
		output("\n\n\"<i>Let's totally blow this joint,</i>\" she says and you head off towards her place.  The two of you settle into her newly redecorated home.  It seems she replaced the originally colorful pillows and curtains with various shades of pink, and her family portrait has been painted over in spots, now showing a happy human couple and their daughter all dressed up in pink.");
		//(If PC is Pimping Bimbo Rubi AND it's been a day since last seeing Rubi)
		if (flags["COC.RUBI_PROSTITUTION"] == 2 && flags["COC.RUBI_PROFIT"] > 0) {
			output("\n\nYour little fuckslut scampers over to a little bejeweled lockbox and opens it, retrieving a sackful of money.  \"<i>Here's your cut for my little side job,</i>\" she giggles.");
			//(Produces money daily?  Not too much, Rubi's a dumb blonde, and we don't want the PC to have a gem farm.  Enough to make it useful, not enough to make it mandatory.)
			pc.credits += flags["COC.RUBI_PROFIT"] * 10;
			flags["COC.RUBI_PROFIT"] = 0;
		}
		output("\n\n\"<i>So baby, what do you wanna do to me?</i>\" she whispers into your ear.");
	}
	//Repeat unirubi variant
	else {
		output("Rather than order anything, you stop Rubi as [rubi.ey]'s going by your table and pull [rubi.em] close.  \"<i>How about we get out of here?</i>\" you whisper into [rubi.eir] ear.");
		output("\n\nThe little demon-" + rubi.mf("boy","girl") + " blushes and [rubi.eir] tail swishes excitedly behind [rubi.em].  \"<i>Again?</i>\" [rubi.ey] asks, looking around furtively, \"<i>let me get Dia to cover my shift.</i>\"  [rubi.Ey] promptly heads off into the back room, returning minutes later with the young canine waitress behind [rubi.em].  Rubi points out a few tables, says some things to [rubi.eir] replacement, and then returns to your side.");
		output("\n\n“<i>Let's go</i>,” [rubi.ey] whispers and you head off towards [rubi.eir] place.  It doesn't take long for the two of you to make your way through the streets of Tel'Adre and up through Rubi's well tended garden.");
		output("\n\nBefore you know it, you're once again standing in Rubi's tastefully decorated living room.  Lots of pillows and cushions are strewn about the room to sit or lay on, and a large plush couch sits opposite a fireplace. On the mantel above the fireplace sits a slightly scorched portrait of a happy-looking human couple with a young boy.  You'd guess that's Rubi's family from before the demons attacked [rubi.eir] village.");
		output("\n\nRubi stretches out on the couch and says,  \"<i>So babe, now that you've got me here, what do you want to do?</i>\"");
	}
	//[Fuck Rubi (if player has cock, OR at least a 4</i>\" clit)] [Dildo Fuck (If player has Deluxe Dildo)] [Tease] [Release (Only if Normal or Incubus Rubi who has been teased)] [Titfuck (Bimbo Rubi only)] [Give Item]
	clearMenu();
	addButton(0, "Sex", rubiSexMenu);
	addButton(1, "Closet", goInRubisClosetSoThatYouCanComeOutOfTheCloset);
	addButton(2, "Identity", rubiIdentity);
	if (rubiAffection() >= 50 && !rubi.isBimbo() && rubi.hasCock() && (!rubi.isBimbo() || int(flags["COC.RUBI_DEBIMBO"]) > 0)) { // two no-bimbo checks? Etis approves!
		//First Time:
		if (int(flags["COC.TIMES_RUBI_MASSAGED"]) == 0) output("\n\nRubi gestures to some bottles and a box from the bakery before mentioning, \"<i>You look awful tense, babe.  I know you've got it hard out there, and well, I-I thought maybe I could really pamper you today, if you'd like.</i>\"");
		else output("\n\nRubi nods towards the bottles and box in the corner and gives you a sly wink.  \"<i>Want another massage?</i>\"");
		addButton(4,"Massage",chocoRubiMassage);
	}
	else addDisabledButton(4, "Massage", "Massage", "Rubi should have a cock and high enough affection. Not available if Rubi is bimbo.");
	if (pc.isNaga() && !rubi.isBimbo() && rubi.cocks[0].cLengthRaw < pc.biggestCockLength() && pc.hasCock() && !rubi.isFeminine() && pc.cor() >= 85 && rubi.breastRows[0].breastRating() <= 2)
	{
		output("\n\n<b>You could use your snake-like motions to hypnotize Rubi and turn [rubi.em] into a more complacent, eager slut. Doing so is likely irreversible.</b>")
		addButton(5,"Hypno",hypnoBimboficationForRubiSloots, undefined, "Hypno", "You could use your snake-like motions to hypnotize Rubi and turn [rubi.em] into a more complacent, eager slut. Doing so is likely irreversible.");
	}
	addButton(14,"Leave",returnToCampUseOneHour);
}

private function rubiSexMenu():void {
	//[Fuck Rubi (if player has cock, OR at least a 4</i>\" clit)] [Dildo Fuck (If player has Deluxe Dildo)] [Tease] [Release (Only if Normal or Incubus Rubi who has been teased)] [Titfuck (Bimbo Rubi only)] [Give Item]
	clearMenu();
	if (pc.hasCock() || (pc.hasVagina() && pc.clitLength >= 4)) addButton(0, "Fuck", fuckRubi);
	
	if (pc.hasKeyItem("Deluxe Dildo")) addButton(1, "Dildo Fuck", dildoFuckRubi);
	else addDisabledButton(1, "Dildo Fuck", "Dildo Fuck", "This option requires you to have Deluxe Dildo.");
	
	addButton(2, "Tease", teaseRubi);
	
	if (flags["COC.RUBI_BLU_BALLS"] > 0 && flags["COC.RUBI_ORGASM_DENIAL"] > 0 && !rubi.isBimbo() && rubi.hasCock()) addButton(3, "Release", releaseRubi);
	else addDisabledButton(3, "Release", "Release", "This option is only available after orgasm denial.");
	
	if (flags["COC.RUBI_AFFECTION"] >= 75 && rubi.analCapacity() < pc.biggestCockVolume() && pc.hasCock())
		addButton(4, "Train", anallyTrainYourBitchBoySlutHowToBeAnalForDCL);
	else addDisabledButton(4, "Train", "Train", "This option is only available if you have a cock which is too large for Rubi, and [rubi.hisHer] affection is high enough.");
	//Get Fucked
	//PC gets fucked by Rubi
	//Rubi must have at least a 5" cock
	//Requires 75 Affection
	if (flags["COC.RUBI_AFFECTION"] >= 75 && rubi.hasCock() && rubi.cocks[0].cLengthRaw >= 5)
		addButton(5, "Get Fucked", getFuckedByRubi);
	else addDisabledButton(5, "Get Fucked", "Get Fucked", "This option requires Rubi to have at least 5\" cock and high enough affection.");
	//Hotdogging
	//PC hotdogs Rubi's ass
	//PC must have a penis
	if (pc.hasCock()) addButton(6, "Hotdogging", rubiHotdogging);
	else addDisabledButton(6, "Hotdogging", "Hotdogging", "This option requires you to have a cock.");
	addButton(14, "Back", rubisFuckingHouseYouPervert);
}

private function rubiIdentity():void {
	clearOutput();
	rubiSprite();
	//Identity
	if (int(flags["COC.TIMES_DISCUSSED_RUBIS_IDENTITY"]) == 0) {
		output("You've noticed Rubi always refers to himself as a \"he\", despite ");
		if (!rubi.hasVagina())
			output("his attempts to appear otherwise");
		else
			output("his relatively recent transformation to the contrary");
		output(".  Questioning him about it, he simply blushes.");
		output("\n\n\"<i>Oh, that... Um, I guess I never really figured I was a girl, you know?  I really love pretty clothes and other things people call girly, but I never necessarily wanted to be a girl.");
		if (rubi.hasVagina())
			output("  Though now that I am, I absolutely love it!");
		output("</i>\" he confides, fidgeting slightly.  \"<i>If you wanted to call me a \"she\", I'd be OK with that, just so you know.</i>\"");
		output("\n\nWhich type of pronoun would you prefer Rubi to use?");
	}
	//(Repeating?)
	else {
		output("You talk with Rubi at length about [rubi.eir] gender identity again.  All in all, [rubi.ey] seems pretty open to being either gender, with no real preference one way or another as long as [rubi.ey] gets [rubi.eir] pretty dresses.");
		output("\n\nWhich type of pronoun would you prefer Rubi to use?");
	}
	IncrementFlag("COC.TIMES_DISCUSSED_RUBIS_IDENTITY");
	//[He] [She]
	clearMenu();
	addButton(0,"He",rubiIsAHe);
	addButton(1,"She",rubiIsAShe);
}

//He
private function rubiIsAHe():void {
	clearOutput();
	rubiSprite();
	rubi.createStatusEffect("Force Male Gender");
	output("Rubi nods, and will refer to himself as a \"he\" from now on.");
	clearMenu();
	addButton(14,"Back",rubisFuckingHouseYouPervert);
}
//She
private function rubiIsAShe():void {
	clearOutput();
	rubiSprite();
	rubi.removeStatusEffect("Force Male Gender");
	output("Rubi nods, and will refer to herself as a \"she\" from now on.");
	clearMenu();
	addButton(14,"Back",rubisFuckingHouseYouPervert);
}
//Sex Scenes Ahoy!
//There are variants for Normal, Bimbo and Incubus Rubi, as well as smaller variations if you're currently teasing him or not.
//Fuck Rubi
//(available for players with cocks or large clits (at least 4</i>\")) (If Orgasm Denial is activated, adds 1 to Blue Balls)
public function fuckRubi():void {
	//output(images.showImage("rubi-fuck"), false);
	var x:int;
	x = pc.cockThatFits(rubi.analCapacity());
	if (x < 0)
		x = pc.biggestCockIndex();
	clearOutput();
	rubiSprite();
	//(-100 Arousal)
	output("You take Rubi by the hand and head into the bedroom, clutching [rubi.em] close.  You sit on the edge of the soft fluffy bed and pull the little demon " + rubi.mf("boy","girl") + " onto your lap.  The two of you kiss, letting your " + pc.tongueDescript() + " explore the depths of your partner's mouth.");
	output("\n\nRunning your hands along Rubi's body, you pull and tear at the clothes keeping you apart.  Garments fly as you ravish each other, and it isn't long before you're both naked, with Rubi straddling your waist.  " + rubi.mf("He giggles and reaches between his legs","She giggles and reaches between her legs") + ", wrapping slender fingers around your ");
	if (pc.hasCock())
	{
		// trace("Rubi - PlayerHasCock");
		output(pc.cockDescript(x), false);
	}
	else
		output(pc.clitDescript(), false);
	output(".");

	var size:int = 0;
	var cock:Boolean = pc.hasCock();
	//(If player cock/clit at or under 4</i>\")
	if (pc.hasCock()) {
		if (pc.cocks[x].cLength() <= 4) size = 0;
		else if (pc.cockThatFits(rubi.analCapacity()) >= 0) size = 1;
		else size = 2;
	}
	else {
		if (pc.clitLength <= 4) size = 0;
		else if (new CockClass(pc.clitLength).volume() <= rubi.analCapacity()) size = 1;
		else size = 2;
	}
	if (size == 0) {
		output("\n\n\"<i>Oh, not packing much here, hm?</i>\"  Rubi asks, smiling, \"<i>");
		if (rubi.cocks[0].cLengthRaw <= 5) output("I guess we're in the same boat.</i>\"");
		else if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output("That's too bad, I was soooo looking forward to a real fucking.</i>\"");
		else output("That's pretty sad, getting shown up by a dainty little thing like me...</i>\"");
	}

	else if (size == 1) output("\n\n\"<i>Oh wow, you're quite the stud,</i>\" Rubi says, eyes sparkling with anticipation.");
	//(If too big, dick/clit area above 24)
	else output("\n\n\"<i>Oh by Marae... there's no way I could fit this inside me... but there are other things we can do with this.</i>\"");

	output("\n\nRelinquishing the hold on your ");
	if (pc.hasCock()) output("cock");
	else output("clit");
	output(", Rubi slips off your lap and kneels on the floor.  [rubi.Ey] pauses a moment, taking in your ");
	if (pc.hasCock()) output(pc.cockDescript(x));
	else output("[pc.clit]");
	output(" with [rubi.eir] eyes before leaning in and giving it a tentative lick, which sends a shiver up your spine.  Seeing that, [rubi.ey] gives a little smile and licks again, running [rubi.eir] smooth tongue all along the length of your ");
	if (pc.hasCock()) output("swollen member");
	else output("impressive love button");
	output(".  Rubi's mouth dances along its length, at times flicking delicately and at others slurping loudly.  [rubi.Eir] tongue ripples along the underside of ");
	if (pc.hasCock()) output("your cockhead");
	else output("the tip of your clit");
	output(", sending shivers of pleasure up your spine.");
	//(If Cock)
	if (pc.hasCock()) output("  Amazingly, with the expert ministrations of your lover's mouth, you can't hold yourself in much longer, and begin to tense up, but at the last minute you pull yourself away from Rubi's grip and lips, halting yourself before you can cum.");

	//(These two paragraphs for cocks under 24 area)
	if (size < 2) {
		//(Normal/Incubus Rubi)
		output("\n\nFiguring [rubi.ey]'s had enough time in charge, you stand and get behind Rubi, pushing [rubi.em] so that [rubi.eir] chest and head are resting on the edge of the bed.  You lift [rubi.eir] tail and place your ");
		if (pc.hasCock()) output(pc.cockDescript(x));
		else output("[pc.clit]");
		output(" at [rubi.eir] tight ");
		if (!rubi.hasVagina()) output("tailhole");
		else output("pussy");
		output(", rubbing the mixture of [rubi.eir] saliva and your juices into [rubi.eir] cleft to get [rubi.em] suitably lubricated before the real fun begins");
		if (rubi.isBimbo()) output(", not that [rubi.ey] needs the extra lubrication, as [rubi.ey]'s practically dripping like a faucet");
		output(".");
		output("  You press forward, sinking your entire length into Rubi's depths, which clench and unclench sensually.");
		pc.cockChange();
		output("  Aided by the additional lubrication, you slip easily in and out, pumping slowly at first.");
	}
	//(These two paragraphs for cocks over 24 area)
	else {
		output("\n\nFiguring [rubi.ey]'s had enough time in charge, you stand and get behind Rubi, pushing [rubi.em] so that [rubi.eir] chest and head are resting on the edge of the bed.  You lift [rubi.eir] tail, press [rubi.eir] legs together, and place your ");
		if (pc.hasCock()) output(pc.cockDescript(x));
		else output("[pc.clit]");
		output(" at the space just below [rubi.eir] ");
		if (!rubi.hasVagina()) output("balls");
		else output("cunt");
		output(", rubbing the mixture of [rubi.eir] saliva and your juices into [rubi.eir] legs to get [rubi.em] suitably lubricated before the real fun begins");
		//(if bimbo)
		if (rubi.isBimbo()) output(", not that [rubi.ey] needs the extra lubrication, as she's practically dripping like a faucet, which dribbles down [rubi.eir] legs suitably enough");
		output(".");
		output("\n\nYou press forward, your enormous ");
		if (pc.hasCock()) output(pc.cockDescript(x));
		else output("[pc.clit]");
		output(" slipping between Rubi's thighs, which grip you tightly.  You feel [rubi.eir] ");
		if (rubi.hasCock()) output("hard cock");
		else output("stiff clit");
		output(" pressing against the top of ");
		if (pc.hasCock()) output("your dick");
		else output("your clit");
		output(", and know that with every thrust you give, [rubi.ey]'ll get a good thrill too.");
	}
	output("\n\nThrusting deeper and deeper, you pick up the pace slowly.  Rubi clutches at the blankets, eyes closed, biting [rubi.eir] lip.");
	//(If Orgasm Denial is activated)
	if (flags["COC.RUBI_ORGASM_DENIAL"] > 0 && !rubi.isBimbo())
	{
		output("  You give Rubi's ass a hard smack and remind [rubi.em] that no matter what happens, [rubi.ey] still can't cum yet.  [rubi.Eir] eyes flutter open and [rubi.ey] actually whimpers a little, but can't form the words to object.");
		rubi.tease();
	}
	//(If Orgasm Denial is NOT activated; male/herm Rubi)
	else if (rubi.hasCock()) {
		output("  Rubi’s body shivers and trembles, and almost collapses.  [rubi.Ey] grasps at the blankets with wild abandon as ropes of pearly white cum erupt from [rubi.eir] cock, splattering against [rubi.eir] chest and the blankets.");
		rubi.orgasm();
	}
	//(Female Rubi)
	else {
		output("  Rubi's body shivers and trembles, and [rubi.ey] almost collapses.  [rubi.Ey] grasps at the blankets with wild abandon and gives and orgasmic scream as [rubi.eir] cunt clenches and unclenches fiercely.  A spray of femjuices erupts outwards from [rubi.em], coating your crotch and dripping down both yours and [rubi.eir] legs.");
		rubi.orgasm();
	}
	
	output("\n\nYou keep this up for as long as you can, steeling yourself until you just can't take any more.  With a final, deep thrust, you groan and let your mind blank as the orgasm overtakes you.  ");
	//(Player has cock under 24 area?)
	if (pc.hasCock() && pc.cockVolume(x) <= rubi.analCapacity()) {
		output("Your " + pc.cockDescript(x) + " engorges for a second before erupting deep inside your demonic little fucktoy.  ");
		if (pc.cumQ() < 250) output("Cum dribbles out from [rubi.eir] hole as you give a couple extra thrusts.");
		else if (pc.cumQ() < 1000) output("A generous amount of cum trickles from [rubi.eir] depths as you give a couple extra thrusts.");
		else if (pc.cumQ() < 2000) {
			output("Cum practically floods from  [rubi.eir] abused ");
			if (!rubi.hasVagina()) output("ass");
			else output("cunt");
			output(" as you give a couple extra thrusts.");
		}
	}
	else if (pc.hasCock()) {
		output("Your " + pc.cockDescript(x) + " engorges for a second before erupting beneath Rubi, splattering [rubi.em] and the blankets ");
		if (pc.cumQ() < 250) output("with a fair amount of your seed.");
		else if (pc.cumQ() < 1000) output("with a generous amount of your spunk.");
		else output("with a veritable torrent of potent pearlescent spooge.");
	}
	//(Player has clit?)
	else output("  Your " + pc.clitDescript() + " throbs and engorges briefly as your " + pc.vaginaDescript(0) + " reflexively contracts and a warm feeling rocks through your entire body.  Femjuices run down your [pc.legs] and relief overtakes you like a powerful wave upon a beach.");

	output("\n\nYou stumble backwards, pulling your " + pc.cockClit(x) + " out of Rubi and collapse on the bed next to [rubi.em].  [rubi.Ey] cuddles up next to you, in a mixed puddle of spunk, and hugs you close.  \"<i>That was ");
	if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output("like, totally ");
	else output("absolutely ");
	output("fantastic babe,</i>\" [rubi.ey] murmurs before drifting off into a sex-filled dreamland.");

	output("\n\nYou're tempted to drift off as well, but as they say, you've got things to see and people to do.  So you peel yourself away from Rubi, grab a quick shower, and head off back to camp.");
	processTime(45);
	pc.orgasm();
	rubiAffection(1);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Dildo Fuck
//(If the PC has the Deluxe Dildo) (If Orgasm Denial is activated, adds +2 to Blue Balls (Yay arousal drugs!))
public function dildoFuckRubi():void {
	//output(images.showImage("rubi-dildo-fuck"), false);
	clearOutput();
	rubiSprite();
	//(If PC has no cock)
	if (!pc.hasCock()) output("You don't have the equipment to give Rubi a good fucking, but there is one thing you do have.");
	//(If PC has cock)
	else output("While you do have the requisite equipment to give Rubi a good fucking, you'd much rather use something else.");
	//(Add)
	output("  You produce the goblin-made dildo from your pack, and Rubi's eyes immediately go wide.  \"<i>Wow,</i>\" [rubi.ey] says, reaching out to touch it.  [rubi.Ey] runs [rubi.eir] hands along its length, marveling at its color, shape and size.");

	output("\n\n\"<i>Do... do we get to use it?</i>\"  Rubi asks with apprehension.  You nod, and the grin that crosses [rubi.eir] face can only be described as manic.  The two of you begin to disrobe quickly, until you're both wearing nothing but your birthday suits.");

	output("\n\nYou turn the dildo on yourself first, running the tip along your body as it begins to produce its marvelous arousing substance.  ");
	//(If PC has a cunt)
	if (pc.hasVagina()) output("You press the tip into your cunt quickly, giving it a taste of what is to come.  The brief contact is enough to make you shudder slightly with pleasure.  ");
	//(If PC has fuckable nipples)
	if (pc.hasFuckableNipples()) output("You let the dildo meander up your body until it reaches your breasts, and with a bit of a grin you insert the tip right into one nipple, enjoying the feeling of your breasts swell up with arousal.  You do the same with the other nipple, and take a minute going back and forth.  ");
	output("Finally you bring the dildo up to your mouth, licking the juices off of it, eagerly downing the goblin sex-drug.");

	output("\n\nRubi looks on in rapt silence, and you can tell [rubi.ey]'s eagerly waiting [rubi.eir] turn.  You get on your hands and knees and crawl over " + rubi.mf("him","her") + ", pressing the dildo against [rubi.eir] skin, letting the drug do its magic.  [rubi.Eir] skin flushes and [rubi.ey] curls [rubi.eir] spine impulsively.");

 	output("\n\nLoving the effects it has on Rubi, you take it slow, first letting [rubi.eir] get a taste by pressing the tip against those luscious ruby red lips.  ");

	//(Normal/Incubus Rubi)
	if (!rubi.isBimbo()) output("They part shakily and [rubi.eir] tongue reaches out to taste the dildo.  ");
	//(Bimbo Rubi)
	else output("They easily part, and [rubi.eir] tongue takes a long slurp, just to taste the dildo.  ");

	output("[rubi.Ey] apparently finds it pleasing, because [rubi.ey] immediately wraps [rubi.eir] lips around the tip, sucking and bobbing on it like it was a real cock.");

	output("\n\nYou actually have to yank it out of Rubi's mouth, and tell [rubi.em] that there's one way you can both get a little pleasure out of this.  You urge Rubi to lie down, and you reach down, pressing the tip of the dildo ");
	if (!rubi.hasVagina()) output("against [rubi.eir] tight ass");
	else output("against [rubi.eir] tight pussy");
	output(", which resists a little at first, but once the drug has a moment to work, it slips right in.  Rubi actually coos a little as it slips inside.");

	output("\n\nYou also lie down, and align the other end with your [pc.vagOrAss], and slip it inside.  Warmth radiates outwards as the drug takes full effect, your whole body becoming aroused.");
	//(If player has pussy)
	if (pc.hasVagina()) output("  Your " + pc.clitDescript() + " stiffens, aching for attention.  It peeks from your folds like a shy little lewd faerie.");
	//(If player has a cock)
	if (pc.hasCock()) output("  Meanwhile, [pc.eachCock] stiffens, throbbing as the drug overtakes it.");
	if (pc.lactationQ() > 0) output("  As the warmth spreads up your body, not even your breasts are left alone.  Your nipples harden and begin leaking milk, which pours down the sides of your body and is soaked up into the cushions beneath you.");
	//(Virginity/stretch check!)
	pc.cuntChange(0, 30, true, true, false);

	output("\n\nYou let the dildo inch further inside the both of you as you wiggle your way closer to Rubi.  Your little demon partner \"<i>oohs</i>\" and \"<i>aahs</i>\" with every little movement.  You feel the thickness of the toy increasing as more of your bodily juices seep into it.  Wanting a little extra, you reach down and grab the middle of the toy, rocking it back and forth, fucking both you and Rubi at the same time.");

	output("\n\nYour body shudders as the warmth grows warmer.  Your body feels so hot, like it's on fire and the only way to quench that fire is orgasm.  Rubi is clutching at pillows, rocking [rubi.em]self on the fake pink dong, which only adds fuel to your fire.");
	//(Orgasm Denial on?)
	if (flags["COC.RUBI_ORGASM_DENIAL"] > 0) {
		output("\n\nIn a sudden moment of clarity, you raise your head and look straight at Rubi, shouting that [rubi.ey]'d better not cum during all this, or else you'll be quite upset.  [rubi.Eir] eyes go wide, \"<i>W—What?  I need to cum, " + pc.mf("sir", "miss") + "!  My body, it's so hot!</i>\"  You growl that it's expressly forbidden, and that [rubi.ey]'d better learn to control [rubi.em]self, or else.");
		rubi.tease();
		rubi.tease();
	}
	//(Normal/Incubus Rubi, Orgasm Denial off)
	else if (rubi.hasCock()) {
		output("\n\n[rubi.Eir] body shudders and convulses, and [rubi.eir] [rubi.cock] twitches, launching jets of cum onto [rubi.eir] stomach, chest and face.  In [rubi.eir] sex-filled stupor, [rubi.ey] eagerly swallows down whatever lands in [rubi.eir] mouth, and actually uses [rubi.eir] fingers to collect the rest , gulping that down as well.");
		rubi.orgasm();
	}
	//(Bimbo/Female Rubi)
	else {
		output("\n\n[rubi.Eir] body shudders and convulses, and though you can't see or feel it, you're confident [rubi.eir] pussy is clenching down tightly on the dildo, as it suddenly becomes very hard to thrust into [rubi.em] with it.  With an orgasmic scream of \"<i>Oh yes!  Yes!</i>\"  and a spray of femjuices, Rubi collapses, exhausted.");
		rubi.orgasm();
	}
	
	output("\n\nBut you're not done yet.  You frantically pump the dildo faster and faster.  You can feel something welling up inside you, something to quench the flames burning throughout your body.  Soon the double dong between you grows too big to properly thrust, so in desperation your hands move towards ");
	//(PC has cock?)
	if (pc.hasCock()) output("[pc.eachCock], stroking it fervently, in desperate need of release.");
	//(PC doesn't have cock, but has pussy?)
	else if (pc.hasVagina()) output("your " + pc.clitDescript() + ", rubbing it frantically, in desperate need of release.");
	//(Bonus, fuckable nipples?)
	else if (pc.hasFuckableNipples()) output("  Your fingers easily slip inside each nipple, pumping in and out like little cocks.");
	//(No cock, no pussy, no breasts?)
	else if (!pc.hasGenitals() && pc.biggestTitSize() == 0) output("  Your hands roam all along your body, from your bare crotch to your [pc.nipples], even over your [pc.hair], all in search of something to give you the release you so desperately crave.");
	//(PC doesn't have either, but breasts above A-cup?)
	else output("your [pc.chest], rubbing your [pc.nipples] vigorously, in desperate need of release.");

	output("\n\nFinally, mercifully, the orgasm welling up inside you rolls over you like a tidal wave, quenching the fires of lust that burned within.  Your lips contort into an \"<i>O</i>\" and a long groan escapes your lips.");
	//(PC has cock?)
	if (pc.hasCock()) {
		output("  [pc.EachCock] twitches and shudders, loosing several jets of [pc.cum] onto your body, ");
		if (pc.cumQ() < 250) output("splattering messily");
		else if (pc.cumQ() < 500) output("coating you lightly");
		else if (pc.cumQ() < 1000) output("covering you in a copious layer of cum");
		else output("covering you in a thick layer of your potent seed");
		output(".");
	}
	//(PC has pussy?)
	if (pc.hasVagina()) output("  Your " + pc.vaginaDescript(0) + " clenches down on the enormous invader, which at this point feels like an enormous steel rod lodged firmly inside you, and a spray of fem-juices erupts from your nethers, coating the already slick dildo and Rubi.");
	//(PC lactating?)
	if (pc.lactationQ() > 0) output("  Your breasts shudder and quake as the orgasmic tsunami washes over them, spraying your [pc.milk] all over yourself, Rubi and the couch.");

	output("\n\nAbsolutely exhausted, you lay there limply, as does Rubi, as if you're both afraid to move and potentially awaken the monstrous dildo again.  With a satisfied sigh, however, you sit up and carefully pull out the shrinking dildo from the both of you.  A pink, cum-like liquid pours from both of your abused holes, pooling together into one puddle between you.");

	output("\n\nRubi rubs [rubi.eir] ");
	if (rubi.hasVagina()) output("pussy");
	else output("asshole");
	output(" with a slight smile on [rubi.eir] face, and says, \"<i>Well, that was interesting.</i>\"  You laugh at the understatement of the century, and stand, helping Rubi up off the couch as well.");

	output("\n\nThe two of you head to the bathroom, leaking pink cum as you go, and share a quick shower, before getting to the task of cleaning up the evidence of your playtime.  Once it's been satisfactorily cleaned, you give Rubi a little kiss and head off back to camp, supremely sated.");
	processTime(45);
	pc.orgasm();
	rubiAffection(1);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Tease
public function teaseRubi():void {
	//output(images.showImage("rubi-tease"), false);
	clearOutput();
	rubiSprite();
	//(Normal and Incubus Rubi.  Activates Orgasm Denial and adds 1 to Blue Balls.)
	rubi.tease();
	
	if (rubi.hasCock()) {
		output("Having something quite different in mind, you order Rubi to strip down.  With a curious look on [rubi.eir] face, [rubi.ey] does so, slowly.  Each garment [rubi.ey] peels from [rubi.eir] soft [rubi.skinFurScales] seems to take an eternity, until finally [rubi.ey]'s standing in front of you in naught but [rubi.eir] panties.");
		output("  [rubi.Eir] [rubi.cock] seems to strain at the panties, aching to be let free.  Standing, you move behind Rubi and sensually whisper into [rubi.eir] ear, nibbling and kissing [rubi.eir] neck between words.  You tell [rubi.em] that, until you specify otherwise, [rubi.ey] is not to cum under any circumstances.  If [rubi.ey] does, [rubi.ey]'ll be severely punished.  Rubi visibly gulps and nods [rubi.eir] assent.");

		//(Taller than 5')
		if (pc.tallness > 60) output("\n\nYou smile and let your hands drape over Rubi's shoulders, letting your fingers trace invisible lines all along [rubi.eir] tender chest and stomach.  One hand casually takes hold of a nipple, while the other drifts downwards, grasping the growing bulge in [rubi.eir] panties.");
		//(Under 5')
		else output("\n\nYou smile and wrap your arms around Rubi's midsection, letting your fingers trace invisible lines all along [rubi.eir] tender chest and stomach.  One hand casually reaches up and takes hold of a nipple, while the other drifts downwards, grasping at the growing bulge in [rubi.eir] panties.");

		//(Normal Rubi)
		output("\n\n\"<i>Ahh, not there,</i>\" Rubi gasps.  Your hand grips [rubi.em] tight, making [rubi.em] give a little yelp.");

		output("\n\nYou kneel down behind your little demon toy, and make [rubi.em] bend over so that [rubi.eir] hands rest on the couch.");
		//(Normal Rubi)
		output("  [rubi.Ey] blushes, looking back at you with a curious, yet lustful expression.  [rubi.Ey] gulps and lifts [rubi.eir] tail, giving you free access to [rubi.eir] pantied rump.");
		output("\n\nGrasping [rubi.eir] panties firmly you shimmy them down until they're at [rubi.eir] ankles.  [rubi.Ey] steps out of them, and, a moment after the thought crosses your mind, you immediately shove them into Rubi's mouth.  [rubi.Ey] mumbles [rubi.eir] objections, but doesn't remove them.");

		output("\n\nWith Rubi's bare ass laid out in front of you, it takes all your willpower not to just bury your face in it.  But you stand fast, and take care to remember your plans.  Instead, you wrap your fingers carefully around [rubi.eir] stiffening manhood.  You grip it tight, feeling [rubi.eir] pulse run through it.  With slow, steady movements you begin to stroke.");
		output("\n\n\"<i>Nnng,</i>\" Rubi grunts, gripping the couch cushions.  You make sure to remind [rubi.em] [rubi.ey] can't cum under any circumstances.  [rubi.Ey] nods, and says, \"<i>Y—Yes " + pc.mf("sir","miss") + ".</i>\"");

		output("\n\nSlightly quickening the pace of your strokes, you also lean in, resting your nose right against Rubi's tail, with your lips against [rubi.eir] tight butthole.  You let your tongue out, letting it run circles around [rubi.eir] ring.  You pull away, marveling at how the saliva makes [rubi.eir] puckering hole look like a jewel in the rough.");

		output("\n\nAllowing a devious smile to cross your face, you extend two fingers and place them at Rubi's now wet entrance and slide them in.  A look of surprise briefly flashes over [rubi.eir] face, but it's replaced by a satisfied smile.  You curve your fingers down, searching for [rubi.eir] prostate.  [rubi.Ey] suddenly jerks and his dick stiffens even more in your hand, and you know you've found it.  Your fingers rub little circles in it, Rubi squirming with every loop.");

		output("\n\n\"<i>Aah, " + pc.mf("sir","miss") + ", I can't take much more of this,</i>\" [rubi.ey] says, half way between a whisper and a moan.");

		output("\n\nYou give [rubi.eir] cock a squeeze and remind [rubi.em] that if [rubi.ey] cums, [rubi.ey]'s in for a punishment.  [rubi.Ey] gulps and nods, closing [rubi.eir] eyes.  [rubi.Eir] whole body seems to stiffen.  [rubi.Ey]'s right, [rubi.ey] really can't take much more of this.  You take this cue to pull your fingers out and relinquish your hold on Rubi's penis.  [rubi.Ey] sighs and almost collapses onto the couch.");
		output("\n\nYou lick your fingers clean of [rubi.eir] pre-cum and kiss [rubi.em], letting [rubi.em] taste [rubi.eir] own juices.  Then you tell [rubi.em] that [rubi.ey]'s not to masturbate in any way until you allow [rubi.em] [rubi.eir] release.");

		output("\n\nWith your devious fun accomplished, you stand, make yourself look presentable, and head out the door.  Your last sight of Rubi is that of [rubi.em] sitting on the couch with a pitiful look on [rubi.eir] face as [rubi.ey] eyes [rubi.eir] raging erection.");
	}
	//Girl Rubi!
	else {
		output("Having something quite different in mind, you order Rubi to strip down.  With a curious look on [rubi.eir] face, [rubi.ey] does so, eagerly.  Each garment [rubi.ey] peels from [rubi.eir] soft [rubi.skinFurScales] seems to take an eternity.  In fact, [rubi.ey] seems to take great delight in stripping, giving little twirls and tossing [rubi.eir] clothes towards you, until [rubi.ey]'s standing in front of you in naught but [rubi.eir] birthday suit.");
		output("\n[rubi.Eir] snatch glistens with arousal, which doesn't surprise you.  [rubi.Ey] seems to be horny 24/7 nowadays.  Standing, you move behind Rubi and sensually whisper into [rubi.eir] ear, nibbling and kissing between words.  You tell [rubi.em] that, until you specify otherwise, [rubi.ey] is not to cum under any circumstances.  And if [rubi.ey] does, there will be serious consequences.  [rubi.Ey] giggles, but nods [rubi.eir] assent.");
		//(Taller than 5')
		if (pc.tallness > 60) output("\n\nYou smile and let your hands drape over Rubi's shoulders, letting your fingers trace invisible lines all along [rubi.eir] [rubi.chest] and stomach.  One hand casually takes hold of a nipple, while the other drifts downwards, slipping into her soft, delicate folds.");
		//(Under 5')
		else output("\n\nYou smile and wrap your arms around Rubi's midsection, letting your fingers trace invisible lines all along [rubi.eir] [rubi.chest] and stomach.  One hand casually reaches up and takes hold of a nipple, while the other drifts downwards, slipping into her soft, delicate folds.");
		output("  \"<i>Ooh, YES, right there,</i>\" Rubi gasps.  Your hand pinches [rubi.eir] clit tight, eliciting a yelp and a coo of pleasure at the same time.");

		output("\n\nYou kneel down behind your little " + rubi.mf("demon","demoness") + " and make [rubi.em] bend over so that [rubi.eir] hands rest on the couch.  [rubi.Ey] looks back at you, hair wild like [rubi.ey]'s already been fucked several times, giving you such a look of lust that you find yourself getting turned on almost as much as [rubi.ey] is.  [rubi.Ey] lifts [rubi.eir] tail, giving you free access to [rubi.eir] rump and cunt, and then waggles it in your face, like someone taunting a pet dog.  You raise a hand and bring it down onto [rubi.eir] pale ass with a SMACK, letting [rubi.em] know just who the pet is in this situation, and smirk at [rubi.em].");

		output("\n\nWith Rubi's bare ass laid out in front of you, it takes all your willpower not to just bury your face in that delicious wet pussy.  But you stand fast, and take care to remember your plans.  Instead, you insert your thumb up into [rubi.eir] hungry cunt, with your index and middle fingers on either side of [rubi.eir] clit, rubbing it with slow, steady movements.");

		output("\n\n\"<i>Nnng,</i>\" Rubi moans, gripping the couch cushions.  You make sure to remind [rubi.em] that [rubi.ey] can't cum under any circumstances, but before you get through the sentence, [rubi.eir] pussy grips your thumb tightly and a spray of fem-juices erupts, coating your hand and face.  Well, so much for that plan.  You guess trying to control the orgasms of a girl this sensitive is pretty much impossible.  But you can still tease [rubi.em].");

		output("\n\nSlightly quickening the pace of your fingers, you also lean in, resting your nose right against Rubi's tail hole, with your lips against [rubi.eir] muff.  You let your tongue out, letting it run rampant across [rubi.eir] netherlips, around your finger.  You pull away and lick your lips, marveling at the taste.");

		output("\n\nAllowing a devious smile to cross your face, you pull your free hand into a conical shape and press it into Rubi's drenched cunt.  A look of bliss crosses [rubi.eir] face, and you're quite certain [rubi.eir] eyes rolled back into [rubi.eir] head.  You curl your fingers together, forming a fist, and pulse it back and forth inside [rubi.em].  Meanwhile, you pull out the thumb of your other hand and put it to work on Rubi's love button, tweaking, rubbing and tormenting it mercilessly.");

		output("\n\n\"<i>Ohh gods,</i>\" Rubi says, half way between a whisper and a moan, \"<i>I'm gonna... I'm gonna ");
		if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output("like, ");
		output("cum!</i>\"");

		output("\n\nYou push your fist in as far as it will go as Rubi's legs tremble and almost give out on [rubi.em].  An earth-shattering scream erupts from [rubi.eir] lips as another jet of femjuices spray out, dousing you again.  Rubi slumps forwards onto the couch, [rubi.eir] vaginal muscles nearly taking you with [rubi.em].  But you manage to pull your fist out before falling over with [rubi.em].");
		output("\n\nYou slowly lick your fingers clean and kiss [rubi.em], letting [rubi.em] taste her own juices.  [rubi.Ey] giggles and licks your face clean as well, until not a drop remains.");
		output("\n\nWith your devious fun accomplished, you stand, make yourself look presentable, and head out the door.  Your last sight of Rubi is that of [rubi.em] sitting spread eagle on the couch with a supremely satisfied look on [rubi.eir] face.");
		rubi.orgasm();
	}
	processTime(25);
	pc.lust(5 + pc.libido() / 10);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Release
public function releaseRubi():void {
	//output(images.showImage("rubi-orgasm-denial-release"), false);
	clearOutput();
	rubiSprite();
	output("You order Rubi to strip down.  Knowing the drill, [rubi.ey] does so slowly.  There's no striptease, no show, [rubi.ey] just disrobes as quickly as possible until [rubi.ey]'s standing in naught but [rubi.eir] panties, ");
	if (rubi.hasCock()) output("[rubi.eir] [rubi.cock] straining at the seams, trying to break free.");
	else output("clinging tight to [rubi.eir] flat little mound.");

	output("\n\nKneeling in front of [rubi.em], you grip both sides of [rubi.eir] undies and strip them off yourself, revealing his rock-hard cock.");
	//(If Blueballs 1-3)
	if (flags["COC.RUBI_BLU_BALLS"] <= 3) {
		output("  Not to mention [rubi.eir] tiny balls");
		if (flags["COC.RUBI_BLU_BALLS"] == 1) output(", trapped in their little sissy sack");
		output(", which you think have swelled somewhat, although you haven't been teasing [rubi.em] long.");
	}
	//(if Blueballs 4-9)
	else if (flags["COC.RUBI_BLU_BALLS"] <= 9) output("  Not to mention [rubi.eir] sizeable balls, which seem to have swelled up to twice their normal size, thanks to your relentless teasing.  They even have a slight bluish tinge to them, although it's not immediately visible.");
	else output("  Not to mention [rubi.eir] enormous balls, which, thanks to your endless teasing, are seemingly the size of baseballs.  They even have a noticeable blue tinge to them, obviously aching for relief.");

	output("\n\nYou direct [rubi.em] to sit on the nearby coffee table, and [rubi.ey] does so.  Wrapping your fingers around [rubi.eir] member, you begin to stroke it slowly, reminding [rubi.em] that [rubi.ey] can't cum.  [rubi.Ey] whimpers but nods.  You can tell [rubi.ey]'s fighting [rubi.eir] body every step of the way, eager for the release that only your command can bring.");

	output("\n\nBut that's not going to happen yet.  You've still got a lot of work to do.  Without removing your grip on [rubi.em], you push [rubi.em] back so that [rubi.ey]'s lying on the table, [rubi.eir] legs dangling off the end.  You take two fingers, collect some pre-cum that's dribbling down [rubi.eir] cock and your hand, and massage it into the tight little tailhole behind [rubi.eir] ");
	if (flags["COC.RUBI_BLU_BALLS"] <= 3) output("swollen");
	else if (flags["COC.RUBI_BLU_BALLS"] <= 9) output("slightly blue");
	else output("incredibly swollen blue");
	output(" balls.  Once it's properly lubed up, you press two fingers inside.");

	output("\n\nRubi's face contorts briefly into an expression of surprise, which quickly morphs into lust.  [rubi.Ey] pants loudly, tongue out.  Behind the ever growing lust present in [rubi.eir] face, however, you see supreme concentration.  No matter what, [rubi.ey]'s determined not to let you down.  If you told [rubi.em] [rubi.em] couldn't cum ever again, you're certain [rubi.ey]'d take it to heart and [rubi.ey]'d never let it happen.  Good thing for [rubi.em] you're not THAT cruel.");

	output("\n\nYour fingers worm around inside [rubi.em], searching for the ");
	if (rubi.hasCock()) output("P-spot");
	else output("G-spot");
	//else output("most sensitive spot");
	output(".  When Rubi jerks and wiggles involuntarily, you know you've found it.  Pre-cum begins leaking from Rubi's [rubi.cock] in copious amounts, running down your hand and arms, and forming a puddle on the coffee table.  Rubi's body trembles and shakes, wriggling on the table like a fish out of water.");

 	output("\n\nFeeling a little more adventurous, you slip a third finger into the little demon " + rubi.mf("boy","girl") + "'s ");
	if (rubi.hasCock()) output("rectum");
	else output("folds");
	output(".  With all three fingers you press and massage [rubi.eir] prostate, increasing the amount of pre-cum flowing from [rubi.eir] tip.");
 	output("\n\nFinally, you think you've had enough.  You retrieve your fingers from [rubi.eir] ass and cup [rubi.eir] balls instead, squeezing them until Rubi squeaks in discomfort.  You pump [rubi.eir] cock faster, and order [rubi.em] to cum, squeezing [rubi.eir] balls with every word.");
	output("\n\nRelief crosses Rubi's face, followed by arousal.  [rubi.Ey]'s been waiting for this moment for a long time.  You give [rubi.eir] balls another squeeze and [rubi.eir] lips form a tight O as a rope of cum lances outwards, flying up before splattering onto [rubi.eir] chest.");
	//(Blueballs 1-3)
	if (flags["COC.RUBI_BLU_BALLS"] <= 3) output("  It's quickly followed by another, less forceful jet of pearly white cum, which lands on [rubi.eir] face, and several even smaller jets which splatter the area around [rubi.em].  [rubi.Eir] cock twitches and spasms, then slowly softens.");
	//(Blueballs 4-5)
	else if (flags["COC.RUBI_BLU_BALLS"] <= 5) output("  It's quickly followed by another, less forceful jet of pearly white cum, then another, and another, each landing closer to [rubi.eir] face.  Finally, it gives a few more token jerks, spurting out tiny globules of cum onto the surrounding area.  [rubi.Eir] cock twitches and spasms, squirting nothing but air, as if [rubi.eir] body is still craving release.");
	//(Blueballs 6-7)
	else if (flags["COC.RUBI_BLU_BALLS"] <= 7) output("  It's quickly followed by another, more forceful jet of pearly white cum which splatters against the ceiling, dripping down onto the both of you.  Another spurt of cum bursts forth, then another, and another, each one liberally covering Rubi's stomach, chest and face.  [rubi.Eir] cock finally gives a few last twitches and spasms, squirting nothing but air, as if [rubi.eir] body is still craving release.");
	//(Blueballs 8-9)
	else if (flags["COC.RUBI_BLU_BALLS"] <= 9) output("  It's quickly followed by another, more forceful jet of pearly white cum, which splatters against the ceiling, dripping down onto the both of you, and then another, and another.  It isn't long before the ceiling has a huge white cum-covered blotch right above you, drizzling down on you like dew dripping from trees.  Rubi's cock doesn't stop there, however, it continues twitching and spurting [rubi.eir] seed until [rubi.ey] is completely covered in the stuff.  Finally, mercifully, it ends, though [rubi.eir] [rubi.cock] continues to spasm, squirting nothing but air, as if [rubi.eir] body is still craving release.");
	//(Blueballs 10+)
	else output("  It's quickly followed by another, more powerful jet of pearly white cum, which splatters against the ceiling, dripping down onto the both of you, and then another, and another.  It isn't long before the ceiling has a huge white cum-covered blotch right above you, drizzling down on you like dew dripping from the trees.  Rubi's cock doesn't stop there, however, it continues twitching and spurting [rubi.eir] seed, liberally covering [rubi.em]self, you and the surrounding area until everything appears to be in a white haze.");

	output("\n\nRubi's body visibly relaxes and [rubi.eir] limbs go limp, along with [rubi.eir] cock, albeit more slowly.  You lick your hands clean and give Rubi a sloppy smooch, to which [rubi.ey] coos thankfully.  The release [rubi.ey] so desired achieved, [rubi.ey] drifts off into an orgasm-induced dream.");

	output("\n\nYou stand and decide to let [rubi.em] sleep.  ");
	//(Blueballs 1-5)
	if (flags["COC.RUBI_BLU_BALLS"] <= 5) output("You clean yourself up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.");
	//(Blueballs 6-9)
	else if (flags["COC.RUBI_BLU_BALLS"] <= 9) output("You head into the bathroom and wash the cum off you, taking a short shower.  Afterwards, you dry up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.");
	//(Blueballs 10+)
	else output("You head into the bathroom and wash the cum off you, no easy feat to be sure.  Afterwards, you dry up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.  You certainly don't want to be there when [rubi.ey] wakes up, lest you have to clean the entire house with [rubi.em].");
	rubiAffection(flags["COC.RUBI_BLU_BALLS"]);
	flags["COC.RUBI_BLU_BALLS"] = 0;
	//Will deactivate Orgasm Denial.  To start Denying again, the PC will have to Tease.
	flags["COC.RUBI_ORGASM_DENIAL"] = 0;
	processTime(25);
	pc.lust(5 + pc.libido() / 10);
	pc.shower();
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Cheating Rubi
public function cheatingRubi():void {
	clearOutput();
	rubiSprite();
	//(Selecting the Rubi button at the Bakery while she's not there)
	output("You take a seat at a table, expectantly waiting for Rubi to slide into your lap...  but she never does.  You look around the place for her, but again, there's no sight of her.  You flag down Dia, the caninemorph waitress, who looks haggard, and inquire as to the location of her co-worker.");
	output("\n\nShe gives you an exasperated sigh and says, \"<i>I dunno, she took off again, like she does with you.  Some guy came in, she got all giggly, and they got out of here.  If you see her, let her know I'm taking all of today's tips again.</i>\"  With that she turns to service another table.");
	output("\n\nSo your bimboified slut is seeing someone else?  What will you do about this?");
	processTime(2);
	//[Find Her] [Don't Care]
	clearMenu();
	addButton(0, "Find Her", findBimboCheatster);
	addButton(1, "Don't Care", dontCareAboutNoCheatingRubis);
}

//(Don't Care)
private function dontCareAboutNoCheatingRubis():void {
	clearOutput();
	rubiSprite();
	output("You shrug your shoulders.  It's not really your problem, is it?  You're free to fuck who you choose, and so is she.");
	output("\n\nYou stand up and leave the bakery, deciding to wander around Tel'Adre a bit more.");
	//(Kicks PC back out to Tel'Adre; PC can still get the Cheating Rubi event)
	processTime(1);
	addNextButton(bakeryuuuuuu);
}

//(Find Her)
private function findBimboCheatster():void {
	clearOutput();
	rubiSprite();
	output("You let out a disgruntled sigh.  Rubi's seeing someone else?!  Not on your watch!  You leave the bakery and make your way towards her neighborhood.  It doesn't take long, you've gone with her there enough times to memorize the path, even without her leading.");
	output("\n\nCreeping into her front yard, you make your way through the garden.  Where once fruits, vegetables and herbs grew are now flowers reflecting every color of the rainbow.  An odd sound makes you stop for a moment just to make sure you weren't caught.  You hear the sound again, and realize it's coming from an open window.  Sneaking forward, you peer inside for the source.");
	output("\n\nThere she is, Rubi, splayed out on the couch, naked with two fingers buried deep inside her pussy.  You shift around a bit, and see nearby her a tanned man in the process of taking off his shirt.  So, you got to them before they did anything.  Rubi moans, running a hand through her platinum blonde hair and staring at the tanned man.");
	output("\n\nYou could interrupt them before they go any further, or wait until it's over.");
	processTime(10);
	//[Interrupt] [Wait]
	addButton(0, "Interrupt", interruptTheNTRsYouCrazyFool);
	addButton(1, "Watch n Wait", waitAndGetNTRedLikeTheBoyBitchYouAre);
}

//(Interrupt)
private function interruptTheNTRsYouCrazyFool():void {
	clearOutput();
	rubiSprite();
	output("No one's sticking their dick in your ");
	if (silly) output("waifu");
	else output("slut");
	output(" if you've got a say in it!  You get out of your hiding place, shout a word of warning and burst inside the vibrant pink house.");
	output("\n\nRubi jumps a little, and sits up, but her fingers remain buried deep in her snatch.  The man, on the other hand, turns around and looks you over appraisingly.  Not surprisingly, he's not human.  Though he has a human face, you see wolf-like ears perched on his head, and a fluffy white and grey tail extends from a hole in his trousers.  The wolfman scoffs dismissively, \"<i>Go on, get out of here.  I got things to see and people to do.</i>\"");

	//Strength 61+)
	if (pc.physique() >= 61) output("\n\nAngered by this blow off, you take a swing at the man.  Catching him off guard, you send him to the ground with a loud THUMP.  He holds his head in his hands for a moment.  You nudge him in the stomach with a [pc.foot] and tell him to get lost.  He grumbles, grabs his shirt and scampers away without looking back.");
	else {
		output("\n\nAngered by this blow off, you take a swing at the man.  Your punch lands square in the jaw and he stumbles back a step.  He looks at you in surprise for a second, and then laughs, \"<i>You got spunk, kid, but let me show you how a real man does it.</i>\"");
		//(Strength <61 and Speed <61)
		if (pc.reflexes() < 61) {
			output("\n\nThe wolfman brings a right hook in your direction, which you try to duck, but it ends up clipping you right in the jaw.  You go down like a sack of potatoes, your vision swimming.  As you struggle to get upright, you see Rubi get off the couch in a furious rage, throwing item after item at your assailant.  You can barely make out what they are, until a black equine-style dildo rolls past you.");
			output("\n\nThe wolfman shields himself and you hear, \"<i>All right, all right, I'm going!  Crazy bitch!</i>\"  as he runs out the door.  After you hear the door shut, you feel hands on your arm as Rubi helps you up onto the couch.  After a moment to collect yourself, your vision is back and you feel none the worse for wear.");
			//[Leads to Resolution]
		}
		//(Strength <61 and  Speed 60+)
		else {
			output("\n\nThe wolfman brings a right hook in your direction, but you easily dodge under it and sweep his legs while he's off balance.  He goes tumbling down like a sack of potatoes.  You grin and nudge him in the stomach, telling him to get lost.  He grumbles, grabs his shirt and scampers away without looking back.");
		}
	}
	processTime(5);
	//[Leads to Resolution]
	addNextButton(NTRbimboBitchResolution);
}

//(Wait)
private function waitAndGetNTRedLikeTheBoyBitchYouAre():void {
	//output(images.showImage("rubi-get-ntr-ed"), false);
	clearOutput();
	rubiSprite();
	output("You decide to wait and see how this plays out.  The man fully disrobes and it's not at all surprising to you that he's not fully human.  A pair of wolf-like ears are perched upon his head, while a fluffy white and grey tail extends from his waist.  The wolfman opens his mouth to speak, but you can't hear what he says from out here.  Whatever it was, it certainly got Rubi's attention.");
	output("\n\nThe blonde airhead moves from her position on the couch and kneels in front of the wolfman, whose back is to you.  From what you can see, you're certain she's sucking his cock.  Arousal and a twinge of jealousy well up inside you, and you find yourself moving around the side of the house to find a better vantage point.");
	output("\n\nPeering in a new window, you see Rubi's glittering red lips wrapped around the wolfman's canine cock.  She slips up and down at a sensuously slow speed, her tongue darts out every few seconds almost as if it's taunting you.  Her head bobs with increasing speed, and you note that her fingers have descended to her nethers, which are unfortunately obscured by her legs from this angle.");
	output("\n\nAs you contemplate moving to another window, you see the wolfman speak.  Rubi relinquishes her lip locked grip on his cock and smiles.  You see she's giggling and laughing, and she crawls onto the couch on all fours, presenting herself to her canine compatriot, and inadvertently to you as well.  You can see her cunt is slick with juices, and her tail swishes from side to side in a hypnotizing, catlike fashion.  Saying the man has a wolfish grin would be a disservice as his grin stretches from ear to ear.  He climbs onto the couch on his knees behind your bimbo lover.  Curses, your view is ruined again!");
	output("\n\nMaking your way back to the front window with shaking knees, you see the wolfman's glistening red canine cock just slide right inside Rubi's eager hole.  Her mouth opens, and you can just imagine the low moan that rumbles out, since you've heard her make that noise on several occasions.  A small pang of jealousy arises within you that this man gives her the same reaction.  As Rubi's wolfish lover begins to assail this new territory, more \"<i>oohs</i>\" and \"<i>aahs</i>\" roll out of her mouth and into your imagination.  You're a little ashamed of yourself, but you have to admit this is turning you on.");
	if (!pc.isTaur()) {
		output("\n\nAs the lovemaking continues, you find your hand descending into your [pc.gear] to fondle ");
		if (pc.hasVagina()) output("your " + pc.vaginaDescript());
		else if (pc.hasCock()) output("[pc.eachCock]");
		output(".  ");
	}
	else output("\n\n");
	output("The two go on like this for five minutes, then ten, then fifteen.  Each position, you find, is more intriguing than the last.  ");
	if (silly) output("They're even doing positions that aren't available in the game!  ");
	output("Half an hour later, Rubi and the wolfman sit exhausted on the couch, his seed pouring from each of her holes.");

	output("\n\nThe male grins at her, but to your surprise she only gives a polite little smile and says a few words.  The man looks a little taken aback, but begins re-dressing almost immediately.  As he's doing that, you move to a window around the side of the house, so as not to get caught by this fleeing stud.  A minute later, you see the wolfman exit the house and take off walking down the street, mumbling something like \"<i>insatiable bitch.</i>\"");
	output("\n\nWell, this is as good of a time as any to confront her...  You stand up, adjust your clothing, and walk inside as a naked Rubi cleans herself off with a moist towel.");
	output("\n\nShe spots you and lights up, \"<i>Oh baby!  Like, I didn't know you'd be coming by!</i>\"  She then seems to realize that she's stark naked, mostly covered in cum, and that you came in just seconds after her previous lover left.  \"<i>Oh.  Yeah.</i>\"");
	//[leads to Resolution]
	processTime(25);
	addNextButton(NTRbimboBitchResolution);
}

//(Resolution)
private function NTRbimboBitchResolution():void {
	clearOutput();
	rubiSprite();
	output("You look at Rubi and say that you're definitely going to have to talk about what just happened.");
	output("\n\nShe nods and sits, covering her naked body with one of the pastel pink cushions that lie around the place.  \"<i>Like, I know...  I really shouldn't have.  I love you baby, I really do.  But ever since...  this,</i>\" she removes the cushion for a second, motioning down at her bombshell of a body, \"<i>It's just...</i>\"  She bites her lip, deep in thought as she wracks her brain for the right words to say.");
	output("\n\n\"<i>I love this body, I love you for giving it to me... but it has needs, you know?  I get so hot thinking about you, thinking about others, I just can't con-, can't cont-, I can't stop myself.  That guy means nothing to me, I'd only just met him.  Like, I totally wish you were here for me all the time, you know?  We could take care of these...  urges,</i>\" she languishes over the word, \"<i>daily.  Or several times a day... but we can't.  You're the cha-, the cham-, the hero guy, and I'm just a waitress in this city.  Like, I totes can't keep you from your mission.</i>\"");
	output("\n\nShe watches your face for a moment, biting her ruby red lip again, then says, \"<i>Like, I'll totally try to con-, to stop myself if you want.  I've got more sexy fun time toys in here than a goblin's treasure room.  If you want me just to yourself, I'll for sure stick to it.  But if you felt otherwise...  I think it'd totally be easier to keep these urges under control with a real cock to suck or a pussy to lick.</i>\"");
	output("\n\nRubi hugs the cushion close, apparently done with her speech.  So how do you react?");
	output("\n\nYou could tell her no, forbidding her to see anyone else.  Or you could say yes, letting her sleep with anyone.  You could always break up with her.  Or there might be a fourth option...");
	//[No] [Yes] [Break Up] [Pimp]
	processTime(5);
	clearMenu();
	addButton(0, "No", noBimboNTR);
	addButton(1, "Yes", yesBimboNTR);
	addButton(2, "Break Up", breakUpWithRubi);
	addButton(3, "Pimp", pimpOutRubi);
}

//(No)
private function noBimboNTR():void {
	clearOutput();
	rubiSprite();
	output("Folding your arms, you shake your head.  You tell her that if this is going to work out, she has to remain faithful to you.  Sex toys and masturbation will have to do to keep her \"<i>urges</i>\" under control.  She looks a little sad, but nods as you speak.");
	output("\n\n\"<i>Of course, baby.  Whatever you say,</i>\" then she giggles, \"<i>At least I'll have you to look forward to, whenever you roll into town.</i>\"");
	output("\n\nThat's that then, Rubi will refrain from sleeping around.  With that settled, you decide to let her get dressed and mull it over.  You head out of the house, and make your way back to camp.");
	flags["COC.RUBI_PROSTITUTION"] = -1;
	processTime(5);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}
//(Yes)
private function yesBimboNTR():void {
	clearOutput();
	rubiSprite();
	output("You contemplate it for a moment, and then slowly nod your head.  What's the harm in letting her blow off steam?  You know she'll always come back to you.  You assent to her wishes, to which she squeals and hugs you tightly, tossing the pink cushion aside.");
	output("\n\n\"<i>Ohh baby I love you so much!</i>\"  She plants a fury of kisses all over your face, giggling constantly.  \"<i>None of them could ever compare to you, but they will help.</i>\"");
	output("\n\nThat's that then, Rubi will be free to sleep with anyone, just as you are.  With that settled, you decide to let her get dressed.  You head out of the house, and make your way back to camp.");
	flags["COC.RUBI_PROSTITUTION"] = 1;
	processTime(5);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//(Break Up)
private function breakUpWithRubi():void {
	clearOutput();
	rubiSprite();
	output("You think about it for a long moment and then sigh sadly.  You look Rubi dead in the eyes and explain you can't be with a woman who wants to cheat on her partner.  Tears form in her eyes as she sniffles, but she nods with you.");
	output("\n\nAfter a moment of silence a faint whisper escapes her ruby red lips, \"<i>Get.  Out.</i>\"  You shrug, getting up, but as you start to leave the house, Rubi's voice screeches after you.  \"<i>You MONSTER!  I let you turn me into this because I loved you!  I could like, live with the con- the results, but I guess the hero couldn't!  You're desp-</i>\" she struggles with her bimbo-addled brain.  \"<i>You're totally DESPICABLE,</i>\" she finally says with a smirk.");
	output("\n\nAnd with that, she slams the door behind you.  Well, that could have gone better.  With an exasperated sigh you head back to your camp.");
	flags["COC.RUBI_PROSTITUTION"] = -2;
	flags["COC.RUBI_DISABLED"] = 1;
	processTime(5);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}
//(Pimp)
private function pimpOutRubi():void {
	clearOutput();
	rubiSprite();
	output("You think about it for a long while, mulling over all the possibilities.  Then something else occurs to you. She wants help controlling her urges, why not make a little money in the meantime?  You explain that she's free to sleep with whoever she wants, but that she could charge them for her time.  After all, if you're going to do what you love, you may as well get paid for it.");
	output("\n\nRubi thinks it over and finally nods happily, \"<i>Oh, it's such a great idea, baby!  I'll be like Edryn then!  And I'll give you your 'cut' whenever you come by as well.</i>\"  She giggles and plants a kiss right on your lips.  \"<i>Oooh, I'll need more outfits, and make up, and...</i>\" her voice trails off as she excitedly hurries off to her bedroom.");
	output("\n\nThat's that then, Rubi will officially prostitute herself and share the profits with you.  With that settled, you decide to let her go through her wardrobe in peace.  You head out of the house, and make your way back to camp.");
	flags["COC.RUBI_PROSTITUTION"] = 2;
	processTime(5);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Chocolate Covered Strawberries, Oil, Massage?
//Rubi
//Kinda shy but eager to do it.
//Wants to please the PC.
//Calls PC Babe.
//Has red demon tail
//Offer
//First Time:
//	Rubi gestures to some bottles and a box from the bakery before mentioning, \"<i>You look awful tense, babe.  I know you've got it hard out there, and well, I-I thought maybe I could really pamper you today, if you'd like.</i>\"
//Repeat:
//	Rubi nods towards the bottles and box in the corner and gives you a sly wink.  \"<i>Want another massage?</i>\"

//Actual Scene:
private function chocoRubiMassage():void {
	//output(images.showImage("rubi-get-massage"), false);
	clearOutput();
	rubiSprite();
	output("You look over [rubi.eir] supplies and decide that a pampered day at Rubi's \"spa\" is just what you need.  Allowing [rubi.em] to escort you to [rubi.eir] bed, you catch a few peeps of a pint-sized pup-tent in Rubi's bottoms.  [rubi.Ey] doesn't seem aware of your prying gaze, but [rubi.ey]'s blushing nonetheless, perhaps lost in [rubi.eir] own less-than-pure thoughts as [rubi.ey] guides you to the corner of [rubi.eir] room.");

	output("\n\n\"<i>Babe, you'll need to... ah, take off your equipment for this,</i>\" Rubi instructs, holding a bottle full of shimmering fluid as [rubi.ey] prances around the room.  You arch an eyebrow at [rubi.em] questioningly as you take in [rubi.eir] eager expression, waiting until [rubi.ey] starts to gnaw at [rubi.eir] bottom lip before you ");
	if (pc.cor() >= 66 || pc.exhibitionism() >= 66) output("start sensually undressing, turning the simple act into a seductive show that causes Rubi's petite boner to jerk unpredictably beneath [rubi.eir] clothes.  A small, damp stain appears at the tip by the time you finish your salacious tease.");
	else if (pc.cor() >= 33 || pc.exhibitionism() >= 33) output("get undressed without much pause or fanfare.  Rubi makes a show of turning [rubi.eir] head, but you can see [rubi.em] peeping glimpses out of the corners of [rubi.eir] eyes, and [rubi.eir] boner seems to be bigger and harder than it was moments before.");
	else {
		output("make [rubi.em] turn around while you undress.  You quickly shuck your clothes and ask [rubi.em] what to do next, holding a hand across your [pc.chest] and groin");
		if (pc.biggestCockVolume() >= cockVolume(40) || pc.biggestTitSize() >= 8) output(", not that it does much good");
		output(".");
	}

	output("\n\nRubi politely holds a towel between you as you climb into the bed face down, your head coming to rest on a down-filled pillow.  The fluffy fabric barrier is draped across your [pc.butt], though your feminine boyfriend is sure to fold it so that your [pc.legs] are fully exposed.  The box is placed in front of your " + pc.face() + " and opened.  Inside is a candied, fruity treasure - chocolate covered strawberries.  Rubi's slender fingers pluck up one of the delectable treats and press it into your yielding lips, the sweet treat gliding onto your tongue whereupon it goes to work releasing starbursts of flavor.  You hum contently as you devour the confectionary gift, already feeling much more relaxed than you had been.  The rest are within easy reach, and you languidly set to snacking on them.");

	output("\n\nMeanwhile, you hear Rubi's clothing falling by the wayside.  You aren't sure what else you expected from the sexy little trap.  When you turn to look at [rubi.em], you're treated to the sight of [rubi.em] all dolled up for you.  [rubi.Ey] has a crotchless set of panties clinging to [rubi.eir] ");
	if (flags["COC.RUBI_BLU_BALLS"] < 3) output("small");
	else if (flags["COC.RUBI_BLU_BALLS"] < 8) output("big");
	else output("huge, stretched");
	output(" scrotum while allowing [rubi.eir] delicate, aroused maleness to hang out freely, bouncing up in excitement as soon as you lay eyes on it.  Clinging to [rubi.eir] svelte torso, a lacy corset compresses [rubi.eir] middle slightly and amplifies [rubi.eir] next-to-nonexistent chest, giving [rubi.em] an even greater appearance of femininity than before.");

	output("\n\n" + pc.mf("Giggling","Smiling") + " appreciatively, you lick some half-melted chocolate from your upper lip.  You flick your gaze back to [rubi.eir] dong in time to see a pearl of clear pre-cum bead on [rubi.eir] cute cock's crown.  Rubi clenches [rubi.eir] knees together, a little embarrassed, but [rubi.ey] musters [rubi.eir] courage and climbs into bed with you, [rubi.eir] pert bottom coming to rest on your own.  Chastity is maintained, of course, by the fluffy, white towel between your (mostly) nude bodies.  [rubi.Eir] weight is noticeable but not uncomfortable, and [rubi.ey] begins to work on your shoulders almost immediately, squeezing the right one while [rubi.eir] left pops the cap on a bottle of oil.");

	output("\n\nOhhhh, that's cold!  The slippery glaze rubs down your spine as [rubi.ey] pours it out all over your back, and you shiver from the difference between [rubi.eir] hands and the slick fluid.  [rubi.Ey] sets the bottle aside after your top half has a generous coating and apologizes, \"<i>Sorry, I'll get you warmed up in a second, babe.</i>\"  It's clear from [rubi.eir] tone that [rubi.ey] seems genuinely penitent for the slip-up, but when [rubi.eir] fingers begin to knead your " + pc.skinFurScales() +", all is immediately forgiven.  You moan while Rubi puts [rubi.eir] girlish palms to work on your muscles.  [rubi.Eir] touches are electric, and each contact releases tension that you didn't even know you had.  Lubricating the whole process, the oil is enhancing the touches, warming nicely from the heat of two bodies so close together.");

	output("\n\nGrunting as [rubi.ey] exerts [rubi.em]self for your pleasure, the girlish brunette leans down to tend to a particularly stubborn knot, inadvertently pressing [rubi.eir] tumescent organ into your crack along with the intervening fabric.  You both groan out loud at the same time - [rubi.em] from the pressure on [rubi.eir] most sensitive, erotic spot, and you from the relief [rubi.eir] hands are doling out.  You slowly drag another strawberry to your lips and begin to lick and suck on the tip, slowly melting the layers of chocolate until the red tip is revealed, pushing in and out of your lips teasingly.  Rubi is barely able to handle the display.  [rubi.Ey]'s breathing heavily and barely stopping [rubi.em]self from humping you through the towel.");
	output("\n\nRubi whimpers, \"<i>I-uh... ummm, [pc.name], I'm getting c-c-close,</i>\" without stopping.  [rubi.Eir] tail is slowly rubbing on your [leg] as [rubi.ey] tries to keep [rubi.eir] rebellious hips in place, but they jerk and stutter again and again, pressing [rubi.eir] hot little tool into the towel.  You're totally and completely relaxed, and [rubi.ey]'s wound tighter than a spring.");

	output("\n\nDo you let [rubi.em] release or force [rubi.em] to stay all bottled up?  [rubi.Ey] has been awful nice...");
	processTime(40 + rand(20));
	pc.energy(40);
	pc.libido( -1);
	pc.lust(5);
	IncrementFlag("COC.TIMES_RUBI_MASSAGED");
	//[Release] [Nope]
	//{Not Pent Up: Go to release}
	clearMenu();
	addButton(0, "Release", releaseRubiMassage);
	addButton(1, "Bottle Up", bottleUpRubiMassage);
}

//Bottle Up:
private function bottleUpRubiMassage():void {
	clearOutput();
	rubiSprite();
	output("You bite the strawberry in half and mouth, \"<i>No, not yet.  Just let it build up.</i>\"  [rubi.Ey] whines plaintively, but you cock your head to the side and say, \"<i>Come on, do it for me.  Just, don't let any out....  Here, come off of there and come into bed with me.  We can snuggle and let you relax a bit.</i>\"");
	output("\n\nYou pat the bed next to your hip and assist Rubi in snuggling against you, making sure you don't accidentally brush [rubi.eir] boner - no point in letting [rubi.em] spill it all out after you've kept [rubi.em] on edge so long.  [rubi.Ey] slowly relaxes into your shoulder, and you share a kiss with [rubi.em] before feeding [rubi.em] the rest of the strawberries.");
	output("\n\n[rubi.Ey] gratefully says, \"<i>Thanks, babe,</i>\" and though [rubi.eir] body is still warm with almost feverish desire, [rubi.ey] won't be cumming any time soon.");
	rubi.tease();
	processTime(40 + rand(20));
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Release/Not Pent Up
private function releaseRubiMassage():void {
	clearOutput();
	rubiSprite();
	output("You figure after all the pampering [rubi.ey] did, [rubi.ey] deserves a treat.");
	output("\n\nPushing the strawberry deeper, you bring its widest point to your oral entrance and let your tongue play across the chocolaty surface, melting the mocha-hued shell as your eyes lock with Rubi's.  [rubi.Ey] groans as [rubi.ey] drinks in the oral feast.  Bubbling pre-cum freely, [rubi.eir] short, girly cock looks like it's about ready to explode.  It almost looks like an overinflated sausage except this one is dangerously close to letting loose.  [rubi.Ey] manages to hold it back though, waiting for your permission to cum since [rubi.ey] is on your backside after all.");
	output("\n\nYou push the strawberry into your mouth and swallow it, noisily smacking your lips before saying, \"<i>Come on Rubi, don't keep me waiting.  You deserve to release some tension too.</i>\"");

	output("\n\nAt your proclamation, Rubi bites down on [rubi.eir] lower lip and [rubi.eir] eyelids flutter down low, uncontrolled.  [rubi.Ey] moans, \"<i>Ohhh-okay!</i>\" and grabs hold of your towel-wrapped buns, pushing them together around [rubi.eir] length.  You feel [rubi.eir] turgid phallus bounce against your bottom once, twice, thrice, and then your lover's high-pitched voice is luridly moaning, accompanied by a sensation of dampness on your bottom.");
	//Not pent up or <= 3
	if (flags["COC.RUBI_BLU_BALLS"] <= 3) output("\n\nBubbling spurts of semen boil out of [rubi.eir] petite sack, quickly soaking into the fluffy fabric as Rubi exhausts [rubi.em]self.  Soon, [rubi.ey]'s barely letting out a single drop of cum, but [rubi.eir] boner is dutifully convulsing as if it could keep cumming forever.  The look of relief on [rubi.eir] face is adorable, and you pull Rubi down into a snuggle while the cum-rag handles [rubi.eir] lurid ejaculation.");
	//<= 5
	else if (flags["COC.RUBI_BLU_BALLS"] <= 5) output("\n\nThick lances of hot cum splatter wetly into the fluffy fabric as Rubi's backed-up balls do their best to empty the hot load you forced them to hold in.  [rubi.Eir] warm jism quickly soaks into the towel and puddles in the dick-shaped depression [rubi.ey]'s molded into your ass-cleavage, slowly dripping through the barrier onto your bottom.  [rubi.Eir] tongue drools out of [rubi.eir] mouth in a display of palpable relief as [rubi.ey] empties, eventually collapsing onto your back as the last of [rubi.eir] load drools out of [rubi.em].\n\nYou pull [rubi.em] off of you and into a snuggle as [rubi.ey] slowly calms, kissing [rubi.em] and thanking [rubi.em] for the wonderful evening.");
	//<= 7
	else if (flags["COC.RUBI_BLU_BALLS"] <= 7) {
		output("\n\nHis cum shoots out hard enough to go right through the towel and into your crack.  Numerous spurts erupt out of [rubi.eir] tiny cock, firing so fast and hard that the fabric turns into a sloppy mess, and your [pc.butt] becomes moist with [rubi.eir] sticky boy-goo.  Rubi's voluminous ejaculations abruptly lance up onto your back as [rubi.ey] changes position, tongue hanging out in a display of complete relief and rapture, [rubi.eir] eyes rolled most of the way as [rubi.ey] completely loses [rubi.em]self to [rubi.eir] thunderous climax.  Gurgling as they shrink, the femboy's balls convulse with each shot until they return to their normal size.  Your back has already been treated to a one-man bukkake show at that point, however.");
		output("\n\nRubi abruptly shudders, squirting a few weak strands of cream into the sopping-wet towel before [rubi.ey] flops down atop you into [rubi.eir] own mess.  You pull [rubi.em] to the side for a snuggle and rouse [rubi.em] with a kiss.  When [rubi.ey] seems sane enough to understand you again, you thank [rubi.em] for the wonderful time.  Rubi blushes at that before apologizing for the mess and helping to clean you up before you go.  More than one towel has fallen prey to your boy-toy's backed up virility this day.");
	}
	//<= 9
	else {
		output("\n\nHis cum rolls out of [rubi.em] in a thick, white wave, forcefully enough to immediately seep through the towel and voluminous enough that by [rubi.eir] third squirt semen is dripping from the fringes of the sodden fabric.  Moaning like a whore, [rubi.eir] hands knead your soaked bottom as [rubi.eir] body is wracked by paroxysms of pleasure.  Muscles the femboy didn't even know [rubi.ey] had are working triple-time to spray [rubi.eir] bounty of liquid love out, and as [rubi.eir] back arches involuntarily, [rubi.eir] spurting jizz-fountain lifts to hose down your back, the cum beading on the oil like rain on glass.  [rubi.Eir] balls are shrinking by the second, but the bed is turning into a hot, wet mess along with your body.  You watch as [rubi.eir] eyes roll the whole way back, and [rubi.eir] tongue lolls from [rubi.eir] mouth - Rubi's brain has shut down under the onslaught of [rubi.eir] pleasure, leaving [rubi.eir] body to jizz on autopilot until [rubi.ey] goes dry.");
		output("\n\nSlowly, the flood dies down to a lazy drip, and then, with a whimper, it ends.  Rubi splashes down on your jizz-stained back nervelessly, [rubi.eir] hands sinking into the puddles [rubi.ey]'s turned the mattress into on either side of you.  You teasingly roll your cheeks from side to side, earning a few last twitches from [rubi.eir] spent erection before you pull the exhausted femboy down beside you.  Rubi whimpers as you hug [rubi.em] close and kiss [rubi.em], ignoring the mess [rubi.ey]'s made so that you can simply enjoy the tender moment with your lover.  It looks like you both got what you needed today, though Rubi's going to go through a few more towels before you're fit to depart...");
	}
	rubi.orgasm();
	processTime(40 + rand(20));
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Closet
private function goInRubisClosetSoThatYouCanComeOutOfTheCloset():void {
	clearOutput();
	rubiSprite();
	output("You ask to see Rubi's wardrobe.  [rubi.Eir] eyes light up and [rubi.ey] claps [rubi.eir] hands together excitedly.  \"<i>");
	if (rubi.isBimbo() && int(flags["COC.RUBI_DEBIMBO"]) == 0) output("Oh my god!  ");
	output("Really?  It's right over here!</i>\"  Rubi clasps your hand and drags you into the bedroom, then through another doorway.");
	output("\n\nYou struggle to keep your jaw from hitting the floor.  Rubi's closet must be the size of [rubi.eir] bedroom!  Various pants, blouses, dresses, bottoms, and tops hang from racks on either side of the room, under which are small dressers or racks of shoes of all types.  Flats, heels, boots, ballet slippers.  Almost any shoe imaginable seems to be here, in any color possible.  The majority of the opposite wall is taken up by an enormous vanity table, with a large ornate mirror and more cosmetics covering its surface than you know what to do with.  Full length mirrors are scattered around the remaining empty spaces along the wall, while the middle is left completely open.");

	output("\n\nRubi twirls around in the center of the room, clearly happy to be in here.  Before you can say anything, Rubi strips out of [rubi.eir] current outfit, setting it aside in a neatly folded pile before standing proud with [rubi.eir] hands on [rubi.eir] hips.  \"<i>So, you want me to wear something?</i>\"");
	//(Go To Appearance)
	clearMenu();
	addButton(0,"Next",rubiAppearance);
}

//Appearance
private function rubiAppearance():void {
	//output(images.showImage("rubi-inspect-appearance"), false);
	clearOutput();
	rubiSprite();
	output("You look over your naked, demon-morph lover.");
	output("\n\nRubi is about five feet tall, with a very lithe, feminine body.  [rubi.Eir] skin is ");
	
	if (rubi.hasFur()) output("covered with a fine layer of silky-smooth pink fur");
	else if (rubi.skinTone == "pale") output("pale, almost like porcelain");
	else if (rubi.skinTone == "red") output("an exotic cherry red");
	if(rubi.skinAccent != "") output(" which contrasts well with a [rubi.skinAccent] belly and stripes that run up and down [rubi.eir] legs and arms");
	
	if (!rubi.hasFur()) output(" and completely hairless, except for [rubi.eir] ");
	else output(", and [rubi.ey] sports ");
	
	output(rubi.hairDescript(true, true) + " , which [rubi.ey] keeps cut in a cute, feminine style.  Rubi's face is soft and rounded");
	if (rubi.hasStatusEffect("Whiskers")) output(", with a cute set of whiskers sprouting from [rubi.eir] cheeks");
	output(", [rubi.eir] lips painted a [rubi.lipColor], [rubi.eir] [rubi.eyeColor] eyes framed with eyeliner, belying [rubi.eir] masculine origins.  ");
	if (rubi.hasHorns()) output("Two tiny horns extend upwards from [rubi.eir] hairline, solid black in color.  ");
	output("A pair of ");
	if (rubi.earType == GLOBAL.TYPE_HUMAN) output("cute, normal ears protrude from the sides of [rubi.eir] head, each one pierced with a small dangling earring");
	else if (rubi.earType == GLOBAL.TYPE_FELINE) output("cute, cat-like ears pop up from the top of [rubi.eir] head, each one seemingly able to move independently");
	else if (rubi.earType == GLOBAL.TYPE_AVIAN) output("feathered ears protrude from the sides of [rubi.eir] head, each one fluttering cutely from time to time, and each pierced with a small dangling earring");
	output(".");

	output("\n\n[rubi.Ey] has a ");
	if (rubi.breastRows[0].breastRating() < 1) output("flat-chest ");
	else output("[rubi.chest]");
	output(" supporting two perky [rubi.nippleColor] nipples.");

	output("\n\nBetween [rubi.eir] legs is a ");
	if (rubi.hasCock()) {
		output("[rubi.cock], which starts to perk up under your scrutiny. From experience, you know it can reach a impressive " + rubi.cocks[0].cLengthRaw + " inches when erect.  ");
		output("Under [rubi.eir] cock swings a set of ");
		if (flags["COC.RUBI_BLU_BALLS"] >= 4 && flags["COC.RUBI_BLU_BALLS"] < 9) output("cum-swollen ");
		else if (flags["COC.RUBI_BLU_BALLS"] >= 9) output("engorged, blue-tinged ");
		output("testicles");
		if (flags["COC.RUBI_BLU_BALLS"] <= 1) output(", which cling tight to [rubi.eir] body in a cute spherical pouch");
	}
	if (rubi.hasCock() && rubi.hasVagina()) output(" and a ");
	if (rubi.hasVagina()) {
		output("cute [rubi.vaginaColor] pussy topped off by a little love button.  Though you can't see it, you know Rubi's got a perfect little asshole, between [rubi.eir] buttcheeks, right where it belongs.");
	}
	else
	{
		output(".");
	}

	output("\n\nSwaying behind [rubi.em] is a red spaded tail, which coils around [rubi.eir] leg occasionally.  ");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output("Finally, Rubi stands on a long black spike that makes [rubi.em] walk as though [rubi.ey] were wearing high heels.");

	//[Give Item] [Get Dressed] [Back]
	clearMenu();
	addButton(0, "Give Item", pickAnItemToFeedRubi);
	addButton(1, "Get Dressed", playDressUp);
	addButton(14, "Back", rubisFuckingHouseYouPervert);
}

//Get Dressed
private function playDressUp():void {
	clearOutput();
	rubiSprite();
	output("You look over Rubi's vast collection of clothes.  What outfit would you like Rubi to put on?\n\n");
	clearMenu();
	var closet:Array = [];
	var buttonNames:Array = [];
	if (rubi.hasItem(new CoCSuitclothes())) {
		closet[closet.length] = "Suitclothes";
		buttonNames[buttonNames.length] = "Suit";
	}
	if (rubi.hasItem(new CoCRubberClothes())) {
		closet[closet.length] = "Rubber Fetish Clothes";
		buttonNames[buttonNames.length] = "Rubber";
	}
	if (rubi.hasItem(new CoCAdvClth())) {
		closet[closet.length] = "A Green Adventurer's Outfit";
		buttonNames[buttonNames.length] = "Green Outfit";
	}
	if (rubi.hasItem(new CoCTubeTop())) {
		closet[closet.length] = "A Tube Top";
		buttonNames[buttonNames.length] = "Tube Top";
	}
	if (rubi.hasItem(new CoCTransparentBodysuit())) {
		closet[closet.length] = "A Sheer Bodysuit";
		buttonNames[buttonNames.length] = "Bodysuit";
	}
	if (rubi.hasItem(new CoCLongDress())) {
		//trace("PRE-CRASH");
		closet[closet.length] = "A Long Dress";
		buttonNames[buttonNames.length] = "Long Dress";
	}
	if (rubi.hasItem(new CoCLthrPnt())) {
		closet[closet.length] = "A Dashing Outfit With Tight Leather Pants";
		buttonNames[buttonNames.length] = "DashingOutfit";
	}
	if (rubi.hasItem(new CoCNurseOutfit())) {
		closet[closet.length] = "Nurse's Clothes";
		buttonNames[buttonNames.length] = "Nurse'sClothes";
	}
	//(Slutty Swimwear (Normal))
	if (rubi.hasItem(new CoCSluttySwimwear())) {
		closet[closet.length] = "Slutty Swimwear";
		buttonNames[buttonNames.length] = "Swimwear";
	}
	if (rubi.hasItem(new CoCBimboSkirt())) {
		closet[closet.length] = "A Bimbo Minidress";
		buttonNames[buttonNames.length] = "Bimbo Dress";
	}
	if (rubi.hasItem(new CoCBondageStraps())) {
		closet[closet.length] = "Bondage Straps";
		buttonNames[buttonNames.length] = "Bondage Straps";
	}
	if (rubi.hasItem(new CoCInquisitorsCorset())) {
		closet[closet.length] = "An Inquisitor's Corset";
		buttonNames[buttonNames.length] = "Corset";
	}
	//RIsque waitress uniform
	if (flags["COC.RUBI_AFFECTION"] >= 100) {
		closet[closet.length] = "A Risque Waitress's Uniform";
		buttonNames[buttonNames.length] = "RisqueUniform";
	}
	closet[closet.length] = "Rubi's Waitress's Uniform";
	if (closet.length > 0) {
		output("<b>Rubi's Closet Contains:</b>\n");
		temp = 0;
		while(temp < closet.length) {
			output(closet[temp] + "\n");
			temp++;
		}
		output("\n");
	}
	var button:int = 0;
	var buttonId:int = 0;
	while(button < buttonNames.length) {
		trace("BUTTONNAMES: " + buttonNames[button]);
		trace("CLOSET: " + closet[button]);
		addButton(buttonId, buttonNames[button], dressUpRouter, closet[button]);
		button++;
		buttonId++;
		if (buttonId % 14 == 0) buttonId++;
	}
	addButton(14,"Back",rubiAppearance);
}

private function dressUpRouter(arg:String):void {
	clearOutput();
	rubiSprite();
	if (arg == "Suitclothes") putOnASuitYouSlut();
	else if (arg == "A Waitress's Uniform") putRubiInAWaitressUniform();
	else if (arg == "Rubber Fetish Clothes") rubiHasARubberFetish();
	else if (arg == "A Green Adventurer's Outfit") goOnAnAnalAdventureRubiNotReallyJustAnAdventurersOutfit();
	else if (arg == "A Tube Top") putOnATubeTopYouWhore();
	else if (arg == "A Sheer Bodysuit") putOnMyBodysuitYouWhore();
	else if (arg == "A Long Dress") giveRubiALongDressToHideHerHideousBody();
	else if (arg == "A Dashing Outfit With Tight Leather Pants") putOnADashingOutfitYouWhore();
	else if (arg == "Nurse's Clothes") rubiPutsOnNursesClothesSoSheCanCheckYourTemperature();
	else if (arg == "Slutty Swimwear") putOnSluttySwimwearYouSkank();
	else if (arg == "A Bimbo Minidress") putOnADressYouBimbo();
	else if (arg == "Bondage Straps") putOnBondageStrapsYouBondageTrap();
	else if (arg == "An Inquisitor's Corset") whyTheFuckIsRubiWearingAnInquisitorsCorset();
	else if (arg == "A Risque Waitress's Uniform") putOnAWaitressUniformYouWhore();
	else if (arg == "An Adventurer's Outfit") goOnAnAnalAdventureRubiNotReallyJustAnAdventurersOutfit();

}

//Waitress Uniform
private function putRubiInAWaitressUniform():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the waitress uniform.  \"<i>Hm, well all right, but it's just my work clothes,</i>\" [rubi.ey] replies.");
	output("\n\nRubi starts off with a white bra trimmed with lace");
	if (rubi.breastRows[0].breastRating() < 1) output(", though it's obvious [rubi.ey] doesn't need it with [rubi.eir] flat-chest");
	output(".  [rubi.Ey] slips [rubi.eir] arms through the holes and expertly latches the back.  Next [rubi.ey] takes a black garter belt and slips it up [rubi.eir] slender ");
	if (!rubi.hasFur()) output("hairless");
	else output("furred");
	output(" legs, until it rests snugly around [rubi.eir] waist.  A matching pair of sheer stockings quickly follow, held up by the garter.");

	if (!rubi.isBimbo() || int(flags["COC.RUBI_DEBIMBO"]) > 0) output("\n\nYour demon-morphed lover next trots over to a chest of drawers and rummages through it until [rubi.ey] produces a pair of frilly pink panties, complete with a little bow on the front.  [rubi.Ey] steps into the underwear one stocking-clad leg at a time and pulls them up until they fit snugly around [rubi.eir] round ass and [rubi.cock].");
	else output("\n\nNow is when you'd expect [rubi.em] to put on a pair of panties, but it seems [rubi.eir] bimbo-addled mind has completely forgotten them.");
	output("  Rubi approaches a rack of clothes, searching quietly for a moment before picking two hangars off it: a pink blouse and a matching pink skirt.");

	output("\n\nThe blouse goes on first, followed by the skirt.  Rubi only buttons the blouse about half way up");
	if (rubi.breastRows[0].breastRating() < 1) output(", showing off some of [rubi.eir] flat chest");
	else output(", showing off a generous portion of cleavage");
	output(", and tucks the hem of the blouse into the skirt.  Finally, Rubi selects a pair of ");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output("what appears to be flats, with a hole in the heel for [rubi.eir] demonic heels");
	else output("short heels");
	output(" and slips them on.  [rubi.Ey] gives a little twirl in the waitress uniform, and bends over several times to show off [rubi.eir] ");
	if (!rubi.isBimbo() || int(flags["COC.RUBI_DEBIMBO"]) > 0) output("girly panties");
	else output("naked nethers");
	output(".");

	output("\n\n\"<i>There we go!  How do I look?</i>\"  You grin and tell [rubi.em] that [rubi.ey] looks great, and that you never could resist a [rubi.man] in uniform.");

	output("\n\nNow that Rubi is dressed up, what do you want to do?");

	//[Date (go to Ice Cream date)] [Back]
	clearMenu();
	addButton(0, "Date", dateIntro, iceCreamDate);
	addButton(4, "Back", rubiAppearance);
}
//Dashing Outfit
private function putOnADashingOutfitYouWhore():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the dashing outfit.  \"<i>Ohh, feeling like plundering a little booty today?</i>\" [rubi.ey] asks with a coy smile.");

	output("\n\nRubi starts off with what seems to be the skimpiest g-string you've ever seen.  [rubi.Ey] steps into the tiny underwear and pulls them up, ");
	if (rubi.hasCock()) output("tucking [rubi.eir] cock firmly into the triangular strip of cloth covering [rubi.eir] crotch, while ");
	output("the string gets firmly lodged between Rubi's butt cheeks.  The next thing Rubi picks out is a pair of impossibly small leather pants.  [rubi.Ey] puts them on one leg at a time, and struggles to pull the tight pants up [rubi.eir] smooth thighs and shapely ass.  You get involved at some point, helping to hoist the pants up while Rubi buttons them properly.  The end result is a pair of leather pants that cling to Rubi's legs like a second skin, showing off every curve of [rubi.eir] ass, thighs and calves");
	if (rubi.hasCock()) output(", not to mention the sizeable package in [rubi.eir] crotch");
	output(".");

	output("\n\nYour demon-morphed lover picks out a garment from the nigh-endless racks around you, a white silk shirt.  Foregoing the usual bra, [rubi.ey] slips on the shirt and, seeing as there are no buttons on it, knots up the bottom.  The outfit as a whole is damned sexy, showing off [rubi.eir] midriff and baring the valley running down [rubi.eir] [rubi.chest].");
	if (rubi.hasCock()) output("  Combined with the sizeable bulge in the crotch, Rubi looks like quite the dashing, if slutty, piratess.");

	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to Ice Cream date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,iceCreamDate);
	addButton(4,"Back",rubiAppearance);
}

//Adventurer's Outfit
private function goOnAnAnalAdventureRubiNotReallyJustAnAdventurersOutfit():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the adventurer's outfit.  \"<i>Ah yes, am I going to be the Champion now?</i>\" Rubi asks, balling up [rubi.eir] dainty hands and putting them on [rubi.eir] hips.  \"<i>Rubi, Champion of Mareth!  Slayer of demons and ");
	if (silly) output("collector of waifus!");
	else output("layer of ladies");
	output("!  Has a bit of a ring to it doesn't it?</i>\"  [rubi.Ey] giggles for a moment and then gathers up the clothes.");

	output("\n\n[rubi.Ey] starts with a simple, only slightly lacy white bra");
	if (rubi.breastRows[0].breastRating() < 1) output(", though it's obvious [rubi.ey] doesn't need it with [rubi.eir] flat-chest");
	output(".  [rubi.Ey] slips [rubi.eir] arms through the holes and expertly latches the back.  Following that is a matching pair of panties that [rubi.ey] slips up [rubi.eir] long, smooth legs.  [rubi.Ey] pulls them up so that they hug [rubi.eir] round, cute ass tightly.");

	output("\n\nThe next thing to go on is a pair of brown leggings.  Rubi rolls them up first before sitting down on the seat in front of the vanity and slips one leg in, unrolling the leggings up to the knee before doing the same with the other leg.  Then [rubi.ey] stands and pulls them up the rest of the way.  The way they cling to [rubi.eir] legs and ass just makes it look more shapely, and you can't help but lick your lips.");

	output("\n\nA dark green tunic is the last garment to go on, which Rubi simply tosses on over [rubi.eir] head and fastens in place with a leather belt.  [rubi.Ey] pulls on a matching green pointed cap that tapers to a point");
	if (rubi.earType == GLOBAL.TYPE_FELINE) output(", covering [rubi.eir] feline ears");
	output(".  The boots that go with the outfit are mid-calf length and made of supple, fine leather");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(" with a hole cut out in the heel, apparently for Rubi's demonic heels to fit through");
	output(".  Once those are on, Rubi completes the look by retrieving a wooden sword from somewhere while you were too distracted by [rubi.eir] ass.");

	output("\n\nNow that Rubi is dressed up, what do you want to do?");

	//[Date (go to Ice Cream date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,iceCreamDate);
	addButton(4,"Back",rubiAppearance);
}

//Long Dress
private function giveRubiALongDressToHideHerHideousBody():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the long dress.  \"<i>Oohh, I just </i>love<i> that one! One second!</i>\" [rubi.ey] says as [rubi.ey] pulls out the dress and several accessories.");
	output("\n\nRubi starts with an off-pink strap-less bra");
	if (rubi.breastRows[0].breastRating() < 1) output(", despite the fact that [rubi.ey] clearly doesn't need one");
	output(", which [rubi.ey] expertly fastens behind [rubi.em]");
	output(".  Next, [rubi.ey] takes a white garter belt and slips it up [rubi.eir] slender ");
	if (!rubi.hasFur()) output("hairless");
	else output("furred");
	output(" legs, until it rests snugly around [rubi.eir] waist.  A matching pair of white stockings quickly follow, held up by the garter.  The next thing is an off-pink pair of panties that [rubi.ey] slides up [rubi.eir] legs and pulls up so that they cling tightly to [rubi.eir] ample rump.");

	output("\n\nFinally Rubi takes the strapless dress into [rubi.eir] arms, twirling and making dancing motions for a moment before [rubi.ey] suddenly seems to remember you're in the room with [rubi.em].  [rubi.Eir] face goes scarlet");
	if (rubi.skinTone == "red") output(" (or darkens at least)");
	output(", and [rubi.ey] returns to the task at hand.  The dress goes on neatly, and once it's in place you help to pull the strings on the built-in corset, tying them off with a neat little bow in back. To top it all off is a pair of pink pumps");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(" with the heels cut off and a hole for Rubi's demonic heel to fit through");
	output(", which [rubi.ey] slips on quickly.");
	output("\n\nAll in all, [rubi.ey] looks ready for a night at some kind of fancy ball.");
	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to fancy dinner date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,fancyDate);
	addButton(4,"Back",rubiAppearance);
}

//Nurse's Clothes
private function rubiPutsOnNursesClothesSoSheCanCheckYourTemperature():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the nurse's uniform.  \"<i>Ohh, coming down with a bit of a fever?  Do you need a sponge bath?</i>\" [rubi.ey] says coyly, before gathering up the clothing.");
	output("\n\n[rubi.Ey] starts with a simple, only slightly lacy white bra");
	if (rubi.breastRows[0].breastRating() < 1) output(", though it's obvious [rubi.ey] doesn't need it with [rubi.eir] flat-chest");
	output(".  [rubi.Ey] slips [rubi.eir] arms through the holes and expertly latches the back.  Next [rubi.ey] takes a white garter belt and slips it up [rubi.eir] slender ");
	if (rubi.hasFur()) output("furred ");
	else output("hairless ");
	output("legs, until it rests snugly around [rubi.eir] waist.  A matching pair of white fishnet stockings quickly follow, held up by the garter.  The next thing is a pair of white cotton panties that [rubi.ey] slides up [rubi.eir] legs and pulls up so that they cling tightly to [rubi.eir] ample rump.");

	output("\n\nNext it's time for the actual dress.  Rubi holds up the white dress for a moment before slipping it on.  The slinky white dress clings tightly to [rubi.eir] body, with a little red cross resting right above [rubi.eir] ");
	if (rubi.breastRows[0].breastRating() < 1) output("heart");
	else output("left breast");
	output(".  [rubi.Ey] places the matching hat on [rubi.eir] head and adjusts it before putting on a pair of white pumps");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(" with the heels removed and a hole for [rubi.eir] demonic heels");
	output(".");

	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to ice cream date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,iceCreamDate);
	addButton(4,"Back",rubiAppearance);
}

//Rubber Fetish Clothes
private function rubiHasARubberFetish():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the rubber fetish outfit.  \"<i>Ohoh,</i>\" [rubi.ey] giggles and quirks an eyebrow at you, \"</i>feeling a bit kinky are we?</i>\"");
	output("\n\nRubi starts off, not with any clothing, but with a small dispenser of oil and lotion.  [rubi.Ey] takes a small handful of the stuff, which smells slightly like lilacs, rubs [rubi.eir] hands together and begins applying it to [rubi.eir] ");
	if (!rubi.hasFur()) output("skin");
	else output("furred body");
	output(", starting with [rubi.eir] legs and moving up to the torso and arms.  Once Rubi's ");
	if (!rubi.hasFur()) output("skin ");
	else output("fur ");
	output("glistens with the oils it's time to put on the actual clothes.  ");
	//(If Not Bimbo)
	if (!rubi.isBimbo() || int(flags["COC.RUBI_DEBIMBO"]) > 0) output("[rubi.Ey] first takes a pair of transparent rubber panties and slides them up [rubi.eir] legs until they lovingly cling around [rubi.eir] ass.  ");
	output("Rubi next slides into a transparent latex shirt, long sleeved, with holes cut out to accommodate [rubi.eir] nipples.  It takes some work, and you have to help Rubi to put on the difficult garment, but once it's on, it looks fantastic, clinging to [rubi.eir] body like a second skin.");

	output("\n\nNext goes the skirt, a relatively simple affair compared to the shirt.  The matching stockings, however, are a pain.  Rubi has to sit down on the floor as you muscle them up [rubi.eir] ");
	if (rubi.hasFur()) output("furred ");
	output("legs.  You wonder how [rubi.ey] does this when you're not around!  Finally, Rubi slips on a pair of heels");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(", the actual heel cut off to make room for [rubi.eir] demonic heel,");
	output(" to complete the look.  All in all, [rubi.ey] looks ready for a night in the dungeons.");
	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to bar date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,barDate);
	addButton(4,"Back",rubiAppearance);
}

//Suitclothes
private function putOnASuitYouSlut():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the suit.  \"<i>Oh, really?  It looks nice, but you don't think it's too manly?</i>\"");
	output("\n\nRubi starts with a black, lacy bra");
	if (rubi.breastRows[0].breastRating() < 1) output(", despite the fact that [rubi.ey] clearly doesn't need one");
	output(", which [rubi.ey] expertly fastens behind [rubi.em].  Next, [rubi.ey] takes a black garter belt and slips it up [rubi.eir] slender ");
	if (!rubi.hasFur()) output("hairless");
	else output("furred");
	output(" legs, until it rests snugly around [rubi.eir] waist.  A matching pair of black stockings quickly follow, held up by the garter.  The next thing is a black pair of panties that [rubi.ey] slides up [rubi.eir] legs and pulls up so that they cling tightly to [rubi.eir] ample rump.  You wonder what all this has to do with a suit, but then you remember who you're dealing with.");

	output("\n\nFinally Rubi begins to put on the actual suit, beginning with a simple white, button-up shirt.  Slacks follow behind, and Rubi tucks the shirt into the pants neatly.  A black jacket goes on last, fitting rather loosely over [rubi.eir] frame.  Rubi slips into a pair of heels");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(", with the actual heel cut off to make room for [rubi.eir] demonic heel,");
	output(" and quickly combs back [rubi.eir] hair.  All in all, [rubi.ey] looks like a girl dressed in her boyfriend's clothes... which is to say, quite sexy.");
	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to fancy date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,fancyDate);
	addButton(4,"Back",rubiAppearance);
}

//Tube-Top
private function putOnATubeTopYouWhore():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the tube top and shorts.  \"<i>Ooh, I like that one.  It's a little risque, but so cute!</i>\"");
	output("\n\nRubi starts off with what seems to be the skimpiest g-string you've ever seen.  [rubi.Ey] steps into the tiny underwear and pulls them up, ");
	if (rubi.hasCock()) output("tucking [rubi.eir] cock firmly into the triangular strip of cloth covering [rubi.eir] crotch, while ");
	output("the string gets firmly lodged between Rubi's butt cheeks.  This is followed up by an impossibly small pair of denim shorts which slide up [rubi.eir] slender legs and barely cover the g-string already worn.  Rubi pulls at the side strings of the skimpy underwear, making sure they're plainly visible over the denim shorts.");

	output("\n\nNext [rubi.ey] takes the tube top, little more than a rectangular strip of cloth, and pulls it on over [rubi.eir] head, setting it into place over top of [rubi.eir] [rubi.chest]");
	if (rubi.breastRows[0].breastRating() > 2) output(", which strain the flimsy piece of material");
	output(".  Completing the look is a simple pair of sandals");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(", with a hole cut in the sole to make room for Rubi's demonic heels");
	output(".");
	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to exhibitionist date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}

//Slutty Swimwear
private function putOnSluttySwimwearYouSkank():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the swimsuit.  \"<i>Oh, but there's no pool or lake nearby.  Or do you just want to see me in a bikini?</i>\"  Rubi giggles a moment.");

	output("\n\nRubi starts off with the bikini bottoms, which consists of a strip of cloth that can barely be considered clothing.  [rubi.Ey] pulls it up [rubi.eir] legs and lets it cling tightly to [rubi.eir] ample ass before turning around and waggling it at you.  Next comes the top, a halter-style bikini top that [rubi.ey] slips over [rubi.eir] head and ties up behind [rubi.eir] back.  The two triangular pieces of fabric");
	if (rubi.breastRows[0].breastRating() < 3) output(" sit loosely over Rubi's small chest");
	else output("strain thanks to Rubi's ample busom");
	output(".");

	output("\n\nTopping it off, your demonic lover slips on a pair of sandals");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(", with a hole in the sole to make room for [rubi.eir] demonic heels");
	output(".");

	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to exhibitionist date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}

//Bimbo Minidress
private function putOnADressYouBimbo():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the minidress.  \"<i>Oh that cute little thing we picked up together?  For sure!  It's so cute!</i>\"");
	output("\n\nIt seems there's not much to this strapless pastel pink dress at all, as Rubi simple pulls out the short, hollow tube of fabric and slips it up [rubi.eir] body, adjusting it momentarily around [rubi.eir] [rubi.chest], and pulling it down enough to maintain some level of modesty, though you're certain that won't last long.  After all, [rubi.ey] didn't put on any kind of bra or panties.  Rubi does, however, add a pair of pink pumps");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(", with the heels removed to make room for [rubi.eir] own demonic heels");
	output(".");

	output("\n\nRubi poses several times afterwards, giving you a good show of [rubi.eir] barely-covered body.");

	output("\n\nNow that Rubi is dressed up, what do you want to do?");

	//[Date (go to exhibitionist date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}

//Bodysuit
private function putOnMyBodysuitYouWhore():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the bodysuit.  \"<i>Oh, that thing is pretty cute,</i>\" [rubi.ey] says, \"<i>Though there's not much to it.  But I suppose that's the point, huh?</i>\"");

	output("\n\nRubi giggles for a moment and retrieves the bodysuit from its hangar.  It's almost sheer, though with a few strategically placed opaque, flowery decorations you know it'll preserve Rubi's modesty... just barely, anyway.  Rubi sits on the edge of [rubi.eir] vanity's seat as [rubi.ey] slips the suit up [rubi.eir] ");
	if (!rubi.hasFur()) output("smooth");
	else output("furred");
	output(" legs, then up the rest of [rubi.eir] body until [rubi.ey] slips [rubi.eir] arms into the long, sheer sleeves.  After a few adjustments, making sure ");
	if (rubi.hasCock()) output("[rubi.eir] package is neatly tucked away");
	else output("a red rose is neatly covering up [rubi.eir] pubic mound");
	output(", and the butt of the suit is clinging perfectly to [rubi.eir] own, [rubi.ey] poses for you.");

	output("\n\nNow that Rubi is dressed up, what do you want to do?");

	//[Date (go to bar date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,barDate);
	addButton(4,"Back",rubiAppearance);
}
//Bondage Straps
private function putOnBondageStrapsYouBondageTrap():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the bondage straps.  \"<i>Oh!  That outfit, huh?</i>\"  Rubi blushes brightly");
	if (rubi.hasFur() || rubi.skinTone == "red") output(", or so you imagine");
	output(".  \"<i>That one's so embarrassing... but for you, I'll wear it.</i>\"");

	output("\n\nThe little demon " + rubi.mf("boy","girl") + " retrieves the leather straps from a chest filled with other leather accoutrements.  Rubi fumbles with the tangled web of straps until you step in to help out.  With your help, the two of you manage to figure out which end is which, and Rubi slips [rubi.eir] legs into the bottom.  You pull the mess of leather up [rubi.eir] legs and fasten it in place.  Pulling the rest of the garment up, you tighten and fasten it up further.");
	output("\n\nEventually you've fastened the whole thing up Rubi's torso and arms, including a thick collar around [rubi.eir] neck.  You've cinched up the whole thing in such a way that Rubi's movements are slightly restricted, though [rubi.ey] is fully able to get out of it later.");
	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to exhibitionist date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}

//Inquisitor's Corset
private function whyTheFuckIsRubiWearingAnInquisitorsCorset():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the inquisitor's corset.  \"<i>Oh my, I really love that one.  It's so pretty and lacy!</i>\"");

	output("\n\nRubi starts with a black bra with red lace accents");
	if (rubi.breastRows[0].breastRating() < 1) output(", despite the fact that [rubi.ey] clearly doesn't need one");
	output(", which [rubi.ey] expertly fastens behind [rubi.em].  Next [rubi.ey] takes a black garter belt and slips it up [rubi.eir] slender ");
	if (!rubi.hasFur()) output("hairless");
	else output("furred");
	output(" legs, until it rests snugly around [rubi.eir] waist.  A matching pair of fishnet stockings quickly follow, held up by the garter.  They're black, but on the back is a gold-inlaid corset pattern, leading up to a pair of floppy crimson bows.  The next thing is a red pair of panties accented with gold that [rubi.ey] slides up [rubi.eir] legs and pulls up so that they cling tightly to [rubi.eir] ample rump.");

	output("\n\nNext comes the actual corset, a red and gold work of art with intricate golden runes stitched into it.  Rubi loosens up the lacing in the back and slips into it, pulling it up [rubi.eir] body.  [rubi.Ey] struggles to tighten it up for a moment before you step in, taking the strings and tightening it all the way up, shrinking Rubi's waistline several sizes.  You finish it off with a delicate little bow.  Afterwards, Rubi slips on a pair of black heels");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(", with the heels removed to make room for [rubi.eir] own demonic heels");
	output(".");
	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to bar date)] [Back]
	clearMenu();
	addButton(0,"Date",dateIntro,barDate);
	addButton(4,"Back",rubiAppearance);
}

//Risque Waitress Uniform
private function putOnAWaitressUniformYouWhore():void {
	clearOutput();
	rubiSprite();
	output("You tell Rubi you'd like to see [rubi.em] in the risque version of [rubi.eir] normal waitress uniform.  \"<i>Oh, you like that outfit, huh?  I thought you might,</i>\" Rubi says with a giggle.");
	output("\n\nOf course, there's not much to this outfit, which starts off with a skirt so short it could be confused for a belt.  ");
	//(not bimbo)
	if (!rubi.isBimbo() || int(flags["COC.RUBI_DEBIMBO"]) > 0) {
		output("Next [rubi.ey] slips on a pair of pink frilly panties, sliding them up [rubi.eir] slender legs until they come up to cling to [rubi.eir] ample ass.  ");
		if (rubi.hasCock()) output("Oddly enough, these panties only seem to cover Rubi's balls, leaving [rubi.eir] cock right out in the open.  ");
	}
	output("Taking a simple white apron, Rubi throws that on next, looping the halter-like top over [rubi.eir] neck and tying off the straps around [rubi.eir] waist.");
	if (rubi.hasCock()) output("  To top it all off, Rubi takes a pink lacy cocksock and slips it down [rubi.eir] [rubi.cock], fastening it into place with a pink ribbon that [rubi.ey] ties into a bow around the base of [rubi.eir] cock.");

	output("\n\nAfter all that, [rubi.ey] simply puts on a pair of black, open-toed heels");
	if (rubi.hasLegFlag(GLOBAL.FLAG_HEELS)) output(", with the heels removed to make room for [rubi.eir] own demonic heels");
	output(", and poses for you in the skimpy outfit.");
	output("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to cooking date)] [Back]
	clearMenu();
	//addButton(0,"Date",dateIntro,cookingDate);
	addDisabledButton(0, "Date", "Date", "<b>Third forgot to write this one!</b>");
	addButton(4,"Back",rubiAppearance);
}
//private function cookingDate():void {
	//output("\n\n<b>Third forgot to write this one!</b>");
	//addNextButton(returnToCampUseOneHour);
//}

//Dates
private function dateIntro(date:Function):void {
	clearOutput();
	rubiSprite();
	//(First Time)
	if (int(flags["COC.TIMES_RUBI_DATED"]) == 0) {
		output("An idea strikes you.  While you have talked with Rubi and gotten to know [rubi.em] at work, you haven't really been out with [rubi.em] anywhere else.  You wonder, and ask if Rubi would like to go out somewhere, maybe to pick up some food and talk.");
		output("\n\nRubi's eyes light up and [rubi.ey] nods vehemently.  \"<i>Like a date?  Of course!  I've always wanted to go on a date with you, but you're so busy with your champion duties and all... I never had the courage to ask you!</i>\"  Rubi loops an arm around yours and clings to you.  \"<i>So, where are we going?</i>\"");
	}
	//(Repeats)
	else {
		output("Seeing Rubi all dressed up like this, you figure it might be time to go on another date.  You ask, and Rubi predictably makes a gleeful sound and assents.");
	}
	if (date == iceCreamDate) {
		if (pc.credits < 20) {//Can't Afford It?
			output("\n\nYou think you'd love to take Rubi out for a quick dessert... but you're far too certain you wouldn't be able to afford it at the moment.");
			output("\n\nSeriously, you're the Champion. You shouldn't be this broke.");
			clearMenu();
			addButton(0,"Next",rubiAppearance);
			return;
		}
	}
	
	if (date == fancyDate) {
		//Can't Afford It?
		if (pc.credits < 100) {
			output("\n\nYou think you'd love to take Rubi out for a fancy meal, but you're certain you wouldn't be able to afford it at the moment.");
			output("\n\nSeriously, you're the Champion. You shouldn't be this broke.");
			clearMenu();
			addButton(0,"Next",rubiAppearance);
		}
	}
	IncrementFlag("COC.TIMES_RUBI_DATED");
	date();
}

//Ice-Cream Date
//For Waitress Uniform, Dashing Outfit, Adventurer's Outfit, Nurse Uniform
//Costs 2 gems.
private function iceCreamDate():void {
	pc.credits -= 20;
	rubiSprite();
	output("\n\nYou take your freshly dressed-up lover and head out of the little house.  Hand-in-hand you head down the streets of Tel'Adre, looking for a good place to have a quiet meal.  Past the bakery where Rubi works, you spot a small shop labelled as a \"Ice Cream Parlour\".  Rubi looks inside, [rubi.eir] eyes wide as [rubi.ey] asks, \"<i>Oh!  Can we stop in here?</i>\"");
	output("\n\nNodding, the two of you head inside.  It's a small shop, with only a few tables, most of which are empty.  There's a counter at the far end of the store, behind which you can see several buckets filled with icy, creamy goodness.  A male fox standing behind the counter tells you to sit anywhere, and that he'll come by for your orders momentarily.  You take Rubi over to a table next to the window and sit, chatting idly until the fox approaches.");
	output("\n\n\"<i>Ah, I'll have a parfait!  Thanks!</i>\"  Rubi says immediately.  You order one for yourself as well, and in no time the fox returns, setting two parfaits down on your table.");
	output("\n\nRubi's eyes grow as big as saucers as [rubi.ey] picks up [rubi.eir] spoon and digs in, as do you.  \"<i>I love coming here,</i>\" [rubi.ey] says, \"<i>it's one of the only places in Tel'Adre that has ice cream and cold desserts.  It's so great.  I just come in here and people watch sometimes.  I used to do that back in my village too, with my parents...</i>\"  Rubi suddenly gets very quiet, but when [rubi.ey] turns to you, [rubi.ey] bursts out in a fit of giggles.");

	output("\n\nPerplexed, you ask what's so funny.  \"<i>You've got a bit of ice cream on you,</i>\" [rubi.ey] says between giggles.  You wipe at your face and nose, trying to rid yourself of the sugary sweets.");

	output("\n\nJust when you're certain you've gotten it all, Rubi stops [rubi.eir] giggling and says, \"<i>You missed a spot.</i>\"  Before you can ask where, Rubi leans over the table and kisses you full on the lips, sucking off a dollop of ice cream that you're not even sure existed in the first place.  Blushing bright red, Rubi sits back in [rubi.eir] seat and mutters, \"<i>Got it.</i>\"");
	output("\n\nThe two of you pass the rest of your date watching the people outside, occassionally coming up with life stories, goals and relationships for them.  Rubi's hopeless romantic side blossoms here.  Everyone, it seems, is pining for someone else in [rubi.eir] imagination.  There's unrequited love, love triangles, love quadrangles, affairs and more.  Each person that passes by the window seems to be head-over-heels for someone, or multiple people.  Rubi invents entire backstories, first dates, first kisses overlooking a sunset, and their first nights together.");

	//(if Relationship 100, happens once)
	if (flags["COC.RUBI_AFFECTION"] >= 100 && flags["COC.RUBI_ICECREAM_CONFESSION"] == undefined) {
		output("\n\n[rubi.Ey] looks over at you during all this, places a hand on yours and says very earnestly, \"<i>I... Thank you for this.  It means a lot to me.  I did this with my mom and dad a lot.  You know, before the demons attacked.  Even though they're not with me any more, it means a lot that I can do this with someone else again.</i>\"");
		flags["COC.RUBI_ICECREAM_CONFESSION"] = 1;
	}

	output("\n\nYour parfaits are not infinite, however, and once you've depleted your layered frozen treats it seems it's time to head back.  The two of you clasp hands once more and head out of the shop, heading back to Rubi's place in silence, content to be in each other's presence.");

	output("\n\nOnce you're back in the house, Rubi sprawls out on the couch, a devilish grin on [rubi.eir] face.  \"<i>So, you plan on giving me a good \"kiss\" good night?\"");
	//[Go to Sex menu]
	processTime(45);
	rubiSexMenu();
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Fancy Dinner Date
//For Suitclothes, Long Dress.
private function fancyDate():void {
	rubiSprite();
	//Costs 10 gems
	pc.credits -= 100;
	output("\n\nSince your lover is dressed up for a night on the town, you decide to take [rubi.em] to the fanciest restaurant in all of Tel'Adre.  Together, hand in hand, the two of you strike out of Rubi's small, yet cozy home, and head off in search of the best eatery in town.  Rubi directs you over a few streets, and you find yourself in front of \"Bigby's Cafe\", a large, imposing restaurant front.  Columns of fine marble flank the entrance to this impeccable shop.");
	output("\n\nYou offer Rubi your arm, like a " + rubi.mf("gentleman","lady") + " should, which [rubi.ey] accepts graciously, and you escort [rubi.em] inside.  A well-dressed bunny-boy meets you inside and escorts you to a table before handing you each a menu.  He bows and mentions that your waiter will be right with you.  You glance over your menu briefly, only recognizing a few entrees.  Many of the dishes seem to be foreign, at least to you.");

	output("\n\nYour waiter, a broad-shouldered wolf man who wouldn't look out of place in a guard's uniform, arrives moments later.  Rubi orders a fillet of fish, claiming that [rubi.ey] is feeling a bit nostalgic.  You decide to order the same thing, as you're certain you could only understand what a fraction of the things on the menu were.  The waiter nods, retrieves your menus, and heads back to the kitchen.");
	output("\n\nThis gives you and Rubi a chance to watch the other people in the restaurant.  Despite its fancy exterior, many of the patrons are dressed simply.  You wouldn't be surprised to see these people at the bakery, or the Wet Bitch for that matter.  You wonder briefly if Rubi is overdressed, though with how happy [rubi.ey] looks in that outfit, you're certain [rubi.ey] wouldn't care.");
	output("\n\nThe two of you people watch for some time, your mutual gazes eventually settling on a pair of foxes alone in a corner.  They're both clasping each other's hands, talking indistinctly to one another.");
	output("\n\n\"<i>Oh, but Fabius, I love you so much my dear,</i>\" says Rubi, suddenly.  You're confused for a moment before you realize that [rubi.eir] hopeless romantic side has taken over, and [rubi.ey]'s just dramatizing the foxes' conversation.");
	output("\n\n\"<i>I know my sweet Carmilla, but we must keep this a secret, for if our families knew then we could not be together,</i>\" [rubi.ey] continues, in a mock masculine voice.  You notice with a smile that even when attempting a male voice, [rubi.ey] can't help but sound like an innocent young girl.");

	output("\n\nAs the dramatization continues, you find yourself concentrating less upon the couple, and more on Rubi and [rubi.eir] story.  [rubi.Ey] seems to adore the idea of forbidden love, especially true love, that must be kept hidden lest it tear families asunder.  The idea of two people who seem by all means to be destined for one another, and who must remain apart for one reason or another, really strikes a chord within Rubi, and you realize that [rubi.ey] has been tearing up as the fiction continues.");

	//(If Relationship 100, only happens once)
	if (flags["COC.RUBI_AFFECTION"] >= 100 && flags["COC.RUBI_FANCY_CONFESSION"] == undefined) {
		output("\n\nToward the end of the faux lip-reading, Rubi suddenly stops and looks over at you.  \"<i>I... They're kind of like us, aren't they?  You can't stay here with me, and I can't go with you.  But we still find our moments, here and now, with each other, don't we?  That's what I look forward to the most.  The few moments I get to spend with you,</i>\" [rubi.ey] confesses, dead serious, the tears forming in [rubi.eir] eyes.");
		flags["COC.RUBI_FANCY_CONFESSION"] = 1;
	}
	output("\n\nEventually, though, your food comes around, and Rubi dabs a napkin at [rubi.eir] eyes, careful not to smudge the elegant makeup [rubi.ey] put on for this event.  \"<i>Well, that's enough of that,</i>\" [rubi.ey] says with a giggle.  \"<i>Let's try this fish out.  I wonder if it's better than...</i>\" Rubi's voice trails off as [rubi.ey] tries a bite.  \"<i>Nope, definitely not,</i>\" [rubi.ey] concludes, through a mouthful of fish.");
	output("\n\nYou too try your fish.  It's quite good");
	//(if PC has met Callu)
	if (flags["COC.MET_OTTERGIRL"] == 1) output(" though not as good as Callu's, the ottergirl fisherman you met at the lake.");
	else output(", which makes you wonder who Rubi is thinking about.  Perhaps one of [rubi.eir] parents?");

	output("\n\nOnce the two of you finish off your respective meals, you pay for the dinner and escort your lovely date back to [rubi.eir] place, enjoying each other's company on the quiet walk.");

	output("\n\nOnce you're back in the house, Rubi sprawls out on the couch, a devilish grin on [rubi.eir] face.  \"<i>So, you plan on giving me a good \"kiss\" good night?\"");
	//[to sex menu]
	processTime(45);
	rubiSexMenu();
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Exhibitionist Date
///For Tube Top, Slutty Swimwear, Bimbo Minidress, Bondage Straps.
private function exhibitionistDate():void {
	rubiSprite();
	output("\n\nYou think carefully as to where you could go.  With [rubi.em] dressed up as sluttily as [rubi.ey] is, you think a nice dinner is out of the question.  However, perhaps you can have a bit of fun taking a walk around town.  You wrap your arm around your lover's waist and together the two of you strike out into the warm Tel'Adran air.");
	output("\n\nYou head away from the more populated avenues of the city.  Rubi fidgets slightly, not used to being so... exposed on the streets.  You whisper words of encouragement in [rubi.eir] ear, saying how sexy [rubi.ey] is looking, that [rubi.ey] shouldn't feel bad about flaunting it.  In fact, you suggest, [rubi.ey] might even like to show off a bit more to the random people you pass.");
	output("\n\nRubi gulps visibly, then nods and follows your suggestion, pulling aside [rubi.eir] clothes and flashing [rubi.eir] [rubi.chest] at the next person to pass you by.  The feline male's eyes widen in surprise.  You swiftly pass him by, eager to get out of sight just in case his reaction is less than friendly.  Luckily, as he looks back, you see a small smirk on his face... it seems Rubi just made his day.");
	output("\n\nYou run your hand along your lover's body and squeeze [rubi.eir] buttocks firmly, assuring [rubi.em] that the feline man enjoyed the show... and that [rubi.ey] should show off to the next person you pass as well.  An equine woman, quite physically fit and powerful-looking, begins to saunter by, looking curiously at Rubi and [rubi.eir] outrageous getup.  Just as the three of you begin to pass one-another, Rubi pulls aside [rubi.eir] clothes to reveal [rubi.eir] ");
	if (rubi.hasCock()) output("[rubi.cock]");
	else output("glistening, wet pussy");
	output(".");

	output("\n\nThe female equine's jaw drops slightly and her eyes dart between the demon-" + rubi.mf("boy","girl") + "'s crotch, and both you and Rubi's faces.  The two of you rush past quickly, until the latest target of your lover's exhibitionism is out of sight.");

	output("\n\nRubi begins giggling madly once the two of you duck into an alleyway.  \"<i>That was so great!  Did you see her face?  Aaaah, I love it!</i>\"  It takes several minutes for Rubi to calm down, and by the time [rubi.ey]'s done, [rubi.ey]'s practically dragging you back out onto the streets.  \"<i>Come on, I wanna flash some more people,</i>\" [rubi.ey] says, simply.  Looks like [rubi.ey]'s really enjoying [rubi.em]self.");

	output("\n\nRubi flashes several people throughout your \"date\", sometimes even walking around topless, or bottomless.  It seems that [rubi.ey] has no sense of modesty, at least at the moment.  Thoughts of keeping [rubi.eir] \"secret\" are long gone, it seems.");

	output("\n\nBy the time the two of you loop back to Rubi's house, you estimate [rubi.ey] has flashed [rubi.eir] body off to at least a dozen people, all of whom seemed to get a thrill out of it themselves.  None more so than Rubi, however, whose body is simply trembling as you cross the threshold into [rubi.eir] home.");

	output("\n\n[rubi.Ey] grips your arm and gives you a wild kiss on the lips, saying, \"<i>Oh gods that was so exhilarating, babe.  I can't wait until we do that again.  It got me really, </i>really<i> hot... what are you going to do about it?</i>\"");

	//[Go to sex menu]
	processTime(45);
	rubiSexMenu();
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Bar Date
//For Rubber Fetish Clothes, Bodysuit, Inquisitor's Corset.
private function barDate():void {
	rubiSprite();
	output("\n\nYou think carefully about where you could go.  Your companion is not quite dressed well enough for any kind of fancy dinner, but you think you could head down to the local bar for a drink or two.  You wrap your arm around Rubi's waist and together the two of you head out onto the streets of Tel'Adre.  You head from street to street until you come upon the local bar, the \"Wet Bitch\".");

	output("\n\nYou slip inside with your date and find a place up at the bar.  When the bartender moves down to your side of the bar, Rubi blushes brightly and asks, \"<i>Oh, can I get a sex on the beach?</i>\"  You laugh to yourself and order one as well.  The bartender nods and begins mixing the two drinks up.  Meanwhile, Rubi turns around on the stool to watch the rest of the bar.");

	output("\n\n\"<i>This place is great,</i>\" [rubi.ey] comments as you turn around as well.  \"<i>Almost everyone comes by here at some point.  It's a great place to people watch.  See, check those two out,</i>\" [rubi.ey] says, pointing out a pair of young spider-morph females.  \"<i>When I started coming to the bar, they hadn't even met.  I've managed to see their first meeting, their first date, and several of them down the road.  They make such a cute couple, don't they?</i>\"");

	output("\n\nYou follow Rubi's gaze and look at the pair of girls cuddling together in one side of a bench.  The smaller one nuzzles into the larger one's chest as they sip at a pair of drinks.  Rubi smiles contentedly.  \"<i>True love, it's so romantic.</i>\"");

	output("\n\n\"<i>A double dose of sex on a beach,</i>\" comes the voice of the bartender behind you, and the two of you turn to find a pair of drinks set in front of you.  Rubi grasps [rubi.eir] drink and holds it up, \"<i>To true love!</i>\"");

	output("\n\nYou hold up your drink as well and tap it against Rubi's before taking a drink.  Rubi comments on several other patrons, mostly remarking on their love lives.  It seems that, before Rubi met you, [rubi.ey]'d been too embarrassed to date anyone, and settled on living vicariously through others.  It's surprising how many happy couples Rubi can point out, though there is a fair share of heartbreak as well.");

	//(If Relationship 100, happens once)
	if (flags["COC.RUBI_AFFECTION"] >= 100 && flags["COC.RUBI_BAR_CONFESSION"] == undefined) {
		output("\n\n\"<i>Babe... Thanks for all of this.  I know you've got your hands full trying to save the world and all that, but thanks,</i>\" Rubi says suddenly, leaning [rubi.eir] head on your shoulder.  \"<i>I hope one day someone sees us and thinks the same things I used to think.</i>\"");
		flags["COC.RUBI_BAR_CONFESSION"] = 1;
	}
	output("\n\nAfter a few drinks Rubi is quite amorous with you, practically sitting on your lap as you discuss the other patrons of the bar as usual.  You smile at [rubi.em] concernedly, and suggest that maybe [rubi.ey]'s had enough to drink.  [rubi.Ey] waves [rubi.eir] hand dismissively for a moment, before almost toppling off the barstool.  After righting [rubi.em]self, [rubi.ey] nods briefly to you.  \"<i>Maybe it's best we head back,</i>\" [rubi.ey] suggests.");

	output("\n\nYou nod in agreement and grasp Rubi around the shoulders, holding [rubi.em] close as you start walking back to [rubi.eir] place.  It doesn't take long, but Rubi remains frisky the entire way, unable to keep [rubi.eir] hands to [rubi.em] self.");

	output("\n\nBy the time you enter Rubi's bedroom, [rubi.eir] lips are locked with yours.  \"<i>So babe, what are we going to do about this?</i>\"");
	//[Goto Sex menu]
	processTime(45);
	rubiSexMenu();
	addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Anal Training
//Requires 75 Affection.
//Must have a cock larger than Rubi's capacity.
//Repeatable
//Must have a cock greater than Rubi's capacity.
//Rubi's capacity won't go larger than 100.
private function anallyTrainYourBitchBoySlutHowToBeAnalForDCL():void {
	clearOutput();
	rubiSprite();
	IncrementFlag("COC.RUBI_TIMES_ANALLY_TRAINED");
	//First Time
	if (flags["COC.RUBI_TIMES_ANALLY_TRAINED"] == 1) {
		output("You sit down on the couch next to Rubi, making small talk.  After a few minutes the two of you are laughing comfortably as you lounge on the cushions, discussing everything from life in Tel'Adre to your adventuring exploits.  Eventually the topic of conversation circles back to sex, and how you're a bit too much for [rubi.em] to handle at the moment.");
		output("\n\nRubi gulps visibly and nods, \"<i>I can't help it, babe.  That cock of yours looks so ");
		if (rubi.isBimbo() || int(flags["COC.RUBI_DEBIMBO"]) == 0) output("totally ");
		output("delicious, but I'm afraid it's too big!  I couldn't possibly fit that entire thing inside me... not comfortably at least.</i>\"");
		output("\n\nYou frown.  Naturally you don't want to hurt [rubi.em], but the situation can't be hopeless, can it?  This is Mareth after all, where everything AND its mother has a gigantic penis.  Out loud, you assert that there must be some solution to the problem.");
		output("\n\nThe adorable demon morph beside you looks sheepish for a moment before saying, \"<i>Well, I kinda-sorta might be ahead of you on that...</i>\"  Perplexed, you ask what [rubi.ey] means by that.  Rather than explain, Rubi stands up, takes you by the hand, and leads you into [rubi.eir] bedroom.  After that [rubi.ey] kneels down by the bed, reaches under it, and slides out a large black and pink chest.");
		output("\n\nRubi pauses for a moment, taking a deep breath to collect [rubi.em]self before opening the chest.  There, laid out in the chest, is a veritable cornucopia of dildos, dongs, vibrators and a variety of other phallic toys.  They come in all shapes and sizes, from a small pink vibrator all the way up to a mammoth equine dildo as big as Rubi's arm.  Rubi's skin flushes red");
		if (rubi.skinTone == "red") output(", or redder at least");
		else output(", what little of it you can see");
		output(", and [rubi.ey] sits knock-kneed behind the chest.");

		output("\n\n\"<i>Well I've kind of had these for a while.  I thought maybe I could work my way up to your size, but I haven't actually used any yet.  Would you... would you like me to?</i>\" [rubi.ey] asks, fidgeting slightly.");

		output("\n\nYou survey the wide array of saucy toys in the chest.  Well, if it means stretching [rubi.em] out enough for you to finally get your dick in there, why not?  You nod and voice your approval of this plan.  Rubi smiles, stands, and sprints off into the closet, [rubi.eir] demonic tail swishing excitedly behind [rubi.em].");

		output("\n\nYou cock an eyebrow, wondering what [rubi.ey] could possibly be doing in there.  After a few minutes [rubi.ey] returns, wearing a see-through, skimpy, black negligee.  \"<i>There, how do I look?</i>\" [rubi.ey] asks, twirling around.  As [rubi.ey] does, the hem of the negligee flutters up to expose [rubi.eir] naked butt and crotch");
		if (rubi.hasCock()) output(", [rubi.eir] dick wobbling enticingly");
		output(".");

		output("\n\nLicking your lips, you agree [rubi.ey] looks good enough to fuck.  Rubi giggles, minces over and plants a kiss on your cheek.  \"<i>Well that </i>IS<i> the idea... but before that, I'm going to have to do some work,</i>\" [rubi.ey] says, taking up a small, human-sized dildo from the chest along with a bottle of what you assume to be lubricant.  \"<i>I may as well give you a little show. Can't let me have all the fun.</i>\"");

		output("\n\nRubi urges you to sit on the edge of the bed, while [rubi.ey] moves a bit further away, laying down on the plush carpet covering the room.  Setting the dildo and lube aside for now, [rubi.eir] hands explore [rubi.eir] tender body, focusing just for a moment on [rubi.eir] [rubi.chest] and [rubi.nippleColor] nipples, which jut straight up, straining against the sheer fabric of the negligee.  A soft gasp escapes Rubi's soft lips as [rubi.ey] pinches one nipple, while [rubi.eir] other hand flutters down between [rubi.eir] thighs to stroke [rubi.eir] ");
		if (rubi.hasCock()) output("[rubi.cock]");
		else output("quickly dampening pussy");
		output(".");

		output("\n\n[rubi.Eir] hands don't remain there for long, however, as [rubi.ey] seems eager to get on to the main show.  After a minute of stroking, Rubi brings [rubi.eir] fingers up to [rubi.eir] [rubi.lipColor] lips, licking the ");
		if (rubi.hasCock()) output("pre-cum");
		else output("juices");
		output(" off of them with a smile.  [rubi.Eir] newly cleaned fingers move to the bottle of lube sitting nearby.  After pumping a handful into [rubi.eir] palm, the rich scent of raspberries seems to fill the air, making your nostrils twitch.  Scented lube?");

		output("\n\nWith [rubi.eir] other hand, Rubi grasps the dildo and brings it up to [rubi.eir] lips, taking it in slowly.  Within seconds the small, wobbly dildo is buried deep in the demon-morph's throat, and when it emerges, it glistens with saliva.  With another handful of raspberry-scented lube, Rubi adds to the slick, goopy layer covering the fake cock and, with a little hesitation, lowers it between [rubi.eir] legs to press the spongy mushroom-like glans of the dildo against [rubi.eir] ");
		if (!rubi.hasCock()) output("slick vagina");
		else output("hungry asshole");
		output(".");

		output("\n\nRubi's lips form an O-shape as the tip of the dildo slips inside [rubi.eir] tight hole.  You slip forward on the edge of the bed, eyes drawing in the scene before you.  With this erotic display, you're not surprised to find yourself getting quite turned on as well.  Your lover's demonic tail flutters forward, slithering around the dildo while Rubi presses it in deeper, [rubi.eir] ");
		if (!rubi.hasCock()) output("cunt");
		else output("asshole");
		output(" clinging so tightly to the toy you imagine it must be like a vice.");

		output("\n\nThe sweet little creature before you moans lightly as more of the dildo's length presses inside, until [rubi.ey] finds [rubi.ey]'s bottomed out, reaching the large flared bottom of the dildo.  Rubi's soft rosy lips curl upwards in a proud smile.  [rubi.Eir] hand and tail take a renewed grip on the fake cock, and [rubi.ey] lifts [rubi.eir] hips a few inches before slamming them back down onto the dildo.");

		output("\n\nYou bite your lip and find [pc.eachCock] straining against your [pc.gear] and close your eyes for a moment, letting your imagination take over.  You imagine Rubi astride your naked body, your hands moving up [rubi.eir] own.  The sensations of thrusting inside your lover overtake you like a breath of fresh air.  Rubi's hips gyrate atop you, and you can feel a powerful urge building inside of you...");

		output("\n\nYou're brought back to reality by a sudden moan from Rubi.  Your eyes bolt open and focus on the demon-" + rubi.mf("boy","girl") + "'s slender frame, which is quivering madly.  [rubi.Eir] ");
		if (rubi.hasCock()) output("[rubi.cock] is standing at full attention, bobbing up and down as Rubi fucks [rubi.em]self on the dildo");
		if (rubi.hasCock() && rubi.hasVagina()) output(", and [rubi.eir] ");
		if (rubi.hasVagina()) output("cunt lips are glistening red with arousal, just begging for attention");
		output(".  Rubi's cries grow louder, [rubi.eir] lips parting and [rubi.eir] tongue lolling out as [rubi.ey] pants for breath.  You can tell [rubi.ey]'s building up to something, something powerful at that.");

		output("\n\n[rubi.Eir] hips spin and oscillate, working vigorously to keep [rubi.eir] ");
		if (!rubi.hasVagina()) output("backside");
		else output("fuck hole");
		output(" filled with dick, however fake it may be.  The slender, feminine demon's voice is so suffused with lustful fervor that it's virtually palpable in the warm air permeating the area.  Each near-orgasmic tone that worms its ways from [rubi.eir] throat just drips with euphoria and writhes its way into your ears, filling your body with a portion of [rubi.eir] passion.");

		output("\n\nUltimately, however, Rubi can't hold out.  [rubi.Eir] muscles contract, arms pulling in and covering [rubi.eir] chest as though [rubi.ey] were suddenly aware of the revealing nature of [rubi.eir] lingerie.  [rubi.Eir] deliciously ");
		if (!rubi.hasFur()) output("bare");
		else output("furred");
		output(" legs buckle, one jerking like mad, causing [rubi.em] to impale [rubi.em]self fully onto the imitation shaft of man meat.  Amid the chaos of spasming limbs and newfound modesty, Rubi loses [rubi.eir] breath, making small gasping noises when [rubi.ey] isn't moaning for more.");

		if (rubi.hasCock()) output("\n\nRubi's cock spasms along with [rubi.em] suddenly loosing a spray of pearly white cum into the air.  It doesn't stop with just one spurt however, instead turning [rubi.eir] crotch into some kind of lewd sprinkler, covering nearly every surface within the immediate vicinity with [rubi.eir] love juices.");
		if (rubi.hasVagina()) output("\n\nWith a clear look at Rubi's crotch, you can see [rubi.eir] pussylips contract around the artificial vaginal invader, [rubi.eir] clitoris sinking into the flesh for a moment before pushing right back out.  [rubi.Eir] little love button pulses like this several times, the next one more languid than the last.");

		output("\n\nWith [rubi.eir] orgasm subsiding, Rubi slouches back against the wall, the small human-like dildo taking this opportunity to slip about halfway out of [rubi.eir] ");
		if (!rubi.hasVagina()) output("asshole");
		else output("cunt");
		output(", seeking freedom from its sweet, fleshy prison.  A long supine sigh escapes your slender lover's mouth.  [rubi.Ey]'s clearly exhausted and happy for this rapturous release.");

		output("\n\nYou slip off the bed, moving forward to inspect the object of your voyeuristic fantasy, whose eyes are half-way closed.  [rubi.Ey] motions to the bed and whispers, \"<i>I think I need some rest after that.</i>\"  Grinning, you oblige your submissive lover and pick [rubi.em] up, letting the dildo flop completely out, and carry [rubi.em] over to the bed, placing [rubi.em] on the sheets.  Rubi murmurs [rubi.eir] appreciation, and cuddles up with a particularly fluffy pillow.");

		output("\n\nYou turn to make your way out of the room, when you see the toy chest again.  You hunch down, poking through the chest until you spot it... a glistening metal buttplug with a gemstone set in the bottom.  A sly grin creeps across your face as you retrieve the plug and sidle into the bed behind Rubi.  [rubi.Ey] hums slightly at your presence.  You run a hand along [rubi.eir] body and dip it between [rubi.eir] legs, slipping a finger inside [rubi.eir] slightly gaping ");
		if (!rubi.hasVagina()) output("ass");
		else output("pussy");
		output(".");

		output("\n\nWhen Rubi turns [rubi.eir] head around to question your actions, you smirk and slip the plug inside [rubi.em].  Rubi's eyes shut tight and [rubi.ey] stifles a moan, any question or comment forgotten.  You whisper into [rubi.eir] ");
		if (rubi.earType == GLOBAL.TYPE_HUMAN) output("ear");
		else if (rubi.earType == GLOBAL.TYPE_FELINE) output("feline ear");
		else output("feathered ear");
		output(" that [rubi.ey] should keep that in for a few hours, just to make sure this training takes hold.  Rubi gives you a small smile in response along with a small peck on the cheek before slipping under the sheets for a quick nap.");

		output("\n\nYou decide this is the best time to head out as well, and make your way out of the apartment and back to camp.");
		pc.lust(20 + pc.libido() / 5);
	}
	//Repeatable
	//Must have a cock greater than Rubi's capacity.
	//Rubi's capacity won't go larger than 100.
	else {
		output("You bring up the subject of training Rubi's ass again.  [rubi.Ey] looks up at you with a sheepish smile on [rubi.eir] face and confesses, \"<i>I was hoping you'd say that, babe.  I've actually been practicing a little bit on my own.  I... Well, I've been itching to get that bad boy you've got inside me.</i>\"");

		output("\n\nYou grin in response, and say that, with enough training maybe soon [rubi.ey] can.");

		output("\n\nRubi stands up from the couch and slowly makes [rubi.eir] way to the bedroom, giving [rubi.eir] hips and tail a sexy sashay that you're certain is an invitation.  You rise, in more ways than one, and follow quickly behind the demonic little minx.  [rubi.Ey] motions to the plush, soft bed as the two of you enter, and [rubi.ey] says, \"<i>Make yourself comfortable.  I'll go slip into something a little... less comfortable,</i>\"");

		output("\n\nWith the stupid grin still plastered across your face, you take a seat at the edge of Rubi's bed, a fluffy white monster with a lilac-colored bedspread laid across it.  You get comfortable as your demon-tailed lover disappears into the bathroom. Almost ten minutes later, [rubi.ey] reemerges, posing in the doorway.");

		output("\n\nWith one arm raised [rubi.ey] leans against the frame of the door, showing off [rubi.eir] powder blue babydoll.  The skimpy, sheer lingerie barely covers Rubi's body, and in fact leaves [rubi.eir] [rubi.chest] completely open, framed by a triangle of white lace.  The wavy hem of the babydoll drapes low, but not low enough to cover [rubi.eir] crotch.  Rubi's ");
		if (rubi.hasCock()) output("[rubi.cock]");
		else output("sweet pussy");
		output(" is readily on display, and it's all for you.  Rubi's makeup is less than subtle, with bright red lips and a light dusting of silver eyeshadow, enough to make [rubi.eir] eyes pop and not clash with the outfit.  Completing the look is a pair of white fishnet stockings that go up [rubi.eir] legs, ending about mid-thigh.");

		output("\n\nYou lick your lips hungrily.  \"<i>Oh?</i>\" Rubi asks, sauntering over to you.  The way [rubi.eir] hips sway with each step makes your heart flutter ever so slightly.  \"<i>Would you,</i>\" [rubi.ey] leans down, [rubi.eir] half-closed eyes giving [rubi.em] a sultry look.  [rubi.Eir] lips brush past your own, the briefest of contact, but nonetheless electric in its sensations. \"<i>Like a,</i>\" [rubi.ey] puckers [rubi.eir] lips as they meet with yours in a wet, steamy kiss that leaves you breathless.  \"<i>Taste?</i>\" [rubi.ey] concludes, breaking away from your mouth with a small, feminine gasp.");

		output("\n\nYou're left breathless as Rubi pulls away, giggling.  \"<i>Sorry, babe, you just look so awestruck.  I couldn't help but tease you a little.</i>\"  You laugh, then wrap your arm around [rubi.eir] waist, pulling [rubi.em] onto your lap with ease.  Your lips lock once again and Rubi just melts in your embrace.  Meeting no resistance, your tongue invades the " + rubi.mf("demon","demoness"));
		output("'s mouth, exploring every inch and entwining with Rubi's own.");

		output("\n\nWhen you break away, it's Rubi that's left breathless.  [rubi.Eir] mouth gapes slightly, and [rubi.eir] eyes remain closed for several seconds, until your light chuckling snaps [rubi.em] out of it.  Rubi's cheeks ");
		if (rubi.hasFur()) output("would be blushing bright red now, were it not for the fine layer of fur");
		else if (rubi.skinTone == "red") output("go a vivid purple");
		else output("go bright red");
		output(", and [rubi.ey] snaps back to the present.  \"<i>Eheh... I guess I deserved that.</i>\"");

		output("\n\nRubi sits upon your leg, awkwardly staring into your eyes for a minute, before [rubi.ey] seems to realize why [rubi.ey] invited you back here in the first place.  \"<i>Right, right!  I do believe it's time for a little more </i>training,\" [rubi.ey] says, putting a heavy emphasis on the word.  Rubi shimmies off your leg and retrieves the black and pink chest of toys from under the bed.  Your girly little lover pops the top on the chest and rummages through, until [rubi.eir] eyes light up.");

		output("\n\nWhat [rubi.ey] produces from the box causes your eyes to widen as well.  A twelve inch tall purple and black mottled horsecock.  But that's not the most disconcerting thing... it's the rounded area just above the base of the wobbling dildo.  Something that reminds you of a canine knot.");

		output("\n\nRubi beams as [rubi.ey] holds it up.  \"<i>This bad boy will get the job done, that's for sure!  See, it's got this little pump here,</i>\" [rubi.ey] says, holding up a small, hand-held air-pump connected to the dildo by a long tube.  \"<i>That inflates the knot by the base... which will certainly stretch me wide open for you, babe.</i>\"  Rubi giggles and places the dildo on the floor in front of you and hands you the pump with a wink.  \"<i>You take this, and just give it a pump whenever, OK?  Now let's get this tasty treat all warmed up.</i>\"");

		output("\n\n[rubi.Ey] retrieves a bottle from the chest.  It appears to be a small, sealed flagon with a picture of a smiling, and quite naked, goblin on it.  \"<i>It's a brand of lubricant I saw at the goblin market the other day, while I was out shopping for this little babydoll.  It's supposed to help with the whole \"stretching\" thing,</i>\" Rubi explains, popping the top off of the flagon.  [rubi.Ey] tips it over the rubbery dong, letting a generous amount of the carmelly liquid splash down onto the flared tip.");

		output("\n\nThe smell of peaches and alcohol fill the room, reminding you of peach schnapps, or perhaps a peach margarita.  The scent alone is almost intoxicating.  Setting the bottle of lube aside, Rubi runs [rubi.eir] well-manicured fingers along the horsecock's length, spreading the thick, fruity substance around until the entire length is coated in it.  [rubi.Ey] pours another dollop of the peach margarita-scented lube into [rubi.eir] palm, leans forward and spreads it across [rubi.eir] ");
		if (!rubi.hasVagina()) output("asshole");
		else output("pussy");
		output(", making sure to cover every inch.  You're certain you even see a few fingers press inside [rubi.eir] hole.");

		output("\n\nWith everything prepped and ready to go, Rubi stands up and hovers over the dildo.  One of [rubi.eir] lube covered hands reaches forwards, pulling you close, while the other reaches beneath [rubi.em], making sure the dildo is positioned correctly.  [rubi.Eir] lips meet yours again just as [rubi.ey] lowers [rubi.em]self down onto the rubbery horsecock.  What follows is the most passionate moan you've ever heard from Rubi, directed into your mouth.");

		output("\n\n\"<i>Mmm, oh gods,</i>\" [rubi.ey] exclaims, your lips parting from one another.  \"<i>It's so </i>big!\"  Rubi sinks down another couple inches, [rubi.eir] face somewhere between torture and ecstasy.  [rubi.Ey] backs away from you, enough so that you can see the huge, slick rod currently impaling your lover.");

		if (rubi.hasCock()) output("\n\nRubi's [rubi.cock] twitches, rising from its state of semi-hardness.  Within a minute it's standing straight up, creating a noticeable tent in the pale blue, sheer fabric covering your lover's body.  ");
		else output("\n\n");
		output("It takes another minute or so for Rubi to sink all the way down onto the cock, a huge feat in and of itself... but then, of course, there's the knot.  Even now with it deflated, you're not sure your demonic little vixen could handle it.  In fact, [rubi.ey] struggles with it for quite a while, until you lean over and whisper words of encouragement into [rubi.eir] ear.  Naughty words saying what you'll do to that ");
		if (rubi.hasCock()) output("ass");
		else output("pussy");
		output(" once it's been properly trained.");

		output("\n\nNeeding no more encouragement, Rubi pushes [rubi.em]self down further.  [rubi.Eir] eyes rolling up into their sockets in delight as [rubi.eir] ");
		if (rubi.hasCock()) output("asshole");
		else output("cunt");
		output(" is stretched nearly to its limits.  Finally [rubi.ey] lets out a sigh of relief as the knot pops completely into place.  \"<i>Oh... fuck me it's so big,</i>\" [rubi.ey] squeals, [rubi.eir] body visibly shaking.  Rubi's tongue lolls out, dripping a bit of spittle down [rubi.eir] chin.");

		output("\n\nRubi's breath grows more and more ragged as [rubi.ey] gyrates [rubi.eir] hips around on the dildo.  Breathy, primal moans escape [rubi.eir] lips.  You've never seen [rubi.em] this turned on before.  It must be something in the lube, or maybe [rubi.ey] is really just an exhibitionist, getting off by putting this show on for you.  Either way, you're not exactly complaining, especially when [rubi.eir] hands suddenly dart towards your [pc.gear] grasping madly for the prize hidden within.");

		output("\n\nNot one to disappoint, especially such an eager slut, you disrobe as quickly as you can manage, settling back into position in front of Rubi.  [pc.EachCock] bobs to attention immediately.  [rubi.Ey] wastes no time.  Leaning forward, [rubi.ey] grasps the base with one hand, while guiding the [pc.cockHead " + pc.biggestCockIndex() + "] to [rubi.eir] mouth with the other.");

		output("\n\nA warm sensation rolls over you as the demon-morph's tongue makes contact.  Soft and wet, it rolls around the tip of your cock like a wave.  A sex-starved, hungry wave.  The sensual, velvety wave is followed up by a pair of lips wrapping around your tremendous manhood, clamping down like a vice.  Rubi sucks, drawing what seems like all the blood from your body right to the tip of your dick, enhancing all the sensations assaulting your brain a hundred fold.");

		output("\n\nAs the wanton slut between your legs goes to work, you notice the small air pump for [rubi.eir] dildo laying next to you.  A devilish smile crosses your face.  With Rubi's eyes closed, [rubi.eir] head bobbing up and down on your [pc.cock " + pc.biggestCockIndex() + "], [rubi.ey] doesn't notice you take hold of it.  [rubi.Ey] does notice, however, when you give it a light squeeze.  No doubt the knot firmly lodged in [rubi.eir] ");
		if (!rubi.hasVagina()) output("anus");
		else output("cunt");
		output(" just widened slightly.  Rubi's eye go wide as [rubi.ey] looks up at you with a mouth full of cock, moaning something you can't understand.");

		output("\n\nYou wonder if [rubi.ey] wants you to pump it again.  So you do.  Rubi's mouth vibrates around your cock as [rubi.ey] moans louder, [rubi.eir] eyes beginning to roll back into [rubi.eir] head.  Another pump.  ");
		if (rubi.hasCock()) output("You can feel your lover's cock straining against your leg, aching for some release.  You idly press your foot against it, feeling a slick layer of precum coating it from top to bottom already.  ");
		output("A pleading look enters Rubi's eyes.  You hold up the pump and ask [rubi.em] if [rubi.ey] wants you to use it again.  [rubi.Ey] gives [rubi.eir] head a quick nod of assent, and reaffirms this by taking your [pc.cock " + pc.biggestCockIndex() + "] even deeper into [rubi.eir] mouth.");

		output("\n\nYou give it a quick pump, followed by a second, final one.  Rubi's [rubi.eyeColor] eyes close tight as [rubi.ey] succumbs to a brain-melting orgasm.  [rubi.Eir] entire body trembles, from [rubi.eir] curling toes right up [rubi.eir] twitching, painted fingers.");
		if (rubi.hasCock()) output("  Even, no, <i>especially</i> [rubi.eir] cock twitches and spasms jerking upwards and splattering globules of sticky white goo against the inside of Rubi's babydoll before dripping down onto the floor between [rubi.eir] legs, creating a rapidly growing puddle.");

		output("\n\nYou don't last much longer either.  Even as Rubi experiences that mind-altering climax, [rubi.ey] continues to suck and lick your large dick until you feel the warm fires of ecstasy growing in your veins.  You imagine what it will be like to finally plunge this meaty cock inside Rubi's ");
		if (!rubi.hasVagina()) output("ass");
		else output("cunt");
		output(", to make [rubi.em] squeal from your actions, and not that of a lifeless dildo.  You imagine the " + rubi.mf("demon","demoness") + "'s hot, wet walls clamped around you, milking you for everything you've got.");

		output("\n\nAnd that's enough to push you over.  You grip the soft sheets of the bed and stifle a moan of your own.  The heat in your body rises, centering around the cock you have half-buried in Rubi's throat.  You can feel the intensity building, and do your best to hold it back, but to no avail.  With a loud grunt you cum, loosing one spray of pearlescent jizz after another deep into your lover's gullet.  [rubi.Ey] gulps it all down eagerly, trying not to waste a drop.");

		output("\n\nRubi pulls [rubi.eir] head back finally, just in time for two last jets of cum to blast [rubi.em] in the face.  [rubi.Ey] just gives you a sultry smile, however, and scoops up the remaining mass of sweet semen with [rubi.eir] fingers before licking them clean.  You collapse back onto the bed, completely spent.  You hadn't expected things to go that way.  Not that you're complaining of course.");

		output("\n\nYou hear a soft popping sound, and are soon joined by Rubi on the bed.  \"<i>Mmm, I'm glad you enjoyed that, babe,</i>\" [rubi.ey] says, still licking [rubi.eir] hands clean.  \"<i>I hope we can do it again soon.</i>\"  [rubi.Ey] wraps an arm around you and begins drifting off to sleep.  [rubi.Ey] was obviously exhausted after that powerful stretching session.");

		output("\n\nYou stay with [rubi.em] for a good ten minutes before slipping out of [rubi.eir] grasp, and putting a pillow in your place, which Rubi gratefully hugs.  You turn to make your way out of the room, when you see the toy chest again.  You hunch down, poking through the chest until you spot it... a huge, black rubbery buttplug.  A sly grin creeps across your face as you retrieve the plug and sidle into the bed behind Rubi.  [rubi.Ey] hums slightly at your presence.  You run a hand along [rubi.eir] body and dip it between [rubi.eir] legs, slipping a finger inside [rubi.eir] slightly gaping ");
		if (!rubi.hasVagina()) output("ass");
		else output("pussy");
		output(".");

		output("\n\nWhen Rubi turns [rubi.eir] head around to question your actions, you smirk and slip the plug inside [rubi.em].  Rubi's eyes shut tight and [rubi.ey] stifles a moan, any question or comment forgotten.  You whisper into [rubi.eir] ");
		if (rubi.earType == GLOBAL.TYPE_HUMAN) output("ear");
		else if (rubi.earType == GLOBAL.TYPE_FELINE) output("feline ear");
		else output("feathered ear");
		output(" that [rubi.ey] should keep that in for a few hours, just to make sure this training takes hold.  Rubi gives you a small smile in response along with a small peck on the cheek before slipping under the sheets for a quick nap.");
		output("\n\nYou decide this is the best time to head out as well, and make your way out of the apartment and back to camp.");
		pc.orgasm();
	}
	
	rubi.orgasm();
	rubi.ass.bonusCapacity += 10;
	if (rubi.ass.bonusCapacity > 100) rubi.ass.bonusCapacity = 100;
	
	processTime(40 + rand(20));
	addButton(0, "Next", function():*{ processTime(10 + rand(10)); mainGameMenu(); } );
}

//Get Fucked
//PC gets fucked by Rubi
//Rubi must have at least a 5" cock
//Requires 75 Affection
private function getFuckedByRubi():void {
	//output(images.showImage("rubi-fucks-you"), false);
	clearOutput();
	rubiSprite();
	output("Rather than wait for you to initiate something, Rubi takes you by the hands and leads you into the bedroom.  [rubi.Ey] puts one arm on your shoulder and runs [rubi.eir] fingers up through the hair on the back of your head before pulling you into a deep kiss.  Rubi's [rubi.lipColor] lips feel so delicate against yours, but they quickly part as [rubi.eir] tongue slithers between them, exploring the depths of your warm, wet mouth.");

	output("\n\nRubi smiles after you break the kiss, looking at you a little sheepishly.  \"<i>I'm sorry babe, I just...  I've been wanting to do this for so long,</i>\" [rubi.ey] says, [rubi.eir] hand slipping between [rubi.eir] legs, where you notice a sizeable bulge in [rubi.eir] clothing.  [rubi.Eir] dainty hands grip your arms and [rubi.ey] pushes you backwards onto the bed, though your [pc.legs] dangle off the end.");

	output("\n\nDespite this uncharacteristic shift, [rubi.eir] movements are insistent, but not forceful.  [rubi.Eir] glittering [rubi.eyeColor] eyes constantly meet yours, looking for approval, before and after every act.  You're certain you're still the one in charge here... but you're simply letting Rubi take the lead.");

	output("\n\nThe young demon-morph hurriedly strips you out of your [pc.gear] and licks [rubi.eir] lips at the sight of your naked, prone form.  [rubi.Ey] slips down to [rubi.eir] knees and whispers, \"<i>Let's get this ");
	if (!pc.hasVagina()) output("asshole");
	else output("cunt");
	output(" of yours all ready for me.</i>\"  Rubi's head descends between your legs");
	if (pc.hasCock()) output(", ignoring your [pc.cocks] completely,");
	output(" and presses [rubi.eir] face into your [pc.vagOrAss], inhaling deeply.  [rubi.Eir] lips pucker as [rubi.ey] plants a kiss directly onto your ");
	if (!pc.hasVagina()) output("ass");
	else output("moistening pussy");
	output(".  You let out a small moan and lean backwards, taking your eyes off the [rubi.hairColor] head betwixt your thighs and taking in the sensations.");

	output("\n\nRubi wraps [rubi.eir] lips around your [pc.vagOrAss] and flicks [rubi.eir] tongue along the sensitive flesh.  You shiver and sprawl out on the bed, taking it all in.  Rubi lavishes your tight hole with [rubi.eir] lips and tongue, lapping and slurping messily, all in preparation for what is to come, no doubt.  But [rubi.ey] doesn't get ahead of [rubi.em]self, and takes [rubi.eir] time to make sure you're good and ready.  [rubi.Eir] perfectly manicured fingers trace patterns only [rubi.ey] can decipher on your inner thigh, movements so delicate and precise that your body quivers of its own accord.  [rubi.Eir] other hand slips up your stomach, inching along and teasing your flesh with the same arcane movements of [rubi.eir] fingers.");

	output("\n\nWith your crotch freshly lubricated, Rubi stands and quickly disrobes, adding to the pile of clothing on the floor.  [rubi.Eir] feminine hands run down [rubi.eir] body and grasp at the [rubi.cock] sprouting from [rubi.eir] groin, stroking it to its full length.  Its [rubi.cockHead] emerges from the foreskin surrounding it as [rubi.eir] cock strains, aching for something, anything to fill.");

	output("\n\nWith a look into your eyes, confirming [rubi.eir] desires, [rubi.ey] gives [rubi.eir] cock what it wants.  One swift motion is all it takes as Rubi sinks [rubi.eir] dick inside you several inches.  The feeling of penetration makes you moan suddenly, louder than you wanted to.  Rubi smiles, pulls out a few inches, and pushes back inside, just a little deeper.  This time it's your demonic lover's turn to moan as you clamp your [pc.vagOrAss] around [rubi.eir] invading member, tightening around [rubi.em] like a vice.");
	if (!pc.hasVagina()) pc.buttChange(rubi.cockVolume(), true, true, false);
	else pc.cuntChange(0, rubi.cockVolume(), true, true, false);

	output("\n\nRubi takes hold of one of your legs, lifting it up onto [rubi.eir] shoulder and thrusts in just a little bit deeper.  The movement is just right, rubbing your ");
	if (!pc.hasVagina()) output("prostate");
	else output("g-spot");
	output(" briefly, but enough to send a hot shiver up your spine.  Seeing this reaction, Rubi's smile widens into a grin and begins to thrust in and out at a slow pace.  Every thrust brushes past your sensitive ");
	if (!pc.hasVagina()) output("prostate");
	else output("g-spot");
	output(", and one by one your limbs start to tingle.  In and out, [rubi.ey] goes, and you can feel something building inside you.");

	output("\n\nYour arms tingle, hands gripping at the sheets in an attempt to anchor yourself.  Your [pc.legs] shiver as goose bumps rise on your flesh.  One leg spasms wildly, unwilling to follow your brain's commands in the face of this rising pleasure.  Your head spins, awash in feelings of bliss and something else... could it be love?  You bite your lip, your face contorting into a look of needful desperation.  Love for this demon-tainted " + rubi.mf("boy","girl") + ", for this person who's shared their secrets, their life with you?  Your mind grows foggy, and at this point not even you are certain of the true answer buried under all of these sensations.  The look on Rubi's face, however, is as plain as day.  Adoration pours from [rubi.em] as [rubi.ey] pounds away, fucking your [pc.vagOrAss] faster and faster with each measured, careful thrust.");

	output("\n\nSeveral things happen in quick succession.  First, your lover glances down at you with that same look [rubi.ey]'s used all day.  That questioning, submissive look, the look that just minutes ago said, \"<i>Can I fuck you?\</i>\"  Now it says, through the guise of those sparkling [rubi.eyeColor] eyes, \"<i>Can I come inside you?</i>\"");

	output("\n\nSecond, your heart skips a beat.  Third, a lump forms in your throat.  You swallow hard, attempting to rid yourself of it, but it persists.  Your stomach churns, as if butterflies were swarming around inside of it.  Fourth, without really thinking about it... you nod.  It's a short, almost imperceptible movement, but Rubi picks up on it.");

	output("\n\n[rubi.Eir] cock plunges in, putting a new, renewed pressure on your ");
	if (!pc.hasVagina()) output("prostate");
	else output("g-spot");
	output(".  Orgasmic energy suddenly bursts outwards from your crotch.  The tingling, needful sensations in your limbs explode in turn, showering your nerves with cool euphoria.  It washes over you like a tidal wave, causing your body to tense, your back arching and limbs jerking violently.  Your mouth parts and you can't help but scream, \"<i>Yes, yes!</i>\" repeatedly, not caring who could possibly hear you.  Rubi gives one last thrust, causing another miniature orgasm to rock across you, and giving you the acute sensation of being filled, as [rubi.eir] body joins yours in its sex rapture.");

	output("\n\nRubi's [rubi.cock] surges inside you, releasing one jet after another of warm, sticky jism into your needy ");
	if (!pc.hasVagina()) output("bowels");
	else output("womb");
	output(".  ");

	//(Blueballs 4-6)
	if (int(flags["COC.RUBI_BLU_BALLS"]) < 4) {}
	else if (int(flags["COC.RUBI_BLU_BALLS"]) <= 6) {
		output("There's so much of it that it oozes out from your abused ");
		if (!pc.hasVagina()) output("ass");
		else output("cunt");
		output(", dribbling down your buttcheeks and pooling onto the bed and floor below.  ");
	}
	//(Blueballs 6-9)
	else if (int(flags["COC.RUBI_BLU_BALLS"]) <= 9) {
		output("Your insides rumble suddenly as Rubi's impressive load begins to fill you up, [rubi.eir] seed slipping into every available nook and cranny.  What doesn't fit slips out of your abused ");
		if (!pc.hasVagina()) output("ass");
		else output("cunt");
		output(" in a small torrent, pooling onto the bed and floor below.  ");
	}
	//(Blueballs 10)
	else output("Your insides rumble dangerously and your stomach actually swells up, gaining a noticeable paunch as Rubi's lavish load coats your insides, filling every available nook and cranny and even creating new ones.  What doesn't fit slips out of your abused hole in a flood, coating the bed and floor beneath you in a slick, white glaze.  ");
	
	output("Rubi doesn't stop there, however; [rubi.ey] continues to assail your [pc.vagOrAss], bringing you to several more miniature, body-shaking orgasms, until [rubi.ey] just can't handle any more, and [rubi.ey] pulls out, [rubi.eir] cock still rather erect and looking cozy in its jacket-like foreskin.");

	output("\n\nYou waggle a finger at [rubi.em] hazily, and [rubi.ey] climbs up onto the bed next to you.  You wrap your arms around [rubi.em] and kiss [rubi.em] passionately before pulling [rubi.em] into a cuddling hug.  The two of you drift off into a short nap, contentedly wrapped up in each other's arms.");
	processTime(60 + rand(20));
	pc.orgasm();
	rubi.orgasm();
	if (!pc.hasVagina()) pc.loadInAss(rubi);
	else pc.loadInCunt(rubi);
	//dynStats("sen", 2);
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Hotdogging
//PC hotdogs Rubi's ass
//PC must have a penis
//If Rubi is being teased, adds +1 to blueballs
//-100 arousal for PC
private function rubiHotdogging():void {
	//output(images.showImage("rubi-hotdogged"), false);
	clearOutput();
	rubiSprite();
	output("You sit on the couch next to your sexy lover and pull [rubi.em] onto your lap with one smooth motion.  Rubi giggles, wiggling in place for a moment before leaning down to kiss you on the lips.  You put one hand on [rubi.eir] supple ass, and another on [rubi.eir] back between [rubi.eir] shoulders and pull [rubi.em] close, pressing your [tongue] into [rubi.eir] mouth.  You sensually explore your partner's mouth as [rubi.ey] closes [rubi.eir] eyes and moans.");
	output("\n\nThe two of you break the kiss long enough to gasp for breath, and go at it once more.  In your lip-locked escapade you blindly grasp at Rubi's clothing, stripping [rubi.em] down, layer by layer until the ");
	if (rubi.hasFur()) output("fur-covered");
	else output("[rubi.skinTone] skinned");
	output(" " + rubi.mf("boy","girl") + " lays naked on your lap.  Rubi giggles and dips a hand between [rubi.eir] thighs ");
	if (rubi.hasCock()) output("taking hold of [rubi.eir] cock");
	else output("rubbing a finger along [rubi.eir] clit");
	output(" while [rubi.ey] says, \"<i>So babe, what do you intend to do?  Are you going to hold me down and ravish me?  What will it be?</i>\"");

	output("\n\nRubi wiggles [rubi.eir] hips, eagerly awaiting your reply while your lips curl into a smirk.  Well, [rubi.ey]'s sure getting antsy, isn't [rubi.ey]?");

	output("\n\nRubi responds with a giggle and a nod of [rubi.eir] head.  \"<i>Oh yes, I'm positively </i>aching<i> for you, babe,</i>\" [rubi.ey] says, slipping off your lap and onto [rubi.eir] knees at your feet.");

	output("\n\nYou grunt in approval at this show of submission and lean back on the couch, stretching your arms wide along the back.  You tell the little minx at your feet to get you ready first, before [rubi.ey] gets [rubi.eir] needs met.  [rubi.Eir] ruby red lips morph into a grin, and [rubi.ey] wastes no time in freeing your [pc.cock " + pc.biggestCockIndex() + "] from its trappings.  Rubi smacks [rubi.eir] lips and descends upon your half-hard cock, planting a kiss on its tip, and down each and every inch.");

	output("\n\nYou sigh happily and sink deeper into the soft cushions of the couch, exulting as the fiery slut betwixt your legs goes to work.  [rubi.Eir] lips pucker around the outside of your shaft, leaving a hazy reddish smudge of lipstick behind.  It isn't long until more such blotches join it, creating a \"crown\" of lipstick marks wreathing your [pc.cockHead " + pc.biggestCockIndex() + "].  Your [pc.cock " + pc.biggestCockIndex() + "] throbs almost painfully, oozing precum from its cumslit, which Rubi eagerly laps at, letting it roll over [rubi.eir] tongue and then down [rubi.eir] throat.");

	output("\n\nAs content as you are to just sit back and wait until you pop in Rubi's mouth, you've got other, more devilish plans.  You wave [rubi.em] off and stand up.  The little demon " + rubi.mf("boy","girl") + " looks a little disappointed at first, but the prospect of something more causes [rubi.em] to smile up at you expectantly.  You have Rubi climb up onto the couch and kneel with [rubi.eir] back to you.");

	output("\n\n[rubi.Ey] shudders as you run a hand down [rubi.eir] back, down [rubi.eir] spine and lightly circling the base of [rubi.eir] tail.  You run the tip of your fingers along [rubi.eir] sides, just barely touching [rubi.eir] soft, ");
	if (!rubi.hasFur()) output("tender skin");
	else output("silky fur");
	output(".  Rubi's back arches and a soft gasp escapes [rubi.eir] lips.  [rubi.Eir] body reflexively jerks towards your hand, hoping for more than a simple teasing touch, but you pull your hand away and give [rubi.eir] round ass a playful smack, chastising [rubi.em].");

	output("\n\n\"<i>S-Sorry, babe,</i>\" [rubi.ey] says, [rubi.eir] voice shaky, \"<i>It's just that it feels so good, I can't help myself.</i>\"  You forgive [rubi.em] easily, but say that if [rubi.ey] wants to cum at the end of all this, [rubi.ey]'s going to have to remain still and follow your every command.  Rubi swallows hard, but nods happily,  \"<i>Ooh, really taking charge, hm?  Do your worst, babe.</i>\"  You shoot [rubi.em] back a malevolent grin and assure [rubi.em] that you will.");

	output("\n\nYour fingers return to the spellbound demon before you, tantalizing [rubi.eir] flesh with the slightest of touches.  It does its job, as between [rubi.eir] legs you can see [rubi.eir] ");
	if (rubi.hasVagina()) output("cunt moistening");
	if (rubi.hasVagina() && rubi.hasCock()) output(" and ");
	if (rubi.hasCock()) output("cock hardening");
	output(".  [rubi.Ey] obviously enjoys this light, playful teasing.  You give Rubi's ass another playful smack, watching [rubi.eir] ");
	if (rubi.hasFur()) output("fur-covered flesh");
	else output("[rubi.skinTone] skin");
	output(" jiggle with a smile.");

	output("\n\nThe teasing doesn't end there, however.  You grasp your lipstick-smudged cock, which hasn't softened one bit, and slip it between Rubi's ass cheeks, eliciting a soft, feminine \"<i>oooh</i>\" from your partner.  You rub the head of your [pc.cock " + pc.biggestCockIndex() + "] up and down Rubi's sensuous backdoor, smearing it with your pre-cum, but don't penetrate at all.  Instead, you grab hold of Rubi's buns and squeeze them together, pressing them against your shaft.  You give a light grunt, relishing the feeling of [rubi.eir] silky [rubi.skinFurScalesNoun] against your manhood as you slowly begin to pump in and out of Rubi's ass cheeks.");

	output("\n\nRubi, for [rubi.eir] part, groans in frustration at this ultimate tease, but, continuing to follow your instructions, remains stock-still as you plow away at [rubi.eir] plump booty.  As you grunt with every thrust, you start to notice Rubi's arms and legs trembling, and hushed sighs escape from [rubi.eir] lips as well.  This must really be turning [rubi.em] on!  Without breaking your rhythm, you reach down between [rubi.eir] legs, and slip your thumb into [rubi.eir] ");
	if (!rubi.hasVagina()) output("asshole");
	else output("pussy");
	output(", while your index and middle fingers rub slowly around [rubi.eir] ");
	if (rubi.hasVagina()) output("clit");
	else output("perineum");
	output(".");

	output("\n\nYou think to yourself.  You could keep teasing [rubi.em] like this, without letting [rubi.em] cum, as [rubi.ey] obviously delights in the feelings.  Or you could be generous and let [rubi.em] pop [rubi.eir] load right now... Which will it be?");
	processTime(15);
	pc.lust(pc.lustMax(), true);
	clearMenu();
	//[Tease] [Pop]
	addButton(0,"Tease Rubi",teaseButtjobs);
	addButton(1,"Pop",popButtjobs);
}

//Tease
private function teaseButtjobs():void {
	//output(images.showImage("rubi-tease-buttjob"), false);
	clearOutput();
	rubiSprite();
	output("Grinning to yourself, you decide to tease the little demon " + rubi.mf("boy","girl") + " a little further.  You plunge your thumb further into [rubi.eir] ");
	if (!rubi.hasVagina()) output("ass");
	else output("pussy");
	output(", finding [rubi.eir] ");
	if (!rubi.hasVagina()) output("prostate");
	else output("g-spot");
	output(" and rubbing circles around it, drawing out a long moan from Rubi's smeared lips.  With every thrust into Rubi's soft ass-pillows you draw another loop around [rubi.eir] most sensitive spot with your digit, until you can feel [rubi.eir] body start to tense up.");

	output("\n\nAs familiar you are with your lover's body, you can tell when [rubi.ey]'s about to climax, and you wait for that perfect moment, where [rubi.eir] body is at its tensest, [rubi.eir] back arched, toes curled, mouth pulled into that perfect O-shape with [rubi.eir] cock-sucking lips quivering, teetering that edge of orgasm.  And, just like that, you withdraw your thumb and smack [rubi.eir] ass, a little harder than you have before.  [rubi.Eir] body tenses further, and [rubi.ey] bites [rubi.eir] lip, but there's no relief, no blissful release that [rubi.ey] so desired.  You chastise the slutty little doll before you, saying that the only way [rubi.ey]'s going to cum is when you allow it.  Rubi whines slightly, looking back at you with sad, lustful eyes, but [rubi.ey] nods understandingly.");

	output("\n\nYou feel your orgasm coming on, fueled by Rubi's display of submission.  No matter how you tease [rubi.em], [rubi.ey] remains stock-still, with only a shudder and a longing sigh to mark the pleasurable feelings no doubt coursing through [rubi.eir] body.  You grip one buttcheek hard and thrust upwards as much as you can as a dam suddenly breaks within you.  Your [pc.balls] churns pleasurably, your [pc.cock " + pc.biggestCockIndex() + "] stiffens suddenly, and you let loose a long, drawn-out sigh as your dick erupts, jetting cum upwards, which immediately splatters against Rubi's tail and back before dripping down [rubi.eir] bountiful asscheeks.");

	output("\n\nYou immediately spin Rubi around, and [rubi.ey], getting the idea, wraps [rubi.eir] already cock-smeared lips around the [pc.cockHead " + pc.biggestCockIndex() + "] as your cock spasms wildly, loosing spray after spray of [pc.cumFlavor] jism into Rubi's waiting mouth.  [rubi.Ey] gulps it all down ");
	if (pc.cumQ() <= 50) output("in one go, with a small, proud look on [rubi.eir] face");
	else if (pc.cumQ() <= 150) output("with one, throat-straining swallow, a small, proud smile taking [rubi.eir] face when [rubi.ey] stops panting for breath");
	else output("as it comes, mouthful after mouthful of cum practically injected straight into [rubi.eir] stomach. There's so much of it, [rubi.ey] can't help but smile mid-way through, proud to take such a huge load");
	if (pc.cumQ() >= 1000) output(".  After guzzling down so much, you're certain Rubi's actually sporting a bit of a belly now, almost as if [rubi.ey] were several months pregnant");
	output(".");

	output("\n\nFinally, with one final spurt of cum that lands on your lover's face, you slip sideways onto the comfortable couch, completely spent.  Rubi, however, seems to have plenty of energy left, and spends the next few minutes dutifully licking over your [pc.cock " + pc.biggestCockIndex() + "], cleaning it of your juices until it sits, shiny and pristine, in your lap.");

	output("\n\nYou laugh and give the demon-" + rubi.mf("boy","girl") + " a kiss, remarking how lucky you are to be with [rubi.em].");

	output("\n\n\"<i>No, babe, I'm lucky to have found you,</i>\" [rubi.ey] says, snuggling [rubi.eir] naked body up against yours as the two of you drift off into a lazy, sex-induced nap.");
	processTime(15);
	rubi.tease();
	pc.orgasm();
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Pop
private function popButtjobs():void {
	//output(images.showImage("rubi-pop-buttjob"), false);
	clearOutput();
	rubiSprite();
	output("No, you figure Rubi has been so great lately [rubi.ey] definitely deserves to cum.  You plunge your thumb further into [rubi.eir] ");
	if (!rubi.hasVagina()) output("ass");
	else output("pussy");
	output(", finding [rubi.eir] ");
	if (!rubi.hasVagina()) output("prostate");
	else output("g-spot");
	output(" and rubbing circles around it, drawing out a long moan from Rubi's smeared lips.  With every thrust into Rubi's soft ass-pillows you draw another loop around [rubi.eir] most sensitive spot with your digit, until you can feel [rubi.eir] body start to tense up.");

	output("\n\nAs familiar you are with your lover's body, you can tell when [rubi.ey]'s about to climax, and you wait for that perfect moment, where [rubi.eir] body is at its tensest, [rubi.eir] back arched, toes curled, mouth pulled into that perfect O-shape with [rubi.eir] cock-sucking lips quivering, teetering that edge of orgasm.  At just the right moment, you press down hard on that most tender of points, pushing [rubi.em] over the edge, hard.  Rubi cries out, a high, feminine shout before biting [rubi.eir] lip.");

	output("\n\nRubi's ");
	if (rubi.hasVagina()) output("cunt clamps down on your thumb and gushes, coating your hand in [rubi.eir] slick juices");
	else output("asshole quivers and attempts to suck in more of your thumb before clamping down, leaking slick fluids all over your hand");
	output(".  [rubi.Eir] entire body spasms as the climax wracks it, one sexy leg suddenly jerking back and forth uncontrollably.  Rubi grips at a pillow, biting it and stifling another orgasmic moan.");
	//(If Rubi has Penis)
	if (rubi.hasCock()) output("  Beneath [rubi.em], [rubi.eir] cock jerks and twitches, loosing a spray of pearly white cum which splatters against the couch below");
	if (int(flags["COC.RUBI_BLU_BALLS"]) < 4) {}
	//((blueballs 4-5)
	else if (int(flags["COC.RUBI_BLU_BALLS"]) <= 5) output(" which is quickly followed by another, more powerful stream of cum, which splashes against [rubi.eir] stomach, coating [rubi.eir] [rubi.chest] in semen");
	else if (int(flags["COC.RUBI_BLU_BALLS"]) <= 7) output(" which is quickly followed by another, more powerful stream of cum, and a third, and a fourth.  Before you know it, Rubi's entire torso, including [rubi.eir] [rubi.chest] are practically glazed with cum");
	else if (int(flags["COC.RUBI_BLU_BALLS"]) <= 9) output(" which is followed up by several more, each seemingly more poweful than the one previous.  Rubi's body twitches and shudders with every jet, until [rubi.eir] entire torso, and the couch, is covered in the musky jizz");
	else output(" which is followed by a dozen more, each one thicker and more powerful than the last.  Rubi's cock twitches uncontrollably, just like [rubi.eir] body, as it coats the entire couch, [rubi.eir] entire upper body, and even some of the wall five feet away in the musky stuff");
	output(".");

	output("\n\nYou feel your orgasm coming on, fueled by Rubi's own intense-looking one.  [rubi.Eir] body lays face down on the couch, ass high into the air as you rub your cock between [rubi.eir] supple ass.  Small aftershocks of bliss ripple through [rubi.eir] body as you grip one buttcheek hard and thrust upwards as much as you can as a dam suddenly breaks within you.  Your [pc.balls] ");
	if (pc.balls > 1) output("churn");
	else output("churns");
	output(" pleasurably, your [pc.cock " + pc.biggestCockIndex() + "] stiffens suddenly, and you let loose a long, drawn-out sigh as your dick erupts, jetting cum upwards, which immediately splatters against Rubi's tail and back before dripping down [rubi.eir] bountiful asscheeks.");

	output("\n\nYou immediately spin Rubi around, and though [rubi.ey]'s still recovering from [rubi.eir] own mind-wracking orgasm, [rubi.ey] seems to get the idea, and wraps [rubi.eir] already cock-smeared lips around the [pc.cockHead " + pc.biggestCockIndex() + "] as your cock spasms wildly, loosing spray after spray of sweet jism into Rubi's waiting mouth.  [rubi.Ey] gulps it all down ");
	if (pc.cumQ() <= 50) output("in one go, with a small, proud look on [rubi.eir] face");
	else if (pc.cumQ() <= 150) output("with one, throat-straining swallow, a small, proud smile taking [rubi.eir] face when [rubi.ey] stops panting for breath");
	else output("as it comes, mouthful after mouthful of cum practically injected straight into [rubi.eir] stomach. There's so much of it, [rubi.ey] can't help but smile mid-way through, proud to take such a huge load");
	if (pc.cumQ() >= 1000) output(".  After guzzling down so much, you're certain Rubi's actually sporting a bit of a belly now, almost as if [rubi.ey] were several months pregnant");
	output(".");

	output("\n\nFinally, with one final spurt of cum that lands on your lover's face, you slip sideways onto the comfortable couch, completely spent.  Rubi, however, seems to have plenty of energy left, and spends the next few minutes dutifully licking over your [pc.cock " + pc.biggestCockIndex() + "], cleaning it of your juices until it sits, shiny and pristine, in your lap.");

	output("You laugh and give the demon-" + rubi.mf("boy","girl") + " a kiss, remarking how lucky you are to be with [rubi.em].");

	output("\n\n\"<i>No, babe, I'm lucky to have found you,</i>\" [rubi.ey] says, snuggling [rubi.eir] naked body up against yours as the two of you drift off into a lazy, sex-induced nap.");
	pc.orgasm();
	rubi.orgasm(); //Since he just came so he should be cured of blue balls
	processTime(20);
	rubi.tease();
	pc.orgasm();
	addNextButton(function():*{ processTime(10 + rand(10)); mainGameMenu(); });
}

//Give Item
//(Can give him Purified Succubus Milk, grows boobs, shrinks penis.)
//(Can give him Purified Incubus Draft, shrinks boobs, grows penis.)
//(Can give him Gro+ to grow either one.)
private function giveRubiATFItem(itype:Class):void {
	clearOutput();
	rubiSprite();
	//First Time Giving a TF Item
	if (int(flags["COC.RUBI_TIMES_GIVEN_AN_ITEM"]) == 0) {
		output("Rubi looks at the offered item, curiously.  [rubi.Ey] turns it over in [rubi.eir] hands, carefully examining the liquid within.  Finally [rubi.ey] asks apprehensively, \"<i>Is this going to... change my body?</i>\"");
		output("\n\nYou nod slowly, explaining its effects to the young demon-morph.  Rubi absently bobs [rubi.eir] head along as you explain its effects.  \"<i>So, you want me to change?</i>\" [rubi.ey] says when you're done.  \"<i>I mean... I'm fine the way I am, but if you want me to change...</i>\"  Rubi looks up at you, with love shining in [rubi.eir] eyes.  \"<i>If you want me to change I'll gladly do it.</i>\"\n\n");
	}
	IncrementFlag("COC.RUBI_TIMES_GIVEN_AN_ITEM");
	//[go to TF scene]
	//Succubus Milk
	if (itype == CoCSucMilk || itype == CoCSucMilkPure) {
		if (itype == CoCSucMilk) {
			//Increase bust size by 1.
			//Decrease penis size by 1.
			//Random chance to give vagina (will always give it if Rubi has no penis or penis is just removed).
			//Random chance to give demonic high heels.
			//Random chance to give horns.
			//Random chance to give red skin.
			output("You hand over the bottle of milky white fluids to Rubi.  [rubi.Ey] takes a moment to read over the pink label before pulling out the cork and downing the whole bottle in one gulp.");
		}
		else {
			//Purified Succubus Milk
			//Increase bust size by 1. (See Succubus Milk)
			//Decrease penis size by 1. (See Succubus Milk)
			//Random chance to give vagina (will always give it if Rubi has no penis or penis is just removed). (See Succubus Milk)
			output("You hand over the bottle of purified milky white fluids to Rubi.  [rubi.Ey] takes a moment to read over the pink label before pulling out the cork and downing the whole bottle in one gulp.");
		}
		//(If Bust size increases)
		if (rubi.breastRows[0].breastRating() < 7) {
			output("\n\nRubi gasps a little and [rubi.eir] hands immediately dart to [rubi.eir] chest.  Before your eyes, Rubi's breasts begin to swell, growing an entire cup size.  Rubi cups [rubi.eir] breasts experimentally, getting used to their new weight.");
			rubi.breastRows[0].breastRatingRaw++;
		}
		//(If Penis size decreases)
		if (rubi.cocks[0].cLength() > 4) {
			output("\n\nRubi's [rubi.cock] swells up suddenly, growing painfully hard.  [rubi.Ey] grasps it and moans suddenly as it begins to dwindle in size, shrinking down by at least an inch, leaving [rubi.em] with a ");
			rubi.cocks[0].cLength(-1);
			if (rubi.cocks[0].cLengthRaw < 4) rubi.cocks[0].cLengthRaw = 4;
			output(Math.round(rubi.cocks[0].cLengthRaw * 10) / 10 + "-inch penis.");
		}
		//(If Penis is removed)
		else if (rubi.cocks[0].cLengthRaw <= 4 && rubi.hasCock()) {
			output("\n\nRubi's cock swells up slightly, its inch-long hardness reminding you of a large clitoris at this point.  However, it doesn't remain for long.  The inch-long dick begins to dwindle away, retracting into the demon-morph's groin until it shrivels into nothingness.  Rubi's hand dives between [rubi.eir] thighs, grasping for [rubi.eir] lost manhood, but to no avail.");
			rubi.removeCocks();
		}
		//(If Rubi randomly gets vagina)
		//if Penis is removed AND no vagina exists; add
		if ((rand(3) == 0 || !rubi.hasCock()) && !rubi.hasVagina()) {
			output("\n\nRubi shudders suddenly, a soft moan escaping [rubi.eir] lips.  [rubi.Eir] fingers dive between [rubi.eir] thighs, seemingly going inside [rubi.eir] body!  Although it seems strange, you're certain that <b>Rubi has grown a brand new vagina</b>.  \"<i>Oooh,</i>\" Rubi says, [rubi.eir] body quivering.  \"<i>It's so sensitive!</i>\"");
			rubi.createVagina();
			rubi.removeStatusEffect("Force Male Gender");
		}
		//(If Rubi gets demonic heels)
		if (!rubi.hasLegFlag(GLOBAL.FLAG_HEELS) && rand(3) == 0 && itype == CoCSucMilk) {
			output("\n\nRubi suddenly hops from foot to foot, breathing in sharply.  \"<i>Ow, ow, ow!</i>\" [rubi.ey] exclaims, dropping down onto [rubi.eir] naked butt.  [rubi.Ey] lifts one foot gingerly, inspecting the heel and sole.  Rubi rocks back and forth, craddling [rubi.eir] foot as a pronounced bulge appears on the heel.  Soon, it splits as a sharp black horn grows out, pointing downwards.  After a minute of this, Rubi suddenly sighs with relief as the painful growth seems to subside.  [rubi.Ey] gets to [rubi.eir] feet, the horn making [rubi.em] stand and walk as if [rubi.ey] were wearing high heels.");
			rubi.addLegFlag(GLOBAL.FLAG_HEELS);
		}
		//(If Rubi gets horns)
		if (rand(3) == 0 && !rubi.hasHorns() && itype == CoCSucMilk) {
			output("\n\nRubi's hands suddenly dart up, clutching [rubi.eir] head as though [rubi.ey] has a massive headache.  [rubi.Ey] feels around blindly, trying to locate the source of the pain, and then you see it.  Two small bulges appear on [rubi.eir] forehead, just at the hairline.  They grow larger and larger until the skin splits cleanly open revealing shiny black bone.  Horns.  They grow up and backwards, forming light ridges.  They don't quite grow completely past [rubi.eir] head, however, before the growth stops.  Rubi calms and stands.  [rubi.Eir] hands roam over every inch of [rubi.eir] new addition as glances in the mirror, marveling at [rubi.eir] demonic appearance.");
			rubi.horns = 2;
			rubi.hornType = GLOBAL.TYPE_DEMONIC;
			rubi.hornLength = 6;
		}
		//(If Rubi gets red skin)
		if (rand(3) == 0 && (rubi.skinTone != "red" || rubi.hasFur()) && itype == CoCSucMilk) {
			output("\n\nRubi clutches [rubi.eir] stomach suddenly as you notice red spots appearing on [rubi.eir] ");
			if (!rubi.hasFur()) output("skin");
			else output("coat of fur");
			output(".  The blotches soon spread, rapidly overtaking [rubi.eir] body.  ");
			if (rubi.hasFur()) output("Meanwhile the silky soft fur that covered [rubi.eir] body seems to be falling out as this red menace takes over.  ");
			output("In no time at all, [rubi.eir] smooth, hairless skin now appears to be a deep crimson, matching the color of [rubi.eir] spade tail that [rubi.ey] received long ago.");
			rubi.skinType = GLOBAL.TYPE_HUMAN;
			rubi.skinTone = "red";
		}
	}
	else if (itype == CoCIncubiD || itype == CoCIncubiDPure) {
		//Incubus Draft
		//Decrease bust size by 1.
		//Increase penis size by 1 (will grow a 5" penis if none exists).
		//Random chance to remove vagina.
		//Random chance to give demonic high heels. (See Succubus Milk)
		//Random chance to give large horns. (See Succubus Milk)
		//Random chance to give red skin. (See Succubus Milk)
		if (itype == CoCIncubiD) output("You hand over the bottle of milky white fluids to Rubi.  [rubi.Ey] takes a moment to read over the label before pulling out the cork and downing the whole bottle in one gulp.");
		//Purified Incubus Draft
		//Decrease bust size by 1. (See Incubus Draft)
		//Increase penis size by 1 (will grow a penis if none exists). (See Incubus Draft)
		//Random chance to remove vagina. (See Incubus Draft)
		else output("You hand over the bottle of purified milky white fluids to Rubi.  [rubi.Ey] takes a moment to read over the pink label before pulling out the cork and downing the whole bottle in one gulp.");

		//(If Bust size decreases)
		if (rubi.breastRows[0].breastRating() > 0) {
			output("\n\nRubi gasps a little and [rubi.eir] hands immediately dart to [rubi.eir] chest.  Before your eyes, Rubi's breasts begin to dwindle, shrinking down an entire cup size.  Rubi cups [rubi.eir] breasts experimentally, getting used to their new, reduced, weight.");
			rubi.breastRows[0].breastRating( -1);
		}
		//(If Penis size increases)
		if (rubi.hasCock() && ((rubi.cocks[0].cLengthRaw < 12 || (rubi.cocks[0].cType == GLOBAL.TYPE_EQUINE && rubi.cocks[0].cLengthRaw < 20)) ) )
		{
			output("\n\nRubi's [rubi.cock] swells up suddenly, growing painfully hard.  [rubi.Ey] grasps it and moans suddenly as it begins to pulse, growing larger with every throb, increasing in size by at least an inch, leaving [rubi.em] with a ");
			rubi.cocks[0].cLength(1);
			output(Math.round(rubi.cocks[0].cLengthRaw * 10) / 10 + "-inch penis.");
		}
		//(If Rubi has no penis; instead)
		else if (!rubi.hasCock()){
			output("\n\nRubi gasps and [rubi.eir] hands dart between [rubi.eir] legs, grasping frantically for something.  Between [rubi.eir] fingers you spot it, a fleshy ");
			if (rubi.skinTone == "red") output("red");
			else output("pink");
			output(" protrusion... a brand new cock!  Rubi shudders, [rubi.eir] delicate little fingers wrapped around the new, five-inch cock.");
			rubi.createCock(5);
		}
		//(If Vagina removed)
		if (rubi.hasVagina() && rand(3) == 0) {
			output("\n\nRubi trembles, [rubi.eir] hand dipping between [rubi.eir] thighs, searching around for something.  [rubi.Ey] pokes around madly, apparently finding nothing.  \"<i>It... It's gone!</i>\" [rubi.ey] says with a shaky voice.  \"<i>My vagina's gone!</i>\"");
			rubi.removeVagina();
			rubi.createStatusEffect("Force Male Gender");
		}
		//(If Rubi gets red skin)
		if (rand(3) == 0 && (rubi.skinTone != "red" || rubi.hasFur()) && itype == CoCIncubiD) {
			output("\n\nRubi clutches [rubi.eir] stomach suddenly as you notice red spots appearing on [rubi.eir] ");
			if (!rubi.hasFur()) output("skin");
			else output("coat of fur");
			output(".  The blotches soon spread, rapidly overtaking [rubi.eir] body.  ");
			if (rubi.hasFur()) output("Meanwhile the silky soft fur that covered [rubi.eir] body seems to be falling out as this red menace takes over.  ");
			output("In no time at all, [rubi.eir] smooth, hairless skin now appears to be a deep crimson, matching the color of [rubi.eir] spade tail that [rubi.ey] received long ago.");
			rubi.skinType = GLOBAL.TYPE_HUMAN;
			rubi.skinTone = "red";
		}
		//(If Rubi gets horns)
		if (rand(3) == 0 && !rubi.hasHorns() && itype == CoCIncubiD) {
			output("\n\nRubi's hands suddenly dart up, clutching [rubi.eir] head as though [rubi.ey] has a massive headache.  [rubi.Ey] feels around blindly, trying to locate the source of the pain, and then you see it.  Two small bulges appear on [rubi.eir] forehead, just at the hairline.  They grow larger and larger until the skin splits cleanly open revealing shiny black bone.  Horns.  They grow up and backwards, forming light ridges.  They don't quite grow completely past [rubi.eir] head, however, before the growth stops.  Rubi calms and stands.  [rubi.Eir] hands roam over every inch of [rubi.eir] new addition as glances in the mirror, marveling at [rubi.eir] demonic appearance.");
			rubi.horns = 2;
			rubi.hornType = GLOBAL.TYPE_DEMONIC;
			rubi.hornLength = 6;
		}
	}
	//Gro+
	//Can choose Boobs or Penis. Grow that body part by 2.
	else if (itype == CoCGroPlus) {
		output("\n\nWhere would you like to inject the Gro+?");
		//[Breasts] [Penis (if present)] [Back]
		clearMenu();
		addButton(0,"Breast",rubiGrowPlusBreasts);
		addButton(1,"Penis",rubiPenisGroPlus);
		addButton(4,"Back",pickAnItemToFeedRubi);
		return;
	}
	else if (itype == CoCReducto) {
		//Reducto
		//Can choose Penis or Boobs. Reduces that body part by 1. (Won't reduce below E-cup (5) if Rubi has bimbo body)
		//Won't remove penises.
		//Can't give it to him if breasts/penis already at minimum.
		output("\n\nWhere would you like Rubi to use the reducto?");
		//[Breasts] [Penis (if present)] [Back]
		clearMenu();
		addButton(0,"Breasts",rubiBoobsReducto);
		addButton(1,"Penis",rubiPenisReducto);
		addButton(4,"Back",pickAnItemToFeedRubi);
		return;
	}
	//Bimbo Liqueur (Modified for variant genders)
	else if (itype == CoCBimboLiqueur) {
		output("You hold out the bottle of Bimbo Liqueur.  Rubi takes it, and looks it over tentatively.  \"<i>Bimbo... liqueur?</i>\" [rubi.ey] asks, quirking an eyebrow at you.  \"<i>But what does this do?  There's a huge warning label right here.  Effects are permanent, strong...</i>\" [rubi.eir] voice drifts off as [rubi.ey] reads.");
		output("\n\nYou explain that this liqueur will give [rubi.em] the fresh start [rubi.ey] so desired when [rubi.ey] came to Tel'Adre.  That before [rubi.ey] was simply wearing a mask, now [rubi.ey] can become the mask.  [rubi.Ey] nods along with you, but still frowns.");
		output("\n\n\"<i>Are you sure?  I'm fine with my body how it is... but if you want me to change, I'll do it,</i>\" [rubi.ey] says, clutching the bottle tight, suddenly looking very serious.");
		output("\n\nYou nod, and tell [rubi.em] this is exactly what you want.");
		output("\n\n\"<i>If it's what you want, then it's what I want, babe.</i>\" [rubi.Ey] takes a deep breath, opens the bottle and closes [rubi.eir] eyes.  In one swift motion, [rubi.ey] puts the bottle to [rubi.eir] lips and downs its contents.");
		output("\n\nIt takes a moment for the effects to hit, but once they do, they come in rapid succession.  Rubi doubles over, clutching [rubi.eir] stomach in pain.  [rubi.Ey] looks down, [rubi.eir] eyes as wide as they can be, to see the changes first hand.  Bones crack, shift, and wobble as Rubi's waist shrinks and [rubi.eir] hips grow outwards.  [rubi.Eir] entire body seems to shrink before your eyes, growing more slender.  [rubi.Eir] " + rubi.hairDescript(true) + " hair suddenly bursts outwards, long platinum blonde locks flow past [rubi.eir] shoulders like a waterfall.  [rubi.Eir] already dainty hands grow more feminine, as do [rubi.eir] feet.");
		rubi.hairLength = 24;
		rubi.femininity = 100;
		
		//(If Rubi has a Penis)
		if (rubi.hasCock()) {
			output("\n\nWith a wide eyed moment of trepidation, Rubi clutches at [rubi.eir] crotch, [rubi.eir] hands slipping between [rubi.eir] thighs as [rubi.eir] dick shrivels away, leaving Rubi with ");
			if (rubi.hasVagina()) output("[rubi.eir] vagina");
			else output("a pristine new vagina");
			output(".  It's pretty clear, this former male is now completely female.  Rubi collapses backwards onto the couch, the transformations seemingly done.");
			rubi.removeCocks();
			if (!rubi.hasVagina()) rubi.createVagina();
			rubi.removeStatusEffect("Force Male Gender");
		}
		output("\n\n\"<i>Like, oh.  My.  Gods.  That was so wild,</i>\" [rubi.ey] says, and suddenly grips [rubi.eir] throat.  \"<i>Whoa, like, my voice is different!</i>\"  Though [rubi.ey] had a very feminine voice to begin with, it is noticeably more girly.  Not high pitched, just... girly, and tinged with a hint of a ditzy accent.");

		//(if boobs <E)
		if (rubi.breastRows[0].breastRating() < 7) {
			output("\n\n[rubi.Ey] looks down at [rubi.eir] chest, and a look of disappointment crosses [rubi.eir] face.  \"<i>Aww, I get this totally killer bod, but no tits?</i>\" [rubi.ey] exclaims, visibly upset.");
			//(boobgrowth continues)
			output("\n\nAs if on cue, the flesh around [rubi.eir] [rubi.nippleColor] nipples begins to tremble and then expand.  You swear you hear a whooshing sound, like someone is blowing up a balloon.");
			//(if flat-chested)
			if (rubi.breastRows[0].breastRating() == 0) output("  Within seconds, Rubi has the chest of a pubescent girl, within a minute they're at least a B-cup.");
			output("  You both sit with morbid curiosity, watching the flesh grow outwards, bit by bit and cup by cup.  After five minutes the growth stops, and Rubi carefully cradles [rubi.eir] new enormous E-cup breasts.");
			processTime(5);
			rubi.breastRows[0].breastRatingRaw = 7;
		}
		output("\n\nThe silence is broken when Rubi shouts, \"<i>Oh fuck yes, this is more like it!</i>\"  [rubi.Ey] stands and dances what can only be called the titty-dance, squeezing one breast and then the other in quick succession to some tune that exists only in [rubi.eir] head.  It seems that, in addition to a new body, the liqueur also granted Rubi excessive amounts of energy!");

		output("\n\nSuddenly remembering you're here, [rubi.ey] stops and gives you a great big hug, pressing [rubi.eir] breasts against ");
		if (pc.biggestTitSize() < 1) output("yours");
		else output("you");
		output(".  \"<i>Like, thank you so much baby!  You're the freaking best!  Now... you want to break this body in?</i>\"");

		output("\n\nYou grin and say, \"<i>Of course.</i>\"  After all, you're always happy to help!");
		processTime(5);
		//(Go to sex menu)
		pc.destroyItemByType(itype);
		rubi.removeStatusEffect("Force Male Gender");
		rubi.createPerk("Bimbo Brains");
		rubi.hairColor = "blonde";
		rubiSexMenu();
		addButton(14, "Leave", function():*{ processTime(10 + rand(10)); mainGameMenu(); });
		return;
	}
	//Equinum
	//Gives horsecock.
	//Grows cock. (As Incubus Draft above)
	else if (itype == CoCEquinum) {
		output("You hand over the vial of milky white fluids.  Rubi looks it over and gives you an odd look.  \"<i>Horses?  Really?  What, do you like the giant cocks?</i>\" [rubi.ey] asks, incredulously.  Nevertheless, [rubi.ey] pops the cork out of the vial and puts [rubi.eir] lips to the flared opening, downing the transformative drink in one swallow.");
		if (!rubi.hasCock()) {
			output("\n\nRubi gasps and [rubi.eir] hands dart between [rubi.eir] legs, grasping frantically for something.  Between [rubi.eir] fingers you spot it, a fleshy ");
			if (rubi.skinTone == "red") output("red");
			else output("pink");
			output(" protrusion... a brand new cock!  Rubi shudders, [rubi.eir] delicate little fingers wrapped around the new, five-inch cock.");
			rubi.createCock(5);
		}
		//(If Rubi gets Horsecock)
		if (rubi.cocks[0].cType != GLOBAL.TYPE_EQUINE) {
			output("\n\nFor a few moments nothing happens.  Then Rubi suddenly doubles over, clutching [rubi.eir] stomach in pain.  With one hand clamped firmly around [rubi.eir] midsection, [rubi.eir] other hand reaches down to grasp at [rubi.eir] [rubi.cock].  The flesh on [rubi.eir] cock ripples, veins suddenly bulging.  A low moan wrestles its way out of Rubi's throat as [rubi.eir] cock morphs, the pink head flattening all of a sudden and flaring outwards.");
			rubi.shiftCock(0, GLOBAL.TYPE_EQUINE);
			output("\n\nRubi's dick thickens in [rubi.eir] hand, gaining at least an inch of width as it continues to change.  A thick, fleshy ring bulges out near the base of the cock... the beginnings of a sheathe, no doubt.  As you watch on in awe, the flesh at the base of Rubi's cock begins to darken, slowly become a dusky grey-black, which also overtakes [rubi.eir] ");
			if (rubi.ballSizeMod >= 4 && rubi.ballSizeMod < 9) output("swollen ");
			else if (rubi.ballSizeMod >= 9) output("engorged ");
			else if (rubi.hasStatusEffect("Uniball")) output("tight, trappy ");
			output("ballsack.  The colors move forward, seemingly stopping at the thick ring that marks the edge of [rubi.eir] sheathe... except patches of  dusky gray appear along the next few inches of [rubi.eir] length, creating a nice contrast and pattern with the bright pink of [rubi.eir] cockflesh.");

			output("\n\nSighing suddenly, Rubi relinquishes [rubi.eir] stomach and cock, recovering for a moment before looking down in wonderment at [rubi.eir] new horsecock.  \"<i>Oh wow,</i>\" [rubi.ey] says, running [rubi.eir] fingers along the spongy new ridge at its tip.  \"<i>Ah, this is going to take some getting used to...</i>\"");
			rubi.cocks[0].cLength(3 + rand(5));
		}
	}
	//Trap Oil
	else if (itype == CoCTrapOil) {
		//Decrease bust size by 1 if above 1. (See Incubus Draft)
		//Increase bust size by 1 if below 1. (See succubus milk)
		//Decrease penis size by 1 if above 3. (See succubus milk)
		//Random chance to give trap ballsack.
		//Random chance to give black eyes.
		//Random chance to give black nipples.
		output("You twirl the little bottle of oil in one hand and pull Rubi out of the closet.  For what you have in mind, [rubi.ey] will need somewhere comfortable to lay.  The two of you return to the bedroom, and you instruct Rubi to rest on the bed face down.  [rubi.Ey] flattens the bedspread out before eagerly doing so.");
		output("\n\nYour eyes run over the sight before you.  Rubi, face down on what must be the softest and most girly bed ever constructed.  [rubi.Eir] supple flesh lays bare to you, with its pert, heart-shaped ass, creamy thighs, and tender feet.  Not to mention the sinuous tail that flutters from side to side.  You can't help but grin as you climb on top of Rubi's prone form, popping the top off the bottle as you do so.");
		output("\n\nSettling down on Rubi's thighs, with [rubi.eir] perky ass and back laid out before you, you upturn the bottle just a bit, letting a fair dollop of the semi-thick oil to cascade down [rubi.eir] spine.  It forms a puddle in the small of [rubi.eir] back.  You splash your hands with some of the oil, and then set the bottle aside.  Giving your hands a good stretch beforehand, you dive right in, pressing your fingers into Rubi's flesh.");
		output("\n\nYour fingers search for the knots in the muscles, working from [rubi.eir] shoulders all the way down to [rubi.eir] lower back, lingering longer than needed on [rubi.eir] ass.  You likewise assault the muscles in [rubi.eir] arms and legs, massaging the tension from every pore as Rubi moans delightfully into the bedspread.");
		output("\n\nBefore long you have [rubi.em] flip over, and return to your stance just above [rubi.eir] thighs.  Rubi's toned midsection heaves, as [rubi.eir] breath comes labored.");
		if (rubi.hasCock()) {
			output("  Rubi's [rubi.cock] twitches, already leaking precum from its tip as it attempts to reach the skies above");
		}
		else output("  Rubi's cunt glistens, soaked through entirely thanks to your ministrations");
		if (rubi.breastRows[0].breastRating() > 0) output(", while [rubi.eir] [rubi.chest] gently rock up and down with the motions of [rubi.eir] breathing");
		output(".");

		output("\n\nYou repeat the process here, applying a generous dollop of the oils to your lover's body, which arches appreciatively at your touch.  Your fingers dive right back in, no longer focusing on working out the knots in Rubi's body, but instead focusing on [rubi.eir] nipples, belly, and groin.  You love the way [rubi.ey] reacts to every little touch, from the curling of [rubi.eir] toes as you brush past [rubi.eir] inner thighs, to the cute lip-bite you see as your fingers tantalize [rubi.eir] underarms.");

		output("\n\nWith Rubi finally covered from the neck down in the oils, you stand back and smile, waiting for the transformations to kick in.");
		//(If Bust size decreases)
		if (rubi.breastRows[0].breastRating() > 1) {
			output("\n\nRubi gasps a little and [rubi.eir] hands immediately dart to [rubi.eir] chest.  Before your eyes, Rubi's breasts begin to dwindle, shrinking down an entire cup size.  Rubi cups [rubi.eir] breasts experimentally, getting used to their new, reduced, weight.");
			rubi.breastRows[0].breastRating(-1);
			if (rubi.breastRows[0].breastRatingRaw < 1) rubi.breastRows[0].breastRatingRaw = 1;
		}
		//(If Bust size increases)
		else if (rubi.breastRows[0].breastRating() < 1) {
			output("\n\nRubi gasps a little and [rubi.eir] hands immediately dart to [rubi.eir] chest.  Before your eyes, Rubi's breasts begin to swell, growing an entire cup size.  Rubi cups [rubi.eir] breasts experimentally, getting used to their new weight.");
			rubi.breastRows[0].breastRatingRaw = 1;
		}
		//(If Penis size decreases)
		else if (rubi.cocks[0].cLengthRaw > 3) {
			output("\n\nRubi's [rubi.cock] swells up suddenly, growing painfully hard.  [rubi.Ey] grasps it and moans suddenly as it begins to dwindle in size, shrinking down by at least an inch, leaving [rubi.em] with a ");
			rubi.cocks[0].cLength( -1);
			if (rubi.cocks[0].cLengthRaw < 3) rubi.cocks[0].cLengthRaw = 3;
			output(Math.round(rubi.cocks[0].cLengthRaw * 10) / 10 + "-inch penis.");
		}
		//(Trappy ballsack)
		else if (!rubi.hasStatusEffect("Uniball")) {
			output("\n\nThe oils seem to seep into Rubi's skin, giving it a glossy, almost insectile shine for a moment.  However, your eyes seem drawn, not to [rubi.eir] lustrous skin, but rather to [rubi.eir] crotch, [rubi.eir] testicles in particular.  The sack itself seems to contort oddly, and you realize it's shrinking!  Rubi makes a panicked noise as the sack constricts and pulls upwards, but thankfully it does not disappear.  Rather, it seems to have tightened up.  You rest your fingers on [rubi.eir] new sack experimentally, pleased to note that [rubi.ey] still has two testicles, though it looks like [rubi.ey] only has one: trapped in a cute little package that seems to pull upwards, rather than dangle down.");
			rubi.createStatusEffect("Uniball");
		}
		//(Black Nipples)
		else if (rubi.nippleColor != "black") {
			output("\n\nRubi's hands quickly dart to [rubi.eir] nipples, which perk up as if the temperature had dropped by twenty degrees.  [rubi.Ey] can't help but giggle as though [rubi.ey] were being tickled as the nipples begin to darken, starting at the edge of the areola and working their way in.  In no time at all, Rubi's nipples have turned an enticing onyx black.");
			rubi.nippleColor = "black";
		}
		//(Black Eyes)
		else if (rubi.eyeType != GLOBAL.TYPE_MYR) {
			output("\n\nRubi blinks, then blinks again, as if something is trapped in [rubi.eir] eyes.  [rubi.Ey] brings a hand up to them, but you can already see the cause of this discomfort.  Some inky, black substance seems to be coating [rubi.eir] eyes, starting from the outside and working its way in. In no time it's covered the sclera, and then the iris.  Rubi holds [rubi.eir] eyes closed for a minute and then opens them, revealing [rubi.eir] new, solid black eyes.  [rubi.Ey] quickly rushes off into the closet to check them out in a mirror.");
			rubi.eyeType = GLOBAL.TYPE_MYR;
			rubi.eyeColor = "black";
		}
		else output("\n\nSadly, however, nothing seems to happen.  Perhaps there's nothing left to transform, or you got a dud bottle.  Regardless, Rubi seems to be quite happy with the massage, and is content to lie on the bed for several minutes before cleaning [rubi.em]self up and returning to the closet.");
		processTime(10);
	}
	//Whisker Fruit
	//Progression of furriness: cat ears, then whiskers and paws, then cat penis, then furry body.
	else if (itype == CoCWhiskerFruit) {
		output("You hand over the tiny peach-like fruit to Rubi.  [rubi.Ey] turns it over in [rubi.eir] hands and remarks, \"<i>How can you like these things?  They're so... furry!  Well, to each their own I suppose.</i>\"  Rubi gulps visibly, preparing [rubi.em]self for the whiskery fruit before biting down.  Apparently, it's not as bad as [rubi.ey] thought it was, as [rubi.ey] makes an appreciative grunt and consumes the fruit down to the pit.");

		//(Gaining Cat Ears)
		if (rubi.earType != GLOBAL.TYPE_FELINE) {
			output("\n\nRubi's hands dart to [rubi.eir] head and [rubi.ey] kneels down in pain.  For a moment, you're not sure what's wrong, and then you see it: [rubi.eir] ears twist and elongate, suddenly sprouting a fine layer of [rubi.furColor] fur.  They slowly form into a triangular shape and migrate up Rubi's head until they stop, perching on top like... well like a pair of cat's ears.");
			rubi.earType = GLOBAL.TYPE_FELINE;
		}
		//(Gaining Whiskers and Paws)
		else if (!rubi.hasStatusEffect("Whiskers") || rubi.armType != GLOBAL.TYPE_FELINE) {
			output("\n\nRubi's hands dart to [rubi.eir] face this time as a number of whiskers sprout from [rubi.eir] cheeks.  They twitch cutely at [rubi.eir] touch, but that's not the full extend of the changes.  Rubi looks at [rubi.eir] hands and gasps, marveling as they sprout a fine layer of white fur and morph.  Patches of skin on [rubi.eir] palms and fingers brighten, becoming pink in color, as the white fur overtakes the rest.  In the end, Rubi is left with a pair of paw-like hands.");
			if (!rubi.hasStatusEffect("Whiskers")) rubi.createStatusEffect("Whiskers");
			rubi.armType = GLOBAL.TYPE_FELINE;
			rubi.armFlags = [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
		}
		else if (rubi.legType != GLOBAL.TYPE_FELINE) {
			output("\n\nRubi then sits down as a shooting pain seems to go up [rubi.eir] legs.  [rubi.Ey] cradles one leg as a similar process happens there, the foot being overtaken by [rubi.furColor] fur while pink pads form on the soles and toes.  [rubi.Eir] heel lengthens as well, drawing itself away from the toes and forming what you're sure is a digitigrade structure.  Sure enough, when the transformation is over and Rubi takes a few tentative steps on [rubi.eir] new legs, [rubi.ey] is forced to walk on tip-toes, which really helps accentuate [rubi.eir] ass.");
			rubi.legType = GLOBAL.TYPE_FELINE;
			rubi.legFlags = [GLOBAL.FLAG_DIGITIGRADE, GLOBAL.FLAG_FURRED, GLOBAL.FLAG_PAWS];
		}
		//(Gaining Cat Penis)
		else if (rubi.hasCock() && rubi.cocks[0].cType != GLOBAL.TYPE_FELINE) {
			output("\n\nFor a few moments nothing happens.  Then Rubi suddenly doubles over, clutching [rubi.eir] stomach in pain.  With one hand clamped firmly around [rubi.eir] midsection, [rubi.eir] other hand reaches down to grasp at [rubi.eir] [rubi.cock].  The flesh on [rubi.eir] cock ripples, veins suddenly bulging.  A low moan wrestles its way out of Rubi's throat as [rubi.eir] cock morphs, its tip lengthening out while a number of barb-like protrusions sprout from the head.  Before your eyes the barbs quiver and then go flush against [rubi.eir] cock.  They don't seem sharp, more like they're ready to stimulate a potential mate.");
			rubi.shiftCock(0, GLOBAL.TYPE_FELINE);
		}
		//(Gaining Fur)
		else if (!rubi.hasFur()) {
			output("\n\nRubi clutches [rubi.eir] stomach suddenly as you notice white spots appearing on [rubi.eir] skin.  You notice it's not simply a skin tone change, but rather a fine layer of [rubi.furColor] fur has sprouted from [rubi.eir] flesh and is taking over at a rapid pace!  The blotches of fur quickly overtake [rubi.eir] torso, leaving the nipples unchanged, then the arms and legs, and finally the face, leaving [rubi.em] with a cute little button nose.");
			rubi.skinType = GLOBAL.SKIN_TYPE_FUR;
		}
	}
	//Purity Peach
	if (itype == CoCPurePeach) {
		//Requires 5 Purity Peaches
		//Consumes 1 hour
		//Gives Anemone Penis.
		//Feathery ears.
		//Striped, shark-like skin.
		output("Though you know these peaches alone don't cause any kind of transformation, you wonder if together they might do something to someone like Rubi.  You hand over the five peaches and mention how these might taste good in a pie.  Rubi's eyes light up and [rubi.ey] nods, \"<i>Oh!  I could give that a try, sure!");
		output("\n\nRubi takes an apron off of a hangar and ties it around [rubi.eir] body, not bothering to put on anything else, as [rubi.ey] heads into the kitchen.  You follow and watch as [rubi.ey] gets to work, first preheating the little oven, then retrieving a pie pan and lining it with a fresh pie crust.  [rubi.Ey] cuts up the peaches and throws some other ingredients in that you don't register.  Truth be told your gaze is focusing more on Rubi's shapely naked ass as it wiggles to and fro.");
		output("\n\nBefore you know it, there's an entire pie baking in the oven and Rubi is pushing you onto the couch.  [rubi.Ey] climbs on top and then lays down on you, holding you close.  The two of you spend the next half-hour or so snuggling on the couch like this, Rubi's half-naked body clutched against yours.  Eventually, though, the timer by the oven goes off, and Rubi springs up out of your grasp like a cat threatened with water.  [rubi.Ey] sprints over to the oven, and, donning a comically large oven mitt, retrieves the fresh baked pie from its depths.");
		output("\n\n[rubi.Ey] inhales deeply and sighs.  \"<i>Mmm, this smells good! Do you want a fresh slice?</i>\"");

		output("\n\nYou decline, saying you brought these peaches for [rubi.em], and that you can get some more any time.  [rubi.Ey] nods and cuts [rubi.em]self a wedge of the pie, letting it cool off slightly before taking a bite.  [rubi.Eir] lips immediately curl up into a smile, and you swear you hear a small moan of delight muscle its way out of [rubi.eir] closed lips.  Before you know it, that slice is gone, followed by a second, and then half the pie has seemingly disappeared.");

		output("\n\n\"<i>Oh my that's good,</i>\" Rubi says, making [rubi.eir] way back to the couch and slumping into the cushions.  [rubi.Ey] removes the apron, revealing the naked [rubi.skinFurScales] underneath.  The demon-marked " + rubi.mf("boy","girl") + " rubs [rubi.eir] stomach appreciatively.  \"<i>Those were some great peaches, babe.</i>\"");

		//(Any changes? Yes)
		if (rubi.earType != GLOBAL.TYPE_AVIAN || (rubi.skinType != GLOBAL.SKIN_TYPE_SKIN || rubi.skinAccent != "gray") || (rubi.hasCock() && rubi.cocks[0].cType != GLOBAL.TYPE_ANEMONE))
		{
			output("\n\nRubi's eyes suddenly dart open and [rubi.ey] clutches [rubi.eir] stomach.  \"<i>Oh gods...  My belly feels so warm all of a sudden.</i>\"");
			//(Feathery ears)
			if (rubi.earType != GLOBAL.TYPE_AVIAN) {
				output("\n\n[rubi.Eir] hands don't dally there long before darting up to [rubi.eir] head, as [rubi.eir] ears seem to shimmer and morph right before your eyes.  [rubi.Eir] ");
				if (rubi.earType == GLOBAL.TYPE_HUMAN) output("normal");
				else output("feline");
				output(" ears seem to pull into [rubi.eir] skull before disappearing, leaving nothing but skin and hair behind.  You wonder if Rubi's lost [rubi.eir] ears permanently, but as the thought finishes crossing your mind you notice two small nubs growing where normal ears would be.");

				output("\n\nThey quickly blossom outward, growing into something vaguely ear-shaped.  And then a number of bright feathers sprout, covering the entire ear in pink and orange down.");
				output("\n\n[rubi.Eir] hands pull away, as [rubi.ey] gives the ears a few experimental pokes.  They twitch cutely, and Rubi rushes off to check [rubi.em]self out in a mirror.");
				rubi.earType = GLOBAL.TYPE_AVIAN;
			}
			//(Shark Skin)
			else if (rubi.skinAccent == "") {
				output("\n\n[rubi.Eir] hands firmly clamp down on the naked flesh of [rubi.eir] stomach.  Amazingly, you notice, [rubi.eir] skin seems to be taking on a different hue.  At first it darkens, ");
				if (rubi.hasFur()) output("the fur rapidly retreating and replaced with bright red flesh underneath");
				else if (rubi.skinTone == "red") output("which is barely noticeable on [rubi.eir] already cherry red flesh");
				else output("its normal paleness replaced with a vibrant cherry red");
				output(", but it doesn't seem to be even.  The majority of Rubi's body is cherry red, while [rubi.eir] belly actually lightens, becoming a sweet, silvery gray.  A number of similarly silver stripes appear, seemingly at random, up and down Rubi's arms and legs, and even down [rubi.eir] demonic tail, amazingly enough.");
				output("\n\nWhen the changes seem to stop, or at least slow, Rubi calmly relinquishes [rubi.eir] hold on [rubi.eir] stomach and goes to check [rubi.em]self out in the mirror.");
				rubi.skinType = GLOBAL.SKIN_TYPE_SKIN;
				rubi.skinTone = "red";
				rubi.skinAccent = "gray";
			}
			//(Anemone Penis, must have a penis)
			else if (rubi.hasCock() && rubi.cocks[0].cType != GLOBAL.TYPE_ANEMONE) {
				output("\n\n[rubi.Eir] hands don't dally there long before darting down to [rubi.eir] crotch, groping at the [rubi.cock] betwixt [rubi.eir] legs.  The flesh seems to  ripple, with veins suddenly bulging.  A low, husky groan wrestles its way out of Rubi's throat as [rubi.eir] cock morphs");
				if (rubi.cocks[0].cType != GLOBAL.TYPE_HUMAN) output(", first shifting towards a more human-like appearance");
				output(".  Small nodules appear, around the crown of the penis, and around its base.  Rubi's delicate hands run across two of the nodules, and [rubi.eir] cock suddenly stiffens, harder than you've ever seen it!  Whatever those things are, they're quite sensitive.");
				
				output("\n\nThe little nubs quickly grow outwards, lengthening into tiny, anemone-like tentacles.  When the changes finally stop, Rubi gazes down with no small amount of trepidation, as the four tentacles around the head of [rubi.eir] penis and the four at its base wriggle and writhe of their own accord.");
				
				output("\n\n\"<i>Oh... Oh my.</i>\"  It's all [rubi.ey] can say as [rubi.ey] wraps a hand around this newly modified appendage.  The tentacles likewise attempt to wrap themselves around Rubi's hand, clearly having a mind of their own.  You're fairly certain this will take a little while to adapt to.");
				
				rubi.shiftCock(0, GLOBAL.TYPE_ANEMONE);
			}
		}
		//(No)
		else {
			output("\n\nYou monitor Rubi carefully, but it seems this batch of peaches has no effect other than filling [rubi.eir] stomach.  Or perhaps there's nothing more to change.");
		}
		pc.destroyItemByType(itype, 4);
		processTime(30);
	}
	pc.destroyItemByType(itype, 1);
	processTime(10);
	clearMenu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}

//GRO+/REDUCTO
private function rubiGrowPlusBreasts():void {
	//output(images.showImage("rubi-gro-plus-tits"), false);
	clearOutput();
	rubiSprite();
	output("You hand over the vial of blueish liquid.  Rubi takes a moment to look it over, before taking a deep breath and injecting half of the vial into one breast and the rest into [rubi.eir] other breast.");

	//(If breast increase)
	if (rubi.breastRows[0].breastRating() < 7) {
		output("\n\nRubi's breasts suddenly wobble of their own accord, swelling up like they're being inflated.  The little demon-morph shivers as pleasure wracks [rubi.eir] body, with [rubi.eir] breasts growing at least two cup sizes.  [rubi.Eir] fingers absently grope at [rubi.eir] new endowments, tweaking the flushed, sensitive flesh until the erotic heat from the transformation eventually dissipates, leaving [rubi.em] panting on the floor before you.");
		rubi.breastRows[0].breastRating(2 + rand(2));
		// trace("Normal grow");
		if (rubi.breastRows[0].breastRating() > 7) rubi.breastRows[0].breastRating(7, true);
	}
	//(If breasts already maxed)
	else output("\n\nSadly, apart from making [rubi.eir] nipples particularly perky, they don't seem to have much effect on Rubi's already enormous rack.");
	processTime(10);
	pc.destroyItemByType(CoCGroPlus);
	clearMenu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}
//(If Penis)
private function rubiPenisGroPlus():void {
	//output(images.showImage("rubi-gro-plus-penis"), false);
	clearOutput();
	rubiSprite();
	output("You hand over the vial of greenish liquid.  Rubi takes a moment to look it over, before taking a deep breath and injecting the entire thing into the base of [rubi.eir] [rubi.cock].");

	//(If Penis increase)
	if (rubi.cocks[0].cLength() < 12 || (rubi.cocks[0].cType == GLOBAL.TYPE_EQUINE && rubi.cocks[0].cLength() < 20)) {
		output("\n\nRubi grips [rubi.eir] cock as it suddenly hardens, visibly throbbing in [rubi.eir] grasp.  It surges, growing larger, gaining about two inches right before your eyes.");
		rubi.cocks[0].cLength(2 + rand(2));
		
		if (rubi.cocks[0].cType != GLOBAL.TYPE_EQUINE) {
			if (rubi.cocks[0].cLengthRaw > 12) rubi.cocks[0].cLengthRaw = 12;
		}
		else {
			if (rubi.cocks[0].cLengthRaw > 20) rubi.cocks[0].cLengthRaw = 20;
		}
	}
	else {
		output("\n\nSadly, apart from making [rubi.eir] cock hard, it doesn't seem to have much of an effect on Rubi's ");
		if (rubi.cocks[0].cType == GLOBAL.TYPE_EQUINE) output("sheath-stuffing horse-dick");
		else output("giant dick.");
	}
	processTime(10);
	pc.destroyItemByType(CoCGroPlus);
	clearMenu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}

//(If Breasts)
private function rubiBoobsReducto():void {
	clearOutput();
	rubiSprite();
	output("You hand over the jar of paste.  Rubi looks it over and, after giving it a sniff, uses two fingers to scoop up some of the pale substance, smearing it over [rubi.eir] breasts.  Before long, the jar is empty and [rubi.eir] [rubi.chest] are covered in the stuff.");
	if (rubi.breastRows[0].breastRating() > 0) {
		output("\n\nIt seems to take a moment for the effects to kick in, and soon you see Rubi shiver while [rubi.eir] breasts seem to quake, shrinking rapidly in size.  When the process is done, you're certain [rubi.ey]'s lost an entire cup size, and the paste has been completely absorbed in the process.");
		rubi.breastRows[0].breastRating(-1);
	}
	processTime(20);
	pc.destroyItemByType(CoCReducto);
	clearMenu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}

//(If Penis)
private function rubiPenisReducto():void {
	clearOutput();
	rubiSprite();
	output("You hand over the jar of paste.  Rubi looks it over and, after giving it a sniff, uses two fingers to scoop up some of the pale substance, smearing it over [rubi.eir] penis.  Before long, the jar is empty and [rubi.eir] [rubi.cock] is covered in the stuff.");
	if (rubi.cocks[0].cLength() >= 3) {
		output("\n\nIt seems to take a moment for the effects to kick in, and soon you see Rubi shiver while [rubi.eir] [rubi.cock] stiffens and then shrinks rapidly in size.  When the process is done, you're certain [rubi.ey]'s lost an entire inch, and the paste has been completely absorbed in the process.");
		rubi.cocks[0].cLength( -1);
		if (rubi.cocks[0].cLength() < 3) rubi.cocks[0].cLength(3, true);
	}
	else {
		output("\n\nIt doesn't seem to have any effect.");
	}
	processTime(20);
	pc.destroyItemByType(CoCReducto);
	clearMenu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to item giving menu!
}

//Give Item.
private function pickAnItemToFeedRubi():void {
	clearOutput();
	rubiSprite();
	var button:int = 1;
	var closet:Array = [];
	var gifts:Array = [];
	clearMenu();
	if (rubi.hasItemByType(CoCSuitclothes))
		closet[closet.length] = "Suitclothes";
	else {
		gifts.push("Suitclothes");
		if (pc.hasItemByType(CoCSuitclothes)) addButton(button++, "Suitclothes", giveRubiClothes, CoCSuitclothes);
	}
	
	if (rubi.hasItemByType(CoCRubberClothes))
		closet[closet.length] = "Rubber Fetish Clothes";
	else {
		gifts.push("Rubber Fetish Clothes");
		if (pc.hasItemByType(CoCRubberClothes)) addButton(button++, "Rubberclothes", giveRubiClothes, CoCRubberClothes);
	}
	
	if (rubi.hasItemByType(CoCAdvClth))
		closet[closet.length] = "A Green Adventurer's Outfit";
	else {
		gifts.push("A Green Adventurer's Outfit");
		if (pc.hasItemByType(CoCAdvClth)) addButton(button++, "Green Clothes", giveRubiClothes, CoCAdvClth);
	}
	
	if (rubi.hasItemByType(CoCTubeTop))
		closet[closet.length] = "A Tube Top";
	else {
		gifts.push("A Tube Top");
		if (pc.hasItemByType(CoCTubeTop)) addButton(button++, "Tube Top", giveRubiClothes, CoCTubeTop);
	}
	
	if (rubi.hasItemByType(CoCTransparentBodysuit))
		closet[closet.length] = "A Sheer Bodysuit";
	else {
		gifts.push("A Sheer Bodysuit");
		if (pc.hasItemByType(CoCTransparentBodysuit)) addButton(button++, "Bodysuit", giveRubiClothes, CoCTransparentBodysuit);
	}
	
	if (rubi.hasItemByType(CoCLongDress))
		closet[closet.length] = "A Long Dress";
	else {
		gifts.push("A Long Dress");
		if (pc.hasItemByType(CoCLongDress)) addButton(button++, "Long Dress", giveRubiClothes, CoCLongDress);
	}
	
	if (rubi.hasItemByType(CoCLthrPnt))
		closet[closet.length] = "A Dashing Outfit With Tight Leather Pants";
	else {
		gifts.push("A Dashing Outfit With Tight Leather Pants");
		if (pc.hasItemByType(CoCLthrPnt)) addButton(button++, "Leather Pants", giveRubiClothes, CoCLthrPnt);
	}
	
	if (rubi.hasItemByType(CoCNurseOutfit))
		closet[closet.length] = "Nurse's Clothes";
	else {
		gifts.push("Nurse's Clothes");
		if (pc.hasItemByType(CoCNurseOutfit)) addButton(button++, "Nurse Clothes", giveRubiClothes, CoCNurseOutfit);
	}
	
	if (rubi.hasItemByType(CoCSluttySwimwear))
		closet[closet.length] = "Slutty Swimwear";
	else {
		gifts.push("Slutty Swimwear");
		if (pc.hasItemByType(CoCSluttySwimwear)) addButton(button++, "SluttySwim", giveRubiClothes, CoCSluttySwimwear);
	}
	
	if (rubi.hasItemByType(CoCBimboSkirt))
		closet[closet.length] = "A Bimbo Minidress";
	else {
		gifts.push("A Bimbo Minidress"); //No button, must be found in a special event
		if (pc.hasItemByType(CoCBimboSkirt)) addButton(button++, "BimboSk", giveRubiClothes, CoCBimboSkirt);
	}
	
	if (rubi.hasItemByType(CoCBondageStraps))
		closet[closet.length] = "Bondage Straps";
	else {
		gifts.push("Bondage Straps");
		if (pc.hasItemByType(CoCBondageStraps)) addButton(button++, "Bondage S.", giveRubiClothes, CoCBondageStraps);
	}
	
	if (rubi.hasItemByType(CoCInquisitorsCorset))
		closet[closet.length] = "An Inquisitor's Corset";
	else {
		gifts.push("An Iquisitor's Corset");
		if (pc.hasItemByType(CoCInquisitorsCorset)) addButton(button++, "I. Corset", giveRubiClothes, CoCInquisitorsCorset);
	}
	
	if (flags["COC.RUBI_AFFECTION"] >= 100)
		closet[closet.length] = "A Risque Waitress's Uniform";
	else
		gifts.push("A Risque Waitress's Uniform");
	
	if (closet.length > 0) {
		output("<b>Rubi's Closet:</b>");
		for (var x:int = 0; x < closet.length; x++) output("\n" + closet[x]);
		output("\n\n");
	}
	
	if (gifts.length > 0) {
		output("After a quick glance around Rubi's things, you bet [rubi.ey] could really use... " + gifts[rand(gifts.length)] + ".\n\n");
	}
	else {
		output("You've given Rubi all the clothes [rubi.ey] would want to make use of.");
		if (silly) output("\n\n(<b>Achievement Unlocked: Dress-tacular</b>)");
		//awardAchievement("Dress-tacular", kACHIEVEMENTS.GENERAL_DRESSTACULAR);
		output("\n\n");
	}
	
	if (!rubi.isBimbo() && !rubiIncubus() && rubiAffection() >= 100) {
		output("You could give Rubi some incubi draft to make [rubi.em] a little more manly but corrupt, or you could give Rubi a Bimbo Draft to turn [rubi.em] into a smoking hot, female sex-bomb.\n\n");
	}
	output("What will you give [rubi.em]?");
	if (pc.hasItemByType(CoCBimboLiqueur) && !rubi.isBimbo()) addButton(button++, "Bimbo Liq", giveRubiATFItem, CoCBimboLiqueur);
	if (pc.hasItemByType(CoCIncubiD)) addButton(button++, "Incubi Draft", giveRubiATFItem, CoCIncubiD);
	if (pc.hasItemByType(CoCIncubiDPure)) addButton(button++, "Pure Draft", giveRubiATFItem, CoCIncubiDPure);
	if (pc.hasItemByType(CoCSucMilk)) addButton(button++, "Sucb Milk", giveRubiATFItem, CoCSucMilk);
	if (pc.hasItemByType(CoCSucMilkPure)) addButton(button++, "PureScbMlk", giveRubiATFItem, CoCSucMilkPure);
	if (pc.hasItemByType(CoCPurePeach, 5)) addButton(button++, "Pure Peach", giveRubiATFItem, CoCPurePeach);
	if (pc.hasItemByType(CoCEquinum)) addButton(button++, "Equinum", giveRubiATFItem, CoCEquinum);
	if (pc.hasItemByType(CoCWhiskerFruit)) addButton(button++, "Whsk.Fruit", giveRubiATFItem, CoCWhiskerFruit);
	if (pc.hasItemByType(CoCReducto)) addButton(button++, "Reducto", giveRubiATFItem, CoCReducto);
	if (pc.hasItemByType(CoCGroPlus)) addButton(button++, "Gro Plus", giveRubiATFItem, CoCGroPlus);
	if (pc.hasItemByType(CoCTrapOil)) addButton(button++, "Trap Oil", giveRubiATFItem, CoCTrapOil);
	addButton(0, "Back", rubiAppearance);
}


//(Give Clothes)
public function giveRubiClothes(itype:Class = null):void {
	clearOutput();
	rubiSprite();
	if (itype == null || rubi.hasItemByType(itype) || !pc.hasItemByType(itype)) {
		output("WRONG ITEM TO GIVE, SOMETHING GONE WRONG");
		addNextButton(rubisFuckingHouseYouPervert);
		return;
	}
	output("You hand over the spare set of clothes, and Rubi's eyes light up.  \"<i>For me?</i>\"  the little demon practically screams, ecstatic.  \"<i>ThankyouthankyouthankyouTHANKYOU!</i>\"");
	output("\n\nRubi holds the outfit up to [rubi.eir] body and grins, \"<i>Ooooh, I just love it!  I mean, I'll have to take it to the tailors to get fitted, but I absolutely adore it!</i>\"");
	output("\n\nYou wonder how [rubi.ey] could get so excited over it, after all it's just clothes, but you smile and nod along, happy to make [rubi.em] happy.");
	processTime(2);
	pc.destroyItemByType(itype, 1);
	rubi.inventory.push(new itype());
	rubiAffection(20);
	addNextButton(rubisFuckingHouseYouPervert);
}

//Rubi's Bimbofication
public function hypnoBimboficationForRubiSloots():void
{
	clearOutput();
	output("You slither out of your [pc.gear], flicking your tongue hungrily at the air, tasting the petite boy's desire. He is so attracted to you, and yet, he's trying so hard to be classy about it. It's cute in its own way, but you'd rather see him be more... honest about his drives. You want the cute, ");
	if (rubi.breastRows[0].breastRating() < 1) output("femmy boy");
	else if (!rubi.hasVagina()) output("dick-girl");
	else output("little slut");
	output(" ready to lust after your cock openly, to cling to you whenever you arrive and grope your bulge in public. He needs to be less worried about propriety and more focused on sexual satiation and appeal... yes.");
	output("\n\nRubi is watching you in open mouthed fascination. His lips move, stammering, trying to talk, but he just can't get the words out. It's no wonder, really - you've got your big, hard tool");
	if (pc.cockTotal() > 1) output("s");
	output(" whipped out and swaying with your sinuous movements, and all he has is his comparatively undersized little pecker. You rock your whole body with the snake-like grace given to you by your naga body, swaying rhythmically as you meet his eyes. Knowing full well just what kinds of depravity you'd like to force him into, you feel a ");
	if (flags["COC.JOJO_STATE"] >= 5) output("familiar ");
	else output("strange ");
	output("dark power welling up within you.");
	output("\n\nRubi is powerless to resist your hypnotic gaze. Your very eyes seem alight with wisps of dark, almost-demonic power, beginning to entrance the vulnerable ");
	if (!rubi.hasVagina()) output("femboy");
	else output("hermaphrodite");
	output(". The longer he stares into your power, the slacker his jaw becomes.");

	output("\n\n\"<i>That's it, Rubi,</i>\" you soothe. \"<i>Look closer. You can trust me.</i>\"");
	output("\n\nHe mouths, \"<i>...can trust you....</i>\"");
	output("\n\nYou slide closer and ");
	if (pc.tallness >= 72) output("bend down");
	else output("lean forward");
	output(" so that his cute face is just inches away from your own. The entire time, you continue your entrancing sway, drawing him deeper and deeper as his eyes lazily follow your body. Rubi's slack lips allow a strand of drool to dangle down to his chin, and you imagine his very consciousness is draining out of him in much the same way, leaking down towards his [rubi.cock].");
	output("\n\nYou cannot afford to spare a glance in that hand, yet your roving hand finds him stiffening soon enough. As a matter of fact, he's stiffening in record time. It only takes a few seconds for him to reach his full size and start pulsing in your hand. Moisture trickles through his clothing almost immediately. It's slick and sticky: pre-cum.");
	output("\n\nAs you gaze deeply into the increasingly pliant boy's empty eyes, you realize that whatever dark power you've managed to harness has enhanced the hypnosis you started to an almost telepathic degree. Rubi is hopelessly, completely spellbound, and he's so deep already that he's literally letting his conscious thoughts drip out his dick as pre-cum. Just how far does your power go? There's only one way to test.");
	output("\n\n\"<i>Rubi,</i>\" you say to get his attention, \"<i>You can feel the power of my eyes, can't you? They bind you, they control you, and they guide you into this blissful, thoughtless, dripping state.</i>\"");
	output("\n\nRubi answer is mumbled. \"<i>Yahhhh... ...eyes so preeetty.</i>\"");
	output("\n\n\"<i>I know they are, pet. Focus on their power. They're so powerful that you can feel them inside you, so powerful that even after I look away you'll still feel them boring into you, filling you up so that there's no room for anything but my control.</i>\"");
	output("\n\n\"<i>No room...</i>\" comes the quietly moaned reply.");
	output("\n\nYou instruct, \"<i>That's right, my eyes are inside you, controlling you. I'm going to close the eyes on the outside, but they'll be right there, inside you, fixating you, making you feel so good that your thoughts melt down into sticky, drippy, sexy submission.</i>\"");

	output("\n\n\"<i>Gooooood... sexy...</i>\" Rubi pants, twitching slightly in your hand as you blink and look down. His bottoms are completely soaked with pre! He's dripping uncharistically fast - faster than ever before. Your palm is immediately soaked from the touch, and you pull away, wiping yourself off on the mesmerized, soon-to-be-slut's clothing. He still stares vacantly into space, unmoving, though his hips have begin to make tiny gyrations, lifting into the air as if he could hump it. You can see his thighs quivering with need; the poor little ");
	if (!rubi.hasVagina()) output("femboy");
	else output("dickgirl");
	output(" must have quite the mind on him if it's making him drip THAT fast.");
	output("\n\nYou had better take care of that. Wrapping your tail around his unresisting arms, you snake it higher until it's encircling his neck and forehead. Once there, you focus your energies and speak, your words weighted with supernatural heft, \"<i>Oh Rubi, your mind is so used to being active isn't it? But, it's so messy to let it go on like that.</i>\" You wriggle the tip of your serpentine length up against his ear, worming it inside. \"<i>There's no need for that now, Rubi. It feels so good not to think, doesn't it?</i>\"");
	output("\n\nBeyond words, the ");
	if (rubi.hasVagina()) output("dick-");
	output("girl");
	if (!rubi.hasVagina()) output("y-boy");
	output(" simply gives the slightest of nods as a reply.");

	output("\n\n\"<i>Would you like to feel like this all the time - happy and carefree?</i>\" you ask.");

	output("\n\nRubi nods, a little more vigorously.");
	output("\n\nA predatory smile spreads across your face. \"<i>That's natural. Everyone wants to be happy, and I'm going to help you become soooo happy.</i>\" Imagining your tail as some kind of psionic antennae, you channel your thoughts through it as you continue to speak and mold your hapless victim. \"<i>You feel good right now because you are aroused and empty-minded, Rubi. Your mind prevented you from experiencing this complete bliss. Even now, it's interfering, forcing me to reroute your thoughts down to your dick to give you this present.</i>\"");
	output("\n\nYou didn't think it possible, but Rubi's face slackens further.");

	output("\n\n\"<i>I can help you fix that, Rubi, but I need your help. I need you to want it. I need you to want to be horny, thoughtless, and happy all the time. You need to truly want to feel this good all the time, and it does feel sooo good, doesn't it?</i>\"");
	output("\n\nRubi drools. \"<i>...yesssss...</i>\"");
	output("\n\nYou reply, \"<i>Good boy. I want you to close your eyes, still seeing my eyes inside you, feeling the tail in your ear feeding them power, making them so compelling that their thoughts and their commands become your own. Feel me taking over Rubi, and open yourself completely, let my mind guide yours to your personal nirvana.</i>\"");
	output("\n\nThere is no spoken reply, but you feel the change almost immediately. You can feel his thoughts swirling around you, seeming to vanish into a vat of molasses-thick goo, and his mind is putty in your imaginary hands. There is no longer even a token of resistance - just total, complete, surrender. A whimper slides out of his lips. His cock trembles, twitching, so hard it looks fit to burst, and his balls quake meaningfully, on the edge of unloading.");
	output("\n\n<i>\"Yesss, good boy,\"</i> you hiss as you telepathic make his mind your playground. Self-consciousness? Your toy doesn't need that. You dedicate that space to seeking and enjoying physical pleasure instead, turning the former center of worry into a mental clitoris. Next, you find Rubi's libido. A touch of dark power has no problem swelling it, even if you have to give over a little of his reasoning ability to make room. His intelligence drips out his dick like excess sperm. You coo comfortingly, the tremors of your voice making his eyes flutter in wonder.");
	output("\n\n<i>\"You are doing so good for me, Rubi, so very good.\"</i> Petting his cock one-handed, you continue to work. The boy-slut's mind isn't quite ready yet. His tame little fetishes don't really befit a cock-hungry slave. It won't matter if you sacrifice a little more of his intelligence in exchange for giving him a depraved lust for cocks and cunts that could rival a demon, will it?");
	output("\n\nThat's better. You whisper, <i>\"You can feel the differences already, can't you, my shameless little slut? They've got you hornier and more aroused than ever before, just waiting on your orgasm to burn my changes into place, turning you irrevocable into a cock-hungry fuck-toy.\"</i> You stroke him a little faster before releasing him. He's practically pissing his pre-cum at this point, and the fluid is even starting to get a little off-white with his sperm.");
	output("\n\nHis jaw clenches, and plaintive moans and whines slip out of his slackened (but cute) jawline. He almost sounds like a puppy. You coil around to the other side, putting your lips on his ear, whispering, <i>\"Can you feel yourself throbbing, pet? Can you feel that beautiful ache in your loins, tingling with need, driving you towards an orgasm that'll change you forever?\"</i> You lick his earlobe. <i>\"Come on puppy. Twitch for me. Pulse for me. Release for me.\"</i>");
	output("\n\nRubi, without ever touching himself, sighs. You look down just in time to see his [rubi.cock] launch a rope of pearl-hued submission onto the floor. As thick as it is, it could almost be called a cable. The slut is literally cumming out all his worries, shooting each of his old worries and concerns out in ivory streams of ecstatic pleasure. His hips move into shuddering spasmodic thrusts as he gives in, his eyes long since rolling back into their sockets as your magic locks in, true to your words.");
	output("\n\nWhen he finishes, there's a huge puddle on the ground and Rubi's cock is unflaggingly hard, incredibly erect and ready for round two.");
	output("\n\nThere's still something missing, though. A cum-slurping, constantly horny toy ought to be a little prettier. You draw deeper on the well of forbidden power inside you and place your hands upon the bliss-soaked boy's chest. He should have tits: big, pillowy tits than everyone will want to fuck. He'll want to let them too; you're sure of it. Tweaking Rubi's nipples, you give the petite little buds a gentle, but firm pull, smiling when you feel the flesh filling out underneath your touches, feeling them bud out like flowers about to bloom, fuller with each passing second. Soon, you've got handfuls of pale flesh in your palms, but it isn't enough. You squeeze them encouragingly, and the femboy's flesh responds obligingly, curving out into bubbly bust. You heft them, shaking them in your palms. They might be c-cups.");
	output("\n\nMeanwhile, the excited bimbo-to-be cums from the sensation a second time, too excited not to blow from having his - no... her titties mauled. Rubi's turning into a pliable, fuck-hungry shemale, and it's best you thought of her as one. Still, C-cups aren't big enough for a proper boobjob, so you focus harder, pouring corruption thicker than molasses directly into her jiggling, swelling tits. They sit high and proud on her chest as they fill, passing by D-cups on their way to a perfect pair of double D's - a good size to start with.");
	output("\n\nRubi shudders weakly, slowly regaining consciousness, and looks to you. Her eyes are a little duller and less inquisitive than before, but they burn bright with happiness and desire. Before she can talk, you press a finger to her lips, silencing her. A trickle of the darkness behind the change slips out into them, filling them into a slightly-pursed pair of cock-pillows. Perfect.");
	output("\n\n<i>\"Just looking at you has gotten me horny. What are you going to do about it?\"</i>\n\nRubi smiles eagerly.");
	output("\n\n<b>Rubi is now a ");
	if (!rubi.hasVagina()) output("shemale ");
	output("bimbo! She's going to be a lot more lusty and airheaded, but isn't that what you wanted?</b>");
	rubi.createPerk("Bimbo Brains");
	rubi.removeStatusEffect("Force Male Gender");
	rubi.breastRows[0].breastRatingRaw = 5;
	//Sex menu
	pc.lust(pc.lustMax());
	pc.cor(10);
	rubiSexMenu();
	rubiAffection(100);
}