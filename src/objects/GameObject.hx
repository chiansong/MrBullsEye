package objects;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;

/**
 * ...
 * @author CS.Lim
 */
class GameObject extends FlxSprite
{
	public var mSpeedX:Float;
	public var mSpeedY:Float;
	public var mState:Int;
	public var mActive:Bool;
	
	public static var IDLE:Int = 0;
	public static var MOVE:Int = 1;
	public static var PASS:Int = 2;
	
	public var name:String;
	public var parent:FlxGroup;
	
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		
	}
	
	public function activate(_pos:FlxPoint, _speedX:Float, _speedY:Float):Void
	{
		reset(_pos.x, _pos.y);
		
		mState = MOVE;
		mSpeedX = _speedX;
		mSpeedY = _speedY;
		
		mActive = true;
		visible = true;
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
	
	public override function update():Void
	{
		super.update();
	}
}