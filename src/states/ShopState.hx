package states;

import event.EventType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import game.GlobalGameData;
import managers.DisplayManager;
import managers.EventManager;
import managers.ShopManager;
import openfl.Assets;

/**
 * ...
 * @author C.S.LIM
 */

class ShopState extends FlxState
{
	var screen:FlxSprite;
	var character:FlxSprite;
	var bulleye:FlxSprite;
	var title:FlxSprite;
	
	override public function create():Void
	{
		ShopManager.init();
		add(ShopManager.mGUIGroup);
		
		EventManager.subscrible(EventType.LEAVE_SHOP, onShopToGame);
	}
	
	private function onShopToGame(evt:Int, params:Dynamic):Void
	{
		FlxG.switchState(new PlayState());
	}

	override public function update():Void
	{
		super.update();
		
		EventManager.update();
		//if (FlxG.mouse.justPressed)
		//{
			//FlxG.switchState(GlobalGameData.mPlayState);
		//}
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