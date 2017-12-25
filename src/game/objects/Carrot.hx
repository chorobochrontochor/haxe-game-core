/*
 *	Copyright 12/25/2017 Michal Deak. All rights reserved.
 */
package game.objects;

import com.genome2d.textures.GTextureManager;

class Carrot extends ObjectBase{

    public function new() {
        super(GTextureManager.getTextureAtlas(AssetId.TEXTURE_GAME_ATLAS).getSubTexture(AssetId.TEXTURE_CARROT), 0.5, 1);
    }
}
