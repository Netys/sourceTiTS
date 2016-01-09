package classes.Characters.CoC
{
	import classes.Creature;
	import classes.GLOBAL;
	
	public class CoCTrader extends Creature
	{
		//constructor
		public function CoCTrader()
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = true;
			
			this.short = "";
			this.sellMarkup = 1.;
			this.buyMarkdown = 1.;
			this.typesBought = [GLOBAL.ALL];
		}
	}
}
