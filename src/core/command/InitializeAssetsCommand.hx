/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core.command;
import com.genome2d.text.GFontManager;
import com.genome2d.text.GFont;
import core.sound.SoundManager;
import core.CoreConfig;
import com.genome2d.assets.GAsset;
import com.genome2d.assets.GStaticAssetManager;
import com.genome2d.assets.GXmlAsset;
import com.genome2d.textures.GTextureManager;
import core.command.base.Command;
import core.enums.AssetType;

class InitializeAssetsCommand extends Command {

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
            var id:String = _assetData[i].id;
            var type:AssetType = _assetData[i].type;

            if (type == AssetType.TEXTURE || type == AssetType.TEXTURE_ATLAS_XML) {
                //Id is url, because we wantd uniqu id for GAsset, to match atas + xml by same id //FIXME
                GStaticAssetManager.addFromUrl(CoreConfig.FOLDER_ASSETS + url, url);
            }
            if (type == AssetType.SOUND) {
                SoundManager.addFromUrl(CoreConfig.FOLDER_ASSETS + url, id);
            }
            if (type == AssetType.FONT) {
                GStaticAssetManager.addFromUrl(CoreConfig.FOLDER_ASSETS + url, id);
            }
        }
        GStaticAssetManager.loadQueue(onAssetsLoaded, onAssetsFailed);
    }

    private function onAssetsLoaded():Void {
        for (i in 0 ... _assetData.length) {
            var url:String = _assetData[i].url;
            var id:String = _assetData[i].id;
            var type:AssetType = _assetData[i].type;

            var asset:GAsset = GStaticAssetManager.getAssetById(url);

            if (type == AssetType.TEXTURE) {
                GTextureManager.createTexture(id, asset);
            }
            if (type == AssetType.TEXTURE_ATLAS_XML) {
                var texture = GTextureManager.getTexture(id);
                var xml:Xml = cast(asset, GXmlAsset).xml;
                GTextureManager.createTextureAtlas(texture, xml, false);
            }
            if (type == AssetType.FONT) {
                var texture = GTextureManager.getTexture(id);
                var xml:Xml = cast(GStaticAssetManager.getAssetById(id), GXmlAsset).xml;
                GFontManager.createTextureFont(id, texture, xml);
            }
        }
        onCommandSucceed();
    }

    private function onAssetsFailed(asset:GAsset):Void {
        onCommandFailed(asset.url);
    }
}
