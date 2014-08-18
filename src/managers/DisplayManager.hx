package managers;
import flixel.FlxBasic;
import flixel.FlxObject;
import managers.EventManager;
import flixel.FlxG;
import flixel.group.FlxGroup;
import utils.DisplayLayers;

/**
 * ...
 * @author Lim Chian Song
 */
 
class DisplayManager
{	
	public static var mDisplayLayers:Array<FlxGroup>;
	
	/**
	 * Init the Display Manager.
	 */
	public static function init():Void
	{
		mDisplayLayers = new Array<FlxGroup>();
		for (i in 0 ... DisplayLayers.TOTALNUMBEROFLAYERS.getIndex())
		{
			var group = new FlxGroup();
			mDisplayLayers.push(group);
			FlxG.state.add(group);
		}
	}
	
	/**
	 * Add object to the layer
	 * @param	object - the object itself
	 * @param	layer - the layer
	 */
	public static function addToLayer(object:FlxBasic, layer:Int):Void
	{
		mDisplayLayers[layer].add(object);
	}
	
	/**
	 * Hide the chosen layer
	 * @param	layer
	 */
	public static function hideLayer(layer:Int):Void
	{
		mDisplayLayers[layer].visible = false;
	}
	
	/**
	 * Show the chosen layer
	 * @param	layer
	 */
	public static function showLayer(layer:Int):Void
	{
		mDisplayLayers[layer].visible = true;
	}
}