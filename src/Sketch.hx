
import Luxe;
import luxe.Parcel;
import luxe.ParcelProgress;

import luxe.Color;
import luxe.Vector;

import luxe.Scene;
import luxe.options.SpriteOptions;

import Furniture;
import Actor;

typedef SceneData = {
    var furniture:Array<FurnitureOptions>;
    var actors:Array<ActorOptions>;
    /*
    var props:Array<PropData>;
    */
}

/*
typedef SpriteData = {
    var name:String;
    var image:String;
    @:optional var anim:String;
    var x:Float;
    var y:Float;
    var depth:Float;
    @:optional var centered:Bool;
}

typedef AnimationData = {
    var json: String;
    var _default: String;
}

typedef PropData = {
    >SpriteData;
}

typedef ActorData {
    >SpriteData;
    var is_player:Bool:
}
*/

class Sketch {
    var name:String;
    public function new(_name:String) {
        name = _name;
        var promise = Luxe.resources.load_json('assets/$name/scene.json');
        promise.then(config_loaded);
    }

    function config_loaded(_) {
        var config:SceneData = Luxe.resources.json('assets/$name/scene.json').asset.json;

        var jsons = new Array<JSONInfo>();
        var textures = new Array<TextureInfo>();
        for (item in config.furniture) {
            textures.push({ id: item.texture_id });
            if (item.animation_id != null) jsons.push({ id: item.animation_id });
        }
        /*
        for (item in config.props) {
            textures.push({ id: 'assets/$name/${item.texture}' });
            if (item.anim != null) jsons.push({ id: 'assets/$name/${item.anim}' });
        }
        */
        for (item in config.actors) {
            textures.push({ id: item.texture_id });
            if (item.animation_id != null) jsons.push({ id: item.animation_id });
        }

        var parcel = new Parcel({jsons: jsons, textures: textures});
        new ParcelProgress({
            parcel: parcel,
            background: new Color(1, 1, 1, 0.85),
            oncomplete: assets_loaded.bind(config),
        });
        parcel.load();
    }

    function assets_loaded(config:SceneData, _) {
        for (item in config.furniture) Luxe.scene.add(new Furniture(item));
        for (item in config.actors) {
            var actor = new Actor(item);
            Luxe.scene.add(actor);
            actor.say("hello world");
        }
    }
}
