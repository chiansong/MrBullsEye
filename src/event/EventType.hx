package event;

/**
 * ...
 * @author CS.Lim
 */
class EventType
{
	//STATE EVENT
	public static inline var GAME_INIT:Int     	= 1000;
	public static inline var GAME_OVER:Int     	= 1001;
	
	//IN-GAME
	public static inline var ARROW_FIRED:Int   	= 2000;
	public static inline var ARROW_MISSED:Int  	= 2001;
	public static inline var OBJECT_MOVE:Int 	= 2101;
	public static inline var OBJECT_HIT:Int  	= 2102;
	public static inline var OBJECT_OUT:Int  	= 2102;
}