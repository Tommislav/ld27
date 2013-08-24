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
	public static inline var TILE_WIDTH = 64;
	public static inline var TILE_HEIGHT = 64;
	public static inline var SPRITE_WIDTH = 64;
	public static inline var SPRITE_HEIGHT = 128;
	
	
	public static inline var FLOOR_REGULAR = 0;
	public static inline var FLOOR_SELECTED = 1;
	public static inline var FLOOR_INVALID = 2;
	
	public static inline var STONE = 3;
	public static inline var HERO = 4;
	public static inline var HERO_EXIT = 5;
	
	
	
	public static inline var BOMB_1 = 6;
	public static inline var BOMB_2 = 7;
	public static inline var BOMB_3 = 8;
	
	public static inline var EXIT_1 = 9;
	public static inline var EXIT_2 = 10;
	public static inline var EXIT_3 = 11;
	public static inline var EXIT_4 = 12;
	
	
	public static function buildTileSheet(bd:BitmapData):TilesheetEx {
		var sheet:TilesheetEx = new TilesheetEx(bd);
		
		sheet.addTileRect(tileRect(0, 0));		// floor
		sheet.addTileRect(tileRect(0, 1));		// path
		sheet.addTileRect(tileRect(0, 2));		// invalid
		
		sheet.addTileRect(tileRect(1, 0));		// stone
		sheet.addTileRect(tileRect(4, 0)); 		// player
		sheet.addTileRect(tileRect(4, 1)); 		// player_exit
		
		sheet.addTileRect(tileRect(5, 0)); // bomb1
		sheet.addTileRect(tileRect(5, 1)); // bomb2
		sheet.addTileRect(tileRect(5, 2)); // bomb3
		
		sheet.addTileRect(tileRect(6, 0)); // exit1
		sheet.addTileRect(tileRect(6, 1)); // exit2
		sheet.addTileRect(tileRect(6, 2)); // exit3
		sheet.addTileRect(tileRect(6, 3)); // exit4
		
		
		
		
		return sheet;
	}
	
	
	private static function tileRect(x, y):Rectangle {
		return new Rectangle(x * 64, y * 64, TILE_WIDTH, TILE_HEIGHT);
	}
	
	private static function spriteRect(x, y):Rectangle {
		return new Rectangle(x * 64, y * 64, SPRITE_WIDTH, SPRITE_HEIGHT);
	}
	
	
	public function new() 
	{
		
	}
	
}