package managers;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import game.GlobalGameData;
import openfl.Assets;
import utils.DisplayLayers;
import utils.ShopSelection;

/**
 * ...
 * @author Lim Chian Song
 */
class ShopManager
{
	public static var mGUIGroup:FlxGroup; //Shop GUI
	//Top
	public static var mGold:FlxText;
	//Middle
	public static var mSelected:ShopSelection;
	public static var mUpgradeArrowSpeedButton:FlxButton;
	public static var mButtonOutline:FlxSprite;
	//Buttom
	public static var mUpgradeButton:FlxButton;
	public static var mPlayButton:FlxButton;
	
	public static function init():Void 
	{
		mGUIGroup = new FlxGroup();
		mGUIGroup.visible = false;
		mSelected = ShopSelection.NIL;
		setupShop();

		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
		//DisplayManager.addToLayer(mGUIGroup, DisplayLayers.GUILAYER.getIndex());
	}
	
	private static function setupShop():Void
	{
		var mStartingX:Float = FlxG.width / 2;
		var mStartingY:Float = FlxG.height / 6;
		
		mGold = new FlxText(mStartingX, mStartingY, 200, "", 25);
		mGold.text = Std.string(GlobalGameData.getGold());
		mGUIGroup.add(mGold);
		
		mStartingX = FlxG.width / 5;
		mStartingY = FlxG.height / 5;
		
		mButtonOutline = new FlxSprite(0, 0);
		mButtonOutline.loadGraphic(Assets.getBitmapData("shop/button_outline.png"), true, false, 100, 100);
		mButtonOutline.visible = false;
		mGUIGroup.add(mButtonOutline);
		
		mUpgradeArrowSpeedButton = new FlxButton(mStartingX, mStartingY, null, onUpgradeArrowSpeedClick);
		mUpgradeArrowSpeedButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeArrowSpeedButton);
		
		mStartingX = FlxG.width - 250;
		mStartingY = FlxG.height - 200;
		mUpgradeButton = new FlxButton(mStartingX, mStartingY, null, Upgrade);
		mUpgradeButton.loadGraphic(Assets.getBitmapData("shop/upgrade.png"), true, false, 150, 50);
		mGUIGroup.add(mUpgradeButton);
		
		mStartingX = FlxG.width - 200;
		mStartingY = FlxG.height - 75;
		mPlayButton = new FlxButton(mStartingX, mStartingY, null, Play);
		mPlayButton.loadGraphic(Assets.getBitmapData("shop/upgrade.png"), true, false, 150, 50);
		mGUIGroup.add(mPlayButton);
		
		//mGUIGroup.visible = false;
		mGUIGroup.visible = true;
	}
		
	/**************/
	//Shop Buttons//
	/**************/
	private static function onUpgradeArrowSpeedClick():Void
	{
		mButtonOutline.setPosition(mUpgradeArrowSpeedButton.x - 10, mUpgradeArrowSpeedButton.y - 10);
		mButtonOutline.visible = true;
		
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
	}
	
		
	public static function hideShop()
	{
		mGUIGroup.visible = false;
		mUpgradeButton.kill();
		mPlayButton.kill();
	}
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		//We can see it !!! 
		mGUIGroup.visible = true;
		//mPlayButton.revive();
		//mUpgradeButton.kill();
		
		//Time to get some data ... Let grab gold text.
		mGold.text = Std.string(GlobalGameData.getGold());
	}
	
	private static function Upgrade():Void
	{
		ArrowManager.increaseUpgradeSpeed();
	}
	
	private static function Play():Void
	{
		EventManager.triggerEvent(EventType.LEAVE_SHOP);
	}
}