package utils;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxPool;

/**
 * ...
 * @author Lim Chian Song
 */
class StatusStringPool
{
	public static var mGroup:FlxGroup;
	private static var mStatusPool:ObjectPool<FlxText>;
	
	//Init the status pool
	public function init() 
	{
		mStatusPool = new ObjectPool<FlxText>(10, createStatusText);
	}
	
	//Create text
	private function createStatusText():FlxText
	{
		var text = new FlxText(0, 0, 0, "", 0);
		text.kill();
		mGroup.add(text);
		return text;
	}
	
	
	private function setText(text:String):Void
	{
		mStatusPool.get().text = text;
	}
}