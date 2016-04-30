import flash.events.MouseEvent;
import flash.ui.Mouse;
	
//Table of Contents
//0. PARSER
//1: TEXT FUNCTIONS
//2. DISPLAY STUFF
//3. UTILITY FUNCTIONS
//4. MOVEMENTS


public function doParse(script:String, markdown:Boolean = false):String 
{
	return parser.recursiveParser(script, markdown);
}

// HTML tag formatting wrappers, because lazy as fuck
public function header(words:String, newLine:Boolean = true):String
{
	if(!newLine) return String("<span class='header'>" + words + "</span>");
	return String("<span class='header'>" + words + "</span>\n");
}

public function blockHeader(words:String, newLine:Boolean = true):String
{
	if(!newLine) return String("<span class='blockHeader'>" + words + "</span>");
	return String("<span class='blockHeader'>" + words + "</span>\n");
}

//1: TEXT FUNCTIONS
public function output(words:String, markdown:Boolean = false, parse:Boolean = true):void 
{
	if (parse) this.userInterface.outputBuffer += doParse(words, markdown);
	else this.userInterface.outputBuffer += words;
	this.userInterface.output();
}

public function clearOutput():void 
{
	if (this.userInterface.imgString != null && this.userInterface.imgString.length > 0) this.userInterface.imgString = "";
	this.userInterface.clearOutput();
}

public function output2(words:String, markdown:Boolean = false):void
{
	this.userInterface.outputBuffer2 += doParse(words, markdown);
	this.userInterface.output2();
}

public function clearOutput2():void
{
	this.userInterface.clearOutput2();
}

public function outputCodex(words:String, markdown:Boolean = false):void
{
	this.userInterface.outputCodexBuffer += doParse(words, markdown);
}

public function clearOutputCodex():void
{
	this.userInterface.clearOutputCodex();
}

public function num2Text(number:Number, capitalize:Boolean = false):String {
	return classes.Engine.Utility.num2Text(number, capitalize);
}

public function num2Text2(number:int):String {
	return classes.Engine.Utility.num2Ordinal(number);
}

public function leftBarClear():void {
	this.userInterface.leftBarClear();
}
public function hidePCStats():void {
	this.userInterface.hidePCStats()
}
public function showPCStats():void {
	this.userInterface.showPCStats()
}
public function showNPCStats():void {
	this.userInterface.showNPCStats()
}
public function hideNPCStats():void {
	this.userInterface.hideNPCStats()
}
public function showMinimap():void {
	this.userInterface.showMinimap();
}
public function hideMinimap():void {
	this.userInterface.hideMinimap();
}
public function deglow():void 
{
	this.userInterface.deglow()
}

public function updatePCStats():void 
{
	if (!inCombat()) userInterface.showPlayerParty([pc]); // Combat will handle this correctly
	
	if ((pc as PlayerCharacter).levelUpAvailable())
	{
		if (gameOverEvent == true || inSceneBlockSaving == true)
		{
			userInterface.levelUpButton.Deactivate();
		}
		else
		{
			userInterface.levelUpButton.Activate();
		}
	}
	else
	{
		userInterface.levelUpButton.Deactivate();
	}
}

public function setLocation(title:String, planet:String = "Error Planet", system:String = "Error System"):void 
{
	userInterface.setLocation(title, planet, system);
}

public function clearList():void
{
	list = new Array();
}

public var list:Array = new Array();

public function addToList(arg:*):void
{
	list[list.length] = arg;
}
public function formatList():String {
	var stuff:String = "";
	if(list.length == 1) return list[0];
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
	list = new Array();
	return stuff;	
}
