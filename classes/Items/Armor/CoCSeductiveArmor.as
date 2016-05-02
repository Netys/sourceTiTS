package classes.Items.Armor 
{
	import classes.Characters.PlayerCharacter;
	import classes.Creature;
	import classes.Engine.Interfaces.output;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.GameData.TooltipManager;
	
	public class CoCSeductiveArmor extends ItemSlotClass
	{
		// super("SeductA", "SeductA", "scandalously seductive armor", "a set of scandalously seductive armor", 0, 1, "A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.");
		public function CoCSeductiveArmor() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.ARMOR;
			
			this.shortName = "SeductA";
			
			this.longName = "scandalously seductive armor";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a set of scandalously seductive armor";
			
			this.tooltip = "A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 0;
			this.attack = 0;
			this.defense = 2;
			this.shieldDefense = 0;
			this.sexiness = 4;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			itemFlags.push(GLOBAL.ITEM_FLAG_EXPOSE_ASS);
			
			this.version = this._latestVersion;
		}
		
		override public function onEquip(targetCreature:Creature):void
		{
			if (!(targetCreature is PlayerCharacter)) return;
			
			if (!kGAMECLASS.ceraphIsFollower()) {
				output("After struggling to get it on, you feel a sudden shift in your scandalous new armor.  To your horror, it begins folding into itself, revealing more and more of your [pc.skinFurScales].  The transforming armor gradually covers less and less of you until it's little more than a pair of huge nipple-coverings and a silver chain.  A loud KA-CHUNK startles you, and then you're screaming as you feel something stabbing through your nipples.  Goosebumps cover your flesh as you twist in unexpected agony.\n\n");
				output("After you've had a chance to recover, you inspect your abused nipples and discover that your armor has totally disappeared.  The only thing left behind is a pair of seamless black nipple-studs, embedded into your vulnerable flesh.  There doesn't appear to be any way to remove them either.  The thought of having to run around naked stays stubbornly locked in your mind, and you mentally curse the demon for what she's done to you.\n\n");
				output("As if summoned by your thoughts, you can hear her voice on the wind, taunting you again, \"<i>Enjoy your new bondage fetish, pet!  One more piercing and you'll be ready.  Don't have too much fun being tied down and fucked, ok?</i>\"\n\n");
				if (targetCreature.nipplesPierced > 0) output("You're left to wonder - where did the old piercings go?\n\n");
				targetCreature.nipplesPierced = 1;
				targetCreature.nipplesPShort = "seamless black nipple-studs";
				targetCreature.nipplesPLong = "Seamless black nipple-studs";
				targetCreature.flags["COC.PC_FETISH"] = 2;
			}
			else {
				output("As you're trying to put on the armor, Ceraph appears from nowhere, apologizing profusely and stopping you before you can slide the last strap into place.  \"<i>Please don't put that on, " + targetCreature.mf("Master","Mistress") + ".  I trapped that armor to pierce new fetishes the unwary so that I could add them to my harem.  I'd hate to garner your anger.</i>\"  She wrings her hands nervously.  \"<i>If you'll hand it here, I'll get rid of it for you. Noone would buy it anyway.</i>\"");
				output("\n\nYou shrug and toss her the armor, disappointed that you're down a potentially sexy outfit.");
				output("\n\nCeraph bows gratefully and swiftly backpedals, offering, \"<i>And if you ever want me to stuff you full of magic fetishes, just ask, okay?</i>\"");
				output("\n\nShe's gone before you can reply.  Sometimes she's more trouble than she's worth.");
			}
			
			targetCreature.armor = new EmptySlot();
		}
	}
}