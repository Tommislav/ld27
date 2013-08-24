package se.salomonsson.ld27.game.factories;
import se.salomonsson.ld27.game.comp.PosComp;
import se.salomonsson.ld27.game.comp.SelectableComp;
import se.salomonsson.ld27.game.comp.SpriteCollisionComponent;
import se.salomonsson.ld27.game.comp.SpriteComp;
import se.salomonsson.ld27.game.comp.SystemComp;
import se.salomonsson.seagal.core.EntManager;
import se.salomonsson.seagal.core.EW;

/**
 * ...
 * @author Tommislav
 */
class SpriteFactory
{
	
	
	
	public static function heroSprite(em:EntManager, x:Int, y:Int) {
		
		em.getComp(SystemComp).numPlayers += 1;
		
		var sprite:SpriteComp = new SpriteComp();
		sprite.addState("default", [TileSheetFactory.HERO]);
		sprite.addState("exit", [TileSheetFactory.HERO_EXIT]);
		
		var sel:SelectableComp = new SelectableComp();
		sel.currentTileX = x;
		sel.currentTileY = y;
		
		var pos:PosComp = new PosComp();
		pos.x = sel.currentTileX * 64;
		pos.y = sel.currentTileY * 64;
		
		em.allocateEntity()
			.addComponent(sprite)
			.addComponent(pos)
			.addComponent(sel);
	}
	
	
	
	public static function bombSprite(em:EntManager, x:Int, y:Int) {
		var sprite:SpriteComp = new SpriteComp();
		sprite.addState("default", [TileSheetFactory.BOMB_1, TileSheetFactory.BOMB_1, TileSheetFactory.BOMB_2, TileSheetFactory.BOMB_2, TileSheetFactory.BOMB_3, TileSheetFactory.BOMB_3]);
		sprite.autoLoop = true;
		
		var pos:PosComp = new PosComp();
		pos.x = x * 64;
		pos.y = y * 64;
		
		em.allocateEntity()
			.addComponent(sprite)
			.addComponent(pos)
			.addComponent(new SpriteCollisionComponent(SpriteCollisionComponent.SOLID));
	}
	
	
	
	public static function exitSprite(em:EntManager, x:Int, y:Int) {
		var sprite:SpriteComp = new SpriteComp();
		sprite.addState("default", [
			TileSheetFactory.EXIT_1, 
			TileSheetFactory.EXIT_1, 
			TileSheetFactory.EXIT_2, 
			TileSheetFactory.EXIT_2, 
			TileSheetFactory.EXIT_2, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_4, 
			TileSheetFactory.EXIT_4, 
			TileSheetFactory.EXIT_4, 
			TileSheetFactory.EXIT_4, 
			TileSheetFactory.EXIT_4, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_3, 
			TileSheetFactory.EXIT_2, 
			TileSheetFactory.EXIT_2, 
			TileSheetFactory.EXIT_2, 
			TileSheetFactory.EXIT_1,
			TileSheetFactory.EXIT_1
			]);
		sprite.autoLoop = true;
		
		var pos:PosComp = new PosComp();
		pos.x = x * 64;
		pos.y = y * 64;
		
		var coll:SpriteCollisionComponent = new SpriteCollisionComponent(SpriteCollisionComponent.EXIT);
		
		em.allocateEntity()
			.addComponent(sprite)
			.addComponent(pos)
			.addComponent(coll);
	}
	
	public static function destroyAllSprites(em:EntManager) {
		var allSprites:Array<EW> = em.getEWC([SpriteComp]);
		for (entWrapper in allSprites) {
			entWrapper.destroy();
		}
	}
	
	
	
	public function new() {}
	
}