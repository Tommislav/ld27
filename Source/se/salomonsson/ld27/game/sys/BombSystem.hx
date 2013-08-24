package se.salomonsson.ld27.game.sys;

import flash.events.Event;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import pgr.gconsole.GameConsole;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class BombSystem extends Sys
{
	private var _touch:TouchComp;
	private var _sys:SystemComp;
	
	private var _lastTick:Int;
	
	private var _tf:TextField;
	
	public function new() 
	{
		super();
		_lastTick = -1;
		
		_tf = new TextField();
		_tf.selectable = false;
		_tf.background = true;
		_tf.autoSize = TextFieldAutoSize.LEFT;
		Lib.current.stage.addChild(_tf);
		
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_touch = em.getComp(TouchComp);
		_sys = em.getComp(SystemComp);
		_sys.timeLeft = 10 * 1000;
		
		addListener(GameEvent.LEVEL_START, onLevelStart);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(GameEvent.LEVEL_START, onLevelStart);
	}
	
	private function onLevelStart(e:GameEvent):Void 
	{
		_sys.timeLeft = 10 * 1000;
	}
	
	override public function tick(gt:GameTime):Void 
	{
		super.tick(gt);
		
		if (!_touch.isTouching) {
			// count down
			
			var now = Lib.getTimer();
			if (_lastTick > -1) {
				var delta = now - _lastTick;
				_sys.timeLeft -= delta;
				
				
				
				if (_sys.timeLeft < 0) {
					// BOOM
					dispatch(new GameEvent(GameEvent.BOMB_EXPLODE));
				}
			}
			
			_lastTick = now;
		} else {
			_lastTick = -1;
		}
		
		_tf.text = ("" + Math.floor(_sys.timeLeft / 1000));
	}
}