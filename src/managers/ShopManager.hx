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
	//Background
	public static var mBackground:FlxSprite; //Background.
	public static var mBackgroundRay:FlxSprite; //BackgroundRay
	public static var mUpgradeGrid:FlxSprite; //Upgrade Grid.
	
	//Top
	public static var mGold:FlxText;
	public static var mStatusText:FlxText;
	//Middle
	public static var mSelected:ShopSelection;
	public static var mButtonOutline:FlxSprite;
	public static var mUpgradeTimerButton:FlxButton;
	public static var mUpgradeTimerCost:FlxText;
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
	public static var mDescriptionBox:FlxSprite;
	public static var mShopCharacter:FlxSprite;
	
	public static function init():Void 
	{
		mGUIGroup = new FlxGroup();
		mGUIGroup.visible = false;
		mSelected = ShopSelection.NIL;
		
		setupBackground();
		setupShop();
	}
	
	private static function setupBackground():Void
	{
		//The background
		mBackground = new FlxSprite();
		mBackground.loadGraphic(Assets.getBitmapData("shop/backgroundbase.png"));
		mBackground.setPosition(FlxG.width / 2 - mBackground.width / 2, FlxG.height / 2 - mBackground.height / 2);
		mBackgroundRay = new FlxSprite();
		mBackgroundRay.loadGraphic(Assets.getBitmapData("shop/backgroundRay.png"));
		mBackgroundRay.setPosition(FlxG.width / 2 - mBackgroundRay.width / 2, FlxG.height / 2 - mBackgroundRay.height / 2);
		mBackgroundRay.angularVelocity = 2.5;
		
		//The upgrade grid background
		mUpgradeGrid = new FlxSprite();
		mUpgradeGrid.loadGraphic(Assets.getBitmapData("shop/upgradegrid.png"));
		mUpgradeGrid.setPosition(FlxG.width / 2 - mUpgradeGrid.width / 2, FlxG.height / 2 - mUpgradeGrid.height / 2);
		
		//Character
		mShopCharacter = new FlxSprite();
		mShopCharacter.loadGraphic(Assets.getBitmapData("shop/shopcharacter.png"),true,false,80,80);
		mShopCharacter.setPosition(FlxG.width / 5 - mShopCharacter.width, 
								   FlxG.height - mShopCharacter.height / 1.15);
		mShopCharacter.animation.add("talk", [3, 4, 5, 3, 5, 0, 4, 3, 0], 12, false);
		mShopCharacter.animation.add("buy", [0, 1, 0, 2, 0, 1, 0, 2, 0], 12, false);
		mShopCharacter.scale.x = 3;
		mShopCharacter.scale.y = 3;
		
		mDescriptionBox = new FlxSprite();

		//Let add it
		mGUIGroup.add(mBackground);
		mGUIGroup.add(mBackgroundRay);
		mGUIGroup.add(mUpgradeGrid);
		mGUIGroup.add(mDescriptionBox);
		mGUIGroup.add(mShopCharacter);
	}
	
	private static function setupShop():Void
	{
		var mStartingX:Float = FlxG.width / 2;
		var mStartingY:Float = FlxG.height / 2 - FlxG.height / 3.5;
		
		//The Gold Text
		mGold = new FlxText(mStartingX, mStartingY, 200, "", 25);
		mGold.x -= mGold.width / 2;
		mGold.text = Std.string(GlobalGameData.getGold());
		mGold.alignment = "center";
		mGUIGroup.add(mGold);
	
		//With status
		mStatusText = new FlxText(mStartingX, mStartingY + 30, 200, "", 15);
		mGUIGroup.add(mStatusText);
		
		//Buttons
		mStartingX = FlxG.width / 2 - FlxG.width/3;
		mStartingY += FlxG.height / 10;
		
		mButtonOutline = new FlxSprite(0, 0);
		mButtonOutline.loadGraphic(Assets.getBitmapData("shop/button_outline.png"), true, false, 100, 100);
		mButtonOutline.visible = false;
		mGUIGroup.add(mButtonOutline);
		
		//Upgrade Arrow Speed
		mUpgradeTimerButton = new FlxButton(mStartingX, mStartingY, null, onUpgradeTimerClick);
		mUpgradeTimerButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeTimerButton);
		mUpgradeTimerCost = new FlxText(mStartingX, mUpgradeTimerButton.y + mUpgradeTimerButton.height + 10,
										Std.int(mUpgradeTimerButton.width), "", 12);
		mUpgradeTimerCost.text = Std.string(GameDataManager.mTimerMap.get(GlobalGameData.timerLevel).cost);
		mUpgradeTimerCost.alignment = "center";
		mGUIGroup.add(mUpgradeTimerCost);
			
		//Upgrade Arrow No
		mUpgradeArrowNoButton = new FlxButton(mStartingX + mUpgradeTimerButton.width + 20, mStartingY, null, onUpgradeArrowNoClick);
		mUpgradeArrowNoButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeArrowNoButton);
		mUpgradeArrowNoCost = new FlxText(mUpgradeArrowNoButton.x, mUpgradeArrowNoButton.y + mUpgradeArrowNoButton.height + 10,
										Std.int(mUpgradeArrowNoButton.width), "", 12);
		mUpgradeArrowNoCost.text = Std.string(GameDataManager.mArrowNoMap.get(GlobalGameData.arrowNoLevel).cost);
		mUpgradeArrowNoCost.alignment = "center";
		mGUIGroup.add(mUpgradeArrowNoCost);
		
		//Upgrade Gold No
		mUpgradeGoldButton = new FlxButton(mUpgradeArrowNoButton.x + mUpgradeTimerButton.width + 20, mStartingY, null, onUpgradeGoldClick);
		mUpgradeGoldButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeGoldButton);
		mUpgradeGoldCost = new FlxText(mUpgradeGoldButton.x, mUpgradeGoldButton.y + mUpgradeGoldButton.height + 10,
										Std.int(mUpgradeGoldButton.width), "", 12);
		mUpgradeGoldCost.text = Std.string(GameDataManager.mGoldMap.get(GlobalGameData.goldLevel).cost);
		mUpgradeGoldCost.alignment = "center";
		mGUIGroup.add(mUpgradeGoldCost);
		
		//Upgrade Apple No
		mUpgradeAppleButton = new FlxButton(mUpgradeGoldButton.x + mUpgradeGoldButton.width + 20, mStartingY, null, onUpgradeAppleClick);
		mUpgradeAppleButton.loadGraphic(Assets.getBitmapData("shop/arrowspeed.png"), true, false, 80, 80);
		mGUIGroup.add(mUpgradeAppleButton);
		mUpgradeAppleCost = new FlxText(mUpgradeAppleButton.x, mUpgradeAppleButton.y + mUpgradeAppleButton.height + 10,
										Std.int(mUpgradeAppleButton.width), "", 12);
		mUpgradeAppleCost.text = Std.string(GameDataManager.mAppleMap.get(GlobalGameData.appleLevel).cost);
		mUpgradeAppleCost.alignment = "center";
		mGUIGroup.add(mUpgradeAppleCost);
		
		//Setup description text.
		mStartingX = mUpgradeTimerButton.x;
		mStartingY = mUpgradeTimerButton.y + mUpgradeTimerButton.height + FlxG.height / 8;
		mDescription = new FlxText(mStartingX, mStartingY, 250, "", 15);
		mGUIGroup.add(mDescription);
		
		//The chat box below it.
		mDescriptionBox.loadGraphic(Assets.getBitmapData("shop/shopchatbox.png"));
		mDescriptionBox.setPosition(mDescription.x - 20, 
								    mDescription.y - 20);		
		
		//Upgrade Button
		mStartingX = mDescription.x + mDescription.width + 15;
		mUpgradeButton = new FlxButton(mStartingX, mStartingY, null, Upgrade);
		mUpgradeButton.loadGraphic(Assets.getBitmapData("shop/upgrade.png"), true, false, 150, 50);
		mGUIGroup.add(mUpgradeButton);
		
		mStartingY = mUpgradeButton.y + mUpgradeButton.height + 15;
		mPlayButton = new FlxButton(mStartingX, mStartingY, null, Play);
		mPlayButton.loadGraphic(Assets.getBitmapData("shop/upgrade.png"), true, false, 150, 50);
		mGUIGroup.add(mPlayButton);
		
		//Show it
		mGUIGroup.visible = true;
		mPlayButton.revive();
		mUpgradeButton.kill();
	}
		
	/**************/
	//Shop Buttons//
	/**************/
	private static function onUpgradeTimerClick():Void
	{
		mButtonOutline.setPosition(mUpgradeTimerButton.x - 10, mUpgradeTimerButton.y - 10);
		mButtonOutline.visible = true;	
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
		
		mDescription.text = GameDataManager.mTimerDescription;
		mSelected = ShopSelection.TIMERUPGRADE;
		
		mShopCharacter.animation.play("talk");
	}
	
	private static function onUpgradeArrowNoClick():Void
	{
		mButtonOutline.setPosition(mUpgradeArrowNoButton.x - 10, mUpgradeArrowNoButton.y - 10);
		mButtonOutline.visible = true;	
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
		
		mDescription.text = GameDataManager.mArrowNoDescription;
		mSelected = ShopSelection.ARROWNUMBERUPGRADE;
		
		mShopCharacter.animation.play("talk");
	}
	
	private static function onUpgradeGoldClick():Void
	{
		mButtonOutline.setPosition(mUpgradeGoldButton.x - 10, mUpgradeGoldButton.y - 10);
		mButtonOutline.visible = true;	
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
		
		mDescription.text = GameDataManager.mGoldDescription;
		mSelected = ShopSelection.GOLDUPGRADE;
		
		mShopCharacter.animation.play("talk");
	}
	
	private static function onUpgradeAppleClick():Void
	{
		mButtonOutline.setPosition(mUpgradeAppleButton.x - 10, mUpgradeAppleButton.y - 10);
		mButtonOutline.visible = true;	
		mUpgradeButton.visible = true;
		mUpgradeButton.revive();
		
		mDescription.text = GameDataManager.mAppleDescription;
		mSelected = ShopSelection.APPLEUPGRADE;
		
		mShopCharacter.animation.play("talk");
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
			case TIMERUPGRADE:
			{
				//Check if high level.
				if (GameDataManager.mTimerLevel == GlobalGameData.timerLevel)
				{
					mStatusText.text = "Already At Max Level";
					return;
				}

				if (GlobalGameData.deductGold(GameDataManager.mTimerMap.get(GlobalGameData.timerLevel).cost))
				{
					mStatusText.text = "Timer Leveled Up";
					GameDataManager.increaseTimeLevel();
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
		else
		{
			//Update the gold data.
			mShopCharacter.animation.play("buy");
			mGold.text = Std.string(GlobalGameData.getGold());
			GlobalGameData.save();
			//Save it
		}
		
	}
	
	private static function Play():Void
	{
		EventManager.triggerEvent(EventType.LEAVE_SHOP);
	}
}