package se.salomonsson.ld27.game.comp;
import se.salomonsson.seagal.core.IComponent;

/**
 * ...
 * @author Tommislav
 */
class TouchComp implements IComponent
{
	public var isTouching:Bool;
	public var touchTick:Int;
	public var touchX:Int;
	public var touchY:Int;
	
	public var startX:Int;
	public var startY:Int;
	
	public var lastX:Int;
	public var lastY:Int;
	
	public var deltaX:Int;
	public var deltaY:Int;
	
	public var selected:Int;
	
	
	public function new() {}
	
}