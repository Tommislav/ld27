package se.salomonsson.ld27.game.comp;

import se.salomonsson.seagal.core.IComponent;

/**
 * ...
 * @author Tommislav
 */
class SystemComp implements IComponent
{
	public var vpWidth:Int;
	public var vpHeight:Int;
	public var tileW:Int;
	public var tileH:Int;
	
	public var timeLeft:Int;
	
	public var numPlayers:Int;
	public var playersDead:Int;
	public var playersRescued:Int;
	public var playersRescueThreshold:Int;
	
	public var bombHasExploded:Bool;
	public var bombFloodFillCompleted:Bool;
	
	public function new() {}
	
}