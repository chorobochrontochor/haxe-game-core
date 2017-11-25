/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core.command.base;

import core.logger.Logger;
import haxe.Constraints.Function;

class CommandStack {

    private var _onSucceedCallback:Function;
    private var _onFailedCallback:Function;

    private var _stackCommands:Array<Command>;

    private var _isRunning:Bool;

    public function new(onSucceedCallback:Function, onFailedCallback:Function) {
        _onSucceedCallback = onSucceedCallback;
        _onFailedCallback = onFailedCallback;

        _stackCommands = new Array<Command>();
        _isRunning = false;
    }

    /**
    * This method is called only from Command !
    **/
    inline public function nextCommand():Void {
        if (_stackCommands.length == 0) {
            _onSucceedCallback();
            return;
        }

        var command:Command = _stackCommands.shift();
        command.setCommandStack(this);
        Logger.log("Command executing", [Type.getClassName(Type.getClass(command))]);
        command.execute();
    }

    //-------------------------------------------------------------------------------------------------
    //
    // Public
    //
    //-------------------------------------------------------------------------------------------------

    public function add(command:Command):Void {
        _stackCommands.push(command);
    }

    public function start():Void {
        if (!_isRunning) {
            nextCommand();
        } else {
            Logger.error("You cant call start more then once!!!", null, true);
        }
    }
}
