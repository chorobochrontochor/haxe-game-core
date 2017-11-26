/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package ;

import core.command.InitializeAssetsCommandData;
import core.enums.AssetType;
import core.Initialization;

class Main {

    static public function main() {

        //Initialization
        var initialization:Initialization = new Initialization(onInit);
        var assetData:Array<InitializeAssetsCommandData> = [
            new InitializeAssetsCommandData("textures/test.png", "test", AssetType.TEXTURE),
            new InitializeAssetsCommandData("textures/test_atlas.png", "test_atlas", AssetType.TEXTURE),
            new InitializeAssetsCommandData("textures/test_atlas.xml", "test_atlas", AssetType.TEXTURE_ATLAS_XML),
            new InitializeAssetsCommandData("sounds/test_sound.mp3", "test_sound", AssetType.SOUND)
        ];
        initialization.init(assetData);
    }

    static public function onInit():Void {
        new Game();
    }
}
