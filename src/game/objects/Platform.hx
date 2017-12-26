/*
 *	Copyright 12/24/2017 Michal Deak. All rights reserved.
 */
package game.objects;

import com.genome2d.textures.GTextureManager;

class Platform extends ObjectBase {

    public function new() {

        var rand:Int = Math.round(Math.random()*3);
        var textureId:String = "";

        if(rand == 0){
            textureId = AssetId.TEXTURE_PLATFORM1;
        }
        if(rand == 1){
            textureId = AssetId.TEXTURE_PLATFORM2;
        }
        if(rand == 2){
            textureId = AssetId.TEXTURE_PLATFORM3;
        }
        if(rand == 3){
            textureId = AssetId.TEXTURE_PLATFORM4;
        }
        super(GTextureManager.getTextureAtlas(AssetId.ATLAS_GAME).getSubTexture(textureId), 0.5, 0);
    }
}
