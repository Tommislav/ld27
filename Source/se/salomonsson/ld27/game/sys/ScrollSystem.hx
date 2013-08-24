package se.salomonsson.ld27.game.sys;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class ScrollSystem extends Sys
{
	private var _touch:TouchComp;
	private var _sys:SystemComp;
	private var _cam:CameraComp;
	
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
		
		
		_scrollX = _scrollY = 0;
	}
	
	override public function tick(gt:GameTime):Void 
	{
		super.tick(gt);
		
		if (_touch.selected == 0) {
			if (_touch.isTouching) {
				_scrollX = -_touch.deltaX;
				_scrollY = -_touch.deltaY;
			} else {
				if (_scrollX < -0.01 && _scrollX > 0.01)
					_scrollX *= 0.7;
					
				if (_scrollY < -0.01 && _scrollY > 0.01)
					_scrollY *= 0.7;
			}
			
			_cam.x += _scrollX;
			_cam.y += _scrollY;
		}
		
	}
	
}