package game;
import flixel.util.FlxSave;
import managers.ShopManager;
import states.PlayState;
import states.ShopState;

/**
 * ...
 * @author CS.Lim
 */
class GlobalGameData
{
	private static var gameSaveData:FlxSave;
	private static var gold:Int;
	private static var highestScore:Int;
	private static var arrowSpeedLevel:Int;
	
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
		gameSaveData.flush();
	}
	
	public static function load():Void
	{
		//First time we enter the game. 
		if (gameSaveData.data.gold == null)
		{
			gold = 0;
			highestScore = 0;
			return;
		}
		
		gold = gameSaveData.data.gold;		
	}
	
	public static function getGold():Int
	{
		return gold;
	}
	
	public static function addGold(_value):Void
	{
		gold += _value;
	}
}