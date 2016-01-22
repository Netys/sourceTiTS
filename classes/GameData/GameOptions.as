package classes.GameData 
{
	import classes.DataManager.Serialization.UnversionedSaveable;
	/**
	 * ...
	 * @author Gedan
	 */
	public class GameOptions extends UnversionedSaveable
	{
		
		public function GameOptions() 
		{
			bustPriority = ["CHESHIRE", "SHOU", "GATS", "GATSOLD"];
			bustsEnabled = true;
			bustFallbacks = true;
			easyMode = false;
			sillyMode = false;
			debugMode = false;
			fontSize = 18;
			combineDamageValueOutput = false;
			colourDamageValueOutput = true;
			saveNotesToggle = true;
			overwriteToggle = true;
			authorToggle = true;
			vendorToggle = true;
		}
		
		public function setBustPriority(artist:String, priority:int):void
		{
			if (priority < 0 || priority > 3) return;
			if (artist != "CHESHIRE" && artist != "GATS" && artist != "GATSOLD" && artist != "SHOU" && artist != "none") return;
			
			if (artist == "none")
			{
				bustPriority.splice(priority, 1);
				return;
			}
			
			// Artist exsts in array
			if (bustPriority.indexOf(artist) != -1)
			{
				// Correct location exit
				if (bustPriority.indexOf(artist) == priority) return;
				
				// Splice out if new prio < old prio
				if (bustPriority.indexOf(artist) > priority) bustPriority.splice(bustPriority.indexOf(artist), 1);
				else return;
			}
			
			bustPriority.splice(priority, 0, artist);
			
			trace("boop");
		}
		
		public function getBustPriority(priority:int):String
		{
			if (priority < 0 || priority > 3) return null;
			
			if (priority > bustPriority.length) return null;
			
			return bustPriority[priority];
		}
		
		// Busts disabled
		public var bustsEnabled:Boolean;
		
		// Priority list of bust names
		public var bustPriority:Array;
		
		// Allow bust fallback images to be displayed
		public var bustFallbacks:Boolean;
		
		// Game mode settings
		
		// Easy
		public var easyMode:Boolean;
		
		// Debug
		public var debugMode:Boolean;
		
		// Silly
		public var sillyMode:Boolean;
		
		// Text Settings
		
		// FontSize
		public var fontSize:int;
		
		public var combineDamageValueOutput:Boolean;
		public var colourDamageValueOutput:Boolean;
		public var saveNotesToggle:Boolean;
		public var overwriteToggle:Boolean;
		public var authorToggle:Boolean;
		public var vendorToggle:Boolean;
	}

}
