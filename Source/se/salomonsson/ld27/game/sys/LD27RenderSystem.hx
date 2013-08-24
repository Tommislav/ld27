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
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.comp.TouchComp;
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
	
	public function new(canvas:Graphics) {
		super();
		_canvas = canvas;
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		
		_sheet = new TilesheetEx(Assets.getBitmapData("assets/spritesheet.png"));
		_sheet.addTileRect(new Rectangle(0, 0, 64, 64));
		_sheet.addTileRect(new Rectangle(64, 0, 64, 128), new Point(0,0));
		_sheet.addTileRect(new Rectangle(128, 0, 64, 128), new Point(0,0));
		
		_sheet.addTileRect(new Rectangle(0, 64, 64, 64)); // floor white
		_sheet.addTileRect(new Rectangle(0, 64, 64*2, 64)); // floor walk
		_sheet.addTileRect(new Rectangle(0, 64, 64*3, 64)); // floor cannot walk
		
	}
	
	override public function tick(gt:GameTime):Void 
	{
		if (_systemComp == null)
			_systemComp = em().getComp(SystemComp);
			
		if (_touchComp == null)
			_touchComp = em().getComp(TouchComp);
		
		var cam:CameraComp = em().getComp(CameraComp);
		var map:PixelMapParser = em().getComp(LevelComp).level;
		
		_canvas.clear();
		
		var tileArray:Array<Float> = new Array<Float>();
		var scale:Float = 1.0;
		
		
		var camX:Float = cam.x;
		var camY:Float = cam.y;
		
		//var w:Int = Math.ceil(camera.width / 64) + 1;
		//var h:Int = Math.ceil(camera.height / 64) + 1;
		var tileX:Int = Math.floor(camX / 64);
		var tileY:Int = Math.floor(camY / 64);
		
		var offX = aboveZero(camX % 64, 64);
		var offY = aboveZero(camY % 64, 64);
		
		for (y in 0..._systemComp.tileH) {
			for (x in 0..._systemComp.tileW) {
				
				// floor
				tileArray.push((x * 64) - offX);
				tileArray.push((y * 64) - offY);
				tileArray.push(3);
				tileArray.push(scale);
				
				if (map.atCoord(x + tileX, y + tileY) == 0) {
					// wall
					
					tileArray.push((x * 64) - offX);
					tileArray.push((y * 64) - offY);
					tileArray.push(0);
					tileArray.push(scale);
				}
			}
		}
		
		_sheet.drawTiles(_canvas, tileArray, false, Tilesheet.TILE_SCALE);
		
		
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