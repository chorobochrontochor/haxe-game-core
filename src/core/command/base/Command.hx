/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core.command.base;

import core.logger.Logger;
class Command implements ICommand {

    private var _commandStack:CommandStack;

    public function new() {
    }

    public function execute():Void {
    }

    public function setCommandStack(commandStack:CommandStack):Void{
        _commandStack = commandStack;
    }

    private function onCommandSucceed():Void {
        if (_commandStack != null) {
            _commandStack.nextCommand();
        }
    }

    private function onCommandFailed(msg:String = ""):Void {
        Logger.error("Command failed ("+msg+")", [Type.getClassName(Type.getClass(this))], true);

        if (_commandStack != null) {
            _commandStack.nextCommand();
        }
    }
}
