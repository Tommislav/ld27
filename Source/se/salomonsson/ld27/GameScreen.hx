package se.salomonsson.ld27;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.Assets;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.ld27.game.event.InitGameEvent;
import se.salomonsson.ld27.game.event.StartNewLevelEvent;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.ld27.game.sys.BombSystem;
import se.salomonsson.ld27.game.sys.FloodFillExplosionSystem;
import se.salomonsson.ld27.game.sys.HandleSelecatbleObjectsSystem;
import se.salomonsson.ld27.game.sys.LD27RenderSystem;
import se.salomonsson.ld27.game.sys.LevelSystem;
import se.salomonsson.ld27.game.sys.MoveSelectableObjectsSystem;
import se.salomonsson.ld27.game.sys.ScreenSystem;
import se.salomonsson.ld27.game.sys.ScrollSystem;
import se.salomonsson.ld27.game.sys.SoundSys;
import se.salomonsson.ld27.game.sys.TouchSystem;
import se.salomonsson.ld27.game.sys.UpdateExplodablesSystem;
import se.salomonsson.ld27.game.sys.UpdateExplodablesSystem;
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
			.addComponent(getLevelComponentWithTileSheet());
		
		
		_core.addSystem(new TouchSystem(), 5);
		
		_core.addSystem(new BombSystem(), 4);
		_core.addSystem(new LevelSystem(), 4);
		_core.addSystem(new HandleSelecatbleObjectsSystem(), 4);
		
		_core.addSystem(new MoveSelectableObjectsSystem(), 3);
		_core.addSystem(new FloodFillExplosionSystem(), 3);
		_core.addSystem(new SoundSys(), 3);
		
		_core.addSystem(new ScrollSystem(), 2);
		_core.addSystem(new UpdateFloorRenderDataSystem(), 2);
		_core.addSystem(new UpdateExplodablesSystem(), 2);
		
		_core.addSystem(new ScreenSystem(graphics), 1);
		_core.addSystem(new LD27RenderSystem(graphics), 1);
		
		
		_core.dispatch(new InitGameEvent(InitGameEvent.INIT, 1));
		
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
	
	private function getLevelComponentWithTileSheet() {
		var lvl:LevelComp = new LevelComp();
		lvl.sheet = TileSheetFactory.buildTileSheet(Assets.getBitmapData("assets/spritesheet.png"));
		return lvl;
	}
	
	private function onEF(e:Event):Void 
	{
		_core.tick();
	}
	
}