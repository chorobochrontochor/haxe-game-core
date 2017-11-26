/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core.command;
import com.genome2d.assets.GAsset;
import com.genome2d.assets.GStaticAssetManager;
import com.genome2d.textures.GTextureManager;
import core.command.base.Command;
import core.enums.AssetType;

class InitializeAssetsCommand extends Command {

    static private var FOLDER_ASSETS:String = "assets/";

    private var _assetData:Array<InitializeAssetsCommandData>;

    public function new(assetData:Array<InitializeAssetsCommandData>) {
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
            var url:String = _assetData[i].url;
            GStaticAssetManager.addFromUrl(FOLDER_ASSETS + url, url);
        }
        GStaticAssetManager.loadQueue(onAssetsLoaded, onAssetsFailed);
    }

    private function onAssetsLoaded():Void {
        for (i in 0 ... _assetData.length) {
            var url:String = _assetData[i].url;
            var id:String = _assetData[i].id;
            var type:AssetType = _assetData[i].type;

            var asset:GAsset = GStaticAssetManager.getAssetById(url);

            if (type == AssetType.ASSET_TEXTURE) {
                GTextureManager.createTexture(id, asset);
            }
            if (type == AssetType.ASSET_ATLAS_XML) {
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
