package event;

/**
 * ...
 * @author CS.Lim
 */
class EventType
{
	//STATE EVENT
	public static inline var FIRST_INIT:Int		= 0001;
	public static inline var GAME_INIT:Int     	= 1000;
	public static inline var GAME_OVER:Int     	= 1001;
	
	//IN-GAME
	//ARROW
	public static inline var ARROW_FIRED:Int   	= 2000;
	public static inline var ARROW_MISSED:Int  	= 2001;
	public static inline var ARROW_OUT:Int  	= 2002;
	
	//OBJECT
	public static inline var OBJECT_MOVE:Int 	= 2101;
	public static inline var OBJECT_HIT:Int  	= 2102;
	public static inline var OBJECT_OUT:Int  	= 2103;
	public static inline var SPEED_UP:Int		= 2104;
	//GAME OBJECT
	public static inline var BULLSEYE_HIT:Int	= 2150;
	public static inline var APPLE_HIT:Int		= 2151;
	public static inline var GOLDBAG_HIT:Int	= 2152;
	//SHOP STUFF
	public static inline var ENTER_SHOP:Int		= 2205;
	public static inline var LEAVE_SHOP:Int		= 2206;
}