
import luxe.Vector;
import luxe.Sprite;
import luxe.components.sprite.SpriteAnimation;
import luxe.options.SpriteOptions;

import phoenix.Texture;

import types.SimpleVector;
import types.SpriteOptions;

typedef ActorOptions = {
    > SpriteOptions,
    var is_player:Bool;
    var can_move:Bool;
}

class Actor extends Sprite {
    public var anim:SpriteAnimation;
    public var speech:Speech;
    public var has_fish:Bool = false;

    override public function new(options:ActorOptions) {
        var texture = Luxe.resources.texture(options.texture_id);
        texture.filter_min = texture.filter_mag = FilterType.nearest;

        var size = if (options.size != null) {
            new Vector(options.size.x, options.size.y);
        } else {
            new Vector(texture.width, texture.height);
        }

        var position = if (options.position != null) {
            new Vector(options.position.x, options.position.y);
        } else {
            new Vector(texture.width, texture.height);
        }

        super({
            name: options.name,
            texture: texture,
            size: Utils.pix2screen(size),
            pos: Utils.pix2screen(position),
            depth: options.depth,
            centered: options.centered,
        });

        speech = add(new Speech({ name: '$name/speech' }));

        if (options.animation_id != null) {
            anim = add(new SpriteAnimation({ name: '$name/anim' }));
            var anim_data = Luxe.resources.json(options.animation_id);
            anim.add_from_json_object(anim_data.asset.json);
            anim.animation = 'idle';
            anim.play();
        }

        if (options.is_player) {
            if (options.can_move) add(new PlayerMovement({ name: '$name/movement' }));
            add(new PlayerInteract({ name: '$name/interact' }));
        }
    }

    public function say(text:String, duration:Float) {
        if (speech != null) speech.say(text, duration);
    }

    public function give_fish() {
        has_fish = true;
        switch (anim.animation) {
            case 'idle': anim.animation = 'fish_idle';
            case 'walk': anim.animation = 'fish_walk';
        }
        remove('$name/interact');
        add(new PlayerSlap({ name: '$name/slap' }));
    }

    public function set_walking() {
        anim.animation = if (has_fish) 'fish_walk'; else 'walk';
    }

    public function set_idle() {
        anim.animation = if (has_fish) 'fish_idle'; else 'idle';
    }
}
