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
		mCombo = 0;
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
		InGameGUIManager.mScore.text = Std.string(mScore);
	}
	
	public static function increaseMultipler():Void
	{
		mMultipler += 1;
	}
	
	public static function increaseCombo():Void
	{
		mCombo += 1;
		
		if (GameDataManager.mHighestCombo < mCombo)
			GameDataManager.mHighestCombo = mCombo;
		
		//Check the combo ...
		//Add Gold ... Add Bonus Score & Gold ... might move to XML style
		switch(mCombo)
		{
			case 5:
				mScore += 10;
				GameDataManager.addGoldEarned(10);
			case 10:
				mScore += 20;
				GameDataManager.addGoldEarned(20);
			case 25:
				mScore += 50;
				GameDataManager.addGoldEarned(50);
		}
	}
}