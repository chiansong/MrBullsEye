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
	public static var mGUIGroup1:FlxGroup; //In-Game GUI
	public static var mGUIGroup2:FlxGroup; //Stats GUI
	
	//G1
	public static var mScore:FlxText;
	public static var mNumberOfArrowLeft:FlxText;
	public static var mCombo:FlxText;
	
	//G2
	public static var mGoldEarned:FlxText;
	public static var mBestCombo:FlxText;
	public static var mNoOfCritical:FlxText;
	public static var mUpgradeShop:FlxButton;
	

	public static function init():Void
	{
		mGUIGroup1 = new FlxGroup();
		mGUIGroup2 = new FlxGroup();
	
		//Group 1: In Game Stuff.
		mScore = new FlxText(FlxG.width / 2, 15, 100, "", 24);
		mScore.text = "0";
		mGUIGroup1.add(mScore);
		
		mNumberOfArrowLeft = new FlxText(10, 15, 100, "",24);
		mNumberOfArrowLeft.text = Std.string(ArrowManager.getMaxArrow());
		mGUIGroup1.add(mNumberOfArrowLeft);
		
		mCombo = new FlxText(FlxG.width - 20, 10, 100, 24);
		mCombo.text = Std.string(ScoreManager.mCombo);
		mGUIGroup1.add(mCombo);
		
		//Group 2: Stats After Game
		var mStartingX:Float = FlxG.width / 3 - 250;
		var mStartingY:Float = FlxG.height / 3;
		var mDiff:Float = 50;
		
		mGoldEarned = new FlxText(mStartingX, mStartingY, 500, "", 24);
		mGoldEarned.text = "Gold Earned: XXX";
		mGoldEarned.alignment = "right";
		mGUIGroup2.add(mGoldEarned);
		
		mBestCombo = new FlxText(mStartingX, mStartingY + mDiff, 500, "", 24);
		mBestCombo.text = "Best Combo: XXX";
		mBestCombo.alignment = "right";
		mGUIGroup2.add(mBestCombo);
		
		mNoOfCritical = new FlxText(mStartingX,  mStartingY + mDiff * 2, 500, "", 24);
		mNoOfCritical.text = "No Of Critical: XXX";
		mNoOfCritical.alignment = "right";
		mGUIGroup2.add(mNoOfCritical);
	
		mStartingX = FlxG.width / 2 + FlxG.width / 4;
		mStartingY = mStartingY + mDiff * 4;
		mUpgradeShop = new FlxButton(mStartingX, mStartingY, "Shop", onClick);
		mGUIGroup2.add(mUpgradeShop);
		
		//Hide The GUI Group
		mGUIGroup2.visible = false;

		DisplayManager.addToLayer(mGUIGroup1, DisplayLayers.GUILAYER.getIndex());
		DisplayManager.addToLayer(mGUIGroup2, DisplayLayers.GUILAYER.getIndex());
		
		EventManager.subscrible(EventType.GAME_OVER, onGameOver);
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
	}	
	
	private static function onClick():Void
	{
		EventManager.triggerEvent(EventType.ENTER_SHOP);
	}
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		mGUIGroup1.visible = false;
		mGUIGroup2.visible = false;
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		mGUIGroup1.visible = true;
		mGUIGroup2.visible = false;
		//ShopManager.hideShop();
	}
	
	private static function onGameOver(evt:Int, params:Dynamic):Void
	{
		mGUIGroup1.visible = false;
		mGUIGroup2.visible = true;
	}
	
	public static function setArrows(_current:Int, _max:Int)
	{
		mNumberOfArrowLeft.text = Std.string(_current) + " / " + Std.string(_max);
	}
	
	public function update():Void
	{
	
	}
}