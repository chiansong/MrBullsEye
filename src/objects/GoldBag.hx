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
	public var mHealth:Int;
	public function new() 
	{
		super();
		loadGraphic(Assets.getBitmapData("character/goldbag.png"), false, false, 44, 50);
		animation.add("gold0", [0], 0);
		animation.add("gold1", [1], 0);
		animation.add("gold2", [2], 0);
		animation.play("gold" + mHealth % 3);
		
		mSpeedX = 0;
		mSpeedY = 0;
		mState = GameObject.IDLE;
		
		width = width / 2;
		height *= 0.60;
		centerOffsets();
		
		//Set the size.
		mStartingScale = 0.25;
		mShootingScale = 1;
		scale.x = scale.y = 0;
		
		mHealth = 3;
		mType = ObjectType.GOLD;

		EventManager.subscrible(EventType.GOLDBAG_HIT, onHit);
	}
	
	public function onHit(evt:Int, params:Dynamic):Void
	{
		//Not the GOLDBAG u are looking for
		if (params.gold != this)
			return;
		
		mHealth -= 1;
		//Play animation
		animation.play("gold" + (3 - mHealth));	
		//Check the health first
		if (mHealth > 0)
			return;
		
		
		//Increase Multipler and Add Score by it worth
		GameDataManager.addGoldEarned(25);
		ScoreManager.instantAddScore(ScoreManager.mMultipler * 10);
	}
	
	public override function update():Void
	{
		super.update();
		
		//Update the size
		SetScaleBasedOnPosition();
		
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