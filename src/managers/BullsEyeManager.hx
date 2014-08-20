package managers;
import flixel.FlxG;
import flixel.util.FlxPoint;
import haxe.xml.Fast;
import managers.DisplayManager;
import managers.EventManager;
import event.EventType;
import flixel.group.FlxGroup;
import objects.Arrow;
import objects.BullsEye;
import utils.DisplayLayers;
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
 
class BullsEyeManager
{
	public static var mGroup:FlxGroup;
	public static var mStartingPosition:FlxPoint;
	private static var mBullsEyePool:ObjectPool<BullsEye>;
	private static var mActiveArray:Array<BullsEye>;
	private static var mLanuchTime:Float;
	private static var mLanuchTimer:Float;
	
	private static var mPreviousMovementSpeedY:Float;
	private static var mMovementSpeedY:Float;
	
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mActiveArray = new Array<BullsEye>();
		mBullsEyePool = new ObjectPool<BullsEye>(50, createBullsEye);
		mStartingPosition = new FlxPoint();
		setPosition(FlxG.width - 100, -34);
		mPreviousMovementSpeedY = 0;
		mMovementSpeedY = 100;
		mLanuchTime = 2;
		mLanuchTimer = 0;
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.BULLSEYE_MOVE, onLanuch);
		EventManager.subscrible(EventType.BULLSEYE_OUT, onOut);
	}
	
	private static function createBullsEye():BullsEye
	{
		var bullseye = new BullsEye();
		bullseye.kill();
		mGroup.add(bullseye);
		return bullseye;
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
		//Grab a Arrow
		var bullseye = mBullsEyePool.get();
		bullseye.activate(mStartingPosition, 0, mMovementSpeedY);
		mActiveArray.push(bullseye);
	}
	
	public static function update():Void
	{
		mLanuchTimer += FlxG.elapsed;
		if (mLanuchTimer > 2)
		{
			EventManager.triggerEvent(EventType.BULLSEYE_MOVE);
			mLanuchTimer = 0;
		}
		updateSpeed();
	}
	
	public static function updateActiveSpeed(speed:Float)
	{
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].velocity.y = speed;
		}
	}
	
	public static function updateSpeed():Void
	{
		if(ScoreManager.mScore < 50)
			mMovementSpeedY = 100;
		else if (ScoreManager.mScore > 50 && ScoreManager.mScore < 100)
			mMovementSpeedY = 150;
		else if (ScoreManager.mScore > 100 && ScoreManager.mScore < 250)
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