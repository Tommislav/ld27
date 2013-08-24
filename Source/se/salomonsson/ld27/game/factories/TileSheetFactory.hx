package se.salomonsson.ld27.game.factories;
import aze.display.TilesheetEx;
import flash.display.BitmapData;
import flash.geom.Rectangle;

/**
 * ...
 * @author Tommislav
 */
class TileSheetFactory
{
	public static inline var FLOOR_REGULAR = 0;
	public static inline var FLOOR_SELECTED = 1;
	public static inline var FLOOR_INVALID = 2;
	
	public static inline var STONE = 3;
	public static inline var HERO = 4;
	
	public static inline var TILE_WIDTH = 64;
	public static inline var TILE_HEIGHT = 64;
	public static inline var SPRITE_WIDTH = 64;
	public static inline var SPRITE_HEIGHT = 128;
	
	public static function buildTileSheet(bd:BitmapData):TilesheetEx {
		var sheet:TilesheetEx = new TilesheetEx(bd);
		
		sheet.addTileRect(new Rectangle(64*0, 64*0, TILE_WIDTH, TILE_HEIGHT));		// floor
		sheet.addTileRect(new Rectangle(64 * 0, 64 * 1, TILE_WIDTH, TILE_HEIGHT));	// path
		sheet.addTileRect(new Rectangle(64 * 0, 64 * 2, TILE_WIDTH, TILE_HEIGHT));	// invalid
		
		sheet.addTileRect(new Rectangle(64 * 1, 64 * 0, TILE_WIDTH, TILE_HEIGHT));	// stone
		
		sheet.addTileRect(new Rectangle(64 * 4, 64 * 0, SPRITE_WIDTH, SPRITE_HEIGHT)); // player
		
		
		
		
		return sheet;
	}
	
	
	public function new() 
	{
		
	}
	
}