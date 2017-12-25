/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package game;

import com.genome2d.Genome2D;
import com.genome2d.input.GMouseInput;
import com.genome2d.node.GNode;
import core.timers.EveryFrameTimer;
import game.objects.Bunny;
import game.objects.Carrot;
import game.objects.NomNomNom;
import game.objects.ObjectBase;
import game.objects.Platform;

class Game {

    private static var PLATFORM_GAP:Int = 220;
    private static var PLATFORM_RANDOM_GAP:Int = 40;
    private static var SPEED:Float = 6;

    private var _scene:GNode;
    private var _bunny:Bunny;
    private var _platforms:Array<Platform>;
    private var _carrots:Array<Carrot>;

    private var _lastPlatformPositionY:Float = 0;

    public function new() {
        createScene();
    }

    private function createScene():Void {

        Genome2D.getInstance().getContext().setBackgroundColor(0x89b6ff);

        _platforms = new Array<Platform>();
        _carrots = new Array<Carrot>();

        //Scene
        _scene = new GNode();
        _scene.x = Genome2D.getInstance().getContext().getStageViewRect().width / 2;
        _scene.y = Genome2D.getInstance().getContext().getStageViewRect().height / 2;
        Genome2D.getInstance().root.addChild(_scene);

        //Bunny
        _bunny = new Bunny();
        _bunny.getNode().y = -50;
        _scene.addChild(_bunny.getNode());

        spawnNextPlatform();

        EveryFrameTimer.add(onFrame);
        Genome2D.getInstance().onMouseInput.add(onMouseInput);
    }

    private function onMouseInput(mouseInput:GMouseInput):Void {
        var bunnyLocation:Float = mouseInput.contextX - Genome2D.getInstance().getContext().getStageViewRect().width / 2;
        _bunny.setBunnyPositionX(bunnyLocation);
    }

    private function onFrame(delta:Float):Void {
        //Generate new platforms above bunny
        while (_platforms[_platforms.length - 1].getNode().y > -_scene.y) {
            spawnNextPlatform();
        }

        //Destroy old platforms behind bunny
        while (_platforms.length > 0 && isObjectOutFromScreen(_platforms[0])) {
            _platforms[0].destroy();
            _platforms[0] = null;
            _platforms.splice(0, 1);
        }

        //Destroy old carrots behind bunny
        while (_carrots.length > 0 && isObjectOutFromScreen(_carrots[0])) {
            _carrots[0].destroy();
            _carrots[0] = null;
            _carrots.splice(0, 1);
        }

        //Check bunny and platforms
        for (platform in _platforms) {
            if (_bunny.isFalling() && isBunnyHitPlatform(platform)) {
                _bunny.getNode().y = platform.getNode().y;
                _bunny.jump();
                break;
            }
        }

        //Check bunny and carrots
        for (i in 0 ... _carrots.length) {
            var carrot:Carrot = _carrots[i];
            if (isBunnyHitCarrot(carrot)) {
                //Spawn nom nom nom
                var nomnomnom:NomNomNom = new NomNomNom();
                _scene.addChild(nomnomnom.getNode());
                nomnomnom.getNode().x = carrot.getNode().x;
                nomnomnom.getNode().y = carrot.getNode().y - carrot.SIZE_HEGITH / 2;

                carrot.destroy();
                _carrots.splice(i, 1);
                break;
            }
        }

        _bunny.onFrameUpdate();

        _scene.y += SPEED;
    }

    private function isObjectOutFromScreen(objectBase:ObjectBase):Bool {
        return objectBase.getNode().y > -_scene.y + Genome2D.getInstance().getContext().getStageViewRect().height;
    }

    private function isBunnyHitCarrot(carrot:Carrot):Bool {
        var bunnyLocationX:Float = _bunny.getNode().x;
        var bunnyLocationY:Float = _bunny.getNode().y + _bunny.SIZE_HEGITH / 2;

        if (bunnyLocationX > carrot.getBoundingBox().x && bunnyLocationX < carrot.getBoundingBox().width &&
        bunnyLocationY > carrot.getBoundingBox().y && bunnyLocationY < carrot.getBoundingBox().height) {
            return true;
        }
        return false;
    }

    private function isBunnyHitPlatform(platform:Platform):Bool {
        var platformCornerLeft:Float = platform.getNode().x - platform.SIZE_WIDTH / 2;
        var platformCornerRight:Float = platform.getNode().x + platform.SIZE_WIDTH / 2;
        var bunnyLeftCorner:Float = _bunny.getNode().x - _bunny.SIZE_WIDTH / 2 * 0.75;
        var bunnyRightCorner:Float = _bunny.getNode().x + _bunny.SIZE_WIDTH / 2 * 0.75;

        //Hit floor
        if (_bunny.getNode().y > 0) {
            return true;
        }

        //Vertical check
        if (_bunny.getNode().y - 10 <= platform.getNode().y && _bunny.getNextFrameBunnyPositionY() >= platform.getNode().y) {
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

        platform.getNode().x = platform.SIZE_WIDTH / 2 + Math.random() * (Genome2D.getInstance().getContext().getStageViewRect().width - platform.SIZE_WIDTH) - Genome2D.getInstance().getContext().getStageViewRect().width / 2;
        platform.getNode().y = _lastPlatformPositionY - Math.random() * PLATFORM_RANDOM_GAP - PLATFORM_GAP ;

        //Spawn carrot
        if (Math.round(Math.random()) == 0) {
            var carrot:Carrot = new Carrot();
            _carrots.push(carrot);
            _scene.addChild(carrot.getNode());
            carrot.getNode().x = platform.getNode().x;
            carrot.getNode().y = platform.getNode().y;
            carrot.refreshBoundingBox();
        }

        _lastPlatformPositionY = platform.getNode().y;

        return platform;
    }
}