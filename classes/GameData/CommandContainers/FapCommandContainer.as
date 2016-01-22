package classes.GameData.CommandContainers 
{
	import classes.GameData.CommandContainer;
	/**
	 * ...
	 * @author Gedan
	 */
	public class FapCommandContainer extends CommandContainer
	{
		public var ignoreRandomSelection:Boolean;
		public var ignorePublic:Boolean;
		
		public function FapCommandContainer() 
		{
			ignoreRandomSelection = false;
			ignorePublic = false;
		}
		
	}

}