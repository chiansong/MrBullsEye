package objects;
import flixel.FlxSprite;
import openfl.Assets;

/**
 * ...
 * @author Lim Chian Song
 */
class Arrow extends FlxSprite
{

	public function new() 
	{
		super();
		
		loadGraphic(Assets.getBitmapData("assets/character/player.png"), true, false, 32, 8);
	}
	
}