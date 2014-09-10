package objects;

import managers.DisplayManager;
import managers.EventManager;
import event.EventType;
import managers.GameObjectManager;
import openfl.Assets;
import utils.DisplayLayers;
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
		loadGraphic(Assets.getBitmapData("character/player.png"), true, false, 64, 64);
	}
	
	override public function init()
	{
		DisplayManager.addToLayer(this, DisplayLayers.OBJECT1LAYER.getIndex());
	}
	
	override public function update()
	{
		super.update();
		
		if (GameObjectManager.mGameOver)
			return;
		
		if (KeyBinding.justPressed["click"]())
		{
			EventManager.triggerEvent(EventType.ARROW_FIRED);
		}
	}
}