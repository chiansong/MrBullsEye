package objects;
import event.EventType;
import flixel.FlxG;
import managers.EventManager;
import managers.ScoreManager;
import openfl.Assets;

/**
 * ...
 * @author CS.Lim
 */
class Apple extends GameObject
{
	public function new() 
	{
		super();
		loadGraphic(Assets.getBitmapData("character/apple.png"), false, false, 36, 36);
		
		mSpeedX = 0;
		mSpeedY = 0;
		mState = GameObject.IDLE;
		
		width = width / 2;
		height *= 0.60;
		centerOffsets();
		
		EventManager.subscrible(EventType.OBJECT_HIT, onHit);
	}
	
	private function onHit(evt:Int, params:Dynamic):Void
	{
		if (params.object != this)
			return;
		
		ScoreManager.mMultipler += 1;
		ScoreManager.mScore += 100 * ScoreManager.mMultipler;
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