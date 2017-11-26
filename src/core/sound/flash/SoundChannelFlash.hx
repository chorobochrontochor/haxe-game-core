/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound.flash;

import flash.media.SoundChannel;

class SoundChannelFlash implements ISoundChannel{

    private var _soundChannel:SoundChannel;

    public function new(soundChannel:SoundChannel) {
        _soundChannel = soundChannel;
    }

    public function stop():Void{
        _soundChannel.stop();
    }
}
