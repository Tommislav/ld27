package se.salomonsson.ld27.game.sys;

import openfl.Assets;
import se.salomonsson.game.utils.PixelMapParser;
import se.salomonsson.ld27.game.comp.LevelComp;
import se.salomonsson.seagal.core.Sys;

/**
 * ...
 * @author Tommislav
 */
class LevelSystem extends Sys
{

	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		
		var lvl:LevelComp = em.getComp(LevelComp);
		var map:PixelMapParser = new PixelMapParser(Assets.getBitmapData("assets/level1.png"));
		lvl.level = map;
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
	}
	
}