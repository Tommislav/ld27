package se.salomonsson.ld27.game.sys;

import flash.geom.Point;
import se.salomonsson.ld27.game.comp.ExplodableComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.PosComp;
import se.salomonsson.ld27.game.comp.RescuableComponent;
import se.salomonsson.ld27.game.comp.SelectableComp;
import se.salomonsson.ld27.game.comp.SpriteComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.seagal.core.EW;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * Kills all objects marked as Explodables
 * @author Tommislav
 */
class UpdateExplodablesSystem extends Sys
{

	private var _level:LevelComp;
	private var _systemComp:SystemComp;
	
	public function new() { super(); }
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		
		_level = em.getComp(LevelComp);
		_systemComp = em.getComp(SystemComp);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
	}
	
	override public function tick(gt:GameTime):Void 
	{
		if (_systemComp.bombHasExploded) {
			var explodables:Array<EW> = em().getEWC([ExplodableComp, PosComp]);
			
			for (explodable in explodables) {
				var exComp:ExplodableComp = explodable.comp(ExplodableComp);
				if (!exComp.blownUp && !exComp.safe) { // alive and NOT safe yet
					var pos:PosComp = explodable.comp(PosComp);
					var tX:Int = Math.floor((pos.x + pos.width / 2) / 64);
					var tY:Int = Math.floor((pos.y + pos.height / 2) / 64);
					
					var tile:Int = _level.map.atCoord(tX, tY);
					if (tile == 1) {
						// bye bye
						exComp.blownUp = true;
						killEntityInAllPossibleWays(explodable);
					}
				}
			}
		}
	}
	
	function killEntityInAllPossibleWays(ew:EW) 
	{
		if (ew.hasComponent(SelectableComp)) {
			var sel:SelectableComp = ew.comp(SelectableComp);
			sel.isSelectable = false;
			sel.selectedPath = new Array<Point>();
			sel.moveToX = -1;
			sel.moveToY = -1;
		}
		
		if (ew.hasComponent(SpriteComp)) {
			ew.comp(SpriteComp).setCurrentState("dead");
		}
		
		if (ew.hasComponent(RescuableComponent)) {
			_systemComp.playersDead++;
		}
	}
}