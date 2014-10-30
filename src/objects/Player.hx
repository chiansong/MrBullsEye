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
		loadGraphic(Assets.getBitmapData("character/player.png"), true, false, 80, 80);
		animation.add("idle", [0, 1, 2, 3], 6, true);
		animation.add("shoot", [7, 8, 9, 10, 11, 12, 13], 12, false);
		animation.callback = animationCallback;
	}

	override public function init()
	{
		DisplayManager.addToLayer(this, DisplayLayers.OBJECT1LAYER.getIndex());
		animation.play("idle");
	}
	
	private function animationCallback(name:String, frameNum:Int, frameIndex:Int):Void
	{
		if (name == "shoot" && animation.finished)
		{
			animation.play("idle");
		}
	}
	
	override public function update()
	{
		super.update();
		
		//Let not care about anything. the game is over.
		if (GameObjectManager.mGameOver)
		{
			animation.pause();
			return;
		}
		
		if (!GameObjectManager.mCanStart)
		{
			return;
		}
		
		//Shoot it.
		if (KeyBinding.justPressed["click"]())
		{
			EventManager.triggerEvent(EventType.ARROW_FIRED);
			animation.play("shoot");
		}
	}
}