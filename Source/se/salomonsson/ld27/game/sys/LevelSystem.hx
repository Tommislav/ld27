package se.salomonsson.ld27.game.sys;

import flash.display.BitmapData;
import openfl.Assets;
import se.salomonsson.game.utils.PixelMapParser;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.event.EndGameEvent;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.event.InitGameEvent;
import se.salomonsson.ld27.game.event.PrepareNewLevelEvent;
import se.salomonsson.ld27.game.event.StartNewLevelEvent;
import se.salomonsson.ld27.game.factories.SpriteFactory;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.ld27.Stage;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;
import se.salomonsson.seagal.debug.SLogger;

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
	private var _delayAction:String;
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		
		addListener(InitGameEvent.INIT, startup);
		addListener(StartNewLevelEvent.NEW_LEVEL, onStartNewLevel);
		addListener(GameEvent.LEVEL_EXIT, onExitLevel);
		
		_systemComp = em.getComp(SystemComp);
		_levelComp = em.getComp(LevelComp);
		
		SLogger.registerFunction(this, "debugStartLevel", "level" );
	}
	
	
	// OUCH - Hacky! Ugly! Well...
	private function startup(e:InitGameEvent):Void 
	{
		removeListener(InitGameEvent.INIT, startup);
		_levelRunning = false;
		_nextLevelCountdown = 0;
		_delayAction = "prepareNextLevel";
		_levelComp.levelId = e.startLevel - 1;
	}
	
	private function onStartNewLevel(e:StartNewLevelEvent):Void 
	{
		_levelRunning = true;
		_delayAction = "";
		
		var camera:CameraComp = em().getComp(CameraComp);
		var levelNum:Int = e.currentLevel;
		_levelComp.levelId = levelNum;
		
		// Reset number of players, dead players and exited players
		_systemComp.numPlayers = 0;
		_systemComp.playersDead = 0;
		_systemComp.playersRescued = 0;
		_systemComp.playersRescueThreshold = 0;
		
		_systemComp.bombHasExploded = false;
		_systemComp.bombFloodFillCompleted = false;
		
		
		
		var success:Bool = true;
		var mapNames:Array<String> = [ "",
			"assets/level1.png",
			"assets/level2.png",
			"assets/level3.png",
			"assets/level4.png",
			"assets/level5.png",
			"assets/level6.png",
			"assets/level7.png",
			"assets/level8.png"
		];
		
		
		if (levelNum > 0 && levelNum < mapNames.length) {
			_levelComp.map = new PixelMapParser(Assets.getBitmapData(mapNames[levelNum]));
			_levelComp.floor = createFloor(_levelComp.map);
		}
		
		switch(levelNum) {
			case 1:
				_levelComp.name = "Chill";
				SpriteFactory.exitSprite(em(), 16, 11);
				SpriteFactory.heroSprite(em(), 9, 9);
				centerCamera(camera, 9, 9);
			
			case 2:
				_levelComp.name = "Bomb?";
				SpriteFactory.bombSprite(em(), 5, 8);
				SpriteFactory.exitSprite(em(), 20, 10);
				SpriteFactory.heroSprite(em(), 6, 8);
				centerCamera(camera, 6, 8);
			
			case 3:
				_levelComp.name = "Brothers";
				SpriteFactory.bombSprite(em(), 7, 3);
				SpriteFactory.exitSprite(em(), 14, 17);
				SpriteFactory.exitSprite(em(), 18, 17);
				SpriteFactory.heroSprite(em(), 6, 3);
				SpriteFactory.heroSprite(em(), 8, 3);
				centerCamera(camera, 7, 3);
			
			case 4:
				_levelComp.name = "Fire run";
				SpriteFactory.bombSprite(em(), 6, 8);
				SpriteFactory.exitSprite(em(), 8, 12);
				SpriteFactory.heroSprite(em(), 5, 8);
				centerCamera(camera, 5, 8);
			
			case 5:
				_levelComp.name = "For the greater good";
				
				SpriteFactory.bombSprite(em(), 2, 5);
				SpriteFactory.bombSprite(em(), 2, 7);
				SpriteFactory.bombSprite(em(), 2, 11);
				SpriteFactory.bombSprite(em(), 2, 13);
				
				SpriteFactory.heroSprite(em(), 3, 5);
				SpriteFactory.heroSprite(em(), 3, 7);
				SpriteFactory.heroSprite(em(), 3, 11);
				SpriteFactory.heroSprite(em(), 3, 13);
				
				_systemComp.playersRescueThreshold = 3; // We can sacrifice one!
				
				centerCamera(camera, 3, 9);
				
			case 6:
				_levelComp.name = "Multitasking";
				SpriteFactory.bombSprite(em(), 11, 9);
				
				SpriteFactory.exitSprite(em(), 6,6);
				SpriteFactory.exitSprite(em(), 6,18);
				SpriteFactory.exitSprite(em(), 11,3);
				SpriteFactory.exitSprite(em(), 16,12);
				
				
				SpriteFactory.heroSprite(em(), 11,7);
				SpriteFactory.heroSprite(em(), 9,9);
				SpriteFactory.heroSprite(em(), 13,9);
				SpriteFactory.heroSprite(em(), 11,11);
				
				centerCamera(camera, 11, 9);
			
			case 7:
				_levelComp.name = "Double run";
				SpriteFactory.bombSprite(em(), 1, 8);
				SpriteFactory.bombSprite(em(), 1, 10);
				
				SpriteFactory.exitSprite(em(), 18, 8);
				SpriteFactory.exitSprite(em(), 18, 12);
				
				SpriteFactory.heroSprite(em(), 2, 8);
				SpriteFactory.heroSprite(em(), 2, 10);
				
				centerCamera(camera, 2, 9);
				
			case 8:
				_levelComp.name = "Random find";
				SpriteFactory.bombSprite(em(), 3, 8);
				SpriteFactory.bombSprite(em(), 25, 18);
				
				SpriteFactory.exitSprite(em(), 2,10);
				SpriteFactory.exitSprite(em(), 2,13);
				SpriteFactory.exitSprite(em(), 2,16);
				SpriteFactory.exitSprite(em(), 26,10);
				SpriteFactory.exitSprite(em(), 26,13);
				SpriteFactory.exitSprite(em(), 26,16);
				
				var randX:Int = 0;
				var randY:Int = 0;
				for (i in 0...6) {
					randX = Std.int( Math.round(Math.random() * 18) + 5 );
					randY = Std.int( Math.round(Math.random() * 18) + 5 );
					SpriteFactory.heroSprite(em(), randX, randY);
				}
				
				centerCamera(camera, randX, randY);
			
			default:
				success = false;
		}
		
		if (_systemComp.playersRescueThreshold == 0) {
			_systemComp.playersRescueThreshold = _systemComp.numPlayers;
		}
		
		
		if (success) {
			dispatch(new GameEvent(GameEvent.LEVEL_START));
		} else {
			
			dispatch(new EndGameEvent(EndGameEvent.GAME_ENDED));
			return;
			
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
		var pX = x * 64 * Stage.stageScale;
		var pY = y * 64 * Stage.stageScale;
		
		cam.x = pX - (sys.vpWidth / 2);
		cam.y = pY - (sys.vpHeight / 2);
		
		// lazy, only check bounds top and left...
		if (cam.x < 0)
			cam.x = 0;
			
		if (cam.y < 0)
			cam.y = 0;
	}
	
	
	
	
	
	override public function tick(gt:GameTime):Void 
	{
		if (_levelRunning) {
			var gameOver:Bool = false;
			var levelCompleted:Bool = false;
			
			var allPlayersGone:Bool = _systemComp.playersDead + _systemComp.playersRescued == _systemComp.numPlayers;
			var bombDone:Bool = _systemComp.bombFloodFillCompleted;
			
			if (bombDone) {
				var playersAlive:Int = _systemComp.numPlayers - _systemComp.playersDead;
				if (playersAlive >= _systemComp.playersRescueThreshold) {
					levelCompleted = true;
				} else {
					gameOver = true;
				}
			}else if (allPlayersGone) {
				if (_systemComp.playersRescued >= _systemComp.playersRescueThreshold) {
					levelCompleted = true;
				} else {
					gameOver = true;
				}
			}
			
			
			if (gameOver) {
				_delayAction = "gameOver";
			}
			
			if (levelCompleted) {
				_delayAction = "prepareNextLevel";
				dispatch(new GameEvent(GameEvent.LEVEL_EXIT));
			}
			
			if (gameOver || levelCompleted) {
				_nextLevelCountdown = 60;
				_levelRunning = false;
				
			}
			
		} else {
			if (--_nextLevelCountdown <= 0) {
				
				if (_delayAction == "prepareNextLevel") {
					_delayAction = "nextLevel";
					_nextLevelCountdown = 1;
					dispatch(new PrepareNewLevelEvent(PrepareNewLevelEvent.PREPARE, (_levelComp.levelId + 1)));
					return;
					
				} else if(_delayAction == "nextLevel") {
					// start next level (here we'll probably want to show a hint or something)
					var nextLevelId:Int = _levelComp.levelId + 1;
					dispatch(new StartNewLevelEvent(StartNewLevelEvent.NEW_LEVEL, nextLevelId));
					
				} else if (_delayAction == "gameOver") {
					
					var lives:Int = _systemComp.lives - 1;
					if (lives >= 0) {
						_systemComp.lives--;
						SLogger.log(this, "Number of lives: " + _systemComp.lives);
						dispatch(new GameEvent(GameEvent.LEVEL_EXIT));
						dispatch(new StartNewLevelEvent(StartNewLevelEvent.NEW_LEVEL, _levelComp.levelId)); // restart same level
					} else {
						dispatch(new GameEvent(GameEvent.GAME_OVER));
					}
				}
				_delayAction = "";
			}
		}
	}
	
	
	
	public function debugStartLevel(levelId:Int):Void {
		SLogger.log(this, "--DEBUG STARTING LEVEL " + levelId);
		dispatch(new GameEvent(GameEvent.LEVEL_EXIT));
		_levelComp.levelId = levelId;
		dispatch(new StartNewLevelEvent(StartNewLevelEvent.NEW_LEVEL, _levelComp.levelId));
	}
}