package se.salomonsson.ld27.game.comp;

import flash.geom.Point;
import se.salomonsson.seagal.core.IComponent;

/**
 * ...
 * @author Tommislav
 */
class SelectableComp implements IComponent
{

	public var isSelectable:Bool;
	public var currentTileX:Int;
	public var currentTileY:Int;
	public var selectedPath:Array<Point>;
	public var moveToX:Float;
	public var moveToY:Float;
	
	public function new() 
	{
		isSelectable = true;
		selectedPath = new Array<Point>();
		moveToX = -1;
		moveToY = -1;
	}
}