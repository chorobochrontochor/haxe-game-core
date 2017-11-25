/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core.command;
import com.genome2d.assets.GAsset;
import com.genome2d.assets.GStaticAssetManager;
import com.genome2d.textures.GTextureManager;
import core.command.base.Command;

class InitializeAssetsCommand extends Command {

    static private var FOLDED_ASSETS:String = "assets/";

    static public var ASSET_ATLAS_XML:String = "atlas";
    static public var ASSET_TEXTURE:String = "texture";

    private var _assetData:Array<Array<String>>;

    public function new(assetData:Array<Array<String>>) {
        super();

        _assetData = assetData;
    }

    /**
    * Assets initialization
    *
    * @param assetData - array of string where first one is url, and second id
    * exampple: ["textures/test.png", "test", ASSET_TEXTURE], ["textures/clip_texture.png", "clip", ASSET_ATLAS_XML]
    **/
    override public function execute():Void {
        for (i in 0 ... _assetData.length) {
            var url:String = _assetData[i][0];
            var id:String = _assetData[i][1];
            GStaticAssetManager.addFromUrl(FOLDED_ASSETS + url, url);
        }
        GStaticAssetManager.loadQueue(onAssetsLoaded, onAssetsFailed);
    }

    private function onAssetsLoaded():Void {
        for (i in 0 ... _assetData.length) {
            var url:String = _assetData[i][0];
            var id:String = _assetData[i][1];
            var type:String = _assetData[i][2];

            var asset:GAsset = GStaticAssetManager.getAssetById(url);

            if (type == ASSET_TEXTURE) {
                GTextureManager.createTexture(id, asset);
            }
            if (type == ASSET_ATLAS_XML) {
                var texture = GTextureManager.getTexture(id);
                GTextureManager.createTextureAtlas(texture, cast asset, false);
            }
        }
        onCommandSucceed();
    }

    private function onAssetsFailed(asset:GAsset):Void {
        onCommandFailed(asset.url);
    }
}
