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
	
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mArrowPool = new ObjectPool<Arrow>(50, createArrow);
		mFiringPosition = new FlxPoint();
		setPosition(100, FlxG.height / 2);
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.ARROW_FIRED, onFire);
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
	}
	
	private static function onFire(evt:Int, params:Dynamic):Void
	{
		//Grab a Arrow
		var arrow = mArrowPool.get();
		arrow.fire(mFiringPosition, 300, 1);
	}
	
	public static function parseArrowData(assetFile:String)
	{
		//var arrowXML = new Fast(Xml.parse(assetFile).firstElement());
	}
}