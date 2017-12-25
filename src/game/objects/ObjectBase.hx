/*
 *	Copyright 12/25/2017 Michal Deak. All rights reserved.
 */
package game.objects;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.geom.GRectangle;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTexture;

class ObjectBase {

    public var SIZE_WIDTH(default, null):Int;
    public var SIZE_HEGITH(default, null):Int;

    private var _image:GSprite;
    private var _boundingBox:GRectangle = new GRectangle();

    public function new(texture:GTexture, pivotX:Float = 0.5, pivotY:Float = 0.5) {
        _image = GNode.createWithComponent(GSprite);
        _image.texture = texture;
        _image.node.scaleX = _image.node.scaleY = 2;

        _image.texture.pivotX = (pivotX - 0.5) * _image.texture.width;
        _image.texture.pivotY = (pivotY - 0.5) * _image.texture.height;

        SIZE_WIDTH = Std.int(_image.texture.width * _image.node.scaleX);
        SIZE_HEGITH = Std.int(_image.texture.height * _image.node.scaleY);

        refreshBoundingBox();
    }

    public function refreshBoundingBox():Void {
        _boundingBox.x = _image.node.x - SIZE_WIDTH / 2;
        _boundingBox.y = _image.node.y - SIZE_HEGITH;
        _boundingBox.width = _image.node.x + SIZE_WIDTH / 2;
        _boundingBox.height = _image.node.y;
    }

    public function getBoundingBox():GRectangle {
        return _boundingBox;
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
