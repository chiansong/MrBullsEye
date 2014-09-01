package objects;
import event.EventType;
import flixel.FlxG;
import managers.EventManager;
import managers.GameDataManager;
import managers.ScoreManager;
import openfl.Assets;

/**
 * ...
 * @author CS.Lim
 */
class GoldBag extends GameObject
{
	public function new() 
	{
		super();
		loadGraphic(Assets.getBitmapData("character/goldbag.png"), false, false, 64, 64);
		
		mSpeedX = 0;
		mSpeedY = 0;
		mState = GameObject.IDLE;
		
		width = width / 2;
		height *= 0.60;
		centerOffsets();
		
		mType = ObjectType.GOLD;

		EventManager.subscrible(EventType.GOLDBAG_HIT, onHit);
	}
	
	public function onHit(evt:Int, params:Dynamic):Void
	{
		//Not the apple u are looking for
		if (params.gold != this)
			return;
		
		//Increase Multipler and Add Score by it worth
		GameDataManager.addGoldEarned(25);
		ScoreManager.instantAddScore(ScoreManager.mMultipler * 10);
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