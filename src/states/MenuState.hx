package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxArrayUtil;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import game.GlobalGameData;
import openfl.Assets;

/**
 * ...
 * @author C.S.LIM
 */

class MenuState extends FlxState
{
	public static var mGUIGroup0:FlxGroup; //Background
	public static var mGUIGroup1:FlxGroup; //Railing ... Fans Area 
	public static var mGUIGroup2:FlxGroup; //In-Game GUI
	public static var mGUIGroup3:FlxGroup; //Title Text Array
	
	//Top
	private static var mBorder:FlxSprite;
	private static var mBackgroundBack:FlxSprite;
	private static var mBackgroundRay:FlxSprite;
	
	//Name
	private static var mEggmenTextArray:Array<FlxSprite>; //EGGMAN -CIRCUS
	private static var mCharacter:FlxSprite;
	private static var mCharacterFlip:Bool;
	private static var mCharacterFlipY:Bool;
	private static var mCharacterInitialY:Float;
	private static var moveAmount = 25;
	private static var moveAmountY = 15;
	
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
	private static var mLight1:FlxSprite;
	private static var mLight2:FlxSprite;
	
	//G4
	private static var mLighting:FlxSprite;
	var mText:FlxText;
	
	//Title Counter
	private static var mCounter:Int;
	
	override public function create():Void
	{
		//Create the group.
		mGUIGroup0 = new FlxGroup();
		mGUIGroup1 = new FlxGroup();
		mGUIGroup2 = new FlxGroup();
		mGUIGroup3 = new FlxGroup();
		mEggmenTextArray = new Array<FlxSprite>();
			
		//The Background Ray From The Center.
		mBackgroundRay = new FlxSprite();
		mBackgroundRay.loadGraphic(Assets.getBitmapData("mainmenu/backgroundray.png"));
		mBackgroundRay.setPosition(FlxG.width / 2 - mBackgroundRay.width / 2, FlxG.height / 2 - mBackgroundRay.height / 2);
		mBackgroundRay.angularVelocity = 2.5;
			
		//Border
		mBorder = new FlxSprite();
		mBorder.loadGraphic(Assets.getBitmapData("mainmenu/border.png"));
		mBorder.setPosition(FlxG.width / 2 - mBorder.width / 2, FlxG.height / 2 - mBorder.height / 2);
		
		mBackgroundBack = new FlxSprite();
		mBackgroundBack.loadGraphic(Assets.getBitmapData("mainmenu/backgroundx.png"));
		mBackgroundBack.setPosition(FlxG.width / 2 - mBackgroundBack.width / 2, FlxG.height / 2 - mBackgroundBack.height / 2);
		
		//The Text
		mText = new FlxText(FlxG.width / 2, FlxG.height/2, 100, "Click To Begin");
		mText.color = FlxColor.WHITE;
		
		setupBackgroundAudience();
		setupLighting();
		
		add(mBackgroundBack);
		add(mBackgroundRay);
		add(mBackground);
		
		//Add the group
		add(mGUIGroup0);
		add(mGUIGroup1);
		add(mGUIGroup2);
		
		//Add in to the scene
		add(mText);
		add(mBorder);
		setupEggNameTitle();
		add(mGUIGroup3);
		
		//Let Play It
		mCounter = 0;
		playTitle(null);
		
		mCharacterFlip = false;
		mCharacterFlipY = false;
	}
	
	private function setupBackgroundAudience():Void
	{
		//Group 0
		mBackground = new FlxSprite(0, 0);
		mBackground.loadGraphic(Assets.getBitmapData("mainmenu/background.png"));
		//Let setup the position properly
		mBackground.setPosition(FlxG.width / 2 - mBackground.width / 2,
								FlxG.height / 2 - mBackground.height / 2);
		mGUIGroup0.add(mBackground);
		
		//Group 1 //Stuff in front of background ... railing , crowd
		//Audience behind crowd mah so let add that first
		mAudienceRow1 = new FlxSprite(0, 0);
		mAudienceRow1.loadGraphic(Assets.getBitmapData("mainmenu/audience.png"), true, false, 580, 25, false);
		mAudienceRow1.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow1.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow1.animation.play("idle");
		mAudienceRow1.color = 0xffbebebe;
		
		mAudienceRow2 = new FlxSprite(0, 0);
		mAudienceRow2.loadGraphic(Assets.getBitmapData("mainmenu/audience.png"), true, false, 580, 25, false);
		mAudienceRow2.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow2.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow2.animation.play("idle");
		mAudienceRow2.color = 0xff7b7b7b;
		
		mAudienceRow3 = new FlxSprite(0, 0);
		mAudienceRow3.loadGraphic(Assets.getBitmapData("mainmenu/audience.png"), true, false, 580, 25, false);
		mAudienceRow3.animation.add("idle", [0, 1, 2], 3, true);
		mAudienceRow3.animation.add("cheer", [0, 1, 2, 0, 1, 2], 12, false);
		mAudienceRow3.animation.play("idle");
		mAudienceRow3.color = 0xff474747;
		
		mGUIGroup1.add(mAudienceRow3);
		mGUIGroup1.add(mAudienceRow2);
		mGUIGroup1.add(mAudienceRow1);
		
		mRailing = new FlxSprite(0, 0);
		mRailing.loadGraphic(Assets.getBitmapData("mainmenu/gamerailing.png"));
		//Setup the position.
		mRailing.setPosition(FlxG.width / 2 - mRailing.width / 2,
							 FlxG.height / 2 -  155);
		mGUIGroup1.add(mRailing);
							 
		//Setup the Audience After the railing
		mAudienceRow1.setPosition(mRailing.x + 20,
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
		//mGUIGroup1.add(mDoor3);
		
		mLight1 = new FlxSprite();
		mLight1.loadGraphic(Assets.getBitmapData("background/spotlight.png"), 
							true, false, 350, 400);
		mLight1.setPosition(FlxG.width / 2 - mLight1.width / 2 - mLight1.width / 4, 0);
		mLight1.animation.add("play", [0, 1, 2, 3, 4, 3, 2, 1, 9, 8, 7, 6, 5, 6, 7, 8], 6);
		mLight1.alpha = 0.25;
		
		mLight2 = new FlxSprite();
		mLight2.loadGraphic(Assets.getBitmapData("background/spotlight.png"), 
							true, false, 350, 400);
		mLight2.setPosition(FlxG.width / 2 - mLight1.width / 2 + mLight1.width / 4, 0);
		mLight2.animation.add("play", [9, 8, 7, 6, 5, 6, 7, 8, 0, 1, 2, 3, 4, 3, 2, 1], 6);
		mLight2.alpha = 0.25;
		
		mLight1.animation.play("play");
		mLight2.animation.play("play");
		
		mGUIGroup1.add(mLight1);
		mGUIGroup1.add(mLight2);
	}
	
	private function setupEggNameTitle():Void
	{
		var mSprite:FlxSprite;
		var mStartingX:Int = Std.int(FlxG.width / 2) - 250;
		var mStartingY:Int = 0;
		
		//First E.
		mSprite = new FlxSprite();
		mSprite.loadGraphic(Assets.getBitmapData("mainmenu/E.png"),
							true, false, 75, 99);
		mSprite.setPosition(mStartingX, mStartingY - mSprite.height);
		mSprite.animation.add("play", [0, 1, 2, 1, 0, 3, 4, 3, 0], 12, false);
		mEggmenTextArray.push(mSprite);
		mGUIGroup3.add(mSprite);
		mStartingX += 55;
		
		//First G.
		mSprite = new FlxSprite();
		mSprite.loadGraphic(Assets.getBitmapData("mainmenu/G.png"),
							true, false, 85, 112);
		mSprite.setPosition(mStartingX, mStartingY - mSprite.height);
		mSprite.animation.add("play", [0, 1, 2, 1, 0, 3, 4, 3, 0], 12, false);
		mEggmenTextArray.push(mSprite);
		mGUIGroup3.add(mSprite);
		mStartingX += 55;
		
		//Second G.
		mSprite = new FlxSprite();
		mSprite.loadGraphic(Assets.getBitmapData("mainmenu/G.png"),
							true, false, 85, 112);
		mSprite.setPosition(mStartingX, mStartingY - mSprite.height);
		mSprite.animation.add("play", [0, 1, 2, 1, 0, 3, 4, 3, 0], 12, false);
		mEggmenTextArray.push(mSprite);
		mGUIGroup3.add(mSprite);
		mStartingX += 55;
		
		//First M.
		mSprite = new FlxSprite();
		mSprite.loadGraphic(Assets.getBitmapData("mainmenu/M.png"),
							true, false, 105, 101);
		mSprite.setPosition(mStartingX, mStartingY - mSprite.height);
		mSprite.animation.add("play", [0, 1, 2, 1, 0, 3, 4, 3, 0], 12, false);
		mEggmenTextArray.push(mSprite);
		mGUIGroup3.add(mSprite);
		mStartingX += 75;
		
		//Second E.
		mSprite = new FlxSprite();
		mSprite.loadGraphic(Assets.getBitmapData("mainmenu/E.png"),
							true, false, 75, 99);
		mSprite.setPosition(mStartingX, mStartingY - mSprite.height);
		mSprite.animation.add("play", [0, 1, 2, 1, 0, 3, 4, 3, 0], 12, false);
		mEggmenTextArray.push(mSprite);
		mGUIGroup3.add(mSprite);
		mStartingX += 55;
		
		//Second N.
		mSprite = new FlxSprite();
		mSprite.loadGraphic(Assets.getBitmapData("mainmenu/N.png"),
							true, false, 101, 96);
		mSprite.setPosition(mStartingX, mStartingY - mSprite.height);
		mSprite.animation.add("play", [0, 1, 2, 1, 0, 3, 4, 3, 0], 12, false);
		mEggmenTextArray.push(mSprite);
		mGUIGroup3.add(mSprite);
		mStartingX = Std.int(FlxG.width / 2) - 100;
		
		//Circus.
		mSprite = new FlxSprite();
		mSprite.loadGraphic(Assets.getBitmapData("mainmenu/circusname.png"),
							true, false, 338, 114);
		mSprite.setPosition(mStartingX, mStartingY - mSprite.height);
		mSprite.animation.add("play", [0, 1, 2, 1, 0, 3, 4, 3, 0], 12, false);
		mEggmenTextArray.push(mSprite);
		mGUIGroup3.add(mSprite);
		
		//Character
		mCharacter = new FlxSprite();
		mCharacter.loadGraphic(Assets.getBitmapData("shop/shopcharacter.png"),true,true,80,80);
		mCharacter.setPosition(FlxG.width / 5 - mCharacter.width, 
							   FlxG.height - mCharacter.height / 1.05);
		mCharacter.animation.add("talk", [3, 4, 5, 3, 5, 0, 4, 3, 0], 12, false);
		mCharacter.animation.add("buy", [0, 1, 0, 2, 0, 1, 0, 2, 0], 12, false);
		mCharacter.facing = FlxObject.RIGHT;
		mCharacter.scale.x = 2;
		mCharacter.scale.y = 2;
		mCharacterInitialY = mCharacter.y;
		
		mGUIGroup3.add(mCharacter);
	}
	
	//Set lighting for background
	private function setupLighting():Void
	{
		mLighting = new FlxSprite();
		mLighting.loadGraphic(Assets.getBitmapData("mainmenu/lighting.png"));
		mLighting.setPosition(FlxG.width/2 - mLighting.width/2, FlxG.height/2 - mLighting.height/2);
		mGUIGroup2.add(mLighting);
	}
	
	private function playTitle(tween:FlxTween):Void
	{
		var delay:Float = 0;
		if (mEggmenTextArray.length <= mCounter)
			return;
		
		if (mCounter == 0)
			delay = 0.5;
		
		//The ending height of the title.
		var newHeight:Float = FlxG.height / 2 - mEggmenTextArray[0].height - 75;
		if (mCounter == mEggmenTextArray.length - 1)
			newHeight =  FlxG.height / 2 - mEggmenTextArray[0].height - 15;
		
		FlxTween.tween(mEggmenTextArray[mCounter], { y: newHeight }, 0.15, { ease:FlxEase.backOut, startDelay:delay, complete:playTitle } );
		
		//Add the counter
		mCounter += 1;
	}
	
	override public function update():Void
	{
		if (FlxG.mouse.justPressed)
		{
			FlxG.switchState(new PlayState());
		}
		
		moveCharacter();
		super.update();
	}
	
	//Yo hooo let move the character
	private function moveCharacter():Void
	{
		//Walking to the left
		if (mCharacterFlip && mCharacter.x < 0)
		{
			moveAmount = -moveAmount;
			mCharacterFlip = false;
			mCharacter.facing = FlxObject.RIGHT;
		}
		else if(!mCharacterFlip && mCharacter.x > FlxG.width - mCharacter.width)
		{
			moveAmount = -moveAmount;
			mCharacterFlip = true;
			mCharacter.facing = FlxObject.LEFT;
		}
		
		//Walking to the left
		if (mCharacterFlipY && mCharacter.y < mCharacterInitialY - 5)
		{
			moveAmountY = -moveAmountY;
			mCharacterFlipY = false;
		}
		else if(!mCharacterFlipY && mCharacter.y > mCharacterInitialY + 5)
		{
			moveAmountY = -moveAmountY;
			mCharacterFlipY = true;
		}
		mCharacter.x += FlxG.elapsed * moveAmount;
		mCharacter.y += FlxG.elapsed * moveAmountY;
	}
	
	////************//
	////Timer Stuff //
	////************//
	//public function playerShoot(?Timer:FlxTimer):Void
    //{
		//var time:Int = FlxRandom.intRanged(5,10);
        //FlxTimer.start(time, playerShoot);
		//character.animation.play("shoot");
	//}
	//
	//public function bullMove(?Timer:FlxTimer):Void
    //{
		//var time:Int = FlxRandom.intRanged(5,10);
        //FlxTimer.start(time, bullMove);
		//bulleye.animation.play("Walk");
	//}
}