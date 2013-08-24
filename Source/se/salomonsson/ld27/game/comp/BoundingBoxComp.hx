package se.salomonsson.ld27.game.comp;

import flash.geom.Rectangle;
import se.salomonsson.seagal.core.IComponent;

/**
 * ...
 * @author Tommislav
 */
class BoundingBoxComp implements IComponent
{
	public var bb:Rectangle;
	
	
	public function new() 
	{
		bb = new Rectangle();
	}
	
}