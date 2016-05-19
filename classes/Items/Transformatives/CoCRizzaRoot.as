package classes.Items.Transformatives
{
	import classes.Creature;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.GameData.TooltipManager;
	import classes.GLOBAL;
	import classes.ItemSlotClass;
	import classes.StringUtil;
	import classes.Util.*;
	
	public class CoCRizzaRoot extends ItemSlotClass
	{
		public function CoCRizzaRoot(dataObject:Object=null)
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 10;
			this.type = GLOBAL.PILL;
			//Used on inventory buttons
			this.shortName = "RizzaRt";
			//Regular name
			this.longName = "tube of rizza root strands";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a tube of rizza root strands";
			//Displayed on tooltips during mouseovers
			this.tooltip = "A small ceramic tube full of fine red root strands.  They smell something like citrus fruit.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			//Information
			this.basePrice = 100;
			
			this.version = this._latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean
		{
			clearOutput();
			var temp:Number = 0;
			var changes:int = 0;
			var changeLimit:int = 1;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			if (target.hasPerk("History: Alchemist")) changeLimit++;
			if (target.hasPerk("Transformation Resistance")) changeLimit--;
			
			output("You chew on the thin red roots. They have a rubbery texture and the taste is something like lemons and oranges mixed together. The roots dry out your mouth as you chew them but at the same time they cause a cooling and numbing sensation that’s rather pleasant.");
			
			if (changes < changeLimit && target.skinType != GLOBAL.SKIN_TYPE_SKIN && rand(6) == 0)
			{
				if (target.skinTypeUnlocked(GLOBAL.SKIN_TYPE_SKIN))
				{
					if (target.skinType == GLOBAL.SKIN_TYPE_FUR)
						output("\n\nYour fur itches incessantly, so you start scratching it.  It starts coming off in big clumps before the whole mess begins sloughing off your body.  In seconds, your skin is hairless, or nearly so. <b>You've lost your fur!</b>");
					else if (target.skinType == GLOBAL.SKIN_TYPE_SCALES)
						output("\n\nYour scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your scales!</b>");
					else
						output("\n\nYour " + target.skinFurScales(false, true) + " itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin. <b>Your skin is once again normal!</b>");
					
					target.skinType = GLOBAL.SKIN_TYPE_SKIN;
					changes += 2;
				}
				else output("\n\n" + target.skinTypeLockedMessage());
			}
			
			if (changes < changeLimit && target.earType != GLOBAL.TYPE_SYLVAN && rand(4) == 0)
			{
				if (target.earTypeUnlocked(GLOBAL.TYPE_SYLVAN))
				{
					target.earType = GLOBAL.TYPE_SYLVAN;
					target.earLength = 4;
					output("\n\nA weird tingling runs through your scalp as your " + target.hairDescript() + " shifts slightly.  You reach up and your hand bumps against <b>your new pointed elfin ears</b>.  You bet they look cute!");
					changes++;
				}
				else output("\n\n" + target.earTypeLockedMessage());
			}
			
			var wings:int = target.cor() < 50 ? GLOBAL.TYPE_SYLVAN : GLOBAL.TYPE_DARK_SYLVAN;
			
			if (changes < changeLimit && !target.hasWings(wings) && rand(4) == 0)
			{
				if (target.wingTypeUnlocked(wings))
				{
					if(target.wingType == 0)
					{
						if(wings == GLOBAL.TYPE_SYLVAN) // Sylvanol copy-paste
							output("\n\nThere’s a budding sensation at your back, an odd pressure that soon leads you to gasp at the sensation of something along your back splitting open like a cocoon to allow a quartet of light blue wings to unfold. Each is a magnificent gossamer beauty, together forming a set of radiant butterfly-like wings. <b>You now have fairy wings!</b>");
						else
							output("\n\nThere’s a budding sensation at your back, an odd pressure that soon leads you to gasp at the sensation of something along your back splitting open like a cocoon to allow a quartet of glittering black wings to unfold. Each is a magnificent gossamer beauty, together forming a set of butterfly-like wings coated in what looks like wisps of shadow. <b>You now have shadowy fairy wings!</b>");
					}
					else
					{
						if(wings == GLOBAL.TYPE_SYLVAN)
							output("\n\nYour [pc.wings] feel strange, and you look behind you to see them melting into a new, delicate-looking form. By the time they finish transforming they’ve become a quartet of light blue gossamer wings, together forming a set of radiant butterfly-like wings. <b>You now have fairy wings!</b>");
						else
							output("\n\nYour [pc.wings] feel strange, and you look behind you to see them melting into a new, delicate-looking form. By the time they finish transforming they’ve become a quartet of glittering black gossamer wings, together forming a set of butterfly-like wings coated in what looks like wisps of shadow. <b>You now have shadowy fairy wings!</b>");
					}
					target.shiftWings(wings, 4);
					changes += 2;
				}
				else output("\n\n" + target.wingTypeLockedMessage());
			}
			
			if ((changes < changeLimit) && (target.tallness < 108))
			{
				target.tallness += changeLimit - changes + rand(2); //Add remaining changes as additional height
				if (target.tallness > 108) target.tallness = 108;
				output("\n\nA shiver runs down your spine.  You realize that it, along with the rest of your frame, is now a bit taller.");
			}
			else if (target.tallness >= 108)
			{
				output("\n\nYou don’t feel anything happening along your spine.  Perhaps this is as tall as the rizza root can make you.");
			}
			
			IncrementFlag("COC.TIMES_TRANSFORMED");
			return false;
		}
	}	
}
