package classes.Engine.Utility
{
	import classes.kGAMECLASS;
	import classes.Creature;
	import classes.GLOBAL;
	import classes.StringUtil;
	import classes.Util.*;
	import classes.Engine.Interfaces.*;
	import classes.Engine.Utility.*;
	import classes.VaginaClass;
	
	/**
	 * This is generic mutation engine to use when you don't want to write custom transition scenes. All functions here should return either number of changes done or boolean if any changes done. Changes should be atomic when it makes sense.
	 * 
	 * TODO: anticlass for growTits to shrink towards configuration. Same thing for cocks.
	 * 
	 * TODO: slice and dice appearance.as and use it's parts to describe before and after states.
	 * 
	 * @author Etis
	 */
	public class Mutator
	{
		public static var buffer:String = "";
		
		/**
		 * Change target ears.
		 * @param	target
		 * @param	newType
		 * @param	newLength
		 * @param	display
		 * @return is something changed
		 */
		public static function changeEars(target:Creature, newType:int, newLength:Number = 0, display:Boolean = true):Boolean {
			// see also: Creature.hasLongEars
			var supportsLength:Array = [GLOBAL.TYPE_SYLVAN, GLOBAL.TYPE_RASKVEL, GLOBAL.TYPE_GABILANI, GLOBAL.TYPE_DEMONIC, GLOBAL.TYPE_LEITHAN];
			// TODO: location type (top/side)
			
			// check if already
			if (target.earType == newType && (target.earLength == newLength || !InCollection(target.earType, supportsLength))) return false;
			
			buffer = "";
			var changes:Number = 0;
			
			if(target.earType != newType)
			{
				if (target.earTypeUnlocked(newType))
				{
					//if (InCollection(target.earType, [GLOBAL.TYPE_HUMAN, GLOBAL.TYPE_HUMANMASKED, ]))
						//buffer += "\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. ";
					
					buffer += "\n\nYour " + target.earsDescript(true, true) + " begin to tingle. You reach up with one [pc.hand] and gently rub them. Your ears twist and morph as they reshape.";
					target.earType = newType;
					buffer += " <b>You now have " + target.earsDescript(true, true) + "!</b>";
					changes++;
				}
				else buffer += "\n\n" + target.earTypeLockedMessage();
			}
			
			if(InCollection(target.earType, supportsLength) && target.earLength != newLength)
			{
				buffer += "\n\nYour " + target.earsDescript(true, true) + " are twitching. You reach up to check them.";
				target.earLength = newLength;
				buffer += " <b>You now have " + num2Text(Math.round(target.earLength)) + "-inch long ears!</b>";
				changes++;
			}
			
			if (display) output(buffer);
			
			return changes > 0;
		}
		
		/**
		 * Change target hair type. Changing type is atomic with flags. Changing color is not atomic.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current.
		 * @param	newColors possible color options for skin/fur/scales depending on new type, can be null to leave current.
		 * @param	newFlags flags to add, both during type change and as standalone.
		 * @param	keepFlags flags which would remain during type change if present, but not added if not. Note, no need to double newFlags here.
		 * @param	removeFlags flags which would be removed if present. Note, all flags not in keep list would be removed during type change. Only to change flags without changing type.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeHair(target:Creature, newType:int, newColors:/*String*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newColors == null) newColors = [];
			
			if (newType == -1) newType = target.hairType;
			
			var item:int;
			
			var newColor:String;
			var newHair:String = "";
			if (newType == GLOBAL.HAIR_TYPE_REGULAR)
				newHair = "hair";
			if (newType == GLOBAL.HAIR_TYPE_FEATHERS)
				newHair = "feather plume";
			if (newType == GLOBAL.HAIR_TYPE_TRANSPARENT)
				newHair = "transparent hair";
			if (newType == GLOBAL.SKIN_TYPE_GOO)
				newHair = "gooey hair";
			if (newType == GLOBAL.HAIR_TYPE_TENTACLES)
				newHair = "tentacle hair";
			
			// basic case - change type
			if(target.hairType != newType)
			{
				if (!target.hairTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.hairTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				buffer += "\n\nYour head is itching...";
				if (target.hasHair()) {
					buffer += " Your " + target.hairDescript(true, true) + " is changing!";
					
					// what is lost
					if (target.hairType == GLOBAL.HAIR_TYPE_REGULAR) buffer += " Your hair is changing into ";
					if (target.hairType == GLOBAL.HAIR_TYPE_FEATHERS) buffer += " You feathers are reforming into ";
					if (target.hairType == GLOBAL.HAIR_TYPE_TRANSPARENT) buffer += " You hair is losing it's transparency, changing into ";
					if (target.hairType == GLOBAL.HAIR_TYPE_GOO) buffer += " Your hair is solidifying into ";
					if (target.hairType == GLOBAL.HAIR_TYPE_TENTACLES) buffer += " Tentacles on your head are withering, changing into ";
					//what is not changed or gained
					if (newType == GLOBAL.HAIR_TYPE_REGULAR) buffer += "human-like hair.";
					if (newType == GLOBAL.HAIR_TYPE_FEATHERS) buffer += "feather plume.";
					if (newType == GLOBAL.HAIR_TYPE_TRANSPARENT) buffer += "halo of ghostly locks.";
					if (newType == GLOBAL.HAIR_TYPE_GOO) buffer += "heap of semi-liquid goo.";
					if (newType == GLOBAL.HAIR_TYPE_TENTACLES) buffer += "crown of wriggling tentacles.";
				} else buffer += " Is something changing?";
				
				if (newColors.length > 0 && !InCollection(target.hairColor, newColors)) {
					newColor = RandomInCollection(newColors);
					if (target.hairColorUnlocked(newColor)) {
						target.hairColor = newColor;
						if(target.hasHair()) buffer += " Your " + newHair + " is " + newColor + " now.";
						changes++;
					}
				}
				
				target.hairType = newType;
				
				if(target.hasHair()) buffer += " <b>You now have " + target.hairDescript(true, true) + "!</b>";
				
				changes++;
				if (display) output(buffer);
				return changes > 0;
			}
			
			if (newColors.length > 0 && !InCollection(target.hairColor, newColors)) {
				newColor = RandomInCollection(newColors);
				if(target.hairColorUnlocked(newColor)) {
					target.hairColor = newColor;
					if(target.hasHair())  {
						buffer += "\n\nYour head is itching...";
						buffer += " Your " + newHair + " is " + newColor + " now.";
						buffer += " <b>You now have " + target.hairDescript(true, true) + "!</b>";
					} else buffer += " Is something changing?";
					changes++;
				} else buffer += "\n\n" + target.hairColorLockedMessage();
			}
			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target face. Changing type is atomic with flags.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current
		 * @param	newFlags flags to add, both during type change and as standalone.
		 * @param	keepFlags flags which would remain during type change if present, but not added if not. Note, no need to double newFlags here.
		 * @param	removeFlags flags which would be removed if present. Note, all flags not in keep list would be removed during type change. Only to change flags without changing type.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeFace(target:Creature, newType:int, newFlags:/*int*/Array = null, keepFlags:/*int*/Array = null, removeFlags:/*int*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newFlags == null) newFlags = [];
			if (keepFlags == null) keepFlags = [];
			if (removeFlags == null) removeFlags = [];
			
			if (newType == -1) newType = target.faceType;
				
			var toKeep:/*int*/Array = [];
			var toRemove:/*int*/Array = [];
			
			var item:int;
			
			// basic case - change type
			if(target.faceType != newType)
			{
				if (!target.faceTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.faceTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				// building keep/remove flags list to build flavored transition scene
				for each (item in target.faceFlags) {
					if (InCollection(item, keepFlags)) toKeep.push(item);
					else if (InCollection(item, newFlags)) toKeep.push(item);
					else toRemove.push(item); // since we are changing type now, ALL flags not in keep/add list are removed anyways
				}
				
				buffer += "\n\nYour " + target.face(true) + " is losing it's " + GLOBAL.TYPE_NAMES[target.faceType].toLowerCase() + " form.";
				
				// what is lost
				enum.clear();
				if (InCollection(GLOBAL.FLAG_SMOOTH, toRemove)) enum.push("smooth");
				if (InCollection(GLOBAL.FLAG_LONG, toRemove)) enum.push("long");
				if (InCollection(GLOBAL.FLAG_ANGULAR, toRemove)) enum.push("angular");
				if (InCollection(GLOBAL.FLAG_MUZZLED, toRemove)) enum.push("muzzled");
				if (!enum.isEmpty()) {
					buffer += " You don't have a " + enum.toString() + " face anymore.";
				}
				//what is not changed or gained
				enum.clear();
				if (InCollection(GLOBAL.FLAG_SMOOTH, newFlags)) enum.push("smooth");
				if (InCollection(GLOBAL.FLAG_LONG, newFlags)) enum.push("long");
				if (InCollection(GLOBAL.FLAG_ANGULAR, newFlags)) enum.push("angular");
				if (InCollection(GLOBAL.FLAG_MUZZLED, newFlags)) enum.push("muzzled");
				if (!enum.isEmpty()) {
					buffer += " Now you have " + enum.toString() + " face.";
				}
				
				target.faceType = newType;
				target.faceFlags = newFlags;
				
				buffer += " <b>You now have " + target.face(true) + " appropriate for " + GLOBAL.TYPE_NAMES[newType].toLowerCase() + " body!</b>";
				
				changes++;
				if (display) output(buffer);
				return changes > 0;
			}
			
			// changing flags without changing type
			var flagsUnlocked:Boolean = true;
			for each (item in newFlags) {
				if (target.hasFaceFlag(item)) continue; // skip existing
				//if (!target.faceFlagsUnlocked(item)) flagsUnlocked = false; // no such function
				toKeep.push(item);
			}
			
			for each (item in removeFlags) {
				if (!target.hasFaceFlag(item)) continue; // skip not present
				//if (!target.faceFlagsUnlocked(item)) flagsUnlocked = false; // no such function
				toRemove.push(item);
			}
			
			if (toKeep.length > 0 || toRemove.length > 0) {
				if (flagsUnlocked) {
					buffer += "\n\nYour " + target.face(true) + " are itching, twitching and... Changing.";
				
					for each (item in toRemove) {
						if (item == GLOBAL.FLAG_SMOOTH) buffer += " Your face is not as smooth as it was.";
						if (item == GLOBAL.FLAG_LONG) buffer += " Your face shortens.";
						if (item == GLOBAL.FLAG_MUZZLED) buffer += " Your face is not resembling animal muzzle anymore.";
						if (item == GLOBAL.FLAG_ANGULAR) buffer += " Your face is not as angular as it was.";
						target.faceFlags.splice(target.faceFlags.indexOf(item), 1);
					}
				
					for each (item in toKeep)
					{
						if (item == GLOBAL.FLAG_SMOOTH) buffer += " Your face is very smooth now.";
						if (item == GLOBAL.FLAG_LONG) buffer += " Your face elongates.";
						if (item == GLOBAL.FLAG_MUZZLED) buffer += " Your face is gaining feral muzzle.";
						if (item == GLOBAL.FLAG_ANGULAR) buffer += " Your face is gaining rough angles.";
						target.addFaceFlag(item);
					}
					
					changes++;
				} //else buffer += "\n\n" + target.faceFlagsLockedMessage();
			}
			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target eyes. Type is NOT atomic with color, but color IS atomic with type. Color can be independant.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeEyes(target:Creature, newType:int, newColors:/*String*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newColors == null) newColors = [];			
			if (newType == -1) newType = target.eyeType;
				
			var toKeep:/*int*/Array = [];
			var toRemove:/*int*/Array = [];
			
			var newColor:String;
			var item:int;
			
			// basic case - change type
			if(target.eyeType != newType)
			{
				if (!target.eyeTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.eyeTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				buffer += "\n\nYour " + target.eyesDescript() + " are suddenly filled with tears and " + target.eyeColor + " mist... They are changing!";
				
				target.eyeType = newType;

				if (newColors.length > 0 && !InCollection(target.eyeColor, newColors)) {
					newColor = RandomInCollection(newColors);
					if(target.eyeColorUnlocked(newColor)) {
						buffer += " Your " + target.eyeColor + " eyes color changed to ";
						target.eyeColor = RandomInCollection(newColors);
						buffer += target.eyeColor + "!";
						changes++;
					}
				}
				
				buffer += " <b>You now have " + target.eyeColor + " " + GLOBAL.TYPE_NAMES[newType].toLowerCase() + " eyes!</b>";
				
				changes++;
				if (display) output(buffer);
				return changes > 0;
			}
			
			if (newColors.length > 0 && !InCollection(target.eyeColor, newColors)) {
				newColor = RandomInCollection(newColors);
				if(target.eyeColorUnlocked(newColor)) {
					buffer += "\n\nYour " + target.eyesDescript() + " are suddenly filled with tears and " + target.eyeColor + " mist... They are changing!";
					buffer += " Your " + target.eyeColor + " eyes color changed to ";
					target.eyeColor = RandomInCollection(newColors);
					buffer += target.eyeColor + "!";
					buffer += " <b>You now have " + target.eyesDescript() + "!</b>";
					changes++;
				} else buffer += "\n\n" + target.eyeColorLockedMessage();
			}			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target tongue. Changing type is atomic with flags.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current
		 * @param	newFlags flags to add, both during type change and as standalone.
		 * @param	keepFlags flags which would remain during type change if present, but not added if not. Note, no need to double newFlags here.
		 * @param	removeFlags flags which would be removed if present. Note, all flags not in keep list would be removed during type change. Only to change flags without changing type.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeTongue(target:Creature, newType:int, newFlags:/*int*/Array = null, keepFlags:/*int*/Array = null, removeFlags:/*int*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newFlags == null) newFlags = [];
			if (keepFlags == null) keepFlags = [];
			if (removeFlags == null) removeFlags = [];
			
			if (newType == -1) newType = target.tongueType;
				
			var toKeep:/*int*/Array = [];
			var toRemove:/*int*/Array = [];
			
			var item:int;
			
			// basic case - change type
			if(target.tongueType != newType)
			{
				if (!target.tongueTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.tongueTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				// building keep/remove flags list to build flavored transition scene
				for each (item in target.tongueFlags) {
					if (InCollection(item, keepFlags)) toKeep.push(item);
					else if (InCollection(item, newFlags)) toKeep.push(item);
					else toRemove.push(item); // since we are changing type now, ALL flags not in keep/add list are removed anyways
				}
				
				buffer += "\n\nYour " + target.tongueDescript() + " is itching, twitching and... Changing.";
				
				// what is lost
				if (InCollection(GLOBAL.FLAG_LONG, toRemove)) buffer += " Your tongue shortens.";
				if (InCollection(GLOBAL.FLAG_PREHENSILE, toRemove)) buffer += " Your tongue is no longer prehensile.";
				if (InCollection(GLOBAL.FLAG_HOLLOW, toRemove)) buffer += " Your tongue is no longer hollow.";
				if (InCollection(GLOBAL.FLAG_LUBRICATED, toRemove)) buffer += " Your tongue is no longer lubricated.";
				if (InCollection(GLOBAL.FLAG_SQUISHY, toRemove)) buffer += " Your tongue is no longer squishy.";
				if (InCollection(GLOBAL.FLAG_APHRODISIAC_LACED, toRemove)) buffer += " Your tongue is no longer aphrodisiac laced.";
				if (InCollection(GLOBAL.FLAG_GOOEY, toRemove)) buffer += " Your tongue is no longer gooey.";
				if (InCollection(GLOBAL.FLAG_STICKY, toRemove)) buffer += " Your tongue is no longer sticky.";
				//what is not changed or gained
				if (InCollection(GLOBAL.FLAG_LONG, toKeep)) buffer += " Your tongue is still quite long.";
				else if (InCollection(GLOBAL.FLAG_LONG, newFlags)) buffer += " Your tongue elongates.";
				if (InCollection(GLOBAL.FLAG_PREHENSILE, toKeep)) buffer += " Your tongue is still prehensile.";
				else if (InCollection(GLOBAL.FLAG_PREHENSILE, newFlags)) buffer += " Your tongue is now prehensile.";
				if (InCollection(GLOBAL.FLAG_HOLLOW, toKeep)) buffer += " Your tongue is still hollow.";
				else if (InCollection(GLOBAL.FLAG_HOLLOW, newFlags)) buffer += " Your tongue is now hollow.";
				if (InCollection(GLOBAL.FLAG_LUBRICATED, toKeep)) buffer += " Your tongue is still lubricated.";
				else if (InCollection(GLOBAL.FLAG_LUBRICATED, newFlags)) buffer += " Your tongue is now lubricated.";
				if (InCollection(GLOBAL.FLAG_SQUISHY, toKeep)) buffer += " Your tongue is still squishy.";
				else if (InCollection(GLOBAL.FLAG_SQUISHY, newFlags)) buffer += " Your tongue is now squishy.";
				if (InCollection(GLOBAL.FLAG_APHRODISIAC_LACED, toKeep)) buffer += " Your tongue is still aphrodisiac laced.";
				else if (InCollection(GLOBAL.FLAG_APHRODISIAC_LACED, newFlags)) buffer += " Your tongue is now aphrodisiac laced.";
				if (InCollection(GLOBAL.FLAG_GOOEY, toKeep)) buffer += " Your tongue is still gooey.";
				else if (InCollection(GLOBAL.FLAG_GOOEY, newFlags)) buffer += " Your tongue is now gooey.";
				if (InCollection(GLOBAL.FLAG_STICKY, toKeep)) buffer += " Your tongue is still sticky.";
				else if (InCollection(GLOBAL.FLAG_STICKY, newFlags)) buffer += " Your tongue is now sticky.";
				
				target.tongueType = newType;
				target.tongueFlags = newFlags;
				
				buffer += " <b>You now have " + target.tongueDescript() + "!</b>";
				
				changes++;				
				if (display) output(buffer);
				return changes > 0;
			}
			
			// changing flags without changing type
			var flagsUnlocked:Boolean = true;
			for each (item in newFlags) {
				if (target.hasTongueFlag(item)) continue; // skip existing
				//if (!target.tongueFlagsUnlocked(item)) flagsUnlocked = false; // no such function
				toKeep.push(item);
			}
			
			for each (item in removeFlags) {
				if (!target.hasTongueFlag(item)) continue; // skip not present
				//if (!target.tongueFlagsUnlocked(item)) flagsUnlocked = false; // no such function
				toRemove.push(item);
			}
			
			if (toKeep.length > 0 || toRemove.length > 0) {
				if (flagsUnlocked) {
					buffer += "\n\nYour " + target.tongueDescript() + " is itching, twitching and... Changing.";
				
					for each (item in toRemove) {
						if (item == GLOBAL.FLAG_LONG) buffer += " Your tongue shortens.";
						if (item == GLOBAL.FLAG_PREHENSILE) buffer += " Your tongue is no longer prehensile.";
						if (item == GLOBAL.FLAG_HOLLOW) buffer += " Your tongue is no longer hollow.";
						if (item == GLOBAL.FLAG_LUBRICATED) buffer += " Your tongue is no longer lubricated.";
						if (item == GLOBAL.FLAG_SQUISHY) buffer += " Your tongue is no longer squishy.";
						if (item == GLOBAL.FLAG_APHRODISIAC_LACED) buffer += " Your tongue is no longer aphrodisiac laced.";
						if (item == GLOBAL.FLAG_GOOEY) buffer += " Your tongue is no longer gooey.";
						if (item == GLOBAL.FLAG_STICKY) buffer += " Your tongue is no longer sticky.";
						target.tongueFlags.splice(target.tongueFlags.indexOf(item), 1);
					}
				
					for each (item in toKeep)
					{
						if (item == GLOBAL.FLAG_LONG) buffer += " Your tongue elongates.";
						if (item == GLOBAL.FLAG_PREHENSILE) buffer += " Your tongue is now prehensile.";
						if (item == GLOBAL.FLAG_HOLLOW) buffer += " Your tongue is now hollow.";
						if (item == GLOBAL.FLAG_LUBRICATED) buffer += " Your tongue is now lubricated.";
						if (item == GLOBAL.FLAG_SQUISHY) buffer += " Your tongue is now squishy.";
						if (item == GLOBAL.FLAG_APHRODISIAC_LACED) buffer += " Your tongue is now aphrodisiac laced.";
						if (item == GLOBAL.FLAG_GOOEY) buffer += " Your tongue is now gooey.";
						if (item == GLOBAL.FLAG_STICKY) buffer += " Your tongue is now sticky.";
						target.addTongueFlag(item);
					}
					
					changes++;
				} //else buffer += "\n\n" + target.tongueFlagsLockedMessage();
			}
			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target arms. Changing type is atomic with flags.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current
		 * @param	newFlags flags to add, both during type change and as standalone.
		 * @param	keepFlags flags which would remain during type change if present, but not added if not. Note, no need to double newFlags here.
		 * @param	removeFlags flags which would be removed if present. Note, all flags not in keep list would be removed during type change. Only to change flags without changing type.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeArms(target:Creature, newType:int, newFlags:/*int*/Array = null, keepFlags:/*int*/Array = null, removeFlags:/*int*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newFlags == null) newFlags = [];
			if (keepFlags == null) keepFlags = [];
			if (removeFlags == null) removeFlags = [];
			
			if (newType == -1) newType = target.armType;
				
			var toKeep:/*int*/Array = [];
			var toRemove:/*int*/Array = [];
			
			var item:int;
			
			// basic case - change type
			if(target.armType != newType)
			{
				if (!target.armTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.armTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				 // building keep/remove flags list to build flavored transition scene
				for each (item in target.armFlags) {
					if (InCollection(item, keepFlags)) toKeep.push(item);
					else if (InCollection(item, newFlags)) toKeep.push(item);
					else toRemove.push(item); // since we are changing type now, ALL flags not in keep/add list are removed anyways
				}
				
				buffer += "\n\nYour " + target.armsDescript(true) + " are losing their " + GLOBAL.TYPE_NAMES[target.armType].toLowerCase() + " form.";
				
				// Screw this shit, native adjective picking function is fine here.
				
				target.armType = newType;
				target.armFlags = newFlags;
				
				buffer += " <b>You now have " + target.armsDescript(true) + " appropriate for " + GLOBAL.TYPE_NAMES[target.armType].toLowerCase() + " body!</b>";
				
				changes++;
				if (display) output(buffer);
				return changes > 0;
			}
			
			// changing flags without changing type
			var flagsUnlocked:Boolean = true;
			for each (item in newFlags) {
				if (target.hasArmFlag(item)) continue; // skip existing
				//if (!target.armFlagsUnlocked(item)) flagsUnlocked = false; // no such function
				toKeep.push(item);
			}
			
			for each (item in removeFlags) {
				if (!target.hasArmFlag(item)) continue; // skip not present
				//if (!target.armFlagsUnlocked(item)) flagsUnlocked = false; // no such function
				toRemove.push(item);
			}
			
			if (toKeep.length > 0 || toRemove.length > 0) {
				if (flagsUnlocked) {
					buffer += "\n\nYour " + target.armsDescript(true) + " are changing.";
					
					enum.clear();
					for each (item in toRemove) {
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_FURRED) enum.push(RandomInCollection("furred", "furry"));
						if (item == GLOBAL.FLAG_SCALED) enum.push(RandomInCollection("scaled", "scaly"));
						if (item == GLOBAL.FLAG_CHITINOUS) enum.push(RandomInCollection("chitinous", "armored"));
						if (item == GLOBAL.FLAG_FEATHERED) enum.push(RandomInCollection("feathered", "feathery"));
						if (item == GLOBAL.FLAG_GOOEY) enum.push(RandomInCollection("slimy", "slick", "gooey"));
						if (item == GLOBAL.FLAG_SPIKED) enum.push(RandomInCollection("spiked", "spiky", "prickly"));
						if (item == GLOBAL.FLAG_STICKY) enum.push("sticky");
						if (item == GLOBAL.FLAG_PAWS) enum.push("paw-like");
						if (item == GLOBAL.FLAG_AMORPHOUS) enum.push(RandomInCollection("amorphous", "gooey"));
						target.armFlags.splice(target.armFlags.indexOf(item), 1);
					}
					if (!enum.isEmpty()) {
						buffer += " They are not " + enum.toString() + " anymore.";
					}
					enum.clear();
					for each (item in toKeep)
					{
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_FURRED) enum.push(RandomInCollection("furred", "furry"));
						if (item == GLOBAL.FLAG_SCALED) enum.push(RandomInCollection("scaled", "scaly"));
						if (item == GLOBAL.FLAG_CHITINOUS) enum.push(RandomInCollection("chitinous", "armored"));
						if (item == GLOBAL.FLAG_FEATHERED) enum.push(RandomInCollection("feathered", "feathery"));
						if (item == GLOBAL.FLAG_GOOEY) enum.push(RandomInCollection("slimy", "gooey"));
						if (item == GLOBAL.FLAG_SPIKED) enum.push(RandomInCollection("spiked", "spiky", "prickly"));
						if (item == GLOBAL.FLAG_STICKY) enum.push("sticky");
						if (item == GLOBAL.FLAG_PAWS) enum.push("paw-like");
						if (item == GLOBAL.FLAG_AMORPHOUS) enum.push(RandomInCollection("amorphous"));
						target.addArmFlag(item);
					}
					if (!enum.isEmpty()) {
						buffer += " They are now " + enum.toString() + ".";
					}
					enum.clear();
					
					changes++;
				} //else buffer += "\n\n" + target.tailFlagsLockedMessage();
			}
			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target tail(s). Changing type is atomic with flags and count. Changing only count and flags are not atomic between.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current
		 * @param	newCount change tail count, if 0 wil attempt to remove tails and everything else is ignored. Set -1 to keep current tail count if more than one.
		 * @param	newFlags flags to add, both during type change and as standalone.
		 * @param	keepFlags flags which would remain during type change if present, but not added if not. Note, no need to double newFlags here.
		 * @param	removeFlags flags which would be removed if present. Note, all flags not in keep list would be removed during type change. Only to change flags without changing type.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeTail(target:Creature, newType:int, newCount:Number = 1, newFlags:/*int*/Array = null, keepFlags:/*int*/Array = null, removeFlags:/*int*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newFlags == null) newFlags = [];
			if (keepFlags == null) keepFlags = [];
			if (removeFlags == null) removeFlags = [];
			
			if (newType == -1) newType = target.tailType;
			if (newCount == -1) newCount = Math.max(target.tailCount, 1);
			
			// remove tail case
			if (newCount == 0) {
				if (!target.hasTail()) return false; // already have no tail
				
				if (!target.tailTypeUnlocked(0)) buffer += "\n\n" + target.tailTypeLockedMessage(); // locked by type
				else if (!target.tailCountUnlocked(0)) buffer += "\n\n" + target.tailCountLockedMessage(); // locked by count
				else {
					if (target.tailCount == 1)
						buffer += "\n\nBase of your " + target.tailsDescript(true, true) + " is itching. This is because your tail is retracting into your body! <b>You have no tail now.</b>";
					else 
						buffer += "\n\nYour " + target.tailsDescript(true, true) + " are itching. This is because they are retracting into your body! <b>You have no tail now.</b>";
					target.removeTails();
					changes++;
				}
				if (display) output(buffer);
				return changes > 0;
			}
			
			 // enforce flags to be failsafe
			if (InCollection(GLOBAL.FLAG_TAILCOCK, newFlags)) {
				newFlags.push(GLOBAL.FLAG_PREHENSILE);
				newFlags.push(GLOBAL.FLAG_NUBBY);
				newFlags.push(GLOBAL.FLAG_TAPERED);
				newFlags.push(GLOBAL.FLAG_SHEATHED);
			}
				
			var toKeep:/*int*/Array = [];
			var toRemove:/*int*/Array = [];
			
			var itthey:String;
			var isare:String;
			var _s:String;
			var item:int;
			
			// basic case - change type
			if(target.tailType != newType)
			{
				if (!target.tailTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.tailTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				if (target.tailCount != newCount && !target.tailCountUnlocked(newCount)) { // if have to, but unable to set proper count...
					buffer += "\n\n" + target.tailCountLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				 // building keep/remove flags list to build flavored transition scene
				for each (item in target.tailFlags) {
					if (InCollection(item, keepFlags)) toKeep.push(item);
					else if (InCollection(item, newFlags)) toKeep.push(item);
					else toRemove.push(item); // since we are changing type now, ALL flags not in keep/add list are removed anyways
				}
				
				if (!target.hasTail()) { // new tail case
					target.tailType = newType;
					target.tailFlags = newFlags;
					
					if (InCollection(GLOBAL.FLAG_TAILCOCK, target.tailFlags)) { // init tailcock junk
						target.tailGenitalColor = "pink";
						target.tailGenitalArg = GLOBAL.TYPE_FELINE; // PLACEHOLDER. TODO: either determine from race or pass as argument. That is if something is wrong with feline cocks. They are fine by me.
						target.tailGenital = GLOBAL.TAIL_GENITAL_COCK;
					}
					
					buffer += "\n\nYour [pc.ass] is itching.";
					if (kGAMECLASS.silly && !target.analVirgin && rand(4) == 0) buffer += " At first you thought someone is thinking about it, but that is not the case.";
					buffer += " You are growing new appendage!";
					target.tailCount = 1;
					buffer += " <b>You now have " + target.tailDescript(true, true) + "!</b>";
					if(newCount > 1)
						buffer += " But itching is not only going stronger...";
						
				} else { // already has tail(s)
					buffer += "\n\nYour " + target.tailsDescript(true, true) + " " + (target.tailCount > 1 ? "are" : "is") + " flailing wildly as " + (target.tailCount > 1 ? "they are" : "it is") + " losing " + (target.tailCount > 1 ? "their" : "it's") + " " + GLOBAL.TYPE_NAMES[target.tailType].toLowerCase() + " form.";
					
					if (target.tailCount > newCount) {
						target.tailCount = newCount;
						buffer += " They are merging, like liquid, until only " + num2Text(target.tailCount) + " is left.";
					}
					
					itthey = (newCount > 1 ? "they" : "it");
					isare = (newCount > 1 ? "are" : "is");
					_s = (newCount > 1 ? "s" : "");
					
					// screw this shit
					//// what is lost
					//if (InCollection(GLOBAL.FLAG_PREHENSILE, toRemove)) buffer += " Looks like you are losing fine control. Your tail" + _s + " " + isare + " not prehensile anymore.";
					//if (InCollection(GLOBAL.FLAG_LONG, toRemove)) buffer += " Your tail" + _s + " " + isare + " becoming shorter.";
					//if (InCollection(GLOBAL.FLAG_THICK, toRemove)) buffer += " Your tail" + _s + " " + isare + " becoming thinner.";
					//if (InCollection(GLOBAL.FLAG_GOOEY, toRemove)) buffer += " Your tail" + _s + " " + isare + " solidifying from goo-like consistency.";
					//if (InCollection(GLOBAL.FLAG_FEATHERED, toRemove)) buffer += " Your tail" + _s + " " + isare + " shedding feathers.";
					//if (InCollection(GLOBAL.FLAG_CHITINOUS, toRemove)) buffer += " Your tail" + _s + " " + isare + " shedding shitin.";
					//if (InCollection(GLOBAL.FLAG_SCALED, toRemove)) buffer += " Your tail" + _s + " " + isare + " shedding scales.";
					//if (InCollection(GLOBAL.FLAG_FURRED, toRemove)) buffer += " Your tail" + _s + " " + isare + " shedding fur.";
					//else if (InCollection(GLOBAL.FLAG_FLUFFY, toRemove)) buffer += " Fur on your tail" + _s + " " + isare + " now thinner.";
					//if (InCollection(GLOBAL.FLAG_SMOOTH, toRemove)) buffer += " Your tail" + _s + " " + isare + " losing that smooth texture.";
					//if (InCollection(GLOBAL.FLAG_TAILCOCK, toRemove)) buffer += " Genitalia on your tail" + _s + " " + isare + " disappearing.";
					//if (InCollection(GLOBAL.FLAG_OVIPOSITOR, toRemove)) buffer += " Ovipositor" + _s + " on your tail" + _s + " " + isare + " disappearing.";
					//if (InCollection(GLOBAL.FLAG_STINGER_TIPPED, toRemove)) buffer += " Stinger" + _s + " on your tail" + _s + " " + isare + " disappearing.";
					////what is not changed or gained
					//if (InCollection(GLOBAL.FLAG_PREHENSILE, toKeep)) buffer += " Your ability to control your tail" + _s + " is intact.";
					//else if (InCollection(GLOBAL.FLAG_PREHENSILE, newFlags)) buffer += " Looks like you are able to control your tail" + _s + " better now. Your tail" + _s + " " + isare + " prehensile.";
					//
					//if (InCollection(GLOBAL.FLAG_LONG, toKeep)) buffer += " Your tail" + _s + " " + isare + " still long.";
					//else if (InCollection(GLOBAL.FLAG_LONG, newFlags)) buffer += " Your tail" + _s + " " + isare + " becoming longer.";
					//
					//if (InCollection(GLOBAL.FLAG_THICK, toKeep)) buffer += " Your tail" + _s + " " + isare + " still thick.";
					//else if (InCollection(GLOBAL.FLAG_THICK, newFlags)) buffer += " Your tail" + _s + " " + isare + " becoming thicker.";
					//
					//if (InCollection(GLOBAL.FLAG_GOOEY, toKeep)) buffer += " Your tail" + _s + " " + isare + " still retaining goo-like consistency.";
					//else if (InCollection(GLOBAL.FLAG_GOOEY, newFlags)) buffer += " Your tail" + _s + " " + isare + " liquifying to goo-like consistency.";
					//
					//if (InCollection(GLOBAL.FLAG_FEATHERED, toKeep)) buffer += " Your tail" + _s + " " + isare + " still retaining feathers.";
					//else if (InCollection(GLOBAL.FLAG_FEATHERED, newFlags)) buffer += " Your tail" + _s + " " + isare + " growing feathers.";
					//
					//if (InCollection(GLOBAL.FLAG_CHITINOUS, toKeep)) buffer += " Your tail" + _s + " " + isare + " still retaining shitinous plating.";
					//else if (InCollection(GLOBAL.FLAG_CHITINOUS, newFlags)) buffer += " Your tail" + _s + " " + isare + " growing shitinous plating.";
					//
					//if (InCollection(GLOBAL.FLAG_SCALED, toKeep)) buffer += " Your tail" + _s + " " + isare + " still retaining scales.";
					//else if (InCollection(GLOBAL.FLAG_SCALED, newFlags)) buffer += " Your tail" + _s + " " + isare + " growing scales.";
					//
					//if (InCollection(GLOBAL.FLAG_SMOOTH, toKeep)) buffer += " Your tail" + _s + " " + isare + " still retaining smooth texture.";
					//else if (InCollection(GLOBAL.FLAG_SMOOTH, newFlags)) buffer += " Your tail" + _s + " " + isare + " gaining smooth texture.";
					//
					//if (InCollection(GLOBAL.FLAG_FLUFFY, toKeep) && InCollection(GLOBAL.FLAG_FURRED, toKeep)) buffer += " Fur on your tail" + _s + " is still long and fluffy."; // still fluffy
					//else if (InCollection(GLOBAL.FLAG_FURRED, toKeep) && InCollection(GLOBAL.FLAG_FLUFFY, newFlags)) buffer += " Fur on your tail" + _s + " is now longer and fluffier."; // was furry, now fluffy
					//else if (InCollection(GLOBAL.FLAG_FLUFFY, newFlags) && !InCollection(GLOBAL.FLAG_FURRED, toKeep)) buffer += " Your tail" + _s + " " + isare + " growing long and fluffy fur."; // was not furry, now fluffy
					//else if (InCollection(GLOBAL.FLAG_FURRED, newFlags) && !InCollection(GLOBAL.FLAG_FURRED, toKeep)) buffer += " Your tail" + _s + " " + isare + " growing fur."; // was not furry, now furry
					//
					////if (InCollection(GLOBAL.FLAG_TAILCOCK, toKeep)) buffer += " Genitalia on your tail" + _s + " " + isare + " .";
					////else if (InCollection(GLOBAL.FLAG_TAILCOCK, newFlags)) buffer += " Genitalia on your tail" + _s + " " + isare + " ."; // custom handling
					//
					//if (InCollection(GLOBAL.FLAG_OVIPOSITOR, toKeep)) buffer += " Ovipositor" + _s + " on your tail" + _s + " " + isare + " still there.";
					//else if (InCollection(GLOBAL.FLAG_OVIPOSITOR, newFlags)) buffer += " Your tail" + _s + " " + isare + " growing" + _s + " ovipositor" + _s + "!";
					//
					//if (InCollection(GLOBAL.FLAG_STINGER_TIPPED, toKeep)) buffer += " Stinger" + _s + " on your tail" + _s + " " + isare + " still there.";
					//else if (InCollection(GLOBAL.FLAG_STINGER_TIPPED, newFlags)) buffer += " Your tail" + _s + " " + isare + " growing" + _s + " stinger" + _s + "!";
					
					target.tailType = newType;
					target.tailFlags = newFlags;
					
					if (InCollection(target.tailFlags, GLOBAL.FLAG_TAILCOCK)) { // init tailcock junk
						target.tailGenitalColor = RandomInCollection("pink", "red");
						target.tailGenitalArg = guessCockType(target);
						target.tailGenital = GLOBAL.TAIL_GENITAL_COCK;
					}
					buffer += " <b>You now have " + num2Text(target.tailCount) + " " + target.tailsDescript(true, true) + " appropriate for " + (newType == GLOBAL.TYPE_VULPINE && target.tailCount > 1 ? "kitsune's" : GLOBAL.TYPE_NAMES[newType].toLowerCase()) + " body!</b>";
					if(newCount > target.tailCount)
						buffer += " But itching is only going stronger...";
				}
				
				_s = (newCount - target.tailCount > 1 ? "s" : "");
				if (newCount > target.tailCount) {
					buffer += "\n\nYou have " + num2Text(newCount - target.tailCount) + " itching spot" + _s + " on your ass... That is because you have new tail" + _s + " growing!";
					target.tailCount = newCount;
					buffer += " When all is settled down, you found yourself an owner of " + num2Text(target.tailCount) + " matching " + target.tailDescript(true, true) + ".";
				}
				
				if(target.hasTailCock()) {
					if (InCollection(GLOBAL.FLAG_TAILCOCK, toKeep)) { // has tailcock before
						if(target.tailCount == 1)
							buffer += "\n\nThere is something strange in your tail. After some probing you've found your tail genitalia still present.";
						else
							buffer += "\n\nThere is something strange in your tails. After some probing you've found your tail genitalia still present in each of your tails.";
							
					} else {
						if(target.tailCount == 1)
							buffer += "\n\nThere is something strange in your tail. After some probing you've found that <b>your tail is cock-tipped!</b>";
						else
							buffer += "\n\nThere is something strange in your tails. After some probing you've found that <b>alls your tails are cock-tipped!</b>.";
					}
					if (target.tailCount > 1 && kGAMECLASS.silly) buffer += " One-[pc.race] gang-bang time!";
				}
				changes++;
				
				if (display) output(buffer);
				return changes > 0;
			}
			
			// changing tail count without changing type
			if (target.tailCount != newCount)
				if (target.tailCountUnlocked(newCount)) {
					if(newCount > target.tailCount)
						buffer += "\n\nYou have " + num2Text(newCount - target.tailCount) + " itching spots on your ass... That is because you have new tails growing!";
					else
						buffer += "\n\n" + num2Text(newCount - target.tailCount, true) + " of your tails just fall off!";
					target.tailCount = newCount;
					buffer += " When all is settled down, you found yourself an owner of " + num2Text(target.tailCount) + " matching " + target.tailDescript(true, true) + ".";
					changes++;
				} else buffer += "\n\n" + target.tailCountLockedMessage();
			
			// changing flags without changing type
			var flagsUnlocked:Boolean = true;
			for each (item in newFlags) {
				if (target.hasTailFlag(item)) continue; // skip existing
				if (!target.tailFlagsUnlocked(item)) flagsUnlocked = false;
				toKeep.push(item);
			}
			
			for each (item in removeFlags) {
				if (!target.hasTailFlag(item)) continue; // skip not present
				if (!target.tailFlagsUnlocked(item)) flagsUnlocked = false;
				toRemove.push(item);
			}
			
			if (toKeep.length > 0 || toRemove.length > 0) {
				if (flagsUnlocked) {
					itthey = (target.tailCount > 1 ? "they" : "it");
					isare = (target.tailCount > 1 ? "are" : "is");
					_s = (target.tailCount > 1 ? "s" : "");
					buffer += "\n\nYour " + target.tailsDescript(true, true) + " " + isare + " changing.";
					
					enum.clear();
					for each (item in toRemove) {
						if (item == GLOBAL.FLAG_PREHENSILE) enum.push("prehensile");
						if (item == GLOBAL.FLAG_LONG) enum.push("long");
						if (item == GLOBAL.FLAG_THICK) enum.push("thick");
						if (item == GLOBAL.FLAG_GOOEY) enum.push(RandomInCollection("slimy", "gooey"));
						if (item == GLOBAL.FLAG_FEATHERED) enum.push(RandomInCollection("feathered", "feathery"));
						if (item == GLOBAL.FLAG_CHITINOUS) enum.push(RandomInCollection("chitinous", "armored"));
						if (item == GLOBAL.FLAG_SCALED) enum.push(RandomInCollection("scaled", "scaly"));
						if (item == GLOBAL.FLAG_FURRED) enum.push(RandomInCollection("furred", "furry"));
						if (item == GLOBAL.FLAG_FLUFFY) enum.push("fluffy");
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_TAILCOCK) enum.push("cock-tipped");
						if (item == GLOBAL.FLAG_OVIPOSITOR) enum.push("ovipositor-tipped");
						if (item == GLOBAL.FLAG_STINGER_TIPPED) enum.push("stinger-tipped");
						target.tailFlags.splice(target.tailFlags.indexOf(item), 1);
					}
					if (!enum.isEmpty()) {
						buffer += " " + StringUtil.capitalize(itthey) + " " + isare + " not " + enum.toString() + " anymore.";
					}
					
					enum.clear();
					for each (item in toKeep)
					{
						if (item == GLOBAL.FLAG_PREHENSILE) enum.push("prehensile");
						if (item == GLOBAL.FLAG_LONG) enum.push("long");
						if (item == GLOBAL.FLAG_THICK) enum.push("thick");
						if (item == GLOBAL.FLAG_GOOEY) enum.push(RandomInCollection("slimy", "gooey"));
						if (item == GLOBAL.FLAG_FEATHERED) enum.push(RandomInCollection("feathered", "feathery"));
						if (item == GLOBAL.FLAG_CHITINOUS) enum.push(RandomInCollection("chitinous", "armored"));
						if (item == GLOBAL.FLAG_SCALED) enum.push(RandomInCollection("scaled", "scaly"));
						if (item == GLOBAL.FLAG_FURRED) enum.push(RandomInCollection("furred", "furry"));
						if (item == GLOBAL.FLAG_FLUFFY) enum.push("fluffy");
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_TAILCOCK) enum.push("cock-tipped");
						if (item == GLOBAL.FLAG_OVIPOSITOR) enum.push("ovipositor-tipped");
						if (item == GLOBAL.FLAG_STINGER_TIPPED) enum.push("stinger-tipped");
						target.addTailFlag(item);
					}
					if (!enum.isEmpty()) {
						buffer += " " + StringUtil.capitalize(itthey) + " " + isare + " " + enum.toString() + " now.";
					}
					enum.clear();
					
					changes++;
				} else buffer += "\n\n" + target.tailFlagsLockedMessage();
			}
			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target leg(s). Changing type is atomic with flags and count. Changing only count and flags are not atomic between.
		 * @param	target
		 * @param	newType set type from Global or -1 to keep current
		 * @param	newCount is complicated one. If simple int, it is hard target. If -1, number would be not changed. If int array, it should be [min, max, optimal, step], where min and max are hard limits, and optimal is desired target if possible. For leithans it would be [2, 6, 6, 2]: at least two, not more than 6, optimal 6, always even. For normally bipedals, who can be taurs, it would be [2, 6, 2, 2]. Optimal can be -1, in which case it would not move towards optimal if within hard limits and step.
		 * @param	newFlags flags to add, both during type change and as standalone.
		 * @param	keepFlags flags which would remain during type change if present, but not added if not. Note, no need to double newFlags here.
		 * @param	removeFlags flags which would be removed if present. Note, all flags not in keep list would be removed during type change. Only to change flags without changing type.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeLegs(target:Creature, newType:int, newCount:* = 1, newFlags:/*int*/Array = null, keepFlags:/*int*/Array = null, removeFlags:/*int*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newType == -1) newType = target.legType;
			if (newFlags == null) newFlags = [];
			if (keepFlags == null) keepFlags = [];
			if (removeFlags == null) removeFlags = [];
			var desiredMin:int;
			var desiredMax:int;
			var desiredOptimal:int;
			var desiredStep:int;
			
			if (newCount is Array) { // conditions
				desiredMin = newCount[0];
				desiredMax = newCount[1];
				desiredOptimal = newCount[2];
				desiredStep = newCount[3];
			} else { // hard amount
				desiredMin = newCount;
				desiredMax = newCount;
				desiredOptimal = newCount;
				desiredStep = newCount;
			}
			
				
			var targetCount:int;
			// mindfuck with getting compromise between desired and possible leg counts
			if (newCount == -1 || desiredOptimal == target.legCount) // most simple case - keep as is... don't use -1 without external checks to avoid weirdshit!
				targetCount = target.legCount;
			else { // current leg count is not optimal... going to decide... 
				// checking case of floating desired, just boundaries and step
				if (desiredOptimal == -1 && target.legCount >= desiredMin && target.legCount <= desiredMax && target.legCount % desiredStep == 0) {
					targetCount = target.legCount; // optimal is not set, within borders and right step - looks acceptable as is
				}
				// checking case of set desired and direct transfer to desired
				else if (desiredOptimal != -1 && target.legCountUnlocked(desiredOptimal)) {
					targetCount = desiredOptimal; // it is possible to just use optimal
				}
				// territory of searching for compromise
				else {
					var options:Array = []; // collectiong unlocked options
					for (var countOption:int = desiredMin; countOption <= desiredMax; countOption += desiredStep) // iterationg through every option
						if (target.legCountUnlocked(countOption)) options.push(countOption);
					if (options.length == 0) { // we have no options at all! getting the hell out of here
						buffer += "\n\n" + target.legCountLockedMessage();
						if (display) output(buffer);
						return changes > 0;
					}
					if (desiredOptimal == -1) desiredOptimal = target.legCount; // if no hard optimal looking as close to current count as possible
					targetCount = options[0];
					for each (var option:int in options)
						if (Math.abs(option - desiredOptimal) < Math.abs(option - targetCount)) // hard check - in even cases use lesser amount
							targetCount = option;
				}
			}
				
			var toKeep:/*int*/Array = [];
			var toRemove:/*int*/Array = [];
			
			var itthey:String;
			var isare:String;
			var _s:String;
			var item:int;
			
			// basic case - change type
			if(target.legType != newType)
			{
				if (!target.legTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.legTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				 // building keep/remove flags list to build flavored transition scene
				for each (item in target.legFlags) {
					if (InCollection(item, keepFlags)) toKeep.push(item);
					else if (InCollection(item, newFlags)) toKeep.push(item);
					else toRemove.push(item); // since we are changing type now, ALL flags not in keep/add list are removed anyways
				}
				
				buffer += "\n\nYour " + target.legs(true, true) + " give out as " + (target.legCount > 1 ? "they are" : "it is") + " changing as " + (target.legCount > 1 ? "they are" : "it is") + " losing " + (target.legCount > 1 ? "their" : "it's") + " " + GLOBAL.TYPE_NAMES[target.legType].toLowerCase() + " form.";
				
				if (target.legCount < targetCount) { // case of removing some legs
					target.legCount = targetCount;
					buffer += " They are merging and reshaping, like liquid, until only " + num2Text(target.legCount) + " " + (target.legCount > 1 ? "are" : "is") + " left.";
				}
				
				if (target.legCount > targetCount) { // case of growing some legs
					target.legCount = targetCount;
					buffer += " They are merging, splitting and reshaping, until you are left with " + num2Text(target.legCount) + " limb" + (target.legCount > 1 ? "s" : "") + " below your waist.";
				}
				
				if (target.legCount > 2 && newType != GLOBAL.TYPE_DRIDER && target.genitalSpot != 2 && target.genitalSpotUnlocked(2)) {
					buffer += " <b>Your genitals are now residing between your hind legs!</b>";
					target.genitalSpot = 2;
				}
				
				if ((target.legCount <= 2 || newType == GLOBAL.TYPE_DRIDER) && target.genitalSpot != 0 && target.genitalSpotUnlocked(0)) {
					buffer += " <b>Your genitals are now residing under your waist!</b>";
					target.genitalSpot = 0;
				}
					
				itthey = (target.legCount > 1 ? "they" : "it");
				isare = (target.legCount > 1 ? "are" : "is");
				_s = (target.legCount > 1 ? "s" : "");
				
				target.legType = newType;
				target.legFlags = newFlags;
				
				// screw this shit.
				//// what is lost
				//if (InCollection(GLOBAL.FLAG_PREHENSILE, toRemove)) buffer += " Looks like you are losing fine limb control. Your [pc.legs] " + isare + " not prehensile anymore.";
				//if (InCollection(GLOBAL.FLAG_TENDRIL, toRemove)) buffer += " Your [pc.legs] " + isare + " not resembling tendril anymore.";
				//if (InCollection(GLOBAL.FLAG_DIGITIGRADE, toRemove)) buffer += " Your stance is now changed. Your [pc.legs] " + isare + " not digitigrade anymore.";
				//if (InCollection(GLOBAL.FLAG_PLANTIGRADE, toRemove)) buffer += " Your stance is now changed. Your [pc.legs] " + isare + " not plantigrade anymore.";
				//if (InCollection(GLOBAL.FLAG_AMORPHOUS, toRemove)) buffer += " Your stance is now changed. Your [pc.legs] " + isare + " not amoprhous anymore.";
				//if (InCollection(GLOBAL.FLAG_HOOVES, toRemove)) buffer += " Your stance is now changed. Your [pc.legs] " + isare + " not ending in hooves anymore.";
				//if (InCollection(GLOBAL.FLAG_PAWS, toRemove)) buffer += " Your stance is now changed. Your [pc.legs] " + isare + " not ending in paws anymore.";
				//if (InCollection(GLOBAL.FLAG_HEELS, toRemove)) buffer += " Your stance is now changed. Your [pc.legs] " + isare + " not ending in high heels anymore.";
				//if (InCollection(GLOBAL.FLAG_SCALED, toRemove)) buffer += " Your [pc.legs] " + isare + " shedding scales.";
				//if (InCollection(GLOBAL.FLAG_FURRED, toRemove)) buffer += " Your [pc.legs] " + isare + " shedding fur.";
				//if (InCollection(GLOBAL.FLAG_FEATHERED, toRemove)) buffer += " Your [pc.legs] " + isare + " shedding feathers.";
				//if (InCollection(GLOBAL.FLAG_CHITINOUS, toRemove)) buffer += " Your [pc.legs] " + isare + " shedding chitin.";
				//if (InCollection(GLOBAL.FLAG_SMOOTH, toRemove)) buffer += " Your [pc.legs] " + isare + " not as smooth as they were.";
				//if (InCollection(GLOBAL.FLAG_GOOEY, toRemove)) buffer += " Your [pc.legs] " + isare + " solidifying from goo-like consistence.";
				//if (InCollection(GLOBAL.FLAG_STICKY, toRemove)) buffer += " Your [pc.legs] " + isare + " are not sticky anymore.";
				////what is not changed or gained
				//if (InCollection(GLOBAL.FLAG_PREHENSILE, toKeep)) buffer += " Your ability to control your [pc.legs] is intact.";
				//else if (InCollection(GLOBAL.FLAG_PREHENSILE, newFlags)) buffer += " Looks like you are able to control your [pc.legs] better now. Your[pc.legs] " + isare + " prehensile.";
				//if (InCollection(GLOBAL.FLAG_TENDRIL, toKeep)) buffer += " Your [pc.legs] still " + isare + " tendril-like.";
				//else if (InCollection(GLOBAL.FLAG_TENDRIL, newFlags)) buffer += " Your [pc.legs] " + isare + " tendril-like now.";
				//if (InCollection(GLOBAL.FLAG_DIGITIGRADE, toKeep)) buffer += " Your stance is not changed much, your [pc.legs] still " + isare + " digitigrade.";
				//else if (InCollection(GLOBAL.FLAG_DIGITIGRADE, newFlags)) buffer += " Your stance is notably changed, since your [pc.legs] " + isare + " digitigrade now.";
				//if (InCollection(GLOBAL.FLAG_PLANTIGRADE, toKeep)) buffer += " Your stance is not changed much, your [pc.legs] still " + isare + " plantigrade.";
				//else if (InCollection(GLOBAL.FLAG_PLANTIGRADE, newFlags)) buffer += " Your stance is notably changed, since your [pc.legs] " + isare + " plantigrade now.";
				//if (InCollection(GLOBAL.FLAG_AMORPHOUS, toKeep)) buffer += " Your stance is not changed much, your [pc.legs] still " + isare + " amoprhous.";
				//else if (InCollection(GLOBAL.FLAG_AMORPHOUS, newFlags)) buffer += " Your stance is notably changed, since your [pc.legs] " + isare + " amoprhous now.";
				//if (InCollection(GLOBAL.FLAG_HOOVES, toKeep)) buffer += " Your stance is not changed much, your [pc.legs] still " + isare + " ending in hooves.";
				//else if (InCollection(GLOBAL.FLAG_HOOVES, newFlags)) buffer += " Your stance is notably changed, since your [pc.legs] " + isare + " ending in hooves now.";
				//if (InCollection(GLOBAL.FLAG_PAWS, toKeep)) buffer += " Your stance is not changed much, your [pc.legs] still " + isare + " ending in paws.";
				//else if (InCollection(GLOBAL.FLAG_PAWS, newFlags)) buffer += " Your stance is notably changed, since your [pc.legs] " + isare + " ending in paws now.";
				//if (InCollection(GLOBAL.FLAG_HEELS, toKeep)) buffer += " Your stance is not changed much, your [pc.legs] still " + isare + " ending in heels.";
				//else if (InCollection(GLOBAL.FLAG_HEELS, newFlags)) buffer += " Your stance is notably changed, since your [pc.legs] " + isare + " ending in heels now.";
				//if (InCollection(GLOBAL.FLAG_SCALED, toKeep)) buffer += " Your [pc.legs] still " + isare + " covered in scales.";
				//else if (InCollection(GLOBAL.FLAG_SCALED, newFlags)) buffer += " Your [pc.legs] " + isare + " covered in scales now.";
				//if (InCollection(GLOBAL.FLAG_FURRED, toKeep)) buffer += " Your [pc.legs] still " + isare + " covered in fur.";
				//else if (InCollection(GLOBAL.FLAG_FURRED, newFlags)) buffer += " Your [pc.legs] " + isare + " covered in fur now.";
				//if (InCollection(GLOBAL.FLAG_FEATHERED, toKeep)) buffer += " Your [pc.legs] still " + isare + " covered in feathers.";
				//else if (InCollection(GLOBAL.FLAG_FEATHERED, newFlags)) buffer += " Your [pc.legs] " + isare + " covered in feathers now.";
				//if (InCollection(GLOBAL.FLAG_CHITINOUS, toKeep)) buffer += " Your [pc.legs] still " + isare + " covered in chitin.";
				//else if (InCollection(GLOBAL.FLAG_CHITINOUS, newFlags)) buffer += " Your [pc.legs] " + isare + " covered in chitin now.";
				//if (InCollection(GLOBAL.FLAG_SMOOTH, toKeep)) buffer += " Your [pc.legs] still " + isare + " very smooth.";
				//else if (InCollection(GLOBAL.FLAG_SMOOTH, newFlags)) buffer += " Your [pc.legs] " + isare + " very smooth now.";
				//if (InCollection(GLOBAL.FLAG_GOOEY, toKeep)) buffer += " Your [pc.legs] still " + isare + " have goo-like consistence.";
				//else if (InCollection(GLOBAL.FLAG_GOOEY, newFlags)) buffer += " Your [pc.legs] " + isare + " have goo-like consistence now.";
				//if (InCollection(GLOBAL.FLAG_STICKY, toKeep)) buffer += " Your [pc.legs] still " + isare + " sticky.";
				//else if (InCollection(GLOBAL.FLAG_STICKY, newFlags)) buffer += " Your [pc.legs] " + isare + " sticky now.";
				
				buffer += " <b>You now have " + num2Text(target.legCount) + " " + target.legs(true, true) + " appropriate for " + GLOBAL.TYPE_NAMES[newType].toLowerCase() + " body!</b>";
				changes++;
				
				if (display) output(buffer);
				return changes > 0;
			}
			
			// changing count without changing type
			if (target.legCount != targetCount)
				if(target.legCountUnlocked(targetCount)) {
					buffer += "\n\nYour " + target.legs(true, true) + " " + (target.legCount > 1 ? "are" : "is") + " itching, twitching and... Changing.";
					
					if (target.legCount < targetCount) { // case of removing some legs
						target.legCount = targetCount;
						buffer += " They are merging and splitting, like liquid, until only " + num2Text(target.legCount) + " " + (target.legCount > 1 ? "are" : "is") + " left.";
					}
					
					if (target.legCount > targetCount) { // case of growing some legs
						target.legCount = targetCount;
						buffer += " They are merging and splitting, like liquid, until you are left with " + num2Text(target.legCount) + " " + target.legs(true, true) + ".";
					}
					changes++;
				} else buffer += "\n\n" + target.legCountLockedMessage();
			
			// changing flags without changing type
			var flagsUnlocked:Boolean = true;
			for each (item in newFlags) {
				if (target.hasLegFlag(item)) continue; // skip existing
				if (!target.legFlagsUnlocked(item)) flagsUnlocked = false;
				toKeep.push(item);
			}
			
			for each (item in removeFlags) {
				if (!target.hasLegFlag(item)) continue; // skip not present
				if (!target.legFlagsUnlocked(item)) flagsUnlocked = false;
				toRemove.push(item);
			}
			
			if (toKeep.length > 0 || toRemove.length > 0) {
				if (flagsUnlocked) {
					itthey = (target.legCount > 1 ? "they" : "it");
					isare = (target.legCount > 1 ? "are" : "is");
					_s = (target.legCount > 1 ? "s" : "");
					buffer += "\n\nYour " + target.legs(true, true) + " " + isare + " changing.";
					
					enum.clear();
					for each (item in toRemove) {
						if (item == GLOBAL.FLAG_PREHENSILE) enum.push("prehensile");
						if (item == GLOBAL.FLAG_TENDRIL) enum.push("tendril");
						if (item == GLOBAL.FLAG_DIGITIGRADE) enum.push("digitigrade");
						if (item == GLOBAL.FLAG_PLANTIGRADE) enum.push("plantigrade");
						if (item == GLOBAL.FLAG_AMORPHOUS) enum.push("amoprhous");
						if (item == GLOBAL.FLAG_HOOVES) enum.push("hooves");
						if (item == GLOBAL.FLAG_PAWS) enum.push("paws");
						if (item == GLOBAL.FLAG_HEELS) enum.push("high heels");
						if (item == GLOBAL.FLAG_SCALED) enum.push(RandomInCollection("scaled", "scaly"));
						if (item == GLOBAL.FLAG_FURRED) enum.push(RandomInCollection("furred", "furry"));
						if (item == GLOBAL.FLAG_FEATHERED) enum.push(RandomInCollection("feathered", "feathery"));
						if (item == GLOBAL.FLAG_CHITINOUS) enum.push(RandomInCollection("chitinous", "armored"));
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_STICKY) enum.push("sticky");
						if (item == GLOBAL.FLAG_GOOEY) enum.push(RandomInCollection("slimy", "gooey"));
						target.legFlags.splice(target.legFlags.indexOf(item), 1);
					}
					if (!enum.isEmpty()) {
						buffer += " " + StringUtil.capitalize(itthey) + " " + isare + " not " + enum.toString() + " anymore.";
					}
					
					enum.clear();
					for each (item in toKeep)
					{
						if (item == GLOBAL.FLAG_PREHENSILE) enum.push("prehensile");
						if (item == GLOBAL.FLAG_TENDRIL) enum.push("tendril");
						if (item == GLOBAL.FLAG_DIGITIGRADE) enum.push("digitigrade");
						if (item == GLOBAL.FLAG_PLANTIGRADE) enum.push("plantigrade");
						if (item == GLOBAL.FLAG_AMORPHOUS) enum.push("amoprhous");
						if (item == GLOBAL.FLAG_HOOVES) enum.push("hooves");
						if (item == GLOBAL.FLAG_PAWS) enum.push("paws");
						if (item == GLOBAL.FLAG_HEELS) enum.push("high heels");
						if (item == GLOBAL.FLAG_SCALED) enum.push(RandomInCollection("scaled", "scaly"));
						if (item == GLOBAL.FLAG_FURRED) enum.push(RandomInCollection("furred", "furry"));
						if (item == GLOBAL.FLAG_FEATHERED) enum.push(RandomInCollection("feathered", "feathery"));
						if (item == GLOBAL.FLAG_CHITINOUS) enum.push(RandomInCollection("chitinous", "armored"));
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_STICKY) enum.push("sticky");
						if (item == GLOBAL.FLAG_GOOEY) enum.push(RandomInCollection("slimy", "gooey"));
						target.addLegFlag(item);
					}
					if (!enum.isEmpty()) {
						buffer += " " + StringUtil.capitalize(itthey) + " " + isare + " " + enum.toString() + " now.";
					}
					enum.clear();
					
					changes++;
				} else buffer += "\n\n" + target.legFlagsLockedMessage();
			}
			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target skin type. Changing type is atomic with flags. Changing color is not atomic.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current.
		 * @param	newColors possible color options for skin/fur/scales depending on new type, can be null to leave current.
		 * @param	newFlags flags to add, both during type change and as standalone.
		 * @param	keepFlags flags which would remain during type change if present, but not added if not. Note, no need to double newFlags here.
		 * @param	removeFlags flags which would be removed if present. Note, all flags not in keep list would be removed during type change. Only to change flags without changing type.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeSkin(target:Creature, newType:int, newColors:/*String*/Array = null, newFlags:/*int*/Array = null, keepFlags:/*int*/Array = null, removeFlags:/*int*/Array = null, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			if (newColors == null) newColors = [];
			if (newFlags == null) newFlags = [];
			if (keepFlags == null) keepFlags = [];
			if (removeFlags == null) removeFlags = [];
			
			if (newType == -1) newType = target.skinType;
				
			var toKeep:/*int*/Array = [];
			var toRemove:/*int*/Array = [];
			
			var item:int;
			
			var newColor:String;
			var newSkin:String = "";
			var isAre:String = "is";
			var key:String = "";
			if (newType == GLOBAL.SKIN_TYPE_SKIN) {
				newSkin = "skin";
				key = "skinTone";
			}
			if (newType == GLOBAL.SKIN_TYPE_FUR) {
				newSkin = "fur";
				key = "furColor";
			}
			if (newType == GLOBAL.SKIN_TYPE_SCALES) {
				newSkin = "scales";
				isAre = "are";
				key = "scaleColor";
			}
			if (newType == GLOBAL.SKIN_TYPE_GOO) {
				newSkin = "membrane";
				key = "skinTone";
			}
			if (newType == GLOBAL.SKIN_TYPE_CHITIN) {
				newSkin = "chitin";
				key = "scaleColor";
			}
			if (newType == GLOBAL.SKIN_TYPE_FEATHERS) {
				newSkin = "feathers";
				isAre = "are";
				key = "furColor";
			}
			
			// basic case - change type
			if(target.skinType != newType)
			{
				if (!target.skinTypeUnlocked(newType)) { // if have to, but unable to change type return - don't want to have flags weirdshit
					buffer += "\n\n" + target.skinTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				// building keep/remove flags list to build flavored transition scene
				for each (item in target.skinFlags) {
					if (InCollection(item, keepFlags)) toKeep.push(item);
					else if (InCollection(item, newFlags)) toKeep.push(item);
					else toRemove.push(item); // since we are changing type now, ALL flags not in keep/add list are removed anyways
				}
				
				buffer += "\n\n";
				
				// what is lost
				if (target.skinType == GLOBAL.SKIN_TYPE_SKIN) buffer += "Your " + target.skinFurScales(true, true) + "  itches intensely. You gaze down to see ";
				if (target.skinType == GLOBAL.SKIN_TYPE_FUR) buffer += " You are shedding your " + target.skinFurScales(true, true) + ", revealing ";
				if (target.skinType == GLOBAL.SKIN_TYPE_SCALES) buffer += "Your " + target.skinFurScales(true, true) + " itch incessantly. You scratch, feeling them flake off to reveal ";
				if (target.skinType == GLOBAL.SKIN_TYPE_GOO) buffer += " Your membrane is solidifying into ";
				if (target.skinType == GLOBAL.SKIN_TYPE_CHITIN) buffer += " You are shedding your chitin, revealing ";
				if (target.skinType == GLOBAL.SKIN_TYPE_FEATHERS) buffer += " You are shedding your feathers, revealing ";
				
				if (newType == GLOBAL.SKIN_TYPE_SKIN) buffer += "usual bare skin.";
				if (newType == GLOBAL.SKIN_TYPE_FUR) buffer += "more and more hairs breaking forth from your skin, quickly transforming into a soft coat of fur.";
				if (newType == GLOBAL.SKIN_TYPE_SCALES) buffer += "growing scales.";
				if (newType == GLOBAL.SKIN_TYPE_GOO) buffer += "softening to almost liquid consistency skin.";
				if (newType == GLOBAL.SKIN_TYPE_CHITIN) buffer += "new shiny chitin carapace.";
				if (newType == GLOBAL.SKIN_TYPE_FEATHERS) buffer += "coat of feathers.";
				
				enum.clear();
				if (InCollection(GLOBAL.FLAG_SMOOTH, toRemove)) enum.push("smooth");
				if (InCollection(GLOBAL.FLAG_THICK, toRemove)) enum.push("thick");
				if (InCollection(GLOBAL.FLAG_STICKY, toRemove)) enum.push("sticky");
				if (InCollection(GLOBAL.FLAG_FLUFFY, toRemove)) enum.push("fluffy");
				if (InCollection(GLOBAL.FLAG_SQUISHY, toRemove)) enum.push("squishy");
				if (InCollection(GLOBAL.FLAG_LUBRICATED, toRemove)) enum.push("lubricated");
				if (!enum.isEmpty()) {
					buffer += " Unlike your old surface, your " + newSkin + " " + isAre + " not " + enum.toString() + ".";
				}
				
				//what is not changed or gained
				enum.clear();
				if (InCollection(GLOBAL.FLAG_SMOOTH, newFlags)) enum.push("smooth");
				if (InCollection(GLOBAL.FLAG_THICK, newFlags)) enum.push("thick");
				if (InCollection(GLOBAL.FLAG_STICKY, newFlags)) enum.push("sticky");
				if (InCollection(GLOBAL.FLAG_FLUFFY, newFlags)) enum.push("fluffy");
				if (InCollection(GLOBAL.FLAG_SQUISHY, newFlags)) enum.push("squishy");
				if (InCollection(GLOBAL.FLAG_LUBRICATED, newFlags)) enum.push("lubricated");
				if (!enum.isEmpty()) {
					buffer += " Your " + newSkin + " " + isAre + " " + enum.toString() + " now.";
				}
				enum.clear();
				
				if (newColors.length > 0 && !InCollection(target[key], newColors)) {
					newColor = RandomInCollection(newColors);
					if (target[key + "Unlocked"](newColor)) {
						target[key] = newColor;
						buffer += " Your " + newSkin + " " + isAre + " " + newColor + " now.";
						changes++;
					}
				}
				
				target.skinType = newType;
				target.skinFlags = newFlags;
				
				buffer += " <b>You now have " + target.skinFurScales(true, true) + "!</b>";
				
				changes++;
				if (display) output(buffer);
				return changes > 0;
			}
			
			// changing flags without changing type
			var flagsUnlocked:Boolean = true;
			for each (item in newFlags) {
				if (target.hasSkinFlag(item)) continue; // skip existing
				if (!target.skinFlagsUnlocked(item)) flagsUnlocked = false;
				toKeep.push(item);
			}
			
			for each (item in removeFlags) {
				if (!target.hasSkinFlag(item)) continue; // skip not present
				if (!target.skinFlagsUnlocked(item)) flagsUnlocked = false;
				toRemove.push(item);
			}
			
			if (toKeep.length > 0 || toRemove.length > 0) {
				if (flagsUnlocked) {
					buffer += "\n\nYour " + target.skinFurScales() + " is changing.";
					
					enum.clear();
					for each (item in toRemove) {
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_THICK) enum.push("thick");
						if (item == GLOBAL.FLAG_STICKY) enum.push("sticky");
						if (item == GLOBAL.FLAG_FLUFFY) enum.push("fluffy");
						if (item == GLOBAL.FLAG_SQUISHY) enum.push("squishy");
						if (item == GLOBAL.FLAG_LUBRICATED) enum.push("lubricated");
						target.skinFlags.splice(target.skinFlags.indexOf(item), 1);
					}
					if (!enum.isEmpty()) {
						buffer += " Your " + newSkin + " " + isAre + " no longer " + enum.toString() + ".";
					}
					
					enum.clear();
					for each (item in toKeep)
					{
						if (item == GLOBAL.FLAG_SMOOTH) enum.push("smooth");
						if (item == GLOBAL.FLAG_THICK) enum.push("thick");
						if (item == GLOBAL.FLAG_STICKY) enum.push("sticky");
						if (item == GLOBAL.FLAG_FLUFFY) enum.push("fluffy");
						if (item == GLOBAL.FLAG_SQUISHY) enum.push("squishy");
						if (item == GLOBAL.FLAG_LUBRICATED) enum.push("lubricated");
						target.addSkinFlag(item);
					}
					if (!enum.isEmpty()) {
						buffer += " Your " + newSkin + " " + isAre + " " + enum.toString() + " now.";
					}
					enum.clear();
					
					changes++;
				} else buffer += "\n\n" + target.skinFlagsLockedMessage();
			}
			
			if (newColors.length > 0 && !InCollection(target[key], newColors)) {
				newColor = RandomInCollection(newColors);
				if(target[key + "Unlocked"](newColor)) {
					buffer += "\n\nYour " + target.skinFurScales() + " are... Changing color!";
					buffer += " Your " + newSkin + " " + isAre + " " + newColor + " now.";
					target[key] = newColor;
					buffer += " <b>You now have " + target.skinFurScales(true, true) + "!</b>";
					changes++;
				} else buffer += "\n\n" + target[key + "LockedMessage"]();
			}
			
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Change target hair type. Changing type is atomic with flags. Changing color is not atomic.
		 * @param	target
		 * @param	newType type from Global or -1 to keep current.
		 * @param	display
		 * @return is something changed
		 */
		public static function changeWings(target:Creature, newType:int, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
						
			if (newType == -1) newType = target.wingType;
			
			// basic case - change type
			if(target.wingType != newType)
			{
				if (!target.wingTypeUnlocked(newType)) {
					buffer += "\n\n" + target.wingTypeLockedMessage();
					if (display) output(buffer);
					return changes > 0;
				}
				
				if (newType == 0) buffer += " <b>Your " +  target.wingsDescript() + " are gone!</b>";
				
				target.wingType = newType;
				
				if (target.wingType != 0) buffer += " <b>You now have " + target.wingsDescript() + "!</b>";
				
				
				changes++;
				if (display) output(buffer);
				return changes > 0;
			}
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Wrapper for Creature.modFem with some auto-ajust. Supports common Mutator buffer for suppressed output.
		 * 
		 * @param	pc target creature
		 * @param	towards target feminity
		 * @param	power desired amount to change, should be positive
		 * @param	display show results of Creature.modFem in output
		 * @return if something actually changed
		 */
		public static function modFem(pc:Creature, towards:Number, power:Number = 1, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			var current:Number = pc.femininity;
			towards = Math.min(towards, pc.femininityMax());
			towards = Math.max(towards, pc.femininityMin());
			
			if (current == towards) return changes > 0;
			power = Math.abs(power); // failsafe
			power = Math.min(power, Math.abs(current - towards));
			if (current > towards) power *= -1;
			if (!pc.femininityUnlocked(current + power)) {
				buffer += "\n\n" + pc.femininityLockedMessage();
			} else {
				buffer += pc.modFem(power);
				if(pc.femininity != current) changes++;
			}
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Wrapper for Creature.modThickness with some auto-ajust. Supports common Mutator buffer for suppressed output.
		 * 
		 * @param	pc target creature
		 * @param	towards target thickness
		 * @param	power desired amount to change, should be positive
		 * @param	display show results of Creature.modThickness in output
		 * @return if something actually changed
		 */
		public static function modThickness(pc:Creature, towards:Number, power:Number = 1, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			var current:Number = pc.thickness;
			towards = Math.min(towards, pc.thicknessMax());
			towards = Math.max(towards, pc.thicknessMin());
			
			if (current == towards) return changes > 0;
			power = Math.abs(power); // failsafe
			power = Math.min(power, Math.abs(current - towards));
			if (current > towards) power *= -1;
			if (!pc.thicknessUnlocked(current + power)) {
				buffer += "\n\n" + pc.thicknessLockedMessage();
			} else {
				buffer += pc.modThickness(power);
				if(pc.thickness != current) changes++;
			}
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Wrapper for Creature.modTone with some auto-ajust. Supports common Mutator buffer for suppressed output.
		 * 
		 * @param	pc target creature
		 * @param	towards target tone
		 * @param	power desired amount to change, should be positive
		 * @param	display show results of Creature.modTone in output
		 * @return if something actually changed
		 */
		public static function modTone(pc:Creature, towards:Number, power:Number = 1, display:Boolean = true):Boolean {
			buffer = "";
			var changes:Number = 0;
			
			var current:Number = pc.tone;
			towards = Math.min(towards, pc.toneMax());
			towards = Math.max(towards, pc.toneMin());
			
			if (current == towards) return changes > 0;
			power = Math.abs(power); // failsafe
			power = Math.min(power, Math.abs(current - towards));
			if (current > towards) power *= -1;
			if (!pc.toneUnlocked(current + power)) {
				buffer += "\n\n" + pc.toneLockedMessage();
			} else {
				buffer += pc.modTone(power);
				if(pc.tone != current) changes++;
			}
			
			if (display) output(buffer);
			return changes > 0;
		}
		
		/**
		 * Removes amount of cocks, smaller first. All, if amount == -1.
		 */
		public static function killCocks(pc:Creature, amount:Number):Boolean
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (amount < 0) {
				amount = pc.cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (amount > 0) {
				//Find shortest cock and prune it
				temp = pc.cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > pc.cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (pc.cocks[temp].cLength() <= pc.cocks[storedCock].cLength()) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				pc.removeCock(storedCock, 1);
				removed++;
				amount--;
				if (pc.cocks.length == 0) amount = 0;
			}
			//Texts
			if (removed == 1) {
				if (pc.cocks.length == 0) {
					output("<b>Your manhood shrinks into your body, disappearing completely.</b>");
					//if (findStatusAffect(StatusAffects.Infested) >= 0) output("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (pc.cocks.length == 1) {
					output("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [pc.cock].</b>");
				}
				if (pc.cocks.length > 1) {
					output("<b>Your smallest penis disappears forever, leaving you with just [pc.eachCock].</b>");
				}
			}
			if (removed > 1) {
				if (pc.cocks.length == 0) {
					output("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
					//if (findStatusAffect(StatusAffects.Infested) >= 0) output("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (pc.cocks.length == 1) {
					output("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [pc.cock].");
				}
				if (pc.cocks.length > 1) {
					output("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [pc.eachCock].");
				}
			}
			//remove infestation if cockless
			//if (cocks.length == 0) removeStatusAffect(StatusAffects.Infested);
			if (pc.cocks.length == 0 && pc.balls > 0) {
				output("  <b>Your [pc.sack] shrink and disappear, vanishing into your groin.</b>");
				pc.balls = 0;
				pc.ballSizeRaw = 1;
			}
			
			return removed > 0;
		}

		/**
		 * Generic way to grow tits.
		 * @param	pc target to grow
		 * @param	amount how much new weight would be added, exact growth depends on growthType
		 * @param	rowsGrown is now much rows are affected
		 * @param	display
		 * @param	growthType determines how to choose target.
		 * 	1 = equalize rows, if all equal grow top one, skips row is limit is hit. Amount is distributed between rows. Param rowsGrown ignored. Recommended to use breastRows.length as multiplier for amount.
		 *  2 = grow from top and downward by amount, if rowsGrown > than total rows loop. Amount is fully applied to every row, unless limit is hit.
		 *  3 = only top row is affected.
		 *  4 = align rows in stairs pattern, or grow top one. Amount is distributed between rows. growthLimit is for top row, lower rows are each 1 size smaller
		 * @param	growthLimit is how large can it be.
		 */
		public static function growTits(pc:Creature, amount:Number, rowsGrown:Number, display:Boolean, growthType:Number, growthLimit:Number = 999):Boolean
		{
			if (pc.breastRows.length == 0) return false;
			
			//if (growthType == 4 && pc.breastRows.length == 1) growthType = 3;
			
			var temp:Number = pc.breastRows.length;
			var currentRow:Number = 0;
			var result:Number = 0;

			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(amount > 0) {
					//smallest tits index, topmost from even ones
					temp = pc.breastRows.length;
					currentRow = 0;
					while (temp > 0) {
						temp--;
						if (pc.breastRows[currentRow].breastRatingRaw >= pc.breastRows[temp].breastRatingRaw) currentRow = temp;
					}
					
					trace("Breastrow chosen for growth: " + String(currentRow) + ".");
					
					// don't grow above hard limit
					if (currentRow == 0 && pc.breastRows[currentRow].breastRatingRaw >= growthLimit) break;
					
					//track total amount grown
					result++;
					amount--;
					
					//Grow!
					trace("Growing breast row " + currentRow + " by 1");
					pc.breastRows[currentRow].breastRatingRaw++;
				}
			}
			
			if (growthType == 4) {
				var minRow:int = 0;
				//Select smallest breast, grow it, move on
				while (true)  {
					trace("Breastrow chosen for growth: " + String(currentRow) + ".");
					
					// don't grow above hard limit
					if (currentRow == minRow && pc.breastRows[currentRow].breastRatingRaw >= (growthLimit - currentRow)) minRow++;
					if (amount <= 0 || minRow == pc.breastRows.length) break;
					
					//track total amount grown
					result++;
					amount--;

					//Grow!
					trace("Growing breast row " + currentRow + " by 1");
					pc.breastRows[currentRow].breastRatingRaw++;
					
					currentRow++;
					if (currentRow == pc.breastRows.length) currentRow = minRow; // loop while amount > 0 or hard limit hit for all rows
				}
			}

			//Diminishing returns!
			if(pc.breastRows[0].breastRatingRaw > 3) {
				amount/=1.5;
			}
			if(pc.breastRows[0].breastRatingRaw > 7) {
				amount/=2;
			}
			if(pc.breastRows[0].breastRatingRaw > 12) {
				amount/=2;
			}
				
			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if (temp + 1 > pc.breastRows.length) temp = 0;
					if (pc.breastRows[temp].breastRatingRaw < growthLimit) {
						pc.breastRows[temp].breastRatingRaw += amount;
						if (pc.breastRows[temp].breastRatingRaw > growthLimit) pc.breastRows[temp].breastRatingRaw = growthLimit;
						trace("Breasts increased by " + amount + " on row " + temp);
						temp++;
						result += amount;
					}
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					if (pc.breastRows[0].breastRatingRaw < growthLimit) {
						if (pc.breastRows[0].breastRatingRaw > growthLimit) pc.breastRows[0].breastRatingRaw = growthLimit;
						pc.breastRows[0].breastRatingRaw += amount;
						result += amount;
					}
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth ammout = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(pc.breastRows.length > 1) output("Your rows of [pc.fullChest] jiggle with added weight, growing a bit larger.");
						if(pc.breastRows.length == 1) output("Your [pc.fullChest] jiggle with added weight as they expand, growing a bit larger.");
					}
					else if(amount <= 4)
					{
						if(pc.breastRows.length > 1) output("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of [pc.fullChest] expand significantly.");
						if(pc.breastRows.length == 1) output("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your [pc.fullChest] expand significantly.");
					}
					else
					{
						if(pc.breastRows.length > 1) output("You drop to your knees from a massive change in your body's center of gravity.  Your [pc.fullChest] tingle strongly, growing disturbingly large.");
						if(pc.breastRows.length == 1) output("You drop to your knees from a massive change in your center of gravity.  The tingling in your [pc.fullChest] intensifies as they continue to grow at an obscene rate.");
					}
				}
				else
				{
					if(amount <= 2) {
						if(pc.breastRows.length > 1) output("Your top row of [pc.fullChest] jiggles with added weight as it expands, growing a bit larger.");
						if(pc.breastRows.length == 1) output("Your row of [pc.fullChest] jiggles with added weight as it expands, growing a bit larger.");
					}
					if(amount > 2 && amount <= 4) {
						if(pc.breastRows.length > 1) output("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of [pc.fullChest] expand significantly.");
						if(pc.breastRows.length == 1) output("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your [pc.fullChest] expand significantly.");
					}
					if(amount > 4) {
						if(pc.breastRows.length > 1) output("You drop to your knees from a massive change in your body's center of gravity.  Your top row of [pc.fullChest] tingle strongly, growing disturbingly large.");
						if(pc.breastRows.length == 1) output("You drop to your knees from a massive change in your center of gravity.  The tinglng in your [pc.fullChest] intensifies as they continue to grow at an obscene rate.");
					}
				}
			}
			return result > 0;
		}

		/**
		 * Generic way to shrink tits. Shrinks every non-flat row by 1 size. Can sometives shrink by 2 sizes if only one row.
		 */
		public static function shrinkTits(pc:Creature, display:Boolean = true):Boolean
		{
			buffer = "";
			var changed:Boolean = false;
			if(pc.breastRows.length == 1) {
				if(pc.breastRows[0].breastRatingRaw > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					pc.breastRows[0].breastRatingRaw--;
					//Shrink again 50% chance
					//if(pc.breastRows[0].breastRatingRaw >= 1) {
						//temp++;
						//pc.breastRows[0].breastRatingRaw--;
					//}
					if(pc.breastRows[0].breastRatingRaw < 0) pc.breastRows[0].breastRatingRaw = 0;
					//Talk about shrinkage
					if (temp == 1) buffer += "\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + (pc.breastRows[0].breastRating() >= 1 ? pc.breastCup(0) : "flat") + "s.";
					if (temp == 2) buffer += "\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + (pc.breastRows[0].breastRating() >= 1 ? pc.breastCup(0) : "flat") + "s.";
					changed = true;
				}
			}
			else if(pc.breastRows.length > 1) {
				//multiple
				 buffer += "\n";
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = pc.breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(pc.breastRows[temp3].breastRatingRaw > 0) {
						temp2++;
						buffer += "\n";
						if(temp3 < pc.breastRows.length - 1) buffer += "...and y";
						else buffer += "Y";
						buffer += "our " + pc.breastDescript(temp3) + " shrink,";
						pc.breastRows[temp3].breastRatingRaw--;
						if(pc.breastRows[temp3].breastRatingRaw < 0) pc.breastRows[temp3].breastRatingRaw = 0;
						buffer += " dropping to " + (pc.breastRows[temp3].breastRating() >= 1 ? pc.breastCup(temp3) : "flat") + "s.";
					}
					if(pc.breastRows[temp3].breastRatingRaw < 0) pc.breastRows[temp3].breastRatingRaw = 0;
				}
				if (temp2 == 2) buffer += "\nYou feel so much lighter after the change.";
				if (temp2 == 3) buffer += "\nWithout the extra weight you feel particularly limber.";
				if (temp2 >= 4) buffer += "\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.";
				changed = true;
			}
			if (display) output(buffer);
			return changed;
		}

		/** Attempts to put the player in heat (or deeper in heat).
		* Returns true if successful, false if not.
		* The player usually cannot go into heat if she is already pregnant or have no vagina.
		* 
		* First parameter: boolean indicating if function should output standard text.
		* Second parameter: intensity, an integer multiplier that can increase the duration and intensity. Defaults to 1.
		* Third parameter: boolean indicating if this heat will end with pregnancy. If true, nothing would ever end it until it is gone over time, even lack of vagina.
		*/
		public static function goIntoHeat(pc:Creature, out:Boolean, intensity:Number = 1, forced:Boolean = false):Boolean {
			var canVagPreg:Function = function():Boolean {
				for (var i:int = 0; i < pc.vaginas.length; i++)
					if (!pc.isPregnant(i)) return true;
				return false;
			}
			
			if(!forced && !canVagPreg()) {
				return false; // No vagina or already pregnant, can't go into heat.
			}
			
			//Already in heat, intensify further.
			if (pc.hasStatusEffect("Heat")) {
				if(out) {
					output("\n\nYour mind clouds as your [pc.vagina] moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
				}
				pc.setStatusValue("Heat", 1, pc.statusEffectv1("Heat") + 100 * intensity); // fertility bonus
				pc.setStatusValue("Heat", 2, pc.statusEffectv2("Heat") + 20 * intensity); // libido bonus
				if(forced) pc.setStatusValue("Heat", 3, 1); // forced means it would not end if pregnant
				if (pc.hasVagina() && pc.statusEffectv4("Heat") < 4 && pc.vaginas[0].wetnessRaw < 5)
				{
					pc.setStatusValue("Heat", 4, 1); // vaginal wetness bonus
					pc.vaginas[0].wetnessRaw += 1;
				}
				pc.addStatusMinutes("Heat", 48 * 60 * intensity);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is forced (would not end by any means), v4 is wetness bonus
			else {
				if(out) {
					output("\n\nYour mind clouds as your [pc.vagina] moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
				}
				pc.createStatusEffect("Heat", 100 * intensity, 20 * intensity, forced ? 1 : 0, pc.hasVagina() ? 1 : 0, false, "LustUp", "You are aching to be on recieving end of a good fuck due to your animal heat!", false, 48 * 60 * intensity);
				
				if(pc.hasVagina()) pc.vaginas[0].wetnessRaw += 1; // actually, this is horrible, but since we can't access vagina's owner from vagina to check status... either this or special heat field
			}
			return true;
		}


		/** Attempts to put the player in rut (or deeper in rut).
		* Returns true if successful, false if not.
		* The player cannot go into rut without male genitals.
		* 
		* First parameter: boolean indicating if function should output standard text.
		* Second parameter: intensity, an integer multiplier that can increase the duration and intensity. Defaults to 1.
		*/
		public static function goIntoRut(pc:Creature, out:Boolean, intensity:int = 1):Boolean {
			if (!pc.hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			
			//Has rut, intensify it!
			if (pc.hasStatusEffect("Rut")) {
				if(out) {
					output("\n\nYour [pc.multiCocks] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
				}
				
				pc.setStatusValue("Rut", 1, pc.statusEffectv1("Rut") + 100 * intensity); // virility bonus
				pc.setStatusValue("Rut", 2, pc.statusEffectv2("Rut") + 10 * intensity); // libido bonus
				pc.addStatusMinutes("Rut", 48 * 60 * intensity);
			}
			else {
				if(out) {
					output("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				pc.createStatusEffect("Rut", 100 * intensity, 10 * intensity, 0, 0, false, "LustUp", "You desperately want to fuck someone due to your animal rut!", false, 48 * 60 * intensity);
			}
			
			return true;
		}
		
		public static function guessCockType(target:Creature):int {
			var cType:int = GLOBAL.TYPE_HUMAN;
			var race:String = target.race();
			
			// copypaste from race detection for now
			if (target.horseScore() >= 3) cType = GLOBAL.TYPE_EQUINE; // Horse-morphs
			if (target.foxScore() >= 4) cType = GLOBAL.TYPE_VULPINE;
			if (target.kitsuneScore() >= 5 && target.foxScore() < 4) cType = RandomInCollection(GLOBAL.TYPE_HUMAN, GLOBAL.TYPE_VULPINE);
			if (target.lizardScore() >= 4) cType = GLOBAL.TYPE_SNAKE;
			if (target.kangaScore() >= 4) cType = GLOBAL.TYPE_KANGAROO;
			//if (target.bunnyScore() >= 4) race = "bunny-" + mf("boy", "girl");
			if (target.harpyScore() >= 4) cType = GLOBAL.TYPE_AVIAN;
			//if (target.spiderScore() >= 4) race = "spider-" + mf("boy", "girl");
			//if (target.ovirScore() >= 3 && cType == 0) cType = GLOBAL.TYPE_EQUINE; // screws shit
			if (target.ausarScore() >= 2 && cType == 0) cType = GLOBAL.TYPE_CANINE; // Fucking Ausar forever overriding other shit. EXTERMINATUS.
			if (target.kaithritScore() >= 3 && cType == 0) cType = GLOBAL.TYPE_FELINE;
			if (target.leithanScore() >= 3 && cType == 0) cType = GLOBAL.TYPE_SNAKE;
			if (target.nukiScore() >= 2 && cType == 0) cType = GLOBAL.TYPE_KUITAN;
			if (target.raskvelScore() >= 2) cType = GLOBAL.TYPE_SNAKE;
			if (target.bovineScore() >= 3) cType = GLOBAL.TYPE_EQUINE; // Cow-morphs
			if (target.raskvelScore() >= 4) cType = GLOBAL.TYPE_SNAKE;
			//if (target.pandaScore() >= 4) race = "panda-morph";
			if (target.ausarScore() >= 4) cType = GLOBAL.TYPE_CANINE;
			if (target.canineScore() >= 4) cType = GLOBAL.TYPE_CANINE;
			if (target.demonScore() >= 5) cType = GLOBAL.TYPE_DEMONIC;
			if (target.gabilaniScore() >= 5) cType = GLOBAL.TYPE_GABILANI;
			//if (target.frogScore() >= 5) race = "kerokoras";
			if (target.kaithritScore() >= 6) cType = GLOBAL.TYPE_FELINE;
			if (target.felineScore() >= 5) cType = GLOBAL.TYPE_FELINE;
			if (target.leithanScore() >= 6) cType = GLOBAL.TYPE_SNAKE;
			if (target.nukiScore() >= 6) cType = GLOBAL.TYPE_KUITAN;
			//if (target.vanaeScore() >= 6) race = "vanae-morph";
			if (target.raskvelScore() >= 6) cType = GLOBAL.TYPE_SNAKE;
			if (target.zilScore() >= 6) cType = GLOBAL.TYPE_BEE;
			//if (target.badgerScore() >= 4) race = "badger";
			if (target.ovirScore() >= 5) cType = GLOBAL.TYPE_EQUINE;
			//if (target.myrScore() >= 4) race = "myr";
			//if (race == "myr" && target.goldMyrScore() >= 8) race = "gold myr";
			//if (race == "myr" && target.redMyrScore() >= 8) race = "red myr";
			//if (target.orangeMyrScore() >= 9) race = "orange myr";
			// Human-morphs
			//if (race == "human" && target.cowScore() >= 4) cType = GLOBAL.TYPE_EQUINE; // wtf
			// Centaur-morphs
			if (target.horseScore() >= 3 && target.isCentaur()) cType = GLOBAL.TYPE_EQUINE;
			//else if (target.bovineScore() >= 3 && target.isTaur()) cType = GLOBAL.TYPE_EQUINE;
			//else if (race == "human" && target.isCentaur()) cType = GLOBAL.TYPE_EQUINE;
			//else if (target.isTaur()) race = taurRace(race); // Other taurs
			// Naga-morphs
			//if (target.naleenScore() >= 5 && target.isNaga()) cType = GLOBAL.TYPE_SNAKE;
			//else 
			if (target.isNaga()) cType = GLOBAL.TYPE_SNAKE;
			// Slime-morphs
			//if (target.gooScore() >= 6) race = "goo-morph";
			//if (target.gooScore() >= 8) race = "galotian";
			// MLP-morphs
			if (target.legType == GLOBAL.TYPE_MLP) cType = GLOBAL.TYPE_EQUINE;
			// Amalgamations
			//if (race == "human" && humanScore() < 4) race = "alien hybrid";
			
			return cType;
		}
		
		public static function guessVagType(target:Creature):int {
			var cType:int = GLOBAL.TYPE_HUMAN;
			var race:String = target.race();
			
			// copypaste from race detection for now
			if (target.horseScore() >= 3) cType = GLOBAL.TYPE_EQUINE; // Horse-morphs
			if (target.foxScore() >= 4) cType = GLOBAL.TYPE_CANINE;
			if (target.kitsuneScore() >= 5 && target.foxScore() < 4) cType = GLOBAL.TYPE_HUMAN;
			if (target.lizardScore() >= 4) cType = GLOBAL.TYPE_SNAKE;
			//if (target.kangaScore() >= 4) cType = GLOBAL.TYPE_KANGAROO;
			//if (target.bunnyScore() >= 4) race = "bunny-" + mf("boy", "girl");
			//if (target.harpyScore() >= 4) cType = GLOBAL.TYPE_AVIAN;
			//if (target.spiderScore() >= 4) race = "spider-" + mf("boy", "girl");
			//if (target.ovirScore() >= 3 && cType == 0) cType = GLOBAL.TYPE_EQUINE; // screws shit
			//if (target.ausarScore() >= 2 && cType == 0) cType = GLOBAL.TYPE_CANINE; // Fucking Ausar forever overriding other shit. EXTERMINATUS.
			//if (target.kaithritScore() >= 3 && cType == 0) cType = GLOBAL.TYPE_FELINE;
			if (target.leithanScore() >= 3 && cType == 0) cType = GLOBAL.TYPE_LEITHAN;
			if (target.nukiScore() >= 2 && cType == 0) cType = GLOBAL.TYPE_KUITAN;
			if (target.raskvelScore() >= 2) cType = GLOBAL.TYPE_SNAKE;
			if (target.bovineScore() >= 3) cType = GLOBAL.TYPE_EQUINE; // Cow-morphs
			if (target.raskvelScore() >= 4) cType = GLOBAL.TYPE_SNAKE;
			//if (target.pandaScore() >= 4) race = "panda-morph";
			//if (target.ausarScore() >= 4) cType = GLOBAL.TYPE_CANINE;
			if (target.canineScore() >= 4) cType = GLOBAL.TYPE_CANINE;
			//if (target.demonScore() >= 5) cType = GLOBAL.TYPE_DEMONIC;
			if (target.gabilaniScore() >= 5) cType = GLOBAL.TYPE_GABILANI;
			//if (target.frogScore() >= 5) race = "kerokoras";
			//if (target.kaithritScore() >= 6) cType = GLOBAL.TYPE_FELINE;
			if (target.felineScore() >= 5) cType = GLOBAL.TYPE_FELINE;
			if (target.leithanScore() >= 6) cType = GLOBAL.TYPE_LEITHAN;
			if (target.nukiScore() >= 6) cType = GLOBAL.TYPE_KUITAN;
			if (target.vanaeScore() >= 6) cType = GLOBAL.TYPE_VANAE;
			if (target.raskvelScore() >= 6) cType = GLOBAL.TYPE_SNAKE;
			if (target.zilScore() >= 6) cType = GLOBAL.TYPE_BEE;
			//if (target.badgerScore() >= 4) race = "badger";
			//if (target.ovirScore() >= 5) cType = GLOBAL.TYPE_EQUINE;
			//if (target.myrScore() >= 4) race = "myr";
			//if (race == "myr" && target.goldMyrScore() >= 8) race = "gold myr";
			//if (race == "myr" && target.redMyrScore() >= 8) race = "red myr";
			//if (target.orangeMyrScore() >= 9) race = "orange myr";
			// Human-morphs
			//if (race == "human" && target.cowScore() >= 4) cType = GLOBAL.TYPE_EQUINE; // wtf
			// Centaur-morphs
			if (target.horseScore() >= 3 && target.isCentaur()) cType = GLOBAL.TYPE_EQUINE;
			//else if (target.bovineScore() >= 3 && target.isTaur()) cType = GLOBAL.TYPE_EQUINE;
			//else if (race == "human" && target.isCentaur()) cType = GLOBAL.TYPE_EQUINE;
			//else if (target.isTaur()) race = taurRace(race); // Other taurs
			// Naga-morphs
			//if (target.naleenScore() >= 5 && target.isNaga()) cType = GLOBAL.TYPE_SNAKE;
			//else 
			if (target.isNaga()) cType = GLOBAL.TYPE_SNAKE;
			// Slime-morphs
			//if (target.gooScore() >= 6) race = "goo-morph";
			//if (target.gooScore() >= 8) race = "galotian";
			// MLP-morphs
			if (target.legType == GLOBAL.TYPE_MLP) cType = GLOBAL.TYPE_EQUINE;
			// Amalgamations
			//if (race == "human" && humanScore() < 4) race = "alien hybrid";
			
			return cType;
		}
		
		
		/**
		 * Legacy tool. Use example:
		 * Mutator.lengthChange(pc, pc.increaseCock(5,0), pc.cocks.length);
		 */
		public static function lengthChange(pc:Creature, temp2:Number, ncocks:Number):void {
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(pc.cocks.length == 1) output("Your [pc.cock] has grown slightly longer.");
				if(pc.cocks.length > 1) {
					if(ncocks == 1) output("One of your [pc.cocksLight] grows slightly longer.");
					if(ncocks > 1 && ncocks < pc.cocks.length) output("Some of your [pc.cocksLight] grow slightly longer.");
					if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] seem to fill up... growing a little bit larger.");
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(pc.cocks.length == 1) output("A very pleasurable feeling spreads from your groin as your [pc.cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
				if(pc.cocks.length > 1) {
					if(ncocks == pc.cocks.length) output("A very pleasurable feeling spreads from your groin as your [pc.cocksLight] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
					if(ncocks == 1) output("A very pleasurable feeling spreads from your groin as one of your [pc.cocksLight] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
					if(ncocks > 1 && ncocks < pc.cocks.length) output("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [pc.cocksLight] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
				}
			}
			if(temp2 >=3){
				if(pc.cocks.length == 1) output("Your [pc.cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
				if(pc.cocks.length > 1) {
					if(ncocks == 1) output("Your [pc.cocksLight] feel incredibly tight as one of their number begins to grow inch after inch of length.");
					if(ncocks > 1 && ncocks < pc.cocks.length) output("Your [pc.cocksLight] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
					if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] feel incredibly tight as inch after inch of length pour out from your groin.");
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(pc.cocks[0].cLength() >= 8 && pc.cocks[0].cLength()-temp2 < 8){
					if(pc.cocks.length == 1) output("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
					if(pc.cocks.length > 1) output("  <b>Most men would be overly proud to have one cock as long as yours, let alone [pc.cocks].</b>");
				}
				if(pc.cocks[0].cLength() >= 12 && pc.cocks[0].cLength()-temp2 < 12) {
					if(pc.cocks.length == 1) output("  <b>Your [pc.cock] is so long it nearly swings to your knee at its full length.</b>");
					if(pc.cocks.length > 1) output("  <b>Your [pc.cocksLight] are so long they nearly reach your knees when at full length.</b>");
				}
				if(pc.cocks[0].cLength() >= 16 && pc.cocks[0].cLength()-temp2 < 16) {
					if(pc.cocks.length == 1) output("  <b>Your [pc.cock] would look more at home on a large horse than you.</b>");
					if(pc.cocks.length > 1) output("  <b>Your [pc.cocksLight] would look more at home on a large horse than on your body.</b>");
					if (pc.biggestTitSize() >= 3) {
						if (pc.cocks.length == 1) output("  You could easily stuff your [pc.cock] between your breasts and give yourself the titty-fuck of a lifetime.");
						if (pc.cocks.length > 1) output("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
					}
					else {
						if(pc.cocks.length == 1) output("  Your [pc.cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
						if(pc.cocks.length > 1) output("  Your [pc.cocksLight] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
					}
				}
				if(pc.cocks[0].cLength() >= 20 && pc.cocks[0].cLength()-temp2 < 20) {
					if(pc.cocks.length == 1) output("  <b>As if the pulsing heat of your [pc.cock] wasn't enough, the tip of your [pc.cock] keeps poking its way into your view every time you get hard.</b>");
					if(pc.cocks.length > 1) output("  <b>As if the pulsing heat of your [pc.cocksLight] wasn't bad enough, every time you get hard, the tips of your [pc.cocksLight] wave before you, obscuring the lower portions of your vision.</b>");
					if(pc.cor() > 40 && pc.cor() <= 60) {
						if(pc.cocks.length > 1) output("  You wonder if there is a demon or beast out there that could take the full length of one of your [pc.cocksLight]?");
						if(pc.cocks.length ==1) output("  You wonder if there is a demon or beast out there that could handle your full length.");
					}
					if(pc.cor() > 60 && pc.cor() <= 80) {
						if(pc.cocks.length > 1) output("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [pc.cocksLight] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
						if(pc.cocks.length ==1) output("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [pc.cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
					}
					if(pc.cor() > 80) {
						if(pc.cocks.length > 1) output("  You find yourself fantasizing about impaling nubile young champions on your [pc.cocksLight] in a year's time.");
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(pc.cocks.length == 1) output("Your [pc.cocksLight] has shrunk to a slightly shorter length.");
				if(pc.cocks.length > 1) {
					if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] have shrunk to a slightly shorter length.");
					if(ncocks > 1 && ncocks < pc.cocks.length) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] have shrunk to a slightly shorter length.");
					if(ncocks == 1) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] has shrunk to a slightly shorter length.");
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(pc.cocks.length == 1) output("Your [pc.cocksLight] shrinks smaller, flesh vanishing into your groin.");
				if(pc.cocks.length > 1) {
					if(ncocks == pc.cocks.length) output("Your [pc.cocksLight] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks == 1) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks > 1 && ncocks < pc.cocks.length) output("You feel " + num2Text(ncocks) + " of your [pc.cocksLight] shrink smaller, the flesh vanishing into your groin.");
				}
			}
			if(temp2 <= -3) {
				if(pc.cocks.length == 1) output("A large portion of your [pc.cocksLight]'s length shrinks and vanishes.");
				if(pc.cocks.length > 1) {
					if(ncocks == pc.cocks.length) output("A large portion of your [pc.cocksLight] receeds towards your groin, receding rapidly in length.");
					if(ncocks == 1) output("A single member of your [pc.cocksLight] vanishes into your groin, receding rapidly in length.", false);
					if(ncocks > 1 && pc.cocks.length > ncocks) output("Your [pc.cocksLight] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
				}
			}
		}
	}
}