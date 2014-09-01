package utils;

/**
 * ...
 * @author CS.Lim
 */
class MathUtil
{
	public static function getRandomBetween(start:Int, end:Int):Int 
	{
		return start + Std.random(end - start);
	}
	
	public static function getRandomBetweenRare(start:Int, end:Int):Int 
	{
		return start + Std.random(end - start);
	}
}