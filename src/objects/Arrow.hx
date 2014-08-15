package objects;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
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
	
	private inline static var IDLE:Int = 0;
	private inline static var FIRED:Int = 1;
	private inline static var HIT:Int = 2;

	public function new() 
	{
		super();
		
		loadGraphic(Assets.getBitmapData("assets/character/player.png"), true, false, 32, 8);
		mState = IDLE;
		visible = false;
	}
	
	public function fire(_pos:FlxPoint, _speed:Float, _power:Int):Void
	{
		reset(_pos.x, _pos.y - height / 2);
		
		mState = FIRED;
		mSpeed = _speed;
		mPower = _power;
		
		visible = true;
	}
	
	public override function update():Void
	{
		super.update();
		
		if (mState == FIRED)
		{
			velocity.x = mSpeed;
		}
		if (mState == HIT)
		{
			velocity.x = 0;
		}
	}
}