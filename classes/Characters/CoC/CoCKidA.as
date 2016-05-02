package classes.Characters.CoC 
{
	import classes.Items.Miscellaneous.EmptySlot;
	
	public class CoCKidA extends CoCAnemone
	{
		public function CoCKidA() 
		{
			this._latestVersion = 1;
			this.version = _latestVersion;
			this._neverSerialize = false;
			
			this.short = "Kid A";
			
			this.rangedWeapon = new EmptySlot();
			this.meleeWeapon = new EmptySlot();
			
			this.thickness = 25;
			this.tone = 30;
			this.hairLength = 4;
			this.hipRatingRaw = 2;
			this.buttRatingRaw = 2;
			this.breastRows[0].breastRatingRaw = 1; // A
			this.personality = 15;
			
			this._isLoading = false;
		}
	}
}