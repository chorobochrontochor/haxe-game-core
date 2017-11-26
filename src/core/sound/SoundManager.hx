/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound;

#if flash
import core.sound.flash.SoundFlash;
#end

#if js
import core.sound.js.SoundJS;
#end

import core.logger.Logger;
import haxe.ds.StringMap;

class SoundManager {

    static private var _instance:SoundManager;
    static private var _soundCache:StringMap<ISound>;

    public function new() {
        _soundCache = new StringMap<ISound>();
    }

    private function playSound(soundId:String):ISoundChannel {
        if(!_soundCache.exists(soundId)){
            Logger.error("Sound '"+soundId+"' is not cached!");
        }

        var sound:ISound = _soundCache.get(soundId);
        return sound.play();
    }

    private function addSoundFromUrl(url:String, id:String):Void{
        var sound:ISound;

        #if flash
        sound = new SoundFlash(url, id);
        #end

        #if js
        sound = new SoundJS(url, id);
        #end

        _soundCache.set(id, sound);
    }

    static private function getInstance():SoundManager {
        if (_instance == null) {
            _instance = new SoundManager();
        }
        return _instance;
    }

    //-------------------------------------------------------------------------------------------------
    //
    // Public
    //
    //-------------------------------------------------------------------------------------------------

    static public function play(soundId:String):ISoundChannel {
        return getInstance().playSound(soundId);
    }

    static public function addFromUrl(url:String, id:String):Void {
        getInstance().addSoundFromUrl(url, id);
    }
}
