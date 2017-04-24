
import Luxe;
import luxe.Parcel;
import luxe.ParcelProgress;

import luxe.Color;
import luxe.Vector;

import luxe.Entity;
import luxe.options.SpriteOptions;

import Furniture;
import Actor;
import Prop;

typedef SceneData = {
    var furniture:Array<FurnitureOptions>;
    var actors:Array<ActorOptions>;
    var props:Array<PropOptions>;
    var dialogue:Array<DialogueLine>;
    var target:Float;
}

typedef DialogueLine = {
    var actor:String;
    var text:String;
    var duration:Float;
}

typedef StartEvent = {
    var target_time:Float;
}

class Sketch extends Entity {
    var dialogue_iter:Iterator<DialogueLine>;
    var actors:Map<String, Actor> = new Map();

    public function new(_name:String) {
        super({ name: _name});
        var promise = Luxe.resources.load_json('assets/sketch_${name}.json');
        promise.then(config_loaded);
    }

    function config_loaded(_) {
        var config:SceneData = Luxe.resources.json('assets/sketch_${name}.json').asset.json;
        dialogue_iter = config.dialogue.iterator();

        var jsons:Array<JSONInfo> = [];
        var textures:Array<TextureInfo> = [];
        for (item in config.furniture) {
            textures.push({ id: item.texture_id });
            if (item.animation_id != null) jsons.push({ id: item.animation_id });
        }
        for (item in config.props) {
            textures.push({ id: item.texture_id });
            if (item.animation_id != null) jsons.push({ id: item.animation_id });
        }
        for (item in config.actors) {
            textures.push({ id: item.texture_id });
            if (item.animation_id != null) jsons.push({ id: item.animation_id });
        }

        var parcel = new Parcel({jsons: jsons, textures: textures});
        new ParcelProgress({
            parcel: parcel,
            background: new Color(0, 0, 0, 0.85),
            oncomplete: assets_loaded.bind(config),
        });
        parcel.load();
    }

    function assets_loaded(config:SceneData, _) {
        for (item in config.furniture) (new Furniture(item)).parent = this;
        for (item in config.actors) (actors[item.name] = new Actor(item)).parent = this;
        for (item in config.props) (new Prop(item)).parent = this;

        Luxe.events.fire('sketch.start', { target_time: config.target });
        read_dialogue();
    }

    function read_dialogue() {
        if (!destroyed && dialogue_iter.hasNext()) {
            var line = dialogue_iter.next();
            actors[line.actor].say(line.text, line.duration);
            Luxe.timer.schedule(line.duration, read_dialogue);
        }
    }

}
