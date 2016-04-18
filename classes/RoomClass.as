﻿package classes
{
	public class RoomClass
	{
		private var titsClassPtr:*;

		//constructor
		public function RoomClass(titsClassPtrArg:*)
		{
			
			this.titsClassPtr = titsClassPtrArg;
			choices = new Array();
		}
		// include "consts.as";
		//data
		public var planet:String = "";
		//Used on inventory buttons
		public var system:String = "";
		//Room Name
		public var roomName:String = "";
		//Longass shit, not sure what used for yet.
		public var description:String = "";
		//runOnEnter holds functions that overlay the normal functioning
		public var runOnEnter:Function = undefined;
		
		// runAfterEnter gets executed *AFTER* all the standard button controls have been placed- handy for hooking shit
		public var runAfterEnter:Function = undefined;
				
		//Information
		public var moveMinutes:Number = 5;
		public var roomFlags:Array = new Array();
		
		public var choices:Array = new Array();
		
		//Exits - these point to the room key in rooms
		public var northExit:String = "";
		public var eastExit:String = "";
		public var southExit:String = "";
		public var westExit:String = "";
		public var inExit:String = "";
		public var inText:String = "In";
		public var outExit:String = "";
		public var outText:String = "Out";

		public var canSaveInRoom:Boolean = true;
		

		//Functions
		public function hasFlag(arg:int):Boolean {
			for(var x:int = 0; x < roomFlags.length; x++) {
				if(roomFlags[x] == arg) return true;
			}
			return false;
		}
		public function addFlags(...arg:Array/*int*/):void {
			for (var x:int = 0; x < arg.length; x++) {
				addFlag(arg[x]);
			}
		}
		public function addFlag(arg:int):void {
			if(hasFlag(arg)) return;
			roomFlags[roomFlags.length] = arg;
		}
		public function removeFlags(...arg:Array/*int*/):void {
			for (var x:int = 0; x < arg.length; x++) {
				removeFlag(arg[x]);
			}
		}
		public function removeFlag(arg:int):void {
			for(var x:int = 0; x < roomFlags.length; x++) {
				if(arg == roomFlags[x]) roomFlags.splice(x,1);
			}
		}
	}
}
