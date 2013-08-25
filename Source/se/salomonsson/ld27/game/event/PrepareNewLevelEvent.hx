package se.salomonsson.ld27.game.event;

import flash.events.Event;

/**
 * ...
 * @author Tommislav
 */
class PrepareNewLevelEvent extends Event
{
	public static inline var PREPARE:String = "prepareNewLevel";

	public var levelNum:Int;
	
	public function new(type:String, levelNum:Int) 
	{
		this.levelNum = levelNum;
		super(type);
	}
	
	override public function clone():Event 
	{
		return new PrepareNewLevelEvent(type, this.levelNum);
	}
	
}