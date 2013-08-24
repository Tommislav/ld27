package;


import flash.display.Bitmap;
import flash.display.Sprite;
import flash.Lib;
import openfl.Assets;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		var bd = Assets.getBitmapData("assets/conceptart_ludumdare_1.png");
		var bmp = new Bitmap(bd);
		bmp.x = Lib.current.stage.stageWidth / 2 - bmp.width / 2;
		bmp.y = Lib.current.stage.stageHeight / 2 - bmp.height / 2;
		addChild(bmp);
	}
	
	
}