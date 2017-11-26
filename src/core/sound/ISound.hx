/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.sound;
interface ISound {
    function play():ISoundChannel;
    function getUrl():String;
    function getId():String;
}
