package se.salomonsson.ld27;


import flash.display.Sprite;
import se.salomonsson.seagal.screen.ShowBitmapScreen;


// resolution on nexus 7:		1280x736
// resolution on htc one:		1080x776		

class LD27 extends Sprite {
	
	
	public function new () {
		super();
		Stage.adjustScale(800,600);
		//Stage.setScale(1);
		//Stage.stageScale = 1.5;
		showGameScreen();
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