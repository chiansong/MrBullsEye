package objects;

import openfl.Assets;

/**
 * ...
 * @author CS.Lim
 */
class Player extends GameObject
{
	public function new() 
	{
		super();
		
		loadGraphic(Assets.getBitmapData("assets/character/player.png"), true, false, 64, 64);
	}
	
}