package states;
import event.EventType;
import flixel.FlxG;
import managers.DisplayManager;
import managers.EventManager;
import flixel.FlxState;
import managers.ArrowManager;
import managers.BullsEyeManager;
import managers.GUIManager;
import managers.ScoreManager;
import objects.Player;
import utils.KeyBinding;

/////////////////////////*
//..					//
//* @author C.S.LIM		//
//..					//
////////////////////////*/

class PlayState extends FlxState
{
	private static var player:Player;
	public static var mGameLevel:Int = 1;
	
	override public function create():Void
	{
		super.create();
		
		KeyBinding.init();
		EventManager.init();
		ArrowManager.init();
		BullsEyeManager.init();
		DisplayManager.init();
		ScoreManager.init();
		GUIManager.init();
		
		EventManager.triggerEvent(EventType.GAME_INIT);
		
		player = new Player();
		reset();
	}
	
	public static function reset():Void
	{
		player.init();
		player.setPosition(50, FlxG.height / 2 - player.height / 2);
	}

	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update():Void 
	{
		super.update();
		
		EventManager.update();
		KeyBinding.update();
		ArrowManager.update();
		BullsEyeManager.update();
	}
}