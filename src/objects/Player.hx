package objects;

import event.EventManager;
import event.EventType;
import openfl.Assets;
import utils.KeyBinding;

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
		
		if (KeyBinding.pressed["click"]())
		{
			EventManager.triggerEvent(EventType.ARROW_FIRED,[_x:x, _y:y]);
		}
	}
}