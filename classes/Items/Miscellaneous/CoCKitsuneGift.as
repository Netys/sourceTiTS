package classes.Items.Miscellaneous
{
	import classes.Items.Transformatives.CoCFoxBerry;
	import classes.Items.Transformatives.CoCFoxJewel;
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
	
	public class CoCKitsuneGift extends ItemSlotClass
	{
		public function CoCKitsuneGift()
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.QUESTITEM;
			
			//Used on inventory buttons
			this.shortName = "KitGift";
			
			//Regular name
			this.longName = "kitsune's gift";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a kitsune's gift";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "A small square package given to you by a forest kitsune.  It is wrapped up in plain white paper and tied with a string.  Who knows what's inside?";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 0;
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
			
			this.version = _latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			output("Curiosity gets the best of you, and you decide to open the package.  After all, what's the worst that could happen?\n\n");
			RandomInCollection(findFoxJewel, findFoxBerry, findScholarsTea, findGems, findThief, findPrank, findKnowledge, findAphrodisiac, findWither, findDud, findChitin)();
			////[Hair Dye]
			//output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it contains a small vial filled with hair dye!");
			//var itype:Consumable = [
				//game.consumables.RED_DYE,
				//game.consumables.BLOND_D,
				//game.consumables.BLACK_D,
				//game.consumables.WHITEDY
			return true;
		}
		
		private function findFoxJewel():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, sitting in the center is a small teardrop-shaped jewel!");
			output("\n\n<b>You've received a shining Fox Jewel from the kitsune's gift!  How generous!</b>  ");
			//add Fox Berries to inventory
			
			kGAMECLASS.itemScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.lootScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.useItemFunction = kGAMECLASS.mainGameMenu;
			kGAMECLASS.itemCollect([new CoCFoxJewel()]);
		}
		
		private function findFoxBerry():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, there is a small cluster of orange-colored berries sitting in the center!");
			output("\n\n<b>You've received a fox berry from the kitsune's gift!  How generous!</b>  ");
			
			kGAMECLASS.itemScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.lootScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.useItemFunction = kGAMECLASS.mainGameMenu;
			kGAMECLASS.itemCollect([new CoCFoxBerry()]);
		}
		
		private function findScholarsTea():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it contains a small bag of dried tea leaves!");
			output("\n\n<b>You've received a bag of tea from the kitsune's gift!  How thoughtful!</b>  ");
			
			kGAMECLASS.itemScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.lootScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.useItemFunction = kGAMECLASS.mainGameMenu;
			kGAMECLASS.itemCollect([new CoCScholarsTea()]);
		}
		
		private function findGems():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and to your delight, it is filled to the brim with shining gems!");
			var gems:int = 2 + rand(20);
			output("\n\n<b>You've received " + num2Text(gems) + " shining gems from the kitsune's gift!  How generous!</b>");
			kGAMECLASS.pc.credits += gems * 10;
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function findThief():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it leaps into your item pouch, then hops away and gallavants into the woods, carting off a small fortune in gems.");
			output("\n\n<b>The kitsune's familiar has stolen your gems!</b>");
			//// Lose X gems as though losing in battle to a kitsune
			kGAMECLASS.pc.credits -= (2 + rand(15));
			if (kGAMECLASS.pc.credits < 0) kGAMECLASS.pc.credits = 0;
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		
		private function findPrank():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it pulls a large calligraphy brush from thin air and leaps up into your face, then hops away and gallavants off into the woods.  Touching your face experimentally, you come away with a fresh coat of black ink on your fingertips.");
			output("\n\n<b>The kitsune's familiar has drawn all over your face!</b>  The resilient marks take about an hour to completely scrub off in the nearby stream.  You could swear you heard some mirthful snickering among the trees while you were cleaning yourself off.");
			kGAMECLASS.processTime(50 + rand(20));
			kGAMECLASS.pc.lust( -20);
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function findKnowledge():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but it seems like there's nothing else inside.  As you peer into the box, a glowing circle filled with strange symbols suddenly flashes to life!  Light washes over you, and your mind is suddenly assaulted with new knowledge...  and the urge to use that knowledge for mischief!");
			output("\n\n<b>The kitsune has shared some of its knowledge with you!</b>  But in the process, you've gained some of the kitsune's promiscuous trickster nature...");
			////Increase INT and Libido, +10 LUST
			//game.dynStats("int", 4, "sen", 2, "lus", 10);
			kGAMECLASS.pc.slowStatGain("i", 4);
			kGAMECLASS.pc.addMischievous(2);
			kGAMECLASS.pc.lust(10);
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function findAphrodisiac():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it tosses a handful of sweet-smelling pink dust into your face, then hops over the rim of the box and gallavants off into the woods.  Before you know what has happened, you feel yourself growing hot and flushed, unable to keep your hands away from your groin.");
			output("\n\n<b>Oh no!  The kitsune's familiar has hit you with a powerful aphrodisiac!  You are debilitatingly aroused and can think of nothing other than masturbating.</b>");
			////+100 LUST
			kGAMECLASS.pc.lust(kGAMECLASS.pc.lustMax(), true);
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function findWither():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, and sitting in the center is an artfully crafted paper doll.  Before your eyes, the doll springs to life, dancing about fancifully.  Without warning, it tosses a handful of sour-smelling orange powder into your face, then hops over the rim of the box and gallavants off into the woods.  Before you know what has happened, you feel the strength draining from your muscles, withering away before your eyes.");
			output("\n\n<b>Oh no!  The kitsune's familiar has hit you with a strength draining spell!  Hopefully it's only temporary...</b>");
			//game.dynStats("str", -5, "tou", -5);
			kGAMECLASS.pc.physique( -5);
			kGAMECLASS.pc.energy((kGAMECLASS.pc.energy() / 4) - kGAMECLASS.pc.energy());
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function findDud():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but to your disappointment, the only other contents appear to be nothing more than twigs, leaves, and other forest refuse.");
			output("\n\n<b>It seems the kitsune's gift was just a pile of useless junk!  What a ripoff!</b>");
			clearMenu();
			addButton(0, "Next", kGAMECLASS.mainGameMenu);
		}
		
		private function findChitin():void {
			output("As the paper falls away, you carefully lift the cover of the box, your hands trembling nervously.  The inside of the box is lined with purple velvet, but to your disappointment, the only other contents appear to be nothing more than twigs, leaves, and other forest refuse.  Upon further investigation, though, you find a shard of shiny black chitinous plating mixed in with the other useless junk.");
			output("\n\n<b>At least you managed to salvage a shard of black chitin from it...</b>  ");
			
			kGAMECLASS.itemScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.lootScreen = kGAMECLASS.mainGameMenu;
			kGAMECLASS.useItemFunction = kGAMECLASS.mainGameMenu;
			kGAMECLASS.itemCollect([new CoCBlackChitin()]);
		}
	}
}
