package se.salomonsson.ld27.game.sys;

import flash.geom.Point;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SelectableComp;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class UpdateFloorRenderDataSystem extends Sys
{
	private var _level:LevelComp;
	
	public function new() 
	{
		super();
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		addListener(GameEvent.LEVEL_START, onNewLevel);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(GameEvent.LEVEL_START, onNewLevel);
	}
	
	private function onNewLevel(e:GameEvent):Void 
	{
		_level = em().getComp(LevelComp);
	}
	
	override public function tick(gt:GameTime):Void 
	{
		if (_level == null)
			return;
		
		_level.floor.clearAllOverrideValues();
		
		var selectables:Array<SelectableComp> = em().getComponents(SelectableComp);
		for (sel in selectables) {
			if (sel.selectedPath.length > 0) {
				
				var invalidPath:Bool = false;
				var prevPoint:Point = new Point(sel.currentTileX, sel.currentTileY);
				var path:Array<Point> = sel.selectedPath;
				
				for (p in path) {
					var pX:Int = Std.int(p.x);
					var pY:Int = Std.int(p.y);
					
					if (_level.map.atCoord(pX, pY) == 0xFFFFFF) {
						_level.floor.setOverrideValueAtCoord(pX, pY, TileSheetFactory.FLOOR_SELECTED);
					} else { // invalid tile
						
						if (path.length > 1)
							_level.floor.setOverrideValueAtCoord(Std.int(prevPoint.x), Std.int(prevPoint.y), TileSheetFactory.FLOOR_INVALID);
						
						break;
					}
					
					prevPoint = p;
				}
			}
		}
	}
	
}