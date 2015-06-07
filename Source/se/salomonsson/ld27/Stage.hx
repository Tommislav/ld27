package se.salomonsson.ld27;
import flash.display.StageScaleMode;
import flash.Lib;

/**
 * ...
 * @author Tommislav
 */
class Stage
{

	public static var stageScale:Float = 1.0;
	public static var stageWidth;
	public static var stageHeight;
	
	
	public function new() 
	{
		Stage.stageWidth = Lib.current.stage.stageWidth;
		Stage.stageHeight = Lib.current.stage.stageHeight;
	}
	
	public static function setScale(scale:Float) {
		stageScale = scale;
		stageWidth = Lib.current.stage.stageWidth * scale;
		stageHeight = Lib.current.stage.stageHeight * scale;

		Lib.current.scaleX = Lib.current.scaleY = scale;
	}

	public static function adjustScale(preferredWidth:Float, preferredHeight:Float) {
		var actualW = Lib.current.stage.stageWidth;
		var actualH = Lib.current.stage.stageHeight;
		var sX = actualW / preferredWidth;
		var sY = actualH / preferredHeight;
		var scale = sX > sY ? sY : sX;
		setScale(scale);

	}
	
}