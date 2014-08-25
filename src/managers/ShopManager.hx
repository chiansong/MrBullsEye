package managers;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
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
	
	public static var mSelected:ShopSelection;
	public static var mUpgradeArrowSpeedButton:FlxButton;
	public static var mButtonOutline:FlxSprite;
	
	public static var mUpgradeButton:FlxButton;
	public static var mPlayButton:FlxButton;
	
	public static function init():Void 
	{
		mGUIGroup = new FlxGroup();
		mGUIGroup.visible = false;
		mSelected = ShopSelection.NIL;
		setupShop();
		
		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
		DisplayManager.addToLayer(mGUIGroup, DisplayLayers.GUILAYER.getIndex());
	}
	
	public static function hideShop()
	{
		mGUIGroup.visible = false;
	}
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		mGUIGroup.visible = true;
	}
		
	private static function setupShop():Void
	{
		var mStartingX:Float = FlxG.width / 5;
		var mStartingY:Float = FlxG.height / 5;
		
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
		
		mGUIGroup.visible = false;
	}
		
	/**************/
	//Shop Buttons//
	/**************/
	private static function onUpgradeArrowSpeedClick():Void
	{
		mButtonOutline.setPosition(mUpgradeArrowSpeedButton.x - 10, mUpgradeArrowSpeedButton.y - 10);
		mButtonOutline.visible = true;
	}
	
	private static function Upgrade():Void
	{
		ArrowManager.increaseUpgradeSpeed();
	}
	
	private static function Play():Void
	{
		EventManager.triggerEvent(EventType.GAME_INIT);
	}
}