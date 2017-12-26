/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package game.objects;
import com.genome2d.textures.GTextureManager;

class Bunny extends ObjectBase {

    private var JUMP_VELOCITY:Float = 25;
    private var JUMP_DECREASE:Float = 1;
    private var _velocity:Float = 0;

    public function new() {
        super(GTextureManager.getTextureAtlas(AssetId.ATLAS_GAME).getSubTexture(AssetId.TEXTURE_BUNNY), 0.5, 1);
    }

    public function onFrameUpdate():Void {
        _velocity -= JUMP_DECREASE;
        _image.node.y -= _velocity;
        refreshBoundingBox();
    }

    public function getNextFrameBunnyPositionY():Float {
        return _image.node.y - _velocity;
    }

    public function setBunnyPositionX(location:Float):Void {
        if (_image.node.x < location) {
            _image.node.scaleX = -Math.abs(_image.node.scaleX);
        } else if (_image.node.x > location) {
            _image.node.scaleX = Math.abs(_image.node.scaleX);
        }
        _image.node.x = location;
    }

    public function isFalling():Bool {
        return _velocity <= 0;
    }

    public function jump():Void {
        _velocity = JUMP_VELOCITY;
    }
}
