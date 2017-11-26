/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound.flash;
import core.logger.Logger;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;

class SoundFlash implements ISound {

    private var _url:String;
    private var _id:String;

    private var _sound:Sound;
    private var _isReady:Bool = true;

    public function new(url, id) {
        _url = url;
        _id = id;

        _sound = new Sound();
        _sound.addEventListener(Event.COMPLETE, onLoadComplete);
        _sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);

        var req:URLRequest = new URLRequest(_url);
        _sound.load(req);
    }

    private function onLoadComplete(event:Event):Void {
        _isReady = true;
    }

    private function onIOError(event:IOErrorEvent) {
        Logger.error("The sound could not be loaded: " + event.text, null, true);
    }

    public function play():ISoundChannel {
        if (_isReady) {
            var sChannel:SoundChannel = _sound.play();
            var soundChannel:ISoundChannel = new SoundChannelFlash(sChannel);
            return soundChannel;
        }
        return null;
    }

    public function getUrl():String {
        return _url;
    }

    public function getId():String {
        return _id;
    }
}
