/*
 *	Copyright 12/26/2017 Michal Deak. All rights reserved.
 */
package game;
import com.genome2d.text.GTextureFont;
import com.genome2d.text.GTextureFont;
import com.genome2d.assets.GStaticAssetManager;
import com.genome2d.components.renderable.text.GText;
import com.genome2d.node.GNode;
import com.genome2d.text.GFontManager;
import com.genome2d.utils.GHAlignType;
import com.genome2d.utils.GVAlignType;
class Score {

    private var _textFieldScore:GText;
    private var _textFieldText:GText;
    private var _holder:GNode;

    private var _score:Float = 0;

    public function new() {
        _holder = new GNode();

        _textFieldText = createText(0, 0, "Score", GVAlignType.TOP, GHAlignType.CENTER);
        _holder.addChild(_textFieldText.node);

        _textFieldScore = createText(0, 50, "0", GVAlignType.TOP, GHAlignType.CENTER);
        _holder.addChild(_textFieldScore.node);
    }

    private function createText(p_x:Float, p_y:Float, p_text:String, p_vAlign:GVAlignType, p_hAlign:GHAlignType, p_tracking:Int = 0, p_lineSpace:Int = 0):GText {

        var text:GText = cast GNode.createWithComponent(GText);
        text.renderer.textureFont = cast GFontManager.getFont(AssetId.FONT_GAME);
        text.width = 600;
        text.height = 300;
        text.text = p_text;
        text.tracking = p_tracking;
        text.lineSpace = p_lineSpace;
        text.vAlign = p_vAlign;
        text.hAlign = p_hAlign;
        text.node.setPosition(p_x - 300, p_y);
        return text;
    }

    public function getNode():GNode {
        return _holder;
    }

    public function addScore(value:Float):Void {
        _score += value;
        _textFieldScore.text = Std.string(Math.round(_score));
    }

    public function destroy():Void {
        if (_textFieldScore.node.parent != null) {
            _textFieldScore.node.parent.removeChild(_textFieldScore.node);
            _textFieldScore = null;
        }
    }
}
