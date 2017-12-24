/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package core.timers;
import core.logger.Logger;
import haxe.Constraints.Function;
import haxe.Timer;
class EverySecondTimer {

    static private var _instance:EverySecondTimer;

    private var _callbacks:Array<Function>;
    private var _timer:Timer;

    public function new() {
        _callbacks = new Array<Function>();

        _timer = new Timer(1000);
        _timer.run = onTick;

        _instance = this;
    }

    private function onTick():Void {
        for (i in 0 ... _callbacks.length) {
            _callbacks[i]();
        }
    }

    public function addCallback(callback:Function):Void {
        for (i in 0 ... _callbacks.length) {
            if (_callbacks[i] == callback) {
                Logger.log("You already added this EverySecondTimer callback! - ", [callback]);
                return;
            }
        }
        _callbacks.push(callback);
    }

    public function removeCallback(callback:Function) {
        for (i in 0 ... _callbacks.length) {
            if (_callbacks[i] == callback) {
                _callbacks.splice(i, 1);
                return;
            }
        }
        Logger.log("Nothing to remove EverySecondTimer callback! - ", [callback]);
    }

    static public function add(callback:Function):Void {
        if (_instance == null) {
            new EverySecondTimer();
        }
        _instance.addCallback(callback);
    }

    static public function remove(callback:Function):Void {
        if (_instance == null) {
            new EverySecondTimer();
        }
        _instance.removeCallback(callback);
    }
}
