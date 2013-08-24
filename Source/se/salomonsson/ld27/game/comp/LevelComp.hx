package se.salomonsson.ld27.game.comp;
import se.salomonsson.game.utils.PixelMapParser;
import se.salomonsson.seagal.core.IComponent;

/**
 * ...
 * @author Tommislav
 */
class LevelComp implements IComponent
{
	public var levelId:Int;
	public var map:PixelMapParser;
	public var floor:PixelMapParser;

	public function new() {}
}