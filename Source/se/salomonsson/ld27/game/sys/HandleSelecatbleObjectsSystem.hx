package se.salomonsson.ld27.game.sys;

import flash.geom.Point;
import pgr.gconsole.GameConsole;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.PosComp;
import se.salomonsson.ld27.game.comp.SelectableComp;
import se.salomonsson.ld27.game.comp.SpriteComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.seagal.core.EW;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * Listens for clicks and checks if a selectable object was selected.
 * If a selectable object is currently selected and we are dragging the
 * mouse we update the path for that object
 * @author Tommislav
 */
class HandleSelecatbleObjectsSystem extends Sys
{
	private var _touchComp:TouchComp;
	private var _selected:EW;

	public function new() 
	{
		super();
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_touchComp = em.getComp(TouchComp);
	}
	
	override public function tick(gt:GameTime):Void 
	{
		super.tick(gt);
		
		// Array of all selectable objects
		var selectables:Array<EW> = em().getEWC([SelectableComp]);
		if (selectables.length == 0)
			return;
		
		
		
		// update tile-coordinates for all selectable components!
		updateSelectionCoordinates(selectables);
		
		if (_touchComp.isTouching) { // we are clicking
			
			if (_touchComp.touchTick == gt.get_tick()) { // we started clicking this tick, check for new objects to select
				
				_selected = findSelectedSprite(selectables);
				if (_selected != null) {
					_selected.comp(SelectableComp).selectedPath = new Array<Point>(); // reset any paths this guy might have...
					_touchComp.selected = _selected.getEntity();
					
				}
			}
		} else {
			_selected = null;
			_touchComp.selected = 0;
		}
		
		
		
		// only move if not touching!
		
		if (_selected != null) {
			drawPath(); // DRAW PATH!
		}
	}
	
	
	
	function updateSelectionCoordinates(selectables:Array<EW>) 
	{
		for (ent in selectables) {
			var pos:PosComp = ent.comp(PosComp);
			var sel:SelectableComp = ent.comp(SelectableComp);
			sel.currentTileX = (Std.int(pos.x) >> 6);
			sel.currentTileY = (Std.int(pos.y) >> 6);
		}
	}
	
	function findSelectedSprite(selectables:Array<EW>):EW 
	{
		for (ent in selectables) {
			var sel:SelectableComp = ent.comp(SelectableComp);
			if (sel.currentTileX == _touchComp.selectedTileX && sel.currentTileY == _touchComp.selectedTileY) {
				return ent;
			}
		}
		return null;
	}
	
	
	
	function drawPath() 
	{
		var selComp:SelectableComp = _selected.comp(SelectableComp);
		var path:Array<Point> = selComp.selectedPath;
		var lastSelection:Point = (path.length == 0) ? new Point(selComp.currentTileX, selComp.currentTileY) : path[path.length-1];
		
		// Don't add to the path if we're on the same tile, only if we dragged mouse to new tile
		if (_touchComp.selectedTileX != lastSelection.x || _touchComp.selectedTileY != lastSelection.y) {
			path.push(new Point(_touchComp.selectedTileX, _touchComp.selectedTileY));
			GameConsole.log("Path: " + path);
		}
		/*
		var level:LevelComp = em().getComp(LevelComp);
		for (i in 0...path.length) {
			level.map.setOverrideValueAtCoord(Std.int(path[i].x), Std.int(path[i].y), TileSheetFactory.FLOOR_SELECTED);
		}
		*/
	}
}