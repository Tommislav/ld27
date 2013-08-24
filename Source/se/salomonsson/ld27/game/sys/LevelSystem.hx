package se.salomonsson.ld27.game.sys;

import flash.display.BitmapData;
import openfl.Assets;
import se.salomonsson.game.utils.PixelMapParser;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.event.StartNewLevelEvent;
import se.salomonsson.ld27.game.factories.SpriteFactory;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class LevelSystem extends Sys
{

	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		addListener(StartNewLevelEvent.NEW_LEVEL, onStartNewLevel);
		
		var lvl:LevelComp = em.getComp(LevelComp);
		var map:PixelMapParser = new PixelMapParser(Assets.getBitmapData("assets/level1.png"));
		lvl.map = map;
	}
	
	private function onStartNewLevel(e:StartNewLevelEvent):Void 
	{
		var level:LevelComp = em().getComp(LevelComp);
		var camera:CameraComp = em().getComp(CameraComp);
		var levelNum:Int = e.currentLevel;
		level.levelId = levelNum;
		
		
		
		var success:Bool = true;
		
		switch(levelNum) {
			case 1:
				level.map = new PixelMapParser(Assets.getBitmapData("assets/level1.png"));
				level.floor = createFloor(level.map);
				SpriteFactory.bombSprite(em(), 5, 8);
				SpriteFactory.exitSprite(em(), 20, 10);
				SpriteFactory.heroSprite(em(), 6, 8);
				centerCamera(camera, 6, 8);
			
			case 2:
				level.map = new PixelMapParser(Assets.getBitmapData("assets/level2.png"));
				level.floor = createFloor(level.map);
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
	
	function createFloor(map:PixelMapParser) 
	{
		var bd:BitmapData = new BitmapData(map.width, map.height, false, TileSheetFactory.FLOOR_REGULAR);
		return new PixelMapParser(bd);
	}
	
	override public function onRemoved():Void 
	{
		removeListener(StartNewLevelEvent.NEW_LEVEL, onStartNewLevel);
		super.onRemoved();
	}
	
	private function centerCamera(cam:CameraComp, x:Int, y:Int) {
		var sys:SystemComp = em().getComp(SystemComp);
		var pX = x * 64;
		var pY = y * 64;
		
		cam.x = pX - (sys.vpWidth / 2);
		cam.y = pY - (sys.vpHeight / 2);
	}
}