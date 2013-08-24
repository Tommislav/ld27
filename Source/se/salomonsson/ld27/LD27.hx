package se.salomonsson.ld27;


import aze.display.TilesheetEx;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.Lib;
import flash.system.Capabilities;
import flash.system.System;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import openfl.Assets;
import openfl.display.Tilesheet;
import pgr.gconsole.GameConsole;
import se.salomonsson.seagal.core.Core;
import se.salomonsson.seagal.utils.CmToPixels;


// resolution on nexus 7:		1280x736
// resolution on htc one:		1080x776		

class LD27 extends Sprite {
	
	
	public function new () {
		
		super ();
		//var bd = Assets.getBitmapData("assets/conceptart_ludumdare_1.png");
		//var bmp = new Bitmap(bd);
		//bmp.x = Lib.current.stage.stageWidth / 2 - bmp.width / 2;
		//bmp.y = Lib.current.stage.stageHeight / 2 - bmp.height / 2;
		//addChild(bmp);
		/*
		var tf = new TextField();
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.text = "WxH: " + Lib.current.stage.stageWidth + "x" + Lib.current.stage.stageHeight + ", DPI: " + Capabilities.screenDPI;
		addChild(tf);
		
		
		var sheet:TilesheetEx = new TilesheetEx(Assets.getBitmapData("assets/spritesheet.png"));
		sheet.addTileRect(new Rectangle(0,0,64,64));
		sheet.drawTiles(
			graphics,
			[
				0, 100, 0, 2,
				32,132,0,2
			],
			false, Tilesheet.TILE_SCALE
		);
		
		
		var radiusPx = CmToPixels.cmToPixels(1);
		graphics.beginFill(0x4ea5ff, 0.3);
		GameConsole.log("2 cm in pixels " + radiusPx);
		
		graphics.drawCircle(400, 400, 214);
		graphics.endFill();
		
		
		var core:Core = new Core();
		*/
		var game = new GameScreen();
		addChild(game);
	}
	
	
}