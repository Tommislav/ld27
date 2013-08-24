package se.salomonsson.ld27.game.comp;
import pgr.gconsole.GameConsole;
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
	public var autoLoop:Bool;
	
	public var states:Map < String, Array<Int> > ;
	public var currentFrame:Int;
	public var currentState:String;
	
	public function new() {
		x = y = renderOffX = renderOffY = 0;
		states = new Map < String, Array<Int> > ();
		currentState = "";
	}
	
	public function addState(name:String, tileIndexes:Array<Int>) {
		this.states.set(name, tileIndexes);
		if (currentState == "")
			setCurrentState(name);
	}
	
	public function setCurrentState(name:String) {
		currentState = name;
		currentFrame = 0;
	}
	
	public function getCurrentFrame():Float {
		
		if (!this.states.exists(currentState)) {
			throw "Animation state'" + currentState + "' does not exist";
		}
		
		var tiles:Array<Int> = states.get(currentState);
		var frame:Int = tiles[currentFrame];
		
		if (autoLoop) {
			currentFrame++;
			if (currentFrame > tiles.length-1)
				currentFrame = 0;
		}
		
		return frame;
	}
	
	public function getNumFrames():Int {
		return states.get(currentState).length;
	}
	
}