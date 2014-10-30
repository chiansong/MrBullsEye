package managers;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import openfl.Assets;
import states.MenuState;
import states.ShopState;
import utils.DisplayLayers;

/**
 * ...
 * @author Lim Chian Song
 */
class InGameGUIManager
{
	public static var mGUIGroup0:FlxGroup; //Background
	public static var mGUIGroup1:FlxGroup; //Railing ... Fans Area 
	public static var mGUIGroup2:FlxGroup; //In-Game GUI
	public static var mGUIGroup3:FlxGroup; //Stats GUI
	public static var mGUIGroup4:FlxGroup; //Lightning.
	private static var mHasTrigger:Bool; //Has started the game.
	
	//G0
	private static var mBackground:FlxSprite; //Background.
	
	//G1
	private static var mAudienceRow1:FlxSprite; //First row \o/ \o/
	private static var mAudienceRow2:FlxSprite; //Second row \o/ \o/
	private static var mAudienceRow3:FlxSprite; //Thrid row \o/ \o/
	private static var mRailing:FlxSprite;// Railing
	private static var mDoor1:FlxSprite;
	private static var mDoor2:FlxSprite;
	private static var mDoor3:FlxSprite;
	
	//G2
	public static var mScore:FlxText;
	public static var mAddedScore:FlxText;
	public static var mNumberOfArrowLeft:FlxText;
	public static var mCombo:FlxText;
	public static var mTimer:FlxText;
	public static var mAddedTimer:FlxText;
	
	//G3 After Game Text.
	public static var mGoldEarned:FlxText;
	public static var mBestCombo:FlxText;
	public static var mNoOfCritical:FlxText;
	private static var mTimeGained:FlxText;
	private static var mMultiple:FlxText;
	private static var mFinalScore:FlxText;
	public static var mUpgradeShop:FlxButton;
	public static var mResultBackground:FlxSprite;
	public static var mCountdownTimer:FlxSprite;
	
	//G4
	private static var mLighting:FlxSprite;

	public static function init():Void
	{
		mGUIGroup0 = new FlxGroup();
		mGUIGroup1 = new FlxGroup();
		mGUIGroup2 = new FlxGroup();
		mGUIGroup3 = new FlxGroup();
		mGUIGroup4 = new FlxGroup();
		
		//Setup Eveything
		//Setup Background Audience, Lighting.
		setupInGameGUI();
		setupAfterGameText();
		setupBackgroundAudience();
		setupLighting();
		
		DisplayManager.addToLayer(mGUIGroup0, DisplayLayers.BACKGROUND.getIndex());
		DisplayManager.addToLayer(mGUIGroup1, DisplayLayers.FRONTOBJECTLAYER.getIndex());
		DisplayManager.addToLayer(mGUIGroup2, DisplayLayers.GUILAYER.getIndex());
		DisplayManager.addToLayer(mGUIGroup3, DisplayLayers.GUILAYER.getIndex());		
		DisplayManager.addToLayer(mGUIGroup4, DisplayLayers.LIGHTING.getIndex());
		
		EventManager.subscrible(EventType.GAME_OVER, onGameOver);
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.GAMESTART, onGameStart);
		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
		
		//Add score and time
		EventManager.subscrible(EventType.SCOREADDED, onAddedScore);
		EventManager.subscrible(EventType.TIMEADDED, onAddedTime);
		EventManager.subscrible(EventType.COMBOADDED, onAddedCombo);
	}	
	
	//Setup the in-game GUI during the game
	private static function setupInGameGUI():Void
	{
		//Group 2: In Game Stuff.
		//Score
		mScore = new FlxText(FlxG.width - 120, 15, 100, "", 28);
		mScore.text = "0";
		mScore.alignment = "right";
		mGUIGroup2.add(mScore);
		//Added score below added score.
		mAddedScore = new FlxText(mScore.x, mScore.y + 35, 100, "", 20);
		mAddedScore.alignment = "right";
		mGUIGroup2.add(mAddedScore);
		
		//Number of Arrow to left
		mNumberOfArrowLeft = new FlxText(10, 15, 100, "",24);
		mNumberOfArrowLeft.text = Std.string(ArrowManager.getMaxArrow());
		mGUIGroup2.add(mNumberOfArrowLeft);
		
		//Combos
		mCombo = new FlxText(FlxG.width - FlxG.width/2.5, FlxG.height/2 - 10, 250, 36);
		mCombo.text = Std.string(ScoreManager.mCombo);
		mCombo.alignment = "right";
		mGUIGroup2.add(mCombo);
		
		//Timer and Added Timer 
		mTimer = new FlxText(FlxG.width/2 - 20, 10, 100, "", 36);
		mGUIGroup2.add(mTimer);
		mAddedTimer = new FlxText(mTimer.x, mTimer.y + 45, 100, "", 20);
		mGUIGroup2.add(mAddedTimer);
		
		//Countdown Timer
		mCountdownTimer = new FlxSprite();
		mCountdownTimer.loadGraphic(Assets.getBitmapData("game/timecounter.png"), true, false, 82, 130);
		mCountdownTimer.animation.add("play", [0, 1, 2], 1, false);
		mCountdownTimer.setPosition(FlxG.width / 2 - mCountdownTimer.width / 2,
									FlxG.height / 2 - mCountdownTimer.height / 2);
		mGUIGroup2.add(mCountdownTimer);
		
		//Hide some stuff
		mCombo.alpha = 0;
		mAddedScore.alpha = 0;
		mAddedTimer.alpha = 0;
		
		mTimer.alpha = 0;
		mNumberOfArrowLeft.alpha = 0;
		mScore.alpha = 0;
	}
	
	//Text after a game
	private static function setupAfterGameText():Void
	{
		//Group 3: Stats After Game
		//Create Image
		mResultBackground = new FlxSprite();
		mResultBackground.loadGraphic(Assets.getBitmapData("background/result.png"));
		mResultBackground.setPosition(FlxG.width / 2 - mResultBackground.width / 2, 
									  FlxG.height / 2 - mResultBackground.height / 2);
		mGUIGroup3.add(mResultBackground);
									  
		var mStartingX:Float = -FlxG.width;
		var mStartingY:Float = FlxG.height / 4;
		var mDiff:Float = 40;
		
		mTimeGained = new FlxText(mStartingX, mStartingY, 500, "", 24);
		mTimeGained.text = "Total Time: ";
		mTimeGained.alignment = "right";
		mGUIGroup3.add(mTimeGained);
		
		mBestCombo = new FlxText(mStartingX, mStartingY + mDiff, 500, "", 24);
		mBestCombo.text = "Best Combo: ";
		mBestCombo.alignment = "right";
		mGUIGroup3.add(mBestCombo);
		
		mNoOfCritical = new FlxText(mStartingX,  mStartingY + mDiff * 2, 500, "", 24);
		mNoOfCritical.text = "BullEyes: ";
		mNoOfCritical.alignment = "right";
		mGUIGroup3.add(mNoOfCritical);
		
		mMultiple = new FlxText(mStartingX,  mStartingY + mDiff * 3, 500, "", 24);
		mMultiple.text = "Mulitple: ";
		mMultiple.alignment = "right";
		mGUIGroup3.add(mMultiple);
		
		mFinalScore = new FlxText(mStartingX, mStartingY + mDiff * 4, 500, "", 24);
		mFinalScore.text = "Final Score: ";
		mFinalScore.alignment = "right";
		mGUIGroup3.add(mFinalScore);
		
		mGoldEarned = new FlxText(mStartingX, mStartingY + mDiff * 5, 500, "", 24);
		mGoldEarned.text = "Gold: ";
		mGoldEarned.alignment = "right";
		mGUIGroup3.add(mGoldEarned);
		
		mStartingX = FlxG.width / 2 + FlxG.width / 4;
		mStartingY = mGoldEarned.y + mDiff;
		mUpgradeShop = new FlxButton(mStartingX, mStartingY, "Shop", onClick);
		mGUIGroup3.add(mUpgradeShop);
		
		//Hide The GUI Group
		mGUIGroup3.visible = false;
	}
	
	//Setup Behind Fellow 
	private static function setupBackgroundAudience():Void
	{
		//Group 0
		mBackground = new FlxSprite(0, 0);
		mBackground.loadGraphic(Assets.getBitmapData("background/background.png"));
		//Let setup the position properly
		mBackground.setPosition(FlxG.width / 2 - mBackground.width / 2,
								FlxG.height / 2 - mBackground.height / 2);
		mGUIGroup0.add(mBackground);
		
		//Group 1 //Stuff in front of background ... railing , crowd
		//Audience behind crowd mah so let add that first
		mAudienceRow1 = new FlxSprite(0, 0);
		mAudienceRow1.loadGraphic(Assets.getBitmapData("background/audiencerow1.png"), true, false, 990, 25, false);
		mAudienceRow1.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow1.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow1.animation.play("idle");
		mAudienceRow1.color = 0xffbebebe;
		
		mAudienceRow2 = new FlxSprite(0, 0);
		mAudienceRow2.loadGraphic(Assets.getBitmapData("background/audiencerow1.png"), true, false, 990, 25, false);
		mAudienceRow2.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow2.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow2.animation.play("idle");
		mAudienceRow2.color = 0xff7b7b7b;
		
		mAudienceRow3 = new FlxSprite(0, 0);
		mAudienceRow3.loadGraphic(Assets.getBitmapData("background/audiencerow1.png"), true, false, 990, 25, false);
		mAudienceRow3.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow3.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow3.animation.play("idle");
		mAudienceRow3.color = 0xff474747;
		
		mGUIGroup1.add(mAudienceRow3);
		mGUIGroup1.add(mAudienceRow2);
		mGUIGroup1.add(mAudienceRow1);
		
		mRailing = new FlxSprite(0, 0);
		mRailing.loadGraphic(Assets.getBitmapData("background/gamerailing.png"));
		//Setup the position.
		mRailing.setPosition(FlxG.width / 2 - mRailing.width / 2,
							 FlxG.height / 2 -  155);
		mGUIGroup1.add(mRailing);
							 
		//Setup the Audience After the railing
		mAudienceRow1.setPosition(mRailing.x,
								  mRailing.y - mAudienceRow1.height/2);
		mAudienceRow2.setPosition(mAudienceRow1.x - 20,
								  mAudienceRow1.y - mAudienceRow1.height/3);
		mAudienceRow3.setPosition(mAudienceRow1.x + 20,
								  mAudienceRow2.y - mAudienceRow1.height / 3);
					
		//Door Door Door 3 Door Down (The door where the bulleyes spawn)
		mDoor1 = new FlxSprite();
		mDoor1.loadGraphic(Assets.getBitmapData("background/door.png"));
		mDoor1.setPosition(FlxG.width - 3 * FlxG.width/8 - mDoor1.width/2,
						   FlxG.height / 2 -  140);
						   
		mDoor2 = new FlxSprite();
		mDoor2.loadGraphic(Assets.getBitmapData("background/door.png"));
		mDoor2.setPosition(FlxG.width - 2 * FlxG.width/8 - mDoor1.width/2,
						   FlxG.height / 2 -  135);
						   
		mDoor3 = new FlxSprite();
		mDoor3.loadGraphic(Assets.getBitmapData("background/door.png"));
		mDoor3.setPosition(FlxG.width - FlxG.width/8 - mDoor1.width/2,
						   FlxG.height / 2 -  130);
						   
		mGUIGroup1.add(mDoor1);
		mGUIGroup1.add(mDoor2);
		mGUIGroup1.add(mDoor3);
	}
	
	//Set lighting for player
	private static function setupLighting():Void
	{
		mLighting = new FlxSprite();
		mLighting.loadGraphic(Assets.getBitmapData("background/lighting.png"));
		mLighting.setPosition(FlxG.width/2 - mLighting.width/2, FlxG.height/2 - mLighting.height/2);
		mGUIGroup4.add(mLighting);
	}
	
	private static function onClick():Void
	{
		EventManager.triggerEvent(EventType.ENTER_SHOP);
	}
	
	private static function onGameStart(evt:Int, params:Dynamic):Void
	{
		mTimer.alpha = 1;
		mNumberOfArrowLeft.alpha = 1;
		mScore.alpha = 1;
	}
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		mGUIGroup2.visible = false;
		mGUIGroup3.visible = false;
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		mGUIGroup2.visible = true;
		mGUIGroup3.visible = false;
		mUpgradeShop.kill();
		
		mHasTrigger = false;
		mCountdownTimer.revive();
		mCountdownTimer.animation.play("play");
	}
	
	private static function onGameOver(evt:Int, params:Dynamic):Void
	{
		mGUIGroup2.visible = false;
		mGUIGroup3.visible = true;
		mUpgradeShop.revive();
		
		var mStartingX:Float = FlxG.width / 3 - 250;
		FlxTween.tween(mTimeGained, { x:mStartingX }, 0.35, {ease:FlxEase.backOut, startDelay:0.15});
		FlxTween.tween(mBestCombo, { x:mStartingX }, 0.35, {ease:FlxEase.backOut, startDelay:0.30});
		FlxTween.tween(mNoOfCritical, { x:mStartingX }, 0.35, {ease:FlxEase.backOut, startDelay:0.45});
		FlxTween.tween(mMultiple, { x:mStartingX }, 0.35, {ease:FlxEase.backOut, startDelay:0.60});
		FlxTween.tween(mFinalScore, { x:mStartingX }, 0.35, {ease:FlxEase.backOut, startDelay:0.75});
		FlxTween.tween(mGoldEarned, { x:mStartingX }, 0.35, {ease:FlxEase.backOut, startDelay:0.90});
		
		//Update the information ... remove the text in the future.
		mTimeGained.text = "Total Time: " + (Std.int(GameDataManager.mTotalTimer));
		mBestCombo.text = "Highest Combo: " + GameDataManager.mHighestCombo;
		mNoOfCritical.text = "Bulls-eyes: " + GameDataManager.mCriticalCount;
		mMultiple.text = "Multiple: " + ScoreManager.mMultipler;
		mFinalScore.text = "Score: " + ScoreManager.mScore;
		mGoldEarned.text = "Gold: " + GameDataManager.mGoldEarned;
	}
	
	private static function onAddedTime(evt:Int, params:Dynamic):Void
	{
		mAddedTimer.alpha = 1;
		mAddedTimer.text = "+" + params.time + "s";
		FlxTween.tween(mAddedTimer, {alpha:0}, 1.5);
	}
	
	private static function onAddedScore(evt:Int, params:Dynamic):Void
	{
		mAddedScore.alpha = 1;
		mAddedScore.text = "+" + params.score;
		FlxTween.tween(mAddedScore, {alpha:0}, 1.5);
	}
	
	private static function onAddedCombo(evt:Int, params:Dynamic):Void
	{
		mCombo.alpha = 1;
		mCombo.text = params.combo + " Combo";
		FlxTween.tween(mCombo, {alpha:0}, 2.0);
	}
	
	public static function setArrows(_current:Int, _max:Int)
	{
		mNumberOfArrowLeft.text = Std.string(_current) + " / " + Std.string(_max);
	}
	
	public static function update():Void
	{
		mTimer.text = Std.string(Std.int(GameDataManager.mGameTimer));
		
		if (!mHasTrigger && mCountdownTimer.animation.finished)
		{
			mHasTrigger = true;
			mCountdownTimer.kill();
			EventManager.triggerEvent(EventType.GAMESTART);
		}
	}
	
	public static function getDoorPosition(type:Int, what:Int):Float
	{
		switch(type)
		{
			case 1:
			if (what == 1)
				return mDoor1.x + mDoor1.width/2.5;
			else
				return mDoor1.y;
		
			case 2:
			if (what == 1)
				return mDoor2.x + mDoor2.width/2.5;
			else
				return mDoor2.y;
			
			case 3:
			if (what == 1)
				return mDoor3.x + mDoor2.width/2.5;
			else
				return mDoor3.y;
		}
		
		return 0;
	}
}