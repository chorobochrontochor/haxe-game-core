/*
 *	Copyright 12/25/2017 Michal Deak. All rights reserved.
 */
package game.objects;

import com.genome2d.textures.GTextureManager;
import core.timers.EverySecondTimer;

class NomNomNom extends ObjectBase {

    private var timeCounter:Int = 1;

    public function new() {
        super(GTextureManager.getTextureAtlas(AssetId.ATLAS_GAME).getSubTexture(AssetId.TEXTURE_NOMNOMNOM), 0.5, 1);

        EverySecondTimer.add(onTick);
    }

    private function onTick():Void {
        timeCounter--;

        if (timeCounter == 0) {
            destroy();
        }
    }

    override public function destroy():Void {
        EverySecondTimer.remove(onTick);
        super.destroy();
    }
}
