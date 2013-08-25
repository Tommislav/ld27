package se.salomonsson.ld27.game.event;

import flash.events.Event;

/**
 * ...
 * @author Tommislav
 */
class EndGameEvent extends Event
{
	public static inline var GAME_ENDED = "gameEnded";

	public function new(type:String) 
	{
		super(type);
	}
	
}