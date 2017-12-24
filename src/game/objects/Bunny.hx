/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package game.objects;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;

class Bunny {

    public static var SIZE_BUNNY:Int;
    private var _image:GSprite;

    private var JUMP_VELOCITY:Float = 20;
    private var JUMP_DECREASE:Float = 1;
    private var _velocity:Float = 0;

    public function new() {
        createImage();
    }

    private function createImage():Void {
        _image = GNode.createWithComponent(GSprite);
        _image.texture = GTextureManager.getTextureAtlas(AssetId.TEXTURE_GAME_ATLAS).getSubTexture(AssetId.TEXTURE_BUNNY);
        _image.node.scaleX = _image.node.scaleY = 2;
        _image.texture.pivotY = _image.texture.height / 2;

        SIZE_BUNNY = Std.int(_image.texture.width * _image.node.scaleX);
    }

    public function update():Void {
        _velocity -= JUMP_DECREASE;
        _image.node.y -= _velocity;
    }

    public function getNode():GNode {
        return _image.node;
    }

    public function getNextFrameLocation():Float {
        return _image.node.y - _velocity;
    }

    public function isFalling():Bool {
        return _velocity < 0;
    }

    public function jump():Void {
        _velocity = JUMP_VELOCITY;
    }
}
