package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import game.GlobalGameData;
import openfl.Assets;

/**
 * ...
 * @author C.S.LIM
 */

 //Create Splash 
class SplashState extends FlxState
{
	var screen:FlxSprite;
	override public function create():Void
	{
		//SPLASH SCREEN
		screen = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		screen.loadGraphic(Assets.getBitmapData("background/splashscreen.png"), true, false, 400, 200);
		screen.animation.add("play", [0, 1, 2], 3, false);
		screen.animation.play("play");
		add(screen);
		
		//reset it.
		screen.x -= screen.width / 2;
		screen.y -= screen.height / 2;
		
		FlxTimer.start(2.5, go);
		
		//Load the needed data of the game.
		
		GlobalGameData.init();
		GlobalGameData.load();
	}
	
	//Play it
	public function go(?Timer:FlxTimer):Void
	{
		FlxG.switchState(new MenuState());
	}
	
}