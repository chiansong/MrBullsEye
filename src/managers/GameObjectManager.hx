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
import utils.DisplayLayers;
import utils.MathUtil;
import utils.ObjectPool;

/**
 * ...
 * @author Lim Chian Song
 */
class BullsEyeStats
{
	public function new(_speed:Float, _power:Float)
	{
		speed = _speed;
		power = _power;
	}
	
	public var speed:Float;
	public var power:Float;
}
 
class GameObjectManager
{
	public static var mGroup:FlxGroup;
	public static var mStartingPosition:FlxPoint;
	private static var mBullEyePool:ObjectPool<GameObject>;
	private static var mApplePool:ObjectPool<Apple>;
	private static var mActiveArray:Array<GameObject>;
	private static var mLanuchTime:Float;
	private static var mLanuchTimer:Float;
	
	private static var mPreviousMovementSpeedY:Float;
	private static var mMovementSpeedY:Float;
	
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mActiveArray = new Array<GameObject>();
		mBullEyePool = new ObjectPool<GameObject>(50, createBullsEye);
		mApplePool = new ObjectPool<Apple>(10, createApple);
		
		mStartingPosition = new FlxPoint();
		setPosition(FlxG.width - 100, -34);
		mPreviousMovementSpeedY = 0;
		mMovementSpeedY = 100;
		mLanuchTime = 1;
		mLanuchTimer = 0;
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.OBJECT_MOVE, onLanuch);
		EventManager.subscrible(EventType.OBJECT_OUT, onOut);
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
	}
	
	private static function onOut(evt:Int, params:Dynamic):Void
	{
		mActiveArray.remove(params.object);
	}
	
	
	private static function onLanuch(evt:Int, params:Dynamic):Void
	{
		//Grab an Apple
		var object:GameObject;
		if (MathUtil.getRandomBetween(0, 100) < 15)
			object = mApplePool.get();
		else
			object = mBullEyePool.get();
		object.activate(mStartingPosition, 0, mMovementSpeedY);
		mActiveArray.push(object);
	}
	
	public static function update():Void
	{
		mLanuchTimer += FlxG.elapsed;
		if (mLanuchTimer > mLanuchTime)
		{
			EventManager.triggerEvent(EventType.OBJECT_MOVE);
			mLanuchTimer = 0;
		}
		updateSpeed();
	}
	
	public static function updateActiveSpeed(speed:Float)
	{
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].mSpeedY = speed;
		}
	}
	
	public static function updateSpeed():Void
	{
		if(ScoreManager.mScore < 25)
			mMovementSpeedY = 100;
		else if (ScoreManager.mScore > 25 && ScoreManager.mScore < 50)
			mMovementSpeedY = 150;
		else if (ScoreManager.mScore > 50 && ScoreManager.mScore < 100)
			mMovementSpeedY = 200;
			
		if (mPreviousMovementSpeedY != mMovementSpeedY)
		{
			updateActiveSpeed(mMovementSpeedY);
			mPreviousMovementSpeedY = mMovementSpeedY;
		}
	}
	
	public static function parseArrowData(assetFile:String)
	{
		//var arrowXML = new Fast(Xml.parse(assetFile).firstElement());
	}
}