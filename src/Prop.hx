
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

import types.SpriteOptions;

typedef PropOptions = {
    > SpriteOptions,
    var type:String;
}
class Prop extends Sprite {
    public var anim:SpriteAnimation;
    override function new(options:PropOptions) {
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

        if (options.animation_id != null) {
            anim = add(new SpriteAnimation({ name: '$name/anim' }));
            var anim_data = Luxe.resources.json(options.animation_id);
            anim.add_from_json_object(anim_data.asset.json);
            anim.animation = 'idle';
            anim.play();
        }

        switch (options.type) {
            case 'fish': add(new Fish({ name: '$name/fish' }));
        }
    }
}
