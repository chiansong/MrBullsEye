package managers;
import flixel.FlxG;
import flixel.util.FlxPoint;
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
class GameInfoStats
{
	public function new(_speed:Float, _power:Float)
	{
		speed = _speed;
		power = _power;
	}
	
	public var speed:Float;
	public var power:Float;
}

class GameData
{
	public function new(_time:Float,
						_speedY:Int,
						_maxPoint:Int,	
						_lvl2Chance:Int,	
						_lvl3Chance:Int,
						_lvl4Chance:Int,	
						_lvl5Chance:Int)
	{
		time     	= _time;
		speedY	    = _speedY;
		maxPoint	= _maxPoint;	
		lvl2Chance	= _lvl2Chance;
		lvl3Chance	= _lvl3Chance;
		lvl4Chance	= _lvl4Chance;
		lvl5Chance	= _lvl5Chance;
	}
	
	public var time:Float;
	public var speedY:Int;
	public var maxPoint:Int;
	public var appleChance:Int;
	public var lvl2Chance:Int;
	public var lvl3Chance:Int;
	public var lvl4Chance:Int;
	public var lvl5Chance:Int;
}
 
class GameObjectManager
{
	public static var mGroup:FlxGroup;
	public static var mStartingPosition:FlxPoint;
	private static var mBullEyePool:ObjectPool<GameObject>;
	private static var mApplePool:ObjectPool<Apple>;
	private static var mActiveArray:Array<GameObject>;
	private static var mGameDataMap:Map<Int,GameData>;
	private static var mLanuchTime:Float;
	private static var mLanuchTimer:Float;
	
	private static var mPreviousMovementSpeedY:Float;
	private static var mMovementSpeedY:Float;
	private static var mGameLevel:Int;
	private static var mGameOver:Bool;
	
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mActiveArray = new Array<GameObject>();
		mGameDataMap = new Map<Int,GameData>();
		mBullEyePool = new ObjectPool<GameObject>(50, createBullsEye);
		mApplePool = new ObjectPool<Apple>(10, createApple);
		
		mStartingPosition = new FlxPoint();
		setPosition(FlxG.width - 100, -34);
		mPreviousMovementSpeedY = 0;
		mMovementSpeedY = 100;
		mGameLevel = 1;
		mLanuchTime = 1;
		mLanuchTimer = 0;
		
		mGameOver = false;
		
		parseGameData(Assets.getText("data/gamedata.xml"));
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.GAME_OVER, onGameOver);
		EventManager.subscrible(EventType.OBJECT_MOVE, onLanuch);
		EventManager.subscrible(EventType.OBJECT_OUT, onOut);
		EventManager.subscrible(EventType.SPEED_UP, onSpeedUp);
		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
	}
	
	private static function createBullsEye():BullsEye
	{
		var bullseye = new BullsEye();
		bullseye.kill();
		mGroup.add(bullseye);
		return bullseye;
	}
	
	private static function createApple():Apple
	{
		var apple = new Apple();
		apple.kill();
		mGroup.add(apple);
		return apple;
	}
	
	public static function setPosition(_x:Float, _y:Float)
	{
		mStartingPosition.set(_x, _y);
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		DisplayManager.addToLayer(mGroup, DisplayLayers.OBJECT1LAYER.getIndex());
		
		mMovementSpeedY = 100;
		mGameLevel = 1;
		mLanuchTime = 1;
		mLanuchTimer = 0;
		
		mGameOver = false;
	}
	
	private static function onGameOver(evt:Int, params:Dynamic):Void
	{
		//STOP EVERYTHING
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].mSpeedY = 0;
		}
		mGameOver = true;
	}
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		//STOP EVERYTHING
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].kill();
		}
	}
	
	private static function onOut(evt:Int, params:Dynamic):Void
	{
		mActiveArray.remove(params.object);
	}
	
	private static function onLanuch(evt:Int, params:Dynamic):Void
	{
		//Grab an Apple
		var object:GameObject;
		if (MathUtil.getRandomBetween(0, 100) < 0)
			object = mApplePool.get();
		else
			object = mBullEyePool.get();
		object.activate(mStartingPosition, 0, mMovementSpeedY);
		mActiveArray.push(object);
	}
	
	private static function onLevelUp(evt:Int, params:Dynamic):Void
	{
		
	}
	
	public static function update():Void
	{
		if (mGameOver)
			return;
		
		mLanuchTimer += FlxG.elapsed;
		if (mLanuchTimer > mLanuchTime)
		{
			EventManager.triggerEvent(EventType.OBJECT_MOVE);
			mLanuchTimer = 0;
		}
		updateSpeed();
	}
	
	private static function onSpeedUp(evt:Int, params:Dynamic):Void
	{
		//Reduce the max and reset combo
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].mSpeedY = params.speed;
		}
	}
	
	public static function updateSpeed():Void
	{
		if (ScoreManager.mScore > mGameDataMap.get(mGameLevel).maxPoint)
		{
			mGameLevel += 1;
		}
		mLanuchTime = mGameDataMap.get(mGameLevel).time;
		mMovementSpeedY = mGameDataMap.get(mGameLevel).speedY;
		
		if (mPreviousMovementSpeedY != mMovementSpeedY)
		{
			EventManager.triggerEvent(EventType.SPEED_UP, { speed:mMovementSpeedY } );
			mPreviousMovementSpeedY = mMovementSpeedY;
		}
	}
	
	public static function parseGameData(assetFile:String)
	{
		var gameDataXML = new Fast(Xml.parse(assetFile).firstElement());
		//Let Grab the INFO
		for (data in gameDataXML.nodes.level)
		{
			var level:Int = Std.parseInt(data.innerData);
			var time:Float = Std.parseFloat(data.att.time);
			var speedY:Int = Std.parseInt(data.att.speedY);
			var max:Int = Std.parseInt(data.att.max);
			//Get the Levels
			var lvl2:Int = Std.parseInt(data.att.lvl2);
			var lvl3:Int = Std.parseInt(data.att.lvl3);
			var lvl4:Int = Std.parseInt(data.att.lvl4);
			var lvl5:Int = Std.parseInt(data.att.lvl5);
		
			var dataStats:GameData = new GameData(time, speedY, max,
												  lvl2, lvl3, lvl4, lvl5);
											
			
			mGameDataMap.set(level, dataStats);
		}
	}
	
	public static function parseArrowData(assetFile:String)
	{
		//var arrowXML = new Fast(Xml.parse(assetFile).firstElement());
	}
}