package se.salomonsson.ld27.game.sys;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.Assets;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.ld27.game.event.EndGameEvent;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.ld27.game.event.PrepareNewLevelEvent;
import se.salomonsson.seagal.core.Sys;
import se.salomonsson.seagal.debug.SLogger;
import se.salomonsson.seagal.screen.ShowBitmapScreen;

/**
 * ...
 * @author Tommislav
 */
class ScreenSystem extends Sys
{

	private var _currentScreen:DisplayObject;
	private var _sysComp:SystemComp;
	var _canvas:Graphics;
	
	public function new(canvas:Graphics) { 
		super(); 
		_canvas = canvas;
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_sysComp = em.getComp(SystemComp);
		addListener(GameEvent.GAME_OVER, onGameOver);
		addListener(PrepareNewLevelEvent.PREPARE, checkTutorialScreen);
		addListener(EndGameEvent.GAME_ENDED, onGameEnded);
	}
	
	
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(GameEvent.GAME_OVER, onGameOver);
		removeListener(PrepareNewLevelEvent.PREPARE, checkTutorialScreen);
		removeListener(EndGameEvent.GAME_ENDED, onGameEnded);
	}
	
	private function onGameEnded(e:EndGameEvent):Void 
	{
		SLogger.log(this, "onGameEnded");
		_canvas.clear();
		var screen:ShowBitmapScreen = new ShowBitmapScreen("assets/screen_endscreen.png", 0, false);
		screen.show(nothing);
		getManager().pause();
	}
	private function nothing(){}
	
	private function onGameOver(e:GameEvent):Void 
	{
		SLogger.log(this, "GOT GAME OVER EVENT!");
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
	
	
	
	
	private function checkTutorialScreen(e:PrepareNewLevelEvent):Void 
	{
		var num:Int = e.levelNum;
		var tutorialScreens:Array<String> = ["", 
			"assets/screen_tut01.png",
			"assets/screen_tut02.png",
			"",
			"",
			"assets/screens_tutSacrifice.png"
			];
		
		SLogger.log(this, "Check for tutorial screen " + num);
		
		if (num < tutorialScreens.length) {
			var screenName = tutorialScreens[num];
			SLogger.log(this, "SHOW screen with id " + screenName);
			
			if (screenName != "") {
				getManager().pause();
				
				_canvas.clear();
				
				var screen:ShowBitmapScreen = new ShowBitmapScreen(screenName, 5000, true).setFadeTimeSeconds(2);
				screen.show(tutorialComplete);
			}
		}
	}
	
	private function tutorialComplete():Void {
		getManager().resume();
	}
	
}