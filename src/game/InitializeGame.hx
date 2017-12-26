/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package game;
import core.command.InitializeAssetsCommandData;
import core.enums.AssetType;
import core.Initialization;
class InitializeGame {

    public function new() {

        //Initialization
        var initialization:Initialization = new Initialization(onInit);
        var assetData:Array<InitializeAssetsCommandData> = [
            new InitializeAssetsCommandData("textures/game_atlas.png", AssetId.ATLAS_GAME, AssetType.TEXTURE),
            new InitializeAssetsCommandData("textures/game_atlas.xml", AssetId.ATLAS_GAME, AssetType.TEXTURE_ATLAS_XML),

            new InitializeAssetsCommandData("sounds/test_sound.mp3", AssetId.SOUND_TEST, AssetType.SOUND),

            new InitializeAssetsCommandData("font/font.png", AssetId.FONT_GAME, AssetType.TEXTURE),
            new InitializeAssetsCommandData("font/font.fnt", AssetId.FONT_GAME, AssetType.FONT)
        ];
        initialization.init(assetData);
    }

    public function onInit():Void {
        new Game();
    }
}
