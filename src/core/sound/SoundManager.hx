/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound;
#if js
import howler.Howl;
#end
class SoundManager {
    public function new() {
    }

    //TODO

    static public function test(){
        #if js
        //Sound test - ONLY JS
        var options:HowlOptions = {};
        options.src = ["assets/sounds/test_sound.mp3"];
        options.autoplay = false;
        options.loop = true;
        var snd:Howl = new Howl(options);
        snd.play();
        #end
    }
}
