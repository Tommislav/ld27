package se.salomonsson.ld27.game.sys;

import flash.display.BitmapData;
import flash.geom.Point;
import pgr.gconsole.GameConsole;
import se.salomonsson.game.utils.PixelMapParser;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SelectableComp;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class UpdateFloorRenderDataSystem extends Sys
{
	private var _currentLevel:Int;
	
	public function new() 
	{
		super();
		_currentLevel = -1;
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var level:LevelComp = em().getComp(LevelComp);
		if (_currentLevel != level.levelId) {
			// setup
			_currentLevel = level.levelId;
			var bd:BitmapData = new BitmapData(level.map.width, level.map.height, false, TileSheetFactory.FLOOR_REGULAR);
			var floorMap:PixelMapParser = new PixelMapParser(bd);
			level.floor = floorMap;
		}
		
		level.floor.clearAllOverrideValues();
		
		var selectables:Array<SelectableComp> = em().getComponents(SelectableComp);
		for (sel in selectables) {
			if (sel.selectedPath.length > 0) {
				
				var invalidPath:Bool = false;
				var prevPoint:Point = new Point(sel.currentTileX, sel.currentTileY);
				var path:Array<Point> = sel.selectedPath;
				
				for (p in path) {
					var pX:Int = Std.int(p.x);
					var pY:Int = Std.int(p.y);
					
					
					if (level.map.atCoord(pX, pY) == 0xFFFFFF) {
						level.floor.setOverrideValueAtCoord(pX, pY, TileSheetFactory.FLOOR_SELECTED);
					} else {
						level.floor.setOverrideValueAtCoord(Std.int(prevPoint.x), Std.int(prevPoint.y), TileSheetFactory.FLOOR_INVALID);
						break;
					}
					
					prevPoint = p;
				}
			}
		}
	}
	
}