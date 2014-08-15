package objects;
import event.EventManager;
import event.EventType;
import flixel.group.FlxGroup;
import utils.ObjectPool;

/**
 * ...
 * @author Lim Chian Song
 */
class ArrowManager
{
	public static var mGroup:FlxGroup;
	private static var mArrowPool:ObjectPool<Arrow>;
	
	public static function init():Void
	{
		mArrowPool = new ObjectPool<Arrow>(50, createArrow);
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
	}
	
	private static function createArrow():Arrow
	{
		var arrow = new Arrow();
		arrow.kill();
		return arrow;
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		
	}
	
	private static function onFire(evt:Int, params:Dynamic):Void
	{
		
	}
}