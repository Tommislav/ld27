package se.salomonsson.ld27.game.sys;

import flash.media.Sound;
import openfl.Assets;
import se.salomonsson.ld27.game.event.GameEvent;
import se.salomonsson.seagal.core.Sys;
import se.salomonsson.seagal.debug.SLogger;

/**
 * ...
 * @author Tommislav
 */
class SoundSys extends Sys
{

	
	public function new() { 
		super(); 
		//_sndMap = new Map<String, Sound>();
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		setupSounds();
		addListener(GameEvent.BOMB_EXPLODE, onBombExplode);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
	}
	
	function setupSounds() 
	{
		//_snd = Assets.getSound("assets/snd1.wav");
	}
	
	private function onBombExplode(e:GameEvent):Void 
	{
		
		var snd:Sound = Assets.getSound("assets/snd1.wav");
		SLogger.log(this, "explode, sound: " + snd + ", " + snd.bytesLoaded);
		snd.play(0,1);
	}
}