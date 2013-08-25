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
	public static inline var HERO_LEFT = 5;
	public static inline var HERO_RIGHT = 6;
	public static inline var HERO_UP = 7;
	public static inline var HERO_DOWN = 8;
	public static inline var HERO_EXIT = 9;
	public static inline var HERO_DEAD = 10;
	
	
	
	public static inline var BOMB_1 = 11;
	public static inline var BOMB_2 = 12;
	public static inline var BOMB_3 = 13;
	
	public static inline var EXIT_1 = 14;
	public static inline var EXIT_2 = 15;
	public static inline var EXIT_3 = 16;
	public static inline var EXIT_4 = 17;
	
	public static inline var EXPLOSION_1 = 18;
	public static inline var EXPLOSION_2 = 19;
	public static inline var EXPLOSION_3 = 20;
	public static inline var EXPLOSION_4 = 21 ;
	
	
	public static var EXPLOSION:Array<Int> = [EXPLOSION_1, EXPLOSION_2, EXPLOSION_3, EXPLOSION_4];
	
	
	public static function buildTileSheet(bd:BitmapData):TilesheetEx {
		var sheet:TilesheetEx = new TilesheetEx(bd);
		
		sheet.addTileRect(tileRect(0, 0));	// floor
		sheet.addTileRect(tileRect(0, 1));	// path
		sheet.addTileRect(tileRect(0, 2));	// invalid
		
		sheet.addTileRect(tileRect(1, 0));	// stone
		sheet.addTileRect(tileRect(4, 0)); 	// player_regular
		sheet.addTileRect(tileRect(4, 1)); 	// player_left
		sheet.addTileRect(tileRect(4, 2)); 	// player_right
		sheet.addTileRect(tileRect(4, 3)); 	// player_up
		sheet.addTileRect(tileRect(4, 4)); 	// player_down
		sheet.addTileRect(tileRect(4, 5)); 	// player_exit
		sheet.addTileRect(tileRect(4, 6));	// player dead
		
		sheet.addTileRect(tileRect(5, 0)); 	// bomb1
		sheet.addTileRect(tileRect(5, 1)); 	// bomb2
		sheet.addTileRect(tileRect(5, 2)); 	// bomb3
		
		sheet.addTileRect(tileRect(6, 0)); 	// exit1
		sheet.addTileRect(tileRect(6, 1)); 	// exit2
		sheet.addTileRect(tileRect(6, 2)); 	// exit3
		sheet.addTileRect(tileRect(6, 3)); 	// exit4
		
		sheet.addTileRect(tileRect(5, 3));	// explosion 1
		sheet.addTileRect(tileRect(5, 4));	// explosion 2
		sheet.addTileRect(tileRect(5, 5));	// explosion 3
		sheet.addTileRect(tileRect(5, 6));	// explosion 4
		
		
		
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