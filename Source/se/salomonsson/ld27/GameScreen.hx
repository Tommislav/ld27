package se.salomonsson.ld27;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.ld27.game.sys.HandleSelecatbleObjectsSystem;
import se.salomonsson.ld27.game.sys.LD27RenderSystem;
import se.salomonsson.ld27.game.sys.LevelSystem;
import se.salomonsson.ld27.game.sys.MoveSelectableObjectsSystem;
import se.salomonsson.ld27.game.sys.ScrollSystem;
import se.salomonsson.ld27.game.sys.TouchSystem;
import se.salomonsson.ld27.game.sys.UpdateFloorRenderDataSystem;
import se.salomonsson.seagal.core.Core;

/**
 * Main game screen. Sets up the game and all dependencies
 * @author Tommislav
 */
class GameScreen extends Sprite
{
	private var _core:Core;
	
	public function new() 
	{
		super();
		setup();
	}
	
	function setup() 
	{
		_core = new Core();
		_core.getEntManager().allocateEntity()
			.addComponent(getSystemComp())
			.addComponent(new TouchComp())
			.addComponent(new CameraComp())
			.addComponent(new LevelComp());
		
		
		_core.addSystem(new TouchSystem(), 5);
		
		_core.addSystem(new LevelSystem(), 4);
		_core.addSystem(new HandleSelecatbleObjectsSystem(), 4);
		
		_core.addSystem(new MoveSelectableObjectsSystem(), 3);
		
		_core.addSystem(new ScrollSystem(), 2);
		_core.addSystem(new UpdateFloorRenderDataSystem(), 2);
		
		_core.addSystem(new LD27RenderSystem(graphics), 1);
		
		addEventListener(Event.ENTER_FRAME, onEF);
	}
	
	private function getSystemComp() {
		var sys:SystemComp = new SystemComp();
		sys.vpWidth = Lib.current.stage.stageWidth;
		sys.vpHeight = Lib.current.stage.stageHeight;
		sys.tileW = Math.ceil(sys.vpWidth / 64) + 1;
		sys.tileH = Math.ceil(sys.vpHeight / 64) + 1;
		return sys;
	}
	
	private function onEF(e:Event):Void 
	{
		_core.tick();
	}
	
}