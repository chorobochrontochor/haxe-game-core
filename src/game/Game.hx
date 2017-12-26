/*
 *	Copyright 11/25/2017 Michal Deak. All rights reserved.
 */
package game;

import com.genome2d.textures.GTextureFilteringType;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.Genome2D;
import com.genome2d.input.GMouseInput;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;
import core.timers.EveryFrameTimer;
import game.objects.Bunny;
import game.objects.Carrot;
import game.objects.NomNomNom;
import game.objects.ObjectBase;
import game.objects.Platform;

class Game {

    private static var _instance:Game;

    private static var PLATFORM_GAP:Int = 220;
    private static var PLATFORM_RANDOM_GAP:Int = 40;
    private static var SPEED:Float = 5;

    private static var STAGE_WIDTH:Float;
    private static var STAGE_HEIGHT:Float;

    private var _scene:GNode;

    private var _sky:GSprite;
    private var _skyScrollMax:Float;

    private var _score:Score;

    private var _bunny:Bunny;
    private var _platforms:Array<Platform>;
    private var _carrots:Array<Carrot>;

    private var _lastPlatformPositionY:Float;
    private var _lastMAximumBunnyPositionY:Float;

    public function new() {
        _instance = this;

        STAGE_WIDTH = Genome2D.getInstance().getContext().getStageViewRect().width;
        STAGE_HEIGHT = Genome2D.getInstance().getContext().getStageViewRect().height;

        init();
    }

    private function init():Void {

        Genome2D.getInstance().getContext().setBackgroundColor(0x89b6ff);

        _lastPlatformPositionY = 0;
        _lastMAximumBunnyPositionY = 0;

        _platforms = new Array<Platform>();
        _carrots = new Array<Carrot>();

        //Sky
        _sky = cast(GNode.createWithComponent(GSprite), GSprite);
        _sky.texture = GTextureManager.getTextureAtlas(AssetId.ATLAS_GAME).getSubTexture(AssetId.TEXTURE_SKY);
        _sky.texture.pivotY = 0.5 * _sky.texture.height;
        _sky.node.scaleX = STAGE_WIDTH / _sky.texture.width;
        _sky.node.scaleY = _sky.node.scaleX;
        _sky.node.x = STAGE_WIDTH / 2;
        _sky.node.y = STAGE_HEIGHT;
        _sky.texture.filteringType = GTextureFilteringType.NEAREST;
        Genome2D.getInstance().root.addChild(_sky.node);
        _skyScrollMax = _sky.texture.height * _sky.node.scaleY;

        //Scene
        _scene = new GNode();
        _scene.x = STAGE_WIDTH / 2;
        _scene.y = STAGE_HEIGHT / 2;
        Genome2D.getInstance().root.addChild(_scene);

        //Bunny
        _bunny = new Bunny();
        _bunny.getNode().y = -50;
        _scene.addChild(_bunny.getNode());

        spawnNextPlatform();

        //Score
        _score = new Score();
        Genome2D.getInstance().root.addChild(_score.getNode());
        _score.getNode().x = STAGE_WIDTH / 2;
        _score.getNode().y = 50;

        EveryFrameTimer.add(onFrame);
        Genome2D.getInstance().onMouseInput.add(onMouseInput);
    }

    private function onMouseInput(mouseInput:GMouseInput):Void {
        var bunnyLocation:Float = mouseInput.contextX - STAGE_WIDTH / 2;
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

                _score.addScore(1000);
                break;
            }
        }

        _bunny.onFrameUpdate();

        //Calculate score
        var newBunnyPositionY:Float = Math.min(_lastMAximumBunnyPositionY, _bunny.getNode().y);
        if(newBunnyPositionY < _lastMAximumBunnyPositionY){
            _score.addScore((_lastMAximumBunnyPositionY - newBunnyPositionY));
            _lastMAximumBunnyPositionY = newBunnyPositionY;
        }

        _scene.y += SPEED;

        //Move sky
        _sky.node.y += 0.05;
        if (_sky.node.y > _skyScrollMax) {
            _sky.node.y = _skyScrollMax;
        }

        //Bunny fall -> game restart
        if (_bunny.getNode().y > STAGE_HEIGHT - _scene.y) {
            restart();
        }
    }

    private function isObjectOutFromScreen(objectBase:ObjectBase):Bool {
        return objectBase.getNode().y > -_scene.y + STAGE_HEIGHT;
    }

    private function isBunnyHitCarrot(carrot:Carrot):Bool {
        var bunnyLocationX:Float = _bunny.getNode().x;
        var bunnyLocationY:Float = _bunny.getNode().y + _bunny.SIZE_HEGITH / 2;
        var additionalOffset:Int = 50;

        if (bunnyLocationX > carrot.getBoundingBox().x - additionalOffset && bunnyLocationX < carrot.getBoundingBox().width + additionalOffset &&
        bunnyLocationY > carrot.getBoundingBox().y - additionalOffset && bunnyLocationY < carrot.getBoundingBox().height + additionalOffset) {
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

        platform.getNode().x = platform.SIZE_WIDTH / 2 + Math.random() * (STAGE_WIDTH - platform.SIZE_WIDTH) - STAGE_WIDTH / 2;
        platform.getNode().y = _lastPlatformPositionY - Math.random() * PLATFORM_RANDOM_GAP - PLATFORM_GAP ;

        //Spawn carrot
        if (Math.round(Math.random()) == 0) {
            var carrot:Carrot = new Carrot();
            _carrots.push(carrot);
            _scene.addChild(carrot.getNode());
            carrot.getNode().x = platform.getNode().x;
            carrot.getNode().y = platform.getNode().y - 20;
            carrot.refreshBoundingBox();
        }

        _lastPlatformPositionY = platform.getNode().y;

        return platform;
    }

    public function destroy():Void {
        EveryFrameTimer.remove(onFrame);
        Genome2D.getInstance().onMouseInput.remove(onMouseInput);

        for (carrot in _carrots) {
            carrot.destroy();
        }
        for (platform in _platforms) {
            platform.destroy();
        }
        _bunny.destroy();

        if (_sky.node.parent != null) {
            _sky.node.parent.removeChild(_sky.node);
            _sky = null;
        }

        _score.destroy();
    }

    static public function restart():Void {
        _instance.destroy();
        _instance = null;
        new Game();
    }
}