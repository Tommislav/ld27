package se.salomonsson.ld27.game.comp;
import se.salomonsson.seagal.core.IComponent;

/**
 * ...
 * @author Tommislav
 */
class SpriteCollisionComponent implements IComponent
{
	public static inline var SOLID = 1;
	public static inline var EXIT = 2;
	

	public var type:Int;
	
	public function new(collisionType:Int) {
		this.type = collisionType;
	}
	
}