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
        var assetData:Array<InitializeAssetsCommandData> = [new InitializeAssetsCommandData("textures/test.png", "test", AssetType.ASSET_TEXTURE)];
        initialization.init(assetData);
    }

    static public function onInit():Void {
        new Game();
    }
}
