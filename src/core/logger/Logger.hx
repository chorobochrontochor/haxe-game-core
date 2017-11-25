/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package core.logger;
import haxe.CallStack.StackItem;
import String;

class Logger {

    static private var TYPE_ERROR:String = "error";
    static private var TYPE_LOG:String = "log";

    public function new() {
    }

    /**
    * Get class info
    **/
    static private function getClassInfo(pos:haxe.PosInfos):String {
        return pos.className + ".hx::" + pos.methodName + "():" + pos.lineNumber + " - ";
    }

    /**
    * Print callstack
    **/
    static public function printCallStack():Void {
        var callstack:Array<StackItem> = haxe.CallStack.callStack();

        callstack.reverse();
        //Because we want cut off Logger method from here
        callstack.splice(callstack.length - 2, 2);

        haxe.Log.trace(
            haxe.CallStack.toString(callstack)
        );
    }

    /**
    * Prepare data to print
    **/
    static public function traceData(type:String, text:String, params:Array<Dynamic> = null, showCallStack:Bool = false, ?pos:haxe.PosInfos):Void {
        if (showCallStack) {
            printCallStack();
        }

        var str:String = "";
        if (type == TYPE_LOG) {
            str = "#Log -";
        } else if (type == TYPE_ERROR) {
            str = "#Error -";
        }

        str += getClassInfo(pos) + text + " ";
        if (params != null) {
            str += "[";
            for (param in params) {
                if (Std.is(param, String) || Std.is(param, Int) || Std.is(param, Float)) {
                    str += param;
                } else {
                    str += Type.getClass(param);
                }
            }
            str += "]";
        }
        haxe.Log.trace(str);
    }

    //-------------------------------------------------------------------------------------------------
    //
    // Public
    //
    //-------------------------------------------------------------------------------------------------

    /**
    * Method print text to screen
    *
    * @param text - text to print
    * @param params - custom object to print
    * @param printCallStack - if true, print callstack
    **/
    static public function log(text:String, params:Array<Dynamic> = null, showCallStack:Bool = false, ?pos:haxe.PosInfos):Void {
        traceData(TYPE_LOG, text, params, showCallStack, pos);
    }

    /**
    * Method print text to screen
    *
    * @param text - text to print
    * @param params - custom object to print
    * @param printCallStack - if true, print callstack
    **/
    static public function error(text:String, params:Array<Dynamic> = null, showCallStack:Bool = false, ?pos:haxe.PosInfos):Void {
        traceData(TYPE_ERROR, text, params, showCallStack, pos);
    }
}
