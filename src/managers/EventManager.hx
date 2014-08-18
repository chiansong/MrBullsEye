package managers;
import event.Event;

/**
 * ...
 * @author CS.Lim
 */
class EventManager
{
	public static var mEvents:Array<Event> = null;
	public static var mEventToSubscribers:Map < Int, Array < Int->Dynamic->Void >> = null;
	
	public static function init():Void
	{
		mEvents = new Array();
		mEventToSubscribers = new Map < Int , Array < Int->Dynamic->Void >> ();
	}
	
	public static function subscrible(eventType:Int, subscriber:Int->Dynamic->Void):Void
	{
		var subscribers = mEventToSubscribers.get(eventType);
		if (subscribers == null)
		{
			mEventToSubscribers.set(eventType, new Array < Int->Dynamic->Void > ());
			subscribers = mEventToSubscribers.get(eventType);
		}
		
		// only add subscriber that hasn't subscribed to eventType
		if (subscribers.indexOf(subscriber) < 0)
			subscribers.push(subscriber);
	}
	
	public static function unsubscribe(eventType:Int, subscriber:Int->Dynamic->Void):Void
	{
		var subscribers = mEventToSubscribers.get(eventType);
		if (subscribers != null)
		{
			var index = subscribers.indexOf(subscriber);
			if (index > -1)
				subscribers.splice(index, 1);
		}
	}
	
	public static function triggerEvent(eventType:Int, ?params:Dynamic):Void
	{
		var evt:Event = new Event();
		evt.eventType = eventType;
		evt.params = params;
		mEvents.push(evt);
	}
	
	public static function reset():Void
	{
		// remove all events
		mEvents.splice(0, mEvents.length);
		// remove all subscribers
		for (key in mEventToSubscribers.keys())
			mEventToSubscribers.remove(key);
	}
	
	// we notify subscribers of all triggered events here
	public static function update():Void
	{
		var len:Int = 0;
		do
		{
			len = mEvents.length;
			for (i in 0 ... len)
			{
				var evt:Event = mEvents[i];
				var subscribers = mEventToSubscribers.get(evt.eventType);
				if (subscribers == null || subscribers.length == 0)
					continue;
				for (subscriber in subscribers)
				{
					subscriber(evt.eventType, evt.params);
				}
			}
			// empty event list
			mEvents.splice(0, len);
		} while (len != 0);
	}
	
}