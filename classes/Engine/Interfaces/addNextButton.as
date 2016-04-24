package classes.Engine.Interfaces 
{
	/**
	 * ...
	 * @author Etis
	 */
	import classes.kGAMECLASS;
	public function addNextButton(func:Function = kGAMECLASS.mainGameMenu, arg:* = undefined):void
	{
		kGAMECLASS.addNextButton(func, arg);
	}
}