package game;

import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import states.SplashState;
import states.MenuState;
import flixel.plugin.MouseEventManager;
/**
 * ...
 * @author C.S.LIM
 */
class MainGame extends FlxGame
{   
	public function new()
	{
			var stageWidth:Int = Lib.current.stage.stageWidth;
			var stageHeight:Int = Lib.current.stage.stageHeight;
			
			var ratioX:Float = stageWidth / 640;
			var ratioY:Float = stageHeight / 480;
			var ratio:Float = Math.min(ratioX, ratioY);
			
			var fps:Int = 60;
			
			super(Math.ceil(stageWidth / ratio), 
				  Math.ceil(stageHeight / ratio), 
				  MenuState, ratio, fps, fps);
	}
	
	public override function update():Void
	{
		super.update();
		
		//Remove when 
		if (FlxG.keys.justPressed.M)
		{
			GlobalGameData.gameSaveData.erase();
		}
	}
}