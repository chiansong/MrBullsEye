package managers;
import flixel.FlxG;
import flixel.util.FlxPoint;
import game.GlobalGameData;
import haxe.xml.Fast;
import managers.DisplayManager;
import managers.EventManager;
import event.EventType;
import flixel.group.FlxGroup;
import objects.Apple;
import objects.Arrow;
import objects.BullsEye;
import objects.GameObject;
import openfl.Assets;
import utils.DisplayLayers;
import utils.MathUtil;
import utils.ObjectPool;

/**
 * ...
 * @author Lim Chian Song
 */

class ArrowSpeedStats
{
	public function new(_speed:Float, _cost:Float)
	{
		speed = _speed;
		cost = _cost;
	}
	public var speed:Float;
	public var cost:Float;
}

class GameDataManager
{
	private static var mGoldEarned:Int;
	private static var mHighestScore:Int;
	
	private static var mArrowSpeedMap:Map<Int,ArrowSpeedStats>;
	private static var mArrowSpeedDescription:String;
	
	public static function init():Void
	{
		EventManager.subscrible(EventType.GAME_INIT, onGameEnter);
		EventManager.subscrible(EventType.GAME_OVER, onGameOver);
		
		mArrowSpeedMap = new Map<Int,ArrowSpeedStats>();
		parseArrowSpeedData(Assets.getText("data/arrowspeeddata.xml"));
	}
	
	public static function addGoldEarned(value:Int):Void
	{
		mGoldEarned += value;
	}
	
	private static function onGameEnter(evt:Int, params:Dynamic):Void
	{
		mGoldEarned = 0;
	}
	
	private static function onGameOver(evt:Int, params:Dynamic):Void
	{
		mGoldEarned = 100;
		GlobalGameData.addGold(mGoldEarned);
		GlobalGameData.save();
	}
		
	public static function parseArrowSpeedData(assetFile:String)
	{
		var arrowspeedXML = new Fast(Xml.parse(assetFile).firstElement());
		mArrowSpeedDescription = arrowspeedXML.node.description.innerData;
		
		for (data in arrowspeedXML.nodes.level)
		{
			var level:Int = Std.parseInt(data.innerData);
			//The info
			var speed:Int = Std.parseInt(data.att.speed);
			var cost:Int = Std.parseInt(data.att.cost);
			
			var arrowData:ArrowSpeedStats = new ArrowSpeedStats(speed, cost);
			
			mArrowSpeedMap.set(level, arrowData);
		}
	}
}