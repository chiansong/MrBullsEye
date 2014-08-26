package states;
import event.EventType;
import flixel.FlxG;
import flixel.FlxSubState;
import managers.DisplayManager;
import managers.EventManager;
import flixel.FlxState;
import managers.ArrowManager;
import managers.GameDataManager;
import managers.GameObjectManager;
import managers.InGameGUIManager;
import managers.ScoreManager;
import managers.ShopManager;
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
	private static var mShopState:ShopState;
	
	override public function create():Void
	{
		super.create();
	
		KeyBinding.init();
		EventManager.init();
		ArrowManager.init();
		GameObjectManager.init();
		DisplayManager.init();
		ScoreManager.init();
		InGameGUIManager.init();
		GameDataManager.init();
		
		EventManager.triggerEvent(EventType.GAME_INIT);
		EventManager.subscrible(EventType.ENTER_SHOP, onEnterShop);

		mShopState = new ShopState();
		mShopState.close();
		player = new Player();
		reset();
	}
	
	public function onEnterShop(evt:Int, params:Dynamic):Void
	{
		openSubState(mShopState);
	}
	
	public function reset():Void
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
		GameObjectManager.update();
	}
}