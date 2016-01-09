package classes.Items.Transformatives
{
	import classes.CockClass;
	import classes.Creature;
	import classes.Engine.Utility.rand;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.kGAMECLASS;
	import classes.StringUtil;
	import classes.Util.InCollection;
	import classes.Engine.Utility.num2Text;
	
    public class CoCImpFood extends ItemSlotClass
    {
        public function CoCImpFood(dataObject:Object=null)
        {
            this._latestVersion = 1;
            
            this.quantity = 1;
            this.stackSize = 5;
            this.type = GLOBAL.POTION;
            //Used on inventory buttons
            this.shortName = "ImpFood";
            //Regular name
            this.longName = "Imp food";
            
            TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
            
            //Longass shit, not sure what used for yet.
            this.description = "a parcel of imp food";
            //Displayed on tooltips during mouseovers
            this.tooltip = "This is a small parcel of reddish-brown bread stuffed with some kind of meat.  It smells delicious.";
            
            TooltipManager.addTooltip(this.shortName, this.tooltip);
            
            
            //Information
            this.basePrice = 60;
            
            this.version = this._latestVersion;
        }
        
        //METHOD ACTING!
        override public function useFunction(pc:Creature, usingCreature:Creature = null):Boolean
        {
			kGAMECLASS.clearOutput();
			kGAMECLASS.output("The food tastes strange and corrupt - you can't really think of a better word for it, but it's unclean.");
			//pc.refillHunger(20);
			
			if (pc.hasCock() && pc.shortestCockLength() < 12) {
				var arg:int = pc.shortestCockIndex();
				kGAMECLASS.output("\n\nYour hand strays to your [pc.cock " + arg + "] without conscious thought. On noticing it, you merely smile, admiring the shape of your swollen length, like your hand belongs there. Your arm begins to pump, dragging your hand up and down the length, pleasuring yourself before you have a chance to react, and you just slump back, jacking on your [pc.cock " + arg + "] as it feels better and better.");
				var temp:Number = rand(2) + 2;		
				if(pc.hasPerk("Hung")) temp += 1;
				pc.cocks[pc.shortestCockIndex()].cLength(temp);
				kGAMECLASS.output("\n\nThis is way more pleasurable than any normal masturbation! You don't really recall being able to take such long strokes along your length or having it fill your hand so powerfully, throbbing just like the drug's namesake. Looking down, you gasp. Your [pc.cock " + arg + "] is at least two inches longer and still growing! You tug it to help it on its way, moaning as it slops big ropes of pre onto your knuckles. <b>You've gained " + kGAMECLASS.num2Text(temp) + " inches of length!</b>");
			}
			
			kGAMECLASS.output("\n\nInhuman vitality spreads through your body, invigorating you!\n");
			pc.HP(30 + pc.HPMax() / 3);
			pc.lust(3);
			pc.cor(1);
			
			//Shrinkage!
			if (rand(2) == 0 && pc.tallness > 42) {
				kGAMECLASS.output("\n\nYour skin crawls, making you close your eyes and shiver.  When you open them again the world seems... different.  After a bit of investigation, you realize you've become shorter!\n");
				pc.tallness -= 1 + rand(3);
			}
			
			//Red skin!
			if (rand(30) == 0 && pc.skinTone != "red") {
				kGAMECLASS.output("\n\nYour " + pc.skin(true));
				if (rand(2) == 0) pc.skinTone = "red";
				else pc.skinTone = "orange";
				kGAMECLASS.output(" begins to lose its color, fading until you're as white as an albino.  Then, starting at the crown of your head, a reddish hue rolls down your body in a wave, turning you completely [pc.skinColor].");
			}
			return false;
		}
	}	
}
