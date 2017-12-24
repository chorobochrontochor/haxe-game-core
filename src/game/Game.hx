/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package game;

import com.genome2d.Genome2D;
import com.genome2d.input.GMouseInput;
import com.genome2d.node.GNode;
import core.timers.EveryFrameTimer;
import game.objects.Bunny;
import game.objects.Platform;

class Game {

    private static var PLATFORM_GAP:Int = 160;
    private static var SPEED:Float = 5;

    private var _scene:GNode;
    private var _bunny:Bunny;
    private var _platforms:Array<Platform>;

    private var _bunnyLocationX:Float = 0;
    private var _lastPlatformLocationY:Float = 0;

    public function new() {
        createScene();
    }

    private function createScene():Void {

        Genome2D.getInstance().getContext().setBackgroundColor(0x89b6ff);

        _platforms = new Array<Platform>();

        //Scene
        _scene = new GNode();
        _scene.x = Genome2D.getInstance().getContext().getStageViewRect().width / 2;
        _scene.y = Genome2D.getInstance().getContext().getStageViewRect().height / 2;
        Genome2D.getInstance().root.addChild(_scene);

        //Bunny
        _bunny = new Bunny();
        _bunny.getNode().y = -50;
        _scene.addChild(_bunny.getNode());

        //Floor platform
        var floor:Platform = new Platform();
        _platforms.push(floor);
        floor.getNode().scaleX = floor.getNode().scaleY = 10;
        _scene.addChildAt(floor.getNode(), 0);

        EveryFrameTimer.add(onFrame);
        Genome2D.getInstance().onMouseInput.add(onMouseInput);
    }

    private function onMouseInput(mouseInput:GMouseInput):Void {
        var newLocation:Float = mouseInput.contextX - Genome2D.getInstance().getContext().getStageViewRect().width / 2;
        if (_bunnyLocationX < newLocation) {
            _bunny.getNode().scaleX = -Math.abs(_bunny.getNode().scaleX);
        } else {
            _bunny.getNode().scaleX = Math.abs(_bunny.getNode().scaleX);
        }
        _bunnyLocationX = newLocation;
    }

    private function onFrame(delta:Float):Void {
        //Set bunny horizontal location
        _bunny.getNode().x = _bunnyLocationX;

        //Generate new platforms above bunny
        while (_platforms[_platforms.length - 1].getNode().y > -_scene.y) {
            spawnNextPlatform();
        }

        //Destroy old platforms behind bunny
        while (_platforms[0].getNode().y > -_scene.y + Genome2D.getInstance().getContext().getStageViewRect().height) {
            _platforms[0].destroy();
            _platforms[0] = null;
            _platforms.splice(0, 1);
        }

        //Check bunny and platforms
        for (platform in _platforms) {
            if (_bunny.isFalling() && bunnyHitPlatform(platform)) {
                _bunny.getNode().y = platform.getNode().y;
                _bunny.jump();
                break;
            }
        }

        _bunny.update();

        _scene.y += SPEED;
    }

    private function bunnyHitPlatform(platform:Platform):Bool {
        var platformCornerLeft:Float = platform.getNode().x - Platform.SIZE_PLATFORM / 2;
        var platformCornerRight:Float = platform.getNode().x + Platform.SIZE_PLATFORM / 2;
        var bunnyLeftCorner:Float = _bunny.getNode().x - Bunny.SIZE_BUNNY / 2 * 0.75;
        var bunnyRightCorner:Float = _bunny.getNode().x + Bunny.SIZE_BUNNY / 2 * 0.75;

        //Hit floor
        if (_bunny.getNode().y > 0) {
            return true;
        }

        //Vertical check
        if (_bunny.getNode().y <= platform.getNode().y && _bunny.getNextFrameLocation() >= platform.getNode().y) {
            //Horizontal check
            var isOutFromPlatform:Bool = bunnyRightCorner < platformCornerLeft || bunnyLeftCorner > platformCornerRight;
            if (!isOutFromPlatform) {
                return true;
            }
        }
        return false;
    }

    private function spawnNextPlatform():Platform {
        var platform:Platform = new Platform();
        _platforms.push(platform);
        _scene.addChildAt(platform.getNode(), 0);

        platform.getNode().x = Platform.SIZE_PLATFORM / 2 + Math.random() * (Genome2D.getInstance().getContext().getStageViewRect().width - Platform.SIZE_PLATFORM) - Genome2D.getInstance().getContext().getStageViewRect().width / 2;
        platform.getNode().y = _lastPlatformLocationY - PLATFORM_GAP;

        _lastPlatformLocationY = platform.getNode().y;

        return platform;
    }
}