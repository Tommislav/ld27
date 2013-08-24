package se.salomonsson.ld27.game.sys;

import flash.display.BitmapData;
import openfl.Assets;
import pgr.gconsole.GameConsole;
import se.salomonsson.game.utils.PixelMapParser;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.event.StartNewLevelEvent;
import se.salomonsson.ld27.game.factories.SpriteFactory;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class LevelSystem extends Sys
{

	private var _systemComp:SystemComp;
	private var _levelComp:LevelComp;
	private var _nextLevelCountdown:Int;
	private var _levelRunning:Bool;
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		addListener(StartNewLevelEvent.NEW_LEVEL, onStartNewLevel);
		addListener(GameEvent.LEVEL_EXIT, onExitLevel);
		
		_systemComp = em.getComp(SystemComp);
		_levelComp = em.getComp(LevelComp);
	}
	
	private function onStartNewLevel(e:StartNewLevelEvent):Void 
	{
		_levelRunning = true;
		
		var camera:CameraComp = em().getComp(CameraComp);
		var levelNum:Int = e.currentLevel;
		_levelComp.levelId = levelNum;
		
		// Reset number of players, dead players and exited players
		_systemComp.numPlayers = 0;
		_systemComp.playersDead = 0;
		_systemComp.playersRescued = 0;
		
		
		
		var success:Bool = true;
		
		switch(levelNum) {
			case 1:
				_levelComp.map = new PixelMapParser(Assets.getBitmapData("assets/level1.png"));
				_levelComp.floor = createFloor(_levelComp.map);
				SpriteFactory.bombSprite(em(), 5, 8);
				SpriteFactory.exitSprite(em(), 20, 10);
				SpriteFactory.heroSprite(em(), 6, 8);
				centerCamera(camera, 6, 8);
			
			case 2:
				_levelComp.map = new PixelMapParser(Assets.getBitmapData("assets/level2.png"));
				_levelComp.floor = createFloor(_levelComp.map);
				SpriteFactory.bombSprite(em(), 7, 3);
				SpriteFactory.exitSprite(em(), 14, 17);
				SpriteFactory.exitSprite(em(), 18, 17);
				SpriteFactory.heroSprite(em(), 6, 3);
				SpriteFactory.heroSprite(em(), 8, 3);
				centerCamera(camera, 7, 3);
			
			default:
				success = false;
		}
		
		
		
		
		if (success) {
			dispatch(new GameEvent(GameEvent.LEVEL_START));
		} else {
			throw "Failed to initialize level " + levelNum;
		}
	}
	
	private function onExitLevel(e:GameEvent) {
		SpriteFactory.destroyAllSprites(em());
	}
	
	function createFloor(map:PixelMapParser) 
	{
		var bd:BitmapData = new BitmapData(map.width, map.height, false, TileSheetFactory.FLOOR_REGULAR);
		return new PixelMapParser(bd);
	}
	
	override public function onRemoved():Void 
	{
		removeListener(StartNewLevelEvent.NEW_LEVEL, onStartNewLevel);
		removeListener(GameEvent.LEVEL_EXIT, onExitLevel);
		super.onRemoved();
	}
	
	private function centerCamera(cam:CameraComp, x:Int, y:Int) {
		var sys:SystemComp = em().getComp(SystemComp);
		var pX = x * 64;
		var pY = y * 64;
		
		cam.x = pX - (sys.vpWidth / 2);
		cam.y = pY - (sys.vpHeight / 2);
	}
	
	
	
	
	
	override public function tick(gt:GameTime):Void 
	{
		if (_levelRunning) {
			if (_systemComp.playersRescued == _systemComp.numPlayers) {
				GameConsole.log("Start next level!!");
				
				// Level completed
				dispatch(new GameEvent(GameEvent.LEVEL_EXIT));
				
				_levelRunning = false;
				_nextLevelCountdown = 60;
			}
		} else {
			if (--_nextLevelCountdown <= 0) {
				// start next level (here we'll probably want to show a hint or something)
				var nextLevelId:Int = _levelComp.levelId + 1;
				dispatch(new StartNewLevelEvent(StartNewLevelEvent.NEW_LEVEL, nextLevelId));
			}
		}
		
		
		
		
	}
}