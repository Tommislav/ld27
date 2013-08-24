package se.salomonsson.ld27.game.comp;
import se.salomonsson.seagal.core.IComponent;

/**
 * Sprite object
 * @author Tommislav
 */
class SpriteComp implements IComponent
{
	public var x:Float;
	public var y:Float;
	public var renderOffX:Float;
	public var renderOffY:Float;
	
	public var states:Map < String, Array<Int> > ;
	public var currentFrame:Int;
	public var currentState:String;
	
	public function new() {
		x = y = renderOffX = renderOffY = 0;
		states = new Map < String, Array<Int> > ();
	}
	
	public function addState(name:String, tileIndexes:Array<Int>) {
		states.set(name, tileIndexes);
		if (currentState == "")
			setCurrentState(name);
	}
	
	public function setCurrentState(name:String) {
		currentState = name;
		currentFrame = 0;
	}
	
	public function getCurrentFrame():Float {
		return states[currentState][currentFrame];
	}
	
	public function getNumFrames():Int {
		return states.get(currentState).length;
	}
	
}