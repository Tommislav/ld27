package se.salomonsson.ld27.game.comp;
import se.salomonsson.seagal.core.IComponent;

/**
 * ...
 * @author Tommislav
 */
class PosComp implements IComponent
{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	
	public function new() 
	{
		x = y = width = height = 0;
	}
	
}