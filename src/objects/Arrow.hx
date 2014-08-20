package objects;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import managers.EventManager;
import openfl.Assets;

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
	
	public inline static var IDLE:Int = 0;
	public inline static var FIRED:Int = 1;
	public inline static var HIT:Int = 2;

	public function new() 
	{
		super();
		
		loadGraphic(Assets.getBitmapData("character/arrow.png"), true, false, 32, 8);
		mState = IDLE;
		visible = false;
		
		EventManager.subscrible(EventType.BULLSEYE_HIT, onBullsEyeHit);
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
	}
	
	public function onBullsEyeHit(evt:Int, params:Dynamic):Void
	{
		if (params.arrow != this)
			return;
		
		mState = HIT;
		var bullseyes:BullsEye = cast(params.bullseye, BullsEye);
		velocity.x = bullseyes.velocity.x;
		velocity.y = bullseyes.velocity.y;
	}
	
	public override function update():Void
	{
		super.update();
		
		if (mState == FIRED)
		{
			velocity.x = mSpeed;
			
			if (x >= FlxG.width + width)
			{
				EventManager.triggerEvent(EventType.ARROW_MISSED);
				kill();
			}
		}
	}
}