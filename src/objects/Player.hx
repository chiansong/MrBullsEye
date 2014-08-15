package objects;

import openfl.Assets;

/**
 * ...
 * @author CS.Lim
 */
class Player extends GameObject
{
	//Create the main player with controls of arrow
	public function new() 
	{
		super();
		loadGraphic(Assets.getBitmapData("assets/character/player.png"), true, false, 64, 64);
	}
	
	override public function update()
	{
		super.update();
		
	}
}