/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package ;

import core.sound.ISoundChannel;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.Genome2D;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;
import core.logger.Logger;
import core.sound.SoundManager;
import haxe.Timer;

class Game {

    var ttt:ISoundChannel;

    public function new() {
        testTexture();
        testSound();
    }

    //TEST TEXTURES

    private function testTexture():Void {
        Logger.log("TestTexture started...");

        var sprite:GSprite = GNode.createWithComponent(GSprite);
        //sprite.texture = GTextureManager.getTexture("test");
        sprite.texture = GTextureManager.getTextureAtlas("test_atlas").getSubTexture("test_atlas_1");
        sprite.node.setPosition(20, 20);
        Genome2D.getInstance().root.addChild(sprite.node);

        Logger.log("TestTexture ended.");
    }

    //TEST SOUNDS

    private function testSound():Void {
        Logger.log("TestSound started...");

        ttt = SoundManager.play("test_sound");
        var time:Timer = new Timer(3000);
        time.run = testSound2;

        Logger.log("TestSound ended.");
    }

    private function testSound2():Void {
//        SoundManager.play("test_sound");
        ttt.stop();
        Logger.log("TestSound2 ended.");
    }
}