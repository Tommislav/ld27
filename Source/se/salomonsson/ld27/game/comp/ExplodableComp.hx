package se.salomonsson.ld27.game.comp;

import se.salomonsson.seagal.core.IComponent;

/**
 * Marker interface for entities that can be killed by bombs
 * @author Tommislav
 */
class ExplodableComp implements IComponent
{
	public var blownUp:Bool;
	public var safe:Bool;

	public function new() {}
	
}