/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package game.objects;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;

class Platform {

    public static var SIZE_PLATFORM:Int;

    private var _image:GSprite;

    public function new() {
        createImage();
    }

    private function createImage():Void {
        _image = GNode.createWithComponent(GSprite);
        _image.texture = GTextureManager.getTextureAtlas(AssetId.TEXTURE_GAME_ATLAS).getSubTexture(AssetId.TEXTURE_PLATFORM);
        _image.node.scaleX = _image.node.scaleY = 2;
        _image.texture.pivotY = -_image.texture.height / 2;

        SIZE_PLATFORM = Std.int(_image.texture.width * _image.node.scaleX);
    }

    public function getNode():GNode {
        return _image.node;
    }

    public function destroy():Void {
        if (_image.node.parent != null) {
            _image.node.parent.removeChild(_image.node);
        }
    }
}
