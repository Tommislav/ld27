package se.salomonsson.ld27.game.factories;
import se.salomonsson.ld27.game.comp.PosComp;
import se.salomonsson.ld27.game.comp.SelectableComp;
import se.salomonsson.ld27.game.comp.SpriteComp;
import se.salomonsson.seagal.core.EntManager;

/**
 * ...
 * @author Tommislav
 */
class SpriteFactory
{
	
	public static function build(em:EntManager) {
		heroSprite(em);
	}
	
	
	
	public static function heroSprite(em:EntManager) {
		
		var sprite:SpriteComp = new SpriteComp();
		sprite.addState("default", [TileSheetFactory.HERO]);
		
		var sel:SelectableComp = new SelectableComp();
		sel.currentTileX = 4;
		sel.currentTileY = 4;
		
		var pos:PosComp = new PosComp();
		pos.x = sel.currentTileX * 64;
		pos.y = sel.currentTileY * 64;
		
		em.allocateEntity()
			.addComponent(sprite)
			.addComponent(pos)
			.addComponent(sel);
	}
	
	
	public function new() {}
	
}