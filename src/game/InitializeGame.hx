/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package game;
import core.Initialization;
import core.enums.AssetType;
import core.command.InitializeAssetsCommandData;
class InitializeGame {

    public function new() {

        //Initialization
        var initialization:Initialization = new Initialization(onInit);
        var assetData:Array<InitializeAssetsCommandData> = [
            new InitializeAssetsCommandData("textures/game_atlas.png", AssetId.TEXTURE_GAME_ATLAS, AssetType.TEXTURE),
            new InitializeAssetsCommandData("textures/game_atlas.xml", AssetId.TEXTURE_GAME_ATLAS, AssetType.TEXTURE_ATLAS_XML),
            new InitializeAssetsCommandData("sounds/test_sound.mp3", AssetId.SOUND_TEST, AssetType.SOUND)
        ];
        initialization.init(assetData);
    }

    public function onInit():Void {
        new Game();
    }
}
