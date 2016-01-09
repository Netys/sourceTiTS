package classes.Characters.CoC 
{
	import classes.Creature;
	import classes.Engine.Combat.DamageTypes.TypeCollection;
	import classes.GLOBAL;
	import classes.Items.Melee.Fists;
	import classes.Items.Miscellaneous.EmptySlot;
	import classes.kGAMECLASS;
	import classes.rand;
	import classes.GameData.CodexManager;
	import classes.TITSSaveEdit.Data.CoCTypeDefs;
	import classes.Items.Transformatives.*;
	import classes.Items.Drinks.*;
	
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
			
			this._isLoading = false;
		}		
	}
}