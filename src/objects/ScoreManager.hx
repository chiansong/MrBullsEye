package objects;

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
	
	public static function addScore():Void
	{
		mScore += mCombo * mMultipler * mCurrentPoint;
	}
	
	public static function increaseMultipler():Void
	{
		mMultipler += 1;
	}
	
	public static function increaseCombo():Void
	{
		mCombo += 1;
	}
}