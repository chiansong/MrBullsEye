package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
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
	private var mBackground:FlxSprite;
	private var mBackgroundRay:FlxSprite;
	
	var mText:FlxText;
	
	override public function create():Void
	{
		//The background
		mBackground = new FlxSprite();
		mBackground.loadGraphic(Assets.getBitmapData("shop/backgroundbase.png"));
		mBackground.setPosition(FlxG.width / 2 - mBackground.width / 2, FlxG.height / 2 - mBackground.height / 2);
		mBackgroundRay = new FlxSprite();
		mBackgroundRay.loadGraphic(Assets.getBitmapData("shop/backgroundRay.png"));
		mBackgroundRay.setPosition(FlxG.width / 2 - mBackgroundRay.width / 2, FlxG.height / 2 - mBackgroundRay.height / 2);
		
		mText = new FlxText(FlxG.width / 2, FlxG.height/2, 100, "Click To Begin");
		mText.color = FlxColor.WHITE;
		
		add(mBackground);
		add(mBackgroundRay);
		add(mText);
		
		////SCREEN
		//screen = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		//screen.loadGraphic("img/background.png", false, false, 640, 480);
		//add(screen);
		////reset it.
		//screen.x -= screen.width / 2;
		//screen.y -= screen.height / 2;
		//
		//character = new FlxSprite(35, 185);
		//character.loadGraphic("img/player.png", true, false, 64, 64);
		//character.animation.add("shoot", [3, 4, 3, 5], 12, false);
		//character.scale.x = 7;
		//character.scale.y = 7;
		//add(character);
		//
		//bulleye = new FlxSprite(FlxG.width - 75, 195);
		//bulleye.loadGraphic("img/bulleye.png", true, false, 32, 68);
		//bulleye.animation.add("Walk", [0, 1, 0, 1], 6, false);
		//bulleye.scale.x = 6;
		//bulleye.scale.y = 6;
		//add(bulleye);
		//
		//title = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		//title.loadGraphic("img/title.png", false, false);
		//title.x -= title.width / 2;
		//title.y -= title.height / 2 + 135;
		//add(title);
		//
		//FlxTween.linearMotion(character, -200, character.y, character.x, character.y, 1, true, { ease:FlxEase.backOut } );
		//FlxTween.linearMotion(bulleye, 800, bulleye.y, bulleye.x, bulleye.y, 1.5, true, { ease:FlxEase.backOut} );
		//FlxTween.linearMotion(title, title.x, -200, title.x, title.y, 2.5, true, { ease:FlxEase.bounceOut} );
		//
		//playerShoot();
		//bullMove();
		//FlxG.mouse.show();
	}
	
	override public function update():Void
	{
		if (FlxG.mouse.justPressed)
		{
			FlxG.switchState(new PlayState());
		}
		super.update();
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