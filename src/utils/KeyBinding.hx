package utils;
import flixel.FlxG; 
import lime.helpers.Gamepad;

/**
 * ...
 * @author Lim Chian Song
 */
class KeyBinding
{
	public static var pressed:Map < String, Void->Bool > ;
	public static var justPressed:Map < String, Void->Bool > 

	private static function init():Void
	{
		justPressed = ["click" => clickJustPressed];
	}
	
	public static function update():Void
	{

	}
	
	public static function clickJustPressed():Bool
	{
		return FlxG.mouse.pressed;
	}
}