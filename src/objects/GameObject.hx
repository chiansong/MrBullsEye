package objects;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author CS.Lim
 */
class GameObject extends FlxSprite
{
	public var name:String;
	public var parent:FlxGroup;
	
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		
	}
	
	public var centerX(get, null):Float;
	public function get_centerX():Float
	{
		return x + width * 0.5;
	}
	
	public var centerY(get, null):Float;
	public function get_centerY():Float
	{
		return y + height * 0.5;
	}
}