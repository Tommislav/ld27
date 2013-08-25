package se.salomonsson.ld27.game.event;
import flash.events.Event;

/**
 * ...
 * @author Tommislav
 */
class GameEvent extends Event
{
	public static inline var LEVEL_START = "levelstart";
	public static inline var LEVEL_EXIT = "levelexit";
	public static inline var BOMB_EXPLODE = "bombexplode";
	public static inline var GAME_OVER = "gameover";
	
	public static inline var HERO_REACHED_EXIT = "heroReachedExit";
	public static inline var HERO_DIED = "heroDied";
	
	
	public function new(type:String) 
	{
		super(type);
	}
	
}