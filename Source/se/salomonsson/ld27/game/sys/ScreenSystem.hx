package se.salomonsson.ld27.game.sys;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.Assets;
import pgr.gconsole.GameConsole;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class ScreenSystem extends Sys
{

	private var _currentScreen:DisplayObject;
	private var _sysComp:SystemComp;
	
	public function new() { super(); }
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_sysComp = em.getComp(SystemComp);
		addListener(GameEvent.GAME_OVER, onGameOver);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(GameEvent.GAME_OVER, onGameOver);
	}
	
	private function onGameOver(e:GameEvent):Void 
	{
		GameConsole.log("GOT GAME OVER EVENT!");
		var bd:BitmapData = Assets.getBitmapData("assets/gameover.png");
		var bmp:Bitmap = new Bitmap(bd);
		var holder:Sprite = new Sprite();
		holder.addChild(bmp);
		
		
		var rescued:String = _sysComp.playersRescued + "";
		var needed:String = _sysComp.playersRescueThreshold + "";
		
		addTextTo(holder, rescued, 190, 112);
		addTextTo(holder, needed, 190, 132);
		
		
		
		holder.x = Math.round(_sysComp.vpWidth / 2 - holder.width / 2);
		holder.y = Math.round(_sysComp.vpHeight / 2 - holder.height / 2);
		Lib.current.stage.addChild(holder);
		
		_currentScreen = holder;
	}
	
	private function addTextTo(holder:Sprite, text:String, x:Float, y:Float) {
		var tf:TextField = getTextField(text);
		tf.x = x;
		tf.y = y;
		holder.addChild(tf);
	}
	
	private function getTextField(text:String):TextField
	{
		var tf:TextField = new TextField();
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.selectable = false;
		
		var format:TextFormat = new TextFormat("Arial",24, 0x000000, true);
		tf.defaultTextFormat = format;
		
		tf.text = text;
		
		return tf;	
	}
	
	
	
}