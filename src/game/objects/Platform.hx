/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package game.objects;

import com.genome2d.textures.GTextureManager;

class Platform extends ObjectBase {

    public function new() {
        super(GTextureManager.getTextureAtlas(AssetId.TEXTURE_GAME_ATLAS).getSubTexture(AssetId.TEXTURE_PLATFORM), 0.5, 0);
    }
}
