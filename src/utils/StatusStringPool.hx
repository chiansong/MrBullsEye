package utils;
import event.Event;
import event.EventType;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxPool;
import managers.DisplayManager;
import managers.EventManager;

/**
 * ...
 * @author Lim Chian Song
 */
class StatusStringPool
{
	private static var mGroup:FlxGroup;
	private static var mStatusPool:ObjectPool<FlxText>;
	private static var mCurrentCount:Int;
	private static var mBaseY:Float;
	private static var mDiff:Float = 20;
	
	//Init the status pool
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mStatusPool = new ObjectPool<FlxText>(10, createStatusText);
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
	}
	
	//Create text
	private static function createStatusText():FlxText
	{
		var text = new FlxText(0, 0, Std.int(FlxG.width/3), "", 12);
		text.kill();
		mGroup.add(text);
		return text;
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		DisplayManager.addToLayer(mGroup, DisplayLayers.GUILAYER.getIndex());
		mBaseY = FlxG.height / 2;
	}
	
	public static function setText(text:String):Void
	{
		var statusText:FlxText = mStatusPool.get();
		
		//Change the text;
		statusText.text = text;
		mCurrentCount += 1;
		if (mCurrentCount > 9)
			mCurrentCount = 0;
			
		statusText.x = 0;
		statusText.alignment = "right";
		statusText.reset(FlxG.width - FlxG.width/3,
						 getPosition(mCurrentCount));
		
		
		FlxTween.tween(statusText, { x:FlxG.width/2 }, 0.50, { ease:FlxEase.elasticInOut } );
	}
	
	private static function getPosition(count:Int):Float
	{
		var result:Float = 0;
		var pos:Int = count % 5;
		return result = mBaseY + (pos * mDiff);
	}
}