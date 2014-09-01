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
	public static var mStatusText:FlxText;
	//Middle
	public static var mSelected:ShopSelection;
	public static var mButtonOutline:FlxSprite;
	public static var mUpgradeArrowSpeedButton:FlxButton;
	public static var mUpgradeArrowCost:FlxText;
	public static var mUpgradeArrowNoButton:FlxButton;
	public static var mUpgradeArrowNoCost:FlxText;
	public static var mUpgradeGoldButton:FlxButton;
	public static var mUpgradeGoldCost:FlxText;	
	public static var mUpgradeAppleButton:FlxButton;
	public static var mUpgradeAppleCost:FlxText;
	//Buttom
	public static var mUpgradeButton:FlxButton;
	public static var mPlayButton:FlxButton;
	public static var mDescription:FlxText;
	
	public static function init():Void 
	{
		mGUIGroup = new FlxGroup();
		mGUIGroup.visible = false;
		mSelected = ShopSelection.NIL;
		setupShop();
		
		//DisplayManager.addToLayer(mGUIGroup, DisplayLayers.GUILAYER.getIndex());
	}
	
	private static function setupShop():Void
	{
		var mStartingX:Float = FlxG.width / 2;
		var mStartingY:Float = FlxG.height / 8;
		
		mGold = new FlxText(mStartingX, mStartingY, 200, "", 25);
		mGold.text = Std.string(GlobalGameData.getGold());
		mGUIGroup.add(mGold);
		
		mGold = new FlxText(mStartingX, mStartingY, 200, "", 25);
		mGold.text = Std.string(GlobalGameData.getGold());
		mGUIGroup.add(mGold);
		mStatusText = new FlxText(mStartingX, mStartingY + 30, 200, "", 15);
		mGUIGroup.add(mStatusText);
		
		mStartingX = FlxG.width / 5;
		mStartingY = FlxG.height / 5;
		
		mButtonOutline = new FlxSprite(0, 0);
		mButtonOutline.loadGraphic(Assets.getBitmapData("shop/button_outline.png"), true, false, 100, 100);
		mButtonOutline.visible = false;
		mGUIGroup.add(mButtonOutline);
		
		//Upgrade Arrow Speed
		mUpgradeArrowSpeedButton = new FlxButton(mStartingX, mStartingY, null, onUpgradeArrowSpeedClick);
		mUpgradeArrowSpeedButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeArrowSpeedButton);
		mUpgradeArrowCost = new FlxText(mStartingX, mUpgradeArrowSpeedButton.y + mUpgradeArrowSpeedButton.height + 10,
										Std.int(mUpgradeArrowSpeedButton.width), "", 12);
		mUpgradeArrowCost.text = Std.string(GameDataManager.mArrowSpeedMap.get(GlobalGameData.arrowSpeedLevel).cost);
		mUpgradeArrowCost.alignment = "center";
		mGUIGroup.add(mUpgradeArrowCost);
			
		//Upgrade Arrow No
		mUpgradeArrowNoButton = new FlxButton(mStartingX + mUpgradeArrowSpeedButton.width + 20, mStartingY, null, onUpgradeArrowNoClick);
		mUpgradeArrowNoButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeArrowNoButton);
		mUpgradeArrowNoCost = new FlxText(mUpgradeArrowNoButton.x, mUpgradeArrowNoButton.y + mUpgradeArrowNoButton.height + 10,
										Std.int(mUpgradeArrowNoButton.width), "", 12);
		mUpgradeArrowNoCost.text = Std.string(GameDataManager.mArrowSpeedMap.get(GlobalGameData.arrowNoLevel).cost);
		mUpgradeArrowNoCost.alignment = "center";
		mGUIGroup.add(mUpgradeArrowNoCost);
		
		//Upgrade Gold No
		mUpgradeGoldButton = new FlxButton(mUpgradeArrowNoButton.x + mUpgradeArrowSpeedButton.width + 20, mStartingY, null, onUpgradeGoldClick);
		mUpgradeGoldButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeGoldButton);
		mUpgradeGoldCost = new FlxText(mUpgradeGoldButton.x, mUpgradeGoldButton.y + mUpgradeGoldButton.height + 10,
										Std.int(mUpgradeGoldButton.width), "", 12);
		mUpgradeGoldCost.text = Std.string(GameDataManager.mGoldMap.get(GlobalGameData.goldLevel).cost);
		mUpgradeGoldCost.alignment = "center";
		mGUIGroup.add(mUpgradeGoldCost);
		
		//Upgrade Gold No
		mUpgradeAppleButton = new FlxButton(mUpgradeGoldButton.x + mUpgradeGoldButton.width + 20, mStartingY, null, onUpgradeAppleClick);
		mUpgradeAppleButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeAppleButton);
		mUpgradeAppleCost = new FlxText(mUpgradeAppleButton.x, mUpgradeAppleButton.y + mUpgradeAppleButton.height + 10,
										Std.int(mUpgradeAppleButton.width), "", 12);
		mUpgradeAppleCost.text = Std.string(GameDataManager.mAppleMap.get(GlobalGameData.appleLevel).cost);
		mUpgradeAppleCost.alignment = "center";
		mGUIGroup.add(mUpgradeAppleCost);
		
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
		
		mStartingX = 50;
		mStartingY = FlxG.height - 150;
		mDescription = new FlxText(mStartingX, mStartingY, 300, "", 15);
		mGUIGroup.add(mDescription);
		
		mGUIGroup.visible = true;
		mPlayButton.revive();
		mUpgradeButton.kill();
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
		
		mDescription.text = GameDataManager.mArrowSpeedDescription;
		mSelected = ShopSelection.ARROWSPEEDUPGRADE;
	}
	
	private static function onUpgradeArrowNoClick():Void
	{
		mButtonOutline.setPosition(mUpgradeArrowNoButton.x - 10, mUpgradeArrowNoButton.y - 10);
		mButtonOutline.visible = true;	
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
		
		mDescription.text = GameDataManager.mArrowNoDescription;
		mSelected = ShopSelection.ARROWNUMBERUPGRADE;
	}
	
	private static function onUpgradeGoldClick():Void
	{
		mButtonOutline.setPosition(mUpgradeGoldButton.x - 10, mUpgradeGoldButton.y - 10);
		mButtonOutline.visible = true;	
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
		
		mDescription.text = GameDataManager.mGoldDescription;
		mSelected = ShopSelection.GOLDUPGRADE;
	}
	
	private static function onUpgradeAppleClick():Void
	{
		mButtonOutline.setPosition(mUpgradeAppleButton.x - 10, mUpgradeAppleButton.y - 10);
		mButtonOutline.visible = true;	
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
		
		mDescription.text = GameDataManager.mAppleDescription;
		mSelected = ShopSelection.APPLEUPGRADE;
	}
	
	/*******************/
	// Upgrade Buttons //
	/*******************/
	private static function Upgrade():Void
	{
		var notEnough:Bool = false;
		switch(mSelected)
		{
			case NIL:
				return;
			case ARROWSPEEDUPGRADE:
			{
				//Check if high level.
				if (GameDataManager.mArrowSpeedLevel == GlobalGameData.arrowSpeedLevel)
				{
					mStatusText.text = "Already At Max Level";
					return;
				}

				if (GlobalGameData.deductGold(GameDataManager.mArrowSpeedMap.get(GlobalGameData.arrowSpeedLevel).cost))
				{
					mStatusText.text = "Arrow Speed Leveled Up";
					ArrowManager.increaseUpgradeSpeed();
				}
				else
					notEnough = true;
			}
			
			case ARROWNUMBERUPGRADE:
			{
				//Check if high level.
				if (GameDataManager.mArrowNoLevel == GlobalGameData.arrowNoLevel)
				{
					mStatusText.text = "Already At Max Level";
					return;
				}

				if (GlobalGameData.deductGold(GameDataManager.mArrowNoMap.get(GlobalGameData.arrowNoLevel).cost))
				{
					mStatusText.text = "Arrow Number Leveled Up";
					ArrowManager.increaseUpgradeNo();
				}
				else
					notEnough = true;
			}
			
			case GOLDUPGRADE:
			{
				//Check if high level.
				if (GameDataManager.mGoldLevel == GlobalGameData.goldLevel)
				{
					mStatusText.text = "Already At Max Level";
					return;
				}

				if (GlobalGameData.deductGold(GameDataManager.mGoldMap.get(GlobalGameData.goldLevel).cost))
				{
					mStatusText.text = "Gold Chances Leveled Up";
					GameObjectManager.appleChanceIncrease();
				}
				else
					notEnough = true;
			}
			
			case APPLEUPGRADE:
			{
				//Check if high level.
				if (GameDataManager.mAppleLevel == GlobalGameData.appleLevel)
				{
					mStatusText.text = "Already At Max Level";
					return;
				}

				if (GlobalGameData.deductGold(GameDataManager.mAppleMap.get(GlobalGameData.appleLevel).cost))
				{
					mStatusText.text = "Apple Chances Leveled Up";
					GameObjectManager.goldChanceIncrease();
				}
				else
					notEnough = true;
			}
		}
		
		if (notEnough)
			mStatusText.text = "Not Enough Gold";
		
	}
	
	private static function Play():Void
	{
		EventManager.triggerEvent(EventType.LEAVE_SHOP);
	}
}