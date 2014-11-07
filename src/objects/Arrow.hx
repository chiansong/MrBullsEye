package objects;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import managers.EventManager;
import managers.GameObjectManager;
import managers.ScoreManager;
import openfl.Assets;
import utils.MathUtil;

/**
 * ...
 * @author Lim Chian Song
 */
class Arrow extends FlxSprite
{
	public var mPower:Int;
	public var mSpeed:Float;
	public var mState:Int;
	public var mCanHit:Bool;
	
	public var mCurrentPosition:FlxPoint;
	public var mPreviousPosition:FlxPoint;
	public var mObject:GameObject;
	
	public inline static var IDLE:Int = 0;
	public inline static var FIRED:Int = 1;
	public inline static var HIT:Int = 2;

	public function new() 
	{
		super();
		
		loadGraphic(Assets.getBitmapData("character/arrow.png"), true, false, 32, 8);
		animation.add("fire", [0], 0, false);
		animation.add("hit", [1], 0, false);
		mState = IDLE;
		visible = false;
		
		mCurrentPosition = new FlxPoint();
		mPreviousPosition = new FlxPoint();
		
		EventManager.subscrible(EventType.OBJECT_HIT, onObjectHit);
	}
	
	public function fire(_pos:FlxPoint, _speed:Float, _power:Int):Void
	{
		reset(_pos.x, _pos.y - height / 2);
		
		mState = FIRED;
		mSpeed = _speed;
		mPower = _power;
		
		offset.x += width - 4;
		offset.y += 2;
		width = 4;
		height = 4;
		
		visible = true;
		mCanHit = true;
		
		//play the animation fire.
		animation.play("fire");
	}
	
	public function onObjectHit(evt:Int, params:Dynamic):Void
	{
		if (params.arrow != this)
			return;
		
		mState = HIT;
		var object:GameObject = cast(params.object, GameObject);	
		//object.mArrow = params.arrow;
		velocity.x = object.velocity.x;
		velocity.y = object.velocity.y;

		if (object.mType == ObjectType.APPLE)
			EventManager.triggerEvent(EventType.APPLE_HIT, {apple:object, arrow:this});
		else if (object.mType == ObjectType.BULLSEYE)	
			EventManager.triggerEvent(EventType.BULLSEYE_HIT, {bullseye:object, arrow:this});
		else if (object.mType == ObjectType.GOLD)
			EventManager.triggerEvent(EventType.GOLDBAG_HIT, { gold:object, arrow:this } );
		
		//play the animation hit.
		animation.play("hit");
		
		//Link it
		mObject = object;
	}
	
	public override function update():Void
	{
		if (GameObjectManager.mGameOver)
			return;
		
		super.update();
			
		//Get Previous Position
		mPreviousPosition.x = x;
		mPreviousPosition.y = y;

		//Set the next Position
		mCurrentPosition.x = x + velocity.x * FlxG.elapsed;
		mCurrentPosition.y = y;

		if (mState == FIRED)
		{
			velocity.x = mSpeed;
			
			for (_object in GameObjectManager.mActiveArray)
			{
				if (MathUtil.simpleLineObjectTest(this, _object))
				{
					//y = object.y + height / 2;
					mState = Arrow.HIT;
		
					if (mCanHit)
					{
						mCanHit = false;
						ScoreManager.increaseCombo();
						EventManager.triggerEvent(EventType.OBJECT_HIT, { score:1 ,
																		  arrow:this,
																		  object:_object } );												  
					}
					break;
				}
			}
			
			if (x >= FlxG.width + width)
			{
				EventManager.triggerEvent(EventType.ARROW_MISSED, {object:this});
				kill();
			}
		}
		else if (mState == HIT)
		{
			//Resize it	
			scale.x = mObject.scale.x;
			scale.y = mObject.scale.y;
			x -= FlxG.elapsed * 5;
		
			//Check if it belong the screen
			if (y > FlxG.height)
			{
				EventManager.triggerEvent(EventType.ARROW_OUT, { object:this } );
				mObject = null;
			}
		}
	}
}