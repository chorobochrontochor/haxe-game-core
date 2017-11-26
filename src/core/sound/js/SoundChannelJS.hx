/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound.js;

import howler.Howl;

class SoundChannelJS implements ISoundChannel{

    private var _soundChannel:Howl;
    private var _id:Int;

    public function new(soundChannel:Howl, id:Int) {
        _soundChannel = soundChannel;
        _id = id;
    }

    public function stop():Void{
        _soundChannel.stop(_id);
    }
}
