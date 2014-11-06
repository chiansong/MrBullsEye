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
	private static var mActiveArray:Array<FlxText>;
	private static var mCurrentCount:Int;
	private static var mBaseY:Float;
	private static var mDiff:Float = 20;
	
	//Init the status pool
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mActiveArray = new Array<FlxText>();
		mStatusPool = new ObjectPool<FlxText>(10, createStatusText);
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
	}
	
	//Create text
	private static function createStatusText():FlxText
	{
		var text = new FlxText(0, 0, Std.int(FlxG.width/2.5), "", 16);
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
		statusText.alpha = 1;
		
		//Change the text;
		statusText.text = text;
		mCurrentCount += 1;
		if (mCurrentCount > 9)
			mCurrentCount = 0;
			
		//Set the position
		statusText.x = 0;
		statusText.alignment = "right";
		statusText.reset(FlxG.width, mBaseY);
		
		//Move the active array
		for (count in 0 ... mActiveArray.length)
		{
			moveDown(mActiveArray[count], count);
			trace("count:"+count);
		}
		
		//set status text.
		mActiveArray.push(statusText);
		FlxTween.tween(statusText, { x:FlxG.width - Std.int(FlxG.width/2.25) }, 0.25, { ease:FlxEase.backInOut} );
		FlxTween.tween(statusText, { alpha:0 }, 0.5, { startDelay:0.75} );
	}
	
	//Assuming the one
	private static function moveDown(text:FlxText, num:Int):Void
	{
		var moveBase:Float = 25;
		moveBase *= num;
		FlxTween.tween(text, { y:mBaseY + moveBase }, 0.15);
	}
	
	//Check if it is visible then kill and remove it.
	public static function update():Void
	{
		//Move and kill them when it is dead
		for (count in 0 ... mActiveArray.length)
		{
			if (mActiveArray[count].alpha == 0)
			{
				mActiveArray[count].y = mBaseY;
				mActiveArray[count].kill();
			}
		}
	}
}