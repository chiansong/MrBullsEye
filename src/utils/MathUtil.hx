package utils;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import objects.Arrow;

/**
 * ...
 * @author CS.Lim
 */
class MathUtil
{
	//private stuff
	private static var distanceA:Float;
	private static var distanceB:Float;
	private static var vectorA:FlxPoint;
	private static var vectorB:FlxPoint;
	
	public static function init():Void
	{
		vectorA = new FlxPoint();
		vectorB = new FlxPoint();
	}
	
	public static function getRandomBetween(start:Int, end:Int):Int 
	{
		return start + Std.random(end - start);
	}
	
	public static function inBetween(a:Float, b:Float, x:Float):Bool
	{
		if (a < x && x < b)
			return true;
			
		return false;
	}
	
	public static function simpleLineObjectTest(arrow:Arrow, object:FlxObject):Bool
	{
		//Yo ... you pass liao no need to test liao
		if (arrow.mPreviousPosition.x + arrow.width > object.x + object.width)
			return false;
		
		//Distance A vs Distance B.
		distanceA = (arrow.mCurrentPosition.x + arrow.width - arrow.mPreviousPosition.x + arrow.width);
		distanceB = (object.x + object.width/2 - arrow.mPreviousPosition.x + arrow.width);
		
		if (distanceA > distanceB)
		{
			//Check if it is in between.
			if (inBetween( object.y, object.y + object.height, arrow.y + arrow.height / 2 ))
				return true;
			
			return false;
		}
		else 
			return false;
	}
}