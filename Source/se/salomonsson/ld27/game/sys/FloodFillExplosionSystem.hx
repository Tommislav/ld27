package se.salomonsson.ld27.game.sys;

import se.salomonsson.ld27.game.comp.BombComponent;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.PosComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.FloodFillNode;
import se.salomonsson.seagal.core.EW;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;
import se.salomonsson.seagal.debug.SLogger;

/**
 * ...
 * @author Tommislav
 */
class FloodFillExplosionSystem extends Sys
{
	private static inline var FLOOD_FILL_DELAY = 10;
	
	private var _active:Bool;
	private var _level:LevelComp;
	private var _touch:TouchComp;
	private var _cnt:Int;
	private var _nodeGrid:Array<Array<FloodFillNode>>;
	private var _currentNodes:Array<FloodFillNode>;
	
	
	public function new() { super(); }

	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		addListener(GameEvent.LEVEL_START, onStart);
		addListener(GameEvent.LEVEL_EXIT, onExit);
		addListener(GameEvent.BOMB_EXPLODE, onExplode);
		
		_level = em.getComp(LevelComp);
		_touch = em.getComp(TouchComp);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(GameEvent.LEVEL_START, onStart);
		removeListener(GameEvent.LEVEL_EXIT, onExit);
		removeListener(GameEvent.BOMB_EXPLODE, onExplode);
	}
	
	private function onStart(e:GameEvent):Void 
	{
		_active = false;
	}
	
	private function onExit(e:GameEvent):Void 
	{
		_active = false;
	}
	
	private function onExplode(e:GameEvent):Void 
	{
		_active = true;
		
		if (_level.map == null)
			return;
		
		// Init bloom lookup array
		var w = _level.map.width;
		var h = _level.map.height;
		
		_nodeGrid = new Array<Array<FloodFillNode>>();
		for (y in 0...h) {
			_nodeGrid[y] = new Array<FloodFillNode>();
			for (x in 0...w) {
				_nodeGrid[y][x] = new FloodFillNode(x, y);
	
			}
		}
		
		_currentNodes = new Array<FloodFillNode>();
		_cnt = FLOOD_FILL_DELAY;
		
		var bombs:Array<EW> = em().getEWC([BombComponent]);
		for (b in bombs) {
			var pos:PosComp = b.comp(PosComp);
			addNode(Std.int(pos.x / 64), Std.int(pos.y / 64), _currentNodes);
			b.destroy();
		}
	}
	
	override public function tick(gt:GameTime):Void 
	{
		if (_active && !_touch.isTouching) {
			if (_cnt-- <= 0) {
				_cnt = FLOOD_FILL_DELAY;
				
				if (_currentNodes.length == 0) {
					SLogger.log(this, "Flood Fill Complete!");
					_active = false;
					return;
				}
				
				// bloom
				var newNodes:Array<FloodFillNode> = new Array<FloodFillNode>();
				
				for (node in _currentNodes) {
					addNode(node.x, node.y - 1, newNodes);
					addNode(node.x, node.y + 1, newNodes);
					addNode(node.x - 1, node.y, newNodes);
					addNode(node.x + 1, node.y, newNodes);
				}
				
				_currentNodes = newNodes;
			}
		}
	}
	
	private function addNode(x:Int, y:Int, addTo:Array<FloodFillNode>) {
		
		var node:FloodFillNode = getNode(x,y);
		
		if (node != null) {
			
			floodNode(node);
			addTo.push(node);
		}
	}
	
	private function getNode(x:Int, y:Int) {
		
		var node:FloodFillNode = _nodeGrid[y][x];
		
		if (isValidCoordinate(x, y)) {
			return node;
		}
		return null;
	}
	
	private function floodNode(n:FloodFillNode) {
		if (n != null) {
			if (!n.filled) {
				n.filled = true;
				_level.map.setOverrideValueAtCoord(n.x, n.y, 1);
			}
		}
	}
	
	private function isValidCoordinate(x:Int, y:Int) 
	{
		return (_level.map.atCoord(x, y) == 0xffffff);
	}
}