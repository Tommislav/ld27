package se.salomonsson.ld27.game.sys;
import flash.display.Stage;
import flash.events.MouseEvent;
import flash.Lib;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class TouchSystem extends Sys
{
	private var _stage:Stage;
	private var _tX:Int;
	private var _tY:Int;
	private var _down:Bool;
	private var _touchData:TouchComp;
	
	private var _cam:CameraComp;
	
	override public function tick(gt:GameTime):Void 
	{
		if (_down && !_touchData.isTouching)
			_touchData.touchTick = gt.get_tick();
		
		_touchData.isTouching = _down;
		if (_down) {
			
			var lastX = _touchData.touchX;
			var lastY = _touchData.touchY;
			var wasPressedThisTick = _touchData.touchTick == gt.get_tick();
			
			if (wasPressedThisTick) {
				_touchData.startX = _touchData.lastX = _tX;
				_touchData.startY = _touchData.lastY = _tY;
			} else {
				_touchData.lastX = _touchData.touchX;
				_touchData.lastY = _touchData.touchY;
			}
			
			_touchData.touchX = _tX;
			_touchData.touchY = _tY;
			
			_touchData.selectedTileX = Std.int(_tX + _cam.x) >> 6;
			_touchData.selectedTileY = Std.int(_tY + _cam.y) >> 6;
			
			//GameConsole.log("Touched tile: " + _touchData.selectedTileX + "," + _touchData.selectedTileY);
			
			_touchData.deltaX = (_touchData.touchX - _touchData.lastX);
			_touchData.deltaY = (_touchData.touchY - _touchData.lastY);
		}
		
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_touchData = em.getComp(TouchComp);
		_cam = em.getComp(CameraComp);
		
		_stage = Lib.current.stage;
		_stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		_stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		_stage.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
		_stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
	}
	
	private function onDown(e:MouseEvent):Void 
	{
		_down = true;
		onMove(e);
	}
	
	private function onUp(e:MouseEvent):Void 
	{
		_down = false;
	}
	
	private function onMove(e:MouseEvent):Void 
	{
		if (_down) {
			_tX = Math.round(e.localX);
			_tY = Math.round(e.localY);
		}
	}
	
}