/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package core.timers;
import com.genome2d.Genome2D;
import core.logger.Logger;
import haxe.Constraints.Function;
class EveryFrameTimer {

    static private var _instance:EveryFrameTimer;

    private var _callbacks:Array<Function>;

    public function new() {
        _callbacks = new Array<Function>();

        Genome2D.getInstance().onUpdate.add(onTick);

        _instance = this;
    }

    private function onTick(ms:Float):Void {
        for (i in 0 ... _callbacks.length) {
            _callbacks[i](ms);
        }
    }

    public function addCallback(callback:Function):Void {
        for (i in 0 ... _callbacks.length) {
            if (_callbacks[i] == callback) {
                Logger.log("You already added this EveryFrameTimer callback! - ", [callback]);
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
        Logger.log("Nothing to remove EveryFrameTimer callback! - ", [callback]);
    }

    static public function add(callback:Function):Void {
        if (_instance == null) {
            new EveryFrameTimer();
        }
        _instance.addCallback(callback);
    }

    static public function remove(callback:Function):Void {
        if (_instance == null) {
            new EveryFrameTimer();
        }
        _instance.removeCallback(callback);
    }
}
