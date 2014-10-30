package managers;
import flixel.FlxG;
import flixel.util.FlxPoint;
import game.GlobalGameData;
import haxe.xml.Fast;
import managers.DisplayManager;
import managers.EventManager;
import event.EventType;
import flixel.group.FlxGroup;
import objects.Apple;
import objects.Arrow;
import objects.BullsEye;
import objects.GameObject;
import openfl.Assets;
import utils.DisplayLayers;
import utils.MathUtil;
import utils.ObjectPool;

/**
 * ...
 * @author Lim Chian Song
 */

class DataStats
{
	public function new(_data:Int, _cost:Int)
	{
		data = _data;
		cost = _cost;
	}
	public var data:Int;
	public var cost:Int;
}

//Game Data that is need all the time during the game and upgrade
class GameDataManager
{
	public static var mGoldEarned:Int;
	public static var mHighestScore:Int;
	public static var mHighestCombo:Int; //For in the game only.
	public static var mCriticalCount:Int;
	
	/////////////////
	//Upgrade Stuff//
	/////////////////
	//Arrow Speed
	//public static var mArrowSpeedMap:Map<Int,DataStats>;
	//public static var mArrowSpeedDescription:String;
	//public static var mArrowSpeedLevel:Int;
	//Arrow Number
	public static var mArrowNoMap:Map<Int,DataStats>;
	public static var mArrowNoDescription:String;
	public static var mArrowNoLevel:Int;
	//Gold% Number
	public static var mGoldMap:Map<Int,DataStats>;
	public static var mGoldDescription:String;
	public static var mGoldLevel:Int;
	//Apple% Number
	public static var mAppleMap:Map<Int,DataStats>;
	public static var mAppleDescription:String;
	public static var mAppleLevel:Int;
	//Timer time Number
	public static var mTimerMap:Map<Int,DataStats>;
	public static var mTimerDescription:String;
	public static var mTimerLevel:Int;
	
	//Current Level
	public static var mAppleCurrentLevel:Int;
	public static var mGoldCurrentLevel:Int;
	public static var mAppleChance:Int;
	public static var mGoldChance:Int;
	public static var mGameTimer:Float;
	public static var mTotalTimer:Float;
	private static var mHasStarted:Bool;
	
	public static function init():Void
	{
		EventManager.subscrible(EventType.GAME_INIT, onGameEnter);
		EventManager.subscrible(EventType.GAMESTART, onGameStart);
		EventManager.subscrible(EventType.GAME_OVER, onGameOver);
		
		//mArrowSpeedMap 	= new Map<Int,DataStats>();
		mArrowNoMap 	= new Map<Int,DataStats>();
		mGoldMap 		= new Map<Int,DataStats>();
		mAppleMap 		= new Map<Int,DataStats>();
		mTimerMap		= new Map<Int,DataStats>();
		
		//parseArrowSpeedData(Assets.getText("data/arrowspeeddata.xml"));
		parseArrowNoData(Assets.getText("data/arrownumberdata.xml"));
		parseGoldData(Assets.getText("data/goldchancedata.xml"));
		parseAppleData(Assets.getText("data/applechancedata.xml"));
		parseTimerData(Assets.getText("data/timertimedata.xml"));
	}
	
	public static function addGoldEarned(value:Int):Void
	{
		mGoldEarned += value;
	}
	
	/**
	 * The Game has Enter
	 * @param	evt
	 * @param	params
	 */
	private static function onGameEnter(evt:Int, params:Dynamic):Void
	{
		mGoldEarned = 0;
		mHighestCombo = 0;
		mCriticalCount = 0;
		mGameTimer = mTimerMap.get(GlobalGameData.timerLevel).data;
		mTotalTimer = 0;
		mHasStarted = false;
	}
	
	private static function onGameStart(evt:Int, params:Dynamic):Void
	{
		mHasStarted = true;
	}
	
	private static function onGameOver(evt:Int, params:Dynamic):Void
	{
		//Save in the game.
		GlobalGameData.addGold(mGoldEarned);
		GlobalGameData.save();
	}
	
	public static function update()
	{
		if (GameObjectManager.mGameOver)
			return;
		
		if (!mHasStarted)
			return;
		
		mGameTimer -= FlxG.elapsed;
		mTotalTimer += FlxG.elapsed;
		
		if (mGameTimer <= 0)
			EventManager.triggerEvent(EventType.GAME_OVER);
	}
	
	public static function increaseTimeLevel():Void
	{
		GlobalGameData.timerLevel += 1;
	}
	
	public static function addTime(time:Float):Void
	{
		mGameTimer += time;
	}
	
	public static function parseArrowNoData(assetFile:String)
	{
		var arrownoXML = new Fast(Xml.parse(assetFile).firstElement());
		mArrowNoDescription = arrownoXML.node.description.innerData;
		
		var count:Int = 0;
		for (data in arrownoXML.nodes.level)
		{
			var level:Int = Std.parseInt(data.innerData);
			//The info
			var no:Int = Std.parseInt(data.att.number);
			var cost:Int = Std.parseInt(data.att.cost);
			
			var arrowData:DataStats = new DataStats(no, cost);
			
			++count;
			mArrowNoMap.set(level, arrowData);
		}
		mArrowNoLevel = count;
	}
	
	/**
	 * Get The Data File Needed for Gold%
	 * @param	assetFile
	 */
	public static function parseGoldData(assetFile:String)
	{
		var goldXML = new Fast(Xml.parse(assetFile).firstElement());
		mGoldDescription = goldXML.node.description.innerData;
		
		var count:Int = 0;
		for (data in goldXML.nodes.level)
		{
			var level:Int = Std.parseInt(data.innerData);
			//The info
			var no:Int = Std.parseInt(data.att.precent);
			var cost:Int = Std.parseInt(data.att.cost);
			
			var goldData:DataStats = new DataStats(no, cost);
			
			++count;
			mGoldMap.set(level, goldData);
		}
		mGoldLevel = count;
	}
	
	/**
	 * Get The Data File Needed for Apple%
	 * @param	assetFile
	 */
	public static function parseAppleData(assetFile:String)
	{
		var appleXML = new Fast(Xml.parse(assetFile).firstElement());
		mAppleDescription = appleXML.node.description.innerData;
		
		var count:Int = 0;
		for (data in appleXML.nodes.level)
		{
			var level:Int = Std.parseInt(data.innerData);
			//The info
			var no:Int = Std.parseInt(data.att.precent);
			var cost:Int = Std.parseInt(data.att.cost);
			
			var appleData:DataStats = new DataStats(no, cost);
			
			++count;
			mAppleMap.set(level, appleData);
		}
		mAppleLevel = count;
	}
	
	 /**
	 * Get The Data File Needed for Timer
	 * @param	assetFile
	 */
	public static function parseTimerData(assetFile:String)
	{
		var timerXML = new Fast(Xml.parse(assetFile).firstElement());
		mTimerDescription = timerXML.node.description.innerData;
		
		var count:Int = 0;
		for (data in timerXML.nodes.level)
		{
			var level:Int = Std.parseInt(data.innerData);
			//The info
			var no:Int = Std.parseInt(data.att.time);
			var cost:Int = Std.parseInt(data.att.cost);
			
			var timerData:DataStats = new DataStats(no, cost);
			
			++count;
			mTimerMap.set(level, timerData);
		}
		mTimerLevel = count;
	}
}