/*
 *	Copyright 11/26/2017 Michal Deak. All rights reserved.
 */
package core.command;
import core.enmus.AssetType;

class InitializeAssetsCommandData {

    public var url(default, null):String;
    public var id(default, null):String;
    public var type(default, null):AssetType;

    public function new(url:String, id:String, type:AssetType) {
        this.url = url;
        this.id = id;
        this.type = type;
    }
}
