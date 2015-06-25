package managers;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxCollisionType;
import flixel.util.FlxPoint;
import game.GlobalGameData;
import haxe.xml.Fast;
import managers.DisplayManager;
import managers.EventManager;
import event.EventType;
import flixel.group.FlxGroup;
import objects.Arrow;
import openfl.Assets;
import utils.DisplayLayers;
import utils.MathUtil;
import utils.ObjectPool;

/**
 * ...
 * @author Lim Chian Song
 */	
class ArrowManager
{
	public static var mGroup:FlxGroup;
	public static var mFrontGroup:FlxGroup;
	public static var mFiringPosition:FlxPoint;
	
	private static var mEmitter:FlxEmitter;
	private static var mStarEmitter:FlxEmitter;
	private static var mGoldEmitter:FlxEmitter;
	private static var mParticle:FlxParticle;
	private static var mArrowPool:ObjectPool<Arrow>;
	private static var mActiveArrow:Array<Arrow>;
	private static var mHitArrow:Array<Arrow>;
	private static var mCurrentArrow:Int = 0;
	private static var mMaxArrow:Int = 1;
	private static var mArrowSpeed:Int;

	public static function init():Void
	{
		mGroup 			= new FlxGroup();
		mFrontGroup		= new FlxGroup();
		mActiveArrow 	= new Array<Arrow>();
		mHitArrow		= new Array<Arrow>();
		mArrowPool 		= new ObjectPool<Arrow>(50, createArrow);
		mFiringPosition = new FlxPoint();
		mArrowSpeed 	= 400;
	
		//Dust Emittor
		mEmitter = new FlxEmitter(0, 0, 50);
		mEmitter.setXSpeed(-65, -35);
		mEmitter.setYSpeed( 50, 100);
		mEmitter.setAlpha(0.75, 0.65, 0.15, 0.05);
		mEmitter.setScale(1.25, 1.35, 0.0, 0.15);
		mGroup.add(mEmitter);
		
		//Fill the emittor with particle system.
		for (count in 0 ... (Std.int(mEmitter.maxSize)))
		{
			mParticle = new FlxParticle();
			mParticle.loadGraphic(Assets.getBitmapData("character/smoke.png"), false, false);
			mParticle.visible = false;
			mEmitter.add(mParticle);
		}
		
		//Star Emittor
		mStarEmitter = new FlxEmitter(0, 0, 25);
		mStarEmitter.setXSpeed(0, 0);
		mStarEmitter.setYSpeed( 25, 30);
		mStarEmitter.setAlpha(1.0, 1.0, 0.75, 0.85);
		mStarEmitter.setScale(1, 1, 1.25, 1.25);
		mStarEmitter.setRotation(0, 0);
		mFrontGroup.add(mStarEmitter);
		
		//Fill the emittor with particle system.
		for (count in 0 ... (Std.int(mStarEmitter.maxSize)))
		{
			mParticle = new FlxParticle();
			mParticle.loadGraphic(Assets.getBitmapData("character/critical.png"), true, false, 90, 48);
			mParticle.animation.add("play", [0, 1, 2, 3], 12, true);
			mParticle.visible = false;
			mParticle.animation.play("play");
			mStarEmitter.add(mParticle);
		}
		
		
		
		//Subscrible to the following
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.ARROW_FIRED, onFire);
		EventManager.subscrible(EventType.ARROW_MISSED, onMiss);
		EventManager.subscrible(EventType.OBJECT_HIT, onObjectHit);
		EventManager.subscrible(EventType.CRITICAL_HIT, onCriticalHit);
		EventManager.subscrible(EventType.ARROW_OUT, onOut);
		EventManager.subscrible(EventType.SPEED_UP, onSpeedUp);
		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
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
		DisplayManager.addToLayer(mGroup, DisplayLayers.OBJECT0LAYER.getIndex());
		DisplayManager.addToLayer(mFrontGroup, DisplayLayers.GUILAYER.getIndex());
		mMaxArrow = GameDataManager.mArrowNoMap.get(GlobalGameData.arrowNoLevel).data;
		mCurrentArrow = mMaxArrow;
		
		mArrowSpeed = 500;
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
		ScoreManager.resetOnMiss();
		
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
		//remove actove arrpw 
		mActiveArrow.remove(params.object);
		//we hit something lor.
		if(!params.object.mCanHit)
		{
			mHitArrow.remove(params.object);
		}
		
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
		for (count in 0 ... mHitArrow.length)
		{
			mHitArrow[count].velocity.y = params.speed;
		}
	}
	
	public static function update():Void
	{
		//FlxG.overlap(mGroup, GameObjectManager.mGroup, onArrowHit);
		InGameGUIManager.setArrows(mCurrentArrow, mMaxArrow);
	}
	
	private static function onArrowOut(_arrow:FlxObject, _object:FlxObject):Void
	{
		var BasicArrow:Arrow = cast(_arrow, Arrow);
		BasicArrow.mState = Arrow.IDLE;
	}
	
	private static function onArrowHit(_arrow:FlxObject, _object:FlxObject):Void
	{
		var BasicArrow:Arrow = cast(_arrow, Arrow);
		BasicArrow.mState = Arrow.HIT;
		
		//we can hit stuff with this arrow
		if (BasicArrow.mCanHit)
		{
			BasicArrow.mCanHit = false;
			mHitArrow.push(BasicArrow);
			ScoreManager.increaseCombo();
		}
	}
		
	//When you hit critical portion.
	private static function onCriticalHit(evt:Int, params:Dynamic):Void
	{
		mStarEmitter.setPosition(params.arrow.x + params.arrow.width, params.arrow.y);
		mStarEmitter.start(true, 0.55, 0, 1, 0.20);
	}
	
	public static function onObjectHit(evt:Int, params:Dynamic):Void
	{
		//Spray the emitter.
		mEmitter.setPosition(params.arrow.x + params.arrow.width, params.arrow.y);
		mEmitter.start(true, 0.75, 0, 3, 0.25);
	}
	
	public static function increaseUpgradeNo():Void
	{
		GlobalGameData.arrowNoLevel += 1;
		mMaxArrow = GameDataManager.mArrowNoMap.get(GlobalGameData.arrowNoLevel).data;
	}

	public static function getMaxArrow():Int
	{
		return mMaxArrow;
	}
}