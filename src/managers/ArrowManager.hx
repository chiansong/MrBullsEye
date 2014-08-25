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
class ArrowManager
{
	public static var mGroup:FlxGroup;
	public static var mFiringPosition:FlxPoint;
	private static var mArrowPool:ObjectPool<Arrow>;
	private static var mActiveArrow:Array<Arrow>;
	private static var mCurrentArrow:Int = 0;
	private static var mMaxArrow:Int = 10;
	private static var mArrowSpeed:Int;

	public static function init():Void
	{
		mGroup = new FlxGroup();
		mActiveArrow = new Array<Arrow>();
		mArrowPool = new ObjectPool<Arrow>(50, createArrow);
		mFiringPosition = new FlxPoint();
		mArrowSpeed = 300;
		setPosition(100, FlxG.height / 2);
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.ARROW_FIRED, onFire);
		EventManager.subscrible(EventType.ARROW_MISSED, onMiss);
		EventManager.subscrible(EventType.ARROW_OUT, onOut);
		EventManager.subscrible(EventType.SPEED_UP, onSpeedUp);
		EventManager.subscrible(EventType.ENTER_SHOP, onSpeedUp);
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
		mMaxArrow = 10;
		mCurrentArrow = mMaxArrow;
	}
	
	private static function onFire(evt:Int, params:Dynamic):Void
	{
		//If there is no more arrow, return it
		if (mCurrentArrow <= 0)
			return;
			
		//Grab a Arrow
		var arrow = mArrowPool.get();
		arrow.fire(mFiringPosition, mArrowSpeed, 1);
		arrow.mCanHit = true;
		mCurrentArrow -= 1;
		
		//Add to the active array
		mActiveArrow.push(arrow);
	}
	
	private static function onMiss(evt:Int, params:Dynamic):Void
	{
		//Reduce the max and reset combo
		mMaxArrow -= 1;
		InGameGUIManager.mNumberOfArrowLeft.text = Std.string(mMaxArrow);
		ScoreManager.mCombo = 0;
		//Remove the object
		mActiveArrow.remove(params.object);
		
		//Game Over if 0
		if (mMaxArrow == 0)
		{
			EventManager.triggerEvent(EventType.GAME_OVER);
		}
	}
	
	private static function onOut(evt:Int, params:Dynamic):Void
	{
		mCurrentArrow += 1;
		mActiveArrow.remove(params.object);
		params.object.mState = Arrow.IDLE;
		params.object.kill();
	}
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		//Reduce the max and reset combo
		for (count in 0 ... mActiveArrow.length)
		{
			mActiveArrow[count].kill();
		}
	}
	
	private static function onSpeedUp(evt:Int, params:Dynamic):Void
	{
		//Reduce the max and reset combo
		for (count in 0 ... mActiveArrow.length)
		{
			mActiveArrow[count].velocity.y = params.speed;
		}
	}
	
	public static function update():Void
	{
		FlxG.overlap(mGroup, GameObjectManager.mGroup, onArrowHit);
		InGameGUIManager.setArrows(mCurrentArrow, mMaxArrow);
	}
	
	private static function onArrowOut(_arrow:FlxObject, _object:FlxObject):Void
	{
		var BasicArrow:Arrow = cast(_arrow, Arrow);
		BasicArrow.mState = Arrow.IDLE;
		
		if (BasicArrow.mCanHit)
		{
			BasicArrow.mCanHit = false;
			ScoreManager.mCombo += 1;
			EventManager.triggerEvent(EventType.OBJECT_HIT, { score:1 ,
															  arrow:_arrow,
															  object:_object } );												  
		}
		
	}
	
	private static function onArrowHit(_arrow:FlxObject, _object:FlxObject):Void
	{
		var BasicArrow:Arrow = cast(_arrow, Arrow);
		BasicArrow.mState = Arrow.HIT;
		
		if (BasicArrow.mCanHit)
		{
			BasicArrow.mCanHit = false;
			ScoreManager.mCombo += 1;
			EventManager.triggerEvent(EventType.OBJECT_HIT, { score:1 ,
															  arrow:_arrow,
															  object:_object } );												  
		}
		
	}
	
	public static function increaseUpgradeSpeed():Void
	{
		mArrowSpeed += 50;
	}
	
	public static function increaseArrow():Void
	{
		++mCurrentArrow;
	}
	
	public static function getMaxArrow():Int
	{
		return mMaxArrow;
	}
}