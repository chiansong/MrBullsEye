package objects;
import flixel.FlxG;
import flixel.util.FlxPoint;
import haxe.xml.Fast;
import managers.DisplayManager;
import managers.EventManager;
import event.EventType;
import flixel.group.FlxGroup;
import objects.Arrow;
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
	private static var mLanuchTime:Float;
	private static var mLanuchTimer:Float;
	
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mBullsEyePool = new ObjectPool<BullsEye>(50, createBullsEye);
		mStartingPosition = new FlxPoint();
		setPosition(FlxG.width - 100, -34);
		mLanuchTime = 2;
		mLanuchTimer = 0;
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.BULLSEYE_MOVE, onLanuch);
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
	
	private static function onLanuch(evt:Int, params:Dynamic):Void
	{
		//Grab a Arrow
		var bullseye = mBullsEyePool.get();
		bullseye.activate(mStartingPosition, 0, 100);
	}
	
	public static function update():Void
	{
		mLanuchTimer += FlxG.elapsed;
		if (mLanuchTimer > 2)
		{
			EventManager.triggerEvent(EventType.BULLSEYE_MOVE);
			mLanuchTimer = 0;
		}
	}
	
	public static function parseArrowData(assetFile:String)
	{
		//var arrowXML = new Fast(Xml.parse(assetFile).firstElement());
	}
}