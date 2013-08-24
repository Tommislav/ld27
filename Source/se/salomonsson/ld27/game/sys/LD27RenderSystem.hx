package se.salomonsson.ld27.game.sys;
import aze.display.TileLayer;
import aze.display.TilesheetEx;
import aze.display.TileSprite;
import flash.display.Graphics;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.macro.Expr.Var;
import haxe.remoting.FlashJsConnection;
import openfl.Assets;
import openfl.display.Tilesheet;
import se.salomonsson.game.utils.PixelMapParser;
import se.salomonsson.ld27.game.comp.CameraComp;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.ld27.game.comp.PosComp;
import se.salomonsson.ld27.game.comp.SpriteComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.factories.SpriteFactory;
import se.salomonsson.ld27.game.factories.TileSheetFactory;
import se.salomonsson.seagal.core.EW;
import se.salomonsson.seagal.core.GameTime;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class LD27RenderSystem extends Sys
{
	static inline var POINTER_SIZE = 40;
	
	private var _sheet:TilesheetEx;
	private var _tileLayer:TileLayer;
	private var _canvas:Graphics;
	
	private var _map:PixelMapParser;
	
	private var s:TileSprite;
	private var _systemComp:SystemComp;
	private var _touchComp:TouchComp;
	
	private var _tileStartX:Int;
	private var _tileStartY:Int;
	private var _offX:Float;
	private var _offY:Float;
	
	private var _tileArray:Array<Float>;
	
	
	public function new(canvas:Graphics) {
		super();
		_canvas = canvas;
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		addListener(GameEvent.LEVEL_START, onNewLevel);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(GameEvent.LEVEL_START, onNewLevel);
	}
	
	private function onNewLevel(e:GameEvent):Void 
	{
		_sheet = em().getComp(LevelComp).sheet;
	}
	
	
	
	
	override public function tick(gt:GameTime):Void 
	{
		if (_sheet == null) {
			return;
		}
		
		if (_systemComp == null)
			_systemComp = em().getComp(SystemComp);
			
		if (_touchComp == null)
			_touchComp = em().getComp(TouchComp);
		
		var cam:CameraComp = em().getComp(CameraComp);
		var level:LevelComp = em().getComp(LevelComp);
		var map = level.map;
		
		
		var scale:Float = 1.0;
		
		
		var camX:Float = cam.x;
		var camY:Float = cam.y;
		
		_tileStartX = Math.floor(camX / 64);
		_tileStartY = Math.floor(camY / 64);
		
		_offX = aboveZero(camX % 64, 64);
		_offY = aboveZero(camY % 64, 64);
		
		_tileArray = new Array<Float>();
		
		
		
		
		for (y in 0..._systemComp.tileH) {
			for (x in 0..._systemComp.tileW) {
				
				var tileValue:Int = map.atCoord(_tileStartX + x, _tileStartY + y);
				var floorTile:Int = level.floor.atCoord(_tileStartX + x, _tileStartY + y);
				
				// floor
				_tileArray.push((x * 64) - _offX);
				_tileArray.push((y * 64) - _offY);
				_tileArray.push(floorTile);
				_tileArray.push(scale);
				
				if (tileValue == 0) {
					// wall
					
					_tileArray.push((x * 64) - _offX);
					_tileArray.push((y * 64) - _offY);
					_tileArray.push(TileSheetFactory.STONE);
					_tileArray.push(scale);
				}
			}
		}
		
		var sprites:Array<EW> = em().getEWC([SpriteComp]);
		for (i in 0...sprites.length) {
			var ent:EW = sprites[i];
			var pos:PosComp = ent.comp(PosComp);
			var spr:SpriteComp = ent.comp(SpriteComp);
			_tileArray.push(pos.x-camX);
			_tileArray.push(pos.y-camY);
			_tileArray.push(spr.getCurrentFrame());
			_tileArray.push(scale);
		}
		
		_canvas.clear();
		_sheet.drawTiles(_canvas, _tileArray, false, Tilesheet.TILE_SCALE);
		
		
		// Draw touch circle if touching
		if (_touchComp.isTouching) {
			_canvas.beginFill(0x3e8bff, 0.3);
			_canvas.drawCircle(_touchComp.touchX, _touchComp.touchY, POINTER_SIZE);
			_canvas.endFill();
		}
	}
	
	private function aboveZero(val:Float, range:Float):Float {
		if (val < 0)
			val += range;
		return val;
	}
	
}