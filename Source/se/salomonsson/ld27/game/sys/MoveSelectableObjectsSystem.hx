package se.salomonsson.ld27.game.sys;

import flash.geom.Point;
import pgr.gconsole.GameConsole;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.PosComp;
import se.salomonsson.ld27.game.comp.SelectableComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.seagal.core.EW;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class MoveSelectableObjectsSystem extends Sys
{

	private var _touch:TouchComp;
	
	public function new() 
	{
		super();
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_touch = em.getComp(TouchComp);
	}
	
	override public function tick(gt:GameTime):Void 
	{
		if (_touch.isTouching) {
			return;
		}
		
		var selectableObjects:Array<EW> = em().getEWC([SelectableComp, PosComp]);
		for (ew in selectableObjects) {
			var sel:SelectableComp = ew.comp(SelectableComp);
			
			var isMoving:Bool = (sel.moveToX > -1 && sel.moveToY > -1);
			if (isMoving || sel.selectedPath.length > 0) {
				
				var pos:PosComp = ew.comp(PosComp);
				
				if (!isMoving) { // remove first tile in path and set it as target
					var p:Point = sel.selectedPath.shift();
					if (validTile(p)) {
						sel.moveToX = p.x * 64;
						sel.moveToY = p.y * 64;
						isMoving = true;
					}
				}
				
				if (isMoving) {
					var currX = pos.x;
					var currY = pos.y;
					
					var speed = 2;
					
					var dX = (sel.moveToX - currX);
					var dY = (sel.moveToY - currY);
					var sX = 0;
					var sY = 0;
					
					if (dX != 0)
						sX = (dX > 0) ? speed : -speed;
						
					if (dY != 0)
						sY = (dY > 0) ? speed : -speed;
					
					
					pos.x += sX;
					pos.y += sY;
					
					if (pos.x == sel.moveToX && pos.y == sel.moveToY) {	// reached a node
						sel.moveToX = sel.moveToY = -1;
					}
				}
			}
			
			
		}
	}
	
	function validTile(p:Point) 
	{
		var lvl:LevelComp = em().getComp(LevelComp);
		return (lvl.map.atCoord(Std.int(p.x), Std.int(p.y)) == 0xFFFFFF);
	}
	
	
	
}