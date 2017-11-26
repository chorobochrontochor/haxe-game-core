/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound.js;

import howler.Howl;

class SoundJS implements ISound {

    private var _url:String;
    private var _id:String;

    public function new(url:String, id:String) {
        _url = url;
        _id = id;
    }

    public function play():ISoundChannel{
        var options:HowlOptions = {html5:true}; //{};
        options.src = [_url];
        options.autoplay = false;
        options.loop = true;

        var snd:Howl = new Howl(options);
        var playId:Int = snd.play();

        var soundChannel:ISoundChannel = new SoundChannelJS(snd,playId);
        return soundChannel;
    }

    public function getUrl():String {
        return _url;
    }

    public function getId():String {
        return _id;
    }
}
