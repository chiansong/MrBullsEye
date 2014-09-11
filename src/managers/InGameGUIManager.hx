package managers;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
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
	
	//G0
	private static var mBackground:FlxSprite; //Background.
	
	//G1
	private static var mAudienceRow1:FlxSprite; //First row \o/ \o/
	private static var mAudienceRow2:FlxSprite; //Second row \o/ \o/
	private static var mAudienceRow3:FlxSprite; //Thrid row \o/ \o/
	private static var mRailing:FlxSprite;// Railing
	
	//G2
	public static var mScore:FlxText;
	public static var mAddedScore:FlxText;
	public static var mNumberOfArrowLeft:FlxText;
	public static var mCombo:FlxText;
	public static var mTimer:FlxText;
	public static var mAddedTimer:FlxText;
	
	//G3
	public static var mGoldEarned:FlxText;
	public static var mBestCombo:FlxText;
	public static var mNoOfCritical:FlxText;
	public static var mUpgradeShop:FlxButton;
	
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
		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
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
		mAddedScore = new FlxText(mScore.x, mScore.y + 15, 100, "", 20);
		mAddedScore.alignment = "right";
		mGUIGroup2.add(mAddedScore);
		
		//Number of Arrow to left
		mNumberOfArrowLeft = new FlxText(10, 15, 100, "",24);
		mNumberOfArrowLeft.text = Std.string(ArrowManager.getMaxArrow());
		mGUIGroup2.add(mNumberOfArrowLeft);
		
		//Combos
		mCombo = new FlxText(FlxG.width - 150, FlxG.height/2 - 10, 150, 24);
		mCombo.text = Std.string(ScoreManager.mCombo);
		mGUIGroup2.add(mCombo);
		
		//Timer and Added Timer 
		mTimer = new FlxText(FlxG.width/2 - 20, 10, 100, "", 36);
		mGUIGroup2.add(mTimer);
		mAddedTimer = new FlxText(mTimer.x, mTimer.y - 25, 100, "", 20);
		mGUIGroup2.add(mAddedTimer);
	}
	
	//Text after a game
	private static function setupAfterGameText():Void
	{
		//Group 3: Stats After Game
		var mStartingX:Float = FlxG.width / 3 - 250;
		var mStartingY:Float = FlxG.height / 3;
		var mDiff:Float = 50;
		
		mGoldEarned = new FlxText(mStartingX, mStartingY, 500, "", 24);
		mGoldEarned.text = "Gold Earned: ";
		mGoldEarned.alignment = "right";
		mGUIGroup3.add(mGoldEarned);
		
		mBestCombo = new FlxText(mStartingX, mStartingY + mDiff, 500, "", 24);
		mBestCombo.text = "Best Combo: ";
		mBestCombo.alignment = "right";
		mGUIGroup3.add(mBestCombo);
		
		mNoOfCritical = new FlxText(mStartingX,  mStartingY + mDiff * 2, 500, "", 24);
		mNoOfCritical.text = "No Of Critical: ";
		mNoOfCritical.alignment = "right";
		mGUIGroup3.add(mNoOfCritical);
	
		mStartingX = FlxG.width / 2 + FlxG.width / 4;
		mStartingY = mStartingY + mDiff * 4;
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
		mAudienceRow1.loadGraphic(Assets.getBitmapData("background/audiencerow1.png"), true, false, 840, 30, false);
		mAudienceRow1.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow1.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow1.animation.play("idle");
		mAudienceRow1.color = 0xffbebebe;
		
		mAudienceRow2 = new FlxSprite(0, 0);
		mAudienceRow2.loadGraphic(Assets.getBitmapData("background/audiencerow1.png"), true, false, 840, 30, false);
		mAudienceRow2.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow2.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow2.animation.play("idle");
		mAudienceRow2.color = 0xff7b7b7b;
		
		mAudienceRow3 = new FlxSprite(0, 0);
		mAudienceRow3.loadGraphic(Assets.getBitmapData("background/audiencerow1.png"), true, false, 840, 30, false);
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
								  mAudienceRow2.y - mAudienceRow1.height/3);
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
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		
		mGUIGroup2.visible = false;
		mGUIGroup3.visible = false;
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		mGUIGroup2.visible = true;
		mGUIGroup3.visible = false;
	}
	
	private static function onGameOver(evt:Int, params:Dynamic):Void
	{
		mGUIGroup2.visible = false;
		mGUIGroup3.visible = true;
		
		//Update the information ... remove the text in the future.
		mGoldEarned.text = "Gold Earned: " + GameDataManager.mGoldEarned;
		mBestCombo.text = "Highest Combo: " + GameDataManager.mHighestCombo;
		mNoOfCritical.text = "No. of Critical: " + GameDataManager.mCriticalCount;
	}
	
	public static function setArrows(_current:Int, _max:Int)
	{
		mNumberOfArrowLeft.text = Std.string(_current) + " / " + Std.string(_max);
	}
	
	public static function update():Void
	{
		mCombo.text = Std.string(ScoreManager.mCombo);
		mTimer.text = Std.string(Std.int(GameDataManager.mGameTimer));
	}
}