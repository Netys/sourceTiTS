package classes.Engine.Utility 
{
	/**
	 * Basically wrapped "list".
	 * @author Etis
	 */
	public class enum
	{
		private static var list:Array;
		
		public static function push(...args):void
		{
			list.push(args);
		}
		
		public static function clear():void
		{
			list = new Array();
		}
		
		public static function isEmpty():Boolean
		{
			return list.length == 0;
		}
		
		public static function length():int
		{
			return list.length;
		}
		
		public static function toString():String
		{
			var stuff:String = "";
			if (list.length == 1) {
				stuff = list[0];
				clear();
				return stuff;
			}
			for(var x:int = 0; x < list.length; x++) {
				stuff += list[x];
				if(list.length == 2 && x == 0) {
					stuff += " and ";
				}
				else if(x < list.length-2) {
					stuff += ", ";
				}
				else if(x < list.length-1) {
					stuff += ", and ";
				}
			}
			clear();
			return stuff;
		}
	}
}