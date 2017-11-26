/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package ;

import com.genome2d.components.renderable.GSprite;
import com.genome2d.Genome2D;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;
import core.sound.SoundManager;

class Game {

    public function new() {
        testTexture();
        testSound();
    }

    private function testTexture():Void {
        var sprite:GSprite = GNode.createWithComponent(GSprite);
        sprite.texture = GTextureManager.getTextureAtlas(AssetId.TEXTURE_TEST_ATLAS).getSubTexture(AssetId.TEXTURE_TEST_ATLAS_1);
        sprite.node.setPosition(20, 20);
        Genome2D.getInstance().root.addChild(sprite.node);
    }

    private function testSound():Void {
        SoundManager.play(AssetId.SOUND_TEST);
    }
}