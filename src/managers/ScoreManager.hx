package managers;
import event.EventType;
import haxe.xml.Fast;
import openfl.Assets;

/**
 * ...
 * @author CS.Lim
 */
class BonusData
{
	public function new(_combo:Int, _points:Int,
						_gold:Int, _time:Float)
	{
		combo 	= _combo;
		points 	= _points;
		gold 	= _gold;
		time 	= _time;
	}
	
	public var combo:Int;
	public var points:Int;
	public var gold:Int;
	public var time:Float;
}
 
class ScoreManager
{
	public static var mScore:Int;
	public static var mCurrentPoint:Int;
	public static var mCombo:Int;
	public static var mHighestScore:Int;
	public static var mMultipler:Int;
	public static var mBonusLevel:Int;
	
	//Map
	public static var mBonusMap:Map<Int,BonusData>;
	
	public static function init():Void 
	{
		mBonusMap = new Map<Int, BonusData>();
		
		mScore = 0;
		mHighestScore = 0;
		mMultipler = 1;
		mCombo = 0;
		mBonusLevel = 1;
		mCurrentPoint = 1;
		
		EventManager.subscrible(EventType.GAME_INIT, onGameInit);
		
		parseBonusData(Assets.getText("data/bonusdata.xml"));
	}
	
	private static function onGameInit(evt:Int, params:Dynamic):Void
	{
		mScore = 0;
		mMultipler = 1;
		mCombo = 0;
		mBonusLevel = 1;
		mCurrentPoint = 1;
	}
	
	public static function instantAddScore(score:Int):Void
	{
		mScore += score;
		InGameGUIManager.mScore.text = Std.string(mScore);
	}
	
	public static function addScore(_point):Void
	{
		mScore += mMultipler * _point;
		EventManager.triggerEvent(EventType.SCOREADDED, {score: (mMultipler * _point)});
		InGameGUIManager.mScore.text = Std.string(mScore);
		
	}
	
	public static function increaseMultipler():Void
	{
		mMultipler += 1;
	}
	
	public static function increaseCombo():Void
	{
		mCombo += 1;
		EventManager.triggerEvent(EventType.COMBOADDED, {combo: mCombo});
		
		//Highest Combo Yo.
		if (GameDataManager.mHighestCombo < mCombo)
			GameDataManager.mHighestCombo = mCombo;
		
		if (mBonusMap.get(mBonusLevel).combo == mCombo)
		{
			//Let add score, gold, time
			mScore += mBonusMap.get(mBonusLevel).points;
			GameDataManager.addGoldEarned(mBonusMap.get(mBonusLevel).gold);
			GameDataManager.addTime(mBonusMap.get(mBonusLevel).time);
			
			//Time Added ... show it
			EventManager.triggerEvent(EventType.TIMEADDED, {time: mBonusMap.get(mBonusLevel).time});
			EventManager.triggerEvent(EventType.SCOREADDED, {score: mBonusMap.get(mBonusLevel).points});
			
			//Next Level
			mBonusLevel += 1;
		}
	}
	
	public static function resetOnMiss():Void
	{
		ScoreManager.mCombo = 0;
		ScoreManager.mBonusLevel = 1;
	}
	
	public static function parseBonusData(assetFile:String)	
	{
		var gameDataXML = new Fast(Xml.parse(assetFile).firstElement());
		//Let Grab the INFO
		for (data in gameDataXML.nodes.level)
		{
			var level:Int 	= Std.parseInt(data.innerData);
			var combo:Int 	= Std.parseInt(data.att.combo);
			var points:Int 	= Std.parseInt(data.att.points);
			var gold:Int   	= Std.parseInt(data.att.gold);
			var time:Float 	= Std.parseFloat(data.att.time);

			var dataStats:BonusData = new BonusData(combo, points, gold, time);
									
			mBonusMap.set(level, dataStats);
		}
	}
}