/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package ;

import core.command.base.CommandStack;
import core.command.InitializeAssetsCommand;
import core.command.InitializeGenomeCommand;
import core.logger.Logger;

class Initialization {

    public function new() {
        var commandStack:CommandStack = new CommandStack(onInitializationSucceed, onInitializationFailed);

        commandStack.add(new InitializeGenomeCommand());

        var assetData:Array<Array<String>> = [["textures/test.png", "test", InitializeAssetsCommand.ASSET_TEXTURE]];
        commandStack.add(new InitializeAssetsCommand(assetData));

        commandStack.start();
    }

    private function onInitializationSucceed():Void {
        new Game();
    }

    private function onInitializationFailed():Void {
        Logger.error("Nieco je zle :( ... ", null, true);
    }
}
