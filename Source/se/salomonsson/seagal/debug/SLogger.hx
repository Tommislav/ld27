package se.salomonsson.seagal.debug;
import flash.Lib;
import pgr.gconsole.GCThemes;
import pgr.gconsole.GC;

/**
 * ...
 * @author Tommislav
 */
class SLogger
{	
	public static function log(obj:Dynamic, msg:String) {
		#if debug
			
			var className = "";
			if (Std.is(obj, Class)) {
				className = Type.getClassName(obj);
			}
			else {
				className = Type.getClassName( Type.getClass(obj) );
			}
		
			GC.log(Lib.getTimer() + " " + className + " :: " + msg);
		#end
	}
	
	public static function init() {
		#if debug 
			GC.init(0.5, "DOWN", GCThemes.DARK);
			GC.log("Seagal Enitity System...");
		#end
	}
	
	public static function registerFunction(object:Dynamic, name:String, alias:String, ?monitor:Bool = false) {
		#if debug 
			GC.registerFunction(object, alias);
		#end
	}
	
	public function new() 
	{
		
	}
	
	
	
}