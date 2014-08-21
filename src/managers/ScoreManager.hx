package managers;

/**
 * ...
 * @author CS.Lim
 */
class ScoreManager
{
	public static var mScore:Int;
	public static var mCurrentPoint:Int;
	public static var mCombo:Int;
	public static var mHighestScore:Int;
	public static var mMultipler:Int;
	
	public static function init():Void 
	{
		mScore = 0;
		mHighestScore = 0;
		mMultipler = 1;
		mCombo = 1;
		mCurrentPoint = 1;
	}
	
	public static function instantAddScore(score:Int):Void
	{
		mScore += score;
		GUIManager.mScore.text = Std.string(mScore);
	}
	
	public static function addScore():Void
	{
		mScore += mCombo * mMultipler * mCurrentPoint;
		GUIManager.mScore.text = Std.string(mScore);
	}
	
	public static function increaseMultipler():Void
	{
		mMultipler += 1;
	}
	
	public static function increaseCombo():Void
	{
		mCombo += 1;
		GUIManager.mCombo.text = Std.string(mCombo);
	}
}