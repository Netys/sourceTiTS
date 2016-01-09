/**
 * Context suggestions, ho!
 * @author Etis
 */
package classes.Engine.Interfaces 
{
	import classes.Characters.PlayerCharacter;
	import classes.kGAMECLASS;
	public function get pc():PlayerCharacter
	{
		return kGAMECLASS.pc;
	}
	
	import flash.utils.Dictionary;
	public function get flags():Dictionary
	{
		return kGAMECLASS.flags;
	}
	import classes.Creature;
	public function get chars():/*Creature*/Array // dirty, dirty, DIRTY hack...
	{
		return kGAMECLASS.chars;
	}
	public function get foes():/*Creature*/Array {
		return kGAMECLASS.foes() }
	
	public function addItemButton(slot:int, item:ItemSlotClass, func:Function = undefined, arg:* = undefined, ttHeader:String = null, ttBody:String = null, seller:Creature = null, buyer:Creature = null):void	{
		kGAMECLASS.addItemButton(slot, item, func, arg:*, ttHeader, ttBody, seller, buyer); }
		
	public function addDisabledButton(slot:int, cap:String = "", ttHeader:String = null, ttBody:String = null):void	{
		kGAMECLASS.addDisabledButton(slot, cap, ttHeader, ttBody); }
		
	public function processTime(arg:int):void {
		kGAMECLASS.processTime(arg); }
	}
	
	public function badEnd():void {
		kGAMECLASS.badEnd(); }
	
	public function mainGameMenu():void {
		kGAMECLASS.mainGameMenu(); }
		
	public function get silly():Boolean {
		return kGAMECLASS.silly; }
	public function get easy():Boolean {
		return kGAMECLASS.easy; }
	public function get debug():Boolean {
		return kGAMECLASS.debug; }
	public function get timeAsStamp():uint {
		return kGAMECLASS.GetGameTimestamp(); }
}