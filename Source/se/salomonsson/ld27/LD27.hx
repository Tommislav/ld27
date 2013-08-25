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
import se.salomonsson.seagal.screen.ShowBitmapScreen;
import se.salomonsson.seagal.utils.CmToPixels;


// resolution on nexus 7:		1280x736
// resolution on htc one:		1080x776		

class LD27 extends Sprite {
	
	
	public function new () {
		
		super ();
		showSplashScreen();
	}
	
	private function showSplashScreen() {
		var splash:ShowBitmapScreen = new ShowBitmapScreen("assets/screen_intro.png", 1000, true);
		splash.show(showStartScreen);
	}
	
	private function showStartScreen() {
		var screen:ShowBitmapScreen = new ShowBitmapScreen("assets/screen_start.png", -1, true).setFadeTimeSeconds(0.5);
		screen.show(showGameScreen);
	}
	
	
	private function showGameScreen() {
		var game = new GameScreen();
		addChild(game);
	}
	
}