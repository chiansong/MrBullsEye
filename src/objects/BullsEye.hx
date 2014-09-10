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

/**
 * ...
 * @author Lim Chian Song
 */
class BullsEye extends GameObject
{	
	private var mScore = 1;
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
		width = width / 2;
		height *= 0.85;
		centerOffsets();
		
		mType = ObjectType.BULLSEYE;

		EventManager.subscrible(EventType.BULLSEYE_HIT, onHit);
	}
	
	public function setBullEyes(level:Int)
	{
		animation.play("level" + level);
		mScore = level + 1;
		scale.x = 0.25;
		scale.y = 0.25;
	}
	
	public function onHit(evt:Int, params:Dynamic):Void
	{
		if (params.bullseye != this)
			return;
		
		var score:Int = mScore;
		//Check
		var centerY:Float = y + height / 2;
		if (params.arrow.y > centerY - 5 &&
			params.arrow.y < centerY + 5)
		{
			score = mScore * 2;
			GameDataManager.mCriticalCount += 1;
		}
		
		//Add the score
		ScoreManager.addScore(score);
	}
	
	public override function update():Void
	{
		if (GameObjectManager.mGameOver)
			return;
		
		super.update();
		
		scale.x += 0.25 * FlxG.elapsed;
		scale.y += 0.25 * FlxG.elapsed;
		
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