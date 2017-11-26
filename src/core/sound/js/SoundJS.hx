/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound.js;

class SoundJS implements ISound {

    private var _url:String;
    private var _id:String;

    public function new(url, id) {
        _url = url;
        _id = id;

//        var options:HowlOptions = {};
//        options.src = ["assets/sounds/test_sound.mp3"];
//        options.autoplay = false;
//        options.loop = true;
//        var snd:Howl = new Howl(options);
//        snd.play();
    }

    public function play():ISoundChannel{
        return null;
    }

    public function getUrl():String {
        return _url;
    }

    public function getId():String {
        return _id;
    }
}
