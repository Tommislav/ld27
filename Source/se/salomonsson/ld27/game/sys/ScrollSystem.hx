package se.salomonsson.ld27.game.sys;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.ld27.Stage;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class ScrollSystem extends Sys
{
	private static inline var  FRICTION = 0.97;
	
	private var _touch:TouchComp;
	private var _sys:SystemComp;
	private var _cam:CameraComp;
	private var _level:LevelComp;
	
	private var _scrollX:Float;
	private var _scrollY:Float;
	
	
	public function new() 
	{
		super();
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_touch = em.getComp(TouchComp);
		_sys = em.getComp(SystemComp);
		_cam = em.getComp(CameraComp);
		_level = em.getComp(LevelComp);
		
		_scrollX = _scrollY = 0.0;
	}
	
	override public function tick(gt:GameTime):Void 
	{
		super.tick(gt);
		
		if (_touch.selected == 0) {
			if (_touch.isTouching) {
				_scrollX = -_touch.deltaX;
				_scrollY = -_touch.deltaY;
			} else {
				_scrollX *= FRICTION;
				_scrollY *= FRICTION;
				
				if (_scrollX > -0.001 && _scrollX < 0.001)
					_scrollX = 0;
					
				if (_scrollY > -0.001 && _scrollY < 0.001)
					_scrollY = 0;
			}
			
			if (_scrollX != 0 || _scrollY != 0) {
				var maxX = (_level.map.width * 64  * Stage.stageScale - _sys.vpWidth);
				var maxY = (_level.map.height * 64  * Stage.stageScale - _sys.vpHeight);
				
				_cam.x = clamp(_cam.x + _scrollX, 0, maxX);
				_cam.y = clamp(_cam.y + _scrollY, 0, maxY);
			}			
		}
		
	}
	
	private function clamp(val:Float, min:Float, max:Float):Float {
		if (val < min)
			return min;
		else if (val > max)
			return max;
		
		return val;
	}
	
}