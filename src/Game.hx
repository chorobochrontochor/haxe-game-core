/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package ;

import core.sound.SoundManager;
import core.logger.Logger;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.Genome2D;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;

class Game {

    public function new() {
        testTexture();
        testSound();
    }

    private function testTexture():Void{
        Logger.log("TestTexture started...");

        //Texture test
        var sprite:GSprite = GNode.createWithComponent(GSprite);
        //sprite.texture = GTextureManager.getTexture("test");
        sprite.texture = GTextureManager.getTextureAtlas("test_atlas").getSubTexture("test_atlas_1");
        sprite.node.setPosition(20, 20);
        Genome2D.getInstance().root.addChild(sprite.node);

        Logger.log("TestTexture ended.");
    }

    private function testSound():Void{
        Logger.log("TestSound started...");

        SoundManager.test();

        Logger.log("TestSound ended.");
    }
}