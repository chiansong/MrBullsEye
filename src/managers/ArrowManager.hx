package managers;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxCollisionType;
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
class ArrowStats
{
	public function new(_speed:Float, _power:Float)
	{
		speed = _speed;
		power = _power;
	}
	
	public var speed:Float;
	public var power:Float;
}
 
class ArrowManager
{
	public static var mGroup:FlxGroup;
	public static var mFiringPosition:FlxPoint;
	private static var mArrowPool:ObjectPool<Arrow>;
	private static var mCurrentArrow:Int = 0;
	private static var mMaxArrow:Int = 10;
	
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mArrowPool = new ObjectPool<Arrow>(50, createArrow);
		mFiringPosition = new FlxPoint();
		setPosition(100, FlxG.height / 2);
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.ARROW_FIRED, onFire);
		EventManager.subscrible(EventType.ARROW_MISSED, onMiss);
	}
	
	private static function createArrow():Arrow
	{
		var arrow = new Arrow();
		arrow.kill();
		mGroup.add(arrow);
		return arrow;
	}
	
	public static function setPosition(_x:Float, _y:Float)
	{
		mFiringPosition.set(_x, _y);
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		DisplayManager.addToLayer(mGroup, DisplayLayers.OBJECT1LAYER.getIndex());
		mCurrentArrow = mMaxArrow;
	}
	
	private static function onFire(evt:Int, params:Dynamic):Void
	{
		//Grab a Arrow
		var arrow = mArrowPool.get();
		arrow.fire(mFiringPosition, 300, 1);
		arrow.mCanHit = true;
		mCurrentArrow -= 1;
	}
	
	private static function onMiss(evt:Int, params:Dynamic):Void
	{
		mMaxArrow -= 1;
		GUIManager.mNumberOfArrowLeft.text = Std.string(mMaxArrow);
		ScoreManager.mCombo = 0;
		if (mMaxArrow == 0)
		{
			EventManager.triggerEvent(EventType.GAME_OVER);
		}
	}
	
	public static function update():Void
	{
		FlxG.overlap(mGroup, BullsEyeManager.mGroup, onArrowHit);
	}
	
	private static function onArrowHit(_arrow:FlxObject, _bullseye:FlxObject):Void
	{
		var BasicArrow:Arrow = cast(_arrow, Arrow);
		BasicArrow.mState = Arrow.HIT;
		
		if (BasicArrow.mCanHit)
		{
			BasicArrow.mCanHit = false;
			ScoreManager.mCombo += 1;
			ScoreManager.addScore();
		}
		EventManager.triggerEvent(EventType.BULLSEYE_HIT, { score:1 ,
															arrow:_arrow,
															bullseye:_bullseye} );
	}
	
	public static function getMaxArrow():Int
	{
		return mMaxArrow;
	}
	
	public static function parseArrowData(assetFile:String)
	{
		//var arrowXML = new Fast(Xml.parse(assetFile).firstElement());
	}
}