package managers;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import utils.DisplayLayers;

/**
 * ...
 * @author Lim Chian Song
 */
class GUIManager
{
	public static var mGUIGroup:FlxGroup;
	public static var mScore:FlxText;
	public static var mNumberOfArrowLeft:FlxText;
	public static var mCombo:FlxText;
	
	public static function init():Void
	{
		mGUIGroup = new FlxGroup();
		
		mScore = new FlxText(FlxG.width / 2, 15, 100, 24);
		mScore.text = "0";
		mGUIGroup.add(mScore);
		
		mNumberOfArrowLeft = new FlxText(10, 15, 100, 24);
		mNumberOfArrowLeft.text = Std.string(ArrowManager.getMaxArrow());
		mGUIGroup.add(mNumberOfArrowLeft);
		
		mCombo = new FlxText(FlxG.width - 20, 10, 100, 24);
		mCombo.text = Std.string(ScoreManager.mCombo);
		mGUIGroup.add(mCombo);
		
		DisplayManager.addToLayer(mGUIGroup, DisplayLayers.GUILAYER.getIndex());
	}
	
	public function update():Void
	{
	
	}
	
}