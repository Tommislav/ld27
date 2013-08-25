package se.salomonsson.ld27.game.event;

import flash.events.Event;

/**
 * ...
 * @author Tommislav
 */
class InitGameEvent extends Event
{

	public static inline var INIT:String = "INIT GAME";
	public var startLevel:Int;	
	
	public function new(type, startLevel=0) 
	{
		super(type);
		this.startLevel = startLevel;
	}
	
}