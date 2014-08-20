package objects;
import event.Event;
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
class BullsEye extends FlxSprite
{
	public var mSpeedX:Float;
	public var mSpeedY:Float;
	public var mState:Int;
	public var mActive:Bool;
	
	private inline static var IDLE:Int = 0;
	private inline static var MOVE:Int = 1;
	private inline static var PASS:Int = 2;
	
	public function new() 
	{
		super();
		loadGraphic(Assets.getBitmapData("character/bulleye.png"),true, false, 32, 68);
		
		mSpeedX = 0;
		mSpeedY = -10;
		mState = IDLE;
		
		width = width / 2;
		height *= 0.75;
		
		centerOffsets();
	}
	
	public function activate(_pos:FlxPoint, _speedX:Float, _speedY:Float):Void
	{
		reset(_pos.x, _pos.y);
		
		mState = MOVE;
		mSpeedX = _speedX;
		mSpeedY = _speedY;
		
		mActive = true;
		visible = true;
	}
	
	public override function update():Void
	{
		super.update();
		
		//Move Downward.
		if (mState == IDLE)
		{
			visible = false;
		}
		else if (mState == MOVE)
		{
			velocity.y = mSpeedY;
			if (y > FlxG.height)
				mState = PASS;
		}
		else if (mState == PASS)
		{
			mActive = false;
			mState = IDLE;
			EventManager.triggerEvent(EventType.BULLSEYE_OUT, { object:this } );
			kill();
		}
	}
}