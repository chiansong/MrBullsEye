package game;
import flixel.util.FlxSave;
import managers.ShopManager;
import states.PlayState;
import states.ShopState;

/**
 * Indeed, one might ask what is the different between
 * game data manager vs global game data ... let me tell you
 * Global game data is for information need to be saved.
 * @author CS.Lim
 */
class GlobalGameData
{
	public static var gameSaveData:FlxSave;
	public static var gold:Int;
	public static var highestScore:Int;
	
	//Upgrades
	public static var arrowSpeedLevel:Int;
	public static var arrowNoLevel:Int;
	public static var goldLevel:Int;
	public static var appleLevel:Int;
	public static var timerLevel:Int; //Newly added timer.
	
	public static var mPlayState:PlayState;
	public static var mShopState:ShopState;
	
	public static function init():Void
	{
		mPlayState = new PlayState();
		mShopState = new ShopState();
		
		gameSaveData = new FlxSave();
		gameSaveData.bind("SaveData");
	}
	
	public static function save():Void
	{
		//If there is nothing, save the stuff.
		gameSaveData.data.gold = gold;
		gameSaveData.data.arrowSpeedLevel = arrowSpeedLevel;
		gameSaveData.data.arrowNoLevel = arrowNoLevel;
		gameSaveData.data.goldLevel = goldLevel;
		gameSaveData.data.appleLevel = appleLevel; 
		
		//Save it
		gameSaveData.flush();
	}
	
	public static function load():Void
	{
		//First time we enter the game. 
		if (gameSaveData.data.gold == null)
		{
			gold = 0;
			highestScore = 0;
			arrowSpeedLevel = 0;
			arrowNoLevel = 0;
			goldLevel = 0;
			appleLevel = 0;
			timerLevel = 0;
			return;
		}
		
		gold = gameSaveData.data.gold;
		arrowSpeedLevel = gameSaveData.data.arrowSpeedLevel;
		arrowNoLevel = gameSaveData.data.arrowNoLevel;
		goldLevel = gameSaveData.data.goldLevel;
		appleLevel = gameSaveData.data.appleLevel;
		highestScore = gameSaveData.data.highestScore;
		timerLevel = gameSaveData.data.timerLevel;
	}
	
	public static function getGold():Int
	{
		return gold;
	}
	/**
	 * Let deduct the gold
	 * @param	_value
	 * @return true - got / false - never
	 */
	public static function deductGold(_value):Bool
	{
		//Check if there isn gold.
		if (gold < _value)
			return false;
		//Remove the gold
		gold -= _value;
		//U did it !!!
		return true;
	}
	
	public static function addGold(_value):Void
	{
		gold += _value;
	}
	
	//Erase Game ... might be used for erase info next time.
	public static function eraseResetGame():Void
	{
		gameSaveData.erase();
	}
}