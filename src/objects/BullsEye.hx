package objects;
import event.Event;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import managers.EventManager;
import managers.ScoreManager;
import openfl.Assets;

/**
 * ...
 * @author Lim Chian Song
 */
class BullsEye extends GameObject
{	
	public function new() 
	{
		super();
		loadGraphic(Assets.getBitmapData("character/bulleye.png"),true, false, 32, 68);
		
		mSpeedX = 0;
		mSpeedY = 0;
		mState = GameObject.IDLE;
		
		width = width / 2;
		height *= 0.75;
		centerOffsets();
		
		mType = ObjectType.BULLSEYE;
		//EventManager.subscrible(EventType.OBJECT_HIT, onHit);
	}
	
	public function onHit(evt:Int, params:Dynamic):Void
	{
		if (params.object != this)
			return;
		
	}
	public function getHitPoint(_y:Float):Int
	{
		if(_y > y + height/2 - 5 && _y < y + height/2 + 5)
		{
			return 3;
		}
		return 1;
	}
	
	public override function update():Void
	{
		super.update();
		//Move Downward.
		if (mState == GameObject.IDLE)
		{
			visible = false;
		}
		else if (mState == GameObject.MOVE)
		{
			velocity.y = mSpeedY;
			if (y > FlxG.height)
				mState = GameObject.PASS;
		}
		else if (mState == GameObject.PASS)
		{
			mActive = false;
			mState = GameObject.IDLE;
			EventManager.triggerEvent(EventType.OBJECT_OUT, { object:this } );
			kill();
		}
	}
}