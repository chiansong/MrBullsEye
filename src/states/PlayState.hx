package states;
import event.EventManager;
import flixel.FlxState;
import objects.ArrowManager;
import utils.KeyBinding;

/////////////////////////*
//..					//
//* @author C.S.LIM		//
//..					//
////////////////////////*/

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		
		EventManager.init();
		ArrowManager.init();
		KeyBinding.init();
	}
	
	public static function reset():Void
	{
		
	}

	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update():Void 
	{
		super.update();
		
		KeyBinding.update();
	}
}