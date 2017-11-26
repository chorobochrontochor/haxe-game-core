/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core;

import core.command.base.CommandStack;
import core.command.InitializeAssetsCommand;
import core.command.InitializeAssetsCommandData;
import core.command.InitializeGenomeCommand;
import core.logger.Logger;
import haxe.Constraints.Function;

class Initialization {

    private var _onSucceedCallback:Function;
    private var _onFailedCallback:Function;

    private var _assetData:Array<InitializeAssetsCommandData>;

    public function new(onSucceedCallback:Function, onFailedCallback:Function = null) {
        _onSucceedCallback = onSucceedCallback;
        _onFailedCallback = onFailedCallback;
    }

    public function init(assetData:Array<InitializeAssetsCommandData>):Void {
        var commandStack:CommandStack = new CommandStack(onInitializationSucceed, onInitializationFailed);
        commandStack.add(new InitializeGenomeCommand());
        commandStack.add(new InitializeAssetsCommand(assetData));
        commandStack.start();
    }

    private function onInitializationSucceed():Void {
        _onSucceedCallback();
    }

    private function onInitializationFailed():Void {
        Logger.error("Initialization failed!", null, true);

        if (_onFailedCallback != null) {
            _onFailedCallback();
        }
    }
}
