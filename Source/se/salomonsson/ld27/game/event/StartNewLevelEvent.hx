package se.salomonsson.ld27.game.event;
import flash.events.Event;

/**
 * ...
 * @author Tommislav
 */
class StartNewLevelEvent extends Event
{
	public static inline var NEW_LEVEL = "invokeNewLevel";
	public var currentLevel:Int;
	
	public function new(type:String, currentLevel:Int) 
	{
		super(type);
		this.currentLevel = currentLevel;
	}
	
}