package utils;

/**
 * ...
 * @author Lim Chian Song
 */
class ObjectPool<T>
{
	private var mPool:Array<T>;
	private var mCurrentIndex:Int;
	private var mNewItemFunction:Void->T;
	
	public function getPoolArray():Array<T>
	{
		return mPool;
	}
	
	public function new (size:Int, itemFunction:Void -> T)
	{
		mNewItemFunction = itemFunction;
		
		mCurrentIndex = 0;
		mPool = new Array<T>();
		for (i in 0 ... size)
		{
			var item = mNewItemFunction();
			mPool.push(item);
		}
	}
	
	public function get():T
	{
		var obj = mPool[mCurrentIndex];
		++mCurrentIndex;
		mCurrentIndex %= mPool.length;
		
		return obj;
	}
}