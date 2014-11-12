package objects;
import event.Event;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import managers.EventManager;
import managers.GameDataManager;
import managers.GameObjectManager;
import managers.ScoreManager;
import openfl.Assets;
import utils.StatusStringPool;

/**
 * ...
 * @author Lim Chian Song
 */
class BullsEye extends GameObject
{	
	private var mScore:Int = 1; //how much score they are worth
	private var mNoOfHit:Int = 0; //for multiple hits
	
	public function new() 
	{
		super();
		
		//Get Graphics Animation
		loadGraphic(Assets.getBitmapData("character/bulleye.png"), true, false, 32, 68);
		animation.add("level0", [0]);
		animation.add("level1", [1]);
		animation.add("level2", [2]);
		animation.add("level3", [3]);
		animation.add("level4", [4]);
		
		//No Speed
		mSpeedX = 0;
		mSpeedY = 0;
		mState = GameObject.IDLE;
		
		//Resize the Collision Detection
		width = width / 3.5;
		height *= 0.70;
		centerOffsets();
		
		mType = ObjectType.BULLSEYE;

		EventManager.subscrible(EventType.BULLSEYE_HIT, onHit);
	}
	
	//Set the bulleyes that play with different animation for each level
	public function setBullEyes(level:Int)
	{
		//Play a different animation. Add the score.
		animation.play("level" + level);
		mScore = level + 1;
		
		//Set the size.
		mStartingScale = 0.25;
		mShootingScale = 1;
		scale.x = scale.y = 0;
		
		//reset the number of hit
		mNoOfHit = 0;
	}
	
	public function setStartingPosition(start:Float, end:Float)
	{
		mStartingPositionY = start;
		mShootingPositionY = end;
	}
	
	public function onHit(evt:Int, params:Dynamic):Void
	{
		if (params.bullseye != this)
			return;
		
		var score:Int = mScore;
		//Check for B-U-L-L-E-Y-E-S.
		var centerY:Float = y + height / 2;
		if (params.arrow.y > centerY - 5 &&
			params.arrow.y < centerY + 5)
		{
			score = mScore * 2;
			GameDataManager.mCriticalCount += 1;
			StatusStringPool.setText("B-U-L-L-S-E-Y-E !");
			
			//We have hit CRITICAL HIT.
			EventManager.triggerEvent(EventType.CRITICAL_HIT,{arrow:params.arrow});
		}
		
		mNoOfHit += 1;
		//if we hit more than 1.
		if (mNoOfHit > 1)
		{
			EventManager.triggerEvent(EventType.MULTISHOT, { time:mNoOfHit } );
		}
		
		//Add the score
		ScoreManager.addScore(score);
	}
	
	public override function update():Void
	{
		if (GameObjectManager.mGameOver)
			return;
		
		super.update();
		
		//Update the position
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