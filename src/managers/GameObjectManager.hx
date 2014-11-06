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
import objects.GoldBag;
import openfl.Assets;
import utils.DisplayLayers;
import utils.Globals;
import utils.MathUtil;
import utils.ObjectPool;

/**
 * ...
 * @author Lim Chian Song
 */
class GameInfoStats
{
	public function new(_speed:Float, _power:Float)
	{
		speed = _speed;
		power = _power;
	}
	
	public var speed:Float;
	public var power:Float;
}

class GameData
{
	public function new()
	{
	}
	
	public var gold:Int;
	public var time:Float;
	public var speedY:Int;
	public var maxPoint:Int;
	public var appleChance:Int;
	public var lvl2Chance:Int;
	public var lvl3Chance:Int;
	public var lvl4Chance:Int;
	public var lvl5Chance:Int;
	public var openDoor1:Int;
	public var openDoor2:Int;
	public var openDoor3:Int;
}
 
class GameObjectManager
{
	public static var mGroup:FlxGroup;
	public static var mStartingPosition:FlxPoint;
	private static var mBullEyePool:ObjectPool<GameObject>;
	private static var mApplePool:ObjectPool<Apple>;
	private static var mGoldPool:ObjectPool<GoldBag>;
	
	public static var mActiveArray:Array<GameObject>;
	private static var mGameDataMap:Map<Int,GameData>;
	private static var mLanuchTime:Float;
	private static var mLanuchTimer:Float;
	
	private static var mPreviousMovementSpeedY:Float;
	private static var mMovementSpeedY:Float;
	private static var mGameLevel:Int;
	public static var mGameOver:Bool;
	public static var mCanStart:Bool;
	
	//The 3 Possible Position that are used to spawn.
	private static var mPosition1:FlxPoint;
	private static var mPosition2:FlxPoint;
	private static var mPosition3:FlxPoint;
	
	public static function init():Void
	{
		mGroup = new FlxGroup();
		mActiveArray = new Array<GameObject>();
		mGameDataMap = new Map<Int,GameData>();
		mBullEyePool = new ObjectPool<GameObject>(50, createBullsEye);
		mApplePool = new ObjectPool<Apple>(10, createApple);
		mGoldPool = new ObjectPool<GoldBag>(10, createGoldBag);
		
		mStartingPosition = new FlxPoint();
		mPosition1 = new FlxPoint();
		mPosition2 = new FlxPoint();
		mPosition3 = new FlxPoint();
		
		setPosition(FlxG.width - 3 * FlxG.width / 8, 20);
		
		mPosition1.set(InGameGUIManager.getDoorPosition(1,1), InGameGUIManager.getDoorPosition(1,2));
		mPosition2.set(InGameGUIManager.getDoorPosition(2,1), InGameGUIManager.getDoorPosition(2,2));
		mPosition3.set(InGameGUIManager.getDoorPosition(3,1), InGameGUIManager.getDoorPosition(3,2));
		
		mPreviousMovementSpeedY = 0;
		mMovementSpeedY = 100;
		mGameLevel = 1;
		mLanuchTime = 1;
		mLanuchTimer = 0;
		
		mGameOver = false;
		
		parseGameData(Assets.getText("data/gamedata.xml"));
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		EventManager.subscrible(EventType.GAME_OVER, onGameOver);
		EventManager.subscrible(EventType.OBJECT_MOVE, onLanuch);
		EventManager.subscrible(EventType.OBJECT_OUT, onOut);
		EventManager.subscrible(EventType.SPEED_UP, onSpeedUp);
		EventManager.subscrible(EventType.ENTER_SHOP, onShopEnter);
		EventManager.subscrible(EventType.GAMESTART, onGameStart);
	}
	
	private static function onGameStart(evt:Int, params:Dynamic):Void
	{
		mCanStart = true;
	}
	
	private static function createBullsEye():BullsEye
	{
		var bullseye = new BullsEye();
		bullseye.kill();
		mGroup.add(bullseye);
		return bullseye;
	}
	
	private static function createApple():Apple
	{
		var apple = new Apple();
		apple.kill();
		mGroup.add(apple);
		return apple;
	}
	
	private static function createGoldBag():GoldBag
	{
		var gold = new GoldBag();
		gold.kill();
		mGroup.add(gold);
		return gold;
	}
	
	public static function setPosition(_x:Float, _y:Float)
	{
		mStartingPosition.set(_x, _y);
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		DisplayManager.addToLayer(mGroup, DisplayLayers.OBJECT1LAYER.getIndex());
		
		mMovementSpeedY = 100;
		mGameLevel = 1;
		mLanuchTime = 1;
		mLanuchTimer = 0;
		
		mCanStart = false;
		mGameOver = false;
	}
	
	private static function onGameOver(evt:Int, params:Dynamic):Void
	{
		//STOP EVERYTHING
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].mSpeedY = 0;
		}
		mGameOver = true;
		
		//It is game over, add the gold earn.
		GameDataManager.mGoldEarned += mGameDataMap.get(mGameLevel).gold;
	}
	
	private static function onShopEnter(evt:Int, params:Dynamic):Void
	{
		//STOP EVERYTHING
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].kill();
		}
	}
	
	private static function onOut(evt:Int, params:Dynamic):Void
	{
		mActiveArray.remove(params.object);
	}
	
	private static function onLanuch(evt:Int, params:Dynamic):Void
	{
		var chosen:Int;
		while (true)
		{
			chosen = MathUtil.getRandomBetween(0, 3);
			trace(chosen);

			//Chose where to start
			switch(chosen)
			{
				case 0:
					if (mGameDataMap.get(mGameLevel).openDoor1 == 1)
					{
						mStartingPosition = mPosition1;
						break;
					}
				case 1:
					if (mGameDataMap.get(mGameLevel).openDoor2 == 1)
					{
						mStartingPosition = mPosition2;
						break;
					}
				case 2:
					if (mGameDataMap.get(mGameLevel).openDoor3 == 1)
					{
						mStartingPosition = mPosition3;
						break;
					}
			}
		}
		
		//Grab an Apple
		var object:GameObject;
		if (MathUtil.getRandomBetween(0, 1000) 
		< GameDataManager.mAppleMap.get(GlobalGameData.appleLevel).data)
		{
			object = mApplePool.get();
			object.activate(mStartingPosition, 0, mMovementSpeedY);
			mActiveArray.push(object);
			return;
		}
		
		//Grab Gold Bag
		if (MathUtil.getRandomBetween(0, 1000) <
		GameDataManager.mGoldMap.get(GlobalGameData.goldLevel).data)
		{
			object = mGoldPool.get();
			object.activate(mStartingPosition, 0, mMovementSpeedY);
			mActiveArray.push(object);
			return;
		}
		
		//IT IS A BULLSEYE
		object = mBullEyePool.get();
		var value:Int = 0;
		var bulleye:BullsEye = cast(object, BullsEye);	
		//Level 4
		if (MathUtil.getRandomBetween(0, 100) < mGameDataMap.get(mGameLevel).lvl5Chance)
			value = 4;
		//Level 3
		if (MathUtil.getRandomBetween(0, 100) < mGameDataMap.get(mGameLevel).lvl4Chance)
			value = 3;
		//Level 2
		if (MathUtil.getRandomBetween(0, 100) < mGameDataMap.get(mGameLevel).lvl3Chance)
			value = 2;
		//Level 1
		if (MathUtil.getRandomBetween(0, 100) < mGameDataMap.get(mGameLevel).lvl2Chance)
			value = 1;
		
		//set base on the value then 
		bulleye.setBullEyes(value);	
		bulleye.setStartingPosition(mStartingPosition.y, 
									Globals.player.y); 
		bulleye.activate(mStartingPosition, 0, mMovementSpeedY);
		mActiveArray.push(bulleye);
	}
	
	public static function update():Void
	{
		if (mGameOver)
			return;
		
		if (!mCanStart)
			return;
			
		mLanuchTimer += FlxG.elapsed;
		if (mLanuchTimer > mLanuchTime)
		{
			EventManager.triggerEvent(EventType.OBJECT_MOVE);
			mLanuchTimer = 0;
		}
		updateSpeed();
	}
	
	private static function onSpeedUp(evt:Int, params:Dynamic):Void
	{
		//Reduce the max and reset combo
		for (count in 0 ... mActiveArray.length)
		{
			mActiveArray[count].mSpeedY = params.speed;
		}
	}
	
	public static function updateSpeed():Void
	{
		if (ScoreManager.mScore > mGameDataMap.get(mGameLevel).maxPoint)
		{
			mGameLevel += 1;
						
			//Level Up, 
			EventManager.triggerEvent(EventType.LEVELUP, { level:mGameLevel } );
		}
		
		mLanuchTime = mGameDataMap.get(mGameLevel).time;
		mMovementSpeedY = mGameDataMap.get(mGameLevel).speedY;
		
		if (mPreviousMovementSpeedY != mMovementSpeedY)
		{
			EventManager.triggerEvent(EventType.SPEED_UP, { speed:mMovementSpeedY } );
			mPreviousMovementSpeedY = mMovementSpeedY;
		}
	}
	
	public static function parseGameData(assetFile:String)
	{
		var gameDataXML = new Fast(Xml.parse(assetFile).firstElement());
		//Let Grab the INFO
		for (data in gameDataXML.nodes.level)
		{
			//Get the data for what level it is.
			var level:Int = Std.parseInt(data.innerData);
			
			var dataStats:GameData = new GameData();
			
			dataStats.time 		= Std.parseFloat(data.att.time);
			dataStats.speedY	= Std.parseInt(data.att.speedY);
			dataStats.maxPoint 	= Std.parseInt(data.att.max);
			dataStats.gold		= Std.parseInt(data.att.gold);
			//Get the Levels
			dataStats.lvl2Chance = Std.parseInt(data.att.lvl2);
			dataStats.lvl3Chance = Std.parseInt(data.att.lvl3);
			dataStats.lvl4Chance = Std.parseInt(data.att.lvl4);
			dataStats.lvl5Chance = Std.parseInt(data.att.lvl5);
			
			//Game Data to decide where can be spawn.
			dataStats.openDoor1 = Std.parseInt(data.att.door1);
			dataStats.openDoor2 = Std.parseInt(data.att.door2);
			dataStats.openDoor3 = Std.parseInt(data.att.door3);
	
			mGameDataMap.set(level, dataStats);
		}
	}
	
	/**
	 * Increase the apple chance ... more apple more multipler
	 */
	public static function appleChanceIncrease():Void
	{
		GlobalGameData.appleLevel += 1;
	}
	
	/**
	 * Increase the gold chance ... more gold more multipler
	 */	
	public static function goldChanceIncrease():Void
	{
		GlobalGameData.goldLevel += 1;
	}
}