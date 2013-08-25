package se.salomonsson.ld27.game;

/**
 * ...
 * @author Tommislav
 */
class FloodFillNode
{
	public var initialized:Bool;
	
	//public var N:FloodFillNode;
	//public var W:FloodFillNode;
	//public var S:FloodFillNode;
	//public var E:FloodFillNode;
	
	public var filled:Bool;
	public var isFinal:Bool;
	
	public var x:Int;
	public var y:Int;
	
	public function new(x:Int, y:Int) {
		this.x = x;
		this.y = y;
	}
	
}